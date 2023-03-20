Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE35C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 11:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjCTL1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjCTL12 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 07:27:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94A3A8C
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i10-20020a05600c354a00b003ee0da1132eso665167wmq.4
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 04:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679311623;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/24v3yocMGxJmoI88bw0WqppXDMMlpa5w8iATzLQke0=;
        b=kFNBbFHpq1nHdRlVSkLW64YcLxEBxgoOJfd79GON6vjF3L3w95BHOWA/H2HLcXGicU
         C2ujNYTQx7d3s76iGoYz6TD4pwPwnvMZRe/z/3+QnS/OW9fvkm4nYsu5uSwOYOkzUInN
         /D15GKD2frG1RDFCYOsioekxwjSceiNaXaIqkKP1gLzwXLJLkQcffmskbkR20Z78mCjJ
         EZc0CI7mPvsf0cBibpuaBxWZTeVDFyGf7cSTWoWc3YhreGYULsyvXd9Rmm07McVwt+hK
         oi3FyhCUI8rb3LaeBi+JhjWyMrbF5wJ5ocPuWINTYQU8h+bZ4joyMWwACx5codISc0jJ
         geEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311623;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/24v3yocMGxJmoI88bw0WqppXDMMlpa5w8iATzLQke0=;
        b=EgYUEmTbaukGtGjm07AOgM/cdVN0/bVDMYpl9ccXbWihrEMfcH5/S6kybmlqsSyTmW
         herO1YsN8rbqh1GMtHuMWnpxuxUPa3MjTm/B1PM7RDCJgXv0OKJmQrirJr3MD6N9kOEE
         EOcROd/axkEnMPaKYGstN1yRXnaT2DRfBZH6+O38kWlW/kXDb/WgfZWQ3Kqh0i+erme4
         bnKMvEPxcdjH4jhcdGyL2Xual6uhPoMIr9sDjyD76tdhvK9DKGd1/Av59rNJWrrSSjVb
         XH4aUUoL05ERAKp8vKVUEGVbKIYLDwg3swOjIbrIvlrVqKbeCpEKD4N7FDYdGBtm0vc+
         2Nbg==
X-Gm-Message-State: AO0yUKXzu4aVqmvtY7LLEAe3RkqPUhEXUySNpQaUUbmyOyklZBpYiCrl
        83NamaH2dTy7bl0EIc3CRbHdfvGtPYU=
X-Google-Smtp-Source: AK7set+RtlLYW7azOdMXhU3LqAl61OYgL3NE8ON40+64fbYIN7HKHLwfCe0cnK+TS3RVc4gbN5d2Dg==
X-Received: by 2002:a05:600c:4f01:b0:3ed:31cf:fe6e with SMTP id l1-20020a05600c4f0100b003ed31cffe6emr15753588wmq.41.1679311623174;
        Mon, 20 Mar 2023 04:27:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b002be505ab59asm8631810wrx.97.2023.03.20.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 04:27:02 -0700 (PDT)
Message-Id: <b8523e2be0bf78a782ee3b8591b4b40d4372259d.1679311616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
References: <pull.1489.v3.git.1678902343.gitgitgadget@gmail.com>
        <pull.1489.v4.git.1679311615.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Mar 2023 11:26:54 +0000
Subject: [PATCH v4 8/9] for-each-ref: add ahead-behind format atom
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change implemented the ahead_behind() method, including an
algorithm to compute the ahead/behind values for a number of commit tips
relative to a number of commit bases. Now, integrate that algorithm as
part of 'git for-each-ref' hidden behind a new format atom,
ahead-behind. This naturally extends to 'git branch' and 'git tag'
builtins, as well.

This format allows specifying multiple bases, if so desired, and all
matching references are compared against all of those bases. For this
reason, failing to read a reference provided from these atoms results in
an error.

In order to translate the ahead_behind() method information to the
format output code in ref-filter.c, we must populate arrays of
ahead_behind_count structs. In struct ref_array, we store the full array
that will be passed to ahead_behind(). In struct ref_array_item, we
store an array of pointers that point to the relvant items within the
full array. In this way, we can pull all relevant ahead/behind values
directly when formatting output for a specific item. It also ensures the
lifetime of the ahead_behind_count structs matches the time that the
array is being used.

