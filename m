Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D93D47C5
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083552; cv=none; b=SLgJaAySmmO3JdFRIardfnxyj1TETf9UK3VfhHVF8Ve3sHMzGrrvcwJbzHMy6c8S3TVmHcn+mmJMdEjMjDAntw7XxKUkhnieJcEkrDw8xFX1EYlHv8XPezC2EHjC8QuHg0LqQ7SiLEByvWtaFCdwmCaZ0S+6Lhb3BxVB6xnDwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083552; c=relaxed/simple;
	bh=eN+Ue1aI78zLUZOEMkNeM6F824kg/2JE2WHk6jKBVnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+u2edIHrh8emyn5Bl2+sPvhUqpao1SehN3P4tEKxK/vsIgCq8pmIpuidPhD3YK41ksga1XEhZin9IuPRNZQPL5pAABHCPq0Sm8/bvCri4h9zIEAWCN2qBlk4TelSmDw+LA8KNyKxjCte/OG7UfjIOVnYRCvQ1OuX87NV+b1X8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bNZxR4Nl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CKhC3JR7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bNZxR4Nl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CKhC3JR7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 90C191D000C4;
	Fri,  3 Jul 2026 08:59:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 08:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083549;
	 x=1783169949; bh=++EypMDjW1g6UZzKeSYZsTml4NafPjOJ8arOwhCEJpQ=; b=
	bNZxR4Nl/GotJjOdBeM5qZvkjtkwM5PUOHwcALgWUS7xjSgr6PXh+MpRDWDX15h/
	MmWizi3USJA7va+wXN79Bs7xZwywXTeJG7g4lY00/SCDxQ0t/aAkeaDnBCGFClaf
	oVirY5+tpG3Z+k1gUD8B7LXOMXwS+QvCdFAhTlOHnj5tLJfPzpd15tAxgvh/H2CI
	I/+CCu5BVglM//r0UYmelfa42MD4s3Tm+1tWs4bPtaeGAlBK6dbfiA5dVT/Ys+06
	541XsuRJatuUBtJCheDt7KQQO6b1KQdSxDU+ZxAhXwX5xvGnVLP1p2ejoaQ/LKDe
	7Jo+jsGlPsOUsz/4uI8LHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083549; x=
	1783169949; bh=++EypMDjW1g6UZzKeSYZsTml4NafPjOJ8arOwhCEJpQ=; b=C
	KhC3JR7zFwvhQ8IMSqiaSsfInsNFjzBjCl/UCtmN3CN/R4TvyfBXXhNx0g0bO+Hg
	PcLq3mK0UUyqLCV5ZM13LSGdQOxKbHi1S7Y/POQXRWuCoLwoF+D7jFndzzuAAsrJ
	5x0BpkJ/DQMj556TqUO0uLxK1jwQNCztkEcAdS1LD6x/SCCLF0uqJAo6QngQzqoU
	fYtxAO0BsiUnws6B/Uq5Y3TaUe1stj5MigAXJEr8dHa87AfLnmyDPiAxfMgFNwIQ
	dMKYrl4b2IzRCTHrs0mXLMHKsglAFj0BhyQHFYG61Rj1zBp1U1NfwEXyZFTn/Eln
	CkwDz6jwUQXL2mUt3/4Zw==
X-ME-Sender: <xms:HbJHakjUqXNOLbXVI7Mx5HYomXvXFj6scHBiR8-_BZ1SsbUD-Sh5pg>
    <xme:HbJHakDTllmcjVJDCVwDiwDvR1w5ICpXVhTTrHVxduDZFyJM4nUzB6rc9OdU73GWr
    ebpltWkYvU_ghEKFcfNRDvd-k_ghkDHgMZ0LLuwzJ1T6PiD6GKUEA>
X-ME-Received: <xmr:HbJHahGA7VPWcFWg4el_hcM6UzZLVkCPedl82CiFhUBfaXgjZoz6oHGOJ4cKGpbcGgF6R5Dcl-a9Qhkhwh6vdB7TgNVfBAJKwtOP4JwDEA>
X-ME-Proxy-Cause: dmFkZTEAsk+YBVYfMUrMJ6dASld1O0lDQGZGXe9vQMXuAjvk9Bt3WRe8/uBwS+W3Y2pcjV
    lFwgZiv1SLRNfpLPuiWkxhWKNKcxPGOb/u9K6GJvF+AHbobJSZryk6YaszP4Fq8tmPjAJa
    KJnyQyRhdyEOT8FHd9RWx8boYg5cwvMiJ6oKpvPm1QOAY24R1uUJTyAfmsgqWBXkkbOucU
    bIyN3UAVo8Y+zuh/iMSJtuc1JozPJSQCAWruGY4O/OqGdjpHMfd2Bbj8T2o1BUeVN8m18I
    NXPkOYRe0vbjhjitgAf8c4WJdn1eyWOA5WAkbyLkfx4TTKwdECkwSyOtygfUP7nr4EsnXf
    a8LX1o2gnfGQy5jQORjK1RVK+VtyPtcZslAccetqjueu2bcOn8wlDfI35+hKkHFGLPSI6B
    hxkViCbDYF2e6aQL4/l8YaGoyWabASGvu9Zo6vFL2Mw6Tbai/XDzxm5DZwti+3ajYZsys8
    XgNOhUk+GWycOQnjtHiI7GQwx61nSdEgL+BoNVpy7Lre+6KnQDukKQC8VskXzpGf9gCxOV
    zj5waguPyvaNdljnrFKG0KdkX2s2wQCiOLgJswaip26oydgKFAq3gz/Odp9GF8/LsCIA3/
    UM+QR2KaX511mfo3FhDg/xivCp3uH/u1TT5yiJz8s0uDRkKmmKDjs64glXTQ
X-ME-Proxy: <xmx:HbJHakLb-sOZaNYarO2ilBhlG73UietJYzG7gbuAfxPf14Rk36WAwA>
    <xmx:HbJHatnc5dw6jpqd6R1jhi72TKT77dUOSxNjju5sZbsoMQzyZ8_ttg>
    <xmx:HbJHakRM7KaqpVq4we2TDtXC9PxfWfWF-woEFYGqhr5h7HHsVUyZsQ>
    <xmx:HbJHanKkvC1pEz0M_JywyE6dcIFXIGITTiidcXHXfATGo37aJbw3jA>
    <xmx:HbJHapZTh3wCq1OUjIC58_vtrzoLuJYgQJ639Q_bg5efLfLmksTB3lx8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca383290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:49 +0200
Subject: [PATCH v3 06/12] reftable/block: fix OOB write with bogus inflated
 log size
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-6-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.795.g602f6c329a.dirty

