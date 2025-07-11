Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6902EF9DF
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250731; cv=none; b=ST1o9d4xJ7SxGYPh7PBNHY4STe///BY2myd2DIhXB7tKw4/cl9XJ115gPOnlelVbYfBrg6Zw/dKEIcc27Mm8ucuky7klkGFnzTXEPTymKYcA1aeoOnZBaAGy4tvyyPFMV1e7X7TXMCjPJ7jDxmRT9mPzHnCc1jP+i5npOdby4CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250731; c=relaxed/simple;
	bh=Q8cdp+vuidbJ7PGCIfLVnWmU0LOxcuceVnHgZX3Bh3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELgkHSNs+kG+8aWqapovaRABNKRdCEjouZTopLpWHjJDH76LKlBck70gWkz13gOcefDVA2TzfIVIcXHqaz6cnhLC5wCX7uhdRkfmeMsVTCGVmW48PJnkCOE7O2yJK1Lisn04IkqzAsUUl1ZepZgs7O91xQVPj+NTXYJGtfAECMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fttGvWM3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fttGvWM3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so172005e9.2
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752250727; x=1752855527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFHVQoNlAax8Q3wO5OYYTqA90at3VFWLygfW7z0EmVA=;
        b=fttGvWM3e2mg+/OAuRT+fAJbgHAn0wCTPtEs9YuzGCY1fBzY8ASzqXv7B/AnqZ+9VC
         ItnsWO8A7QcE1nuSCEYuDkWrxYGHZX+7wM2FTCSk9LDjoBFp9NipMTtRDdrUT+5uhG+O
         OcqKbUCEEgYSihe2hAUvzGPqomdK9VTGP0mColxWMoAZG8zbWD+mNHUgGUHJEL4AtluA
         CpgB25xIVkCeNUEnf0Tk3r2+ovmEuT9gnEbRKGQxizWKfm4mIfWVn/vs8vHOW6Vjo3Dx
         qo6WN0vKBJDtndbdx/IutwqBq3OeEoHOraxGEMbFeHxFZDpR2hC0St3bHj8K9rFplCwD
         tOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752250727; x=1752855527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFHVQoNlAax8Q3wO5OYYTqA90at3VFWLygfW7z0EmVA=;
        b=iPNc1lD8kPFjREUni1yBe0HlK5Ny1SADJc0QTmAym1Tuo6q7Si++8l59VM6/eWJ9JL
         19lptGRtyzgyVZzxtMZXkXAC8XzzIOssUTmZO5Rbok6qAJx/ELKEMONUeyG1dEdwRPIh
         CcS24iYrzaLXPR9f+AuMVJaegCjHeclVNOZcygI1ehSvsnTK8i9WON52GerPMgNv4Xep
         nsjhZgE97uYW/UmyGHM0GAxGp5ZCf2yVeY/iQK+ofa+UktvQCd6zaTGjGujBucinA2Yi
         p95K71TDXNEeNOLn+vaVxanBrAvLQMefjuL5jecL3vjk7feY4UDSkuKD04l4dcyKfhPy
         o4zw==
X-Gm-Message-State: AOJu0Ywd5JcatAFDsp1rupcWY4l8IT/aTasXkRJYTICt81NkJO1Wu5Bl
	EW4g+KYs3NOKpNzmitCIlSE041tPb2hpiRuWOP5LyUqgp4f/cyzKVLUz
X-Gm-Gg: ASbGncv/Ut+H8JwPfq+vN8R1GTaZngz1b81qJcfLv0zCNj59qZSznDvpPdUNjPx5prM
	8ooJNDFe3KMDuUrPCI+o3QPrOCCDH3jD/MEm6xNAYJEFiFfqW6R7aNUQmLJ0wPSTkv2efmyJYhk
	GEJJ6EabXrALeHRnREcZ8O8CQbqBngDF3toAQHiGR5Bc7RIjOEdonFyOLzVZ65lf2JhbKUHdzHA
	s+z2EN1ag7t3/3tBd/Bz3dgKVz7MJ1H/AOhhjMjUiB6jsNRrtTr9u5/rT9bgTHxx+hgw1npNzb5
	MrR0584iV4us0cSU2Sjf9USEb5RhM0rFwtPZ/Ptx1BaTK3D5BQYNubClHRxUMd7dx1UwtCyarVL
	K79YNcQ==
