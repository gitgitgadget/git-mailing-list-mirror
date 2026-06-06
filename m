Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AAB2F0680
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772483; cv=none; b=QeLhF2sZyaJaND46nwlOrpytLXUAORzHHYsZxyRLrHT5AJ7HZri+7D+Kxu/tiu+ElcgOZ0okmL+sBZqRkPDm7BrNeTNrBYMDH4YBOYKTPSAch86PyOCiVWjqVTqQ5rbLAB9JO85dRdYIG7EHdv5Fw5ChbTioGqrOU7qr23462i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772483; c=relaxed/simple;
	bh=UihSDtylem/OH5Tn0/jY8QILq0pQ/gXVi709s70Lr6I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=lMXPurbYC+rNk4PHJVoDiG09aqIm4O4Lu4odyETA6YPtt+Q+G4eXWK/xmAJDAOG85yB33hX0LupGQvtVYzfeHSymz6ZftYMHOnAI5jjrR0+cWidse5hovYNYIg2lOy+XjKjkVzC0mo4PXx3I9HtluT9N8bgivP9pJFnP+dBWQV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sl2WSlJC; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sl2WSlJC"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137ec563a95so3571438c88.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2026 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780772481; x=1781377281; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO5rg//koGJr2NuNDdHdWAYDqJa1vQhNln+arR5uL2w=;
        b=sl2WSlJCTGGA/s7UemNCxAWXE9xEBd2UM7nUoMCMn6u3vZhwG1p2R2YhUrLIub1IoP
         A0+7qRaBMxi0JB9UvS7Q94izsxBmyrCfWZ9EV5FmWAKBCJtQV1nysZ9G8ZFc6RXqdOP+
         0fV44BtVXur42BfADKm/MgXJtAKFnWZ2xszuXfqnwUm5jBKoexyqvYSiA5UqZDAcrnRM
         u4OKrAIeEDaTtnmldGWiQVDomTdR52LtjSaTMhd6ZwN9WcBbLB5lidFZ1q0qY2Itb4BX
         6VupAUR/5hUT2gZoJD78+U8rOcm+l46Fr1H0X8XhmvM+bCVqKndNwCjYG+EuiDIXe0Yp
         q/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780772481; x=1781377281;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eO5rg//koGJr2NuNDdHdWAYDqJa1vQhNln+arR5uL2w=;
        b=Asa2sud8gz6BGpW84WGgv8kAQa/L4ylfDBLF4+vVQEHFcI9Jtf4yrGWW4KZs2DP4qW
         LgctacYRGyfue88FIkoLiadamS4/QKK0zSNSAp4dHRznx/5pbZ2/ivgMmrniSIi2/vK2
         CXXhc54uCd0edmtZsaUP4dEn3vd4ZJd09sbZErCrJcG0K8UG+quoOiyWqdNB5G5PuSAS
         18oEId2HpaKnKdm0VyRgaDWN6vYx68sHAGXauJG8LO1m2Uu7TrDr9+ska5lGctAka5vY
         9xornhzMoCtH1GtgekYiYlbCzLd0CxGsT/1P1q7Aqs/CMWcwfQV9/knMg/zrh4Klctt1
         gIdg==
X-Gm-Message-State: AOJu0YzbznDWGK8oA0lrVccoVx5IQMOB8s5jj+i8gblj7CfHTP5Ilgx+
	rPkOfKQ10rNDJGyyxHlwiHJPCvv57cyJkoC68fArc+zQMpM9AUMYDSUmPIJIzg==
X-Gm-Gg: Acq92OF2GfzNkbxpBj51gtZTcqL4oaZ2qVRNKxAfAtMqT+Can/SkB6mfJm6u71Wq1n6
	axhV5Qc71+u2WDSOo9PBo33ZowGx7iOkRG4oGGwStgBfB/II7fjIp/pNjkW1smxgyyXOdlFjJxk
	7OQKaL++LuVsfiYP/QwTT+RolEzDziC4SNyebRmn/1nZfA6Vhelzu2w+V7FSWqfKG+iuYmF1hSW
	I8LkZh9PS6naqVULEgj1ryAozaK7jt5WqrKb2U7isEKK6CC9b75ZQ8UK8dra8TjD7/mPryj4MSr
	uO70fo7koTb4s/I2EeJXQL9mBoow5EA7Sitxs90KNhWcxR120e7B+4gui+w+O1tpUni+nfQCnnA
	F2ecxE2j7RtSIELS87Vvf8MDhf12FW5cPLRRpSOBhF87DAZmeNU6v/mBhiK7Bd/WGb2SSkW32U4
	erefKRzTFI4h8cTKnCqvprVFMx6KI/mNYBZgzkKVWTxYOALJxg
