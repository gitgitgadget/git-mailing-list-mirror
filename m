Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39121128A
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273737; cv=none; b=s0XEDW8kZunTwBJ1IHJXtJYTfFNYEY4jGQI64N2RUMAvyk7eEAR0DoS1S0hwriKIEYZr5AdS46b3PmrpcizDaoTZLq+1qR90SZJLPyAoYY+0bcOBMewSgP3LnV7URY9/6RZTOggvuseWoAbNjw6Z6iAWwtWn1EotZ5Y7xbhL0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273737; c=relaxed/simple;
	bh=eQktM5kWYkU1TcxRbzAgYV4CH7VOl5+KWlP987rQLIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3BxvBQjN15SXM4UazW0RJnYt10fxn9XqXjW0g0yF45ZbcMeo/J94M+88T10Hw9aXPZUW58GMabdwBbd9ONLx6z6q/8DISzyxdPxK6clyw6EOFLvvIlaAr/OY5FV1vPuQGZ3z5jS7PBAznLAxDRIyDKG/BpUCOkInmfkJkiskyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YyreXh3p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CnFvrG01; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YyreXh3p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CnFvrG01"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2628311401E2;
	Thu,  6 Mar 2025 10:08:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 06 Mar 2025 10:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273735;
	 x=1741360135; bh=B2sr2MMIvTkvlsPTzK24wVsW3b7XhDVvulJDMqJOMPo=; b=
	YyreXh3pydP2nDRVzRvhRTbjL/4wizZ84e8doSnhQlWtsaxW4YiTv+2bAMWO/GDJ
	bNgunAVMtebwsSSdy/xrLqcnvL/sKZw3k9kZKt0+43cMoaiqM7P+8eeH2OhZ62OK
	D3T0Xb6+lUktCdG28fsT1l9THFWl8Waq1XeDZn+rrzANaytwfzChUuApkxrnvDW5
	DfdA/4ZMNJ/TSqSqxgJvWuMv9/dSM7jsQYydVj59GJi0UpnipNInnS40at/DQMJ7
	GiVw1Va+hy5DITr+vIKHpMGpkjG4tlMP0ojcNk786nKfSp3Zt8h+foH9ig334UxI
	gBAIu8nrOoIW6GQj1M6Yug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273735; x=
	1741360135; bh=B2sr2MMIvTkvlsPTzK24wVsW3b7XhDVvulJDMqJOMPo=; b=C
	nFvrG01N9hCbR/d/BbaX4UWz55lBTcDoF3y0toyotMckODt7MQKZa+a92aZcAh5s
	Ua4/5WyljI4jpvtry+rUXM9i0Imkh8VajHphcQiM2y7CVN2wU57C/Gafo3VKJybh
	EtX9ONl9U6PikDxgJ4slG6QbsihWtxMT/XUsa3lZGoXGtJThb6Rwp8lGUSGhDvbJ
	FX61d9On6kRvDSsQ+gkLyaRTZ6RJGdnw6BQLLYfhGYkbsL+jgHOW1GYC1I8U6B4c
	OYYoU3Z4JrweD8C8rPSWSL0E6xoWTNu26YZcE3wZ8Py3jpsjXBVqiJDDRrF1+MOW
	sdi7pDIv40NFWjfZT6uIw==
X-ME-Sender: <xms:hrrJZyJHJ_WL0-r5-R8wwXQbqAMdKL_ysoQEHGHKImZpGhBVhf35NA>
    <xme:hrrJZ6Lx7wLzFtyEzCUTI_paLZyegiu4-2ZI__o-H-vvvNPLZQjFKW5tLVD4xfwX0
    5X5KYVy8g8Zgtu8Ug>
X-ME-Received: <xmr:hrrJZyvG-QcsmGooEO8hn3WDWE_84prY3G3shxNbeOgMgzvyDrHwxNeuON5yoMxR3LIsnXOlJM_IOKfsPkzyLorjB3hrGl9-qGPMx4p0-Y4GpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hrrJZ3Zu6wvNj98W7_Jcje2lAO0y5x8Xmv63BNKbWgdFqfhrVamDnw>
    <xmx:hrrJZ5bQh_2WI4lZWzgvUgNQRscCwdTlu3pVOEGP6iX99hAITkvf4A>
    <xmx:hrrJZzAwadedvHA9_Lw70YU37Belx1e6sOlA2ZwRXC2VQdWwTo8L1A>
    <xmx:hrrJZ_Y18reU1KJRs7LEolCzASmTvnFVnQGBc_vd0xMSJBxNZGzygQ>
    <xmx:hrrJZ14ooc41ERwSvnttJibdACI4TralAaxPb146sKsvcZW1IzX7z43b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e4d51737 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:45 +0100
