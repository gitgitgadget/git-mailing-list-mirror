Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB51DFE36
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052903; cv=none; b=JWnzEwB/uTP/D8ckFtcresSVmKP3XYVcsnCZCDHaddSwBHpTdVQGxjBIU6EbvcwiGOyxgxD0WfghaNKDSzUaw5DGuUwwBYS0TBoksq2NMiyC5lPLFGtnl0iHyiYfT1vlqgVvVIVga+ypihecR90kILJIUzagnNjDzclA9BaqIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052903; c=relaxed/simple;
	bh=ihLF34Kh3KEFnHLYIyJ4ZIKsd32TWzp4NSq8yVDamWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/piNn1gr5vpoCzvb3dCvPVVp3qcI62JWnuq7oEiYQe8rKcs0ivaBSfCvhcGPrtrkblBNcKllhpO/zyoyx7mJoz5ybE3QSDWfSVkL7QlFc90bSWGIGmzYZJ+1sCfsjERIopyqopsk03GzkBKNMnTSyoHBfRFHPuyfJnvDNUlYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RJErwZML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z2O+2GlG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RJErwZML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z2O+2GlG"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56FE3254024F;
	Tue, 28 Jan 2025 03:28:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 28 Jan 2025 03:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052900;
	 x=1738139300; bh=b+Euunc3x+y+OvvlvQau2yVS5rSSELXS6sZ42aQZK0g=; b=
	RJErwZMLcf97pkbf/3BluGICPMNqajC+JAB6qDyTOfOEBL8yJCpwFoTSDryXPQhp
	jSZl3p/ICPjoeLC44VLH9XG6lVkd5ZO01/27q0o4YUrLo0u9FsXRfLq466Iw/Q8r
	3R9TUcA5AtxLFu9ii7YiH06AT5GsF/nLTPXRuQTJh+RT+qFYIOCfHDq5WgR9F6HK
	QXuEFhjYYuxBnhFVQY8jOd1pTV7PlBY3EL83/jpfKirKEKBWeyEAyjYZTn3RPPcp
	xOvqpLmPRA2caxjf989n4MJ2W/vR7zfUdICIptcfbD3ryVugKdcQf4K0DsLEajji
	NJERbkQKYeIeGWXa7uWlFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052900; x=
	1738139300; bh=b+Euunc3x+y+OvvlvQau2yVS5rSSELXS6sZ42aQZK0g=; b=z
	2O+2GlGxNWSO2B8xpXvMX/lrFW7f6Fcem4+Xp5Btq1vPjmrskOBO92NL82krOrGm
	LelaJMrQOf2LEXO84gjgniivDkdBGo+TIzmMEPpa+cGT4BWy5AnJE82yTPgrJZkZ
	ENRtuVPtIjVa576biqjL++yrGw3uaWClOYmx/hJKZ48LH2Eo8tl6TmoagXoZ/6I7
	hxx4pGSffzXRpIUg9WDgbFFOlyAXUi0QYC8Zoxt0F1P0VGrY0BPY5ZZbxgHR1xMl
	qR7ZI1B58qLoJ9cksFz5lI5WWPYKolD/KBzWkiFXmH0hq81yfNiDzHTUq79ZuEWP
	6ZWSl5clgctCG+shAn7Tw==
X-ME-Sender: <xms:JJWYZ9w4mFinLSSFleCCkaJimrvFirSU7-HgPuYtL_2TybDr0HdTyw>
    <xme:JJWYZ9T5q_ZgUhg4nNX63ay9xugKJD024ItqmNAPSDl5lQBC9Dm-DO63i_5o6Fycc
    4VbQZRZVwi-Lc73ug>
X-ME-Received: <xmr:JJWYZ3UvfqgrP1b_cu_IQPbHIBskDbz2HwAX81Snm0jYYCafgrxGnl2orX9p0z9-1i4hAhX-1XFHq97MlD-leRgLx3MkmD79wSk0YiWZZWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:JJWYZ_i-HJdwTHTr8vq8cN8Tm72fqOYj0Ak-kl5M4pkBccF4H5qX4w>
    <xmx:JJWYZ_Djs4NJfbDCctU_17z7IH2kLc1uX1OjGqvVExtRExdwk_dsxA>
    <xmx:JJWYZ4JJiHSD3H8tKZAIEcSxmQOQANfu1JI4OWlwabjJuHj9uJ5TvA>
    <xmx:JJWYZ-CphwLC-38hALGewNLRJoXAFTzxsYfUS-Ksa_As2TtdDQES_Q>
    <xmx:JJWYZ6-UUJi-5v_qzryqfixFb1ao9X3pZBG2IJovIQHq9Kl8EOizn7oJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff933276 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:06 +0100
Subject: [PATCH v2 05/20] reftable/record: stop using `BUG()` in
 `reftable_record_init()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-5-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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

