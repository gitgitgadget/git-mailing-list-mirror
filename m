Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60679225769
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828348; cv=none; b=lWeQh1GOeFxhXT92BLTFVmXpufNK6xMgWrHYaJr7IYO8I7pyfSdS5HhMXcnNexU8YTdHHLzVUjgFNBJi4lUBwz+LNUhw0w/IUzlt9JlW4B1ou64gWaO+PSSii+5vTzFMw1DYRXd8RgAFqnQWq8DVQDr4lsSOK4/P97g0Le7A0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828348; c=relaxed/simple;
	bh=x2mGm07+izREe8Y0rddoQtlUiQhuo+VxiYb4e+FX7Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MvoQYWJ2WXECIcjvC/MkdktDbsHCpltqZHhUr1GIrTYs3TcQWH9GJRJ0TSLLYEO2JgGaU5gN01FwesMu+tFPmtD36PNheEgwV0hHviQmJsTRWSDT4C35X7UV36SbMuiOEI151Cr0KUcYu8nzX2N+jhshkzAkISYNxZxnLpQ6naI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nSCsOA8h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4sc/1Rj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nSCsOA8h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4sc/1Rj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 42680114015E;
	Thu,  6 Feb 2025 02:52:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 02:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828345;
	 x=1738914745; bh=TyhVGiG6cUdrBF7vCZTrX0L7pOhpAOfn6lX/mnSvmW4=; b=
	nSCsOA8hoee9V745Ygjyz1vJC/xkBNA4VUin3p8Ag4QDZRAEfaZN54FbINqY4YX5
	h0m2WXipWrS2z26H2jJtxZeE06EduPpdK6eDKl9RzwpQ49Jz8RDUXqJYqCcJKkYR
	pmXDRCd7rKVjbHiWUZzrXhlIAhxjSrC8tl5yKDT0ySkKAr1FoGwB3uxabpVyR3dQ
	FHiX91UEu+RdzkaUOI9MjgwxzxOoeDyc3oFyzf4u9F1oNMgP6PZyll6kavr0nle3
	i4BJQ5IWHzczdH2H5YLqhNr0dAT2HI6Jo/EsUvzBJMYLI9ahNeFsWThiYhwgqIBO
	9OjGhSvXkIdAmlrt6e3LUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828345; x=
	1738914745; bh=TyhVGiG6cUdrBF7vCZTrX0L7pOhpAOfn6lX/mnSvmW4=; b=c
	4sc/1RjKpFA+nPG5FNWQqfWBCU7GBb4Jk/vsKawJF54As5Qvper4aITPhafp2exq
	YKOxf6jeyEfsWlj6isf7ykH934lCfzzUGD3hU/eS93bxKnwkPJdSe2uv50/uyBXu
	CcXx2rWFndpJwF3cqBQxUmr0Lp8n0xu0O0Vf8USASx/HFMrdnrfbIDmFBGnLZP/F
	xN9BpSAORu7ADkOEzN0vzMVfIVg2ki2QE2JbZU8QALipf8jXOGIw7zrOK62bLDLO
	y8tYKZekW81PNoqUYuY0E6JoTCosufdawKUlUdUwVBhI2KsaIT/l1J+fBpC0AhY6
	Gn8wdUgY0qdgR6H+U/4Sw==
X-ME-Sender: <xms:OWqkZyEomBN9cSYnDMM0R-aWfYEGU8HimGmEiHpXBtbdt-d6s23ToA>
    <xme:OWqkZzXYOPCfLz41uIlIhK6ZrPdIspptyjM-VdVMDkKExkPPbqifghFDzSeiYmM4y
    Szi8RM8tuo7QoehDA>