X-Received: by 2002:a05:7022:1a83:b0:137:f001:fce2 with SMTP id a92af1059eb24-13806714407mr4697824c88.33.1780772480398;
        Sat, 06 Jun 2026 12:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.117.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f53f06c4sm8306918c88.0.2026.06.06.12.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:01:19 -0700 (PDT)
Message-Id: <29af24445edac2a8149635505871abcf5b024cd8.1780772477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
References: <pull.2140.git.1780757885582.gitgitgadget@gmail.com>
	<pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 06 Jun 2026 19:01:15 +0000
Subject: [PATCH v2 1/2] prio-queue: fold lazy_queue into prio_queue for
 automatic get+put fusion
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Defer the actual removal in prio_queue_get() until the next
operation.  If that next operation is a prio_queue_put(), the
removal and insertion are fused into a single replace — writing
the new element at the root and sifting it down — which avoids
a full remove-rebalance-insert cycle.

This matches the dominant usage pattern in git's commit traversal:
get a commit, then put its parents.  The first parent insertion
after each get is now a replace operation automatically.

This generalizes the lazy_queue pattern from builtin/describe.c
(introduced in 08bb69d70f) into prio_queue itself.  Three callers
independently implemented the same get+put fusion:

  - builtin/describe.c had a full lazy_queue wrapper
  - commit.c:pop_most_recent_commit() reimplements the same
    get_pending flag with peek+replace
  - builtin/show-branch.c:join_revs() used the same peek+replace
    pattern

All three now collapse to plain _get() and _put(),
with the data structure handling the fusion internally.

Remove prio_queue_replace() since no external callers remain.
Add prio_queue_size() for callers that need the logical element
count, since the physical nr may temporarily include a
pending-removal element.

Benchmarked on a large monorepo (10-15 interleaved runs, 1 warmup):

  Command                       base    patched  speedup
  merge-base --all A A~1000     3.88s   3.77s    1.03x
  rev-list --count A~1000..A    3.57s   3.43s    1.04x
  log --oneline A~1000..A       3.70s   3.49s    1.06x
  rev-parse :/pattern           365ms   364ms    1.00x
  describe HEAD (linux.git)     184ms   190ms    1.00x

No regressions in any scenario.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/describe.c          | 67 +++++++++----------------------------
 builtin/last-modified.c     |  4 +--
 builtin/show-branch.c       | 17 ++++------
 commit-reach.c              |  5 ++-
 commit.c                    | 11 ++----
 pack-bitmap-write.c         |  4 +--
 prio-queue.c                | 49 +++++++++++++++------------
 prio-queue.h                | 12 +++----
 revision.c                  |  5 ++-
 t/unit-tests/u-prio-queue.c |  6 ++--
 walker.c                    |  4 +--
 11 files changed, 68 insertions(+), 116 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1c47d7c0b7..85564f3487 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -251,56 +251,20 @@ static int compare_pt(const void *a_, const void *b_)
 	return 0;
 }
 
