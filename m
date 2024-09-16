Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A99145A17
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476616; cv=none; b=uz1/5060ipP4r6yGr6STl1ZWxx+ONbKHbT5n7WA94vsZMHWwd5qkBLOWD4/OC+C31g0FOAmwZdentyKHweUOUrahj1qdZ2DvcWW9WqCp6oOKKR72d2gOh5IJSze5sLMB4w+S1vd/YniroJJtoQ4Y2LwHJnkkH5jt1OZrdxw/njo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476616; c=relaxed/simple;
	bh=5hwXxoNEBKLw3qlPFgF3Jn9cLMZQdXF1hs+J0EaJVgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPPNsIKpHqchbCID/NmugkPy8a3ZG3I2/lBMyDy5mJEOwrzzJsFoBwY65ViCk1CZ7KIUGVCZuHcoYAg0LtcXkFPtGDItN+nK/b1D2foFAyfJDydWt2Wc1xPy6YjAe9RBN7oI4qtkIJcag5fqjSiyFLAm/5snbJre+nHUMTJtVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b3ETG2ZG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lX1DeENn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b3ETG2ZG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lX1DeENn"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 3056B1380295;
	Mon, 16 Sep 2024 04:50:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 16 Sep 2024 04:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726476613; x=1726563013; bh=IN5/QA0KnF
	jOPYfyOqXlJvg2zOTxRRXhIL/ToHLUHYw=; b=b3ETG2ZG36JoMcpOmwh/eaFtg0
	6IjuUUve5jkb/m7wU5YPcRlqpCgwBAdCujLs1QNn9+KAVTlqROdoc+iYRDksfy11
	Po3RSO+qFPyflC+yV5pwlHSrhqMTEqwlXXfW7E2DydxHj1ZRtMw7N4Ldwn+viPKO
	Deaxz3NZUSw41UkLBr0PL/Am+UZIgzIqLPe0sHSK2BONYKYEXhzCZWXo1HwXOVtW
	Kinq4bweniaJt4xj0yQ0pnnGH5VJ9drmmRoxrCtxHZh0zvZ9afEZGXPk0chAhpA/
	PANPmuGIZKvBE8bgWuH1pWdvUaG7l++64GvaJoSzrp48fi6kCy0nqq512nUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726476613; x=1726563013; bh=IN5/QA0KnFjOPYfyOqXlJvg2zOTx
	RRXhIL/ToHLUHYw=; b=lX1DeENnqOP60rcbmnU7W0VbLLEowK6UhkOrkxpj8qGr
	on3ReLyv3gzyedY3YVvfNgXwuHTGTo4vHk7zTBp4ndf/vtytnQLxdjLv72bKz6qm
	tsCCZhTLZUPL5xXSn2rnTmIlycCjswWselkFg3Y7SxhiznAG4+5CcOB6zyvIHzd3
	esriPrgihYIxJpZupKrYKsb0zKJ1H27ECwRKoBpxhQRp/bVBC29u+5VNhM+jmgwo
	TeB6foP+fYzgOQlIYqnO9T2CXdS6YHNWJhbWPKLc45JYmebNSwHfDBwGQjHG274K
	uJOym3Lr5ZCHbDKU1LZLTdkI8cyAYcZVYfSqqYDccw==
X-ME-Sender: <xms:RPHnZon6Z1PwDdlMbvvGCYyM53QNmY6qfyQnM9sH78lJt6odD9fdrw>
    <xme:RPHnZn3envqAQL4i7qthbutOdbHqVpTowGDLPO7N8PnhuWHDV-DFva4oy60G8yj3j
    6-35BPbozfZKFqOiQ>
X-ME-Received: <xmr:RPHnZmphJeqxzqG9RyQc5-WKQeydJvj1z62SGEY7yS0eZnsw3xaquF4s3DCC52ZQvk6qDh_G1VgORPaP52gNgdPCsw3EE9_hAMvo-uva5WueXkOj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgedtgfefhfdtffettdevjeeiteektdffkeefheeukeet
    feeltefhffdvieejgfeknecuffhomhgrihhnpehuphgurghtvgdrnhgvfidpvhgrlhdvrd
    htrghrghgvthdpuhhpuggrthgvrdgvmhgrihhlnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoh
    epfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:RfHnZkkiC0bLaI5JCh9VAXw1DxpNtey0E8WwLFRbJewZszAifhWiHg>
    <xmx:RfHnZm3zGvmT2S9KwGJ-j7LjhFrbDZyQx9YY-YVbPRva_TgppMYNxw>
    <xmx:RfHnZrsvkLYzLnUQvODR9NEtd444ABPA6JgCN7EvlPhaQfXwKmBCaA>
    <xmx:RfHnZiXmR-O-cJZm4kDTZHgS7ejOrBrGutxEpPqwhgcry6aIuH5Drg>
    <xmx:RfHnZryx6gZRhPAw_pduGRERU6o3bNIy-b6YAesfi_kRDqtl0hy8bBzM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 04:50:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 508085b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 08:49:55 +0000 (UTC)
