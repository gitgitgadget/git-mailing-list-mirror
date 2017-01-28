Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53AF21F437
	for <e@80x24.org>; Sat, 28 Jan 2017 21:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbdA1VmU (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 16:42:20 -0500
Received: from mout.web.de ([212.227.15.4]:57102 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbdA1VmT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 16:42:19 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdrkJ-1c7dVm3QDj-00j0M6; Sat, 28
 Jan 2017 22:41:09 +0100
Subject: [PATCH 3/5] use SWAP macro
To:     Git List <git@vger.kernel.org>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <187c2b39-40cf-7e07-b489-d40cdf5f9145@web.de>
Date:   Sat, 28 Jan 2017 22:40:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9BE4boFZhnMZ9fKsZn3EF7w6glwEamb0KNR4f+51TZ3lh0XGMzj
 zuI+iIX6SaxGnoleMsBGQ2BxTNKTxqtml3CDA0YHNlFFge/3vkU2WhE5e4bIsHcT05nJd7P
 f7VDXGKc4u8FijpA050rrg8/GYazLXiV4IjKuyR7oLYFk6K3g4YDKd6Fuhq9ft7Dl1qrI+o
 a9xkSHOYXYnEsQODxrS1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X8rp+vL4zn0=:5KhX57QXmdxFY0HbyNLKGP
 pWdDsDOdsbObltAwwL1AqIt36ijxSaAVALuX663KuBw6+tqyun+i0mb+9YOlJMzEGDedA247Q
 gqFnZWzlTQW3DlhfKT41eKrIFV1nQaCb3zESzvFSo7uUuG9wQFkrJeGvtTVhXl4MWzIMIywJP
 gTehDyFrIpGG4bBopUJpN9qJlSwtXIJXJHS9XjF/jyL1Y+1K5gQ0ipzIIHNFKyG93B7DpYYPa
 dvgTYbRa3OctJwXq+0LuMF+C80xBWrHktPkmxFTqbOfepk00N7l8UuQM3sLwBXNk56FIp6A6m
 /Hn16p2eVnzIOqMCrNXT4KWisCtKj40oYPXp3j8RqUXI5iPx+SqXlpXqb0pFxf1FW9ICPXGnq
 KF4OYwgUmnQ640EIxCaV1+BLub40gD3vwnWZapBeB7l9nyl/MtHcGf0YJEfPOyegZdE+s11ou
 WkDMVHC5tekm8cjykeNbvmrJNHJnvOl0De0FcV0zCX8mTFXkZRfbaxSzadCR+Z+Nr2WU6M9w2
 rpp4vaFl8dWFpoTMyL6qL8F7AwNd+yG49zdHyhO+vgyYi1dhHrHtbH9m8C28D6YgjNec+3FSd
 OXwCk8BWma7okuLVlJvhGWFTJ8VVyJsXiS94DIfhHZYnLJFmQM+zeR6opxUbUGEnrQQfon2rp
 SZgFZqDUK9QGYlcn+qrcGWFLy2ch5Mlm9TdZT2EIqpPPlMvFr6nbnuV3RIfx77mex7+t5fXzE
 PybwwxAeZj+JaTDitKLUg6EhPZODOx4xDmX3oEOW7M1taGjRter8zqyF23k49JvS7wlZ5Krcf
 iU6BMdy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the semantic patch swap.cocci to convert hand-rolled swaps to use
the macro SWAP.  The resulting code is shorter and easier to read, the
object code is effectively unchanged.

The patch for object.c had to be hand-edited in order to preserve the
comment before the change; Coccinelle tried to eat it for some reason.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/diff-tree.c | 4 +---
 builtin/diff.c      | 9 +++------
 diff-no-index.c     | 3 +--
 diff.c              | 8 +++-----
 graph.c             | 5 +----
 line-range.c        | 3 +--
 merge-recursive.c   | 5 +----
 object.c            | 4 +---
 pack-revindex.c     | 5 +----
 prio-queue.c        | 4 +---
 strbuf.h            | 4 +---
 11 files changed, 15 insertions(+), 39 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 806dd7a885..8ce00480cd 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -147,9 +147,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		tree1 = opt->pending.objects[0].item;
 		tree2 = opt->pending.objects[1].item;
 		if (tree2->flags & UNINTERESTING) {
-			struct object *tmp = tree2;
-			tree2 = tree1;
-			tree1 = tmp;
+			SWAP(tree2, tree1);
 		}
 		diff_tree_sha1(tree1->oid.hash,
 			       tree2->oid.hash,
diff --git a/builtin/diff.c b/builtin/diff.c
index 7f91f6d226..3d64b85337 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -45,12 +45,9 @@ static void stuff_change(struct diff_options *opt,
 		return;
 
 	if (DIFF_OPT_TST(opt, REVERSE_DIFF)) {
-		unsigned tmp;
-		const unsigned char *tmp_u;
-		const char *tmp_c;
-		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
-		tmp_u = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_u;
-		tmp_c = old_name; old_name = new_name; new_name = tmp_c;
+		SWAP(old_mode, new_mode);
+		SWAP(old_sha1, new_sha1);
+		SWAP(old_name, new_name);
 	}
 
 	if (opt->prefix &&
diff --git a/diff-no-index.c b/diff-no-index.c
index f420786039..1ae09894d7 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -186,9 +186,8 @@ static int queue_diff(struct diff_options *o,
 
 		if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 			unsigned tmp;
-			const char *tmp_c;
 			tmp = mode1; mode1 = mode2; mode2 = tmp;
-			tmp_c = name1; name1 = name2; name2 = tmp_c;
+			SWAP(name1, name2);
 		}
 
 		d1 = noindex_filespec(name1, mode1);
diff --git a/diff.c b/diff.c
index f08cd8e033..9de1ba264f 100644
--- a/diff.c
+++ b/diff.c
@@ -5118,13 +5118,11 @@ void diff_change(struct diff_options *options,
 
 	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
 		unsigned tmp;
-		const unsigned char *tmp_c;
-		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
-		tmp_c = old_sha1; old_sha1 = new_sha1; new_sha1 = tmp_c;
+		SWAP(old_mode, new_mode);
+		SWAP(old_sha1, new_sha1);
 		tmp = old_sha1_valid; old_sha1_valid = new_sha1_valid;
 			new_sha1_valid = tmp;
-		tmp = old_dirty_submodule; old_dirty_submodule = new_dirty_submodule;
-			new_dirty_submodule = tmp;
+		SWAP(old_dirty_submodule, new_dirty_submodule);
 	}
 
 	if (options->prefix &&
diff --git a/graph.c b/graph.c
index d4e8519c90..4c722303d2 100644
--- a/graph.c
+++ b/graph.c
@@ -997,7 +997,6 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct strbuf
 static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf *sb)
 {
 	int i;
-	int *tmp_mapping;
 	short used_horizontal = 0;
 	int horizontal_edge = -1;
 	int horizontal_edge_target = -1;
@@ -1132,9 +1131,7 @@ static void graph_output_collapsing_line(struct git_graph *graph, struct strbuf
 	/*
 	 * Swap mapping and new_mapping
 	 */
-	tmp_mapping = graph->mapping;
-	graph->mapping = graph->new_mapping;
-	graph->new_mapping = tmp_mapping;
+	SWAP(graph->mapping, graph->new_mapping);
 
 	/*
 	 * If graph->mapping indicates that all of the branch lines
diff --git a/line-range.c b/line-range.c
index de4e32f942..323399d16c 100644
--- a/line-range.c
+++ b/line-range.c
@@ -269,8 +269,7 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 		return -1;
 
 	if (*begin && *end && *end < *begin) {
-		long tmp;
-		tmp = *end; *end = *begin; *begin = tmp;
+		SWAP(*end, *begin);
 	}
 
 	return 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index d327209443..b7ff1ada3c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1390,14 +1390,11 @@ static int process_renames(struct merge_options *o,
 			branch1 = o->branch1;
 			branch2 = o->branch2;
 		} else {
-			struct rename *tmp;
 			renames1 = b_renames;
 			renames2Dst = &a_by_dst;
 			branch1 = o->branch2;
 			branch2 = o->branch1;
-			tmp = ren2;
-			ren2 = ren1;
-			ren1 = tmp;
+			SWAP(ren2, ren1);
 		}
 
 		if (ren1->processed)
diff --git a/object.c b/object.c
index 67d9a9e221..e680d881a4 100644
--- a/object.c
+++ b/object.c
@@ -104,9 +104,7 @@ struct object *lookup_object(const unsigned char *sha1)
 		 * that we do not need to walk the hash table the next
 		 * time we look for it.
 		 */
-		struct object *tmp = obj_hash[i];
-		obj_hash[i] = obj_hash[first];
-		obj_hash[first] = tmp;
+		SWAP(obj_hash[i], obj_hash[first]);
 	}
 	return obj;
 }
diff --git a/pack-revindex.c b/pack-revindex.c
index 6bc7c94033..1b7ebd8d7e 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -59,7 +59,6 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 	 * be a no-op, as everybody lands in the same zero-th bucket.
 	 */
 	for (bits = 0; max >> bits; bits += DIGIT_SIZE) {
-		struct revindex_entry *swap;
 		unsigned i;
 
 		memset(pos, 0, BUCKETS * sizeof(*pos));
@@ -97,9 +96,7 @@ static void sort_revindex(struct revindex_entry *entries, unsigned n, off_t max)
 		 * Now "to" contains the most sorted list, so we swap "from" and
 		 * "to" for the next iteration.
 		 */
-		swap = from;
-		from = to;
-		to = swap;
+		SWAP(from, to);
 	}
 
 	/*
diff --git a/prio-queue.c b/prio-queue.c
index e4365b00d6..17252d231b 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -12,9 +12,7 @@ static inline int compare(struct prio_queue *queue, int i, int j)
 
 static inline void swap(struct prio_queue *queue, int i, int j)
 {
-	struct prio_queue_entry tmp = queue->array[i];
-	queue->array[i] = queue->array[j];
-	queue->array[j] = tmp;
+	SWAP(queue->array[i], queue->array[j]);
 }
 
 void prio_queue_reverse(struct prio_queue *queue)
diff --git a/strbuf.h b/strbuf.h
index 2262b12683..cf1b5409e7 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -109,9 +109,7 @@ extern void strbuf_attach(struct strbuf *, void *, size_t, size_t);
  */
 static inline void strbuf_swap(struct strbuf *a, struct strbuf *b)
 {
-	struct strbuf tmp = *a;
-	*a = *b;
-	*b = tmp;
+	SWAP(*a, *b);
 }
 
 
-- 
2.11.0

