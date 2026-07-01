Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026C378D94
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923856; cv=none; b=QPWGdgysoGOHdBJ6UsYCUgYX5WduRvFVRNMcqpTdfv+A9gzKYAtWN3YeknuNSnspI8Ss4LmKL4dVaeqYAWAJlyq6jxCgLaF33OeolbdxnHhDll5Nq61GBmlOJytFxwHPZcKuNLKcoK0k9C/0FfBXvz17To04YMJRxkO7+xwc3zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923856; c=relaxed/simple;
	bh=G710mvAZe3YFXUYSrfZCDeWA+DEOJALGZ6DQq7+R6DQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EFSm/ST/WN9BvO+cK8VRhMU4u+3IPAjy3w2k1YG7t7bbVGXy6UvGZwkImQXcjVkN4Fu2LacUpcrGJ8tqsSOLfK1BRNjaB8QH5uqaidRFOEcMOko5XKLXhpWYK2U8icybKP9Os29PTVnBS2uAGNpq3np0pRSLseTmSAjrMIL+jYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJ6LRk8p; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ6LRk8p"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84592b55832so480341b3a.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923854; x=1783528654; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1PFsvZxTorKpGyFI+whHjIecw3V+Fmik+8KFgGqN9Y=;
        b=aJ6LRk8pax+8QeHQompVqMjBBmzXEei+aySfMLpkc+4YVzGGMMSn2ObQCpqeCe40Ky
         QwnYBUawwCzdQvrYnohlKQ0CgEUEC9tCgJbuCLTOxa4cvQObzWw0/tMZ22ooc4x5AlJl
         Y1fnwxlywOKvQCuhh8cl8MtyM6g1vYddBnsoAmcPSHh5P2WX9bAt0kN2jiQ3y89VDxNx
         7gC0bSVOvuoH8CuqcNVwGX9x6T/3pEQ5vXLFbX4p38laxrOOMDkQ0XYBdt3DfxdsxNhF
         LQTKQBInR8UHMFjVkn9aZ+raY242/fLkw/heB59Vx2hQ6Y+O3omJ/aZvoBmNwpkIWBY6
         7lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923854; x=1783528654;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t1PFsvZxTorKpGyFI+whHjIecw3V+Fmik+8KFgGqN9Y=;
        b=XCmxTR6mkLqgU5KxhJ55Hgl3B28WPRrTo14sQ2IKWckAzIGD3E91w2qPknB7EFp7cp
         LwBxAvLYbfWdpwd3eJ9ezsoi6xOqockKK/sLgHHbYOsxwAais2WHqtYJsQ+QL9c8fSDc
         uOK09qSZHHsY5v7sYCL5DFXe0joruDtz0jY3+XF8R48hvPzhgnyGJkxhQ+1ZsZqUBSMK
         PmnTmZAviTxO/03YnI98AXdpuA1gSWi/4LnXne6jGaNKxK3qeLlFvonBToxNgnt3sbbN
         FIPZtp+kRNRyibrjAB8UHZOYNkYiJrdBOW5/cCWRQCHBpQF1yJpWLYw3MKYFOF1fB2Ok
         7TPg==
X-Gm-Message-State: AOJu0YzpxYFsgtz2HcyPm9UQ+fsjLH+uBcDnfgpfhx5GEIavjp7mJou4
	lmxtPXLkzL535lZnwfM1lqt6XYequ2cN7JVzZ9dcUkIefLYkX1tCzXpkXejVjQ==
X-Gm-Gg: AfdE7cl3bksPpE2LzCeWtTKhA6HJgENolKVRNOSgCP0n8piSr2HymFI2uH8Tb+9qRUW
	W3XjSSqCssu/ywP51rQlqIRLL0pd3+1fKDONTCiJ+XbmeZFwVibebrkS+1jwksYrl65uq+3G+r9
	MgtRhatMDDf256SWGVMQNSzXCE+5Jo6PRJLxyl460saDJ0KL2sVq94EqbxghaG+M6bHx7D2uE2f
	xCv1VVrZnnwoJ5OPDy0wPTzGnY2uZMAK3REI4qz8x7d0Dczfv+QLC60caR5RCRCcuZpiXANTB8W
	cSrKdJt8P/3YDo2RqKgHJ9s34bUj4/hCvF0pEgRbtsVgGsXJZwZhS+sVXidhKiyDLoWfXm5incO
	qKVCTt1fXGU04EQBbIb4G0RbcP9tIs4DjBM9hkunOrXljSdoKX/kUE3Qrrldv+3AgH9XeCZgV8E
	XXHhHlwAVUV1IacI4=
