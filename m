Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F364257855
	for <git@vger.kernel.org>; Sun,  7 Jun 2026 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780832602; cv=none; b=hersaPk6t+TQcwDjXZS3S3H0aYmEvdDH/R6GeF7nhI7bywsNyDGeFyJt3yWET57D2ZETWC62p0cK6M4uC9UHAHL/uoeSSoHNL2vDMzyj5MuPfOSLIukmEeHGrL5DTeXIMi39J6HVykQ1jA8x/fDFeA9U9AZRjNUFqBokJ1gqFG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780832602; c=relaxed/simple;
	bh=p3YAOjAt2Gp630MSilgr/Z6tBJ+EL5TEl7+tDIeHwSU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P+TZ10FufyOI/Tyn2k/D7mr7zsiDQHNubYFLPF80UXDXEnOm73MjsPVfsUVs1qAF96AHpiv2xNZi6ML0UjWuWdqY7HIEbCdiiC/Gze+eL4GQyduycKzzkiardxmHgGjGaHrCRODZfM6qKNvzwcghmmn+R99YPhGgux/3oTXTj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtMMGcR9; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtMMGcR9"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-137d464c47eso2711234c88.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780832600; x=1781437400; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUSueDymQnXReXLQ81UfemEIjoukca0V3of1wGBRHsY=;
        b=HtMMGcR9hfwhXAOWMDITcHfLwKWsBLTaCBS2M0ZYlXK3hXNEWUQgZp2qWVZsXVF+Cd
         731MNu4/8+N/cG3nkib9LNGhtw6lkCHaa8Se8jYYg/A/0fj452viQad31VDUJig1G5k6
         /Ma07mHd110wdaIIEN09DQIrEDshc7vOBJrgI6ySau7drTmLdOLzMaQihJhYtKqNEg+o
         sAdWVOm/w6IZXKiISWUmk8H4Rcs4r4b0r0sFXe7uerxDWknmjkubfaGnE9sXw+bXXDOv
         GnFLwWMNwSjRYdO4iRf9Owk4mu6bj7lm5r9Q2R6FteniuYG0ilC5RBO68r6r3TvCljp5
         1a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780832600; x=1781437400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUSueDymQnXReXLQ81UfemEIjoukca0V3of1wGBRHsY=;
        b=MvuVZzQdvCVGUo321uHJuALVVwypK78zMPZSPuX4cMhzDpIMyqbMxH3CmiIbo16Qld
         mq6+4Fp03kKNKzJPGFe4t1iTuxRScM5cPl0pq0PvvaChfJAEgp+SDyaaAR7AWPC1wgyR
         /RTv/g+dLY784PHNfnj0MZgZnOm03tgwvagKS+kCAUA+1ekAIWHOmk7xsL4+drm2SzY4
         d9LX9Pj9JzkPFkofLaR7b/cxH4aMnhur4xliYbtNhgFW2zgFw/lf4P9lkQtWl+QUbH7/
         SNlbeleJmwtZWIACslvQ5OEWSJu5bwESM8S1GgUsOZNn2udX+os4nE6u06N8Uo1BkaxX
         tnSg==
X-Gm-Message-State: AOJu0YwmCzAzIl6e5dNea2nFckuALdTrLgA9XnIjdXUyFK5TFOg1MiLi
	D0eLvGVsWGm4lBpjNDX94KjYnhHR/bUSCC0M9CseAA/MypcqlAs5ep6UQ466pnfL
X-Gm-Gg: Acq92OEFozj4meFpU7H9qkTUACQ+zdDu+WqU8nBsJu5HF3DlBGuUMsXCezcLfkfLk+C
	wkvsaVnYG37ry8Ji/Sc0iBWxN9t/q3uPmp1P76ca7pOK3TD6TJHQPrOWcP+APGK++C8+amyhMB+
	rTEBK5LT9j73whnS3gT96AEqLG6MEO7o/NKaC5hMUcAXk6PpdKuB5ldvrwmc3OY/lR4kX36SfDu
	BHcCmw6//zmbvLL59t/4UXQ4hiPNObHdT/bsem+kaPg5RaYWK/qyqcpHxWQd8kR6f8wBuZOHqfc
	1Bf8XPYkczdIzv5VZ9e+3LnfcFGSEBl1eAPt95CCUEuQDbhT0xHzZ0pbA147KqdmJ+4bJ4fjoFU
	jbsoTxk+RadfK5kakPdn94K6dzwfWytC6UY2/lPLEldNwe/jHqVQqVVvr7avVne+jZowp0XtLgF
	3F7B8lil1KLfhLvaL2PYoej2IJ1zgYGalTPdDubca0sx0RPA==
