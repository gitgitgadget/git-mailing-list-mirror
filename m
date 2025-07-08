Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF92DECB3
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982490; cv=none; b=KY+GAa5NZjrmO86iyMjZTlHHUmswGvHkIOOAgJfPQVlst2nfgA4JpqVItxtj0vuWNaknRMCV3VtSTdhj/2OAmQYW5lyaYhjbxvoKdIYIp3xNpeoX5yhwwI3+DUFqHAWQoaIoyOa8Il8axCs7mGo00FmErUaK5UrXXKnDxnOCIJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982490; c=relaxed/simple;
	bh=vBBVEowkAYF0AyKjXzyB37m2Ttl8yL7DK0MyUdV7bQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iugGhgW+y3Sh8nUQ7+vK4cWNdxkZnVk/B517RqNW2tiU8dyhXPHqg2exxm3BAFhJd5dwX4+LU6xGTu2j67kFpVk1FoYYbYa05aucTxvK0hXPPDZa99Ol1Zw43QJDeZcHAZRJBvMqCLmt+UlAjd5/BkhtMkqxhKK8GN5SNzXnRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+10TcWF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+10TcWF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so693504366b.3
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751982486; x=1752587286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vT3q66WRvVDvF/Ld1p4X46Mabt+6tA53nEkIXh3ZCe0=;
        b=F+10TcWFfJnoLmKR0a7vRE46Lz1Ohstqxbc3ezsysqvS2u43o0k2DynqKrosIDVpnB
         mqj61tHsP74/fPRXR6MB+fvzBS1pPoX7jiOga5Lytw7O7S1j1TQZP2N7PSJxr4OCQzQP
         1mCQ7yq2TFUX2f6mZg0hRfXQnchaLgRg1mwFELuXyQxYKghclpnpt2GXkJ9G54dCE5/B
         +K8x5HSG024NZGaysfOQz0zEIz/4qXcpyhD1caUbA9FgCfhjaRppTNDo0L4GdK5smnHA
         v5XVeWdTLoImMpEcv7nITQfg334cf/VjQbxJfNkMG2D9/THW65CPlHPSSABG0DMEhE1p
         bATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982486; x=1752587286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT3q66WRvVDvF/Ld1p4X46Mabt+6tA53nEkIXh3ZCe0=;
        b=TtfLpHviPXvaNg7vZlWs0wqbrX1vvhKRF8bDX5gfZXDOCuFtXVCp1PN4ZkfHqlpf6a
         e5PNRfdWs4YJpWQh+102zXnnKyB6s2oLKZ936EYrakCD+OqPbRc1Ju+php6vjOj/A8WT
         sL0nBM938aRJsgfYiJlE/jxWn6fU6jmaOx08GUbs/8AHflDNBmddzwWEicWRil+yJIMg
         fsKtbnBvRpN47j70fuz6qsE9lQ/wynAa/UOZwih3ndVL1WkxXLqqI4K6kSMtX0Xtl47b
         +o9pDNWViQcuqQzQJ1X8USMVQzb+Ffo8w5O+18EDULVBiLMxpyMfliSdPvy4+rm6ygfR
         L2Ng==
X-Gm-Message-State: AOJu0YxlkPwyKZzxI24ACjcVi0JlVepR0hLtDk2V+i/4wZ/9ApWmspoX
	gJk4x+01IpVG1A1mAPiBGWWpDvQ23DqnVxbglf94M8PET/eZoYsjAq4L
X-Gm-Gg: ASbGncv2FKsVkhp7iK7ejcunCKeSX6wUQIbDThtYqynArMlEXxku48yVkYN+qTjgWhd
	C5IbvXE2FEiB7h8a/7mPR7Jyw4ZjctcgqrtgUr5Bmt0wwbAXiT/kXYTXn+9J7utjOhFLVhhZj7o
	yBiImZmBxhbv5knfFsmDzODn9mWox3wVGJDvXV+2WD0MlshyCs21GQv/l8NGJxnRVDsMLH54jS9
	4Z4elvohZ0ymEzauyKfq/FFefHoelmbPI45WSpLGtVBMXvASBBv8HmEkUUKARPA5Svii4ZPLpxH
	PRzQj8cSQKFDVrvrS/PPGNjZjWD4ZfOd74uCRxq0
