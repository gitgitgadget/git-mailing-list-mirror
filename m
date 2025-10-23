Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ABE23D7DA
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203786; cv=none; b=JL1BmEUxcrmJlOr86J8Lhy/gSDzmhktMaHEGtUgCpJMqn84LPryMtEgAvSiezJpEIRmJQCPdx5owUSWKl9WT/Ntc9l8dlDgbPuv/WaaPUHULA3VyP4DqHTJ3cGpVFqjbIAzxeodchsSGn/Yt/UHvaPxDGLGnuHxEzJsk63R23Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203786; c=relaxed/simple;
	bh=IOFiP4E/v0mzcocBkZnLyN3swV9rcdWXWchlpCV4w5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVe0svfk8Hdq7vcUnFxcbFWmXVVsyKqEI9RO0EbPmeCCB6xoa2mXrk9vsYPGWRrrEZjqO41UxfWUBUHwpm8addMwaTZBXCtMxXUubitVHPkt5/pYLMLB+6nQVPAP1mt6VHXoCs/9HDL1oHPNL5LkJux+2mcbdsf9FJjYvPyl68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fXvCvvaL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pabkswze; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fXvCvvaL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pabkswze"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A4C2EC022C;
	Thu, 23 Oct 2025 03:16:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 23 Oct 2025 03:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203783;
	 x=1761290183; bh=L93SH8wa5avtwCfao/TdD40mBjzxH41YbEJ6NG1Uk5g=; b=
	fXvCvvaLf8cRaJpc8xBozR23oeH1Rka4rQirkc9OPkGEo8sFLWQzr6/DQBxvVWTh
	x/hp+u3O4x9IVhKQZFaiZ7vTYuk4rGM5KGGlSTt7ZD1cJfebmhQpripLKbMNkp7a
	QX/u2iDFO+YB4SEVykHx86vIu4lmPxadEntqquuCF3J0dbv0X7nVJJrZoDdSYKBm
	LO7kSRoEtSq+y57kHEiXHppF7RSDB3Wrw7LQ4cUAN5FPwyJfMNWJYv587rURcbDa
	rNlB/v6JFy/u7OhbjRNt0ggYgkCebD8R15e2RGgapI79xRj3Q5FtvsUPISrbht9i
	/8928wFWuCuuRPglGU2WTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203783; x=
	1761290183; bh=L93SH8wa5avtwCfao/TdD40mBjzxH41YbEJ6NG1Uk5g=; b=P
	abkswzeNAdYem4XUt9sn/1v5b9lhd2SeXID9aFx3geUvPjOIa8eAymuI6Z7cAPwf
	wuq5fJdVm34yNZXGCltuBjoZYZxR/u9LxJJn8MINWOlVqcDeE+/hCsaph85+g8dm
	bLKZ0Cgkp4vKOrlgp2KuREAV9siwZXqAu7cTiRJMLXu7fyeNypmUdczlF7J9JRHZ
	k2d8OP+ZqJidDgbxBz0GyGI6AKIwYgV2+6i7SP0nKgnpRSxZiA3UEEwdHiJSWy5+
	oog1pLjqRie8vOrIfhETGC6Ql71CVHRymqhKLc/f/eSYN1KeDyPpuZwYo72kb/v9
	OLaXD9cO0JqZUGnmj8rMQ==
X-ME-Sender: <xms:R9b5aGpseGPI844e_X4pGTwsZWGbVUL5q1VPy1wXpkpnJyp6vtARig>
    <xme:R9b5aIWm1mCm2s9f6d3obbKdjK3k8O9tokhUB6d4FBTIGadJO9NXE-PzuOMCHlet7
    rvkKIpaBtSFrwSxGk1sUw_GlrmVwy-gYgdPfFwZVXEeTTREpdtVI7w>
