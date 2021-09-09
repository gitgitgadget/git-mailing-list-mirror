Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5488C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF1661100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 18:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbhIISs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbhIISst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 14:48:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6DEC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 11:47:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y134-20020a25dc8c000000b0059f0301df0fso3522694ybe.21
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wnC8ZH7elaZ7Pnc3nqYiInbIDIgUNm86EluSqxmBEt0=;
        b=pnuiYs7r1p5pvsmrBCWqHh9K5NoQ0tLvrn3S+DKNMHDdmb+FgPvohUTSRJohUTvusA
         FgcckkJRmaAxCe+MXNLrTwm1RfPxXhUbtKYZ2NS4RmU3cR82t1XwWSK1RL1oNAdXIHQV
         tGyEBT3+gdhv4J56EdiGqtAPmyJ3tjyqec2TbvlGpd3sh9oKd3WFZN+3bssFhHlHfA5B
         Mji8gWGHA9LNVga7fMyzZCxWrObBWHdr66ETY7E3njNCKA8QKuHpSGthNTXkOyTWBJPh
         kEotsnzNsfpqQE+xl1him3JX97Z1VeTogrNdVys5y6lOY5x+uBivy717D6x1fq0j/bLk
         Xx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wnC8ZH7elaZ7Pnc3nqYiInbIDIgUNm86EluSqxmBEt0=;
        b=LSTwuT+IAJmhUnCpvQ6i0XmnOwn9PNJTHSf35cB2Mh2ec6+fqLxObIfQjxAl1vPZ57
         FBXMsQ3f6A5LUFm3enoFnqzNcb/c39Vos/LdCeFqLJ67xxWTM8QamyfUxkGII44kTjD8
         lJcmacmE/S9FD2g4DlA1cAJIJG9HtUtoJgvyfoKzBoAYS7wGJWlDEzCwKxhEegXiJbSC
         Mwe8Ied1X36hyIw8ALYOLxBcSqNGq5/ywcHMguI9S3/sJ2zibJsloij7+QnxVO6vRALp
         /ptECddBfgswmWZVAtz2Y6bmc3h+O0iHKvGUuYfUAiKb4xMa5NSRQPWnFOloTlPzIKzs
         Zvqg==
X-Gm-Message-State: AOAM533UAwcZvuxmtMNbJ6bw0NX2mzK0ZuZ/j6Al07Nq2Ho6QKBJktAQ
        Gu+BsbME89dw0VpnvbavunUqpk/goMum1fauNqusP8HV8S9ktw/DNGe1EELEwFrjpQleByY3oHI
        j593fa9ezkFp/U43JYjRHMFM3pYuugqhlwvNnzdZ0JX0+fPvDcAvztUVODoylHT9DKPg3IOI9CJ
        Gg
X-Google-Smtp-Source: ABdhPJxgDwVTo6/VHFUXpPS8/niNQVB1WCzTXPfS4bnWVO4jJ+mxHAd983xwSm9AeFoFZZf27igZwX96mptpM5trNwaY
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1148:: with SMTP id
 p8mr5696539ybu.319.1631213258257; Thu, 09 Sep 2021 11:47:38 -0700 (PDT)
Date:   Thu,  9 Sep 2021 11:47:29 -0700
In-Reply-To: <cover.1631212893.git.jonathantanmy@google.com>
Message-Id: <978174fdc25cdb7ee766a9e6a056145e127f52a4.1631212893.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1631123754.git.jonathantanmy@google.com> <cover.1631212893.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 3/3] revision: remove "submodule" from opt struct
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up a TODO in revision.h by removing the "submodule" field from
struct setup_revision_opt. This field is only used to specify the ref
store to use, so use rev_info->repo to determine the ref store instead.

