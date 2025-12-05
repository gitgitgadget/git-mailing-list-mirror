Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78070809
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939494; cv=none; b=FuH9mH3uiMBCEZ97OX5phS7j8ttHmZIgyuXt1OgqkJDU/ePB3rEIcv/F/jDP38ebsotZSqeFA0eIvoLzpqcE6cYbut+oTqzEEpE3+Z9ts32cuSgH651o02MbuBI/YJftYqZTiED+gge1sBkuW2hIvfXfJZAgNQaMKU6CL15i/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939494; c=relaxed/simple;
	bh=nHwOJs01BxK0jPfZwBrW09wV7df9YwNDuczcrOgOSWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atM9JsbbwOiU7znSMAJiyxdXSF3Xdgu+CaQLCXowjkkLVLite3lJOo5oEl2q0yFy300Sk8cHCwjyXUqPj2ZeQBwcNEGnAa2ufyUBHxD7U1kO4jvlXEcRwZDsYOIQziiKKJzWtPlq8P4aUCbHiIn33VmMYfYPKetH1bstXzQga4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aDYpD7/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTtCyCZ3; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aDYpD7/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTtCyCZ3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F388D14001DA;
	Fri,  5 Dec 2025 07:58:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 05 Dec 2025 07:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764939488;
	 x=1765025888; bh=YjtvdWYXop0y5Z9YlJZG1OhVm3LOff5SFVe/Wyg98i4=; b=
	aDYpD7/J04Ry6MhhJLO8y9c+ip1UUPvZyLCSO00OrPZ/FE8EAel8dzl89D3p9pRv
	P/rUEWjxR0YK1vkKHvPpDhjSauKgkrzGbN9WrOf6F+pe09ofgnNzVG/Ye5SIXk4j
	kG29BDeurDk7PBfLLc2Ig8kWeLop7iARGQWYWKCwWB4V5rv+GwB+wB6QdtANaoyl
	hnV9CMVZIfJP7q5+ciMZI03EKrE2DUblnb1sZELuWZuQ4PmuuPkjBtxuGFcVnGZi
	sflcDItYLJz/jMPXSijI4YvtfTh2Pqd6zJ70yoN6IntrAfkEf4YTihj3ylyQ5gDF
	dIWRw6qvyH4r8raCNPcwsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764939488; x=
	1765025888; bh=YjtvdWYXop0y5Z9YlJZG1OhVm3LOff5SFVe/Wyg98i4=; b=o
	TtCyCZ3FOaL8T5DjsXXY15VoOGq25CdrE/NguusxpzcnbvQ7UuJYK0qHRz0tBoCQ
	REmS2/8dw7JSmMcgMJl5FX8COsnaLdGQal8fOrQ6c4Us90RlDYmxmvWqJ9sqLrTr
	Byh+4NDin/ZlQDguLp/dA6cpn/6IegquMaoQd1SM9ZbqXSGaLIznFeBQBYDXZtKK
	YXU7ELfihDMOsZZ2785i020+/WIPmILA4qEx/g5usZd1XEF9aPEdpz0pe9EhvGV+
	+V1dliYuq0xY9h0aGr32ZQRl1D9JmqFc3P+8TXZf7XhqlV+3Pv7w0GQGkf1YbZy0
	HSp8TCjaMVxQBa/wpj/2Q==
X-ME-Sender: <xms:4NYyaZ8mmWLCyo96GTSrfCLmkOhyDprUw9D-lXTOE9BWftWZs5VeWA>
    <xme:4NYyaVJDTsJVVDm9R2SCqRtS1Hx7zllj9t7vrt6zqJ6323cAorEY5g4dpEZ3Pv3W7
    7Q6-UHLdV7rh1c8ovk4Brb2wHocEUQtZraI2XDf1D-wsUPeWq9-ex0>
X-ME-Received: <xmr:4NYyaUZe5GsnRPFqqxfsZz4tYkqI_a-fawDtR3P5NMnDMWkF6PQGshqTRpdGONwn1VGVYClvAL-kVhVnT6ed2Q1j_r9sDM3NOOSElh8C6e4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:4NYyaXKLQaK-BJapv3tOf3RUSYrqdfV8ynLR3FFJUi-3wngT0Py_Tw>
    <xmx:4NYyaSBHqswJAQOnxRYofDCxgZg8jAX0jvNmwJu7_PmdM7y4NzXlHA>
    <xmx:4NYyacqJeHyN_VKFtLJI78Ca9sZPLINJVBAFMg6k9q_nnnFAr1g9Kw>
    <xmx:4NYyadgwKetb50AZtIxwKCkXZs-Ep3kOD9ETmla4s3vdbLeavrtlgQ>
    <xmx:4NYyac3NO8JnWRiuSjMgf-l210ote_tMs4Pt__gz432QMnE2zvUAoet1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 07:58:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98304b0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 12:58:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Dec 2025 13:57:53 +0100
Subject: [PATCH 2/2] t/unit-tests: demonstrate use of integer comparison
 assertions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-b4-pks-clar-update-v1-2-fd70aac2ab90@pks.im>
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
In-Reply-To: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.3

