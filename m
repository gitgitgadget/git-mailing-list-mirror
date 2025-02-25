Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D926561F
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473775; cv=none; b=KNQWF8pOILTUdxQXSL7gh8BZ6VFvvMFXGBmdVwysrVP6sUhKnxxn2g3DYmDQ/YrIkFC55tN9QxGTfO7jrU9hJr08FuUEcHmIYopYDf/QEv5GlONadSrYUqX5xk3oeCYxTG/2a9TGhnXsfq6VMQtsdbxkjaY6oBSvr+oOIw0JkZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473775; c=relaxed/simple;
	bh=xiLqPWIaqHNSj04VrxsTzvS0m/OZLLm/kcehimI1QcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgqiJgM1xLhySaVoUWtt4A07ZH31mmA5kc5IgBT+JG4VijXWq4LOX+2ilCrjRrbmuEBuD4W0KyPYoJhcz+0oWeLwp3pF3Cyaru10P2xvXkD/aJf6Er8L8cOn9pU8ksXN88mawfTTkzNyoKOZFRpFixiJoYQJ2A3DGgqaEuiNw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YohfjNbU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knwOKM8m; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YohfjNbU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knwOKM8m"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6743911400EA;
	Tue, 25 Feb 2025 03:56:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 03:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473772;
	 x=1740560172; bh=YZ7if7QQEszNuQdaoGxG8wdNHKpN+aco8cKV+QQo/C0=; b=
	YohfjNbU7s/5H/vrLjPutat7XAxoV2WoT7ewCEm+Y3f947Jnu2ONJoIrdNuQ/1XB
	DetNbLJk7h6gH6BborqwPkSTKCH18l2qmmZt34iBpeWkWbTyX09P4+Nssfl8PVmW
	9NtUmAJt9H6cQBqICaUWdbQBAWio0lmFExQVKVkv7jO7MA57J236gQeB7Dmpkm2l
	pYCG5o0DiwxjH4rWg+E54qUE41yrr8ZaK3IPHPPQUT5esPb6Zpj+FPNOywK4OT5a
	C40fbevgOdx1tQK9AMamlPttVUIwyiRdBBPgaaktUHSTj5X2JZPm/DmA0XPS8F67
	beBisAWyn6wxq2XfnE6S+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473772; x=
	1740560172; bh=YZ7if7QQEszNuQdaoGxG8wdNHKpN+aco8cKV+QQo/C0=; b=k
	nwOKM8mf9b0j+Z1JsnBRLNnxQu7+rHWp+0cKIuN3aVGC5uUeHKXLQOj9N9La7tPy
	qE/4CkN40BD++9enIyQoETCig8TbFpQqOX8dK2rvxkILg2de1pFYwBzlDPFj88sR
	LmFujwWIhP96VnP6onFmdqJ0+svi+r3mKOrRobnZIEBcqiTvshG2WaHt9XWYzbk2
	iG/6hrLDT/qKBZ7JhPYylrvO+ZAGAf5LQ+WkjW1MbLmZOI5vrs291ZZqu7i2Hr+4
	OwvFR7n/nhwSMel+H+Gl8FRfH30aiOy/8eurwR5pZtLY6HCXVczLSGBNN9P8aClw
	hptJV5YoqWVNvRyhVQsug==
X-ME-Sender: <xms:q4W9Z2A5ew1wqGxmLP9VAd7XBWiUzlXj_taLkUhinGnIbOj1m1bwEg>
    <xme:q4W9ZwjKed8JGRxG3z8lHmwJWzghj_fmxjpSEkTiWF3OvP303DZp3B0nGvN6WMCXy
    TcYodR9NFtNFkW6Bw>
X-ME-Received: <xmr:q4W9Z5mNHrkWnBUL7PFjg9gPA_1ZoV0lapokHrCggCGodul0srx05oGMt-cWehL2Rn3g6H6_MjORPk6zX7rFNz5nBwh0HbN3CY4DEjMxSfnX4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghh
    rhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:q4W9Z0wsKcFi2dAzBR2dJd-Zv6TxfTRYpkXH1kh-zZcgubQhmPuxHg>
    <xmx:q4W9Z7TopzZAxWiU24O7jCWjHwa_K4ZBTZdHpXYJzifE-cgqnZ1e5A>
    <xmx:q4W9Z_ZoZj_w11E-rOTGNA8pR1jrAHcsiR55M5QYXGkX8-qGVG7qkg>
    <xmx:q4W9Z0RGTYpfH5XtLKE-RekNEAAbTGp-s4S8G9efcYbJcqGxg-QgzQ>
    <xmx:rIW9Z0TmiS8gWGIcbx_qdBvJYh3zdZLWAaRaHb14IUxNyG9hHwb97yYs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:56:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 305ccf9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:56:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Feb 2025 09:56:00 +0100
Subject: [PATCH v3 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-pks-update-ref-optimization-v3-14-77c3687cda75@pks.im>
References: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
In-Reply-To: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
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
2.48.1.683.gf705b3209c.dirty

