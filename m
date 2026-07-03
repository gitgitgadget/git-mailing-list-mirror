Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914E3D6CA0
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083565; cv=none; b=s1NOyAUygujSQ6EdCV+axKw7nRsc4HeTBvQEnNMPscvkWU/5myDMKypOFJTrjc1Lgr60+63GetTSI1KnRn1UZysicC/GieEZxscb09IVWOfHZcTNQskwcVOnHl1aVY2LcUESDdSEXpJpfpCbMhnqrKdDWpv/tIvbT3Yn67C4XNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083565; c=relaxed/simple;
	bh=B3AOJxHjQwDmHQk+vGXl1HIK3evnmBNKM/xH/VcBNHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyYWrPzfV5aWBR5Lx8KFU5eMRdZ38DHfEJ01Db/bRXyPZZT/QoXgWsmHrem5Sx2HdbT7IrMv711hSqTRfbR0tRXzWNQoXSijcOVsppk4n6XZ9UP7gKbjZtgn6YjcEI/XqFDv7OLlpgwQEFP+KsNhzVw+UaCMagrvuuy1KSSb/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F6mJK21m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YI1F4kMC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F6mJK21m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YI1F4kMC"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 728757A0118;
	Fri,  3 Jul 2026 08:59:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jul 2026 08:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083563;
	 x=1783169963; bh=tjOcOjuVMcuFL4pucgKtCETwMvL/srM9ZLjhlyXI7Pg=; b=
	F6mJK21mjN+kw4qj7bfXpa/iSCtjqw68faN+SffMiyfTytp01E4w45DexJkwxxFM
	OTsQauxrRiYyEDtLvjzvJgGPHoOMDl94XKuvDCwsIVlW7Uj7vKuIqkdQ7/blYX8t
	J3YZa/OBA63G7Ygi2rxzf4iVDKxDygarvMIdDtTmzeWjbOW3dWo5RkF1J1N8Iyhz
	NJ9I5jnctsQ91g9fERlJelURaWn/szdgtpuOLM45Z7C4Sk8FOoTgPNc93dL7ymFc
	6meHrgthVG4H9YD+1QL4Lx1iKGMGx5aB4GR5TZ+AKBn4GjvUehr8Ykw+I45fEYsE
	7ylKBM5NaZIQfJ5yDsxvdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083563; x=
	1783169963; bh=tjOcOjuVMcuFL4pucgKtCETwMvL/srM9ZLjhlyXI7Pg=; b=Y
	I1F4kMCoSWqeVKsCBgPyXPKryOb1LMhHCElnZiKCFVaw9RZOrbDjBr943VSQK9zS
	FMq77H4dXZ6qn3gBdhoI6PtpIfE50lPkTl3WB7dWeZNIcw1Edo4kPq2+dGCa3yb6
	rh7Ye+oz65RXJSe/shRFRohzVHAQRMrAgHR5ZRyRjYGtPNgE0h1NZUEZDIgvEDqU
	07U2WSujsx4tPayCyHSqndnXGJrU6VRECDB0Y/2bJeisq5RUxjdMTBrT+bvyZBIz
	C1Qpcv5zJ70FfsYRf4nnsdvVRkJ6/Ir+5ZgXCeHvtu530Ga+zAOnU9CY9LvvssQ2
	tkkIJRchDsmIk+d2rBcPQ==
X-ME-Sender: <xms:K7JHamPL8rJob_STgDGdxnTe2EZiTNEc9Cm9HnBT8P-jT-LWmMPRJA>
    <xme:K7JHar9LjhBTME4wFihUacrWC1Kv8IvhJ-60-KlJnYa27Px2v0cYYMor8JQJHSjCs
    ChuuLm9DmMZlyPUoqYGKiJUFfDkckv9qegFH1uHyN1soVF_BOFusA>
