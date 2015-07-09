From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 04/10] ref-filter: add support to sort by version
Date: Thu, 09 Jul 2015 15:29:40 +0200
Message-ID: <vpqfv4x792z.fsf@anie.imag.fr>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<1436437671-25600-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 15:29:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDBtg-0002IR-4S
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 15:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbbGIN3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 09:29:48 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53425 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbbGIN3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 09:29:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t69DTdst006121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jul 2015 15:29:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t69DTe4b018238;
	Thu, 9 Jul 2015 15:29:40 +0200
In-Reply-To: <1436437671-25600-4-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 9 Jul 2015 15:57:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 09 Jul 2015 15:29:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t69DTdst006121
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437053382.73434@IVp8PsHo9ait8itOVltqrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273750>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add support to sort by version using the "v:refname" and
> "version:refname" option. This is achieved by using the
> 'version_cmp()' function as the comparing function for qsort.

You should elaborate on why you need this. Given the context, I can
guess that you will need this to implement tag, but for example I first
wondered why you needed both version: and v:, but I guess it comes from
the fact that 'git tag --sort' can take version:refname or v:refname.

I think this deserves a test and documentation in for-each-ref.txt.

As-is, the code is a bit hard to understand. I first saw you were
allowing

  git for-each-ref --format '%(version:refname)'

(which you are, but only as a side effect), and then understood that
this was also allowing

  git for-each-ref --sort version:refname

A test would have shown me this immediately. Some hints in the commit
message would clearly have helped too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
