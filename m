Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0382026ADF
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSRHq8yl"
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76A3114
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:04 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-778925998cbso399338585a.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991643; x=1700596443; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzViII5dMOLWDmCjCcUV7YWruXOQN2wnQL9UcYEfTl4=;
        b=ZSRHq8ylH+E5X7tAe/ABBR4nYOl+WsxKCAbXpWN9hG++61UGQQNRYJ0K1dxl77+GUD
         8KZQuzaZpdl06IuxDzVyWR3F1n5YruzE4ahaY2fvnGOQ07x+zvza2jc4QK9bPUp3o3lb
         Q+x9UE6VXlaV80AxPohCgv/etiGJ9mNCew17oI5d8zqRtPa3QbgfBRj4plc4EXnVkP9C
         Hec3x1ZS9kHiWFHtDaKlEvVk2uGiVKvVIMsJAmc8ncRsyf+tOtYT3GPLFga/nzq0gb8P
         1q1tzwuFyFLD8oF3yk6DZE+Wqcz4Q2y9sKK1DsH2B5+4FbaYdJEGdxmUAx5Ki02Jn00V
         ETfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991643; x=1700596443;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzViII5dMOLWDmCjCcUV7YWruXOQN2wnQL9UcYEfTl4=;
        b=RfBMPlTfGpXLfM1sf0RMiWPEBORKu2jgSL0qyfC9Gb5QJWN4xf7BjtsNJC6VzNA2e6
         9Hzurs76CkswyC43ogJS+ZDz3LOIbvsfRzli2IcgZe6RRG69fQaDiSg0myvX0rfLkPsU
         jzOuPmcCJ0LG8NjwN+xJ4uR0nvnuzC+prLLe8CmsjI447kUdhJM8hDhckqnsoxQWzxNy
         2nLjRuoMuXkMYCHl4i+PQpHz0wuwRJegAAnbx6gE2lCyS4CAngZH/x9CBxSW27w9NQE3
         Khr/9KgZ4bt9ZANyn4HTO1wPAWdMcOQd6U5mVSCgOhX3aQsWSTKRPBNgdWvhBvRMxHQW
         ATdg==
X-Gm-Message-State: AOJu0Yx+mSg9ARgW+jtokDRcA6yiNAGC1pDcbfFv0axT4A7rYxs/rdr3
	F/qRK9388VBQMrMe14NfwxqOMZJnBRY=
X-Google-Smtp-Source: AGHT+IGZOvM3phxwIABI4kkrtNzUlB+L+ZrZPM/Dk+sKn205SY8oEjBGL/0nbunz9ypr/vLqdZSvhw==
X-Received: by 2002:a05:620a:6505:b0:778:8ce5:f657 with SMTP id qb5-20020a05620a650500b007788ce5f657mr3821520qkn.20.1699991643372;
        Tue, 14 Nov 2023 11:54:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u24-20020ae9c018000000b0077589913a8bsm2874994qkk.132.2023.11.14.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:03 -0800 (PST)
Message-ID: <074da1ff3e85927324c42a3fa65e4239f051cd70.1699991638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:49 +0000
Subject: [PATCH v2 01/10] ref-filter.c: really don't sort when using --no-sort
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

When '--no-sort' is passed to 'for-each-ref', 'tag', and 'branch', the
printed refs are still sorted by ascending refname. Change the handling of
sort options in these commands so that '--no-sort' to truly disables
sorting.

'--no-sort' does not disable sorting in these commands is because their
option parsing does not distinguish between "the absence of '--sort'"
(and/or values for tag.sort & branch.sort) and '--no-sort'. Both result in
an empty 'sorting_options' string list, which is parsed by
'ref_sorting_options()' to create the 'struct ref_sorting *' for the
command. If the string list is empty, 'ref_sorting_options()' interprets
that as "the absence of '--sort'" and returns the default ref sorting
structure (equivalent to "refname" sort).

To handle '--no-sort' properly while preserving the "refname" sort in the
"absence of --sort'" case, first explicitly add "refname" to the string list
*before* parsing options. This alone doesn't actually change any behavior,
since 'compare_refs()' already falls back on comparing refnames if two refs
are equal w.r.t all other sort keys.

Now that the string list is populated by default, '--no-sort' is the only
way to empty the 'sorting_options' string list. Update
'ref_sorting_options()' to return a NULL 'struct ref_sorting *' if the
string list is empty, and add a condition to 'ref_array_sort()' to skip the
sort altogether if the sort structure is NULL. Note that other functions
using 'struct ref_sorting *' do not need any changes because they already
ignore NULL values.

Finally, remove the condition around sorting in 'ls-remote', since it's no
longer necessary. Unlike 'for-each-ref' et. al., it does *not* do any
sorting by default. This default is preserved by simply leaving its sort key
string list empty before parsing options; if no additional sort keys are
set, 'struct ref_sorting *' is NULL and sorting is skipped.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/branch.c        |  6 ++++
 builtin/for-each-ref.c  |  3 ++
 builtin/ls-remote.c     | 11 +++----
 builtin/tag.c           |  6 ++++
 ref-filter.c            | 19 ++----------
 t/t3200-branch.sh       | 68 +++++++++++++++++++++++++++++++++++++++--
 t/t6300-for-each-ref.sh | 21 +++++++++++++
 t/t7004-tag.sh          | 45 +++++++++++++++++++++++++++
 8 files changed, 153 insertions(+), 26 deletions(-)

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
index fc765754305..b416602b4d3 100644
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
@@ -157,6 +153,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		status = 0; /* we found something */
 	}
 
+	ref_sorting_release(sorting);
 	ref_array_clear(&ref_array);
 	if (transport_disconnect(transport))
 		status = 1;
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

