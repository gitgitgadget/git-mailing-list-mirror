Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10C299929
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377770; cv=none; b=tShm0e8Bk3nQiLSoROafcMSmjojzsB1jMgX2UU2IFhEJyNX+/Nyxdv8aRXRrOn2zqk68OgwU2jUvsQfz1RuAi3WlOUF84mWd6KWroTs6o3lQ0xRk/NP/dCDrvEmD/XZDU5cybGC87n4OVI8qjBCYI0G8IveH/phcNt3xfkfjTZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377770; c=relaxed/simple;
	bh=3HChaWvtNtqqN2FkOzJfKhFf0VVcYsExcVF9BkhLPV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiDYmwmH4rifX5+aOGWtbnurFLShgqk8ghAzvSdoZzWTWiIPbzT3ESEn944W+j50cWeAt8Lcuga6t1v5NSkbuHBphdL4KAEU3UnNxs6Na2HyO4xWDuGiAiGxRWfO6WNUs4dXAWSeR8409KI7NdZj9Ybd82PGASjR4niM9phH1IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTuZHbmz; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTuZHbmz"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso941108f8f.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 12:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781377766; x=1781982566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+xMxXhk41g1YS99wD3bBRHwtOdMnhKXWqZhDN73y8k=;
        b=nTuZHbmzU9j7JZ1d+fNJZyERFcsRPPUvhlSy/8niGyv9PbUzmtOBgqJrNc+8nctaSv
         NlxvNiKXkELUiBHrQ5gvGK1bwbm7Dbq8V1oVj9cQoTC5l4gtAhEvDr/H6GbrobO9O4NI
         RcKIrsXI9QbwzOgwt2HKi6HwNnfANf5ops3svSzCnelXPnCjfTfSkiCK0sz8XxgxqXDt
         kWit5pm4IPv3uC5QGMbD0KuYY1o8O4VeRmDrbwvjbNdHSdWcY7/AZnspLWozRcO8JdRr
         0MYvykBNUJ4zZCT/SNtrqxKqEeFwME9nqQAxoxtal6on1nQeWJqZYCj7xxY19/k8aXdC
         d2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781377766; x=1781982566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s+xMxXhk41g1YS99wD3bBRHwtOdMnhKXWqZhDN73y8k=;
        b=kCfM6q3x9P7opNTN58b9t9jXGVVxWR5qIArj64Lg4OLhYxfVYg6N/1fVxIGnLWhMLO
         HXshdD+gEAp+IJ55O75qUmBB5hsh3Y03qGu9fNkra08lvHU+V0t1cYG4BXP13YZrTLlv
         pLzUtGFhgHMIqAIydqToa84xNUHLQTeNp8lxSEKxq7VNsckLn5FnGsvZ/ODRnkI95BaT
         AdpnqI98xTM0EpmrneCSR0vLZEglvXcuGt5x+xJ4QkC4UUryvljug4rvDikqG9zKCyh4
         PcWQicRaJfEr2mQzx/WDW7ddONWInp0UiVi1+shUeNnwiUYc/GsD7dXnB+HT9Ps94lVD
         tWnw==
X-Gm-Message-State: AOJu0YxdjrV+o1wNK+P+DlKiEe21qzAuZtzpnrMT9+mKSiLgArevL7Bo
	OLO6B/0h8s5WsM7arJLwcGLfTg4q7awDhkORg74jbg2xued5ypv4v4S7NsIvxFx+
X-Gm-Gg: Acq92OHKC9Rh3ZI65Zttewo+zpIoexF1SKdJsJIOodSLoaOiTTcVWe3Lj3iSMGyG80h
	p6OaFc+ydhK6ziSVmkcFuT7sO5hECpg9VeaYDzaosQC8Ro4H1XC5/s4qdCqz05RA/dOipsyqJt9
	pqnxsxX7UzJIEdmCMULaegG8dW8SA5whcb6FGJlVtPVoOu9RbesB+JmfCmlL75YHLMRBqb8VX8x
	4sl0XrpYP/hsdSN4QzNNMU2iJRZ0L8Fga5Cu6m1b+/riCJXbX8uumutgVy2rN4ARckeONWLqJMg
	1v6yza6fE7PxXoI5kGq6E+3SWfY34un12heOmcydZWLy/8v5ysDO7S7e3T9JWDz1384doOFRAF7
	1B/Fs7i+GZ7xNCe5HNzhNM0ApSVi219/fRvh8el14XNYOr2LuOZNoLlteABgeARYkqUz6ieqkyT
	GE2zQC/62d+2Ce3j6D8R5eUJ/u8cx+LVtKqRdCbNvGvbhoFsQF9jLNPtE8YYm4uFYxbgoczThF+
	uyB6bxE1a74MtYbLQECki2v+0j1yLsxATTLMp5zIpCmlhdTzrG5FTTc8BbPNXFO5ujxclm9+l+1
	rBRsF7B/4//umQ2f8a80HB90XbrDMuS8GkFAO4wvI+jOrJzFfBP/5EGkjc+ssVpVz1QFWSVHMVu
	3AmcQxgqTmXlQz8cCQKh/zvdK