X-ME-Received: <xmr:K7JHaiToociMe358M17Ak7Tn7Y8Qulzf1sry7JHgilSFL1eb-maNpfOY0ruDyGWkd9fvdspNkA1szFLYcjRYhejmbe4LTXsXvwfdXMKORA>
X-ME-Proxy-Cause: dmFkZTGoCLYy7o+orBjNqqsIx56U3KxtpJNx7gtMGlkzAJylSMHMnvFdCqwehmPSQPITy9
    R7t5Rzub+QvN3LZVi03voy3ME2/5k2jbcy9di2gK6XKOY0x1AiFfdcghelfqUt0HbY4GYr
    DipJiQWX7aZXgzirzl+EyOCmG2tvgePU8xS92w2WWhH/sIPsPEZzVmiBZQWim47RuszfgC
    Ue9jR02R4F8oeC5uqLZg+cpbPRBIHHfxUTfP4GxqO5uIOmfohih3SRJk6WGsC/r+W68VUI
    xa1LFYM9VCv+6Cv9uWYGWWiTfcMdJmW9pVov3eqY3ZXhw20kVu6VSwBltsiBcRAcNHHElY
    5gp1A7XFtEh2yFGGotEKatYOFADD8DsMFHT1C2gymSx0akOKXmvE6KfHQ6GAWn8WGX+bro
    VB7JjJkasrnfSezhQaTEREEcQjMISbzafMOM44k8uqBQWmnIka4PKpzJk+n8n76Q7V8ggL
    5GJBSHq9lttl7mH1VZU0iIFNFv+7kVysi4J7989f3OzNEQvufAqoRnelA4N1DQWjfFzoky
    pYe796njWet0x2C/KtGE2wKNQvcCPI3vQFn9pPvX7Fez1Xe+bSsGNd3CdBiv9yweJ51kTP
    VknUy9QHONsJrG2+GCCtg4Q2I9ZSMouyqPaiOPdhOp73pXhL55FoTYyA03BA
X-ME-Proxy: <xmx:K7JHalk90PWB1Atjgwab4n99747GpWOnpaBwK0Ra2KjA8EutP7pSSg>
    <xmx:K7JHaqRKFSp3QpMHjIPiSxuxmpAJkCRn9pA8ZnHldpJrlOITeYuTdg>
    <xmx:K7JHarNt5mHc37GvD7Hf8o98K2jWeF_cR1h9LMJoONDicTEsiBw1tA>
    <xmx:K7JHarWampjQqIccXwWBVBNpxN_3wwfYxD7bjn2bY_grCs64mudQgA>
    <xmx:K7JHatnEYMrISzC3B_g2ZRK1w2nG99MQRWtp8YSbCj_G8myVQWWzDhXV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d55f0765 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:54 +0200
Subject: [PATCH v3 11/12] reftable/table: fix NULL pointer access when
 seeking to bogus offsets
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-11-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When seeking an iterator to an arbitrary offset we may return a positive
value in case the offset points beyond the block. This makes sense when
iterating through multiple blocks of the same section, as the positive
value indicates to us that we're at the end of the table.

But when the offset originates from a section or index offset it is
supposed to point at a valid block, so an out-of-bounds value means that
the table is corrupt. Treating it as a normal end-of-iteration causes us
to silently report an empty section instead of surfacing the corruption,
and we are left with a partially-initialized block. This may later on
cause a NULL pointer exception:

  ==1486841==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x55555598e02c bp 0x7fffffff4eb0 sp 0x7fffffff4e70 T0)
  ==1486841==The signal is caused by a READ memory access.
  ==1486841==Hint: address points to the zero page.
      #0 0x55555598e02c in reftable_block_type ./git/build/../reftable/block.c:392:9
      #1 0x55555598ee6e in block_iter_seek_key ./git/build/../reftable/block.c:536:35
      #2 0x5555559ae553 in table_iter_seek_linear ./git/build/../reftable/table.c:344:8
      #3 0x5555559adbff in table_iter_seek ./git/build/../reftable/table.c:450:9
      #4 0x5555559ada9c in table_iter_seek_void ./git/build/../reftable/table.c:460:9
      #5 0x555555992872 in reftable_iterator_seek_log_at ./git/build/../reftable/iter.c:281:9
      #6 0x555555992953 in reftable_iterator_seek_log ./git/build/../reftable/iter.c:287:9
      #7 0x55555583aa78 in test_reftable_table__seek_invalid_log_offset ./git/build/../t/unit-tests/u-reftable-table.c:257:20
      #8 0x5555557f684e in clar_run_test ./git/build/../t/unit-tests/clar/clar.c:335:3
      #9 0x5555557f2e69 in clar_run_suite ./git/build/../t/unit-tests/clar/clar.c:431:3
      #10 0x5555557f2882 in clar_test_run ./git/build/../t/unit-tests/clar/clar.c:636:4
      #11 0x5555557f375f in clar_test ./git/build/../t/unit-tests/clar/clar.c:687:11
      #12 0x5555557fa49d in cmd_main ./git/build/../t/unit-tests/unit-test.c:62:8
      #13 0x55555584cffa in main ./git/build/../common-main.c:9:11
      #14 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b284) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #15 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b337) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
      #16 0x555555694c24 in _start (./git/build/t/unit-tests+0x140c24)

  ==1486841==Register values:
  rax = 0x0000000000000000  rbx = 0x00007fffffff4ec0  rcx = 0x0000000000000000  rdx = 0x00007cfff6e2bd58
  rdi = 0x00007cfff6e2bd58  rsi = 0x00007bfff5da1020  rbp = 0x00007fffffff4eb0  rsp = 0x00007fffffff4e70
   r8 = 0x0000000000000000   r9 = 0x0000000000000002  r10 = 0x0000000000000000  r11 = 0x0000000000000017
  r12 = 0x00007fffffff5908  r13 = 0x0000000000000001  r14 = 0x00007ffff7ffd000  r15 = 0x0000555556056e90
  AddressSanitizer can not provide additional info.
  SUMMARY: AddressSanitizer: SEGV ./git/build/../reftable/block.c:392:9 in reftable_block_type
  ==1486841==ABORTING

