Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BD42F85FA
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751634173; cv=none; b=eyFhfYytzOH72Ru5NRAYR7Rn8X3zOiRltiZVpNSCFHdZ+0gOuJRO1AGhTV8T82Hhda3RYHWL/Fizdv97C+B0Z/dJHYpr9hyJRMjRXhXWtQo30IxVBjHau2co7zAsUcUf0cNsRdvv3VSHemElidKLshZYX1KrqWngrKraJmty6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751634173; c=relaxed/simple;
	bh=O2ydqJCaCI7Ydya+rO28hL6mIdQoVdiqq8N5lxW3WVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fcU29OOXL4/9SJik5zDQM5EwUiY94HIYJq5nptyDDROdT1Tfy95IK4eeCrK/IBM7zFKceUH6cyvnMWe9lhHYwja3NRycEv9O4dEW8DmamQwx5NCqB6Qx1wag0Iqzfwd1lGO7pGpxLLEo7LWzj70kNv8mIJBZZ3qDimRmsvu6ZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpQcacmT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpQcacmT"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso702919f8f.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751634168; x=1752238968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blag9YZvdLmZG/znOj8aVZjF9afspg5DBAS1//9hsHo=;
        b=hpQcacmTKnNUwZWBIhb73nncP4xthpxg8f048EojtXezOpCOgCgS2sf/LB9HoctYFZ
         15T0Jp2Tc6yYqR1iJ4HHyLIGsvOLxNIvIQqWvdsGbrdqiL6mbzGNSHJwd65gy+7sroMg
         3YwMN2BT46dYMtwuLhGHBNSUKYP70sqT5tV0PXA1bXI3WTBE8FapmMQHb0sUvNN5vktT
         tPJyZ/Ww9uwQrduElaiMeK37fBM/vD+AB+KWzR9sOvgPfBGYMlatigjv/c2CrzMJAJaf
         tkZzILzZ0V+FCEL9ME8tNRU0u3C1yRXuDXvs8ni+nuI3b5GaGmizf2V/cZPzhCBexRU9
         paOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751634168; x=1752238968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blag9YZvdLmZG/znOj8aVZjF9afspg5DBAS1//9hsHo=;
        b=ZmHOY/0WkQv8QQNkdVm8qRb2dLEdlLZqFcNDaBD+B1lHa9J5q0yeUjx2eUKOb5LXC+
         Twv9uUxA9rlS+/myGgi3xpDsc6sUThZT4XD4dhM7R3FwaYancKU56FCvDGgse68OXw6B
         u1bersi/TD1xE7NEpIzh7rVrXSDaFURjcBqh34i3GQSQ1GIvYUDcM4jqJTNHSijx7Qpq
         mnU2lNEn0WenxSF6HhtmAyHIEUnTycRh2S6xr9PTM02Y/bSVLN0/cKzd9s97XpN3Sb6k
         EtmRPM3HcPqdMWx3KmLe8ZZId8Lb3nP3kPef2LWJLAru+09j+J9jcypJo0mZGEg+sih8
         j7eg==
X-Gm-Message-State: AOJu0Yw16diIusswKQjnZgoSPYz925foZEZSaUhZP8Hdt8qV3JUatqPh
	Dw3nqjkaZICPp0tgAVBBrOcLPV3pUSLMp/T5sV1Rm9orBJp5YkR3k+/GK9uMTt4E
X-Gm-Gg: ASbGncuGLAIIy+AStPge46+zWhV9zfq5oAU449V07noxluJ4GgAIJbVtWzx07YJ2/Vn
	45EbBg5r2AOHnw4DaaYQIK4dFfiBAgJ+kH+mlB3dI2e/G+SmXOn1aIuQjoDRjiIGfgkWe6DCuXx
	dwBuNZZi44B4jg2PJaVvvGIBCw1VTpM8vwzdzFLbTPQvY6KWUxKFSeOxcdbCB24b3/FLAd7miwT
	KUPbc1RjIqk9tWwiXFdU1aBiGNb/cIeMhYJvlyNlUycRdiWeBlbq1vf3zYASAKGo4nMo1LsClO9
	3NiCtY8RVtYTZ9Y3AW1pojkqSuiZ8R3xTxQ9MsQ=
