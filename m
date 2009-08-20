From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: question concerning branches
Date: Thu, 20 Aug 2009 09:57:57 +0200
Message-ID: <vpqzl9urk6y.fsf@bauges.imag.fr>
References: <m33a7noc3u.fsf@localhost.localdomain> <4a8c51f5@wupperonline.de>
	<32541b130908191250w79461592vf1bed7874aa4138b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Brueckl <ib@wupperonline.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 10:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me2aP-0002R9-6P
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 10:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbZHTIAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 04:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbZHTIAg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 04:00:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:53374 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbZHTIAe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 04:00:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7K7vvnd025860
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Aug 2009 09:57:57 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Me2Wz-00069n-92; Thu, 20 Aug 2009 09:57:57 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Me2Wz-0002aa-6Z; Thu, 20 Aug 2009 09:57:57 +0200
In-Reply-To: <32541b130908191250w79461592vf1bed7874aa4138b@mail.gmail.com> (Avery Pennarun's message of "Wed\, 19 Aug 2009 19\:50\:31 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 20 Aug 2009 09:57:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126614>

Avery Pennarun <apenwarr@gmail.com> writes:

> This is a big difference from how centralized VCSs work: there, a
> commit is a major operation that you're afraid to do in case you make
> someone else mad.  In git, commits are cheap, you just need to be
> careful about pushing.

I second this. "commit" is indeed a bad name in decentralized VCSs.
There's no commitment from the developer, you don't commit to swear
the code is good, but you commit just to record a set of changes, and
attach a descriptive message to it.

In Git, a commit takes usually a fraction of a second, and can be
modified later easily until it's pushed.

'git commit --amend' will allow you to change either the changes or
the message associated to a commit.

'git reset HEAD^' will just undo the commit, turning your commited
changes into uncommited ones.

'git rebase --interactive' will allow you another bunch of cool
things.

So, keeping your changes uncommited has very few advantage, and indeed
has one big drawback: uncommited changes have no descriptive message
associated, so if you leave a branch for some time, it makes it more
difficult for you to remember what you were doing on it when you
switch back to it:

git checkout -b topic-branch
# edit foo.bar
git checkout master
# hack
git commit
# go on holiday
# come back
git checkout topic-branch
git status
# err, what is this all about?

OTOH:

git checkout -b topic-branch
# edit foo.bar
git commit -m "started feature foo, but bar is still to be done"
git checkout master
# hack
git commit
# go on holiday
# come back
git checkout topic-branch
git show
# Ah, I remember!

Actually, all the VCSs I know about (Mercurial, Bazaar, Subversion,
and IIRC GNU Arch) deal with this the way Git does. Hey! there must be
a reason ;-).

-- 
Matthieu
