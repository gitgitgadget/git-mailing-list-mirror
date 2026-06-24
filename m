Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A3B3AE184
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289428; cv=none; b=fUIoi1TVbaUsXX4s1k/tUwI6v/g8ZvsHRPyekrVyfJYjK7lS1Tcnk9TOuGX78qAV2f91TMslLcyhL9/Tfm0MmVuLPGoX/qV/6fQxeemqAxjN+6VqduDapKdynRa+lgL+fCFZg0T+Vx3yS2k86JfLafitX8z41DBeSzSMuReSFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289428; c=relaxed/simple;
	bh=hGMIUFXUlJ5LEDZgTqZxyrVRfUEnHSExBR9BgLNtc3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NI+iZhkul8sIIH6gOpL7aSnQFhyGrsP9FYjYvVZWgnRXGQmoZMG2mAo2ydB0mRJgn6gGsespXaU+dmxh/IuSYYeJFSbajD3PFYb1x1sDYne6LaP4oRblHSAzbLWm2MlKNujibr7iwr0G7VHoo/NZhuvRCuGYzg6X6xLqSBlF82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kji/uned; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kLvVBO15; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kji/uned";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kLvVBO15"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 313E17A01CD;
	Wed, 24 Jun 2026 04:23:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Jun 2026 04:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289425;
	 x=1782375825; bh=Koehk4/EXe2Ext74hXPpdDabJeylAACWqN0ruhCIggc=; b=
	kji/unedW5w3XiFDL3u8OM9y5/6EB9mWocj9MeCOUAZOM+KRMMYOVz+saQ3QBfS3
	tvj8CpaWZOT2Mvw6dmJ+iqYmkIa3sA5hBXGe6RDo+Bai8pKmLTND3EOTtHufYh9I
	6mEuM2ad7A8ocUpc3Nm3cljvH8aWDeQ67UG7H/makW97SqIa+WngShMQvbhgX/W6
	Ugj8H1fQcG9gEVB1za78mt3b8QUMBGY0kYjmeOb89HcfMGf1DCzkd+VhShIuEXmb
	xEhnoFONmtLTZjByOZWavGZV4WbTegImQVB5mswd1G7fcouEAA26LfiO0KZMYw9r
	YqyVa1rum4+3vdOowC/3fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289425; x=
	1782375825; bh=Koehk4/EXe2Ext74hXPpdDabJeylAACWqN0ruhCIggc=; b=k
	LvVBO15lEO0OgmqsP3wBxbaqNn1qHFWRe3tiG6dt3my4PP4HF1AJHnCuphwV6tx1
	wdO3cgSKDk17xToiKeKh7EVOow8tHd7+UcbRSia47U1vWOxNr683N0gWNZHJOtx3
	iw6Npbl9EDVitnRkebQyZAbfSgh8AzGqI6bQUVaQh0ommBbK4Hvluw2MY2pJqKJ7
	zfJ9xABrR+SyrI3TCDoIgLl/uWJbG0/MuhD7QB0Mvn4EA4NZZRR0qxziyQYUI6hk
	R7ACEhws9rvdge1ymkT786Wkb+btYyQ+CUiGEA8a1VdxgoG+NnZGx0c05ay5i5kO
	1HgZin2SuTY8F4W8jArhg==
X-ME-Sender: <xms:EJQ7akWautf0Xd-aUWI50XS9RuR4Ls-fQhmVrCSVXznaoZw879ZOAw>
    <xme:EJQ7aulMPWcD02HhFN6odgfU0Z5tOMeppmFmugeVdDS27UALQ-kexTADj6JkV7dNJ
    wW8KXd8u3MwjcPfR7X2EoXEfAcrSTbBY1vJ_m5grm0nJAXnwXxB>
X-ME-Received: <xmr:EJQ7amALSDGP7eNATE8aVWe1grdn-6hHiyEk54dH73T7P7QBINsCC9Q7Q4ZlG8bZBlVyjTMdPOQORDDNNv7P1J-vzcszpWqSb8Zz-qKe>
X-ME-Proxy-Cause: dmFkZTFTscqWTzOgOVM/4h4ujciNGkBDY0kDO0Jobz36NHnUpRxOxioedCPyL7xWpOQw3l
    jeETOFwa/qNaB9LTKJz+KOPAwg0TQnLAPBhWGEV0aANZMT2e+K2pZ2mucHNoI+yNJoefVi
    Qwu0XNTRUD95z8teh8/Tjx5/DjYDKfwL3x79bg2/Cb56q7qrGP6pqoT1wOcuounxmPsCqh
    LqWbDbnxbVYa1rS6yOPp7WFUt2jOL38SLXOkW50bowX305d0iyzxINuQFJR5GsAtOiUqds
    OPuNR7NpO1+GA2KWIwAO2JhHE9z4Xyxgp27UVzFsLE86cntwOv8mZEUCU8vz1LjbZcfdUH
    A/yVlaYPBwedCODDHF9C7M4lBDiwtmyqRUjme4SEYd1e2UBfv+J6II+iUq/8+r4BLZot0B
    VLrOX08cx7xIJ6ARYshHTdHJVTk+frgE1rgOSCfGq2K6uCHQZwcAN9Nyhpvw5exteWe9DA
    wGI6p/lrsyAGZZpiMrjTFByCk2Zptg87DOS4LNvGzxPYzLgYbtcoUmUr9DeXEROY2xSc66
    ayASpVOcCklskv8Fhqzvhc7uVsS3mZ6Dtx8E+BwK/Cxglx11LFTcfMc6H1yS2B+Gil2XFB
    JiUkX9Pjk1eBTKiXc4RN5/tc09XQYLHEep4MHnbbiYWxL+SKPwS8Z1Av0j7g
X-ME-Proxy: <xmx:EJQ7audgP5pdlal_1hzo8-32U6mOm7EDcN2XjfdZrWhiDSU5syrZIw>
    <xmx:EJQ7ahJKxi4IV84mYHTx8740aDkcU8-ii70ttCMWzBCFQslOJa_xeg>
    <xmx:EJQ7ahehKZPGrA6yNy3seeA7avtM3eyV_ZLgXJuLR4UvTUXZ61bkfg>
    <xmx:EJQ7ao3zPF4sYqkRZzzC3e1lsgTLLoJtXFP11nwIg3mKNHofDvA5bQ>
    <xmx:EZQ7atysPJvNOW_rlbwf0txnSOViecxaJ8yQ0CNnhN1mBH5w_5C1nQSW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d57a20b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:09 +0200
Subject: [PATCH 06/11] reftable/block: fix OOB read with bogus block size
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-6-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
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
 t/unit-tests/u-reftable-block.c | 45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

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
index 40274af5c0..1f35aed91a 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -500,3 +500,48 @@ void test_reftable_block__corrupt_log_block_size(void)
 	block_writer_release(&writer);
 	reftable_buf_release(&data);
 }
+
+void test_reftable_block__corrupt_block_size(void)
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
+	block_writer_release(&writer);
+	reftable_buf_release(&data);
+}

-- 
2.55.0.rc1.745.g43192e7977.dirty

