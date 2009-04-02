From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] {diff,merge}tool: rename helpers to remove them from tab-completion
Date: Thu,  2 Apr 2009 04:38:16 -0700
Message-ID: <1238672296-10265-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 02 13:41:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpLHn-00011e-0m
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 13:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242AbZDBLig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 07:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756762AbZDBLig
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 07:38:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:8512 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755319AbZDBLif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 07:38:35 -0400
Received: by wa-out-1112.google.com with SMTP id j5so395945wah.21
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kQuB5yVaMcf3wDpTydnSJiJ06Da3JHRcYu6DEDqRTjM=;
        b=RK8SDFCd3Px+gBfXvB008VZF3XxMywEgE6p5IqbYNlo2atcMmcGTmqxCtR81FzFdhR
         CZzvoxbNCmSIYdI0eI6rlqpJF1W5boI93q132s35vgTo3scy4eKLcI/mwc45w1T6fBoN
         NZo/mvTGT3D+Wx5FRE3+wcN6dNEHzAmWu02So=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MxG5KNrtEOj4NKCJxnMRdLEjQ4EhvzI9jvMTtLO9Iw8mTk84I0c4eJf2h8b1k4/Wp0
         DDDgaRFNM1A1WqSGzvO5I9xXHwBbgs7iOLNEFjRTAr2/JwMCS2sHhpGqz0MOcYRxvk5x
         y00NUhBxTtsP+N2jNgbndgGD4eksm1z5QvfzI=
Received: by 10.114.161.11 with SMTP id j11mr5853079wae.105.1238672313056;
        Thu, 02 Apr 2009 04:38:33 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g25sm1055536wag.8.2009.04.02.04.38.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 04:38:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.469.gdffc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115460>

Users should never run difftool-helper or mergetool-lib directly,
so rename them to *--helper and *--lib.  This keeps the helper
scripts from showing up when using bash tab completion.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This is based on the 'pu' branch + the patches
I sent out earlier.


 .gitignore                                         |    4 ++--
 ...it-mergetool-lib.txt => git-mergetool--lib.txt} |   10 +++++-----
 Makefile                                           |    4 ++--
 command-list.txt                                   |    2 +-
 git-difftool-helper.sh => git-difftool--helper.sh  |    6 +++---
 git-difftool.perl                                  |    6 +++---
 git-mergetool-lib.sh => git-mergetool--lib.sh      |    2 +-
 git-mergetool.sh                                   |    2 +-
 8 files changed, 18 insertions(+), 18 deletions(-)
 rename Documentation/{git-mergetool-lib.txt => git-mergetool--lib.txt} (82%)
 rename git-difftool-helper.sh => git-difftool--helper.sh (96%)
 rename git-mergetool-lib.sh => git-mergetool--lib.sh (98%)

diff --git a/.gitignore b/.gitignore
index 75c154a..757c7f0 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,7 +36,7 @@ git-diff-files
 git-diff-index
 git-diff-tree
 git-difftool
-git-difftool-helper
+git-difftool--helper
 git-describe
 git-fast-export
 git-fast-import
@@ -80,7 +80,7 @@ git-merge-recursive
 git-merge-resolve
 git-merge-subtree
 git-mergetool
-git-mergetool-lib
+git-mergetool--lib
 git-mktag
 git-mktree
 git-name-rev
diff --git a/Documentation/git-mergetool-lib.txt b/Documentation/git-mergetool--lib.txt
similarity index 82%
rename from Documentation/git-mergetool-lib.txt
rename to Documentation/git-mergetool--lib.txt
index 7377774..ffda66b 100644
--- a/Documentation/git-mergetool-lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -1,13 +1,13 @@
-git-mergetool-lib(1)
-====================
+git-mergetool--lib(1)
+=====================
 
 NAME
 ----
-git-mergetool-lib - Common git merge tool shell scriptlets
+git-mergetool--lib - Common git merge tool shell scriptlets
 
 SYNOPSIS
 --------
