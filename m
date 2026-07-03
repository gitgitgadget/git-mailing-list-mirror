Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FF43D566E
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083554; cv=none; b=mfVgaUKZB2i8hTUB0rDNsGpS9UrVUlY40/cNh2jBpDEcLCgj03zuGmETffssji6bIHJIza3LkwHMePuPC3xcNwgWe/VOUEK4sme1q3qq9otU04A4PoCZAPtofEb86gevhW55FUBrH0rVLLsWHb3IlOViTRhdBQf2m1KO9Ry3EYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083554; c=relaxed/simple;
	bh=AKxb4kuXTUjqh7rXwW/yvkCKjb0Vcz089CRRNbejLYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEYZ1gaKWFBwNh+EnUk9xPVai53pGX3nbo7Ldu3oPeJiuMfgY2tPHvgZyfIRoIllXqQl7WLFQI4LVs50W1Vr1m5ThH0xvIIl0eEG5A8HYa75UuKGExFwLVmBznMiXcOYSq8eYkdU+u3Yb3ONUUcVhuIsSQlix4TQaSyad9VbSZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FezD9cuj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lhtgwGgG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FezD9cuj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lhtgwGgG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E32501D000B1;
	Fri,  3 Jul 2026 08:59:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 08:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083552;
	 x=1783169952; bh=miHCG1SIewM7d7XrxCBcnirXLzuBfq6jPEUgea4WVYw=; b=
	FezD9cuj6BVv3b+aknAPoDfWVKO92bDyRvl8lOKz10p2p5xwdcmEIkakyAMU/rYZ
	f5ixnoOx55wBeL9Usg7xBqXGvaN1vXryne+n3TEQ68CQGQw7W5Ez/O5/bmAk5kMp
	O31zvEfV1Epqi9MgfHATSCUxA0YzlXcrVIU7iNFE5Xw1xfpKMEoopvN1I8fvhouH
	VIRMUZVhhiOVTdykA0LmaqfN0AUGNM7HN2G64tF/oWuW1slIX8ro5a7KIdeM2k22
	nc11yirkpznnl2wQvvid7K8ebAkhJd91sSyvCzqIuZD/DKyz7XBaksdPPp+3iTe+
	Tw+72jfXHifizVhWsfrIDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083552; x=
	1783169952; bh=miHCG1SIewM7d7XrxCBcnirXLzuBfq6jPEUgea4WVYw=; b=l
	htgwGgGZhKUp7ey2MVp9wfM1+5R8dpicOdrVrH1DbH2NdCC1WQ57OZoZLxGBeWc6
	V4FtQl968g+Z3/qKKWWDxRxvFP4YQYJM2tZ3Q+0HUJoo9BZ2EcCfpFNnxLqJwy2b
	7KW5k7Yv58BYnakZpyUAeH2mNkv76Lb9KhdrN47vJZSD17mQMasEAhatyuTedUaE
	7I3DbkT3PUwRht9ZgluVw+InMVReR49T6RpU3slgWdPxyXIeVL86zlshyp7hNhUH
	JK0eGXIkxH3hm5Pg6yqleUB0rju2YUisVM/HGDsFRkk3Gs9hVeqObZY0NOuRXDG2
	H9zhv6JUAaPBePnGATDcA==
X-ME-Sender: <xms:ILJHakCnOIxR0Gu_o3nqxOfiPlEVFfkPALyb8WgCDfFjQF3FfOt4Rg>
    <xme:ILJHath2kazHsn2qZ7gd4XlW9dzW8QFwT74f6U0Olbs0p-9qcf_2Kug4Qjy0C_K2f
    GZrBPSv6zJd8qI32z3ZivP2-R0Yw6HHSvAHyk-L9V4PY_Znr-E8>
X-ME-Received: <xmr:ILJHasm3v3f3uT-3Uxa1wA771_od2LkdzSGX9VriioGZCU62eN50Ngy9TmL-WuHUhU8mZef4vXrsXIf_gFBt4lkKUJbkuKb7l-o7Bjydgw>
X-ME-Proxy-Cause: dmFkZTE9SFgySGcQg/YWKtvbDnY8RdhKr3PeZLl2XS++XqBhJitks2B0Q01z+On5uG4xiq
    BKCCtCXj+kXwHyGc25dGVksExFm60rQM25/WM/unQl7YCEvPHU0tArJM4yqeAlu5eVoeMy
    bBlFLZ1BSz0/Qrsbz1Eqs1w5jMCccQ9ybIdvngMy1ea1BBFo+K/oEOfnVjMob+RTe6VlSs
    Tn8d99YUdRnBSEtPST/gXujMm9KkGJ1UD+4Goh2Q+xEyDPBD5P6+TvFK83h+LFOQh5M8YL
    8FX7Dq0nQfXOuPjtLYqRy8J2pSc5lODSTs5VUXCJ/uGkAiTwdb4JPq2nHvssSfhztlMfMa
    3leHR8JuPYyRy8DvvI+lZ1AiaSi6ZG92xazoYxSEa8Hu/OlSUVxL/VGjN1xwTQpsL9S6b0
    A9bw/lnswznzPe19iKH319iNkQkkK8O+996td6lKWkXDzTlXq8SO7ZtmgJcz7soH82CMo3
    SLlSjcQUxf451vawrktxIfYAzxcTNAhMWliELsVaprxvEghW31BezzCaWCP57O1H2S41bd
    OLmxPyYXZZJCevBSUJSk4GJ+FJLTi2HSDM/WYVblIgNxTm0fKfYzzk9F4OyA/VfV8BHwzg
    pg7PhyLGsqaAFjc2DR+Qm4IBITuw18J6YlDstk0E5qoeBrP98tttoqC0l12g
