Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D63C661D
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776491; cv=none; b=aCHTTlMVIdtNv1rbp2eps8zjFy3KWKmCZ+pOXDfnHea4YreyzQqQcutjn+dVeZAR1VZzgnVnlvafK1EGzn0fwA9ACE7jmM56WwO4g3OzG9kuRv4oObODWz6mCtCGw2EMREkuiijxsGQ7fM5hU/4X04EwNs/fwcAfFyiehsT5wys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776491; c=relaxed/simple;
	bh=EO/iWgdcOxVBQNy0RJ35sEnm+9+IFdY55tmq7AOaOYY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qAspGB5ZUDVZfPIFl/VCJRi8KF7+GBw2Nnw9reAh/I9EUw9cYxsBe0GXNC+xetQv66VAJL2Lo7FS6bhoW9Pnc19JPgYrHMqlwICJcfTu8KxbR71RNSZPwhm0UmPGK6Ht9BGUsgkn+lT0/3d1TKmLUOxzOJWdFxpkxTicYOODjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4QWR60n; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4QWR60n"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381b831d535so2269027a91.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776489; x=1784381289; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OON8Pk7k+eo/s8UVr1SYEMBFclxquMRmiH8ucRL5EhQ=;
        b=G4QWR60nR3aVGA8lqOB2Apeq2gik5dAO4+ApmdeeStgnrrM+5bFTJzxZkPO6Kt59xn
         vpbOeHn8vn5wdIrOEcX/7auZOcZBkHHAbBwe8nqpL2l9HFL5x5ZAJmLKspXzRyDYcilP
         cjBCQ8gOC82x2PCzg9AjfiOTHszmqY7eOmcoRUgXAh3hlb8nJANLuEZNO7+k9AINgEOi
         Zr4zv5XESV75yROmbhKkn1g35eWyVThJ4NZBmHlA7apf6q3FaQBiboYGqAAB9mG/Byqf
         PtjMLzp7o9PGpzXR/4LEZL70hp8t6hB3KsQXtjzhbkR3QhVL+SicQQyswx4XqsxWnAoy
         fIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776489; x=1784381289;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OON8Pk7k+eo/s8UVr1SYEMBFclxquMRmiH8ucRL5EhQ=;
        b=X28bYYNQjDRS35bnmqa8ZG46H4e4VZd3unH2xbAJnCVVC8uZ3U8Jf2NMmgeZ+JVDXu
         fxzxUQPC1NFrWegBQP087KOEopKVkyvpLs/mzgKMOWyO5mV/VtApE83yqNJsW4A41VyW
         zpEJiSd3JGgeRQ7yhqHMWsXC+kcTl+DxbdsJOqkQcQrvBXJ7kqEEpOv2SJMThLRHSKjG
         FHOPHvvAjQHfLZ9ZhH+TdrERsJzs8v53vsJQ7Q1q0ZqsCMMS65/EzAztFFXnYr9Np/00
         D9k+c76yu+hRbiZgr7+duWfsHqVbz7LrIeVtElt/uE6sMJOEBnZWjJpGVO/H4rtvERaD
         n/6Q==
X-Gm-Message-State: AOJu0YzWZZ7biqFi1CIwTKM1ZqSTUEqXR2ETpLELKxv+RzP7R14J8azG
	iiI6a1unDAY1yvYQ6t3BU/aTTqVAbB4+4ceXE7TqbUg/XFjbVagV3HQrcMooXg==
X-Gm-Gg: AfdE7cm9R35UDQCDOAeYqnz6ZCZBE1qtRXWPBHa3m667d62Uwb8B8NdLy0HNsmLdpYy
	kYa810Irrjw+dUZ+AwvzePdnW+IQYfryCf3tzyg/8phPFHeT3kXFjSVgwIDNg4FUHQ7F3Yt2DCL
	JCVU/Cv+bQUARS9Oracy6nxC7PwFKnErUOXmaqkdZ7zzl9PaoxK1VKWv0tZdOa9x7AKlgxcnccq
	ZSI5g+KCEh5wyXoeu9t2FO58i1xzI04aLca2pENomBao0xSQfzx2tfC7DG+D0gevg8dwUPFtiZM
	nHN0cZdZj0kcsYQ/SplUh9TTMjJ+pWCsDmbEaKcb31EQE/vz38NTHh3WsSwAxyncCJdF/BGI3e/
	uoctaOffPJ4TcM7rBiBQHbXTzj9oMwEa5DS6XGq84izNAWbL7ixu+MgUBj0G1BPl0DmfdFSeHPg
	zWpr4aGcOnA26oH9fW/wLpWo9foQ==
X-Received: by 2002:a17:90b:4a0a:b0:37e:144d:7f6e with SMTP id 98e67ed59e1d1-38dc73bb90dmr3042950a91.3.1783776488951;
        Sat, 11 Jul 2026 06:28:08 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm48565011eec.4.2026.07.11.06.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:28:08 -0700 (PDT)
Message-Id: <6d617da1f7fb454651483994e5631fec5c9e9d37.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:45 +0000
Subject: [PATCH v6 10/10] commit-reach: remove commit-date ordering fallback
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
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
queue ordering. Benchmarks of "git merge-base --all v4.8 v4.9"
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
reached the finite generation region. The date ordering fallback
broke this invariant: a commit could have a finite topo level
while the queue was date-ordered, causing the early exit to fire
before all merge bases were found.

