Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B342A154
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440549; cv=none; b=Awqc+ZVb0WuQMD2KeCZDxGrb4DE2shVC++9iPwbKt/XWnuUoetXKhNFhwDu71euby2/nFLdqZvs7z9cU2lCvAMqCPkCjzpYyiwUkjp10cYfgbK+W4b3yWlP+ugERo77XCjXkWjggH1zv8Uter5Dl7kw4Hv5gm43YZLzfKX31Dz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440549; c=relaxed/simple;
	bh=DdgvmoscZVK2Pq3oe2cBT0IyYI/B46He33OkUHgdzCg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eFjxyv6j/7Cxhg4DuWyQaIpFbOrqdi0OJ+/2Jo8EJ0/0Lxg633hNzigmiGDSZF3yT0oKIKzN+s2f2KP4e8BDWZ12kP0jDWPxOqlLaSFJCjk7RMjz5s9QX0TeVBxL6VOUmeInubhOQtVxR76WmG3ru9oqDzBtAIH9KAICcK8H5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZux/y98; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZux/y98"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3521995a91.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440545; x=1787045345; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6TBgPq55HfNezxxr0E6tsaFLCXFjvEM5Z3iM0gI1R1A=;
        b=OZux/y98Iw1lzGtqAD6sUFz+taIfUe/TvTG8W0HDYtLLeBsv69qsCcyL9XBMnMR6rj
         WB5OAaO05BTlXbcux8l+XM2HpzWWVhJCfbAVZLilBNNvSfUXSu3tSjF3uQif8Yvw6Eev
         UlFfTarWC8e78HT5UVxpD6tBabvQ3U7p4B9hvIPz9y2pDGEZZvt0+7H9qbmLBXBkf/Ky
         90/l/pojq4CbI48AbAUn/La/ajHmBcWXixGx1/YMcV3pNkfLshVMNNF15MnKSlmQNgYZ
         d0+S8YR8QU3hbPdGfL/UoDzChFScezACPeQA332jMrpR4s1XY2F/pYE2CMd41PAoo7Z8
         oYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440545; x=1787045345;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6TBgPq55HfNezxxr0E6tsaFLCXFjvEM5Z3iM0gI1R1A=;
        b=PEBLx6Htmfne3M+0/BhAFuQqgKUbBrkSn8F6+7wFeDMYo4jHHJbdQYBewjYZpqR/yb
         V/dr51+OBrAz3Nf/PGr9poM6HAQjsMevwZ7IPMvUbZfF3tXFxLuIUaqg7gmin2cJQakM
         teo66+yB81d0dyNAhKXKcgZorFedZJWQADZxUJKgz2IPJqdxY0Wvp/dBBRCrhqeCj+qI
         KZ6l2J50+mmA8G4sh7KQ45VUGsisjB/CeLuUlpRp9m+86/loADvvlHu9tSqZmxHi8C/v
         FYA/B9iZjHnLjz7d9d6FQXfDgGDPPMkvqsAO4S3M/0HJ6Qn/45K4q+VQFQ/9YnGiq5eQ
         PJkA==
X-Gm-Message-State: AOJu0YzQZOsnABimY4oTKnqruMVQcq3YhOVdxHobTV0+3+BorlDe9SHF
	hAn1woievMGlArggvR8G4eOz+DclGrWdXB46hvAHu7/fWSOeNnS1BDlaAvmf1emV
X-Gm-Gg: AR+sD12pNpeApSZ0CKxz/Th/YxvfVcH78swjRFImNK3EacsFssio2iKQYv6EllIiGHL
	1CbpkP6MqPnIig6eHkgabLMmOuM+Vo0iOHgeAkjctBbZWhg0rvzxu+BQooPKRGZZZiZGYo/8v+9
	91mTubRbXtzfE7eEK2QMZcNIQ8gTF8pQF4NMXgba55tfOtiJ4PhI+//P5X4qWXd4Vrw/dozQkje
	SROgHXQS+0af8rGjec3GHlLFiLUml8yQXAB0WOabVPtJUmQwEVC72Ot0XJiWq7kX1vxRpjqJHLQ
	Nq0wUNPUvBgwi4Kq8hNPjAZT7Uen4aNmV7PgDNSesqaTlpe6ODmKJ0i10mDwaf50gN+55yDqGkH
	daohkAlpEt30FpGvATc7Pt6MWhw5NIKyBHi3HBdZ43l924GlYkUFDOYy6VvB6YGw5vnRb6FConf
	0ZwLLcDAC80poIGGOmGNSMUgtotUQA8DeSVCLCkbQokcDxgP6ZuVs4ETNHjidRBfO2YITPGQIEG
	w==
X-Received: by 2002:a17:90b:4d0a:b0:392:c80c:9202 with SMTP id 98e67ed59e1d1-392ec5b6b24mr1761030a91.14.1786440544495;
        Tue, 11 Aug 2026 02:29:04 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392ee3eadd3sm1271709a91.12.2026.08.11.02.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:04 -0700 (PDT)
Message-Id: <4a6603731cf0256a6aaede225b19c536db9cff0e.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:50 +0000
Subject: [PATCH v8 08/10] commit-reach: terminate merge-base walk when one
 paint side is exhausted
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

Add an early termination check to paint_down_to_common() using the
per-side counters introduced earlier. Once the walk enters the
ordered region, terminate early when one side's exclusive count
drops to zero -- no new merge-base can form without both paint
sides meeting.

The check also waits for pending_merge_bases to reach zero, ensuring
all merge-base candidates have been dequeued and recorded before
exiting.

