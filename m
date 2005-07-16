From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: update recommended workflow when working with others.
Date: Fri, 15 Jul 2005 20:56:12 -0700
Message-ID: <7vslyfo143.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 05:56:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtdmn-0001ex-AB
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 05:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVGPD4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 23:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVGPD4R
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 23:56:17 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54721 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261387AbVGPD4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 23:56:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050716035614.ZCH18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Jul 2005 23:56:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Clarify that the hierarchy implied by the recommended workflow
is only informal.

Refer readers to nice illustration by Rundy Dunlap.

Separate out the step to "push" to own public repository in the
workflow.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/tutorial.txt |   65 ++++++++++++++++++++++++++++++--------------
 1 files changed, 44 insertions(+), 21 deletions(-)

70a7f8c18de2006a500059f3cb23d353250d0a9d
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -967,7 +967,19 @@ unpacked in the destination, unless rsyn
 	Working with Others
 	-------------------
 
-A recommended work cycle for a "project lead" is like this:
+Although git is a truly distributed system, it is often
+convenient to organize your project with an informal hierarchy
+of developers.  Linux kernel development is run this way.  There
+is a nice illustration (page 17, "Merges to Mainline") in Rundy
+Dunlap's presentation (http://tinyurl.com/a2jdg).
+
+It should be stressed that this hierarchy is purely "informal".
+There is nothing fundamental in git that enforces the "chain of
+patch flow" this hierarchy implies.  You do not have to pull
+from only one remote repository.
+
+
+A recommended workflow for a "project lead" goes like this:
 
  (1) Prepare your primary repository on your local machine. Your
      work is done there.
@@ -978,23 +990,28 @@ A recommended work cycle for a "project 
      repository.
 
  (4) "git repack" the public repository.  This establishes a big
-     pack that contains the initial set of objects.
-
- (5) Keep working in your primary repository, and push your
-     changes to the public repository.  Your changes include
-     your own, patches you receive via e-mail, and merge resulting
-     from pulling the "public" repositories of your "subsystem
-     maintainers".
+     pack that contains the initial set of objects as the
+     baseline, and possibly "git prune-packed" if the transport
+     used for pulling from your repository supports packed
+     repositories.
+
+ (5) Keep working in your primary repository.  Your changes
+     include modifications of your own, patches you receive via
+     e-mails, and merges resulting from pulling the "public"
+     repositories of your "subsystem maintainers".
 
      You can repack this private repository whenever you feel
      like.
 
- (6) Every once in a while, "git repack" the public repository.
+ (6) Push your changes to the public repository, and announce it
+     to the public.
+
+ (7) Every once in a while, "git repack" the public repository.
      Go back to step (5) and continue working.
 
-A recommended work cycle for a "subsystem maintainer" that
-works on that project and has own "public repository" is like
-this:
+
+A recommended work cycle for a "subsystem maintainer" that works
+on that project and has own "public repository" goes like this:
 
  (1) Prepare your work repository, by "git clone" the public
      repository of the "project lead".
@@ -1006,21 +1023,27 @@ this:
      currently not automated.
 
  (4) Push into the public repository from your primary
-     repository.
-
- (5) Keep working in your primary repository, and push your
-     changes to your public repository, and ask your "project
-     lead" to pull from it.  Your changes include your own,
-     patches you receive via e-mail, and merge resulting from
-     pulling the "public" repositories of your "project lead"
-     and possibly your "sub-subsystem maintainers".
+     repository.  Run "git repack" (and possibly "git
+     prune-packed" if the transport used for pulling from your
+     repository supports packed repositories.
+
+ (5) Keep working in your primary repository.  Your changes
+     include modifications of your own, patches you receive via
+     e-mails, and merges resulting from pulling the "public"
+     repositories of your "project lead" and possibly your
+     "sub-subsystem maintainers".
 
      You can repack this private repository whenever you feel
      like.
 
- (6) Every once in a while, "git repack" the public repository.
+ (6) Push your changes to your public repository, and ask your
+     "project lead" and possibly your "sub-subsystem
+     maintainers" to pull from it.
+
+ (7) Every once in a while, "git repack" the public repository.
      Go back to step (5) and continue working.
 
+
 A recommended work cycle for an "individual developer" who does
 not have a "public" repository is somewhat different.  It goes
 like this:
