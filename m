Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0212D9EF8
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578921; cv=none; b=WU5rJgGetjdaAYIwbpDM56kQ4U+4JwDJBG8LrzgS4pOizwCQTJCfOZsAh8RA9h4i/cjHi0a9914ATfYVSwdZYNBNju7vbhtfoABWYzmhalQ0YecX4zX8UdhvaG1YhbSlMXBmhGieP+bPP2eg23+AZXH0trz/PQv7QfO7uEM3pG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578921; c=relaxed/simple;
	bh=2JZCcozWwcpvqJhdQGSnIMvPVlMmsbUDsTcIxjcdlaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XqU8y3ojABVewgHS4CTRP+LcJSwPSDX75NLXddTC5tw0VZL7bv6FEgXPtnrRX6TaBiuaT2GfXmrW+QyMrluXeO3I9PmDP2TrBlM55f1vPgaL1mhCWvBW5U2QXWwzgG0iFdZeM7IxmJakkZrobIEtLsEYHD0fKb8mAmSSay8KD20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTIuTBEz; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTIuTBEz"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so11074291a12.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 04:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578917; x=1753183717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bE5S2IuGLR64tQvky/C9LCQbsisDVgAZdjJwZAKmjpI=;
        b=GTIuTBEzEQPR8qt6xHTw5eZnT64IunxyN9oEGSByu5wINPgc+44Kcfq7sBnU7a/sMy
         PlCNLJx7bOhRJZ2M23Qj8MXSfQo6O7hDolYT3rGTf3MwL9sb/WYHjty8DXjBCO/2Kui6
         TjsnjJEq6XwhfHiW8CEftaVfwcQQMlZ5LKRSiBzF6aZOK+Antfl5qPA21mc6vG6Tkn5/
         oflH4gOJEZZlxN4u3C0JG3He4zihX6U4KCwxLp70TVFWf6sW+WXYYkOKQ0IZX9zM1lJE
         5NHH5lDBGc7VZilFeQ1XXMGzHe6+k60XaJVnLrX2340XW0Qo/eJdgpcnweuBjpquC2D/
         2ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578917; x=1753183717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bE5S2IuGLR64tQvky/C9LCQbsisDVgAZdjJwZAKmjpI=;
        b=Ww9iGDdtkugbyLlkafjHbsD8ORVifBjLtn/QuGYAaq5AbAA9DSlpg3iAHHSt6f8cYk
         5sDYmAfm3BPTe+U5baBof2baEGnH3FElG1ObmBKuSXQlUT3i5+xgb/QSt9FtDtpvsFts
         Vx9IWv35xNUBst1vrQMZtbOk7Pi+ArgEf5mt/Zn1adwpEukH6teF+jnUs19RJcSdyXO8
         dBWTafei08IqL/le+c7ho+xNvS7lYj1p536qKNXEMVphT+ZjuYBiZk/UQEf3z70knasr
         YV27IZqI1CiA/uxAh1wrO5yqobg+3Kzzho81tr17yt35HMitLj3a+w17b2Ah/cmxJKlq
         gbDw==
X-Gm-Message-State: AOJu0YySp7iwqXyOcpv+6v/hgWzikjiqf+cyKHra292WFjuJkgnHbToi
	QgniTDUnK4/z1+JenrLNV4wPYrn8oTa6KWaYfOVkO4cllXK98+q/08po
X-Gm-Gg: ASbGncsxEG/GvieLD3p7hmkXLEbLcHz5iiG+BlY01o9ANKLF7l6sqf3RShYZvwtgIHr
	3VbDZx/Dcds/vLrOrX3v85xnGyDlYrLrCabkQtarsEmhY1BnLysIhuBYXfZLEZT31gc9c6g+Ckr
	jIk1ZL2QfQxn1iARUfYO9CZsNNvPIcL/qTqfkqOhkqV6OFLNc5jEx+zFAuJI0HPwWYIebwkzpfN
	lFoTNLxjBjtGhcssEmDMjqcb96gP1/OUjTPw/VU+pSWoMHlOGjrtUX6wGnHjkxY9t38Xo9p4msj
	7eR4GwRNs52xfa6Hr6XQe86PKNXsWQwRW+Kvr1jKkViWbbyNtl705+m5liDuPXfFmjPO5Wg0RZL
	IUPn5
X-Google-Smtp-Source: AGHT+IHS/QT7hrt7INKy+BYzPelm26+ggJPJEWzDCpRDc4RuacQCXxUs4yVipWIoHhZ8JqV/iPqI/g==
X-Received: by 2002:a05:6402:5111:b0:60c:3c19:1e07 with SMTP id 4fb4d7f45d1cf-611e7c5e6e9mr15579811a12.15.1752578917284;
        Tue, 15 Jul 2025 04:28:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:624:7896:99ce:d9ca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c976dc62sm7206596a12.59.2025.07.15.04.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:28:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 15 Jul 2025 13:28:30 +0200
