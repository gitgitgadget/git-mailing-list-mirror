Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D277388885
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289441; cv=none; b=GLbFMKYGo9xnGsaMjMlpRew3wdCaSHNwyFlddPaXXEnpzuec2WenfEbiKqP5zDv87QpDOTg1fFcj13439eAmCJFJROIFUeHqyp55WatgwtISfPZnXsSkS3cp4VNpZMAHXLOGy/Kto5kgbjUpnjjJ0ICFkcKYwB620bB4oM4J4yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289441; c=relaxed/simple;
	bh=4YqjiqiBLRq8uupf/oW5ii2RH8glwYvHWLl0+WpHa24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UruTuCgHaPSt1Vin4yzWvZzbMqOA9LS9IEiC+5dpGOYpqngh/ECUQfwBVgvpKIglM613kEloMrOujrdc3FHPNe5WWEj0zAhVVk8pRgotfQ2dELp2tgxZsRoNQLhN/V+EMYze/lRXMpmpT+PoF8zHmmdlCcROPU9eNhSp8hLYAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cm1ee7Sq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QJiJvV6r; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cm1ee7Sq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QJiJvV6r"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A30271D00114;
	Wed, 24 Jun 2026 04:23:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 04:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289437;
	 x=1782375837; bh=rsDEMb6BeUqdqZs7Jh6rdO/gt1VxEYnmoHRgw6KH3GA=; b=
	Cm1ee7Sq5Nj1ekNC4VgB3FbC7WvtamHnEOZYUW5Qabi6GnTUELa9utR8VOHMuU6E
	vMEXy6EynCPw/t88KiXKFK1GZZKUih32v3QpAUXEw/61lLeR+uLlWl9Y5rYM55O8
	mqvpVosZNWDYJBWuXbbGr//maSUquclCsxpkAL5rGcIBB31ZdZILEf2HPuLDhldk
	EZ07cJlqnOUl0dBpgAxP4cSSbBs97aaIuYhTDune9P1m8SfSeWgA1cVtHDEsjudT
	aVT0iHuaWgNUDoyEJuz1Wg37YTt5Mbn/OoieEG0/SRevSEOX+06RsdoP5SBgrXY6
	ndkzVl+BXgJ1U/VI8jEA9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289437; x=
	1782375837; bh=rsDEMb6BeUqdqZs7Jh6rdO/gt1VxEYnmoHRgw6KH3GA=; b=Q
	JiJvV6rQnrEDbp3FxAn4lheq9ZKOHccrwAnWFz2jubLXMwdUInWY9H9IbbCN7PSy
	8sbMSpIRkaM3Pg1lGLQL3cKe4LpncL5qhAhbZsn+ZhYmkSD9ybn9ifcbKmGPAvdR
	qZMGEmd1JMgsdf9sxVclKcqB27+6tuoNtbrhg2K2DWkC1qo/tfFIEXPva0tzxno6
	w6sI5j5nTgX/oQSIHDF8WU/rcyfHrBiJBd8dag6pynGmZ3xn42V8oczqngzMmk/H
	7kewe8GqsimvGuubyKNriRITsPyPQg+YDjE+vYjNFWjzkiFmfrc0vCVF+Mi9Y64o
	kGjwa9OAdaAGDz6MA4n7g==
X-ME-Sender: <xms:HZQ7av_DtHCGUtnsBmIYOsvaXpCGpgIB4wqxRAr4rGKDReT5VU4_eg>
    <xme:HZQ7ahsttg4pI1yB7asTZqQtEZD9DjYYPMUc2a-mzD_axtBE1DIT7IewUrIGFKt45
    yIw9BLSUZNTsQ0TOFbRdGK-KOES6ont67DTltEUYPWp1-xRpMXK>
X-ME-Received: <xmr:HZQ7aqpsRCMHeAUOmPBDp7J0PTsN-tH-Q2kB87gtg7pR3wq4neCu4-vzcryj7ckDDAs-up1mumBPE2FiKS6yBoHDnFp-1hvWt8tVc9E->
X-ME-Proxy-Cause: dmFkZTF5hBnW8Zc4d7S1uAh+fmg3Dt0FwS3nxeTFy+hj0o6mo+y4+VBO6vm7IoOHRV40eb
    Jt9AFXzWoALKEiUr7yBcaqQX9dt0NW8rrQmaLcsxzdo512oNNcKUBP3O3cjmlbes+S4FST
    oxJ2bBcScSMPlIVMlGjmZGX0ANoxj2N4Czh4+0SZhhX1L2YkGhi47dUkgnnYdmWEXlJxAq
    wHcdqsLNpVHCHjzQxeSM2wa5tJfqzdGAsia0cKYMuNUCt7VLbxx0q+yWF1MjYkEp17RqWc
    2nvo8bpZxio9Hx81F235vhWoXZUu2CfhQVqZEl0hfqQH6epZWcq57QnA+InlLIyKolcUcT
    kiw7pR/Cm5Nuk0CCirrsBqWtPI4AcbZQrTrfv+vuOKmjvprYlBPm/ch3TkIxP7cLWxUNMg
    nWgJ61NHjIHpHhCjsQH2kxlnnVFQoD+HGsKs0iiAmavDvoLt/1SxfTU0Go6v/kSTQQgE0o
    38QLCRUSApUK3pOF4ne0CZ+KdmPBWLqYCJLl8qFIW8+6tCtSljRpqxv2n7k8IN06v7nS0k
    DNA/JDPfuElzD1znvgcv2mMc5U7k/+jUB4s8g5gVehQWNiU1uBdN8nD3BsrLYixt/TUojV
    /ojHhtFrRKk/EqHtDqbwQce+iZ1bxak9P6vv05TKDaeDt+BddNaLNLj0UZcg
X-ME-Proxy: <xmx:HZQ7amlJVT5HexmzzfuMQ_ObXH0q6wgM1MIU6s02KUA2LlJF2mSEdg>
    <xmx:HZQ7amwV187eMt2c3UHYPe_uJkZrFaF9Duv_gtmHD_ozuTUKv4okoA>
    <xmx:HZQ7amkS-1N8UQt3q_hq12ZvHnNT9ckiVEgIp2gJaTPy_XP4aCyeWQ>
    <xmx:HZQ7anff0TYYgW_u57lkbqhFGqW0vr7Q5ZjSbV7jerJksugacvWeIg>
    <xmx:HZQ7anYeEqfVW0wVmoGGtdmcANytm7YxmdC0F_0vB2vXKqFKb34aVv5->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b6679e42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:14 +0200
Subject: [PATCH 11/11] reftable/table: fix OOB read on truncated table
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-11-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
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
2.55.0.rc1.745.g43192e7977.dirty

