Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9723497D
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807440; cv=none; b=neBRCkG2Xi67lghkgsmLTZlZx40oD1rNQSPzDJtdASsgYM6aAS/VZzJJkJLOSRGrFICbbBXg380WhBQbXQj4rd8jjo39KMNM4bQW4Cgre3YAEm9QEnXIukPe6CXSCqheS4U/WZiKq7VuMT04vd4CeW8A0SXPn/3f03CxFPlI168=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807440; c=relaxed/simple;
	bh=B2s7cOW4Abj29R7T+5uWGCDTTPfwBi+gHffjmiGW6B0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sfy6FOvu9MIyK5GFQUJamgNgcc9+ZKiw8gKQcLB1/J4L217xYFOxyp22dbpC55MRZ80zUVCufrBXUYY0rRmBe99arlSt4gFFk1tA8mUV3kasyW1qrcekZd8IinZ3EV1i+gOIzjWmGLctjoA5XyZETMVprS+2HpxmQ2XXvpyTrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LVF3Ihxw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cyMx5oKQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LVF3Ihxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cyMx5oKQ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB6EF254010E;
	Mon, 17 Feb 2025 10:50:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 17 Feb 2025 10:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807437;
	 x=1739893837; bh=btxvst6qh0SPVkvsX7Tu+niXZPEf35b2HvaSP+9QAgU=; b=
	LVF3IhxwYR4nnT/w2HIdDXkbsu6uSJ3Q9INRZ++fXo2VU/BB5xyc/X049LKBHFLV
	pNPFNhR35YSwPBsdYnju54wnuFJ/ujNYhhQuMJ5FQwZu7/Z59IoAC5ziA04hFKIz
	t0jLZofegl58YrP4xr5nAZ8ivBzWWYGa3hibP83K1D02pHcAnUhStRL5Yq0GR6bA
	pxTypLwJ85FmBB9WqZtD2z+tCiGJStNasLqryWxV5xFWOvdlL7oyrcXyoQMTKA/P
	TZkQN/dV6Oyez7WQT+jwjjeVOCDtwwCgWK8B3TWIKjKQwu/Zb0U6q8XcpRGkpfY0
	+dUiDrROhEMHLVodBeWmpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807437; x=
	1739893837; bh=btxvst6qh0SPVkvsX7Tu+niXZPEf35b2HvaSP+9QAgU=; b=c
	yMx5oKQSz4xBUtMUQe//fIjgWFcYsK2WTbbGbpfExjjdKeA9j5d9UKSZskni0H6R
	kKdZQBAD+AN8iazQJAODfD5zxovxAVpTDrBjSK5c9DuAQfofOj42/ju3ozqj3EYk
	JeUZxZ/1j+ckLnWBfWjEXc9SyQuMPx2or4HqPTd94SIgKej+E1MMIwe0ugkNO+jx
	YuEWN8ncLOYilgguf4jPeOn7gZDmKsa1UqZfgKmIFJ/1ARvHt7s1VAhOfrJbjpQJ
	T6OOK/4lYd7Keo4Q0OZjUsK+KGw8gB136MD3CVRy4t9bTWQdxWfkXLrouwfzSkiZ
	bFDKh12v+q2JCtGjoSSog==
X-ME-Sender: <xms:zVqzZ045qbBizFUA4oVffpKvvFgehHN7mHH8OoXmWTE7qPU0OeaZ9A>
    <xme:zVqzZ16WZwGRc6MlEroSQmM9CjaX8me9lXHMaBroEUReDyB6HZuDJs2g8ksfAVCAl
    JQOIZhWAMjQ8-1G_w>
X-ME-Received: <xmr:zVqzZzfSO8RkO0RAyY7_qEMFtiUbpNCpv_M1mTr4foI85qeYZiGZ6gWwn2DGzM5CXjrP7isOEKH6u4Vb3uobjOLURFZ6AxdeBansNj15gQoqWyk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:zVqzZ5JX7Q1r77HAu8V7JVJOe9ZIK7SBLzPJibLRwXo-QPn4im1FaQ>
    <xmx:zVqzZ4I5l739F9KlELB0bea0DpMfJCOkECGqUdPQqU3ALI63xbtDNg>
    <xmx:zVqzZ6zkzNcqSdCFcsoGTxnCtaKBJ6MxdMksfowgCTWzopndh_hQRQ>
    <xmx:zVqzZ8J23WCVjL6gDydj3o2OXT_4J9ZZvUEBUkY3PGO6z1kNcgNYAg>
    <xmx:zVqzZw-OLxDbe6zEdDVAx99FLPxPpGU4HpQHK37_8W-SFIN-RrB4wBBZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d43244d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:26 +0100
Subject: [PATCH 12/14] refs/iterator: implement seeking for `packed-ref`
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-pks-update-ref-optimization-v1-12-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Implement seeking of `packed-ref` iterators. The implementation is again
straight forward, except that we cannot continue to use the prefix
iterator as we would otherwise not be able to reseek the iterator
anymore in case one first asks for an empty and then for a non-empty
prefix. Instead, we open-code the logic to in `advance()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 62 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 38a1956d1a8..71a38acfedc 100644
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
@@ -1130,19 +1155,12 @@ static struct ref_iterator *packed_ref_iterator_begin(
 
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
+	packed_ref_iterator_seek(&iter->base, prefix);
 
 	return ref_iterator;
 }

-- 
2.48.1.666.gff9fcf71b7.dirty

