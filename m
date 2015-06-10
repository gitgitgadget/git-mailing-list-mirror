From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 17:25:58 +0200
Message-ID: <vpqvbevr3eh.fsf@anie.imag.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqbngpl5zu.fsf@anie.imag.fr>
	<550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqq1thkwg5r.fsf@gitster.dls.corp.google.com>
	<1926405730.374352.1433920537226.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqk2vcat2t.fsf@anie.imag.fr>
	<xmqqegljoayp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:26:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2htt-0006mq-04
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933523AbbFJP0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:26:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46020 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933738AbbFJP0K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:26:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFPuN9026480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 17:25:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5AFPwPD024853;
	Wed, 10 Jun 2015 17:25:58 +0200
In-Reply-To: <xmqqegljoayp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 10 Jun 2015 08:10:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Jun 2015 17:25:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5AFPuN9026480
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434554758.93669@diODLkj5nYtqFu2alJcYGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271306>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr> writes:
>>
>>>> That is very different from ENOENT, which is an expected error when
>>>> you are not using a customized terms.
>>>
>>> But in the current state, we are going to create bisect_terms even if
>>> the bisection is in bad/good mode.
>>
>> Which means that in normal cases, you'll either succeed to open it, or
>> get ENOENT. We're talking about unexcepted cases (you don't have
>> permission to read it because it's not your file, because you messed up
>> with a chmod, or whatever reason).
>
> I think both I and you misunderstood what they wanted to do, which
> is to write out good and bad into terms file even though these are
> not customized, and then always read from terms file to learn what
> words are used for good and bad.

Yes, indeed.

> But I do not think it is a good idea to penalize the normal case by
> writing the terms file and reading them back from it when the user
> is bisecting with good/bad in the first place, so....

No strong opinion on that, but creating one file doesn't cost much, and
one advantage of writing it unconditionally is that it unifies bad/good
and old/new more in the code. Just the creation of BISECT_TERMS becomes
a special-case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
