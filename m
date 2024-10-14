Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4045819CD0E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910958; cv=none; b=ZI9gMx22cf/3xm3KfcOodGVld+4X88vmaNcizvilzUzB4JrSnUCAIm1w7cG4jbR80i0Qd43dEA/FCfi9DoImaJ/mRlao8KtOffPrDfZzEXTLqMb+v5SL6e6rhzpkGWl2lg106vyYH3NLnEWSURxBlAEymFuehpW8CCcGdk/kcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910958; c=relaxed/simple;
	bh=KRoqMJf95O7A8DBRS/IU7dGTn6+gsnhidrg9zhDwnHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGlnB+tt2tZkXwpe7y2dfzRb6O7tOhaizm69fFAHPEFiFWHdYV5bu+3MxkU6cmugOBNkIWAnoE/kzI3ZJRP/A9+vtxRC8Ah4N96U7dbEJ2iz8OjjEcClI2omMqQ/pnw0HO8fjfeRyM8ez0OhhnGT0LXqoZZrwRV/jvfXIfrlRiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ATLjXyb9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ClrYjDFi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ATLjXyb9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ClrYjDFi"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F96513800C9;
	Mon, 14 Oct 2024 09:02:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 14 Oct 2024 09:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910955; x=1728997355; bh=5SO4vuNtOJ
	4c+3W+wiijG1N9UBZAy5aGXSP35Kp7FKw=; b=ATLjXyb9bGQ3xj1CeoGYxMC6Ln
	t13djidu4GCRiAMUAcORFtKeB8K2fub6pUCNg3W3QThCBFqmgEG7Qxm2le/BEZgr
	DKyvddqXQPmj57cofoP+vA8ypgEKMFuSR2p5Bznpuu1rUOls3t1u5lukP5QMYVc6
	ri/DGGnT9rdeOhqjnlS9o8BP4giGi3nTLiaW7d2C2HMZ1lWpmaABj2cknCp+Fl/p
	vrvkUdC2vX/ZakJ/yey4/syprI6ZaYn5ZA0H2ogyN0UlgyIKW0Ufuiseqs5VyczJ
	btt5QGUobWS2mvUMCL5r3cpnBPwq8igI4VZBiVM8CzxFHXOQWWwzn3bPJ/oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910955; x=1728997355; bh=5SO4vuNtOJ4c+3W+wiijG1N9UBZA
	y5aGXSP35Kp7FKw=; b=ClrYjDFiy5JzjBnptk7xpatEXOtgj+fez++0KNT4Fofr
	0eqQ+WOLzfkWTxan5NQuHhljVz12fQLqtPz5E+ua4qSBIA+RHgoKpFeo9EVG5lz9
	mbwMjSbdtn7Xq90Pd0d//lJKBSU/iRNsSbQcOC16MGTGaZzSSW0DjQ7P/4bFogAr
	5/EpW+tOQ7RIgXoCofo3DA7UvapTyiRPonEmCp5wORzIrYy90atmZvzGOjDWGpOO
	uQkNZ7k4V3QFfaxWuavHyDfJil3FDxWrJroEkKLQpPqsiPgIvVPwKXR8U4j4M7nc
	QLDzRXItherRdcMv4VuRFpkwNmE5kDwuq0e9fIyTKQ==
X-ME-Sender: <xms:axYNZ-VnQQ-Jw_yUjRC5KjPyZt-htM2E1WMCd9shuSiUkYrjuKn8gA>
    <xme:axYNZ6kWQ-c4yO4X7OD-0eLzhFHIE7nXMLQ59eztiKW-xU4Q2_o3JBZnZVuyhtvAY
    RATvtEBIpQmaXrZkQ>
X-ME-Received: <xmr:axYNZybUGCf6pRW-zdKqVa_mZhIBcqojlO4gzeCg0wP8E-oi7961d6U-F1qm8WxKXpr-CcsJOoc3xAiMUMQ2KBImwobmeMf5LcYMrpEHVFohdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:axYNZ1XkF8Aoftp2fDIm-ab8dIIlhyu31uyrAQ4zHRsYy2mRERvXqA>
    <xmx:axYNZ4la8LHj3zHRVZVe3Cc71P8kgsAv_BZAYznnbXbJ8RE0qzGscw>
    <xmx:axYNZ6c-4HlhZw9XtN5K2m1Q0T_EEL0L_H3oIrgknZntZU5xCFWgWw>
    <xmx:axYNZ6FIVmMlH1fVbU0n8PtzM4EEoxtvgUhMrCPHM_JRkPYB-9YEig>
    <xmx:axYNZygynaks8OfPVluIedVpBrbRVfGU9RKrLVUi3RU8SbO8j9v31Chd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66eee15f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:21 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/10] reftable/blocksource: adapt interface name
