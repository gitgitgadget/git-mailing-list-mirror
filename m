Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B793F88B9
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723763; cv=none; b=VxFbc8aEpQbaSPSHAnv7qAd3cIaIUVjU+0wp41Z4sEsoNT0K8alZ+kKxnMipbRPUAKOPwGov8NeHXYHiVDgHBNdrz8HMjFQ969bcYuCNM0jol3WFzRVz8NcJbW5i6eAbUJvdlXLNUyeTQKFIxHaisfVCNYwpjvOk/txokXhC/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723763; c=relaxed/simple;
	bh=svOuT6AOpbszESC2a8yv7te3upQMji3ooiQtW6TCXmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TeGsOHDxlH/OX8/sFrZJmP7VZ31dtyxnCATbzYR4S3qWk2c2CwED7seIdqTmJr32R8Cr1vH6vtjgYUlIsGtPeWp6BDfOmk4wINev4D3iSjbFNSqZ+V8vnrHItOnrzugcWxzElDTTHm1hPzrq11yXesJOjMzPSjXwN93esW165vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=voKolpHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0tmH4Z7; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="voKolpHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0tmH4Z7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A0847A009C;
	Mon, 29 Jun 2026 05:02:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 05:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723761;
	 x=1782810161; bh=6xFfUwv1Zxxd++eyOfZ8ssagvV0fNTPtdY/5dJD76rA=; b=
	voKolpHiTQuhhpVBg+ElTSP9a73wyX4YknZAsRMpNX2k4o3ADdGmB0WGnt6yYv6F
	RpHpPa4VzSH6WwFmoFEdRQxTvNGnWmV/UmKuKN9TOrRaQp9yIbBZpH2QGl7CG6Zz
	5/vdSICgWD5GG5J2xVhRGVPw01XeNXmDmFz9n+gz8PbK4b7wIeF9Tq+Qbn9P3tEa
	0ggFsCaV/oeizBx+KbDBB6kb4klqX0icaaAm7YyifSI+ez3T46xC0qpr/Tq3RSAO
	BSGQhv3Q/RTV6i8+Dc4lTqgkNnHZbQOZr1UyeE86wY2cpivJexmGRJtVMG5jo9hf
	QHCbM+Uy/7ZNu896k5SSKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723761; x=
	1782810161; bh=6xFfUwv1Zxxd++eyOfZ8ssagvV0fNTPtdY/5dJD76rA=; b=b
	0tmH4Z7sP+VZvOnB1UJJDs6urpWYdtZpiZH3Cc78hc7o/k+9SzAQF3w5LkcyoDak
	DruG0M+KPhd1AN6nqJC2dKRublaLSl9CHUsRXGKaPBaLodNktCk0MV/0shpI5AD1
	33CSrh7XS9QGyzTi6uJN21x560qx3fQrkKjMUMF44xhTwgaajK+YgzGmCJVU/MzF
	YRctloUKD0mL4yfaRIMJE+b6LoiYDSodweUo0Zx2NSl9L+mS1aEa1ulES80icNLQ
	0b/tUPRMDYqVnx9WT7VvDgmnNHP09SnpJmG2EAkUM82dP5H3SrlzfJ6m1xIWrfCY
	iemx5D3tOY/FcXitQLcug==
X-ME-Sender: <xms:sTRCaqMstyAzVTr7Npzr1bxvW6dK7zq8ysWkfZvHoDpr0hKZFhq1EA>
    <xme:sTRCagZrLrIqnzp_X8Ri7M19HWIOijJyUVBJZ9iEtWgWxsOiaUtOxjTKzC5NqvHLa
    BvmRalhqvlchmV17Z-KiM2AeNWGWAPn_Pl-21Joiumz1PCP0xvuhBg>
X-ME-Received: <xmr:sTRCaur98KNa3m7RQ074zkP-1vbn3VWp3ZBcpqGb2kKykOZNxlwQBxPiy6ndoIx2hxrmXnPfA_yH-LdftVlNNJIomZboKxs_IwPckJ_1Owvt>
X-ME-Proxy-Cause: dmFkZTGnRdDsmKmOm1aU1BXJ5dJWsC1GwDzk3XVza2OFY/Rc95WvuidZlpQOdgNYt3DMh3
    DuuknWWXrFy1qO8BSgnJt95dZxDIGhZCeM/yoI1JMr5g3ybDmv3u0uN/3JLlFk17QS7dpx
    cUwttjY+LnmOarQKgvmPQN3M4Y5Ubc/T9A+iJWomps2UlbxXyTxzcD3oenTGdP5r2DKpja
    xVekKw8HhvQq53HK1YSWwi6YK8yja3G+F1JXP8zcXU6AdH6GXomzPjocgzO5a18COZBnHB
    mP+T8t5PTdw7p2GfmdDHnWkgaUZVHGJoCFtfCqHnJSbk+B0JSys3AyytulIZdlHuC4GpJb
    DMf12QxnSYrexZiwYtr50M0GqWsOJ92ot273C5moxkuevgC9YxPU7SKIFEutL/S1P/8TYp
    994livCfiSNK7IPTTGThEaUrGAyeousWYZ8849e8saJgmsaWDpSURi2oeynO3eWB9v/UfU
    PAc1onPLM/IICcvSBJtAWeVGgEVm5ndkwAJ6o7vMF3A6gNlxAhYF8bN5p7eV86aK6jIHEU
    9nuoVlkGN/ZcLOU4/GWdFVaeAGNTudbzWz+oaZZZqmHK4X91dWszz0RwwRCjPIrOK+iUPd
    DgnYT/Nyyjq0BhRwilfPHHScNJRYStBpehKTpUbxbhViodeAUXJKlrJvrifA
X-ME-Proxy: <xmx:sTRCakbcPjqRJg0j2uqHKsxVcJrZZJ3FbluZ3EN052l-5IASNZ2fKg>
    <xmx:sTRCamQplHW0YGbfVS6UbKlfVDFANZKDNTW_FGZYjqlHDSzbZ5nvGQ>
    <xmx:sTRCar74BhgitdP5mMPBk91WlkS4b_C7-TAw5KM6eId79yO0GBeiqg>
    <xmx:sTRCarymbf8U5y7SmA76jtoJXGfwZDhgXViIxQcIkerfbC_BC_cQfQ>
    <xmx:sTRCajXlzaGsE0wpu0AecheZgMrCZOfdI8epHCYElF-2fAJUulQ1IPIW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f5da4f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:21 +0200
Subject: [PATCH v2 08/12] reftable/block: fix OOB read with bogus restart
 count
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-8-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
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
index 43b9d5fb59..a0fbfb247f 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -530,3 +530,36 @@ void test_reftable_block__corrupt_block_size(void)
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
2.55.0.rc2.803.g1fd1e6609c.dirty

