Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399C1EB1B8
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739971433; cv=none; b=GJxvwhLM1enxrkqYiDkbuVP8QolaWxDV/fWqg90AMw+yLQgzZwBGdsc1qaKTVFAjNiYJbuuf71z7brfZ1W5vibWIhdLVuxXyDYPnGS5jr07Qjn2HsiWbSE7jS5OFJ4DIVXvekVwMJug8QC1USVDmbIsIueObvv7Xn/e9twkaZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739971433; c=relaxed/simple;
	bh=pVuwunyLRtPxnmWlISEl9FfLyvP4016D1topcb8rvpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNotycxLBQi5GSlauEg1KSKud08akQuPTbF1L1288wv+/I8IseMl16xoUVC/QgVM2d3SYyUB+3+xKkx/0zigk7ggihGCE//QNwVmHi9/OcfS/cLiDginDCmY35JAVlaDO6Lma67Hzje5CI81WbH0EEDAdb1CNBEPiO4GTQEUPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y/aOStQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WGFbqYSk; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y/aOStQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGFbqYSk"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7368425401DF;
	Wed, 19 Feb 2025 08:23:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 19 Feb 2025 08:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739971430;
	 x=1740057830; bh=0N76+0RZDr/sUInfK1NGEHla/G2IxTyHziAT00c6lvE=; b=
	Y/aOStQLikbKks+1ijn9EyHLKBV8O9EkbqtuDU/6UN0ph9K3/TxA5xUKfEtmil+X
	9F5SdsdN+QzMZblljcEn59VGJGi72ciUeHOS3PIWj/ITASdEQQOIzTwVENBqPs6B
	V4wNDO/9lLkDNQxuC/HvLWZz9KKli0CVw/wjGjmWPcPVJzItKhymWOSKx3VFsI1N
	ZbMhyEK6A66bpQpnEGU6eTTRy7XCdihBqk6iA9i3ehiUKKtlpt6C3Xqm5C417s2O
	KkbuGoAmRQqp6+eQoNuSNH0oZfqM7+sql8QbjmRT3jNiQRduVERb9vZ7CyBFfhqO
	rJJvrNsFdhISHguyQPr0qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739971430; x=
	1740057830; bh=0N76+0RZDr/sUInfK1NGEHla/G2IxTyHziAT00c6lvE=; b=W
	GFbqYSkzcPTx51MpwJ4xBKuAuNX3RFpzc/NrZKk3hQB1IJ/F2o8MrMWlpVj4Wzsr
	Nz1nkma2CV+4TsapEMZZHYQAF7IQiWYPGJ005qSxMqpKr8UMlHeFjPtQfZ0TBPqn
	sCO51FIB6MlmaepEClkgg22fduDKI81+XQFHOavbnTesZbQbDgP0YIiyC5eg7n3Y
	zPJlNr7ylvZiH/zkVIQ3ov5S3j6T00BWipQRJM+/agVfEd41b1c6VqzUdMffVr3i
	8xYj3BkDhoT9Aw8hnSCpgN1TuFn6TvMSboSAhX6S5r8msyt9WR9Gc3/Kc5a9yI5S
	2Ah3mn1dr6BBRcFhzMd7A==
X-ME-Sender: <xms:Ztu1Z21hbkzQjLMpP63DsjTleQ78t746z7r4B2GsOPi6hjrMLa-9BA>
    <xme:Ztu1Z5GF-VQhgB8Lsdpt493XVb5LXpeAeobTJPTz87BvN4PHdv1VEgNc92VZ4utq5
    _oPeWc4Gm_6Cqpaog>
X-ME-Received: <xmr:Ztu1Z-58SjO1SAZ5x28NFH5INP7SzNQbr1CFgTxjG380vKKk_byxC93i7GTkUwiJJKFqRQ9C8Bkm-ol2TsJnge15Qrpd7jwflUH8UIjS5eTeYxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgt
    ohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:Ztu1Z31xQJdCCI9IeJhV2tAAnnJlXWsn5fXOgGumBCUQRkFrCfT43A>
    <xmx:Ztu1Z5Fk5o03Gpk2-RbR3DFYD52uguhIsO7lINXhJ5AD7M91c2xsbQ>
    <xmx:Ztu1Zw-0BV7mTWrn72vDnHluwmTNuVFt3oUzYgnT3YXJr9kSr2u6zA>
    <xmx:Ztu1Z-m1pJqAwPqyFzyvTLbBa4Uj2HdcPTKzepq0AaW2SsMT3qFaqw>
    <xmx:Ztu1Zw2Wg14MjcHkkICMauL5wMEV-9Kgk6eoJmXJjACIecDJIQmpCYc9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:23:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46bb5091 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:23:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:23:41 +0100
Subject: [PATCH v2 14/16] refs/iterator: implement seeking for `packed-ref`
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-pks-update-ref-optimization-v2-14-e696e7220b22@pks.im>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
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
2.48.1.683.gf705b3209c.dirty

