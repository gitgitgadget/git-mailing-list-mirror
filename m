Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E08C18BB94
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422366; cv=none; b=ebw3Y/ykJ/1QIZhan/kwTXLZIEfRNcUfiEbU5Ezjsb5yhGp6/XWN8A3wJeLurXEeQiPt93b4pGWHVhNPWFQOK0r7rUibMhuyqSUi2f+6iH7fM98xRnwkD8FIQTlhHmQMlQ8aDzSD0C6TJUs+qYfLqgQSNilpqj+zu9YdhBMYKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422366; c=relaxed/simple;
	bh=nktoUlX1I5/mhgC7giDFsmwkfdc2tGUfBldMysdUMjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9shrUJWnYRE+JMMvRYDQFSYamaZBGXzMiRUE0LhlZk2w5snIxQedZA8NNbvnr8aSuwWS63bvOAoHmi69Sm0uDaNGTtj2OrDuWHduP1yChM+hRZaA6Ru6WL5H+Acq1sKgxY5odOHhMiwD30B0+smzYJyPBZCnCIpRNnxiixzssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m9eMONNI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLknHfGd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m9eMONNI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLknHfGd"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 32AB0114875E;
	Fri, 23 Aug 2024 10:12:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 23 Aug 2024 10:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422363; x=1724508763; bh=Wd2a0r7EKv
	9Bk5KCWTcXYDg7eiRLDUaKIaLs9Oe0i9w=; b=m9eMONNIofSREqscJSzjvOVGYM
	vmf1umCF9udgquTmyTnQOb2hLOAk5oQHFKNPyZ1ARPx4zwKbCqd8TqpiswjgQdta
	K/L3SviGFQ6IbdlQg9eAqzU9kgY8PP+dr1FEc44sqjk4YNBrE/0urw8lyX67KMaH
	sNm5INkDf8ZimPPYW6T4FSZQgMQRhsccmMizCjtLCLtP320YE5v3l3hgH8Lfes3h
	hMFbgFJXhQl+mGAlv3+canQIZlnCROENAnzX/HGclG5uq+/MevP5lQLkhP5ulN0E
	/cl2A9uoDcHJsFfQZ+1ljH7afhI6kpLHYgzXbCvZ7uHILWikeSG5BIIsgBFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422363; x=1724508763; bh=Wd2a0r7EKv9Bk5KCWTcXYDg7eiRL
	DUaKIaLs9Oe0i9w=; b=hLknHfGd44ogE5OUF/H8cef60OyRyJMn1hOxSpcurDN/
	EFIc2pW4xSR5uioHsXPNxL0eFk7R4/4JnMCpXrz4IGDm0NOafh33xTqrVY+77QXi
	KN8lOc3cqncDnT57m3dfw9pDD4KH86yaXYUo2KQQMeGnOxwbSf8GVn3vOWoK1BtE
	865Hq5G+2yStvKH2tlDiNcCS9XJBXzI/YskKgZCgSVESfYxeq7vXeidgF401octV
	qMa+GBjnlDF+q+YRYDXxUj19WTYifoFc0Gw7yIcvRLQeGywhwfHvIticcCx0SFK7
	/7eoHLVs1Hb4hHlNZiSlFZZahHCVrQjZq4DD8BbHMQ==
X-ME-Sender: <xms:25jIZlGnQI2WV24boJSzLun4bEnPdiEV8WgDl9C1wUsqm7csupQZxQ>
    <xme:25jIZqUffP-YyIq1yo29p36tBGuIqvnjLH8VwtNNLLaZ9BCp9Pg0-eH9fQ0jLFhKX
    PbDY0oE1Wspdre7CA>
X-ME-Received: <xmr:25jIZnIPxIVXQrJeGUYIbhmZniXn_Jp-F9YoU2mwnwrZaln_5oickFc1LycV_yCKUsQX-L3Ybq51kXt4OMUjFnUXPioVcdIfTbGWLHXrcrrKDSDJ4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptdetudffkedtffelvdeghfeuvdekieeuheeiudfgjedu
    ffegheffleelkeetjedtnecuffhomhgrihhnpehosghjpghofhhfshgvthhsrdhishenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:25jIZrFrVnjwBMk0HIq25mhBhrmGX95hfR7xQuKlY5TDo1c3TSihZg>
    <xmx:25jIZrWk_OKbdqb68QPlB2s275ofivStaCb-5-zlG8bBF4HFx-gdqA>
    <xmx:25jIZmNbT-9rZX2xW_ZD4zoHqMqNkTheFdl80d4yCSPrpCbR16vuPg>
    <xmx:25jIZq1sxry6I4cnZMr7E4rgB0ki6B5J-P5fw-xMbCjm8XL5V7_IOQ>
    <xmx:25jIZhwEBhDsNvSfJM1eztyWIuI1mtovFuMDjGZb8b7VSV3_8jZGKp8x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7eff9d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:12:05 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/10] reftable/reader: inline `init_reader()`
Message-ID: <3b6670975011ea5126c6584be48500b9fc241ab0.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
 <cover.1724420744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724420744.git.ps@pks.im>

Most users use an allocated version of the `reftable_reader`, except for
some tests. We are about to convert the reader to become refcounted
though, and providing the ability to keep a reader on the stack makes
this conversion harder than necessary.

Update the tests to use `reftable_reader_new()` instead to prepare for
this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c         | 122 +++++++++++++++++++-------------------
 reftable/reader.h         |   2 -
 reftable/readwrite_test.c |  73 ++++++++++++-----------
 3 files changed, 98 insertions(+), 99 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index ea4fdea90b6..9239679ad95 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -162,58 +162,6 @@ static int parse_footer(struct reftable_reader *r, uint8_t *footer,
 	return err;
 }
 
-int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
-		const char *name)
-{
-	struct reftable_block footer = { NULL };
-	struct reftable_block header = { NULL };
-	int err = 0;
-	uint64_t file_size = block_source_size(source);
-
-	/* Need +1 to read type of first block. */
-	uint32_t read_size = header_size(2) + 1; /* read v2 because it's larger.  */
-	memset(r, 0, sizeof(struct reftable_reader));
-
-	if (read_size > file_size) {
-		err = REFTABLE_FORMAT_ERROR;
-		goto done;
-	}
-
-	err = block_source_read_block(source, &header, 0, read_size);
-	if (err != read_size) {
-		err = REFTABLE_IO_ERROR;
-		goto done;
-	}
-
-	if (memcmp(header.data, "REFT", 4)) {
-		err = REFTABLE_FORMAT_ERROR;
-		goto done;
-	}
-	r->version = header.data[4];
-	if (r->version != 1 && r->version != 2) {
-		err = REFTABLE_FORMAT_ERROR;
-		goto done;
-	}
-
-	r->size = file_size - footer_size(r->version);
-	r->source = *source;
-	r->name = xstrdup(name);
-	r->hash_id = 0;
-
-	err = block_source_read_block(source, &footer, r->size,
-				      footer_size(r->version));
-	if (err != footer_size(r->version)) {
-		err = REFTABLE_IO_ERROR;
-		goto done;
-	}
-
-	err = parse_footer(r, footer.data, header.data);
-done:
-	reftable_block_done(&footer);
-	reftable_block_done(&header);
-	return err;
-}
-
 struct table_iter {
 	struct reftable_reader *r;
 	uint8_t typ;
@@ -637,16 +585,68 @@ void reader_close(struct reftable_reader *r)
 	FREE_AND_NULL(r->name);
 }
 
