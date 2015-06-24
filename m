From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v8 5/5] bisect: allow any terms set by user
Date: Wed, 24 Jun 2015 23:23:45 +0200
Message-ID: <vpqioac3in2.fsf@anie.imag.fr>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435159062-23468-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vp9ezq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 23:23:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7s9F-00059A-RR
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 23:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbbFXVXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 17:23:53 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49721 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbbFXVXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 17:23:52 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5OLNhCo022022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jun 2015 23:23:43 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5OLNjQq002744;
	Wed, 24 Jun 2015 23:23:45 +0200
In-Reply-To: <xmqqa8vp9ezq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 24 Jun 2015 10:46:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Jun 2015 23:23:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5OLNhCo022022
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435785824.82466@tUN7cbYX6dO1ZEgLZqre7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272607>

Junio C Hamano <gitster@pobox.com> writes:

> they would call "term2" into "term1" somewhere.  e.g.
>
> 	-ancestors of term1.
> 	+ancestors of term1.  For example, if something was buggy in
>         +the old part of the history, you know somewhere the bug was
> 	+fixed, and you want to find the exact commit that fixed it,
>         +you may want to say `git bisect terms fixed broken`; this
>         +way, you would mark a commit that still has the bug with
>         +`broken`, and a newer one after the fix with `fixed`.
>
> or something?

Yes.

> I am wondering (together with the documentation patch) if it would
> be better to be more explicit, instead of term[12], like this:
>
> 	git bisect terms new old

Yes. I eliminated all instance of term1 and term2 in the doc of the
patch, and replaced with <term-old> and <term-new>.

>> +bisect_terms () {
>> +	case "$#" in
>> +	0)
>> +		if test -s "$GIT_DIR/BISECT_TERMS"
>> +		then
>> +			{
>> +			read term1
>> +			read term2
>> +			}<"$GIT_DIR/BISECT_TERMS"
>> +			gettextln "Your current terms are $term1 and $term2."
>
> The same comment on this part.  Instead of "git bisect terms" that
> just says "You are using $term1 and $term2", the users would benefit
> if it said "You are using $term1 for newer state and $term2 for
> older state" [*1*].

Done. It's up to date on

https://github.com/moy/git/tree/bisect-terms

Will resend.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