X-ME-Received: <xmr:OWqkZ8IEsJivcQ_4Ww59QqHaDHqeA4MnNR__pHBswM4t__nlI-Pz5zjoDetQUN_kDixXBtA9-mn0SrjhhG2j6WIJn0HcOaL2az-4wNndbCl3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfefieevffduhfejvdevfffhudekhfdvkeevveeg
    ueeiteetveeglefghfevtdfgnecuffhomhgrihhnpehuphgurghtvgdrthiinecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    eitheskhgusghgrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhn
    segvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:OWqkZ8G-8wqHFCYsOdjgVo8Hg0-wtTiA-W6vbPfX7bDk1vJwyOqaUQ>
    <xmx:OWqkZ4ViWRtV2M65cQFk8JpF-9Q9-fMlCj6qfLtDb2SaEywgnOHGXg>
    <xmx:OWqkZ_MMFZ1hC-DkE90nGLi118FWOul3t1DmDzxH_EKg7RrjYNK1UA>
    <xmx:OWqkZ_1mOuhhygoVP_bMM8Atq2ti98RkaXrxPL30VPEu-rIAzG1icQ>
    <xmx:OWqkZyfEcw8pPHLKtFgpfSNafaH8H0Sepb31WYzmOPiuDfWlnYDSNbqj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25456b5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:11 +0100
Subject: [PATCH v4 09/18] reftable/basics: provide wrappers for big endian
 conversion
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-9-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

We're using a mixture of big endian conversion functions provided by
both the reftable library, but also by the Git codebase. Refactor the
code so that we exclusively use reftable-provided wrappers in order to
untangle us from the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                | 19 ----------
 reftable/basics.h                | 76 ++++++++++++++++++++++++++++++++++++++--
 reftable/block.c                 | 12 +++----
 reftable/reader.c                | 22 ++++++------
 reftable/record.c                |  8 ++---
 reftable/writer.c                | 20 +++++------
 t/unit-tests/t-reftable-basics.c | 28 ++++++++++++---
 7 files changed, 127 insertions(+), 58 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 3b5ea27bbd..8c4a4433e4 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -147,25 +147,6 @@ char *reftable_buf_detach(struct reftable_buf *buf)
 	return result;
 }
 
