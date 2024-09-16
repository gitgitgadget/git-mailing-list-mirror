Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46C613C8E8
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476623; cv=none; b=GV5KYjx71+073kPKz+G+V00dajWFz0M7GrzU+LAaoRP/kl87ckQZhEUppotD2ywgkPV0PqXdhiAP9Znq9QPDGIHGb/SuCipY0uGAhiHD+JXZmwa/b2exjcUdJQwaSrQYMZ/HHgZ8vlGsx3AE+N0e8/717t/VD8ZbJ05dNYGiWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476623; c=relaxed/simple;
	bh=HNmXl+nnNXB3O1RJ8GIufcGEYcfbH+jBmf35/7EhlvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reY9UP0jmVE5dh0e7uIQUHeJoZvGuvivv8iMrUk1f0p4CwQohfFvfh3prZ0MxAvsfOTKsHMsvz4VEyTX9sD9vwkB/Iw+aZ7GZCKq4sWxt+AKiLBje2GlnR0/c8S85HvBF8+un5K+pmN+lMS06qhyOXuomd9ZxUuNFNn8o0b1nBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A/tEqmtK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JN6XKEm1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A/tEqmtK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JN6XKEm1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94C841140237;
	Mon, 16 Sep 2024 04:50:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Sep 2024 04:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726476620;
	 x=1726563020; bh=pIa0kYtR1IEJEvwkgkEY3ZRozLOJcNUXqcwp8Ol/yUw=; b=
	A/tEqmtK5wwxTZ4dUk1fogLBExCHu8LBaA8FYUbcHulyDfBinIWXo1CCEG0VqBj/
	d66vufmG+YQs8x15v3i0tHTthr11S+rFV5B8j/f7tMphKJJrZ9DyIebWgCjDYAmk
	W//gB9+2R82iPiEB3HT0qFHsrfG7Eec+u+D5oNnDRDhNEEH7bovXvxxykcMAwoab
	Yc8jZdwSRd0aZCT7Kkazc91suO/vj50j0wL3lxLQ0tqgeyw3x9NksA8NHr7lEVTD
	VVpLa2NT+VWDMkvY8nD0G+VWE+mMuHWsh9Ceo3sGfM9IRb7YMguMPQs2HQW7tpkB
	+JBuxvjCXr8RW/KNKPjayA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726476620; x=
	1726563020; bh=pIa0kYtR1IEJEvwkgkEY3ZRozLOJcNUXqcwp8Ol/yUw=; b=J
	N6XKEm1uWNMJcnJZyvNY9tq064U9O9z2w39TokudcGqncuCswvuNjwpBWYbw5XNq
	mB/2l315bW8pUwiZeNk40YPFwzkDEiMgnj3f7lNmxXaCIXmDE1dQXU0wRBFuiq4z
	KkbCd+g4q/Oks9F6QoU1ttVz7vJOKyxdLBUFQSzyRZrSzXzIFVSdx1CqFXuBXPpd
	UwVaIQ/R5vrgF7aFiEVCO4HrR4N3rPBxzkVMn3Rn2Ti6aBgN70hI0R/9YGkNCcBt
	F34wrDWBsMwPo3wrV47Ny4Q7Z+lFv0aAO3yl0iGwWTLN0nnO65FdeZkdh8bwxuh7
	pXdVRAjBIHj53C54So7Qg==
X-ME-Sender: <xms:TPHnZj5x9zO_Iuaq0zg0qXl4drsyrJL8oB7YQgUEPpnb3ZpzaJsYGg>
    <xme:TPHnZo4HN-EM_SjT4RLl04zs46HMlPTG0RfR5xJFDKS8vebIaCSiPtEyTxQVgiaKX
    ElvMelvMWH37c83Aw>
X-ME-Received: <xmr:TPHnZqcjgGcwBvyxO8z60u9Dc2igQjh8DxKW4Dko2nfiQbxh54hHxbcnXq1MlmrFu0d2jid9iMGyXRTDrKFgVRgDLwWxjzXAcZG7n8uZt3VNyblS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TPHnZkKkbibpRaWbBwY2XRcfnUPqATI8TTQ1SDKR893wycqhOmedRw>
    <xmx:TPHnZnIAy6kJBHBccMArUVPxP5M3Bth4gI7lGYLAD-u6yUP8bIlI0g>
    <xmx:TPHnZtw41HNE7cp5Ztf4T6-ImD1n1KBHTTMcFxvZywgSepQ-9Y4x-A>
    <xmx:TPHnZjJv36GP8UgmpBes-DpBoa2kRU4Qq2h5e-_zimveD1XxWJtc1A>
    <xmx:TPHnZv1dIH-WZELey0U0PsfIvW9E2FJpxqls6Avgx9ojfa8R3poZfJe_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 04:50:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 306eaca5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 08:50:02 +0000 (UTC)
Date: Mon, 16 Sep 2024 10:50:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 6/6] refs/reftable: wire up support for exclude patterns
Message-ID: <050f4906393d1f9c58a6b6bc695b004695d219be.1726476401.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1726476401.git.ps@pks.im>

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
 refs/reftable-backend.c | 133 +++++++++++++++++++++++++++++++++++++++-
 t/t1419-exclude-refs.sh |  49 ++++++++++++---
 trace2.h                |   1 +
 trace2/tr2_ctr.c        |   5 ++
 4 files changed, 176 insertions(+), 12 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1c4b19e737f..3e63833ce41 100644
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
@@ -580,9 +660,53 @@ static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.abort = reftable_ref_iterator_abort
 };
 
+static int qsort_strcmp(const void *va, const void *vb)
+{
+	const char *a = *(const char **)va;
+	const char *b = *(const char **)vb;
+	return strcmp(a, b);
+}
+
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
+		QSORT(filtered, filtered_size, qsort_strcmp);
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
@@ -595,6 +719,7 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 	iter->base.oid = &iter->oid;
 	iter->flags = flags;
 	iter->refs = refs;
+	iter->exclude_patterns = filter_exclude_patterns(exclude_patterns);
 
 	ret = refs->err;
 	if (ret)
@@ -616,7 +741,7 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 
 static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_store,
 						       const char *prefix,
-						       const char **exclude_patterns UNUSED,
+						       const char **exclude_patterns,
 						       unsigned int flags)
 {
 	struct reftable_ref_iterator *main_iter, *worktree_iter;
@@ -627,7 +752,8 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
 		required_flags |= REF_STORE_ODB;
 	refs = reftable_be_downcast(ref_store, required_flags, "ref_iterator_begin");
 
-	main_iter = ref_iterator_for_stack(refs, refs->main_stack, prefix, flags);
+	main_iter = ref_iterator_for_stack(refs, refs->main_stack, prefix,
+					   exclude_patterns, flags);
 
 	/*
 	 * The worktree stack is only set when we're in an actual worktree
@@ -641,7 +767,8 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
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
index 13595744190..3256e4462f9 100755
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
@@ -106,7 +114,30 @@ test_expect_success 'several overlapping excluded regions' '
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
+'
+
+test_expect_success 'unordered excludes' '
+	for_each_ref__exclude refs/heads \
+		refs/heads/foo refs/heads/baz >actual 2>perf &&
+	for_each_ref refs/heads/bar refs/heads/quux >expect &&
+
+	test_cmp expect actual &&
+	case "$GIT_DEFAULT_REF_FORMAT" in
+	files)
+		assert_jumps 1 perf;;
+	reftable)
+		assert_jumps 2 perf;;
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
2.46.0.551.gc5ee8f2d1c.dirty

