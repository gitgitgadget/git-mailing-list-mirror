Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E74448CF6
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014010; cv=none; b=iqDzhX0x0dtlQR26fFci4A2O3YwrKcKJxiYpAvAapbYjddQLxS5b2bpoIaFQ3SF2cIdfRArpd8ZC0UujM0V6qomMJQkGykbABwz7ENAE4h7Rmxx/oggOHg6+pBUcLAfM6VmLbCDr0WknITgHmKJcp3cG1jM93FU7KFGrHPaaBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014010; c=relaxed/simple;
	bh=CCYitPC2N+zQNM5vWQ0wWXeyMZ4+ro6QD4YDiihGMVA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CTmrC3GSmNJzA3IyRvxK5q2oHRs7zy+jCcFvyVtJ0Ffxx+JBTj2PVsil+wawwKu7FiZua+KbW+0QMyfe6F9SaY3D85RRJLuufwF0cG1/771nLuEKqm9tBQfaGbWVVaI4MwWKyBAoSbx8wrDVF1Ccm1yxnZ6R6UAkUfm0HaYtELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go5CouFo; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go5CouFo"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-82011c59e66so39445217b3.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014007; x=1786618807; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rGiu3nxQS8VqGQd5zNr0zvVOuwzmA5xaUy2APbX8uz8=;
        b=Go5CouFoGbODMuX/ca5RY1vdhTzx3/izKLExVymXGFllI+Q3gbNMvk21TluzswET5v
         cwqoe1V1a+4+W/Wi1jPyDo7CXREv/mP5+AIu5TvGupOYkTnkK8f1bx+cUM8S9p60Utcs
         SLrkFV4W8Zc79fjbVf6m9ed1qy4YopIqSY+AyYUifkGdy+50x1badkvztBbjkGqyQkRX
         PXOB4Ad/1CCN47oZ+yTk50oxFXSFA2UKBDUkujFGhUx592c512FR79a9AxdwyhpITExM
         MeStEFkMMtbFbq/c4rwiyiAKbBrPly7wVvERYf8cfT6J5qLc7ErJs2qQj6SOJ8s+9nOp
         zAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014007; x=1786618807;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rGiu3nxQS8VqGQd5zNr0zvVOuwzmA5xaUy2APbX8uz8=;
        b=MswUWMwV5kd/9FNhSFOHKUPs0/h2V1LdfOSkRh8ZfwsM+nRoAeHHgeRtsgKd9cK7j0
         9g8uGVYmAfLaTZZ6jgBxrmn5/8I4uixsxMocemP0EBHKq6gwkRDpexBQtuanR5HzDBOb
         DTjgTLRZlmpU2vhssU5ylR0Hbbx1157QfhQaI8G2qqvoFWJ5IrDFxCAEHdC2mvSP5S8n
         yELfGKjf+Mt8sEtndYaELF+qAmfHKwy+nwVSIAcfKuZzymhjcauYWNMyD0sYOqTe8BPM
         pHyRGsmXHIeG3tH40eICdN0AmCbekTm2UcYQiOUj2y5Q+hicxSn8F1wOG81AKMaKOxyE
         OLkw==
X-Gm-Message-State: AOJu0Yx343ymKzjdQVZS3zzYv2FHByYOTc0iB9qXTmwypUwCK60YiBjC
	2euE5rfj3R14AUs+ToWqZontFuSfMMA8SnW+xDjcZrLcSOSiUXV2aMEXUtA1Og==
X-Gm-Gg: AR+sD10TP6WT/JUQgsOjdV3cNkviIGBzu6BRHWErT8K1WIWd44CyUTLmlIpXq/CgQnC
	9DnTBL81M90c/f3u+oPJhRyNQbLn9iKrNf7hz1dN0+oC2Edsk2mPU3LZTLp1UfMCO/yE5eZ4paS
	7vz2BqTxnZX8pUcSNihTbVflf9Vq0QU5kO1pd4Oo+vazPqFFEiTDKeVgA9H64lor2klKf5K6WtW
	MWHoLCTwfvr0NIW1XmXMZ9s8O1EVG9JUvduBUfjolLJnHUK16K6JbGiESU27IXDk99nURcVh7F7
	6HjhRJb9zm2g9wGG5y6XoyLP8BBdWlzfYXJcOHItkxkLjnssVNshjRqh6jEs6tG9ee+PC9pv+LJ
	Fp/rLFisNKFkBY728MQEKQKvuHLQxO1sOnLBrxKcdhiXioNfrgjWFiYEFjybTMlNrkdcm8o5fTg
	ddo62eNWnwArEflsDyZT9wv6oa1E4bYAC5liMvekXAOekModYuLYd9rjQ4iv53j68=