X-Google-Smtp-Source: AGHT+IEWjsmqjBUCpSg/Iiqps16Rkx6MR2j0ZLahkcuXbFpz4uOnAK72UPyDYRrMku8+c71mqfxU6A==
X-Received: by 2002:adf:9c87:0:b0:3b3:9ca4:ac8e with SMTP id ffacd0b85a97d-3b5f18d2a80mr3009073f8f.44.1752250726789;
        Fri, 11 Jul 2025 09:18:46 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5049:80b7:8726:cf1e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd55b0e4sm51293955e9.39.2025.07.11.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:18:46 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 11 Jul 2025 18:18:40 +0200
Subject: [PATCH v4 4/4] for-each-ref: introduce a '--start-after' option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-306-git-for-each-ref-pagination-v4-4-ed3303ad5b89@gmail.com>
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
In-Reply-To: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15324;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=Q8cdp+vuidbJ7PGCIfLVnWmU0LOxcuceVnHgZX3Bh3U=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhxOWKn6SE41UvisEFQ/5r3xDreajtoHB7sY
 mPJyZFEcIGIlIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJocTliAAoJED7VnySO
 Rox/vIQL/RULUu8sa/e0Z3h78EsEoyT13k3+4Er5pSqzJFzf+T7zasChOArybufw8vPCmYlqDF4
 VpN0YO0DfNjX26zgqqgWU84OLhITh5AW8qQ9z6qB1d6EVfLIuJuU4sEm1Ii8FHo0pQCCXcE3taU
 678har0G7RMh+8A0RWbabxY93gSiS2rBmvltqAt818yV7JvDR/j8U18wiOhGjgDcO8VImiIsOUL
 SYCgRFjfp5L3RNu4OHoHW9pe/vS8EMjdU89pURZXBjnw6RUPuAtzG8mF5T3CNtQxVRq/FtoJDot
 M+ve81brZtVb1L7LMYukE+FwvD0nDwI2DyUfWG6O0EAgRhrqhi5bvkqXNDkPeiGyhVphV35/oQw
 xlETXqIyi+1ohBWSBPRR/C/vI+t01oz6TpDyKhb4TkwCIHSx6/E34o2xzvwUR3cpExiQ3SYgWwF
 tHRb68BREnqpqC0ITNtruF3t2J5F+LKfrCOzB9+wJNHf6rBNFbsYeEUIRSN4LgyfruqmZyh2QF5
 dw=
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

This enables efficient pagination workflows, where the calling script
can remember the last provided reference and use that as the starting
point for the next set of references:
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
 Documentation/git-for-each-ref.adoc |  10 +-
 builtin/for-each-ref.c              |   8 ++
 ref-filter.c                        |  80 +++++++++++----
 ref-filter.h                        |   1 +
 t/t6302-for-each-ref-filter.sh      | 194 ++++++++++++++++++++++++++++++++++++
 5 files changed, 272 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 5ef89fc0fe..ae61ba642a 100644
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
@@ -108,6 +108,14 @@ TAB %(refname)`.
 --include-root-refs::
 	List root refs (HEAD and pseudorefs) apart from regular refs.
 
+--start-after=<marker>::
+    Allows paginating the output by skipping references up to and including the
+    specified marker. When paging, it should be noted that references may be
+    deleted, modified or added between invocations. Output will only yield those
+    references which follow the marker lexicographically. Output begins from the
+    first reference that would come after the marker alphabetically. Cannot be
+    used with general pattern matching or custom sort options.
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

