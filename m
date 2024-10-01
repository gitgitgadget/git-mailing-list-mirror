Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0719F415
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775746; cv=none; b=LUZ6XYKcTjz/f/R/dESApYGJ5uMnJpHAD8r0Ij6X2DJeGVYaUu9vAHwzOcXV47JttS0DGN0H/KbNN9A2JOQxzgqR15qKIYkTLO8IIKoZIkd5e7Y8SvNnjUkZtM4+u9ZOOzd3n159IXajDuRaJHtYYHdYuWGKgHu2WMLVzyplOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775746; c=relaxed/simple;
	bh=TnMRuxLvOthM2Fk74dI32ReBzQNqW+VMyT2XyPacCdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8CSikPpkrrQBg8n9eIR302BdHS/UcX+ZiPItOdRls3ErMQ2Unf8qEU67rj6uFyCtm1g+v9Xyc1Ez0OIKh9QUaijJw6K75cZMunqVuQX8vvbl9149EjD7ueOrmXuSn6rcBRgN3nM8tM9znkYcL5xg+PwW3U2J+zBXNKVEi1DMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qwvUh+IN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nKk0qhy/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qwvUh+IN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKk0qhy/"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6110A1140E2A;
	Tue,  1 Oct 2024 05:42:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 01 Oct 2024 05:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775744; x=1727862144; bh=s4W/aPV3Ti
	GffFf15PzGX7aV+sCgI87f2r0PJ+GUM4M=; b=qwvUh+INqOedvC6MwMBBcWl6qp
	8KlO/WN4wWy5k4GEC9ljKx1WR6VmjFHzJ922p+Uo0yFomvXpk5AQWbduJJohSMkY
	O4ZzKLFau4fj3OXQ75pglKNEE+Y4wZJr8DbI2yhyJcg7wUo0H36q3WPIJIsNUwL4
	z56w1yRwHFaB+77LIo7FqW1uEXUQKJGY/2uO5IkWiVL7CmjhfWtQH4f7681DEpRl
	AJZmccjUIiy8rv1td2uMRhSdbjSLlA+pc7mpd+Eo0oaqLhyrKV+m4Icpr88wfocm
	zB7EOum36dmASH9cD7eVBz4YrD9tCzo2YWjQIhlc6bt04aleaepy6kyET46g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775744; x=1727862144; bh=s4W/aPV3TiGffFf15PzGX7aV+sCg
	I87f2r0PJ+GUM4M=; b=nKk0qhy//Uf6YeTHbS2Rsz9+7MXf+zvno2m2Hr3vSVE+
	scr1L4w85guGFd95xB4wDiZ85TPtW4gqUGC5jW0yS3zL4viSKgd3AsgTVkfAGYYC
	FDydQlOukqqm3Rikl4+ADYdhjTekKj4TohW8JcoUVwQUsLcTU4uMJ2kfdvBNZtM8
	raSatIvOwHSfKA/X+Gi19hUVFFiNLLHThDDm9LfWdPWVKWtoftbdESyD7xM9YAmT
	CSoT06PF+NLCVOJGBQLwyR1+Z34R7idirofFbazLv8FLuGWi5ltZcY8SxKwuIlH3
	tbqyvb66iMl8F8p/aOQnU64yOM7WKBFqBTaje0ED5g==
X-ME-Sender: <xms:AMT7ZqPdJ1RkjkIDF_qG3rm_tZ6gFqwSazF01XeJ1mhovMNPW8FNRA>
    <xme:AMT7Zo_sU5oeoBa1T5tyqMDYnmoefkR9--bWujiiu3gOWeQOl2IQMrRXzzFdpsGoa
    BkUcuPiy5E4E8yiqw>
X-ME-Received: <xmr:AMT7ZhSLeCmE2lByfZ5jFMIMKO9kBarLUH8JfIHJPsUsR0cLceULnIwcHgOUFipJVVwuj91Vzr-mZXSdBaetqQdA1-53sRMIXqEdui_SdFpa2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:AMT7ZqubmsgSamqmLrC0IRjIhmK1oFT_4w65_Ynh7DydcfVXHm2sbw>
    <xmx:AMT7Zieul1muJpmjvpQYkpTKoOob5J8ioXZ78h7TJAqelswgpRPmKg>
    <xmx:AMT7Zu3M5ko6M0zKolQ5NT8dNXGCJ_6v6ykPNjgqzwtQop5LJtfBPg>
    <xmx:AMT7Zm_AeyM9XPBWWi04KUdGxdabrs9hnwkYB_vel1fkI3Pu0_BRCQ>
    <xmx:AMT7Zh5OdYXK7fTDx0LKUwMKxbiAQWsgUt4LW4_8nnRHSn4xdXbzb6Mv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 952f8114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:35 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 12/25] reftable/reader: handle allocation failures in
 `reader_init_iter()`
Message-ID: <ceed83826537cca26cc04d237efb298343dcde14.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

