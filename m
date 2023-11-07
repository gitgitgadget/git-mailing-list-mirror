Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455101C15
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvB5vsR8"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ABB11C
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:06 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c6efcef4eeso62378601fa.1
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320364; x=1699925164; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lah1s9uytX5XX598RCAWq36WhVflhjVdRAmRGoYilwM=;
        b=jvB5vsR8QVXLYGfV+mKp1xZSQtExHwR7Va9l6o/VMaMnHRWmDVXKFmENY+meNxaQCJ
         iTlZvf3LUEBFs31Lyn928BFt21HXU9DuhZLoYNLbguSb/76g5OuyZee2OoQ0oaga8EiV
         SJFb1M3JtIf7Phg8umT6+14/4bquwuCSXgUgtOi8Ph7TTjkFML69XWrmm48foluYPwYq
         oAXGkixOOKI4yPrToPSEOqVzALD49/1ce0sWgu5r7F/Kx2qjpj0GtJIFhoVWuR5jQvn6
         Oiu/Z4nmpVVCPNMkMtKFkhtdu5MedAUPYKgFbzykT113v4obtVSQEN9VD2LGMSH4dEQn
         HGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320364; x=1699925164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lah1s9uytX5XX598RCAWq36WhVflhjVdRAmRGoYilwM=;
        b=weLoX2qp5ujRTG8bOJoY7g3vFzzHJiARwV+NNDVhviPZZdEMaD3s10PY9p+/n6swxs
         1MtUxlVeY5e5O/j4+iq+YwHBQfUDaU5hirWcfzeu08HMSydch3kAc0xnHaCod6MbkXpp
         Xg6UX4i2CUY3TW3J1djm3mfBDJGmOV6JBQ/8XN2Av2SoY5S3TJt1a2cZ1JQuqDy+kMVT
         2bUEZmoKE6Y+bx+8g15UqeClYmGk1B3ZOfzvMsuijLP7pBcx11S6sa3nF1NOYFH/5cYW
         a582uk2AroUXayXqklny6xcebI5o7jsshwJsaIfhI9h/IHPn4CB/DSl3q8GoZu/MptIj
         QWaQ==
X-Gm-Message-State: AOJu0YyBpTIlgBk4op+Vi+TJ9xRy5aRgTtXlP8aXJYiKRWB+3Tc6G1pB
	+WAUSkU/I4HcJ/e5tnvHf8gcQPIY93c=
X-Google-Smtp-Source: AGHT+IGumhtiBaObQFMclFt0X3WI65vn7L6Gksr8LL+VGPEHBceWyI4q3jnPjVnCjSgDHmwQKe02VA==
X-Received: by 2002:a05:6512:acf:b0:507:9d3c:c655 with SMTP id n15-20020a0565120acf00b005079d3cc655mr28967052lfu.61.1699320364270;
        Mon, 06 Nov 2023 17:26:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d42ca000000b0032f7fab0712sm907825wrr.52.2023.11.06.17.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:04 -0800 (PST)
Message-ID: <dea8d7d1e866d9784320051b372ff729fca855d7.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:25:53 +0000
Subject: [PATCH 1/9] ref-filter.c: really don't sort when using --no-sort
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update 'ref_sorting_options()' to return a NULL 'struct ref_sorting *' if
the string list provided to it is empty, rather than returning the default
refname sort structure. Also update 'ref_array_sort()' to explicitly skip
sorting if its 'struct ref_sorting *' arg is NULL. Other functions using
'struct ref_sorting *' do not need any changes because they already properly
ignore NULL values.

The goal of this change is to have the '--no-sort' option truly disable
sorting in commands like 'for-each-ref, 'tag', and 'branch'. Right now,
'--no-sort' will still trigger refname sorting by default in 'for-each-ref',
'tag', and 'branch'.

To match existing behavior as closely as possible, explicitly add "refname"
to the list of sort keys in 'for-each-ref', 'tag', and 'branch' before
parsing options (if no config-based sort keys are set). This ensures that
sorting will only be fully disabled if '--no-sort' is provided as an option;
otherwise, "refname" sorting will remain the default. Note: this also means
that even when sort keys are provided on the command line, "refname" will be
the final sort key in the sorting structure. This doesn't actually change
any behavior, since 'compare_refs()' already falls back on comparing
refnames if two refs are equal w.r.t all other sort keys.

