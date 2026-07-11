Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7E3921DB
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783776485; cv=none; b=h3cbzgkwijzyu8iKdo4ikGUu8WCJq4aCM42a99hxLx7Xa0ce1+PDhtbkce408lJUTLxalwKEomfQs/P3BTbmQFOhkmYOSjiljFZzDq7QEs/vN1DUMDgrORtk9fSZ83/+TKntV1Do9vTEfgOrSiz6xBku8dENP529ls52CDQGV58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783776485; c=relaxed/simple;
	bh=oK4gdKcGub62Yf+KF3PqNMyoVOtV5lcwgFhUDN8W7+M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bweCrJRJetIEkXUvk8U9XtF2wsZYSeamEPM4NxogQ/Lxmz0V57p7qk74cHM9/7618mulwD4Yw0Cj8yp4QuO3JqeNJJdbJo7NfFdD67DCTx6URB5scjSORvys1AECkGVpe7MpR2DrBFxsTut7PtBSVQ6sSnpszEpOCIhbzV2VEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKAF1gT2; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKAF1gT2"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1351443a12.1
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783776484; x=1784381284; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2t64j8xIdhzc7rxoACJMDdj3bVwCcmyBpg4mXfDo4Hk=;
        b=mKAF1gT2vGVMpGRqEFt7QQW7bjQ5Qu5XoucBOmd68YP+nPDnNRjwWK9g6+VW8fRQDO
         rjOwuhk4Ct/ubHNvCS5wofR454iQnLdV3Pwjk2BE439EvhohXgryCquI3UTSM4FDzsoN
         tcS0AQGHtmOabcdILVCiyTXX/sUpvzQ+/MVSoNapakSmOpoDuHJTF+ZWQHTFJBcVoZQG
         H7NvAf3sBs2fOoOIWOIEIY6cHPTaFAhPFFlyw+kB/OfO1hs0RAtWJkKmLywAC5EtqGOi
         evsYLqDD+Xfh2EriTfainn+nBECWnTSye/OHV15Hz6UuoAaoTRWQPRY1JZOxjcWEWh00
         3JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783776484; x=1784381284;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2t64j8xIdhzc7rxoACJMDdj3bVwCcmyBpg4mXfDo4Hk=;
        b=Odx3TxL6tZVK8cUk1/UvpUdD0K0y/5y13FChr5Qvdm1a6T/cUmh/NQkG8HjitDN+YM
         rburL3RuBXXcSjJSPapWBZecDyxPAYJbqHgo7wyr9RX853iQvN2XR3SBEizZX5406ELA
         4V0B3B8HSLfFVfJHWkyswWV4y4e/FjnCqLTy60L6iWnmjPh3Y+t5VhevKzIXqhpLpOqH
         O1sGYWcmLDfdiqNqlqGRe86y3L6RBw/wVIl5irEi6E1E+PzJDrOIaZZFOijYHeTzCbK1
         apJcZKrZhnnode03bp3JOA4l4FSmwx2n9zynbEFU3O72QkezPw3Q9M9X+uVRomDg47C2
         CROQ==
X-Gm-Message-State: AOJu0YxlFxmon5P6mt036dI0EWGfkmIlhcs851+xiawnd0+sY0rTSx42
	CK6VXdjVt1r5XEF2R6TGKXfZvPuJ+ZJiqyJMma3g/zf33wMeWUwa15MHH5hHug==
X-Gm-Gg: AfdE7ck6+s4hCk9fw8PySRnu2r0DQPqf+X6d/+s4uvqgY+w+1MYZpeQyPhnOtf/VwkU
	cTMsFHQ2QywesRmWJmFOpi1PAZdddq1wdYy60yVO2P9UPuTt70MCkmv94lG2zjiyvCN/w6rIuFH
	rCzXQVXozO8EvnXxMXZeaAD0MC6NoiH4UibGXbR8Cmtxp/c/6ny2kq9HCHtzJhbJTcu67KFu19/
	GJo07DYDXI7FHgC8KniFzJcLnKkScw2pBo97bO0BkzUBNEQKN0Zzup2E8IM0eteIB034Na0iTD1
	EeuUsMLm1wTL1oMENP/00RWakQ0f9qru7c/ykxxqqMhPLIVfoOoT79ZWH65WH3dqfBLM/gGiqAg
	3quPmBsStodDWwBmx6A32Kbf8pZLHVFtOuzXsjohXMvfYNfrEUJBQPOh+k2ka88LII8j4hdYK6r
	u/h5hZOvSNMu+bcts=
X-Received: by 2002:a05:6a20:918e:b0:3bf:7f0b:2f6e with SMTP id adf61e73a8af0-3c1108cf016mr3508167637.46.1783776483769;
        Sat, 11 Jul 2026 06:28:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.76.184])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b8deb2a21sm6992184c88.3.2026.07.11.06.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 06:28:02 -0700 (PDT)
Message-Id: <92a327a94c5739664dce359b3bcd00a045de1b72.1783776466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
References: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
	<pull.2149.v6.git.1783776466.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jul 2026 13:27:42 +0000
Subject: [PATCH v6 07/10] commit-reach: introduce struct paint_state with
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Kristofer Karlsson <krka@spotify.com>,
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
 commit-reach.c                                | 103 +++++++++++++-----
 t/t6600-test-reach.sh                         |   6 +-
 3 files changed, 82 insertions(+), 36 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index c203f14455..3b3f7ac8af 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -94,15 +94,12 @@ re-enqueued is bounded by the number of flag transitions.
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
index ee1632d724..ed5e935efd 100644
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
+	if (!state->parent1_count && !state->parent2_count &&
+	    !state->mb_candidate_count)
+		return NULL;
 
-	if (commit)
-		commit->object.flags &= ~ENQUEUED;
+	paint_count_update(state, commit->object.flags, -1);
 	return commit;
 }
 
@@ -109,18 +161,19 @@ static int paint_down_to_common(struct repository *r,
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
@@ -128,15 +181,12 @@ static int paint_down_to_common(struct repository *r,
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
@@ -162,7 +212,7 @@ static int paint_down_to_common(struct repository *r,
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
-				    gen_ordered &&
+				    state.gen_ordered &&
 				    generation < GENERATION_NUMBER_INFINITY)
 					break;
 			}
@@ -176,7 +226,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_nonstale_queue(&queue);
+				clear_prio_queue(&state.queue);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -191,12 +241,11 @@ static int paint_down_to_common(struct repository *r,
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
index 55aa220bb3..f9895f5fd7 100755
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
@@ -438,7 +438,7 @@ test_expect_success 'merge-base --all with clock skew and redundant ancestor (si
 	>input &&
 	git rev-parse se2-MB1 >expect &&
 	run_all_modes git merge-base --all se2-A se2-B &&
-	test_paint_down_steps 8 7 8 8
+	test_paint_down_steps 8 6 8 8
 '
 
 test_expect_success 'reduce_heads' '
-- 
gitgitgadget

