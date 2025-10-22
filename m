Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951622F0C7B
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115299; cv=none; b=eD3Re8LgjDHvyODGMinXbRoWfEVLXRjYGc/7AOIxdY4gUf1dur+0fkHyWLMN7W3FdktpNVby2J80rjlf+wRPZyz2GipGgy8MuxjFByHDzlwS7fTM7gFgKKUUpGe4vUYejjNodnB24CxhsMcl4uFs+/gM1oK66+6TYYM/flRz3IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115299; c=relaxed/simple;
	bh=/XjSuiHF+dzgO1WZ+Qhmu5+3vSiFweY2QG7RpL7xsgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SB7mHKDTvykSCZPdt6PQJ8fOtO1qCoXKwsZVlAd5PyuNIAy7fuFWbbcF3vJ2+ZXCCdrv4Ko1Jo68nnoAp6tljGcP9PUyqJZODVGIas52ZBMGaoY/g0IlqTDyiReccMu5/666CwenNzw39IgwyPMrZMlnJQWFUzKlT33VOwu5VOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eE3H3oNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCUFYl56; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eE3H3oNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCUFYl56"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 81BF91D0012B;
	Wed, 22 Oct 2025 02:41:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 22 Oct 2025 02:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761115296;
	 x=1761201696; bh=l60dzPb1JjWOSON5PN1RMxA2RZky1c4sDN9LJNXwpCo=; b=
	eE3H3oNExLZcrvRkP4jD5wlbbM0OjMG1FuUvjMHWspmQ2ND2TIs4HRqIVgcGgW6e
	lGopNnsAoTAMcnJWKB4Z4aHF5r3shB1L0JIPTE2cpJ4U1R6k5sAy20eZzQ7raBCD
	7Vteun+N3fgFn7R6Htr3dUw5boUFMhaP+JVQFYGx8v+MqsPFcTC8cgDk9FneM1l+
	hprNeueBz5mT8ABuVRFczpcGn3bTG7e3CKeVCf9X+nd84NcETC3Ha3yRU3czTCbU
	KZpToCJB83afUldm2NcJaoHoJHfsHdXlQs36SKOrjLjfyf9v6D2mmw0vSFd3+tix
	nbS4uMKm0QEOd1f87CDt8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761115296; x=
	1761201696; bh=l60dzPb1JjWOSON5PN1RMxA2RZky1c4sDN9LJNXwpCo=; b=P
	CUFYl565XOWooAHDse7pTXkPwrQ/1lyi8IdR5pbZRFhpjIeV/fKFKWiUkpUQOfGJ
	lmjT6R+8SgOR4RNuZOXTcPtdTd+0lofO4DkQ3VJAn083PlS6wfba5PBalSHnAR2H
	VnUom5d0uvArljci71CcAVBW0jSYa2LI8u6kt3rXTx0g7VtraX7YAmq1uDeudGzQ
	HPTDlpd1syXp2sOOiecDn8OAuAEOl8aWA4wD5KUPAuEZ+tlk0O/WLlC4a391pRKg
	5OCDhBFBMSsz8FcYBUj5C3HcPzY4XoQPbgWfeb/WwgPHFkHxm51HGFQlFEeCK54J
	eA4KyjlDS+Xs7iPZ6ismg==
X-ME-Sender: <xms:oHz4aHR4o3ZSuP47B9hB0gbsyWxllqhbe5krRkLgIIzcrg2OSV7ZJg>
    <xme:oHz4aMfCM_xW-RtuGp5sA_Av-IKxuK8axgRCo9SRkbeIigpeegkVM62VJxk31pja1
    8oCQ1XIpUmfIkq9BacqMTBdSUx576ndDcl0DhyfGkP5WcJJiMvhww>
