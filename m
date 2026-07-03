Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411D3D5C06
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083567; cv=none; b=S9ooQu1ig5NkTnn6WVmYlkhnKnsvM7h/bQgXJBqs1gj2SdpRAg7I4tL8Cc+Lgbn4bwoRL8DP8LeUWJd2uopqEQeNqCWD6+5Voa07PDTSGLUOZezawEc0tCVtddoC/2FwrDhkRpPCm9AAve1pZ3SJ0iQqvPsN0LXlm3yNFe0O8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083567; c=relaxed/simple;
	bh=6zgukQkOcCwNQLOufDOl7V9tZA0xsIHv0laB/d+iuP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spwAd63JZwt7krTU8R2yTnEJOA6FinTIoXqxwrXOXeVDV20QApXGB1IFSTJ4l22zxUjCW+qCLTvpXeQQXi5VoE+hD5WxDmvT9hiP9MtTa+tyLQCP+C4CdDEcdF6K0uLipzsrpkG9CQb4W1dEM37TroQ+qiifPw0Ai1nvrh+YRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FYhQWAhL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2ECi7OF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FYhQWAhL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2ECi7OF"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C9EDD1D000B5;
	Fri,  3 Jul 2026 08:59:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jul 2026 08:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083565;
	 x=1783169965; bh=cNbm6Qs87QG+oSC/4ldNWovk84XjP0e626Ilpyp2YoA=; b=
	FYhQWAhLUTWQ5snqJsD0wA1zSpmGC6l4r4u8+De2+mkqMalR/QOc5VZCNJ1BuBQV
	mmylEg4kjER1sU1cayKhkW14IehJloXkiVnYKIS7L5pBRVnKSDxoN6GqqBzgAE3r
	UVq8W/HLPHxL/2RHOVtY+vvl12UVTxBlZQ5hb/55kNI3/eECe6rwgeLl/K94LZUw
	aZ87kOvN2pvZmqapX6ZiT1WoBdwrMdwXi+DRT99vi63kf02nUVXT4JaiKzSmqPgs
	hPn4fnKJhDuRtskExNkJdaFprOP9pBHCgbz581lYxqqcYMcvloEno1zqTYuULH1x
	XBqp/fI/F3IB+Q+8DU/8hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083565; x=
	1783169965; bh=cNbm6Qs87QG+oSC/4ldNWovk84XjP0e626Ilpyp2YoA=; b=d
	2ECi7OFf7pomkF2hI4zyLLoAj0wuUtoZiBgjEiuq6n7yKC4PyluSgzFud/O7wrNT
	+lojR3VK5t6KB2XGHpgij5riCrzwkJ7Ld1rbuAfjvSiHSs1OFVqILZY2bVMmsicf
	sEOFcoraHCo9RCFXfYEgrMFdZxxNxM0or+yer8hadfKlP5Nvoho0CVX3TKQhum00
	YTmCfDf8F8bTlsyPOM1/9uV4xZwyADmLxaWF8qFnB9lj5J03IomctkpOLKqP4F3/
	qCw8iCDWLuXSXLZY/Fnr9D9IgCiWy6YBa5kMT7hEYWSg67AAe97SD8HB7eMeKnVt
	b5Ogisv+OnWjE0gyx6GBQ==
X-ME-Sender: <xms:LbJHahMm142aXLC0kCceZWYRNDxsWTkR2tv0S_OT8qOerARGR6zQnw>
    <xme:LbJHaq8Ig6dPteypV-Qaz8nT_69qSmL4jCKWOb_uxq3c4wjyiLSGhVSPA1kmI1amX
    cTvgpbVhKfCLLb8SWKStWKHd4S21_5ovpxjTIWw5Xyl8bSbMUxCoA>
X-ME-Received: <xmr:LbJHalT61T2Chs9m7O0sGuusFs7CwYVikl1kcDvUVE6EHhMbjrlKfcrMezI2bfToUSEO0MnqsBnwNwT5XfCqXtv3XVqpbOO9jmmZ8TRVlA>
X-ME-Proxy-Cause: dmFkZTEnwvHVL/02oA1h2uWNRZvjgjI9BD+dkxtOdLwJ8hgL6Y0qLSdb2NnWfTr6UNt0dl
    rwcoArYQ53f/0Y1FZHpBSRkzqgsnWJdFO56zP44BeEklSg+tOlFA8QUvWfYVi08L7JDXBX
    C0xy2B23fAAi9AWPhME0flDA5F0trsEpHLxNt21heC4fvk20kF/9jy081ZaZO/gfwY3ch9
    2xOOalj33Pq3zJIZLRyMR9G4D6StkfivX9t6bDBrNuxuuWSBUGXjxloUjOXAUCWNsmPY7p
    s+5SDmDTgvFsrgvtN+2U/UQp4QGAIPVCHjlaeXB5lhP/4PP+T0wy8yw7e67gBqEG1EgqBK
    dJLVOFMLMtMvoiHvD00kuz8Ad/z2R4+hAZ7+nhVZgPilp5NjIQjHSRs8e141PMoyPi1nFS
    WsO2pDcV1qPliMxqiWp8Qr9N12Uc64A7GEhAGgHYj0h+wXi/bz7s4Njtu7o0u7/PicUl7k
    NORklqoregWB1uM3lUQ15JG5xGLo4c0HH1HoDelzZErT4tFwzxC+XDbenveI48s//6ATat
    buzbPoiFNlHamofQursMGrIMq4pwYcBQ1tXuR0fkoYyJ5TZeDx7zPWE5XS+/WhvKeknaFu
    xcS4tGhBk6WvtYdXOSzQ1Jgga/B2cOlJLko0Z+fTW19jc1S2NtBjkftbnGHA