-struct lazy_queue {
-	struct prio_queue queue;
-	bool get_pending;
-};
-
-#define LAZY_QUEUE_INIT { { compare_commits_by_commit_date }, false }
-
-static void *lazy_queue_get(struct lazy_queue *queue)
-{
-	if (queue->get_pending)
-		prio_queue_get(&queue->queue);
-	else
-		queue->get_pending = true;
-	return prio_queue_peek(&queue->queue);
-}
-
-static void lazy_queue_put(struct lazy_queue *queue, void *thing)
-{
-	if (queue->get_pending)
-		prio_queue_replace(&queue->queue, thing);
-	else
-		prio_queue_put(&queue->queue, thing);
-	queue->get_pending = false;
-}
-
-static bool lazy_queue_empty(const struct lazy_queue *queue)
-{
-	return queue->queue.nr == (queue->get_pending ? 1 : 0);
-}
-
-static void lazy_queue_clear(struct lazy_queue *queue)
-{
-	clear_prio_queue(&queue->queue);
-	queue->get_pending = false;
-}
-
-static unsigned long finish_depth_computation(struct lazy_queue *queue,
+static unsigned long finish_depth_computation(struct prio_queue *queue,
 					      struct possible_tag *best)
 {
 	unsigned long seen_commits = 0;
 	struct oidset unflagged = OIDSET_INIT;
+	struct commit *c;
 
-	for (size_t i = queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) {
-		struct commit *commit = queue->queue.array[i].data;
+	for (size_t i = queue->get_pending; i < queue->nr; i++) {
+		struct commit *commit = queue->array[i].data;
 		if (!(commit->object.flags & best->flag_within))
 			oidset_insert(&unflagged, &commit->object.oid);
 	}
 
-	while (!lazy_queue_empty(queue)) {
-		struct commit *c = lazy_queue_get(queue);
+	while ((c = prio_queue_get(queue))) {
 		struct commit_list *parents = c->parents;
 		seen_commits++;
 		if (c->object.flags & best->flag_within) {
@@ -316,7 +280,7 @@ static unsigned long finish_depth_computation(struct lazy_queue *queue,
 			repo_parse_commit(the_repository, p);
 			seen = p->object.flags & SEEN;
 			if (!seen)
-				lazy_queue_put(queue, p);
+				prio_queue_put(queue, p);
 			flag_before = p->object.flags & best->flag_within;
 			p->object.flags |= c->object.flags;
 			flag_after = p->object.flags & best->flag_within;
@@ -364,8 +328,8 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
 
 static void describe_commit(struct commit *cmit, struct strbuf *dst)
 {
-	struct commit *gave_up_on = NULL;
-	struct lazy_queue queue = LAZY_QUEUE_INIT;
+	struct commit *c, *gave_up_on = NULL;
+	struct prio_queue queue = { compare_commits_by_commit_date };
 	struct commit_name *n;
 	struct possible_tag all_matches[MAX_TAGS];
 	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
@@ -407,9 +371,8 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 	}
 
 	cmit->object.flags = SEEN;
-	lazy_queue_put(&queue, cmit);
-	while (!lazy_queue_empty(&queue)) {
-		struct commit *c = lazy_queue_get(&queue);
+	prio_queue_put(&queue, cmit);
+	while ((c = prio_queue_get(&queue))) {
 		struct commit_list *parents = c->parents;
 		struct commit_name **slot;
 
@@ -443,7 +406,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 				t->depth++;
 		}
 		/* Stop if last remaining path already covered by best candidate(s) */
-		if (annotated_cnt && lazy_queue_empty(&queue)) {
+		if (annotated_cnt && !prio_queue_size(&queue)) {
 			int best_depth = INT_MAX;
 			unsigned best_within = 0;
 			for (cur_match = 0; cur_match < match_cnt; cur_match++) {
@@ -466,7 +429,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 			struct commit *p = parents->item;
 			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
-				lazy_queue_put(&queue, p);
+				prio_queue_put(&queue, p);
 			p->object.flags |= c->object.flags;
 			parents = parents->next;
 
@@ -481,7 +444,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 			strbuf_add_unique_abbrev(dst, cmit_oid, abbrev);
 			if (suffix)
 				strbuf_addstr(dst, suffix);
-			lazy_queue_clear(&queue);
+			clear_prio_queue(&queue);
 			return;
 		}
 		if (unannotated_cnt)
@@ -497,11 +460,11 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 	QSORT(all_matches, match_cnt, compare_pt);
 
 	if (gave_up_on) {
-		lazy_queue_put(&queue, gave_up_on);
+		prio_queue_put(&queue, gave_up_on);
 		seen_commits--;
 	}
 	seen_commits += finish_depth_computation(&queue, &all_matches[0]);
-	lazy_queue_clear(&queue);
+	clear_prio_queue(&queue);
 
 	if (debug) {
 		static int label_width = -1;
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 8900ceece1..df2a508244 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -344,6 +344,7 @@ static void process_parent(struct last_modified *lm,
 static int last_modified_run(struct last_modified *lm)
 {
 	int max_count, queue_popped = 0;
+	struct commit *c;
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *list;
@@ -389,10 +390,9 @@ static int last_modified_run(struct last_modified *lm)
 		}
 	}
 
-	while (queue.nr) {
+	while ((c = prio_queue_get(&queue))) {
 		int parent_i;
 		struct commit_list *p;
-		struct commit *c = prio_queue_get(&queue);
 		struct bitmap *active_c = active_paths_for(lm, c);
 
 		if ((0 <= max_count && max_count < ++queue_popped) ||
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..9f7f28f339 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -62,7 +62,7 @@ static const char *get_color_reset_code(void)
 
 static struct commit *interesting(struct prio_queue *queue)
 {
-	for (size_t i = 0; i < queue->nr; i++) {
+	for (size_t i = queue->get_pending; i < queue->nr; i++) {
 		struct commit *commit = queue->array[i].data;
 		if (commit->object.flags & UNINTERESTING)
 			continue;
@@ -228,17 +228,18 @@ static void join_revs(struct prio_queue *queue,
 {
 	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
 	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
+	struct commit *commit;
 
-	while (queue->nr) {
+	while ((commit = prio_queue_peek(queue))) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(queue);
-		struct commit *commit = prio_queue_peek(queue);
-		bool get_pending = true;
 		int flags = commit->object.flags & all_mask;
 
 		if (!still_interesting && extra <= 0)
 			break;
 
+		prio_queue_get(queue);
+
 		mark_seen(commit, seen_p);
 		if ((flags & all_revs) == all_revs)
 			flags |= UNINTERESTING;
@@ -254,14 +255,8 @@ static void join_revs(struct prio_queue *queue,
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |= flags;
-			if (get_pending)
-				prio_queue_replace(queue, p);
-			else
-				prio_queue_put(queue, p);
-			get_pending = false;
+			prio_queue_put(queue, p);
 		}
-		if (get_pending)
-			prio_queue_get(queue);
 	}
 
 	/*
diff --git a/commit-reach.c b/commit-reach.c
index 9b3ea46d6f..0fec2f00be 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1269,7 +1269,7 @@ int get_branch_base_for_tip(struct repository *r,
 			    size_t bases_nr)
 {
 	int best_index = -1;
-	struct commit *branch_point = NULL;
+	struct commit *c, *branch_point = NULL;
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	int found_missing_gen = 0;
 
@@ -1322,8 +1322,7 @@ int get_branch_base_for_tip(struct repository *r,
 		prio_queue_put(&queue, c);
 	}
 
-	while (queue.nr) {
-		struct commit *c = prio_queue_get(&queue);
+	while ((c = prio_queue_get(&queue))) {
 		int best_for_c = get_best(c);
 		int best_for_p, positive;
 		struct commit *parent;
diff --git a/commit.c b/commit.c
index fd8723502e..976bfc4618 100644
--- a/commit.c
+++ b/commit.c
@@ -795,24 +795,17 @@ void commit_list_sort_by_date(struct commit_list **list)
 struct commit *pop_most_recent_commit(struct prio_queue *queue,
 				      unsigned int mark)
 {
-	struct commit *ret = prio_queue_peek(queue);
-	int get_pending = 1;
+	struct commit *ret = prio_queue_get(queue);
 	struct commit_list *parents = ret->parents;
 
 	while (parents) {
 		struct commit *commit = parents->item;
 		if (!repo_parse_commit(the_repository, commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
-			if (get_pending)
-				prio_queue_replace(queue, commit);
-			else
-				prio_queue_put(queue, commit);
-			get_pending = 0;
+			prio_queue_put(queue, commit);
 		}
 		parents = parents->next;
 	}
-	if (get_pending)
-		prio_queue_get(queue);
 	return ret;
 }
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 1c8070f99c..f7c63e3027 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -513,6 +513,7 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			      struct bitmap_index *old_bitmap,
 			      const uint32_t *mapping)
 {
+	struct commit *c;
 	int found;
 	uint32_t pos;
 	if (!ent->bitmap)
@@ -520,9 +521,8 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 
 	prio_queue_put(queue, commit);
 
-	while (queue->nr) {
+	while ((c = prio_queue_get(queue))) {
 		struct commit_list *p;
-		struct commit *c = prio_queue_get(queue);
 
 		if (old_bitmap && mapping) {
 			struct ewah_bitmap *old;
diff --git a/prio-queue.c b/prio-queue.c
index 9748528ce6..1407f2f801 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -34,12 +34,34 @@ void clear_prio_queue(struct prio_queue *queue)
 	queue->nr = 0;
 	queue->alloc = 0;
 	queue->insertion_ctr = 0;
+	queue->get_pending = 0;
+}
+
+static void sift_down_root(struct prio_queue *queue);
+
+static inline void flush_get(struct prio_queue *queue)
+{
+	if (!queue->get_pending)
+		return;
+	queue->get_pending = 0;
+	if (!--queue->nr)
+		return;
+	queue->array[0] = queue->array[queue->nr];
+	sift_down_root(queue);
 }
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
 	size_t ix, parent;
 
+	if (queue->get_pending) {
+		queue->get_pending = 0;
+		queue->array[0].ctr = queue->insertion_ctr++;
+		queue->array[0].data = thing;
+		sift_down_root(queue);
+		return;
+	}
+
 	/* Append at the end */
 	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
 	queue->array[queue->nr].ctr = queue->insertion_ctr++;
@@ -78,41 +100,24 @@ static void sift_down_root(struct prio_queue *queue)
 
 void *prio_queue_get(struct prio_queue *queue)
 {
-	void *result;
+	flush_get(queue);
 
 	if (!queue->nr)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[--queue->nr].data; /* LIFO */
 
-	result = queue->array[0].data;
-	if (!--queue->nr)
-		return result;
-
-	queue->array[0] = queue->array[queue->nr];
-	sift_down_root(queue);
-	return result;
+	queue->get_pending = 1;
+	return queue->array[0].data;
 }
 
 void *prio_queue_peek(struct prio_queue *queue)
 {
+	flush_get(queue);
+
 	if (!queue->nr)
 		return NULL;
 	if (!queue->compare)
 		return queue->array[queue->nr - 1].data;
 	return queue->array[0].data;
 }
-
-void prio_queue_replace(struct prio_queue *queue, void *thing)
-{
-	if (!queue->nr) {
-		prio_queue_put(queue, thing);
-	} else if (!queue->compare) {
-		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
-		queue->array[queue->nr - 1].data = thing;
-	} else {
-		queue->array[0].ctr = queue->insertion_ctr++;
-		queue->array[0].data = thing;
-		sift_down_root(queue);
-	}
-}
diff --git a/prio-queue.h b/prio-queue.h
index da7fad2f1f..482ab5e71d 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -32,6 +32,7 @@ struct prio_queue {
 	void *cb_data;
 	size_t alloc, nr;
 	struct prio_queue_entry *array;
+	unsigned get_pending;
 };
 
 /*
@@ -52,13 +53,10 @@ void *prio_queue_get(struct prio_queue *);
  */
 void *prio_queue_peek(struct prio_queue *);
 
-/*
- * Replace the "thing" that compares the smallest with a new "thing",
- * like prio_queue_get()+prio_queue_put() would do, but in a more
- * efficient way.  Does the same as prio_queue_put() if the queue is
- * empty.
- */
-void prio_queue_replace(struct prio_queue *queue, void *thing);
+static inline size_t prio_queue_size(struct prio_queue *queue)
+{
+	return queue->nr - queue->get_pending;
+}
 
 void clear_prio_queue(struct prio_queue *);
 
diff --git a/revision.c b/revision.c
index 5693618be4..8ce8ffa43d 100644
--- a/revision.c
+++ b/revision.c
@@ -1446,7 +1446,7 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *original_list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
-	struct commit *interesting_cache = NULL;
+	struct commit *commit, *interesting_cache = NULL;
 	struct prio_queue queue = { .compare = compare_commits_by_commit_date };
 
 	if (revs->ancestry_path_implicit_bottoms) {
@@ -1461,8 +1461,7 @@ static int limit_list(struct rev_info *revs)
 		prio_queue_put(&queue, commit);
 	}
 
-	while (queue.nr) {
-		struct commit *commit = prio_queue_get(&queue);
+	while ((commit = prio_queue_get(&queue))) {
 		struct object *obj = &commit->object;
 
 		if (commit == interesting_cache)
diff --git a/t/unit-tests/u-prio-queue.c b/t/unit-tests/u-prio-queue.c
index 63e58114ae..af3e0b8598 100644
--- a/t/unit-tests/u-prio-queue.c
+++ b/t/unit-tests/u-prio-queue.c
@@ -53,13 +53,13 @@ static void test_prio_queue(int *input, size_t input_size,
 			prio_queue_reverse(&pq);
 			break;
 		case REPLACE:
-			peek = prio_queue_peek(&pq);
+			get = prio_queue_get(&pq);
 			cl_assert(i + 1 < input_size);
 			cl_assert(input[i + 1] >= 0);
 			cl_assert(j < result_size);
-			cl_assert_equal_i(result[j], show(peek));
+			cl_assert_equal_i(result[j], show(get));
 			j++;
-			prio_queue_replace(&pq, &input[++i]);
+			prio_queue_put(&pq, &input[++i]);
 			break;
 		default:
 			prio_queue_put(&pq, &input[i]);
diff --git a/walker.c b/walker.c
index e98eb6da53..e3de77f092 100644
--- a/walker.c
+++ b/walker.c
@@ -84,12 +84,12 @@ static struct prio_queue complete = { compare_commits_by_commit_date };
 static int process_commit(struct walker *walker, struct commit *commit)
 {
 	struct commit_list *parents;
+	struct commit *item;
 
 	if (repo_parse_commit(the_repository, commit))
 		return -1;
 
-	while (complete.nr) {
-		struct commit *item = prio_queue_peek(&complete);
+	while ((item = prio_queue_peek(&complete))) {
 		if (item->date < commit->date)
 			break;
 		pop_most_recent_commit(&complete, COMPLETE);
-- 
gitgitgadget