X-Received: by 2002:a05:6a00:e83:b0:845:e3e4:9702 with SMTP id d2e1a72fcca58-847c08c5b62mr2179329b3a.47.1782923853399;
        Wed, 01 Jul 2026 09:37:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb947651sm64656b3a.29.2026.07.01.09.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:32 -0700 (PDT)
Message-Id: <d68972b1d735db86395231c3d209f7bd42938761.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:11 +0000
Subject: [PATCH v5 10/10] commit-reach: remove commit-date ordering fallback
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Remove the fallback that switched paint_down_to_common() from
generation ordering to commit-date ordering when the commit-graph
lacks corrected commit dates (v1 graph with topo levels only).

The fallback was added in 091f4cf3 (commit: don't use generation
numbers if not needed, 2018-08-30) to avoid a performance
regression on the Linux kernel repo where v1 topo levels caused
"git merge-base v4.8 v4.9" to walk 636k commits instead of 167k.
A side branch with a low topo level stayed in the queue behind a
long chain, preventing early STALE propagation.

Side-exhaustion (added in the previous commits) solves this
differently by terminating the walk as soon as one paint side
empties from the queue, preventing the deep walk regardless of
queue ordering.  Benchmarks of "git merge-base --all v4.8 v4.9"
on the Linux kernel repo show that side-exhaustion reduces the
step count far below what the date-ordering fallback achieved:

                         steps      time
  no graph, baseline:   167,413    3.25 s
  v1 graph, baseline:   167,413    0.25 s
  v2 graph, baseline:   167,441    0.29 s
  v1 graph, this series:  5,725    0.02 s
  v2 graph, this series:  3,887    0.01 s

With generation ordering always active, the existing min_generation
check in paint_queue_get() correctly identifies when the walk has
reached the finite generation region.  The date ordering fallback
broke this invariant: a commit could have a finite topo level
while the queue was date-ordered, causing the early exit to fire
before all merge bases were found.

Also remove corrected_commit_dates_enabled() from commit-graph.c
which has no remaining callers.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       | 40 -------------------
 commit-graph.c                                | 11 -----
 commit-graph.h                                |  6 ---
 commit-reach.c                                | 14 +++----
 t/t6600-test-reach.sh                         |  8 ++--
 5 files changed, 10 insertions(+), 69 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 8a8a7a930e..7b8e483af2 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -40,20 +40,10 @@ and PARENT2, it is a merge-base candidate. A candidate gains the
 STALE flag so its ancestors propagate staleness -- any deeper common
 ancestor is necessarily redundant.
 
-NOTE: When the commit-graph uses only topological levels (generation
-number v1) and the caller passes `min_generation = 0`, a legacy
-fallback replaces the generation-ordered comparator with a pure
-commit-date comparator. This breaks the ordering invariants
-described below -- see <<date-ordering-fallback>>.
-
 [[generation-regions]]
 INFINITY and finite generation regions
 --------------------------------------
 
-The properties in this section assume generation-number ordering (the
-default comparator). They do NOT hold when the date-ordering fallback
-is active -- see <<date-ordering-fallback>>.
-
 The commit-graph stores a generation number for each commit. Commits
 not in the commit-graph have generation `GENERATION_NUMBER_INFINITY`. The
 graph is closed under reachability: if a commit is in the graph, all
@@ -154,36 +144,6 @@ descendant of this candidate (generation ordering guarantees
 children are visited first), so it cannot be redundant and the walk
 can stop immediately.
 
-This optimization is NOT safe when the date-ordering fallback is
-active, because commit-date order can visit a deeper ancestor
-before a shallower one -- see <<date-ordering-fallback>>.
-
-[[date-ordering-fallback]]
-Date-ordering fallback
-----------------------
-
-When `min_generation` is zero and the commit-graph does not contain
-corrected commit dates (generation number v1, which stores only
-topological levels), `paint_down_to_common()` replaces the default
-generation-ordered comparator with `compare_commits_by_commit_date`.
-
-This was introduced as a performance heuristic: topological levels
-are coarser than commit dates, so date ordering can reach merge
-bases in fewer steps when timestamps are well-behaved. However,
-commit dates are not required to be monotonic -- a parent can have
-a later date than its child (clock skew, rebases, etc.) -- so the
-queue may visit commits out of topological order.
-
-This disables optimizations that depend on generation ordering:
-
-  1. *Single result*: the first merge-base candidate found may not
-     be the shallowest, because a deeper ancestor with a higher
-     commit date can be dequeued first.
-
-  2. *Side-exhaustion* (see subsequent commits): one paint side can
-     appear to drain from the queue while commits from that side are
-     still waiting with lower dates, causing premature termination.
-
 Related documentation
 ---------------------
 
