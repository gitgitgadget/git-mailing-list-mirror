Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06E3644BA
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847996; cv=none; b=s1+3bxVY4ZbU5+odD84G/j4VweIHa1BuBtfH8f4nmVHdkKYe1AX2286eCUXeLyNGR2XroOvUNjLu1dMIdlrKIFy5/EPbhJeuyugNNoLGjk5+vVzNtAtGs7Qu9b/JKlknu13JPlYuuUDG7V8a9snRadZn7ZhZKCT55iL7TFI9Esg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847996; c=relaxed/simple;
	bh=oj6pdNvgNxggfN3ptMQKhp6JFtgF92jl/m+/z9FzI80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcLf0cM5nEGv6hT2csTGkLx2/9RDQ9luUGK8shxh6RisVqRBLT6dh6wlRDT+9lm7HwKtSXsuTckfSJZ54c3LcdCFk9zt3i5Fjwdi5Ad31SYnFjHOgZSMMMQxbxiLs49syLxmUGSmDZpXGYLhRBLT4XBz2i7EsETI3oMpxbyX4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LoyWBdcw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A7onkKfm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LoyWBdcw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A7onkKfm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 592AEEC05BE;
	Mon, 23 Feb 2026 06:59:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 23 Feb 2026 06:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771847992;
	 x=1771934392; bh=z8XYynN/4YLGKWwEhmmyBsddZIsSMTRO/5Yc9eH8myo=; b=
	LoyWBdcwMNsCG9Xmx9eeIIeqHCILHvUSRclkgZwn82ppUakPTocUgu2Mo1u7VjJ3
	HfLtU1O+30unptdzD5wXOn6CZBUCSffbYKenHZyNENJ9eTpxi4fq5Z34BRFW8S/t
	O7Ojz/LGTx6Bdi/pTxlFDujVPHQ6XfwvmE/KBOeK9dF1XK32fRGTyNxcfW+SCyZq
	NaeoScKV5HDDvbQRbxs7p/Dv5fraMfEod9dE/Upc1cK4WSRYwXDaAVOJSPP4XZ15
	uYhbyy5+Is1lOmpEhpDcZcbyCMpZyTwiQG1qaRLxnC2VP8DaQ6iu5hjSXp9SmZT9
	dHRNmywmMegyjqTyvzsReg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771847992; x=
	1771934392; bh=z8XYynN/4YLGKWwEhmmyBsddZIsSMTRO/5Yc9eH8myo=; b=A
	7onkKfmk7cAAC1VtKKLIU7iMyNtrsGxb970VkHgPX8Tx3C9rjTMXqaCGVCrE4ee/
	EeFxUurKxaddWHcs+HlrsWgOoluFq4/lD1C0EUxLJU4puDIcafA6dMbFy8xh8pk1
	nBT6hyxNeTz7w3Blf8NOh0FC7FIBmbSKQ75+qzIOQT9hvVFYNFi60Ite65FjWWrn
	vJAKUCnWF6B72hjCB5PM1r24UJHU/d+uTOfs+vnYLgOdIy7ETgfSyOZ79SqYuLZP
	Whkdf1GhtemalvoxtbcplrvRQHcY2hteoYFiU+S3U4Pe5qgnWMZq2U85cedeNg6d
	2FnJKMh8tjG7Fof8akQ0A==
X-ME-Sender: <xms:OEGcafydid7raQBty8PqjFssX1naxP8O_Opim840je5yTSI9HFrQ3A>
    <xme:OEGcaeujqkL4Y9JROEnovqYCR_G5D59LcX5XMpMTSmcQCpElS-5omhp94Cu01WjZN
    81DJYjOxfHJxrZg-7nSdGOnY4Sk-Z-iRIxKgfahcg3br-w1g2Iv>
