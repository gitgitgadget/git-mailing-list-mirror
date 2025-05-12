Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4B581720
	for <git@vger.kernel.org>; Mon, 12 May 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062967; cv=none; b=gTLHTGuM4Apf5cCZ3ouEsxV3+JDSzl/rmJ11H29oB1YE+ZxctQ9Yd3J+LH5v0CTX82ZkP6pogUxekpI4Pi0GXQh3P7JMLAojEfag4/3ImxfyDhntCP2ql6TX3PRjMF8vNLU0a987sWCLYSTnVNGmkcGv6+DxVBMwOfWHqqQu1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062967; c=relaxed/simple;
	bh=y+cdwWpE8t4kN1w2K5bY8H30HQoFi+6Jpq+WdxXLNdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=skY6zdq5KGYB3AAnLo34rvdXWNdPvWXVuzVIAX7BlG8ggSmd6BYjrOx85gd4Ltq6Ez1v2rzXFcMoE1GTd3GuxqrvbyPJW/b55GtHz4gkV7x92/4Vs9wC3L/9wSKe6dECcm3O3rFP1RgW8npYh3HBMx87kw1qCcTqijw6m7Skpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uG+7K67s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vFEoZc2C; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uG+7K67s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vFEoZc2C"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F797114015A
	for <git@vger.kernel.org>; Mon, 12 May 2025 11:16:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 May 2025 11:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1747062963; x=1747149363; bh=CBSP2NAuvm
	cp7Qula6pSs6XEvjlbBVxLRGFrFKROAyk=; b=uG+7K67sXvZ866EDwwASB3C90f
	qYXQR2HJf1dgzsHdZ/nycC2jwNqe+DcXVVRwebafH5uE0Yu5TbxgQPbbAlCyvaIT
	vhtzOrmqoAlT5f1VsQVyKy0S6uryeq8W7NjVU3zfNkBkSBHF2e8x/gmXL0EAdoHh
	vf0jjR3BRZpmq2kghzy1sjy4P6p/IYlVxN32bhSN4uzEIbE9hMstg6kb2mHyqxfb
	05OKfpf6Ka8g2WH97M006uRRBUxiZoYlQp9oUaJjurW3zElRDRtK0OhvLvHRXlUD
	zqBios11YnSl44dv94fprlJjFzddVxeQ09gqnqhjJNf57Xpoj93lcTDU+Gxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747062963; x=1747149363; bh=CBSP2NAuvmcp7Qula6pSs6XEvjlb
	BVxLRGFrFKROAyk=; b=vFEoZc2Cbyb0bKwO+oyoJlwISe3uqGOBltSBzvbu3Pps
	slraDH7xt/RGjFbmcOJPlWcCRwHav+deiWLVgViofGWCXSCr+2jDbDnQD3uUUrZD
	oCsnMnWHVBusiwqxAjR7UKxt3oBLR5mR+cDPmwwWZciFkNBCq+5gsi4vpZmQ2Q9r
	kcmgkUTpSw9hZWnoyBRpvpA44L7ZK/w4Mg03wWIIesWrRhlP+qy6yQuIoFWB7Owr
	CPQgHC4/ABGooPNj6RG68dQ5vRli1+3CW+L9In97Rbf4QJThEaF/s3ObSRigfvXP
	3v0NOQ7Bd24GAqb5MSnzrNvf/izzw8HKUfHHcGzocw==
X-ME-Sender: <xms:shAiaBKoksZ71wsk8EDhUtLBrVsL1gqwl03pFOwvt0enk0RlkJYY1A>
    <xme:shAiaNLX_yN6R0LrX5iTPBH-mCrVNq6BHHDeQGqKPZrhbNrZOiCn8R362tPHJvIhx
    EUHWRlmnUVdVSNCow>
