From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/23] Documentation: move linked worktree description from checkout to worktree
Date: Mon,  6 Jul 2015 13:30:40 -0400
Message-ID: <1436203860-846-4-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAF5-0007f6-QD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbbGFRbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:37 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33134 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570AbbGFRbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:32 -0400
Received: by ieqy10 with SMTP id y10so118355291ieq.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H8PJRg81L+BuChcsLhCHUCpanP7NJrC9bJTXg7Tr0F0=;
        b=MBk1ewd+/VWZz5qteUIxDa0omuqXR/lNmTx3vIeDrLH8gNHZPWNg0fVU7ygLJ8rP0u
         qoB5BvnLFAR/zLXzq3RDXkQo8bfBmgkUlWJFzx/M4fgv3H9zdbIYeZxr1qW2wo8tfyrN
         fqsWnkUnH2EY8QgGzUnVO+rHwKocvim3CulJzZtPl/FIaqWem0sQx1yosOPzLz4cB3h3
         4Z47hfPPcZVBZSi0EsAjIAHDpO2WQuaOhCc4TS4RZIO5x9vO7RBG0hUvU6RPjTqNtmMd
         SJhkAgl7vwPOqamHekYMh60I1GxFQMGVrMORXUE2BfQiDvZ6PSFWUhKG1jJ1GLt0b/sX
         rDUQ==
X-Received: by 10.107.167.73 with SMTP id q70mr4200ioe.82.1436203891766;
        Mon, 06 Jul 2015 10:31:31 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.30
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273414>

Now that the git-worktree command exists, its documentation page is the
natural place for the linked worktree description to reside. Relocate
the "MULTIPLE WORKING TREES" description verbatim from git-checkout.txt
to git-worktree.txt.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-checkout.txt | 69 ++----------------------------------------
 Documentation/git-worktree.txt | 62 +++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 67 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index ce223e6..77b7141 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -229,8 +229,8 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	Check out a branch in a separate working directory at
 	`<path>`. A new working directory is linked to the current
 	repository, sharing everything except working directory
-	specific files such as HEAD, index... See "MULTIPLE WORKING
-	TREES" section for more information.
+	specific files such as HEAD, index, etc. See
+	linkgit:git-worktree[1] for a description of linked worktrees.
 
 --ignore-other-worktrees::
 	`git checkout` refuses when the wanted ref is already checked
@@ -401,71 +401,6 @@ $ git reflog -2 HEAD # or
 $ git log -g -2 HEAD
 ------------
 