Subject: [PATCH v5 5/5] for-each-ref: introduce a '--start-after' option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-306-git-for-each-ref-pagination-v5-5-852d5a2f56e1@gmail.com>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
In-Reply-To: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im, 
 schwab@linux-m68k.org, phillip.wood123@gmail.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15162;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=2JZCcozWwcpvqJhdQGSnIMvPVlMmsbUDsTcIxjcdlaw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGh2O128JEKKkYk0GzIGWD2SGwfz83S6v03Hg
 AfOUYeeioVKLYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJodjtdAAoJED7VnySO
 Rox/7DIL/Ahp/gOfdU7kaqRd0PGWcypkQjivJo7aumOJLAjTI5rnfQXnfqMLz9b8Yq7kpfWFOyY
 VqhFfb76Nf4EWfzO6VRndp/g4+QO8xtxBUzghfgqDqO6XsbxLjjWZTe6+MtfDVzH2rHZpMZ0ryq
 I5eqVoIb/xkfqeI6Y9ursw0WFOyV2OpKCL4aZJcvUB8rFjimHyumE1DRmHi0KadElwrXCoJDyRI
 Cmuo4RDMUGiARLVLX0CQXBrT3TnSGSGakbjHdWb87Gr2o1U2NRMJR+RFNLk5+OOstDTS6J1GN40
 7hgoM/Wq3rpAe7RawtfxFnOjwky1v4zqDwV+s+Qqve9r4sz9vygFI9SUu8VZjyqZftUBWeu17j3
 1sAW7IsRoXtwYjvyqEJqSYb8li8j0m3yO3z0a5hOUPF/OmxFryMfUevkYbb8Royj+KfzAa8BXhh
 zf/smwUmztExDKESnB9tQV8jF6Bd9nXYhqqiqFbw2jaomnMpRcsecTx1yWe89HiFCH6QjeTMQ97
 Bs=
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
 ref-filter.c                        |  78 +++++++++++----
 ref-filter.h                        |   1 +
 t/t6302-for-each-ref-filter.sh      | 194 ++++++++++++++++++++++++++++++++++++
 5 files changed, 272 insertions(+), 19 deletions(-)

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
index da663c7ac8..c8a6b7f1af 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2683,6 +2683,41 @@ static int filter_exclude_match(struct ref_filter *filter, const char *refname)
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
+static int for_each_fullref_with_seek(struct ref_filter *filter, each_ref_fn cb,
+				       void *cb_data, unsigned int flags)
+{
+	struct ref_iterator *iter;
+	int ret = 0;
+
+	iter = refs_ref_iterator_begin(get_main_ref_store(the_repository), "",
+				       NULL, 0, flags);
+	if (filter->start_after)
+		ret = start_ref_iterator_after(iter, filter->start_after);
+
+	if (ret)
+		return ret;
+
+	return do_for_each_ref_iterator(iter, cb, cb_data);
+}
+
 /*
  * This is the same as for_each_fullref_in(), but it tries to iterate
  * only over the patterns we'll care about. Note that it _doesn't_ do a full
@@ -2694,8 +2729,8 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 {
 	if (filter->kind & FILTER_REFS_ROOT_REFS) {
 		/* In this case, we want to print all refs including root refs. */
-		return refs_for_each_include_root_refs(get_main_ref_store(the_repository),
-						       cb, cb_data);
+		return for_each_fullref_with_seek(filter, cb, cb_data,
+						  DO_FOR_EACH_INCLUDE_ROOT_REFS);
 	}
 
 	if (!filter->match_as_path) {
@@ -2704,8 +2739,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		 * prefixes like "refs/heads/" etc. are stripped off,
 		 * so we have to look at everything:
 		 */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						"", NULL, cb, cb_data);
+		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
 	if (filter->ignore_case) {
@@ -2714,14 +2748,12 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		 * so just return everything and let the caller
 		 * sort it out.
 		 */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						"", NULL, cb, cb_data);
+		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
 	if (!filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
-		return refs_for_each_fullref_in(get_main_ref_store(the_repository),
-						 "", filter->exclude.v, cb, cb_data);
+		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
 	return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_repository),
@@ -3189,6 +3221,7 @@ void filter_is_base(struct repository *r,
 
 static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref_fn fn, void *cb_data)
 {
+	const char *prefix = NULL;
 	int ret = 0;
 
 	filter->kind = type & FILTER_REFS_KIND_MASK;
@@ -3207,19 +3240,28 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 	 * of filter_ref_kind().
 	 */
 	if (filter->kind == FILTER_REFS_BRANCHES)
-		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-					       "refs/heads/", NULL,
-					       fn, cb_data);
+		prefix = "refs/heads/";
 	else if (filter->kind == FILTER_REFS_REMOTES)
-		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-					       "refs/remotes/", NULL,
-					       fn, cb_data);
+		prefix = "refs/remotes/";
 	else if (filter->kind == FILTER_REFS_TAGS)
-		ret = refs_for_each_fullref_in(get_main_ref_store(the_repository),
-					       "refs/tags/", NULL, fn,
-					       cb_data);
-	else if (filter->kind & FILTER_REFS_REGULAR)
+		prefix = "refs/tags/";
+
+	if (prefix) {
+		struct ref_iterator *iter;
+
+		iter = refs_ref_iterator_begin(get_main_ref_store(the_repository),
+					       "", NULL, 0, 0);
+
+		if (filter->start_after)
+			ret = start_ref_iterator_after(iter, filter->start_after);
+		else if (prefix)
+			ret = ref_iterator_seek(iter, prefix, 1);
+
+		if (!ret)
+			ret = do_for_each_ref_iterator(iter, fn, cb_data);
+	} else if (filter->kind & FILTER_REFS_REGULAR) {
 		ret = for_each_fullref_in_pattern(filter, fn, cb_data);
+	}
 
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
index bb02b86c16..e097db6b02 100755
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
+	git for-each-ref --format="%(refname)" --start-after=refs/odd/ >actual &&
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
+	git for-each-ref --format="%(refname)" --start-after=refs/lost >actual &&
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

