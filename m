From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: can git reset or checkout be reverted?
Date: Fri, 06 Feb 2009 15:43:30 +0100
Message-ID: <vpqiqnnbp7x.fsf@bauges.imag.fr>
References: <20090206141940.GB7231@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 15:49:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVS1P-0004m4-PV
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbZBFOrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbZBFOru
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:47:50 -0500
Received: from imag.imag.fr ([129.88.30.1]:52467 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZBFOru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:47:50 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n16EhVvc005609
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Feb 2009 15:43:31 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LVRvW-00011p-8O; Fri, 06 Feb 2009 15:43:30 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LVRvW-0004TP-64; Fri, 06 Feb 2009 15:43:30 +0100
In-Reply-To: <20090206141940.GB7231@b2j> (bill lam's message of "Fri\, 6 Feb 2009 22\:19\:40 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 06 Feb 2009 15:43:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108722>

bill lam <cbill.lam@gmail.com> writes:

> If I want to recall a old version of testing by
>
> git reset --hard sha1

git reset is mostly about changing the place the current branch points
to. If you checkout branch master, and then say "git reset --hard
sha1", then, you say "OK, from now, the tip of branch master will be
sha1".

> git checkout sha1

This is the one you were looking for.

> then git log does not show anything beyond that commit. It does give
> some warning and recommend -b switch next time.

It does not "recommand" it, it says that _if_ you wanted to create a
branch, you could have done it with -b.

> If I only do that by accident or ignorance. How to revert to the
> original HEAD?

Case 1: you used checkout. Then, the branch still points to where you
were before the "checkout". Just "git checkout master", or replace
master with where you used to be.

In any case: the reflog can help you. It keeps track of where your
HEAD and other references (branches, ...) have been pointing before.

git reflog
git reflog show master

to see it, and this allows you to say things like

git checkout HEAD@{1}
git reset HEAD@{1}

The HEAD@{1} means "where HEAD used to be one move ago".

-- 
Matthieu
