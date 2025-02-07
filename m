Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A91DF967
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929132; cv=none; b=j7lQ+lfEGwkV5TKg0lZg1XLx649L0jfbr9GJd3f9pqOrz1g25O+H55bUeovsCw6cjnS56woHzyqB5R3eQpcRHkK3uzCMRCd3HA3eCuZaVlra+cpkz6KDPk56Sykx878LppkRHhke/StUj2mXmKVcV0d++i4P0lR+iKAEHMa/tJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929132; c=relaxed/simple;
	bh=9/A1Bccc2cIxVF/mcHaqQ905YH53c82cafmO7EtfsUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtBg3rZifCxpP9dXRelkOJZLaedQV/LNrT/Rtjhg9xDEVus87T7HG+5waCnNcMMKxjPCskT9dzSEo2cO3AOaBvfi96KNjnTr2T7Zepy/moiUCrYZfGN93hfqDYZUH5YiKjnvifuD28QaBOvbIxiPMnU6/Si1wHUAbDteeqamkhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dmTul//w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jmhqCFBE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dmTul//w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jmhqCFBE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 602FE13801A7;
	Fri,  7 Feb 2025 06:52:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Feb 2025 06:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929130;
	 x=1739015530; bh=ZJx+EF7rq9i9fC06psF/6Mk0ZFHRyDowMH9Dx6Yzo0I=; b=
	dmTul//wJbn6VLvD3Hpb2eFG2b6cAjRKpUeuvQvBQXFV01wu72CSVuSftJW2CSmd
	93N+/e9Keb/7VW8IuWV+gCuI7iqNo5s2R7rK/6ZjGqhy5CUXiOvZ4u8g5IHiLifV
	BVn8BbbYc1VSaukBeuSVHtvVp/utJ9s2yPH5lb+HjocWvZd4yo+BjCaZhQ0O3phu
	TC4LWxFeIl1wF8AmXlg8TuFSpeSQYr/r0iJ2FyK5IuSZ20AHCqwgJdH9n1Ni2pqv
	xV4EeRoYjW3VbUAZVK09UVQqBH+twijrbyHXi1t3f71nvQ34N/yrHPaekCn87j1i
	HNgqA7rYPY/pUs472gBfZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929130; x=
	1739015530; bh=ZJx+EF7rq9i9fC06psF/6Mk0ZFHRyDowMH9Dx6Yzo0I=; b=j
	mhqCFBEkpV5EKUKfbZW6asIhVqfIwz/d1QEcr7PPHHvFhKXsORTCoxIVCdHqcPeH
	uMiRRoYayhrR8b3i2kOIim+viyALmW+fBqnwQWpbApz7x3Iii9mXUwkpy0SHIp5T
	MUzchYG43ErnYBgURE4BGLnfIxvdRkV8ldhcI+9imBahnnLzDCVe6qMu1xsZkozt
	G1d0/Zhe+jbLK0vwr7EfWlZ3/TyYNG0OaR+2iV9CKXt/zf9BPknCv2DQaeCxczuX
	Iq5zuCo5LU7ZdksT71GvI7rFJd3v47ehZHDJWyyUx/p5sivZCbXJ5yGn3T3uJvLM
	U8X7VPL8MMvbU4VQckQGw==
X-ME-Sender: <xms:6vOlZ0KxcDgokZJuXzgHeLRpfq1ZkoL8zki_J_J7B8y3JhaScedCew>
    <xme:6vOlZ0LhCjSZsn0qtFp1KADbKGcR6zpZxMLsgHk8JTGmD2FBnkI-G-v3w2XM3gkni
    Zk5vhWgXpFMDTHMRg>
X-ME-Received: <xmr:6vOlZ0uNO8ty1fr15AM2JXtVRDnC2pJ1F87SLN7sU3BSKGgkTPBq2adUvVxRyuQyR1lnXnb-B40Bt_b-06lZbCWnRxp0kooJXKQvQ5GeVEIhmTxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6vOlZxb3U5kn_JR1dkokcOO95X7iZMMj6ZWYdEVMt2DQRCUThiReVQ>
    <xmx:6vOlZ7a8SdEkgNe6wIDatkppyXdlP3YZKr4-8Sda3xzfpmgBU3rDOg>
    <xmx:6vOlZ9B5n6gRA8bRNUE3vR7IWOLV0vS2s6vqt1bZgT1TIioM3dp8pQ>
    <xmx:6vOlZxZPtTFAJXj4pxMJDN1g3iGKvmdJPj30WjobDWlsWA2Bne9zwA>
    <xmx:6vOlZ2ycO2hMYaRWGRdU8QZcxi6w8pwtfH6NFuXVzywQLk9sJEXi84HA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2462f6c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:00 +0100
Subject: [PATCH v5 05/18] reftable/record: stop using `BUG()` in
 `reftable_record_init()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-5-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
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
index 2c0cc32cbd..1e18f8dffb 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1306,7 +1306,7 @@ reftable_record_vtable(struct reftable_record *rec)
 	abort();
 }
 
-void reftable_record_init(struct reftable_record *rec, uint8_t typ)
+int reftable_record_init(struct reftable_record *rec, uint8_t typ)
 {
 	memset(rec, 0, sizeof(*rec));
 	rec->type = typ;
@@ -1315,11 +1315,11 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ)
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
2.48.1.538.gc4cfc42d60.dirty