X-ME-Received: <xmr:shAiaJvozThTsTW4oD7qBP0THaCnl-ZlymeoiPDSnR7R6jyNDNW9b9ldKgjfmj8Kc4vHPX04a7x7SNt-m3sOduodjnTRQ6QwZgjMwW7QnwY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdeujeekff
    ejjeduveefvdfhgfegfedttdfhueduuefhvedtuefgffektdeujeevnecuffhomhgrihhn
    pegsvghntghhvghrrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sxAiaCa4bky5_SCo-c-sgndk6x0vW88wTsjSwzoPyXrAJ64wR41TEA>
    <xmx:sxAiaIZQ4veku7zzyTrFi80KAOR4ZvzN4fua6xEmVT3xrWBBwkHLUg>
    <xmx:sxAiaGBJI9D__4KX5JWI7Az7PDf8y1eoG4uxrxqA0mZrO9lSc4EWHw>
    <xmx:sxAiaGYPEKq1X7cMYquZOcghkbFOlSFH1r7IhiHBeqv3k4qnvUkeeg>
    <xmx:sxAiaGku2hPqXOzsm3PwYkbCKE3Kj1mqwRBPZe9snv4Kv1jaUfAU0uDt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 12 May 2025 11:16:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7778c34 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 12 May 2025 15:16:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 May 2025 17:15:56 +0200
Subject: [PATCH] reftable: fix perf regression when reading blocks of
 unwanted type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-pks-reftable-perf-fix-v1-1-002cab9fdb08@pks.im>
X-B4-Tracking: v=1; b=H4sIAKsQImgC/x2MQQqAIBAAvxJ7bsHEDeor0aF0raUo0Qgh+nvSc
 WBmHkgchRP01QORb0lyHgWaugK7TsfCKK4waKVJUaMxbAkj+2uad8bA0aOXjLY1jjwZ7khBaUN
 RJP/fYXzfD8Y5YstnAAAA
X-Change-ID: 20250512-pks-reftable-perf-fix-c64d5f54e950
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In fd888311fbc (reftable/table: move reading block into block reader,
2025-04-07), we have refactored how reftable blocks are read so that
most of the logic is contained in the "block.c" subsystem itself. Most
importantly, the whole logic to read the data itself is now contained in
that subsystem.

This change caused a significant performance regression though when
reading blocks that aren't of the specific type one is searching for:

    Benchmark 1: update-ref: create 100k refs (revision = fd888311fbc~)
      Time (mean ± σ):      2.171 s ±  0.028 s    [User: 1.189 s, System: 0.977 s]
      Range (min … max):    2.117 s …  2.206 s    10 runs

    Benchmark 2: update-ref: create 100k refs (revision = fd888311fbc)
      Time (mean ± σ):      3.418 s ±  0.030 s    [User: 2.371 s, System: 1.037 s]
      Range (min … max):    3.377 s …  3.473 s    10 runs

    Summary
      update-ref: create 100k refs (revision = fd888311fbc~) ran
        1.57 ± 0.02 times faster than update-ref: create 100k refs (revision = fd888311fbc)

The root caute of the performance regression is that we changed when
exactly blocks of an uninteresting type are being discarded. Previous to
the refactoring in the mentioned commit we'd load the block data, read
its type, notice that it's not the wanted type and discard the block.
After the commit though we don't discard the block immediately, but we
fully decode it only to realize that it's not the desired type. We then
discard the block again, but have already performed a bunch of pointless
work.

Fix the regression by making `reftable_block_init()` return early in
case the block is not of the desired type. This fixes the performance
hit:

    Benchmark 1: update-ref: create 100k refs (revision = HEAD~)
      Time (mean ± σ):      2.712 s ±  0.018 s    [User: 1.990 s, System: 0.716 s]
      Range (min … max):    2.682 s …  2.741 s    10 runs

    Benchmark 2: update-ref: create 100k refs (revision = HEAD)
      Time (mean ± σ):      1.670 s ±  0.012 s    [User: 0.991 s, System: 0.676 s]
      Range (min … max):    1.652 s …  1.693 s    10 runs

    Summary
      update-ref: create 100k refs (revision = HEAD) ran
        1.62 ± 0.02 times faster than update-ref: create 100k refs (revision = HEAD~)

Note that the baseline performance is lower than in the original due to
a couple of unrelated performance improvements that have landed since
the original commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch fixes a performance regression that I have recently
introduced into the reftable library. This regression has been flagged
to us via Bencher [1], see the "Create refs atomically" benchmark.

Thanks!

Patrick

