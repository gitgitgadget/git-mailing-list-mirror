From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Sun, 10 Jun 2012 20:12:13 +0200
Message-ID: <vpq8vfvghoi.fsf@bauges.imag.fr>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	<20120609215236.Horde.J-h4cnwdC4BP06mEUeqxRlA@webmail.minatec.grenoble-inp.fr>
	<38899eac92a1ea5c17b98f5e7bd5d948@telesun.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <konglu@minatec.inpg.fr>,
	<Javier.Roucher-Iglesias@ensimag.imag.fr>, <git@vger.kernel.org>,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: roucherj <roucherj@telesun.imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 10 20:12:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdmci-0006OE-6d
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 20:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab2FJSMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 14:12:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44349 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752836Ab2FJSMT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 14:12:19 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5AI3DS5030503
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Jun 2012 20:03:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SdmcY-0006ZW-I4; Sun, 10 Jun 2012 20:12:14 +0200
In-Reply-To: <38899eac92a1ea5c17b98f5e7bd5d948@telesun.imag.fr>
	(roucherj@telesun.imag.fr's message of "Sun, 10 Jun 2012 19:41:17
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 10 Jun 2012 20:03:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5AI3DS5030503
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339956194.67822@EtBVMlGMuMvapcsn869l6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199614>

roucherj <roucherj@telesun.imag.fr> writes:

> On Sat, 09 Jun 2012 21:52:36 +0200, konglu@minatec.inpg.fr wrote:
>>> +void cmd_credential (int argc, char **argv, const char *prefix){
>>> +	const char *op;
>>> +	struct credential c = CREDENTIAL_INIT;
>>> +	int i;
>>> +
>>> +	op = argv[1];
>>> +	if (!op)
>>> +		usage(usage_msg);
>>> +
>>> +	for (i = 2; i < argc; i++)
>>> +		string_list_append(&c.helpers, argv[i]);
>>> +
>>> +	if (credential_read(&c, stdin) < 0)
>>> +		die("unable to read credential from stdin");
>>> +
>>> +	if (!strcmp(op, "fill")) {
>>> +		credential_fill(&c);
>>> +		if (c.username)
>>> +			printf("username=%s\n", c.username);
>>> +		if (c.password)
>>> +			printf("password=%s\n", c.password);
>>> +	}
>>> +	else if (!strcmp(op, "approve")) {
>>> +		credential_approve(&c);
>>> +	}
>>> +	else if (!strcmp(op, "reject")) {
>>> +		credential_reject(&c);
>>> +	}
>>> +	else
>>> +		usage(usage_msg);
>>
>> Braces for the last "else" part. In general, the structure should be
>>
>>       if (...) {
>>                /*code*/
>>       } else if (...) {
>>                /*code*/
>>       } else {
>>                /*code*/
>>       }
>>
>> If juste one block needs brances, all the other "else if"/"else" part
>> need it too.
>>
>> BTW, please be aware of the white spaces (here mostly in the doc) :).
>>
>> Lucien Kong.
>
> I will remove brances.

The remark was about adding them, not removing them. There's one branch
of the if/else if/ with several instructions, so we usually put braces
everywhere.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