X-ME-Proxy: <xmx:ILJHaprkK9DjYjjMEeeQRrjlLh6_2AKOrGAyO37wu2R2N6-706vSCg>
    <xmx:ILJHalHnSwkWbl2-04i3Mhup_lBlxRNCOqP9xq__fnbruMyXohTJ3g>
    <xmx:ILJHalyRZvIjib43PEhIhpxrNpp7xIBf01qEKZxPjhctdLrDKIzylQ>
    <xmx:ILJHaqqf_6wGS1k1MuqUYA-0WVcbkGUFHSxI0S6N4L3CF_uB9KfOLw>
    <xmx:ILJHas5GZLrzWZMeZI6qJEyfGjeMP1_eg06p1B16JlvkrSkMm4yeL2do>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62c83fe8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:50 +0200
Subject: [PATCH v3 07/12] reftable/block: fix OOB read with bogus block
 size
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-7-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

The block size is read from the block header, which is untrusted data.
We use it without verification to access the restart count at the end of
the block as well as to compute the restart table offset. With a bogus
block size that exceeds the data we have actually read this can lead to
an out-of-bounds read:

  ==2274138==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c3ff6de2e3f at pc 0x55555598c6ea bp 0x7fffffff4ee0 sp 0x7fffffff4ed8
  READ of size 1 at 0x7c3ff6de2e3f thread T0
      #0 0x55555598c6e9 in reftable_get_be16 /home/pks/Development/git/build/../reftable/basics.h:119:20
      #1 0x55555598c252 in reftable_block_init /home/pks/Development/git/build/../reftable/block.c:343:18
      #2 0x555555813c70 in test_reftable_block__corrupt_block_size /home/pks/Development/git/build/../t/unit-tests/u-reftable-block.c:531:20
      #3 0x5555557f684e in clar_run_test /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:335:3
      #4 0x5555557f2e69 in clar_run_suite /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:431:3
      #5 0x5555557f2882 in clar_test_run /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:636:4
      #6 0x5555557f375f in clar_test /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:687:11
      #7 0x5555557fa49d in cmd_main /home/pks/Development/git/build/../t/unit-tests/unit-test.c:62:8
      #8 0x55555584b8aa in main /home/pks/Development/git/build/../common-main.c:9:11
      #9 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/8kvxvr3pmsypxiypq4g8zy13glnfr7nx-glibc-2.42-67/lib/libc.so.6+0x2b284) (BuildId: 5a702452a01df1d7d50ce0663acec7be3c71fd4d)
      #10 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/8kvxvr3pmsypxiypq4g8zy13glnfr7nx-glibc-2.42-67/lib/libc.so.6+0x2b337) (BuildId: 5a702452a01df1d7d50ce0663acec7be3c71fd4d)
      #11 0x555555694c24 in _start (/home/pks/Development/git/build/t/unit-tests+0x140c24)

  0x7c3ff6de2e3f is located 0 bytes after 47-byte region [0x7c3ff6de2e10,0x7c3ff6de2e3f)
  allocated by thread T0 here:
      #0 0x55555579e95b in malloc (/home/pks/Development/git/build/t/unit-tests+0x24a95b)
      #1 0x5555559871c2 in reftable_malloc /home/pks/Development/git/build/../reftable/basics.c:24:9
      #2 0x5555559872e8 in reftable_calloc /home/pks/Development/git/build/../reftable/basics.c:54:6
      #3 0x55555598f0d3 in reftable_buf_read_data /home/pks/Development/git/build/../reftable/blocksource.c:67:2
      #4 0x55555598ea7e in block_source_read_data /home/pks/Development/git/build/../reftable/blocksource.c:41:19
      #5 0x55555598c555 in read_block /home/pks/Development/git/build/../reftable/block.c:224:9
      #6 0x55555598b69e in reftable_block_init /home/pks/Development/git/build/../reftable/block.c:258:9
      #7 0x555555813c70 in test_reftable_block__corrupt_block_size /home/pks/Development/git/build/../t/unit-tests/u-reftable-block.c:531:20
      #8 0x5555557f684e in clar_run_test /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:335:3
      #9 0x5555557f2e69 in clar_run_suite /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:431:3
      #10 0x5555557f2882 in clar_test_run /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:636:4
      #11 0x5555557f375f in clar_test /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:687:11
      #12 0x5555557fa49d in cmd_main /home/pks/Development/git/build/../t/unit-tests/unit-test.c:62:8
      #13 0x55555584b8aa in main /home/pks/Development/git/build/../common-main.c:9:11
      #14 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/8kvxvr3pmsypxiypq4g8zy13glnfr7nx-glibc-2.42-67/lib/libc.so.6+0x2b284) (BuildId: 5a702452a01df1d7d50ce0663acec7be3c71fd4d)
      #15 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/8kvxvr3pmsypxiypq4g8zy13glnfr7nx-glibc-2.42-67/lib/libc.so.6+0x2b337) (BuildId: 5a702452a01df1d7d50ce0663acec7be3c71fd4d)
      #16 0x555555694c24 in _start (/home/pks/Development/git/build/t/unit-tests+0x140c24)

  SUMMARY: AddressSanitizer: heap-buffer-overflow /home/pks/Development/git/build/../reftable/basics.h:119:20 in reftable_get_be16
  Shadow bytes around the buggy address:
    0x7c3ff6de2b80: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
    0x7c3ff6de2c00: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
    0x7c3ff6de2c80: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fa
    0x7c3ff6de2d00: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fa
    0x7c3ff6de2d80: fa fa 00 00 00 00 00 00 fa fa fd fd fd fd fd fd
  =>0x7c3ff6de2e00: fa fa 00 00 00 00 00[07]fa fa fa fa fa fa fa fa
    0x7c3ff6de2e80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7c3ff6de2f00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7c3ff6de2f80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7c3ff6de3000: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7c3ff6de3080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  Shadow byte legend (one shadow byte represents 8 application bytes):
    Addressable:           00
    Partially addressable: 01 02 03 04 05 06 07
    Heap left redzone:       fa
    Freed heap region:       fd
    Stack left redzone:      f1
    Stack mid redzone:       f2
    Stack right redzone:     f3
    Stack after return:      f5
    Stack use after scope:   f8
    Global redzone:          f9
    Global init order:       f6
    Poisoned by user:        f7
    Container overflow:      fc
    Array cookie:            ac
    Intra object redzone:    bb
    ASan internal:           fe
    Left alloca redzone:     ca
    Right alloca redzone:    cb

