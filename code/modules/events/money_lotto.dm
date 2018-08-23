/datum/event/money_lotto
	var/winner_name = "John Smith"
	var/winner_sum = 0
	var/deposit_success = 0

/datum/event/money_lotto/start()
	winner_sum = pick(1000, 2000, 5000, 10000)
	if(prob(50))
		if(all_money_accounts.len)
			var/datum/money_account/D = pick(all_money_accounts)
			winner_name = D.owner_name
			if(!D.suspended)
				var/datum/transaction/T = new("Nyx Daily Grand Slam -Stellar- Lottery", "Winner!", winner_sum, "Biesel TCD Terminal #[rand(111,333)]")
				D.do_transaction(T)
				deposit_success = 1

	else
		winner_name = random_name(pick(MALE,FEMALE), species = SPECIES_HUMAN)
		deposit_success = pick(0,1)

/datum/event/money_lotto/announce()
	var/author = "[GLOB.using_map.company_name] Editor"
	var/channel = "Nyx Daily"

	var/body = "Nyx Daily wishes to congratulate <b>[winner_name]</b> for recieving the Nyx Stellar Slam Lottery, and receiving the out of this world sum of [winner_sum] Ethericoins!"
	if(!deposit_success)
		body += "<br>Unfortunately, we were unable to verify the account details provided, so we were unable to transfer the money. In order to have your winnings re-sent, send a cheque containing a processing fee of 5000 Ethericoins to the ND 'Stellar Slam' office on the Nyx gateway with your updated details."

	news_network.SubmitArticle(body, author, channel, null, 1)
