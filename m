From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC] Clean way to disable pager
Date: Sun, 19 Aug 2007 19:41:12 +0200
Message-ID: <vpqwsvr1kxz.fsf@bauges.imag.fr>
References: <vpq1wdz307k.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 19:41:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMomQ-0006U4-Jo
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 19:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbXHSRlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 13:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbXHSRlf
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 13:41:35 -0400
Received: from imag.imag.fr ([129.88.30.1]:57529 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbXHSRle (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 13:41:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7JHfCZ7025683
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 19 Aug 2007 19:41:13 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IMom0-0006Ee-R1; Sun, 19 Aug 2007 19:41:12 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IMom0-0002Uq-Oc; Sun, 19 Aug 2007 19:41:12 +0200
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <vpq1wdz307k.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sun\, 19 Aug 2007 19\:26\:07 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 19 Aug 2007 19:41:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56131>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> What I can't find is a clean way to _disable_ the pager. A hacky way
> is to run "git whatever | cat", or "GIT_PAGER=cat git whatever". 

I juste realized that the second way is actually documented:


'GIT_PAGER'::
	This environment variable overrides `$PAGER`. If it is set
	to an empty string or to the value "cat", git will not launch
	a pager.

Still, I find this a bit too hidden in the documentation. I'd expect
to find the way to disable the pager close to the place where I find
the way to enable it. Perhaps something like this would do:

--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -101,7 +101,8 @@ OPTIONS
 	the current setting and then exit.
 
 -p|--paginate::
-	Pipe all output into 'less' (or if set, $PAGER).
+	Pipe all output into 'less' (or if set, $GIT_PAGER or $PAGER).
+	See the documentation of GIT_PAGER below to disable the pager.
 
 --git-dir=<path>::
 	Set the path to the repository. This can also be controlled by


Or perhaps move the sentence about "cat" from the documentation of
GIT_PAGER to the one of --paginate (neither place is really
appropriate, it's not specific to GIT_PAGER since setting $PAGER works
also, and not specific to --paginate since many commands enable it
automatically).

-- 
Matthieu
