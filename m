Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3B0C1F453
	for <e@80x24.org>; Wed,  1 May 2019 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfEAKOX (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 06:14:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34777 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEAKOW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 06:14:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id b67so4159554wmg.1
        for <git@vger.kernel.org>; Wed, 01 May 2019 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=37e0UXUB2UavzG/bCx92FDgrkKx20QN9wj6QccArmYI=;
        b=BA/q044USwLKEzjkIX/Qj1wRBwGi4wOjsd1wQDapiFwngDf6gtWLRxsEue7t5of7Xb
         e8/AYo/D8/fca013yEKhwvdCflg5DK+kQwGOMm7bSw5xYVTTeAU1zBrcxoWgM6qHG4vt
         TVW1NUNJaT2b1nT7HRGVtnfqZI3OdkScjuhN5aO5/cZqaKL7VfrWFb0NN0m9UnOsDP9L
         LLd0IBrwrX3EPO4BX3nYSVj949v94wZcrMKlGMkWj34lqmlEMBS7xhP2yRxxGkRbtg+o
         D0CBEAe1WQERZ5/Qzwqnjg+eHrK/Nsj8V92V0JIOP/5aFw3jNmAYr3nMw5v/hhjJeQWQ
         MpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=37e0UXUB2UavzG/bCx92FDgrkKx20QN9wj6QccArmYI=;
        b=qqujnAn4DCIyzpXH4xy7B45PQM6NBK7rDHfmLks1wt38N0+3OGFympoOWH+tUUuuQO
         rzMmweWAA7UflvF1oYgBC9Ljg4XF0g8z+7PLXjkXxl0GP+hALNPvYHnBXNADXlMS32JA
         Fe9wVK5SNuSHW2mDVKrtkyrF2VUIAnbxcrCg2cjPD5bEPVw0bAoayVEDHfS1QG6ALA4M
         /004ovxKCcvp0+pQQX4vClnpgnSmn3JERY1xCvoyJICOZU7mUqpp2Snjfu900524/Vg3
         FdoBnm4qTDdw7AwI7FlfKauLG+v06R8l+V6UzeY/wHfXE5uOdGcz5dUIW7+4QYYW4yod
         7/Mg==
X-Gm-Message-State: APjAAAWPyhiIWEwmx7ak3emA4UWVoumqhnvZ8ZX0edOYoZX0SxTrA0YH
        fOUNKDEbE2x6tyyMifODwCiu16a1
X-Google-Smtp-Source: APXvYqzke1segs8M7USAKVmqRRmO8WQ0L2bh9TIIVhHSOK4WGgAuOpyn/9lJg+Qn+jFSdOiB1x3BUQ==
X-Received: by 2002:a1c:5588:: with SMTP id j130mr6540911wmb.72.1556705659464;
        Wed, 01 May 2019 03:14:19 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id d16sm38114498wra.54.2019.05.01.03.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 03:14:19 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/2] read-tree: add --exclude-standard
Date:   Wed,  1 May 2019 11:14:03 +0100
Message-Id: <20190501101403.20294-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501101403.20294-1-phillip.wood123@gmail.com>
References: <20190501101403.20294-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Currently there is no way to get read-tree to respect
.git/info/exclude or core.excludesFile so scripts using `read-tree -u`
have subtly different behavior to porcelain commands like checkout
even when they use --exclude-per-directory. This new option is copied
from ls-tree's --exclude-standard option to setup the standard
excludes. The new option is also used to fix a known submodule test
failure.

Note that KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED is still
used by t7112-reset-submodule.sh as it is not removed (apparently
reset does not call setup_standard_excludes()).

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-read-tree.txt |  9 +++++-
 builtin/read-tree.c             | 55 ++++++++++++++++++++++++++++++---
 t/t1005-read-tree-reset.sh      | 36 ++++++++++++++++++---
 t/t1013-read-tree-submodule.sh  |  3 +-
 4 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 67864c6bbc..a2b8b73a99 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -107,7 +107,14 @@ OPTIONS
 	running `make clean` to remove the generated file.  This
 	option tells the command to read per-directory exclude
 	file (usually '.gitignore') and allows such an untracked
