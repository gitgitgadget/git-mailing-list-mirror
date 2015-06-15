From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFCv5 3/3] git rebase -i: add static check for commands and SHA-1
Date: Mon, 15 Jun 2015 10:25:44 +0200
Message-ID: <vpqzj4174zb.fsf@anie.imag.fr>
References: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433931035-20011-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<vpq8ubrtws0.fsf@anie.imag.fr>
	<58099623.334723.1433951804504.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqa8w71r80.fsf@anie.imag.fr>
	<775816946.447663.1434237425837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:26:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Pif-00047s-ML
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 10:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbbFOI0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 04:26:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53704 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbbFOI0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 04:26:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5F8Ph0H009281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2015 10:25:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5F8PiHU010273;
	Mon, 15 Jun 2015 10:25:44 +0200
In-Reply-To: <775816946.447663.1434237425837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Galan Alfonso's message of "Sun, 14 Jun 2015 01:17:05 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jun 2015 10:25:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5F8Ph0H009281
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434961547.61872@sTAJtNxXAxH1IfdJpZptMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271661>

Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
>> 
>> > It is mainly because here the SHA-1 is a long one (40 chars)
>> 
>> OK, but then the minimum would be to add a comment saying that.
>> 
>> Now, this makes me wonder why you are doing the check after the sha1
>> expansion and not before. Also, when running `git bisect --edit-todo`, I
>> do get the short sha1. So, there's a piece of code doing what you want
>> somewhere already. You may want to use it.
>
> Originally I did the whole checking after the expansion because I
> though that it was a better idea to avoid doing it myself (Comparing
> the whole SHA-1 instead of partial ones to find missing ones made more
> sense for me since otherwise I would have to check if one is the
> prefix of the other or expand to the same size before comparing).

Checking the missing commits after expansion makes sense (but it is only
a matter of adding "| git rev-list --no-walk --stdin" somewhere in the
pipeline).

But IMHO, checking the syntax errors is better done as early as possible
if you want accurate error messages. This way you still have what the
user typed available.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
