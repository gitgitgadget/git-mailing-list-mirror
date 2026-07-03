Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5C3D6465
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083557; cv=none; b=WQH8cVyaujgsyIRPzOzQqDxeGJTvURm0Vu6KB24/XtHpTwxSBzLlfTcfHMAUq3FobLLlQwVHFNsvtQ8P/mRmIe1YH73bsG3gkSxaxO+qNnUXHHb+r2wRsYN6OIoC1+MVeBScCc/6Et6a/r+MRUbL+wTJl2hvs4Gnag0/NZs4RC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083557; c=relaxed/simple;
	bh=cHvimGEl7Xn0YWeCh8tvE0eoj2aMsgVoBCV5E57K8Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WL9C16sEqFh6tiQeVEogeeBxZEbTwhohvYkKIlV6BBcqmKRc+9YeUYCOmtezBlSM7mFgW7IDFZStrkQOpmqlYT4s9sEUQhH85nMNMCgbW2h8yR4UzLX1O0Jkd6fyyjJi+TbTDx+3t025cdIA/znh7IFV22wxGLAeTtyDUfx3j1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bG+kyLnO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+mZyEji; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bG+kyLnO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+mZyEji"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3EAC91D000B6;
	Fri,  3 Jul 2026 08:59:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 08:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083555;
	 x=1783169955; bh=RbBKQFJuHL+O3ptB0feSIc/EuLRoTuhjOXmquftp5vo=; b=
	bG+kyLnO8+DhpPPKDdL2L2vHadS9wRKIehYy5yQaG+BUELJlc2SOUd2GJWI8C4Xt
	FZTAxVZVcOiln0feeHwJGzcUy4z9pOS7AStLgblt0gB9EcDH3X4kY0S6RBmx8dcd
	RRwCZwGpNUjhz+pByKJqIinCIGMSdGAtkeZTtNIMetFxlKy/ExxP0Yzw+0mLqKfk
	Ck2oxuS6EAYciq2luaSqqUiLisaPoBeOGQEmTQ8bDIcPrS/uO7AAPZHjD9M8oQVl
	NeYGHZFDXvN9Qj6IvxwFuTlzEN5M/dy02Qhx2+m7DnIPkMfr/CB3Y6PHzA5rjcE2
	o0ZgsmvlNmtjnnjuPV8j/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083555; x=
	1783169955; bh=RbBKQFJuHL+O3ptB0feSIc/EuLRoTuhjOXmquftp5vo=; b=a
	+mZyEjifgOG6Tlqh5bFoMRkKFUTNe01i+EMUZRVi0Tc5ApnSSPgZ7p3BMkJi8z5D
	GcOdQUqypLYIzCN1ZNBE7W1yT0/7z/wZdivEKouSU9QCu87KoiQmyx1EFEUPa8j1
	k/jDMVzPZJ6Z7gia4+pSzR4rbn6cjolA/ArDYrC+7s1rNjOMnRw1vHbX/1pVx1Kd
	jyPwY8O8bgfIyQGPedNA9nBSwJbYvhB/XIGJd17RfiGkz0ecCsFykmh9pprXjF5P
	GViId8paIuLeqikAKaidjam7ld+II5gy/MhrYqVR1Rnt66lzUDB2aD0lfOY5/3Ig
	Tike4WOFI644BKyDAIBVg==
X-ME-Sender: <xms:I7JHaq_xdxK5qE8bRX2l0wou10SB5JPtEZkJgnDTtgHfmr_fi1LGnQ>
    <xme:I7JHahvit5IOlwjDtrr526qVZTLEVyDB3GD4TZAJHacWmtKZ-bUeOBG8Lg3VXbh-C
    HQoTxtp5gdChtQfGXSUbS4BLuaggztlMnno6CubzyZf4aNN555t>
X-ME-Received: <xmr:I7JHalCVPfZEuoo69i2Sa1A-2RVBH9dQqJ-ZlC-oi3c6t2s8oLt5yTZ0mO_JGg15g31V_A4YHe__KMX7-VwjpMfEiCC3Zk3U3wLEaJIqbw>
X-ME-Proxy-Cause: dmFkZTE9SFgySGcQg/YWKtvbDnY8RdhKr3PeZLl2XS++XqBhJitks2B0Q01z+On5uG4xiq
    BKCCtCXj+kXwHyGc25dGVksExFm60rQM25/WM/unQl7YCEvPHU0tArJM4yqeAlu5eVoeMy
    bBlFLZ1BSz0/Qrsbz1Eqs1w5jMCccQ9ybIdvngMy1ea1BBFo+K/oEOfnVjMob+RTe6VlSs
    Tn8d99YUdRnBSEtPST/gXujMm9KkGJ1UD+4Goh2Q+xEyDPBD5P6+TvFK83h+LFOQh5M8YL
    8FX7Dq0nQfXOuPjtLYqRy8J2pSc5lODSTs5VUXCJ/uGkAiTwdb4JPq2nHvssSfhztlMfM2
    uTZj9xucGjnUNuWzoBEyZmqSnpdYw2qiQO8TRS4s+vUXOTsIVgss/jMix2EgXI+IWfmePn
    s/kh8IlEFzAxMKwXeDTmBf1+CwmttPEzLwj9gXK9Ux5KsseMHqbdJ3jGEE1To6eedQbnRB
    Q0+cjdQK5iGjAi5cs2w4QPFEF6CVX/L8UGBXa/dT+o3shtigmf1hDZotV/cVOYSyLF9/gr
    NJ+YEAXJrLv5SNo7o3/HA2MsSq5bVQ2OAkIYWnvTevS4o1V7Pi1i/w5ovFL0wsDBzbN5OB
    /CvmdA2nbc8OiIxq+vMnrycSqRuKfu07bRprh5Ocx7tBWgaw/ovVtWtpgHdQ
X-ME-Proxy: <xmx:I7JHahWBPgvYZHP-1qsfpKpmt5NqXJtutwED9_d9i8yl5plUsjtjFw>
    <xmx:I7JHarAJM9QzNnMChjmO8LfyVP5_hifyc5OtjpEUy0r3pykk7HMq2Q>
    <xmx:I7JHas-NRRHq2pcIt5Twj2a2OyUpeVnyIA9HbItc5CXkN8TaNTOaXg>
    <xmx:I7JHaqFuxJwxZReo40lJ-aL1aCmioyO_CHjhSTAcev1mqHSYEca0Eg>
    <xmx:I7JHagAK_SwSALXqlDYJ34p7E6d32Ou2SHylklhnYCuTIuNbcx_fEJyS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id acbb07cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:51 +0200
Subject: [PATCH v3 08/12] reftable/block: fix OOB read with bogus restart
 count
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-8-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
 t/unit-tests/u-reftable-block.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index 6995eb8bf1..d77048cdd0 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -535,3 +535,36 @@ void test_reftable_block__corrupt_block_size(void)
 	reftable_block_release(&block);
 	reftable_buf_release(&data);
 }
+
+void test_reftable_block__corrupt_restart_count(void)
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
+	int block_size;
+
+	block_size = cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
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
+	reftable_buf_release(&data);
+}

-- 
2.55.0.795.g602f6c329a.dirty