X-Received: by 2002:a05:600c:1511:b0:490:ce99:d2ee with SMTP id 5b1f17b1804b1-490ec4df7b5mr62951625e9.15.1781377765425;
        Sat, 13 Jun 2026 12:09:25 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0d28sm18238110f8f.20.2026.06.13.12.09.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 13 Jun 2026 12:09:24 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH v5 2/2] graph: indent visual root in graph
Date: Sat, 13 Jun 2026 21:09:16 +0200
Message-ID: <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
 <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When rendering a graph, if the history contains multiple "visual roots",
actual roots or commits that look like roots (i.e. have their parents
filtered out) can end up being vertically adjacent to unrelated commits,
falsely appearing to be related.

A fix for this issue was already attempted [1] a while ago.

This happens because the commits fill the space from left to right and
when a visual root ends, its column becomes free for the following
commit even if they are not related. Once this happens the unrelated
commit is rendered below the visual root. Because there is no special
character or way to identify when a visual root is rendered making the
graph confusing.

By indenting the visual roots when there are still commits to show the
vertical adjacency can be avoided.

Add is_visual_root flag to git_graph making it visible in all graph states,
give graph_update() a new function, graph_is_visual_root() to know if the
current commit is a visual root and set is_visual_root.
The different handled cases are:

- If a visual root has children: similar to GRAPH_PRE_COMMIT state when
  octopus merges need space, an edge row needs to be printed to connect
  the child with the indented visual root. A new state GRAPH_PRE_ROOT is
  needed to connect the child with the visual root:

    * child of the visual root
     \ GRAPH_PRE_ROOT
      * visual root indented

- If a visual root is child-less we can skip GRAPH_PRE_ROOT state and
  render the indented commit directly.

      * visual root indented
    * unrelated commit

- If two or more visual roots are adjacent: by having a lookahead to the
  next commit that will be rendered, if the next commit is also a visual
  root and we are on a visual root, meaning two visual root adjacent in
  the history, the top one can omit the indent, making the one below to
  indent only once, if there are more adjacent visual commits, the
  indentation will increase for each adjacent one, cascading.

    * visual root
      * visual root
        * visual root
    * last commit

  Even if the last commit is a root, because there is nothing that will be
  rendered below we can omit the indentation on purpose.

The lookahead is not completely reliable, on graphs with filtered parents,
the walker when processing the current commit it will simplify its
parents by removing the ones that won't be shown, (They have the
TREESAME flag when filtering by path for example), but it doesn't act
for the grandparents or the next commit if it is unrelated until we move
to the next.

For example given

  A visual root
  B child
  C parent of B, visual root FILTERED
  D last commit

We would expect

  A
    B
  D

When processing A, for the walker and the information at the renderer, B
is still a child of C, as B parent, hasn't been removed yet. This makes
cascade to not trigger as the lookahead fails to detect if the next
commit will be a visual root.
Once at B, its parent has been removed and has become a visual root, and
it just adds its indent to the one left by A. We end up with an extra
indent:

    A
      B
  D

The output isn't broken as unrelated commits are successfully separated
by indentation, but an indent level should have been avoided.

Create a new test file for graph indentations test called
't4218-log-graph-indentation.sh'.

The filtered parents edge case is documented as a NEEDSWORK on the
lookahead function and it has its own 'test_expect_failure' at 't4218'.

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 graph.c                          | 262 ++++++++++++++++++++++
 t/meson.build                    |   1 +
 t/t4218-log-graph-indentation.sh | 467 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 730 insertions(+)