Add specific tests of the ahead/behind counts in t6600-test-reach.sh, as
it has an interesting repository shape. In particular, its merging
strategy and its use of different commit-graphs would demonstrate over-
counting if the ahead_behind() method did not already account for that
possibility.

Also add tests for the specific for-each-ref, branch, and tag builtins.
In the case of 'git tag', there are intersting cases that happen when
some of the selected tips are not commits. This requires careful logic
around commits_nr in the second loop of filter_ahead_behind(). Also, the
test in t7004 is carefully located to avoid being dependent on the GPG
prereq. It also avoids using the test_commit helper, as that will add
ticks to the time and disrupt the expected timestamps in later tag
tests.

Also add performance tests in a new p1300-graph-walks.sh script. This
will be useful for more uses in the future, but for now compare the
ahead-behind counting algorithm in 'git for-each-ref' to the naive
implementation by running 'git rev-list --count' processes for each
input.

For the Git source code repository, the improvement is already obvious:

Test                                            this tree
---------------------------------------------------------------
1500.2: ahead-behind counts: git for-each-ref   0.07(0.07+0.00)
1500.3: ahead-behind counts: git branch         0.07(0.06+0.00)
1500.4: ahead-behind counts: git tag            0.07(0.06+0.00)
1500.5: ahead-behind counts: git rev-list       1.32(1.04+0.27)

But the standard performance benchmark is the Linux kernel repository,
which demosntrates a significant improvement:

Test                                            this tree
---------------------------------------------------------------
1500.2: ahead-behind counts: git for-each-ref   0.27(0.24+0.02)
1500.3: ahead-behind counts: git branch         0.27(0.24+0.03)
1500.4: ahead-behind counts: git tag            0.28(0.27+0.01)
1500.5: ahead-behind counts: git rev-list       4.57(4.03+0.54)

The 'git rev-list' test exists in this change as a demonstration, but it
will be removed in the next change to avoid wasting time on this
comparison.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-for-each-ref.txt |  5 ++
 builtin/branch.c                   |  1 +
 builtin/for-each-ref.c             |  3 ++
 builtin/tag.c                      |  1 +
 ref-filter.c                       | 73 +++++++++++++++++++++++++
 ref-filter.h                       | 26 ++++++++-
 t/perf/p1500-graph-walks.sh        | 45 ++++++++++++++++
 t/t3203-branch-output.sh           | 14 +++++
 t/t6301-for-each-ref-errors.sh     | 14 +++++
 t/t6600-test-reach.sh              | 86 ++++++++++++++++++++++++++++++
 t/t7004-tag.sh                     | 28 ++++++++++
 11 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100755 t/perf/p1500-graph-walks.sh

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index ccdc2911bb9..0713e49b499 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -222,6 +222,11 @@ worktreepath::
 	out, if it is checked out in any linked worktree. Empty string
 	otherwise.
 
+ahead-behind:<committish>::
+	Two integers, separated by a space, demonstrating the number of
+	commits ahead and behind, respectively, when comparing the output
+	ref to the `<committish>` specified in the format.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb9..0554d7cebb3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -448,6 +448,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
 
+	filter_ahead_behind(the_repository, format, &array);
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 9df16cfb854..6b3d07ef409 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "ref-filter.h"
 #include "strvec.h"
