From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and
 reply to
Date: Tue, 24 May 2016 00:10:20 +0200
Message-ID: <6e44c8dd-56cd-37c2-81bb-cfaa001bb549@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
 <20160523195504.GA8957@dcvr.yhbt.net> <vpqmvng8rnt.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tom Russello <tom.russello@grenoble-inp.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@ensimag.grenoble-inp.fr,
	Tom Russello <tom.russello@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Tue May 24 00:10:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4y3R-0002sv-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 00:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbcEWWK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 18:10:26 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:49926 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbcEWWKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 18:10:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 1B5D42546;
	Tue, 24 May 2016 00:10:21 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5cH8IS1mRKxn; Tue, 24 May 2016 00:10:21 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 084A3251D;
	Tue, 24 May 2016 00:10:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id F384B2077;
	Tue, 24 May 2016 00:10:20 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZFIUtxNWm_Yt; Tue, 24 May 2016 00:10:20 +0200 (CEST)
Received: from linux.home (LFbn-1-8166-195.w90-112.abo.wanadoo.fr [90.112.75.195])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 9051A2066;
	Tue, 24 May 2016 00:10:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpqmvng8rnt.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295402>



On 05/23/2016 10:07 PM, Matthieu Moy wrote:
> Eric Wong <e@80x24.org> writes:
>
>> Tom Russello <tom.russello@grenoble-inp.org> wrote:
>>
>>> +	#Message body
>>> +	while (<$fh>) {
>>> +		#for files containing crlf line endings
>>> +		$_=~ s/\r//g;
>>> +		my $space="";
>>> +		if (/^[^>]/) {
>>> +			$space = " ";
>>> +		}
>>> +		$message_quoted .=  ">".$space.$_;
>>
>> Is this really necessary to switch between "> " and ">" prefix?
>> AFAIK, MUAs prefix unconditionally with "> ".
>
> I had the same question, but at least my mailer (Gnus) has the same
> special-case it seems.


Thunderbird behaves the same way, so we decided to mimic that behavior.

It is specified neither in RFC 2822 [1] nor in RFC 5322 [2].

When we write an email, we write it with a maximum width of 72 columns. 
If we insert "> " with each reply, the 80-columns limit will be reached 
with only 4 replies.

So IMHO we should trim the extra space to allow up to 7 replies before 
reaching the 80-columns limit.


[1] https://www.ietf.org/rfc/rfc2822.txt
[2] https://www.ietf.org/rfc/rfc5322.txt
