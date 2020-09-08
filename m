Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40955C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0518720768
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egbSMZDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbgIHTuU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbgIHPuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 11:50:46 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE2FC061362
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 08:38:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 19so10733568qtp.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 08:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=np0+At6oyHjrnLpCb3rxyiIKmlL3dZueBXmHrGWAiPA=;
        b=egbSMZDShKWqQzJ7+gU7932b5VIlb4GqTOEYVhq/JX9eT6tsRBXNVemZDSLSaMd0Hn
         WHUgjnaYdu11XerZssAtbeIWc0dyVNjcTL+a3hkEBwCqyp6GjJJVOIV6W+LksdWoOpLS
         a+iwXuUc/45hd9SjYHPGU7Et1GaUOnr1Hm9ML01z5Dv9jOpK/0A+vKhypOdxM9Q67Yyr
         /XbmHZ5T6V7neVXPWY5pXWjD5s9iY2rLPPzN8JoXwEwW1fH2wGxweCuBXmtIYltnUw1C
         nI6halqIFkGOaRrxwEaVfeanz0kbBeNeEBfUF1qCu2coJ6HMQC66gRi612Ur3PFCpN42
         f0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=np0+At6oyHjrnLpCb3rxyiIKmlL3dZueBXmHrGWAiPA=;
        b=Jn9a2PyyZmzKZ5J174WHuUEb4VQrnk1lBimQWWiuzq2LABG8/0XjlnxWTLEkG7J7kB
         uamxzz0x1/zjO92ejmOi1Zy+eoSRPMTHwlKrC5fu6eSQ30s7ES4O+FPVRWLnu3xpUMZ/
         4e93C3Xye3ylvLsIKjIybyLZAfNUDgAFWN7MGEMDEQTOs49FwI38bqA4RBTAE10O13MI
         0rS9osbOLYsF5A0IiY3p60+6ywxMcY9fHN2xsxdt0txdjag3TseEQ8BJjEDtToX1GdcJ
         L/jwmmr4r8nB1rCEkuoD4/ldEXli3+Dk/6vEKg4Nu5L9vs5sGFLyiq0FPgIF8oBx6TtV
         z0Bw==
X-Gm-Message-State: AOAM530SXDq69C+RjvkEoj1crASIp+sz4rpgJv1VBj6J6bYmxIKxWzUZ
        DL7u9hTo3ym1n1GFY7dWIOppXCHYwIZOKg==
X-Google-Smtp-Source: ABdhPJwHdQj8wRmWyE10eyfpuZHTEsi2PVZi78i8qiR85Sp+NnlNl9ih7Uu63wIB3viB/OORXp5aDQ==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr623267qti.81.1599579501699;
        Tue, 08 Sep 2020 08:38:21 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id d49sm15274286qtc.55.2020.09.08.08.38.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 08:38:20 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH] ref-filter: allow merged and no-merged filters
Date:   Tue,  8 Sep 2020 11:37:59 -0400
Message-Id: <20200908153759.36504-1-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enable ref-filter to process multiple merged and no-merged filters, and
extend functionality to git branch, git tag and git for-each-ref. This
provides an easy way to check for branches that are "graduation
candidates:"

$ git branch --no-merged master --merged next

To accomplish this, store the merged and no-merged filters in two
commit_list structs (reachable_from and unreachable_from) rather than
using a single commit struct (merge_commit).

If passed more than one merged (or more than one no-merged) filter,
mirror the existing boolean logic used by contains/no-contains filters:
refs must satisfy any of the merged filters, and all of the no-merged
filters.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
This functionality was originally proposed in 2013:
https://lore.kernel.org/git/87fvzwmp23.fsf@59A2.org/T/

In deciding how to handle multiple merged or multiple no-merged
filters, I mirrored the existing behavior for contains/no-contains
filters. However, I noticed this existing behavior isn't documented or
covered by tests. I think it makes sense to hold off on officially
documenting this behavior for now in case we wish to refine it later,
but I'm curious what others think.

If merging into next, please be sure to also include my previous
patch correcting tests in t3200:
https://lore.kernel.org/git/20200830224200.21103-1-alipman88@gmail.com

(Apologies, realizing I should have submitted both together.)


 Documentation/git-branch.txt       |  6 +--
 Documentation/git-for-each-ref.txt |  6 +--
 Documentation/git-tag.txt          |  4 +-
 builtin/branch.c                   |  4 +-
 builtin/tag.c                      |  6 +--
 ref-filter.c                       | 71 ++++++++++++++++--------------
 ref-filter.h                       |  9 +---
 t/t3200-branch.sh                  |  4 +-
 t/t3201-branch-contains.sh         | 12 +++++
 t/t6302-for-each-ref-filter.sh     |  4 +-
 t/t7004-tag.sh                     |  2 +-
 11 files changed, 68 insertions(+), 60 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 03c0824d52..8f0dbcd0ac 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -252,13 +252,11 @@ start-point is either a local or remote-tracking branch.
 
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
-	specified commit (HEAD if not specified). Implies `--list`,
-	incompatible with `--no-merged`.
+	specified commit (HEAD if not specified). Implies `--list`.
 
 --no-merged [<commit>]::
 	Only list branches whose tips are not reachable from the
