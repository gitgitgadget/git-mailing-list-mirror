Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EC3F86F5
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723771; cv=none; b=cjoDoQqbiRuYngWr74fiogGSlMuRxZgemX9J02TBdajMbcQZqvEGCenhUqke4y6p+r081YAeXPUNMWaJ4Q487DCAflO2QJsPJ6SesSVzRyEJHoFDsO6iwtOH/v8+b/sH/i+snM7im730g7iwZ/g3RTG/DKSBQlD2XhE2gVtvYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723771; c=relaxed/simple;
	bh=PESWRZnIuHUQbbeFFc9N5XoFIMf0FmAITguCQydzHgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgMeUQvBHzPFAlE+yKDxoFd8OwrkN7qw15W4PSMNW6TTWDeW5puQXwv6S2dKnRqilA27PJSyd9tE1eEtst+0nAVS4WxAQpGGFNab1DHcjc+alzxZsMbHEsheKb0bu2YhMj9epLlZniP7Ht/N7WdiTrcgaw/qwUV51RjD1YHHoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nmm3d88C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAMT42Ys; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nmm3d88C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAMT42Ys"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6615A1D00044;
	Mon, 29 Jun 2026 05:02:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 05:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723769;
	 x=1782810169; bh=bhVB55Rmw4vZOu3qaYpM6sfhcDXjbBcxYtHwzxCrQO8=; b=
	Nmm3d88CzsL9i2lqZxo0HSjp3C3CDq9wqcBm4z5gm7X/TBMYagrwTH8rZMRWWJG4
	P9XmEmTsJLfUHybJawQ5QBQUjGCDuNKLQk3yy4wnK2ZNnKxygf9Ow3i7jFc6kbaF
	L37QYKzCwPrnkC5q2DdgNZXyeOwBvqOK4TjrjA8+iM5MpF63pZXuJcitnuP6GswV
	SHiKFCH9ku8HBKnayEZ/xMakXz28zLOM1BM5zpFjK+8l0LAST8FRW4W7IipLGVVN
	2nE7ZbJuvvHpYAe2Wu1859xJIQRPJzE10YIpmImG08HdwV+Meilp4mIv2Miivy/E
	roEdIex0AtmDxbj1fQ/jPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723769; x=
	1782810169; bh=bhVB55Rmw4vZOu3qaYpM6sfhcDXjbBcxYtHwzxCrQO8=; b=l
	AMT42YsA9SrQZIix7KrKj3s7izMdb3hOmeZ4d3y1rFqs2uE2IFAt0Bqg5mGf8+V6
	d+pIFSmuOJVIvVZM/AZtA2gifTptze7q6bGLoKAQn05ApCKSWn0ioxvNKpDRsG0J
	NWrwchVU9TJX0ie2d6nva1ysI46mGRXpSkZlRHWxHmT17DdmW2ieL01tpLWA4ATr
	i+UJJinex31QqwVP9GaxIjXrYQQNYfxL7liB+l+XPG8phxybkA6yX+4lnGQ83/4Q
	ZNzPyKdVahgvH7leLkZIWt5qhpDwqpd5ocCDwB26kI29wP+7RY61ZwaLBIpY9pDm
	0iNAJJzg1SOOhVkAkbcRQ==
X-ME-Sender: <xms:uTRCan09v1jZ_FqCPKO0vbxYEspmfumYQoYGyoKCojE8YNlNCSf82w>
    <xme:uTRCathzuWEzJbiaoTOUr_q_XYK2vv9g_b-ReZdEHldQfdNDOqdAhr0YlRMgWd1xe
    hIz3T8Wy9JStv6z_SdttL2Y6Cy65DD8c9IhEdSQg7K7FaK72A0EL1g>
X-ME-Received: <xmr:uTRCalRrqInR1NfK3NuM4CrfbwATt1sGwG3ujz1oe7WS0JdlcaGlRFJIdJm2rpspMMaWpHf0FD_AyQLPxHgSwLifL7FVBVmMZPv1Zo97SYcB>
X-ME-Proxy-Cause: dmFkZTFIFtFxlmLq/s33B/HHi6uAtub6mNCwWROrE61oQAbx6T5DCJNKS0sqwY1QyABice
    Wu95K6QLsSzeo1J0/tMBdLQZdryRd1glFVDyXXjyIja9hnwjOh90TzSzm36QEGg18Y6K5L
    jFwa7yz5ar4HH3H5aPaHfnftn4nbpjVGlTjVp6TluG2CgLZf4IepsJ7k821WYdV2zpf5mC
    jTDUkevq8fzo0sReLf+MOYKLOwf32bguIyihqt9ltHxd77n//rzMa/mo687Afy67EWQffq
    LKXHxIhLhbm52DB/vUAaJzhf6Q4ubszL+h//w/3oE0ZJNT/MCZRG9zwcGgMQo44rbT0Lky
    wTrAqBZmTMYn/TZiXPRhZEm0vL2rasASq3OPadlkl50qlBSU/Kysq42naeUnzCva7nf3M9
    KQp6MOx+xazgwuWIn53VGgtf5fRkiWuSBbKKSoNcX4FTwA+QIiCRIVDCpctt9v+m31ww5K
    x4raJyCMgWJJjnKCQtHuiafN2kK++98p6IjmRu2+VnISKf5zJBYDGyb42uWBPiyi4tTGHJ
    U8PQ8n/C0HU13I18DVHo6PrlF+hIq+JPpHwtTuJXugapEmQnnRV0v4vErwtBszsq2zVMPg
    hVmcscBVLe3pcOo4Nrg+1YNRLkfPU1fkjnX7tCOCKJGiy9wjH4kRUz0TIllQ
X-ME-Proxy: <xmx:uTRCamiuXZ-OXKMa1-StZunebkVAf3YZ8cJSD_TEzkCRd_kZTH14jg>
    <xmx:uTRCat4t1mcoRsnof7eQj9c3vjYMbrQfNjtpGaxNSS9m5qfaRbUfSg>
    <xmx:uTRCarB8oHrVlZFWuEx_6eVqRZHyNLLTp-8qhBFeJmJfUnJC54uriw>
    <xmx:uTRCasZAbmZiZGywRfkkeoCtGWRm-eBYfx9cqwfUiNMUMYkuuRkJtQ>
    <xmx:uTRCascPI8I2hOdsLJOenPJCdY6dBx620v6KLWp8_s0GbAZrPvlHSJ9W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 123141eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:24 +0200
Subject: [PATCH v2 11/12] reftable/table: fix NULL pointer access when
 seeking to bogus offsets
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-11-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