Date: Mon, 16 Sep 2024 10:50:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 4/6] t/unit-tests: introduce reftable library
Message-ID: <6747076420fe01cf741d44400114431070c3c54a.1726476401.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
 <cover.1726476401.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726476401.git.ps@pks.im>

We have recently migrated all of the reftable unit tests that were part
of the reftable library into our own unit testing framework. As part of
that migration we have duplicated some of the functionality that was
part of the reftable test framework into each of the migrated test
suites. This was a sensible decision to not have all of the migrations
dependent on each other, but now that the migration is done it makes
sense to deduplicate the functionality again.

Introduce a new reftable test library that hosts some shared code and
adapt tests to use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |   1 +
 t/unit-tests/lib-reftable.c         |  93 ++++++++++++++++++++
 t/unit-tests/lib-reftable.h         |  20 +++++
 t/unit-tests/t-reftable-merged.c    |  87 +++----------------
 t/unit-tests/t-reftable-readwrite.c | 130 +++++++++-------------------
 t/unit-tests/t-reftable-stack.c     |  25 +++---
 6 files changed, 177 insertions(+), 179 deletions(-)
 create mode 100644 t/unit-tests/lib-reftable.c
 create mode 100644 t/unit-tests/lib-reftable.h

diff --git a/Makefile b/Makefile
index 4ed5f1f50a8..9460a80d0dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1358,6 +1358,7 @@ UNIT_TEST_PROGRAMS += t-urlmatch-normalization
 UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
+UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
diff --git a/t/unit-tests/lib-reftable.c b/t/unit-tests/lib-reftable.c
new file mode 100644
index 00000000000..ab1fa44a282
--- /dev/null
+++ b/t/unit-tests/lib-reftable.c
@@ -0,0 +1,93 @@
+#include "lib-reftable.h"
+#include "test-lib.h"
+#include "reftable/constants.h"
+#include "reftable/writer.h"
+
+void t_reftable_set_hash(uint8_t *p, int i, uint32_t id)
+{
+	memset(p, (uint8_t)i, hash_size(id));
+}
+
+static ssize_t strbuf_writer_write(void *b, const void *data, size_t sz)
+{
+	strbuf_add(b, data, sz);
+	return sz;
+}
+
+static int strbuf_writer_flush(void *arg UNUSED)
+{
+	return 0;
+}
+
+struct reftable_writer *t_reftable_strbuf_writer(struct strbuf *buf,
+						 struct reftable_write_options *opts)
+{
+	return reftable_new_writer(&strbuf_writer_write,
+				   &strbuf_writer_flush,
+				   buf, opts);
+}
+
+void t_reftable_write_to_buf(struct strbuf *buf,
+			     struct reftable_ref_record *refs,
+			     size_t nrefs,
+			     struct reftable_log_record *logs,
+			     size_t nlogs,
+			     struct reftable_write_options *_opts)
+{
+	struct reftable_write_options opts = { 0 };
+	const struct reftable_stats *stats;
+	struct reftable_writer *writer;
+	uint64_t min = 0xffffffff;
+	uint64_t max = 0;
+	int ret;
+
+	if (_opts)
+		opts = *_opts;
+
+	for (size_t i = 0; i < nrefs; i++) {
+		uint64_t ui = refs[i].update_index;
+		if (ui > max)
+			max = ui;
+		if (ui < min)
+			min = ui;
+	}
+	for (size_t i = 0; i < nlogs; i++) {
+		uint64_t ui = logs[i].update_index;
+		if (ui > max)
+			max = ui;
+		if (ui < min)
+			min = ui;
+	}
+
+	writer = t_reftable_strbuf_writer(buf, &opts);
+	reftable_writer_set_limits(writer, min, max);
+
+	if (nrefs) {
+		ret = reftable_writer_add_refs(writer, refs, nrefs);
+		check_int(ret, ==, 0);
+	}
+
+	if (nlogs) {
+		ret = reftable_writer_add_logs(writer, logs, nlogs);
+		check_int(ret, ==, 0);
+	}
+
+	ret = reftable_writer_close(writer);
+	check_int(ret, ==, 0);
+
+	stats = reftable_writer_stats(writer);
+	for (size_t i = 0; i < stats->ref_stats.blocks; i++) {
+		size_t off = i * (opts.block_size ? opts.block_size
+						  : DEFAULT_BLOCK_SIZE);
+		if (!off)
+			off = header_size(opts.hash_id == GIT_SHA256_FORMAT_ID ? 2 : 1);
+		check_char(buf->buf[off], ==, 'r');
+	}
+
+	if (nrefs)
+		check_int(stats->ref_stats.blocks, >, 0);
+	if (nlogs)
+		check_int(stats->log_stats.blocks, >, 0);
+
+	reftable_writer_free(writer);
+}
diff --git a/t/unit-tests/lib-reftable.h b/t/unit-tests/lib-reftable.h
new file mode 100644
index 00000000000..d1154190847
--- /dev/null
+++ b/t/unit-tests/lib-reftable.h
@@ -0,0 +1,20 @@
+#ifndef LIB_REFTABLE_H
+#define LIB_REFTABLE_H
+
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "reftable/reftable-writer.h"
+
+void t_reftable_set_hash(uint8_t *p, int i, uint32_t id);
+
+struct reftable_writer *t_reftable_strbuf_writer(struct strbuf *buf,
+						 struct reftable_write_options *opts);
+
+void t_reftable_write_to_buf(struct strbuf *buf,
+			     struct reftable_ref_record *refs,
+			     size_t nrecords,
+			     struct reftable_log_record *logs,
+			     size_t nlogs,
+			     struct reftable_write_options *opts);
+
+#endif
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index e9d100a01ea..b8c92fdb365 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -7,6 +7,7 @@ license that can be found in the LICENSE file or at
 */
 
 #include "test-lib.h"
