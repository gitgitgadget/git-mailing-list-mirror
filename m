Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D21CB302
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629670; cv=none; b=Rn/8z4LgGgMJQoTcjzSThb4sGoIZE2yYMGm3ZbRAPTLfh0GeS5PNgb8fS1SzJdnAxqZffpHXghzdgL54w9uqQVCGODJ2bscv27d0d52LhP1tH7LxhhscqiL3IuhmHel1YXIyMCIoGeZx95Gx5nQn7cF3iNsVceR4y5X/zXtRwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629670; c=relaxed/simple;
	bh=KRoqMJf95O7A8DBRS/IU7dGTn6+gsnhidrg9zhDwnHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9tRPjO5fHHVvsZycUGpA+q+bSQMClx53qEYxzxM/AiKpgGmoQSqU32Ho2xt7WaGzuCYQtwQb3ijx8XMukwfyDUCZONz35EhVRpEdWKdbfGECK6y8Dl99yResqF7MqpkwxoP01/9LysHX/jEa1TDDtvgfv3oWz5OplllrNHLRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LuE5c48a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3X941cl; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LuE5c48a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3X941cl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FB3C1380253;
	Fri, 11 Oct 2024 02:54:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 11 Oct 2024 02:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629666; x=1728716066; bh=5SO4vuNtOJ
	4c+3W+wiijG1N9UBZAy5aGXSP35Kp7FKw=; b=LuE5c48acIevP2lRU5guOXouuA
	RXA/g+oKO56dZQGGJn4AXvKn9yRhFOWWqg2g7AHHEFqOM0fKKpK8ZpY3JKrPabLP
	/ssKuWUWEPzgTg89tGHbxj3FqXwYeKGpeGGyjcQHaNuQskYgap8de0AcETBJp4q3
	SabHevxmLsQW4RfbrFCdIqxZDmOqt5zDJnJ2wiUMuZdwBt6/eIfmhnQ63PLn+U+w
	sIbA/imTZkDkKVpcEdgKoNjUe8DdbKvIy9s9KIwOeP9CPwD/tREo3yRWXDFvhua5
	Hm6U3DfAI2mazvDP0WMeKQDa5g3MegBof/aTpF7nQ/2galOr74PmRCmaZvfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629666; x=1728716066; bh=5SO4vuNtOJ4c+3W+wiijG1N9UBZA
	y5aGXSP35Kp7FKw=; b=m3X941cl/XC9V0+Qzf4Wd3ARb1HyNlv3O90kNB1RfFq9
	7KWhNpUdBl2rowi4rQyAgopKOfxiJSz73G654VW5OjRnIV0ZsNMT0C4roK5+vQsj
	LF2fgJI9fA9m8swaANOIgZlFuiGWj6r6K47wbmwUeD5MQ+eUxJQeEp4VDsgKMxOy
	dtH2E00hoj80JpdS0tceS6R3572bPSfbwDOMk9HQdn6CPIiXFNDQibKSjYjwYGAL
	hO66waJcQz90Oh2n5XD32LCgq+C9zxFW5GesNmdMyUkovm+HnNod6+ebbPRuoZ4+
	bjYPGVT6Ou4RONpfXrsQ+OqpuRDJcOBWDDeYeVh8dQ==
X-ME-Sender: <xms:ossIZxKS-UUBPBMF8aEmqLVjxqzOI7HWkERZZ4lmKP7Vv9b2jrjVGQ>
    <xme:ossIZ9J5DZEJi9tGvEEyMvjK1bc6yW6LNrjx7riz5A225cw4FZv7yGwWRvnvug_zi
    Q8KD4FSilVwC_9G8Q>
X-ME-Received: <xmr:ossIZ5viJz8mF07ytrH0R1HrqF4QnqO2718sh8wRX-pav-LtsDf0oog6Hx9jqsnu0BbleNXnoxsiYTZrxsLqJiIh37lr-Q1SsA_bcC5JHDoGx8k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:ossIZyYqWk_2hPVa2KFo79Ke73RnfbUbASzorw3njy47VejgfiSZyA>
    <xmx:ossIZ4bajdYyMKBKWrzSXsZR_lKHis_JYfoECprKwOU0YTWki8ESKA>
    <xmx:ossIZ2ALKfXQDyMNZVHL8lHAGjNy8HHCUisAR0MrUZdbtJiXjdffVA>
    <xmx:ossIZ2apz3Ea-vgu-TsPLGfzMA2hf6fcSjO86LmA9jhxsFuT2y794Q>
    <xmx:ossIZ3lyK0_z-obj4I6GEvOlWM8ZTCtnt7LSZhkUFrlR-56bKH4xc3xt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05ba274e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:19 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 05/10] reftable/blocksource: adapt interface name
Message-ID: <da432d7a38468bc7d7420693d5dd894bcfcb7c41.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728629612.git.ps@pks.im>

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