Finally, remove the condition around sorting in 'ls-remote', since it's no
longer necessary. Unlike 'for-each-ref' et. al., it does *not* set any sort
keys by default. The default empty list of sort keys will produce a NULL
'struct ref_sorting *', which causes the sorting to be skipped in
'ref_array_sort()'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/branch.c        |  6 ++++
 builtin/for-each-ref.c  |  3 ++
 builtin/ls-remote.c     | 10 ++----
 builtin/tag.c           |  6 ++++
 ref-filter.c            | 19 ++----------
 t/t3200-branch.sh       | 68 +++++++++++++++++++++++++++++++++++++++--
 t/t6300-for-each-ref.sh | 21 +++++++++++++
 t/t7004-tag.sh          | 45 +++++++++++++++++++++++++++
 8 files changed, 152 insertions(+), 26 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e7ee9bd0f15..d67738bbcaa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -767,7 +767,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
 
+	/*
+	 * Try to set sort keys from config. If config does not set any,
+	 * fall back on default (refname) sorting.
+	 */
 	git_config(git_branch_config, &sorting_options);
+	if (!sorting_options.nr)
+		string_list_append(&sorting_options, "refname");
 
 	track = git_branch_track;
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 350bfa6e811..93b370f550b 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -67,6 +67,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	/* Set default (refname) sorting */
+	string_list_append(&sorting_options, "refname");
+
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index fc765754305..436249b720c 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -58,6 +58,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
 	struct ref_array ref_array;
+	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 
 	struct option options[] = {
@@ -141,13 +142,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		item->symref = xstrdup_or_null(ref->symref);
 	}
 