X-ME-Proxy: <xmx:LbJHaskbkwl-bWoD050PC01X4rCYM2bkvO-LKVAxojO1tdG3mmHn-A>
    <xmx:LbJHalSgJteQEzEgUAUXfOTRxkh6ZcNVF8WLvnb-LomATJTLG2V-ug>
    <xmx:LbJHaqMJhENlRjWGtdPq-Axoj5Sc9lOoZwSVVSMHL-L8xX4jh_D72w>
    <xmx:LbJHauWfDyR6DGeUPe_iKkeYkB4lOL-gcLCyA5P33oYtt5QXKptTKg>
    <xmx:LbJHagl6liIcv2rtgELsGnc9BdHHW3iiPQlgg8Prat9xpVbxUq2t4gH_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f429ab66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:55 +0200
Subject: [PATCH v3 12/12] reftable/table: fix OOB read on truncated table
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-12-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When opening a table we compute the size of its data section by
subtracting the footer size from the file size. We do not verify that
the file is actually large enough to contain both the header and the
footer though. With a truncated table the subtraction can thus
underflow, causing us to read the footer out of bounds:

  SUMMARY: AddressSanitizer: heap-buffer-overflow (/home/pks/Development/git/build/t/unit-tests+0x2479a4) in __asan_memcpy
  Shadow bytes around the buggy address:
    0x7ccff6e0de80: fa fa fa fa fa fa fa fa fd fd fd fd fd fd fd fd
    0x7ccff6e0df00: fd fd fd fd fd fd fd fd fd fa fa fa fa fa fa fa
    0x7ccff6e0df80: fa fa fd fd fd fd fd fd fd fd fd fd fd fd fd fd
    0x7ccff6e0e000: fd fd fd fd fa fa fa fa fa fa fa fa fd fd fd fd
    0x7ccff6e0e080: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fa fa
  =>0x7ccff6e0e100: fa fa fa fa fa[fa]00 00 00 00 00 00 00 00 00 00
    0x7ccff6e0e180: 00 00 00 00 00 00 00 04 fa fa fa fa fa fa fa fa
    0x7ccff6e0e200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    0x7ccff6e0e280: 00 00 fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7ccff6e0e300: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    0x7ccff6e0e380: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
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
  ==1500371==ABORTING

Verify that the file is large enough to contain both the header and the
footer before computing the table size.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/table.c                |  5 +++++
 t/unit-tests/u-reftable-table.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/reftable/table.c b/reftable/table.c
index f4bc86a29d..b4d3f9e211 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -562,6 +562,11 @@ int reftable_table_new(struct reftable_table **out,
 		goto done;
 	}
 
+	if (file_size < header_size(t->version) + footer_size(t->version)) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
 	t->size = file_size - footer_size(t->version);
 	t->source = *source;
 	t->name = reftable_strdup(name);
diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index c7dca45e70..28b0ef5258 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -262,3 +262,31 @@ void test_reftable_table__seek_invalid_log_offset(void)
 	reftable_table_decref(table);
 	reftable_buf_release(&buf);
 }
+
+void test_reftable_table__new_with_truncated_table(void)
+{
+	struct reftable_ref_record refs[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 42 },
+		},
+	};
+	struct reftable_block_source source = { 0 };
+	struct reftable_table *table;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+
+	cl_reftable_write_to_buf(&buf, refs, ARRAY_SIZE(refs), NULL, 0, NULL);
+
+	/*
+	 * Truncate the table so that it is large enough to read the header, but
+	 * too small to also contain the footer.
+	 */
+	buf.len = footer_size(1) - 1;
+	block_source_from_buf(&source, &buf);
+
+	cl_assert_equal_i(reftable_table_new(&table, &source, "name"),
+			  REFTABLE_FORMAT_ERROR);
+
+	reftable_buf_release(&buf);
+}

-- 
2.55.0.795.g602f6c329a.dirty

