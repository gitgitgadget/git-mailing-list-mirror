Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF314C581
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550234; cv=none; b=jwiUNUsdYqFXIcrQitG3+0+O6sAGWuApjG8w8ygI3ZkbsWv5EHv67IfL7zwtF9jEl9sy60w74nsFQlHm2x1UXSALbagZH/UpJB7SDa2amxWcIK+cz8g7XW79Ikq/1Ij5M9pOE/+ZWe5TZaWoQxYzpSTc52dj3Yepqrzr2vEUlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550234; c=relaxed/simple;
	bh=Vt3H32IemtxNNUBvkdsZob1QZ6eXxwCXLKk9THfB+bo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c41SFUtsjw71t66882D+Z7xfIYMXO8+g/ENvvS22bK2W2MQmB2y5Ali9CtWrypTQX+nSI44WYoxItAEkLZcZh4xrKRqY+wHimZc49gUNCTJJUWAk54O6R8bSZDKKbcBXyoqwvCLkyxZWhzAGK2KS8YSHpXCRtZq18laAbCG8ZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L86iYqcz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L86iYqcz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso50484085e9.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 15:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722550229; x=1723155029; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k0u6wbd0+NIsqEvViikE4OHcuI9PDNcFloMQf67GQE=;
        b=L86iYqcz2H6cvs+cq48/IC/hmdsE/Rs5Z3bbFyaij6MeONMLNkgg2lE2uD3f7Xx19t
         Q/23aMSoegrxPbs+rXHz38BTH4ilTAtIyKkLzZVGmvZ7kEfIK/8Vo9ubMNcPmLN2ukMJ
         iZk9cIVVJIYhjJ2x6YzKntnLeDw2UoSlrn6JynTGnbwtPiINDZ6eduIB478wwRRSq9YF
         w40FkeioCsUMpK8f+gNYWXEQyp5Va1GwjvbsVx/LLtcCPB06bXEedPlQoQ/2qvxKzKS6
         74cIwQ3f6nrR2e90AUMeUo3px3BKqoTchhHbCUhIJls/+FHPSw8mg6QHrr1iy4Dpf2RD
         SsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722550229; x=1723155029;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k0u6wbd0+NIsqEvViikE4OHcuI9PDNcFloMQf67GQE=;
        b=WdgnGejQ6e1yok2IwtLg8X2Slhb7eK1DFISGT5s9TmeS7v+9BIBm088qu0L8NTyhcK
         nk0v3ztAhPyslnf7LCTbbB47APCiGU0oPNFowyFxjDjK3GLCyi68zn8poWwjFueL5Vph
         iWXTcoNVz4Hg3xkXkiW5Y8qVZzAPB+HEcBm3O/GZoll1WWOizddhnLx7tqSff9Gpnl3/
         XTALvovqkMxDvasDstdBEW6MlnnJH/NDOoCB8ZnZP9rgKyqMM8YmuHbAi5mOl5dH5+Wm
         Vjc2wisyERoioZ2Q9VAdIwWZOlW6YAAiDWWBdey50gRm76Ni+qqnvvDX1ERHIXWrEe/z
         dSiA==
X-Gm-Message-State: AOJu0YxIZwNktclqc/6lBlJMW1t4cVvalCOiFt2hMVbOs59vgOO0e/1Z
	HKmSuuosQxAmt3ktwboWDZ+Gs19W3Lg42D6SsG1eVVC4X/V1+GFGNMZ+zA==
X-Google-Smtp-Source: AGHT+IFtitrvON+iN4RVAftb58W31mkWA5TlrL6Ln2opJ4wsjy7IoE21/vQkBc65oJ/8N2alu3GIyg==
X-Received: by 2002:a05:600c:4fcb:b0:426:647b:1bfa with SMTP id 5b1f17b1804b1-428e6aeaa8cmr9517855e9.8.1722550228929;
        Thu, 01 Aug 2024 15:10:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d648a0sm10112745e9.10.2024.08.01.15.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 15:10:28 -0700 (PDT)
Message-Id: <a1fbdca374fe665d3194187ff3ae7977693f01ad.1722550226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
References: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 22:10:25 +0000
Subject: [PATCH 2/3] for-each-ref: add 'is-base' token
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
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change introduced the get_branch_base_for_tip() method in
commit-reach.c. The motivation of that change was about using a heuristic to
deteremine the base branch for a source commit from a list of candidate
commit tips. This change makes that algorithm visible to users via a new
atom in the 'git for-each-ref' format. This change is very similar to the
chang in 49abcd21da6 (for-each-ref: add ahead-behind format atom,
2023-03-20).

