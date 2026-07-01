Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC119049B
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923852; cv=none; b=MDTx/LLb6K9DHldanI/2N5U6EOkdcq6A7m10FHWLuOOkv+knUpE3Hi6+OVdkFUd+uTAdPH6NPyohgu0Xyqc6rZIjfvxGiMH6Ph9rv5oG8fEYmTv/ah1SKIz3KHuIDljNoEhL5IYxrxRAxFJrFNtqFD9VIT2Fn1kKxYCw2ny494Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923852; c=relaxed/simple;
	bh=ET5OOJ36JqV5xMdtz+4S+2RnU9q4l/0qEgDlGILf79I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=STFcdsAjaD21bKh3QjUH7p/5lrtJS4oFYZd8Y5N6ki8VvvSg0+PHFkodKvLXogMr8jUCm2wB8vnlxWiW1Am8APWgitk/z0AiOmI+bdofSKeYgl/npIpU2apnSltKJ8XeZ0apUaQV9rBQnmWBmfb0GYRQ9Wvo3bL4m53/JWoceCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRWsD44l; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRWsD44l"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84783bce476so752807b3a.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923848; x=1783528648; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd1JcC+jyGZ3lMwd2bGKqtFuZ05IUK0D0O4QudS4cjw=;
        b=BRWsD44lFt4Q7uJs6DR0HmV7sT/Nkruh0kRCe719qPYWsfY/rD68YCk3X9JE5zkcYX
         wFSlPOoD5cAs3jeIr9DKZT4/StCDbUrmX1Ek0cPy5JkVUaaj8OdFcs1ywzJYESos9Zj8
         KfPQ/tClwQhZ6S6yNtKX+mYCW1YHKgMQ3SfL8HDGeDy4UQ4s/GdT8gpdQb8/FwsQ95zn
         V689IZKMKeiBqgZTOMlh/4ttS5DsTUfXMjulfc0vY80Nw7fQ+UBj6VyqqSODMZWvVYXa
         tG1MBZlRzY+wBwSidyS2qcSV0Dx69ZuqGWFcKgeHVpqYfJ/gb4btK5r1ZIGw/buEash1
         R4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923848; x=1783528648;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dd1JcC+jyGZ3lMwd2bGKqtFuZ05IUK0D0O4QudS4cjw=;
        b=SWhjRNaGT/DHzl9QorFogw8Te4j/+8PRGMaN1ZWqEugAHcav/jl7bP6KTycCIkkjRs
         L+iZrWeaAWXJlgH5jW04QffMY2Uiye1SUOU/sMtPjCqLSPlq92xlewQHgXrYOdX9OzKy
         +LAUh8kdVSSdYNcSq/MOQcbaTvh5C8MH+nGgFQJaPDCfpuOWHRmflLAXQzLehWkRXa00
         e2IPOcKRKBg3enhSvJM6yFHqENMuVM2e1ngs99QXeo6xu3zqTeA9k2WuqPwfIymahsHD
         NGRvdlnqeCF/sqM87kWqj9RIxecgS9jeAw1V1RCO1kH2FTyrQOlzl92S1a0rUDNV7NqP
         byWg==
X-Gm-Message-State: AOJu0Yx0A7QlsypQE29fmB7UaEvFih0LEW7GZluVAhaG6KPKskHMyS7c
	X3cTbES6DyTm0mJcHkqUZl1YCVUqME5wwZIv9nJRdGtTi5DiJZUqvTGLlLRc+A==