diff --git a/graph.c b/graph.c
index 842282685f..e0d1e2a510 100644
--- a/graph.c
+++ b/graph.c
@@ -60,12 +60,23 @@ struct column {
 	 * index into column_colors.
 	 */
 	unsigned short color;
+	/*
+	 * Marks if a commit is a non-first parent of a merge. These columns are
+	 * already visually connected to the merge commit and do not need
+	 * indentation.
+	 *
+	 * The first parent is the one that inherits the column and it can need
+	 * indentation if turns out to be a visual root and there's still
+	 * commits to render.
+	 */
+	unsigned is_merge_parent:1;
 };
 
 enum graph_state {
 	GRAPH_PADDING,
 	GRAPH_SKIP,
 	GRAPH_PRE_COMMIT,
+	GRAPH_PRE_ROOT,
 	GRAPH_COMMIT,
 	GRAPH_POST_MERGE,
 	GRAPH_COLLAPSING
@@ -315,6 +326,48 @@ struct git_graph {
 	 * diff_output_prefix_callback().
 	 */
 	struct strbuf prefix_buf;
+
+	/*
+	 * If a commit is a visual root, we need to indent it to prevent
+	 * unrelated commits from being vertically adjacent to it.
+	 */
+	unsigned is_visual_root:1;
+
+	/*
+	 * Indentation increases for each visual root adjacent to another visual
+	 * root, making visual root commits indentation cascade.
+	 */
+	unsigned int visual_root_depth;
+
+	/*
+	 * When a visual root is adjacent to other visual roots, the first one
+	 * can avoid indentation and the rest cascades, increasing the indentation
+	 * for each one.
+	 */
+	unsigned visual_root_cascade:1;
+
+	/*
+	 * Set when the current commit was already present in graph->columns
+	 * before being processed.
+	 */
+	unsigned commit_in_columns:1;
+};
+
+struct graph_lookahead_flags {
+	/*
+	 * Set when there will be a commit after the current one that will be
+	 * rendered.
+	 */
+	unsigned int is_next_visible:1;
+	/*
+	 * Set when the next visible commit is candidate to be a visual root.
+	 */
+	unsigned int is_next_visual_root:1;
+	/*
+	 * Set when the next visible commit will be rendered under the current
+	 * commit.
+	 */
+	unsigned int next_has_column:1;
 };
 
 static inline int graph_needs_truncation(struct git_graph *graph, int lane)
@@ -388,6 +441,8 @@ struct git_graph *graph_init(struct rev_info *opt)
 	graph->num_columns = 0;
 	graph->num_new_columns = 0;
 	graph->mapping_size = 0;
+	graph->visual_root_depth = 0;
+	graph->visual_root_cascade = 0;
 	/*
 	 * Start the column color at the maximum value, since we'll
 	 * always increment it for the first commit we output.
@@ -561,6 +616,11 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 					  struct commit *commit,
 					  int idx)
 {
+	/*
+	 * Get the initial merge_layout before it's modified to know if this
+	 * is a merge.
+	 */
+	int initial_merge_layout = graph->merge_layout;
 	int i = graph_find_new_column_by_commit(graph, commit);
 	int mapping_idx;
 
@@ -572,6 +632,7 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 		i = graph->num_new_columns++;
 		graph->new_columns[i].commit = commit;
 		graph->new_columns[i].color = graph_find_commit_color(graph, commit);
+		graph->new_columns[i].is_merge_parent = 0;
 	}
 
 	if (graph->num_parents > 1 && idx > -1 && graph->merge_layout == -1) {
@@ -610,6 +671,12 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	}
 
 	graph->mapping[mapping_idx] = i;
+
+	/*
+	 * Mark non-first parents of a merge.
+	 */
+	if (graph->num_parents > 1 && initial_merge_layout >= 0 && idx > -1)
+		graph->new_columns[i].is_merge_parent = 1;
 }
 
 static void graph_update_columns(struct git_graph *graph)
@@ -701,10 +768,20 @@ static void graph_update_columns(struct git_graph *graph)
 			if (graph->num_parents == 0)
 				graph->width += 2;
 		} else {
+			int j;
 			graph_insert_into_new_columns(graph, col_commit, -1);
+			/*
+			 * This column is not the current commit, but we need to
+			 * propagate the flag until the commit is processed.
+			 */
+			j = graph_find_new_column_by_commit(graph, col_commit);
+			if (j >= 0 && graph->columns[i].is_merge_parent)
+				graph->new_columns[j].is_merge_parent = 1;
 		}
 	}
 
+	graph->commit_in_columns = is_commit_in_columns;
+
 	/*
 	 * If graph_max_lanes is set, cap the width
 	 */
@@ -763,9 +840,135 @@ static int graph_needs_pre_commit_line(struct git_graph *graph)
 	       graph->expansion_row < graph_num_expansion_rows(graph);
 }
 