+#include "lib-reftable.h"
 #include "reftable/blocksource.h"
 #include "reftable/constants.h"
 #include "reftable/merged.h"
@@ -15,77 +16,6 @@ license that can be found in the LICENSE file or at
 #include "reftable/reftable-merged.h"
 #include "reftable/reftable-writer.h"
 
-static ssize_t strbuf_add_void(void *b, const void *data, const size_t sz)
-{
-	strbuf_add(b, data, sz);
-	return sz;
-}
-
-static int noop_flush(void *arg UNUSED)
-{
-	return 0;
-}
-
-static void write_test_table(struct strbuf *buf,
-			     struct reftable_ref_record refs[], const size_t n)
-{
-	uint64_t min = 0xffffffff;
-	uint64_t max = 0;
-	size_t i;
-	int err;
-
-	struct reftable_write_options opts = {
-		.block_size = 256,
-	};
-	struct reftable_writer *w = NULL;
-	for (i = 0; i < n; i++) {
-		uint64_t ui = refs[i].update_index;
-		if (ui > max)
-			max = ui;
-		if (ui < min)
-			min = ui;
-	}
-
-	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
-	reftable_writer_set_limits(w, min, max);
-
-	for (i = 0; i < n; i++) {
-		uint64_t before = refs[i].update_index;
-		int n = reftable_writer_add_ref(w, &refs[i]);
-		check_int(n, ==, 0);
-		check_int(before, ==, refs[i].update_index);
-	}
-
-	err = reftable_writer_close(w);
-	check(!err);
-
-	reftable_writer_free(w);
-}
-
-static void write_test_log_table(struct strbuf *buf, struct reftable_log_record logs[],
-				 const size_t n, const uint64_t update_index)
-{
-	int err;
-
-	struct reftable_write_options opts = {
-		.block_size = 256,
-		.exact_log_message = 1,
-	};
-	struct reftable_writer *w = NULL;
-	w = reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
-	reftable_writer_set_limits(w, update_index, update_index);
-
-	for (size_t i = 0; i < n; i++) {
-		int err = reftable_writer_add_log(w, &logs[i]);
-		check(!err);
-	}
-
-	err = reftable_writer_close(w);
-	check(!err);
-
-	reftable_writer_free(w);
-}
-
 static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