X-Google-Smtp-Source: AGHT+IGsHzv370FCLyM0EbgpODu+s6OSQ+JX3Nmz/jaXeuQnr7AM17virNPIr9WSSigiK+uWkCQRjw==
X-Received: by 2002:a17:907:6ea4:b0:ae3:f299:ba47 with SMTP id a640c23a62f3a-ae3fe7b3445mr1704789066b.32.1751982485835;
        Tue, 08 Jul 2025 06:48:05 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b03032sm886575466b.124.2025.07.08.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:48:05 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 08 Jul 2025 15:47:49 +0200
Subject: [PATCH v3 4/4] for-each-ref: introduce a '--start-after' option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-306-git-for-each-ref-pagination-v3-4-8cfba1080be4@gmail.com>
References: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
In-Reply-To: <20250708-306-git-for-each-ref-pagination-v3-0-8cfba1080be4@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15213;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=vBBVEowkAYF0AyKjXzyB37m2Ttl8yL7DK0MyUdV7bQo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhtIY8OJjNiDUZsOlxlYAyFZjWsxe0TuO5On
 HdRp5Oz31/+NokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJobSGPAAoJED7VnySO
 Rox/U1YL/jyogr6mtCbAtH+ZCOU1A63VVXy7b0yn/2k0TLnKk/Ot0gttpJ4qqJ9Dl8EcMlfkkFp
 XJ9AMPvqOETEpa8legeSIT76X3z3wPWu4HejwKS/mJkqXanxvG0vE5AGLl8Cjg/wQ74/WTtVcs1
 7c89D2N+Y9RF4t24/gbYLLgxL/kTkJVqb5I3XzUQWkf4Z+X7gq1UKBuBJ6wgd/oI/Y87LDVrChd
 ZhxxAInZ2lcNDf0IGMxAkSjPnCRWEdzKLSaLi4jVY/Wpzvnr47kkBhm+f5lAlv9mXNsXpZx3XhK
 24rNlwzg+8KmLiuFfpqr1EBWH5XbmWRo87qtpqqkSamanrFdkSEe/Es4FomENiSWChE+OGvYuMO
 uAPZhxb8iziu6RYkiCS/V3lNasfNN6+4ru4UlJX6X6OnSYxR5ChoB84aOFZ+eYVAl2RmAhMYrFX
 /FhVqcF+djDZvCRhBQEAL2h1Uxtbp4yrftkQgiSHCuCvZCtXdk0WKbT43s67LEDWbMDvQpH2Dt5
 Vg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git-for-each-ref(1)` command is used to iterate over references
present in a repository. In large repositories with millions of
references, it would be optimal to paginate this output such that we
can start iteration from a given reference. This would avoid having to
iterate over all references from the beginning each time when paginating
through results.

The previous commit added 'seek' functionality to the reference
backends. Utilize this and expose a '--start-after' option in
'git-for-each-ref(1)'. When used, the reference iteration seeks to the
lexicographically next reference and iterates from there onward.

This enables efficient pagination workflows like:
    git for-each-ref --count=100
    git for-each-ref --count=100 --start-after=refs/heads/branch-100
    git for-each-ref --count=100 --start-after=refs/heads/branch-200

Since the reference iterators only allow seeking to a specified marker
via the `ref_iterator_seek()`, we introduce a helper function
`start_ref_iterator_after()`, which seeks to next reference by simply
adding (char) 1 to the marker.

We must note that pagination always continues from the provided marker,
as such any concurrent reference updates lexicographically behind the
marker will not be output. Document the same.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc |  11 +-
 builtin/for-each-ref.c              |   8 ++
 ref-filter.c                        |  80 +++++++++++----
 ref-filter.h                        |   1 +
 t/t6302-for-each-ref-filter.sh      | 194 ++++++++++++++++++++++++++++++++++++
 5 files changed, 273 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 5ef89fc0fe..e099d1ba7c 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -14,7 +14,7 @@ SYNOPSIS
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
-		   [--exclude=<pattern> ...]
+		   [--exclude=<pattern> ...] [--start-after=<marker>]
 
 DESCRIPTION
 -----------
@@ -108,6 +108,15 @@ TAB %(refname)`.
 --include-root-refs::
 	List root refs (HEAD and pseudorefs) apart from regular refs.
 
