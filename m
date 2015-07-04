From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 03/23] Documentation: move linked worktree description from checkout to worktree
Date: Fri,  3 Jul 2015 20:17:12 -0400
Message-ID: <1435969052-540-4-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:18:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAM-00004v-IV
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbbGDASh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:37 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38499 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611AbbGDASa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:30 -0400
Received: by igrv9 with SMTP id v9so85101680igr.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lfOSDroHaPH16d/MezOuxh1jWrgljl1e3Ho/NofkRoM=;
        b=PZCZx+ZAXnyDFYHI1NegWV7WqU4ntOdzMDmiRdUEY0FiMcx2rgBjXutcxQdLmFMvrr
         LIdXWmfFKeDfeV0FoTPc1t+oQO61AdeXWoKagbTog96AQaWqfy36SgKDQmCy+GBvzW5D
         h1gSfHUeCgTPKPk37UsUdDf9fojgfLcnXTDy0pwZQzgVRVr+ezvgURE2Pd5VOrgcZMx8
         Hsr4DYXXLpEb5W/M9t2w1QI/nojpChVkpV+oml3e11CFC8V/06g9TGk583Xc49R25kAz
         V/ooQNCxd/fGyUa8M/XHEukVC2Mok73KD0XjJKwigeYPFEmvRoWvGZtd075iGBTHOCUV
         gsjg==
X-Received: by 10.50.64.147 with SMTP id o19mr24405584igs.15.1435969109237;
        Fri, 03 Jul 2015 17:18:29 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.28
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:28 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273318>

Now that the git-worktree command exists, its documentation page is the
natural place for the linked worktree description to reside. Relocate
the "MULTIPLE WORKING TREES" description verbatim from git-checkout.txt
to git-worktree.txt.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

When Junio queued v1[1] on 'pu', he changed the second sentence of the
first paragraph of the description to say "...a new working tree is
created and associated..." in place of the original "...a new working
tree is associated...". I wanted this to be a pure documentation-
movement patch, so I did not carry over his modification. Moreover, his
text is not quite accurate since, although <path> will be created if
missing, <path> can also be pre-existing, provided that it is an empty
directory. Patch 13/23 adds documentation which states this explicitly.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/273032

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
