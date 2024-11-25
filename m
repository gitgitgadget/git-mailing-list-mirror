Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FA4188012
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516056; cv=none; b=PV23UrmUekU2voa1qHZagmoXVFYfW2b/sMWHslVLFvvk3DY+IUv4aKNFvh5wSoSyNzta+UFber/V1/z/GCjq2GV4mBYk6jqrpTVva0xbjiExq0jt6IBHmTJRjbTdaz5n+ObTIBQGBlKmfJ/BpfiWuzggKvEbz695f29LCzx6r5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516056; c=relaxed/simple;
	bh=MfsSQRH2fqZgDR30/3PGSsU8NJjIxRnpqo5jWHdD880=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3USOcBTPJLHjkiy3/sgq6LWwJ/XBZ2rcTJWbl0qUvUgPyZ/sB8M2HJ/dYfQ7V4K77Er05GRLdeM96GKDr58ct5s8On2NMd8mP8QDU9uq55Bx7CnqFbDohP++3V1yGCNTZEuy+cAKMiLj4avaW4uQHxBU/dp2LeHqDvH7YUQQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mNqkjanR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QcYmjHWu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mNqkjanR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcYmjHWu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 755F11140108;
	Mon, 25 Nov 2024 01:27:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 01:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732516052;
	 x=1732602452; bh=nbgnLbBXaRLAZoV4R4SapjuK++qP4UT8EXLHh55+3zM=; b=
	mNqkjanRGbSHe1NHmwtUDBMnw85r99bPYZECYcXkKlYWip9ggh2hQvZkuyEiblNb
	QKRXH/Od5ueltcM62p7KqUeSACxiGnDrc6XG3oU7ivSgq25/6PO22wgrAy7jZTmw
	JSYh6Wux5YYpbIZeCJxDjybHGzgMIUMCs0B55lOgapFXaFbIHtMFP/5E22BPBcMl
	JxNjQFpqEnqqLO0ZXw1WM/P7Pf+FMLPLz2h82JVxYVYgOFD+nAjOFbvyrbnTJV5L
	/Za96KjdHmSsbwunxzNCv4sgQL8yvl7BXUbsh/C8upadwLgfyTxxfbYi1l3FxfTa
	2H/mf8za6OniEQpsNMGfWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516052; x=
	1732602452; bh=nbgnLbBXaRLAZoV4R4SapjuK++qP4UT8EXLHh55+3zM=; b=Q
	cYmjHWunKDIKyagW8LPrT1Ap/sOAiHnGNPjg6fZ4q5WBNcoYWarEYwe7oFJHyVqy
	ykAyxyFmXtJ4tkLO89unPk/OZ4V2jIDCF11lxHP8JikXesXtLR53xmTjmSGlV8/K
	dVMb7frLBdIFGDg0Y6WA6hws0oydCcSMDqgigkzEHtf9+/dnRxaj+j4362K8GIpz
	44Pbg3o/aJKpzLav5WZWU6ufHoAAGidLnBFPT4Mw7tTrd3khrGCPXYbbXItetSoa
	Jl06qLk3mBgwEF9dFqN7K1lWaXcFmbb2XZ/RArduk9p1BDGbCHRxr/Vwjepf56j0
	bmS7eTKLDfnm6aQE0DDPA==
X-ME-Sender: <xms:1BhEZ4NM7aBa6RS_Ngx0JhEjOgDQYV5H4fLAX4cu5MJHxEmvsJkkCg>
    <xme:1BhEZ-9hgSJXMBg9jFAj6UcKLKujnrHk4XSdcnpUi3_h-3fVvp2JVZGIXD1vdKitH
    taiDEmzUgI8VEuuMw>
X-ME-Received: <xmr:1BhEZ_TEx3AOZsq6hDCX6dl21voEUS8EfWY1S1_GmYlOXRS5iTAXLjpMNvCgKYSPRIn7r143e5SgFqog06Wipl38u7DKQQWlEl4KnG-4H9ekXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1BhEZwuA1e0-3D8OHeDtpwvpHccYQ2epDHQ6oUY3f5RLe3GgI8h2uw>
    <xmx:1BhEZwcrWeWG42WL1MqPOnuDqXHQWaCURX6ObnlBc1MR1W9d1jXRlg>
    <xmx:1BhEZ004-gBoJlJZyMnY_YYRQlEvsRDlehrK0cBiZEp5za8JYzko9A>
    <xmx:1BhEZ0-4uFhXM7G4sBSoXvacHm3QsgAAW0hyA5hnX4fXYZ-BOvIyKw>
    <xmx:1BhEZ1Hj5WHgvM0BHniQ-72_XaEXH_R7NV5RaSfXLIa8-PGKIF4GmYxr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:27:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dbb20739 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:26:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 07:27:14 +0100