The only users of this field are merge-ort.c and merge-recursive.c.
However, both these files specify the superproject as rev_info->repo and
the submodule as setup_revision_opt->submodule. In order to be able to
pass the submodule as rev_info->repo, all commits must be parsed with
the submodule explicitly specified; this patch does that as well. (An
incremental solution in which only some commits are parsed with explicit
submodule will not work, because if the same commit is parsed twice in
different repositories, there will be 2 heap-allocated object structs
corresponding to that commit, and any flag set by the revision walking
mechanism on one of them will not be reflected onto the other.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 merge-ort.c       | 53 +++++++++++++++++++++++++++++++----------------
 merge-recursive.c | 49 ++++++++++++++++++++++++++++---------------
 revision.c        | 16 +++++---------
 revision.h        |  1 -
 4 files changed, 72 insertions(+), 47 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6eb910d6f0..b8efaee8e0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -32,6 +32,7 @@
 #include "promisor-remote.h"
 #include "revision.h"
 #include "strmap.h"
+#include "submodule-config.h"
 #include "submodule.h"
 #include "tree.h"
 #include "unpack-trees.h"
@@ -1499,7 +1500,6 @@ static int find_first_merges(struct repository *repo,
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
 	repo_init_revisions(repo, &revs, NULL);
-	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
@@ -1509,7 +1509,7 @@ static int find_first_merges(struct repository *repo,
 		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object *o = &(commit->object);
-		if (in_merge_bases(b, commit))
+		if (repo_in_merge_bases(repo, b, commit))
 			add_object_array(o, NULL, &merges);
 	}
 	reset_revision_walk();
@@ -1524,7 +1524,7 @@ static int find_first_merges(struct repository *repo,
 		contains_another = 0;
 		for (j = 0; j < merges.nr; j++) {
 			struct commit *m2 = (struct commit *) merges.objects[j].item;
-			if (i != j && in_merge_bases(m2, m1)) {
+			if (i != j && repo_in_merge_bases(repo, m2, m1)) {
 				contains_another = 1;
 				break;
 			}
@@ -1545,10 +1545,12 @@ static int merge_submodule(struct merge_options *opt,
 			   const struct object_id *b,
 			   struct object_id *result)
 {
+	struct repository subrepo;
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
 	struct commit *commit_o, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
-	struct strbuf sb = STRBUF_INIT;
 
 	int i;
 	int search = !opt->priv->call_depth;
@@ -1564,6 +1566,10 @@ static int merge_submodule(struct merge_options *opt,
 	if (is_null_oid(b))
 		return 0;
 
+	/*
+	 * NEEDSWORK: Remove this when all submodule object accesses are
+	 * through explicitly specified repositores.
+	 */
 	if (add_submodule_odb(path)) {
 		path_msg(opt, path, 0,
 			 _("Failed to merge submodule %s (not checked out)"),
@@ -1571,39 +1577,48 @@ static int merge_submodule(struct merge_options *opt,
 		return 0;
 	}
 
-	if (!(commit_o = lookup_commit_reference(opt->repo, o)) ||
-	    !(commit_a = lookup_commit_reference(opt->repo, a)) ||
-	    !(commit_b = lookup_commit_reference(opt->repo, b))) {
+	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
+		path_msg(opt, path, 0,
+				_("Failed to merge submodule %s (not checked out)"),
+				path);
+		return 0;
+	}
+
+	if (!(commit_o = lookup_commit_reference(&subrepo, o)) ||
+	    !(commit_a = lookup_commit_reference(&subrepo, a)) ||
+	    !(commit_b = lookup_commit_reference(&subrepo, b))) {
 		path_msg(opt, path, 0,
 			 _("Failed to merge submodule %s (commits not present)"),
 			 path);
-		return 0;
+		goto cleanup;
 	}
 
 	/* check whether both changes are forward */
-	if (!in_merge_bases(commit_o, commit_a) ||
-	    !in_merge_bases(commit_o, commit_b)) {
+	if (!repo_in_merge_bases(&subrepo, commit_o, commit_a) ||
+	    !repo_in_merge_bases(&subrepo, commit_o, commit_b)) {
 		path_msg(opt, path, 0,
 			 _("Failed to merge submodule %s "
 			   "(commits don't follow merge-base)"),
 			 path);
-		return 0;
+		goto cleanup;
 	}
 
 	/* Case #1: a is contained in b or vice versa */
-	if (in_merge_bases(commit_a, commit_b)) {
+	if (repo_in_merge_bases(&subrepo, commit_a, commit_b)) {
 		oidcpy(result, b);
 		path_msg(opt, path, 1,
 			 _("Note: Fast-forwarding submodule %s to %s"),
 			 path, oid_to_hex(b));
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
-	if (in_merge_bases(commit_b, commit_a)) {
+	if (repo_in_merge_bases(&subrepo, commit_b, commit_a)) {
 		oidcpy(result, a);
 		path_msg(opt, path, 1,
 			 _("Note: Fast-forwarding submodule %s to %s"),
 			 path, oid_to_hex(a));
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
 	/*
@@ -1615,10 +1630,10 @@ static int merge_submodule(struct merge_options *opt,
 
 	/* Skip the search if makes no sense to the calling context.  */
 	if (!search)
-		return 0;
+		goto cleanup;
 
 	/* find commit which merges them */
-	parent_count = find_first_merges(opt->repo, path, commit_a, commit_b,
+	parent_count = find_first_merges(&subrepo, path, commit_a, commit_b,
 					 &merges);
 	switch (parent_count) {
 	case 0:
@@ -1652,7 +1667,9 @@ static int merge_submodule(struct merge_options *opt,
 	}
 
 	object_array_clear(&merges);
-	return 0;
+cleanup:
+	repo_clear(&subrepo);
+	return ret;
 }
 
 static void initialize_attr_index(struct merge_options *opt)
diff --git a/merge-recursive.c b/merge-recursive.c
index 3355d50e8a..fc8ac39d8c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -24,6 +24,7 @@
 #include "repository.h"
 #include "revision.h"
 #include "string-list.h"
+#include "submodule-config.h"
 #include "submodule.h"
 #include "tag.h"
 #include "tree-walk.h"
@@ -1113,7 +1114,6 @@ static int find_first_merges(struct repository *repo,
 	xsnprintf(merged_revision, sizeof(merged_revision), "^%s",
 		  oid_to_hex(&a->object.oid));
 	repo_init_revisions(repo, &revs, NULL);
-	rev_opts.submodule = path;
 	/* FIXME: can't handle linked worktrees in submodules yet */
 	revs.single_worktree = path != NULL;
 	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
@@ -1123,7 +1123,7 @@ static int find_first_merges(struct repository *repo,
 		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object *o = &(commit->object);
-		if (in_merge_bases(b, commit))
+		if (repo_in_merge_bases(repo, b, commit))
 			add_object_array(o, NULL, &merges);
 	}
 	reset_revision_walk();
@@ -1138,7 +1138,7 @@ static int find_first_merges(struct repository *repo,
 		contains_another = 0;
 		for (j = 0; j < merges.nr; j++) {
 			struct commit *m2 = (struct commit *) merges.objects[j].item;
-			if (i != j && in_merge_bases(m2, m1)) {
+			if (i != j && repo_in_merge_bases(repo, m2, m1)) {
 				contains_another = 1;
 				break;
 			}
@@ -1174,6 +1174,8 @@ static int merge_submodule(struct merge_options *opt,
 			   const struct object_id *base, const struct object_id *a,
 			   const struct object_id *b)
 {
+	struct repository subrepo;
+	int ret = 0;
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
@@ -1197,27 +1199,36 @@ static int merge_submodule(struct merge_options *opt,
 	if (is_null_oid(b))
 		return 0;
 
+	/*
+	 * NEEDSWORK: Remove this when all submodule object accesses are
+	 * through explicitly specified repositores.
+	 */
 	if (add_submodule_odb(path)) {
 		output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
 		return 0;
 	}
 
-	if (!(commit_base = lookup_commit_reference(opt->repo, base)) ||
-	    !(commit_a = lookup_commit_reference(opt->repo, a)) ||
-	    !(commit_b = lookup_commit_reference(opt->repo, b))) {
-		output(opt, 1, _("Failed to merge submodule %s (commits not present)"), path);
+	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
+		output(opt, 1, _("Failed to merge submodule %s (not checked out)"), path);
 		return 0;
 	}
 
+	if (!(commit_base = lookup_commit_reference(&subrepo, base)) ||
+	    !(commit_a = lookup_commit_reference(&subrepo, a)) ||
+	    !(commit_b = lookup_commit_reference(&subrepo, b))) {
+		output(opt, 1, _("Failed to merge submodule %s (commits not present)"), path);
+		goto cleanup;
+	}
+
 	/* check whether both changes are forward */
-	if (!in_merge_bases(commit_base, commit_a) ||
-	    !in_merge_bases(commit_base, commit_b)) {
+	if (!repo_in_merge_bases(&subrepo, commit_base, commit_a) ||
+	    !repo_in_merge_bases(&subrepo, commit_base, commit_b)) {
 		output(opt, 1, _("Failed to merge submodule %s (commits don't follow merge-base)"), path);
-		return 0;
+		goto cleanup;
 	}
 
 	/* Case #1: a is contained in b or vice versa */
-	if (in_merge_bases(commit_a, commit_b)) {
+	if (repo_in_merge_bases(&subrepo, commit_a, commit_b)) {
 		oidcpy(result, b);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
@@ -1227,9 +1238,10 @@ static int merge_submodule(struct merge_options *opt,
 		else
 			; /* no output */
 
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
-	if (in_merge_bases(commit_b, commit_a)) {
+	if (repo_in_merge_bases(&subrepo, commit_b, commit_a)) {
 		oidcpy(result, a);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
@@ -1239,7 +1251,8 @@ static int merge_submodule(struct merge_options *opt,
 		else
 			; /* no output */
 
-		return 1;
+		ret = 1;
+		goto cleanup;
 	}
 
 	/*
@@ -1251,10 +1264,10 @@ static int merge_submodule(struct merge_options *opt,
 
 	/* Skip the search if makes no sense to the calling context.  */
 	if (!search)
-		return 0;
+		goto cleanup;
 
 	/* find commit which merges them */
-	parent_count = find_first_merges(opt->repo, &merges, path,
+	parent_count = find_first_merges(&subrepo, &merges, path,
 					 commit_a, commit_b);
 	switch (parent_count) {
 	case 0:
@@ -1281,7 +1294,9 @@ static int merge_submodule(struct merge_options *opt,
 	}
 
 	object_array_clear(&merges);
-	return 0;
+cleanup:
+	repo_clear(&subrepo);
+	return ret;
 }
 
 static int merge_mode_and_contents(struct merge_options *opt,
diff --git a/revision.c b/revision.c
index cddd0542a6..31fc1884d2 100644
--- a/revision.c
+++ b/revision.c
@@ -2561,8 +2561,7 @@ static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void
 	return for_each_bisect_ref(refs, fn, cb_data, term_good);
 }
 
-static int handle_revision_pseudo_opt(const char *submodule,
-				      struct rev_info *revs,
+static int handle_revision_pseudo_opt(struct rev_info *revs,
 				      const char **argv, int *flags)
 {
 	const char *arg = argv[0];
@@ -2570,7 +2569,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	struct ref_store *refs;
 	int argcount;
 
-	if (submodule) {
+	if (revs->repo != the_repository) {
 		/*
 		 * We need some something like get_submodule_worktrees()
 		 * before we can go through all worktrees of a submodule,
@@ -2579,9 +2578,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		 */
 		if (!revs->single_worktree)
 			BUG("--single-worktree cannot be used together with submodule");
-		refs = get_submodule_ref_store(submodule);
-	} else
-		refs = get_main_ref_store(revs->repo);
+	}
+	refs = get_main_ref_store(revs->repo);
 
 	/*
 	 * NOTE!
@@ -2699,12 +2697,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 {
 	int i, flags, left, seen_dashdash, revarg_opt;
 	struct strvec prune_data = STRVEC_INIT;
-	const char *submodule = NULL;
 	int seen_end_of_options = 0;
 
-	if (opt)
-		submodule = opt->submodule;
-
 	/* First, search for "--" */
 	if (opt && opt->assume_dashdash) {
 		seen_dashdash = 1;
@@ -2733,7 +2727,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		if (!seen_end_of_options && *arg == '-') {
 			int opts;
 
-			opts = handle_revision_pseudo_opt(submodule,
+			opts = handle_revision_pseudo_opt(
 						revs, argv + i,
 						&flags);
 			if (opts > 0) {
diff --git a/revision.h b/revision.h
index fbb068da9f..d8e0e93026 100644
--- a/revision.h
+++ b/revision.h
@@ -339,7 +339,6 @@ extern volatile show_early_output_fn_t show_early_output;
 struct setup_revision_opt {
 	const char *def;
 	void (*tweak)(struct rev_info *, struct setup_revision_opt *);
-	const char *submodule;	/* TODO: drop this and use rev_info->repo */
 	unsigned int	assume_dashdash:1,
 			allow_exclude_promisor_objects:1;
 	unsigned revarg_opt;
-- 
2.33.0.309.g3052b89438-goog