X-ME-Received: <xmr:R9b5aFC_Xzat7WVKeRiXQ-BAI81MoRt5atxJFmAUA789JYFm6aZQXnOmZwMTlMuur7JxX3lbte_FWSEqgqqStO5vHGGt7sudPiGBuv9wiyiNRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpefgueduueefheehhfdtvedtudffuddttdetgeevffevieejvdfgfedugefgleeuffen
    ucffohhmrghinheprhgvfhdrnhgrmhgvpdhrvghfrdhtrghrghgvthenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:R9b5aM3EU86IIngiahz4MMR_5Fu0nm_hdhdjYEDJXa_5Y_XTb4vVzA>
    <xmx:R9b5aH3I7LWR_3en8bKLR2jkgQYype8GFjkiFG0EftfyPgP039boYQ>
    <xmx:R9b5aBDKXfoFcd8OkQ-gdX8oC9XU9AFWb_yUX_hUJypTfNdeZB0bjQ>
    <xmx:R9b5aG7fQRKc3xmMKh7sCCKEfBKHFucc2hGV146NNmitdhq8yOI5mQ>
    <xmx:R9b5aPmsRmjSDSRH9nNFjDxpzfCWkJ_aK1bJV0xMsL2livsaYS4HpiRQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d72a043 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:11 +0200
Subject: [PATCH v4 02/14] refs: introduce `.ref` field for the base
 iterator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-2-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The base iterator has a couple of fields that tracks the name, target,
object ID and flags for the current reference. Due to this design we
have to create a new `struct reference` whenever we want to hand over
that reference to the callback function, which is tedious and not very
efficient.

Convert the structure to instead contain a `struct reference` as member.
This member is expected to be populated by the implementations of the
iterator and is handed over to the callback directly.

While at it, simplify `should_pack_ref()` to take a `struct reference`
directly instead of passing its respective fields.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                  |  8 ++++----
 refs/debug.c            |  8 +++-----
 refs/files-backend.c    | 47 +++++++++++++++++++++--------------------------
 refs/iterator.c         | 39 ++++++++++++---------------------------
 refs/packed-backend.c   | 46 +++++++++++++++++++++++-----------------------
 refs/ref-cache.c        | 10 +++++-----
 refs/refs-internal.h    |  5 +----
 refs/reftable-backend.c | 12 ++++++------
 8 files changed, 75 insertions(+), 100 deletions(-)

diff --git a/refs.c b/refs.c
index 25f0579d610..f96cf43b128 100644
--- a/refs.c
+++ b/refs.c
@@ -2327,8 +2327,8 @@ int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
 int peel_iterated_oid(struct repository *r, const struct object_id *base, struct object_id *peeled)
 {
 	if (current_ref_iter &&
-	    (current_ref_iter->oid == base ||
-	     oideq(current_ref_iter->oid, base)))
+	    (current_ref_iter->ref.oid == base ||
+	     oideq(current_ref_iter->ref.oid, base)))
 		return ref_iterator_peel(current_ref_iter, peeled);
 
 	return peel_object(r, base, peeled) ? -1 : 0;
@@ -2703,7 +2703,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 
 			while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
 				if (skip &&
-				    string_list_has_string(skip, iter->refname))
+				    string_list_has_string(skip, iter->ref.name))
 					continue;
 
 				if (transaction && ref_transaction_maybe_set_rejected(
@@ -2712,7 +2712,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					continue;
 
 				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
-					    iter->refname, refname);
+					    iter->ref.name, refname);
 				goto cleanup;
 			}
 
diff --git a/refs/debug.c b/refs/debug.c
index 697adbd0dc3..67718bd1f49 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -160,11 +160,9 @@ static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		trace_printf_key(&trace_refs, "iterator_advance: (%d)\n", res);
 	else
 		trace_printf_key(&trace_refs, "iterator_advance: %s (0)\n",
-			diter->iter->refname);
+			diter->iter->ref.name);
 
-	diter->base.refname = diter->iter->refname;
-	diter->base.oid = diter->iter->oid;
-	diter->base.flags = diter->iter->flags;
+	diter->base.ref = diter->iter->ref;
 	return res;
 }
 
@@ -185,7 +183,7 @@ static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	struct debug_ref_iterator *diter =
 		(struct debug_ref_iterator *)ref_iterator;
 	int res = diter->iter->vtable->peel(diter->iter, peeled);
-	trace_printf_key(&trace_refs, "iterator_peel: %s: %d\n", diter->iter->refname, res);
+	trace_printf_key(&trace_refs, "iterator_peel: %s: %d\n", diter->iter->ref.name, res);
 	return res;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index eb3142f8f2d..fac53fa052d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -961,26 +961,23 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
