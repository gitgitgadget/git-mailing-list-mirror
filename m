Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93923A4521
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782649572; cv=none; b=KncLlJTFXt/e+K3JByuD+RFEp5S9Zf+laYNspQkxVxJ1iu3cdFgVjFi8/1OsF3NDrk267N+6NVvlt1KH41d2Bxb4ZCHefrF9+vVoMI3SKrOVwvXDtOn/l/Ry6KKCQWFzeCQRcISVqHQF0axQFMLesNTRs1d1SGUyhy61CjKuync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782649572; c=relaxed/simple;
	bh=1/j2WjzD3+TxEugRkdx1GbHmgWGndxNHPcZT6YWuQl4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mji4snGelrXV7L/GtwCXT/2gYioyXu+tsWAXxDyMmZ3KXdecDTJFjpdW2lrKa1wq1kTjzW+MTeSFHx93ZqzqF7EPu8nyqXYGZ34+e8OrnRuTRnDux3ShlQDWkdtO12j2envWmwpYWMeT5i2svvn8r1uX6ePKeXNeOlUGB9Zt9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/UiFQAO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/UiFQAO"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92c7a0a7059so102649985a.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2026 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782649570; x=1783254370; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWSn5kKQdBPezAdk1e79dDPkljc4bt7YWtgUmpKBXtc=;
        b=q/UiFQAObLEsNrU3PB2Avb2Wrv/S4ZkxjHsFbHLebZd8UbiihHnZH+YFxT63+Qi3yW
         /WxigphzvWVYupdxckLOl1BV1ESDdOdxUq7SuPBAk4+6dRHI4GhiR0zOkT6v9SuQ+hDf
         awMarCfixjo8klKl+seh6cJt+mwuNf62fFKdXJ37oR7LlPZ515JSSQC/QNJp/BO6Zz4J
         vlpN+W6DDe2Ni5J5RK5qQC5fX+TuCkco64QSX5AEdyR5MjcE+axNaYqL7FaLY0X3aJa0
         Be1dqDE63EwAeX8vnf83veXbJ5oSIZXGNA2w5vWDnDrp/fEyjlAQy/6mSz/S7i0WZ3t2
         iK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782649570; x=1783254370;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWSn5kKQdBPezAdk1e79dDPkljc4bt7YWtgUmpKBXtc=;
        b=aj0+rAf3nO28OKN5MvldRpkmTYGWtu++s4rRgYH6aAbOMg1nhi66vFtt871UBvH/EC
         6YM9+pKqTuSVfo0ZMKDQIeOdDg/vqudAzY+XDCBVk+VQu9+Xm1miROEMmRS+RpFd8KZu
         F+OUXU/EjpzDgto2KP+G/h02QLlsFr303eAW0fASqOgXuRKMCjcWmP/yDw3ZrlMgCs3O
         mJSIi35U13kfnmDzObpKPLZMFizzNuFCXXfXBRtLRwqsfEsnxQr9LRGunmptgcMQK2kn
         ZhQzwq+hsQq/pF6LMR51YQhX5uPAP1bfGbjwwGp6ogK3amSg6IwfkCmxP6bhidbBwnFd
         RLMw==
X-Gm-Message-State: AOJu0YyGIDdX/kuq/y616qCnsd8+QF3oqYgJ8oPmTt3owmpHO+j8sCGY
	VYs7+QUi78hLnhBYj/vIsWRFlUUHLkhRJnU3iesXVdvqpDidW0NoGeIrHx+ydQ==
X-Gm-Gg: AfdE7ckBAED1HhgavLMWDT6lCPrLt+nLbOFknOoSyHggZkIcZEtVZkyyI60rQwWN6yh
	kXUWUHZaXQKKXyhgkebN3495lZV6Pr9hV7LemrnUW9nSpLyPCoYNQDHorbqVT2nmTefPtzzNRah
	IJetBzQrEjFv2C4XXx3CSSlgaVCQu1itEaCpHAoeF8Xh8J9OQbyvV1klfyjp0bDA2CdfY5ED8fO
	CFG9eAP4QUFsOcVmAZsdY1jpbl+pGbfMOKCgc22We8QUthM9nxmLKxjfAJDDurhDAHnhIh+XJz7
	haRiuuqfs06yupf1Trxa2uJYKg57xuAhz9zYfjM4ksrSRMQDrjmLJW5Pf8JYUZbkuzuCHoR9T9W
	NgVO7hJH6H2LUJLhfEGT2iFZLUW08TzrwDI4iEzLR5jf1Y1E4ZUlZoWOzH9SHh08JD/EvzaedbJ
	ckb9X4grCncdw2NmM7