+#include "commit-reach.h"
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
@@ -98,6 +99,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL);
+	filter_ahead_behind(the_repository, &format, &array);
+
 	ref_array_sort(sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
diff --git a/builtin/tag.c b/builtin/tag.c
index d428c45dc8d..1b3f49d7b4c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -66,6 +66,7 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
 	filter_refs(&array, filter, FILTER_REFS_TAGS);
+	filter_ahead_behind(the_repository, format, &array);
 	ref_array_sort(sorting, &array);
 
 	for (i = 0; i < array.nr; i++) {
diff --git a/ref-filter.c b/ref-filter.c
index f8203c6b052..62135f649ec 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -158,6 +158,7 @@ enum atom_type {
 	ATOM_THEN,
 	ATOM_ELSE,
 	ATOM_REST,
+	ATOM_AHEADBEHIND,
 };
 
 /*
@@ -586,6 +587,22 @@ static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
+static int ahead_behind_atom_parser(struct ref_format *format, struct used_atom *atom,
+				    const char *arg, struct strbuf *err)
+{
+	struct string_list_item *item;
+
+	if (!arg)
+		return strbuf_addf_ret(err, -1, _("expected format: %%(ahead-behind:<committish>)"));
+
+	item = string_list_append(&format->bases, arg);
+	item->util = lookup_commit_reference_by_name(arg);
+	if (!item->util)
+		die("failed to find '%s'", arg);
+
+	return 0;
+}
+
 static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
@@ -645,6 +662,7 @@ static struct {
 	[ATOM_THEN] = { "then", SOURCE_NONE },
 	[ATOM_ELSE] = { "else", SOURCE_NONE },
 	[ATOM_REST] = { "rest", SOURCE_NONE, FIELD_STR, rest_atom_parser },
+	[ATOM_AHEADBEHIND] = { "ahead-behind", SOURCE_OTHER, FIELD_STR, ahead_behind_atom_parser },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -1848,6 +1866,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	struct object *obj;
 	int i;
 	struct object_info empty = OBJECT_INFO_INIT;
+	int ahead_behind_atoms = 0;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
@@ -1978,6 +1997,16 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			continue;
+		} else if (atom_type == ATOM_AHEADBEHIND) {
+			if (ref->counts) {
+				const struct ahead_behind_count *count;
+				count = ref->counts[ahead_behind_atoms++];
+				v->s = xstrfmt("%d %d", count->ahead, count->behind);
+			} else {
+				/* Not a commit. */
+				v->s = xstrdup("");
+			}
+			continue;
 		} else
 			continue;
 
@@ -2328,6 +2357,7 @@ static void free_array_item(struct ref_array_item *item)
 			free((char *)item->value[i].s);
 		free(item->value);
 	}
+	free(item->counts);
 	free(item);
 }
 
@@ -2356,6 +2386,8 @@ void ref_array_clear(struct ref_array *array)
 		free_worktrees(ref_to_worktree_map.worktrees);
 		ref_to_worktree_map.worktrees = NULL;
 	}
+
+	FREE_AND_NULL(array->counts);
 }
 
 #define EXCLUDE_REACHED 0
@@ -2418,6 +2450,47 @@ static void reach_filter(struct ref_array *array,
 	free(to_clear);
 }
 
+void filter_ahead_behind(struct repository *r,
+			 struct ref_format *format,
+			 struct ref_array *array)
+{
+	struct commit **commits;
+	size_t commits_nr = format->bases.nr + array->nr;
+
+	if (!format->bases.nr || !array->nr)
+		return;
+
+	ALLOC_ARRAY(commits, commits_nr);
+	for (size_t i = 0; i < format->bases.nr; i++)
+		commits[i] = format->bases.items[i].util;
+
+	ALLOC_ARRAY(array->counts, st_mult(format->bases.nr, array->nr));
+
+	commits_nr = format->bases.nr;
+	array->counts_nr = 0;
+	for (size_t i = 0; i < array->nr; i++) {
+		const char *name = array->items[i]->refname;
+		commits[commits_nr] = lookup_commit_reference_by_name(name);
+
+		if (!commits[commits_nr])
+			continue;
+
+		CALLOC_ARRAY(array->items[i]->counts, format->bases.nr);
+		for (size_t j = 0; j < format->bases.nr; j++) {
+			struct ahead_behind_count *count;
+			count = &array->counts[array->counts_nr++];
+			count->tip_index = commits_nr;
+			count->base_index = j;
+
+			array->items[i]->counts[j] = count;
+		}
+		commits_nr++;
+	}
+
+	ahead_behind(r, commits, commits_nr, array->counts, array->counts_nr);
+	free(commits);
+}
+
 /*
  * API for filtering a set of refs. Based on the type of refs the user
  * has requested, we iterate through those refs and apply filters
diff --git a/ref-filter.h b/ref-filter.h
index aa0eea4ecf5..c9a11495177 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
+#include "string-list.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -24,6 +25,7 @@
 
 struct atom_value;
 struct ref_sorting;
+struct ahead_behind_count;
 
 enum ref_sorting_order {
 	REF_SORTING_REVERSE = 1<<0,
@@ -40,6 +42,8 @@ struct ref_array_item {
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
+	struct ahead_behind_count **counts;
+
 	char refname[FLEX_ARRAY];
 };
 
@@ -47,6 +51,9 @@ struct ref_array {
 	int nr, alloc;
 	struct ref_array_item **items;
 	struct rev_info *revs;
+
+	struct ahead_behind_count *counts;
+	size_t counts_nr;
 };
 
 struct ref_filter {
@@ -80,9 +87,15 @@ struct ref_format {
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+
+	/* List of bases for ahead-behind counts. */
+	struct string_list bases;
 };
 