@@ -93,13 +23,16 @@ merged_table_from_records(struct reftable_ref_record **refs,
 			  struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
+	struct reftable_write_options opts = {
+		.block_size = 256,
+	};
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(*readers, n);
 	REFTABLE_CALLOC_ARRAY(*source, n);
 
 	for (size_t i = 0; i < n; i++) {
-		write_test_table(&buf[i], refs[i], sizes[i]);
+		t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
 
 		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
@@ -268,13 +201,17 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct strbuf *buf, const size_t n)
 {
 	struct reftable_merged_table *mt = NULL;
+	struct reftable_write_options opts = {
+		.block_size = 256,
+		.exact_log_message = 1,
+	};
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(*readers, n);
 	REFTABLE_CALLOC_ARRAY(*source, n);
 
 	for (size_t i = 0; i < n; i++) {
-		write_test_log_table(&buf[i], logs[i], sizes[i], i + 1);
+		t_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
 
 		err = reftable_reader_new(&(*readers)[i], &(*source)[i],
@@ -402,9 +339,7 @@ static void t_default_write_opts(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
-
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record rec = {
 		.refname = (char *) "master",
 		.update_index = 1,
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index 82bfaf32874..e1b235a5f13 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -7,6 +7,7 @@ license that can be found in the LICENSE file or at
 */
 
 #include "test-lib.h"
+#include "lib-reftable.h"
 #include "reftable/basics.h"
 #include "reftable/blocksource.h"
 #include "reftable/reader.h"
@@ -15,22 +16,6 @@ license that can be found in the LICENSE file or at
 
 static const int update_index = 5;
 
-static void set_test_hash(uint8_t *p, int i)
-{
-	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
-}
-
-static ssize_t strbuf_add_void(void *b, const void *data, size_t sz)
-{
-	strbuf_add(b, data, sz);
-	return sz;
-}
-
-static int noop_flush(void *arg UNUSED)
-{
-	return 0;
-}
-
 static void t_buffer(void)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -62,61 +47,34 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 		.block_size = block_size,
 		.hash_id = hash_id,
 	};
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
-	struct reftable_ref_record ref = { 0 };
-	int i = 0, n;
-	struct reftable_log_record log = { 0 };
-	const struct reftable_stats *stats = NULL;
+	struct reftable_ref_record *refs;
+	struct reftable_log_record *logs;
+	int i;
 
 	REFTABLE_CALLOC_ARRAY(*names, N + 1);
+	REFTABLE_CALLOC_ARRAY(refs, N);
+	REFTABLE_CALLOC_ARRAY(logs, N);
 
-	reftable_writer_set_limits(w, update_index, update_index);
 	for (i = 0; i < N; i++) {
-		char name[100];
-		int n;
-
-		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
-
-		ref.refname = name;
-		ref.update_index = update_index;
-		ref.value_type = REFTABLE_REF_VAL1;
-		set_test_hash(ref.value.val1, i);
-		(*names)[i] = xstrdup(name);
-
-		n = reftable_writer_add_ref(w, &ref);
-		check_int(n, ==, 0);
+		refs[i].refname = (*names)[i] = xstrfmt("refs/heads/branch%02d", i);
+		refs[i].update_index = update_index;
+		refs[i].value_type = REFTABLE_REF_VAL1;
+		t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMAT_ID);
 	}
 
 	for (i = 0; i < N; i++) {
-		char name[100];
-		int n;
-
-		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
-
-		log.refname = name;
-		log.update_index = update_index;
-		log.value_type = REFTABLE_LOG_UPDATE;
-		set_test_hash(log.value.update.new_hash, i);
-		log.value.update.message = (char *) "message";
-
-		n = reftable_writer_add_log(w, &log);
-		check_int(n, ==, 0);
+		logs[i].refname = (*names)[i];
+		logs[i].update_index = update_index;
+		logs[i].value_type = REFTABLE_LOG_UPDATE;
+		t_reftable_set_hash(logs[i].value.update.new_hash, i,
+				    GIT_SHA1_FORMAT_ID);
+		logs[i].value.update.message = (char *) "message";
 	}
 
-	n = reftable_writer_close(w);
-	check_int(n, ==, 0);
-
-	stats = reftable_writer_stats(w);
-	for (i = 0; i < stats->ref_stats.blocks; i++) {
-		int off = i * opts.block_size;
-		if (!off)
-			off = header_size((hash_id == GIT_SHA256_FORMAT_ID) ? 2 : 1);
-		check_char(buf->buf[off], ==, 'r');
-	}
+	t_reftable_write_to_buf(buf, refs, N, logs, N, &opts);
 
-	check_int(stats->log_stats.blocks, >, 0);
-	reftable_writer_free(w);
+	free(refs);
+	free(logs);
 }
 
 static void t_log_buffer_size(void)
@@ -138,8 +96,7 @@ static void t_log_buffer_size(void)
 					   .time = 0x5e430672,
 					   .message = (char *) "commit: 9\n",
 				   } } };
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 
 	/* This tests buffer extension for log compression. Must use a random
 	   hash, to ensure that the compressed part is larger than the original.
@@ -181,8 +138,7 @@ static void t_log_overflow(void)
 			},
 		},
 	};
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 
 	memset(msg, 'x', sizeof(msg) - 1);
 	reftable_writer_set_limits(w, update_index, update_index);
@@ -208,8 +164,7 @@ static void t_log_write_read(void)
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	const struct reftable_stats *stats = NULL;
 	reftable_writer_set_limits(w, 0, N);
 	for (i = 0; i < N; i++) {
@@ -229,8 +184,10 @@ static void t_log_write_read(void)
 		log.refname = names[i];
 		log.update_index = i;
 		log.value_type = REFTABLE_LOG_UPDATE;
-		set_test_hash(log.value.update.old_hash, i);
-		set_test_hash(log.value.update.new_hash, i + 1);
+		t_reftable_set_hash(log.value.update.old_hash, i,
+				    GIT_SHA1_FORMAT_ID);
+		t_reftable_set_hash(log.value.update.new_hash, i + 1,
+				    GIT_SHA1_FORMAT_ID);
 
 		err = reftable_writer_add_log(w, &log);
 		check(!err);
@@ -297,8 +254,7 @@ static void t_log_zlib_corruption(void)
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	const struct reftable_stats *stats = NULL;
 	char message[100] = { 0 };
 	int err, i, n;
@@ -528,15 +484,12 @@ static void t_table_refs_for(int indexed)
 	int err;
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
-
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
-
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_iterator it = { 0 };
 	int j;
 
-	set_test_hash(want_hash, 4);
+	t_reftable_set_hash(want_hash, 4, GIT_SHA1_FORMAT_ID);
 
 	for (i = 0; i < N; i++) {
 		uint8_t hash[GIT_SHA1_RAWSZ];
@@ -552,8 +505,10 @@ static void t_table_refs_for(int indexed)
 		ref.refname = name;
 
 		ref.value_type = REFTABLE_REF_VAL2;
-		set_test_hash(ref.value.val2.value, i / 4);
-		set_test_hash(ref.value.val2.target_value, 3 + i / 4);
+		t_reftable_set_hash(ref.value.val2.value, i / 4,
+				    GIT_SHA1_FORMAT_ID);
+		t_reftable_set_hash(ref.value.val2.target_value, 3 + i / 4,
+				    GIT_SHA1_FORMAT_ID);
 
 		/* 80 bytes / entry, so 3 entries per block. Yields 17
 		 */
@@ -618,8 +573,7 @@ static void t_write_empty_table(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_block_source source = { 0 };
 	struct reftable_reader *rd = NULL;
 	struct reftable_ref_record rec = { 0 };
@@ -657,8 +611,7 @@ static void t_write_object_id_min_length(void)
 		.block_size = 75,
 	};
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
 		.value_type = REFTABLE_REF_VAL1,
@@ -692,8 +645,7 @@ static void t_write_object_id_length(void)
 		.block_size = 75,
 	};
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.update_index = 1,
 		.value_type = REFTABLE_REF_VAL1,
@@ -726,8 +678,7 @@ static void t_write_empty_key(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record ref = {
 		.refname = (char *) "",
 		.update_index = 1,
@@ -749,8 +700,7 @@ static void t_write_key_order(void)
 {
 	struct reftable_write_options opts = { 0 };
 	struct strbuf buf = STRBUF_INIT;
-	struct reftable_writer *w =
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_ref_record refs[2] = {
 		{
 			.refname = (char *) "b",
@@ -798,7 +748,7 @@ static void t_write_multiple_indices(void)
 	struct reftable_reader *reader;
 	int err, i;
 
-	writer = reftable_new_writer(&strbuf_add_void, &noop_flush, &writer_buf, &opts);
+	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (i = 0; i < 100; i++) {
 		struct reftable_ref_record ref = {
@@ -876,7 +826,7 @@ static void t_write_multi_level_index(void)
 	struct reftable_reader *reader;
 	int err;
 
-	writer = reftable_new_writer(&strbuf_add_void, &noop_flush, &writer_buf, &opts);
+	writer = t_reftable_strbuf_writer(&writer_buf, &opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (size_t i = 0; i < 200; i++) {
 		struct reftable_ref_record ref = {
diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index d62a9c1bed5..65e513d5ec8 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -7,17 +7,13 @@ license that can be found in the LICENSE file or at
 */
 
 #include "test-lib.h"
+#include "lib-reftable.h"
 #include "reftable/merged.h"
 #include "reftable/reader.h"
 #include "reftable/reftable-error.h"
 #include "reftable/stack.h"
 #include <dirent.h>
 
-static void set_test_hash(uint8_t *p, int i)
-{
-	memset(p, (uint8_t)i, hash_size(GIT_SHA1_FORMAT_ID));
-}
-
 static void clear_dir(const char *dirname)
 {
 	struct strbuf path = STRBUF_INIT;
@@ -125,7 +121,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/branch-%04"PRIuMAX, (uintmax_t)i);
 		ref.refname = buf.buf;
-		set_test_hash(ref.value.val1, i);
+		t_reftable_set_hash(ref.value.val1, i, GIT_SHA1_FORMAT_ID);
 
 		err = reftable_stack_add(st, &write_test_ref, &ref);
 		check(!err);
@@ -470,13 +466,13 @@ static void t_reftable_stack_add(void)
 		refs[i].refname = xstrdup(buf);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
-		set_test_hash(refs[i].value.val1, i);
+		t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMAT_ID);
 
 		logs[i].refname = xstrdup(buf);
 		logs[i].update_index = N + i + 1;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.email = xstrdup("identity@invalid");
-		set_test_hash(logs[i].value.update.new_hash, i);
+		t_reftable_set_hash(logs[i].value.update.new_hash, i, GIT_SHA1_FORMAT_ID);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -562,14 +558,14 @@ static void t_reftable_stack_iterator(void)
 		refs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		refs[i].update_index = i + 1;
 		refs[i].value_type = REFTABLE_REF_VAL1;
-		set_test_hash(refs[i].value.val1, i);
+		t_reftable_set_hash(refs[i].value.val1, i, GIT_SHA1_FORMAT_ID);
 
 		logs[i].refname = xstrfmt("branch%02"PRIuMAX, (uintmax_t)i);
 		logs[i].update_index = i + 1;
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.email = xstrdup("johndoe@invalid");
 		logs[i].value.update.message = xstrdup("commit\n");
-		set_test_hash(logs[i].value.update.new_hash, i);
+		t_reftable_set_hash(logs[i].value.update.new_hash, i, GIT_SHA1_FORMAT_ID);
 	}
 
 	for (i = 0; i < N; i++) {
@@ -704,7 +700,8 @@ static void t_reftable_stack_tombstone(void)
 		refs[i].update_index = i + 1;
 		if (i % 2 == 0) {
 			refs[i].value_type = REFTABLE_REF_VAL1;
-			set_test_hash(refs[i].value.val1, i);
+			t_reftable_set_hash(refs[i].value.val1, i,
+					    GIT_SHA1_FORMAT_ID);
 		}
 
 		logs[i].refname = xstrdup(buf);
@@ -712,7 +709,8 @@ static void t_reftable_stack_tombstone(void)
 		logs[i].update_index = 42;
 		if (i % 2 == 0) {
 			logs[i].value_type = REFTABLE_LOG_UPDATE;
-			set_test_hash(logs[i].value.update.new_hash, i);
+			t_reftable_set_hash(logs[i].value.update.new_hash, i,
+					    GIT_SHA1_FORMAT_ID);
 			logs[i].value.update.email =
 				xstrdup("identity@invalid");
 		}
@@ -844,7 +842,8 @@ static void t_reflog_expire(void)
 		logs[i].value_type = REFTABLE_LOG_UPDATE;
 		logs[i].value.update.time = i;
 		logs[i].value.update.email = xstrdup("identity@invalid");
-		set_test_hash(logs[i].value.update.new_hash, i);
+		t_reftable_set_hash(logs[i].value.update.new_hash, i,
+				    GIT_SHA1_FORMAT_ID);
 	}
 
 	for (i = 1; i <= N; i++) {
-- 
2.46.0.551.gc5ee8f2d1c.dirty

