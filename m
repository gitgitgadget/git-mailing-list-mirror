Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8453750DB
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923853; cv=none; b=c5tzsm/vYF3KwCbpFe6qdLjfVb77M5Uhglkb+0kEjlctSDFAhYqRT/VrVFKI/Oo4TCKSgjMvAYlj/HQgR+u0G5WGKVf/sUaji2pZ8+sSs4p4Q9bcSuLHabt3MNiv+J9PTRCoJ+P2gI2hkU0MwjeR9oQc0GK4cMPDcX/q04D58R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923853; c=relaxed/simple;
	bh=/GrFKUK2mdi/c/cGS125MBzHVDZSk0ODjpkKq/PJftw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rpjpwEXwPhiHJg4Kj+0oDbc4Lu8xqBmW6p2ySyvbkqaEndgttvx62ENCXNSwT/ax78I37Lhl3jI3LSAOENZGQBvim8xeyaCHZYiNzOSiGSAJc65YqxkHHBZ7KV+TLLU4NcQlS5Frmldm5bPSRKDiVjg/dG36pW7QwqLGXzh855o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc0O2Aqc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc0O2Aqc"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84794e800f4so464603b3a.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923850; x=1783528650; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gaf3XmvEtEck9kSF7juk+kyUWtirZVKi3HmwsbSiH0=;
        b=nc0O2Aqctl69vMZQkKyXbuoCpSynXjUblSGu0hfPA+CTQ/NZrNdzGainUq2xQjesJr
         7ayiBqgKZpl1E7omjYYm+q+CH92O6KFxP4yYgjOcAawHgpDA6pW39a/grCdq4ICwrHaz
         ug6yNFzKPaossIgkrW9gT/EcjD4YMvKTHZsGLDfFyPUrSo1pSMCc2OFLZKcLLfRxHIHi
         yanFM32LhTOqs8oumJeTsWeGDer8Zi4ENjbV/IhdyK7VKhGlTh884K+yEE//FJq/5sKQ
         TFy2Pgbi+R/lyHzXd0GAIvVvMEEGifP5qwDKMVtAPzlIjA2i+ST1lphwsnyGwOzfDs9A
         F2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923850; x=1783528650;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6gaf3XmvEtEck9kSF7juk+kyUWtirZVKi3HmwsbSiH0=;
        b=dJjvyyhbMZR45UCwIJMUnOaQudVHF0vsTN21xjUAvd/40bxJW1SgNEyw4WYK1gkQ/v
         aD9tsHXDjUHupNci9TCIqmHpTJ2JMVAS3KPfJ7puGiZIVYx0WftcMLNcUjZ5F+D4g3pO
         FBqcS9L6aI8zEtwUrBTu2Nnunxd/dJ51Sl1/pcLYxctr0Uen3W4vuSdNNy6ZAWwnP3xo
         bYEFK7v/NKY5H8UvRx5gjx/XR5xblFB0oFkuJiUDMGrV7iucMtEywnrOIkB5lB9hbqLJ
         Ab1Tm4qYqkKoQvnbV7N4Zb68lb608VWzub1gUJDensPegBOkY0peawv7xU1vbtQS11gE
         l+Og==
X-Gm-Message-State: AOJu0Yy+iPv9+0Wa4WzQQST9iyrba/m9HYtHFp56de27NAEavqP+Z0OC
	cmL2zi9txywAmtSnjLW27amRya4TrtvUNhMsNLuDs+wEQwSc7irqQ6gNwCz7rw==
X-Gm-Gg: AfdE7cnHq87HdSrYGMGAh6QWpLaMWvq0TBJffedCsOD+LE1CvoPs9vQb3eLfQ1rz6um
	+22z5TpODm3G4ikmlTowfSOgDqrZ39gi6pvJWe5jA4FZ/BtJIOG0W5NMKYUSERXUolHyE44ZaPd
	oa/qn5GTqmBfSYRRHnxjrHgIe09Q+Qf64g4HOeH5LpAasyUA5kPoAWDyHW2pgFbpweR3gSBEJ7y
	TblpCp7CB/ckmtYHdCfEro57vVHhyzVXo8nvQr2CLnoI+RXmMGs0FZIj73YRffs/Os8ojsVLm38
	Uf1GrCJqR7fYHo8Obo8sbo98XN92P4A23tNGazN2uAdDRFMdJpUJOhoi3L6Pw0n7iIX1fQEppgd
	NyiG9TrKcMspHxMOgHj+IB//i0pXo9WiMFna+hloRaqvPwGVAjsMNsFKd1PFAdVdxfRrZcTXGMn
	FxGDB/FoORvqQhDi8=
X-Received: by 2002:a05:6a00:806:b0:846:f517:ba5a with SMTP id d2e1a72fcca58-847c5141135mr1393230b3a.28.1782923849539;
        Wed, 01 Jul 2026 09:37:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb6dc1afsm83176b3a.6.2026.07.01.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:28 -0700 (PDT)
Message-Id: <f8f00b7bcc818dffb6b3d0523522b8a92267e383.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:09 +0000
Subject: [PATCH v5 08/10] commit-reach: terminate merge-base walk when one
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
per-side counters introduced earlier.  Once the walk enters the
finite-generation region, terminate early when one side's exclusive
count drops to zero -- no new merge-base can form without both paint
sides meeting.

The check also waits for pending_merge_bases to reach zero, ensuring
all merge-base candidates have been dequeued and recorded before
exiting.

The INFINITY gate ensures correctness: commits without a commit-graph
entry have GENERATION_NUMBER_INFINITY and are ordered by commit date,
which is not topologically reliable.  The optimization only fires
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
 .../technical/paint-down-to-common.adoc        | 17 +++++++++++++++++
 commit-reach.c                                 | 18 +++++++++++++++---
 t/t6600-test-reach.sh                          |  4 ++--
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index 74ba675643..8a8a7a930e 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -110,6 +110,9 @@ ends when one of the following conditions holds:
   4. Single result: the caller only needs one merge base, one has
      been found, and the walk has entered the finite-generation
      region.
+  5. Side exhaustion: no pure PARENT1 or pure PARENT2 commits
+     remain in the queue, no pending merge-base candidates exist,
+     and the walk has entered the finite-generation region.
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
@@ -120,6 +123,20 @@ existing candidates by proving one is an ancestor of another, but
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
diff --git a/commit-reach.c b/commit-reach.c
index dbbbea641f..2b9249105c 100644
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
index 11db9ec988..fd11febf1a 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -298,7 +298,7 @@ test_expect_success 'in_merge_bases_many:self' '
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
 	test_all_modes in_merge_bases_many &&
-	test_paint_down_steps 45 2 25 3
+	test_paint_down_steps 45 1 25 1
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -415,7 +415,7 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	>input &&
 	git rev-parse commit-9-1 >expect &&
 	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
-	test_paint_down_steps 81 80 81 81
+	test_paint_down_steps 81 9 57 81
 '
 
 test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-exhaustion)' '
-- 
gitgitgadget

