Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5624211B3
	for <e@80x24.org>; Sun,  9 Dec 2018 20:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbeLIUFI (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 15:05:08 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44984 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeLIUFI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 15:05:08 -0500
Received: by mail-wr1-f51.google.com with SMTP id z5so8412064wrt.11
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 12:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GtPGQIh0OUkZCwDoPnRmfu8zS4UwjMxygBHJe/8XWCA=;
        b=bNUi52dzmsuK7O0NS+Tz7TfhR5cxKYve0nOSIcB4EYCyq1EXYwc1n3HuSjGx2j97/s
         PkrJQ7QqYx7wDjYju450ksHLFwyEZ1t6du3jG7FjraZzwjIk/RB0x4Po6klDO4FLnniW
         aCHWwWGIjO8Wej42ZNc7fp2cqaueSAbRequw/+ITyq6EWBExSkSDuZcSjZyXrGYTH0g9
         wXDg9Ni1hLEZpDi0QXKxbw1trGciN1A41rutWkyMhcKp0oyuCBrAHFa0+b0FaP3BGbGG
         a0qnpiF0iXR5Kw6X4qSrZBLOhnwrAKvQFZlkmfHvv+RjjQfmMvcqEP5iVElTzgWJ3wOM
         9hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtPGQIh0OUkZCwDoPnRmfu8zS4UwjMxygBHJe/8XWCA=;
        b=uWVpbM3xzMAV+ddpyccPrVbQKvH2xAYASqXsrGCtuPqTSXWuM+v5X8HFq65xSmV7w7
         dBKzh1LQgbw1ogdYyt4IKKR1DkY5r3pB7D9S9QeSnAh5dweK0g6Dk31RDVXHqH+o1DON
         JznfSPyX/OFzB4UkBGgTZxcvQZTJATQGOmNh2jwgtFkMKTA09fT9Wq/IL5GY93pC9p7W
         DswCV8MkVfCYVAVxSg6qeIAHtgH1JYI0bbPUbSnZUvkIukKxiyGhO2LfPH6Txnx/CD4T
         2vbGV/m01aI17sGP5cIyJnCSL1TsxLMuoWcJHGzhRt45nlmVLqlw0rdxDm9YbE9R2VEj
         AZZg==
X-Gm-Message-State: AA+aEWZkqkP+dMGJBAq8oKIyamAybKjiLSxMvOevmT8hIxWYchxTkpdE
        SkOJhiV2EsGk4PFVwsK/N91+YGMF
X-Google-Smtp-Source: AFSGD/Wi5+lwDyoT+v1R8dM29x5rpy+7ncq6QVWW8AUOjjUcgFD8fsGC7QOqE7oHO8PVcitAUv+l3A==
X-Received: by 2002:adf:c505:: with SMTP id q5mr7575352wrf.84.1544385905976;
        Sun, 09 Dec 2018 12:05:05 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id k19sm19271304wre.5.2018.12.09.12.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 12:05:05 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 6/8] checkout: add --cached option
Date:   Sun,  9 Dec 2018 20:04:47 +0000
Message-Id: <20181209200449.16342-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181209200449.16342-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new --cached option to git checkout, which works only on the
index, but not the working tree, similar to what 'git reset <tree-ish>
-- <pathspec>... does.  Indeed the tests are adapted from the 'git
reset' tests.

In the longer term the idea is to potentially deprecate 'git reset
<tree-ish> -- <pathspec>...', so the 'git reset' command becomes only
about re-pointing the HEAD, and not also about copying entries from
<tree-ish> to the index.

Note that 'git checkout' by default works in overlay mode, meaning
files that match the pathspec that don't exist in <tree-ish>, but
exist in the index would not be removed.  'git checkout --no-overlay
--cached' can be used to get the same behaviour as 'git reset
<tree-ish> -- <pathspec>'.

One thing this patch doesn't currently deal with is conflicts.
Currently 'git checkout --{ours,theirs} -- <file-with-conflicts>'
doesn't do anything with the index, so the --cached option just
mirrors that behaviour.  But given it doesn't even deal with
conflicts, the '--cached' option doesn't make much sense when no
<tree-ish> is given.  As it operates only on the index, it's always a
no-op if no tree-ish is given.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

Maybe we can just disallow --cached without <tree-ish> given for now,
and possibly later allow it with some different behaviour for
conflicts, not sure what the best way forward here is.  We can also
just make it update the index as appropriate, and have it behave
different than 'git checkout' curerntly does when handling conflicts?

 builtin/checkout.c         |  26 ++++++++--
 t/t2016-checkout-patch.sh  |   8 +++
 t/t2026-checkout-cached.sh | 103 +++++++++++++++++++++++++++++++++++++
 t/t9902-completion.sh      |   1 +
 4 files changed, 135 insertions(+), 3 deletions(-)
 create mode 100755 t/t2026-checkout-cached.sh

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0aef35bbc4..6ba85e9de5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -45,6 +45,7 @@ struct checkout_opts {
 	int ignore_other_worktrees;
 	int show_progress;
 	int overlay_mode;
+	int cached;
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -288,6 +289,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
+	if (opts->patch_mode && opts->cached)
+		return run_add_interactive(revision, "--patch=reset",
+					   &opts->pathspec);
+
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=checkout",
 					   &opts->pathspec);
@@ -319,7 +324,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 				 * the current index, which means that it should 
 				 * be removed.
 				 */
