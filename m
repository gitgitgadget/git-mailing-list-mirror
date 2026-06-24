Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99E3AEF44
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289438; cv=none; b=JNklLqlOyuEwgRhNIzOpO6RFwlHjD4YiyUaPTPipx3QRDokCME4iDj2zQq7kxsCxcyYX0p7bfXM5n5wOVOBReP89GJNM/BOgIIj6r7Rid6Azrv+2CrNYCOa8Ob59N4OAK6jUddwF5rFtfhhikCkbhWtX3nydXdh4J0a7ZOuT3bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289438; c=relaxed/simple;
	bh=AbxYkLRGT4N5/ACJ+f9fA5qwz7B776QhKWdxpIhm9XE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+GlXZ+DzISdFNBAsLvwklxAD8+5vMWBTyHK8IAD6OJtNR2edQuiHshFkFOGly72c/M7y8hnebddw008cCl5orYqXYUTvcZ04MapPS+ExfqjsuqsedeuvJtz8Z92lSnQdawMXDYrXzK9b8wzx0nPZn5K02oTxUQKLwr+9hdl22M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BMddCyUD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fpO4MqfG; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BMddCyUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fpO4MqfG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 913701D00112;
	Wed, 24 Jun 2026 04:23:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 04:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289434;
	 x=1782375834; bh=AIZ3rT8SAIkpSYpgBae1WUWguWOWbf/1/6YJKTTOaRU=; b=
	BMddCyUDoBnB5iGqzi0RKC3YP4qr+/eKrJPc9uwjQETtox8+w+TuDz6k7nkGedEN
	TzGPEthchr0fUjgBqsq0/Aia8WBMS0mW8ctZj5nnstFMfJj5IRnddqXPuAdv5vXv
	IsZJ7ioW2BSnep3WVQi0e7KYFQRE3DiWFucuiD/EdR+EZjj3prb66oQ0q1VkKe6K
	RYhmEjVJ6F3ycrUj4ArZ5YGJkJgQ4kZjhWFYhuQKIUEXt2QSNi/Srxfy7QV1lOyX
	Pn1uZN9sUwUl6ZVV2IkwaR6g2YkvTlfUAV5JBvlg2Vh030omJocDt1tCmYpHpT69
	Z1h3ttfmZ08bfSDKuh4gHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289434; x=
	1782375834; bh=AIZ3rT8SAIkpSYpgBae1WUWguWOWbf/1/6YJKTTOaRU=; b=f
	pO4MqfG7xkBdCvr24ZCaHLDEHN+4KxtcC2TK6IJdrueZMZnAzv/fDE+YmU1XIy9/
	emGqDu+3YqhYipCLPde52suVSjkCzzYA3VoajFlCYdR/YOrN1wxRH2MvsiYot3OB
	xr2e/dBZ7EeLvZCKClJT3OZqWN66Uif3E8KStxP9EfEK/gku2S08woEyAEoeoKED
	u6kiq6GZ8zHBpgrUEalDdTB5qQE/Wt6kozyPs1IMaroilCJHYyBgxfXYc/ABaGG7
	YBT2omry/WebyiC0SfcjHroXeTiHj896RLjPR8C4Mnh7NJT4Hh6SIbp6CopCTuDP
	Wr/OWS9vmkL87N9jI78rQ==
X-ME-Sender: <xms:GpQ7amulT3PhzrDQo_SLwLu5HKoNL6PMzn1-4xMBO2Z_4XUc6sFNdg>
    <xme:GpQ7ahcwv8h17EtJEF-R7sIMyWrlufKo3eVxENW3b0kAoy08-mWpAMXPwZjx_jvS_
    FW8PBLx-0-0eTuDOp2WGkT-NeHz2a6fFgfpJZNVpvFbJ8RH8FKbag>
X-ME-Received: <xmr:GpQ7avYZGboow13dfTILaYTp7jTn0gdMRCNPhoSdQ3wa9m2xp_-SbxGMsuM6oLIJstWaYxvBRaE1w08yZAeddHx0dpAFONARtCgDszhb>
X-ME-Proxy-Cause: dmFkZTFZXcZ/Oq+pXUx3MrzHOE9X7O54PeKGz/yYsinIULoHmTgNayMn73+ZTDOMCUnRVn
    oEbcuYX2O2lKaRpVOhRwS4op07gIC1wCUVsH3hqOTGhCEOJUbGEwxdVw7s6MH/yOgiYOOP
    UTDb2UFJ+GKFMQxKE7IFlRtbywF7DBjFdx34DkBOOv3Hjl4AZcichv1LhVa94rEermMWtI
    oK1bUJZN/r7UdPZNfUGQtOBBJRUQsymqw7xvmlHJwSxtuZKhwtlAEtct146j6SCCdIuAyR
    oErJYMoihhPmhg9v5KLz2iP/gjh6BJ8+GWRoIWGLXpAJq09zkDil+Cn7PZMwrlxidJ5tQb
    /a6SZYF8GXS+gr6BC58K7Zbtrem1n7kcaJ8tdr3CNGb6dxWBLEzBjgFxTTIRk9035xyAKg
    dqFxFOQblF+vFAAODpTzksigK/c5uNdIxaYQVoupG/lgo1eFoGEg41hd3d4TY4u996WNZg
    mqLniy0rUZ7B4imHakMOHhfx7LMJC+RA69aGB/LEJDZ9+RpJ4n0vEYQA7nsDIlIqxH/Q+h
    nm0lSxx5yohdj14qKRf0MNmh0Mn9amTXUnFejGK2TycR2ZMl1TQbMYHRPUjNbNy2A6SJ86
    TbMd8+RHgNLUsVo54AyEkoVYwv7zBmC27g2lY87dDX11zj5qwzMkEEJNJMsw
X-ME-Proxy: <xmx:GpQ7asVapTSgue_mzgkE6wHG94iMOjGzLClukQ_-0hUeHSmX-BTX7g>
    <xmx:GpQ7apghV2cj0e6UlqI-yCTK8ERilhj8I-CkrFhgJ8NklzaGTJgDMA>
    <xmx:GpQ7aiXJ_60HqYFfCkznnShw8qp-79NkTTeebzSr1CbUnYwMjOyhBQ>
    <xmx:GpQ7aoOVUERjDXLg3dyAyqF-8PZ0V-6AM93HSyGtJLGUrTetRunBdg>
    <xmx:GpQ7aiJKH_7ZaBAokrqWPsRb6SeCnj41PAw8blGXMU9kUcCtYfhrAmHY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aeaca056 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:13 +0200
Subject: [PATCH 10/11] reftable/table: fix NULL pointer access when seeking
 to bogus offsets
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-10-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
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
2.55.0.rc1.745.g43192e7977.dirty

