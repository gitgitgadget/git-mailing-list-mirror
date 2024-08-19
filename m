Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E961FD7
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081999; cv=none; b=INbRADpIQjs38jBQv4e74Hka8feL5auJ4VPEhtp438Z3iqflmM1fpBCTDjNlsFNW3H34DLlx6GOGt3WGmnFrncVTjF6gniaaLx4Z9Vq0AloONnSy1ugUoxbZ+vYLDeG/QXAL9v0CVwNvJhdb0jKHw/UeNRkSnk6GFzqVxSmJowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081999; c=relaxed/simple;
	bh=+HcxEy4aoEU84kakcmd8xbN5ovoPRYckyTfkiwvd6nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEhCfqFIFDQaX8Fk/TLq0282fi6tr1EVEHfIVz4zlpk6E6C3mtr61rmsWsiwhgknvSBbXqCYpTjciAat+o+CqQVsWgpP4VzD5ADmju9Ffc9HPxJtE0pHdmMnfq9UIpRQ/i5+O9Jn7/JPJ1Lee0FdtpQp8GwHpy3rHXjPfyqMMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hn+aANIy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSYvWVR6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hn+aANIy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSYvWVR6"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B364F1151A97;
	Mon, 19 Aug 2024 11:39:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 19 Aug 2024 11:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724081996; x=1724168396; bh=hO795mKdJJ
	qsrWeMFzNh+llv07v5LW2bwqpGVsA7mPU=; b=hn+aANIysp+S0nmYXN1RxTpCmn
	6ybx9JbOfNbukGReztlZzwYcZ6bCV+xuaHZFwjTQ9iP6Gjb5cIAYCWYG79ztNSJJ
	dLbWLq3RneMXLqhrYIl8m3DZeUCoO1OF3XQaUgj55HWclclpM3x1WM38W2I+4t0b
	TEWda5tmcp8FWDDqhAwAcRSqUW3APAhrl7BcQaqSOPCjj8wDmUk+bpP+T08gc3oT
	LBO6xPybObv7xgkHz7CA4KSdAXe0TQMPUZddr6XBDDTga9VRXePne6sukKz/YOmH
	oNiiMEvI0inGPZxydmOBqh/2mf839+h64GJjXIa4tS206LGJQmU0Wuqmwy5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724081996; x=1724168396; bh=hO795mKdJJqsrWeMFzNh+llv07v5
	LW2bwqpGVsA7mPU=; b=GSYvWVR6r1XJw363R/f+Kuiutl+zPhpn0aUy0/8QYgNA
	UC6X+++JZs2cFliK/AlijLk64DzVAqZ38DbWnEF4ccKMsOI+qMT8bIhctEGC7YCO
	80xjxXwk95vIsPjMF/UGHz9XPLvPXIPWYLVI75dXWbF97vrijU5HVKO6A3ddm3RN
	Sb+HcM/mbfr74EP1BL83JNAlVmTerjMm9v3CT/0qIC7vgF6zv/qvz+c/w9IWTYtD
	INZRJeduBmFVBDdsnZDqMP3RkMECTMU3k/nGfYt5ki0l6tCava2ID0+2r6nxalPY
	kxU2rt2v5Tx19ki3ZmePGE+BKo+caJGap8KuI8LA5Q==
X-ME-Sender: <xms:TGfDZmocG2RjhcGjcwpqxRzNeRka6Xwl-AcIzzc2QhsuzZiO2fmn2w>
    <xme:TGfDZkpxwGBjSnH-l4TVLzYr3ZIIfGswWp_-mjsJAb1etGXOPEuJDTioyQPkbER5l
    C2Im8EcWUtas4alxA>
X-ME-Received: <xmr:TGfDZrMQUasLJN7sNa12_Kz4vOZs7d7e4EH07wIg9ai9VCesyHg8EvkOeqEWHlT9d3Xvm5EHeXrvrnutM-9gyf1FttfLA0vF-lft6oXFCa7cjgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtteduffektd
    ffledvgefhuedvkeeiueehiedugfejudffgeehffelleekteejtdenucffohhmrghinhep
    ohgsjhgpohhffhhsvghtshdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TGfDZl5abKq8thpiQSxzn0-9euJ4d2v6XU9hyv3l42uWujwZ_njBbw>
    <xmx:TGfDZl6yPvgsMO6R10QLolY0xEMP3Pwr5UiTf8P-g8VR7D5cbN4i-Q>
    <xmx:TGfDZlgCgXoVlD4aE82Nh_cHjz5wM9CJiLODl3zXAxtESKWhG-lYCQ>
    <xmx:TGfDZv6gxvxcnMxGUPOidbGEUfIw6CuRGmAZeCo1dfO_WnlA_l1kwA>
    <xmx:TGfDZlFtPtc4I0jGNipnYTdGfHZTT9DOGd0XxHB_7YPlE3b16gAZ1-nn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:39:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a837db9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:26 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:39:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 04/10] reftable/reader: inline `init_reader()`
Message-ID: <f628b7dafb9f4b253ff27c116b5f7f29794a3520.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

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
index ea4fdea90b..9239679ad9 100644
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
index d8cbfd6404..762cd6de66 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -52,8 +52,6 @@ struct reftable_reader {
 	struct reftable_reader_offsets log_offsets;
 };
 
-int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
-		const char *name);
 void reader_close(struct reftable_reader *r);
 const char *reader_name(struct reftable_reader *r);
 
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 101cdb5cd6..2f2ff787b2 100644
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

