From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] tutorial: mention "git clone" records .git/branches/origin
Date: Mon, 18 Jul 2005 10:29:36 -0700
Message-ID: <7vvf38rpj3.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
	<7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
	<7virzbnruf.fsf_-_@assigned-by-dhcp.cox.net>
	<7vek9yn1f5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507161032410.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 19:29:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuZR1-0006tz-2n
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 19:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVGRR3j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 13:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVGRR3j
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 13:29:39 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:4601 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261223AbVGRR3i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 13:29:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050718172938.JGJH22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Jul 2005 13:29:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507161032410.19183@g5.osdl.org> (Linus Torvalds's message of "Sat, 16 Jul 2005 10:33:30 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Update the recommended workflow for individual developers.
While they are tracking the origin, refs/heads/origin is updated
by "git fetch", so there is no need to manually copy FETCH_HEAD
to refs/heads/ anywhere.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/tutorial.txt |   48 ++++++++++++++++++++------------------------
 1 files changed, 22 insertions(+), 26 deletions(-)

6af33a52163dd15beaaf610f6b7506b900189770
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -1042,7 +1042,8 @@ A recommended work cycle for a "subsyste
 on that project and has own "public repository" goes like this:
 
  (1) Prepare your work repository, by "git clone" the public
-     repository of the "project lead".
+     repository of the "project lead".  The URL used for the
+     initial cloning is stored in .git/branches/origin.
 
  (2) Prepare a public repository accessible to others.
 
@@ -1051,7 +1052,7 @@ on that project and has own "public repo
      currently not automated.
 
  (4) Push into the public repository from your primary
-     repository.  Run "git repack" (and possibly "git
+     repository.  Run "git repack", and possibly "git
      prune-packed" if the transport used for pulling from your
      repository supports packed repositories.
 
@@ -1076,30 +1077,25 @@ A recommended work cycle for an "individ
 not have a "public" repository is somewhat different.  It goes
 like this:
 
- (1) Prepare your work repositories, by "git clone" the public
-     repository of the "project lead" (or "subsystem
-     maintainer", if you work on a subsystem).
-
- (2) Copy .git/refs/master to .git/refs/upstream.
-
- (3) Do your work there.  Make commits.
-
- (4) Run "git fetch" from the public repository of your upstream
-     every once in a while.  This does only the first half of
-     "git pull" but does not merge.  The head of the public
-     repository is stored in .git/FETCH_HEAD.  Copy it in
-     .git/refs/heads/upstream.
-
- (5) Use "git cherry" to see which ones of your patches were
-     accepted, and/or use "git rebase" to port your unmerged
-     changes forward to the updated upstream.
-
- (6) Use "git format-patch upstream" to prepare patches for
-     e-mail submission to your upstream and send it out.
-     Go back to step (3) and continue. 
-
-[Side Note: I think Cogito calls this upstream "origin".
- Somebody care to confirm or deny?  ]
+ (1) Prepare your work repository, by "git clone" the public
+     repository of the "project lead" (or a "subsystem
+     maintainer", if you work on a subsystem).  The URL used for
+     the initial cloning is stored in .git/branches/origin.
+
+ (2) Do your work there.  Make commits.
+
+ (3) Run "git fetch origin" from the public repository of your
+     upstream every once in a while.  This does only the first
+     half of "git pull" but does not merge.  The head of the
+     public repository is stored in .git/refs/heads/origin.
+
+ (4) Use "git cherry origin" to see which ones of your patches
+     were accepted, and/or use "git rebase origin" to port your
+     unmerged changes forward to the updated upstream.
+
+ (5) Use "git format-patch origin" to prepare patches for e-mail
+     submission to your upstream and send it out.  Go back to
+     step (2) and continue.
 
 
 [ to be continued.. cvsimports ]