X-Gm-Gg: AfdE7cmgXT1FFiveTeN1oVRQ4fH9q4DyK/fWoqaDoCtXH3QHbGP8uaRN0s1nS7AfM8e
	4xUS/XJR+sMlI5YKylLT1Lk2KUSyBrh8kschTLcYdLPEuvKjQCCvGlgluuHneCvsm2kKV/5VGzB
	w8Rcc14Py10v6RKu8K53V7qMcaNOY6Jdl4c1uzo1Vr+EmSr6Z92+UY4ichEOAHji+jzqmyN0NCa
	BS3UvoAMngiawUMVQQGv+BcksjqImkE+VYc76f88/Fjvnw2xYJ00yJxkOvrV2sg/UKSr+L4oFLP
	UoTB/e4SDB/4E2liZ9knBScyPWTSSum/M4A0yaVNXjo+d6r2HygDi0KAMmVNFhjoyXBSOBBqihE
	bl13MWXfmdvgIp8llpETRVyXeSiflIEwUcwY+9PADlVYBGatJ2a5INXCjqpmhUUvKMxnZUDhMWD
	WG77aRaX/LWUGNGMQ=
X-Received: by 2002:a05:6a00:1c93:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-847c0744b00mr2157112b3a.9.1782923847536;
        Wed, 01 Jul 2026 09:37:27 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb76c0b9sm78769b3a.21.2026.07.01.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:26 -0700 (PDT)
Message-Id: <42a75899f2753e530d61c4b0b35ad4fdaae4a580.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:08 +0000
Subject: [PATCH v5 07/10] commit-reach: introduce struct paint_state with
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
became unused and are removed.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       |   9 +-
 commit-reach.c                                | 102 +++++++++++++-----
 t/t6600-test-reach.sh                         |   6 +-
 3 files changed, 83 insertions(+), 34 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index ff015c5c8f..74ba675643 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -99,15 +99,12 @@ re-enqueued is bounded by the number of flag transitions.
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
index f6a438550b..dbbbea641f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -79,21 +79,73 @@ static void clear_nonstale_queue(struct nonstale_queue *queue)
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
 }
 
-static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
+static void paint_queue_put(struct paint_state *state,
+			    struct commit *c, unsigned add_flags)
 {
-	struct commit *commit = nonstale_queue_get(queue);
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
+}
 
-	if (commit)
-		commit->object.flags &= ~ENQUEUED;
+static struct commit *paint_queue_get(struct paint_state *state)
+{
+	struct commit *commit = prio_queue_get(&state->queue);
+
+	if (!commit)
+		return NULL;
+
+	commit->object.flags &= ~ENQUEUED;
+
+	if (!state->parent1_count && !state->parent2_count &&
+	    !state->mb_candidate_count)
+		return NULL;
+
+	paint_count_update(state, commit->object.flags, -1);
 	return commit;
 }
 
@@ -109,31 +161,32 @@ static int paint_down_to_common(struct repository *r,
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
 	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
-	if (!min_generation && !corrected_commit_dates_enabled(r))
-		queue.pq.compare = compare_commits_by_commit_date;
+	if (!min_generation && !corrected_commit_dates_enabled(r)) {
+		state.queue.compare = compare_commits_by_commit_date;
+		state.gen_ordered = 0;
+	}
 
 	one->object.flags |= PARENT1;
 	if (!n) {
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
@@ -172,7 +225,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_nonstale_queue(&queue);
+				clear_prio_queue(&state.queue);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -187,12 +240,11 @@ static int paint_down_to_common(struct repository *r,
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
index 26a2a0a62f..11db9ec988 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -367,7 +367,7 @@ test_expect_success 'get_merge_bases_many:pending-stale' '
 		git rev-parse ps-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 6 6 6 6
+	test_paint_down_steps 5 5 5 5
 '
 
 test_expect_success 'get_merge_bases_many:infinity-both-sides' '
@@ -382,7 +382,7 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		git rev-parse pi-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 5 5 5 5
+	test_paint_down_steps 5 4 5 5
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
@@ -445,7 +445,7 @@ test_expect_success 'merge-base --all with clock skew returns wrong merge base (
 	>input &&
 	git rev-parse se2-MB1 >expect &&
 	run_all_modes git merge-base --all se2-A se2-B &&
-	test_paint_down_steps 8 7 8 8
+	test_paint_down_steps 8 6 8 8
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget

