Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F4224B04
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945858; cv=none; b=gcrLciCp09220dvv9VnQ2dKk8yCf2zGitcZ4u4lsoAqC+TeW6MxnkI4icC9NKZ7gtGkC5T8HTT+M8aDXFzIzxH2zdGQKgbMhOBbCbpbOyR9yRVEgBSovwJdcpJ/zWFc0brdiyS7sDfDqq9TXN3SrJIT+t2yTpuOoZa+EGw1KeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945858; c=relaxed/simple;
	bh=rg2TIA1JvhNV4PaD1wlJt/yiTCmLBxyrg4KxHHd2ADc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G0gyUeHp1zD1Zxeq1BGyUdtwDVzmc11GRV7cJGUYqueFYa04EtoZVY8/Ky7XON/P0vSlEwd2izVj6XBh7lJw8sz3Mh3KFB5EtD20XFUFQ1QGe6BuqNmTeClbVdhWadvsb9D+uPl5fxm7L3o39lQmBIcGfHmfFSDhi6OvxKzujGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQn6h/+R; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQn6h/+R"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5a46be4862fso1141765e0c.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780945855; x=1781550655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X/2fgOvpXkR6HarjqWooNb6Oe8pSrOKzbQVSdqARkA=;
        b=GQn6h/+RQ69xsLcDLqXeDHn6mEAo2avvd1WRMD11gUqBGSI7bn+JwyLD0HpabaAEVb
         GFqZjjW4krH2k2u2TIc3L060X+zUnZuh+J2XIt44EwuNya+A/2Ar6mP6vuIYJHqkVnfs
         7oIcToVQmiaKHy6A7h7tossYn+Dj3bsiNgYtILJh2aIA7VbjG4PxQo98KEA2wJDOU6vQ
         D1GxdJoa6Cl43gXIx7qiRyOuluoKpOyv6ywXOJvvAZU1Ty4efmSP5FP9OlNkvNNiSW9P
         Di+zxm/trddxXgEaVcO148KwFPjTG1R/pwrQvN+mMLvnSFVlArkrhBaO4gT8Nsdaxh/O
         1jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945855; x=1781550655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2X/2fgOvpXkR6HarjqWooNb6Oe8pSrOKzbQVSdqARkA=;
        b=SKgkPFTUdX4iTx6k6g1Rg++b2rdR8Y2dofC77+6vQPGg1OWMSBNqSs7w/xVxChUq3N
         W0SuldrPzCBYHIIvNyHw9H3JHdVD323Pz555XN4PrDyRQXkkwwN5LODt+CtgVGRm1Rdv
         01Cw6p8q6oomHse4P3Qu33zzgecjkSYId13HMqxEIx1k2PwcT0YHuaUf3lR5iFra0EsK
         SExJm3w32nhjWnAAyFP2Z1/LClEE+p5IM9pcI1cx2JpCUd4gg+QUufo57Oay7Ae7tvED
         jLltKuDRXh7UcFtNHPgB11I6wIoJ4gapqXkVpfAHF6zGVJdnMK6DNRrLSKVidf/Wzzm3
         6E2Q==
X-Gm-Message-State: AOJu0YxhTp4Xqb84PEG8+oz71XHod04XMoTFhRqImS4VM76fAskAIHNx
	/c2cij5qWArJ68WoK+86KA9C1ZqyQsWeCj7BzVpeEztePJhqMeLQtXYhGfZwVA==
X-Gm-Gg: Acq92OFLrK8ZBlPKJNiXV1JTKthvQmti9sipMMXtWR91Kh/3Pjd/LtH9WZk9c59aD8U
	ei7k4zjiMxRw+/a4+y5RO90+IBCIXCrej7kuqH7RQDZLq6TPm4QTt4jKJOj77FXoRablpd3jKpf
	HKNUc37avl4U8eadp3wGKvVkQzfIb+H6obup16Jt3bNPnhr9dYdqsp8XT/aSeIT3/X2N8G7c2F/
	B8RkdejiEhkkjrCICtSgB3QDuCLlZAPveBz5vbfLeXh+a09PSVKIQZkJw5twFFGtefCXO0U5GuA
	y/bht+yNu9YZ8O0yLk26lXcbAeoRpBrHGZaPFeChXTp83OGQBRmSeNUnX0e2NH4L5zbUE3r61VA
	IddNs+ydadMLpYG/FLIl/3M6hsyqZKp6p+rTw1UYCRorq/7LLwNMolVmy4I9EOwo8RNkG+EWNFm
	xQhl/BWB9vww8VlhY5/6ve81tTzQxqp6bjiirU
