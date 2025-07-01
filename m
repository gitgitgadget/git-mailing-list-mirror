Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4527978D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382259; cv=none; b=nE2owxHbxS6bZVgaJPZ6htJakEU30RRNHcj3yqYVq/VH4qEwSJ5e3LnxRhARjUZA9Yi4zDj77nxm0Phv9A+0cbarTjHQpJDLkzKlbiCyLJjS+rX6yMbNuGsPjTcf6RscVQLQWq69ahV8JCqA9sdIl9fhXhPUND7OQ3n56Y9vi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382259; c=relaxed/simple;
	bh=VKUjDgwe4sJMzskoPCR3+5zuc0yfYObEkMVI+OmWesY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddk+iUbhKqMwp8eaydeNOyBS9nSH6uMp1YhwdX5JybXg4mVjpaOLTtyLpRXvPi2R2gvkKifYi6TPibw8Xpz4MBIdiixhmikEng3WeHkQ4Fr+B9F4oVWzDBAwsAMnqI3i4yPREWtj7PT/cnxHCS0Zof7fMrDtvTBcvKFt/UyUK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es04qHLo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es04qHLo"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acb5ec407b1so607669166b.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751382255; x=1751987055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1MyXco+PQBYloONSVcOcZuWXSGE2KcL2uveFszEzjU=;
        b=es04qHLoE7brKyeHMb6ddyGbdIb915ho/x+CBt2XkqKNE/8yfQAm65a6SXOZwGMWQx
         aBRFOr+2uRh/lGSdbMp/jMWQzoFXjA1rXhPA52tHeiiHDwXzLqXwNhcbUfbOmoR4uZbk
         iUBZ0HNv57zBj6MVuab0eETDIL/WhItYJf2h+lpfuC5rmldgH93VdekxNXTBh/pZze0J
         WPxN79qkvx8WXH6rvf1NDYSzjq5KfgLE5BufLHKVKRlaGEk6Fk4iOWF9aoxbkMxx+HP4
         bswma9zapsSQxtA8OTDDcueHj3EI4k8wfLfz0zlHPz2GS9BYysWq/Mk3+5Shg1rURKGC
         CVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382255; x=1751987055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1MyXco+PQBYloONSVcOcZuWXSGE2KcL2uveFszEzjU=;
        b=XQvPnyMj4rUNyK/V1mTeOutnL6b4CmfsAaTVqy36Nb0LmH+KoBtJ+PwqgYWU4pWcVa
         h+CwT0w8XWVWXJ4YxvxOOpOoLB2ahWen/9NBSnQgwItk5PXPngchL8OsxPAZNxc4A/1v
         bdpnRBgWUD7LhT6mmL+nUe67g2WvwDAAyILr3Y5ZYFBIJDNhef9qh7/4JGf9H9P+FxGN
         40fOd6JX7srWt3diEii0V1OINUsNLPW2VgsBN/TjeyseQxDG1RgRxhhZ1DrQR/6CvR/7
         +bHPCBjOFkCGykbsFBVEW221eKuLf1f6hwrwV3MaYKj+qQXwgz7wT21QaVKOCXK+Dv/Z
         ay6w==
X-Gm-Message-State: AOJu0YwW2lMqaEl45MFEz6hSg08A98Jq9FU9TnFmT2jFBzWCxGThqZem
	LUEMeZ53KUf+paDuvKgt6pw86nsopGziid+pApr5I0Ts71eJ2FLY5tmmldwYI+o6
