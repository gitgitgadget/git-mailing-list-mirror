Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAEEE95A67
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbjJHGqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJHGpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC0AF4
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406650da82bso31945185e9.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747539; x=1697352339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWrRDWmuKNGFWC6JuocFGdOrnGxs6hYPP7n9KlRUB4c=;
        b=Rcsxntlf0zRjboZyr4cHl7OMs5jDXVZi9xj22BuTFbD669Ycm7RvZN2Yy6QDiTk5i2
         47RZlsmKMaQXHuuabzAjaYBlo5fdjEQBg8KRMNMX3/LrHjtIEVNCSgulxyIFYiL/cysN
         B8qajvYi229cvxjYjKC9vS0mkX9wrl1kmz8pWiIbWJ695aMOWtmsmpHHBcTWodB7xM7e
         VMDfDddikRvEUmuAB1rG7c/g2iWQT71HySCX4+M59xIhIRo0rRfFkgpaJ+ujr6WdBU9k
         V5mL3doRbq+jFqxsAXIsyxG37cxJ8wS49akcxSwz4i63O08mSYKzLxf8CLy3RPk/wLvn
         m2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747539; x=1697352339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWrRDWmuKNGFWC6JuocFGdOrnGxs6hYPP7n9KlRUB4c=;
        b=PjrKvb2b5ht+NavFZLpEvUiBZnK1hTasNXkHxklVBiV5ZIVlTecrdm0g5N5pIP3taP
         Fg9XWH5MlkTeLDeBKGcZHbBt/znI2rRvWI8WPffXIw67jUXXPjRbAXH2U/PlXvxdQKoh
         vLpL//WtfOb9qZbK3Z0IU9+x9sStRnYCYjwqnay9oJm2Y87+2PT6zPia7efU5Wdgxi7H
         dFteAmqYzq7HFuOjHXASLs5iNMKla8yU9TP9e6DAcer059XomiDKQccSvtSfyaKVAtui
         6CakfSs+yiDsMVdfyYxDHOiwv4i/wuchQb42B5fCkDflHQe+l0VfqjoGgwD0yeMk9+Oc
         vF4w==
X-Gm-Message-State: AOJu0YzXLLSlRoFcFV4rcEX7IT6G2FbdMw6y7iKwEkj1e9CLxmEvr72k
        CXYeLuxA7xlZYGOlNMm6IzUCpDD9hLw=
X-Google-Smtp-Source: AGHT+IHj7Ypdoqt34Ls7ba1GL1W/FUlyfg6+RY6k1hXLryPs2J9NysQNqkB5IHJgWqYY2Zam0W4uLw==
X-Received: by 2002:a05:6000:104a:b0:31a:d2f9:7372 with SMTP id c10-20020a056000104a00b0031ad2f97372mr10978290wrx.29.1696747538503;
        Sat, 07 Oct 2023 23:45:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b003143c9beeaesm6006516wrx.44.2023.10.07.23.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:38 -0700 (PDT)
Message-ID: <a5fc283bab4864d024ad351e9029dcfc8353eaa1.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:14 +0000
Subject: [PATCH 12/25] documentation: fix singular vs. plural
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/ToolsForGit.txt                  | 2 +-
 Documentation/config/advice.txt                | 2 +-
 Documentation/config/column.txt                | 2 +-
 Documentation/config/diff.txt                  | 2 +-
 Documentation/config/fetch.txt                 | 2 +-
 Documentation/config/mailinfo.txt              | 2 +-
 Documentation/config/rerere.txt                | 2 +-
 Documentation/config/user.txt                  | 2 +-
 Documentation/config/versionsort.txt           | 4 ++--
 Documentation/diff-generate-patch.txt          | 2 +-
 Documentation/git-am.txt                       | 2 +-
 Documentation/git-merge-tree.txt               | 6 +++---
 Documentation/git-repack.txt                   | 2 +-
 Documentation/git-replace.txt                  | 2 +-
 Documentation/git-send-pack.txt                | 4 ++--
 Documentation/git-show-branch.txt              | 2 +-
 Documentation/git-show.txt                     | 2 +-
 Documentation/git-update-index.txt             | 6 +++---
 Documentation/git-whatchanged.txt              | 2 +-
 Documentation/gitcli.txt                       | 2 +-
 Documentation/gitdiffcore.txt                  | 2 +-
 Documentation/giteveryday.txt                  | 2 +-
 Documentation/githooks.txt                     | 4 ++--
 Documentation/gitsubmodules.txt                | 2 +-
 Documentation/mergetools/vimdiff.txt           | 2 +-
 Documentation/technical/api-index-skel.txt     | 2 +-
 Documentation/technical/racy-git.txt           | 2 +-
 Documentation/technical/repository-version.txt | 2 +-
 Documentation/urls-remotes.txt                 | 2 +-
 29 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/Documentation/ToolsForGit.txt b/Documentation/ToolsForGit.txt
