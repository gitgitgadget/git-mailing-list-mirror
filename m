Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482663F65FC
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782479296; cv=none; b=g02N/jMr1P/pn7U9ZMDIjwVAcpBN1vBogwRpD3R83KPh731X0plvmwV60vBe6QlkCrUgldBLdM1yUti+qcscHzcwXyKfeBAcbfWbSf65jD9AHTZFnJDl2mraZ2CI9XNC+QFkbm75L0WBGTayEo3aAXv/ZSbY6bzr133q04s1cig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782479296; c=relaxed/simple;
	bh=6IQIXiMuPc6G680OuJAT5cj+c5mOlZnTOUHKV/zdxmg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oTytah5Zq3XzcEmMvh+QL/3FRZ/5B0eMnuTS0IaHrJ8P0Rstzks50UtRvsQy/UECbDo4tfkAwKWGxlEGtiXxzXr9k8q79cbUHdAAHvS4T2mSdPMABGcY+gk8gl/UEo8bWa4ftKe0zTowml21E6F0Ch06Pi6OrfvAEhTnTtF9fpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB45PbOL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB45PbOL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5178a42caa3so8192181cf.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 06:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782479294; x=1783084094; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtPQHkXz3RD4xdM62vPxHh81Oc0xbdPUJ94mjkg6hso=;
        b=WB45PbOLTmSvywrmzusAYsI2YIbloxjkd4fjFaFOaaO6c8R8wZuMNET/2H87LqJrYF
         qBeb8gwTmz+KQbMvxHg0zIBZLauMYqHyhKcVAVjjbRfCVtA4XrpW/tud7gS+FNftTQ5b
         b9VqgN1qYzVv2WtZZn+FzVxTO1xwONXr13bM+UKLXIs7ERPMkgWBNU0Mi346j8+vdWtn
         hKOFPYAsTUW8NBMGpYd8OX8F6wFbaGnQFn/Fy/fc8uij6t/Z/50Tb8+s5/HXvFg9h1ml
         BkhUnl/2sizTSt/rlMkGN/PoWdrZx4FgdiTAgCp8I+zYtk8F0mG5gjWfIsHqU0obHF2s
         tIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782479294; x=1783084094;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TtPQHkXz3RD4xdM62vPxHh81Oc0xbdPUJ94mjkg6hso=;
        b=ny5HM/fAZZ8teyqo3F5wa3pusOIyvPhnOUWysozFTRXZ2fnVI5tVpLGLKUxlN/3UFU
         dlOw+q/96pxj8Epq0MSrbSSLSYQuIXvs7nDgyfi6kj0B5iCbQnSZ+CDj5q2BMHOFC0YF
         6DYvBt60WVzd84wlziqXrnAO08OPaEkeod/31J/bEyZY/IyI4MHBYh5QtK6XR7JJEjQn
         nOq9+9lbY3rGPulUHEkuTr6DdrlKDLIeoiNqeYdQB8APPTpxCdZ8cWr7JsaGrx+mvfit
         CKwdH2sAhZzvaXM5qpb+9dGU/1UXlP86rGHv5P6DOmtAnV9LY7ZUXT4Kdz4qALEmrQQY
         1jKw==
X-Gm-Message-State: AOJu0YzuFtKF2eisM5CCWRgtiiasDSnljCxFSICPmks1P1Eg/Bt086zw
	n5TVC4V8MsII4JCLeBgt9/9T/yLjy3uJ84ZgihzeGVi2xnS2Yq1CwVo0CdVafzRD
X-Gm-Gg: AfdE7cnDqGVnT9YK3hs4w7r1d3kiAssa8fnMdErJE8StiLarybNXgK/z+y/sfhjKLlv
	oAo8EDVyvktPvJdwzK1Ca5b6v3SCWyX9ItpT+MB7w5pSx+Se2/q5niE+B1+Lj88xdTpm9D2Okwr
	qZ2fJkcdnE1Yvwq5EakKW89CknrgBR6HUwDWvP0KVIwIBFahjx3ZUcdrtfdN7j1GyISUpEXJcSo
	cH6yxjdnwwPX1dQ+NlWKE9GvI3Cnj2o6ocxsFIMKU4NAZplSDztDQaRE/2L12cEdtDUt3cX9vhn
	pbFHA7obwfk3JIt1wlYpDgcm4z4/eRVSMAQSdcyqiRdfcZwCfzTGSA7mp12cNNAEt15OJeV71ui
	4o/j2glpQhF1QuqEg+3bVNwLUfONHx0GeQvPallX4HAygDyg0cL1vZdCi2s6g+O/LLddEo//zBA
	CIxDBv+Uj/jXRAMg==