X-Received: by 2002:a05:690c:601:b0:81e:7075:e2e3 with SMTP id 00721157ae682-82022630960mr83268277b3.35.1786014007399;
        Thu, 06 Aug 2026 04:00:07 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-820131db2f2sm35971867b3.9.2026.08.06.04.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:00:06 -0700 (PDT)
Message-Id: <391fa07783a7819a60c0b0c2a3ea86fb13c95079.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:39 +0000
Subject: [PATCH v7 08/10] commit-reach: terminate merge-base walk when one
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
finite-generation region, terminate early when one side's exclusive
count drops to zero -- no new merge-base can form without both paint
sides meeting.

The check also waits for pending_merge_bases to reach zero, ensuring
all merge-base candidates have been dequeued and recorded before
exiting.

The INFINITY gate ensures correctness: commits without a commit-graph
entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
which is not topologically reliable. The optimization only fires
once the walk enters the finite-generation region where ordering
guarantees hold.

Step counts measured with trace2 on git.git with commit-graph:

  merge-base --all v2.0.0 v2.55.0-rc1:
    before: 72264 steps    after: 44589 steps

  merge-base --all v2.55.0-rc1 v2.55.0-rc1~5:
    before:   110 steps    after:     7 steps

Helped-by: Derrick Stolee <stolee@gmail.com>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       | 23 ++++++++++++++++++-
 commit-reach.c                                | 18 ++++++++++++---
 t/t6600-test-reach.sh                         |  4 ++--
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 37fa6f93c1..7c93f7e676 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -114,6 +114,9 @@ ends when one of the following conditions holds:
   4. Single result: the caller only needs one merge base, one has
      been found, and the walk has entered the finite-generation
      region.
+  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
+     remain in the queue, no pending merge-base candidates exist,
+     and the walk has entered the finite-generation region.
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
@@ -124,6 +127,20 @@ existing candidates by proving one is an ancestor of another, but
 `remove_redundant()` handles that as a post-processing step, so it
 is safe to exit early.
 
+Side-exhaustion condition
+~~~~~~~~~~~~~~~~~~~~~~~~~
+A new merge-base requires commits from both sides to meet. When one
+side's exclusive counter reaches zero and there are no pending
+merge-base candidates, no future traversal step can produce a new
+candidate.
+
+This optimization only activates in the finite-generation region
+where topological ordering holds. In that region, children are
+always visited before parents, so paint flags are final at visit
+time and an exhausted side cannot reappear. In the INFINITY region,
+commit-date ordering can violate this guarantee, so the check is
+skipped.
+
 Generation cutoff
 ~~~~~~~~~~~~~~~~~
 Some callers (notably `remove_redundant()`) supply a `min_generation`
@@ -169,12 +186,16 @@ ordering via `compare_commits_by_commit_date`.  Because commit
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
index a62b5e4624..e03505b535 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -132,6 +132,10 @@ static void paint_queue_put(struct paint_state *state,
 	}
 }
 
+/*
+ * Dequeue the next commit for the paint walk, or return NULL when
+ * no more merge bases can be discovered.
+ */
 static struct commit *paint_queue_get(struct paint_state *state)
 {
 	struct commit *commit = prio_queue_get(&state->queue);
@@ -141,9 +145,17 @@ static struct commit *paint_queue_get(struct paint_state *state)
 
 	commit->object.flags &= ~ENQUEUED;
 
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
+		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+			return NULL;
+	}
 
 	paint_count_update(state, commit->object.flags, -1);
 	return commit;
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index f9895f5fd7..6bf17cb7b6 100755
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