-	but explicitly ignored file to be overwritten.
+	but explicitly ignored file to be overwritten. Incompatible
+	with `--exclude-standard`.
+
+--exclude-standard::
+	When updating the worktree use the standard Git exclusions:
+	.git/info/exclude, .gitignore in each directory, and the user's global
+	exclusion file when deciding if it is safe to overwrite a file.
+	Incompatible with `--exclude-per-directory`.
 
 --index-output=<file>::
 	Instead of writing the results out to `$GIT_INDEX_FILE`,
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 23735adde9..5df493c4a7 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -50,6 +50,40 @@ static int index_output_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+enum exclude_type {
+	EXCLUDE_NONE,
+	EXCLUDE_PER_DIRECTORY,
+	EXCLUDE_STANDARD
+} exclude_opt = EXCLUDE_NONE;
+
+static int exclude_error(enum exclude_type exclude)
+{
+	if (exclude == exclude_opt)
+		return error("more than one --exclude-per-directory given");
+	else
+		return error("cannot combine --exclude-per-directory and "
+			     "--exclude-standard");
+}
+
+static int option_parse_exclude_standard(const struct option *opt,
+					 const char *arg, int unset)
+{
+	struct unpack_trees_options *opts;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	if (exclude_opt == EXCLUDE_PER_DIRECTORY)
+		return exclude_error(EXCLUDE_STANDARD);
+
+	opts = (struct unpack_trees_options *)opt->value;
+	opts->dir = xcalloc(1, sizeof(*opts->dir));
+	setup_standard_excludes(opts->dir);
+	exclude_opt = EXCLUDE_STANDARD;
+
+	return 0;
+}
+
 static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 				    int unset)
 {
@@ -61,12 +95,13 @@ static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 	opts = (struct unpack_trees_options *)opt->value;
 
 	if (opts->dir)
-		die("more than one --exclude-per-directory given.");
+		return exclude_error(EXCLUDE_PER_DIRECTORY);
 
 	dir = xcalloc(1, sizeof(*opts->dir));
 	dir->flags |= DIR_SHOW_IGNORED;
 	dir->exclude_per_dir = arg;
 	opts->dir = dir;
+	exclude_opt = EXCLUDE_PER_DIRECTORY;
 	/* We do not need to nor want to do read-directory
 	 * here; we are merely interested in reusing the
 	 * per directory ignore stack mechanism.
@@ -147,6 +182,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		  N_("gitignore"),
 		  N_("allow explicitly ignored files to be overwritten"),
 		  PARSE_OPT_NONEG, exclude_per_directory_cb },
+		{ OPTION_CALLBACK, 0, "exclude-standard", &opts, NULL,
+			N_("add the standard git exclusions"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			option_parse_exclude_standard },
 		OPT_BOOL('i', NULL, &opts.index_only,
 			 N_("don't check the working tree after merging")),
 		OPT__DRY_RUN(&opts.dry_run, N_("don't update the index or the work tree")),
@@ -219,10 +258,16 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
 	}
 	if ((opts.dir && !opts.update))
-		die("--exclude-per-directory is meaningless unless -u");
-	if (opts.dir && opts.reset == UNPACK_RESET_OVERWRITE_UNTRACKED)
-		warning("--exclude-per-directory without --preserve-untracked "
-			"has no effect");
+		die("%s requires -u", exclude_opt == EXCLUDE_STANDARD ?
+			"--exclude-standard" :" --exclude-per-directory");
+	if (opts.dir && opts.reset == UNPACK_RESET_OVERWRITE_UNTRACKED) {
+		if (exclude_opt == EXCLUDE_STANDARD)
+			die("--reset with --exclude-standard requires "
+			    "--protect-untracked");
+		else
+			warning("--exclude-per-directory without "
+				"--preserve-untracked has no effect");
+	}
 	if (opts.merge && !opts.index_only)
 		setup_work_tree();
 
diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 6c9dd6805b..2e2a6a0c69 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -30,6 +30,20 @@ test_expect_success '--protect-untracked option sanity checks' '
 	read_tree_u_must_fail -m -u --no-protect-untracked
 '
 
+test_expect_success 'exclude option sanity checks' '
+	read_tree_u_must_fail --reset -u --exclude-standard HEAD &&
+	read_tree_u_must_fail --reset --protect-untracked --exclude-standard &&
+	read_tree_u_must_fail --reset -u --protect-untracked \
+			      --exclude-standard \
+			      --exclude-per-directory=.gitignore HEAD &&
+	read_tree_u_must_fail --reset -u --protect-untracked \
+			      --exclude-per-directory=gitignore \
+			      --exclude-per-directory=.gitignore HEAD &&
+	read_tree_u_must_fail --reset --exclude-per-directory=.gitignore HEAD &&
+	read_tree_u_must_succeed --reset -u --exclude-per-directory=.gitignore \
+				 HEAD
+'
+
 test_expect_success 'reset should reset worktree' '
 	echo changed >df &&
 	read_tree_u_must_succeed -u --reset HEAD^ &&
@@ -53,12 +67,24 @@ test_expect_success 'reset --protect-untracked protects untracked directory' '
 	test_cmp expected-err actual-err
 '
 
-test_expect_success 'reset --protect-untracked resets' '
-	rm -rf new &&
+test_expect_success 'reset --protect-untracked --exclude-standard overwrites ignored path' '
+	test_when_finished "rm .git/info/exclude" &&
+	echo missing >.git/info/exclude &&
+	read_tree_u_must_fail -u --reset --protect-untracked \
+			      --exclude-standard HEAD &&
+	echo new >.git/info/exclude &&
 	echo changed >df/file &&
-	read_tree_u_must_succeed -u --reset --protect-untracked HEAD &&
-	git ls-files >actual-two &&
-	test_cmp expect-two actual-two
+	read_tree_u_must_succeed -u --reset --protect-untracked \
+				 --exclude-standard HEAD &&
+	git ls-files >actual &&
+	test_cmp expect-two actual
+'
+
+test_expect_success 'reset --protect-untracked resets' '
+	echo changed >df &&
+	read_tree_u_must_succeed -u --reset --protect-untracked HEAD^ &&
+	git ls-files >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'reset should remove remnants from a failed merge' '
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index 91a6fafcb4..728280d40d 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -6,9 +6,8 @@ test_description='read-tree can handle submodules'
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
-KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
-test_submodule_switch_recursing_with_args "read-tree -u -m"
+test_submodule_switch_recursing_with_args "read-tree -u -m --exclude-standard"
 
 test_submodule_forced_switch_recursing_with_args "read-tree -u --reset"
 
-- 
2.21.0

