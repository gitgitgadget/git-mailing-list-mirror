From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Mon, 15 Jun 2015 10:37:23 +0200
Message-ID: <vpqoakh74fw.fsf@anie.imag.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqy4jq2rjr.fsf@anie.imag.fr>
	<1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<835646176.485512.1434310200681.JavaMail.zimbra@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Mon Jun 15 10:37:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Ptl-0008Ki-5t
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 10:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbbFOIhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 04:37:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46157 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbbFOIh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 04:37:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5F8bMu2027981
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2015 10:37:23 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5F8bN9R010676;
	Mon, 15 Jun 2015 10:37:23 +0200
In-Reply-To: <835646176.485512.1434310200681.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Sun, 14 Jun 2015 21:30:00 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jun 2015 10:37:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5F8bMu2027981
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434962244.67883@Y6h9pg4yWC+YcxPYdxzKZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271662>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> Louis Stuber <louis--alexandre.stuber@ensimag.grenoble-inp.fr> writes: 
>
>>Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes: 
>> 
>>> Modifying in PATCH 7 some code that you introduced in PATCH 3 is 
>>> suspicious. Is there any reason you did not name the variable 
>>> "terms_defined" in the first place? (i.e. squash this hunk and the other 
>>> instance of start_bad_good into PATCH 3) 
>>> 
>>> (Whether this is a rethorical question is up to you ;-) ) 
>> 
>>In the previouses versions where we only want to introduce old/new, 
>>the terms can only be defined in bisect_start if the user typed 
>>start <bad> <good>. The name "start_bad_good" is not very explicit 
>>indeed, but isn't it more appropriate in this case than terms_defined ? 
>
> I agree with Louis, but maybe a consistant commit history is more 
> important. But if only the first patches (which implement old/new ) 
> would come to be accepted the name of the variable would sounds strange. 

I would say terms_defined is OK even if only the first patches get
merged. The reason why you need this variable is because you need to
know whether the terms have been defined or not, and to me that's the
most important.

I'd suggest something like this:

# terms_defined is 0 when the user did not define the terms explicitely
# yet. This is the case when running 'git bisect start bad_rev good_rev'
# before we see an explicit reference to a term.
terms_defined=0

Then PATCH 7/7 can add a mention of 'git bisect terms' just in the
comment.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
