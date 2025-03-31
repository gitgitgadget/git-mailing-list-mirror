Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D01D63E1
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410497; cv=none; b=FKA6pZ1OPA7m8NZOgzWIMRSxy6z1qeN7svMn3FiFm2m8K+Zk3XQ6lCAk/Fnc/IelMyLV4XJCCWNfSdMDtNOxdqLlEUnt+IW6179Zaptovk+N4p79rSk0D67dOKTpp/UJAHoJxohtTSVspBWE64/RZfdQkrPHzMhwZy2nhepsMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410497; c=relaxed/simple;
	bh=Xf2c0usNbbdqHIQ5jI0XgbdYAduuAJKWHK16y03uO4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F+F+S4frTQ19YdETjLsQql6TfW4vVcD733Mnic0LO5bvZsnYTArBMZbKBP1GllfIE+GTpQUsld61pivYSt465NCPMSNJfp6XuX9h7F3KGF+eB9G2JjzUoQqell7geY/lwh1B2YtFWJMguF28xaWmFnLWGV8JV+HTaHpAAMkydM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+aRdLjm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jWaKWx4x; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+aRdLjm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jWaKWx4x"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 658F01382D37
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Mar 2025 04:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410495;
	 x=1743496895; bh=7EqkI8g+LtMedBS/FW2hTZMggaiE7vPO2nUWCNmzPMc=; b=
	V+aRdLjmHT3MAn2//2nt2+nnrI2qHxjzHeONEbN9shhtQkJ1L0BSQHn+ryoIpbl3
	ySm9S984vN4UA5Qirxa1VkEwGYLvFxdhic7AXOjCD6c0DcmV2M9SjKJ4CQnmZjR0
	tczh6j/y1wiGvzsIRtFjIMo/iyX/m1DLjrXBx+tSCJvqqNLQQC7EduYhF1LeCMjM
	DJxV6Qokj26HlPC7SSLJNEE91mYZ86Rar3XFtMaKOAorZRBLqN1WYegibaxGTn48
	v1dRzKxOlbwXXFk7q688g/UySi7L5phNsm0CWweaKhXjORPjmxLrVspBuIhSDBVz
	EiCZzakukURzH3xojhMPQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410495; x=
	1743496895; bh=7EqkI8g+LtMedBS/FW2hTZMggaiE7vPO2nUWCNmzPMc=; b=j
	WaKWx4xHkhVkMInyX3v6f32h1bUQTvZdjWJdjg8xJ36oGs54NWeV63BE3I2S6RyE
	b/oU0qd6ogywOd/CtWgVZx22mbk4/onNRBFhsnALmMhsAgxxyxKQ80zluZCA7toL
	YUDPx/gYKnqRkOBWCx1dANHbQ42INzg6fnVM4ocjiM753EEayiDlGl+1/N+/pBG+
	W32Vff9jEpSh7Wb8MXB0au1qdNdEco99ON66HcQw4n8GljFNzzGu9uqtBfENuyuG
	BgI2V1wWcWqh7grkxuQ8Dvcgo5tJI/qNjAgUhlZ2Bg8CC0Lb6cDBRTQSEQMmbgSx
	wWK8hzQPBlQzBFQj0OZTw==
X-ME-Sender: <xms:P1XqZ1TApvs2wCHWAPgLuxHtIOgjDkHjnCijDINpaI29y634Q57hFw>
    <xme:P1XqZ-x3MWSi1qv98KbDDjmmaSUfuadxDPeAz1-U9R8QOBFrwI4tYKxgzpB1bmBRZ
    zav4uDd9d2Xigh9Xg>
