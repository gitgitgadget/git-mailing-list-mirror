Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0C3F9298
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723773; cv=none; b=RSRraIuUAsKxLDao/rMadeq4xlMyf6WM7+W78qLTNitDCSyRWR0Suwh5Y9hpyHNWNwbErgISGHB9gkwOZmD0Ygk8QguNgePaFxQ7/BOxd3KTfS2EolNJxuK8+zIRRdneTZBa+3anbP6FV6pmSwjGushCD9780Dy1butmX7m0Cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723773; c=relaxed/simple;
	bh=xAqqX5mW9VIYF9RaeUSCPbIHqfQY9BQqzLcYf7nA+rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stJBHn05EC47XrCfuGJXvaEsH+zKjHSlOUw9wEUK45ayMJfs2m31CRAvAP0GOY0SUfFSECdmAr87HmLkF+DCONW/2BXx5/df0POuctzqBUt2IU34jrbyEJj1/1r/ULqAcLCMfDSHVryaqjWhI9OOpSzd6WQS/jkFdsZMYfw1IBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HYgAQYqP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbMeJH3P; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HYgAQYqP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbMeJH3P"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A43157A00EF;
	Mon, 29 Jun 2026 05:02:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 29 Jun 2026 05:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723771;
	 x=1782810171; bh=VUDQoxmzum4b2A3CA/501CUP1hnKd6HXBFmWwvNdeHI=; b=
	HYgAQYqP2bz4MKmptBPcEqo3LAyBXwyBhuNrCV3Q3Z4cVxIW6yEaqBoLii2+kVqk
	iFjWCDHnD+Kd6S7aHLxia8qCsK1QJHnHmpsml9FzM0hxYcAnYgRBfy2obMK9bZsb
	KEsWC+GloQrpR6jfoYcuEgt2ik8Ji0RvCVnapU4hI41Run2oIHFYWbyQ/64nRj+W
	L+x3j93C97wlRJj2xMNMIUsKxUh8Caajq/JrkmFFPfyKY8Lg4swDVAWPPhbZLBAc
	Aj0FqmH3KCIhrhcMkiVoJRKakY4PwjKKakjuMN+kkYTp8YiO9xMzNf9HZmNy5GuX
	6SqD2pNCOJSF6paHnhnI6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723771; x=
	1782810171; bh=VUDQoxmzum4b2A3CA/501CUP1hnKd6HXBFmWwvNdeHI=; b=M
	bMeJH3PqIgyDogY7vyuS17/Vmntoz3IPGYL1mvYZ22y7zy1GS4iGE4GBNpBs1QRF
	NXr16QNvGz/VtwAYEdzz225WvBpSXwhkMx+ocrgN1Ksrc3XPy/Hx7aonzLGl580e
	c5tZvTFhwRmtv3JVpnUF9/jpv78m4qeggKXIHIhhfq/pPiCfG76tBh8Ql2rZN987
	zoMCpSp0sMp3DhIFdBqV+gDJ6f+bUHcbeYoHuEpjbJ42MH9o7G5ZmUvKPCtXuhnZ
	vNt9f5AJl1uVRoBYrk+3s6jubjb0RE01iAbLpcsHEoxz1J09+SN+9uK8ORAupRXn
	lXsF5MeAZCt6CY3W+00LQ==
X-ME-Sender: <xms:uzRCaiJoxeTAatDx6n98t48Zp-WoejejCI8rOV80elQoYvSp7_wyXw>
    <xme:uzRCahnaxfCuva8I7WQQNm33J8B_HnUKUTpMck0RxTpghyb6dkA9otEpmVhCXGDlM
    NXq_8H1tFgMVerTBtf5xAwwoigWlYbyTN1mj-Wmy_0LxOldASd80g>
X-ME-Received: <xmr:uzRCagFbujesSSdSKkbkdL9G3JAuGxGi3IyG8Xdzifxpqi7exfJVOeYIIHK5hKASW9dLfCjfFqN8SmQ6MG9QVQn1J7edQk02ke_b0GAIGBZz>
X-ME-Proxy-Cause: dmFkZTFf78gZ4U0pV8g2y1IIGqqh2NaGrNkO7MwAw/Ul/PxXTDFsYY7TBS+5vpiy2xQ7kz
    hAKYtnO2uhrhKcBaCsJJYq2jPVxR8LLd87L7SpRvAxRPUIAFt+csN8nCQNTB5FmR62wCIP
    IbJQKlONF1vyW4B5TCQR+975Kr/6uN3lyeUY3bP4uI4r6V72gBE5za4Zgdo2EjWI2Z4+23
    zL+T+fL+VvnGSI7bzahZX0xa2GHAlT1G1LqqdC7L/nx7VON0p+oUNkhLwRzgAwDZGCVh/D
    QUao3LF4tlWzI0Yx+HzylfSpnzpnJRbJ6/5juiKS6UrTXnw6cxhucNlBjxqpyBz4ETehWO
    b4FyMRyn0/1MNky1u06epRfCmewcbPTEI6Ks0czx6bnQOEwxbf8LkyYiSJpxe8IorUBKGn
    cburlzKUeQVj/SCE2k32Npreb7tjCPJ8BYyrsqYKlN+zsC3/WvAw3ZrV6kTjuACQJz3i7C
    /zjryD9hRiNQaI2GJXdOslVnBrY0q2Je3Gd/ghf5hPDRovdtkcqLH3gKxZzrkqXPJ9vrq3
    8prJ8ncGcOnje85EqkS08N4Wb+i2xoCA/AuT70DaMi8BbvtpGjSSe2ETyoEGGJrlSZUIRw
    VuVRahS2Libx4Ou8GvARJXHAP4OqrEfWjRJ7pYG3jQFkau9S+BWpWCB/Fj5A
X-ME-Proxy: <xmx:uzRCahEp0tMQ5jYRZIY6pyHN9-7xo7oDfOcoKMRmLqJmZtUnLbsUMQ>
    <xmx:uzRCatM9bgXMIMuXk7siRjJVhAIhDSrnPaiBhMHE_DNft8X9Ftp3Ig>
    <xmx:uzRCagFmkV7o3Rhg4NuL9uL3liMV5Y_CITK7jSa9TbvwrwRhgJLQFg>
    <xmx:uzRCakNeTDqfMq-ajCS4K0OihPeOyn-L-IN63mAseSA2D9n6Q3ikMw>
    <xmx:uzRCaugbTybs-0P7k0been2ZOwMQW5QoxZuaamNxTrTQ8ASY3iNWAqXu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 424e04f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:25 +0200
Subject: [PATCH v2 12/12] reftable/table: fix OOB read on truncated table
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-12-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