Also remove corrected_commit_dates_enabled() from commit-graph.c
which has no remaining callers.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       | 51 +++----------------
 commit-graph.c                                | 11 ----
 commit-graph.h                                |  6 ---
 commit-reach.c                                | 15 +++---
 t/t6600-test-reach.sh                         | 23 ++++-----
 5 files changed, 21 insertions(+), 85 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 7ae9b11529..f9978ff9f0 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -44,10 +44,6 @@ ancestor is necessarily redundant.
 INFINITY and finite generation regions
 --------------------------------------
 
-The properties in this section assume generation-number ordering (the
-default comparator). They do NOT hold when the date-ordering fallback
-is active -- see <<date-ordering-fallback>>.
-
 The commit-graph stores a generation number for each commit.
 Commits not in the commit-graph have generation
 `GENERATION_NUMBER_INFINITY`. The graph is closed under
@@ -82,10 +78,12 @@ traversal: children are always visited before their parents. This
 means that paint on already-visited commits is final -- no future
 traversal step can add paint to them.
 
-In the INFINITY region, commit-date ordering can violate this: a
-parent with a later date can be visited before a child with an earlier
-date. Paint flags are therefore NOT final at visit time, and a
-commit visited with only one side's paint may later gain the other.
+In the INFINITY region, all commits share the same generation
+value, so the queue breaks ties by commit date. This can violate
+topological ordering: a parent with a later date can be visited
+before a child with an earlier date. Paint flags are therefore
+NOT final at visit time, and a commit visited with only one
+side's paint may later gain the other.
 
 Paint flags are only added, never removed. Since each flag can be set
 at most once per commit, the number of times a commit can be
@@ -149,43 +147,6 @@ descendant of this candidate (generation ordering guarantees
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
-When the commit-graph has generation numbers v1 and no
-generation floor is specified, topological ordering
-(via generation numbers) is disabled.  Topological levels are
-correct but unbalanced -- ordering by such generation numbers
-can sometimes cause the walk to detour too far before finding
-merge bases.  Commit-date ordering typically reaches them in
-fewer steps -- see this change for more details:
-
-   091f4cf3 (commit: don't use generation numbers if not needed,
-   2018-08-30)
-
-With generation number v2 (corrected commit dates) we have the best
-of both worlds and do not need this fallback.
-
-For v1, `paint_down_to_common()` falls back to pure commit-date
-ordering via `compare_commits_by_commit_date`.  Because commit
-dates are not monotonic (clock skew, rebases, etc.), the queue
-may visit commits out of topological order.
-
-This disables the optimizations that depend on generation ordering:
-
-  - *Single result*: the first merge-base candidate found may not
-    be the shallowest, because a deeper ancestor with a higher
-    commit date can be dequeued first.
-
-  - *Side exhaustion*: one paint side can appear to drain from the
-    queue while commits from that side are still waiting with lower
-    dates, causing premature termination.
-
 Related documentation
 ---------------------
 
diff --git a/commit-graph.c b/commit-graph.c
index 9dc8bd5eee..10c2cf9023 100644
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
index 8f6c810e4f..9e491a97fd 100644
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
@@ -229,7 +227,6 @@ static int paint_down_to_common(struct repository *r,
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
-				    state.gen_ordered &&
 				    state.last_gen < GENERATION_NUMBER_INFINITY)
 					break;
 			}
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 6bf17cb7b6..445449a458 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -381,7 +381,7 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		git rev-parse pi-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 5 4 5 5
+	test_paint_down_steps 5 4 5 4
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
@@ -414,31 +414,26 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	>input &&
 	git rev-parse commit-9-1 >expect &&
 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
-	test_paint_down_steps 81 9 57 81
+	test_paint_down_steps 81 9 57 37
 '
 
 test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
-	# Verify correct merge base under clock skew.  se-D (the
-	# merge base) has a higher date than its child se-C.
-	# Generation ordering ensures se-C is visited before se-D,
-	# so P1 paint propagates correctly and se-D is found.
+	# Verify that the merge base is computed correctly even
+	# when commits have non-monotonic commit dates.
 	>input &&
 	git rev-parse se-D >expect &&
 	run_all_modes git merge-base --all se-A se-B &&
-	test_paint_down_steps 6 4 6 6
+	test_paint_down_steps 6 4 6 4
 '
 
 test_expect_success 'merge-base --all with clock skew and redundant ancestor (side-exhaustion)' '
-	# Verify correct merge base when clock skew could cause a
-	# too-deep result.  MB1 is the correct merge base; MB2 is
-	# its ancestor.  A reaches MB2 via E (high date) and MB1
-	# via C (low date).  Generation ordering ensures C is
-	# visited before side-exhaustion fires, so MB1 is found
-	# and remove_redundant correctly discards MB2.
+	# Verify that the correct merge base is found even when
+	# non-monotonic commit dates could cause a redundant
+	# ancestor to be visited first.
 	>input &&
 	git rev-parse se2-MB1 >expect &&
 	run_all_modes git merge-base --all se2-A se2-B &&
-	test_paint_down_steps 8 6 8 8
+	test_paint_down_steps 8 6 8 6
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget
