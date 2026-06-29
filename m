Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E611C3F88A3
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723760; cv=none; b=d7UKM5sCALPzNhWghV7vYtsGAcLX7Qa0y+cbFuRBhNjxwzOByp9YGyVsr0ZBHAKs6XJwjiv5gt0kJ7wJittBw+7weCiz4LZorzIqTQEdIdJT/0Oh35Y86Et5NOV6Rul9I9sk3r+mmW+5euo0bLhK2+biyXY6sqTtlowHhBz17hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723760; c=relaxed/simple;
	bh=0WWvxteeaTAGJibsSfIRc1ggI9EoQUUUZN6mZTrLFeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7mPv5YF5OfI0+v0br/J255FQPErA+n7w5vuQbCrSbLFU2Z2ZYMy/9otyxBpVZCsSnpBYuCLH+gLMQgh9nXA2FhIRRwo3aGXwFyKqfXANv4gZFyG+o7mUwF0o0KItz4nNrppWqBoOr3yd49O7c4nIA2Nb2i/Fi/npC3nBShuj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YRmgJi9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HzdM0w8y; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YRmgJi9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HzdM0w8y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3D72B7A008F;
	Mon, 29 Jun 2026 05:02:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 05:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723758;
	 x=1782810158; bh=0pVHiByVBn54vwekKI83NiJEt1vBRmolawziab5ulNU=; b=
	YRmgJi9jr6YoJgpltASfI7K7o5+hU6cHamX7pLKJV4iONpvc168zjRaBalw08iqH
	UhtbNB8sktuZDUZGT7QxCI5AF66dV9S6LiLhC8rqNVPKm/q3DQn5zOmICzDgVvUS
	l+5QGPnbLJkKEs50AOvyoenqtq8Fw7KkLQiq/bl/M4qcj6+42bz5PDInC5SSLnNi
	N6I52CEyoUPsAj49Cn2md140TwWYT/2z3KHXuioAIYnkZ4TRVzweEx+qMXI2xjog
	XSTdvhN+H33NMgvS15LANRtisJmhxPXlKEGakq2d5vQgxZlWqHQJusG6VT16De6j
	7DPxthSCEgqH+axxjWlHkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723758; x=
	1782810158; bh=0pVHiByVBn54vwekKI83NiJEt1vBRmolawziab5ulNU=; b=H
	zdM0w8yguE1dmhyn7Kf8SZccll8zY/acDdB7P6loN+1Cf6tkK2I6bPOm0WrChVHZ
	nknYryCOmh/KNGcbBwm5m+o48pgqHgpF1uwYbDpZHq8y8OKAtOnFv8xbL0sC0bzh
	TcjGEUkH75toFKVrUkm6KdS8vfcrkJUXP4yKqvHNgHGugk//6PrFDFPyaQFkkDnW
	4srucI8UAo6AjqwEoMQMr9VqvPLLAehmTJLobNWPYznxpmZJ9RqvdWhERyp1PUQR
	jClS7YzoR96qvTNvUATJErG8mHKmyKRbUSq6Co5Kymx1m8c5z7WRaE1xpaqyeY5D
	/L/+545vtWmJcPK9NECvg==
X-ME-Sender: <xms:rjRCapzAhLO6YO-010AoOI9evtCr4a7yLOb9xSLzgoKZVi3YMR7DVQ>
    <xme:rjRCagsiND7Dnbon_ioBIPxs_xk1Sb5zEYyRC2iLwUzFI7Bcf_MUhSXysEtUzsTCY
    nSmub5AZ_-Cr6kWOIJbIi_gi_eiNzsivKQw_6bVhW75QNwjfEh7Ww>
X-ME-Received: <xmr:rjRCagtpanObSA_CqDd_8Vj3sP_ZI_5_sWeZAuJa8wNnhuLHia6lHsj4sGVvT6WcwPPuU8Iylw2gxU3f2K6fOQA4p-qqEI__wdaXeWWxw__e>
X-ME-Proxy-Cause: dmFkZTFnuXjxUI11T0S5a29HeBT8+4m7fPSX/iBRAf35DXWb/MMwDwLQJNv5uRmeVFf1l5
    d4CZtVGD6R8iL37efJb4Q+F+8sab7OAQUlGU6U58lLlQDsR1Ulfzw4dr4xfAXwIhrjdBCC
    JrCoJLRXsxfRjtxCFO1YE5QOVHS46WTeMMD1iBxNauA+2I3U8gUEpEHr8hMzqhZbmUjCvE
    cc8Ze2FOICPsCz9myRsb2jB4N9MjyXyWoCuuAC7oKkOBZV15rdsO0LcMfVd0+iIJENnOPH
    kLAiHtSQv70ocjnHcyqadhanOYKpTl65vOS+GlS52Hyikl/ocPBxAPG+f1JO7IFA2mhAU7
    TM/zn9qLtLc4fKP69q9pa5O1Yn1X0D5O1E3VcKHn9Shg4mud4ZeQF+U77fuEheLiECopcj
    gfbFQpQfuVYnGUK+Osd32vg9mpW2D1+9+tNOfz41irl+GBkJNzww8A6TQhZaUKXyqjNHdB
    xiNytVHb1ZYzeWsyLaup1u+2QjjXeVTtwtSCtn6NGjaIcVoNkz3qo4T7TnpolaL+viCdZn
    q6qTlYSYoy+aFItVT5QkAoZujU3/OvkNnvozqiMmbHsbFOvhJ6zIFejnpCMHdXaRvW0JwW
    nwKS/zaxwoxBGIFyY0PvOs/KuN3axgMACW8Gt9N3HAECIug4qyJXPoKnYtGA
X-ME-Proxy: <xmx:rjRCalMfnQeAdC-Cg3LK_h0y_8MfDla3bWUAfAmRSs7dlliZJzgb7Q>
    <xmx:rjRCau1j8KyK9eYa8wEHlux-_toQCMQYPuYFcHE_TwJbhKXWnieryA>
    <xmx:rjRCahP7LktxsLDytio6zcINRVuwc4Js2oscQY6UIR4Xfiu_p6XUcw>
    <xmx:rjRCau0C65VJqpluJIr2mdMD6lNnTgNM9jCoEl9F-xrE0Q7B8Seyjg>
    <xmx:rjRCapphT-TOtL5pQ6hWGEM2mumo1M7iwIzsZoLg3Oxv75kFU_AHOUPp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1683be68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:20 +0200
Subject: [PATCH v2 07/12] reftable/block: fix OOB read with bogus block
 size
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-7-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

The block size is read from the block header, which is untrusted data.
We use it without verification to access the restart count at the end of
the block as well as to compute the restart table offset. With a bogus
block size that exceeds the data we have actually read this can lead to
an out-of-bounds read:

  ==1458284==ERROR: AddressSanitizer: SEGV on unknown address 0x7d8ff7de4b7d (pc 0x55555598c339 bp 0x7fffffff4ef0 sp 0x7fffffff4eb0 T0)
  ==1458284==The signal is caused by a READ memory access.
      #0 0x55555598c339 in reftable_get_be16 ./build/../reftable/basics.h:118:9
      #1 0x55555598bee2 in reftable_block_init ./build/../reftable/block.c:344:18
      #2 0x555555813e0e in test_reftable_block__corrupt_block_size ./build/../t/unit-tests/u-reftable-block.c:540:8
      #3 0x5555557f684e in clar_run_test ./build/../t/unit-tests/clar/clar.c:335:3
      #4 0x5555557f2e69 in clar_run_suite ./build/../t/unit-tests/clar/clar.c:431:3
      #5 0x5555557f2882 in clar_test_run ./build/../t/unit-tests/clar/clar.c:636:4
      #6 0x5555557f375f in clar_test ./build/../t/unit-tests/clar/clar.c:687:11
      #7 0x5555557fa49d in cmd_main ./build/../t/unit-tests/unit-test.c:62:8
      #8 0x55555584b55a in main ./build/../common-main.c:9:11
      #9 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b284) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #10 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b337) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #11 0x555555694c24 in _start (./build/t/unit-tests+0x140c24)

  ==1458284==Register values:
  rax = 0x00007d8ff7de4b7d  rbx = 0x00007fffffff4f00  rcx = 0x0000000000000006  rdx = 0x0000000000000010
  rdi = 0x00007d8ff7de4b7d  rsi = 0x00007bfff5cf0420  rbp = 0x00007fffffff4ef0  rsp = 0x00007fffffff4eb0
   r8 = 0x00000f807eb960b8   r9 = 0x0000000000000001  r10 = 0x00007bfff5cf05e7  r11 = 0x000000000000000f
  r12 = 0x00007fffffff58f8  r13 = 0x0000000000000001  r14 = 0x0000555555ee8160  r15 = 0x0000000000000000
  AddressSanitizer can not provide additional info.

Verify that the claimed block size fits into the block data before using
it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                |  9 +++++++++
 t/unit-tests/u-reftable-block.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index 088162483e..43b9d5fb59 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -497,3 +497,36 @@ void test_reftable_block__corrupt_log_block_size(void)
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
+	reftable_put_be24((uint8_t *) data.buf + 1, 0xffffff);
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
2.55.0.rc2.803.g1fd1e6609c.dirty