-int reftable_reader_new(struct reftable_reader **p,
-			struct reftable_block_source *src, char const *name)
+int reftable_reader_new(struct reftable_reader **out,
+			struct reftable_block_source *source, char const *name)
 {
-	struct reftable_reader *rd = reftable_calloc(1, sizeof(*rd));
-	int err = init_reader(rd, src, name);
-	if (err == 0) {
-		*p = rd;
-	} else {
-		block_source_close(src);
-		reftable_free(rd);
+	struct reftable_block footer = { 0 };
+	struct reftable_block header = { 0 };
+	struct reftable_reader *r;
+	uint64_t file_size = block_source_size(source);
+	uint32_t read_size;
+	int err;
+
+	REFTABLE_CALLOC_ARRAY(r, 1);
+
+	/*
+	 * We need one extra byte to read the type of first block. We also
+	 * pretend to always be reading v2 of the format because it is larger.
+	 */
+	read_size = header_size(2) + 1;
+	if (read_size > file_size) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	err = block_source_read_block(source, &header, 0, read_size);
+	if (err != read_size) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	if (memcmp(header.data, "REFT", 4)) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+	r->version = header.data[4];
+	if (r->version != 1 && r->version != 2) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
+
+	r->size = file_size - footer_size(r->version);
+	r->source = *source;
+	r->name = xstrdup(name);
+	r->hash_id = 0;
+
+	err = block_source_read_block(source, &footer, r->size,
+				      footer_size(r->version));
+	if (err != footer_size(r->version)) {
+		err = REFTABLE_IO_ERROR;
+		goto done;
+	}
+
+	err = parse_footer(r, footer.data, header.data);
+	if (err)
+		goto done;
+
+	*out = r;
+
+done:
+	reftable_block_done(&footer);
+	reftable_block_done(&header);
+	if (err) {
+		reftable_free(r);
+		block_source_close(source);
 	}
 	return err;
 }
diff --git a/reftable/reader.h b/reftable/reader.h
index a2c204d523c..762cd6de667 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -52,8 +52,6 @@ struct reftable_reader {
 	struct reftable_reader_offsets log_offsets;
 };
 
-int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
-		const char *name);
 void reader_close(struct reftable_reader *r);
 const char *reader_name(struct reftable_reader *r);
 
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 101cdb5cd66..2f2ff787b26 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -195,7 +195,7 @@ static void test_log_write_read(void)
 	struct reftable_log_record log = { NULL };
 	int n;
 	struct reftable_iterator it = { NULL };
-	struct reftable_reader rd = { NULL };
+	struct reftable_reader *reader;
 	struct reftable_block_source source = { NULL };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
@@ -236,10 +236,10 @@ static void test_log_write_read(void)
 
 	block_source_from_strbuf(&source, &buf);
 
-	err = init_reader(&rd, &source, "file.log");
+	err = reftable_reader_new(&reader, &source, "file.log");
 	EXPECT_ERR(err);
 
-	reftable_reader_init_ref_iterator(&rd, &it);
+	reftable_reader_init_ref_iterator(reader, &it);
 
 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
 	EXPECT_ERR(err);
@@ -254,7 +254,7 @@ static void test_log_write_read(void)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	reftable_reader_init_log_iterator(&rd, &it);
+	reftable_reader_init_log_iterator(reader, &it);
 
 	err = reftable_iterator_seek_log(&it, "");
 	EXPECT_ERR(err);
@@ -279,7 +279,7 @@ static void test_log_write_read(void)
 	/* cleanup. */
 	strbuf_release(&buf);
 	free_names(names);
-	reader_close(&rd);
+	reftable_reader_free(reader);
 }
 
 static void test_log_zlib_corruption(void)
@@ -288,7 +288,7 @@ static void test_log_zlib_corruption(void)
 		.block_size = 256,
 	};
 	struct reftable_iterator it = { 0 };
-	struct reftable_reader rd = { 0 };
+	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w =
@@ -331,18 +331,18 @@ static void test_log_zlib_corruption(void)
 
 	block_source_from_strbuf(&source, &buf);
 
-	err = init_reader(&rd, &source, "file.log");
+	err = reftable_reader_new(&reader, &source, "file.log");
 	EXPECT_ERR(err);
 
