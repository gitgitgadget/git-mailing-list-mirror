Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26C3ACA58
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289426; cv=none; b=nA2KM+KeJQIYty4Zi8EUyX1ZEhEFFVkNJC2sGRtMy5n7STUflfbd9y+jTCnDYYj14oxT5f35ynnG6kighPxcPVT+WRNPvv5NPoyJJqvFmNs8hk4wsAZFklHAmTa/Te4kfNg05uLI7v4bndj8ck0mv3pGDhNy8wEh8tF4W0Jbc+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289426; c=relaxed/simple;
	bh=bXQVs50ZoMJNyWsQXuu/6rYY/0x29OaiwjnJwydlMsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fDAo5DgfCw7ZwoVRM4ifdZQhDnaQjFWzkXYn1S8mtfIg0r4Oe0dQjvnq4eAndh0zE5K/YlacTj31EJjUOkbHj+dkCayuG7Xp2WDGnNMYv+oengYCOoPzGny9wFqqfHVVNORTSxA7qYlFO8SGzwD8+jQCvpHqwH0Q6subRguyTZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jd3TOuQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9H27b7A; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jd3TOuQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9H27b7A"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E36751D0011C;
	Wed, 24 Jun 2026 04:23:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 04:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289421;
	 x=1782375821; bh=d0CYnnRz8UuycEoDK6QgUwxyx6QtnN06Lvh5POosVMM=; b=
	jd3TOuQLrmRDEtsBprPdUmQxuLGBQPCF8QgotN58bj0c9as9ilUdNKzz5wvNRXyr
	8uciM4PPeSmKqqBwJi0HfX4lDGs3YcD3cPVU+VZgFwkR75xBPpGieAN0T7ERt0TH
	hOzThIQwEdIBcpgSHW9iF9AMDIHDbWDU55AmsxnkuPc15isjZw5p5eG7kBzFTmRT
	03nG77Xgd2gPC8iUzU7L0edEshAsmVsdZX5GRo7rXgCCfOlQqN9L3gYxnfIp975r
	xDJtnNL/VVn8Cu/V0c+j1vc3GVV7DULP2q9E9AZhcUv4jBwQIG1Lu0y0W8+HZRnX
	e877cbNso0mR0cEOySGXYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289421; x=
	1782375821; bh=d0CYnnRz8UuycEoDK6QgUwxyx6QtnN06Lvh5POosVMM=; b=W
	9H27b7Asr726nsPBD7t0pRhWnH9KWJjWCd4/gbCabYkD3+pCkz+5ZOpiKln6lfRp
	2Da2NGs2PiaFO9JyYSjFMSG5ShAJ3SQPc5Kz+LNTf1xtH3/7gzLi+9804l0gu3E5
	IdApQ+M+pEVsk7WYlJ1WAT1nTfEXSCG0Je2YTRTGDTX8xWVTOfhVQTdmIzzH2Ll2
	KPOe9EEebp7GKRokORYdpsZB3a2y9r/ar3f4vsfYRI09QahQUm1xP9zrjcXWSfLa
	+VyqkVSgnFwV1jV8b02OLi1PGrrPVXmBwJ7FbfgKICIpUN/cUksnx4UYSTIE6vrq
	0iRus4Atmk/CeWXTmgSmg==
X-ME-Sender: <xms:DZQ7ao6KbbHYgo-euAi9X49Ko-P7VpFtI-w7otInRw-rATh3oJbG4Q>
    <xme:DZQ7av4xm60kEsbzl9822YDdxJgXLh6CnFAmKWKJja8jFJzjQb9MoWNj-OTANFjNl
    LQwlHTMu_4QjU6A7IRwNLSE6aABDFFrrtZfIRed0q8FrOOVyTZe>
