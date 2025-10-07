Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2312D9796
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834767; cv=none; b=qplV7nxcv5agHiDXas7hPlC+u7fjbhgKFSCSktqaxHBRAyQWZ0GaA6ythqwlfFo81ymbV5J+CW5K1nchu+ChS1iw5rIOnH06Dci9GKIkeO26MT7foBStPc7rAPUuNBShkRxsgjhtcDpFO4zlgJIZCZZE4W8PVcPfc8Qu0kCsGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834767; c=relaxed/simple;
	bh=22/b71fQij8aXHQWRFqAlAI9D3WxMEpZ6twmmdDuS3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxZnReJYeoGkvaxhOIp7uHQG6UWcRSnWnyrc5JBtHsTK7IPqgx0a0+uMN6zdtR7SMbW15XJG8Dlo+rfFg3vxkKQMxgUc/VSoSCrmKxXu4uQ2MOz/eVX1iLjOVGHTE+wCqXLXrOgACOORdlIysIxXw5Ez9CfJFfO603YvAt40Np8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ecf5qWqf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wT4R0rGK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ecf5qWqf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wT4R0rGK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A2AF7A0084
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 06:59:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 07 Oct 2025 06:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759834764;
	 x=1759921164; bh=XhqkGSeiDkrLoJvfgWCE5ymuVD7AclCI6jSYWlLjKb0=; b=
	ecf5qWqfYx0dD9yEQ7pz30+v7CwE29jJHPuneMWTNYKhh8CrXFhsJIoXUEuDzTQq
	rtt4EWApPYsFzap6XJ+oR1+SsozfpNqHD46HpHuJotLov3vBkx0lenV5Qs1JlWqD
	1rdR+VKBKsfO6b8paVapl1XqfI3rInwNQhImrIKyepbYV9mb8oa2pTU7dNJk2DKK
	SL05OTvzXgJvDBkkJtahYxi9/ErNrLJG/Xdvde9S5bODCUylhALfEdAGun+0iIK/
	kJlJUXHU4E2XgG2zlAwXi/GR92U0HQvwkAzAWVBOSH7oZgs8n2GxDZJGGoeKNFRY
	FX/tHIzGSo6UmcXRELUgUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759834764; x=
	1759921164; bh=XhqkGSeiDkrLoJvfgWCE5ymuVD7AclCI6jSYWlLjKb0=; b=w
	T4R0rGKSYij0mGl+FkGcSIVLnnVmFOGeEYcDJu86HTC52ykEhrPAbWnJtk79RKum
	WvLhVdOl2ZrzjNCzQ1bTKtRIfAvpeRGY5Id679JebOyDQTU6pHXa0aIzBDUOJdTf
	UuLkcDYLCXVMcmm5/+OcmKxocohwIWdyV181XEVXxCKWZ56930uklbNYmkbr7V6W
	dsnBugK4K8zn1l0d2VPEU19mgcPXMM72y5JnBYdXYwURDxC6NvKj+RG0vg/aWHg5
	DCxEXGKhJ537jJ0XSm9m0a5spTQaVXazd6Yp84o0n4f49CUiMJFvrwxX56vTYqNp
	Dlzgc+8teQoNOoO7noDoQ==
X-ME-Sender: <xms:jPLkaMsELOQSs_w9cGXpA5aKsVCC74QqUD1qDYD4kEqLAO2ER_MXfA>
    <xme:jPLkaAaB0M4LTwxwSFid8I0KK_J4gHN4V4fTqjwaBfnSxYfAKGVjHh1dUO-_kkH28
    myWVTjOJ777JRe32cZU2X6j3vde-uMkTlo2M8Vme12xicR3Ac4VVQ>
X-ME-Received: <xmr:jPLkaNa-XARGztRguNvQ_3-pWyQo9MLsfDk1MrBEKK7ZOBFP1-zO03q_tMJ7wYR0XiR3fXQYDsNDfFneR6C8siTlv4ZGTeQm1ZY8bTZ35Oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteei
    leejgfenucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jPLkaEUGrxhY2SXepFpoEfNDpnodG_hzHxHhoLMumVwVW_NtivpmYg>
    <xmx:jPLkaM2e6ABzWAzHCM2RjWGzLsY3O-LOCJ-jvklcxI4oDCRCTOBRkQ>
    <xmx:jPLkaDa4Xk4aECHC08u_vxiPAPh_8ImVBmzyEQn8nCQADziDULKCnw>
    <xmx:jPLkaHr8myxOBRcIJkFaxPc9H0fzxIn9Fn9lIRIdNFDTs2JgxhQFqw>
    <xmx:jPLkaPdwtbv8YPd49AsCxGMSii9u_2oQzpglGISbQkF86NEcHWTuYGkW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Oct 2025 06:59:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5e56830 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Oct 2025 10:59:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 12:58:46 +0200
Subject: [PATCH 09/13] refs: drop infrastructure to peel via iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-9-916cc7c6886b@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
To: git@vger.kernel.org
Cc: 
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
index f1e023df35..1f76000055 100644
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
index 7922d63acc..274c2f23aa 100644
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
 
@@ -1526,13 +1509,8 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 
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
index 2f46f650a6..7d515fc527 100644
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
index f93ab96358..14160023e5 100644
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
2.51.0.764.g787ff6f08a.dirty