+--start-after::
+    Allows paginating the output by skipping references up to and including the
+    specified marker. When paging, it should be noted that references may be
+    deleted, modified or added between invocations. Output will only yield those
+    references which follow the marker lexicographically. If the marker does not
+    exist, output begins from the first reference that would come after it
+    alphabetically. Cannot be used with general pattern matching or custom
+    sort options.
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3d2207ec77..3f21598046 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -13,6 +13,7 @@ static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [--points-at <object>]"),
 	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
 	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
+	N_("git for-each-ref [--start-after <marker>]"),
 	NULL
 };
 
@@ -44,6 +45,7 @@ int cmd_for_each_ref(int argc,
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(  0 , "start-after", &filter.start_after, N_("start-start"), N_("start iteration after the provided marker")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),
@@ -79,6 +81,9 @@ int cmd_for_each_ref(int argc,
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
+	if (filter.start_after && sorting_options.nr > 1)
+		die(_("cannot use --start-after with custom sort options"));
+
 	sorting = ref_sorting_options(&sorting_options);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
@@ -100,6 +105,9 @@ int cmd_for_each_ref(int argc,
 		filter.name_patterns = argv;
 	}
 
+	if (filter.start_after && filter.name_patterns && filter.name_patterns[0])
+		die(_("cannot use --start-after with patterns"));
+
 	if (include_root_refs)
 		flags |= FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;
 
diff --git a/ref-filter.c b/ref-filter.c
index 7a274633cf..2dfd385313 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2683,6 +2683,24 @@ static int filter_exclude_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
 }
 
+/*
+ * We need to seek to the reference right after a given marker but excluding any
+ * matching references. So we seek to the lexicographically next reference.
+ */
+static int start_ref_iterator_after(struct ref_iterator *iter, const char *marker)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret;
+
+	strbuf_addstr(&sb, marker);
+	strbuf_addch(&sb, 1);
+
+	ret = ref_iterator_seek(iter, sb.buf, 0);
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 /*
  * This is the same as for_each_fullref_in(), but it tries to iterate
  * only over the patterns we'll care about. Note that it _doesn't_ do a full
@@ -2692,10 +2710,13 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       each_ref_fn cb,
 				       void *cb_data)
 {
+	struct ref_iterator *iter;
+	int flags = 0, ret = 0;
+
 	if (filter->kind & FILTER_REFS_ROOT_REFS) {
 		/* In this case, we want to print all refs including root refs. */
-		return refs_for_each_include_root_refs(get_main_ref_store(the_repository),
-						       cb, cb_data);
+		flags |= DO_FOR_EACH_INCLUDE_ROOT_REFS;
+		goto non_prefix_iter;
 	}
 
 	if (!filter->match_as_path) {
@@ -2704,8 +2725,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						"", NULL, cb, cb_data);
+		goto non_prefix_iter;
 	}
 
 	if (filter->ignore_case) {
@@ -2714,20 +2734,29 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		 * so just return everything and let the caller
 		 * sort it out.
 		 */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						"", NULL, cb, cb_data);
+		goto non_prefix_iter;
 	}
 
 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						 "", filter->exclude.v, cb, cb_data);
+		goto non_prefix_iter;
 	}
 
 	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
 						 NULL, filter->name_patterns,
 						 filter->exclude.v,
 						 cb, cb_data);
