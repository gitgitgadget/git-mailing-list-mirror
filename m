Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959632DF134
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203812; cv=none; b=kIymMCTX/llut4xny7dOd3yzIlk4gXHprswyMpLPVhDur0FlLdDl629/zLRRdfGIy4cIaC508q8RUOiMZLdwOpxXH3/0iRBxqnen27A+PQnhwqvyK21WWZkgA+j2ti3JaKmVtVQ6w0LzeWAVMtS/AZ8bDVX/MzQpnYoVW/24B+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203812; c=relaxed/simple;
	bh=A2bBU5vO22ocibu4EwgC4KxE3XNSCeTO7o24H1hqL60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtoMtiRvMkGhh1D145zZCL4QfNT0J2qgBPltW0x7GoddAgbL0wC9Dn8c55ABbgcBWp8Edan0a4Zmg1x3hgSWl7+aNh+GkJ35YQHPFlDl+PYKn46LW+vAKy0ubcZ22q+zrMzRCh2OzktqDDkavUaaUPZZLx5SFLq+s1Ok0FVCOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iAAYhFVf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E+MNMwh9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iAAYhFVf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E+MNMwh9"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A99DDEC01FA;
	Thu, 23 Oct 2025 03:16:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 23 Oct 2025 03:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203809;
	 x=1761290209; bh=GBqcjEEOHqGOBVGaIkaf1PMrYoD1uFoIo2rt06xfH9Q=; b=
	iAAYhFVf/Ql3EiOvzep9lp6k4QeWcoNlGYWRNCsfaoL9ktSez+NDEqnyf0kgmnr/
	AyEFg2jfXvh/RoweykRTmBbq/9hLzmoGMQy3Tcfj8yC2gNT6NRUEVzlS01icR63+
	bJJ6+hCsl3jF3wBEe4M1RcfEGJHTxdyJJbZ3NvJrcLq1zue0wReSypfbhQ1dqmWh
	DEJcaaq1vP1v6GDDWKKl0rRACfViPd/6IECbHVZvv7Ct+D0ZwMJqe7y1nd5D4Hno
	/t1UUsIuUQ8GLEATtEg8gsn4AUKZKOw3a//6/EKD/X51+lQbvTGemrbzgwVUqfu1
	78HQ2YDuvYF4jgCYEN7rww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203809; x=
	1761290209; bh=GBqcjEEOHqGOBVGaIkaf1PMrYoD1uFoIo2rt06xfH9Q=; b=E
	+MNMwh9pvmXL6ZIjCmDDH/+vuOFAJqO2JAumIf8grjtKqOhty3t/ntSZO17dpgtE
	MvGcll48Mqow7nghIT7k9zUb08K6Ph4SeNodSKx/hvHsX4uO3ZdaW59ySgbfNJzC
	tuDZG/BudS9jJn1E7kjoGAu/TUbbbKOQAw9P2EneDBH8tGdBh/kHtLjWhCSFPE74
	JSUbi1/i6eOg6oMb10Xn88mo8HrNHE6uTOSd2totHNp2eHPb2BQmQqfvT7KnjWsu
	q8WbInMUNQMQmr/JJkDm6YecHgCnOWOCI1UuBwabdJphAh+Mu4riBnFRPPO42Qvq
	ZiTrijyYsr2AdWpu0erEA==
X-ME-Sender: <xms:Ydb5aIW-FwRm3087vc3aWH5CejLz6WmzX0B8w7A_MGrg2CYSHFwWLQ>
    <xme:Ydb5aATeVAP2ObAjT4S4wmREA-VJRcIhXizh-ww6aw2sQoAvAqxxauR4ruWKUvHAM
    jg1YzZxEMrr0go-IDM_w6XhaenBdkPLPfP1C7bhR2Naao_SJvhXcyE>
X-ME-Received: <xmr:Ydb5aGN6DReGP-FM07MSo-gaH_H9FSAL-73QAvbioA_acsvJHaeTKeNLtOLj1dh7UrWorgHd-aSHH2NxGanrbe2xlAdOOvC38pD5Fv_Y82wiVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeljeekveekkeeljeegleduheekkeetfeefudfgkeffhfelueduteeileejgfen
    ucffohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeekse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:Ydb5aOR9433eWr4O3GVPPj4gX8ecEItr-QvkG9mrkFApvVdcnqeyBA>
    <xmx:Ydb5aEhBnSkvlFxQbbYGnHW4lcfDnJwmiE09PiuTHfPTPMJC-wRimA>
    <xmx:Ydb5aH-aKy4GgRKBlooPaxvGgxQ4pqIg6G5m_WebiD5WW5jYLXd0Yg>
    <xmx:Ydb5aLFYe3KJgSKYXhoJbVKZT8KwmissGTQ6lURuBwakQqqa5chUXA>
    <xmx:Ydb5aGSp_zRwFTqtexIDMAaAuMgDrajxPmjl8do4hcT-6pPFR_t9prkx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c892c8a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:19 +0200
Subject: [PATCH v4 10/14] refs: drop infrastructure to peel via iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-10-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
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
2.51.1.930.gacf6e81ea2.dirty

