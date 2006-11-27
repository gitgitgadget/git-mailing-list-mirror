X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH/RFC] "init-db" can really be just "init"
Date: Mon, 27 Nov 2006 16:31:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 27 Nov 2006 21:32:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32452>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goo53-0003dA-PS for gcvg-git@gmane.org; Mon, 27 Nov
 2006 22:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933709AbWK0Vbu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 16:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933692AbWK0Vbu
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 16:31:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S933689AbWK0Vbt (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 16:31:49 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9E004VDRSZWOI1@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Mon,
 27 Nov 2006 16:31:49 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This should make first GIT impression a little less intimidating.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

Maybe that could be a good rule of thumb to have all porcelainish 
commands not have any hyphen in their name, like "diff", "commit", 
"add", etc. ?

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 9677671..ee9ddee 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -25,7 +25,7 @@ Basic Repository[[Basic Repository]]
 
 Everybody uses these commands to maintain git repositories.
 
-  * gitlink:git-init-db[1] or gitlink:git-clone[1] to create a
+  * gitlink:git-init[1] or gitlink:git-clone[1] to create a
     new repository.
 
   * gitlink:git-fsck-objects[1] to check the repository for errors.
@@ -106,7 +106,7 @@ Use a tarball as a starting point for a new repository:
 ------------
 $ tar zxf frotz.tar.gz
 $ cd frotz
-$ git-init-db
+$ git-init
 $ git add . <1>
 $ git commit -m 'import of frotz source tree.'
 $ git tag v2.43 <2>
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index ca7d09d..bc3ba14 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -74,6 +74,7 @@ Running `git-init-db` in an existing repository is safe. It will not overwrite
 things that are already there. The primary reason for rerunning `git-init-db`
 is to pick up newly added templates.
 
+Note that `git-init` is the same as `git-init-db`.
 
 
 EXAMPLES
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
new file mode 100644
index 0000000..36838c7
--- /dev/null
+++ b/Documentation/git-init.txt
@@ -0,0 +1 @@
+include::git-init-db.txt[]
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 619d656..5501ae0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -347,6 +347,7 @@ gitlink:git-hash-object[1]::
 gitlink:git-index-pack[1]::
 	Build pack idx file for an existing packed archive.
 
+gitlink:git-init[1]::
 gitlink:git-init-db[1]::
 	Creates an empty git object database, or reinitialize an
 	existing one.
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 6389de5..13a1878 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -17,7 +17,7 @@ Let's start a new project and create a small amount of history:
 ------------------------------------------------
 $ mkdir test-project
 $ cd test-project
-$ git init-db
+$ git init
 defaulting to local storage area
 $ echo 'hello world' > file.txt
 $ git add .
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 35af81a..978d4bd 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -20,7 +20,7 @@ can place it under git revision control as follows.
 ------------------------------------------------
 $ tar xzf project.tar.gz
 $ cd project
-$ git init-db
+$ git init
 ------------------------------------------------
 
 Git will reply
diff --git a/Makefile b/Makefile
index e547e2a..c307324 100644
--- a/Makefile
+++ b/Makefile
@@ -203,7 +203,7 @@ EXTRA_PROGRAMS =
 
 BUILT_INS = \
 	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
-	git-get-tar-commit-id$X \
+	git-get-tar-commit-id$X git-init$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
 # what 'all' will build and 'install' will install, in gitexecdir
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 235a0ee..408b51a 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -242,7 +242,7 @@ static void create_default_files(const char *git_dir, const char *template_path)
 }
 
 static const char init_db_usage[] =
-"git-init-db [--template=<template-directory>] [--shared]";
+"git-init [--template=<template-directory>] [--shared]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
diff --git a/git.c b/git.c
index f97de60..5ae5afc 100644
--- a/git.c
+++ b/git.c
@@ -241,6 +241,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP },
 		{ "help", cmd_help },
+		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
