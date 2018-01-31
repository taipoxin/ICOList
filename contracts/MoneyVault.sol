pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

/**
 * @title Contract where user ether stored
 * @dev Admins can only contribute crowdsales
 */
contract MoneyVault {

    event Refunded(address _address, uint256 _amount);

    using SafeMath for uint256;

    /**
     *   @dev A mapping for save amount that was invested by address
     */
    mapping (address => uint256) deposited;

    /**
     *   @dev Function for claiming our ether back, if crowdsale fails
     */
    function claimRefunds() public {
        uint256 memory amount = deposited[msg.sender];
        deposited[msg.sender] = 0;
        investor.transfer(amount);
        Refunded(msg.sender, amount);
    }

    /**
     *  @dev Stores ether in MoneyVault contract
     */
    function deposit() payable external {
        deposited[msg.sender].add(msg.value);
    }
}