X-Gm-Gg: ASbGncvZfUnXahih5taiBkx5Fu9yTSqfJq3aWi8E5h0IW+Drr5nHAwOWm1IWbH579uj
	HHOJLIABKyJHzNoV0Ph14xt8kvW+irYnTcf3Y+5NHITx+qvexJycksZzvssq3Nv/TZGl1mti/Ur
	8IctmNZj0uTlCGpSDUtg11ub3EWoVYQYiukYoRNHzwukUzdI8KaOrSW0VEA+9nncnZVv2Wh1Kht
	WMWi88Mu7692xDvubBWYTDta5TuWADNqD2j0t/t3z4sPaQwP7PnPFVRAZkdmGUR+LWMmpwSTZL6
	MzPFg8eN2P/Phh5En//bmlHVyB8oCs/BwlDVdjYNUmk+SA==
X-Google-Smtp-Source: AGHT+IHKwPKWISZVJyWCFq7wQ9d7LDLYzRpWM2qWV9tAZAjCvVGS6gB9/IKvM6rOl/yLC91NQpRhIA==
X-Received: by 2002:a17:907:3d8c:b0:ade:4339:9358 with SMTP id a640c23a62f3a-ae34fd7223emr1693631466b.22.1751382252784;
        Tue, 01 Jul 2025 08:04:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:6747:3d30:531b:25db])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c013c2sm895472266b.102.2025.07.01.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:04:12 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 01 Jul 2025 17:03:30 +0200
Subject: [PATCH 4/4] for-each-ref: introduce a '--skip-until' option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-306-git-for-each-ref-pagination-v1-4-4f0ae7c0688f@gmail.com>
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
In-Reply-To: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12416;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=VKUjDgwe4sJMzskoPCR3+5zuc0yfYObEkMVI+OmWesY=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhj+Oh5qeSIBL7EqoPLnHyBy1qC8XFCa+I1y
 uIH1RpQi3V/SokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoY/joAAoJED7VnySO
 Rox/CiIL/3iTGbxCPxrtL0RNE1RNZ+aY6N8aahcIYWUJ5LRSuZqQd1pwvY76H8a455Vudji/ZN+
 AYRaIC6GjqgNp947E3rCCaUAvURLZwYyi/OaEf2GgWvd+ZbHttegGyLWcQiDQpitrwAEs+ZJ8Xb
 IuLpxJBlNQLZ/0974caMe+j6gAwi06yg+V1f+L6wMgx9Ysfnq6U7Lnlr9GwKcXkydGO6IXnFhHw
 0Sz+OfVul6IzLA/KcyMdsXLFD8HkeIy7fexgT4dEhC0thVSmnKf/P6bNQ2MkrOO+KRimo9zSt4P
 yyAsrF0rlo4yxLQHTjRXh4Yns0HF1HKTcCiDtT7qE2evyxpGmSqkS8DKBtB1qnapJH8C055D/tK
 766hrrOCnGN2No7F0o3FfMaVsZKGN2SXi+7dBGFjwFXe0y6Z8QMToicLRz1bD7Dj5a51Iv2VY63
 8E+jYna7txI6xiSSdEbw4u93o0lTlykT/vgVYzc3CAKaVzLLT+ylH5j5X+mVp1wGFALGOrQ9yB7
 hw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git-for-each-ref(1)` command is used to iterate over references
present in a repository. In large repositories with millions of
references, it would be optimal to paginate this output such that we
can start iteration from a given reference. This would avoid having to
iterate over all references from the beginning each time when paginating
through results.

The previous commit added 'seek' functionality to the reference
backends. Utilize this and expose a '--skip-until' option in
'git-for-each-ref(1)'. When used, the reference iteration seeks to the
first matching reference and iterates from there onward.

This enables efficient pagination workflows like:
    git for-each-ref --count=100
    git for-each-ref --count=100 --skip-until=refs/heads/branch-100
    git for-each-ref --count=100 --skip-until=refs/heads/branch-200

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.adoc |   6 +-
 builtin/for-each-ref.c              |   5 +
 ref-filter.c                        |  57 ++++++++----
 ref-filter.h                        |   1 +
 t/t6302-for-each-ref-filter.sh      | 180 ++++++++++++++++++++++++++++++++++++
 5 files changed, 230 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 5ef89fc0fe..4bf7c66b8c 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -14,7 +14,7 @@ SYNOPSIS
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
 		   [--contains[=<object>]] [--no-contains[=<object>]]
-		   [--exclude=<pattern> ...]
+		   [--exclude=<pattern> ...] [--skip-until=<pattern>]
 
 DESCRIPTION
 -----------
@@ -108,6 +108,10 @@ TAB %(refname)`.
 --include-root-refs::
 	List root refs (HEAD and pseudorefs) apart from regular refs.
 