Introduce the 'is-base:<source>' atom, which will indicate that the
algorithm should be computed and the result of the algorithm is reported
using an indicator of the form '(<source>)'. For example, using
'%(is-base:HEAD)' would result in one line having the token '(HEAD)'.

Use the sorted order of refs included in the ref filter to break ties in the
algorithm's heuristic. In the previous change, the motivating examples
include using an L0 trunk, long-lived L1 branches, and temporary release
branches. A caller could communicate the ordered preference among these
categories using the input refpecs and avoiding a different sort mechanism.
This sorting behavior is tested in the test scripts.

It is important to include this atom as a special case to
can_do_iterative_format() to match the expectations created in bd98f9774e1
(ref-filter.c: filter & format refs in the same callback, 2023-11-14). The
ahead-behind atom was one of the special cases, and this similarly requires
using an algorithm across all input refs before starting the format of any
single ref.

In the test script, the format tokens use colons or lack whitespace to avoid
Git complaining about trailing whitespace errors.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 ref-filter.c          | 78 ++++++++++++++++++++++++++++++++++++++++++-
 ref-filter.h          | 15 +++++++++
 t/t6600-test-reach.sh | 47 ++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 59ad6f54ddb..59689672da1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -167,6 +167,7 @@ enum atom_type {
 	ATOM_ELSE,
 	ATOM_REST,
 	ATOM_AHEADBEHIND,
+	ATOM_ISBASE,
 };
 
 /*
@@ -889,6 +890,23 @@ static int ahead_behind_atom_parser(struct ref_format *format,
 	return 0;
 }
 
+static int is_base_atom_parser(struct ref_format *format,
+			       struct used_atom *atom UNUSED,
+			       const char *arg, struct strbuf *err)
+{
+	struct string_list_item *item;
+
+	if (!arg)
+		return strbuf_addf_ret(err, -1, _("expected format: %%(is-base:<committish>)"));
+
+	item = string_list_append(&format->is_base_tips, arg);
+	item->util = lookup_commit_reference_by_name(arg);
+	if (!item->util)
+		die("failed to find '%s'", arg);
+
+	return 0;
+}
+
 static int head_atom_parser(struct ref_format *format UNUSED,
 			    struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
@@ -952,6 +970,7 @@ static struct {
 	[ATOM_ELSE] = { "else", SOURCE_NONE },
 	[ATOM_REST] = { "rest", SOURCE_NONE, FIELD_STR, rest_atom_parser },
 	[ATOM_AHEADBEHIND] = { "ahead-behind", SOURCE_OTHER, FIELD_STR, ahead_behind_atom_parser },
+	[ATOM_ISBASE] = { "is-base", SOURCE_OTHER, FIELD_STR, is_base_atom_parser },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -2334,6 +2353,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	int i;
 	struct object_info empty = OBJECT_INFO_INIT;
 	int ahead_behind_atoms = 0;
+	int is_base_atoms = 0;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
@@ -2475,6 +2495,16 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 				v->s = xstrdup("");
 			}
 			continue;
+		} else if (atom_type == ATOM_ISBASE) {
+			if (ref->is_base && ref->is_base[is_base_atoms]) {
+				v->s = xstrfmt("(%s)", ref->is_base[is_base_atoms]);
+				free(ref->is_base[is_base_atoms]);
+			} else {
+				/* Not a commit. */
+				v->s = xstrdup("");
+			}
+			is_base_atoms++;
+			continue;
 		} else
 			continue;
 
@@ -2876,6 +2906,7 @@ static void free_array_item(struct ref_array_item *item)
 		free(item->value);
 	}
 	free(item->counts);
+	free(item->is_base);
 	free(item);
 }
 
@@ -3040,6 +3071,49 @@ void filter_ahead_behind(struct repository *r,
 	free(commits);
 }
 
