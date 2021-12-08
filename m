Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC5BC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 19:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhLHTnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhLHTnd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 14:43:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12AC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 11:40:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o29so2580409wms.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 11:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jpKzSaa1vLOzLitspYXOY0rB72oZr2VnYo72GMh22u4=;
        b=A56zCfK/kM1L0zQpwiIMcpMPF2iZftd/Vz/NvGqeXsYZot0aihLkcA7Kil+/81VxoV
         tG2exSs0TzGjk54G8MNYcucb/MhNHZwg1YOg1WExyFRBObCgTC6zcJlPG2SGfpyf/E2v
         VxnIoaw97hN4F3iz5b9LzCXWvXEkNl7L//PIKQit7+t/gkpYB6lcmKq8Icuja/hF0AOV
         KnQ6tdWfAVwJu3GPHR+NvNTRXuEEwz1rqu7nVfBuaShS9HESHGCnaezxUNxqx7yK62v/
         miemJKoqSVsVlep3uMXkwW10We5GNQIMpzRBrS4J3UAqSPA/nwbpbhV5aHP92yjazTll
         QJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jpKzSaa1vLOzLitspYXOY0rB72oZr2VnYo72GMh22u4=;
        b=CXmpoDuTyv+nnXMcIIZlCCe8NTrJiZVeM+c+tYSN5USBe0Pz2/NXqs0S2AamccxBe+
         6RKGKZMY1AnG/ukAN+dhJ9Q+82FLTslRToR5E7i9GrIn/CT90zMc+pxB3imWhPulzyPd
         jO9KT6WOCKIDCXbO++Apr7dUqCCVs4dge8o+oYy3BPslcbpoVBRQbYAt5k2mAiCj0Xqd
         DuniZtIgMxliqiRxxVNLYmblK2NfeDjBizyHTi9jkjH8s/Jf2zzOqdD9O9TzzlfS7mta
         o6rRE/WC6CzEGEeH4QvAda13Hj/rmlZZ4cpfPhdroxShPVDb0TqzS744cFf589PkxCmV
         2Zxw==
X-Gm-Message-State: AOAM530RnhnzUvsRYL796fQTTbzyc+oGuIUKfdlqegEK2ZrPkH1Xl8Hc
        +FwViaovJ+NWKeMpH5oa/zu1Ca6LBSY=
X-Google-Smtp-Source: ABdhPJxkKwEEiLjELScPkxRLFcV5+ZICrPdzC4lnDUQLykW9Md1POffnVEnmNy2jiyt4xeBbqPLZiA==
X-Received: by 2002:a05:600c:4e51:: with SMTP id e17mr781155wmq.127.1638992399020;
        Wed, 08 Dec 2021 11:39:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm3520301wrz.23.2021.12.08.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:39:58 -0800 (PST)
Message-Id: <58b5eca483502b0d45601490f6b4255f6419e6bd.1638992396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
        <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 19:39:52 +0000
Subject: [PATCH v2 2/5] ls-files: add --sparse option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Existing callers to 'git ls-files' are expecting file names, not
directories. It is best to expand a sparse index to show all of the
contained files in this case.

However, expert users may want to inspect the contents of the index
itself including which directories are sparse. Add a --sparse option to
allow users to request this information.

During testing, I noticed that options such as --modified did not affect
the output when the files in question were outside the sparse-checkout
definition. Tests are added to document this preexisting behavior and
how it remains unchanged with the sparse index and the --sparse option.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-ls-files.txt           |  4 ++
 builtin/ls-files.c                       | 12 +++-
 t/t1092-sparse-checkout-compatibility.sh | 90 ++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 6d11ab506b7..1c5d5f85ec5 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -187,6 +187,10 @@ Both the <eolinfo> in the index ("i/<eolinfo>")
 and in the working tree ("w/<eolinfo>") are shown for regular files,
 followed by the  ("attr/<eolattr>").
 
+--sparse::
+	If the index is sparse, show the sparse directories without expanding
+	to the contained files.
+
 \--::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 031fef1bcaa..c151eb1fb77 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -37,6 +37,7 @@ static int debug_mode;
 static int show_eol;
 static int recurse_submodules;
 static int skipping_duplicates;
+static int show_sparse_dirs;
 
 static const char *prefix;
 static int max_prefix_len;
@@ -315,8 +316,10 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
 	if (!(show_cached || show_stage || show_deleted || show_modified))
 		return;