-	specified commit (HEAD if not specified). Implies `--list`,
-	incompatible with `--merged`.
+	specified commit (HEAD if not specified). Implies `--list`.
 
 <branchname>::
 	The name of the branch to create or delete.
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ea71c5f6c..bb113da5a2 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -76,13 +76,11 @@ OPTIONS
 
 --merged[=<object>]::
 	Only list refs whose tips are reachable from the
-	specified commit (HEAD if not specified),
-	incompatible with `--no-merged`.
+	specified commit (HEAD if not specified).
 
 --no-merged[=<object>]::
 	Only list refs whose tips are not reachable from the
-	specified commit (HEAD if not specified),
-	incompatible with `--merged`.
+	specified commit (HEAD if not specified).
 
 --contains[=<object>]::
 	Only list refs which contain the specified commit (HEAD if not
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index f6d9791780..786d4dfd6f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -149,11 +149,11 @@ This option is only applicable when listing tags without annotation lines.
 
 --merged [<commit>]::
 	Only list tags whose commits are reachable from the specified
-	commit (`HEAD` if not specified), incompatible with `--no-merged`.
+	commit (`HEAD` if not specified).
 
 --no-merged [<commit>]::
 	Only list tags whose commits are not reachable from the specified
-	commit (`HEAD` if not specified), incompatible with `--merged`.
+	commit (`HEAD` if not specified).
 
 --points-at <object>::
 	Only list tags of the given object (HEAD if not
diff --git a/builtin/branch.c b/builtin/branch.c
index e82301fb1b..4bdb700dd5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -688,8 +688,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	    !show_current && !unset_upstream && argc == 0)
 		list = 1;
 
-	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
-	    filter.no_commit)
+	if (filter.with_commit || filter.no_commit ||
+	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
 		list = 1;
 
 	if (!!delete + !!rename + !!copy + !!new_upstream + !!show_current +
diff --git a/builtin/tag.c b/builtin/tag.c
index 5cbd80dc3e..b1a0398c85 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -457,8 +457,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		if (argc == 0)
 			cmdmode = 'l';
 		else if (filter.with_commit || filter.no_commit ||
-			 filter.points_at.nr || filter.merge_commit ||
-			 filter.lines != -1)
+			 filter.reachable_from || filter.unreachable_from ||
+			 filter.points_at.nr || filter.lines != -1)
 			cmdmode = 'l';
 	}
 
@@ -509,7 +509,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die(_("--no-contains option is only allowed in list mode"));
 	if (filter.points_at.nr)
 		die(_("--points-at option is only allowed in list mode"));
-	if (filter.merge_commit)
+	if (filter.reachable_from || filter.unreachable_from)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd')
 		return for_each_tag_name(argv, delete_tag, NULL);
diff --git a/ref-filter.c b/ref-filter.c
index 8ba0e31915..21dca5e68b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2119,9 +2119,9 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * obtain the commit using the 'oid' available and discard all
 	 * non-commits early. The actual filtering is done later.
 	 */
-	if (filter->merge_commit || filter->with_commit || filter->no_commit || filter->verbose) {
-		commit = lookup_commit_reference_gently(the_repository, oid,
-							1);
+	if (filter->reachable_from || filter->unreachable_from ||
+	    filter->with_commit || filter->no_commit || filter->verbose) {
+		commit = lookup_commit_reference_gently(the_repository, oid, 1);
 		if (!commit)
 			return 0;
 		/* We perform the filtering for the '--contains' option... */
@@ -2183,11 +2183,17 @@ void ref_array_clear(struct ref_array *array)
 	}
 }
 
-static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
+static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata, int reachable)
 {
+	struct commit_list *check_reachable_list = reachable ?
+		ref_cbdata->filter->reachable_from :
+		ref_cbdata->filter->unreachable_from;
+
+	if (!check_reachable_list)
+		return;
+
 	struct rev_info revs;
 	int i, old_nr;
-	struct ref_filter *filter = ref_cbdata->filter;
 	struct ref_array *array = ref_cbdata->array;
 	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
 
@@ -2199,12 +2205,15 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 		to_clear[i] = item->commit;
 	}
 
-	filter->merge_commit->object.flags |= UNINTERESTING;
-	add_pending_object(&revs, &filter->merge_commit->object, "");
+	for (struct commit_list *rl = check_reachable_list; rl; rl = rl->next) {
+		struct commit *merge_commit = rl->item;
+		merge_commit->object.flags |= UNINTERESTING;
+		add_pending_object(&revs, &merge_commit->object, "");
 
-	revs.limited = 1;
-	if (prepare_revision_walk(&revs))
-		die(_("revision walk setup failed"));
+		revs.limited = 1;
+		if (prepare_revision_walk(&revs))
+			die(_("revision walk setup failed"));
+	}
 
 	old_nr = array->nr;
 	array->nr = 0;