Subject: [PATCH v5 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-14-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of `packed-ref` iterators. The implementation is again
straight forward, except that we cannot continue to use the prefix
iterator as we would otherwise not be able to reseek the iterator
anymore in case one first asks for an empty and then for a non-empty
prefix. Instead, we open-code the logic to in `advance()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 65 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 38a1956d1a8..f4c82ba2c7d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -819,6 +819,8 @@ struct packed_ref_iterator {
 
 	struct snapshot *snapshot;
 
+	char *prefix;
+
 	/* The current position in the snapshot's buffer: */
 	const char *pos;
 
@@ -841,11 +843,9 @@ struct packed_ref_iterator {
 };
 
 /*
- * Move the iterator to the next record in the snapshot, without
- * respect for whether the record is actually required by the current
- * iteration. Adjust the fields in `iter` and return `ITER_OK` or
- * `ITER_DONE`. This function does not free the iterator in the case
- * of `ITER_DONE`.
+ * Move the iterator to the next record in the snapshot. Adjust the fields in
+ * `iter` and return `ITER_OK` or `ITER_DONE`. This function does not free the
+ * iterator in the case of `ITER_DONE`.
  */
 static int next_record(struct packed_ref_iterator *iter)
 {
@@ -942,6 +942,9 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 	int ok;
 
 	while ((ok = next_record(iter)) == ITER_OK) {
+		const char *refname = iter->base.refname;
+		const char *prefix = iter->prefix;
+
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
 		    !is_per_worktree_ref(iter->base.refname))
 			continue;
@@ -951,12 +954,41 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 					    &iter->oid, iter->flags))
 			continue;
 
+		while (prefix && *prefix) {
+			if (*refname < *prefix)
+				BUG("packed-refs backend yielded reference preceding its prefix");
+			else if (*refname > *prefix)
+				return ITER_DONE;
+			prefix++;
+			refname++;
+		}
+
 		return ITER_OK;
 	}
 
 	return ok;
 }
 
+static int packed_ref_iterator_seek(struct ref_iterator *ref_iterator,
+				    const char *prefix)
+{
+	struct packed_ref_iterator *iter =
+		(struct packed_ref_iterator *)ref_iterator;
+	const char *start;
+
+	if (prefix && *prefix)
+		start = find_reference_location(iter->snapshot, prefix, 0);
+	else
+		start = iter->snapshot->start;
+
+	free(iter->prefix);
+	iter->prefix = xstrdup_or_null(prefix);
+	iter->pos = start;
+	iter->eof = iter->snapshot->eof;
+
+	return 0;
+}
+
 static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
 				   struct object_id *peeled)
 {
@@ -979,11 +1011,13 @@ static void packed_ref_iterator_release(struct ref_iterator *ref_iterator)
 		(struct packed_ref_iterator *)ref_iterator;
 	strbuf_release(&iter->refname_buf);
 	free(iter->jump);
+	free(iter->prefix);
 	release_snapshot(iter->snapshot);
 }
 
 static struct ref_iterator_vtable packed_ref_iterator_vtable = {
 	.advance = packed_ref_iterator_advance,
+	.seek = packed_ref_iterator_seek,
 	.peel = packed_ref_iterator_peel,
 	.release = packed_ref_iterator_release,
 };
@@ -1097,7 +1131,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
 {
 	struct packed_ref_store *refs;
 	struct snapshot *snapshot;
-	const char *start;
 	struct packed_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
 	unsigned int required_flags = REF_STORE_READ;
@@ -1113,14 +1146,6 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	 */
 	snapshot = get_snapshot(refs);
 
-	if (prefix && *prefix)
-		start = find_reference_location(snapshot, prefix, 0);
-	else
-		start = snapshot->start;
-
-	if (start == snapshot->eof)
-		return empty_ref_iterator_begin();
-
 	CALLOC_ARRAY(iter, 1);
 	ref_iterator = &iter->base;
 	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable);
@@ -1130,19 +1155,15 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
 	iter->snapshot = snapshot;
 	acquire_snapshot(snapshot);
-
-	iter->pos = start;
-	iter->eof = snapshot->eof;
 	strbuf_init(&iter->refname_buf, 0);
-
 	iter->base.oid = &iter->oid;
-
 	iter->repo = ref_store->repo;
 	iter->flags = flags;
 
-	if (prefix && *prefix)
-		/* Stop iteration after we've gone *past* prefix: */
-		ref_iterator = prefix_ref_iterator_begin(ref_iterator, prefix, 0);
+	if (packed_ref_iterator_seek(&iter->base, prefix) < 0) {
+		ref_iterator_free(&iter->base);
+		return NULL;
+	}
 
 	return ref_iterator;
 }

-- 
2.49.0.rc0.416.g627208d89d.dirty