Message-ID: <fe8c9ace4633ba5609741f657a7bb298e9f0dedd.1728910727.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728910726.git.ps@pks.im>

Adapt the name of the `strbuf` block source to no longer relate to this
interface, but instead to the `reftable_buf` interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c              | 26 +++++++++++++-------------
 reftable/blocksource.h              |  4 ++--
 t/unit-tests/t-reftable-block.c     |  8 ++++----
 t/unit-tests/t-reftable-merged.c    |  6 +++---
 t/unit-tests/t-reftable-reader.c    |  4 ++--
 t/unit-tests/t-reftable-readwrite.c | 24 ++++++++++++------------
 6 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index d6242d67900..52e0915a67b 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,19 +13,19 @@ license that can be found in the LICENSE file or at
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
-static void strbuf_return_block(void *b UNUSED, struct reftable_block *dest)
+static void reftable_buf_return_block(void *b UNUSED, struct reftable_block *dest)
 {
 	if (dest->len)
 		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
-static void strbuf_close(void *b UNUSED)
+static void reftable_buf_close(void *b UNUSED)
 {
 }
 
-static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
-			     uint32_t size)
+static int reftable_buf_read_block(void *v, struct reftable_block *dest,
+				   uint64_t off, uint32_t size)
 {
 	struct reftable_buf *b = v;
 	assert(off + size <= b->len);
@@ -37,23 +37,23 @@ static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
 	return size;
 }
 
-static uint64_t strbuf_size(void *b)
+static uint64_t reftable_buf_size(void *b)
 {
 	return ((struct reftable_buf *)b)->len;
 }
 