+--skip-until::
+    Skip references up to the specified pattern. Cannot be used with
+    general pattern matching.
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3d2207ec77..543013cd11 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -13,6 +13,7 @@ static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [--points-at <object>]"),
 	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
 	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
+	N_("git for-each-ref [--skip-until <pattern>]"),
 	NULL
 };
 
@@ -44,6 +45,7 @@ int cmd_for_each_ref(int argc,
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &format.array_opts.max_count, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT_STRING(  0 , "skip-until", &filter.seek, N_("skip-until"), N_("skip references until")),
 		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_REF_FILTER_EXCLUDE(&filter),
 		OPT_REF_SORT(&sorting_options),
@@ -100,6 +102,9 @@ int cmd_for_each_ref(int argc,
 		filter.name_patterns = argv;
 	}
 
+	if (filter.seek && filter.name_patterns && filter.name_patterns[0])
+		die(_("cannot use --skip-until with patterns"));
+
 	if (include_root_refs)
 		flags |= FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;
 
diff --git a/ref-filter.c b/ref-filter.c
index 7a274633cf..9d0255d5db 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2692,10 +2692,13 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
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
@@ -2704,8 +2707,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						"", NULL, cb, cb_data);
+		goto non_prefix_iter;
 	}
 
 	if (filter->ignore_case) {
@@ -2714,20 +2716,28 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
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
+	if (filter->seek)
+		ret = ref_iterator_seek(iter, filter->seek, 0);
+	if (ret)
+		return ret;
+
+	return do_for_each_ref_iterator(iter, cb, cb_data);
 }
 
 /*
@@ -3200,6 +3210,8 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 	if (!filter->kind)
 		die("filter_refs: invalid type");
 	else {
+		const char *prefix = NULL;
+
 		/*
 		 * For common cases where we need only branches or remotes or tags,
 		 * we only iterate through those refs. If a mix of refs is needed,
@@ -3207,19 +3219,28 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
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
+			if (filter->seek)
+				ret = ref_iterator_seek(iter, filter->seek, 0);
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
index c98c4fbd4c..9e97c65bc2 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -64,6 +64,7 @@ struct ref_array {
 
 struct ref_filter {
 	const char **name_patterns;
+	const char *seek;
 	struct strvec exclude;
 	struct oid_array points_at;
 	struct commit_list *with_commit;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index bb02b86c16..af2c60a2ce 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -541,4 +541,184 @@ test_expect_success 'validate worktree atom' '
 	test_cmp expect actual
 '
 
+test_expect_success 'skip until with empty value' '
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
+	git for-each-ref --format="%(refname)" --skip-until="" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until to a specific reference' '
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
+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until to a specific reference with partial match' '
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
+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/sp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until just behind a specific reference' '
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
+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/parrot >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until to specific directory' '
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
+	git for-each-ref --format="%(refname)" --skip-until=refs/odd >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until to specific directory with trailing slash' '
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
+	git for-each-ref --format="%(refname)" --skip-until=refs/lost >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until just behind a specific directory' '
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
+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/ >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until overflow specific reference length' '
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
+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/spotnew >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until overflow specific reference path' '
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
+	git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot/new >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until used with a pattern' '
+	cat >expect <<-\EOF &&
+	fatal: cannot use --skip-until with patterns
+	EOF
+	test_must_fail git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot refs/tags  2>actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.49.0