The optimization is gated by gen_ordered (which excludes v1
commit-graphs that use the date-ordering fallback) and by a
generation check against topo_ceiling. topo_ceiling is
GENERATION_NUMBER_INFINITY for v2 graphs and
GENERATION_NUMBER_V1_MAX for v1 graphs, so that saturated commits
are treated as unordered. Together these ensure the check only
fires in the ordered region where topological ordering holds.

The same topo_ceiling boundary is applied to the existing
single-result early exit so that all generation-dependent gates
express the same saturation-aware boundary consistently.

Step counts measured with trace2 on git.git with commit-graph:

  merge-base --all v2.0.0 v2.55.0-rc1:
    before: 72264 steps    after: 44589 steps

  merge-base --all v2.55.0-rc1 v2.55.0-rc1~5:
    before:   110 steps    after:     7 steps

Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       | 25 +++++++++++++++++--
 commit-reach.c                                | 20 ++++++++++++---
 t/t6600-test-reach.sh                         |  4 +--
 3 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index acf32bacd4..2393bb03b6 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -76,7 +76,11 @@ its child.
 Commits not in the commit-graph have generation INFINITY; v1
 commit-graphs saturate at V1_MAX. Both place commits in the
 unordered region. Any optimization that depends on generation
-ordering must account for this saturation boundary.
+ordering must account for this saturation boundary. The early
+exit gates compare against a topological ceiling --
+`GENERATION_NUMBER_V1_MAX` for v1 graphs and
+`GENERATION_NUMBER_INFINITY` for v2 graphs -- so that saturated
+commits are treated as unordered.
 
 With generation ordering, values in the unordered region exceed
 those in the ordered region. The walk may therefore transition
@@ -103,6 +107,9 @@ ends when one of the following conditions holds:
      a caller-supplied `min_generation` threshold.
   4. Single result: the caller only needs one merge base, one has
      been found, and the walk has entered the ordered region.
+  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
+     remain in the queue, no pending merge-base candidates exist,
+     and the walk has entered the ordered region.
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
@@ -113,6 +120,16 @@ existing candidates by proving one is an ancestor of another, but
 `remove_redundant()` handles that as a post-processing step, so it
 is safe to exit early.
 
+Side-exhaustion condition
+~~~~~~~~~~~~~~~~~~~~~~~~~
+A new merge-base requires commits from both sides to meet. When one
+side's exclusive counter reaches zero and there are no pending
+merge-base candidates, no future traversal step can produce a new
+candidate. This optimization only activates in the ordered region,
+where paint flags are final at visit time; in the unordered region,
+a side that appears exhausted could reappear through late paint
+propagation.
+
 Generation cutoff
 ~~~~~~~~~~~~~~~~~
 Some callers (notably `remove_redundant()`) supply a `min_generation`
@@ -158,12 +175,16 @@ ordering via `compare_commits_by_commit_date`. Because commit
 dates are not monotonic (clock skew, rebases, etc.), the queue
 may visit commits out of topological order.
 
-This disables the optimization that depends on generation ordering:
+This disables the optimizations that depend on generation ordering:
 
   - *Single result*: the first merge-base candidate found may not
     be the shallowest, because a deeper ancestor with a higher
     commit date can be dequeued first.
 
+  - *Side exhaustion*: one paint side can appear to drain from the
+    queue while commits from that side are still waiting with lower
+    dates, causing premature termination.
+
 Related documentation
 ---------------------
 
diff --git a/commit-reach.c b/commit-reach.c
index 0f5ffec36e..7c5bbe00c3 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -90,6 +90,7 @@ struct paint_state {
 	size_t parent2_count;
 	size_t mb_candidate_count;
 	int gen_ordered;
+	timestamp_t topo_ceiling;
 };
 
 static void paint_count_update(struct paint_state *state,
@@ -150,9 +151,17 @@ static struct commit *paint_queue_get(struct paint_state *state)
 	 * still include this commit, so the last non-stale commit
 	 * sees a non-zero count and is returned for processing.
 	 */
-	if (!state->parent1_count && !state->parent2_count &&
-	    !state->mb_candidate_count)
-		return NULL;
+	if (!state->mb_candidate_count) {
+		/* only stale entries remain */
+		if (!state->parent1_count && !state->parent2_count)
+			return NULL;
+
+		/* one side is exhausted */
+		if ((!state->parent1_count || !state->parent2_count) &&
+		    state->gen_ordered &&
+		    commit_graph_generation(commit) < state->topo_ceiling)
+			return NULL;
+	}
 
 	paint_count_update(state, commit->object.flags, -1);
 	return commit;
@@ -180,6 +189,9 @@ static int paint_down_to_common(struct repository *r,
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
+	state.topo_ceiling = corrected_commit_dates_enabled(r)
+		? GENERATION_NUMBER_INFINITY
+		: GENERATION_NUMBER_V1_MAX;
 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
 		state.queue.compare = compare_commits_by_commit_date;
 		state.gen_ordered = 0;
@@ -222,7 +234,7 @@ static int paint_down_to_common(struct repository *r,
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
 				    state.gen_ordered &&
-				    generation < GENERATION_NUMBER_INFINITY)
+				    generation < state.topo_ceiling)
 					break;
 			}
 			/* Mark parents of a found merge stale */
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 9f3a8f4743..23417897c8 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -297,7 +297,7 @@ test_expect_success 'in_merge_bases_many:self' '
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
 	test_all_modes in_merge_bases_many &&
-	test_paint_down_steps 45 2 25 3
+	test_paint_down_steps 45 1 25 1
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -414,7 +414,7 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	>input &&
 	git rev-parse commit-9-1 >expect &&
 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
-	test_paint_down_steps 81 80 81 81
+	test_paint_down_steps 81 9 57 81
 '
 
 test_expect_success 'merge-base --all with clock skew (side-exhaustion)' '
-- 
gitgitgadget

