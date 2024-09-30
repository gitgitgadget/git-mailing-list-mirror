Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD318873D
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687632; cv=none; b=abj6pCEHr155i7JZ28e9aSKCiYPG3qZDditwVQSzNHktgJOvou/xFReo8hm4bDd3C8nczu/UkJEfyxQ3daqfgsEL9ftRmfrNStlH/Ovj6fWpz01cPxV243eaZXO837PZueLCJdRa5HW+eUbEBR/cfyY1ij+97VtIhZEzvRrtvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687632; c=relaxed/simple;
	bh=xFLAuXOQ7tEISg+ooFnAA9mSSVyfW5FXp3wxDKnyTlw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy/CX/j6q1ZOVL5EFOFXEvUcg/rH37wbk+LAdesZLnCbXVqmp5y1IzARKCyDZrbINAvtZqAeUF2P1QQ/EnOxOPjRMIiKn0IqwtsuRzGs6IfwF+ZjfIM2QXtBV8E1mqAsBNtsTIWVViYw1goy/87BJX1g7itd2Nz3mCDSFtFMRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KBYsFMAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gr01JBeV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KBYsFMAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gr01JBeV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69E7B114026A
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 05:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687629; x=1727774029; bh=hsQ8jnMUZu
	W7rwYaT0StV6Kb9gNFFAzQ2lbG1n2g0fU=; b=KBYsFMAQYdH+/hSrK/2Gb40T0H
	sODhcA6w5+r/d/okUT4Vj/7inyNtI62qZn+B8NwPWQ9dkTaFAZaIpmE6CcstQAIN
	0w5XXBpC2ERFG68/GwB4zsqp0Xlsx+fikg4jzGW2jRu3J3eAETZDmt/bAoiyURZu
	9T4onAgMn5+1zC0OlIAv/rjY2RH7PXoI704HmpIC79kfiQ2LIN7OQLFmnejVpSQj
	dJ+88wFan82E1kdj7D3KbWVCHSRH5Cd375lYEkIcXI4C/cz/pf+CGBEOYOPJtjM+
	eolvqk6xzHh3egY/yEbtT1gnpN68v/EI4F0rlUVJ6YFTF8o20c1F/JHG9oYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687629; x=1727774029; bh=hsQ8jnMUZuW7rwYaT0StV6Kb9gNF
	FAzQ2lbG1n2g0fU=; b=Gr01JBeVe3uzcZVYuvm8GEoqwMplhWppYUswl8YF2U/5
	aQQQgo244nuOZPiwwaKoeHzctvZP7JK9NGumK4E/8AhcZ6J3f4YYPnvsVFzhvxBl
	bkjO0PtHhCKjCjG29dTBz80Ep6KGTsVD9Ucust6qGgtoUfwtwboWCMINF439gsxs
	f/WAzwlV4mBN0po6SfOQ+HQrFMSbjk+G+N/gimq+c+qkWXbQ55BtDQBVwdG1kfnz
	O2qdKd80d8YN/S68qW8UOeUKK0zrsT60DR6kWmXNAIWJ9ExWeuCOfOem9wUmB4VH
	5zCCF8DJgImpYiCiZqQVczaocYa7wRen2W+I3xAmHg==
X-ME-Sender: <xms:zWv6Zj49TnS_iBm3-kPfC10dgJZRS3mG_KtWiuQzGGyDXvr4vkzDAg>
    <xme:zWv6Zo7jc1HF5a9TLz0rxmEcR4eQs34LNGdCoVl2lhgpilVIK8_X1z8J-Efak35e-
    FWMdnp1RbRdkEL9vQ>
X-ME-Received: <xmr:zWv6ZqfPEa8m7r99S1aCAaOaewy1TpwazCN-Iuy7vIrfUzA2ILJKi_2Tz6RvHlaDxWtzIMI3gdgyDbWW_Xk_h3Wvv-ECxlodjAJLOKKajfMuWyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zWv6ZkLg_A_peH84vl4BuksS8X0NfmeKt_Zct-xtNzP3XdJzRfARgw>
    <xmx:zWv6ZnKMQjXyD4FGOxsVJXq5WNsro8NxsUN2eDPBSyYuV67jxoruog>
    <xmx:zWv6ZtzUgk3dlugRAT0o0uBHHWwgDOWXbM8SWCCz6mh4Gur_CEZ_lg>
    <xmx:zWv6ZjLbXwG8dnQOx-cKlZ418ZiRY9qQxo0g8jourX4Haq_4RQgajA>
    <xmx:zWv6ZtjxwqEtZnjS48jVeiCQ_Z0oU95FSV7OyYSXG3fA2999Fp8grzCO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a850a1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:13:02 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/23] diff: improve lifecycle management of diff queues
Message-ID: <a475d974cc1d060fdae26da31fea834c04b059c5.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

The lifecycle management of diff queues is somewhat confusing:

  - For most of the part this can be attributed to `DIFF_QUEUE_CLEAR()`,
    which does not release any memory but rather initializes the queue,
    only. This is in contrast to our common naming schema, where
    "clearing" means that we release underlying memory and then
    re-initialize the data structure such that it is ready to use.

  - A second offender is `diff_free_queue()`, which does not free the
    queue structure itself. It is rather a release-style function.

Refactor the code to make things less confusing. `DIFF_QUEUE_CLEAR()` is
replaced by `DIFF_QUEUE_INIT` and `diff_queue_init()`, while
`diff_free_queue()` is replaced by `diff_queue_release()`. While on it,
adapt callsites where we call `DIFF_QUEUE_CLEAR()` with the intent to
release underlying memory to instead call `diff_queue_clear()` to fix
memory leaks.

This memory leak is exposed by t4211, but plugging it alone does not
make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bloom.c            |  8 +-------
 diff.c             | 22 ++++++++++++----------
 diffcore-break.c   |  8 ++------
 diffcore-pickaxe.c |  4 +---
 diffcore-rename.c  |  3 +--
 diffcore-rotate.c  |  3 +--
 diffcore.h         | 10 ++++------
 line-log.c         | 15 +++++++--------
 log-tree.c         |  4 ++--
 merge-ort.c        |  2 +-
 10 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/bloom.c b/bloom.c
index c915f8b1ba..c428634105 100644
--- a/bloom.c
+++ b/bloom.c
@@ -476,8 +476,6 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 				*last_slash = '\0';
 
 			} while (*path);
-
-			diff_free_filepair(diff_queued_diff.queue[i]);
 		}
 
 		if (hashmap_get_size(&pathmap) > settings->max_changed_paths) {
@@ -508,8 +506,6 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	cleanup:
 		hashmap_clear_and_free(&pathmap, struct pathmap_hash_entry, entry);
 	} else {
-		for (i = 0; i < diff_queued_diff.nr; i++)
-			diff_free_filepair(diff_queued_diff.queue[i]);
 		init_truncated_large_filter(filter, settings->hash_version);
 
 		if (computed)
@@ -519,9 +515,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
 	if (computed)
 		*computed |= BLOOM_COMPUTED;
 
-	free(diff_queued_diff.queue);
-	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-
+	diff_queue_clear(&diff_queued_diff);
 	return filter;
 }
 
diff --git a/diff.c b/diff.c
index 173cbe2bed..3e9137ffed 100644
--- a/diff.c
+++ b/diff.c
@@ -5983,11 +5983,18 @@ void diff_free_filepair(struct diff_filepair *p)
 	free(p);
 }
 
-void diff_free_queue(struct diff_queue_struct *q)
+void diff_queue_init(struct diff_queue_struct *q)
+{
+	struct diff_queue_struct blank = DIFF_QUEUE_INIT;
+	memcpy(q, &blank, sizeof(*q));
+}
+
+void diff_queue_clear(struct diff_queue_struct *q)
 {
 	for (int i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
 	free(q->queue);
+	diff_queue_init(q);
 }
 
 const char *diff_aligned_abbrev(const struct object_id *oid, int len)
@@ -6551,8 +6558,7 @@ int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int result = diff_get_patch_id(options, oid, diff_header_only);
 
-	diff_free_queue(q);
-	DIFF_QUEUE_CLEAR(q);
+	diff_queue_clear(q);
 
 	return result;
 }
@@ -6835,8 +6841,7 @@ void diff_flush(struct diff_options *options)
 	}
 
 free_queue:
-	diff_free_queue(q);
-	DIFF_QUEUE_CLEAR(q);
+	diff_queue_clear(q);
 	diff_free(options);
 
 	/*
@@ -6867,9 +6872,7 @@ static void diffcore_apply_filter(struct diff_options *options)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
-
-	DIFF_QUEUE_CLEAR(&outq);
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
 
 	if (!options->filter)
 		return;
@@ -6962,8 +6965,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
-	DIFF_QUEUE_CLEAR(&outq);
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
diff --git a/diffcore-break.c b/diffcore-break.c
index 02735f80c6..c4c2173f30 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -131,7 +131,7 @@ static int should_break(struct repository *r,
 void diffcore_break(struct repository *r, int break_score)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
 
 	/* When the filepair has this much edit (insert and delete),
 	 * it is first considered to be a rewrite and broken into a
@@ -178,8 +178,6 @@ void diffcore_break(struct repository *r, int break_score)
 	if (!merge_score)
 		merge_score = DEFAULT_MERGE_SCORE;
 
-	DIFF_QUEUE_CLEAR(&outq);
-
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		int score;
@@ -275,11 +273,9 @@ static void merge_broken(struct diff_filepair *p,
 void diffcore_merge_broken(void)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
 	int i, j;
 
-	DIFF_QUEUE_CLEAR(&outq);
-
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (!p)
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index b195fa4eb3..43fef8e8ba 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -182,9 +182,7 @@ static void pickaxe(struct diff_queue_struct *q, struct diff_options *o,
 		    regex_t *regexp, kwset_t kws, pickaxe_fn fn)
 {
 	int i;
-	struct diff_queue_struct outq;
-
-	DIFF_QUEUE_CLEAR(&outq);
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
 
 	if (o->pickaxe_opts & DIFF_PICKAXE_ALL) {
 		/* Showing the whole changeset if needle exists */
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3d6826baa3..1b1c1a6a1f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -1388,7 +1388,7 @@ void diffcore_rename_extended(struct diff_options *options,
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
 	int num_destinations, dst_cnt;
@@ -1638,7 +1638,6 @@ void diffcore_rename_extended(struct diff_options *options,
 	 * are recorded in rename_dst.  The original list is still in *q.
 	 */
 	trace2_region_enter("diff", "write back to queue", options->repo);
-	DIFF_QUEUE_CLEAR(&outq);
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		struct diff_filepair *pair_to_free = NULL;
diff --git a/diffcore-rotate.c b/diffcore-rotate.c
index 533986cf63..73ca20b331 100644
--- a/diffcore-rotate.c
+++ b/diffcore-rotate.c
@@ -10,7 +10,7 @@
 void diffcore_rotate(struct diff_options *opt)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
 	int rotate_to, i;
 
 	if (!q->nr)
@@ -31,7 +31,6 @@ void diffcore_rotate(struct diff_options *opt)
 		return;
 	}
 
-	DIFF_QUEUE_CLEAR(&outq);
 	rotate_to = i;
 
 	for (i = rotate_to; i < q->nr; i++)
diff --git a/diffcore.h b/diffcore.h
index 1701ed50b9..2feb325031 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -153,18 +153,16 @@ struct diff_queue_struct {
 	int nr;
 };
 
-#define DIFF_QUEUE_CLEAR(q) \
-	do { \
-		(q)->queue = NULL; \
-		(q)->nr = (q)->alloc = 0; \
-	} while (0)
+#define DIFF_QUEUE_INIT { 0 }
+
+void diff_queue_init(struct diff_queue_struct *q);
+void diff_queue_clear(struct diff_queue_struct *q);
 
 extern struct diff_queue_struct diff_queued_diff;
 struct diff_filepair *diff_queue(struct diff_queue_struct *,
 				 struct diff_filespec *,
 				 struct diff_filespec *);
 void diff_q(struct diff_queue_struct *, struct diff_filepair *);
-void diff_free_queue(struct diff_queue_struct *q);
 
 /* dir_rename_relevance: the reason we want rename information for a dir */
 enum dir_rename_relevance {
diff --git a/line-log.c b/line-log.c
index 67c80b39a0..89e0ea4562 100644
--- a/line-log.c
+++ b/line-log.c
@@ -787,15 +787,14 @@ static void move_diff_queue(struct diff_queue_struct *dst,
 			    struct diff_queue_struct *src)
 {
 	assert(src != dst);
-	memcpy(dst, src, sizeof(struct diff_queue_struct));
-	DIFF_QUEUE_CLEAR(src);
+	memcpy(dst, src, sizeof(*dst));
+	diff_queue_init(src);
 }
 
 static void filter_diffs_for_paths(struct line_log_data *range, int keep_deletions)
 {
 	int i;
-	struct diff_queue_struct outq;
-	DIFF_QUEUE_CLEAR(&outq);
+	struct diff_queue_struct outq = DIFF_QUEUE_INIT;
 
 	for (i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *p = diff_queued_diff.queue[i];
@@ -850,12 +849,12 @@ static void queue_diffs(struct line_log_data *range,
 		clear_pathspec(&opt->pathspec);
 		parse_pathspec_from_ranges(&opt->pathspec, range);
 	}
-	DIFF_QUEUE_CLEAR(&diff_queued_diff);
+	diff_queue_clear(&diff_queued_diff);
 	diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
 	if (opt->detect_rename && diff_might_be_rename()) {
 		/* must look at the full tree diff to detect renames */
 		clear_pathspec(&opt->pathspec);
-		DIFF_QUEUE_CLEAR(&diff_queued_diff);
+		diff_queue_clear(&diff_queued_diff);
 
 		diff_tree_oid(parent_tree_oid, tree_oid, "", opt);
 
@@ -1097,7 +1096,7 @@ static struct diff_filepair *diff_filepair_dup(struct diff_filepair *pair)
 static void free_diffqueues(int n, struct diff_queue_struct *dq)
 {
 	for (int i = 0; i < n; i++)
-		diff_free_queue(&dq[i]);
+		diff_queue_clear(&dq[i]);
 	free(dq);
 }
 
@@ -1200,7 +1199,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	if (parent)
 		add_line_range(rev, parent, parent_range);
 	free_line_log_data(parent_range);
-	diff_free_queue(&queue);
+	diff_queue_clear(&queue);
 	return changed;
 }
 
diff --git a/log-tree.c b/log-tree.c
index 3758e0d3b8..60774c16b3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -675,7 +675,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 		struct diff_queue_struct dq;
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
-		DIFF_QUEUE_CLEAR(&diff_queued_diff);
+		diff_queue_init(&diff_queued_diff);
 
 		fprintf_ln(opt->diffopt.file, "\n%s", opt->idiff_title);
 		show_interdiff(opt->idiff_oid1, opt->idiff_oid2, 2,
@@ -694,7 +694,7 @@ static void show_diff_of_diff(struct rev_info *opt)
 		};
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
-		DIFF_QUEUE_CLEAR(&diff_queued_diff);
+		diff_queue_init(&diff_queued_diff);
 
 		fprintf_ln(opt->diffopt.file, "\n%s", opt->rdiff_title);
 		/*
diff --git a/merge-ort.c b/merge-ort.c
index 8b81153e8f..11029c10be 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3536,7 +3536,7 @@ static int detect_and_process_renames(struct merge_options *opt)
 	/* Free memory for renames->pairs[] and combined */
 	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
 		free(renames->pairs[s].queue);
-		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
+		diff_queue_init(&renames->pairs[s]);
 	}
 	for (i = 0; i < combined.nr; i++)
 		pool_diff_free_filepair(&opt->priv->pool, combined.queue[i]);
-- 
2.46.2.852.g229c0bf0e5.dirty

