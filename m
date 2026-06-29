Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56FD3F9298
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723768; cv=none; b=C+mHulsiXJIqBEaXJVPtnzRLUZarxR7Ic7A6MSuBBPjm8SBn9Nww3W0Zn1uUAXny9ZNwfuTs74xA4UPZ14IJFXKGUBDKzcaFAXRkFACjM0Nwn49kRH8Axayha34OP+il/t/E8updCrSQzpijVbUhhcLor6zf7AB9Q8jdPBdevOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723768; c=relaxed/simple;
	bh=8i2LiHtEY2+B8CqdFtprYLzcZg3tuHDzDL0ceIRnIaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYoP1M8jE9KhpmqO/5RB6BybpXsY/Y62AqU77eI+gMXu7l9RCDbgg/DsR9uyMPcvKO5Zfyp8ZNv43k/8P6RgziL05/IRYV1oQ1FP9ThBOjJ9B5Cl4re1yNbGqrKwNHHFjkMV00VC9PZxyhnSBeipriA4AXvPYCt9ecy294aGrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vhLk4/EX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GZqBio6b; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vhLk4/EX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GZqBio6b"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2613A1D0007F;
	Mon, 29 Jun 2026 05:02:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 05:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723766;
	 x=1782810166; bh=s4OfqNZU8t1zfx99tiRDHzRPvmlBTscd8of0kK5Hois=; b=
	vhLk4/EXam5TMQxzPSDrJ70CsqK69eAknxsRv7sPVLI98U68/LEYHh5TTGIEyXQ3
	kZogiloR3fTsvHLYULxuz38RRBZTv9qZ+GmGq7NZpQm6f3SSOOTIGTf1F1ycwGXi
	j4rJK9WN7fpo5rq/UmNNwjESwzg0mRtJqwa/2C9j7GAkap6Rgrus7fRxgomtbvWZ
	caIRg2ii1kkyAt6aplb7R2Og8MztPW3JvgZFT/z9t3VbwojPAB9NMzsBBVvHfr/W
	7lKO+iJ1WL6n43AVgoSa+9TZtPgjh+xm4piKx/ACmCt+v5ZCxBG921AuDRgkWZ7b
	e9jcWyuwF9peLrwUpmI9sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723766; x=
	1782810166; bh=s4OfqNZU8t1zfx99tiRDHzRPvmlBTscd8of0kK5Hois=; b=G
	ZqBio6bcYfQatP/wxBNcrW66VMWLTGoT3+w/MvFN8vQN+DDRtxnx9Ngljw5K1nFy
	aI5Fp3KlGUeQDDlHmksKs4JhZzd6fc6i+N8rH/TiBgeL12fiUfWJWps/6rsKV/Sd
	4laLDUXAWPU0/Co9ksa/kn/M2D1fd9yD0cdxAielZmBZ4JwGF+cCdjepFCiFVib4
	vnvJSlccbsI99WeAzdDhjOIZZbyj+deuIpwu3d/ziHVtdtuBSr8mS/z1l7bueQMa
	8TQSn4Qxjl1jjyp+MRKaoG+jaTydasWC1pzyh+5pawewPQ/8DdjAyXtrIHA/ZIxm
	s+MJQiTr0HbvqQ742omvg==
X-ME-Sender: <xms:tTRCanEAh2BAXh0Fz3inOmtpuPJ-yXUkJ0vPUVXfrNoPX3C9WlgUBw>
    <xme:tTRCaryt3nuQ0nzUPQ6qlNDqvHprCVJ3ioQ1oqFa73YtDzQAeAveCNKa53kjtOhc1
    kuAR0W7-f5FjAB1ENuXameGhkCOWF6MQ5Qo5rTq_WkHyNO-flLIEQ>
X-ME-Received: <xmr:tTRCamjptDO-LR6tNqw7LvgK9FoWFYchXonB7JZuRP8hPTvVaZZb0pyd4hHharGkWkmYuQZxbpc__Yo396gLjqN_1RQcZskiDcPogRK-oNVr>
X-ME-Proxy-Cause: dmFkZTFIPt9rndgyHbsSDShJmzU6lQ/iZ6kO3Do6MmbO3fz2cbgPj+g35hbL6uA1xdnXi1
    EsYgUKeNVGn74xysnTjYhkbvfAnkCYTe5O7WrLFwGo8pvGepQwT7RdpI/oKEzctblDmceW
    qiOQfuhEMg1f4YFlOQWU8k4uaBMONUCxF49BIIjq2ny6ZCYnvtmjic5uxbbeR42uUOm+eh
    SmFH/fqAUHRBrsgLk7w4p8dXPnNzzYPhriHqtW2I7ZzBQceR1snHIumGcWW4A6x1caBOVp
    +UXfyfF8UW3EfJWNaGy7NizENdwwt9btBmweKq2p8s4AzeDHwmZ9uq2p5aVi9rrXYnQeNn
    NXR+K3rgbEngWoVGvwlZ2fw8/WSYF304IK4zq92D8uhPYkGdRsuncZAMTA897BfFX3jnu6
    wftbGyc/QCah8VfXJ/ytDEvHYji0usopUTjXNrQPYTWGvuj9e48/wJ6D6Y6Hlf4absNi/+
    cviTDVwQ9Cq52ITasScylyEIEGy24EFMWmkaKZPZqWtjIVP+X9RdKskX8SLcy3blQx+seI
    3G9Zsu/Ci0PSItxJbOcjO6t1y/8kJhkhFaq+uImLB7ypk/vZFVEXwDBPwSxBYgABQOguVY
    +xpXy3bE3ZUZdeB3D2rYfLzQxbmG4G8IP10Oa2469l4HDVgnkXJt64ZaqT6A
X-ME-Proxy: <xmx:tTRCauxUZdJkuTeA_kGLiHJbYp-i42zZNnz2pgsTORNxkiqJKnRpcQ>
    <xmx:tTRCahKsYvsxtkPAF5IoyUScGgz5Nm0HztTMrIeD9sTmbnbYiYyyYg>
    <xmx:tTRCatTwxPbN-JC50JpUVWEHGqq4L5MTSYiq2s0hAdDzs_ZLwB6wrA>
    <xmx:tTRCahoMfEvqGO7YLjpbrSPYRswKPy-0E0YqgrnlsxxM8F3zx7ZQWQ>
    <xmx:tjRCaisFY_oNXBHtAOpe7NPjclh4uRj_u25Nk5yCtZUXGHR1Jg1QzAKx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 80649272 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:23 +0200
Subject: [PATCH v2 10/12] reftable/block: fix OOB read with bogus restart
 offset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-10-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Restart points encode records in a given block that do not use prefix
compression and that can thus immediately be seeked to. These offsets
are encoded in the restart table, where each offset needs to point at
one of the records of the block. We do not verify this though, so a
bogus restart offset may cause an out-of-bounds read:

  ==1472280==ERROR: AddressSanitizer: SEGV on unknown address 0x7d8ff7de5f7f (pc 0x55555599502b bp 0x7fffffff4df0 sp 0x7fffffff4d40 T0)
  ==1472280==The signal is caused by a READ memory access.
      #0 0x55555599502b in get_var_int ./git/build/../reftable/record.c:30:6
      #1 0x555555995c2a in reftable_decode_keylen ./git/build/../reftable/record.c:177:6
      #2 0x55555598e85c in restart_needle_less ./git/build/../reftable/block.c:455:6
      #3 0x55555598895f in binsearch ./git/build/../reftable/basics.c:175:9
      #4 0x55555598e189 in block_iter_seek_key ./git/build/../reftable/block.c:543:6
      #5 0x555555814aee in test_reftable_block__corrupt_restart_offset ./git/build/../t/unit-tests/u-reftable-block.c:636:20
      #6 0x5555557f684e in clar_run_test ./git/build/../t/unit-tests/clar/clar.c:335:3
      #7 0x5555557f2e69 in clar_run_suite ./git/build/../t/unit-tests/clar/clar.c:431:3
      #8 0x5555557f2882 in clar_test_run ./git/build/../t/unit-tests/clar/clar.c:636:4
      #9 0x5555557f375f in clar_test ./git/build/../t/unit-tests/clar/clar.c:687:11
      #10 0x5555557fa49d in cmd_main ./git/build/../t/unit-tests/unit-test.c:62:8
      #11 0x55555584c25a in main ./git/build/../common-main.c:9:11
      #12 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b284) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #13 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b337) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #14 0x555555694c24 in _start (./git/build/t/unit-tests+0x140c24)

  ==1472280==Register values:
  rax = 0x00007d8ff7de5f7f  rbx = 0x00007fffffff4e00  rcx = 0x00007d8ff7de5f80  rdx = 0x00007bfff5b6af60
  rdi = 0x00007bfff5b6af40  rsi = 0x00007bfff592dfa0  rbp = 0x00007fffffff4df0  rsp = 0x00007fffffff4d40
   r8 = 0x00000000ff00002b   r9 = 0x00007d8ff7de5f7f  r10 = 0x00000f7ffeb25bf0  r11 = 0xf3f30000f1f1f1f1
  r12 = 0x00007fffffff58f8  r13 = 0x0000000000000001  r14 = 0x00007ffff7ffd000  r15 = 0x0000555556055fd0
  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV ./git/build/../reftable/record.c:30:6 in get_var_int

Guard against such restart offsets and signal an error to the caller via
`args.error`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                |  9 +++++++++
 t/unit-tests/u-reftable-block.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/reftable/block.c b/reftable/block.c
index 89efce8751..1fa81405d2 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -440,6 +440,15 @@ static int restart_needle_less(size_t idx, void *_args)
 	uint8_t extra;
 	int n;
 
+	/*
+	 * The restart offset must point to a record, which is stored before
+	 * the restart table. Verify that this is the case.
+	 */
+	if (off >= args->block->restart_off) {
+		args->error = 1;
+		return -1;
+	}
+
 	/*
 	 * Records at restart points are stored without prefix compression, so
 	 * there is no need to fully decode the record key here. This removes
diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
index a0fbfb247f..b8bb9a23e4 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -563,3 +563,42 @@ void test_reftable_block__corrupt_restart_count(void)
 	reftable_block_release(&block);
 	reftable_buf_release(&data);
 }
+
+void test_reftable_block__corrupt_restart_offset(void)
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
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT;
+	struct reftable_buf data = REFTABLE_BUF_INIT;
+
+	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
+
+	block_source_from_buf(&source, &data);
+	cl_must_pass(reftable_block_init(&block, &source, 0, 0, data.len,
+					 REFTABLE_HASH_SIZE_SHA1, REFTABLE_BLOCK_TYPE_REF));
+
+	/*
+	 * Corrupt the first restart offset, stored as a big-endian 24-bit
+	 * integer at the start of the restart table, to point past the end of
+	 * the records section. Seeking such a block must fail gracefully.
+	 */
+	reftable_put_be24((uint8_t *) block.block_data.data + block.restart_off,
+			  0xffffff);
+
+	block_iter_init(&it, &block);
+	cl_must_pass(reftable_buf_addstr(&want, "refs/heads/main"));
+	cl_assert_equal_i(block_iter_seek_key(&it, &want), REFTABLE_FORMAT_ERROR);
+
+	reftable_buf_release(&want);
+	block_iter_close(&it);
+	reftable_block_release(&block);
+	reftable_buf_release(&data);
+}

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

