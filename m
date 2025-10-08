Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFDB2FB607
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938658; cv=none; b=gRrzmudRc6ocMszl3RDVOS+gUsieZ/zSxl/vUQQOlC2gPj/Mv8Jrv32u4qnaWRrr4lNbBVRaxYKjwXH/tdDrudMM2q0IL3JmAJTnBu6nsWr5DFhex/VxCz1qY8KSYR14FeVUTcwVkSUO+xEv90hO3O/ayJBxySh+smRN2oizkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938658; c=relaxed/simple;
	bh=D40KurRmB2xSDnzjk/jgeezHWo1iA4S900r/uCmYowc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dELcyJb3FLw2ebe8r6rvzjSG4UA3q+TO1lSy+ntj5EFc/y+VGq7MuFqbQXgvEHtV6fmXWsdcWimVEL7BT/rg3SUwvIQY/4Efw9PWUEakArcSZwjNMFzxHCz20T/7i9qb1bLrTC373BJwtyW5+sEHNajjLd5t+mIg/Lib5WrYCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IR1mNN0W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AD/wAgCQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IR1mNN0W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AD/wAgCQ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CEBD87A05D6;
	Wed,  8 Oct 2025 11:50:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 08 Oct 2025 11:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759938655;
	 x=1760025055; bh=l+ffiKgPxjrvaKf1teq7J01+NVR+9JUWg05ipRkPEYk=; b=
	IR1mNN0WBcKshk4xRVUes7879u2tR+vln0DOrNDKfQ32lHeRZcsl9uGpWnXqVEgy
	Wxj7Hp7coRBTmJWOnn0d4u+8BjYKqA6YGmzpc6lpAsZPBNx6uI39fCZV1MLPXQDQ
	2gIdUaj5spP9ZLSlsYghIy3k3uERAhvnql8fyy1f7OtJD3e5F2mQMNqKZmXwJ05h
	Hwwh8M2yfFCrJbAXYVqAEIaTMP0t46RCYqi6Zcpyc4oTlpp0Aair0vJvWxPcu0UJ
	6kLlLEjY+P3YPbQRG4CFvqKtrnxae+4YCHt+6cdbRybpnzJLB2/2wd3mT0s2igxb
	oFSGnzAMlOkNq6Oho5tZWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759938655; x=
	1760025055; bh=l+ffiKgPxjrvaKf1teq7J01+NVR+9JUWg05ipRkPEYk=; b=A
	D/wAgCQWHVRxEarycih/gGcgoHreQjF+i4SsWm6whbTwApN0QX8qL5NDiVw0q7GI
	20Es4pW1QrVzCtTkx8vHVPfJwaUsTftjfpEXDMBAgqzJSk9nPwn3lG0ImtE8k67d
	wbmer2qkYRtEatz+RSCUzNja/YMNCkHjvEgFxxeoHc5MO8h+AgBq+u4GFwTjWimx
	bnNDQMzt/vyQtefIBZbyDRXXOMQ4SHUFGxLIP5AiOGCJ82XzHPV8D92DlO7oTIQy
	z9Hi56cVq7m5dtglcnOG8cpxrqwHPa+0Znjv/O5hfZMTF1RHMMseus0cJXH+Vjlc
	Vrr0mRoiLnqwIBxk0CKOw==
X-ME-Sender: <xms:X4jmaNxcPCwC8kxwqaFP7xNR-QdE2xYO064QvgZYWqgZ3WX6wbFbLA>
    <xme:X4jmaA9zYmv364kOhJqBidlAUo6_EtSsegjEzcNKi3bnVSCP13VEoQsiGELLNDPcA
    EBpkv95LljdMr5Kz6tI5oJ5HbMeSG4WZfqQWIR0oAWj1tBM6GrPVhA>