-'. "$(git --exec-path)/git-mergetool-lib"'
+'. "$(git --exec-path)/git-mergetool--lib"'
 
 DESCRIPTION
 -----------
@@ -16,7 +16,7 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 Porcelain-ish scripts and/or are writing new ones.
 
-The 'git-mergetool-lib' scriptlet is designed to be sourced (using
+The 'git-mergetool--lib' scriptlet is designed to be sourced (using
 `.`) by other shell scripts to set up functions for working
 with git merge tools.
 
diff --git a/Makefile b/Makefile
index 086f9e7..3e56274 100644
--- a/Makefile
+++ b/Makefile
@@ -277,14 +277,14 @@ TEST_PROGRAMS =
 
 SCRIPT_SH += git-am.sh
 SCRIPT_SH += git-bisect.sh
-SCRIPT_SH += git-difftool-helper.sh
+SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
-SCRIPT_SH += git-mergetool-lib.sh
+SCRIPT_SH += git-mergetool--lib.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
diff --git a/command-list.txt b/command-list.txt
index 922c815..fd66395 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -69,7 +69,7 @@ git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
 git-merge-one-file                      purehelpers
 git-mergetool                           ancillarymanipulators
-git-mergetool-lib                       purehelpers
+git-mergetool--lib                      purehelpers
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
diff --git a/git-difftool-helper.sh b/git-difftool--helper.sh
similarity index 96%
rename from git-difftool-helper.sh
rename to git-difftool--helper.sh
index d174b34..602cd4f 100755
--- a/git-difftool-helper.sh
+++ b/git-difftool--helper.sh
@@ -1,13 +1,13 @@
 #!/bin/sh
-# git-difftool-helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
+# git-difftool--helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
 # This script is typically launched by using the 'git difftool'
 # convenience command.
 #
 # Copyright (c) 2009 David Aguilar
 
-# Load common functions from git-mergetool-lib
+# Load common functions from git-mergetool--lib
 TOOL_MODE=diff
-. git-mergetool-lib
+. git-mergetool--lib
 
 # difftool.prompt controls the default prompt/no-prompt behavior
 # and is overridden with $GIT_DIFFTOOL*_PROMPT.
diff --git a/git-difftool.perl b/git-difftool.perl
index 985dfe0..948ff7f 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -2,11 +2,11 @@
 # Copyright (c) 2009 David Aguilar
 #
 # This is a wrapper around the GIT_EXTERNAL_DIFF-compatible
-# git-difftool-helper script.
+# git-difftool--helper script.
 #
 # This script exports GIT_EXTERNAL_DIFF and GIT_PAGER for use by git.
 # GIT_DIFFTOOL_NO_PROMPT, GIT_DIFFTOOL_PROMPT, and GIT_DIFF_TOOL
-# are exported for use by git-difftool-helper.
+# are exported for use by git-difftool--helper.
 #
 # Any arguments that are unknown to this script are forwarded to 'git diff'.
 
@@ -30,7 +30,7 @@ sub setup_environment
 {
 	$ENV{PATH} = "$DIR:$ENV{PATH}";
 	$ENV{GIT_PAGER} = '';
-	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool-helper';
+	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
 }
 
 sub exe
diff --git a/git-mergetool-lib.sh b/git-mergetool--lib.sh
similarity index 98%
rename from git-mergetool-lib.sh
rename to git-mergetool--lib.sh
index 197533e..91d5453 100644
--- a/git-mergetool-lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,4 +1,4 @@
-# git-mergetool-lib is a library for common merge tool functions
+# git-mergetool--lib is a library for common merge tool functions
 diff_mode() {
 	test $TOOL_MODE = "diff"
 }
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 16562bd..401c107 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -13,7 +13,7 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 TOOL_MODE=merge
 . git-sh-setup
-. git-mergetool-lib
+. git-mergetool--lib
 require_work_tree
 
 # Returns true if the mode reflects a symlink
-- 
1.6.2.1.469.gdffc1
