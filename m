Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0CC1FF1A8
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983063; cv=none; b=oohA13jZGMsuE0BqUol1+mwh4Wvej2/k8QMfvNUJtt48mF2k5VxqiessmuXF6VDsiFxSOddBLKJaYUoTSd3s4jfsBRYK7rMfUcwrjM9C5+/KZl6RcjP9iR+cam6nhR//0OS0tecXT7XCET0rzdO2Bb9rBciU81biZmwXkAlEgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983063; c=relaxed/simple;
	bh=ihLF34Kh3KEFnHLYIyJ4ZIKsd32TWzp4NSq8yVDamWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVuxcVcAiCvwh212WAjS/t9Jf9V7oL6nBcsftm+/PlIa1aJLoNkSB+oN+HnN8aeTXdRpu8qq0aOdoIExbcQhvSmLikD+CvgyNdrea6DSf0iYJhGQ1FReQbFgBIazQzBlaBL56HkU8c0e5XkXk4Dn77tTu43+vFa+b4f587XETVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DSLlOi5x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5WksFB1; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DSLlOi5x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5WksFB1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25BC11140235;
	Mon, 27 Jan 2025 08:04:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 08:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983060;
	 x=1738069460; bh=b+Euunc3x+y+OvvlvQau2yVS5rSSELXS6sZ42aQZK0g=; b=
	DSLlOi5xCvL+xgbvgPI+tUxVVI2/crzhinppNfINigWv9f5+PUr+APPwuLTMDhqt
	yQw2bC3OExXMA4spAMSuF4id7uPnRIFtxSD5L5rAqK/WOFZqxF7HIvOl4nK/GG4u
	9jh/QtM4sV2ctjvm4YmiueJ1fe7KNiymbxHUDAcpec6tRUiaEdxnL1zcM4AwtpFF
	jp2EzsOXaClWijPkAY04NvxLk759Q7OFp6uv/S2xmBeZbW5cNx6mzq+kE+m3NeXx
	3GmXOqEGr2JvKBWCryT9fkS+ePHzlm2npPW+b8PxAhYkTECjLP7m3W2DuRD1CIfg
	vErj11nNUP+pB7DgP9G0mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983060; x=
	1738069460; bh=b+Euunc3x+y+OvvlvQau2yVS5rSSELXS6sZ42aQZK0g=; b=S
	5WksFB1e6pFl5e3oZIRGFpRbkHmOjGE+0oj0ZhyPtIxCIycEC8RyY6jmBhIxbBI0
	CPo7KEIymRtvLWdP6Jr0Rz++I+pObjyZBj1vDnweqXs6a0LlK+zlaYniVkR6WRim
	WvemJU9OY5Lv71Vni0kd4rUrgerAfEXrNnUufKwJcfB2A8r/uRunKjUjN/rEqpyp
	gV3vmqkr+I4ddtkYafJbFtT+0jyaaZoBfzLaPvuyOZc8XENhjOwb6JZncsq2dbMy
	x4c+CCSASzRu3JNT8jpPAWbFACbESvlyAfq+Zs2fIzLT9B4X9X4eFsK4yHwGQoxZ
	r8P+Z6SmbsYVzobuBEhBw==
X-ME-Sender: <xms:U4SXZ8ns0BVByXOqICjY_zisqRCkAsuTDt1Iz8l4fRxv0etV4jRRMg>
    <xme:U4SXZ72D893Fslbmt_lf1Put9JmTtn50nsOTCIisX_CioztHxvvMgVDQM67UQ8fGB
    NmccRBNG8AiDJLO4A>
X-ME-Received: <xmr:U4SXZ6o9p5iIEoPa_jCePNMESeDR-B2PfherWKjm2sSyUqqCejrfvyUVKLNGt0o6iwc0Sb0Bg89MCId7hdCwimSo2CKz-R4brkNLezvXsbV0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U4SXZ4lpN8olmZEaTjXsXd55cs2FIBE5ARuhgdYFQit4rHHmKBMeMQ>
    <xmx:VISXZ63J-Dbb0oScCntg2Dik1W5Z3czorNEAq7JZqxb29PuyWlzQqA>
    <xmx:VISXZ_vogV_yB-W4gdjIbO3Z4rdsm6VkInrlHxARqvp90AVEG_cj_w>
    <xmx:VISXZ2VGo0U0C5r71HtAGxiO77LukZZu4nC4Z-Gj3o9I_OGUEnQUgw>
    <xmx:VISXZ4B_IPHegl4NVDlWIdKzXQM6owqxzRZIu4HBccUZG2mxb_3LOuiW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42bdcd3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:13 +0100