-	if (sorting_options.nr) {
-		struct ref_sorting *sorting;
-
-		sorting = ref_sorting_options(&sorting_options);
-		ref_array_sort(sorting, &ref_array);
-		ref_sorting_release(sorting);
-	}
+	sorting = ref_sorting_options(&sorting_options);
+	ref_array_sort(sorting, &ref_array);
 
 	for (i = 0; i < ref_array.nr; i++) {
 		const struct ref_array_item *ref = ref_array.items[i];
diff --git a/builtin/tag.c b/builtin/tag.c
index 3918eacbb57..64f3196cd4c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -501,7 +501,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	setup_ref_filter_porcelain_msg();
 
+	/*
+	 * Try to set sort keys from config. If config does not set any,
+	 * fall back on default (refname) sorting.
+	 */
 	git_config(git_tag_config, &sorting_options);
+	if (!sorting_options.nr)
+		string_list_append(&sorting_options, "refname");
 
 	memset(&opt, 0, sizeof(opt));
 	filter.lines = -1;
diff --git a/ref-filter.c b/ref-filter.c
index e4d3510e28e..7250089b7c6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3142,7 +3142,8 @@ void ref_sorting_set_sort_flags_all(struct ref_sorting *sorting,
 
 void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
 {
-	QSORT_S(array->items, array->nr, compare_refs, sorting);
+	if (sorting)
+		QSORT_S(array->items, array->nr, compare_refs, sorting);
 }
 
 static void append_literal(const char *cp, const char *ep, struct ref_formatting_state *state)
@@ -3248,18 +3249,6 @@ static int parse_sorting_atom(const char *atom)
 	return res;
 }
 
-/*  If no sorting option is given, use refname to sort as default */
-static struct ref_sorting *ref_default_sorting(void)
-{
-	static const char cstr_name[] = "refname";
-
-	struct ref_sorting *sorting = xcalloc(1, sizeof(*sorting));
-
-	sorting->next = NULL;
-	sorting->atom = parse_sorting_atom(cstr_name);
-	return sorting;
-}
-
 static void parse_ref_sorting(struct ref_sorting **sorting_tail, const char *arg)
 {
 	struct ref_sorting *s;
@@ -3283,9 +3272,7 @@ struct ref_sorting *ref_sorting_options(struct string_list *options)
 	struct string_list_item *item;
 	struct ref_sorting *sorting = NULL, **tail = &sorting;
 
-	if (!options->nr) {
-		sorting = ref_default_sorting();
-	} else {
+	if (options->nr) {
 		for_each_string_list_item(item, options)
 			parse_ref_sorting(tail, item->string);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 3182abde27f..9918ba05dec 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1570,9 +1570,10 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 
 test_expect_success 'configured committerdate sort' '
 	git init -b main sort &&
+	test_config -C sort branch.sort "committerdate" &&
+
 	(
 		cd sort &&
-		git config branch.sort committerdate &&
 		test_commit initial &&
 		git checkout -b a &&
 		test_commit a &&
@@ -1592,9 +1593,10 @@ test_expect_success 'configured committerdate sort' '
 '
 
 test_expect_success 'option override configured sort' '
+	test_config -C sort branch.sort "committerdate" &&
+
 	(
 		cd sort &&
-		git config branch.sort committerdate &&
 		git branch --sort=refname >actual &&
 		cat >expect <<-\EOF &&
 		  a
@@ -1606,10 +1608,70 @@ test_expect_success 'option override configured sort' '
 	)
 '
 
+test_expect_success '--no-sort cancels config sort keys' '
+	test_config -C sort branch.sort "-refname" &&
+
+	(
+		cd sort &&
+
+		# objecttype is identical for all of them, so sort falls back on
+		# default (ascending refname)
+		git branch \
+			--no-sort \
+			--sort="objecttype" >actual &&
+		cat >expect <<-\EOF &&
+		  a
+		* b
+		  c
+		  main
+		EOF
+		test_cmp expect actual
+	)
+
+'
+
+test_expect_success '--no-sort cancels command line sort keys' '
+	(
+		cd sort &&
+
+		# objecttype is identical for all of them, so sort falls back on
+		# default (ascending refname)
+		git branch \
+			--sort="-refname" \
+			--no-sort \
+			--sort="objecttype" >actual &&
+		cat >expect <<-\EOF &&
+		  a
+		* b
+		  c
+		  main
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--no-sort without subsequent --sort prints expected branches' '
+	(
+		cd sort &&
+
+		# Sort the results with `sort` for a consistent comparison
+		# against expected
+		git branch --no-sort | sort >actual &&
+		cat >expect <<-\EOF &&
+		  a
+		  c
+		  main
+		* b
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'invalid sort parameter in configuration' '
+	test_config -C sort branch.sort "v:notvalid" &&
+
 	(
 		cd sort &&
-		git config branch.sort "v:notvalid" &&
 
 		# this works in the "listing" mode, so bad sort key
 		# is a dying offence.
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 00a060df0b5..0613e5e3623 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1335,6 +1335,27 @@ test_expect_success '--no-sort cancels the previous sort keys' '
 	test_cmp expected actual
 '
 
+test_expect_success '--no-sort without subsequent --sort prints expected refs' '
+	cat >expected <<-\EOF &&
+	refs/tags/multi-ref1-100000-user1
+	refs/tags/multi-ref1-100000-user2
+	refs/tags/multi-ref1-200000-user1
+	refs/tags/multi-ref1-200000-user2
+	refs/tags/multi-ref2-100000-user1
+	refs/tags/multi-ref2-100000-user2
+	refs/tags/multi-ref2-200000-user1
+	refs/tags/multi-ref2-200000-user2
+	EOF
+
+	# Sort the results with `sort` for a consistent comparison against
+	# expected
+	git for-each-ref \
+		--format="%(refname)" \
+		--no-sort \
+		"refs/tags/multi-*" | sort >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 	test_when_finished "git checkout main" &&
 	git for-each-ref --format="%(HEAD) %(refname:short)" refs/heads/ >actual &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e689db42929..b41a47eb943 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1862,6 +1862,51 @@ test_expect_success 'option override configured sort' '
 	test_cmp expect actual
 '
 
+test_expect_success '--no-sort cancels config sort keys' '
+	test_config tag.sort "-refname" &&
+
+	# objecttype is identical for all of them, so sort falls back on
+	# default (ascending refname)
+	git tag -l \
+		--no-sort \
+		--sort="objecttype" \
+		"foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.3
+	foo1.6
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--no-sort cancels command line sort keys' '
+	# objecttype is identical for all of them, so sort falls back on
+	# default (ascending refname)
+	git tag -l \
+		--sort="-refname" \
+		--no-sort \
+		--sort="objecttype" \
+		"foo*" >actual &&
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.3
+	foo1.6
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '--no-sort without subsequent --sort prints expected tags' '
+	# Sort the results with `sort` for a consistent comparison against
+	# expected
+	git tag -l --no-sort "foo*" | sort >actual &&
+	cat >expect <<-\EOF &&
+	foo1.10
+	foo1.3
+	foo1.6
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'invalid sort parameter on command line' '
 	test_must_fail git tag -l --sort=notvalid "foo*" >actual
 '
-- 
gitgitgadget

