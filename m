From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/2] tutorial: shorthand for remotes but show distributed nature of git
Date: Wed, 17 Jan 2007 01:10:14 +0100
Message-ID: <87ejpuikd5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 17 01:10:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6yOD-0000Df-0k
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 01:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXAQAKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Jan 2007 19:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbXAQAKu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 19:10:50 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:39247 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbXAQAKt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 19:10:49 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0H0Ale28460
	for <git@vger.kernel.org>; Wed, 17 Jan 2007 01:10:47 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36985>


=46rom: Junio C Hamano <junkio@cox.net>

* Promiscous pull shows the distributed nature of git better.
* Add a new step after that to teach "remote add".
* Highlight that with the shorthand defined you will get
  remote tracking branches for free.
* Fix Alice's workflow.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---

 Update patch.

 Documentation/tutorial.txt |   43 ++++++++++++++++++++++++------------=
-------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 1b93013..c27a450 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -283,12 +283,10 @@ at /home/bob/myrepo.  She does this with:
=20
 ------------------------------------------------
 $ cd /home/alice/project
-$ git remote add bob /home/bob/myrepo
-$ git pull bob master
+$ git pull /home/bob/myrepo master
 ------------------------------------------------
=20
-First it adds the "remote" Bob's repository with the name "bob" and
-then it merges the changes from Bob's "master" branch into Alice's
+This merges the changes from Bob's "master" branch into Alice's
 current branch.  If Alice has made her own changes in the meantime,
 then she may need to manually fix any conflicts.  (Note that the
 "master" argument in the above command is actually unnecessary, as it
@@ -297,14 +295,27 @@ is the default.)
 The "pull" command thus performs two operations: it fetches changes
 from a remote branch, then merges them into the current branch.
=20
-You can perform the first operation alone using the "git fetch"
-command without merging them with her own branch, using:
+When you are working in a small closely knit group, it is not
+unusual to interact with the same repository over and over
+again.  By defining 'remote' repository shorthand, you can make
+it easier:
+
+------------------------------------------------
+$ git remote add bob /home/bob/myrepo
+------------------------------------------------
+
+With this, you can perform the first operation alone using the
+"git fetch" command without merging them with her own branch,
+using:
=20
 -------------------------------------
 $ git fetch bob
 -------------------------------------
=20
-which fetches the changes from Bob's branches.  Then
+Unlike the longhand form, when Alice fetches from Bob using a
+remote repository shorthand set up with `git remote`, what was
+fetched is stored in a remote tracking branch, in this case
+`bob/master`.  So after this:
=20
 -------------------------------------
 $ git log -p master..bob/master
@@ -313,28 +324,22 @@ $ git log -p master..bob/master
 shows a list of all the changes that Bob made since he branched from
 Alice's master branch.
=20
-After examining those changes, and possibly fixing things, Alice
+After examining those changes, Alice
 could merge the changes into her master branch:
=20
 -------------------------------------
-$ git checkout master
 $ git merge bob/master
 -------------------------------------
=20
-The last command is a merge of the "bob/master" branch in Alice's
-own repository.
-
-Alice could also perform both steps at once with:
+This `merge` can also be done by 'pulling from her own remote
+tracking branch', like this:
=20
 -------------------------------------
-$ git pull bob
+$ git pull . remotes/bob/master
 -------------------------------------
=20
-This is just like the "git pull bob master" that we saw
-before, except that it also stores the unmerged changes from bob's
-master branch in bob/master before merging them into Alice's
-current branch.  Note that git pull always merges into the current
-branch, regardless of what else is given on the commandline.
+Note that git pull always merges into the current branch,
+regardless of what else is given on the commandline.
=20
 Later, Bob can update his repo with Alice's latest changes using
=20
--=20
1.5.0.rc1.gaa1c42
