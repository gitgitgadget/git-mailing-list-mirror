Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168F1E1A2B
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058510; cv=none; b=MGai5sF4coOpt0Jvb5BhuNa7nH11a9hyra7Q9pKKqdZYi9s0E6SrpDuX28fIpn3pxvBUwPcwz337qnzYCEzoKo+GG6ptwqzFV7/3ApGuwv8g+wplD21fXHnSLiMk+VMWpjzx8vRPzirMgLrdLscj5nGcNgd+w5SnmIS/gPpqM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058510; c=relaxed/simple;
	bh=QE93IovdqFhq/XROpI4yDaylqc1RSWwXkh6+uD+OZr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxLe7gTkO/Nz3RjqmpPoEK4AcK8Lgo1QnkufHEfpwGeQ4Gh5/IQvng1BWJhRFKdOILK+UuOHHBM2VI95ny5x0dhhxqIIah9GkQsMUqE5w7PnwDp/bpbVpmTc2IF0AIWUu0Vp1I0us6Mt4t87RDDJW8cLGeAInEfR/89UyBUeqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B7uSZ4mp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lUwySAZU; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B7uSZ4mp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lUwySAZU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id BB5B1114016C
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 08 Nov 2024 04:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058507;
	 x=1731144907; bh=X5lppt4N0HpwWs6Ec8MWlO/QU/PMv5g7PMAZOQFF1F8=; b=
	B7uSZ4mpvxPAhHGK5iLSnaF9ysovwqPjHnSQZLN9BnYSmW2SCdozwNGXqD/OYSF8
	vO1XxAo1ltZDGHXUeuSrQXJdizF/R9Z/KkhAfmTvrMQo2Qqk7BKDZkLfq6oTvpZ6
	C6twovIRwQE6pm25TLiWzAUC2FlIpSRmmgaQMqWCVpFzEQiGr6HCn93+f7siytQG
	cDQLKev0kuVQI7S0CFAwLXqUaxrg7m0RZR3rWy2GIrzyUPCL78PzgLzV9RSBDMFW
	9ssqU7z1+rpkwFov77fiah88GOuXmNTydWJVBS9+QwJvbv3YFT5kVcFIMOc4agQd
	IPrMjjfzCJ+E+qwXdagJgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058507; x=
	1731144907; bh=X5lppt4N0HpwWs6Ec8MWlO/QU/PMv5g7PMAZOQFF1F8=; b=l
	UwySAZUcl4AbXlTn29fuqyF8fG2mqjIA3twalrAx+qk1MCpFuTEfgmicGik9qHSH
	J5ez3SMz3r0J0KKSelvF2aL36uTEO1InUHKsNuh9taIaX4Di1OA9AehbBDmImHGU
	TJrCwcJGlhiwjHbaPIvKzmJTHQSF3wBtLZHQ4qWcGyA1sF6eFs8E7hkitzQni236
	33UTpGu7jbDiTE3z/CVMJDiTZmtXNLwtOC4o/849bp2bkK8OTDAxnLfVJ96RGXWI
	huGCPhvORYl7WPqfY2LEIQGXTmozsdVxW+QcExohOPD4+1Ey2DhO5PGNGpg0tABZ
	8VaEonmvpGwEOQ0yMoYFA==
X-ME-Sender: <xms:S9stZwnuMuyKnCP65pbXih0Ev_btdA8_pOpgj3CoVPmPti4NLpIIPg>
    <xme:S9stZ_2Lzdm9FH48zBkOWyZS74fL5XgvgTmoMfuory9PkcwH15c0Iu9B4cR4_tCxv
    k0pjnTddVTLM9pwEA>
X-ME-Received: <xmr:S9stZ-pA5tLwN7JE5-NdJfuAyr3m5plDWQwr15itL5UbIzAga6e7V0XzCEnFK0E6DUWP-irtE2eh2ti3wN4bdpErhkV9Awu1OFZf2KBaPNxwug8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:S9stZ8lL97K76uuuJOKTDkghnPh_b_KVUrWlkar4NudWNZiezvd9lw>
    <xmx:S9stZ-2e8civY0XyFW4r4scB4bbJuRVrlyDnFRkWVnBhJVhcyFZXGg>
    <xmx:S9stZzs1DC2rEXnjiebby-HZOMy6G-JvF_lSe-SigBTruJ6kzUfqQA>
    <xmx:S9stZ6U9B9WQpu6XRaP-GKeDYzdOhAk8qRW_2_hKYi8XlHKS6r0MMQ>
    <xmx:S9stZz-nVpCKUQsFue-TDkjBLSMWAfSstQjCGPFPPUNEXzE4BTSEhPaw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0fd6d140 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:49 +0100
Subject: [PATCH 09/10] reftable/block: rename `block_writer::buf` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-9-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
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
2.47.0.229.g8f8d6eee53.dirty

