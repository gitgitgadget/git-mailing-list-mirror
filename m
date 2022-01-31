Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B02DC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 15:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358790AbiAaPBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 10:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358760AbiAaPBH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 10:01:07 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBAC06173B
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:06 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so9565116wms.3
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gK4ZPfO2ivlVA1lIXUAfZArXY/3xNecB/HSAOb9Ny7g=;
        b=dLAkYepUFgW8rDJVmYi+1BWni2NSvoAT8yCroRjddrwpPc58qWFKG9uQk7cLb5Gr7a
         p41watXoF69MxLvHHxEwZ2HQ8i+rx8UNyB99W1vZ6qKNmNHxIIkZvyO9qH6FMri6/xJ8
         Kt6l2V+8lMi93Xrmfleo3WgVH2r8iHJXKfp8wG65YF1QpbTuzMVI46VXFIaZLjGxt9+/
         Nm0mCoIcJ52QBoIGTXayAPZ7danwQbole5ZJ6y5QZ/r30Cioxo9m9kY/EXG/KyWOWwr0
         drlfX3GEZBVIRbtTXqaYeWunCLfnv+R+V9BZ7rzBQpwUaxQMwnoSZFx70pzcqqt/1Ns1
         +IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gK4ZPfO2ivlVA1lIXUAfZArXY/3xNecB/HSAOb9Ny7g=;
        b=2pMoVSEzaxAIZZ4um8p4NT5mNK6d2gfJX1bFVOUREXm8tk66Ghjn94t6NujMYOd14w
         swXopscJvque+REb/WzVFZwEnsXV5Vh9/tsoyBTuOC+mQcIuyr3D+6UteAS3E+F6gZj4
         FDB2C/QJo4fdz302QyjaMDxzIK/JOG0qph3JTurBdFH6e/T4Xkflm04X61No6jZSs+p/
         fWJuVZAXz2ECf4Ggi3PlovZOO1icV6OKcXqq2IXJCkjQ0lismPd2aimlfy6FxnjzyF6h
         sUS3+bar1mmYc2ZELKvlqEl2PwCF3/2XkrPggrOwyiSqcBy2ONQL/ji2TkJyH/iBbLEb
         h+HQ==
X-Gm-Message-State: AOAM533hv7diyV2IWNMDKfpGiuJ7Iw9Cwt2vt0I0chSSviF+5YBFB3KB
        Vl6tTrVHdqXuFdThHU2JA3GjbdVuHf4=
X-Google-Smtp-Source: ABdhPJxVWKugGwLXSXRsnMo5q4Sg5cfHP+rv5ocOIHGlMP/CLj9ykZem9IlbOc6fqGAz2L+NYn0bQA==
X-Received: by 2002:a05:600c:4f06:: with SMTP id l6mr5605446wmq.126.1643641265249;
        Mon, 31 Jan 2022 07:01:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay3sm6114151wmb.44.2022.01.31.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 07:01:04 -0800 (PST)
Message-Id: <85779dfaed39220e18129e823aff9c95ade5985b.1643641259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
        <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 15:00:59 +0000
Subject: [PATCH v5 5/5] worktree: copy sparse-checkout patterns and config on
 add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When adding a new worktree, it is reasonable to expect that we want to
use the current set of sparse-checkout settings for that new worktree.
This is particularly important for repositories where the worktree would
become too large to be useful. This is even more important when using
partial clone as well, since we want to avoid downloading the missing
blobs for files that should not be written to the new worktree.

The only way to create such a worktree without this intermediate step of
expanding the full worktree is to copy the sparse-checkout patterns and
config settings during 'git worktree add'. Each worktree has its own
sparse-checkout patterns, and the default behavior when the
sparse-checkout file is missing is to include all paths at HEAD. Thus,
we need to have patterns from somewhere, they might as well be the
current worktree's patterns. These are then modified independently in
the future.