X-Google-Smtp-Source: AGHT+IHsH/YxJVJ4qxlL2HG++DIHwbWBFST8w0VKLuk5ihfLeKrnE4rqEevt8wm8hz3ls0C3uny6zg==
X-Received: by 2002:a05:6000:2006:b0:3a5:2cb5:63fd with SMTP id ffacd0b85a97d-3b49700c452mr1914232f8f.10.1751634168036;
        Fri, 04 Jul 2025 06:02:48 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030ba69sm2477687f8f.16.2025.07.04.06.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:02:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 04 Jul 2025 15:02:32 +0200
Subject: [PATCH v2 4/4] for-each-ref: introduce a '--skip-until' option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-306-git-for-each-ref-pagination-v2-4-bcde14acdd81@gmail.com>
References: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
In-Reply-To: <20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13283;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=O2ydqJCaCI7Ydya+rO28hL6mIdQoVdiqq8N5lxW3WVg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGhn0PNFDaNycX7Gnm5vYGGX06JQ74o4b5iiP
 mE+fAYL3c8Tk4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoZ9DzAAoJED7VnySO
 Rox/gPML/imdqjCdXiVzRc9P7KBQM/COOzKGrzNYJvHsQEFmEEP3iypcUglDoWsMzsf+BMsX1O4
 j0P8nBdtVtuORX0cHYSqJyXOPaHkfGCkv/v6v65jgPacgqOvyKy+ijqRAEbJT9tgupZ9yfd08TQ
 UEa4jZ9o7zrBt2hrwAuOvkj46b22DFn049boNC3uNtnUsT7d0gC1tuuV+VPLZLSupGDc0zLW1L9
 5/smjEEkXytfQHOngLtjnPsSAtHElJsDTHCjpQMtIQn0lAvJIGi050fTjiVWG/Xx0xto78hhTdX
 KO4orwKuT/R5WTaFpQaJR8P556d1b8JasXHLz2zHNJu37rI2gZ80emxERwgzD80JM2fYWdZDAY0
 GpCGNKiOgLOqVlCqtiZRstWrPnlB5WQL3DUvzUrpADt7Ow9HCz+lDmaKCEu9w4aXXQy8AC/AnpQ
 VX8q+Y500KPev9EGKuamdzXzyeg4tnqHisLvqTDno+pVIhLmca9LOIeEjQjAedt63qvohCRqcB4
 5U=
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
 builtin/for-each-ref.c              |   8 ++
 ref-filter.c                        |  61 ++++++++----
 ref-filter.h                        |   1 +
 t/t6302-for-each-ref-filter.sh      | 188 ++++++++++++++++++++++++++++++++++++
 5 files changed, 243 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 5ef89fc0fe..e369fee9a1 100644
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
+    Skip references up to but excluding the specified pattern. Cannot be used
+    with general pattern matching or custom sort options.
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3d2207ec77..aee2e7489a 100644
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
@@ -79,6 +81,9 @@ int cmd_for_each_ref(int argc,
 	if (verify_ref_format(&format))
 		usage_with_options(for_each_ref_usage, opts);
 
+	if (filter.seek && sorting_options.nr > 1)
+		die(_("cannot use --skip-until custom sort options"));
+
 	sorting = ref_sorting_options(&sorting_options);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
 	filter.ignore_case = icase;
@@ -100,6 +105,9 @@ int cmd_for_each_ref(int argc,
 		filter.name_patterns = argv;
 	}
 
+	if (filter.seek && filter.name_patterns && filter.name_patterns[0])
+		die(_("cannot use --skip-until with patterns"));
+
 	if (include_root_refs)
 		flags |= FILTER_REFS_ROOT_REFS | FILTER_REFS_DETACHED_HEAD;
 
diff --git a/ref-filter.c b/ref-filter.c
index 7a274633cf..56bb5312bd 100644
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
@@ -3197,9 +3207,11 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
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
index bb02b86c16..3f1823e95b 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -541,4 +541,192 @@ test_expect_success 'validate worktree atom' '
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
+	test_must_fail git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot refs/tags 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'skip until used with custom sort order' '
+	cat >expect <<-\EOF &&
+	fatal: cannot use --skip-until custom sort options
+	EOF
+	test_must_fail git for-each-ref --format="%(refname)" --skip-until=refs/odd/spot --sort=author 2>actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.49.0

