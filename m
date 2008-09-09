From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git merge vs git commit
Date: Tue, 09 Sep 2008 23:32:21 +0200
Message-ID: <vpqiqt50zve.fsf@bauges.imag.fr>
References: <20080909165236.GA8850@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAso-0001R7-4c
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbYIIVfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbYIIVfI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:35:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:63962 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590AbYIIVfH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:35:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m89LXCrP009642
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 9 Sep 2008 23:33:12 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KdAov-0000FA-Jm; Tue, 09 Sep 2008 23:32:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KdAov-0003Iv-HX; Tue, 09 Sep 2008 23:32:21 +0200
In-Reply-To: <20080909165236.GA8850@flint.arm.linux.org.uk> (Russell King's message of "Tue\, 9 Sep 2008 17\:52\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 09 Sep 2008 23:33:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95442>

Russell King <rmk@arm.linux.org.uk> writes:

> Hi,
>
> Using git 1.5.4.5, I notice that the result from git merge and git commit
> are different in an unexpected way.
>
> Take the following tree:
>
>      B---C---D---E2
>     /
>   -A1
>     \
>      F---G---H---I3
>
> (letters represent commits, numbers represent where the references are).
>
> Your current head is '1', and you want to merge branches '2' and '3', so
> you use:
>
> 	git merge 2 3

AAUI, "git merge 2 3" doesn't mean "merge 2 and 3 together", but
"merge 2 and 3 with the current HEAD". So, what you wanted was :

git checkout 1
git merge 2

And what you did was an octopus merge of A, E and I (which ends up
being the same since A is anyway the common ancestor of E and I).

Now, this doesn't explain why the conflicted merge gives a result
different from the other.

-- 
Matthieu
