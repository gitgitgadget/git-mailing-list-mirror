Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B0C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 02:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiHQCsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 22:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbiHQCsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 22:48:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F015801
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:48:24 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n7so3464068wrv.4
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=6/FXS/ZuutTzBkfndxcajPggh0zEjXkaRAnGxs76yC0=;
        b=I5bLc1EsWH/oO15aG08JjSJ6g50CF0VW5MXy8tY4lXjJ4WMdFhVk3KBHMgT9YrWfIS
         Pvsoj+ZC21fML5+wddcXNUmIY7huA6jIOkYwNwnMyKo022Qwl+fv7W2eIFGOjmPoXp9g
         mhgVqPYMuM93HaPTbQIA4V+8M2UEL2PJAqZMIf+W3ZWl1cmPdao0qXLyreOTCYEN3yac
         6IJpJKn+GQzRrvkQGQ7jgFNmdE3xNhxceWOw29pq8vnAt+Lx/9sSUsnu5h+1TOG1W9Fe
         hE7MqR2/Xti+2srDxz+c6ZslWSpOVQib+OFj1YZPrynBGOVgkleDpH+q+54wWIsyb2xT
         kZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=6/FXS/ZuutTzBkfndxcajPggh0zEjXkaRAnGxs76yC0=;
        b=mB9KEFzN9kMh2bQYWxq/Xb82fOiYD+5uKXGeiPhEl0FNTZLArOAiQgFdvObjUurXHj
         S4ZXYrSzN4a/eG1D6kAy/jlBAnQL21w3U8If4j8hv9w2kznv9/X3ijqOlY93Deq8Akjd
         OhcqdjTTrlijFeumLm/R63tqk9KF+0j67NRQW0tcWv+u8aafFmPTh98+jr7CY8iel/is
         CAWMB1TUFa/rfXJ8hjBOI9XgNpBwejuaD+7Lg7ixtfnehXwOzZRFJIWPxtkbstFEqV3l
         7tnnFapZvctJQqpC7BTtANjQkGJDnr/0KO0MupdXIf6cALSti2kZo0e6XSDQbOMebNpG
         BzdA==
X-Gm-Message-State: ACgBeo1xa52RKrY2wLNwLxMH1homdedD08e7VKUdPBZXFzMi0NWyuQl4
        J6L5k3ctkVBYe5R9R4++AzGH2Vgy930=
X-Google-Smtp-Source: AA6agR4XhsP1UQTZg3Qc2gFLbk/et1UJqtShQLOsli+xBsu3Sa+SsMg7KVWDI7WO/sOgkdbDCoOCeg==
X-Received: by 2002:adf:fbc7:0:b0:220:6004:18ca with SMTP id d7-20020adffbc7000000b00220600418camr12700926wrs.632.1660704502275;
        Tue, 16 Aug 2022 19:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c2cd700b003a2e1883a27sm725879wmc.18.2022.08.16.19.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 19:48:21 -0700 (PDT)
Message-Id: <99287b67fd1c1e9fbceb4877738fb0aed722ec4a.1660704498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 02:48:18 +0000
Subject: [PATCH 2/2] revision: allow --ancestry-path to take an argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We have long allowed users to run e.g.
    git log --ancestry-path next..seen
which shows all commits which satisfy all three of these criteria:
  * are an ancestor of seen
  * are not an ancestor next
  * have next as an ancestor

This commit allows another variant:
    git log --ancestry-path=$TOPIC next..seen
which shows all commits which satisfy all of these criteria:
  * are an ancestor of seen
  * are not an ancestor of next
  * have $TOPIC in their ancestry-path
that last bullet can be defined as commits meeting any of these
criteria:
    * are an ancestor of $TOPIC
    * have $TOPIC as an ancestor
    * are $TOPIC

This also allows multiple --ancestry-path arguments, which can be
used to find commits with any of the given topics in their ancestry
path.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/rev-list-options.txt | 45 ++++++++++++----
 object.h                           |  2 +-
 revision.c                         | 83 ++++++++++++++++++++----------
 revision.h                         |  3 ++
 t/t6019-rev-list-ancestry-path.sh  | 47 ++++++++++++++++-
 5 files changed, 139 insertions(+), 41 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 2f85726745a..001e49cee55 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -389,12 +389,15 @@ Default mode::
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.
 