-		    parse_worktree_ref(iter->iter0->refname, NULL, NULL,
+		    parse_worktree_ref(iter->iter0->ref.name, NULL, NULL,
 				       NULL) != REF_WORKTREE_CURRENT)
 			continue;
 
 		if ((iter->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS) &&
-		    (iter->iter0->flags & REF_ISSYMREF) &&
-		    (iter->iter0->flags & REF_ISBROKEN))
+		    (iter->iter0->ref.flags & REF_ISSYMREF) &&
+		    (iter->iter0->ref.flags & REF_ISBROKEN))
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->iter0->refname,
+		    !ref_resolves_to_object(iter->iter0->ref.name,
 					    iter->repo,
-					    iter->iter0->oid,
-					    iter->iter0->flags))
+					    iter->iter0->ref.oid,
+					    iter->iter0->ref.flags))
 			continue;
 
-		iter->base.refname = iter->iter0->refname;
-		iter->base.oid = iter->iter0->oid;
-		iter->base.flags = iter->iter0->flags;
-		iter->base.referent = iter->iter0->referent;
+		iter->base.ref = iter->iter0->ref;
 
 		return ITER_OK;
 	}
@@ -1367,30 +1364,29 @@ static void prune_refs(struct files_ref_store *refs, struct ref_to_prune **refs_
  * Return true if the specified reference should be packed.
  */
 static int should_pack_ref(struct files_ref_store *refs,
-			   const char *refname,
-			   const struct object_id *oid, unsigned int ref_flags,
+			   const struct reference *ref,
 			   struct pack_refs_opts *opts)
 {
 	struct string_list_item *item;
 
 	/* Do not pack per-worktree refs: */
-	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
+	if (parse_worktree_ref(ref->name, NULL, NULL, NULL) !=
 	    REF_WORKTREE_SHARED)
 		return 0;
 
 	/* Do not pack symbolic refs: */
-	if (ref_flags & REF_ISSYMREF)
+	if (ref->flags & REF_ISSYMREF)
 		return 0;
 
 	/* Do not pack broken refs: */
-	if (!ref_resolves_to_object(refname, refs->base.repo, oid, ref_flags))
+	if (!ref_resolves_to_object(ref->name, refs->base.repo, ref->oid, ref->flags))
 		return 0;
 
-	if (ref_excluded(opts->exclusions, refname))
+	if (ref_excluded(opts->exclusions, ref->name))
 		return 0;
 
 	for_each_string_list_item(item, opts->includes)
-		if (!wildmatch(item->string, refname, 0))
+		if (!wildmatch(item->string, ref->name, 0))
 			return 1;
 
 	return 0;
@@ -1443,8 +1439,7 @@ static int should_pack_refs(struct files_ref_store *refs,
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs, 0), NULL,
 					refs->base.repo, 0);
 	while ((ret = ref_iterator_advance(iter)) == ITER_OK) {
-		if (should_pack_ref(refs, iter->refname, iter->oid,
-				    iter->flags, opts))
+		if (should_pack_ref(refs, &iter->ref, opts))
 			refcount++;
 		if (refcount >= limit) {
 			ref_iterator_free(iter);
@@ -1489,24 +1484,24 @@ static int files_pack_refs(struct ref_store *ref_store,
 		 * in the packed ref cache. If the reference should be
 		 * pruned, also add it to refs_to_prune.
 		 */
-		if (!should_pack_ref(refs, iter->refname, iter->oid, iter->flags, opts))
+		if (!should_pack_ref(refs, &iter->ref, opts))
 			continue;
 
 		/*
 		 * Add a reference creation for this reference to the
 		 * packed-refs transaction:
 		 */
-		if (ref_transaction_update(transaction, iter->refname,
-					   iter->oid, NULL, NULL, NULL,
+		if (ref_transaction_update(transaction, iter->ref.name,
+					   iter->ref.oid, NULL, NULL, NULL,
 					   REF_NO_DEREF, NULL, &err))
 			die("failure preparing to create packed reference %s: %s",
-			    iter->refname, err.buf);
+			    iter->ref.name, err.buf);
 
 		/* Schedule the loose reference for pruning if requested. */
 		if ((opts->flags & PACK_REFS_PRUNE)) {
 			struct ref_to_prune *n;
-			FLEX_ALLOC_STR(n, name, iter->refname);
-			oidcpy(&n->oid, iter->oid);
+			FLEX_ALLOC_STR(n, name, iter->ref.name);
+			oidcpy(&n->oid, iter->ref.oid);
 			n->next = refs_to_prune;
 			refs_to_prune = n;
 		}
@@ -2379,7 +2374,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 					 REFNAME_ALLOW_ONELEVEL))
 			continue;
 
-		iter->base.refname = diter->relative_path;
+		iter->base.ref.name = diter->relative_path;
 		return ITER_OK;
 	}
 
diff --git a/refs/iterator.c b/refs/iterator.c
index 7f2e718f1c9..fe5980e1b6c 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -41,10 +41,7 @@ void base_ref_iterator_init(struct ref_iterator *iter,
 			    struct ref_iterator_vtable *vtable)
 {
 	iter->vtable = vtable;
-	iter->refname = NULL;
-	iter->referent = NULL;
-	iter->oid = NULL;
-	iter->flags = 0;
+	memset(&iter->ref, 0, sizeof(iter->ref));
 }
 
 struct empty_ref_iterator {
@@ -127,8 +124,8 @@ enum iterator_selection ref_iterator_select(struct ref_iterator *iter_worktree,
 		 * latter.
 		 */
 		if (iter_worktree) {
-			int cmp = strcmp(iter_worktree->refname,
-					 iter_common->refname);
+			int cmp = strcmp(iter_worktree->ref.name,
+					 iter_common->ref.name);
 			if (cmp < 0)
 				return ITER_SELECT_0;
 			else if (!cmp)
@@ -139,7 +136,7 @@ enum iterator_selection ref_iterator_select(struct ref_iterator *iter_worktree,
 		  * We now know that the lexicographically-next ref is a common
 		  * ref. When the common ref is a shared one we return it.
 		  */
-		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
+		if (parse_worktree_ref(iter_common->ref.name, NULL, NULL,
 				       NULL) == REF_WORKTREE_SHARED)
 			return ITER_SELECT_1;
 
@@ -212,10 +209,7 @@ static int merge_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		}
 
 		if (selection & ITER_YIELD_CURRENT) {
-			iter->base.referent = (*iter->current)->referent;
-			iter->base.refname = (*iter->current)->refname;
-			iter->base.oid = (*iter->current)->oid;
-			iter->base.flags = (*iter->current)->flags;
+			iter->base.ref = (*iter->current)->ref;
 			return ITER_OK;
 		}
 	}
@@ -313,7 +307,7 @@ static enum iterator_selection overlay_iterator_select(
 	else if (!front)
 		return ITER_SELECT_1;
 
-	cmp = strcmp(front->refname, back->refname);
+	cmp = strcmp(front->ref.name, back->ref.name);
 
 	if (cmp < 0)
 		return ITER_SELECT_0;
@@ -371,7 +365,7 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
-		int cmp = compare_prefix(iter->iter0->refname, iter->prefix);
+		int cmp = compare_prefix(iter->iter0->ref.name, iter->prefix);
 		if (cmp < 0)
 			continue;
 		/*
@@ -382,6 +376,8 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 		if (cmp > 0)
 			return ITER_DONE;
 
+		iter->base.ref = iter->iter0->ref;
+
 		if (iter->trim) {
 			/*
 			 * It is nonsense to trim off characters that
@@ -392,15 +388,11 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			 * one character left in the refname after
 			 * trimming, report it as a bug:
 			 */
-			if (strlen(iter->iter0->refname) <= iter->trim)
+			if (strlen(iter->base.ref.name) <= iter->trim)
 				BUG("attempt to trim too many characters");
-			iter->base.refname = iter->iter0->refname + iter->trim;
-		} else {
-			iter->base.refname = iter->iter0->refname;
+			iter->base.ref.name += iter->trim;
 		}
 
-		iter->base.oid = iter->iter0->oid;
-		iter->base.flags = iter->iter0->flags;
 		return ITER_OK;
 	}
 
@@ -476,14 +468,7 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 
 	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		struct reference ref = {
-			.name = iter->refname,
-			.target = iter->referent,
-			.oid = iter->oid,
-			.flags = iter->flags,
-		};
-
-		retval = fn(&ref, cb_data);
+		retval = fn(&iter->ref, cb_data);
 		if (retval)
 			goto out;
 	}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a8c22a0a7ff..7987acdc96a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -908,7 +908,7 @@ static int next_record(struct packed_ref_iterator *iter)
 	if (iter->pos == iter->eof)
 		return ITER_DONE;
 
-	iter->base.flags = REF_ISPACKED;
+	iter->base.ref.flags = REF_ISPACKED;
 	p = iter->pos;
 
 	if (iter->eof - p < snapshot_hexsz(iter->snapshot) + 2 ||
@@ -923,22 +923,22 @@ static int next_record(struct packed_ref_iterator *iter)
 				      iter->pos, iter->eof - iter->pos);
 
 	strbuf_add(&iter->refname_buf, p, eol - p);
-	iter->base.refname = iter->refname_buf.buf;
+	iter->base.ref.name = iter->refname_buf.buf;
 
 	if (refname_contains_nul(&iter->refname_buf))
-		die("packed refname contains embedded NULL: %s", iter->base.refname);
+		die("packed refname contains embedded NULL: %s", iter->base.ref.name);
 
-	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (!refname_is_safe(iter->base.refname))
+	if (check_refname_format(iter->base.ref.name, REFNAME_ALLOW_ONELEVEL)) {
+		if (!refname_is_safe(iter->base.ref.name))
 			die("packed refname is dangerous: %s",
-			    iter->base.refname);
+			    iter->base.ref.name);
 		oidclr(&iter->oid, iter->repo->hash_algo);
-		iter->base.flags |= REF_BAD_NAME | REF_ISBROKEN;
+		iter->base.ref.flags |= REF_BAD_NAME | REF_ISBROKEN;
 	}
 	if (iter->snapshot->peeled == PEELED_FULLY ||
 	    (iter->snapshot->peeled == PEELED_TAGS &&
-	     starts_with(iter->base.refname, "refs/tags/")))
-		iter->base.flags |= REF_KNOWS_PEELED;
+	     starts_with(iter->base.ref.name, "refs/tags/")))
+		iter->base.ref.flags |= REF_KNOWS_PEELED;
 
 	iter->pos = eol + 1;
 
