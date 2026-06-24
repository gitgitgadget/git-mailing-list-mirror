Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77E3AE193
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289431; cv=none; b=N0ha0QB191jJA1oXVCZH3XjLccOHB3hRz3ehZFqWg1oBjVIXWScWPH03JiZFPpF6RWotwB9wvCCJrDg1+I5BIKNhe+JoMaPO0LEv7fkWJOfqdVLgMTzZFtohFimxWluY2P3EyGSIt5fgK4fVA3y7+s5qB7J3egfL83176yMm/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289431; c=relaxed/simple;
	bh=6optbZPiTWLQPba2Gb2Ic5FaM/0u8j4RJNX1JRa6D/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luJe55jR9lS7uIteLZ7BUwcpsaVpSJBoMLFRlcrmAapLNzkAUkmAMIqGFhWUTP++cnN8uIQCVIcJb3Dv39CRuFWEX8zziHJ3Q6knb2MzTmT3+qOwigvZBOXPUpgY7uflFULv5d94yC09jGmKr/NRUgEUFKujCKfyGl+5tdQRR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c/gXv30J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eMn5d/Y3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c/gXv30J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eMn5d/Y3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 44E6B1D000D7;
	Wed, 24 Jun 2026 04:23:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 04:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289427;
	 x=1782375827; bh=tfFfHDKZPyWMql7TBmAjOF0TOjueMwE0anhaaS3HvmE=; b=
	c/gXv30JYAich1H7iRtDZBn5TVHH/moMpYPyA8QWMcIKOhHlXOIwuXXZRX8Kw+Sn
	33lszKeRSo0EPyIA/Fw4rQTAxXjgYGaOXuEl3GRZGs0+8n1ZuoOl/XCywS7JRZSp
	WnAIS5/ZWqeit1Qr33RKDEyt3bmrdtk6fVpZ5tqrPFSQ0ED5vt5uCYuyphf+fKmG
	d/khkPZYJrpJBAItzjZAZiEimiwCSUOYW1w8yYO0kH6zeWNlOETeFaowc5DGIqlF
	QFzG6Zp3JoEaCR6uDWMST81lFjG/puyHpAIyMYX2/FwsSuJqYFjyH1nGu/CBJNyY
	i06ol7k+aAwRHkUiXif7WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289427; x=
	1782375827; bh=tfFfHDKZPyWMql7TBmAjOF0TOjueMwE0anhaaS3HvmE=; b=e
	Mn5d/Y3GVsC4MI81QkS98Lxm+MXV9hIWxdMByxaVfijwEjRxauuz4X7+4oL9Gr8D
	HYjIfV5mH0UlX120qbxmi8D2AQFXLFSzOqFI4V3mEQij9KcMP7kum/i7Ja+31frw
	YkqCqwxNFAxGgQa2FTd3iNNoWRv0ACkUYJxZDO854kdas68C4K4JauoN7APr5+ac
	CJuOHH4FXe1js84PDbtcwk1nVDQNBtXHVLgkJM/q6x1h5LeR6ZinpK54f8IZWLcp
	8xZN/9qDHSOBwlhv/tH6bu1ovk6R96kKT4hqZQYk6V5/g6kV76m0PzVwkYGFDvyp
	tPRpXhU+8Fztm8XkKpCZQ==
X-ME-Sender: <xms:E5Q7arDOHBQFVO3uYurl5zyPfOTmFQQ9huvVWPweruidcoa7_yPlfg>
    <xme:E5Q7anjAyXTta0u5ln0ObkWcbWl0dAoCvD4blp2_LQbqpiuEPpD0H6vV4fGgJRuMv
    72D3A4OqXO_wmRozHzK_lcntprLyFIH4KMkeqFUVPDpSoOyMYk_>
