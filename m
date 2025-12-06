Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BA28934F
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021689; cv=none; b=dBhE5S0wesL/+6HCnGYQ2jDkzYxK0TjN63P8jaCfZbT0VTn5SYsFZ1KhZSCbkJnev0IpqDG2AipQ+w4ey2y6/98I4YON4DgnTgROlmLV7/fpBLCdFKurGnXi/VGNvwFdSwG2RP7xRVbfvRcXCMcO9DWw13PnwT3xXdXjoKKcfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021689; c=relaxed/simple;
	bh=nHwOJs01BxK0jPfZwBrW09wV7df9YwNDuczcrOgOSWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cDOjJ9CsT9vbAH0xj6D5H0mAFRa8WqtOq9CO9In5rCjFhOezyof7oWWT7m6Dz0Uk0YygTrvEurZXLdm3ej4lHcCAK6Wt3cCTkiQPpoPcmYwN+EQHRvCsx4rN6RmSi0qYPqcBgTz/kQ95JQfJobUYHbgFxjfT84f/WA6I0+Vmmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vpawdjdq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D7w8aFQu; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vpawdjdq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D7w8aFQu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 35B967A0110;
	Sat,  6 Dec 2025 06:48:05 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 06 Dec 2025 06:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765021685;
	 x=1765108085; bh=YjtvdWYXop0y5Z9YlJZG1OhVm3LOff5SFVe/Wyg98i4=; b=
	VpawdjdqV7+LGzopGpxMAONhxfbyiYgxNrlc3/vPrutAGPjLbgQc2qepJOX/Qmoy
	EROGcZedSRIIxnBMVuQVMlgwXU8GQ5sMIKULuO6iwH5REgswhxoRylLpV4pFfHNH
	gvzDVbbyBIJiIpnM++F2N6DS9Kn4HcRfanXblepBm++g7E/1cR7RyyYY6KJgi887
	nT/1wrTDXm7hxTxCR+YYAl8VmPEQnV5hjl6I4PXfNW0NWpCZVyjElIXkahgT3eQj
	0zM17QpXOvsJFIWtfuqg3CJHT6EbBe/y8rWuRzAWtIiuJ/lIdl7jCutYMAm3ORT2
	w8e6kOafr+fpGQmlrmhXwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765021685; x=
	1765108085; bh=YjtvdWYXop0y5Z9YlJZG1OhVm3LOff5SFVe/Wyg98i4=; b=D
	7w8aFQudSM9etdWf0Olb+ebv6P5eQoMXONwQrfOPBd1UFM0/+6zjoE3LJ+3bPvWk
	hPz4rupp0jLTCpJaom9d3fKsJr8f/VtcDCBpYHDJ+NINYhhChaIMcrQtsPitxjRk
	7lqdcUIIutUNWFfzo4MCmEOtO+zitdkY82SJZ2JvVv/aoyTneOKvzaISwpuoODBt
	7EKOtmsuIvE0i92SWBKDNXuwMk51RUvQju0XIkD8pmt+rmo5BRiGddHSmlNKaR4s
	62KQImJcih80qBdEUJfVE9xKn5aMhslhOQk39/nL2tOKO6V6wdrzw07Xi7IVvp2M
	Lc07BfUKJJEUMqVs8pDCA==
X-ME-Sender: <xms:9Rc0aXK9wkIx2hra8mFBdzO9MS2WzyMN4Y2rfDb-VZPo4k_f5jMd-Q>
    <xme:9Rc0aSkNCZZIwbsKKpJlhSN7McUTovj2vxJkp2rsegqF7fVQSQXSHjL38JfD6eNyB
    iSDprN4Uole7uEPyHoYj_7bsFC237Yp5tjsnXusxZr9WXWxL83HJw>
X-ME-Received: <xmr:9Rc0adF49-e6wPibLCKbp_Ae0LpB1N7naWSbp4gdKAyAhe2yJWgtqZUPejNzwxc8O8s2CCU0CKoyHe3pcm2YuO8uNAW7K84TXGUIwUM9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:9Rc0aaG6YKJjPY2AVtGiMTg8uW06o-YLDf_qmIX66v-BKjUCqHdGFQ>
    <xmx:9Rc0aSOYqR-PJk_w3kUZpVemXAgSt_6lYkhAwJSoyOO2J8QZQsdh4Q>
    <xmx:9Rc0aRG6un71FiyNiwPlIWKNzZjlfYjOTxJCGn_474w3omQdNRT7fA>
    <xmx:9Rc0aROJK2wmMoF7UY--Wx7ChXVu171W3HPI6iS3EonHh-uegFkMag>
    <xmx:9Rc0afQe578AwDXMFDhEBOU90jtoLCFnQAkOnfT2hXl1Dvkg08LJIw04>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 06:48:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 872b63ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 11:48:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sat, 06 Dec 2025 12:47:33 +0100
Subject: [PATCH v2 2/3] t/unit-tests: demonstrate use of integer comparison
 assertions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251206-b4-pks-clar-update-v2-2-9a14b10c1a36@pks.im>
References: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
In-Reply-To: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
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