Handle allocation failures in `reader_init_iter()`. This requires us to
also adapt `reftable_reader_init_*_iterator()` to bubble up the new
error codes. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                   |  4 +++-
 reftable/reader.c                   | 28 +++++++++++++++---------
 reftable/reader.h                   |  6 ++---
 reftable/reftable-reader.h          |  8 +++----
 t/unit-tests/t-reftable-readwrite.c | 34 +++++++++++++++++++----------
 5 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index de4f81abaf..69790c345c 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -244,7 +244,9 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 
 	for (size_t i = 0; i < mt->readers_len; i++) {
 		reftable_record_init(&subiters[i].rec, typ);
-		reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		ret = reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		if (ret < 0)
+			goto out;
 	}
 
 	REFTABLE_CALLOC_ARRAY(mi, 1);
diff --git a/reftable/reader.c b/reftable/reader.c
index 485ee085da..f696e992df 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -554,32 +554,37 @@ static void iterator_from_table_iter(struct reftable_iterator *it,
 	it->ops = &table_iter_vtable;
 }
 
-void reader_init_iter(struct reftable_reader *r,
-		      struct reftable_iterator *it,
-		      uint8_t typ)
+int reader_init_iter(struct reftable_reader *r,
+		     struct reftable_iterator *it,
+		     uint8_t typ)
 {
 	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
 
 	if (offs->is_present) {
 		struct table_iter *ti;
 		REFTABLE_ALLOC_ARRAY(ti, 1);
+		if (!ti)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 		table_iter_init(ti, r);
 		iterator_from_table_iter(it, ti);
 	} else {
 		iterator_set_empty(it);
 	}
+
+	return 0;
 }
 
-void reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it)
+int reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it)
 {
-	reader_init_iter(r, it, BLOCK_TYPE_REF);
+	return reader_init_iter(r, it, BLOCK_TYPE_REF);
 }
 
-void reftable_reader_init_log_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it)
+int reftable_reader_init_log_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it)
 {
-	reader_init_iter(r, it, BLOCK_TYPE_LOG);
+	return reader_init_iter(r, it, BLOCK_TYPE_LOG);
 }
 
 int reftable_reader_new(struct reftable_reader **out,
@@ -689,7 +694,10 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	struct indexed_table_ref_iter *itr = NULL;
 
 	/* Look through the reverse index. */
-	reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	err = reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	if (err < 0)
+		goto done;
+
 	err = iterator_seek(&oit, &want);
 	if (err != 0)
 		goto done;
diff --git a/reftable/reader.h b/reftable/reader.h
index 3710ee09b4..02d10c5d37 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -56,9 +56,9 @@ struct reftable_reader {
 
 const char *reader_name(struct reftable_reader *r);
 
-void reader_init_iter(struct reftable_reader *r,
-		      struct reftable_iterator *it,
-		      uint8_t typ);
+int reader_init_iter(struct reftable_reader *r,
+		     struct reftable_iterator *it,
+		     uint8_t typ);
 
 /* initialize a block reader to read from `r` */
 int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index a600452b56..6a2d0b693f 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -46,12 +46,12 @@ void reftable_reader_incref(struct reftable_reader *reader);
 void reftable_reader_decref(struct reftable_reader *reader);
 
 /* Initialize a reftable iterator for reading refs. */
-void reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it);
+int reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it);
 
 /* Initialize a reftable iterator for reading logs. */
-void reftable_reader_init_log_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it);
+int reftable_reader_init_log_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it);
 
 /* returns the hash ID used in this table. */
 uint32_t reftable_reader_hash_id(struct reftable_reader *r);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index e1b235a5f1..acca927a2c 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -206,7 +206,8 @@ static void t_log_write_read(void)
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 
 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
 	check(!err);
@@ -221,8 +222,8 @@ static void t_log_write_read(void)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	reftable_reader_init_log_iterator(reader, &it);
-
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
@@ -296,7 +297,8 @@ static void t_log_zlib_corruption(void)
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
 
-	reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "refname");
 	check_int(err, ==, REFTABLE_ZLIB_ERROR);
 
@@ -325,7 +327,8 @@ static void t_table_read_write_sequential(void)
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
@@ -376,7 +379,8 @@ static void t_table_read_api(void)
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, names[0]);
 	check(!err);
 
@@ -419,7 +423,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 	}
 
 	for (i = 1; i < N; i++) {
-		reftable_reader_init_ref_iterator(reader, &it);
+		err = reftable_reader_init_ref_iterator(reader, &it);
+		check(!err);
 		err = reftable_iterator_seek_ref(&it, names[i]);
 		check(!err);
 		err = reftable_iterator_next_ref(&it, &ref);
@@ -435,7 +440,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 	strbuf_addstr(&pastLast, names[N - 1]);
 	strbuf_addstr(&pastLast, "/");
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err == 0) {
 		struct reftable_ref_record ref = { 0 };
@@ -534,7 +540,8 @@ static void t_table_refs_for(int indexed)
 	if (!indexed)
 		reader->obj_offsets.is_present = 0;
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 	reftable_iterator_destroy(&it);
@@ -593,7 +600,8 @@ static void t_write_empty_table(void)
 	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(rd, &it);
+	err = reftable_reader_init_ref_iterator(rd, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
@@ -802,7 +810,8 @@ static void t_write_multiple_indices(void)
 	 * Seeking the log uses the log index now. In case there is any
 	 * confusion regarding indices we would notice here.
 	 */
-	reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
@@ -858,7 +867,8 @@ static void t_write_multi_level_index(void)
 	/*
 	 * Seeking the last ref should work as expected.
 	 */
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
 	check(!err);
 
-- 
2.47.0.rc0.dirty

