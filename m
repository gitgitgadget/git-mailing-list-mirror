Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA24C433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655512067B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 16:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvz0ZgR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgFGQYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 12:24:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D95C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 09:24:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so4963049pjb.5
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a1i4QOlSI/UXwb5/uziApA8NYTvtu779e32arW2lBMA=;
        b=dvz0ZgR3fPBJFT9OINI3aVXTQaxkviSFgrtWJ7FPgDESf4AW0gB3+MLQxxe2M0xzDl
         67Gu3ZfMlDbkyr2BjF4N3jWVBsuz8t3P3VBLEHLtMoM1/CNJdsR29oqXDhvfz30bIM3G
         McH4z5mLGZLvq60LC4XOlfVbPs9nbSe6LeDzrzwlJ55uasEwvAfy+2D78c5u3Yhm4QUe
         Kw69wkczvZ1B+tIH94+tXwr59mOFfxOWRIWfg8NwEkbZOqQ1uc716GjQxp/Xx0NnCS1p
         NnC9fA+ns3Z7sOfkMZczwD5bNtxWusGId4MQnmXggoT2Fy3P+LwjZAMqSB1GW7VhBK6l
         GGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a1i4QOlSI/UXwb5/uziApA8NYTvtu779e32arW2lBMA=;
        b=sJNbBOIMyqySrQp3dc0ziFvfBguVeQAfr4jONUsF6C96WBMG6Jxns+jnynBf4y//Nu
         yMS1r9kzfmFXLYeRMwt9AnzSaDffbDcbuOjX9+mDydjcDIuOCT/s+HY2UvBLNKt5c6pD
         u2e8zQn4i7eW7u7z6TFlxY6KVijhWOBH8G9hZdqTt7uBpffD4V/zKTWiSiR2cWuxyRK/
         15flg9jEcDn2+qP/j8p19RgnEOuIULKZXZyrndMHVYx112btJsDZBFVVFHAl8nDJPOTG
         Bu2cd/gPfKR9DKJcoJWgS/s1bQ/+YUm9/6h5bYv2mJT4qhBaDQZidgx7tAYvxDqEKfzD
         9Eag==
X-Gm-Message-State: AOAM533pV3GbQFBn2B8heo4UZCB+vv3U8PUgRf6tB8TttzG/TFN1/lUV
        L1bubB1zL+tzsGXLjJSTzxg=
X-Google-Smtp-Source: ABdhPJyJs/QQyNMWJb2xKSRleiHM5THTXY0P4UGdA3kszMXFP35wu8Qbwqr3Gx9fwqG/I60xuflcSg==
X-Received: by 2002:a17:90a:c283:: with SMTP id f3mr12400448pjt.166.1591547087430;
        Sun, 07 Jun 2020 09:24:47 -0700 (PDT)
Received: from ?IPv6:2601:8c0:37f:6012:8c4b:deea:298c:b06f? ([2601:8c0:37f:6012:8c4b:deea:298c:b06f])
        by smtp.gmail.com with ESMTPSA id w124sm4718495pfc.213.2020.06.07.09.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 09:24:46 -0700 (PDT)
Subject: [PATCH 2/3] Teach git-rev-list --ignore-merge-bases
From:   Antonio Russo <antonio.e.russo@gmail.com>
To:     git-ml <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <456a1271-4f17-5503-5d13-d0c97115e2fd@gmail.com>
Message-ID: <a2cb2897-6632-1e99-3dbe-4d8c7d2f9b39@gmail.com>
Date:   Sun, 7 Jun 2020 10:24:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <456a1271-4f17-5503-5d13-d0c97115e2fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This new option simplifies the graph of commits for merges.  Edges to
commits reachable from more leftward parents, or more leftward parents
of recursive child commits, are removed.  This "skeleton" spanning tree
effectively omits all information about merge bases.

When multiple tip commits are specified, all commits reachable from each
tip commit (but not earlier tips) are simplified as above to form a
"component".  All edges between components are displayed.

When used with --graph, this amputation can dramatically reduce the
width of the displayed graph and the total time taken to draw all
output.

Signed-off-by: Antonio Russo <antonio.e.russo@gmail.com>
---
 Documentation/rev-list-options.txt |  13 ++
 builtin/log.c                      |   2 +-
 builtin/show-branch.c              |   2 +-
 commit.c                           | 132 +++++++++++++---
 commit.h                           |   4 +-
 graph.c                            |  40 +++--
 revision.c                         | 240 +++++++++++++++++++++++++++--
 revision.h                         |  17 ++
 8 files changed, 404 insertions(+), 46 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b01b2b6773..3470e710c8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -363,6 +363,19 @@ Default mode::
 	merges from the resulting history, as there are no selected
 	commits contributing to this merge.