Subject: [PATCH 05/19] reftable/record: stop using `BUG()` in
 `reftable_record_init()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-5-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

We're aborting the program via `BUG()` in case `reftable_record_init()`
was invoked with an unknown record type. This is bad because we may now
die in library code, and because it makes us depend on the Git codebase.

Refactor the code such that `reftable_record_init()` can return an error
code to the caller. Adapt any callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c                 | 4 +++-
 reftable/merged.c                | 5 ++++-
 reftable/reader.c                | 5 ++++-
 reftable/record.c                | 8 ++++----
 reftable/record.h                | 4 ++--
 t/unit-tests/t-reftable-pq.c     | 6 +++---
 t/unit-tests/t-reftable-record.c | 2 +-
 7 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 8ac865ce78..255d566854 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -509,7 +509,9 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 	it->block_len = br->block_len;
 	it->hash_size = br->hash_size;
 
-	reftable_record_init(&rec, block_reader_type(br));
+	err = reftable_record_init(&rec, block_reader_type(br));
+	if (err < 0)
+		goto done;
 
 	/*
 	 * We're looking for the last entry less than the wanted key so that
diff --git a/reftable/merged.c b/reftable/merged.c
index e72b39e178..4156eec07f 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -253,7 +253,10 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 	}
 
 	for (size_t i = 0; i < mt->readers_len; i++) {
-		reftable_record_init(&subiters[i].rec, typ);
+		ret = reftable_record_init(&subiters[i].rec, typ);
+		if (ret < 0)
+			goto out;
+
 		ret = reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
 		if (ret < 0)
 			goto out;
diff --git a/reftable/reader.c b/reftable/reader.c
index 3f2e4b2800..de6e6dd932 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -360,7 +360,10 @@ static int table_iter_seek_linear(struct table_iter *ti,
 	struct reftable_record rec;
 	int err;
 
-	reftable_record_init(&rec, reftable_record_type(want));
+	err = reftable_record_init(&rec, reftable_record_type(want));
+	if (err < 0)
+		goto done;
+
 	err = reftable_record_key(want, &want_key);
 	if (err < 0)
 		goto done;
diff --git a/reftable/record.c b/reftable/record.c
index d1664c47ca..31985bb977 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1301,7 +1301,7 @@ reftable_record_vtable(struct reftable_record *rec)
 	abort();
 }
 
-void reftable_record_init(struct reftable_record *rec, uint8_t typ)
+int reftable_record_init(struct reftable_record *rec, uint8_t typ)
 {
 	memset(rec, 0, sizeof(*rec));
 	rec->type = typ;
@@ -1310,11 +1310,11 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ)
 	case BLOCK_TYPE_REF:
 	case BLOCK_TYPE_LOG:
 	case BLOCK_TYPE_OBJ:
-		return;
+		return 0;
 	case BLOCK_TYPE_INDEX:
 		reftable_buf_init(&rec->u.idx.last_key);
-		return;
+		return 0;
 	default:
-		BUG("unhandled record type");
+		return REFTABLE_API_ERROR;
 	}
 }
diff --git a/reftable/record.h b/reftable/record.h
index c7755a4d75..e1846c294b 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -130,8 +130,8 @@ struct reftable_record {
 	} u;
 };
 
-/* Initialize the reftable record for the given type */
-void reftable_record_init(struct reftable_record *rec, uint8_t typ);
+/* Initialize the reftable record for the given type. */
+int reftable_record_init(struct reftable_record *rec, uint8_t typ);
 
 /* see struct record_vtable */
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index f3f8a0cdf3..d8a4c283a1 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -32,7 +32,7 @@ static void t_pq_record(void)
 	char *last = NULL;
 
 	for (i = 0; i < N; i++) {
-		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
 	}
 
@@ -72,7 +72,7 @@ static void t_pq_index(void)
 	size_t N = ARRAY_SIZE(recs), i;
 
 	for (i = 0; i < N; i++) {
-		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = (char *) "refs/heads/master";
 	}
 
@@ -111,7 +111,7 @@ static void t_merged_iter_pqueue_top(void)
 	size_t N = ARRAY_SIZE(recs), i;
 
 	for (i = 0; i < N; i++) {
-		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		check(!reftable_record_init(&recs[i], BLOCK_TYPE_REF));
 		recs[i].u.ref.refname = (char *) "refs/heads/master";
 	}
 
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index d49d2a2729..6540bd20e3 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -17,7 +17,7 @@ static void t_copy(struct reftable_record *rec)
 	uint8_t typ;
 
 	typ = reftable_record_type(rec);
-	reftable_record_init(&copy, typ);
+	check(!reftable_record_init(&copy, typ));
 	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);
 	/* do it twice to catch memory leaks */
 	reftable_record_copy_from(&copy, rec, REFTABLE_HASH_SIZE_SHA1);

-- 
2.48.1.362.g079036d154.dirty

