Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87516C4332F
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbhLVOVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245661AbhLVOVB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:21:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551FC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e5so5256399wrc.5
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D8biI8g5hUBagVH35EigGLK5NbB9QTcBEuE3+vURGtQ=;
        b=mWPbC2oOcX9LJXQ5qX6rw2xK2EcnKLtEfcyySZF0cBwk+3w75vscK61h4dzqn8Wfqa
         8YYG6dMBben1dnsj7mUDk9/KbUwccdqPR8gII9zo5Tr8XpPVjaLTyqLWjESrPVNomUGa
         GtWqMUzrBIngHsHfOCDvcIgLKkrkL6vxRbsgz0VFNSsg/snhAQ6HGOQ7JYbAGF7n8UY8
         47n4B6P+Ho1lidHgNCAGxOILJRgiI4Kv82Mq/Byt+ylW70vGbxJf5tdpBJL/2ANrHJkN
         BCMjV0hb7FXJX0MOgd6leV+mmGmmJsrlJbFIMOiBqPzVvfeNwuzY6x855EspHPS0URlk
         aPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D8biI8g5hUBagVH35EigGLK5NbB9QTcBEuE3+vURGtQ=;
        b=fynDzFDN8DxnNnne/36sVqcK2c/VuFJooJqyL34yHFeGeaYbaLSEvQDhN/bekwntqd
         ApjTJoLGRshrWpo/vZJGKvkmePjk6q3mSPG8LEzwof/Exo0eowyD6+vPJ7qdvpq+Lr8N
         FNHRA8D+eVZ3YnokZE0xZg6qJSy4Ho7iVw+OvumaK1O0I5mXnNbSzLCTVKB/aPCR8AU+
         Kq3esP6KbhfNFHu08ZgH+NiXL21wuWSuzh7hJsF2xQkWmJEfdQIHXp7xoJq5kiebSB3E
         G+X935M74whVJ8l+yjoiH04YiG8gvmlUR5Q0s7I+RBkdSzha/C5IEG6KhKz2N91cAYaJ
         wpTg==
X-Gm-Message-State: AOAM532KCgHmtTpYT/ukTUxY9V+YGNhu2bnJ66UbXKlAS7sFQpL+hzet
        OIAF6ZuXpBCgcbW0h/BJmckLpEW7UV4=
X-Google-Smtp-Source: ABdhPJxelhgG41QGBfS93A9eyjqaRngZEjZpcrBPlgNrQuItgmuX1gYfYfO7Q9f7Tq3KcqANktXyhg==
X-Received: by 2002:adf:e683:: with SMTP id r3mr2207363wrm.480.1640182859656;
        Wed, 22 Dec 2021 06:20:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e4sm2149062wrh.56.2021.12.22.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:20:59 -0800 (PST)
Message-Id: <e1ec52881d9ad18097254040824902b799667113.1640182856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
References: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
        <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:20:53 +0000
Subject: [PATCH v4 2/5] ls-files: add --sparse option
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
 Documentation/git-ls-files.txt           |  5 ++
 builtin/ls-files.c                       | 12 +++-
 t/t1092-sparse-checkout-compatibility.sh | 91 ++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 2e3d695fa21..48cc7c0b6f4 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -187,6 +187,11 @@ Both the <eolinfo> in the index ("i/<eolinfo>")
 and in the working tree ("w/<eolinfo>") are shown for regular files,
 followed by the  ("attr/<eolattr>").
 
+--sparse::
+	If the index is sparse, show the sparse directories without expanding
+	to the contained files. Sparse directories will be shown with a
+	trailing slash, such as "x/" for a sparse directory "x".
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
index 8d3c21fc84c..0c51e9bd3b7 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -816,6 +816,12 @@ test_expect_success 'sparse-index is expanded and converted back' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
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
 
@@ -871,6 +877,7 @@ test_expect_success 'sparse-index is not expanded' '
 	init_repos &&
 
 	ensure_not_expanded status &&
+	ensure_not_expanded ls-files --sparse &&
 	ensure_not_expanded commit --allow-empty -m empty &&
 	echo >>sparse-index/a &&
 	ensure_not_expanded commit -a -m a &&
@@ -1019,6 +1026,90 @@ test_expect_success 'sparse index is not expanded: fetch/pull' '
 	ensure_not_expanded pull full base
 '
 
+test_expect_success 'ls-files' '
+	init_repos &&
+
+	# Use a smaller sparse-checkout for reduced output
+	test_sparse_match git sparse-checkout set &&
+
+	# Behavior agrees by default. Sparse index is expanded.
+	test_all_match git ls-files &&
+
+	# With --sparse, the sparse index data changes behavior.
+	git -C sparse-index ls-files --sparse >actual &&
+
+	cat >expect <<-\EOF &&
+	a
+	deep/
+	e
+	folder1-
+	folder1.x
+	folder1/
+	folder10
+	folder2/
+	g
+	x/
+	z
+	EOF
+
+	test_cmp expect actual &&
+
+	# With --sparse and no sparse index, nothing changes.
+	git -C sparse-checkout ls-files >dense &&
+	git -C sparse-checkout ls-files --sparse >sparse &&
+	test_cmp dense sparse &&
+
+	# Set up a strange condition of having a file edit
+	# outside of the sparse-checkout cone. This is just
+	# to verify that sparse-checkout and sparse-index
+	# behave the same in this case.
+	write_script edit-content <<-\EOF &&
+	mkdir folder1 &&
+	echo content >>folder1/a
+	EOF
+	run_on_sparse ../edit-content &&
+
+	# ls-files does not currently notice modified files whose
+	# cache entries are marked SKIP_WORKTREE. This may change
+	# in the future, but here we test that sparse index does
+	# not accidentally create a change of behavior.
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
+	test_all_match git ls-files &&
+	git -C sparse-index ls-files --sparse >actual &&
+
+	cat >expect <<-\EOF &&
+	a
+	deep/
+	e
+	folder1-
+	folder1.x
+	folder1/0/0/0
+	folder1/0/1
+	folder1/a
+	folder10
+	folder2/
+	g
+	x/
+	z
+	EOF
+
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