-	reftable_reader_init_log_iterator(&rd, &it);
+	reftable_reader_init_log_iterator(reader, &it);
 	err = reftable_iterator_seek_log(&it, "refname");
 	EXPECT(err == REFTABLE_ZLIB_ERROR);
 
 	reftable_iterator_destroy(&it);
 
 	/* cleanup. */
+	reftable_reader_free(reader);
 	strbuf_release(&buf);
-	reader_close(&rd);
 }
 
 static void test_table_read_write_sequential(void)
@@ -352,7 +352,7 @@ static void test_table_read_write_sequential(void)
 	int N = 50;
 	struct reftable_iterator it = { NULL };
 	struct reftable_block_source source = { NULL };
-	struct reftable_reader rd = { NULL };
+	struct reftable_reader *reader;
 	int err = 0;
 	int j = 0;
 
@@ -360,10 +360,10 @@ static void test_table_read_write_sequential(void)
 
 	block_source_from_strbuf(&source, &buf);
 
-	err = init_reader(&rd, &source, "file.ref");
+	err = reftable_reader_new(&reader, &source, "file.ref");
 	EXPECT_ERR(err);
 
-	reftable_reader_init_ref_iterator(&rd, &it);
+	reftable_reader_init_ref_iterator(reader, &it);
 	err = reftable_iterator_seek_ref(&it, "");
 	EXPECT_ERR(err);
 
@@ -381,11 +381,11 @@ static void test_table_read_write_sequential(void)
 		reftable_ref_record_release(&ref);
 	}
 	EXPECT(j == N);
+
 	reftable_iterator_destroy(&it);
+	reftable_reader_free(reader);
 	strbuf_release(&buf);
 	free_names(names);
-
-	reader_close(&rd);
 }
 
 static void test_table_write_small_table(void)
@@ -404,7 +404,7 @@ static void test_table_read_api(void)
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
 	int N = 50;
-	struct reftable_reader rd = { NULL };
+	struct reftable_reader *reader;
 	struct reftable_block_source source = { NULL };
 	int err;
 	int i;
@@ -415,10 +415,10 @@ static void test_table_read_api(void)
 
 	block_source_from_strbuf(&source, &buf);
 
-	err = init_reader(&rd, &source, "file.ref");
+	err = reftable_reader_new(&reader, &source, "file.ref");
 	EXPECT_ERR(err);
 
-	reftable_reader_init_ref_iterator(&rd, &it);
+	reftable_reader_init_ref_iterator(reader, &it);
 	err = reftable_iterator_seek_ref(&it, names[0]);
 	EXPECT_ERR(err);
 
@@ -431,7 +431,7 @@ static void test_table_read_api(void)
 	}
 	reftable_iterator_destroy(&it);
 	reftable_free(names);
-	reader_close(&rd);
+	reftable_reader_free(reader);
 	strbuf_release(&buf);
 }
 
@@ -440,7 +440,7 @@ static void test_table_read_write_seek(int index, int hash_id)
 	char **names;
 	struct strbuf buf = STRBUF_INIT;
 	int N = 50;
-	struct reftable_reader rd = { NULL };
+	struct reftable_reader *reader;
 	struct reftable_block_source source = { NULL };
 	int err;
 	int i = 0;
@@ -453,18 +453,18 @@ static void test_table_read_write_seek(int index, int hash_id)
 
 	block_source_from_strbuf(&source, &buf);
 
-	err = init_reader(&rd, &source, "file.ref");
+	err = reftable_reader_new(&reader, &source, "file.ref");
 	EXPECT_ERR(err);
