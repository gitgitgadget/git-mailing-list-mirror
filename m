Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C2CC4332F
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 00:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiBMAkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:40:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiBMAkM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 19:40:12 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C960063
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so7404463wrg.11
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z9ZjyuUbCFmXJ+QFmd5JFTucKVhEzd4nfQj2WDALRHg=;
        b=YaeN440/APSz4qfXzw7T3L/qPO57Ff9Sy+y/HrUR4shtMibUf4LgktEvl48JLQlGkj
         mjTRfaV9dTWe8GuUS1zUgKK/JyEj+ZcBOxG+iUjFcxiRPoo4Rhkn0AMsAavUefIPFp54
         KsG1E60BlnW0QMZ179CW+UYf2GO58XBbIYbw4aaEReKbhzwxa+1Lg62b7pZ5lGEkW1aQ
         ikw+a7VhMSlyPri6n0+RwRVj1/MKAysU6hkvSlywrw9YpEqlCiqDSlng5h/heCdlw/Qi
         RXWE4jxfspJ/g7r+h5n+XncOPj5Ijh8ykUmFb06VbI2ErqlBxxF1Xyp9QfpvUOHhkNJg
         9bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z9ZjyuUbCFmXJ+QFmd5JFTucKVhEzd4nfQj2WDALRHg=;
        b=LKxjkYb0/UlP9dDFJOK0jS0t+49Kymfr17qLRQUac6KO+hGvYL4FbnGFCZvLEvA6ch
         waRXvIZlJuZUDDKJMX85a/wKGAkuFp9PeNiMpgVqPZJejTUa7tOVFljFlRCNkkRBWvE7
         T8vBxDK32N9ArgRy3MlGu1GX0BH7lhbofN8eKq/W4Lo+yIr/OXbM9ssEJ2TpJew6GiwK
         EEmZ8EcM9/oAea7M/g/LG2DxrhFyo96EHPgQUUzIHcSOuMWBoLdIvayDqEb8H5EIIqN5
         9Ra6GWEHIWYhamNvO0rdYUCC8st+ea0w2eGZbL/r7fvCKEL57P4cHSmQPX1HiOk7NXBz
         L+5A==
X-Gm-Message-State: AOAM530O6mLYLM42hir2TOjeKx0KzzBj7/pyhMXHmqtx+89VXrz5uIlu
        ZJjlK5xkksq9YEkBSCnZrNXhahn1UFs=
X-Google-Smtp-Source: ABdhPJzCrhN4mIB+uEE90KjEBBCo6/Tz6g0xBIG19x6z6IHIKPynn9PBC+JoLedvUiHMOt2fvQqNlg==
X-Received: by 2002:a5d:468a:: with SMTP id u10mr6270998wrq.273.1644712805271;
        Sat, 12 Feb 2022 16:40:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm7451415wmk.16.2022.02.12.16.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:40:04 -0800 (PST)
Message-Id: <e30119b96dfaf9fdb82039cab84f8b81caacc1de.1644712798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Feb 2022 00:39:57 +0000
Subject: [PATCH 7/7] sparse-checkout: make --cone the default and deprecate
 --no-cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Make --cone mode the default, and deprecate --no-cone mode.  While we
have no current plans to actually remove --no-cone mode, we think users
would be better off not using it.  Update the documentation accordingly,
including explaining why we think non-cone mode is problematic for
users.

While at it, since the new default just uses directories and removes the
need to understand patterns, we can mark multiple sections in the manual
as "INTERNALS" to reflect the fact that users do not need to wade
through those sections to understand how to use the command any more.
We can instead add a simple EXAMPLES section to the manual which
distills the necessary bits from the more complex INTERNALS sections.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 228 +++++++++++++++++++-------
 builtin/sparse-checkout.c             |   8 +-
 t/t1091-sparse-checkout-builtin.sh    |  15 +-
 t/t3602-rm-sparse-checkout.sh         |   6 +-
 t/t3705-add-sparse-checkout.sh        |   4 +-
 t/t6428-merge-conflicts-sparse.sh     |   4 +-
 t/t7002-mv-sparse-checkout.sh         |   2 +-
 t/t7012-skip-worktree-writing.sh      |   2 +-
 8 files changed, 190 insertions(+), 79 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 88e55f432f3..abe8c796313 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -42,11 +42,11 @@ COMMANDS
 
 'set'::
 	Enable the necessary sparse-checkout config settings
