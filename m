Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3B425CC6
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440546; cv=none; b=IIHZw/VNYYD+s0pkrgIsUAxRuLsZUyc+ovv0gkiPjCtzzKnYbqyQ9LYD9ry32jgH7y7IJUksPhFZesdR/w4lw2UQzEgN8xsxzc8M6OZbQRP7OL0VWJjXgg4OxPuc/nkR6gbGJy2dbeJqktdzO813gP6PWtXpBUNN7hysuIJ1sOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440546; c=relaxed/simple;
	bh=J0cqh/qdklQp/aZy+RkY5qBARCaGxKFDGySeGL0KjjU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ots4LvOmagqbXIDULw+LMWpHTgxFUPwTZs8tL8dE5Tc9vcIVfkDfRfxppUswGtSqSfo/dhrTr0hRJ+Kt7R381AXowyLkJl483GiezgQNBYwiOzf0aPviADJCu3LMSxyONnTWWVZYmgLrTQQ4G1tLaVAWtpFPq+DGrsZ01RFo4FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sm/NEOu+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm/NEOu+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so3020058a91.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440543; x=1787045343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eX3Atsu/LB/YN83Exl8GZpPeGXCjFBgLgLpKF4Xc6QI=;
        b=sm/NEOu+2wTS2DwPyupXkCJYNymFmYXM1JlEC0KfwcKUeLyKOyVAZeBJA0MZFEllXI
         enH+IyTd6ZGQSysT2DAUXUMGy6tzCnm+CrCBoHhVFJQsZnoZgDbA0Sk0NZj3EtEzJNdy
         fp2nt33KlAs/ctiObp9IsrBuFjpanFb6SO9heY4HplDrnIa+qnwSvku9vEwJ3Fzi33kL
         WZ8IFQZB4LzOI8N+0X6C8oqhHUZEx+bInBncN9OzVN9TXLGFREeb1qiCXIE1VR4F/qy1
         7iPW7SfsDeXkjf6Z5n1b8qYFnDQI7IYMsA9SJ9cCP7HhWRw++m4NQX5CsP9OUj8Irmlr
         TBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440543; x=1787045343;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eX3Atsu/LB/YN83Exl8GZpPeGXCjFBgLgLpKF4Xc6QI=;
        b=Iy8QzQqchA+ByRgyvmcI6Uiq84pTC05C2flZTUYmZ7CtV3D2jelx5dBdnlsukFI08r
         6OcExuntX+W8ht1d/zw1QyHfr1JcokUosqxAmFNX+ZAs389Mklipw0yWEPjV6P5BLLdF
         S9wf9thjJN4tSjWxqNPPkBWJ+/9gy1Q4dSG0lPR0O9MYFd8BlXaWvvG2D3YRrKjAmiq+
         jo0mJF9K25ZRgwl7rDHdn4zpHf1SpQTroBf+0wGPyrmk5Xc4icVR42fDAt/tRbHaoQQd
         wni3Hr7ibcX/Iim6p3Ds4iF6A+jN47eT8LdA3AX5LkgctFWoUENJle5g1QNIAbEkONyP
         lpTw==
X-Gm-Message-State: AOJu0YzddSJX3lPx9OT0E1GmJ+vE79T5wGAbFtRKQaq2iIRFMe5FiIau
	f5G5Dfx6u07MBfG2GmKt36jwrY/gNCCV6BsppNYTU+jRRCIM7XfPeHEBK4bdKkpq
X-Gm-Gg: AR+sD123RaDfwD3s+tyUe7fGjRDr7WdlhEltivEpKsVq7ajXbinvSQxo4hDvV2XzNgq
	T7Oh+XCuLKhQEc8RXEOtjK1ygSqfSP7oxrCY+SMS0eBqT7/r+J12fXtiFdZ5tsj+75uMpkjh9zS
	ilHR3+aeiFEr35j2mui0SZte/n92hzi2BcSUBGRWjNE3rgj+XVH3xkb9rYThct0gY4aJ5Vr9Kzt
	wJYWbBAbjxo1AUzF4V6DmwTHOwjwYbW5/tYiQ2TBDPd8aAdrOH4BAF5X0uj7l89NudNJWqUT+E7
	OVGsmSzke+hsUNRWlkW3/mYoq+LI5pD9Yl+LD9p198jvZ5iQxhl+gjU6xWo6OEgvScVYP7unCIH
	8kt8YZ5NtP8pm4xMolhCKKXBCjat8Qw/LEDOAZn54HlmjbO/FtIF/xUxPaP75TdwC1T5Fp8S93L
	/CAKkWAyYIu8jiI/c256rPAu3VKQ5pVM/574YHeFOplrZ5Hg68FfR8Err8CM0Pbfg=