X-ME-Received: <xmr:OEGcaWv1Ds3et7l-qJ59p7IwSdNnvpEMOmUzHRXqsfRJ0ag3JgcjRWRDBil6_E0TcC_HVlgn1UrRcNwM5rappTuhq4e3wjHMYhMF5UpKIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeuvdekgfefgfdvgeekteelkeehueevgffflefgfeejheeggfeigffgudefffdukeen
    ucffohhmrghinheprhgvfhdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidr
    uggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:OEGcaTMkS7G-dotHYc68Eje1gga8w0X2HQUvZxlDfFJVC6r1dXXvTg>
    <xmx:OEGcaU236QJ04zGBZZWeJLKrECiGvZxekdFggryrmbMDvy_nZSNF2g>
    <xmx:OEGcafO6vwMGtwLa6OvTzqPPyAgwRISUw92nmSu46uhmPv8lrRT9GA>
    <xmx:OEGcaU31b1qj4jND6-D8P2SMmFvSGPn2xJQHmrSKD6PrgsXbQGQCOQ>
    <xmx:OEGcaXNDZxW7OOfWJN7wEI1XQM8zCQAuZgppsQNhwocg9WHDOq4H-1L->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 06:59:51 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58bcf298 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 11:59:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:38 +0100
Subject: [PATCH v2 04/17] refs: rename `do_for_each_ref_flags`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-4-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

The enum `do_for_each_ref_flags` and its individual values don't match
to our current best practices when it comes to naming things. Rename it
to `refs_for_each_flag`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ref-filter.c            |  2 +-
 refs.c                  | 18 +++++++++---------
 refs.h                  | 12 ++++++------
 refs/files-backend.c    | 12 ++++++------
 refs/packed-backend.c   |  8 ++++----
 refs/reftable-backend.c | 10 +++++-----
 6 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3917c4ccd9..4bc54ebd9d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2810,7 +2810,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 	if (filter->kind & FILTER_REFS_ROOT_REFS) {
 		/* In this case, we want to print all refs including root refs. */
 		return for_each_fullref_with_seek(filter, cb, cb_data,
-						  DO_FOR_EACH_INCLUDE_ROOT_REFS);
+						  REFS_FOR_EACH_INCLUDE_ROOT_REFS);
 	}
 
 	if (!filter->match_as_path) {
diff --git a/refs.c b/refs.c
index 466398494f..52a680797a 100644
--- a/refs.c
+++ b/refs.c
@@ -1812,7 +1812,7 @@ struct ref_iterator *refs_ref_iterator_begin(
 		const char *prefix,
 		const char **exclude_patterns,
 		int trim,
-		enum do_for_each_ref_flags flags)
+		enum refs_for_each_flag flags)
 {
 	struct ref_iterator *iter;
 	struct strvec normalized_exclude_patterns = STRVEC_INIT;
@@ -1834,14 +1834,14 @@ struct ref_iterator *refs_ref_iterator_begin(
 		exclude_patterns = normalized_exclude_patterns.v;
 	}
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
+	if (!(flags & REFS_FOR_EACH_INCLUDE_BROKEN)) {
 		static int ref_paranoia = -1;
 
 		if (ref_paranoia < 0)
 			ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 1);
 		if (ref_paranoia) {
-			flags |= DO_FOR_EACH_INCLUDE_BROKEN;
-			flags |= DO_FOR_EACH_OMIT_DANGLING_SYMREFS;
+			flags |= REFS_FOR_EACH_INCLUDE_BROKEN;
+			flags |= REFS_FOR_EACH_OMIT_DANGLING_SYMREFS;
 		}
 	}
 