-void put_be24(uint8_t *out, uint32_t i)
-{
-	out[0] = (uint8_t)((i >> 16) & 0xff);
-	out[1] = (uint8_t)((i >> 8) & 0xff);
-	out[2] = (uint8_t)(i & 0xff);
-}
-
-uint32_t get_be24(uint8_t *in)
-{
-	return (uint32_t)(in[0]) << 16 | (uint32_t)(in[1]) << 8 |
-	       (uint32_t)(in[2]);
-}
-
-void put_be16(uint8_t *out, uint16_t i)
-{
-	out[0] = (uint8_t)((i >> 8) & 0xff);
-	out[1] = (uint8_t)(i & 0xff);
-}
-
 size_t binsearch(size_t sz, int (*f)(size_t k, void *args), void *args)
 {
 	size_t lo = 0;
diff --git a/reftable/basics.h b/reftable/basics.h
index 646f8d67f2..c1ddbaec3f 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -76,9 +76,79 @@ char *reftable_buf_detach(struct reftable_buf *buf);
 
 /* Bigendian en/decoding of integers */
 
-void put_be24(uint8_t *out, uint32_t i);
-uint32_t get_be24(uint8_t *in);
-void put_be16(uint8_t *out, uint16_t i);
+static inline void reftable_put_be16(void *out, uint16_t i)
+{
+	unsigned char *p = out;
+	p[0] = (uint8_t)((i >> 8) & 0xff);
+	p[1] = (uint8_t)((i >> 0) & 0xff);
+}
+
+static inline void reftable_put_be24(void *out, uint32_t i)
+{
+	unsigned char *p = out;
+	p[0] = (uint8_t)((i >> 16) & 0xff);
+	p[1] = (uint8_t)((i >>  8) & 0xff);
+	p[2] = (uint8_t)((i >>  0) & 0xff);
+}
+
+static inline void reftable_put_be32(void *out, uint32_t i)
+{
+	unsigned char *p = out;
+	p[0] = (uint8_t)((i >> 24) & 0xff);
+	p[1] = (uint8_t)((i >> 16) & 0xff);
+	p[2] = (uint8_t)((i >>  8) & 0xff);
+	p[3] = (uint8_t)((i >>  0) & 0xff);
+}
+
+static inline void reftable_put_be64(void *out, uint64_t i)
+{
+	unsigned char *p = out;
+	p[0] = (uint8_t)((i >> 56) & 0xff);
+	p[1] = (uint8_t)((i >> 48) & 0xff);
+	p[2] = (uint8_t)((i >> 40) & 0xff);
+	p[3] = (uint8_t)((i >> 32) & 0xff);
+	p[4] = (uint8_t)((i >> 24) & 0xff);
+	p[5] = (uint8_t)((i >> 16) & 0xff);
+	p[6] = (uint8_t)((i >>  8) & 0xff);
+	p[7] = (uint8_t)((i >>  0) & 0xff);
+}
+
+static inline uint16_t reftable_get_be16(const void *in)
+{
+	const unsigned char *p = in;
+	return (uint16_t)(p[0]) << 8 |
+	       (uint16_t)(p[1]) << 0;
+}
+
+static inline uint32_t reftable_get_be24(const void *in)
+{
+	const unsigned char *p = in;
+	return (uint32_t)(p[0]) << 16 |
+	       (uint32_t)(p[1]) << 8 |
+	       (uint32_t)(p[2]) << 0;
+}
+
+static inline uint32_t reftable_get_be32(const void *in)
+{
+	const unsigned char *p = in;
+	return (uint32_t)(p[0]) << 24 |
+	       (uint32_t)(p[1]) << 16 |
+	       (uint32_t)(p[2]) <<  8|
+	       (uint32_t)(p[3]) <<  0;
+}
+
+static inline uint64_t reftable_get_be64(const void *in)
+{
+	const unsigned char *p = in;
+	return (uint64_t)(p[0]) << 56 |
+	       (uint64_t)(p[1]) << 48 |
+	       (uint64_t)(p[2]) << 40 |
+	       (uint64_t)(p[3]) << 32 |
+	       (uint64_t)(p[4]) << 24 |
+	       (uint64_t)(p[5]) << 16 |
+	       (uint64_t)(p[6]) <<  8 |
+	       (uint64_t)(p[7]) <<  0;
+}
 
 /*
  * find smallest index i in [0, sz) at which `f(i) > 0`, assuming that f is
diff --git a/reftable/block.c b/reftable/block.c
index 255d566854..373908807e 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -148,13 +148,13 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 int block_writer_finish(struct block_writer *w)
 {
 	for (uint32_t i = 0; i < w->restart_len; i++) {
-		put_be24(w->block + w->next, w->restarts[i]);
+		reftable_put_be24(w->block + w->next, w->restarts[i]);
 		w->next += 3;
 	}
 
-	put_be16(w->block + w->next, w->restart_len);
+	reftable_put_be16(w->block + w->next, w->restart_len);
 	w->next += 2;
-	put_be24(w->block + 1 + w->header_off, w->next);
+	reftable_put_be24(w->block + 1 + w->header_off, w->next);
 
 	/*
 	 * Log records are stored zlib-compressed. Note that the compression
@@ -216,7 +216,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 {
 	uint32_t full_block_size = table_block_size;
 	uint8_t typ = block->data[header_off];
-	uint32_t sz = get_be24(block->data + header_off + 1);
+	uint32_t sz = reftable_get_be24(block->data + header_off + 1);
 	int err = 0;
 	uint16_t restart_count = 0;
 	uint32_t restart_start = 0;
@@ -300,7 +300,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		full_block_size = sz;
 	}
 
-	restart_count = get_be16(block->data + sz - 2);
+	restart_count = reftable_get_be16(block->data + sz - 2);
 	restart_start = sz - 2 - 3 * restart_count;
 	restart_bytes = block->data + restart_start;
 
@@ -355,7 +355,7 @@ int block_reader_first_key(const struct block_reader *br, struct reftable_buf *k
 
 static uint32_t block_reader_restart_offset(const struct block_reader *br, size_t idx)
 {
-	return get_be24(br->restart_bytes + 3 * idx);
+	return reftable_get_be24(br->restart_bytes + 3 * idx);
 }
 
 void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
diff --git a/reftable/reader.c b/reftable/reader.c
index 36a5633ede..bf07a0a586 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -101,18 +101,18 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	}
 
 	f++;
-	r->block_size = get_be24(f);
+	r->block_size = reftable_get_be24(f);
 
 	f += 3;
-	r->min_update_index = get_be64(f);
+	r->min_update_index = reftable_get_be64(f);
 	f += 8;
-	r->max_update_index = get_be64(f);
+	r->max_update_index = reftable_get_be64(f);
 	f += 8;
 
 	if (r->version == 1) {
 		r->hash_id = REFTABLE_HASH_SHA1;
 	} else {
-		switch (get_be32(f)) {
+		switch (reftable_get_be32(f)) {
 		case REFTABLE_FORMAT_ID_SHA1:
 			r->hash_id = REFTABLE_HASH_SHA1;
 			break;
@@ -127,24 +127,24 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 		f += 4;
 	}
 
-	r->ref_offsets.index_offset = get_be64(f);
+	r->ref_offsets.index_offset = reftable_get_be64(f);
 	f += 8;
 
-	r->obj_offsets.offset = get_be64(f);
+	r->obj_offsets.offset = reftable_get_be64(f);
 	f += 8;
 
 	r->object_id_len = r->obj_offsets.offset & ((1 << 5) - 1);
 	r->obj_offsets.offset >>= 5;
 
-	r->obj_offsets.index_offset = get_be64(f);
+	r->obj_offsets.index_offset = reftable_get_be64(f);
 	f += 8;
-	r->log_offsets.offset = get_be64(f);
+	r->log_offsets.offset = reftable_get_be64(f);
 	f += 8;
-	r->log_offsets.index_offset = get_be64(f);
+	r->log_offsets.index_offset = reftable_get_be64(f);
 	f += 8;
 
 	computed_crc = crc32(0, footer, f - footer);
-	file_crc = get_be32(f);
+	file_crc = reftable_get_be32(f);
 	f += 4;
 	if (computed_crc != file_crc) {
 		err = REFTABLE_FORMAT_ERROR;
@@ -214,7 +214,7 @@ static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t off,
 
 	*typ = data[0];
 	if (reftable_is_block_type(*typ)) {
-		result = get_be24(data + 1);
+		result = reftable_get_be24(data + 1);
 	}
 	return result;
 }
diff --git a/reftable/record.c b/reftable/record.c
index b39d99fcc7..3552bafa99 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -689,7 +689,7 @@ static int reftable_log_record_key(const void *r, struct reftable_buf *dest)
 		return err;
 
 	ts = (~ts) - rec->update_index;
-	put_be64(&i64[0], ts);
+	reftable_put_be64(&i64[0], ts);
 
 	err = reftable_buf_add(dest, i64, sizeof(i64));
 	if (err < 0)
@@ -814,7 +814,7 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 	if (s.len < 2)
 		return -1;
 
-	put_be16(s.buf, r->value.update.tz_offset);
+	reftable_put_be16(s.buf, r->value.update.tz_offset);
 	string_view_consume(&s, 2);
 
 	n = encode_string(
@@ -846,7 +846,7 @@ static int reftable_log_record_decode(void *rec, struct reftable_buf key,
 	}
 
 	memcpy(r->refname, key.buf, key.len - 8);
-	ts = get_be64(key.buf + key.len - 8);
+	ts = reftable_get_be64((unsigned char *)key.buf + key.len - 8);
 
 	r->update_index = (~max) - ts;
 
@@ -937,7 +937,7 @@ static int reftable_log_record_decode(void *rec, struct reftable_buf key,
 		goto done;
 	}
 
-	r->value.update.tz_offset = get_be16(in.buf);
+	r->value.update.tz_offset = reftable_get_be16(in.buf);
 	string_view_consume(&in, 2);
 
 	n = decode_string(scratch, in);
diff --git a/reftable/writer.c b/reftable/writer.c
index 155863ee5f..5961698311 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -99,9 +99,9 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 
 	dest[4] = writer_version(w);
 
-	put_be24(dest + 5, w->opts.block_size);
-	put_be64(dest + 8, w->min_update_index);
-	put_be64(dest + 16, w->max_update_index);
+	reftable_put_be24(dest + 5, w->opts.block_size);
+	reftable_put_be64(dest + 8, w->min_update_index);
+	reftable_put_be64(dest + 16, w->max_update_index);
 	if (writer_version(w) == 2) {
 		uint32_t hash_id;
 
@@ -116,7 +116,7 @@ static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
 			return -1;
 		}
 
-		put_be32(dest + 24, hash_id);
+		reftable_put_be32(dest + 24, hash_id);
 	}
 
 	return header_size(writer_version(w));
@@ -717,19 +717,19 @@ int reftable_writer_close(struct reftable_writer *w)
 	}
 
 	p += writer_write_header(w, footer);
-	put_be64(p, w->stats.ref_stats.index_offset);
+	reftable_put_be64(p, w->stats.ref_stats.index_offset);
 	p += 8;
-	put_be64(p, (w->stats.obj_stats.offset) << 5 | w->stats.object_id_len);
+	reftable_put_be64(p, (w->stats.obj_stats.offset) << 5 | w->stats.object_id_len);
 	p += 8;
-	put_be64(p, w->stats.obj_stats.index_offset);
+	reftable_put_be64(p, w->stats.obj_stats.index_offset);
 	p += 8;
 
-	put_be64(p, w->stats.log_stats.offset);
+	reftable_put_be64(p, w->stats.log_stats.offset);
 	p += 8;
-	put_be64(p, w->stats.log_stats.index_offset);
+	reftable_put_be64(p, w->stats.log_stats.index_offset);
 	p += 8;
 
-	put_be32(p, crc32(0, footer, p - footer));
+	reftable_put_be32(p, crc32(0, footer, p - footer));
 	p += 4;
 
 	err = w->flush(w->write_arg);
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 9ba7eb05ad..c9e751e49e 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -128,12 +128,30 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 		reftable_buf_release(&b);
 	}
 
-	if_test ("put_be24 and get_be24 work") {
+	if_test ("reftable_put_be64 and reftable_get_be64 work") {
+		uint64_t in = 0x1122334455667788;
+		uint8_t dest[8];
+		uint64_t out;
+		reftable_put_be64(dest, in);
+		out = reftable_get_be64(dest);
+		check_int(in, ==, out);
+	}
+
+	if_test ("reftable_put_be32 and reftable_get_be32 work") {
+		uint32_t in = 0x11223344;
+		uint8_t dest[4];
+		uint32_t out;
+		reftable_put_be32(dest, in);
+		out = reftable_get_be32(dest);
+		check_int(in, ==, out);
+	}
+
+	if_test ("reftable_put_be24 and reftable_get_be24 work") {
 		uint32_t in = 0x112233;
 		uint8_t dest[3];
 		uint32_t out;
-		put_be24(dest, in);
-		out = get_be24(dest);
+		reftable_put_be24(dest, in);
+		out = reftable_get_be24(dest);
 		check_int(in, ==, out);
 	}
 
@@ -141,8 +159,8 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 		uint32_t in = 0xfef1;
 		uint8_t dest[3];
 		uint32_t out;
-		put_be16(dest, in);
-		out = get_be16(dest);
+		reftable_put_be16(dest, in);
+		out = reftable_get_be16(dest);
 		check_int(in, ==, out);
 	}
 

-- 
2.48.1.538.gc4cfc42d60.dirty