X-ME-Received: <xmr:P1XqZ61vvkeV-BdYmT7MFFoehLw_4LrDoIt-rrR5Eoqte4U57e6ZkgGYXm2Q6QC-ePdXS0vyyLtxp812Hhn2UmuNWtZzkLkdDyPhY6aacLVgd_FM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:P1XqZ9BmyuLlVZFX3cg5X-Z_jHgsaPUx-MHusCxj3hkNHx1FsMOO4Q>
    <xmx:P1XqZ-hqkMypKePHa5QCE0ylfdbps1ewfrQM1P2dVO1Fa7ZlK6PmIw>
    <xmx:P1XqZxqRUBg7jPRtcpcJWpGrYyxGCYnAQWHzfOBNnYbhpJ0LrzSHpg>
    <xmx:P1XqZ5i1QH--Pd-brhhHP-pOEzY3047R4ElRu3dt73QYUd23SaZ74A>
    <xmx:P1XqZyZ8WRkXNFK3eqxEW1cMLplFJ4eaLLDugsTR5dt0-1fwYJz1ywS4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b390e54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:32 +0200
Subject: [PATCH 14/16] reftable/table: introduce iterator for table blocks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-14-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Introduce a new iterator that allows the caller to iterate through all
blocks contained in a table. This gives users more fine-grained control
over how exactly those blocks are being read and exposes information to
callers that was previously inaccessible.

This iterator will be required by a future patch series that adds
consistency checks for the reftable backend. In addition to that though
we will also reimplement `reftable_table_print_blocks()` on top of this
new iterator in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-table.h       |  16 ++++++
 reftable/table.c                |  47 +++++++++++++++++
 t/unit-tests/t-reftable-table.c | 109 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)

diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
index a78db9eea7e..f0f1784c664 100644
--- a/reftable/reftable-table.h
+++ b/reftable/reftable-table.h
@@ -10,6 +10,7 @@
 #define REFTABLE_TABLE_H
 
 #include "reftable-iterator.h"
+#include "reftable-block.h"
 #include "reftable-blocksource.h"
 
 /*
@@ -99,4 +100,19 @@ uint64_t reftable_table_min_update_index(struct reftable_table *t);
 /* print blocks onto stdout for debugging. */
 int reftable_table_print_blocks(const char *tablename);
 
+/*
+ * An iterator that iterates through the blocks contained in a given table.
+ */
+struct reftable_table_iterator {
+	void *iter_arg;
+};
+
+int reftable_table_init_table_iterator(struct reftable_table *t,
+				       struct reftable_table_iterator *it);
+
+void reftable_table_iterator_release(struct reftable_table_iterator *it);
+
+int reftable_table_iterator_next(struct reftable_table_iterator *it,
+				 const struct reftable_block **out);
+
 #endif
diff --git a/reftable/table.c b/reftable/table.c
index 5422ed6769c..d84a87e7ad0 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -804,3 +804,50 @@ int reftable_table_print_blocks(const char *tablename)
 	table_iter_close(&ti);
 	return err;
 }
+
+int reftable_table_init_table_iterator(struct reftable_table *t,
+				       struct reftable_table_iterator *it)
+{
+	struct table_iter *ti;
+	int err;
+
+	REFTABLE_ALLOC_ARRAY(ti, 1);
+	if (!ti)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+	err = table_iter_init(ti, t);
+	if (err < 0)
+		goto out;
+
+	it->iter_arg = ti;
+	err = 0;
+
+out:
+	if (err < 0)
+		reftable_free(ti);
+	return err;
+}
+
+void reftable_table_iterator_release(struct reftable_table_iterator *it)
+{
+	if (!it->iter_arg)
+		return;
+	table_iter_close(it->iter_arg);
+	reftable_free(it->iter_arg);
+	it->iter_arg = NULL;
+}
+
+int reftable_table_iterator_next(struct reftable_table_iterator *it,
+				 const struct reftable_block **out)
+{
+	struct table_iter *ti = it->iter_arg;
+	int err;
+
+	err = table_iter_next_block(ti);
+	if (err)
+		return err;
+
+	*out = &ti->block;
+
+	return 0;
+}
diff --git a/t/unit-tests/t-reftable-table.c b/t/unit-tests/t-reftable-table.c
index 77c59dbf46d..58b13ad496f 100644
--- a/t/unit-tests/t-reftable-table.c
+++ b/t/unit-tests/t-reftable-table.c
@@ -1,7 +1,10 @@
 #include "test-lib.h"
 #include "lib-reftable.h"
 #include "reftable/blocksource.h"