+--ignore-merge-bases::
+	Simplify merges by removing edges to commits reachable from
+	more leftware parents, or more leftward parents of recursive
+	children. When used with `--graph`, this can help visualize
+	repositories with many merges when you are not interested in
+	the merge base used for each merge. It also reduces the width
+	of the graph visualization when used with `--graph`.
+
+	When multiple tip commits are specified, all commits reachable
+	from each tip commit (but not earlier tips) are simplified as
+	above to form a "component".  All edges between components are
+	displayed.
+
 --ancestry-path::
 	When given a range of commits to display (e.g. 'commit1..commit2'
 	or 'commit2 {caret}commit1'), only display commits that exist
diff --git a/builtin/log.c b/builtin/log.c
index d104d5c688..2883fa2872 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -306,7 +306,7 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 	int show_header = 1;

 	revs->diffopt.close_file = 0;
-	sort_in_topological_order(&list, revs->sort_order);
+	sort_in_topological_order(&list, NULL, revs->sort_order);
 	while (list && i) {
 		struct commit *commit = list->item;
 		switch (simplify_commit(revs, commit)) {
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 7e52ee9126..c766d61126 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -903,7 +903,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		exit(0);

 	/* Sort topologically */
-	sort_in_topological_order(&seen, sort_order);
+	sort_in_topological_order(&seen, NULL, sort_order);

 	/* Give names to commits */
 	if (!sha1_name && !no_name)
diff --git a/commit.c b/commit.c
index 87686a7055..aa5ff43c78 100644
--- a/commit.c
+++ b/commit.c
@@ -758,14 +758,18 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 /*
  * Performs an in-place topological sort on the list supplied.
  */
-void sort_in_topological_order(struct commit_list **list, enum rev_sort_order sort_order)
+void sort_in_topological_order(struct commit_list **list,
+			       struct skel_info *skel,
+			       enum rev_sort_order sort_order)
 {
 	struct commit_list *next, *orig = *list;
 	struct commit_list **pptr;
 	struct indegree_slab indegree;
-	struct prio_queue queue;
-	struct commit *commit;
+	struct prio_queue queue, revqueue;
+	struct commit *commit, *parent;
 	struct author_date_slab author_date;
+	int *comp_p = NULL, *comp_c = NULL, next_comp = 1;
+	struct skel_datum *d_p = NULL, *d_c = NULL;

 	if (!orig)
 		return;
@@ -773,20 +777,10 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so

 	init_indegree_slab(&indegree);
 	memset(&queue, '\0', sizeof(queue));
+	memset(&revqueue, '\0', sizeof(revqueue));

-	switch (sort_order) {
-	default: /* REV_SORT_IN_GRAPH_ORDER */
-		queue.compare = NULL;
-		break;
-	case REV_SORT_BY_COMMIT_DATE:
-		queue.compare = compare_commits_by_commit_date;
-		break;
-	case REV_SORT_BY_AUTHOR_DATE:
+	if (sort_order == REV_SORT_BY_AUTHOR_DATE)
 		init_author_date_slab(&author_date);
-		queue.compare = compare_commits_by_author_date;
-		queue.cb_data = &author_date;
-		break;
-	}

 	/* Mark them and clear the indegree */
 	for (next = orig; next; next = next->next) {
@@ -795,19 +789,100 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 		/* also record the author dates, if needed */
 		if (sort_order == REV_SORT_BY_AUTHOR_DATE)
 			record_author_date(&author_date, commit);
+		prio_queue_put(&queue, commit);
 	}

+	/*
+	 * When performing a skeleton walk, all commits must be processed from
+	 * highest priority to lowest priority.  The highest priority commits
+	 * appear first in orig, so we must reverse the queue to ensure they
+	 * are processed first.
+	 */
+	if (skel)
+		prio_queue_reverse(&queue);
+
 	/* update the indegree */
-	for (next = orig; next; next = next->next) {
-		struct commit_list *parents = next->item->parents;
-		while (parents) {
+	while ((commit = prio_queue_get(&queue)) != NULL) {
+		if (skel) {
+			comp_c = &skel_slab_at(&skel->slab, commit)->component;
+
+			/*
+			 * Store if we have visited the commit in its sign bit.
+			 *
+			 * Skip if we already visited, or mark that this commit
+			 * has been visisted.
+			 *
+			 * Assign a new component if none has already been
+			 * propagated to the commit.
+			 */
+			if (*comp_c > 0)
+				continue;
+
+			if (!*comp_c)
+				*comp_c = next_comp++;
+			else
+				*comp_c = -*comp_c;
+		}
+
+		for (struct commit_list *parents = commit->parents;
+		     parents; parents = parents->next) {
 			struct commit *parent = parents->item;
 			int *pi = indegree_slab_at(&indegree, parent);

-			if (*pi)
+			if (!*pi)
+				continue;
+
+			if (skel) {
+				d_p = skel_slab_at(&skel->slab, parent);
+				/*
+				 * Back-propagate the child's component, and
+				 * mark the principle child.
+				 *
+				 * Only count the first intra-component
+				 * reference. but count all inter-component
+				 * references.
+				 *
+				 * Override lower-priorty (higher numerical
+				 * value) components.
+				 */
+				comp_p = &d_p->component;
+				if (!*comp_p || *comp_p > *comp_c) {
+					*comp_p = -*comp_c;
+					d_p->child = commit;
+					prio_queue_put(&revqueue, parent);
+					(*pi)++;
+				} else if (*comp_p < *comp_c)
+					(*pi)++;
+			} else
 				(*pi)++;
-			parents = parents->next;
 		}
+
+		/*
+		 * More leftward commits are higher priority, and therefore
+		 * must be processed first.
+		 */
+		if (skel)
+			while ((parent = prio_queue_get(&revqueue)) != NULL)
+				prio_queue_put(&queue, parent);
+	}
+
+	if (skel) {
+		clear_prio_queue(&revqueue);
+		clear_prio_queue(&queue);
+	}
+
+	/* reuse the priority queue */
+	switch (sort_order) {
+	default: /* REV_SORT_IN_GRAPH_ORDER */
+		queue.compare = NULL;
+		break;
+	case REV_SORT_BY_COMMIT_DATE:
+		queue.compare = compare_commits_by_commit_date;
+		break;
+	case REV_SORT_BY_AUTHOR_DATE:
+		queue.compare = compare_commits_by_author_date;
+		queue.cb_data = &author_date;
+		break;
 	}

 	/*
@@ -838,10 +913,18 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 	*list = NULL;
 	while ((commit = prio_queue_get(&queue)) != NULL) {
 		struct commit_list *parents;
+		if (skel) {
+			d_c = skel_slab_at(&skel->slab, commit);
+			comp_c = &d_c->component;
+		}

 		for (parents = commit->parents; parents ; parents = parents->next) {
 			struct commit *parent = parents->item;
 			int *pi = indegree_slab_at(&indegree, parent);
+			if (skel) {
+				d_p = skel_slab_at(&skel->slab, parent);
+				comp_p = &d_p->component;
+			}

 			if (!*pi)
 				continue;
@@ -850,9 +933,14 @@ void sort_in_topological_order(struct commit_list **list, enum rev_sort_order so
 			 * parents are only enqueued for emission
 			 * when all their children have been emitted thereby
 			 * guaranteeing topological order.
+			 *
+			 * If we are performing a skeleton walk, do not count
+			 * intra-component references that are not from the
+			 * principle child.
 			 */
-			if (--(*pi) == 1)
-				prio_queue_put(&queue, parent);
+			if (!skel || (*comp_p != *comp_c || d_p->child == commit))
+				if (--(*pi) == 1)
+					prio_queue_put(&queue, parent);
 		}
 		/*
 		 * all children of commit have already been
diff --git a/commit.h b/commit.h
index 1b2dea5d85..64d04d124f 100644
--- a/commit.h
+++ b/commit.h
@@ -183,6 +183,7 @@ struct commit_list *copy_commit_list(struct commit_list *list);
 void free_commit_list(struct commit_list *list);

 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
+struct skel_info;

 int has_non_ascii(const char *text);
 const char *logmsg_reencode(const struct commit *commit,
@@ -226,7 +227,8 @@ enum rev_sort_order {
  *                            chain together.
  *   REV_SORT_BY_COMMIT_DATE: show eligible commits in committer-date order.
  */
-void sort_in_topological_order(struct commit_list **, enum rev_sort_order);
+void sort_in_topological_order(struct commit_list **, struct skel_info *,
+			       enum rev_sort_order);

 struct commit_graft {
 	struct object_id oid;
diff --git a/graph.c b/graph.c
index 4cd9915075..57fd51fb05 100644
--- a/graph.c
+++ b/graph.c
@@ -428,21 +428,43 @@ static void graph_ensure_capacity(struct git_graph *graph, int num_columns)
  */
 static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
 {
-	/*
-	 * If revs->boundary is set, commits whose children have
-	 * been shown are always interesting, even if they have the
-	 * UNINTERESTING or TREESAME flags set.
-	 */
-	if (graph->revs && graph->revs->boundary) {
-		if (commit->object.flags & CHILD_SHOWN)
-			return 1;
+	struct skel_datum *dat_p, *dat_c;
+	struct rev_info *revs = graph->revs;
+	struct skel_info *skel = NULL;
+
+	if (revs->ignore_merge_bases)
+		skel = revs->skel_info;
+
+	if (revs) {
+		/*
+		 * If revs->boundary is set, commits whose children have
+		 * been shown are always interesting, even if they have the
+		 * UNINTERESTING or TREESAME flags set.
+		 */
+		if (revs->boundary) {
+			if (commit->object.flags & CHILD_SHOWN)
+				return 1;
+		}
+
+		/*
+		 * If revs->ignore_merge_bases is set, suppress intra-component
+		 * edges that are not from the principle child.
+		 */
+		if (skel) {
+			dat_p = skel_slab_at(&skel->slab, commit);
+			dat_c = skel_slab_at(&skel->slab, graph->commit);
+			if (dat_p->component == dat_c->component &&
+			    dat_p->child != graph->commit) {
+				return 0;
+			}
+		}
 	}

 	/*
 	 * Otherwise, use get_commit_action() to see if this commit is
 	 * interesting
 	 */
-	return get_commit_action(graph->revs, commit) == commit_show;
+	return get_commit_action(revs, commit) == commit_show;
 }

 static struct commit_list *next_interesting_parent(struct git_graph *graph,
diff --git a/revision.c b/revision.c
index 60cca8c0b9..af676fd847 100644
--- a/revision.c
+++ b/revision.c
@@ -39,6 +39,22 @@ static const char *term_good;

 implement_shared_commit_slab(revision_sources, char *);

+implement_shared_commit_slab(skel_slab, struct skel_datum);
+
+static struct skel_info *new_skel_info(void)
+{
+	struct skel_info *info = xcalloc(1, sizeof(struct skel_info));
+	memset(info, '\0', sizeof(struct skel_info));
+	init_skel_slab(&info->slab);
+	return info;
+}
+
+static void free_skel_info(struct skel_info *info)
+{
+	clear_skel_slab(&info->slab);
+	free(info);
+}
+
 void show_object_with_name(FILE *out, struct object *obj, const char *name)
 {
 	const char *p;
@@ -2204,6 +2220,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--topo-order")) {
 		revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
 		revs->topo_order = 1;
+	} else if (!strcmp(arg, "--ignore-merge-bases")) {
+		revs->topo_order = 1;
+		revs->ignore_merge_bases = 1;
+		revs->skel_info = new_skel_info();
 	} else if (!strcmp(arg, "--simplify-merges")) {
 		revs->simplify_merges = 1;
 		revs->topo_order = 1;
@@ -3348,14 +3368,179 @@ static void indegree_walk_step(struct rev_info *revs)
 	}
 }

+/*
+ * The skeleton walk is over edges in a graph.  Notationally, we refer to the
+ * commit (item) and the child, because we will be interested in the parents of
+ * item, not the children of child.
+ */
+struct skel_walk_list {
+	struct commit *item;
+	struct skel_walk_list *next;
+	struct commit *child;
+};
+
+static void swl_pop(struct skel_walk_list **stack)
+{
+	struct skel_walk_list *top = *stack;
+
+	if (top) {
+		*stack = top->next;
+		free(top);
+	}
+	return;
+}
+
+static struct skel_walk_list **swl_append(struct commit *item,
+					 struct commit *child,
+					 struct skel_walk_list **list_p)
+{
+	struct skel_walk_list *new_list = xmalloc(sizeof(struct skel_walk_list));
+
+	if (parse_commit_gently(item, 1) < 0) {
+		printf("WHAT!\n");
+		return list_p; //XXX: !!?
+	}
+
+	new_list->item = item;
+	new_list->next = *list_p;
+	new_list->child = child;
+
+	*list_p = new_list;
+	return &new_list->next;
+}
+
+static void skel_walk_step(struct rev_info *revs,
+			   struct skel_walk_list **next)
+{
+	struct indegree_slab *indegree = &revs->topo_walk_info->indegree;
+	struct skel_info *skel = revs->skel_info;
+	struct commit *commit = (*next)->item;
+	struct skel_datum *d_i = skel_slab_at(&skel->slab, commit);
+	int comp_c, first = 1;
+
+	explore_to_depth(revs, commit->generation);
+
+	/*
+	 * If the commit has already been visited, all the parents have already
+	 * been processed, but we still must count inter-component references.
+	 */
+	if (d_i->component) {
+		if ((*next)->child) {
+			comp_c = skel_slab_at(&skel->slab, (*next)->child)->component;
+
+			if (d_i->component < comp_c)
+				(*indegree_slab_at(indegree, commit))++;
+		}
+
+		swl_pop(next);
+		return;
+	}
+
+	/*
+	 * We are visiting commit for the first time:
+	 *  - count the indegree
+	 *  - mark the principle child
+	 *  - back-propagate the component
+	 *
+	 * If there is no principle child, allocate a new component.
+	 */
+	if (!(*next)->child)
+		d_i->component = skel->next_comp++;
+	else {
+		d_i->child = (*next)->child;
+		d_i->component = skel_slab_at(&skel->slab, d_i->child)->component;
+		*indegree_slab_at(indegree, commit) = 2;
+	}
+
+	/*
+	 * Push all parents onto the skeleton walk list, replacing *next.
+	 */
+	for (struct commit_list *parents = commit->parents;
+	     parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+
+		/*
+		 * Micro-optimization to reuse the skeleton walk list entry,
+		 * if possible.
+		 */
+		if (first) {
+			(*next)->item = parent;
+			(*next)->child = commit;
+
+			next = &(*next)->next;
+			first = 0;
+		} else
+			next = swl_append(parent, commit, next);
+
+		if (revs->first_parent_only)
+			return;
+	}
+
+	if (first)
+		swl_pop(next);
+
+	return;
+}
+
 static void compute_indegrees_to_depth(struct rev_info *revs,
 				       uint32_t gen_cutoff)
 {
 	struct topo_walk_info *info = revs->topo_walk_info;
 	struct commit *c;
-	while ((c = prio_queue_peek(&info->indegree_queue)) &&
-	       c->generation >= gen_cutoff)
-		indegree_walk_step(revs);
+	struct skel_info *skel = NULL;
+	struct skel_walk_list **next;
+	uint32_t t, p_gen_cutoff = gen_cutoff;
+
+	if (revs->ignore_merge_bases)
+		skel = revs->skel_info;
+
+	if (!skel) {
+		while ((c = prio_queue_peek(&info->indegree_queue)) &&
+		       c->generation >= gen_cutoff)
+			indegree_walk_step(revs);
+		return;
+	}
+
+	/*
+	 * Explore all edges originating from commits of appropriate generation
+	 */
+	next = &skel->walk;
+	while (*next) {
+		if ((*next)->item->generation < gen_cutoff) {
+			/*
+			 * Ideally, we would explore this edge right now, but
+			 * we cannot, because we have not yet necessarily
+			 * explored more leftward commits to this depth.
+			 *
+			 * Notice that (*next)->child is not NULL, because we
+			 * always perform an initial search with depth of the
+			 * maximum of all tip commits.
+			 */
+			if ((*next)->child->generation < gen_cutoff) {
+				t = (*next)->item->generation;
+				if (t < p_gen_cutoff)
+					p_gen_cutoff = t;
+			}
+
+			next = &(*next)->next;
+			continue;
+		}
+
+		skel_walk_step(revs, next);
+	}
+
+	/*
+	 * Double back to get the parents of commits above gen_cutoff.
+	 */
+	next = &skel->walk;
+	while (*next) {
+		if ((*next)->item->generation < p_gen_cutoff) {
+			next = &(*next)->next;
+			continue;
+		}
+
+		skel_walk_step(revs, next);
+	}
 }

 static void reset_topo_walk(struct rev_info *revs)
@@ -3375,6 +3560,12 @@ static void init_topo_walk(struct rev_info *revs)
 {
 	struct topo_walk_info *info;
 	struct commit_list *list;
+	struct skel_walk_list **tail = NULL;
+	struct skel_info *skel = NULL;
+
+	if (revs->ignore_merge_bases)
+		skel = revs->skel_info;
+
 	if (revs->topo_walk_info)
 		reset_topo_walk(revs);

@@ -3387,6 +3578,13 @@ static void init_topo_walk(struct rev_info *revs)
 	memset(&info->indegree_queue, 0, sizeof(info->indegree_queue));
 	memset(&info->topo_queue, 0, sizeof(info->topo_queue));

+	if (skel) {
+		tail = &skel->walk;
+		*tail = NULL;
+		skel->next_comp = 1;
+	}
+
+
 	switch (revs->sort_order) {
 	default: /* REV_SORT_IN_GRAPH_ORDER */
 		info->topo_queue.compare = NULL;
@@ -3411,16 +3609,23 @@ static void init_topo_walk(struct rev_info *revs)
 		if (parse_commit_gently(c, 1))
 			continue;

-		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
-		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
-
 		if (c->generation < info->min_generation)
 			info->min_generation = c->generation;

-		*(indegree_slab_at(&info->indegree, c)) = 1;
+		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);

 		if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
 			record_author_date(&info->author_date, c);
+
+		*(indegree_slab_at(&info->indegree, c)) = 1;
+
+		if (skel) {
+			tail = swl_append(c, NULL, tail);
+			continue;
+		}
+
+		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
+
 	}
 	compute_indegrees_to_depth(revs, info->min_generation);

@@ -3457,6 +3662,11 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 {
 	struct commit_list *p;
 	struct topo_walk_info *info = revs->topo_walk_info;
+	struct skel_info *skel = revs->skel_info;
+
+	if (!revs->ignore_merge_bases)
+		skel = NULL;
+
 	if (process_parents(revs, commit, NULL, NULL) < 0) {
 		if (!revs->ignore_missing_links)
 			die("Failed to traverse parents of commit %s",
@@ -3480,9 +3690,11 @@ static void expand_topo_walk(struct rev_info *revs, struct commit *commit)

 		pi = indegree_slab_at(&info->indegree, parent);

-		(*pi)--;
-		if (*pi == 1)
-			prio_queue_put(&info->topo_queue, parent);
+		if (!skel ||
+		    (skel_slab_at(&skel->slab, parent)->component != skel_slab_at(&skel->slab, commit)->component ||
+		     skel_slab_at(&skel->slab, parent)->child == commit ))
+			if (--(*pi) == 1)
+				prio_queue_put(&info->topo_queue, parent);

 		if (revs->first_parent_only)
 			return;
@@ -3531,7 +3743,9 @@ int prepare_revision_walk(struct rev_info *revs)
 		if (limit_list(revs) < 0)
 			return -1;
 		if (revs->topo_order)
-			sort_in_topological_order(&revs->commits, revs->sort_order);
+			sort_in_topological_order(&revs->commits,
+						  revs->skel_info,
+						  revs->sort_order);
 	} else if (revs->topo_order)
 		init_topo_walk(revs);
 	if (revs->line_level_traverse)
@@ -3987,11 +4201,13 @@ static void create_boundary_commit_list(struct rev_info *revs)
 		commit_list_insert(c, &revs->commits);
 	}

+	revs->ignore_merge_bases = 0;
+
 	/*
 	 * If revs->topo_order is set, sort the boundary commits
 	 * in topological order
 	 */
-	sort_in_topological_order(&revs->commits, revs->sort_order);
+	sort_in_topological_order(&revs->commits, NULL, revs->sort_order);
 }

 static struct commit *get_revision_internal(struct rev_info *revs)
diff --git a/revision.h b/revision.h
index 93491b79d4..b33fbe8829 100644
--- a/revision.h
+++ b/revision.h
@@ -88,6 +88,21 @@ struct rev_cmdline_info {
 struct oidset;
 struct topo_walk_info;

+struct skel_datum {
+	int component;
+	struct commit *child;
+};
+
+define_shared_commit_slab(skel_slab, struct skel_datum);
+
+struct skel_walk_list;
+
+struct skel_info {
+	struct skel_walk_list *walk;
+	int next_comp;
+	struct skel_slab slab;
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -137,6 +152,7 @@ struct rev_info {
 			show_pulls:1,
 			topo_order:1,
 			simplify_merges:1,
+			ignore_merge_bases:1,
 			simplify_by_decoration:1,
 			single_worktree:1,
 			tag_objects:1,
@@ -307,6 +323,7 @@ struct rev_info {
 	 * This is loaded from the commit-graph being used.
 	 */
 	struct bloom_filter_settings *bloom_filter_settings;
+	struct skel_info *skel_info;
 };

 int ref_excluded(struct string_list *, const char *path);
-- 
2.27.0

