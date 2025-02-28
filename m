Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865725DD05
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734824; cv=none; b=b1gf9w8UCVUzy3OR/2lzVhyq3LQEziMHuUcCv6WLbGTEdOTZH5f90uq9RyhuBCWbhnSClLuFTBcl5RXHEsl4usIWjN8yKQzq5ytWUg0FHBHHCkO8tFJeYihqPPKe/hyII6+rA78T9n2Yh9O8e+uzTTBdczX2+uFwlfkwxdXIprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734824; c=relaxed/simple;
	bh=8el6F4q9ygAbd+gHQh9CCUrn2dg5a0yIuC1z6g8y5vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j91kh08oqaN7HVT7m4xV4usSo+ycBYQ82AtwIjfPXguE9I3apc5QZdGxGMilI1nnigTyOxVvX/WwBGg0sACzcyPwZCmPRPJrt38CurqKVapAqY4iPPTPQmH3e+2CyQweO7Ab1j/ZGY7HhLEJLEplvKeG28TgibmkutMQK9AetoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z4QJmZWh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlXfJHsh; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z4QJmZWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlXfJHsh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43A021140352;
	Fri, 28 Feb 2025 04:27:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 04:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740734821;
	 x=1740821221; bh=zyVWeLaNeZBjvcE2EFPG+GPVeX+R4GHzWnIuWr210HU=; b=
	Z4QJmZWhB8zmFFXNbWKOt+yazulKl8OWJh2eNEC1qJog11LERA1pILhd35rPxbv8
	srqF2aEUFIU/NXIc5X9aurC6/h4ALFh6tZWdbdrabU9yFj9JD5fVoWABWE8G4pw9
	wLOwiZtp8VxmWB6HJLaZFR/gYsdBhAC0S8ow/uZNLxgF5zK9a/z1XwTQNj0ZAAEl
	FmCB1srgxhn3LcU5hf7GEaWy4koPGi378PF7RHJ8+ac26o4QCpM5QRlE073Oz/Ch
	RUS2GUm8FnWnDgJo9TLx0/hQX7kRbambPCsvi9zmue09hxDwLhTOuHupHKQv307O
	I5eq8WnGCN1q0xkAnL28BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740734821; x=
	1740821221; bh=zyVWeLaNeZBjvcE2EFPG+GPVeX+R4GHzWnIuWr210HU=; b=V
	lXfJHshlo55Ft5qvbLT81yFZGvFMCznqt5Yw1T+CGD/a6C4D1VOv54FA+LDD9jy+
	eJT5EWJV2lKAmA/UuP71IBkNRFdOTW6I6Rmsk01+x43jFn5myQLu/Z1oFFjnigkN
	Wey9cfpRESzH2DD97S9yaddQy0MgtkEo2Xky7DDKFIWBs1RLhJV2Xk9cbQCJX3ol
	aN9NCiiXgM6NtDqc5nbvEpTgeyuRqd/Oaw5CfpxMf3B0uqT9ucTChyQNBU9VIqyl
	kozXkwWX2LDvwfZyaWAvklzMhOsVBncagZaNlyiSUdp8Z+5oMtDIz2GuwaEUB17v
	0S5W5FyIRtn0NAK3sJmxw==
X-ME-Sender: <xms:ZIHBZyZaCD5ihxCmhjggNjGntt65ZDtVelnZ8S82Fo2rbTnYho2ZUQ>
    <xme:ZIHBZ1aiikEuXnUCSCWV1fF6tyMUu0ufwdtDb-dYJx7RHRdYsp6FgCUNDc8OHxUcn
    UkxRc6nDKaSE-Y9Yw>
X-ME-Received: <xmr:ZIHBZ8-6iKhGvF3wvwDT1DPxDndPXqG7aBMPYl55MzkwvZTYWqmeJtbfMojHLx_xbmGp67Mrs9_8ykKNS_wLOV2R-qO4YUYw7Bq2lO3CHky_JR82>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZIHBZ0rwxJdtRX7g1de5RSIeKmROHIKsOToD6l3sY3sLZtcnkeOFmA>
    <xmx:ZIHBZ9qPOHvx2-hnHMZRxvTbm9pVd73GNEsWAtPWLUtQEY2KOzKCYA>
    <xmx:ZIHBZyS4MXLw3gJNoiamBe_zNe5dX25tP7CHrbK2daGgvyHNxSyATQ>
    <xmx:ZIHBZ9pQabbyb0EQOeBcGIGQGLMXeWyeE-647W1AcTUGUbeK08SwXg>
    <xmx:ZYHBZxJu2XoXC5zrJCI-DUP2yFuLymtBxK1ZBS1LuQ66FaM0NwNrrxxj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 04:26:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9be23070 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 09:26:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 28 Feb 2025 10:26:51 +0100
Subject: [PATCH v4 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-pks-update-ref-optimization-v4-14-6425c04268b5@pks.im>
References: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
In-Reply-To: <20250228-pks-update-ref-optimization-v4-0-6425c04268b5@pks.im>
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
2.49.0.rc0.375.gae4b89d849.dirty