X-ME-Received: <xmr:X4jmaBLS4YjzmIF3abEOcN8K12g0kQDc6MSnfLBNy2VtQPXzhETZXj0ncwniJ2f4rT_D6PghF_ltZct_nT_Ta9xODecU37tGmAxkLNK3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteeileejgfen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:X4jmaGcNaFMf1ykX3ArOg1bMtudTusWii1GcHzwxum5OkaN2pPckgA>
    <xmx:X4jmaA8OwhLVdMFHejdYDP6TfYgN6VM97u880n9j0vRaVg4GEseCaw>
    <xmx:X4jmaDqVRdzoilOlFA62lNAWdpI7cbI9EyfteddNrZd2T9HroFAkcA>
    <xmx:X4jmaFAcMznG5HMtJk8S_bVvLliVB4QxkQux0AbV74qAk2vslNnLfg>
    <xmx:X4jmaEue_brbJ1TAw7keXBYH_uYDEXSU3is0w9MqwLuJOqCEFBXUzyVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:50:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3f91326 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 15:50:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 08 Oct 2025 17:50:25 +0200
Subject: [PATCH v2 10/14] refs: drop infrastructure to peel via iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-10-76e30d5c9542@pks.im>
References: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
In-Reply-To: <20251008-b4-pks-ref-filter-skip-parsing-objects-v2-0-76e30d5c9542@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Now that the peeled object ID gets propagated via the `struct reference`
there is no need anymore to call into the reference iterator itself to
dereference an object. Remove this infrastructure.

Most of the changes are straight-forward deletions of code. There is one
exception though in `refs/packed-backend.c::write_with_updates()`. Here
we stop peeling the iterator and instead just pass the peeled object ID
of that iterator directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h                  | 14 --------------
 refs/debug.c            | 11 -----------
 refs/files-backend.c    | 17 -----------------
 refs/iterator.c         | 36 ------------------------------------
 refs/packed-backend.c   | 24 +-----------------------
 refs/ref-cache.c        |  9 ---------
 refs/refs-internal.h    |  7 -------
 refs/reftable-backend.c | 24 ------------------------
 8 files changed, 1 insertion(+), 141 deletions(-)

diff --git a/refs.h b/refs.h
index 886ed2c0f4..2dd7ac1a16 100644
--- a/refs.h
+++ b/refs.h
@@ -1289,10 +1289,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
  * to the next entry, ref_iterator_advance() aborts the iteration,
  * frees the ref_iterator, and returns ITER_ERROR.
  *
- * The reference currently being looked at can be peeled by calling
- * ref_iterator_peel(). This function is often faster than peel_ref(),
- * so it should be preferred when iterating over references.
- *
  * Putting it all together, a typical iteration looks like this:
  *
  *     int ok;
@@ -1307,9 +1303,6 @@ int repo_migrate_ref_storage_format(struct repository *repo,
  *             // Access information about the current reference:
  *             if (!(iter->flags & REF_ISSYMREF))
  *                     printf("%s is %s\n", iter->refname, oid_to_hex(iter->oid));
- *
- *             // If you need to peel the reference:
- *             ref_iterator_peel(iter, &oid);
  *     }
  *
  *     if (ok != ITER_DONE)
@@ -1400,13 +1393,6 @@ enum ref_iterator_seek_flag {
 int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *refname,
 		      unsigned int flags);
 
-/*
- * If possible, peel the reference currently being viewed by the
- * iterator. Return 0 on success.
- */
-int ref_iterator_peel(struct ref_iterator *ref_iterator,
-		      struct object_id *peeled);
-
 /* Free the reference iterator and any associated resources. */
 void ref_iterator_free(struct ref_iterator *ref_iterator);
 
diff --git a/refs/debug.c b/refs/debug.c
index 7a26035617..162c24e5cc 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -178,16 +178,6 @@ static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return res;
 }
 
-static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
-{
-	struct debug_ref_iterator *diter =
-		(struct debug_ref_iterator *)ref_iterator;
-	int res = diter->iter->vtable->peel(diter->iter, peeled);
-	trace_printf_key(&trace_refs, "iterator_peel: %s: %d\n", diter->iter->ref.name, res);
-	return res;
-}
-
 static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct debug_ref_iterator *diter =
@@ -199,7 +189,6 @@ static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 	.advance = debug_ref_iterator_advance,
 	.seek = debug_ref_iterator_seek,
-	.peel = debug_ref_iterator_peel,
 	.release = debug_ref_iterator_release,
 };
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d34fbe55d6..a4cda57981 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -994,15 +994,6 @@ static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return ref_iterator_seek(iter->iter0, refname, flags);
 }
 
-static int files_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
-{
-	struct files_ref_iterator *iter =
-		(struct files_ref_iterator *)ref_iterator;
-
-	return ref_iterator_peel(iter->iter0, peeled);
-}
-
 static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct files_ref_iterator *iter =