X-ME-Received: <xmr:DZQ7alFzb-iOKQVXUFiJ0NH2pyLz3hz7iz0okbnblj6zL5QKS-bwXI0XNHMTi_glNW7eyRhPReV1zhD5zEh_UK2qjL_D5lvIR7R39qp3>
X-ME-Proxy-Cause: dmFkZTFBzRyZmediwmxpVIvDclFZs2oZ7aDDY+7mVx+Vm9LOdUHnrEfD2KyBBvLc8rc8BD
    qXO+6xeB2PYgRe4y4z2oBexFFD/ZKKeyer3LAQkZy8DAfNuY80W0hqcWjpAx8oYCPSCjHC
    Mn4kDldjyr2WyQuKoTvhLJdK3Si+8QDRVZ2oWxIJsvJAi9fQ21RlKdZfXgfn0EnmBA4Gtl
    63sIJRWoMp7+Gq4jl9W0VtrE8KG1Fvk8sv5nfoCx6WkR8+3v/yte0+Z9DRFBNCNqz2xgW1
    UObw2JbazdO1JTm7lit3VU06IExg130AzbZi8fPlHz17POxBiwO3W8B3qQjpTkvu0Hw+op
    Q2LmOMlxJkiT4SBcdbTw3ctRWJ/R3RS+Ak/sB6BftM8ADaGhcworopl4skOAngkG6szPAu
    LE747zrr9GrAx7XHFwI9dXdjyCDkp1MshtPJJHRsciK4JMYxyTF1jAcVgN11QNvQ7YoaH4
    udj8VVNNHx9QipiAMiQuM1gMRAiaHD4oCaPZMy99lURI88SjTDOosNGwF+/cz9DesUdysX
    ettTPdRSyCc3Vjw0RFDZwpDE2MHrl9x89538npeclo10TiDVlIqkIxN+oAQX490iT4jP9E
    DywtSE9DKsw9/KCd38wlw1bzJCv5z/rKsbl68BAZK82lGLOr/HNf8YBmeF/Q
X-ME-Proxy: <xmx:DZQ7aoQolc2mUC1bg8CoZPA__vXaEa0DQEAIcapJGd4tR_K_hD5vDA>
    <xmx:DZQ7autVX0aw6STvIBif4kbZMVRaVc7sZAaW-wVAoaEP3lReTAPqYg>
    <xmx:DZQ7anyiBDqDuV3AE4Y6XIfGzWeBOBdSY70W1DuUw1JusPQVcCUUMg>
    <xmx:DZQ7ao5J2QtyJbaGQdEmTcKmzi-JWMKWCNQRthGgoxyP-EZLE26i_Q>
    <xmx:DZQ7alVr8xYJ2Z7vaVjpUW-JL6qPMwWOZrFfLxtJ4hnzx_KEQPZAsNzm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c8c2bb07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:08 +0200
Subject: [PATCH 05/11] reftable/block: fix OOB write with bogus inflated
 log size
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-5-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
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
 t/unit-tests/u-reftable-block.c | 44 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

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
index f4bded7d26..40274af5c0 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -456,3 +456,47 @@ void test_reftable_block__iterator(void)
 	block_writer_release(&writer);
 	reftable_buf_release(&data);
 }
+
+void test_reftable_block__corrupt_log_block_size(void)
+{
+	struct reftable_block_source source = { 0 };
+	struct block_writer writer = {
+		.last_key = REFTABLE_BUF_INIT,
+	};
+	struct reftable_record rec = {
+		.type = REFTABLE_BLOCK_TYPE_LOG,
+		.u.log = {
+			.refname = (char *) "refs/heads/main",
+			.update_index = 1,
+			.value_type = REFTABLE_LOG_UPDATE,
+		},
+	};
+	struct reftable_block block = { 0 };
+	struct reftable_buf data;
+
+	data.len = 1024;
+	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
+	cl_assert(data.buf != NULL);
+
+	cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_LOG,
+				       (uint8_t *) data.buf, data.len,
+				       0, hash_size(REFTABLE_HASH_SHA1)));
+	cl_must_pass(block_writer_add(&writer, &rec));
+	cl_assert(block_writer_finish(&writer) > 0);
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
+	block_writer_release(&writer);
+	reftable_buf_release(&data);
+}

-- 
2.55.0.rc1.745.g43192e7977.dirty

