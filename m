From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 01 Jun 2015 20:47:56 +0200
Message-ID: <vpqiob7z2n7.fsf@anie.imag.fr>
References: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr>
	<xmqqiob773iy.fsf@gitster.dls.corp.google.com>
	<vpqa8wj48c1.fsf@anie.imag.fr>
	<xmqqpp5f5l7v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:48:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUkr-0002OU-W8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbbFASsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:48:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60354 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796AbbFASsE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:48:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t51IlsM9002503
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 20:47:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t51Ilu8F025430;
	Mon, 1 Jun 2015 20:47:56 +0200
In-Reply-To: <xmqqpp5f5l7v.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 01 Jun 2015 11:37:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 01 Jun 2015 20:47:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t51IlsM9002503
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433789277.95271@TktT8Vx5bJ5xYBpyfgDnKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270458>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> @@ -1,1 +1,2 @@
>>> +5
>>>  10
>>> @@ -1,3 +2,3 @@
>>>  10
>>> +15
>>> -20
>>>  30
>>
>> With this one, I get:
>>
>> $ git apply < p2.diff   
>> error: patch failed: pre.txt:1
>> error: pre.txt: patch does not apply
>> $ patch < p2.diff 
>> patching file pre.txt
>>
>> => no fuzzy matching for patch, git apply should actually work.
>
> I am not sure what you are trying to do with that patch that tries
> to touch the same line twice.  Is this the same old laziness coming
> back to bite us, the one that we attempted to work around with
> 933e44d3 ("add -p": work-around an old laziness that does not
> coalesce hunks, 2011-04-06)?

Indeed, "git apply" works with --allow-overlap in this case. But this is
not sufficient to fix "git add -p" which already uses it. So, there's
something else.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