+/*
+ * A commit can be a visual root when:
+ * - It has no parents.
+ *
+ * - It has parents but they are all filtered out and
+ *   commit->parents arrives NULL.
+ *
+ * - It is not a boundary commit. Boundary commits also have no visible
+ *   parents, but they are not selected as visual roots because they cannot
+ *.  cause the ambiguity of being vertically adjacent because:
+ *
+ *   1. A boundary only appears because an included commit is its child.
+ *      Children are always above, and the renderer draws an edge down to
+ *      the boundary from that child. Rather than starting a column like a
+ *      visual root would do, it inherits its child column.
+ *
+ *   2. Included commits cannot appear below a boundary. Boundaries are
+ *      ancestors of the exclusion point; if an included commit were an
+ *      ancestor of the boundary it would be excluded and not rendered.
+ *      Boundaries therefore always sink to the bottom.
+ */
+static int graph_is_visual_root_candidate(struct commit *c)
+{
+	return c->parents == NULL && !(c->object.flags & BOUNDARY);
+}
+
+static int graph_is_visual_root(struct git_graph *graph,
+				struct graph_lookahead_flags *flags)
+{
+	/*
+	 * This must be only called for the current commit as graph contains
+	 * the state for the current commit only.
+	 *
+	 * To check if a commit is a visual root, call graph_is_visual_root_candidate()
+	 * but we won't know if it is really a visual root until we get to the
+	 * next commit state.
+	 *
+	 * The current commit is an actual visual root if it is a candidate and
+	 * the commit is not a non-first parent of a merge.
+	 *
+	 *   *
+	 *   |\
+	 *   | *    <- it is a visual root candidate but it shouldn't be indented
+	 *   *         because it is already connected by an edge.
+	 *   ^         if commit_in_columns && is_merge_parent means the commit
+	 *   |         was put by a merge and is connected.
+	 *   |
+	 *   `-------- if !is_next_visible means we're on the last commit, avoid
+	 *             indentation unless the one before is a visual root, then
+	 *             we need to differentiate from the one above.
+	 *
+	 * If next_has_columns means that the next commit has
+	 * already a column, so it will not be rendered below, the
+	 * current commit has to act as the last commit and omit
+	 * indentation.
+	 */
+	return graph_is_visual_root_candidate(graph->commit) &&
+	       !(graph->commit_in_columns &&
+		 graph->columns[graph->commit_index].is_merge_parent) &&
+	       flags->is_next_visible &&
+	       (!flags->next_has_column || graph->visual_root_depth > 0);
+}
+
+/*
+ * Iterates the commits queue searching for the next visible commit, once found
+ * sets visibleness and visual-root flags.
+ * Knowing if the next commit is also a visual root avoids redundant indentations
+ *
+ * NEEDSWORK: The queue is actively being modified by the walker, for each commit
+ * its parents and itself get simplified and their flags set, but for the next
+ * unrelated commit or the grandparents they are not simplified yet, which means
+ * that a commit whose parents are all filtered will not be marked as a visual
+ * root candidate at the lookahead.
+ * This causes the lookahead to fail, failing to set the cascade flag to avoid
+ * redundant indentations.
+ * See 'test_expect_failure' at t4218-log-graph-indentation.sh.
+ */
+static void graph_peek_next_visible(struct git_graph *graph,
+				    struct graph_lookahead_flags *flags)
+{
+	struct commit_list *cl;
+
+	flags->is_next_visible = 0;
+	flags->is_next_visual_root = 0;
+	flags->next_has_column = 0;
+
+	for (cl = graph->revs->commits; cl; cl = cl->next) {
+		if (get_commit_action(graph->revs, cl->item) != commit_show)
+			continue;
+		flags->is_next_visible = 1;
+		flags->next_has_column = graph_find_new_column_by_commit(graph, cl->item) >= 0;
+		/*
+		 * We do not need graph->commit_in_columns or is_merge_parent,
+		 * because we only need to know whether the next one might be a
+		 * visual root, affecting the current commit where the cascade
+		 * would have to be set and the first visual root not indented.
+		 *
+		 * It will set next_is_visual_root to true for merge parents that
+		 * graph_is_visual_root() would return false, but if the next is
+		 * a merge parent, the current commit is the child and cannot
+		 * be a visual root and therefore having no effect.
+		 */
+		if (!graph_is_visual_root_candidate(cl->item))
+			return;
+
+		/*
+		 * The next visible commit is a visual root candidate, but
+		 * only set cascade if it's not the last commit to be rendered.
+		 */
+		for (cl = cl->next; cl; cl = cl->next) {
+			if (get_commit_action(graph->revs, cl->item) != commit_show)
+				continue;
+			flags->is_next_visual_root = 1;
+			return;
+		}
+		return;
+	}
+}
+
+static int graph_needs_pre_root_line(struct git_graph *graph)
+{
+	return graph->commit_in_columns && graph->is_visual_root &&
+	       graph->num_columns > 0 && !graph->visual_root_cascade;
+}
+
 void graph_update(struct git_graph *graph, struct commit *commit)
 {
 	struct commit_list *parent;
+	struct graph_lookahead_flags flags;
 
 	/*
 	 * Set the new commit
@@ -796,6 +999,23 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 */
 	graph_update_columns(graph);
 
+	graph_peek_next_visible(graph, &flags);
+
+	graph->is_visual_root = graph_is_visual_root(graph, &flags);
+
+	if (graph->is_visual_root) {
+		/*
+		 * If next is a visual root we can omit the indent for the first
+		 * visual root and start cascading.
+		 */
+		if (!graph->visual_root_depth && flags.is_next_visual_root)
+			graph->visual_root_cascade = 1;
+		graph->visual_root_depth++;
+	} else {
+		graph->visual_root_depth = 0;
+		graph->visual_root_cascade = 0;
+	}
+
 	graph->expansion_row = 0;
 
 	/*
@@ -813,11 +1033,16 @@ void graph_update(struct git_graph *graph, struct commit *commit)
 	 * room for it.  We need to do this only if there is a branch row
 	 * (or more) to the right of this commit.
 	 *
+	 * If it is a visual root, we need to print an extra row to
+	 * connect the indentation.
+	 *
 	 * If there are less than 3 parents, we can immediately print the
 	 * commit line.
 	 */
 	if (graph->state != GRAPH_PADDING)
 		graph->state = GRAPH_SKIP;
+	else if (graph_needs_pre_root_line(graph))
+		graph->state = GRAPH_PRE_ROOT;
 	else if (graph_needs_pre_commit_line(graph))
 		graph->state = GRAPH_PRE_COMMIT;
 	else
@@ -1065,6 +1290,17 @@ static void graph_output_commit_line(struct git_graph *graph, struct graph_line
 
 		if (col_commit == graph->commit) {
 			seen_this = 1;
+			if (graph->is_visual_root) {
+				int depth = graph->visual_root_depth;
+				/*
+				 * Each visual column is 2 characters wide.
+				 * Omit the indentation for the first visual
+				 * root in cascade mode.
+				 */
+				int padding = (depth - graph->visual_root_cascade) * 2;
+				graph_line_addchars(line, ' ', padding);
+				graph->width += padding;
+			}
 			graph_output_commit_char(graph, line);
 
 			if (graph_needs_truncation(graph, i)) {
@@ -1436,6 +1672,29 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct graph_l
 		graph_update_state(graph, GRAPH_PADDING);
 }
 
+static void graph_output_pre_root_line(struct git_graph *graph, struct graph_line *line)
+{
+	/*
+	 * This function adds a row before a visual root, to connect the
+	 * branch to the indented commit. It should only be called on a
+	 * visual root.
+	 */
+	assert(graph->is_visual_root);
+
+	for (size_t i = 0; i < graph->num_columns; i++) {
+		struct column *col = &graph->columns[i];
+		if (col->commit == graph->commit) {
+			graph_line_addch(line, ' ');
+			graph_line_write_column(line, col, '\\');
+		} else {
+			graph_line_write_column(line, col, '|');
+		}
+		graph_line_addch(line, ' ');
+	}
+
+	graph_update_state(graph, GRAPH_COMMIT);
+}
+
 int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int shown_commit_line = 0;
@@ -1461,6 +1720,9 @@ int graph_next_line(struct git_graph *graph, struct strbuf *sb)
 	case GRAPH_PRE_COMMIT:
 		graph_output_pre_commit_line(graph, &line);
 		break;
+	case GRAPH_PRE_ROOT:
+		graph_output_pre_root_line(graph, &line);
+		break;
 	case GRAPH_COMMIT:
 		graph_output_commit_line(graph, &line);
 		shown_commit_line = 1;
diff --git a/t/meson.build b/t/meson.build
index c5832fee05..17037a8465 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -576,6 +576,7 @@ integration_tests = [
   't4215-log-skewed-merges.sh',
   't4216-log-bloom.sh',
   't4217-log-limit.sh',
+  't4218-log-graph-indentation.sh',
   't4252-am-options.sh',
   't4253-am-keep-cr-dos.sh',
   't4254-am-corrupt.sh',
diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-indentation.sh
new file mode 100755
index 0000000000..ccf15c0a52
--- /dev/null
+++ b/t/t4218-log-graph-indentation.sh
@@ -0,0 +1,467 @@
+#!/bin/sh
+
+test_description='git log --graph visual root indentations'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-log-graph.sh
+
+check_graph_with_description () {
+	cat >expect &&
+	lib_test_cmp_graph --format="%s%ndescription%nsecond-line" "$@"
+}
+
+create_orphan () {
+	git checkout --orphan "$1" &&
+	{ git rm -rf . || true; }
+}
+
+# disable commit-graph topo order to have the graph to render in different
+# ways (used in --first-parent tests to have multiple visual roots while a
+# column is active at the same time).
+unset_commit_graph() {
+	sane_unset GIT_TEST_COMMIT_GRAPH &&
+	rm -f .git/objects/info/commit-graph &&
+	rm -rf .git/objects/info/commit-graphs
+}
+
+test_expect_success 'single root commit is not indented' '
+	create_orphan _1 && test_commit 1_A &&
+	lib_test_check_graph _1 <<-\EOF
+	* 1_A
+	EOF
+'
+
+test_expect_success 'visual root indented before unrelated branch' '
+	create_orphan _2 && test_commit 2_A && test_commit 2_B &&
+	create_orphan _3 && test_commit 3_A &&
+	lib_test_check_graph _2 _3 <<-\EOF
+	  * 3_A
+	* 2_B
+	* 2_A
+	EOF
+'
+
+test_expect_success 'visual root indentation with --left-right' '
+	lib_test_check_graph --left-right _2..._3 <<-\EOF
+	  > 3_A
+	< 2_B
+	< 2_A
+	EOF
+'
+
+# A better case of why indentation is still needed with '--left-right' flag is
+# that unrelated branches can be on the same side, so it's needed to
+# differentiate visual roots on the same side.
+test_expect_success 'visual root indentation with --left-right having unrelated commits on the same side' '
+	lib_test_check_graph --left-right _2..._3 _1 <<-\EOF
+	  > 3_A
+	< 2_B
+	 \
+	  < 2_A
+	> 1_A
+	EOF
+'
+
+test_expect_success 'visual root indents the description also' '
+	check_graph_with_description _2 _3 <<-\EOF
+	  * 3_A
+	    description
+	    second-line
+	* 2_B
+	| description
+	| second-line
+	* 2_A
+	  description
+	  second-line
+	EOF
+'
+
+test_expect_success 'indented visual root parent gets connected to its child' '
+	create_orphan _4 && test_commit 4_A && test_commit 4_B &&
+	create_orphan _5 && test_commit 5_A && test_commit 5_B &&
+	lib_test_check_graph _4 _5<<-\EOF
+	* 5_B
+	 \
+	  * 5_A
+	* 4_B
+	* 4_A
+	EOF
+'
+
+test_expect_success 'indented visual root parent gets connected to its child with description' '
+	check_graph_with_description _4 _5 <<-\EOF
+	* 5_B
+	| description
+	| second-line
+	 \
+	  * 5_A
+	    description
+	    second-line
+	* 4_B
+	| description
+	| second-line
+	* 4_A
+	  description
+	  second-line
+	EOF
+'
+
+test_expect_success 'visual roots cascade and last root does not' '
+	create_orphan _7 && test_commit 7_A && test_commit 7_B &&
+	create_orphan _8 && test_commit 8_A &&
+	create_orphan _9 && test_commit 9_A &&
+	create_orphan _10 && test_commit 10_A &&
+	lib_test_check_graph _7 _8 _9 _10  <<-\EOF
+	* 10_A
+	  * 9_A
+	    * 8_A
+	* 7_B
+	* 7_A
+	EOF
+'
+
+test_expect_success 'last root does not cascade' '
+	lib_test_check_graph _8 _9 _10 <<-\EOF
+	* 10_A
+	  * 9_A
+	* 8_A
+	EOF
+'
+
+test_expect_success 'merge parents are roots between them but they do not indent' '
+	create_orphan _11 && test_commit 11_A &&
+	create_orphan _12 && test_commit 12_A &&
+	create_orphan _13 && test_commit 13_A &&
+	git checkout _11 &&
+	TREE=$(git write-tree) &&
+	MERGE=$(git commit-tree $TREE -p _11 -p _12 -p _13 -m 11_octopus) &&
+	git reset --hard $MERGE &&
+	lib_test_check_graph _11 <<-\EOF
+	*-.   11_octopus
+	|\ \
+	| | * 13_A
+	| * 12_A
+	* 11_A
+	EOF
+'
+
+# The last parent of a merge can be indented if nothing related to it needs to
+# be rendered after, if it's another visual root, merge parent must not get
+# indented but rather activate cascading.
+test_expect_success 'merge then unrelated visual root and unrelated branch' '
+	create_orphan _16 && test_commit 16_A && test_commit 16_B &&
+	create_orphan _17 && test_commit 17_A &&
+	create_orphan _18 && test_commit 18_A &&
+	create_orphan _19 && test_commit 19_A &&
+	create_orphan _20 && test_commit 20_A &&
+	git checkout _18 &&
+	TREE=$(git write-tree) &&
+	MERGE=$(git commit-tree $TREE -p _18 -p _19 -p _20 -m 18_octopus) &&
+	git reset --hard $MERGE &&
+	lib_test_check_graph _18 _17 _16 <<-\EOF
+	*-.   18_octopus
+	|\ \
+	| | * 20_A
+	| * 19_A
+	* 18_A
+	  * 17_A
+	* 16_B
+	* 16_A
+	EOF
+'
+
+# The last commit root does not get indented, if the next thing after the root
+# merge parent is the last commit, indent the merge parent.
+test_expect_success 'merge then unrelated root indents merge parent' '
+	lib_test_check_graph _18 _17 <<-\EOF
+	*-.   18_octopus
+	|\ \
+	| | * 20_A
+	| * 19_A
+	 \
+	  * 18_A
+	* 17_A
+	EOF
+'
+
+test_expect_success 'merge then unrelated branch indents merge parent' '
+	lib_test_check_graph _18 _16 <<-\EOF
+	*-.   18_octopus
+	|\ \
+	| | * 20_A
+	| * 19_A
+	 \
+	  * 18_A
+	* 16_B
+	* 16_A
+	EOF
+'
+
+test_expect_success 'two-parent merge of orphans' '
+	create_orphan _21 && test_commit 21_A &&
+	create_orphan _22 && test_commit 22_A &&
+	git checkout _21 &&
+	TREE=$(git write-tree) &&
+	MERGE=$(git commit-tree $TREE -p _21 -p _22 -m 21_merge) &&
+	git reset --hard $MERGE &&
+	lib_test_check_graph _21 <<-\EOF
+	*   21_merge
+	|\
+	| * 22_A
+	* 21_A
+	EOF
+'
+
+test_expect_success 'commit with filtered parent becomes a visual root' '
+	create_orphan _23 &&
+	echo test >other.txt &&
+	git add other.txt &&
+	git commit -m "23_A" &&
+	echo test >foo.txt &&
+	git add foo.txt &&
+	git commit -m "23_B" &&
+	create_orphan _24 &&
+	echo test >foo.txt &&
+	git add foo.txt &&
+	git commit -m "24_A" &&
+	lib_test_check_graph _23 _24 -- foo.txt <<-\EOF
+	  * 23_B
+	* 24_A
+	EOF
+'
+
+# The walker simplifies the commit for the current one and its parents, removing
+# the filtered parents, but it doesn't go one step ahead, this causes some edge
+# cases with the lookahead.
+# Given A (orphan), the walker only processes A, and when we lookahead for B
+# (child of C) even tho C will be filtered, it hasn't been simplified yet, so we
+# don't see B as a visual root, therefore cascade indentation isn't applied to A.
+# (cascade indentation starts the indentation at the second visual root, to avoid
+# redundant indentation). So A gets an extra indent, and once B is processed,
+# when rendering it, C has been removed, B is a visual root and as the last commit
+# isn't considered a visual root as it cannot have unrelated commits below it,
+# cascading isn't also applied, giving B another indent.
+#
+# The final result is an extra indent for A and B:
+#
+#	  A
+#	    B
+#	D
+#
+# This will happen for any case where we find ourselves with the next commit
+# being a unrelated child of a parent the will be filtered.
+#
+# instead of the expected:
+test_expect_failure 'filtered parent cascading edge case' '
+	create_orphan _25 &&
+	git rm -rf . &&
+	echo test >other.txt &&
+	git add other.txt &&
+	git commit -m "C-filtered" &&
+
+	echo test >foo.txt &&
+	git add foo.txt &&
+	git commit -m "B (child of filtered)" &&
+
+	create_orphan _26 &&
+	git rm -rf . &&
+	echo test >foo.txt &&
+	git add foo.txt &&
+	git commit -m "A (visual root)" &&
+
+	create_orphan _27 &&
+	git rm -rf . &&
+	echo test >foo.txt &&
+	git add foo.txt &&
+	git commit -m "D (last)" &&
+
+	lib_test_check_graph _25 _26 _27 -- foo.txt <<-\EOF
+	* A (visual root)
+	  * B (child of filtered)
+	* D (last)
+	EOF
+'
+
+test_expect_failure 'multiple filtered parents in sequence' '
+	create_orphan _44 &&
+	git rm -rf . &&
+	echo a >other.txt && git add other.txt && git commit -m "44_F" &&
+	echo b >foo.txt && git add foo.txt && git commit -m "44_C" &&
+
+	create_orphan _45 &&
+	git rm -rf . &&
+	echo c >other.txt && git add other.txt && git commit -m "45_F" &&
+	echo d >foo.txt && git add foo.txt && git commit -m "45_C" &&
+
+	create_orphan _46 &&
+	git rm -rf . &&
+	echo e >foo.txt && git add foo.txt && git commit -m "46_A" &&
+
+	lib_test_check_graph _44 _45 _46 -- foo.txt <<-\EOF
+	* 46_A
+	  * 45_C
+	* 44_C
+	EOF
+'
+
+test_expect_failure 'real orphan root followed by child of filtered parent' '
+	create_orphan _47 &&
+	git rm -rf . &&
+	echo a >foo.txt && git add foo.txt && git commit -m "47_A" &&
+
+	create_orphan _48 &&
+	git rm -rf . &&
+	echo b >other.txt && git add other.txt && git commit -m "48_filtered" &&
+	echo c >foo.txt && git add foo.txt && git commit -m "48_B" &&
+
+	create_orphan _49 &&
+	git rm -rf . &&
+	echo d >foo.txt && git add foo.txt && git commit -m "49_last" &&
+
+	lib_test_check_graph _47 _48 _49 -- foo.txt <<-\EOF
+	* 47_A
+	  * 48_B
+	* 49_last
+	EOF
+'
+
+# This tests prove why there is no need to have indentation for boundary
+# commits.
+#
+# Boundary commits rather than starting a column they 'inherit' the one of
+# its child so there will always be an edge that connects it removing the
+# ambiguity.
+test_expect_success 'unrelated boundaries are not ambiguous' '
+	create_orphan _28 && test_commit 28_A && test_commit 28_B &&
+	test_commit 28_C &&
+	create_orphan _29 && test_commit 29_A && test_commit 29_B &&
+	lib_test_check_graph --boundary 28_A.._28 29_A.._29 <<-\EOF
+	* 29_B
+	| * 28_C
+	| * 28_B
+	| o 28_A
+	o 29_A
+	EOF
+'
+
+# Same structure as t6016
+test_expect_success 'boundary commits big test' '
+	# 3 commits on branch _30
+	create_orphan _30 &&
+	test_commit 30_A &&
+	test_commit 30_B &&
+	test_commit 30_C &&
+
+	# 2 commits on branch _31, started from 30_A
+	git checkout -b _31 30_A &&
+	test_commit 31_A &&
+	test_commit 31_B &&
+
+	# 2 commits on branch _32, started from 30_B
+	git checkout -b _32 30_B &&
+	test_commit 32_A &&
+	test_commit 32_B &&
+
+	# Octopus merge _31 and _32 into -30
+	git checkout _30 &&
+	git merge _31 _32 -m 30_D &&
+	git tag 30_D &&
+	test_commit 30_E &&
+
+	# More commits on _32, then merge _32 into _30
+	git checkout _32 &&
+	test_commit 32_C &&
+	test_commit 32_D &&
+	git checkout _30 &&
+	git merge -s ours _32 -m 30_F &&
+	git tag 30_F &&
+	test_commit 30_G &&
+	lib_test_check_graph --boundary _30 _31 _32 ^32_C <<-\EOF
+	* 30_G
+	*   30_F
+	|\
+	| * 32_D
+	* | 30_E
+	| |
+	|  \
+	*-. \   30_D
+	|\ \ \
+	| * | | 31_B
+	| * | | 31_A
+	* | | | 30_C
+	o | | | 30_B
+	|/ / /
+	o / / 30_A
+	 / /
+	| o 32_C
+	|/
+	o 32_B
+	EOF
+'
+
+# Filter by --first-parent and then forcing the filtered parents to be shown.
+test_expect_success '--first-parent flag with the filtered parents' '
+	(
+		unset_commit_graph &&
+		create_orphan _35 && test_commit 35_A && test_commit 35_B &&
+		create_orphan _36 && test_commit 36_A &&
+		create_orphan _37 && test_commit 37_A &&
+		git checkout _35 &&
+		TREE=$(git write-tree) &&
+		MERGE=$(git commit-tree $TREE -p _35 -p _36 -p _37 -m 35_octopus) &&
+		git reset --hard $MERGE &&
+		lib_test_check_graph --first-parent _35 _36 _37 <<-\EOF
+		* 35_octopus
+		| * 37_A
+		|   * 36_A
+		* 35_B
+		* 35_A
+		EOF
+	)
+'
+
+test_expect_success '--first-parent with filtered parents but one has a child' '
+	(
+		unset_commit_graph &&
+		create_orphan _38 && test_commit 38_A && test_commit 38_B &&
+		create_orphan _39 && test_commit 39_A &&
+		create_orphan _40 && test_commit 40_A && test_commit 40_B &&
+		git checkout _38 &&
+		TREE=$(git write-tree) &&
+		MERGE=$(git commit-tree $TREE -p _38 -p _39 -p _40 -m 38_octopus) &&
+		git reset --hard $MERGE &&
+		lib_test_check_graph --first-parent _38 _39 _40 <<-\EOF
+		* 38_octopus
+		| * 40_B
+		| * 40_A
+		|   * 39_A
+		* 38_B
+		* 38_A
+		EOF
+	)
+'
+
+test_expect_success '--first-parent with filtered parents but both have childs' '
+	(
+		unset_commit_graph &&
+		create_orphan _41 && test_commit 41_A && test_commit 41_B &&
+		create_orphan _42 && test_commit 42_A && test_commit 42_B &&
+		create_orphan _43 && test_commit 43_A && test_commit 43_B &&
+		git checkout _41 &&
+		TREE=$(git write-tree) &&
+		MERGE=$(git commit-tree $TREE -p _41 -p _42 -p _43 -m 41_octopus) &&
+		git reset --hard $MERGE &&
+		lib_test_check_graph --first-parent _41 _42 _43 <<-\EOF
+		* 41_octopus
+		| * 43_B
+		|  \
+		|   * 43_A
+		| * 42_B
+		| * 42_A
+		* 41_B
+		* 41_A
+		EOF
+	)
+'
+
+test_done

-- 
2.54.0