X-Received: by 2002:a05:7022:43a4:b0:137:e3b4:433c with SMTP id a92af1059eb24-13807dae2bemr5047143c88.21.1780832600104;
        Sun, 07 Jun 2026 04:43:20 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539432sm11709887c88.9.2026.06.07.04.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:43:18 -0700 (PDT)
Message-Id: <033215e3042ece9e1bfae3579f844dd8950d1323.1780832592.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
References: <pull.2140.v2.git.1780772477.gitgitgadget@gmail.com>
	<pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Jun 2026 11:43:11 +0000
Subject: [PATCH v3 2/2] prio-queue: rename .nr to .nr_internal to prevent
 direct access
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Rename the .nr member to .nr_internal so that callers outside
prio-queue.c that directly reference .nr get a compilation error.
This catches both existing misuse and future in-flight topics.

Add prio_queue_for_each() macro for callers that need to walk all
elements in the queue, accounting for the get_pending offset.

Convert all external .nr users:
 - Loop conditions: use prio_queue_size(), prio_queue_get(), or
   prio_queue_peek() as the loop condition
 - Array iterations: use prio_queue_for_each()

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/describe.c      |  7 +++---
 builtin/last-modified.c |  5 ++---
 builtin/show-branch.c   |  9 ++++----
 commit-reach.c          | 19 +++++++++-------
 fetch-pack.c            |  4 ++--
 negotiator/default.c    |  4 +++-
 negotiator/skipping.c   | 12 ++++++-----
 object-name.c           |  2 +-
 pack-bitmap-write.c     |  6 +++---
 path-walk.c             |  8 +++----
 prio-queue.c            | 48 +++++++++++++++++++++++------------------
 prio-queue.h            |  9 ++++++--
 revision.c              | 11 +++++-----
 13 files changed, 79 insertions(+), 65 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 85564f3487..64424543ef 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -258,10 +258,9 @@ static unsigned long finish_depth_computation(struct prio_queue *queue,
 	struct oidset unflagged = OIDSET_INIT;
 	struct commit *c;
 
-	for (size_t i = queue->get_pending; i < queue->nr; i++) {
-		struct commit *commit = queue->array[i].data;
-		if (!(commit->object.flags & best->flag_within))
-			oidset_insert(&unflagged, &commit->object.oid);
+	prio_queue_for_each(queue, c) {
+		if (!(c->object.flags & best->flag_within))
+			oidset_insert(&unflagged, &c->object.oid);
 	}
 
 	while ((c = prio_queue_get(queue))) {
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index df2a508244..5478182f2e 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -344,7 +344,7 @@ static void process_parent(struct last_modified *lm,
 static int last_modified_run(struct last_modified *lm)
 {
 	int max_count, queue_popped = 0;
-	struct commit *c;
+	struct commit *c, *n;
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	struct prio_queue not_queue = { compare_commits_by_gen_then_commit_date };
 	struct commit_list *list;
@@ -416,9 +416,8 @@ static int last_modified_run(struct last_modified *lm)
 		 */
 		repo_parse_commit(lm->rev.repo, c);
 
-		while (not_queue.nr) {
+		while ((n = prio_queue_get(&not_queue))) {
 			struct commit_list *np;
-			struct commit *n = prio_queue_get(&not_queue);
 
 			repo_parse_commit(lm->rev.repo, n);
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 9f7f28f339..2435e8aeda 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -62,11 +62,10 @@ static const char *get_color_reset_code(void)
 
 static struct commit *interesting(struct prio_queue *queue)
 {
-	for (size_t i = queue->get_pending; i < queue->nr; i++) {
-		struct commit *commit = queue->array[i].data;
-		if (commit->object.flags & UNINTERESTING)
-			continue;
-		return commit;
+	struct commit *commit;
+	prio_queue_for_each(queue, commit) {
+		if (!(commit->object.flags & UNINTERESTING))
+			return commit;
 	}
 	return NULL;
 }
diff --git a/commit-reach.c b/commit-reach.c
index 0fec2f00be..dfe6016cb2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -41,8 +41,8 @@ static int compare_commits_by_gen(const void *_a, const void *_b)
 
 static int queue_has_nonstale(struct prio_queue *queue)
 {
-	for (size_t i = 0; i < queue->nr; i++) {
-		struct commit *commit = queue->array[i].data;
+	struct commit *commit;
+	prio_queue_for_each(queue, commit) {
 		if (!(commit->object.flags & STALE))
 			return 1;
 	}
@@ -1069,6 +1069,7 @@ void ahead_behind(struct repository *r,
 		  struct commit **commits, size_t commits_nr,
 		  struct ahead_behind_count *counts, size_t counts_nr)
 {
+	struct commit *c;
 	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
 	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
 
@@ -1085,17 +1086,19 @@ void ahead_behind(struct repository *r,
 	init_bit_arrays(&bit_arrays);
 
 	for (size_t i = 0; i < commits_nr; i++) {
-		struct commit *c = commits[i];
-		struct bitmap *bitmap = get_bit_array(c, width);
+		struct bitmap *bitmap;
+		c = commits[i];
+		bitmap = get_bit_array(c, width);
 
 		bitmap_set(bitmap, i);
 		insert_no_dup(&queue, c);
 	}
 
 	while (queue_has_nonstale(&queue)) {
-		struct commit *c = prio_queue_get(&queue);
 		struct commit_list *p;
-		struct bitmap *bitmap_c = get_bit_array(c, width);
+		struct bitmap *bitmap_c;
+		c = prio_queue_get(&queue);
+		bitmap_c = get_bit_array(c, width);
 
 		for (size_t i = 0; i < counts_nr; i++) {
 			int reach_from_tip = !!bitmap_get(bitmap_c, counts[i].tip_index);
@@ -1135,8 +1138,8 @@ void ahead_behind(struct repository *r,
 
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
-	for (size_t i = 0; i < queue.nr; i++)
-		free_bit_array(queue.array[i].data);
+	prio_queue_for_each(&queue, c)
+		free_bit_array(c);
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 120e01f3cf..29c41132ee 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -662,8 +662,8 @@ static int mark_complete_oid(const struct reference *ref, void *cb_data UNUSED)
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
 					 timestamp_t cutoff)
 {
-	while (complete.nr) {
-		struct commit *item = prio_queue_peek(&complete);
+	struct commit *item;
+	while ((item = prio_queue_peek(&complete))) {
 		if (item->date < cutoff)
 			break;
 		print_verbose(args, _("Marking %s as complete"),
diff --git a/negotiator/default.c b/negotiator/default.c
index 78d58d57ce..19cdf3808c 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -113,10 +113,12 @@ static const struct object_id *get_rev(struct negotiation_state *ns)
 		unsigned int mark;
 		struct commit_list *parents;
 
-		if (ns->rev_list.nr == 0 || ns->non_common_revs == 0)
+		if (ns->non_common_revs == 0)
 			return NULL;
 
 		commit = prio_queue_get(&ns->rev_list);
+		if (!commit)
+			return NULL;
 		repo_parse_commit(the_repository, commit);
 		parents = commit->parents;
 
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 68c9b3b997..db90fa77b5 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -143,8 +143,7 @@ static int push_parent(struct data *data, struct entry *entry,
 		/*
 		 * Find the existing entry and use it.
 		 */
-		for (size_t i = 0; i < data->rev_list.nr; i++) {
-			parent_entry = data->rev_list.array[i].data;
+		prio_queue_for_each(&data->rev_list, parent_entry) {
 			if (parent_entry->commit == to_push)
 				goto parent_found;
 		}
@@ -181,10 +180,12 @@ static const struct object_id *get_rev(struct data *data)
 		struct commit_list *p;
 		int parent_pushed = 0;
 
-		if (data->rev_list.nr == 0 || data->non_common_revs == 0)
+		if (data->non_common_revs == 0)
 			return NULL;
 
 		entry = prio_queue_get(&data->rev_list);
+		if (!entry)
+			return NULL;
 		commit = entry->commit;
 		commit->object.flags |= POPPED;
 		if (!(commit->object.flags & COMMON))
@@ -253,8 +254,9 @@ static void have_sent(struct fetch_negotiator *n, struct commit *c)
 static void release(struct fetch_negotiator *n)
 {
 	struct data *data = n->data;
-	for (size_t i = 0; i < data->rev_list.nr; i++)
-		free(data->rev_list.array[i].data);
+	void *entry;
+	prio_queue_for_each(&data->rev_list, entry)
+		free(entry);
 	clear_prio_queue(&data->rev_list);
 	FREE_AND_NULL(data);
 }
diff --git a/object-name.c b/object-name.c
index 9ac86f19c7..2fedfe1761 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1208,7 +1208,7 @@ static int get_oid_oneline(struct repository *r,
 		l->item->object.flags |= ONELINE_SEEN;
 		prio_queue_put(&copy, l->item);
 	}
-	while (copy.nr) {
+	while (prio_queue_size(&copy)) {
 		const char *p, *buf;
 		struct commit *commit;
 		int matches;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index f7c63e3027..ed9714b135 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -514,6 +514,7 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			      const uint32_t *mapping)
 {
 	struct commit *c;
+	struct tree *tree;
 	int found;
 	uint32_t pos;
 	if (!ent->bitmap)
@@ -574,9 +575,8 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 		}
 	}
 
-	while (tree_queue->nr) {
-		if (fill_bitmap_tree(writer, ent->bitmap,
-				     prio_queue_get(tree_queue)) < 0)
+	while ((tree = prio_queue_get(tree_queue))) {
+		if (fill_bitmap_tree(writer, ent->bitmap, tree) < 0)
 			return -1;
 	}
 	return 0;
diff --git a/path-walk.c b/path-walk.c
index 94ff90bd15..cf3b2d0765 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -699,6 +699,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	int ret;
 	size_t commits_nr = 0, paths_nr = 0;
 	struct commit *c;
+	char *path;
 	struct type_and_oid_list *root_tree_list;
 	struct type_and_oid_list *commit_list;
 	struct path_walk_context ctx = {
@@ -808,8 +809,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 	free(commit_list);
 
 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
-	while (!ret && ctx.path_stack.nr) {
-		char *path = prio_queue_get(&ctx.path_stack);
+	while (!ret && (path = prio_queue_get(&ctx.path_stack))) {
 		paths_nr++;
 
 		ret = walk_path(&ctx, path);
@@ -821,12 +821,12 @@ int walk_objects_by_path(struct path_walk_info *info)
 	if (!strmap_empty(&ctx.paths_to_lists)) {
 		struct hashmap_iter iter;
 		struct strmap_entry *entry;
+		char *path;
 
 		strmap_for_each_entry(&ctx.paths_to_lists, &iter, entry)
 			push_to_stack(&ctx, entry->key);
 
-		while (!ret && ctx.path_stack.nr) {
-			char *path = prio_queue_get(&ctx.path_stack);
+		while (!ret && (path = prio_queue_get(&ctx.path_stack))) {
 			paths_nr++;
 
 			ret = walk_path(&ctx, path);
diff --git a/prio-queue.c b/prio-queue.c
index a03c617470..f96b810c15 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -22,16 +22,16 @@ void prio_queue_reverse(struct prio_queue *queue)
 
 	if (queue->compare)
 		BUG("prio_queue_reverse() on non-LIFO queue");
-	if (!queue->nr)
+	if (!queue->nr_internal)
 		return;
-	for (i = 0; i < (j = (queue->nr - 1) - i); i++)
+	for (i = 0; i < (j = (queue->nr_internal - 1) - i); i++)
 		swap(queue, i, j);
 }
 
 void clear_prio_queue(struct prio_queue *queue)
 {
 	FREE_AND_NULL(queue->array);
-	queue->nr = 0;
+	queue->nr_internal = 0;
 	queue->alloc = 0;
 	queue->insertion_ctr = 0;
 	queue->get_pending = 0;
@@ -41,13 +41,16 @@ static void sift_down_root(struct prio_queue *queue)
 {
 	size_t ix, child;
 
-	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
-		child = ix * 2 + 1;
-		if (child + 1 < queue->nr &&
+	/* Push down the one at the root */
+	for (ix = 0; ix * 2 + 1 < queue->nr_internal; ix = child) {
+		child = ix * 2 + 1; /* left */
+		if (child + 1 < queue->nr_internal &&
 		    compare(queue, child, child + 1) >= 0)
-			child++;
+			child++; /* use right child */
+
 		if (compare(queue, ix, child) <= 0)
 			break;
+
 		swap(queue, child, ix);
 	}
 }
@@ -64,34 +67,37 @@ void prio_queue_put(struct prio_queue *queue, void *thing)
 		return;
 	}
 
-	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
-	queue->array[queue->nr].ctr = queue->insertion_ctr++;
-	queue->array[queue->nr].data = thing;
-	queue->nr++;
+	/* Append at the end */
+	ALLOC_GROW(queue->array, queue->nr_internal + 1, queue->alloc);
+	queue->array[queue->nr_internal].ctr = queue->insertion_ctr++;
+	queue->array[queue->nr_internal].data = thing;
+	queue->nr_internal++;
 	if (!queue->compare)
-		return;
+		return; /* LIFO */
 
-	for (ix = queue->nr - 1; ix; ix = parent) {
+	/* Bubble up the new one */
+	for (ix = queue->nr_internal - 1; ix; ix = parent) {
 		parent = (ix - 1) / 2;
 		if (compare(queue, parent, ix) <= 0)
 			break;
+
 		swap(queue, parent, ix);
 	}
 }
 
 void *prio_queue_get(struct prio_queue *queue)
 {
-	if (!queue->nr)
+	if (!queue->nr_internal)
 		return NULL;
 	if (!queue->compare)
-		return queue->array[--queue->nr].data;
+		return queue->array[--queue->nr_internal].data; /* LIFO */
 
 	if (queue->get_pending) {
-		if (!--queue->nr) {
+		if (!--queue->nr_internal) {
 			queue->get_pending = 0;
 			return NULL;
 		}
-		queue->array[0] = queue->array[queue->nr];
+		queue->array[0] = queue->array[queue->nr_internal];
 		sift_down_root(queue);
 	}
 
@@ -101,16 +107,16 @@ void *prio_queue_get(struct prio_queue *queue)
 
 void *prio_queue_peek(struct prio_queue *queue)
 {
-	if (!queue->nr)
+	if (!queue->nr_internal)
 		return NULL;
 	if (!queue->compare)
-		return queue->array[queue->nr - 1].data;
+		return queue->array[queue->nr_internal - 1].data;
 
 	if (queue->get_pending) {
 		queue->get_pending = 0;
-		if (!--queue->nr)
+		if (!--queue->nr_internal)
 			return NULL;
-		queue->array[0] = queue->array[queue->nr];
+		queue->array[0] = queue->array[queue->nr_internal];
 		sift_down_root(queue);
 	}
 
diff --git a/prio-queue.h b/prio-queue.h
index 482ab5e71d..f08ab87691 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -30,7 +30,7 @@ struct prio_queue {
 	prio_queue_compare_fn compare;
 	size_t insertion_ctr;
 	void *cb_data;
-	size_t alloc, nr;
+	size_t alloc, nr_internal; /* use prio_queue_size() for logical count */
 	struct prio_queue_entry *array;
 	unsigned get_pending;
 };
@@ -55,9 +55,14 @@ void *prio_queue_peek(struct prio_queue *);
 
 static inline size_t prio_queue_size(struct prio_queue *queue)
 {
-	return queue->nr - queue->get_pending;
+	return queue->nr_internal - queue->get_pending;
 }
 
+#define prio_queue_for_each(queue, it) \
+	for (size_t pq_ix_ = (queue)->get_pending; \
+	     pq_ix_ < (queue)->nr_internal && ((it) = (queue)->array[pq_ix_].data, 1); \
+	     pq_ix_++)
+
 void clear_prio_queue(struct prio_queue *);
 
 /* Reverse the LIFO elements */
diff --git a/revision.c b/revision.c
index 8ce8ffa43d..34e2d146f4 100644
--- a/revision.c
+++ b/revision.c
@@ -476,16 +476,15 @@ static struct commit *handle_commit(struct rev_info *revs,
 static int everybody_uninteresting(struct prio_queue *orig,
 				   struct commit **interesting_cache)
 {
-	size_t i;
+	struct commit *commit;
 
 	if (*interesting_cache) {
-		struct commit *commit = *interesting_cache;
+		commit = *interesting_cache;
 		if (!(commit->object.flags & UNINTERESTING))
 			return 0;
 	}
 
-	for (i = 0; i < orig->nr; i++) {
-		struct commit *commit = orig->array[i].data;
+	prio_queue_for_each(orig, commit) {
 		if (commit->object.flags & UNINTERESTING)
 			continue;
 
@@ -4027,8 +4026,8 @@ static enum rewrite_result rewrite_one_1(struct rev_info *revs,
 
 static void merge_queue_into_list(struct prio_queue *q, struct commit_list **list)
 {
-	while (q->nr) {
-		struct commit *item = prio_queue_peek(q);
+	struct commit *item;
+	while ((item = prio_queue_peek(q))) {
 		struct commit_list *p = *list;
 
 		if (p && p->item->date >= item->date)
-- 
gitgitgadget