X-Received: by 2002:a05:620a:a291:10b0:92b:67e6:8ac0 with SMTP id af79cd13be357-92b67e68dc8mr662497485a.74.1782649569767;
        Sun, 28 Jun 2026 05:26:09 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.135.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92b5fa631f6sm603387085a.5.2026.06.28.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 05:26:08 -0700 (PDT)
Message-Id: <8dd15d44e6a60fc39bbf6d894628507e839f9248.1782649547.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
	<pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jun 2026 12:25:46 +0000
Subject: [PATCH v4 8/8] commit-reach: move min_generation check into
 paint_queue_get()
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
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Consolidate the min_generation termination condition into
paint_queue_get(), alongside the existing stale-entry and
side-exhaustion checks.

Move last_gen into struct paint_state so that
commit_graph_generation() is called exactly once per dequeued commit
and the result is shared across all termination checks and the
monotonicity BUG assertion.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index e174b219c6..5c5c54d66e 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -89,6 +89,8 @@ struct paint_state {
 	size_t parent1_count;
 	size_t parent2_count;
 	size_t mb_candidate_count;
+	timestamp_t min_generation;
+	timestamp_t last_gen;
 };
 
 static void paint_count_update(struct paint_state *state,
@@ -138,11 +140,23 @@ static void paint_queue_put(struct paint_state *state,
 static struct commit *paint_queue_get(struct paint_state *state)
 {
 	struct commit *commit = prio_queue_get(&state->queue);
+	timestamp_t generation;
 
 	if (!commit)
 		return NULL;
 
 	commit->object.flags &= ~ENQUEUED;
+	generation = commit_graph_generation(commit);
+
+	if (state->min_generation && generation > state->last_gen)
+		BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
+		    generation, state->last_gen,
+		    oid_to_hex(&commit->object.oid));
+	state->last_gen = generation;
+
+	/* generation cutoff */
+	if (generation < state->min_generation)
+		return NULL;
 
 	if (!state->mb_candidate_count) {
 		/* only stale entries remain */
@@ -151,7 +165,7 @@ static struct commit *paint_queue_get(struct paint_state *state)
 
 		/* one side is exhausted */
 		if ((!state->parent1_count || !state->parent2_count) &&
-		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+		    generation < GENERATION_NUMBER_INFINITY)
 			return NULL;
 	}
 
@@ -177,9 +191,10 @@ static int paint_down_to_common(struct repository *r,
 	struct commit *commit;
 	int i;
 	int steps = 0;
-	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
+	state.min_generation = min_generation;
+	state.last_gen = GENERATION_NUMBER_INFINITY;
 	if (!min_generation && !corrected_commit_dates_enabled(r))
 		state.queue.compare = compare_commits_by_commit_date;
 
@@ -196,18 +211,8 @@ static int paint_down_to_common(struct repository *r,
 	while ((commit = paint_queue_get(&state))) {
 		struct commit_list *parents;
 		int flags;
-		timestamp_t generation = commit_graph_generation(commit);
 		steps++;
 
-		if (min_generation && generation > last_gen)
-			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
-			    generation, last_gen,
-			    oid_to_hex(&commit->object.oid));
-		last_gen = generation;
-
-		if (generation < min_generation)
-			break;
-
 		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
 		if (flags == (PARENT1 | PARENT2)) {
 			if (!(commit->object.flags & RESULT)) {
@@ -219,7 +224,7 @@ static int paint_down_to_common(struct repository *r,
 				 * descendant of this one.
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
-				    generation < GENERATION_NUMBER_INFINITY)
+				    state.last_gen < GENERATION_NUMBER_INFINITY)
 					break;
 			}
 			/* Mark parents of a found merge stale */
-- 
gitgitgadget