@@ -1861,7 +1861,7 @@ struct ref_iterator *refs_ref_iterator_begin(
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   const char **exclude_patterns,
 			   each_ref_fn fn, int trim,
-			   enum do_for_each_ref_flags flags, void *cb_data)
+			   enum refs_for_each_flag flags, void *cb_data)
 {
 	struct ref_iterator *iter;
 
@@ -1897,7 +1897,7 @@ int refs_for_each_replace_ref(struct ref_store *refs, each_ref_fn fn, void *cb_d
 	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
 	return do_for_each_ref(refs, git_replace_ref_base, NULL, fn,
 			       strlen(git_replace_ref_base),
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
 int refs_for_each_namespaced_ref(struct ref_store *refs,
@@ -1929,7 +1929,7 @@ int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
 			    each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(refs, prefix, NULL, fn, 0,
-			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
+			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
 static int qsort_strcmp(const void *va, const void *vb)
@@ -2741,7 +2741,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
 			if (!iter)
 				iter = refs_ref_iterator_begin(refs, dirname.buf, NULL, 0,
-							       DO_FOR_EACH_INCLUDE_BROKEN);
+							       REFS_FOR_EACH_INCLUDE_BROKEN);
 			else if (ref_iterator_seek(iter, dirname.buf,
 						   REF_ITERATOR_SEEK_SET_PREFIX) < 0)
 				goto cleanup;
@@ -3281,7 +3281,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
 	 * ensure that there are no concurrent writes.
 	 */
 	ret = do_for_each_ref(old_refs, "", NULL, migrate_one_ref, 0,
-			      DO_FOR_EACH_INCLUDE_ROOT_REFS | DO_FOR_EACH_INCLUDE_BROKEN,
+			      REFS_FOR_EACH_INCLUDE_ROOT_REFS | REFS_FOR_EACH_INCLUDE_BROKEN,
 			      &data);
 	if (ret < 0)
 		goto done;
diff --git a/refs.h b/refs.h
index 6fd7a706b5..2ae4a6e75b 100644
--- a/refs.h
+++ b/refs.h
@@ -406,7 +406,7 @@ typedef int each_ref_fn(const struct reference *ref, void *cb_data);
  * These flags are passed to refs_ref_iterator_begin() (and do_for_each_ref(),
  * which feeds it).
  */
-enum do_for_each_ref_flags {
+enum refs_for_each_flag {
 	/*
 	 * Include broken references in a do_for_each_ref*() iteration, which
 	 * would normally be omitted. This includes both refs that point to
@@ -416,7 +416,7 @@ enum do_for_each_ref_flags {
 	 * ref; this is not a corruption, but as they have no valid oid, we
 	 * omit them from normal iteration results).
 	 */
-	DO_FOR_EACH_INCLUDE_BROKEN = (1 << 0),
+	REFS_FOR_EACH_INCLUDE_BROKEN = (1 << 0),
 
 	/*
 	 * Only include per-worktree refs in a do_for_each_ref*() iteration.
@@ -424,19 +424,19 @@ enum do_for_each_ref_flags {
 	 * where all reference backends will presumably store their
 	 * per-worktree refs.
 	 */
-	DO_FOR_EACH_PER_WORKTREE_ONLY = (1 << 1),
+	REFS_FOR_EACH_PER_WORKTREE_ONLY = (1 << 1),
 
 	/*
 	 * Omit dangling symrefs from output; this only has an effect with
 	 * INCLUDE_BROKEN, since they are otherwise not included at all.
 	 */
-	DO_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
+	REFS_FOR_EACH_OMIT_DANGLING_SYMREFS = (1 << 2),
 
 	/*
 	 * Include root refs i.e. HEAD and pseudorefs along with the regular
 	 * refs.
 	 */
-	DO_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
+	REFS_FOR_EACH_INCLUDE_ROOT_REFS = (1 << 3),
 };
 
 /*
@@ -1372,7 +1372,7 @@ struct ref_iterator;
 struct ref_iterator *refs_ref_iterator_begin(
 	struct ref_store *refs,
 	const char *prefix, const char **exclude_patterns,
-	int trim, enum do_for_each_ref_flags flags);
+	int trim, enum refs_for_each_flag flags);
 
 /*
  * Advance the iterator to the first or next item and return ITER_OK.
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b1b13b41f6..6c98e14414 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -439,7 +439,7 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
 
 		dir = get_ref_dir(refs->loose->root);
 
-		if (flags & DO_FOR_EACH_INCLUDE_ROOT_REFS)
+		if (flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS)
 			add_root_refs(refs, dir);
 
 		/*
@@ -955,17 +955,17 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
-		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		if (iter->flags & REFS_FOR_EACH_PER_WORKTREE_ONLY &&
 		    parse_worktree_ref(iter->iter0->ref.name, NULL, NULL,
 				       NULL) != REF_WORKTREE_CURRENT)
 			continue;
 
-		if ((iter->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS) &&
+		if ((iter->flags & REFS_FOR_EACH_OMIT_DANGLING_SYMREFS) &&
 		    (iter->iter0->ref.flags & REF_ISSYMREF) &&
 		    (iter->iter0->ref.flags & REF_ISBROKEN))
 			continue;
 
-		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		if (!(iter->flags & REFS_FOR_EACH_INCLUDE_BROKEN) &&
 		    !ref_resolves_to_object(iter->iter0->ref.name,
 					    iter->repo,
 					    iter->iter0->ref.oid,
@@ -1012,7 +1012,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
+	if (!(flags & REFS_FOR_EACH_INCLUDE_BROKEN))
 		required_flags |= REF_STORE_ODB;
 
 	refs = files_downcast(ref_store, required_flags, "ref_iterator_begin");
@@ -1050,7 +1050,7 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 */
 	packed_iter = refs_ref_iterator_begin(
 			refs->packed_ref_store, prefix, exclude_patterns, 0,
-			DO_FOR_EACH_INCLUDE_BROKEN);
+			REFS_FOR_EACH_INCLUDE_BROKEN);
 
 	overlay_iter = overlay_ref_iterator_begin(loose_iter, packed_iter);
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 59b3ecb9d6..5ef4ae32b8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -982,11 +982,11 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		const char *refname = iter->base.ref.name;
 		const char *prefix = iter->prefix;
 
-		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		if (iter->flags & REFS_FOR_EACH_PER_WORKTREE_ONLY &&
 		    !is_per_worktree_ref(iter->base.ref.name))
 			continue;
 
-		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		if (!(iter->flags & REFS_FOR_EACH_INCLUDE_BROKEN) &&
 		    !ref_resolves_to_object(iter->base.ref.name, iter->repo,
 					    &iter->oid, iter->flags))
 			continue;
@@ -1159,7 +1159,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
+	if (!(flags & REFS_FOR_EACH_INCLUDE_BROKEN))
 		required_flags |= REF_STORE_ODB;
 	refs = packed_downcast(ref_store, required_flags, "ref_iterator_begin");
 
@@ -1401,7 +1401,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 	 * of updates is exhausted, leave i set to updates->nr.
 	 */
 	iter = packed_ref_iterator_begin(&refs->base, "", NULL,
-					 DO_FOR_EACH_INCLUDE_BROKEN);
+					 REFS_FOR_EACH_INCLUDE_BROKEN);
 	if ((ok = ref_iterator_advance(iter)) != ITER_OK) {
 		ref_iterator_free(iter);
 		iter = NULL;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 5611808ad7..34bc074dd3 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -662,7 +662,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		 * the root refs are to be included. We emulate the same behaviour here.
 		 */
 		if (!starts_with(iter->ref.refname, "refs/") &&
-		    !(iter->flags & DO_FOR_EACH_INCLUDE_ROOT_REFS &&
+		    !(iter->flags & REFS_FOR_EACH_INCLUDE_ROOT_REFS &&
 		      is_root_ref(iter->ref.refname))) {
 			continue;
 		}
@@ -676,7 +676,7 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		if (iter->exclude_patterns && should_exclude_current_ref(iter))
 			continue;
 
-		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		if (iter->flags & REFS_FOR_EACH_PER_WORKTREE_ONLY &&
 		    parse_worktree_ref(iter->ref.refname, NULL, NULL, NULL) !=
 			    REF_WORKTREE_CURRENT)
 			continue;
@@ -714,12 +714,12 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			flags |= REF_BAD_NAME | REF_ISBROKEN;
 		}
 
-		if (iter->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS &&
+		if (iter->flags & REFS_FOR_EACH_OMIT_DANGLING_SYMREFS &&
 		    flags & REF_ISSYMREF &&
 		    flags & REF_ISBROKEN)
 			continue;
 
-		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		if (!(iter->flags & REFS_FOR_EACH_INCLUDE_BROKEN) &&
 		    !ref_resolves_to_object(iter->ref.refname, refs->base.repo,
 					    &iter->oid, flags))
 				continue;
@@ -871,7 +871,7 @@ static struct ref_iterator *reftable_be_iterator_begin(struct ref_store *ref_sto
 	struct reftable_ref_store *refs;
 	unsigned int required_flags = REF_STORE_READ;
 
-	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
+	if (!(flags & REFS_FOR_EACH_INCLUDE_BROKEN))
 		required_flags |= REF_STORE_ODB;
 	refs = reftable_be_downcast(ref_store, required_flags, "ref_iterator_begin");
 

-- 
2.53.0.536.g309c995771.dirty

