Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCCB2E7378
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723758; cv=none; b=HG00lZfa+9JV9ogxeUutizRQ66lXK6y+AF5/ovU/t1MDkhgc+XwQQ8g4BB8WSW9e0k4R2iY9NiShYAB5S1baY2/klkR1XdAPmqzza89U/+0vRLE4bbr6UyxV6fbngppvfnn86wIn7kzAJsWZ7TX6O9lp1GCiEsvPH5vTW+Oeqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723758; c=relaxed/simple;
	bh=aFk003pvsFDA5Q96FN7f3DodS042+GqVS+rYp1/JEGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjPK1t2Vn9wHSB1iRoSgeYsJqBBYXuul/iHh6fNilv8uer79sxSsUWhh/X+RWfXEQzDrnyW7h6crhhHF16COtmZE8KddN9VOW24jg9JopM3nPHnWGNTp9qnQkXouTmGk3CrJ4xZmZy/9XpHHEsASD27D1gbgVhi4fiw4sK/pWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OaZOxbTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPDldvlA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OaZOxbTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPDldvlA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E91431D00069;
	Mon, 29 Jun 2026 05:02:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 05:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723755;
	 x=1782810155; bh=t1wwC9rWyeveog45A3o69/bnsLqfe+T9u8j6H1kcHZQ=; b=
	OaZOxbTRdtZeBbECmeuByiWP/6He95TqUPGVrcQkRtgutMgJQcyF0GQ4hHeDfMX4
	aZnXFlfY1wcIJTaikzroOdE+HZ3bTlhGxuuaD34GyHVj4HvGMDE2/RAPN/yRy7Bz
	XJ351MejGS/TH9pkCWQbHZEy1Xgpl77+TR1mOetuLzrnF8x1/OqXCFTt7MsZuZy0
	4RX2W3BCpxjVBCMZaHCclIiR7DM9tfWDqI0ShzfwF1pzfsvPipurE8OvgcYsvTol
	H7EuIGilhY1mbE/SMO178cUvm2LGGt3Zn2lLuZBdT6lHlXgLWe4OXtrloVNdDsAE
	UNvwEjQwzE0sDPr2dZHgQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723755; x=
	1782810155; bh=t1wwC9rWyeveog45A3o69/bnsLqfe+T9u8j6H1kcHZQ=; b=W
	PDldvlATx8a9h0OC4LDxFaFc8cXekn1Zi4qvGVj2r7GDejnp9Ktycw8xW1pl15/j
	/ljg3U0IB52td3UVZWpM3iTJLF9QzVnRKnk4sihjlVYCQ7hz9WxoVJNoz1tnPBJ1
	3we7RGQzoTx1ylyM5Iqhhjz34+x+ON/BnV2PiflWApu4wPnm6Ha8eJsg3mfGci+b
	Qkp8kpWU9gHSTYe2IedTpzqlTwnUJhvadFru+dKKAhdgpa+ezVQMvMydtvnOxujp
	DdOTbFpesyW+Z4dxk1VOvTYyxajAbeeqx2PneSF7dB/cvFLt6iGEu2TzHqpKf/gY
	SHmc4i8tsUvQQSj5bbg1w==
X-ME-Sender: <xms:qzRCaku90Ne_rDW2cAbnp6SnxU7lznmvIhJYEXySCxGJvu6DBeTo-w>
    <xme:qzRCao7y56q4CoPlvleO5DmPyrQiJy_VBmfzv-HnB2lU7h-Gpl5e89GfcQPoxsuCv
    XJZSyfu33bDpqMLXKafSrIGatl31qH4tN3-GHCyBgjXcdi74-mPzA>