@@ -956,11 +956,11 @@ static int next_record(struct packed_ref_iterator *iter)
 		 * definitely know the value of *this* reference. But
 		 * we suppress it if the reference is broken:
 		 */
-		if ((iter->base.flags & REF_ISBROKEN)) {
+		if ((iter->base.ref.flags & REF_ISBROKEN)) {
 			oidclr(&iter->peeled, iter->repo->hash_algo);
-			iter->base.flags &= ~REF_KNOWS_PEELED;
+			iter->base.ref.flags &= ~REF_KNOWS_PEELED;
 		} else {
-			iter->base.flags |= REF_KNOWS_PEELED;
+			iter->base.ref.flags |= REF_KNOWS_PEELED;
 		}
 	} else {
 		oidclr(&iter->peeled, iter->repo->hash_algo);
@@ -976,15 +976,15 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = next_record(iter)) == ITER_OK) {
-		const char *refname = iter->base.refname;
+		const char *refname = iter->base.ref.name;
 		const char *prefix = iter->prefix;
 
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
-		    !is_per_worktree_ref(iter->base.refname))
+		    !is_per_worktree_ref(iter->base.ref.name))
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
-		    !ref_resolves_to_object(iter->base.refname, iter->repo,
+		    !ref_resolves_to_object(iter->base.ref.name, iter->repo,
 					    &iter->oid, iter->flags))
 			continue;
 