X-ME-Received: <xmr:E5Q7akO5u6_hJGPSOINmy7PE8JvOpaKSCS7CN9w8srgjLr1pNU_hs3K7SeAI9NhX2XlUbayacUkDvYgNjkz0_HBi-RBfFfQqZ2h30kHy>
X-ME-Proxy-Cause: dmFkZTEsodp80S4Vz3sObkKy6OgCEe6EYWj434mdM5RNVDLmeX3ZiZwugAN2aW9haOmyhx
    lAuge8Tcd9RYt//i+tMpzRzXNAQjyX9KecqTSREwqNb4MKugMdsyUrhoJ5u58N2vsEt3GG
    eGioKrvcqnvt8pH8YvUuLZF8Qt3mjaIOtjbMDSQlYxKNAhY151op9N0efqX2deHdpZ+y/v
    mkZRMKGsZ8hvxQ27J3zvjq4iH23aythms9I+/0HCQB8YSZM5/xk49q01ZVeH5K1dqm3EQI
    7UdLTgv2iTahb6tN5/DLomIE+51e2oGzroxSHXF2JWj3J/UzFRzNcCLAQvF/LIS7C5WLse
    TIWuy/woRWzYH3tacdPKAR4tFVnySB3ZnpxuFiaPq6cJ44iJC2iHb5gL25tpQXMNts36D5
    W0Fw5Aq4IQ1z2UpuJhZOVSdYX/hSsSZaRCP253Kl1udvKoy+VH2OKqqs3XXBn+2gz33cov
    HJVEN7MQAg1ZGox1t3kXIYxmB9hP/UYykF/HBhz0emv9ZxD2qgBtfsEeyeOImeEYD12pFi
    od83f79G2uWiu/7FCaXwoPGO0PgBefbiwWkAbQlc4uBX0ObBYkIvcaBXm1bKqmqrtexhgf
    WErc6zoMYA6KSdYgoisiU/nykBIudTgiaXUQ0DBvkUrGsOeXMfyQSG37r+RQ
X-ME-Proxy: <xmx:E5Q7ao5c_oYsktwnWkx2_SAlCB6naPwOF4bct1__5yn_mbZHkGXqYA>
    <xmx:E5Q7ai16I2Kp619BYwuDhN9Tt4vadScHgWZB_H494W37_h20k5VL9A>
    <xmx:E5Q7apZe8-0VUzOMGqVKTACm8Vd2zfgyX4Pntq9kd8Re1Sc8kCalwQ>
    <xmx:E5Q7aqC8dhmiZmuHgdT9j11gciXyDej4nnokqatkFxMJtnE5e9vQLw>
    <xmx:E5Q7atd-zCzbffm8EnT24xrDRHmNOxEpHVXsiGno-hTQN3bUkDmWmqco>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ff0b76c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:10 +0200
Subject: [PATCH 07/11] reftable/block: fix OOB read with bogus restart
 count
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-7-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
X-Mailer: b4 0.15.2