In addition to the sparse-checkout file, copy the worktree config file
if worktree config is enabled and the file exists. This will copy over
any important settings to ensure the new worktree behaves the same as
the current one. The only exception we must continue to make is that
core.bare and core.worktree should become unset in the worktree's config
file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/worktree.c                 | 60 ++++++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 31 +++++++++++----
 t/t2400-worktree-add.sh            | 46 ++++++++++++++++++++++-
 3 files changed, 127 insertions(+), 10 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 2838254f7f2..dc9cd6decc8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -335,6 +335,66 @@ static int add_worktree(const char *path, const char *refname,
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
 
+	/*
+	 * If the current worktree has sparse-checkout enabled, then copy
+	 * the sparse-checkout patterns from the current worktree.
+	 */
+	if (core_apply_sparse_checkout) {
+		char *from_file = git_pathdup("info/sparse-checkout");
+		char *to_file = xstrfmt("%s/worktrees/%s/info/sparse-checkout",
+					realpath.buf, name);
+
+		if (file_exists(from_file)) {
+			if (safe_create_leading_directories(to_file) ||
+			    copy_file(to_file, from_file, 0666))
+				error(_("failed to copy '%s' to '%s'; sparse-checkout may not work correctly"),
+				      from_file, to_file);
+		}
+
+		free(from_file);
+		free(to_file);
+	}
+
+	/*
+	 * If we are using worktree config, then copy all current config
+	 * values from the current worktree into the new one, that way the
+	 * new worktree behaves the same as this one.
+	 */
+	if (repository_format_worktree_config) {
+		char *from_file = git_pathdup("config.worktree");
+		char *to_file = xstrfmt("%s/worktrees/%s/config.worktree",
+					realpath.buf, name);
+
+		if (file_exists(from_file)) {
+			struct config_set cs = { { 0 }};
+			const char *str_value;
+			int bool_value;
+
+			if (safe_create_leading_directories(to_file) ||
+			    copy_file(to_file, from_file, 0666))
+				die(_("failed to copy worktree config from '%s' to '%s'"),
+				    from_file, to_file);
+
+			git_configset_init(&cs);
+			git_configset_add_file(&cs, from_file);
+
+			if (!git_configset_get_bool(&cs, "core.bare", &bool_value) &&
+			    bool_value &&
+			    git_config_set_multivar_in_file_gently(
+					to_file, "core.bare", NULL, "true", 0))
+				error(_("failed to unset 'core.bare' in '%s'"), to_file);
+			if (!git_configset_get_value(&cs, "core.worktree", &str_value) &&
+			    git_config_set_in_file_gently(to_file,
+							  "core.worktree", NULL))
+				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
+
+			git_configset_clear(&cs);
+		}
+
+		free(from_file);
+		free(to_file);
+	}
+
 	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 	cp.git_cmd = 1;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index be6ea4ffe33..8b92e307318 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -146,9 +146,9 @@ test_expect_success 'interaction with clone --no-checkout (unborn index)' '
 '
 
 test_expect_success 'set enables config' '
-	git init empty-config &&
+	git init worktree-config &&
 	(
-		cd empty-config &&
+		cd worktree-config &&
 		test_commit test file &&
 		test_path_is_missing .git/config.worktree &&
 		git sparse-checkout set nothing &&
@@ -201,6 +201,21 @@ test_expect_success 'add to sparse-checkout' '
 	check_files repo "a folder1 folder2"
 '
 
+test_expect_success 'worktree: add copies sparse-checkout patterns' '
+	cat repo/.git/info/sparse-checkout >old &&
+	test_when_finished cp old repo/.git/info/sparse-checkout &&
+	test_when_finished git -C repo worktree remove ../worktree &&
+	git -C repo sparse-checkout set --no-cone "/*" &&
+	git -C repo worktree add --quiet ../worktree 2>err &&
+	test_must_be_empty err &&
+	new=repo/.git/worktrees/worktree/info/sparse-checkout &&
+	test_path_is_file $new &&
+	test_cmp repo/.git/info/sparse-checkout $new &&
+	git -C worktree sparse-checkout set --cone &&
+	test_cmp_config -C worktree true core.sparseCheckoutCone &&
+	test_must_fail git -C repo core.sparseCheckoutCone
+'
+
 test_expect_success 'cone mode: match patterns' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
@@ -520,13 +535,13 @@ test_expect_success 'interaction with submodules' '
 '
 
 test_expect_success 'different sparse-checkouts with worktrees' '
+	git -C repo sparse-checkout set --cone deep folder1 &&
 	git -C repo worktree add --detach ../worktree &&
-	check_files worktree "a deep folder1 folder2" &&
-	git -C worktree sparse-checkout init --cone &&
-	git -C repo sparse-checkout set folder1 &&
-	git -C worktree sparse-checkout set deep/deeper1 &&
-	check_files repo a folder1 &&
-	check_files worktree a deep
+	check_files worktree "a deep folder1" &&
+	git -C repo sparse-checkout set --cone folder1 &&
+	git -C worktree sparse-checkout set --cone deep/deeper1 &&
+	check_files repo "a folder1" &&
+	check_files worktree "a deep"
 '
 
 test_expect_success 'set using filename keeps file on-disk' '
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 37ad79470fb..3fb5b21b943 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -165,8 +165,50 @@ test_expect_success '"add" default branch of a bare repo' '
 	(
 		git clone --bare . bare2 &&
 		cd bare2 &&
-		git worktree add ../there3 main
-	)
+		git worktree add ../there3 main &&
+		cd ../there3 &&
+		git status
+	) &&
+	cat >expect <<-EOF &&
+	init.t
+	EOF
+	ls there3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '"add" to bare repo with worktree config' '
+	(
+		git clone --bare . bare3 &&
+		cd bare3 &&
+		git config extensions.worktreeconfig true &&
+		git config --worktree core.bare true &&
+		git config --worktree core.worktree "$(pwd)" &&
+		git config --worktree bogus.key value &&
+		git config --unset core.bare &&
+		git worktree add ../there4 main &&
+		cd ../there4 &&
+		git status &&
+		git worktree add --detach ../there5 &&
+		cd ../there5 &&
+		git status
+	) &&
+
+	# the worktree has the arbitrary value copied.
+	test_cmp_config -C there4 value bogus.key &&
+	test_cmp_config -C there5 value bogus.key &&
+
+	# however, core.bare and core.worktree were removed.
+	test_must_fail git -C there4 config core.bare &&
+	test_must_fail git -C there4 config core.worktree &&
+
+	cat >expect <<-EOF &&
+	init.t
+	EOF
+
+	ls there4 >actual &&
+	test_cmp expect actual &&
+	ls there5 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'checkout with grafts' '
-- 
gitgitgadget