[1]: https://bencher.dev/console/projects/git/plots
---
 reftable/block.c                |  7 ++++++-
 reftable/reftable-block.h       |  3 ++-
 reftable/table.c                | 11 +----------
 t/unit-tests/t-reftable-block.c | 15 ++++++++++-----
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 471faa1642a..920b3f44867 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -227,7 +227,8 @@ static int read_block(struct reftable_block_source *source,
 int reftable_block_init(struct reftable_block *block,
 			struct reftable_block_source *source,
 			uint32_t offset, uint32_t header_size,
-			uint32_t table_block_size, uint32_t hash_size)
+			uint32_t table_block_size, uint32_t hash_size,
+			uint8_t want_type)
 {
 	uint32_t guess_block_size = table_block_size ?
 		table_block_size : DEFAULT_BLOCK_SIZE;
@@ -247,6 +248,10 @@ int reftable_block_init(struct reftable_block *block,
 		err = REFTABLE_FORMAT_ERROR;
 		goto done;
 	}
+	if (want_type != REFTABLE_BLOCK_TYPE_ANY && block_type != want_type) {
+		err = 1;
+		goto done;
+	}
 
 	block_size = reftable_get_be24(block->block_data.data + header_size + 1);
 	if (block_size > guess_block_size) {
diff --git a/reftable/reftable-block.h b/reftable/reftable-block.h
index 04c3b518c87..0b05a8f7e37 100644
--- a/reftable/reftable-block.h
+++ b/reftable/reftable-block.h
@@ -56,7 +56,8 @@ struct reftable_block {
 int reftable_block_init(struct reftable_block *b,
 			struct reftable_block_source *source,
 			uint32_t offset, uint32_t header_size,
-			uint32_t table_block_size, uint32_t hash_size);
+			uint32_t table_block_size, uint32_t hash_size,
+			uint8_t want_type);
 
 /* Release resources allocated by the block. */
 void reftable_block_release(struct reftable_block *b);
diff --git a/reftable/table.c b/reftable/table.c
index ee831276158..56362df0eda 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -173,16 +173,7 @@ int table_init_block(struct reftable_table *t, struct reftable_block *block,
 		return 1;
 
 	err = reftable_block_init(block, &t->source, next_off, header_off,
-				  t->block_size, hash_size(t->hash_id));
-	if (err < 0)
-		goto done;
-
-	if (want_typ != REFTABLE_BLOCK_TYPE_ANY && block->block_type != want_typ) {
-		err = 1;
-		goto done;
-	}
-
-done:
+				  t->block_size, hash_size(t->hash_id), want_typ);
 	if (err)
 		reftable_block_release(block);
 	return err;
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 7dbd93601c7..52f1dae1c95 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -64,7 +64,8 @@ static void t_ref_block_read_write(void)
 	block_writer_release(&bw);
 
 	block_source_from_buf(&source ,&block_data);
-	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	reftable_block_init(&block, &source, 0, header_off, block_size,
+			    REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_REF);
 
 	block_iter_init(&it, &block);
 
@@ -153,7 +154,8 @@ static void t_log_block_read_write(void)
 	block_writer_release(&bw);
 
 	block_source_from_buf(&source, &block_data);
-	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	reftable_block_init(&block, &source, 0, header_off, block_size,
+			    REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_LOG);
 
 	block_iter_init(&it, &block);
 
@@ -245,7 +247,8 @@ static void t_obj_block_read_write(void)
 	block_writer_release(&bw);
 
 	block_source_from_buf(&source, &block_data);
-	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	reftable_block_init(&block, &source, 0, header_off, block_size,
+			    REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_OBJ);
 
 	block_iter_init(&it, &block);
 
@@ -329,7 +332,8 @@ static void t_index_block_read_write(void)
 	block_writer_release(&bw);
 
 	block_source_from_buf(&source, &block_data);
-	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
+	reftable_block_init(&block, &source, 0, header_off, block_size,
+			    REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_INDEX);
 
 	block_iter_init(&it, &block);
 
@@ -411,7 +415,8 @@ static void t_block_iterator(void)
 	check_int(err, >, 0);
 
 	block_source_from_buf(&source, &data);
-	reftable_block_init(&block, &source, 0, 0, data.len, REFTABLE_HASH_SIZE_SHA1);
+	reftable_block_init(&block, &source, 0, 0, data.len,
+			    REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_REF);
 
 	err = reftable_block_init_iterator(&block, &it);
 	check_int(err, ==, 0);

---
base-commit: 7a1d2bd0a596f42a8a7a68d55577967bb454fec0
change-id: 20250512-pks-reftable-perf-fix-c64d5f54e950