Subject: [PATCH v3 09/10] reftable/block: rename `block_writer::buf`
 variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-refs-optimize-migrations-v3-9-17bc85e33ad7@pks.im>
References: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
In-Reply-To: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Adapt the name of the `block_writer::buf` variable to instead be called
`block`. This aligns it with the existing `block_len` variable, which
tracks the length of this buffer, and is generally a bit more tied to
the actual context where this variable gets used.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 20 ++++++++++----------
 reftable/block.h |  8 ++++----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index f5b432566a6b9f171a1f1374b6c892ab0696d744..3fa36c002a0c1852790780e74a6e055161f857d9 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -70,14 +70,14 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	return 0;
 }
 
-int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
+int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
 		      uint32_t block_size, uint32_t header_off, int hash_size)
 {
-	bw->buf = buf;
+	bw->block = block;
 	bw->hash_size = hash_size;
 	bw->block_size = block_size;
 	bw->header_off = header_off;
-	bw->buf[header_off] = typ;
+	bw->block[header_off] = typ;
 	bw->next = header_off + 4;
 	bw->restart_interval = 16;
 	bw->entries = 0;
@@ -95,7 +95,7 @@ int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
 
 uint8_t block_writer_type(struct block_writer *bw)
 {
-	return bw->buf[bw->header_off];
+	return bw->block[bw->header_off];
 }
 
 /* Adds the reftable_record to the block. Returns -1 if it does not fit, 0 on
@@ -107,7 +107,7 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	struct reftable_buf last =
 		w->entries % w->restart_interval == 0 ? empty : w->last_key;
 	struct string_view out = {
-		.buf = w->buf + w->next,
+		.buf = w->block + w->next,
 		.len = w->block_size - w->next,
 	};
 
@@ -153,13 +153,13 @@ int block_writer_finish(struct block_writer *w)
 {
 	int i;
 	for (i = 0; i < w->restart_len; i++) {
-		put_be24(w->buf + w->next, w->restarts[i]);
+		put_be24(w->block + w->next, w->restarts[i]);
 		w->next += 3;
 	}
 
-	put_be16(w->buf + w->next, w->restart_len);
+	put_be16(w->block + w->next, w->restart_len);
 	w->next += 2;
-	put_be24(w->buf + 1 + w->header_off, w->next);
+	put_be24(w->block + 1 + w->header_off, w->next);
 
 	/*
 	 * Log records are stored zlib-compressed. Note that the compression
@@ -188,7 +188,7 @@ int block_writer_finish(struct block_writer *w)
 
 		w->zstream->next_out = w->compressed;
 		w->zstream->avail_out = compressed_len;
-		w->zstream->next_in = w->buf + block_header_skip;
+		w->zstream->next_in = w->block + block_header_skip;
 		w->zstream->avail_in = src_len;
 
 		/*
@@ -206,7 +206,7 @@ int block_writer_finish(struct block_writer *w)
 		 * adjust the `next` pointer to point right after the
 		 * compressed data.
 		 */
-		memcpy(w->buf + block_header_skip, w->compressed,
+		memcpy(w->block + block_header_skip, w->compressed,
 		       w->zstream->total_out);
 		w->next = w->zstream->total_out + block_header_skip;
 	}
diff --git a/reftable/block.h b/reftable/block.h
index 9a3effa513420039ee3f2834339c5082f64339d0..b3f837d612a8f0fbe98430b04e2dddaa975a15ab 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -22,7 +22,7 @@ struct block_writer {
 	unsigned char *compressed;
 	size_t compressed_cap;
 
-	uint8_t *buf;
+	uint8_t *block;
 	uint32_t block_size;
 
 	/* Offset of the global header. Nonzero in the first block only. */
@@ -43,9 +43,9 @@ struct block_writer {
 };
 
 /*
- * initializes the blockwriter to write `typ` entries, using `buf` as temporary
- * storage. `buf` is not owned by the block_writer. */
-int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
+ * initializes the blockwriter to write `typ` entries, using `block` as temporary
+ * storage. `block` is not owned by the block_writer. */
+int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
 		      uint32_t block_size, uint32_t header_off, int hash_size);
 
 /* returns the block type (eg. 'r' for ref records. */

-- 
2.47.0.274.g962d0b743d.dirty