@@ -1013,7 +1004,6 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
 	.seek = files_ref_iterator_seek,
-	.peel = files_ref_iterator_peel,
 	.release = files_ref_iterator_release,
 };
 
@@ -2389,12 +2379,6 @@ static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
 	BUG("ref_iterator_seek() called for reflog_iterator");
 }
 
-static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
-				      struct object_id *peeled UNUSED)
-{
-	BUG("ref_iterator_peel() called for reflog_iterator");
-}
-
 static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct files_reflog_iterator *iter =
@@ -2405,7 +2389,6 @@ static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
 	.seek = files_reflog_iterator_seek,
-	.peel = files_reflog_iterator_peel,
 	.release = files_reflog_iterator_release,
 };
 
diff --git a/refs/iterator.c b/refs/iterator.c
index 072c6aacdb..d79aa5ec82 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -21,12 +21,6 @@ int ref_iterator_seek(struct ref_iterator *ref_iterator, const char *refname,
 	return ref_iterator->vtable->seek(ref_iterator, refname, flags);
 }
 
-int ref_iterator_peel(struct ref_iterator *ref_iterator,
-		      struct object_id *peeled)
-{
-	return ref_iterator->vtable->peel(ref_iterator, peeled);
-}
-
 void ref_iterator_free(struct ref_iterator *ref_iterator)
 {
 	if (ref_iterator) {
@@ -60,12 +54,6 @@ static int empty_ref_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
 	return 0;
 }
 
-static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
-				   struct object_id *peeled UNUSED)
-{
-	BUG("peel called for empty iterator");
-}
-
 static void empty_ref_iterator_release(struct ref_iterator *ref_iterator UNUSED)
 {
 }
@@ -73,7 +61,6 @@ static void empty_ref_iterator_release(struct ref_iterator *ref_iterator UNUSED)
 static struct ref_iterator_vtable empty_ref_iterator_vtable = {
 	.advance = empty_ref_iterator_advance,
 	.seek = empty_ref_iterator_seek,
-	.peel = empty_ref_iterator_peel,
 	.release = empty_ref_iterator_release,
 };
 
@@ -240,18 +227,6 @@ static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return 0;
 }
 
-static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
-{
-	struct merge_ref_iterator *iter =
-		(struct merge_ref_iterator *)ref_iterator;
-
-	if (!iter->current) {
-		BUG("peel called before advance for merge iterator");
-	}
-	return ref_iterator_peel(*iter->current, peeled);
-}
-
 static void merge_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct merge_ref_iterator *iter =
@@ -263,7 +238,6 @@ static void merge_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable merge_ref_iterator_vtable = {
 	.advance = merge_ref_iterator_advance,
 	.seek = merge_ref_iterator_seek,
-	.peel = merge_ref_iterator_peel,
 	.release = merge_ref_iterator_release,
 };
 
@@ -412,15 +386,6 @@ static int prefix_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return ref_iterator_seek(iter->iter0, refname, flags);
 }
 
-static int prefix_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				    struct object_id *peeled)
-{
-	struct prefix_ref_iterator *iter =
-		(struct prefix_ref_iterator *)ref_iterator;
-
-	return ref_iterator_peel(iter->iter0, peeled);
-}
-
 static void prefix_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct prefix_ref_iterator *iter =
@@ -432,7 +397,6 @@ static void prefix_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable prefix_ref_iterator_vtable = {
 	.advance = prefix_ref_iterator_advance,
 	.seek = prefix_ref_iterator_seek,
-	.peel = prefix_ref_iterator_peel,
 	.release = prefix_ref_iterator_release,
 };
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1fefefd54e..6fa229edd0 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1030,22 +1030,6 @@ static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return 0;
 }
 
-static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
-{
-	struct packed_ref_iterator *iter =
-		(struct packed_ref_iterator *)ref_iterator;
-
-	if ((iter->base.ref.flags & REF_KNOWS_PEELED)) {
-		oidcpy(peeled, &iter->peeled);
-		return is_null_oid(&iter->peeled) ? -1 : 0;
-	} else if ((iter->base.ref.flags & (REF_ISBROKEN | REF_ISSYMREF))) {
-		return -1;
-	} else {
-		return peel_object(iter->repo, &iter->oid, peeled) ? -1 : 0;
-	}
-}
-
 static void packed_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct packed_ref_iterator *iter =