---ancestry-path::
+--ancestry-path[=<commit>]::
 	When given a range of commits to display (e.g. 'commit1..commit2'
-	or 'commit2 {caret}commit1'), only display commits that exist
-	directly on the ancestry chain between the 'commit1' and
-	'commit2', i.e. commits that are both descendants of 'commit1',
-	and ancestors of 'commit2'.
+	or 'commit2 {caret}commit1'), only display commits in that
+	range where <commit> is part of the ancestry chain.  By "part of
+	the ancestry chain", we mean including <commit> itself and
+	commits that are either ancestors or descendants of <commit>.
+	If no commit is specified, use 'commit1' (the excluded part of
+	the range) as <commit>.  Can be passed multiple times to look for
+	commits in the ancestry range of multiple commits.
 
 A more detailed explanation follows.
 
@@ -568,11 +571,10 @@ Note the major differences in `N`, `P`, and `Q` over `--full-history`:
 
 There is another simplification mode available:
 
---ancestry-path::
-	Limit the displayed commits to those directly on the ancestry
-	chain between the ``from'' and ``to'' commits in the given commit
-	range. I.e. only display commits that are ancestor of the ``to''
-	commit and descendants of the ``from'' commit.
+--ancestry-path[=<commit>]::
+	Limit the displayed commits to those containing <commit> in their
+	ancestry path.  I.e. only display <commit> and commits which have
+	<commit> as either a direct ancestor or descendant.
 +
 As an example use case, consider the following commit history:
 +
@@ -604,6 +606,29 @@ option does. Applied to the 'D..M' range, it results in:
 			       \
 				L--M
 -----------------------------------------------------------------------
++
+We can also use `--ancestry-path=D` instead of `--ancestry-path` which
+means the same thing when applied to the 'D..M' range but is just more
+explicit.
++
+If we instead are interested in a given topic within this range, and all
+commits affected by that topic, we may only want to view the subset of
+`D..M` which contain that topic in their ancestry path.  So, using
+`--ancestry-path=H D..M` for example would result in:
++
+-----------------------------------------------------------------------
+		E
+		 \
+		  G---H---I---J
+			       \
+				L--M
+-----------------------------------------------------------------------
++
+Whereas `--ancestry-path=K D..M` would result in
++
+-----------------------------------------------------------------------
+		K---------------L--M
+-----------------------------------------------------------------------
 
 Before discussing another option, `--show-pulls`, we need to
 create a new example history.
