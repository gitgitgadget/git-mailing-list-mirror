From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: do people use the 'git' command?
Date: Fri, 10 Jun 2005 23:26:40 -0600
Message-ID: <E1DgyW0-0004PE-Ct@highlab.com>
References: <E1DgodI-0003ov-Fl@highlab.com> <7vy89h4m9r.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 07:21:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgyQi-0000yX-0a
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 07:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVFKFZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 01:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVFKFZL
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 01:25:11 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:59106 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261255AbVFKFYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 01:24:40 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (sccrmhc12) with ESMTP
          id <20050611052439012000tb6me>; Sat, 11 Jun 2005 05:24:39 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1DgyW0-0004PE-Ct; Fri, 10 Jun 2005 23:26:40 -0600
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vy89h4m9r.fsf@assigned-by-dhcp.cox.net> 
Comments: In-reply-to Junio C Hamano <junkio@cox.net>
   message dated "Fri, 10 Jun 2005 20:15:12 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> >>>>> "SK" == Sebastian Kuzminsky <seb@highlab.com> writes:
> 
> SK> Can we drop the "git" program?
> 
> No chance, especially with a patch that is not accompanied with
> necessary changes to Documentation/tutorial.txt that already
> tells the user to type "git commit" and "git log" ;-).

Of course, you're right.  How about this?  Against Cogito but applies
cleanly to Linus' git:


 b/Documentation/cvs-migration.txt |    4 ++--
 b/Documentation/tutorial.txt      |    6 +++---
 b/Makefile                        |    2 +-
 git                               |    4 ----
 4 files changed, 6 insertions(+), 10 deletions(-)


diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -63,7 +63,7 @@
 any more familiar with it, but make sure it is in your path. After that,
 the magic command line is
 
-	git cvsimport <cvsroot> <module>
+	git-cvsimport-script <cvsroot> <module>
 
 which will do exactly what you'd think it does: it will create a git
 archive of the named CVS module. The new archive will be created in a
@@ -90,7 +90,7 @@
 
 So, something has gone wrong, and you don't know whom to blame, and
 you're an ex-CVS user and used to do "cvs annotate" to see who caused
-the breakage. You're looking for the "git annotate", and it's just
+the breakage. You're looking for the "git-annotate", and it's just
 claiming not to find such a script. You're annoyed.
 
 Yes, that's right.  Core git doesn't do "annotate", although it's
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -362,7 +362,7 @@
 for you, and starts up an editor to let you write your commit message
 yourself, so let's just use that:
 
-	git commit
+	git-commit-script
 
 Write whatever message you want, and all the lines that start with '#'
 will be pruned out, and the rest will be used as the commit message for
@@ -417,7 +417,7 @@
 To see the whole history of our pitiful little git-tutorial project, you
 can do
 
-	git log
+	git-log-script
 
 which shows just the log messages, or if we want to see the log together
 with the associated patches use the more complex (and much more
@@ -465,7 +465,7 @@
    history outside of the project you created.
 
  - if you want to move or duplicate a git archive, you can do so. There
-   is no "git clone" command: if you want to create a copy of your
+   is no "git-clone" command: if you want to create a copy of your
    archive (with all the full history that went along with it), you can
    do so with a regular "cp -a git-tutorial new-git-tutorial".
 
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -42,7 +42,7 @@
 AR?=ar
 INSTALL?=install
 
-SCRIPTS=git git-apply-patch-script git-merge-one-file-script git-prune-script \
+SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
 	git-pull-script git-tag-script git-resolve-script git-whatchanged \
 	git-deltafy-script git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script
diff --git a/git b/git
deleted file mode 100755
--- a/git
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-cmd="git-$1-script"
-shift
-exec $cmd "$@"


-- 
Sebastian Kuzminsky