X-ME-Received: <xmr:qzRCatLiExw2PAdMPlvwRzTtTBfs5UZXXKSxBns-896DU1zA1B0bIJhXO1XYwoFcxmdUOmszY6mqLwXhW24xjP5Is1geiLKY1Aml9SYyoP3q>
X-ME-Proxy-Cause: dmFkZTFf78gZ4U0pV8g2y1IIGqqh2NaGrNkO7MwAw/Ul/PxXTDFsYY7TBS+5vpiy2xQ7kz
    hAKYtnO2uhrhKcBaCsJJYq2jPVxR8LLd87L7SpRvAxRPUIAFt+csN8nCQNTB5FmR62wCIP
    IbJQKlONF1vyW4B5TCQR+975Kr/6uN3lyeUY3bP4uI4r6V72gBE5za4Zgdo2EjWI2Z4+23
    zL+T+fL+VvnGSI7bzahZX0xa2GHAlT1G1LqqdC7L/nx7VON0p+oUNkhLwRzgAwDZGCVh/D
    QUao3LF4tlWzI0Yx+HzylfSpnzpnJRbJ6/5juiKS6UrTXnw6cxhucNlBjxqpyBz4ETehp4
    3EHl21kplbL0j/npdjFRGBTQFJt6MeJbnOIc7+XtKq1VNElycogzdm95TvyvvxmCVl6Xzx
    RpflR8KkC8xz9s4QpLUPIUi01AMlIEnoVCSgZ6eBxX4z8k9BmksWRPjDRdseHEgjLmAIG2
    qWwrjnT59biypKoV42ysDl1n5jMwF+byAHJlgMK4enuUzguCFG8YRrCvijP3CmHY5aMoyK
    sFLXidY5UByQDdHUUdo+bt/kiLMvbtBrWlORXh2VzhAGLR8ZS0xkamrkoxtgb7busvekfV
    nqqm+PdVHUl/doAY177FprMRg0g2GFAOeSxLkvj6lO/0ovu5gBCFRXzJQQuw
X-ME-Proxy: <xmx:qzRCag7DovCz3YihQrhFDesvHzohNJOIk-gQbI4Rgmyg_SrbGMr-uw>
    <xmx:qzRCaowc1Q8EEwHeFL6IsJhs5LOBT2E4664hz0PcbDjySE5z6MgQnQ>
    <xmx:qzRCasZwBPl3eaZcndXCz4Rmz4c5bF58foKNXAuBzv7uHmQRIuIrsQ>
    <xmx:qzRCaiTykBw2uju8uYm1qGodV69pvP4n7SZMICPu-sfMJc5p2LNNbA>
    <xmx:qzRCar3rNpb6bJhaMhExLWe9h01aiIw2ZYHtggH9nEHANsGcJG3NJQFI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83f38dff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:19 +0200
Subject: [PATCH v2 06/12] reftable/block: fix OOB write with bogus inflated
 log size
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-6-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

The "log" reftable block stores reflog information. This information is
compressed using zlib. The inflated size is stored in the block header
so that callers can easily learn ahead of time how large of a buffer
they have to allocate to inflate the data in a single pass. So to
reconstruct the full inflated block we:

  - Copy over the header as-is, as it's not deflated.

  - Append the inflated data to the buffer.

The inflated block size stored in the header also includes the length of
the header itself. So to figure out the bytes that should be inflated by
zlib we need to subtract the header size, which is trusted data, from
the block size, which is untrusted data derived from the block header.