-#define REF_FORMAT_INIT { .use_color = -1 }
+#define REF_FORMAT_INIT {             \
+	.use_color = -1,              \
+	.bases = STRING_LIST_INIT_DUP, \
+}
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
@@ -143,4 +156,15 @@ struct ref_array_item *ref_array_push(struct ref_array *array,
 				      const char *refname,
 				      const struct object_id *oid);
 
+/*
+ * If the provided format includes ahead-behind atoms, then compute the
+ * ahead-behind values for the array of filtered references. Must be
+ * called after filter_refs() but before outputting the formatted refs.
+ *
+ * If this is not called, then any ahead-behind atoms will be blank.
+ */
+void filter_ahead_behind(struct repository *r,
+			 struct ref_format *format,
+			 struct ref_array *array);
+
 #endif /*  REF_FILTER_H  */
diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
new file mode 100755
index 00000000000..439a448c2e6
--- /dev/null
+++ b/t/perf/p1500-graph-walks.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='Commit walk performance tests'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup' '
+	git for-each-ref --format="%(refname)" "refs/heads/*" "refs/tags/*" >allrefs &&
+	sort -r allrefs | head -n 50 >refs &&
+	for ref in $(cat refs)
+	do
+		git branch -f ref-$ref $ref &&
+		echo ref-$ref ||
+		return 1
+	done >branches &&
+	for ref in $(cat refs)
+	do
+		git tag -f tag-$ref $ref &&
+		echo tag-$ref ||
+		return 1
+	done >tags &&
+	git commit-graph write --reachable
+'
+
+test_perf 'ahead-behind counts: git for-each-ref' '
+	git for-each-ref --format="%(ahead-behind:HEAD)" --stdin <refs
+'
+
+test_perf 'ahead-behind counts: git branch' '
+	xargs git branch -l --format="%(ahead-behind:HEAD)" <branches
+'
+
+test_perf 'ahead-behind counts: git tag' '
+	xargs git tag -l --format="%(ahead-behind:HEAD)" <tags
+'
+
+test_perf 'ahead-behind counts: git rev-list' '
+	for r in $(cat refs)
+	do
+		git rev-list --count "HEAD..$r" || return 1
+	done
+'
+
+test_done
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index d34d77f8934..1c0f7ea24e7 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -337,6 +337,20 @@ test_expect_success 'git branch --format option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git branch --format with ahead-behind' '
+	cat >expect <<-\EOF &&
+	(HEAD detached from fromtag) 0 0
+	refs/heads/ambiguous 0 0
+	refs/heads/branch-one 1 0
+	refs/heads/branch-two 0 0
+	refs/heads/main 1 0
+	refs/heads/ref-to-branch 1 0
+	refs/heads/ref-to-remote 1 0
+	EOF
+	git branch --format="%(refname) %(ahead-behind:HEAD)" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch with --format=%(rest) must fail' '
 	test_must_fail git branch --format="%(rest)" >actual
 '
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index bfda1f46ad2..2667dd13fe3 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -54,4 +54,18 @@ test_expect_success 'Missing objects are reported correctly' '
 	test_must_be_empty brief-err
 '
 
+test_expect_success 'ahead-behind requires an argument' '
+	test_must_fail git for-each-ref \
+		--format="%(ahead-behind)" 2>err &&
+	echo "fatal: expected format: %(ahead-behind:<committish>)" >expect &&
+	test_cmp expect err
+'
+
+test_expect_success 'missing ahead-behind base' '
+	test_must_fail git for-each-ref \
+		--format="%(ahead-behind:refs/heads/missing)" 2>err &&
+	echo "fatal: failed to find '\''refs/heads/missing'\''" >expect &&
+	test_cmp expect err
+'
+
 test_done
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 338a9c46a24..0cb50797ef7 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -443,4 +443,90 @@ test_expect_success 'get_reachable_subset:none' '
 	test_all_modes get_reachable_subset
 '
 