-	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
-	`index.sparse`) if they are not already set to the desired values,
-	and write a set of patterns to the sparse-checkout file from the
-	list of arguments following the 'set' subcommand. Update the
-	working directory to match the new patterns.
+	(`extensions.worktreeConfig`, `core.sparseCheckout`,
+	`core.sparseCheckoutCone`, and `index.sparse`) if they are not
+	already set to the desired values, populate the sparse-checkout
+	file from the list of arguments following the 'set' subcommand,
+	and update the working directory to match.
 +
 To ensure that adjusting the sparse-checkout settings within a worktree
 does not alter the sparse-checkout settings in other worktrees, the 'set'
@@ -60,22 +60,24 @@ When the `--stdin` option is provided, the directories or patterns are
 read from standard in as a newline-delimited list instead of from the
 arguments.
 +
-When `--cone` is passed or `core.sparseCheckoutCone` is enabled, the
-input list is considered a list of directories.  This allows for
-better performance with a limited set of patterns (see 'CONE PATTERN
-SET' below).  The input format matches the output of `git ls-tree
---name-only`.  This includes interpreting pathnames that begin with a
-double quote (") as C-style quoted strings.  Note that the set command
-will write patterns to the sparse-checkout file to include all files
-contained in those directories (recursively) as well as files that are
-siblings of ancestor directories. This may become the default in the
-future; --no-cone can be passed to request non-cone mode.
+By default, the input list is considered a list of directories, matching
+the output of `git ls-tree -d --name-only`.  This includes interpreting
+pathnames that begin with a double quote (") as C-style quoted strings.
+Note that all files under the specified directories (at any depth) will
+be included in the sparse checkout, as well as files that are siblings
+of either the given directory or any of its ancestors (see 'CONE PATTERN
+SET' below for more details).  In the past, this was not the default,
+and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
+to be enabled.
 +
-When `--no-cone` is passed or `core.sparseCheckoutCone` is not enabled,
-the input list is considered a list of patterns.  This mode is harder
-to use and less performant, and is thus not recommended.  See the
-"Sparse Checkout" section of linkgit:git-read-tree[1] and the "Pattern
-Set" sections below for more details.
+When `--no-cone` is passed, the input list is considered a list of
+patterns.  This mode is harder to use, and unless you can keep the
+number of patterns very small, its design also scales quite poorly.  It
+used to be the default mode, but we do not recommend using it.  It does
+not work with the `--sparse-index` option, and will likely be
+incompatible with other new features as they are added.  See the
+"Non-cone Problems" section below and the "Sparse Checkout" section of
+linkgit:git-read-tree[1] for more details.
 +
 Use the `--[no-]sparse-index` option to use a sparse index (the
 default is to not use it).  A sparse index reduces the size of the
@@ -137,8 +139,44 @@ paths to pass to a subsequent 'set' or 'add' command.  However,
 the disable command, so the easy restore of calling a plain `init`
 decreased in utility.
 
-SPARSE CHECKOUT
----------------
+EXAMPLES
+--------
+`git sparse-checkout set MY/DIR1 SUB/DIR2`::
+
+	Change to a sparse-checkout with all files (at any depth) under
+	MY/DIR1/ and SUB/DIR2/ present in the working copy (plus all
+	files immediately under MY/ and SUB/ and the toplevel
+	directory).  If already in a sparse checkout, change which files
+	are present in the working copy to this new selection.  Note
+	that this command will also delete all ignored files in any
+	directory that no longer has either tracked or
+	non-ignored-untracked files present.
+
+`git sparse-checkout disable`::
+
+	Repopulate the working directory with all files, disabling sparse
+	checkouts.
+
+`git sparse-checkout add SOME/DIR/ECTORY`::
+
+	Add all files under SOME/DIR/ECTORY/ (at any depth) to the
+	sparse checkout, as well as all files immediately under
+	SOME/DIR/ and immediately under SOME/.  Must already be in a
+	sparse checkout before using this command.
+
+`git sparse-checkout reapply`::
+
+	It is possible for commands to update the working tree in a way
+	that does not respect the selected sparsity directories, either
+	because of special cases (such as hitting conflicts when
+	merging/rebasing), or because some commands didn't fully support
+	sparse checkouts (e.g. the old `recursive` merge backend had
+	only limited support).  This command reapplies the existing
+	sparse directory specifications to make the working directory
+	match.
+
+INTERNALS -- SPARSE CHECKOUT
+----------------------------
 
 "Sparse checkout" allows populating the working directory sparsely.  It
 uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell Git
@@ -155,22 +193,93 @@ directory, it updates the skip-worktree bits in the index based
 on this file. The files matching the patterns in the file will
 appear in the working directory, and the rest will not.
 
-To enable the sparse-checkout feature, run `git sparse-checkout set` to
-set the patterns you want to use.
-
-To repopulate the working directory with all files, use the
-`git sparse-checkout disable` command.
-
-
-FULL PATTERN SET
-----------------
-
-By default, the sparse-checkout file uses the same syntax as `.gitignore`
-files.
-
-While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
-files are included, you can also specify what files are _not_ included,
-using negative patterns. For example, to remove the file `unwanted`:
+INTERNALS -- NON-CONE PROBLEMS
+------------------------------
+
+The `$GIT_DIR/info/sparse-checkout` file populated by the `set` and
+`add` subcommands is defined to be a bunch of patterns (one per line)
+using the same syntax as `.gitignore` files.  In cone mode, these
+patterns are restricted to matching directories (and users only ever
+need supply or see directory names), while in non-cone mode any
+gitignore-style pattern is permitted.  Using the full gitignore-style
+patterns in non-cone mode has a number of shortcomings:
+
+  * Fundamentally, it makes various worktree-updating processes (pull,
+    merge, rebase, switch, reset, checkout, etc.) require O(N*M) pattern
+    matches, where N is the number of patterns and M is the number of
+    paths in the index.  This scales poorly.
+
+  * Avoiding the scaling issue means selecting paths via leading
+    directory name or glob.  Passing globs on the command line is
+    error-prone as users may forget to quote the glob, causing the
+    shell to expand it into all matching files and pass them all
+    individually along to sparse-checkout set/add.  This both
+    exacerbates the scaling problem, and hardcodes the list of
+    selected files to those which were present at the time the initial
+    set/add subcommand was run (and thus ignoring other files matching
+    the same glob which come into the working tree after switching
+    branches or pulling down updates).
+
+  * It uses "ignore"/"exclude" syntax for selecting what to "include",
+    which periodically causes confusion.
+
+  * It introduces inconsistencies in the Git command line, since other
+    commands use pathspecs, but sparse-checkout (in non-cone mode) uses
+    gitignore patterns.
+
+  * It has edge cases where the "right" behavior is unclear.  Two examples:
+
+    First, two users are in a subdirectory, and the first runs
+       git sparse-checkout set '/toplevel-dir/*.c'
+    while the second runs
+       git sparse-checkout set relative-dir
+    Should those arguments be transliterated into
+       current/subdirectory/toplevel-dir/*.c
+    and
+       current/subdirectory/relative-dir
+    before inserting into the sparse-checkout file?  The user who typed
+    the first command is probably aware that arguments to set/add are
+    supposed to be patterns in non-cone mode, and probably would not be
+    happy with such a transliteration.  However, many gitignore-style
+    patterns are just paths, which might be what the user who typed the
+    second command was thinking, and they'd be upset if their argument
+    wasn't transliterated.
+
+    Second, what should bash-completion complete on for set/add commands
+    for non-cone users?  If it suggests paths, is it exacerbating the
+    problem above?  Also, if it suggests paths, what if the user has a
+    file or directory that begins with either a '!' or '#' or has a '*',
+    '\', '?', '[', or ']' in its name?  And if it suggests paths, will
+    it complete "/pro" to "/proc" (in the root filesytem) rather than to
+    "/progress.txt" in the current directory?  (Note that users are
+    likely to want to start paths with a leading '/' in non-cone mode,
+    for the same reason that .gitignore files often have one.)
+    Completing on files or directories might give nasty surprises in
+    all these cases.
+
+  * The excessive flexibility made other extensions essentially
+    impractical.  `--sparse-index` may not have been feasible in
+    non-cone mode, but even if it was, it would have been far more work
+    to implement and may have been too slow in practice.  Some ideas for
+    adding coupling between partial clones and sparse-checkouts are only
+    practical with a more restricted set of paths.
+
+For all these reasons, non-cone mode is deprecated.  Please switch to
+using cone mode.
+
+INTERNALS -- FULL PATTERN SET
+-----------------------------
+
+As noted above, the sparse-checkout file uses the same syntax as
+`.gitignore` files; see linkgit:gitignore[5] for details.  Here, though,
+the patterns are being used to select which files to include rather than
+which files to exclude.
+
+To complicate things a bit further, while
+`$GIT_DIR/info/sparse-checkout` is usually used to specify what files
+are included, you can also specify what files are _not_ included, using
+negative patterns. For example, to select everything, and then to remove
+the file `unwanted`:
 
 ----------------
 /*
@@ -178,14 +287,14 @@ using negative patterns. For example, to remove the file `unwanted`:
 ----------------
 
 
-CONE PATTERN SET
-----------------
+INTERNALS -- CONE PATTERN SET
+-----------------------------
 
-The full pattern set allows for arbitrary pattern matches and complicated
-inclusion/exclusion rules. These can result in O(N*M) pattern matches when
-updating the index, where N is the number of patterns and M is the number
-of paths in the index. To combat this performance issue, a more restricted
-pattern set is allowed when `core.sparseCheckoutCone` is enabled.
+The full pattern set allows for arbitrary pattern matches and
+complicated inclusion/exclusion rules. As noted above, this can result
+in O(N*M) pattern matches when updating the index, where N is the number
+of patterns and M is the number of paths in the index. To combat this
+performance issue, a more restricted pattern set is used by default.
 
 The accepted patterns in the cone pattern set are:
 
@@ -197,9 +306,9 @@ In addition to the above two patterns, we also expect that all files in the
 root directory are included. If a recursive pattern is added, then all
 leading directories are added as parent patterns.
 
-By default, when running `git sparse-checkout init`, the root directory is
-added as a parent pattern. At this point, the sparse-checkout file contains
-the following patterns:
+By default, when running `git sparse-checkout set` with no directories
+specified, the root directory is added as a parent pattern. At this
+point, the sparse-checkout file contains the following patterns:
 
 ----------------
 /*
@@ -208,11 +317,11 @@ the following patterns:
 
 This says "include everything in root, but nothing two levels below root."
 
-When in cone mode, the `git sparse-checkout set` subcommand takes a list of
-directories instead of a list of sparse-checkout patterns. In this mode,
-the command `git sparse-checkout set A/B/C` sets the directory `A/B/C` as
-a recursive pattern, the directories `A` and `A/B` are added as parent
-patterns. The resulting sparse-checkout file is now
+When in cone mode, the `git sparse-checkout set` subcommand takes a list
+of directories. In this mode, the command `git sparse-checkout set
+A/B/C` sets the directory `A/B/C` as a recursive pattern, the
+directories `A` and `A/B` are added as parent patterns. The resulting
+sparse-checkout file is now
 
 ----------------
 /*
@@ -227,10 +336,11 @@ patterns. The resulting sparse-checkout file is now
 Here, order matters, so the negative patterns are overridden by the positive
 patterns that appear lower in the file.
 
-If `core.sparseCheckoutCone=true`, then Git will parse the sparse-checkout file
-expecting patterns of these types. Git will warn if the patterns do not match.
-If the patterns do match the expected format, then Git will use faster hash-
-based algorithms to compute inclusion in the sparse-checkout.
+If `core.sparseCheckoutCone=true` (set by default or with an explicit
+`--cone`), then Git will parse the sparse-checkout file expecting
+patterns of these types. Git will warn if the patterns do not match.  If
+the patterns do match the expected format, then Git will use faster
+hash- based algorithms to compute inclusion in the sparse-checkout.
 
 In the cone mode case, the `git sparse-checkout list` subcommand will list the
 directories that define the recursive patterns. For the example sparse-checkout
@@ -257,8 +367,8 @@ use `git add` and `git commit` to store them, then remove any remaining files
 manually to ensure Git can behave optimally.
 
 
-SUBMODULES
-----------
+INTERNALS -- SUBMODULES
+-----------------------
 
 If your repository contains one or more submodules, then submodules
 are populated based on interactions with the `git submodule` command.
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 6e0af166f80..aa2c66f15e3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -395,13 +395,13 @@ static int update_modes(int *cone_mode, int *sparse_index)
 
 	/* Set cone/non-cone mode appropriately */
 	core_apply_sparse_checkout = 1;
-	if (*cone_mode == 1) {
+	if (*cone_mode == 1 || *cone_mode == -1) {
 		mode = MODE_CONE_PATTERNS;
-		core_sparse_checkout_cone = 1;
+		if (record_mode)
+			core_sparse_checkout_cone = 1;
 	} else {
 		mode = MODE_ALL_PATTERNS;
-		if (record_mode)
-			core_sparse_checkout_cone = 0;
+		core_sparse_checkout_cone = 0;
 	}
 	if (record_mode && set_config(mode))
 		return 1;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 343ce16a534..5e1a6d91411 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -72,7 +72,7 @@ test_expect_success 'git sparse-checkout list (populated)' '
 '
 
 test_expect_success 'git sparse-checkout init' '
-	git -C repo sparse-checkout init &&
+	git -C repo sparse-checkout init --no-cone &&
 	cat >expect <<-\EOF &&
 	/*
 	!/*/
@@ -111,6 +111,7 @@ test_expect_success 'init with existing sparse-checkout' '
 
 test_expect_success 'clone --sparse' '
 	git clone --sparse "file://$(pwd)/repo" clone &&
+	git -C clone sparse-checkout reapply --no-cone &&
 	git -C clone sparse-checkout list >actual &&
 	cat >expect <<-\EOF &&
 	/*
@@ -124,7 +125,7 @@ test_expect_success 'switching to cone mode with non-cone mode patterns' '
 	git init bad-patterns &&
 	(
 		cd bad-patterns &&
-		git sparse-checkout init &&
+		git sparse-checkout init --no-cone &&
 		git sparse-checkout add dir &&
 		git config --worktree core.sparseCheckoutCone true &&
 		test_must_fail git sparse-checkout add dir 2>err &&
@@ -402,7 +403,7 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
 		git sparse-checkout set nothing 2>err &&
 		test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&
 		test_i18ngrep ! ".git/index.lock" err &&
-		git sparse-checkout set file
+		git sparse-checkout set --no-cone file
 	)
 '
 
@@ -424,7 +425,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	git clone repo dirty &&
 	echo dirty >dirty/folder1/a &&
 
-	git -C dirty sparse-checkout init 2>err &&
+	git -C dirty sparse-checkout init --no-cone 2>err &&
 	test_i18ngrep "warning.*The following paths are not up to date" err &&
 
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
@@ -435,7 +436,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with dirty status'
 	test_must_be_empty err &&
 
 	git -C dirty reset --hard &&
-	git -C dirty sparse-checkout init &&
+	git -C dirty sparse-checkout init --no-cone &&
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* &&
 	test_path_is_missing dirty/folder1/a &&
 	git -C dirty sparse-checkout disable &&
@@ -451,7 +452,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	EOF
 	git -C unmerged update-index --index-info <input &&
 
-	git -C unmerged sparse-checkout init 2>err &&
+	git -C unmerged sparse-checkout init --no-cone 2>err &&
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 
 	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
@@ -462,7 +463,7 @@ test_expect_success 'sparse-checkout (init|set|disable) warns with unmerged stat
 	test_i18ngrep "warning.*The following paths are unmerged" err &&
 
 	git -C unmerged reset --hard &&
-	git -C unmerged sparse-checkout init &&
+	git -C unmerged sparse-checkout init --no-cone &&
 	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* &&
 	git -C unmerged sparse-checkout disable
 '
diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
index 034ec010910..08580fd3dcc 100755
--- a/t/t3602-rm-sparse-checkout.sh
+++ b/t/t3602-rm-sparse-checkout.sh
@@ -30,7 +30,7 @@ test_expect_success 'setup' "
 for opt in "" -f --dry-run
 do
 	test_expect_success "rm${opt:+ $opt} does not remove sparse entries" '
-		git sparse-checkout set a &&
+		git sparse-checkout set --no-cone a &&
 		test_must_fail git rm $opt b 2>stderr &&
 		test_cmp b_error_and_hint stderr &&
 		git ls-files --error-unmatch b
@@ -118,7 +118,7 @@ test_expect_success 'can remove files from non-sparse dir' '
 	test_commit w/f &&
 	test_commit x/y/f &&
 
-	git sparse-checkout set w !/x y/ &&
+	git sparse-checkout set --no-cone w !/x y/ &&
 	git rm w/f.t x/y/f.t 2>stderr &&
 	test_must_be_empty stderr
 '
@@ -128,7 +128,7 @@ test_expect_success 'refuse to remove non-skip-worktree file from sparse dir' '
 	git sparse-checkout disable &&
 	mkdir -p x/y/z &&
 	test_commit x/y/z/f &&
-	git sparse-checkout set !/x y/ !x/y/z &&
+	git sparse-checkout set --no-cone !/x y/ !x/y/z &&
 
 	git update-index --no-skip-worktree x/y/z/f.t &&
 	test_must_fail git rm x/y/z/f.t 2>stderr &&
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 95609046c61..2bade9e804f 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -166,7 +166,7 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
 test_expect_success 'git add fails outside of sparse-checkout definition' '
 	test_when_finished git sparse-checkout disable &&
 	test_commit a &&
-	git sparse-checkout init &&
+	git sparse-checkout init --no-cone &&
 	git sparse-checkout set a &&
 	echo >>sparse_entry &&
 
@@ -208,7 +208,7 @@ test_expect_success 'add obeys advice.updateSparsePath' '
 '
 
 test_expect_success 'add allows sparse entries with --sparse' '
-	git sparse-checkout set a &&
+	git sparse-checkout set --no-cone a &&
 	echo modified >sparse_entry &&
 	test_must_fail git add sparse_entry &&
 	test_sparse_entry_unchanged &&
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 142c9aaabc5..064be1b629e 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -87,7 +87,7 @@ test_expect_success 'conflicting entries written to worktree even if sparse' '
 		test_path_is_file numerals &&
 
 		git sparse-checkout init &&
-		git sparse-checkout set README &&
+		git sparse-checkout set --no-cone README &&
 
 		test_path_is_file README &&
 		test_path_is_missing numerals &&
@@ -123,7 +123,7 @@ test_expect_success 'present-despite-SKIP_WORKTREE handled reasonably' '
 		test_path_is_file numerals &&
 
 		git sparse-checkout init &&
-		git sparse-checkout set README &&
+		git sparse-checkout set --no-cone README &&
 
 		test_path_is_file README &&
 		test_path_is_missing numerals &&
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 1d3d2aca21c..f0f7cbfcdb7 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup' "
 test_expect_success 'mv refuses to move sparse-to-sparse' '
 	test_when_finished rm -f e &&
 	git reset --hard &&
-	git sparse-checkout set a &&
+	git sparse-checkout set --no-cone a &&
 	touch b &&
 	test_must_fail git mv b e 2>stderr &&
 	cat sparse_error_header >expect &&
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index cb9f1a6981e..cd5c20fe51b 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -151,7 +151,7 @@ test_expect_success 'stash restore in sparse checkout' '
 
 		git stash push &&
 
-		git sparse-checkout set subdir &&
+		git sparse-checkout set --no-cone subdir &&
 
 		# Ensure after sparse-checkout we only have expected files
 		cat >expect <<-EOF &&
-- 
gitgitgadget