-static struct reftable_block_source_vtable strbuf_vtable = {
-	.size = &strbuf_size,
-	.read_block = &strbuf_read_block,
-	.return_block = &strbuf_return_block,
-	.close = &strbuf_close,
+static struct reftable_block_source_vtable reftable_buf_vtable = {
+	.size = &reftable_buf_size,
+	.read_block = &reftable_buf_read_block,
+	.return_block = &reftable_buf_return_block,
+	.close = &reftable_buf_close,
 };
 
-void block_source_from_strbuf(struct reftable_block_source *bs,
-			      struct reftable_buf *buf)
+void block_source_from_buf(struct reftable_block_source *bs,
+			   struct reftable_buf *buf)
 {
 	assert(!bs->ops);
-	bs->ops = &strbuf_vtable;
+	bs->ops = &reftable_buf_vtable;
 	bs->arg = buf;
 }
 
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
index ee3647c6531..a84a3ccd891 100644
--- a/reftable/blocksource.h
+++ b/reftable/blocksource.h
@@ -15,7 +15,7 @@ struct reftable_block_source;
 struct reftable_buf;
 
 /* Create an in-memory block source for reading reftables */
-void block_source_from_strbuf(struct reftable_block_source *bs,
-			      struct reftable_buf *buf);
+void block_source_from_buf(struct reftable_block_source *bs,
+			   struct reftable_buf *buf);
 
 #endif
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index 56514b43630..df1d45fe8e4 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -34,7 +34,7 @@ static void t_ref_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
 	block.len = block_size;
-	block_source_from_strbuf(&block.source ,&buf);
+	block_source_from_buf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 				header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	check(!ret);
@@ -128,7 +128,7 @@ static void t_log_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
 	block.len = block_size;
-	block_source_from_strbuf(&block.source ,&buf);
+	block_source_from_buf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
 				header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	check(!ret);
@@ -218,7 +218,7 @@ static void t_obj_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
 	block.len = block_size;
-	block_source_from_strbuf(&block.source, &buf);
+	block_source_from_buf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
 				header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	check(!ret);
@@ -302,7 +302,7 @@ static void t_index_block_read_write(void)
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
 	check(block.data != NULL);
 	block.len = block_size;
-	block_source_from_strbuf(&block.source, &buf);
+	block_source_from_buf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
 				header_off, hash_size(GIT_SHA1_FORMAT_ID));
 	check(!ret);
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 9b0162a4b32..484c18251f3 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -35,7 +35,7 @@ merged_table_from_records(struct reftable_ref_record **refs,
 
 	for (size_t i = 0; i < n; i++) {
 		t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
-		block_source_from_strbuf(&(*source)[i], &buf[i]);
+		block_source_from_buf(&(*source)[i], &buf[i]);
 
 		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
 					  "name");
@@ -293,7 +293,7 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 
 	for (size_t i = 0; i < n; i++) {
 		t_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
-		block_source_from_strbuf(&(*source)[i], &buf[i]);
+		block_source_from_buf(&(*source)[i], &buf[i]);
 
 		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
 					  "name");
@@ -442,7 +442,7 @@ static void t_default_write_opts(void)
 	check(!err);
 	reftable_writer_free(w);
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
index 8a18d7f9be4..19cb53b6415 100644
--- a/t/unit-tests/t-reftable-reader.c
+++ b/t/unit-tests/t-reftable-reader.c
@@ -20,7 +20,7 @@ static int t_reader_seek_once(void)
 	int ret;
 
 	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	ret = reftable_reader_new(&reader, &source, "name");
 	check(!ret);
@@ -61,7 +61,7 @@ static int t_reader_reseek(void)
 	int ret;
 
 	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	ret = reftable_reader_new(&reader, &source, "name");
 	check(!ret);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index c56a33f1a1e..7c7c72bb162 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -24,7 +24,7 @@ static void t_buffer(void)
 	int n;
 	uint8_t in[] = "hello";
 	reftable_buf_add(&buf, in, sizeof(in));
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 	check_int(block_source_size(&source), ==, 6);
 	n = block_source_read_block(&source, &out, 0, sizeof(in));
 	check_int(n, ==, sizeof(in));
@@ -207,7 +207,7 @@ static void t_log_write_read(void)
 	reftable_writer_free(w);
 	w = NULL;
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
@@ -298,7 +298,7 @@ static void t_log_zlib_corruption(void)
 	/* corrupt the data. */
 	buf.buf[50] ^= 0x99;
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
@@ -328,7 +328,7 @@ static void t_table_read_write_sequential(void)
 
 	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
@@ -380,7 +380,7 @@ static void t_table_read_api(void)
 
 	write_table(&names, &buf, N, 256, GIT_SHA1_FORMAT_ID);
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
@@ -416,7 +416,7 @@ static void t_table_read_write_seek(int index, int hash_id)
 
 	write_table(&names, &buf, N, 256, hash_id);
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
@@ -538,7 +538,7 @@ static void t_table_refs_for(int indexed)
 	reftable_writer_free(w);
 	w = NULL;
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
@@ -600,7 +600,7 @@ static void t_write_empty_table(void)
 
 	check_int(buf.len, ==, header_size(1) + footer_size(1));
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 
 	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
@@ -806,7 +806,7 @@ static void t_write_multiple_indices(void)
 	check_int(stats->obj_stats.index_offset, >, 0);
 	check_int(stats->log_stats.index_offset, >, 0);
 
-	block_source_from_strbuf(&source, &writer_buf);
+	block_source_from_buf(&source, &writer_buf);
 	err = reftable_reader_new(&reader, &source, "filename");
 	check(!err);
 
@@ -863,7 +863,7 @@ static void t_write_multi_level_index(void)
 	stats = reftable_writer_stats(writer);
 	check_int(stats->ref_stats.max_index_level, ==, 2);
 
-	block_source_from_strbuf(&source, &writer_buf);
+	block_source_from_buf(&source, &writer_buf);
 	err = reftable_reader_new(&reader, &source, "filename");
 	check(!err);
 
@@ -889,7 +889,7 @@ static void t_corrupt_table_empty(void)
 	struct reftable_reader *reader;
 	int err;
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 }
@@ -903,7 +903,7 @@ static void t_corrupt_table(void)
 	int err;
 	reftable_buf_add(&buf, zeros, sizeof(zeros));
 
-	block_source_from_strbuf(&source, &buf);
+	block_source_from_buf(&source, &buf);
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check_int(err, ==, REFTABLE_FORMAT_ERROR);
 
-- 
2.47.0.dirty