index 5d01e8191aa..209eaad31ea 100644
--- a/Documentation/ToolsForGit.txt
+++ b/Documentation/ToolsForGit.txt
@@ -5,7 +5,7 @@ Tools for developing Git
 [[summary]]
 == Summary
 
-This document gathers tips, scripts and configuration file to help people
+This document gathers tips, scripts and configuration files to help people
 working on Git's codebase use their favorite tools while following Git's
 coding style.
 
diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c8e38a0e5cd..c5cde1c24ee 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -63,7 +63,7 @@ advice.*::
 		the template shown when writing commit messages in
 		linkgit:git-commit[1], and in the help message shown
 		by linkgit:git-switch[1] or
-		linkgit:git-checkout[1] when switching branch.
+		linkgit:git-checkout[1] when switching branches.
 	statusUoption::
 		Advise to consider using the `-u` option to linkgit:git-status[1]
 		when the command takes more than 2 seconds to enumerate untracked
diff --git a/Documentation/config/column.txt b/Documentation/config/column.txt
index 9f30322362d..01e4198429e 100644
--- a/Documentation/config/column.txt
+++ b/Documentation/config/column.txt
@@ -51,5 +51,5 @@ column.status::
 	See `column.ui` for details.
 
 column.tag::
-	Specify whether to output tag listing in `git tag` in columns.
+	Specify whether to output tag listings in `git tag` in columns.
 	See `column.ui` for details.
diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 9391c77e552..bd5ae0c3378 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -1,6 +1,6 @@
 diff.autoRefreshIndex::
 	When using 'git diff' to compare with work tree
-	files, do not consider stat-only change as changed.
+	files, do not consider stat-only changes as changed.
 	Instead, silently run `git update-index --refresh` to
 	update the cached stat information for paths whose
 	contents in the work tree match the contents in the
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index c1a7cdd6bf4..aea5b97477b 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -53,7 +53,7 @@ fetch.pruneTags::
 fetch.output::
 	Control how ref update status is printed. Valid values are
 	`full` and `compact`. Default value is `full`. See the
-	OUTPUT section in linkgit:git-fetch[1] for detail.
+	OUTPUT section in linkgit:git-fetch[1] for details.
 
 fetch.negotiationAlgorithm::
 	Control how information about the commits in the local repository
diff --git a/Documentation/config/mailinfo.txt b/Documentation/config/mailinfo.txt
index 3854d4ae37c..ec3a5d81f72 100644
--- a/Documentation/config/mailinfo.txt
+++ b/Documentation/config/mailinfo.txt
@@ -1,6 +1,6 @@
 mailinfo.scissors::
 	If true, makes linkgit:git-mailinfo[1] (and therefore
 	linkgit:git-am[1]) act by default as if the --scissors option
-	was provided on the command-line. When active, this features
+	was provided on the command-line. When active, this feature
 	removes everything from the message body before a scissors
 	line (i.e. consisting mainly of ">8", "8<" and "-").
diff --git a/Documentation/config/rerere.txt b/Documentation/config/rerere.txt
index 40abdf6a6b5..3a78b5ebb1d 100644
--- a/Documentation/config/rerere.txt
+++ b/Documentation/config/rerere.txt
@@ -1,7 +1,7 @@
 rerere.autoUpdate::
 	When set to true, `git-rerere` updates the index with the
 	resulting contents after it cleanly resolves conflicts using
-	previously recorded resolution.  Defaults to false.
+	previously recorded resolutions.  Defaults to false.
 
 rerere.enabled::
 	Activate recording of resolved conflicts, so that identical
diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
index 958e62464a5..2bbc8e929f0 100644
--- a/Documentation/config/user.txt
+++ b/Documentation/config/user.txt
@@ -5,7 +5,7 @@ author.email::
 committer.name::
 committer.email::
 	The `user.name` and `user.email` variables determine what ends
-	up in the `author` and `committer` field of commit
+	up in the `author` and `committer` fields of commit
 	objects.
 	If you need the `author` or `committer` to be different, the
 	`author.name`, `author.email`, `committer.name` or
diff --git a/Documentation/config/versionsort.txt b/Documentation/config/versionsort.txt
index 6c7cc054fad..0d66617f59f 100644
--- a/Documentation/config/versionsort.txt
+++ b/Documentation/config/versionsort.txt
@@ -24,9 +24,9 @@ among those other suffixes.  E.g. if the suffixes "-rc", "", "-ck" and
 are listed first, followed by "v4.8", then "v4.8-ckX" and finally
 "v4.8-bfsX".
 +
-If more than one suffixes match the same tagname, then that tagname will
+If more than one suffix matches the same tagname, then that tagname will
 be sorted according to the suffix which starts at the earliest position in
-the tagname.  If more than one different matching suffixes start at
+the tagname.  If more than one different matching suffix starts at
 that earliest position, then that tagname will be sorted according to the
 longest of those suffixes.
 The sorting order between different suffixes is undefined if they are
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 49ad31fca2a..65e0b1646e1 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -142,7 +142,7 @@ or like this (when the `--cc` option is used):
 +
 The `mode <mode>,<mode>..<mode>` line appears only if at least one of
 the <mode> is different from the rest. Extended headers with