-MULTIPLE WORKING TREES
-----------------------
-
-A git repository can support multiple working trees, allowing you to check
-out more than one branch at a time.  With `git checkout --to` a new working
-tree is associated with the repository.  This new working tree is called a
-"linked working tree" as opposed to the "main working tree" prepared by "git
-init" or "git clone".  A repository has one main working tree (if it's not a
-bare repository) and zero or more linked working trees.
-
-Each linked working tree has a private sub-directory in the repository's
-$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
-the base name of the linked working tree's path, possibly appended with a
-number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
-command `git checkout --to /path/other/test-next next` creates the linked
-working tree in `/path/other/test-next` and also creates a
-`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
-if `test-next` is already taken).
-
-Within a linked working tree, $GIT_DIR is set to point to this private
-directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
-$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
-(e.g. `/path/main/.git`). These settings are made in a `.git` file located at
-the top directory of the linked working tree.
-
-Path resolution via `git rev-parse --git-path` uses either
-$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
-linked working tree `git rev-parse --git-path HEAD` returns
-`/path/main/.git/worktrees/test-next/HEAD` (not
-`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
-rev-parse --git-path refs/heads/master` uses
-$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
-since refs are shared across all working trees.
-
-See linkgit:gitrepository-layout[5] for more information. The rule of
-thumb is do not make any assumption about whether a path belongs to
-$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
-inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
-
-When you are done with a linked working tree you can simply delete it.
-The working tree's entry in the repository's $GIT_DIR/worktrees
-directory will eventually be removed automatically (see
-`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
-`git worktree prune` in the main or any linked working tree to
-clean up any stale entries in $GIT_DIR/worktrees.
-
-If you move a linked working directory to another file system, or
-within a file system that does not support hard links, you need to run
-at least one git command inside the linked working directory
-(e.g. `git status`) in order to update its entry in $GIT_DIR/worktrees
-so that it does not get automatically removed.
-
-To prevent a $GIT_DIR/worktrees entry from from being pruned (which
-can be useful in some situations, such as when the
-entry's working tree is stored on a portable device), add a file named
-'locked' to the entry's directory. The file contains the reason in
-plain text. For example, if a linked working tree's `.git` file points
-to `/path/main/.git/worktrees/test-next` then a file named
-`/path/main/.git/worktrees/test-next/locked` will prevent the
-`test-next` entry from being pruned.  See
-linkgit:gitrepository-layout[5] for details.
-
-Multiple checkout support for submodules is incomplete. It is NOT
-recommended to make multiple checkouts of a superproject.
-
 EXAMPLES
 --------
 
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 1ac1217..3d28896 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -17,6 +17,68 @@ DESCRIPTION
 Manage multiple worktrees attached to the same repository. These are
 created by the command `git checkout --to`.
 
+A git repository can support multiple working trees, allowing you to check
+out more than one branch at a time.  With `git checkout --to` a new working
+tree is associated with the repository.  This new working tree is called a
+"linked working tree" as opposed to the "main working tree" prepared by "git
+init" or "git clone".  A repository has one main working tree (if it's not a
+bare repository) and zero or more linked working trees.
+
+Each linked working tree has a private sub-directory in the repository's
+$GIT_DIR/worktrees directory.  The private sub-directory's name is usually
+the base name of the linked working tree's path, possibly appended with a
+number to make it unique.  For example, when `$GIT_DIR=/path/main/.git` the
+command `git checkout --to /path/other/test-next next` creates the linked
+working tree in `/path/other/test-next` and also creates a
+`$GIT_DIR/worktrees/test-next` directory (or `$GIT_DIR/worktrees/test-next1`
+if `test-next` is already taken).
+
+Within a linked working tree, $GIT_DIR is set to point to this private
+directory (e.g. `/path/main/.git/worktrees/test-next` in the example) and
+$GIT_COMMON_DIR is set to point back to the main working tree's $GIT_DIR
+(e.g. `/path/main/.git`). These settings are made in a `.git` file located at
+the top directory of the linked working tree.
+
+Path resolution via `git rev-parse --git-path` uses either
+$GIT_DIR or $GIT_COMMON_DIR depending on the path. For example, in the
+linked working tree `git rev-parse --git-path HEAD` returns
+`/path/main/.git/worktrees/test-next/HEAD` (not
+`/path/other/test-next/.git/HEAD` or `/path/main/.git/HEAD`) while `git
+rev-parse --git-path refs/heads/master` uses
+$GIT_COMMON_DIR and returns `/path/main/.git/refs/heads/master`,
+since refs are shared across all working trees.
+
+See linkgit:gitrepository-layout[5] for more information. The rule of
+thumb is do not make any assumption about whether a path belongs to
+$GIT_DIR or $GIT_COMMON_DIR when you need to directly access something
+inside $GIT_DIR. Use `git rev-parse --git-path` to get the final path.
+
+When you are done with a linked working tree you can simply delete it.
+The working tree's entry in the repository's $GIT_DIR/worktrees
+directory will eventually be removed automatically (see
+`gc.pruneworktreesexpire` in linkgit::git-config[1]), or you can run
+`git worktree prune` in the main or any linked working tree to
+clean up any stale entries in $GIT_DIR/worktrees.
+
+If you move a linked working directory to another file system, or
+within a file system that does not support hard links, you need to run
+at least one git command inside the linked working directory
+(e.g. `git status`) in order to update its entry in $GIT_DIR/worktrees
+so that it does not get automatically removed.
+
+To prevent a $GIT_DIR/worktrees entry from from being pruned (which
+can be useful in some situations, such as when the
+entry's working tree is stored on a portable device), add a file named
+'locked' to the entry's directory. The file contains the reason in
+plain text. For example, if a linked working tree's `.git` file points
+to `/path/main/.git/worktrees/test-next` then a file named
+`/path/main/.git/worktrees/test-next/locked` will prevent the
+`test-next` entry from being pruned.  See
+linkgit:gitrepository-layout[5] for details.
+
+Multiple checkout support for submodules is incomplete. It is NOT
+recommended to make multiple checkouts of a superproject.
+
 COMMANDS
 --------
 prune::
-- 
2.5.0.rc1.197.g417e668
