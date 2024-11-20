Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A161D18D63E
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089116; cv=none; b=Lk0WCsAKpyVWIfJHkbsdUArA3lK5LgLvwzWgkocEGpyKgVr1u+cNnA3WAZ23G/ldUDGbFKsQFuQO1f5zd5Oltrra2LkQrrhGQXOaAPsTa87Lx4cPqBowzIB1zwhDlpiKeHQVB8cUwljWa00KerxXpwzAJYNl+i8D6V3gUg30Nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089116; c=relaxed/simple;
	bh=MfsSQRH2fqZgDR30/3PGSsU8NJjIxRnpqo5jWHdD880=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nsMUz0IClMV8cUDIkr8qAQehX/mL1TVAIODm70HMHK19GdAdK5ykt7+vI3ppvfPkdpoXxIeRsOgl/CWjEIRd6er5Aibel4uGAkHGgsRRXEsrjW2XE0Qxjdd+0XcPsYj2fYXyle4g0mVtCtpmuaTruSmM5FJ8fmxL947x5ryob+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CT/2OzwU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yeW/AjKP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CT/2OzwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yeW/AjKP"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C0E6C1380136;
	Wed, 20 Nov 2024 02:51:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 20 Nov 2024 02:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089113;
	 x=1732175513; bh=nbgnLbBXaRLAZoV4R4SapjuK++qP4UT8EXLHh55+3zM=; b=
	CT/2OzwUvEyWLf1oAtIa8+PFyzmJEHc3q2JVYTRtCHGnXrJzER472/+Tuq7dcCFR
	SHLDdEu9pnK4SDVgmz9wo1zWpe6CS9RLduAO6/9HtrZITUZg3y+FL3S7fjAjXJMP
	WvkWjcCitq7utKhvjhX/WJb6Rw9UDycdB8W1xa0UkZuI+vJ1PqDQ5D/OfO/h+p4o
	5zE/myqqB7YTK1zbcVePRnNEbPK12p7oStTMexgkoUxiCmDha6c/CJXQJLWkVUnB
	tbuA/7yM1DmHyLo7wr833KDX1MOqD3x9ZpTxaqhMKHqtDpJogwmLHaWCU37dePXg
	SEQ5bswQrlJOOnia2eyJsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089113; x=
	1732175513; bh=nbgnLbBXaRLAZoV4R4SapjuK++qP4UT8EXLHh55+3zM=; b=y
	eW/AjKPukn037PFUdcxxyMJGE75Z4bIbZAustM2SKrkqWlCXDJrjTWsn16SHnsES
	JmLTVLcVK1nZgZubTDWSkivcW781o55Mv4n4WMcQmjxoVlqn991G3bqhBLHDKHz8
	S6+Z8bKPOJeh2ji6od6aTxe68DaytWmHzDnMn1Wamf2JbZITnl0Y3CDHOjP2kDBn
	WjPAGQUAk+yChMT4/IHbL+sakyOq4KlqMgy7cgCFVea5u4Px9/Q8q/fWoQxAlvuc
	pGuBWmSUfuaiI0Smh3KhwiZ4Fw+opjcUygJftv83myerCl+e/DWQSvqhXS42Yydh
	0Zu2QQeXXiQMV/k23ljXQ==
X-ME-Sender: <xms:GZU9Z_nnUjbeMSA5ZeQ3D5KH02vNRwsB4sT76OnmCFgtxCZLECJgcw>
    <xme:GZU9Zy2XOK2xJEsAjTswVH6mAOEWb4UGsHNyyDAu7UzUs7buJWV5dHHZ5NCm80nce
    v_ZKn-x36MxOzXLiQ>
X-ME-Received: <xmr:GZU9Z1okx_OF4lDlO9csH_Ax1J8T6j_6mEJJ6SAiRIfGU4cJl_ErA5Q8tofNxqekJmJtk42EcS0my1nydPpgJ_m8df5sHsY7Ur8pSP0xYDcZhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GZU9Z3nCTooKS9ceS2xy-LcjpuqhHo_lDjFnOOeH9tAvQmq-PPGlPA>
    <xmx:GZU9Z91HERg5ZZGe2bf96hK2nZDo-4gNwvPbzmONm1ePWNpRX8pkvA>
    <xmx:GZU9Z2vDjiw4jr2Hh7mDGV5yqqaRCiLlmxNt1lEfKkmYV0-tFplv4Q>
    <xmx:GZU9ZxXonJ-AtsGPk56pbE-ul_DKM7Bgpkx-LqbENRbZBjrtHf7yzg>
    <xmx:GZU9Z2wL5gIUJoIRnbZYXVQwKz40gwEnlIqivX4sRsQ6pqds_tJsS4_f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7abcc390 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:38 +0100
Subject: [PATCH v2 09/10] reftable/block: rename `block_writer::buf`
 variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-9-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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