X-Received: by 2002:a05:6122:4692:b0:5a6:7838:d679 with SMTP id 71dfb90a1353d-5ac52c09f1amr8249060e0c.13.1780945855488;
        Mon, 08 Jun 2026 12:10:55 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.213.35])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96413fcc8fdsm14096643241.7.2026.06.08.12.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 12:10:54 -0700 (PDT)
Message-Id: <d0f22946610492695d42b6f98368157625b246a2.1780945851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2140.v4.git.1780945851.gitgitgadget@gmail.com>
References: <pull.2140.v3.git.1780832592.gitgitgadget@gmail.com>
	<pull.2140.v4.git.1780945851.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 19:10:50 +0000
Subject: [PATCH v4 1/2] prio-queue: rename .nr to .nr_ and add accessor
 helpers
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

Rename the .nr member to .nr_ so that callers outside prio-queue.c
that directly reference .nr get a compilation error.  This catches
both existing misuse and future in-flight topics.

Add prio_queue_size() for callers that need to know the element count
and prio_queue_for_each() for callers that need to walk all elements.

Convert all external .nr users:
 - Loop conditions: use prio_queue_size(), prio_queue_get(), or
   prio_queue_peek() as the loop condition
 - Array iterations: use prio_queue_for_each()

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/describe.c      | 11 ++++++++---
 builtin/last-modified.c |  7 +++----
 builtin/show-branch.c   | 13 ++++++-------
 commit-reach.c          | 14 +++++++-------
 fetch-pack.c            |  4 ++--
 negotiator/default.c    |  4 +++-
 negotiator/skipping.c   | 12 +++++++-----
 object-name.c           |  2 +-
 pack-bitmap-write.c     | 10 +++++-----
 path-walk.c             |  8 ++++----
 prio-queue.c            | 38 +++++++++++++++++++-------------------
 prio-queue.h            | 12 +++++++++++-
 revision.c              | 16 +++++++---------
 walker.c                |  4 ++--
 14 files changed, 85 insertions(+), 70 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1c47d7c0b7..8e88bdeea6 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -278,7 +278,7 @@ static void lazy_queue_put(struct lazy_queue *queue, void *thing)
 
 static bool lazy_queue_empty(const struct lazy_queue *queue)
 {
-	return queue->queue.nr == (queue->get_pending ? 1 : 0);
+	return prio_queue_size(&queue->queue) == (queue->get_pending ? 1 : 0);
 }
 
 static void lazy_queue_clear(struct lazy_queue *queue)