X-ME-Received: <xmr:oHz4aGoTQE1LyHvbExJu-gGDdPF7RNBuVzAR420w9j8Dm63uYmEBI_H8ETAV7DO-Pg0JvVFgIGy4R7Eq4x8usPqPDLQm-qKivYlwNeCk54c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteeileejgfen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oHz4aN_vXis7jeeQu70Ab8FIBXWFku7W9L5BVNNkmflGP45DLVs4Ng>
    <xmx:oHz4aCdL-KxYAfcldOBFgc8E3NHrnofFs5lQOUZcyf7fvL9O3Eql4w>
    <xmx:oHz4aHIoYWLCeAZBoYHRRCue0I2WHz2_rrP4GJkR_9d83ofYSXvv3g>
    <xmx:oHz4aCgb1WAs7M4K5ezfz1rd0KWa0OUWUCysYHU2-HQphUYgOhyIPA>
    <xmx:oHz4aGNgrNfXJwMnWFyU0ICXo4FL9SihXkrTU69-DBWr_LvYoT6BUl9->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 02:41:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d9c67eff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 22 Oct 2025 06:41:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 22 Oct 2025 08:41:10 +0200
Subject: [PATCH v3 10/14] refs: drop infrastructure to peel via iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-10-eb9f71985ef0@pks.im>
References: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
In-Reply-To: <20251022-b4-pks-ref-filter-skip-parsing-objects-v3-0-eb9f71985ef0@pks.im>
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
index 886ed2c0f43..2dd7ac1a16a 100644
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
index 67718bd1f49..01499b9033c 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -177,16 +177,6 @@ static int debug_ref_iterator_seek(struct ref_iterator *ref_iterator,
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
@@ -198,7 +188,6 @@ static void debug_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable debug_ref_iterator_vtable = {
 	.advance = debug_ref_iterator_advance,
 	.seek = debug_ref_iterator_seek,
-	.peel = debug_ref_iterator_peel,
 	.release = debug_ref_iterator_release,
 };
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fac53fa052d..5aeb454fb47 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -993,15 +993,6 @@ static int files_ref_iterator_seek(struct ref_iterator *ref_iterator,
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
@@ -1012,7 +1003,6 @@ static void files_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable files_ref_iterator_vtable = {
 	.advance = files_ref_iterator_advance,
 	.seek = files_ref_iterator_seek,
-	.peel = files_ref_iterator_peel,
 	.release = files_ref_iterator_release,
 };
 
@@ -2388,12 +2378,6 @@ static int files_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSED,
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
@@ -2404,7 +2388,6 @@ static void files_reflog_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 	.advance = files_reflog_iterator_advance,
 	.seek = files_reflog_iterator_seek,
-	.peel = files_reflog_iterator_peel,
 	.release = files_reflog_iterator_release,
 };
 
diff --git a/refs/iterator.c b/refs/iterator.c
index 072c6aacdb0..d79aa5ec82d 100644
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
index 1fefefd54ed..6fa229edd0f 100644
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
index e427848879d..ffef01a5975 100644
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
index f4f845bbeaf..4671517dade 100644
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
index e214e120d77..e329d4a423a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -744,21 +744,6 @@ static int reftable_ref_iterator_seek(struct ref_iterator *ref_iterator,
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
@@ -776,7 +761,6 @@ static void reftable_ref_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable reftable_ref_iterator_vtable = {
 	.advance = reftable_ref_iterator_advance,
 	.seek = reftable_ref_iterator_seek,
-	.peel = reftable_ref_iterator_peel,
 	.release = reftable_ref_iterator_release,
 };
 
@@ -2098,13 +2082,6 @@ static int reftable_reflog_iterator_seek(struct ref_iterator *ref_iterator UNUSE
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
@@ -2117,7 +2094,6 @@ static void reftable_reflog_iterator_release(struct ref_iterator *ref_iterator)
 static struct ref_iterator_vtable reftable_reflog_iterator_vtable = {
 	.advance = reftable_reflog_iterator_advance,
 	.seek = reftable_reflog_iterator_seek,
-	.peel = reftable_reflog_iterator_peel,
 	.release = reftable_reflog_iterator_release,
 };
 

-- 
2.51.1.851.g4ebd6896fd.dirty