@@ -2215,14 +2224,19 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
 
 		int is_merged = !!(commit->object.flags & UNINTERESTING);
 
-		if (is_merged == (filter->merge == REF_FILTER_MERGED_INCLUDE))
+		if (is_merged == reachable)
 			array->items[array->nr++] = array->items[i];
 		else
 			free_array_item(item);
-	}
+  }
 
 	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
-	clear_commit_marks(filter->merge_commit, ALL_REV_FLAGS);
+
+	while (check_reachable_list) {
+		struct commit *merge_commit = pop_commit(&check_reachable_list);
+		clear_commit_marks(merge_commit, ALL_REV_FLAGS);
+	}
+
 	free(to_clear);
 }
 
@@ -2274,8 +2288,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	clear_contains_cache(&ref_cbdata.no_contains_cache);
 
 	/*  Filters that need revision walking */
-	if (filter->merge_commit)
-		do_merge_filter(&ref_cbdata);
+	do_merge_filter(&ref_cbdata, 1);
+	do_merge_filter(&ref_cbdata, 0);
 
 	return ret;
 }
@@ -2493,31 +2507,22 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
 {
 	struct ref_filter *rf = opt->value;
 	struct object_id oid;
-	int no_merged = starts_with(opt->long_name, "no");
 
 	BUG_ON_OPT_NEG(unset);
 
-	if (rf->merge) {
-		if (no_merged) {
-			return error(_("option `%s' is incompatible with --merged"),
-				     opt->long_name);
-		} else {
-			return error(_("option `%s' is incompatible with --no-merged"),
-				     opt->long_name);
-		}
-	}
-
-	rf->merge = no_merged
-		? REF_FILTER_MERGED_OMIT
-		: REF_FILTER_MERGED_INCLUDE;
-
 	if (get_oid(arg, &oid))
 		die(_("malformed object name %s"), arg);
 
-	rf->merge_commit = lookup_commit_reference_gently(the_repository,
-							  &oid, 0);
-	if (!rf->merge_commit)
+	struct commit *merge_commit = lookup_commit_reference_gently(the_repository,
+								     &oid, 0);
+
+	if (!merge_commit)
 		return error(_("option `%s' must point to a commit"), opt->long_name);
 
+	if (starts_with(opt->long_name, "no"))
+		commit_list_insert(merge_commit, &rf->unreachable_from);
+	else
+		commit_list_insert(merge_commit, &rf->reachable_from);
+
 	return 0;
 }
diff --git a/ref-filter.h b/ref-filter.h
index 8ecc33cdfa..feaef4a8fd 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -54,13 +54,8 @@ struct ref_filter {
 	struct oid_array points_at;
 	struct commit_list *with_commit;
 	struct commit_list *no_commit;
-
-	enum {
-		REF_FILTER_MERGED_NONE = 0,
-		REF_FILTER_MERGED_INCLUDE,
-		REF_FILTER_MERGED_OMIT
-	} merge;
-	struct commit *merge_commit;
+	struct commit_list *reachable_from;
+	struct commit_list *unreachable_from;
 
 	unsigned int with_commit_tag_algo : 1,
 		match_as_path : 1,
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 028c88d1b2..be8f61b751 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1299,8 +1299,8 @@ test_expect_success '--merged catches invalid object names' '
 	test_must_fail git branch --merged 0000000000000000000000000000000000000000
 '
 
-test_expect_success '--merged is incompatible with --no-merged' '
-	test_must_fail git branch --merged HEAD --no-merged HEAD
+test_expect_success '--merged is compatible with --no-merged' '
+	git branch --merged master --no-merged master
 '
 
 test_expect_success '--list during rebase' '
diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 40251c9f8f..6e73789995 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -211,4 +211,16 @@ test_expect_success 'branch --contains combined with --no-contains' '
 
 '
 
+test_expect_success 'branch --merged combined with --no-merged' '
+	git checkout master &&
+	git checkout -b next &&
+	git merge side &&
+	git branch --merged next --no-merged master >actual &&
+	cat >expect <<-\EOF &&
+	* next
+	  side
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 35408d53fd..781e470aea 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -437,8 +437,8 @@ test_expect_success 'check %(if:notequals=<string>)' '
 	test_cmp expect actual
 '
 
-test_expect_success '--merged is incompatible with --no-merged' '
-	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
+test_expect_success '--merged is compatible with --no-merged' '
+	git for-each-ref --merged HEAD --no-merged HEAD
 '
 
 test_expect_success 'validate worktree atom' '
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 74b637deb2..7d544eceda 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -2016,7 +2016,7 @@ test_expect_success '--merged can be used in non-list mode' '
 '
 
 test_expect_success '--merged is incompatible with --no-merged' '
-	test_must_fail git tag --merged HEAD --no-merged HEAD
+	git tag --merged HEAD --no-merged HEAD
 '
 
 test_expect_success '--merged shows merged tags' '
-- 
2.24.3 (Apple Git-128)