Fix this by returning a proper error in `table_iter_seek_to()` when the
offset ranges beyond the block.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/table.c                |  2 ++
 t/unit-tests/u-reftable-table.c | 63 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/reftable/table.c b/reftable/table.c
index 56362df0ed..f4bc86a29d 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -242,6 +242,8 @@ static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t typ)
 	int err;
 
 	err = table_init_block(ti->table, &ti->block, off, typ);
+	if (err > 0)
+		return REFTABLE_FORMAT_ERROR;
 	if (err != 0)
 		return err;
 
diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index 14fae8b199..c7dca45e70 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -1,8 +1,11 @@
 #include "unit-test.h"
 #include "lib-reftable.h"
+#include "reftable/basics.h"
+#include "reftable/block.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/iter.h"
+#include "reftable/reftable-error.h"
 #include "reftable/table.h"
 #include "strbuf.h"
 
@@ -199,3 +202,63 @@ void test_reftable_table__block_iterator(void)
 	reftable_buf_release(&buf);
 	reftable_free(records);
 }
+
+void test_reftable_table__seek_invalid_log_offset(void)
+{
+	struct reftable_ref_record refs[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 42 },
+		},
+	};
+	struct reftable_log_record logs[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.update_index = 1,
+			.value_type = REFTABLE_LOG_UPDATE,
+			.value.update = {
+				.name = (char *) "user",
+				.email = (char *) "user@example.com",
+				.message = (char *) "message\n",
+			},
+		},
+	};
+	struct reftable_block_source source = { 0 };
+	struct reftable_log_record log = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_table *table;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	size_t fsize = footer_size(1);
+	uint8_t *footer;
+
+	cl_reftable_write_to_buf(&buf, refs, ARRAY_SIZE(refs),
+				 logs, ARRAY_SIZE(logs), NULL);
+
+	/*
+	 * Corrupt the log section offset stored in the footer so that it points
+	 * past the end of the table. The footer is checksummed, so we also have
+	 * to recompute and rewrite the CRC.
+	 */
+	footer = (uint8_t *) buf.buf + buf.len - fsize;
+	reftable_put_be64(footer + header_size(1) + 24, UINT64_MAX);
+	reftable_put_be32(footer + fsize - 4, crc32(0, footer, fsize - 4));
+
+	block_source_from_buf(&source, &buf);
+	cl_must_pass(reftable_table_new(&table, &source, "name"));
+
+	/*
+	 * Seeking the log iterator must not crash even though the log section
+	 * offset is bogus. As the offset points past the end of the table we
+	 * know that the table is corrupt, so the seek must report a format
+	 * error instead of pretending that the section is empty.
+	 */
+	reftable_table_init_log_iterator(table, &it);
+	cl_assert_equal_i(reftable_iterator_seek_log(&it, ""),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_log_record_release(&log);
+	reftable_iterator_destroy(&it);
+	reftable_table_decref(table);
+	reftable_buf_release(&buf);
+}

-- 
2.55.0.795.g602f6c329a.dirty

