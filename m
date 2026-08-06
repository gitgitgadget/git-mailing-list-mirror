Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4D41BA95
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014012; cv=none; b=oZCjZnpaG2rEDjsoDmxTLDRecrwd106N4+bVdOgpX7noJC04v8BvYI+mRlYpUTVIYx5GEDQ0TOuwTaIOT6oTZ1PopZyIoysK5030M/fzRHlB8AncwDdj23H1SFZAzfan4luAsuWXS94M3R/FtcCjx6JsZk2YA0+k79yPRIKAz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014012; c=relaxed/simple;
	bh=K5P+Kf3eaOS6Nrz53vzJOGF5cDQmYebGTgT9cRN52JE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DCIDV13b+jDjw2SuUP1hXIrZRQruuqBC1SwcCRyGJ4QTJ31LcWKGws5jz30tEA7R7+8UNRR+otN4C9dC9KEq/PDeQh1mTjOUddBn5KqvKSC2YLah1xjmMXVcZ85DWfmQafXFCbMzt3frTydCBX8xGbwNnYYVUwvNi/nX1s4oX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VH1IO0QJ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VH1IO0QJ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81f64e8dfbcso30669887b3.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014010; x=1786618810; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=29T0oScvJM+GL3ttSZLFmuYZ05VgNzXAsbYPr0GR1p8=;
        b=VH1IO0QJQJzq2fQEC/i49kOF6x9nwdQdFWQdSjIIOwcvRtvHLsQZB7Q9sHAw3jrDvX
         5K11Sli3w5vil453OG6Dd5TyDpkQ1Wltba4lh/WqDu9chTpMjcgi/KARgwCUZc4i+Jd+
         bdZxAVgh9w9wmAZisNZsxSRYycWvTAs1LQuvVSreElz085sXjblTcxi7RscEuxH2E8c7
         Yh8cqEHIz9FTPjp5I+zg30KAtC5G05Pr8e0lN+ROZ32EsntLgEr+Mna0hgoZu9TkoQAB
         PYanHiFd+n4jSUBcjhWZ2kJfvETbGt5INwya0FX9n2AP65Y2y+cgosRAoO2FXtpaZW8Q
         07vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014010; x=1786618810;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=29T0oScvJM+GL3ttSZLFmuYZ05VgNzXAsbYPr0GR1p8=;
        b=fwi7qJiNrTjjK58RJk8o7wVTSB43iQ4g413Tf+PlkFcQbC4dZxEk2F3V6U3LlDD4cO
         XrQrmZY7KovctekA4TOoqPlGDyi9i3MoOQzMcs2lNwmFOnDHq/FIBN68X8bmitEg/OYx
         LpscyXR6R8Dt20RvqAYQFuql4dFPi13L8GXcBLz6r5VvUthIuqpoN/8TvL+7/P9HpGpq
         dX17Y/EJ2CKwJltQWaP2TGrkoZ/4YP39BqT/zEJqKET97TtNDx7BRugaEnYbterBpdpM
         HY+HFZrzvMlSdiHtCFJgDybXQTME7iUvZ3rcJW+kchGatG5oLnGuw9TqJ7j6LwHR+ISw
         O2PA==
X-Gm-Message-State: AOJu0YzNNtS3x+KEaVkqhww0t5U11ugvbwT1EHNVytVLeT5LsmoKPBe9
	yP5uFsM7cCnNWq++EvAiPj4UIqba422lJJHlqK2qitlpa8DdiFlz2KHarq58pA==
X-Gm-Gg: AR+sD11sA0hE30b36y+hDAOLTEJR1+1Som8YubG/jdSK9CfnacUAaJ/px4d5D+U8BzK
	kdkVdNKIThaSKUwhHHIu6RYkntSdmre17LzDJ/3W8oAGeLoJBP8YzpH4hy6tKrvY1+F3oRstG0R
	8dUqFIilmCLscYZiL3TtpAWnYNBRQC4IL6xJiQf4xpcjJLxE7XukiposZ3Umov508V6MUtf9tkl
	V9NgCm0gvjS8KogF3nutgRhYADoDO2VObeSsvm/c9KlaAyzvnkwok8Dgdtpieb5cxRFXSR1ku8z
	llDXqPX9ct2h+NmYTyr0QIXamvnQI7sMZLIfdiHPYbvg+BauGLbUo4UiRmijTP26bu5ZqBOUd2P
	mpEouDKXBreBtgIV36hm0A4053ye5BsNIcNYgKGMBGcbaAfGte2w3ILFtdpxmEDYcfdu7ypVFih
	un5Fa0H6G7pjI5dvhSO8+kw2I3eXau0wGJeA6zZBXgKq0ndVA+T3zS9/TAK68N5xQ=
X-Received: by 2002:a05:690c:688d:b0:81e:79f0:48b8 with SMTP id 00721157ae682-8201f0bd34dmr83883787b3.7.1786014008860;
        Thu, 06 Aug 2026 04:00:08 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201341d3d2sm36157277b3.31.2026.08.06.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:00:08 -0700 (PDT)
Message-Id: <cd3273eb15383ab044d60f9659c333e51104d985.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:40 +0000
Subject: [PATCH v7 09/10] commit-reach: move min_generation check into
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
Cc: Kristofer Karlsson <krka@spotify.com>,
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
index e03505b535..b50b0e4e47 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -90,6 +90,8 @@ struct paint_state {
 	size_t parent2_count;
 	size_t mb_candidate_count;
 	int gen_ordered;
+	timestamp_t min_generation;
+	timestamp_t last_gen;
 };
 
 static void paint_count_update(struct paint_state *state,
@@ -139,11 +141,23 @@ static void paint_queue_put(struct paint_state *state,
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
@@ -153,7 +167,7 @@ static struct commit *paint_queue_get(struct paint_state *state)
 		/* one side is exhausted */
 		if ((!state->parent1_count || !state->parent2_count) &&
 		    state->gen_ordered &&
-		    commit_graph_generation(commit) < GENERATION_NUMBER_INFINITY)
+		    generation < GENERATION_NUMBER_INFINITY)
 			return NULL;
 	}
 
@@ -180,9 +194,10 @@ static int paint_down_to_common(struct repository *r,
 	struct commit *commit;
 	int i;
 	int steps = 0;
-	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
+	state.min_generation = min_generation;
+	state.last_gen = GENERATION_NUMBER_INFINITY;
 	if (!min_generation && !corrected_commit_dates_enabled(r)) {
 		state.queue.compare = compare_commits_by_commit_date;
 		state.gen_ordered = 0;
@@ -201,18 +216,8 @@ static int paint_down_to_common(struct repository *r,
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
@@ -225,7 +230,7 @@ static int paint_down_to_common(struct repository *r,
 				 */
 				if (!(mb_flags & MERGE_BASE_FIND_ALL) &&
 				    state.gen_ordered &&
-				    generation < GENERATION_NUMBER_INFINITY)
+				    state.last_gen < GENERATION_NUMBER_INFINITY)
 					break;
 			}
 			/* Mark parents of a found merge stale */
-- 
gitgitgadget