-	/* TODO: audit for interaction with sparse-index. */
-	ensure_full_index(repo->index);
+
+	if (!show_sparse_dirs)
+		ensure_full_index(repo->index);
+
 	for (i = 0; i < repo->index->cache_nr; i++) {
 		const struct cache_entry *ce = repo->index->cache[i];
 		struct stat st;
@@ -670,6 +673,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_BOOL(0, "deduplicate", &skipping_duplicates,
 			 N_("suppress duplicate entries")),
+		OPT_BOOL(0, "sparse", &show_sparse_dirs,
+			 N_("show sparse directories in the presence of a sparse index")),
 		OPT_END()
 	};
 	int ret = 0;
@@ -677,6 +682,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(ls_files_usage, builtin_ls_files_options);
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 3ba19ba1c14..bf2c6b169b9 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -802,6 +802,12 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
 		git -C sparse-index reset -- folder1/a &&
 	test_region index convert_to_sparse trace2.txt &&
+	test_region index ensure_full_index trace2.txt &&
+
+	# ls-files expands on read, but does not write.
+	rm trace2.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git -C sparse-index ls-files &&
 	test_region index ensure_full_index trace2.txt
 '
 
@@ -826,6 +832,7 @@ test_expect_success 'sparse-index is not expanded' '
 	init_repos &&
 
 	ensure_not_expanded status &&
+	ensure_not_expanded ls-files --sparse &&
 	ensure_not_expanded commit --allow-empty -m empty &&
 	echo >>sparse-index/a &&
 	ensure_not_expanded commit -a -m a &&
@@ -974,6 +981,89 @@ test_expect_success 'sparse index is not expanded: fetch/pull' '
 	ensure_not_expanded pull full base
 '
 
+test_expect_success 'ls-files' '
+	init_repos &&
+
+	# Behavior agrees by default. Sparse index is expanded.
+	test_all_match git ls-files &&
+
+	# With --sparse, the sparse index data changes behavior.
+	git -C sparse-index ls-files >dense &&
+	git -C sparse-index ls-files --sparse >sparse &&
+
+	cat >expect <<-\EOF &&
+	@@ -13,13 +13,9 @@
+	 e
+	 folder1-
+	 folder1.x
+	-folder1/0/0/0
+	-folder1/0/1
+	-folder1/a
+	+folder1/
+	 folder10
+	-folder2/0/0/0
+	-folder2/0/1
+	-folder2/a
+	+folder2/
+	 g
+	-x/a
+	+x/
+	 z
+	EOF
+
+	diff -u dense sparse | tail -n +3 >actual &&
+	test_cmp expect actual &&
+
+	# With --sparse and no sparse index, nothing changes.
+	git -C sparse-checkout ls-files >dense &&
+	git -C sparse-checkout ls-files --sparse >sparse &&
+	test_cmp dense sparse &&
+
+	write_script edit-content <<-\EOF &&
+	mkdir folder1 &&
+	echo content >>folder1/a
+	EOF
+	run_on_sparse ../edit-content &&
+
+	# ls-files does not notice modified files whose
+	# cache entries are marked SKIP_WORKTREE.
+	test_sparse_match git ls-files --modified &&
+	test_must_be_empty sparse-checkout-out &&
+	test_must_be_empty sparse-index-out &&
+
+	git -C sparse-index ls-files --sparse --modified >sparse-index-out &&
+	test_must_be_empty sparse-index-out &&
+
+	# Add folder1 to the sparse-checkout cone and
+	# check that ls-files shows the expanded files.
+	test_sparse_match git sparse-checkout add folder1 &&
+	test_sparse_match git ls-files --modified &&
+
+	git -C sparse-index ls-files >dense &&
+	git -C sparse-index ls-files --sparse >sparse &&
+
+	cat >expect <<-\EOF &&
+	@@ -17,9 +17,7 @@
+	 folder1/0/1
+	 folder1/a
+	 folder10
+	-folder2/0/0/0
+	-folder2/0/1
+	-folder2/a
+	+folder2/
+	 g
+	-x/a
+	+x/
+	 z
+	EOF
+
+	diff -u dense sparse | tail -n +3 >actual &&
+	test_cmp expect actual &&
+
+	# Double-check index expansion is avoided
+	ensure_not_expanded ls-files --sparse
+'
+
 # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 # in this scenario, but it shouldn't.
 test_expect_success 'reset mixed and checkout orphan' '
-- 
gitgitgadget