-	EXPECT(hash_id == reftable_reader_hash_id(&rd));
+	EXPECT(hash_id == reftable_reader_hash_id(reader));
 
 	if (!index) {
-		rd.ref_offsets.index_offset = 0;
+		reader->ref_offsets.index_offset = 0;
 	} else {
-		EXPECT(rd.ref_offsets.index_offset > 0);
+		EXPECT(reader->ref_offsets.index_offset > 0);
 	}
 
 	for (i = 1; i < N; i++) {
-		reftable_reader_init_ref_iterator(&rd, &it);
+		reftable_reader_init_ref_iterator(reader, &it);
 		err = reftable_iterator_seek_ref(&it, names[i]);
 		EXPECT_ERR(err);
 		err = reftable_iterator_next_ref(&it, &ref);
@@ -480,7 +480,7 @@ static void test_table_read_write_seek(int index, int hash_id)
 	strbuf_addstr(&pastLast, names[N - 1]);
 	strbuf_addstr(&pastLast, "/");
 
-	reftable_reader_init_ref_iterator(&rd, &it);
+	reftable_reader_init_ref_iterator(reader, &it);
 	err = reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err == 0) {
 		struct reftable_ref_record ref = { NULL };
@@ -498,7 +498,7 @@ static void test_table_read_write_seek(int index, int hash_id)
 		reftable_free(names[i]);
 	}
 	reftable_free(names);
-	reader_close(&rd);
+	reftable_reader_free(reader);
 }
 
 static void test_table_read_write_seek_linear(void)
@@ -530,7 +530,7 @@ static void test_table_refs_for(int indexed)
 	int i = 0;
 	int n;
 	int err;
-	struct reftable_reader rd;
+	struct reftable_reader *reader;
 	struct reftable_block_source source = { NULL };
 
 	struct strbuf buf = STRBUF_INIT;
@@ -579,18 +579,18 @@ static void test_table_refs_for(int indexed)
 
 	block_source_from_strbuf(&source, &buf);
 
-	err = init_reader(&rd, &source, "file.ref");
+	err = reftable_reader_new(&reader, &source, "file.ref");
 	EXPECT_ERR(err);
 	if (!indexed) {
-		rd.obj_offsets.is_present = 0;
+		reader->obj_offsets.is_present = 0;
 	}
 
-	reftable_reader_init_ref_iterator(&rd, &it);
+	reftable_reader_init_ref_iterator(reader, &it);
 	err = reftable_iterator_seek_ref(&it, "");
 	EXPECT_ERR(err);
 	reftable_iterator_destroy(&it);
 
-	err = reftable_reader_refs_for(&rd, &it, want_hash);
+	err = reftable_reader_refs_for(reader, &it, want_hash);
 	EXPECT_ERR(err);
 
 	j = 0;
@@ -611,7 +611,7 @@ static void test_table_refs_for(int indexed)
 	strbuf_release(&buf);
 	free_names(want_names);
 	reftable_iterator_destroy(&it);
-	reader_close(&rd);
+	reftable_reader_free(reader);
 }
 
 static void test_table_refs_for_no_index(void)
@@ -928,11 +928,11 @@ static void test_corrupt_table_empty(void)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_block_source source = { NULL };
-	struct reftable_reader rd = { NULL };
+	struct reftable_reader *reader;
 	int err;
 
 	block_source_from_strbuf(&source, &buf);
-	err = init_reader(&rd, &source, "file.log");
+	err = reftable_reader_new(&reader, &source, "file.log");
 	EXPECT(err == REFTABLE_FORMAT_ERROR);
 }
 
@@ -941,13 +941,14 @@ static void test_corrupt_table(void)
 	uint8_t zeros[1024] = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_block_source source = { NULL };
-	struct reftable_reader rd = { NULL };
+	struct reftable_reader *reader;
 	int err;
 	strbuf_add(&buf, zeros, sizeof(zeros));
 
 	block_source_from_strbuf(&source, &buf);
-	err = init_reader(&rd, &source, "file.log");
+	err = reftable_reader_new(&reader, &source, "file.log");
 	EXPECT(err == REFTABLE_FORMAT_ERROR);
+
 	strbuf_release(&buf);
 }
 
-- 
2.46.0.164.g477ce5ccd6.dirty