diff --git a/commit-graph.c b/commit-graph.c
index 801471a098..3d5d41f65a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -793,17 +793,6 @@ int generation_numbers_enabled(struct repository *r)
 	return !!first_generation;
 }
 
-int corrected_commit_dates_enabled(struct repository *r)
-{
-	struct commit_graph *g;
-
-	g = prepare_commit_graph(r);
-	if (!g || !g->num_commits)
-		return 0;
-
-	return g->read_generation_data;
-}
-
 struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 {
 	struct commit_graph *g;
diff --git a/commit-graph.h b/commit-graph.h
index 13ca4ff010..d96147a07c 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -136,12 +136,6 @@ struct commit_graph *parse_commit_graph(struct repository *r,
  */
 int generation_numbers_enabled(struct repository *r);
 
-/*
- * Return 1 if and only if the repository has a commit-graph
- * file and generation data chunk has been written for the file.
- */
-int corrected_commit_dates_enabled(struct repository *r);
-
 struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
 
 enum commit_graph_write_flags {
diff --git a/commit-reach.c b/commit-reach.c
index 871d67d07a..826c4324f2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -89,7 +89,6 @@ struct paint_state {
 	size_t parent1_count;
 	size_t parent2_count;
 	size_t mb_candidate_count;
-	int gen_ordered;
 	timestamp_t min_generation;
 	timestamp_t last_gen;
 };
@@ -166,7 +165,6 @@ static struct commit *paint_queue_get(struct paint_state *state)
 
 		/* one side is exhausted */
 		if ((!state->parent1_count || !state->parent2_count) &&
-		    state->gen_ordered &&
 		    generation < GENERATION_NUMBER_INFINITY)
 			return NULL;
 	}
@@ -187,9 +185,13 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
+	/*
+	 * Generation ordering is required for the side-exhaustion and
+	 * single-result early exits, which rely on topological traversal
+	 * order (children visited before parents) in the finite region.
+	 */
 	struct paint_state state = {
-		.queue = { compare_commits_by_gen_then_commit_date },
-		.gen_ordered = 1,
+		.queue = { compare_commits_by_gen_then_commit_date }
 	};
 	struct commit *commit;
 	int i;
@@ -198,10 +200,6 @@ static int paint_down_to_common(struct repository *r,
 
 	state.min_generation = min_generation;
 	state.last_gen = GENERATION_NUMBER_INFINITY;
-	if (!min_generation && !corrected_commit_dates_enabled(r)) {
-		state.queue.compare = compare_commits_by_commit_date;
-		state.gen_ordered = 0;
-	}
 
 	one->object.flags |= PARENT1;
 	if (!n) {
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index fd11febf1a..6a0899c44a 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -382,7 +382,7 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		git rev-parse pi-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 5 4 5 5
+	test_paint_down_steps 5 4 5 4
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
@@ -415,7 +415,7 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	>input &&
 	git rev-parse commit-9-1 >expect &&
 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
-	test_paint_down_steps 81 9 57 81
+	test_paint_down_steps 81 9 57 37
 '
 
 test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-exhaustion)' '
@@ -429,7 +429,7 @@ test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-
 	>input &&
 	git rev-parse se-D >expect &&
 	run_all_modes git merge-base --all se-A se-B &&
-	test_paint_down_steps 6 4 6 6
+	test_paint_down_steps 6 4 6 4
 '
 
 test_expect_success 'merge-base --all with clock skew returns wrong merge base (side-exhaustion)' '
@@ -445,7 +445,7 @@ test_expect_success 'merge-base --all with clock skew returns wrong merge base (
 	>input &&
 	git rev-parse se2-MB1 >expect &&
 	run_all_modes git merge-base --all se2-A se2-B &&
-	test_paint_down_steps 8 6 8 8
+	test_paint_down_steps 8 6 8 6
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget
