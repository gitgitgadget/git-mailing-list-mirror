Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7D17C22A
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683761; cv=none; b=O8VYCeT8rzS4o+6gFYFsovZDH9CVmth5hD80am6KOJ8XbjoFUiMT9TDPPULMsrKiXLzK0uVLGA0dKFqmRpGR8FAI+Jn3cy/RdMrTO681/iRjlge5oCmWu4kcZSRuRqbYXTWs6s7/g2KKps1ycp8N/yTdxJ0umvJY01QvCczwsEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683761; c=relaxed/simple;
	bh=5tX/4dSMqPOtYtbnmuxItVfQbceWrNWRA4U5DAC01Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWF5EP2gxrpbUlywlhp9za/Os6HXARl/+IufI0p327D2ccSYx1TrPM6+1gajXlmVB2gdxSLGyGFQKo+sQ8kfKPUB2KFcwhoJELTkkMinBDcTNCfAkl4lGGabf4E6PFu7iWXDZHFqaW43CD9Z5WyZSzxKL7fWR1uI0EuM/yLRl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rL2ATmTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgkQ134m; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rL2ATmTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgkQ134m"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74B971140227;
	Mon, 30 Sep 2024 04:09:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 04:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683759; x=1727770159; bh=EMwUHnZeh6
	RVH7z25KkD4Cl0EILfp1N4IpHNzLgy9Cc=; b=rL2ATmTt5kXOWY6wOMhrPTAiHa
	lI+4geBsFsbRrUl7TZJIXbbCz6TNCKZ1e+m+3fiJ+tOELY4TdKU1wAWoqwa0mah0
	R7J0419KTEJ3dCg0iEy3pfKzoeOCzZbu+sKjeTxNauoJtY5j8/Ai+Ca7ve9wvLWV
	5+ibEAmTRh6710VeJb4qquw+nqq1bqj/qOLVydJwfQisEORhVvB7RXg5LGoCSiSk
	d07U7NwlrVG8KJ/b/9oYH/9PaTaF1gkeZ9weZef+2jKVmMOTBfBFuyS1U+YZA+tp
	KUXIPozBUmAjpL/XzSp7ttvOG0EA3A5iqMKF+AanLLebXFxlYfsRlicWvjWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683759; x=1727770159; bh=EMwUHnZeh6RVH7z25KkD4Cl0EILf
	p1N4IpHNzLgy9Cc=; b=fgkQ134m2ZrGlumd8Co+q8f8Ppu9FpJCsMz6XwJhXhzl
	29T/uQuJlbMkpnBfUdxUp2+p3SmEChGZ+wUrOWqtOQmey72wCaSO/HyHdj4y0Wvq
	5U8aGkxluxd3jL+VZJX0Pv0ItLYQreKpOPUC9rOwY0RdKjNIWr3E7QpQEC7/hNGQ
	YHzfQGdi0z5B5cIT0XKrV1sV3Xxuji24FyXGmCcr8Xj1rsnu+/QL57H38Pv01xaa
	O5EvVqqDgXDGg5f1In0rHJWR7AKjxqoyFxzgJ+rlotQGGDLYGB7Oenc7hTW/Ow1b
	0eucx6dWBZLHqHpT8HOPBlQS+7/DcHgORisuJnnhRA==
X-ME-Sender: <xms:r1z6ZkY4jdwvMWMYaVPwZXCaLKlnlRJS5cwwDVaLBrP_7ZqRLB-ibg>
    <xme:r1z6Zvb1LaVRsIRKvHm5DCMg1rN5H9vUxa6COGOmr0Se244fy14thXYX4FgnjrVhr
    91CICR0cNaJGp31_A>
X-ME-Received: <xmr:r1z6Zu8VtanaQiO59WAaJ2F2oRWhT2ERhOlHD4H7xo1NpPhplnclgVy5gWoHyu2XuzyV6dGtYj7W4X7F4GU76ncPracRpSgg-ZU2_vJAiBh5ZlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomh
X-ME-Proxy: <xmx:r1z6Zup8BrOK_HWZgdd9P9djBL8HIomKkHn1LGx4wx2lj67E7CXO5Q>
    <xmx:r1z6Zvov-V0jQZ-VcIrm8wXTkeyqVDFezEAK0e0uusSlGKSfm1AJJA>
    <xmx:r1z6ZsSlkmvUGiTPKk2Mo2do7j5RRt1oQEsaOnfgilWycgTM5xX0zw>
    <xmx:r1z6Zvo9rMlzRcbGlOrtqQzLvdNppY_E5H66MpS5M8btVrr2CUGNWg>
    <xmx:r1z6ZgnSxYk3DEoWXCMxoID-LQpWw_n_aadafmTxXVWh8cigjiJ9FEDY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:09:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 308d9090 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:32 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:09:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 22/22] reftable: handle trivial allocation failures
Message-ID: <20f50c446abeb563ecc8c6f8a8be0349abee4dcb.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle trivial allocation failures in the reftable library and its unit
tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                   |  3 +++
 reftable/reader.c                   | 10 +++++++++-
 reftable/stack.c                    | 20 ++++++++++++++++++++
 reftable/writer.c                   | 13 +++++++++++--
 t/unit-tests/t-reftable-block.c     |  4 ++++
 t/unit-tests/t-reftable-merged.c    |  4 ++++
 t/unit-tests/t-reftable-readwrite.c | 27 ++++++++++++++++-----------
 7 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 2c20845d62..52bc66c527 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -203,6 +203,9 @@ int reftable_merged_table_new(struct reftable_merged_table **dest,
 	}
 
 	REFTABLE_CALLOC_ARRAY(m, 1);
+	if (!m)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 	m->readers = readers;
 	m->readers_len = n;
 	m->min = first_min;
diff --git a/reftable/reader.c b/reftable/reader.c
index 0179e4e73d..98e7aa2637 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -598,6 +598,10 @@ int reftable_reader_new(struct reftable_reader **out,
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(r, 1);
+	if (!r) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 
 	/*
 	 * We need one extra byte to read the type of first block. We also
@@ -627,7 +631,11 @@ int reftable_reader_new(struct reftable_reader **out,
 
 	r->size = file_size - footer_size(r->version);
 	r->source = *source;
-	r->name = xstrdup(name);
+	r->name = reftable_strdup(name);
+	if (!r->name) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	r->hash_id = 0;
 	r->refcount = 1;
 
diff --git a/reftable/stack.c b/reftable/stack.c
index 990784d9d2..7df28ab343 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -116,6 +116,11 @@ static int fd_read_lines(int fd, char ***namesp)
 	}
 
 	REFTABLE_ALLOC_ARRAY(buf, size + 1);
+	if (!buf) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	if (read_in_full(fd, buf, size) != size) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
@@ -140,6 +145,8 @@ int read_lines(const char *filename, char ***namesp)
 	if (fd < 0) {
 		if (errno == ENOENT) {
 			REFTABLE_CALLOC_ARRAY(*namesp, 1);
+			if (!*namesp)
+				return REFTABLE_OUT_OF_MEMORY_ERROR;
 			return 0;
 		}
 
@@ -420,6 +427,10 @@ static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
 			}
 
 			REFTABLE_CALLOC_ARRAY(names, 1);
+			if (!names) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto out;
+			}
 		} else {
 			err = fd_read_lines(fd, &names);
 			if (err < 0)
@@ -779,7 +790,11 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
 {
 	int err = 0;
 	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
+
 	REFTABLE_CALLOC_ARRAY(*dest, 1);
+	if (!*dest)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 	**dest = empty;
 	err = reftable_stack_init_addition(*dest, st);
 	if (err) {
@@ -886,7 +901,12 @@ int reftable_addition_add(struct reftable_addition *add,
 
 	REFTABLE_ALLOC_GROW(add->new_tables, add->new_tables_len + 1,
 			    add->new_tables_cap);
+	if (!add->new_tables) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	add->new_tables[add->new_tables_len++] = strbuf_detach(&next_name, NULL);
+
 done:
 	delete_tempfile(&tab_file);
 	strbuf_release(&temp_tab_file_name);
diff --git a/reftable/writer.c b/reftable/writer.c
index 44bed92f46..ad4718edec 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -49,8 +49,14 @@ static int padded_write(struct reftable_writer *w, uint8_t *data, size_t len,
 {
 	int n = 0;
 	if (w->pending_padding > 0) {
-		uint8_t *zeroed = reftable_calloc(w->pending_padding, sizeof(*zeroed));
-		int n = w->write(w->write_arg, zeroed, w->pending_padding);
+		uint8_t *zeroed;
+		int n;
+
+		zeroed = reftable_calloc(w->pending_padding, sizeof(*zeroed));
+		if (!zeroed)
+			return -1;
+
+		n = w->write(w->write_arg, zeroed, w->pending_padding);
 		if (n < 0)
 			return n;
 
@@ -767,6 +773,9 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 	 * case we will end up with a multi-level index.
 	 */
 	REFTABLE_ALLOC_GROW(w->index, w->index_len + 1, w->index_cap);
+	if (!w->index)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 	index_record.offset = w->next;
 	strbuf_reset(&index_record.last_key);
 	strbuf_addbuf(&index_record.last_key, &w->block_writer->last_key);
diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index e52a612e85..d470060e8b 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -32,6 +32,7 @@ static void t_ref_block_read_write(void)
 	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	check(block.data != NULL);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
@@ -125,6 +126,7 @@ static void t_log_block_read_write(void)
 	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	check(block.data != NULL);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source ,&buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_LOG, block.data, block_size,
@@ -214,6 +216,7 @@ static void t_obj_block_read_write(void)
 	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	check(block.data != NULL);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_OBJ, block.data, block_size,
@@ -297,6 +300,7 @@ static void t_index_block_read_write(void)
 	struct strbuf want = STRBUF_INIT, buf = STRBUF_INIT;
 
 	REFTABLE_CALLOC_ARRAY(block.data, block_size);
+	check(block.data != NULL);
 	block.len = block_size;
 	block_source_from_strbuf(&block.source, &buf);
 	ret = block_writer_init(&bw, BLOCK_TYPE_INDEX, block.data, block_size,
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 3d2848632d..3c84363e98 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -29,7 +29,9 @@ merged_table_from_records(struct reftable_ref_record **refs,
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(*readers, n);
+	check(*readers != NULL);
 	REFTABLE_CALLOC_ARRAY(*source, n);
+	check(*source != NULL);
 
 	for (size_t i = 0; i < n; i++) {
 		t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
@@ -285,7 +287,9 @@ merged_table_from_log_records(struct reftable_log_record **logs,
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(*readers, n);
+	check(*readers != NULL);
 	REFTABLE_CALLOC_ARRAY(*source, n);
+	check(*source != NULL);
 
 	for (size_t i = 0; i < n; i++) {
 		t_reftable_write_to_buf(&buf[i], NULL, 0, logs[i], sizes[i], &opts);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index acca927a2c..bfa069caff 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -52,8 +52,11 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 	int i;
 
 	REFTABLE_CALLOC_ARRAY(*names, N + 1);
+	check(*names != NULL);
 	REFTABLE_CALLOC_ARRAY(refs, N);
+	check(refs != NULL);
 	REFTABLE_CALLOC_ARRAY(logs, N);
+	check(logs != NULL);
 
 	for (i = 0; i < N; i++) {
 		refs[i].refname = (*names)[i] = xstrfmt("refs/heads/branch%02d", i);
@@ -150,23 +153,25 @@ static void t_log_overflow(void)
 
 static void t_log_write_read(void)
 {
-	int N = 2;
-	char **names = reftable_calloc(N + 1, sizeof(*names));
-	int err;
 	struct reftable_write_options opts = {
 		.block_size = 256,
 	};
 	struct reftable_ref_record ref = { 0 };
-	int i = 0;
 	struct reftable_log_record log = { 0 };
-	int n;
 	struct reftable_iterator it = { 0 };
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	const struct reftable_stats *stats = NULL;
+	int N = 2, err, i, n;
+	char **names;
+
+	names = reftable_calloc(N + 1, sizeof(*names));
+	check(names != NULL);
+
 	reftable_writer_set_limits(w, 0, N);
+
 	for (i = 0; i < N; i++) {
 		char name[256];
 		struct reftable_ref_record ref = { 0 };
@@ -178,6 +183,7 @@ static void t_log_write_read(void)
 		err = reftable_writer_add_ref(w, &ref);
 		check(!err);
 	}
+
 	for (i = 0; i < N; i++) {
 		struct reftable_log_record log = { 0 };
 
@@ -476,8 +482,7 @@ static void t_table_read_write_seek_index(void)
 
 static void t_table_refs_for(int indexed)
 {
-	int N = 50;
-	char **want_names = reftable_calloc(N + 1, sizeof(*want_names));
+	char **want_names;
 	int want_names_len = 0;
 	uint8_t want_hash[GIT_SHA1_RAWSZ];
 
@@ -485,15 +490,15 @@ static void t_table_refs_for(int indexed)
 		.block_size = 256,
 	};
 	struct reftable_ref_record ref = { 0 };
-	int i = 0;
-	int n;
-	int err;
 	struct reftable_reader *reader;
 	struct reftable_block_source source = { 0 };
 	struct strbuf buf = STRBUF_INIT;
 	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
 	struct reftable_iterator it = { 0 };
-	int j;
+	int N = 50, n, j, err, i;
+
+	want_names = reftable_calloc(N + 1, sizeof(*want_names));
+	check(want_names != NULL);
 
 	t_reftable_set_hash(want_hash, 4, GIT_SHA1_FORMAT_ID);
 
-- 
2.46.2.852.g229c0bf0e5.dirty