@@ -1033,10 +1033,10 @@ static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 	struct packed_ref_iterator *iter =
 		(struct packed_ref_iterator *)ref_iterator;
 
-	if ((iter->base.flags & REF_KNOWS_PEELED)) {
+	if ((iter->base.ref.flags & REF_KNOWS_PEELED)) {
 		oidcpy(peeled, &iter->peeled);
 		return is_null_oid(&iter->peeled) ? -1 : 0;
-	} else if ((iter->base.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
+	} else if ((iter->base.ref.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
 		return -1;
 	} else {
 		return peel_object(iter->repo, &iter->oid, peeled) ? -1 : 0;
@@ -1194,7 +1194,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	iter->snapshot = snapshot;
 	acquire_snapshot(snapshot);
 	strbuf_init(&iter->refname_buf, 0);
-	iter->base.oid = &iter->oid;
+	iter->base.ref.oid = &iter->oid;
 	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
@@ -1436,7 +1436,7 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 			if (!iter)
 				cmp = +1;
 			else
-				cmp = strcmp(iter->refname, update->refname);
+				cmp = strcmp(iter->ref.name, update->refname);
 		}
 
 		if (!cmp) {
@@ -1459,11 +1459,11 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 					}
 
 					goto error;
-				} else if (!oideq(&update->old_oid, iter->oid)) {
+				} else if (!oideq(&update->old_oid, iter->ref.oid)) {
 					strbuf_addf(err, "cannot update ref '%s': "
 						    "is at %s but expected %s",
 						    update->refname,
-						    oid_to_hex(iter->oid),
+						    oid_to_hex(iter->ref.oid),
 						    oid_to_hex(&update->old_oid));
 					ret = REF_TRANSACTION_ERROR_INCORRECT_OLD_VALUE;
 
@@ -1527,8 +1527,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 			struct object_id peeled;
 			int peel_error = ref_iterator_peel(iter, &peeled);
 
-			if (write_packed_entry(out, iter->refname,
-					       iter->oid,
+			if (write_packed_entry(out, iter->ref.name,
+					       iter->ref.oid,
 					       peel_error ? NULL : &peeled))
 				goto write_error;
 
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index e5e5df16d85..f1abc396241 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -425,10 +425,10 @@ static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			level->prefix_state = entry_prefix_state;
 			level->index = -1;
 		} else {
-			iter->base.refname = entry->name;
-			iter->base.referent = entry->u.value.referent;
-			iter->base.oid = &entry->u.value.oid;
-			iter->base.flags = entry->flag;
+			iter->base.ref.name = entry->name;
+			iter->base.ref.target = entry->u.value.referent;
+			iter->base.ref.oid = &entry->u.value.oid;
+			iter->base.ref.flags = entry->flag;
 			return ITER_OK;
 		}
 	}
@@ -550,7 +550,7 @@ static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
 {
 	struct cache_ref_iterator *iter =
 		(struct cache_ref_iterator *)ref_iterator;
-	return peel_object(iter->repo, ref_iterator->oid, peeled) ? -1 : 0;
+	return peel_object(iter->repo, ref_iterator->ref.oid, peeled) ? -1 : 0;
 }
 
 static void cache_ref_iterator_release(struct ref_iterator *ref_iterator)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4ef3bd75c6a..ed749d16572 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -249,10 +249,7 @@ const char *find_descendant_ref(const char *dirname,
  */
 struct ref_iterator {
 	struct ref_iterator_vtable *vtable;
-	const char *refname;
-	const char *referent;
-	const struct object_id *oid;
-	unsigned int flags;
+	struct reference ref;
 };
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d4b79286202..0e47986cb5b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -704,10 +704,10 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 					    &iter->oid, flags))
 				continue;
 
-		iter->base.refname = iter->ref.refname;
-		iter->base.referent = referent;
-		iter->base.oid = &iter->oid;
-		iter->base.flags = flags;
+		iter->base.ref.name = iter->ref.refname;
+		iter->base.ref.target = referent;
+		iter->base.ref.oid = &iter->oid;
+		iter->base.ref.flags = flags;
 
 		break;
 	}
@@ -828,7 +828,7 @@ static struct reftable_ref_iterator *ref_iterator_for_stack(struct reftable_ref_
 
 	iter = xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
-	iter->base.oid = &iter->oid;
+	iter->base.ref.oid = &iter->oid;
 	iter->flags = flags;
 	iter->refs = refs;
 	iter->exclude_patterns = filter_exclude_patterns(exclude_patterns);
@@ -2072,7 +2072,7 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 
 		strbuf_reset(&iter->last_name);
 		strbuf_addstr(&iter->last_name, iter->log.refname);
-		iter->base.refname = iter->log.refname;
+		iter->base.ref.name = iter->log.refname;
 
 		break;
 	}

-- 
2.51.1.930.gacf6e81ea2.dirty

