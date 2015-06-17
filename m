From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Wed, 17 Jun 2015 10:18:20 +0200
Message-ID: <vpqioam21f7.fsf@anie.imag.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqy4jq2rjr.fsf@anie.imag.fr>
	<1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<835646176.485512.1434310200681.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqoakh74fw.fsf@anie.imag.fr>
	<183774662.562924.1434489533064.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq1tha4xxq.fsf@anie.imag.fr>
	<575469420.568311.1434528064283.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 10:19:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58Yk-0006vT-5P
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 10:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbbFQISs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 04:18:48 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51735 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbbFQIS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 04:18:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5H8IJ1J029226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 10:18:19 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5H8IKHx030365;
	Wed, 17 Jun 2015 10:18:20 +0200
In-Reply-To: <575469420.568311.1434528064283.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Wed, 17 Jun 2015 10:01:04 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 17 Jun 2015 10:18:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5H8IJ1J029226
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435133904.24218@Yk+PIpHzMMU2Z3dEmDj6eA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271817>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes: 
>
>>> 
>>>># terms_defined is 0 when the user did not define the terms explicitely 
>>>># yet. This is the case when running 'git bisect start bad_rev good_rev' 
>>>># before we see an explicit reference to a term. 
>>>>terms_defined=0 
>>> 
>>> The thing is: 
>>> 'git bisect reset 
>>> git bisect new HEAD 
>
>>"git bisect new" does not exist. Did you mean "git bisect start HEAD"? 
>
> No I meant new but it can be 'git bisect bad' aswell

OK, answering emails before coffee doesn't suit me well, I did not
remember that the series was about "new" ;-).

(Actually your use-case is not possible yet as of PATCH 3 which
introduces start_bad_good. It is possible after PATCH 4)

> So 
> '
> git bisect reset
> git bisect bad
> answer yes to "autostart ?"
> '

> In the case I rewrited, we saw a 'bad' but terms_defined value in bisect_start
> (called by the autostart) is 0. 

As you said, it is really equivalent to

git bisect start
git bisect bad

the autostart is just a convenience piece of code to run "git bisect
start" for the user, but does not change the logic of the code. Write
good code for the normal case (start, and then bad), and it will just
work without having to worry about in in the autostart case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