-information about detected contents movement (renames and
+information about detected content movement (renames and
 copying detection) are designed to work with diff of two
 <tree-ish> and are not used by combined diff format.
 
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 900be198b14..51c26715159 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -22,7 +22,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Splits mail messages in a mailbox into commit log message,
+Splits mail messages in a mailbox into commit log messages,
 authorship information and patches, and applies them to the
 current branch. You could think of it as a reverse operation
 of linkgit:git-format-patch[1] run on a branch with a straight
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index ffc4fbf7e89..9f951c7fe34 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -24,7 +24,7 @@ this documentation describes modern `--write-tree` mode.
 Performs a merge, but does not make any new commits and does not read
 from or write to either the working tree or index.
 
-The performed merge will use the same feature as the "real"
+The performed merge will use the same features as the "real"
 linkgit:git-merge[1], including:
 
   * three way content merges of individual files
@@ -253,7 +253,7 @@ Do NOT attempt to guess or make the user guess the conflict types from
 the <<CFI,Conflicted file info>> list.  The information there is
 insufficient to do so.  For example: Rename/rename(1to2) conflicts (both
 sides renamed the same file differently) will result in three different
-file having higher order stages (but each only has one higher order
+files having higher order stages (but each only has one higher order
 stage), with no way (short of the <<IM,Informational messages>> section)
 to determine which three files are related.  File/directory conflicts
 also result in a file with exactly one higher order stage.
@@ -263,7 +263,7 @@ a file with exactly one higher order stage.  In all cases, the
 <<IM,Informational messages>> section has the necessary info, though it
 is not designed to be machine parseable.
 
-Do NOT assume that each paths from <<CFI,Conflicted file info>>, and
+Do NOT assume that each path from <<CFI,Conflicted file info>>, and
 the logical conflicts in the <<IM,Informational messages>> have a
 one-to-one mapping, nor that there is a one-to-many mapping, nor a
 many-to-one mapping.  Many-to-many mappings exist, meaning that each
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index cbc0ece61e3..882ec056a3c 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -207,7 +207,7 @@ When `--unpacked` is specified, loose objects are implicitly included in
 this "roll-up", without respect to their reachability. This is subject
 to change in the future. This option (implying a drastically different
 repack mode) is not guaranteed to work with all other combinations of
-option to `git repack`.
+options to `git repack`.
 +
 When writing a multi-pack bitmap, `git repack` selects the largest resulting
 pack as the preferred pack for object selection by the MIDX (see
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index f271d758c38..fdd2e0f0883 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -111,7 +111,7 @@ OPTIONS
 FORMATS
 -------
 
-The following format are available:
+The following formats are available:
 
 * 'short':
 	<replaced sha1>
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index e76c262d7f9..9c1ed757b9d 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -115,7 +115,7 @@ both on the local side and on the remote side are updated.
 
 When one or more '<ref>' are specified explicitly (whether on the
 command line or via `--stdin`), it can be either a
-single pattern, or a pair of such pattern separated by a colon
+single pattern, or a pair of such patterns separated by a colon
 ":" (this means that a ref name cannot have a colon in it).  A
 single pattern '<name>' is just shorthand for '<name>:<name>'.
 
@@ -130,7 +130,7 @@ name. See linkgit:git-rev-parse[1].
  - It is an error if <src> does not match exactly one of the
    local refs.
 
- - It is an error if <dst> matches more than one remote refs.
+ - It is an error if <dst> matches more than one remote ref.
 
  - If <dst> does not match any remote ref, either
 
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 58cf6210cde..080b5246a4e 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -154,7 +154,7 @@ $ git show-branch master fixes mhf
   ! [mhf] Allow "+remote:local" refspec to cause --force when fetching.
 ---
   + [mhf] Allow "+remote:local" refspec to cause --force when fetching.
-  + [mhf~1] Use git-octopus when pulling more than one heads.
+  + [mhf~1] Use git-octopus when pulling more than one head.
  +  [fixes] Introduce "reset type" flag to "git reset"
   + [mhf~2] "git fetch --force".
   + [mhf~3] Use .git/remote/origin, not .git/branches/origin.
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index 03c06345186..5eb67439aff 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -61,7 +61,7 @@ EXAMPLES
 --------
 
 `git show v1.0.0`::
-	Shows the tag `v1.0.0`, along with the object the tags
+	Shows the tag `v1.0.0`, along with the object the tag
 	points at.
 
 `git show v1.0.0^{tree}`::
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1271486ae9c..7f0c950a5fd 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -49,7 +49,7 @@ OPTIONS
 --remove::
 	If a specified file is in the index but is missing then it's
 	removed.
-	Default behavior is to ignore removed file.
+	Default behavior is to ignore removed files.
 
 --refresh::
 	Looks at the current index and checks to see if merges or
@@ -108,7 +108,7 @@ you will need to handle the situation manually.
 	without regard to the "assume unchanged" setting.
 
 --[no-]skip-worktree::
-	When one of these flags is specified, the object name recorded
+	When one of these flags is specified, the object names recorded
 	for the paths are not updated. Instead, these options
 	set and unset the "skip-worktree" bit for the paths. See
 	section "Skip-worktree bit" below for more information.
@@ -119,7 +119,7 @@ you will need to handle the situation manually.
 	the `--remove` option was specified.
 
 --[no-]fsmonitor-valid::
-	When one of these flags is specified, the object name recorded
+	When one of these flags is specified, the object names recorded
 	for the paths are not updated. Instead, these options
 	set and unset the "fsmonitor valid" bit for the paths. See
 	section "File System Monitor" below for more information.
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index ee8c1aa0ca4..fc2dc5a3b1d 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -3,7 +3,7 @@ git-whatchanged(1)
 
 NAME
 ----
-git-whatchanged - Show logs with difference each commit introduces
+git-whatchanged - Show logs with differences each commit introduces
 
 
 SYNOPSIS
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index f0986881bac..71ffe5556ae 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -26,7 +26,7 @@ arguments.  Here are the rules:
     accept dashed options after you have already given non-option
     arguments (which may make the command ambiguous), but you should
     not rely on it (because eventually we may find a way to fix
-    these ambiguity by enforcing the "options then args" rule).
+    these ambiguities by enforcing the "options then args" rule).
 
  * Revisions come first and then paths.
    E.g. in `git diff v1.0 v2.0 arch/x86 include/asm-x86`,
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 5681ba3f330..411ce863598 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -230,7 +230,7 @@ like these:
 
 * -B/60 (the same as above, since diffcore-break defaults to 50%).
 
-Note that earlier implementation left a broken pair as a separate
+Note that earlier implementation left a broken pair as separate
 creation and deletion patches.  This was an unnecessary hack and
 the latest implementation always merges all the broken pairs
 back into modifications, but the resulting patch output is
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index faba2ef0881..12b62b91256 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -14,7 +14,7 @@ DESCRIPTION
 -----------
 
 Git users can broadly be grouped into four categories for the purposes of
-describing here a small set of useful command for everyday Git.
+describing here a small set of useful commands for everyday Git.
 
 *	<<STANDALONE,Individual Developer (Standalone)>> commands are essential
 	for anybody who makes a commit, even for somebody who works alone.
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 34e2c656de3..e62ad343eda 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -80,7 +80,7 @@ If it exits with non-zero status, then the working tree will not be
 committed after applying the patch.
 
 It can be used to inspect the current working tree and refuse to
-make a commit if it does not pass certain test.
+make a commit if it does not pass certain tests.
 
 The default 'pre-applypatch' hook, when enabled, runs the
 'pre-commit' hook, if the latter is enabled.
@@ -379,7 +379,7 @@ following example for the protocol, the letter 'S' stands for
     S: ... ...
     S: flush-pkt
 
-    # Receive result from the hook.
+    # Receive results from the hook.
     # OK, run this command successfully.
     H: PKT-LINE(ok <ref>)
     # NO, I reject it.
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 13678ead045..8400d591da0 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -192,7 +192,7 @@ For example:
   [submodule "baz"]
     url = https://example.org/baz
 
-In the above config only the submodule 'bar' and 'baz' are active,
+In the above config only the submodules 'bar' and 'baz' are active,
 'bar' due to (1) and 'baz' due to (3). 'foo' is inactive because
 (1) takes precedence over (3)
 
diff --git a/Documentation/mergetools/vimdiff.txt b/Documentation/mergetools/vimdiff.txt
index c36c5479392..d1a4c468e63 100644
--- a/Documentation/mergetools/vimdiff.txt
+++ b/Documentation/mergetools/vimdiff.txt
@@ -162,7 +162,7 @@ information as the first tab, with a different layout.
 |       REMOTE        |                     |
 ---------------------------------------------
 ....
-Note how in the third tab definition we need to use parenthesis to make `,`
+Note how in the third tab definition we need to use parentheses to make `,`
 have precedence over `/`.
 --
 
diff --git a/Documentation/technical/api-index-skel.txt b/Documentation/technical/api-index-skel.txt
index eda8c195c19..7780a76b080 100644
--- a/Documentation/technical/api-index-skel.txt
+++ b/Documentation/technical/api-index-skel.txt
@@ -1,7 +1,7 @@
 Git API Documents
 =================
 
-Git has grown a set of internal API over time.  This collection
+Git has grown a set of internal APIs over time.  This collection
 documents them.
 
 ////////////////////////////////////////////////////////////////
diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
index 02ae508d227..59bea66c0fc 100644
--- a/Documentation/technical/racy-git.txt
+++ b/Documentation/technical/racy-git.txt
@@ -190,7 +190,7 @@ In a large project where raciness avoidance cost really matters,
 however, the initial computation of all object names in the
 index takes more than one second, and the index file is written
 out after all that happens.  Therefore the timestamp of the
-index file will be more than one seconds later than the
+index file will be more than one second later than the
 youngest file in the working tree.  This means that in these
 cases there actually will not be any racily clean entry in
 the resulting index.
diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 8ef664b0b95..045a76756fc 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -96,7 +96,7 @@ The value of this key is the name of the promisor remote.
 ==== `worktreeConfig`
 
 If set, by default "git config" reads from both "config" and
-"config.worktree" file from GIT_DIR in that order. In
+"config.worktree" files from GIT_DIR in that order. In
 multiple working directory mode, "config" file is shared while
 "config.worktree" is per-working directory (i.e., it's in
 GIT_COMMON_DIR/worktrees/<id>/config.worktree)
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index 3504afbf2e9..bf170122415 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -48,7 +48,7 @@ provide a refspec on the command line.  This file should have the
 following format:
 
 ------------
-	URL: one of the above URL format
+	URL: one of the above URL formats
 	Push: <refspec>
 	Pull: <refspec>
 
-- 
gitgitgadget