@@ -1059,7 +1043,6 @@ static void packed_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 	.advance = packed_ref_iterator_advance,
 	.seek = packed_ref_iterator_seek,
-	.peel = packed_ref_iterator_peel,
 	.release = packed_ref_iterator_release,
 };
 
@@ -1525,13 +1508,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 
 		if (cmp < 0) {
 			/* Pass the old reference through. */
-
-			struct object_id peeled;
-			int peel_error = ref_iterator_peel(iter, &peeled);
-
 			if (write_packed_entry(out, iter->ref.name,
-					       iter->ref.oid,
-					       peel_error ? NULL : &peeled))
+					       iter->ref.oid, iter->ref.peeled_oid))
 				goto write_error;
 
 			if ((ok = ref_iterator_advance(iter)) != ITER_OK) {
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 4726de430d..9d0cae10b5 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -546,14 +546,6 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return 0;
 }
 
-static int cache_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
-{
-	struct cache_ref_iterator *iter =
-		(struct cache_ref_iterator *)ref_iterator;
-	return peel_object(iter->repo, ref_iterator->ref.oid, peeled) ? -1 : 0;
-}
-
 static void cache_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct cache_ref_iterator *iter =
@@ -565,7 +557,6 @@ static void cache_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable cache_ref_iterator_vtable = {
 	.advance = cache_ref_iterator_advance,
 	.seek = cache_ref_iterator_seek,
-	.peel = cache_ref_iterator_peel,
 	.release = cache_ref_iterator_release,
 };
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f4f845bbea..4671517dad 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -357,12 +357,6 @@ typedef int ref_iterator_advance_fn(struct ref_iterator *ref_iterator);
 typedef int ref_iterator_seek_fn(struct ref_iterator *ref_iterator,
 				 const char *refname, unsigned int flags);
 
-/*
- * Peels the current ref, returning 0 for success or -1 for failure.
- */
-typedef int ref_iterator_peel_fn(struct ref_iterator *ref_iterator,
-				 struct object_id *peeled);
-
 /*
  * Implementations of this function should free any resources specific
  * to the derived class.
@@ -372,7 +366,6 @@ typedef void ref_iterator_release_fn(struct ref_iterator *ref_iterator);
 struct ref_iterator_vtable {
 	ref_iterator_advance_fn *advance;
 	ref_iterator_seek_fn *seek;
-	ref_iterator_peel_fn *peel;
 	ref_iterator_release_fn *release;
 };
 
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 0468f62a7e..d9447f8fa7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -743,21 +743,6 @@ static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
 	return iter->err;
 }
 
-static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
-				      struct object_id *peeled)
-{
-	struct reftable_ref_iterator *iter =
-		(struct reftable_ref_iterator *)ref_iterator;
-
-	if (iter->ref.value_type == REFTABLE_REF_VAL2) {
-		oidread(peeled, iter->ref.value.val2.target_value,
-			iter->refs->base.repo->hash_algo);
-		return 0;
-	}
-
-	return -1;
-}
-
 static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct reftable_ref_iterator *iter =
@@ -775,7 +760,6 @@ static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.advance = reftable_ref_iterator_advance,
 	.seek = reftable_ref_iterator_seek,
-	.peel = reftable_ref_iterator_peel,
 	.release = reftable_ref_iterator_release,
 };
 
@@ -2097,13 +2081,6 @@ static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSE
 	return -1;
 }
 
-static int reftable_reflog_iterator_peel(struct ref_iterator *ref_iterator UNUSED,
-					 struct object_id *peeled UNUSED)
-{
-	BUG("reftable reflog iterator cannot be peeled");
-	return -1;
-}
-
 static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 {
 	struct reftable_reflog_iterator *iter =
@@ -2116,7 +2093,6 @@ static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable reftable_reflog_iterator_vtable = {
 	.advance = reftable_reflog_iterator_advance,
 	.seek = reftable_reflog_iterator_seek,
-	.peel = reftable_reflog_iterator_peel,
 	.release = reftable_reflog_iterator_release,
 };
 

-- 
2.51.0.764.g787ff6f08a.dirty

