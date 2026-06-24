Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384EB3AEF4B
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289435; cv=none; b=rEKZT3BhByjsZvoZYq1RDOJi+aIwFTE+3TBzcE/iyHSpSAjqundnmfdu6Wf3mpH1sYt50wrQOA+qKv4YW1SiMRMecD337cbfkS6DA5HSLkQNTmEKhvO2A8zhvnf05/6jEb1UXiigxKkiC8pPyY5aoukKsd4b2I14SAZsTv+fAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289435; c=relaxed/simple;
	bh=OsewHWzPLbrlrDYNlGzgNtrd6q+c2Fn+8Kk9zJRDUys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tt19ViDxMt/OQka3+NUhlDtAS94swK+IOrl1Z2vMtuhdwHXePfLoG0u4kWB8o1ORvdNcMLFTFr3j9BedzooKyso5yo7nHPahx4xyd3yZVIIvLAGTexrMng9saNL1LXOsHyb9UGhHjXJH5buGjRgEtYI+zFdc8PLXMDQetAu2Y0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mQh5HOLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IDMGB3FG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mQh5HOLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IDMGB3FG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7652F7A01CC;
	Wed, 24 Jun 2026 04:23:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 04:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289432;
	 x=1782375832; bh=OEi2zgQNbmd5ZcRJy7u2iyoqypkpf/f1H3ZIdtwZTBA=; b=
	mQh5HOLYcu3PB9zkN39AtxGJ85nslUwIuaVNNudwht+UQaPrSfGg2lUQHhdfAF/6
	j3yilgWuXnaxWOF+7UqvtK4rEGUaaeP8wmR8s+1s4HFOAiGRKKNFp+QNVjZell83
	5OEcwqjLVUwDksN+phIAKgPk3Dubkix3XxttWJ9Yu33cT1ku0OMkW33jItKcUolg
	/TdXHbIW7Y/YZQF8Pki6r+wl4umnoU3Jn34oKY348ZfaXJxtm0+P+Qpjiq4H7D+P
	bNMwTtveBSeTVJZNUZFFjgPuFIwfo9xBk0y4aZGRtAuKgItiRqGwnMDyxS+qlzvq
	GZZcEtQp1de+YV8GKyZGTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289432; x=
	1782375832; bh=OEi2zgQNbmd5ZcRJy7u2iyoqypkpf/f1H3ZIdtwZTBA=; b=I
	DMGB3FGma6oJlokLQy7bGLg0D4+nJe87dOifREP6AeCESvNue8QMPA9J75fBGW7V
	RBC6cRYgOh2+8OqLSjJP/+1nVCWKXsxdr5XOOH5Bp8C1g6XHA+HzQ9YEZFRMEPM7
	CW4CfLQ9mByeZx8PuYTGX2BAQGb79yf6X907njbbFvhMxWvtsSEpdInWQGNFyHA4
	AAoNGPBITWEe5ts2rjspy/LofGdr0rXuEcEqEzpkodHVeojTOlVqoUDtfuhjQNJm
	3yu8j3TjRGzFBKlTGdkz0CkeG79P2SvEXfJAVkRaGBnFfeKYM3hy3Vqb51VO11Iz
	TvtSIPVdcYpjAA86EwMOg==
X-ME-Sender: <xms:GJQ7arlTp1J2CoMg0o0DJA8qLzZc8NLv24dcCfMNr0x6FQsF74TKhQ>
    <xme:GJQ7ak17lvsCkOxs38k2ZR_oBMmAfi1-ot8hgt1Z2m8kDoPbzy6z4KBC8QRGWk6fS
    rhPVgId2pdojhxOc9RPNNz38ku1WSEE6B341RHe8NdV-I0UfXUu>