X-Received: by 2002:a05:622a:13cf:b0:519:defb:2442 with SMTP id d75a77b69052e-51a722fbee0mr77134221cf.17.1782479293817;
        Fri, 26 Jun 2026 06:08:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a8aef286csm1860811cf.8.2026.06.26.06.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:08:13 -0700 (PDT)
Message-Id: <e82e0c72b6fc72b214f40efa9586c77790881f93.1782479286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jun 2026 13:08:02 +0000
Subject: [PATCH v3 5/8] commit-reach: introduce struct paint_state with
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

The existing nonstale_queue is left in place for ahead_behind().

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 .../technical/paint-down-to-common.adoc       |  9 +-
 commit-reach.c                                | 94 ++++++++++++++++---
 t/t6600-test-reach.sh                         |  4 +-
 3 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/paint-down-to-common.adoc b/Documentation/technical/paint-down-to-common.adoc
index c10d5d2887..0f4e1892a5 100644
--- a/Documentation/technical/paint-down-to-common.adoc
+++ b/Documentation/technical/paint-down-to-common.adoc
@@ -88,15 +88,12 @@ re-enqueued is bounded by the number of flag transitions.
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
 
 Stale entry condition
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/commit-reach.c b/commit-reach.c
index f6a438550b..0f29b143bd 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -97,6 +97,75 @@ static struct commit *nonstale_queue_get_dedup(struct nonstale_queue *queue)
 	return commit;
 }
 
+/*
+ * Priority queue with per-side commit counters for paint_down_to_common().
+ * Each non-stale queued commit occupies exactly one bucket: PARENT1-only,
+ * PARENT2-only, or both (a pending merge-base candidate).
+ */
+struct paint_state {
+	struct prio_queue queue;
+	int p1_count;
+	int p2_count;
+	int pending_merge_bases;
+};
+
+static void paint_count_update(struct paint_state *state,
+			       unsigned flags, int delta)
+{
+	switch (flags & (PARENT1 | PARENT2 | STALE)) {
+	case PARENT1:
+		state->p1_count += delta;
+		break;
+
+	case PARENT2:
+		state->p2_count += delta;
+		break;
+
+	case PARENT1 | PARENT2:
+		state->pending_merge_bases += delta;
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
+}
+
+static struct commit *paint_queue_get(struct paint_state *state)
+{
+	struct commit *commit = prio_queue_get(&state->queue);
+
+	if (!commit)
+		return NULL;
+
+	commit->object.flags &= ~ENQUEUED;
+
+	if (!state->p1_count && !state->p2_count &&
+	    !state->pending_merge_bases)
+		return NULL;
+
+	paint_count_update(state, commit->object.flags, -1);
+	return commit;
+}
+
 /*
  * See Documentation/technical/paint-down-to-common.adoc
  *
@@ -109,31 +178,29 @@ static int paint_down_to_common(struct repository *r,
 				enum merge_base_flags mb_flags,
 				struct commit_list **result)
 {
-	struct nonstale_queue queue = {
-		{ compare_commits_by_gen_then_commit_date }
+	struct paint_state state = {
+		.queue = { compare_commits_by_gen_then_commit_date }
 	};
+	struct commit *commit;
 	int i;
 	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
 	if (!min_generation && !corrected_commit_dates_enabled(r))
-		queue.pq.compare = compare_commits_by_commit_date;
+		state.queue.compare = compare_commits_by_commit_date;
 
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
@@ -172,7 +239,7 @@ static int paint_down_to_common(struct repository *r,
 			if ((p->object.flags & flags) == flags)
 				continue;
 			if (repo_parse_commit(r, p)) {
-				clear_nonstale_queue(&queue);
+				clear_prio_queue(&state.queue);
 				commit_list_free(*result);
 				*result = NULL;
 				/*
@@ -187,12 +254,11 @@ static int paint_down_to_common(struct repository *r,
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
index b3a31b80ac..51f3d70492 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -289,7 +289,7 @@ test_expect_success 'get_merge_bases_many:pending-stale' '
 		git rev-parse ps-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 6 6 6 6
+	test_paint_down_steps 5 5 5 5
 '
 
 test_expect_success 'get_merge_bases_many:infinity-both-sides' '
@@ -304,7 +304,7 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		git rev-parse pi-B
 	} >expect &&
 	test_all_modes get_merge_bases_many &&
-	test_paint_down_steps 5 5 5 5
+	test_paint_down_steps 5 4 5 5
 '
 
 test_expect_success 'setup mixed finite/INFINITY topology' '
-- 
gitgitgadget