The restart count is stored in the last two bytes of a block. We use it
without verification to compute the offset of the restart table. With a
bogus restart count that is large enough this computation underflows,
and the subsequent reads via the restart table access out-of-bounds
memory:

  ==129439==ERROR: AddressSanitizer: SEGV on unknown address 0x7d90f6dcd0ad (pc 0x55555598ce89 bp 0x7fffffff4ed0 sp 0x7fffffff4e80 T0)
  ==129439==The signal is caused by a READ memory access.
      #0 0x55555598ce89 in reftable_get_be24 ./git/build/../reftable/basics.h:125:9
      #1 0x55555598eabf in block_restart_offset ./git/build/../reftable/block.c:407:9
      #2 0x55555598e5d5 in restart_needle_less ./git/build/../reftable/block.c:431:17
      #3 0x5555559887e2 in binsearch ./git/build/../reftable/basics.c:165:13
      #4 0x55555598dfec in block_iter_seek_key ./git/build/../reftable/block.c:529:6
      #5 0x555555814517 in test_reftable_block__corrupt_restart_count ./git/build/../t/unit-tests/u-reftable-block.c:593:15
      #6 0x5555557f684e in clar_run_test ./git/build/../t/unit-tests/clar/clar.c:335:3
      #7 0x5555557f2e69 in clar_run_suite ./git/build/../t/unit-tests/clar/clar.c:431:3
      #8 0x5555557f2882 in clar_test_run ./git/build/../t/unit-tests/clar/clar.c:636:4
      #9 0x5555557f375f in clar_test ./git/build/../t/unit-tests/clar/clar.c:687:11
      #10 0x5555557fa49d in cmd_main ./git/build/../t/unit-tests/unit-test.c:62:8
      #11 0x55555584c12a in main ./git/build/../common-main.c:9:11
      #12 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b284) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #13 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b337) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #14 0x555555694c24 in _start (./git/build/t/unit-tests+0x140c24)

  ==129439==Register values:
  rax = 0x00007d90f6dcd0ad  rbx = 0x00007fffffff4f20  rcx = 0xf2f2f2f8f2f2f2f8  rdx = 0x0000000000000000
  rdi = 0x00007d90f6dcd0ad  rsi = 0x0000000000007fff  rbp = 0x00007fffffff4ed0  rsp = 0x00007fffffff4e80
   r8 = 0x0000000000000000   r9 = 0x0000000000000000  r10 = 0x0000000000000000  r11 = 0x0000000000000017
  r12 = 0x00007fffffff58e8  r13 = 0x0000000000000001  r14 = 0x00007ffff7ffd000  r15 = 0x00005555560550b0
  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV ./git/build/../reftable/basics.h:125:9 in reftable_get_be24

Verify that the restart table actually fits into the block.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                |  4 ++++
 t/unit-tests/u-reftable-block.c | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/reftable/block.c b/reftable/block.c
index 4d6b11c2e7..4d285aefd7 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -351,6 +351,10 @@ int reftable_block_init(struct reftable_block *block,
 
 	restart_count = reftable_get_be16(block->block_data.data + block_size - 2);
 	restart_off = block_size - 2 - 3 * restart_count;
+	if (restart_off < header_size + 4 || restart_off > block_size - 2) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
 
 	block->block_type = block_type;
 	block->hash_size = hash_size;
diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
index 1f35aed91a..ba410a0885 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -545,3 +545,49 @@ void test_reftable_block__corrupt_block_size(void)
 	block_writer_release(&writer);
 	reftable_buf_release(&data);
 }
+
+void test_reftable_block__corrupt_restart_count(void)
+{
+	struct reftable_block_source source = { 0 };
+	struct block_writer writer = {
+		.last_key = REFTABLE_BUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = REFTABLE_BLOCK_TYPE_REF,
+		.u.ref = {
+			.value_type = REFTABLE_REF_VAL1,
+			.refname = (char *) "refs/heads/main",
+		},
+	};
+	struct reftable_block block = { 0 };
+	struct reftable_buf data;
+	int block_size;
+
+	data.len = 1024;
+	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
+	cl_assert(data.buf != NULL);
+
+	cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF,
+				       (uint8_t *) data.buf, data.len,
+				       0, hash_size(REFTABLE_HASH_SHA1)));
+	cl_must_pass(block_writer_add(&writer, &rec));
+	block_size = block_writer_finish(&writer);
+	cl_assert(block_size > 0);
+
+	/*
+	 * Corrupt the restart count to claim a bogus number of restart points.
+	 * Note that this would only cause us to perform an out-of-bounds
+	 * access when seeking into the block, but we want to refuse such a
+	 * block outright.
+	 */
+	reftable_put_be16((uint8_t *) data.buf + block_size - 2, 0xffff);
+
+	block_source_from_buf(&source, &data);
+	cl_assert_equal_i(reftable_block_init(&block, &source, 0, 0, data.len,
+					      REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_REF),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_block_release(&block);
+	block_writer_release(&writer);
+	reftable_buf_release(&data);
+}

-- 
2.55.0.rc1.745.g43192e7977.dirty