@@ -292,9 +292,14 @@ static unsigned long finish_depth_computation(struct lazy_queue *queue,
 {
 	unsigned long seen_commits = 0;
 	struct oidset unflagged = OIDSET_INIT;
+	struct commit *commit;
+	int skip = queue->get_pending ? 1 : 0;
 
-	for (size_t i = queue->get_pending ? 1 : 0; i < queue->queue.nr; i++) {
-		struct commit *commit = queue->queue.array[i].data;
+	prio_queue_for_each(&queue->queue, commit) {
+		if (skip) {
+			skip = 0;
+			continue;
+		}
 		if (!(commit->object.flags & best->flag_within))
 			oidset_insert(&unflagged, &commit->object.oid);
 	}
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 8900ceece1..5478182f2e 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -344,6 +344,7 @@ static void process_parent(struct last_modified *lm,
 static int last_modified_run(struct last_modified *lm)
 {
 	int max_count, queue_popped = 0;
+	struct commit *c, *n;
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
@@ -416,9 +416,8 @@ static int last_modified_run(struct last_modified *lm)
 		 */
 		repo_parse_commit(lm->rev.repo, c);
 
-		while (not_queue.nr) {
+		while ((n = prio_queue_get(&not_queue))) {
 			struct commit_list *np;
-			struct commit *n = prio_queue_get(&not_queue);
 
 			repo_parse_commit(lm->rev.repo, n);
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index f02831b085..8846f2376f 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -62,11 +62,10 @@ static const char *get_color_reset_code(void)
 
 static struct commit *interesting(struct prio_queue *queue)
 {
-	for (size_t i = 0; i < queue->nr; i++) {
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
@@ -228,11 +227,11 @@ static void join_revs(struct prio_queue *queue,
 {
 	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
 	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
+	struct commit *commit;
 
-	while (queue->nr) {
+	while ((commit = prio_queue_peek(queue))) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(queue);
-		struct commit *commit = prio_queue_peek(queue);
 		bool get_pending = true;
 		int flags = commit->object.flags & all_mask;
 
diff --git a/commit-reach.c b/commit-reach.c
index 9b3ea46d6f..a849de653e 100644
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
@@ -1070,6 +1070,7 @@ void ahead_behind(struct repository *r,
 		  struct ahead_behind_count *counts, size_t counts_nr)
 {
 	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
+	void *entry;
 	size_t width = DIV_ROUND_UP(commits_nr, BITS_IN_EWORD);
 
 	if (!commits_nr || !counts_nr)
@@ -1135,8 +1136,8 @@ void ahead_behind(struct repository *r,
 
 	/* STALE is used here, PARENT2 is used by insert_no_dup(). */
 	repo_clear_commit_marks(r, PARENT2 | STALE);
-	for (size_t i = 0; i < queue.nr; i++)
-		free_bit_array(queue.array[i].data);
+	prio_queue_for_each(&queue, entry)
+		free_bit_array(entry);
 	clear_bit_arrays(&bit_arrays);
 	clear_prio_queue(&queue);
 }
@@ -1269,7 +1270,7 @@ int get_branch_base_for_tip(struct repository *r,
 			    size_t bases_nr)
 {
 	int best_index = -1;
-	struct commit *branch_point = NULL;
+	struct commit *c, *branch_point = NULL;
 	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
 	int found_missing_gen = 0;
 
@@ -1322,8 +1323,7 @@ int get_branch_base_for_tip(struct repository *r,
 		prio_queue_put(&queue, c);
 	}
 
-	while (queue.nr) {
-		struct commit *c = prio_queue_get(&queue);
+	while ((c = prio_queue_get(&queue))) {
 		int best_for_c = get_best(c);
 		int best_for_p, positive;
 		struct commit *parent;
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
index 1c8070f99c..ed9714b135 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -513,6 +513,8 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 			      struct bitmap_index *old_bitmap,
 			      const uint32_t *mapping)
 {
+	struct commit *c;
+	struct tree *tree;
 	int found;
 	uint32_t pos;
 	if (!ent->bitmap)
@@ -520,9 +522,8 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
 
 	prio_queue_put(queue, commit);
 
-	while (queue->nr) {
+	while ((c = prio_queue_get(queue))) {
 		struct commit_list *p;
-		struct commit *c = prio_queue_get(queue);
 
 		if (old_bitmap && mapping) {
 			struct ewah_bitmap *old;
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
index 9748528ce6..ead4faf4bb 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -22,16 +22,16 @@ void prio_queue_reverse(struct prio_queue *queue)
 
 	if (queue->compare)
 		BUG("prio_queue_reverse() on non-LIFO queue");
-	if (!queue->nr)
+	if (!queue->nr_)
 		return;
-	for (i = 0; i < (j = (queue->nr - 1) - i); i++)
+	for (i = 0; i < (j = (queue->nr_ - 1) - i); i++)
 		swap(queue, i, j);
 }
 
 void clear_prio_queue(struct prio_queue *queue)
 {
 	FREE_AND_NULL(queue->array);
-	queue->nr = 0;
+	queue->nr_ = 0;
 	queue->alloc = 0;
 	queue->insertion_ctr = 0;
 }
@@ -41,15 +41,15 @@ void prio_queue_put(struct prio_queue *queue, void *thing)
 	size_t ix, parent;
 
 	/* Append at the end */
-	ALLOC_GROW(queue->array, queue->nr + 1, queue->alloc);
-	queue->array[queue->nr].ctr = queue->insertion_ctr++;
-	queue->array[queue->nr].data = thing;
-	queue->nr++;
+	ALLOC_GROW(queue->array, queue->nr_ + 1, queue->alloc);
+	queue->array[queue->nr_].ctr = queue->insertion_ctr++;
+	queue->array[queue->nr_].data = thing;
+	queue->nr_++;
 	if (!queue->compare)
 		return; /* LIFO */
 
 	/* Bubble up the new one */
-	for (ix = queue->nr - 1; ix; ix = parent) {
+	for (ix = queue->nr_ - 1; ix; ix = parent) {
 		parent = (ix - 1) / 2;
 		if (compare(queue, parent, ix) <= 0)
 			break;
@@ -63,9 +63,9 @@ static void sift_down_root(struct prio_queue *queue)
 	size_t ix, child;
 
 	/* Push down the one at the root */
-	for (ix = 0; ix * 2 + 1 < queue->nr; ix = child) {
+	for (ix = 0; ix * 2 + 1 < queue->nr_; ix = child) {
 		child = ix * 2 + 1; /* left */
-		if (child + 1 < queue->nr &&
+		if (child + 1 < queue->nr_ &&
 		    compare(queue, child, child + 1) >= 0)
 			child++; /* use right child */
 
@@ -80,36 +80,36 @@ void *prio_queue_get(struct prio_queue *queue)
 {
 	void *result;
 
-	if (!queue->nr)
+	if (!queue->nr_)
 		return NULL;
 	if (!queue->compare)
-		return queue->array[--queue->nr].data; /* LIFO */
+		return queue->array[--queue->nr_].data; /* LIFO */
 
 	result = queue->array[0].data;
-	if (!--queue->nr)
+	if (!--queue->nr_)
 		return result;
 
-	queue->array[0] = queue->array[queue->nr];
+	queue->array[0] = queue->array[queue->nr_];
 	sift_down_root(queue);
 	return result;
 }
 
 void *prio_queue_peek(struct prio_queue *queue)
 {
-	if (!queue->nr)
+	if (!queue->nr_)
 		return NULL;
 	if (!queue->compare)
-		return queue->array[queue->nr - 1].data;
+		return queue->array[queue->nr_ - 1].data;
 	return queue->array[0].data;
 }
 
 void prio_queue_replace(struct prio_queue *queue, void *thing)
 {
-	if (!queue->nr) {
+	if (!queue->nr_) {
 		prio_queue_put(queue, thing);
 	} else if (!queue->compare) {
-		queue->array[queue->nr - 1].ctr = queue->insertion_ctr++;
-		queue->array[queue->nr - 1].data = thing;
+		queue->array[queue->nr_ - 1].ctr = queue->insertion_ctr++;
+		queue->array[queue->nr_ - 1].data = thing;
 	} else {
 		queue->array[0].ctr = queue->insertion_ctr++;
 		queue->array[0].data = thing;
diff --git a/prio-queue.h b/prio-queue.h
index da7fad2f1f..7f2aa986b1 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -30,7 +30,7 @@ struct prio_queue {
 	prio_queue_compare_fn compare;
 	size_t insertion_ctr;
 	void *cb_data;
-	size_t alloc, nr;
+	size_t alloc, nr_;
 	struct prio_queue_entry *array;
 };
 
@@ -52,6 +52,16 @@ void *prio_queue_get(struct prio_queue *);
  */
 void *prio_queue_peek(struct prio_queue *);
 
+static inline size_t prio_queue_size(const struct prio_queue *queue)
+{
+	return queue->nr_;
+}
+
+#define prio_queue_for_each(queue, it) \
+	for (size_t pq_ix_ = 0; \
+	     pq_ix_ < (queue)->nr_ && ((it) = (queue)->array[pq_ix_].data, 1); \
+	     pq_ix_++)
+
 /*
  * Replace the "thing" that compares the smallest with a new "thing",
  * like prio_queue_get()+prio_queue_put() would do, but in a more
diff --git a/revision.c b/revision.c
index 5693618be4..34e2d146f4 100644
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
 
@@ -1446,7 +1445,7 @@ static int limit_list(struct rev_info *revs)
 	struct commit_list *original_list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
-	struct commit *interesting_cache = NULL;
+	struct commit *commit, *interesting_cache = NULL;
 	struct prio_queue queue = { .compare = compare_commits_by_commit_date };
 
 	if (revs->ancestry_path_implicit_bottoms) {
@@ -1461,8 +1460,7 @@ static int limit_list(struct rev_info *revs)
 		prio_queue_put(&queue, commit);
 	}
 
-	while (queue.nr) {
-		struct commit *commit = prio_queue_get(&queue);
+	while ((commit = prio_queue_get(&queue))) {
 		struct object *obj = &commit->object;
 
 		if (commit == interesting_cache)
@@ -4028,8 +4026,8 @@ static enum rewrite_result rewrite_one_1(struct rev_info *revs,
 
 static void merge_queue_into_list(struct prio_queue *q, struct commit_list **list)
 {
-	while (q->nr) {
-		struct commit *item = prio_queue_peek(q);
+	struct commit *item;
+	while ((item = prio_queue_peek(q))) {
 		struct commit_list *p = *list;
 
 		if (p && p->item->date >= item->date)
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