-				ce->ce_flags |= CE_MATCHED | CE_REMOVE | CE_WT_REMOVE;
+				ce->ce_flags |= CE_MATCHED | CE_REMOVE;
+				if (!opts->cached)
+					ce->ce_flags |= CE_WT_REMOVE;
 				continue;
 			} else {
 				/*
@@ -392,6 +399,9 @@ static int checkout_paths(const struct checkout_opts *opts,
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
+			if (opts->cached) {
+				continue;
+			}
 			if (!ce_stage(ce)) {
 				errs |= checkout_entry(ce, &state, NULL);
 				continue;
@@ -571,6 +581,11 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	 * not tested here
 	 */
 
+	/*
+	 * opts->cached cannot be used with switching branches so is
+	 * not tested here
+	 */
+
 	/*
 	 * If we aren't creating a new branch any changes or updates will
 	 * happen in the existing branch.  Since that could only be updating
@@ -1207,9 +1222,13 @@ static int checkout_branch(struct checkout_opts *opts,
 		die(_("'%s' cannot be used with switching branches"),
 		    "--patch");
 
-	if (!opts->overlay_mode)
+	if (opts->overlay_mode != -1)
+		die(_("'%s' cannot be used with switching branches"),
+		    "--overlay/--no-overlay");
+
+	if (opts->cached)
 		die(_("'%s' cannot be used with switching branches"),
-		    "--no-overlay");
+		    "--cached");
 
 	if (opts->writeout_stage)
 		die(_("'%s' cannot be used with switching branches"),
@@ -1300,6 +1319,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
+		OPT_BOOL(0, "cached", &opts.cached, N_("work on the index only")),
 		OPT_END(),
 	};
 
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 47aeb0b167..e8774046e0 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -108,6 +108,14 @@ test_expect_success PERL 'path limiting works: foo inside dir' '
 	verify_state dir/foo head head
 '
 
+test_expect_success PERL 'git checkout --cached -p' '
+	set_and_save_state dir/foo work work &&
+	test_write_lines n y | git checkout --cached -p >output &&
+	verify_state dir/foo work head &&
+	verify_saved_state bar &&
+	test_i18ngrep "Unstage" output
+'
+
 test_expect_success PERL 'none of this moved HEAD' '
 	verify_saved_head
 '
diff --git a/t/t2026-checkout-cached.sh b/t/t2026-checkout-cached.sh
new file mode 100755
index 0000000000..1b66192727
--- /dev/null
+++ b/t/t2026-checkout-cached.sh
@@ -0,0 +1,103 @@
+#!/bin/sh
+
+test_description='checkout --cached <pathspec>'
+
+. ./test-lib.sh
+
+test_expect_success 'checkout --cached <pathspec>' '
+	echo 1 >file1 &&
+	echo 2 >file2 &&
+	git add file1 file2 &&
+	test_tick &&
+	git commit -m files &&
+	git rm file2 &&
+	echo 3 >file3 &&
+	echo 4 >file1 &&
+	git add file1 file3 &&
+	git checkout --cached HEAD -- file1 file2 &&
+	test_must_fail git diff --quiet &&
+
+	cat >expect <<-\EOF &&
+	diff --git a/file1 b/file1
+	index d00491f..b8626c4 100644
+	--- a/file1
+	+++ b/file1
+	@@ -1 +1 @@
+	-1
+	+4
+	diff --git a/file2 b/file2
+	deleted file mode 100644
+	index 0cfbf08..0000000
+	--- a/file2
+	+++ /dev/null
+	@@ -1 +0,0 @@
+	-2
+	EOF
+	git diff >actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-\EOF &&
+	diff --git a/file3 b/file3
+	new file mode 100644
+	index 0000000..00750ed
+	--- /dev/null
+	+++ b/file3
+	@@ -0,0 +1 @@
+	+3
+	EOF
+	git diff --cached >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'checking out an unmodified path is a no-op' '
+	git reset --hard &&
+	git checkout --cached HEAD -- file1 &&
+	git diff-files --exit-code &&
+	git diff-index --cached --exit-code HEAD
+'
+
+test_expect_success 'checking out specific path that is unmerged' '
+	test_commit file3 file3 &&
+	git rm --cached file2 &&
+	echo 1234 >file2 &&
+	F1=$(git rev-parse HEAD:file1) &&
+	F2=$(git rev-parse HEAD:file2) &&
+	F3=$(git rev-parse HEAD:file3) &&
+	{
+		echo "100644 $F1 1	file2" &&
+		echo "100644 $F2 2	file2" &&
+		echo "100644 $F3 3	file2"
+	} | git update-index --index-info &&
+	git ls-files -u &&
+	git checkout --cached HEAD file2 &&
+	test_must_fail git diff --quiet &&
+	git diff-index --exit-code --cached HEAD
+'
+
+test_expect_success '--cached without --no-overlay does not remove entry from index' '
+	test_must_fail git checkout --cached HEAD^ file3 &&
+	git ls-files --error-unmatch -- file3
+'
+
+test_expect_success 'file is removed from the index with --no-overlay' '
+	git checkout --cached --no-overlay HEAD^ file3 &&
+	test_path_is_file file3 &&
+	test_must_fail git ls-files --error-unmatch -- file3
+'
+
+test_expect_success 'test checkout --cached --no-overlay at given paths' '
+	mkdir sub &&
+	>sub/file1 &&
+	>sub/file2 &&
+	git update-index --add sub/file1 sub/file2 &&
+	T=$(git write-tree) &&
+	git checkout --cached --no-overlay HEAD sub/file2 &&
+	test_must_fail git diff --quiet &&
+	U=$(git write-tree) &&
+	echo "$T" &&
+	echo "$U" &&
+	test_must_fail git diff-index --cached --exit-code "$T" &&
+	test "$T" != "$U"
+'
+
+test_done
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index a3fd9a9630..cbc304ace8 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1437,6 +1437,7 @@ test_expect_success 'double dash "git checkout"' '
 	--no-quiet Z
 	--no-... Z
 	--overlay Z
+	--cached Z
 	EOF
 '
 
-- 
2.20.0.405.gbc1bbc6f85