+#include "reftable/constants.h"
+#include "reftable/iter.h"
 #include "reftable/table.h"
+#include "strbuf.h"
 
 static int t_table_seek_once(void)
 {
@@ -88,9 +91,115 @@ static int t_table_reseek(void)
 	return 0;
 }
 
+static int t_table_block_iterator(void)
+{
+	struct reftable_block_source source = { 0 };
+	struct reftable_table_iterator it = { 0 };
+	struct reftable_ref_record *records;
+	const struct reftable_block *block;
+	struct reftable_table *table;
+	struct reftable_buf buf = REFTABLE_BUF_INIT;
+	struct {
+		uint8_t block_type;
+		uint16_t header_off;
+		uint16_t restart_count;
+		uint16_t record_count;
+	} expected_blocks[] = {
+		{
+			.block_type = BLOCK_TYPE_REF,
+			.header_off = 24,
+			.restart_count = 10,
+			.record_count = 158,
+		},
+		{
+			.block_type = BLOCK_TYPE_REF,
+			.restart_count = 10,
+			.record_count = 159,
+		},
+		{
+			.block_type = BLOCK_TYPE_REF,
+			.restart_count = 10,
+			.record_count = 159,
+		},
+		{
+			.block_type = BLOCK_TYPE_REF,
+			.restart_count = 2,
+			.record_count = 24,
+		},
+		{
+			.block_type = BLOCK_TYPE_INDEX,
+			.restart_count = 1,
+			.record_count = 4,
+		},
+		{
+			.block_type = BLOCK_TYPE_OBJ,
+			.restart_count = 1,
+			.record_count = 1,
+		},
+	};
+	const size_t nrecords = 500;
+	int ret;
+
+	REFTABLE_CALLOC_ARRAY(records, nrecords);
+	for (size_t i = 0; i < nrecords; i++) {
+		records[i].value_type = REFTABLE_REF_VAL1,
+		records[i].refname = xstrfmt("refs/heads/branch-%03"PRIuMAX, (uintmax_t) i);
+	}
+
+	t_reftable_write_to_buf(&buf, records, nrecords, NULL, 0, NULL);
+	block_source_from_buf(&source, &buf);
+
+	ret = reftable_table_new(&table, &source, "name");
+	check(!ret);
+
+	ret = reftable_table_init_table_iterator(table, &it);
+	check(!ret);
+
+	for (size_t i = 0; i < ARRAY_SIZE(expected_blocks); i++) {
+		struct reftable_iterator record_it = { 0 };
+		struct reftable_record record = {
+			.type = expected_blocks[i].block_type,
+		};
+
+		ret = reftable_table_iterator_next(&it, &block);
+		check(!ret);
+
+		check_int(block->block_type, ==, expected_blocks[i].block_type);
+		check_int(block->header_off, ==, expected_blocks[i].header_off);
+		check_int(block->restart_count, ==, expected_blocks[i].restart_count);
+
+		ret = reftable_block_init_iterator(block, &record_it);
+		check(!ret);
+
+		for (size_t j = 0; ; j++) {
+			ret = iterator_next(&record_it, &record);
+			if (ret > 0) {
+				check_int(j, ==, expected_blocks[i].record_count);
+				break;
+			}
+			check(!ret);
+		}
+
+		reftable_iterator_destroy(&record_it);
+		reftable_record_release(&record);
+	}
+
+	ret = reftable_table_iterator_next(&it, &block);
+	check_int(ret, ==, 1);
+
+	for (size_t i = 0; i < nrecords; i++)
+		reftable_free(records[i].refname);
+	reftable_table_iterator_release(&it);
+	reftable_table_decref(table);
+	reftable_buf_release(&buf);
+	reftable_free(records);
+	return 0;
+}
+
 int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_table_seek_once(), "table can seek once");
 	TEST(t_table_reseek(), "table can reseek multiple times");
+	TEST(t_table_block_iterator(), "table can iterate through blocks");
 	return test_done();
 }

-- 
2.49.0.604.gff1f9ca942.dirty