X-Received: by 2002:a17:90b:3c8b:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-392ec2ec34cmr2226369a91.2.1786440543412;
        Tue, 11 Aug 2026 02:29:03 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51c3727sm2956371a91.5.2026.08.11.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:02 -0700 (PDT)
Message-Id: <bbb83f8eaaee8bf8aaed9668336859fe650c7886.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:49 +0000
Subject: [PATCH v8 07/10] commit-reach: introduce struct paint_state with
 per-side counters
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

Add a paint_state struct for use by paint_down_to_common() that
wraps a prio_queue with per-side commit counters. Each non-stale
queued commit occupies exactly one counter bucket based on its
paint flags: PARENT1-only, PARENT2-only, or both sides (a pending
merge-base candidate).

The counters are maintained by paint_count_update() which adjusts
the appropriate bucket by a signed delta. An exhaustive switch on
the paint+stale bits documents all valid flag combinations in one
place.

Convert paint_down_to_common() to use paint_state. The loop now
drains the queue via paint_queue_get() which returns NULL when all
counters reach zero, replacing the old pointer-based termination
(max_nonstale). This is equivalent behavior -- both conditions
detect that no non-stale entries remain.

paint_queue_get() uses a "pop first" form: it dequeues a commit,
then checks the counters. This means the loop exits one iteration
earlier than the old code in some topologies (the popped stale
commit is never processed), so a few step counts drop by one.

The existing nonstale_queue is left in place for ahead_behind(),
though nonstale_queue_put_dedup() and nonstale_queue_get_dedup()
become unused and are removed.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       |   9 +-
 commit-reach.c                                | 112 +++++++++++++-----
 t/t6600-test-reach.sh                         |   6 +-
 3 files changed, 91 insertions(+), 36 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 4bd3c2adb5..acf32bacd4 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -93,15 +93,12 @@ re-enqueues per commit.
 Termination
 -----------
 
-The walk uses a `nonstale_queue` wrapper around `prio_queue` that
-tracks `max_nonstale`: the lowest-priority non-stale commit enqueued
-so far. Once that commit is dequeued, every remaining entry is known
-to be STALE and the loop terminates. Specifically, the main loop
+The walk tracks the number of commits of each type in the queue
+(PARENT1-only, PARENT2-only, pending merge-base). The main loop
 ends when one of the following conditions holds:
 
   1. The queue is empty.
-  2. `max_nonstale` has been dequeued, meaning the queue only contains
-     STALE entries.
+  2. The queue contains only stale entries.
   3. Generation cutoff: the dequeued commit's generation is below
      a caller-supplied `min_generation` threshold.
   4. Single result: the caller only needs one merge base, one has
diff --git a/commit-reach.c b/commit-reach.c
index d59e76a2e2..0f5ffec36e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -79,21 +79,82 @@ static void clear_nonstale_queue(struct nonstale_queue *queue)
 	queue->max_nonstale = NULL;
 }
 
-static void nonstale_queue_put_dedup(struct nonstale_queue *queue,
-				     struct commit *c)
+/*
+ * Priority queue with per-side commit counters for paint_down_to_common().
+ * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
+ * PARENT2-only, or both (a pending merge-base candidate).
+ */
+struct paint_state {
+	struct prio_queue queue;
+	size_t parent1_count;
+	size_t parent2_count;
+	size_t mb_candidate_count;
+	int gen_ordered;
+};
+
+static void paint_count_update(struct paint_state *state,
+			       unsigned flags, int delta)
 {
-	if (c->object.flags & ENQUEUED)
-		return;
-	c->object.flags |= ENQUEUED;
-	nonstale_queue_put(queue, c);
+	switch (flags & (PARENT1 | PARENT2 | STALE)) {
+	case PARENT1:
+		state->parent1_count += delta;
+		break;
+
+	case PARENT2:
+		state->parent2_count += delta;
+		break;
+
+	case PARENT1 | PARENT2:
+		state->mb_candidate_count += delta;
+		break;
+
+	case PARENT1 | PARENT2 | STALE:
+		break;
+
+	default:
+		BUG("unexpected paint state");
+	}
+}
+
+static void paint_queue_put(struct paint_state *state,
+			    struct commit *c, unsigned add_flags)
+{
+	unsigned old_flags = c->object.flags;
+	c->object.flags |= add_flags;
+
+	if (old_flags & ENQUEUED) {
+		paint_count_update(state, old_flags, -1);
+		paint_count_update(state, c->object.flags, 1);
+	} else {
+		c->object.flags |= ENQUEUED;
+		prio_queue_put(&state->queue, c);
+		paint_count_update(state, c->object.flags, 1);
+	}
 }
 
