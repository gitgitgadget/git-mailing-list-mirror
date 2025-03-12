Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C6258CDB
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794988; cv=none; b=DtiJb2tAiJaoRx+98EwGDwkT5DHOxlulPyk912Z3S1ZU3MsL/q5msys+AmBeOY9FJ617V2Fa7c6Du3w0eygCyppa3wj5wV9LHzAM0fgfwJuFrzZ8cy65Hm6u7TNjuYLyTidoae4xz/8e0XSCaDC3AIX+RKjx1ZDzWMG86PMdSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794988; c=relaxed/simple;
	bh=jWJmG5b6aaqEzGjDMnZ6Z0GkMINs1oUh8NwnYkRCEs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f6Vo2MibGYmMFwN1XVLl8CRJX7F4ruIi9Rjy/TJ0TCFrupOrvbFVWvwjUhpyLPZptT11QmXchb+ODunMqD4ESzUYORw8NxoceQ4k/Ei1WVUKJ1zdqEDF8HVJPtnBHUSNW7YkaI9KkhoZ0sU2TbTnUsMYF/KpjSkXXZj27fUcii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XWa3oJC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0DikXhoF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XWa3oJC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0DikXhoF"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A4F202540312;
	Wed, 12 Mar 2025 11:56:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 12 Mar 2025 11:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794985;
	 x=1741881385; bh=uXhF9ndDLYF46pzv1SWMMdCFFhDN44mKIIgkHIu0E40=; b=
	XWa3oJC2qGptQNKMJd4NKVR/zgIXKMGG+yOoUTuO8KkXl3cO1AS00qjSADciOUia
	Mz7K0ze214KM+9H+ZwOHgUGdUwhkT/TBN6UWmRnKQMUbqPWbNFSZXdg46B3C4eBT
	6bzk83Q2NNIENXAvRMIuyhYaLF1MuhdW7RIuljtDcmNNXyBqRFkL7sWvg5+EpKA7
	gUKzToK2jcXuPtgTbKmnYCT4bjB+yPFEmCqZJR8c5ZwIRYcTbiXh86Kpg7NL3KuN
	Y9EJb4qxwVPrNnEnIhchA+WHX/+HWPMBuz4UCEbeI48SBlGupDi7e2VaVASXHQ1y
	UMBu7xHjPR7R2/s5zFME/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794985; x=
	1741881385; bh=uXhF9ndDLYF46pzv1SWMMdCFFhDN44mKIIgkHIu0E40=; b=0
	DikXhoFA1sdwB3oArOerATljT6wPAossvTcglDnaRvk5B9GDdySm4lLWBXdqtqn1
	/qx7SUQyg6RCo3UivuaC5VjwlmuBsB2OBrHf2/Fc3NBS6E0OFcHIK6MKj/rN6AQU
	OfVUkt4qahJ7QaBqh0hrJNUB2fUCkGHZ8Ob1uIiBk7M5KBfcmF341RnXMhQ+H94X
	xCP+8zYK2YKtGyvYKMCbTKHfeoRy56c2f+JIMBAO4m58FYa3s90j35ADKne+wGW1
	tfFVtX9dWqMz9pmyIIWMQIFz5RWG0I+Xi3Ps1T6tChMSxTVS2mkeNuiwUI3YG2QB
	JRib0pgCd/UTUQZlGQTmA==
X-ME-Sender: <xms:qa7RZySlnIzEzmyrvT2GRojNkkUNze7I_19kljUA0u7uFpFALuazwQ>
    <xme:qa7RZ3zENljIJIxF3v_aqmUkNbklXvVDDAnIGFmUGZHRmHslLIzgUQ4ud21Ywo1UD
    wwK4JJr3aKxI1RDkg>
X-ME-Received: <xmr:qa7RZ_1oiWW2o0wauyNoWkFDJUJh2xKYQTmcbf0_sMWrSjxlhDhnwh8Uc6q93wkXWUEj0B2UquV29OzCOG842tTTFf6A-p2BR2RIPmvqk7J77u0Dlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qa7RZ-Bt9CNIuCNu5-MyhdKiZUZ_l5dtyd4vuIXnoEIQvJWNtbgt8w>
    <xmx:qa7RZ7jMjbCfp4J7OwsRJchA0XbgD6UF9Y3-c5ShjyQScdvr4qCCjA>
    <xmx:qa7RZ6oW1Fy1B0pOSqAOq8gMKPLER46Nwc64Oxe-UvbJEyAfaSm1sg>
    <xmx:qa7RZ-jz_9W_RvCmU9y9bNAoUz8EgeJ_W2AcbQvX5eyt7JIFOEXBrQ>
    <xmx:qa7RZ7hlCk4g_zr19U3_SAglKWLioWNIPeVH3r6hdTZb7yf2o4KhacGU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 152a7844 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:20 +0100
Subject: [PATCH v6 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-14-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
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
2.49.0.rc2.394.gf6994c5077.dirty