diff --git a/object.h b/object.h
index a2219464c2b..9caef89f1f0 100644
--- a/object.h
+++ b/object.h
@@ -59,7 +59,7 @@ struct object_array {
 
 /*
  * object flag allocation:
- * revision.h:               0---------10         15             23------26
+ * revision.h:               0---------10         15             23------27
  * fetch-pack.c:             01    67
  * negotiator/default.c:       2--5
  * walker.c:                 0-2
diff --git a/revision.c b/revision.c
index 0c6e26cd9c8..660f1dd1b9b 100644
--- a/revision.c
+++ b/revision.c
@@ -1105,7 +1105,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			   struct commit_list **list, struct prio_queue *queue)
 {
 	struct commit_list *parent = commit->parents;
-	unsigned left_flag;
+	unsigned left_flag, ancestry_flag;
 
 	if (commit->object.flags & ADDED)
 		return 0;
@@ -1161,6 +1161,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 		return 0;
 
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
+	ancestry_flag = (commit->object.flags & ANCESTRY_PATH);
 
 	for (parent = commit->parents; parent; parent = parent->next) {
 		struct commit *p = parent->item;
@@ -1181,6 +1182,8 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (!*slot)
 				*slot = *revision_sources_at(revs->sources, commit);
 		}
+		if (revs->ancestry_path)
+			p->object.flags |= ancestry_flag;
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
@@ -1304,13 +1307,20 @@ static int still_interesting(struct commit_list *src, timestamp_t date, int slop
 }
 
 /*
- * "rev-list --ancestry-path A..B" computes commits that are ancestors
+ * "rev-list --ancestry-path=C A..B" computes commits that are ancestors
  * of B but not ancestors of A but further limits the result to those
- * that are descendants of A.  This takes the list of bottom commits and
- * the result of "A..B" without --ancestry-path, and limits the latter
- * further to the ones that can reach one of the commits in "bottom".
+ * that have C in their ancestry path (i.e. are either ancestors of C,
+ * descendants of C, or are C).  If multiple --ancestry-path=$COMMITTISH
+ * arguments are supplied, we limit the result to those that have at
+ * least one of those COMMITTISH in their ancestry path. If
+ * --ancestry-path is specified with no commit, we use all bottom
+ * commits for C.
+ *
+ * Before this function is called, ancestors of C will have already been
+ * marked with ANCESTRY_PATH previously, so we just need to also mark
+ * the descendants here, then collect both sets of commits.
  */
-static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *list)
+static void limit_to_ancestry(struct commit_list *bottoms, struct commit_list *list)
 {
 	struct commit_list *p;
 	struct commit_list *rlist = NULL;
@@ -1323,7 +1333,7 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
 	for (p = list; p; p = p->next)
 		commit_list_insert(p->item, &rlist);
 
-	for (p = bottom; p; p = p->next)
+	for (p = bottoms; p; p = p->next)
 		p->item->object.flags |= TMP_MARK;
 
 	/*
@@ -1356,38 +1366,39 @@ static void limit_to_ancestry(struct commit_list *bottom, struct commit_list *li
 	 */
 
 	/*
-	 * The ones that are not marked with TMP_MARK are uninteresting
+	 * The ones that are not marked with either TMP_MARK or
+	 * ANCESTRY_PATH are uninteresting
 	 */
 	for (p = list; p; p = p->next) {
 		struct commit *c = p->item;
-		if (c->object.flags & TMP_MARK)
+		if (c->object.flags & (TMP_MARK | ANCESTRY_PATH))
 			continue;
 		c->object.flags |= UNINTERESTING;
 	}
 
-	/* We are done with the TMP_MARK */
+	/* We are done with TMP_MARK and ANCESTRY_PATH */
 	for (p = list; p; p = p->next)
-		p->item->object.flags &= ~TMP_MARK;
-	for (p = bottom; p; p = p->next)
-		p->item->object.flags &= ~TMP_MARK;
+		p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
+	for (p = bottoms; p; p = p->next)
+		p->item->object.flags &= ~(TMP_MARK | ANCESTRY_PATH);
 	free_commit_list(rlist);
 }
 
 /*
- * Before walking the history, keep the set of "negative" refs the
- * caller has asked to exclude.
+ * Before walking the history, add the set of "negative" refs the
+ * caller has asked to exclude to the bottom list.
  *
  * This is used to compute "rev-list --ancestry-path A..B", as we need
  * to filter the result of "A..B" further to the ones that can actually
  * reach A.
  */
-static struct commit_list *collect_bottom_commits(struct commit_list *list)
+static void collect_bottom_commits(struct commit_list *list,
+				   struct commit_list **bottom)
 {
-	struct commit_list *elem, *bottom = NULL;
+	struct commit_list *elem;
 	for (elem = list; elem; elem = elem->next)
 		if (elem->item->object.flags & BOTTOM)
-			commit_list_insert(elem->item, &bottom);
-	return bottom;
+			commit_list_insert(elem->item, bottom);
 }
 
 /* Assumes either left_only or right_only is set */
@@ -1414,12 +1425,12 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *original_list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
-	struct commit_list *bottom = NULL;
 	struct commit *interesting_cache = NULL;
 
