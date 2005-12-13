From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Everyday: some examples.
Date: Mon, 12 Dec 2005 16:22:11 -0800
Message-ID: <7vek4hg824.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051209215414.14072.qmail@science.horizon.com>
	<7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:23:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Elxvs-0003ex-UK
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 01:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVLMAWO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 19:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbVLMAWO
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 19:22:14 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36560 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932253AbVLMAWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 19:22:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213002034.KGJL17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 19:20:34 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512120827440.15597@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Dec 2005 08:34:12 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13549>

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 9 Dec 2005, Junio C Hamano wrote:
>>
>> Exactly.  That's why task oriented list would be most useful.
>> Here is a starter.
>> 
>> 
>> Everyday GIT Cheat Sheet Or Git With 20 Commands
>> ================================================
>
> Would this file perhaps also have examples?

How about...

---

 Documentation/everyday.txt |   72 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 68 insertions(+), 4 deletions(-)

44db136cad84c003506e231a38935ca6acba4d7d
diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 5775cd2..ded4d51 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -59,9 +59,6 @@ following commands.
 
   * gitlink:git-show-branch[1] to see where you are.
 
-  * gitlink:git-diff[1] and gitlink:git-status[1] to see what
-    you are in the middle of doing.
-
   * gitlink:git-log[1] to see what happened.
 
   * gitlink:git-whatchanged[1] to find out where things have
@@ -70,7 +67,11 @@ following commands.
   * gitlink:git-checkout[1] and gitlink:git-branch[1] to switch
     branches.
 
-  * gitlink:git-update-index[1] to manage the index file.
+  * gitlink:git-add[1] and gitlink:git-update-index[1] to manage
+    the index file.
+
+  * gitlink:git-diff[1] and gitlink:git-status[1] to see what
+    you are in the middle of doing.
 
   * gitlink:git-commit[1] to advance the current branch.
 
@@ -83,6 +84,37 @@ following commands.
   * gitlink:git-rebase[1] to maintain topic branches.
 
 
+Examples
+~~~~~~~~
+
+* Extract a tarball and create a working tree and a new repository to keep track of it.
+------------
+$ tar zxf frotz.tar.gz
+$ cd frotz
+$ git-init-db
+$ git add .
+$ git commit -m 'import of frotz source tree.'
+------------
+
+* Create a topic branch and develop
+------------
+$ git checkout -b private
+$ edit/compile/test
+$ git diff <1>
+$ git checkout -- foo.c <2>
+$ edit/compile/test
+$ git commit -a -s <3>
+$ git checkout master <4>
+$ git pull . private <5>
+
+<1> to see what changes you are committing.
+<2> revert your botched changes in selected path "foo.c".
+<3> commit everything as you have tested.
+<4> switch to the master branch.
+<5> merge a topic branch into your master branch
+------------
+
+
 Individual Developer (Participant)[[Individual Developer (Participant)]]
 ------------------------------------------------------------------------
 
@@ -100,6 +132,38 @@ addition to the ones needed by a standal
     you adopt Linux kernel-style public forum workflow.
 
 
+Examples
+~~~~~~~~
+
+* Clone the upstream and work on it.  Feed changes to upstream.
+------------
+$ git clone git://git.kernel.org/pub/scm/.../torvalds/linux-2.6 my2.6
+$ cd my2.6
+$ edit/compile/test; git commit -a -s <1>
+$ git format-patch master <2>
+$ git pull <3>
+$ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <4>
+
+<1> repeat as needed.
+<2> extract patches from your branch for e-mail submission.
+<3> "pull" fetches from "origin" by default and merges.
+<4> fetch from a specific branch from a specific repository and and merge. 
+------------
+
+* Branch off of a specific tag.
+------------
+$ git checkout -b private2.6.14 v2.6.14 <1>
+$ edit/compile/test; git commit -a
+$ git checkout master
+$ git format-patch -k -m --stdout v2.6.14..private2.6.14 |
+  git am -3 -k <2>
+<1> create a private branch based on a well known (but somewhat behind)
+tag.
+<2> forward port all changes in private2.6.14 branch to master
+branch without formal "merging".
+------------
+
+
 Integrator[[Integrator]]
 ------------------------
 
-- 
0.99.9.GIT