-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
+/*
+ * Dequeue the next commit for the paint walk, or return NULL when
+ * no more merge bases can be discovered.
+ */
+static struct commit *paint_queue_get(struct paint_state *state)
 {
-	struct commit *commit = nonstale_queue_get(queue);
+	struct commit *commit = prio_queue_get(&state->queue);
+
+	if (!commit)
+		return NULL;
+
+	commit->object.flags &= ~ENQUEUED;
+
+	/*
+	 * Check exit condition before decrementing: the counters
+	 * still include this commit, so the last non-stale commit
+	 * sees a non-zero count and is returned for processing.
+	 */
+	if (!state->parent1_count && !state->parent2_count &&
+	    !state->mb_candidate_count)
+		return NULL;
 
-	if (commit)
-		commit->object.flags &= ~ENQUEUED;
+	paint_count_update(state, commit->object.flags, -1);
 	return commit;
 }
 
@@ -109,18 +170,19 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
-	struct nonstale_queue queue = {
-		{ compare_commits_by_gen_then_commit_date }
+	struct paint_state state = {
+		.queue = { compare_commits_by_gen_then_commit_date },
+		.gen_ordered = 1,
 	};
+	struct commit *commit;
 	int i;
-	int gen_ordered = 1;
 	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
-		queue.pq.compare = compare_commits_by_commit_date;
-		gen_ordered = 0;
+		state.queue.compare = compare_commits_by_commit_date;
+		state.gen_ordered = 0;
 	}
 
 	one->object.flags |= PARENT1;
@@ -128,15 +190,12 @@ static int paint_down_to_common(struct repository *r,
 		commit_list_append(one, result);
 		return 0;
 	}
-	nonstale_queue_put_dedup(&queue, one);
+	paint_queue_put(&state, one, 0);
 
-	for (i = 0; i < n; i++) {
-		twos[i]->object.flags |= PARENT2;
-		nonstale_queue_put_dedup(&queue, twos[i]);
-	}
+	for (i = 0; i < n; i++)
+		paint_queue_put(&state, twos[i], PARENT2);
 
-	while (queue.max_nonstale) {
-		struct commit *commit = nonstale_queue_get_dedup(&queue);
+	while ((commit = paint_queue_get(&state))) {
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
@@ -162,7 +221,7 @@ static int paint_down_to_common(struct repository *r,
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
-				    gen_ordered &&
+				    state.gen_ordered &&
 				    generation < GENERATION_NUMBER_INFINITY)
 					break;
 			}
@@ -176,7 +235,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_nonstale_queue(&queue);
+				clear_prio_queue(&state.queue);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -191,12 +250,11 @@ static int paint_down_to_common(struct repository *r,
 				return error(_("could not parse commit %s"),
 					     oid_to_hex(&p->object.oid));
 			}
-			p->object.flags |= flags;
-			nonstale_queue_put_dedup(&queue, p);
+			paint_queue_put(&state, p, flags);
 		}
 	}
 
-	clear_nonstale_queue(&queue);
+	clear_prio_queue(&state.queue);
 	trace2_data_intmax("paint_down_to_common", r,
 			   "steps", steps);
 	commit_list_sort_by_date(result);
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 2a6c7c656e..9f3a8f4743 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -366,7 +366,7 @@ test_expect_success 'get_merge_bases_many:pending-stale' '
 		git rev-parse ps-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 6 6 6 6
+	test_paint_down_steps 5 5 5 5
 '
 
 test_expect_success 'get_merge_bases_many:infinity-both-sides' '
@@ -381,7 +381,7 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		git rev-parse pi-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 5 5 5 5
+	test_paint_down_steps 5 4 5 5
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
@@ -433,7 +433,7 @@ test_expect_success 'merge-base --all with clock skew and redundant ancestor (si
 	>input &&
 	git rev-parse se2-MB1 >expect &&
 	run_all_modes git merge-base --all se2-A se2-B &&
-	test_paint_down_steps 8 7 8 8
+	test_paint_down_steps 8 6 8 8
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget

