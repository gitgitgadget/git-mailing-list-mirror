Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E21B78F7
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881514; cv=none; b=P6j+WbQ8UB/pg1rdivGTJ84mYWmmsvn142U/65Ea1V/NxGx13BSvXDlcTnCtLHCFdIbtABVfhBdywbKx8KM2end+j0qhhm32CdhNq//fZF3iGgOE4QB4+e9E9Dfqq9BDejmLox9vvjMuwSwfMnqSzWUJjM6dlLAnCamjLe2adaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881514; c=relaxed/simple;
	bh=R8uVUJEBgPis5LkVv4cbMBhnCJLpe99QRMnbyBc6HSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMfj7+TXjGlYKNMGwTK0L5gyjvpsvjaGdbJxOfYFC3/d0HGpKTOvQHW/a35YBTLriV5aXVklvgcIjHTO6Sc/f2IUWGbb0inx2/d3nN22XOWC+gBSl8ezVZM2zYPiUYidB6e7emSP7z6LvaNARaa89AFBgLql7jfWZcNIULtikOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K+c/Kdb1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hGKoCvUY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K+c/Kdb1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hGKoCvUY"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E0F11140293;
	Mon,  9 Sep 2024 07:31:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 09 Sep 2024 07:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725881511;
	 x=1725967911; bh=UcDzOTbkPS1zkkHDfNrTFEeAUih5aDbvxwHaI2sJXMM=; b=
	K+c/Kdb1hcUeVR71KpyBJj8O3A3+cNNtMJZNHW15WP4zLA1js4RJeS4PGTWHbHXU
	iCcgdNwDT5/xf2uGiESNVYxpBeUcIdJCXQ2jcJwolPIbNubxTezKVW2Nt+bwk5wC
	RsQ4NFQ0QVr5h026n5YYkqIuXawfyo9X9xWIsWrGbvFyLiaPSYJjTvaputjrmF07
	cKXnyFs0Pje5ESCaB4xSoIJIULEScjIUIAkbzNXA/sEpUt3L9uUfXrVrN75sZ4Cg
	gQS/wgv8RA+1KVeBhSKCboAyo8DA5PL9m3jHMhErG5SsCk94zXQqTmrHbu/NNZ/l
	rtctUtcCfycBrOnsBK3onA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725881511; x=
	1725967911; bh=UcDzOTbkPS1zkkHDfNrTFEeAUih5aDbvxwHaI2sJXMM=; b=h
	GKoCvUYBCQc9++YHujzcfxdcKEqoFN0QUctz/JAg64nm3qY5RYsk2aYfpJ99DMMX
	yzBnC8JU9QrtEzHVLOS8TKqzeYaRA4aLcBbvroIQEcddmBvF+BIErEVeu9etjj/T
	l+oSXKMNrUC2tBP+wOQ9IyPHnlt4dpD2COlAAGMmgrgwivp1J3QcD1zMUYuz6Dy+
	/IngwCsyjy2KM34OlNuVmOAAPosxViZSOLbiZqGufM4qd23JSmPQ67DWKX6FK8tL
	3YwIAGG5fFrBNxy/2kEhXcdcp2PWIqTeJvuDxsb2Z69o52ViILasvcWo3bgAwiwi
	ibDuzvLw/vxxN739dcPIg==
X-ME-Sender: <xms:p9zeZpnfFdKLFJHe-Wc6pAmCDn0VEu5SokwNRppINOvLMNyjTlqZaw>
    <xme:p9zeZk3GNTHCiHWncBFRD_Rtze7h6B1SCJ8eSr52h593AVJLP5Ayg2p66uj2E338h
    1obCFvXlLByzQaNNA>
X-ME-Received: <xmr:p9zeZvr0atBoxsgS_fLdNk1BMzHPHZK-0Rcp_1YYa2yHBKrP8CSV7jyn4FJbepbi5i0CQ5rV2g2LEW1hCWj2xcq8wXKkbnB5Fuot0fkiHM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitd
    etleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:p9zeZplW_rzH-fthmf5ZWH4uWIVBSK2GMNmDC8Zu5JwviYtsD-H9gA>
    <xmx:p9zeZn0ZaLlKywNX9WFftHh_V3izcbBll_x_8evXI8LcfqBgvJgEGw>
    <xmx:p9zeZovEW94OD2SJ4psWa1cz75zW7TsscImFPx0xxGSrEmq3DNLyWQ>
    <xmx:p9zeZrUiaUwjRCtCgUktMlHsJiYEc853XmpxQQJiEcdNm6Rkxce8Mw>
    <xmx:p9zeZlD5G50k0GYt0jykZVFK690I5NRW2QH-AIezJuxprXLjuj-S7vZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:31:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e2a6ad6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:31:48 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:31:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 6/6] refs/reftable: wire up support for exclude patterns
Message-ID: <f3922b81db69cd3bbdddcfbe02c99613448fd9ed.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1725881266.git.ps@pks.im>

Exclude patterns can be used by reference backends to skip over blocks
of references that are uninteresting to the caller. Reference backends
do not have to wire up support for them, and all callers are expected to
behave as if the backend didn't support them. In fact, the only backend
that supports exclude patterns right now is the "packed" backend.

Exclude patterns can be quite an important performance optimization in
repositories that have loads of references. The patterns are set up in
case "transfer.hideRefs" and friends are configured during a fetch, so
handling these patterns becomes important once there are lots of hidden
refs in a served repository.

Now that we have properly re-seekable reftable iterators we can also
wire up support for these patterns in the "reftable" backend. Doing so
is conceptually simple: once we hit a reference whose prefix matches the
current exclude pattern we re-seek the iterator to the first reference
that doesn't match the pattern anymore. This schema only works for
trivial patterns that do not have any globbing characters in them, but
this restriction also applies do the "packed" backend.

This makes t1419 work with the "reftable" backend with some slight
modifications. Of course it also speeds up listing of references with
hidden refs. The following benchmark prints one reference with 1 million
hidden references:

    Benchmark 1: HEAD~
      Time (mean ± σ):      93.3 ms ±   2.1 ms    [User: 90.3 ms, System: 2.5 ms]
      Range (min … max):    89.8 ms …  97.2 ms    33 runs

    Benchmark 2: HEAD
      Time (mean ± σ):       4.2 ms ±   0.6 ms    [User: 2.2 ms, System: 1.8 ms]
      Range (min … max):     3.1 ms …   8.1 ms    765 runs

    Summary
      HEAD ran
       22.15 ± 3.19 times faster than HEAD~

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 125 +++++++++++++++++++++++++++++++++++++++-
 t/t1419-exclude-refs.sh |  33 ++++++++---
 trace2.h                |   1 +
 trace2/tr2_ctr.c        |   5 ++
 4 files changed, 152 insertions(+), 12 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1c4b19e737f..5c241097a4e 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -21,6 +21,7 @@
 #include "../reftable/reftable-iterator.h"
 #include "../setup.h"
 #include "../strmap.h"
+#include "../trace2.h"
 #include "parse.h"
 #include "refs-internal.h"
 
@@ -447,10 +448,81 @@ struct reftable_ref_iterator {
 
 	const char *prefix;
 	size_t prefix_len;
+	char **exclude_patterns;
+	size_t exclude_patterns_index;
+	size_t exclude_patterns_strlen;
 	unsigned int flags;
 	int err;
 };
 
+/*
+ * Handle exclude patterns. Returns either `1`, which tells the caller that the
+ * current reference shall not be shown. Or `0`, which indicates that it should
+ * be shown.
+ */
+static int should_exclude_current_ref(struct reftable_ref_iterator *iter)
+{
+	while (iter->exclude_patterns[iter->exclude_patterns_index]) {
+		const char *pattern = iter->exclude_patterns[iter->exclude_patterns_index];
+		char *ref_after_pattern;
+		int cmp;
+
+		/*
+		 * Lazily cache the pattern length so that we don't have to
+		 * recompute it every time this function is called.
+		 */
+		if (!iter->exclude_patterns_strlen)
+			iter->exclude_patterns_strlen = strlen(pattern);
+
+		/*
+		 * When the reference name is lexicographically bigger than the
+		 * current exclude pattern we know that it won't ever match any
+		 * of the following references, either. We thus advance to the
+		 * next pattern and re-check whether it matches.
+		 *
+		 * Otherwise, if it's smaller, then we do not have a match and
+		 * thus want to show the current reference.
+		 */
+		cmp = strncmp(iter->ref.refname, pattern,
+			      iter->exclude_patterns_strlen);
+		if (cmp > 0) {
+			iter->exclude_patterns_index++;
+			iter->exclude_patterns_strlen = 0;
+			continue;
+		}
+		if (cmp < 0)
+			return 0;
+
+		/*
+		 * The reference shares a prefix with the exclude pattern and
+		 * shall thus be omitted. We skip all references that match the
+		 * pattern by seeking to the first reference after the block of
+		 * matches.
+		 *
+		 * This is done by appending the highest possible character to
+		 * the pattern. Consequently, all references that have the
+		 * pattern as prefix and whose suffix starts with anything in
+		 * the range [0x00, 0xfe] are skipped. And given that 0xff is a
+		 * non-printable character that shouldn't ever be in a ref name,
+		 * we'd not yield any such record, either.
+		 *
+		 * Note that the seeked-to reference may also be excluded. This
+		 * is not handled here though, but the caller is expected to
+		 * loop and re-verify the next reference for us.
+		 */
+		ref_after_pattern = xstrfmt("%s%c", pattern, 0xff);
+		iter->err = reftable_iterator_seek_ref(&iter->iter, ref_after_pattern);
+		iter->exclude_patterns_index++;
+		iter->exclude_patterns_strlen = 0;
+		trace2_counter_add(TRACE2_COUNTER_ID_REFTABLE_RESEEKS, 1);
+
+		free(ref_after_pattern);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 {
 	struct reftable_ref_iterator *iter =
@@ -481,6 +553,9 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			break;
 		}
 
+		if (iter->exclude_patterns && should_exclude_current_ref(iter))
+			continue;
+
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
 		    parse_worktree_ref(iter->ref.refname, NULL, NULL, NULL) !=
 			    REF_WORKTREE_CURRENT)
@@ -570,6 +645,11 @@ static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
 		(struct reftable_ref_iterator *)ref_iterator;
 	reftable_ref_record_release(&iter->ref);
 	reftable_iterator_destroy(&iter->iter);
+	if (iter->exclude_patterns) {
+		for (size_t i = 0; iter->exclude_patterns[i]; i++)
+			free(iter->exclude_patterns[i]);
+		free(iter->exclude_patterns);
+	}
 	free(iter);
 	return ITER_DONE;
 }
@@ -580,9 +660,45 @@ static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.abort = reftable_ref_iterator_abort
 };
 
+static char **filter_exclude_patterns(const char **exclude_patterns)
+{
+	size_t filtered_size = 0, filtered_alloc = 0;
+	char **filtered = NULL;
+
+	if (!exclude_patterns)
+		return NULL;
+
+	for (size_t i = 0; ; i++) {
+		const char *exclude_pattern = exclude_patterns[i];
+		int has_glob = 0;
+
+		if (!exclude_pattern)
+			break;
+
+		for (const char *p = exclude_pattern; *p; p++) {
+			has_glob = is_glob_special(*p);
+			if (has_glob)
+				break;
+		}
+		if (has_glob)
+			continue;
+
+		ALLOC_GROW(filtered, filtered_size + 1, filtered_alloc);
+		filtered[filtered_size++] = xstrdup(exclude_pattern);
+	}
+
+	if (filtered_size) {
+		ALLOC_GROW(filtered, filtered_size + 1, filtered_alloc);
+		filtered[filtered_size++] = NULL;
+	}
+
+	return filtered;
+}
+
 static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_store *refs,
 							    struct reftable_stack *stack,
 							    const char *prefix,
+							    const char **exclude_patterns,
 							    int flags)
 {
 	struct reftable_ref_iterator *iter;
@@ -595,6 +711,7 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 	iter->base.oid = &iter->oid;
 	iter->flags = flags;
 	iter->refs = refs;
+	iter->exclude_patterns = filter_exclude_patterns(exclude_patterns);
 
 	ret = refs->err;
 	if (ret)
@@ -616,7 +733,7 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 
 static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_store,
 						       const char *prefix,
-						       const char **exclude_patterns UNUSED,
+						       const char **exclude_patterns,
 						       unsigned int flags)
 {
 	struct reftable_ref_iterator *main_iter, *worktree_iter;
@@ -627,7 +744,8 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
 		required_flags |= REF_STORE_ODB;
 	refs = reftable_be_downcast(ref_store, required_flags, "ref_iterator_begin");
 
-	main_iter = ref_iterator_for_stack(refs, refs->main_stack, prefix, flags);
+	main_iter = ref_iterator_for_stack(refs, refs->main_stack, prefix,
+					   exclude_patterns, flags);
 
 	/*
 	 * The worktree stack is only set when we're in an actual worktree
@@ -641,7 +759,8 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
 	 * Otherwise we merge both the common and the per-worktree refs into a
 	 * single iterator.
 	 */
-	worktree_iter = ref_iterator_for_stack(refs, refs->worktree_stack, prefix, flags);
+	worktree_iter = ref_iterator_for_stack(refs, refs->worktree_stack, prefix,
+					       exclude_patterns, flags);
 	return merge_ref_iterator_begin(&worktree_iter->base, &main_iter->base,
 					ref_iterator_select, NULL);
 }
diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 13595744190..8c7b69a9b34 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -8,12 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
-if test_have_prereq !REFFILES
-then
-	skip_all='skipping `git for-each-ref --exclude` tests; need files backend'
-	test_done
-fi
-
 for_each_ref__exclude () {
 	GIT_TRACE2_PERF=1 test-tool ref-store main \
 		for-each-ref--exclude "$@" >actual.raw
@@ -28,7 +22,14 @@ assert_jumps () {
 	local nr="$1"
 	local trace="$2"
 
-	grep -q "name:jumps_made value:$nr$" $trace
+	case "$GIT_DEFAULT_REF_FORMAT" in
+	files)
+		grep -q "name:jumps_made value:$nr$" $trace;;
+	reftable)
+		grep -q "name:reseeks_made value:$nr$" $trace;;
+	*)
+		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+	esac
 }
 
 assert_no_jumps () {
@@ -89,7 +90,14 @@ test_expect_success 'adjacent, non-overlapping excluded regions' '
 	for_each_ref refs/heads/foo refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
-	assert_jumps 1 perf
+	case "$GIT_DEFAULT_REF_FORMAT" in
+	files)
+		assert_jumps 1 perf;;
+	reftable)
+		assert_jumps 2 perf;;
+	*)
+		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+	esac
 '
 
 test_expect_success 'overlapping excluded regions' '
@@ -106,7 +114,14 @@ test_expect_success 'several overlapping excluded regions' '
 	for_each_ref refs/heads/quux >expect &&
 
 	test_cmp expect actual &&
-	assert_jumps 1 perf
+	case "$GIT_DEFAULT_REF_FORMAT" in
+	files)
+		assert_jumps 1 perf;;
+	reftable)
+		assert_jumps 3 perf;;
+	*)
+		BUG "unhandled ref format $GIT_DEFAULT_REF_FORMAT";;
+	esac
 '
 
 test_expect_success 'non-matching excluded section' '
diff --git a/trace2.h b/trace2.h
index 19e04bf040f..901f39253a6 100644
--- a/trace2.h
+++ b/trace2.h
@@ -554,6 +554,7 @@ enum trace2_counter_id {
 	TRACE2_COUNTER_ID_TEST2,     /* emits summary and thread events */
 
 	TRACE2_COUNTER_ID_PACKED_REFS_JUMPS, /* counts number of jumps */
+	TRACE2_COUNTER_ID_REFTABLE_RESEEKS, /* counts number of re-seeks */
 
 	/* counts number of fsyncs */
 	TRACE2_COUNTER_ID_FSYNC_WRITEOUT_ONLY,
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index d3a33715c14..036b643578b 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -31,6 +31,11 @@ static struct tr2_counter_metadata tr2_counter_metadata[TRACE2_NUMBER_OF_COUNTER
 		.name = "jumps_made",
 		.want_per_thread_events = 0,
 	},
+	[TRACE2_COUNTER_ID_REFTABLE_RESEEKS] = {
+		.category = "reftable",
+		.name = "reseeks_made",
+		.want_per_thread_events = 0,
+	},
 	[TRACE2_COUNTER_ID_FSYNC_WRITEOUT_ONLY] = {
 		.category = "fsync",
 		.name = "writeout-only",
-- 
2.46.0.519.g2e7b89e038.dirty