-	if (revs->ancestry_path) {
-		bottom = collect_bottom_commits(original_list);
-		if (!bottom)
+	if (revs->ancestry_path_need_bottoms) {
+		collect_bottom_commits(original_list,
+				       &revs->ancestry_path_bottoms);
+		if (!revs->ancestry_path_bottoms)
 			die("--ancestry-path given but there are no bottom commits");
 	}
 
@@ -1464,9 +1475,8 @@ static int limit_list(struct rev_info *revs)
 	if (revs->left_only || revs->right_only)
 		limit_left_right(newlist, revs);
 
-	if (bottom)
-		limit_to_ancestry(bottom, newlist);
-	free_commit_list(bottom);
+	if (revs->ancestry_path)
+		limit_to_ancestry(revs->ancestry_path_bottoms, newlist);
 
 	/*
 	 * Check if any commits have become TREESAME by some of their parents
@@ -2213,7 +2223,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			       const struct setup_revision_opt* opt)
 {
 	const char *arg = argv[0];
-	const char *optarg;
+	const char *optarg = NULL;
 	int argcount;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
@@ -2280,10 +2290,26 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->first_parent_only = 1;
 	} else if (!strcmp(arg, "--exclude-first-parent-only")) {
 		revs->exclude_first_parent_only = 1;
-	} else if (!strcmp(arg, "--ancestry-path")) {
+	} else if (!strcmp(arg, "--ancestry-path") ||
+		   skip_prefix(arg, "--ancestry-path=", &optarg)) {
 		revs->ancestry_path = 1;
 		revs->simplify_history = 0;
 		revs->limited = 1;
+		if (optarg) {
+			struct commit *c;
+			struct object_id oid;
+			const char *msg = _("could not get commit for ancestry-path argument %s");
+
+			if (repo_get_oid_committish(revs->repo, optarg, &oid))
+				return error(msg, optarg);
+			get_reference(revs, optarg, &oid, ANCESTRY_PATH);
+			c = lookup_commit_reference(revs->repo, &oid);
+			if (!c)
+				return error(msg, optarg);
+			commit_list_insert(c, &revs->ancestry_path_bottoms);
+		} else {
+			revs->ancestry_path_need_bottoms = 1;
+		}
 	} else if (!strcmp(arg, "-g") || !strcmp(arg, "--walk-reflogs")) {
 		init_reflog_walk(&revs->reflog_info);
 	} else if (!strcmp(arg, "--default")) {
@@ -2991,6 +3017,7 @@ static void release_revisions_topo_walk_info(struct topo_walk_info *info);
 void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
+	free_commit_list(revs->ancestry_path_bottoms);
 	object_array_clear(&revs->pending);
 	object_array_clear(&revs->boundary_commits);
 	release_revisions_cmdline(&revs->cmdline);
diff --git a/revision.h b/revision.h
index e576845cdd1..d86241ad8fc 100644
--- a/revision.h
+++ b/revision.h
@@ -48,6 +48,7 @@
  */
 #define NOT_USER_GIVEN	(1u<<25)
 #define TRACK_LINEAR	(1u<<26)
+#define ANCESTRY_PATH	(1u<<27)
 #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PULL_MERGE)
 
 #define DECORATE_SHORT_REFS	1
@@ -164,6 +165,7 @@ struct rev_info {
 			cherry_mark:1,
 			bisect:1,
 			ancestry_path:1,
+			ancestry_path_need_bottoms:1,
 			first_parent_only:1,
 			exclude_first_parent_only:1,
 			line_level_traverse:1,
@@ -306,6 +308,7 @@ struct rev_info {
 	struct saved_parents *saved_parents_slab;
 
 	struct commit_list *previous_parents;
+	struct commit_list *ancestry_path_bottoms;
 	const char *break_bar;
 
 	struct revision_sources *sources;
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index af57a04b7ff..d3657737fa6 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -8,8 +8,13 @@ test_description='--ancestry-path'
 #   /                     \
 #  A-------K---------------L--M
 #
-#  D..M                 == E F G H I J K L M
-#  --ancestry-path D..M == E F H I J L M
+#  D..M                                     == E F G H I J K L M
+#  --ancestry-path                     D..M == E F   H I J   L M
+#  --ancestry-path=F                   D..M == E F       J   L M
+#  --ancestry-path=G                   D..M ==     G H I J   L M
+#  --ancestry-path=H                   D..M == E   G H I J   L M
+#  --ancestry-path=K                   D..M ==             K L M
+#  --ancestry-path=K --ancestry-path=F D..M == E F       J K L M
 #
 #  D..M -- M.t                 == M
 #  --ancestry-path D..M -- M.t == M
@@ -66,6 +71,44 @@ test_expect_success 'rev-list --ancestry-path D..M' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-list --ancestry-path=F D..M' '
+	test_write_lines E F J L M >expect &&
+	git rev-list --ancestry-path=F --format=%s D..M |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'rev-list --ancestry-path=G D..M' '
+	test_write_lines G H I J L M >expect &&
+	git rev-list --ancestry-path=G --format=%s D..M |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+test_expect_success 'rev-list --ancestry-path=H D..M' '
+	test_write_lines E G H I J L M >expect &&
+	git rev-list --ancestry-path=H --format=%s D..M |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --ancestry-path=K D..M' '
+	test_write_lines K L M >expect &&
+	git rev-list --ancestry-path=K --format=%s D..M |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rev-list --ancestry-path=F --ancestry-path=K D..M' '
+	test_write_lines E F J K L M >expect &&
+	git rev-list --ancestry-path=F --ancestry-path=K --format=%s D..M |
+	sed -e "/^commit /d" |
+	sort >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rev-list D..M -- M.t' '
 	echo M >expect &&
 	git rev-list --format=%s D..M -- M.t |
-- 
gitgitgadget
