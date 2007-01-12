From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 1/2] tutorial: Use "git remote add"
Date: Fri, 12 Jan 2007 12:57:28 +0100
Message-ID: <87sleg31av.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 12 11:58:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5K6t-0001df-Uc
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 11:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829AbXALK6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 12 Jan 2007 05:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbXALK6I
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 05:58:08 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:42315 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932666AbXALK6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 05:58:07 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l0CAw3e22974
	for <git@vger.kernel.org>; Fri, 12 Jan 2007 11:58:04 +0100
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36668>


This way all the branches are in the separate layout,
so the newbies only have to understand one layout.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Hi *,

   I've used:

$ git pull . remotes/bob/master

   instead of:

$ git pull . bob/master

   because the latter does not work. I think it's a bug, because

$ git show bob/master
$ git merge bob/master

   work as expected.

 Documentation/tutorial.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index d2bf0b9..4b7eba3 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -285,10 +285,12 @@ at /home/bob/myrepo.  She does this with:
=20
 ------------------------------------------------
 $ cd /home/alice/project
-$ git pull /home/bob/myrepo master
+$ git remote add bob /home/bob/myrepo
+$ git pull bob master
 ------------------------------------------------
=20
-This merges the changes from Bob's "master" branch into Alice's
+First it adds the "remote" Bob's repository with the name "bob" and
+then it merges the changes from Bob's "master" branch into Alice's
 current branch.  If Alice has made her own changes in the meantime,
 then she may need to manually fix any conflicts.  (Note that the
 "master" argument in the above command is actually unnecessary, as it
@@ -298,18 +300,16 @@ The "pull" command thus performs two operations: =
it fetches changes
 from a remote branch, then merges them into the current branch.
=20
 You can perform the first operation alone using the "git fetch"
-command.  For example, Alice could create a temporary branch just to
-track Bob's changes, without merging them with her own, using:
+command without merging them with her own branch, using:
=20
 -------------------------------------
-$ git fetch /home/bob/myrepo master:bob-incoming
+$ git fetch bob
 -------------------------------------
=20
-which fetches the changes from Bob's master branch into a new branch
-named bob-incoming.  Then
+which fetches the changes from Bob's branches.  Then
=20
 -------------------------------------
-$ git log -p master..bob-incoming
+$ git log -p master..bob/master
 -------------------------------------
=20
 shows a list of all the changes that Bob made since he branched from
@@ -320,21 +320,21 @@ could pull the changes into her master branch:
=20
 -------------------------------------
 $ git checkout master
-$ git pull . bob-incoming
+$ git pull . remotes/bob/master
 -------------------------------------
=20
-The last command is a pull from the "bob-incoming" branch in Alice's
+The last command is a pull from the "bob/master" branch in Alice's
 own repository.
=20
 Alice could also perform both steps at once with:
=20
 -------------------------------------
-$ git pull /home/bob/myrepo master:bob-incoming
+$ git pull bob
 -------------------------------------
=20
-This is just like the "git pull /home/bob/myrepo master" that we saw
+This is just like the "git pull bob master" that we saw
 before, except that it also stores the unmerged changes from bob's
-master branch in bob-incoming before merging them into Alice's
+master branch in bob/master before merging them into Alice's
 current branch.  Note that git pull always merges into the current
 branch, regardless of what else is given on the commandline.
=20
--=20
1.5.0-rc1.GIT