+test_expect_success 'for-each-ref ahead-behind:linear' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-1-3
+	refs/heads/commit-1-5
+	refs/heads/commit-1-8
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1 0 8
+	refs/heads/commit-1-3 0 6
+	refs/heads/commit-1-5 0 4
+	refs/heads/commit-1-8 0 1
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname) %(ahead-behind:commit-1-9)" --stdin
+'
+
+test_expect_success 'for-each-ref ahead-behind:all' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-2-4
+	refs/heads/commit-4-2
+	refs/heads/commit-4-4
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1 0 24
+	refs/heads/commit-2-4 0 17
+	refs/heads/commit-4-2 0 17
+	refs/heads/commit-4-4 0 9
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname) %(ahead-behind:commit-5-5)" --stdin
+'
+
+test_expect_success 'for-each-ref ahead-behind:some' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-5-3
+	refs/heads/commit-4-8
+	refs/heads/commit-9-9
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1 0 53
+	refs/heads/commit-4-8 8 30
+	refs/heads/commit-5-3 0 39
+	refs/heads/commit-9-9 27 0
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname) %(ahead-behind:commit-9-6)" --stdin
+'
+
+test_expect_success 'for-each-ref ahead-behind:some, multibase' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-1-1
+	refs/heads/commit-5-3
+	refs/heads/commit-7-8
+	refs/heads/commit-4-8
+	refs/heads/commit-9-9
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-1-1 0 53 0 53
+	refs/heads/commit-4-8 8 30 0 22
+	refs/heads/commit-5-3 0 39 0 39
+	refs/heads/commit-7-8 14 12 8 6
+	refs/heads/commit-9-9 27 0 27 0
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname) %(ahead-behind:commit-9-6) %(ahead-behind:commit-6-9)" \
+		--stdin
+'
+
+test_expect_success 'for-each-ref ahead-behind:none' '
+	cat >input <<-\EOF &&
+	refs/heads/commit-7-5
+	refs/heads/commit-4-8
+	refs/heads/commit-9-9
+	EOF
+	cat >expect <<-\EOF &&
+	refs/heads/commit-4-8 16 16
+	refs/heads/commit-7-5 7 4
+	refs/heads/commit-9-9 49 0
+	EOF
+	run_all_modes git for-each-ref \
+		--format="%(refname) %(ahead-behind:commit-8-4)" --stdin
+'
+
 test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 9aa1660651b..04a4b44183d 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -792,6 +792,34 @@ test_expect_success 'annotations for blobs are empty' '
 	test_cmp expect actual
 '
 
+# Run this before doing any signing, so the test has the same results
+# regardless of the GPG prereq.
+test_expect_success 'git tag --format with ahead-behind' '
+	test_when_finished git reset --hard tag-one-line &&
+	git commit --allow-empty -m "left" &&
+	git tag -a -m left tag-left &&
+	git reset --hard HEAD~1 &&
+	git commit --allow-empty -m "right" &&
+	git tag -a -m left tag-right &&
+
+	# Use " !" at the end to demonstrate whitespace
+	# around empty ahead-behind token for tag-blob.
+	cat >expect <<-EOF &&
+	refs/tags/tag-blob  !
+	refs/tags/tag-left 1 1 !
+	refs/tags/tag-lines 0 1 !
+	refs/tags/tag-one-line 0 1 !
+	refs/tags/tag-right 0 0 !
+	refs/tags/tag-zero-lines 0 1 !
+	EOF
+	git tag -l --format="%(refname) %(ahead-behind:HEAD) !" >actual 2>err &&
+	grep "refs/tags/tag" actual >actual.focus &&
+	test_cmp expect actual.focus &&
+
+	# Error reported for tags that point to non-commits.
+	grep "error: object [0-9a-f]* is a blob, not a commit" err
+'
+
 # trying to verify annotated non-signed tags:
 
 test_expect_success GPG \
-- 
gitgitgadget