While we do verify that we were able to inflate all data as expected, we
don't verify ahead of time that the encoded block length is larger than
the header length. This can lead to an underflow, which makes zlib
assume that it can write more data into the target buffer than we have
allocated. The result is an out-of-bounds write:

  ==1422297==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c1ff6de5231 at pc 0x55555579a628 bp 0x7fffffff4f10 sp 0x7fffffff46d0
  WRITE of size 4 at 0x7c1ff6de5231 thread T0
      #0 0x55555579a627 in __asan_memcpy (./build/t/unit-tests+0x246627)
      #1 0x55555598b093 in reftable_block_init ./build/../reftable/block.c:277:3
      #2 0x555555813701 in test_reftable_block__corrupt_log_block_size ./build/../t/unit-tests/u-reftable-block.c:495:20
      #3 0x5555557f684e in clar_run_test ./build/../t/unit-tests/clar/clar.c:335:3
      #4 0x5555557f2e69 in clar_run_suite ./build/../t/unit-tests/clar/clar.c:431:3
      #5 0x5555557f2882 in clar_test_run ./build/../t/unit-tests/clar/clar.c:636:4
      #6 0x5555557f375f in clar_test ./build/../t/unit-tests/clar/clar.c:687:11
      #7 0x5555557fa49d in cmd_main ./build/../t/unit-tests/unit-test.c:62:8
      #8 0x55555584af4a in main ./build/../common-main.c:9:11
      #9 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b284) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #10 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b337) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #11 0x555555694c24 in _start (./build/t/unit-tests+0x140c24)

  0x7c1ff6de5231 is located 0 bytes after 1-byte region [0x7c1ff6de5230,0x7c1ff6de5231)
  allocated by thread T0 here:
      #0 0x55555579db1b in realloc.part.0 asan_malloc_linux.cpp.o
      #1 0x5555559868d7 in reftable_realloc ./build/../reftable/basics.c:36:9
      #2 0x55555598a98f in reftable_alloc_grow ./build/../reftable/basics.h:229:10
      #3 0x55555598ae58 in reftable_block_init ./build/../reftable/block.c:269:3
      #4 0x555555813701 in test_reftable_block__corrupt_log_block_size ./build/../t/unit-tests/u-reftable-block.c:495:20
      #5 0x5555557f684e in clar_run_test ./build/../t/unit-tests/clar/clar.c:335:3
      #6 0x5555557f2e69 in clar_run_suite ./build/../t/unit-tests/clar/clar.c:431:3
      #7 0x5555557f2882 in clar_test_run ./build/../t/unit-tests/clar/clar.c:636:4
      #8 0x5555557f375f in clar_test ./build/../t/unit-tests/clar/clar.c:687:11
      #9 0x5555557fa49d in cmd_main ./build/../t/unit-tests/unit-test.c:62:8
      #10 0x55555584af4a in main ./build/../common-main.c:9:11
      #11 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b284) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #12 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b337) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #13 0x555555694c24 in _start (./build/t/unit-tests+0x140c24)

  SUMMARY: AddressSanitizer: heap-buffer-overflow (./build/t/unit-tests+0x246627) in __asan_memcpy
  Shadow bytes around the buggy address:
    0x7c1ff6de4f80: fa fa fd fd fa fa fd fd fa fa fd fd fa fa fd fd
    0x7c1ff6de5000: fa fa fd fd fa fa fd fd fa fa fd fd fa fa fd fd
    0x7c1ff6de5080: fa fa fd fd fa fa fd fd fa fa fd fd fa fa fd fd
    0x7c1ff6de5100: fa fa fd fd fa fa fd fd fa fa fd fd fa fa fd fd
    0x7c1ff6de5180: fa fa fd fd fa fa fd fd fa fa fd fa fa fa fd fd
  =>0x7c1ff6de5200: fa fa 04 fa fa fa[01]fa fa fa fa fa fa fa fa fa
    0x7c1ff6de5280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7c1ff6de5300: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7c1ff6de5380: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7c1ff6de5400: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7c1ff6de5480: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
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

Fix the bug by adding a sanity check and add a unit test.

Reported-by: oxsignal <awo@kakao.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                |  9 +++++++++
 t/unit-tests/u-reftable-block.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/reftable/block.c b/reftable/block.c
index 920b3f4486..b86cb9ec5a 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -260,6 +260,15 @@ int reftable_block_init(struct reftable_block *block,
 			goto done;
 	}
 
+	/*
+	 * Verify that the block size covers at least the table header, block
+	 * header and the 2 byte restart counter.
+	 */
+	if (block_size < header_size + 4 + 2) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
 	if (block_type == REFTABLE_BLOCK_TYPE_LOG) {
 		uint32_t block_header_skip = 4 + header_size;
 		uLong dst_len = block_size - block_header_skip;
diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
index f4e926ce3a..088162483e 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -465,3 +465,35 @@ void test_reftable_block__iterator(void)
 	reftable_block_release(&block);
 	reftable_buf_release(&data);
 }
+
+void test_reftable_block__corrupt_log_block_size(void)
+{
+	struct reftable_block_source source = { 0 };
+	struct reftable_record rec = {
+		.type = REFTABLE_BLOCK_TYPE_LOG,
+		.u.log = {
+			.refname = (char *) "refs/heads/main",
+			.update_index = 1,
+			.value_type = REFTABLE_LOG_UPDATE,
+		},
+	};
+	struct reftable_block block = { 0 };
+	struct reftable_buf data = REFTABLE_BUF_INIT;
+
+	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_LOG, &rec, 1);
+
+	/*
+	 * Log blocks store their inflated size as a big-endian 24-bit integer
+	 * right after the one-byte block type. Rewrite it to claim a size that
+	 * is smaller than the block header.
+	 */
+	reftable_put_be24((uint8_t *) data.buf + 1, 1);
+
+	block_source_from_buf(&source, &data);
+	cl_assert_equal_i(reftable_block_init(&block, &source, 0, 0, data.len,
+					      REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_LOG),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_block_release(&block);
+	reftable_buf_release(&data);
+}

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

