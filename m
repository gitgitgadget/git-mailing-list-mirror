From: Ivan Kanis <expire-by-2011-02-07@kanis.fr>
Subject: Re: problem when pulling a specific branch from origin
Date: Wed, 02 Feb 2011 10:54:34 +0100
Message-ID: <87d3naiwx1.fsf@kanis.fr>
References: <877hdjy8d8.fsf@kanis.fr>
	<20110202001734.GL5713@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Feb 02 10:54:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkZQJ-00062g-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 10:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab1BBJyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 04:54:44 -0500
Received: from kanis.fr ([75.127.73.245]:4031 "EHLO kanis.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617Ab1BBJym (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 04:54:42 -0500
Received: from nantes.visionobjects.com ([92.103.229.106] helo=yan)
	by kanis.fr with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <expire-by-2011-02-07@kanis.fr>)
	id 1PkZQ5-0002SI-Bx; Wed, 02 Feb 2011 04:54:37 -0500
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
In-Reply-To: <20110202001734.GL5713@localhost.localdomain> (Konstantin
	Khomoutov's message of "Wed, 2 Feb 2011 03:17:34 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165900>

--=-=-=

Hi Konstantin,

Thanks for your thorough answer.

Konstantin Khomoutov <flatworm@users.sourceforge.net> wrote:

> The first one is that you seem to maintain a wrong idea about what
> happens when you do `git pull origin branch`.  It appears you assume
> this action is supposed to first update the local branch
> "remotes/origin/branch" and then merge it to the locally checked out
> branch.  The truth is that specifying a branch in this way to git-pull
> (or git-fetch, which is called by git-pull) is a special case -- it
> means that no corresponding local ref is updated, and the fetched line
> of history is directly merged into the checked out branch right after
> fetching (see the git-fetch manual and the EXAMPLES section in the
> git-pull manual).

You're right I get the wrong idea of pull origin branch, it's a special
case and it doesn't update local ref.

> I'm not really sure about your expectation as you did not clearly
> articulate them, so it seems there are two points to touch here...

I expect my local ref to be updated with the server ref.

> In your particular case you're merging remote branch "branch" which is
> one commit ahead of remote "master" to the locally checked branch
> "master" which is, at the moment, the same as the same-named remote
> branch.  Consequently, after merging "branch" (which results in
> fast-forward) your local branch "master" starts to be one commit ahead
> of its remote counterpart; no local branches beyond this one are
> updated.

I forgot to checkout the branch in the repository bar, I have attached
the updated script. The result is the same my branch is one commit ahead.

If we run git fetch without argument the refs are updated:

yan:~/tmp/bar$ git fetch
From /home/ivan/tmp/foo
   6fe0a63..ebcae31  branch     -> origin/branch

However running fetch without arguments pull all remote refs which my
developer does not want. Is there a command to update a specific
remote ref?

> The second point is less clear/more complicated.
> At first, it's not clear whether you wanted to have the remote branch
> "branch" become the active local branch during the cloning process, or
> "master" (in your case "master" became the active branch).
> On the one hand, you explicitly branched "branch" off "master" right
> before cloning (updating the first repo's HEAD ref) which hints you
> intended that branch to be default in the clone.
> On the other hand, while the documentation says the default branch in
> the clone is the one listed in the HEAD ref of the source repository, in
> my tests using Git (1.7.2.x in Debian and msysgit 1.7.3.x), in cases
> like yours the destination repository ends up having the "master" branch
> as the default one, not the branch from the HEAD ref; to make this work,
> the branch listed in the HEAD ref should have received at least one
> commit after forking.  I suspect the problem might be in that such a
> branch freshly cloned off "master" points to the same commit object's
> name which might confuse Git.
> This, in my eyes, might indeed display a bug.

The current behavior is a bit weird to say the least, I don't know if
it's a bug.

Take care,
-- 
Ivan Kanis
http://kanis.fr

At Group L, Stoffel oversees six first-rate programmers, a
managerial challenge roughly comparable to herding cats.
    -- Anonymous , 1985-06-09 , The Washington Post 

--=-=-=
Content-Type: text/x-sh
Content-Disposition: attachment; filename=repro.sh

#!/bin/sh

rm -rf foo bar
git --version
mkdir foo
cd foo
git init
echo foo > foo.txt
git add foo.txt
git commit -am"foo"
git checkout -b branch
cd ..
git clone foo bar
cd foo
echo bar > foo.txt
git commit -am"bar"
cd ..
cd bar
git checkout branch
git pull origin branch
git status
git branch -rv

--=-=-=--
