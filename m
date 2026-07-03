Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219B3D330C
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083562; cv=none; b=i+z0ARYWX105CXCovx6QqecXUqNYPzpo7sGMRhJhhCmnTpxzPNq5YhImbdh/4HAz6iuLNCLlKSkk1Dw39ogmVsfo9u+5NiCxhfTMBJyy1rqmbjP0U9MeIv3cURQ3x8uAJDBe+4XPXyjqriGGJQz5l+1jmIeVFZqym80LI4zdG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083562; c=relaxed/simple;
	bh=Y2ojJzMH3ouMUa53BpFDEcLR5Z7Txwuj2uyt83W6g+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3XVGiSt3z9xwWZHGC0meHtGi+bgvrAf3EB3dPyf1uST7zA9o4Jl6qOOC+N78W8FOLvH2FIG+dl6TiHdeywUw6p+iuo3+eRqRP7rS/UfT24DcpNmVzG/A4r0QEKyqh6BqBD3pkYnAUmoOKarGReZHBWjabhC0whaCrp2sn/QhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WZkr8kdE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Azq0uvFd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WZkr8kdE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Azq0uvFd"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0793B7A0105;
	Fri,  3 Jul 2026 08:59:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 03 Jul 2026 08:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083560;
	 x=1783169960; bh=qRDaV/5yxI7rcTO524IYMOaFQLt38v7XWQqiZtzIjnE=; b=
	WZkr8kdExKC2ZUHlY3bZeZBKNduus/UulSPZTkPALy9whazm2ExAPCYd7uAsvRyN
	cEoiO9DfP43etDMCzb1f54H2UxlKI3j8Q3Ykafllvde4q9EJVL67qSWUWzrPx5xY
	xQM7xXhzhZUUEylPeon/ykL7drJyD+j+Rn1kIRCZyko0mmyDMEkBh4W273uCy5yH
	WMdYSvPWgjEHyu6Z/XP3eL1GTsnodgEup6NPEWJzQnnnn2/gWuloro9XglnRse8Y
	CsPxMgY8MnHMaFs+ncfgxBA4H9VK1A+2mUKoDXHLJYZryf3OYH8m83ZTp5fxGPMJ
	75nbxYsBRXxJaY+HfcWXMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083560; x=
	1783169960; bh=qRDaV/5yxI7rcTO524IYMOaFQLt38v7XWQqiZtzIjnE=; b=A
	zq0uvFdpquP+rSWn90VJZ9fUPoGfyms4Qa/JQM/BXFJ29ZR4H8mtLR8fNxd/C9ze
	5ActkYOyHar10hZ26ADt3B7KSVBkj7DDBxrehfogpp0wi1c0Y9IQvPx57P7F3+iX
	WJ9IFc6cTnJOO+28pd4Ecq37aQqdglx6y8szR88LQIjpsIsfnlUNXmSpwZQAXy4/
	ZSfQUlE22xV3AyYWAkMu63IhqR29JiM3urkbCZIw+OD1RtrIaSTsGc0T+ChXXL8M
	gKcFgIZv6l/XS7FNnOKb1CxMns05dHofFXX1e2L6Ycvvc1kxYCRo3+SV3TEWl5WJ
	5wb4PfeQO5u3ZSUh6Oh/w==
X-ME-Sender: <xms:KLJHalK5rkZmm3l6mOPOji7BqI4PqzcrR26V-aciAbsZR1N6Hq36RQ>
    <xme:KLJHaoJUq2l7okWiO64k2trhTCDqP1cEiNsqwY6xsilITyyYfjNtvqzUGF9S1t0I2
    bnBsMBoNRryi0jVdjhOn4oQOQ9huK4fg6kRfuHU7iDAnMzerQEo3A>
X-ME-Received: <xmr:KLJHaivVof36AThFi5mGEmRXei7ekjy3dqBpDIa2oPTyeahf5VH3BAX3ekJ8dldTCA2wRdhEn_-CahXjfTQXaYM9hoEPmNo1AwSKXM2IuA>
X-ME-Proxy-Cause: dmFkZTE6dK6/aNca8Btdm4TQTvTUaa2vWhyA0sEtyhX1B6Bnt/E+c4Uv/EAgmwRYyz/ISN
    bKj2JUKxj0a0zITXcCS2PunmGAFK2JovogIuFdimmQg3zt3IGnf/CgbctZSxOf592zQ63N
    Hg+dQZ7yPy9WgztmVVKToaZKnCGiqDLZP9eLTqY9b8lgruku/Tvnh1rD2oFi26/iz9juSX
    4VTEmFKXVe0HH9lnq4kxuYdS+eJZh9YAXuT6o/YiMp3g9jRLderEDBNy1J7y1pe0xaHc+5
    j3h/YrAy8hJhOUfX98+8F3eIwwNMOOxzEbJnhw2wlDAMjfpIKppmel3ScuaeLGFkONL2Gh
    wrT3HjZzU8kHgb7Oki3y/m2jM93w8LNNia3cwysQWQZbdYK46j4DoOafQ/kUdOZ+HbLEOt
    XyQ7qsbGjZ0Dv2TGMQhsFIpQenBJiMUbVhWh1TYoUf43rvalztfEJa/8QxuF6F5enc00zv
    WH++FmkmBWhKS/FacGF1xQjotEe85OzdQSF8sRuBRxngqqKF+JHLww/Z/YbpQnby0ij87p
    vTQNMfA83yQSbxTr5XrT0xYrlueAZNKPJM3Rx4CfhIhVSSplQARg+neQtyGnXpv9lha61P
    Uf9HiEeS55V3+ODyjsuKxlzPlI9WszyRKuHyMfuCKDRoVf577dNd4DLKtsRA
X-ME-Proxy: <xmx:KLJHalRzMArHK3e96Ex2re7jrlJ74uJgXapemrhOT80H2GZlW4KMVA>
    <xmx:KLJHaoPI77R0tLY5rNzgCrDM_PcctnFPzm5tvoL1nZy2uKMRXpHXUA>
    <xmx:KLJHaqZfmDlXSv31OJUQYNmCdbP6AphBk8ChFcMEj8cpCXR_yCi2yg>
    <xmx:KLJHaizxwhQl2VBJAfWozRHlDuxu_M0LT1iUbl7sRNV55TSRkqHBPQ>
    <xmx:KLJHalDqkXTCEmKguIq5c6wb4fg2HZHCuhNvsv1FajhJKahEc-TSt6nK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af1c3510 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:53 +0200
Subject: [PATCH v3 10/12] reftable/block: fix OOB read with bogus restart
 offset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-10-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index d77048cdd0..99b155d4bf 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -568,3 +568,42 @@ void test_reftable_block__corrupt_restart_count(void)
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
2.55.0.795.g602f6c329a.dirty