The clar project has introduced a couple of new assertions that perform
relative integer comparisons, like "greater than" or "less or equal".
Adapt the reftable-record unit tests to demonstrate their usage.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/u-reftable-record.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/unit-tests/u-reftable-record.c b/t/unit-tests/u-reftable-record.c
index 6c8c0d5374..1bf2e170dc 100644
--- a/t/unit-tests/u-reftable-record.c
+++ b/t/unit-tests/u-reftable-record.c
@@ -51,10 +51,10 @@ void test_reftable_record__varint_roundtrip(void)
 		int n = put_var_int(&out, in);
 		uint64_t got = 0;
 
-		cl_assert(n > 0);
+		cl_assert_gt_i(n, 0);
 		out.len = n;
 		n = get_var_int(&got, &out);
-		cl_assert(n > 0);
+		cl_assert_gt_i(n, 0);
 
 		cl_assert_equal_i(got, in);
 	}
@@ -110,7 +110,7 @@ void test_reftable_record__ref_record_comparison(void)
 	cl_assert(reftable_record_equal(&in[1], &in[2],
 					REFTABLE_HASH_SIZE_SHA1) == 0);
 	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
-	cl_assert(cmp > 0);
+	cl_assert_gt_i(cmp, 0);
 
 	in[1].u.ref.value_type = in[0].u.ref.value_type;
 	cl_assert(reftable_record_equal(&in[0], &in[1],
@@ -184,7 +184,7 @@ void test_reftable_record__ref_record_roundtrip(void)
 
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-		cl_assert(n > 0);
+		cl_assert_gt_i(n, 0);
 
 		/* decode into a non-zero reftable_record to test for leaks. */
 		m = reftable_record_decode(&out, key, i, dest, REFTABLE_HASH_SIZE_SHA1, &scratch);
@@ -228,11 +228,11 @@ void test_reftable_record__log_record_comparison(void)
 	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
 						REFTABLE_HASH_SIZE_SHA1), 0);
 	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
-	cl_assert(cmp > 0);
+	cl_assert_gt_i(cmp, 0);
 	/* comparison should be reversed for equal keys, because
 	 * comparison is now performed on the basis of update indices */
 	cl_assert_equal_i(reftable_record_cmp(&in[0], &in[1], &cmp), 0);
-	cl_assert(cmp < 0);
+	cl_assert_lt_i(cmp, 0);
 
 	in[1].u.log.update_index = in[0].u.log.update_index;
 	cl_assert(reftable_record_equal(&in[0], &in[1],
@@ -344,7 +344,7 @@ void test_reftable_record__log_record_roundtrip(void)
 		reftable_record_key(&rec, &key);
 
 		n = reftable_record_encode(&rec, dest, REFTABLE_HASH_SIZE_SHA1);
-		cl_assert(n >= 0);
+		cl_assert_ge_i(n, 0);
 		valtype = reftable_record_val_type(&rec);
 		m = reftable_record_decode(&out, key, valtype, dest,
 					   REFTABLE_HASH_SIZE_SHA1, &scratch);
@@ -382,7 +382,7 @@ void test_reftable_record__key_roundtrip(void)
 	extra = 6;
 	n = reftable_encode_key(&restart, dest, last_key, key, extra);
 	cl_assert(!restart);
-	cl_assert(n > 0);
+	cl_assert_gt_i(n, 0);
 
 	cl_assert_equal_i(reftable_buf_addstr(&roundtrip,
 					      "refs/heads/master"), 0);
@@ -432,7 +432,7 @@ void test_reftable_record__obj_record_comparison(void)
 	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
 						REFTABLE_HASH_SIZE_SHA1), 0);
 	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
-	cl_assert(cmp > 0);
+	cl_assert_gt_i(cmp, 0);
 
 	in[1].u.obj.offset_len = in[0].u.obj.offset_len;
 	cl_assert(reftable_record_equal(&in[0], &in[1], REFTABLE_HASH_SIZE_SHA1) != 0);
@@ -485,7 +485,7 @@ void test_reftable_record__obj_record_roundtrip(void)
 		t_copy(&in);
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, REFTABLE_HASH_SIZE_SHA1);
-		cl_assert(n > 0);
+		cl_assert_gt_i(n, 0);
 		extra = reftable_record_val_type(&in);
 		m = reftable_record_decode(&out, key, extra, dest,
 					   REFTABLE_HASH_SIZE_SHA1, &scratch);
@@ -535,7 +535,7 @@ void test_reftable_record__index_record_comparison(void)
 	cl_assert_equal_i(reftable_record_equal(&in[1], &in[2],
 						REFTABLE_HASH_SIZE_SHA1), 0);
 	cl_assert_equal_i(reftable_record_cmp(&in[1], &in[2], &cmp), 0);
-	cl_assert(cmp > 0);
+	cl_assert_gt_i(cmp, 0);
 
 	in[1].u.idx.offset = in[0].u.idx.offset;
 	cl_assert(reftable_record_equal(&in[0], &in[1],

-- 
2.52.0.239.gd5f0c6e74e.dirty