+
+non_prefix_iter:
+	iter = refs_ref_iterator_begin(get_main_ref_store(the_repository), "",
+				       NULL, 0, flags);
+	if (filter->start_after)
+		ret = start_ref_iterator_after(iter, filter->start_after);
+
+	if (ret)
+		return ret;
+
+	return do_for_each_ref_iterator(iter, cb, cb_data);
 }
 
 /*
@@ -3197,9 +3226,11 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 	init_contains_cache(&filter->internal.no_contains_cache);
 
 	/*  Simple per-ref filtering */
-	if (!filter->kind)
+	if (!filter->kind) {
 		die("filter_refs: invalid type");
-	else {
+	} else {
+		const char *prefix = NULL;
+
 		/*
 		 * For common cases where we need only branches or remotes or tags,
 		 * we only iterate through those refs. If a mix of refs is needed,
@@ -3207,19 +3238,28 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 		 * of filter_ref_kind().
 		 */
 		if (filter->kind == FILTER_REFS_BRANCHES)
-			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						       "refs/heads/", NULL,
-						       fn, cb_data);
+			prefix = "refs/heads/";
 		else if (filter->kind == FILTER_REFS_REMOTES)
-			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						       "refs/remotes/", NULL,
-						       fn, cb_data);
+			prefix = "refs/remotes/";
 		else if (filter->kind == FILTER_REFS_TAGS)
-			ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						       "refs/tags/", NULL, fn,
-						       cb_data);
-		else if (filter->kind & FILTER_REFS_REGULAR)
+			prefix = "refs/tags/";
+
+		if (prefix) {
+			struct ref_iterator *iter;
+
+			iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
+						       "", NULL, 0, 0);
+
+			if (filter->start_after)
+				ret = start_ref_iterator_after(iter, filter->start_after);
+			else if (prefix)
+				ret = ref_iterator_seek(iter, prefix, 1);
+
+			if (!ret)
+				ret = do_for_each_ref_iterator(iter, fn, cb_data);
+		} else if (filter->kind & FILTER_REFS_REGULAR) {
 			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
+		}
 
 		/*
 		 * When printing all ref types, HEAD is already included,
diff --git a/ref-filter.h b/ref-filter.h
index c98c4fbd4c..f22ca94b49 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -64,6 +64,7 @@ struct ref_array {
 
 struct ref_filter {
 	const char **name_patterns;
+	const char *start_after;
 	struct strvec exclude;
 	struct oid_array points_at;
 	struct commit_list *with_commit;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index bb02b86c16..a43e099118 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -541,4 +541,198 @@ test_expect_success 'validate worktree atom' '
 	test_cmp expect actual
 '
 
+test_expect_success 'start after with empty value' '
+	cat >expect <<-\EOF &&
+	refs/heads/main
+	refs/heads/main_worktree
+	refs/heads/side
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after="" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after a specific reference' '
+	cat >expect <<-\EOF &&
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/spot >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after a specific reference with partial match' '
+	cat >expect <<-\EOF &&
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/sp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after, just behind a specific reference' '
+	cat >expect <<-\EOF &&
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/parrot >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after with specific directory match' '
+	cat >expect <<-\EOF &&
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after with specific directory and trailing slash' '
+	cat >expect <<-\EOF &&
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/lost >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after, just behind a specific directory' '
+	cat >expect <<-\EOF &&
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after, overflow specific reference length' '
+	cat >expect <<-\EOF &&
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/spotnew >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after, overflow specific reference path' '
+	cat >expect <<-\EOF &&
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10
+	refs/tags/foo1.3
+	refs/tags/foo1.6
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/spot/new >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after, last reference' '
+	cat >expect <<-\EOF &&
+	EOF
+	git for-each-ref --format="%(refname)" --start-after=refs/tags/two >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after used with a pattern' '
+	cat >expect <<-\EOF &&
+	fatal: cannot use --start-after with patterns
+	EOF
+	test_must_fail git for-each-ref --format="%(refname)" --start-after=refs/odd/spot refs/tags 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'start after used with custom sort order' '
+	cat >expect <<-\EOF &&
+	fatal: cannot use --start-after with custom sort options
+	EOF
+	test_must_fail git for-each-ref --format="%(refname)" --start-after=refs/odd/spot --sort=author 2>actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.49.0