X-ME-Received: <xmr:GJQ7avSjHvcom5Hq1bMxK7K3TpBI4ht1PWTO9hxnVtffR08zILlgn4GmDqeWaAb5WflsRgCVLdVNXfmhqpD6AlTSh223GArXKHK_pPs5>
X-ME-Proxy-Cause: dmFkZTEU8dPuKyQ/bmAPf+hHIF6puW4UgII3mv6p1IrzvdKoBWhjBIrSaHqQq3I91ob9C2
    2WELsQbsSh7WXgboJonBlzp6oWBivhFqhmIZGAygtgE4X2mfRIkVLjQNE+IJwhidLH+E1a
    Imu80v2+e62VeLsVAxxStEe8Un5hSZ+y5efRJW8G6gbFDIAaaWyzaXQQVLVs0skWVelkeE
    /WJFQITgB6GwFtpEF5BSROh8DRsWUGX7ghA0k6o/PsNDe21xZ6f9MKTbjJIHR3mJRIXFGt
    n9cAqOrZkgQrdBqqh4BX/ByHekr2m+NqpyBnvpJyAFQvQZVQtBWsvST0AWuRl21Foonej8
    ZDzgwcZXOdacYiWa7P/ple6ZYrcIL2x+Tyb6RNNLacE8U20o+wfx7HOa+xROhXIGIzjyWt
    BcDKjNsTBmQxvxI6/ZRchrbeo9HVM9EUJhLE6J+M9F2A/1ERAuRDkKcKsBtrEfLWdL5Nzw
    JNF/K2CpOXkhVPbZzKlC0qRLEC1HOZSZZttJsJUYqqis0RTAJmvkzD+aseFCD1Y3ij7D6j
    AP2JMrhd4f5IzVH1I0qfR3PmYWwKXgeB+adx6cXCqIlstod3PddAhGy1k4+SQrWL3XrRv+
    aH+o2yL44pcNMlnlWnAtfelN+IAYlXCwfQPXheLCN0AV+Y2MunDNnOFEKTtg
X-ME-Proxy: <xmx:GJQ7autPI6TYd9Q47uDuNCQHRJ1PBpt-yrNAlMpWub5en4EoF2RyQg>
    <xmx:GJQ7asamQP0lFLi8ymwIZZbixPBzgU266q-FddTzDa0Aoev1JmnQnA>
    <xmx:GJQ7arvRfPqUGgVPoKWdDoJ6isN69tMRXA7yQ02GnRmp_d_QjSR_8A>
    <xmx:GJQ7amEBjCnRcgxKQGyli-9CRDm-I8WewQcHO4ftfsya7pp5KUFVzg>
    <xmx:GJQ7ahAWjndzddJ5kyrP5N6JylxMIpLoA3QCExEVsBTAUmU2_7USRVGz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7fd1d7e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:12 +0200
Subject: [PATCH 09/11] reftable/block: fix OOB read with bogus restart
 offset
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-9-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
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
 reftable/block.c                |  9 ++++++++
 t/unit-tests/u-reftable-block.c | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index ba410a0885..77a054d082 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -591,3 +591,54 @@ void test_reftable_block__corrupt_restart_count(void)
 	block_writer_release(&writer);
 	reftable_buf_release(&data);
 }
+
+void test_reftable_block__corrupt_restart_offset(void)
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
+	struct block_iter it = BLOCK_ITER_INIT;
+	struct reftable_buf want = REFTABLE_BUF_INIT;
+	struct reftable_buf data;
+
+	data.len = 1024;
+	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
+	cl_assert(data.buf != NULL);
+
+	cl_must_pass(block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF,
+				       (uint8_t *) data.buf, data.len,
+				       0, hash_size(REFTABLE_HASH_SHA1)));
+	cl_must_pass(block_writer_add(&writer, &rec));
+	cl_assert(block_writer_finish(&writer) > 0);
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
+	block_writer_release(&writer);
+	reftable_buf_release(&data);
+}

-- 
2.55.0.rc1.745.g43192e7977.dirty