Verify that the claimed block size fits into the block data before using
it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                |  9 +++++++++
 t/unit-tests/u-reftable-block.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/reftable/block.c b/reftable/block.c
index b86cb9ec5a..4d6b11c2e7 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -340,6 +340,15 @@ int reftable_block_init(struct reftable_block *block,
 		full_block_size = block_size;
 	}
 
+	/*
+	 * Ensure that we have sufficient data available now to satisfy the
+	 * claimed block size.
+	 */
+	if (block_size > block->block_data.len) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
 	restart_count = reftable_get_be16(block->block_data.data + block_size - 2);
 	restart_off = block_size - 2 - 3 * restart_count;
 
diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
index 088162483e..6995eb8bf1 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -497,3 +497,41 @@ void test_reftable_block__corrupt_log_block_size(void)
 	reftable_block_release(&block);
 	reftable_buf_release(&data);
 }
+
+void test_reftable_block__corrupt_block_size(void)
+{
+	struct reftable_block_source source = { 0 };
+	struct reftable_record rec = {
+		.type = REFTABLE_BLOCK_TYPE_REF,
+		.u.ref = {
+			.value_type = REFTABLE_REF_VAL1,
+			.refname = (char *) "refs/heads/main",
+		},
+	};
+	struct reftable_block block = { 0 };
+	struct reftable_buf data = REFTABLE_BUF_INIT;
+	uint32_t block_size;
+	unsigned char *p;
+
+	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
+
+	/*
+	 * The block size is stored as a big-endian 24-bit integer right after
+	 * the one-byte block type at the start of the block. Corrupt it to
+	 * claim a size that is larger than the data we actually have. Reading
+	 * the restart count and restart table relative to such a bogus block
+	 * size must not access out-of-bounds memory.
+	 */
+	p = (unsigned char *) data.buf + 1;
+	block_size = reftable_get_be24(p);
+	cl_assert_equal_i(block_size, 47);
+	reftable_put_be24(p, block_size + 1);
+
+	block_source_from_buf(&source, &data);
+	cl_assert_equal_i(reftable_block_init(&block, &source, 0, 0, data.len,
+					      REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_REF),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_block_release(&block);
+	reftable_buf_release(&data);
+}

-- 
2.55.0.795.g602f6c329a.dirty