+void filter_is_base(struct repository *r,
+		    struct ref_format *format,
+		    struct ref_array *array)
+{
+	struct commit **bases;
+	size_t bases_nr = 0;
+	struct ref_array_item **back_index;
+
+	if (!format->is_base_tips.nr || !array->nr)
+		return;
+
+	CALLOC_ARRAY(back_index, array->nr);
+	CALLOC_ARRAY(bases, array->nr);
+
+	for (size_t i = 0; i < array->nr; i++) {
+		const char *name = array->items[i]->refname;
+		struct commit *c = lookup_commit_reference_by_name(name);
+
+		CALLOC_ARRAY(array->items[i]->is_base, format->is_base_tips.nr);
+
+		if (!c)
+			continue;
+
+		back_index[bases_nr] = array->items[i];
+		bases[bases_nr] = c;
+		bases_nr++;
+	}
+
+	for (size_t i = 0; i < format->is_base_tips.nr; i++) {
+		struct commit *tip = format->is_base_tips.items[i].util;
+		int base_index = get_branch_base_for_tip(r, tip, bases, bases_nr);
+
+		if (base_index < 0)
+			continue;
+
+		/* Store the string for use in output later. */
+		back_index[base_index]->is_base[i] = xstrdup(format->is_base_tips.items[i].string);
+	}
+
+	free(back_index);
+	free(bases);
+}
+
 static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref_fn fn, void *cb_data)
 {
 	int ret = 0;
@@ -3126,7 +3200,8 @@ static inline int can_do_iterative_format(struct ref_filter *filter,
 	return !(filter->reachable_from ||
 		 filter->unreachable_from ||
 		 sorting ||
-		 format->bases.nr);
+		 format->bases.nr ||
+		 format->is_base_tips.nr);
 }
 
 void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
@@ -3150,6 +3225,7 @@ void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
 		struct ref_array array = { 0 };
 		filter_refs(&array, filter, type);
 		filter_ahead_behind(the_repository, format, &array);
+		filter_is_base(the_repository, format, &array);
 		ref_array_sort(sorting, &array);
 		print_formatted_ref_array(&array, format);
 		ref_array_clear(&array);
diff --git a/ref-filter.h b/ref-filter.h
index 0ca28d2bba6..20419a56218 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -48,6 +48,7 @@ struct ref_array_item {
 	struct commit *commit;
 	struct atom_value *value;
 	struct ahead_behind_count **counts;
+	char **is_base;
 
 	char refname[FLEX_ARRAY];
 };
@@ -101,6 +102,9 @@ struct ref_format {
 	/* List of bases for ahead-behind counts. */
 	struct string_list bases;
 
+	/* List of bases for is-base indicators. */
+	struct string_list is_base_tips;
+
 	struct {
 		int max_count;
 		int omit_empty;
@@ -114,6 +118,7 @@ struct ref_format {
 #define REF_FORMAT_INIT {             \
 	.use_color = -1,              \
 	.bases = STRING_LIST_INIT_DUP, \
+	.is_base_tips = STRING_LIST_INIT_DUP, \
 }
 
 /*  Macros for checking --merged and --no-merged options */
@@ -203,6 +208,16 @@ void filter_ahead_behind(struct repository *r,
 			 struct ref_format *format,
 			 struct ref_array *array);
 
+/*
+ * If the provided format includes is-base atoms, then compute the base checks
+ * for those tips against all refs.
+ *
+ * If this is not called, then any is-base atoms will be blank.
+ */
+void filter_is_base(struct repository *r,
+		    struct ref_format *format,
+		    struct ref_array *array);
+
 void ref_filter_init(struct ref_filter *filter);
 void ref_filter_clear(struct ref_filter *filter);
 
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 3069efc8601..6c7f92bcb38 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -659,4 +659,51 @@ test_expect_success 'get_branch_base_for_tip: all reach tip' '
 	test_all_modes get_branch_base_for_tip
 '
 
+test_expect_success 'for-each-ref is-base: none reach' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1:
+	refs/heads/commit-4-2:(commit-2-3)
+	refs/heads/commit-4-4:
+	refs/heads/commit-8-4:
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname):%(is-base:commit-2-3)" --stdin
+'
+
+test_expect_success 'for-each-ref is-base: all reach' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-4-2
+	refs/heads/commit-5-1
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-4-2:(commit-4-1)
+	refs/heads/commit-5-1:
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname):%(is-base:commit-4-1)" --stdin
+'
+
+test_expect_success 'for-each-ref is-base:multiple' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	refs/heads/commit-8-4
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1[-]
+	refs/heads/commit-4-2[(commit-2-3)-]
+	refs/heads/commit-4-4[-]
+	refs/heads/commit-8-4[-(commit-6-5)]
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname)[%(is-base:commit-2-3)-%(is-base:commit-6-5)]" --stdin
+'
+
 test_done
-- 
gitgitgadget

