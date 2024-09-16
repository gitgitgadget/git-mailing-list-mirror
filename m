Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BD14884C
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476619; cv=none; b=fRGTWQXGEJ1K7v6Afno3DLobJpFg5eZYKBYs9UCMMCuh1B///3C+VHBIDHNYedpcddk7nU8CaEZGOQYKiNlAsEj/9hOKLxBRwd55gbMP+U+500TmlLIbvdAoon5ygqvW3jXIsP8oXpeJ2fdJBDD/ZoKB3UsDpIR9lyF6sIf5CG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476619; c=relaxed/simple;
	bh=os7N13m4Y6tWul9EGsHILivNMtMq9dKjrSIoVBalJfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5a17aCu64ENbC7LtYlHBf5eF7wx9QBSuHfaGOdvc3w9FaLm2c8P4YEmemikeGar/95xMH9z9Zco1kFgzrtJ1lm6qd5dcFij8buHZKF4tTztK3Ti4K8OmUoI/00B8rq2W9P2Zlo2Q3ISLocEL4iSIX+CzSjAg94CQIesXyCUY2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V35v9g5w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2LQ5e4A; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V35v9g5w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2LQ5e4A"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6289B114023C;
	Mon, 16 Sep 2024 04:50:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Sep 2024 04:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726476616; x=1726563016; bh=Z5Y4uDVA3M
	MlOFe6S44JBYjAEXqkuhaeYyQorJgl868=; b=V35v9g5wGzYPhBUw7vGPRCfYmO
	/zDz1FDxSd3WFqIeaB7U2mQ5V8iS94JGCBffkhBCq1bUGptyf91rvWCyGvdZgIwg
	aN01atyt20Pej8bkat0gqw9E/tkDfLXzSeenfoT8pK5Z4VaYU1z5z08qa/QyJ7fB
	bb2dzID+GvXALyeChyNCgftFiP4oY4ME6aR9+jTebinSOkpSpbJFOyDgeGFfUqWo
	Slogv+GKfj8DPBXOfSmSE7qQvoX/gUwWev4MYSOOWCb2ovqWo324gNqS9OAbJoGC
	8UhJxWoJm1Uuv4t47OokB4klU9JmRjMhuG+D7zeHWEZaW3RkVPCn0V3Ft9NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726476616; x=1726563016; bh=Z5Y4uDVA3MMlOFe6S44JBYjAEXqk
	uhaeYyQorJgl868=; b=k2LQ5e4ASoKtyMRorKv0qBWuvzRkzIq0fD5D7nQiXEBC
	E84rIREaM/GBCfkD9ioqAI27g8SRknnULIXMJhMlYwQ2CBpcxD0uQIM+OGqLP7qG
	jpMYZ7l8V02UT/N3rWct10TWzyvCMHJfgdswEqbfyP4IHxG2XS4cs0BA+xZwixUu
	V9QTpaLxV/PUZkt1sa40r1dT95hw1c8Ec05tyLJ7rAja4kWhW6gT5xeyFXBa52v8
	1w5TVtgXjXT+XjJr8Wy72cGFh+3bOkEjses4uc3k0DiPpjwXyqe0pykjF8s92pOA
	0gdAdXhBf/P0BZNV8rF3o3VpaUcXvNb0nTJ0L50aSQ==
X-ME-Sender: <xms:SPHnZr8BlHm1vtcXAtgJvkNkqYqN9k3rUAA4N91npyyUf059pLBT_g>
    <xme:SPHnZnt0oEPiNiKFfGuwVmuPalTtTqzdoOkbx7KFrdFlA9s3ybvMQ3VbMLQIM3CY6
    0XoD9j0ahqwENGBHw>
X-ME-Received: <xmr:SPHnZpByvPZZDPpYoMr7_yJZM9h38XE75pbr_Xz7Nyo2sKDYlDb8ygkm2oVj11MI0G9wPCzdEQmGG35taDCaQPyWqoNeKrzovLY-5J5NpTPgTxCa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SPHnZneTzR4UGC2seTTqvpRY67lM4OpIhDV58umUX3Hvq9TgcAm3OA>
    <xmx:SPHnZgN4_C-m_C5A98PD0w7KOsHH1gxR13WiNAZJtyMxLgQ37PfB6Q>
    <xmx:SPHnZpln_P86dGsReySw5rKoAeClFqDiTlwZ194NI4zduMNK_Oqowg>
    <xmx:SPHnZqsjNWWLD4VNsBwgWgYt4d0FLQoK5jaFOS5sz-hJ0_05za9Okg>
    <xmx:SPHnZlrHpqnzArEE6tNk_wnEZs9lOp8zUiUpilHdNgq7LdDURHfFFxOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 04:50:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6298146 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 08:49:58 +0000 (UTC)
Date: Mon, 16 Sep 2024 10:50:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 5/6] reftable/reader: make table iterator reseekable
Message-ID: <3278cdf92fe7632b3798a732ad68044ab1d4adc2.1726476401.git.ps@pks.im>
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

In 67ce50ba26 (Merge branch 'ps/reftable-reusable-iterator', 2024-05-30)
we have refactored the interface of reftable iterators such that they
can be reused in theory. This patch series only landed the required
changes on the interface level, but didn't yet implement the actual
logic to make iterators reusable.

As it turns out almost all of the infrastructure already does support
re-seeking. The only exception is the table iterator, which does not
reset its `is_finished` bit. Do so and add a couple of tests that verify
that we can re-seek iterators.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                         |  1 +
 reftable/reader.c                |  1 +
 t/unit-tests/t-reftable-merged.c | 76 +++++++++++++++++++++++++
 t/unit-tests/t-reftable-reader.c | 96 ++++++++++++++++++++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 t/unit-tests/t-reftable-reader.c

diff --git a/Makefile b/Makefile
index 9460a80d0dd..4039e355b09 100644
--- a/Makefile
+++ b/Makefile
@@ -1346,6 +1346,7 @@ UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
 UNIT_TEST_PROGRAMS += t-reftable-merged
 UNIT_TEST_PROGRAMS += t-reftable-pq
+UNIT_TEST_PROGRAMS += t-reftable-reader
 UNIT_TEST_PROGRAMS += t-reftable-readwrite
 UNIT_TEST_PROGRAMS += t-reftable-record
 UNIT_TEST_PROGRAMS += t-reftable-stack
diff --git a/reftable/reader.c b/reftable/reader.c
index f8770990876..6494ce2e327 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -328,6 +328,7 @@ static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t typ)
 	ti->typ = block_reader_type(&ti->br);
 	ti->block_off = off;
 	block_iter_seek_start(&ti->bi, &ti->br);
+	ti->is_finished = 0;
 	return 0;
 }
 
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index b8c92fdb365..19e54bdfb8b 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -194,6 +194,81 @@ static void t_merged_refs(void)
 	reftable_free(bs);
 }
 
+static void t_merged_seek_multiple_times(void)
+{
+	struct reftable_ref_record r1[] = {
+		{
+			.refname = (char *) "a",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 1 },
+		},
+		{
+			.refname = (char *) "c",
+			.update_index = 1,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 2 },
+		}
+	};
+	struct reftable_ref_record r2[] = {
+		{
+			.refname = (char *) "b",
+			.update_index = 2,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 3 },
+		},
+		{
+			.refname = (char *) "d",
+			.update_index = 2,
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 4 },
+		},
+	};
+	struct reftable_ref_record *refs[] = {
+		r1, r2,
+	};
+	size_t sizes[] = {
+		ARRAY_SIZE(r1), ARRAY_SIZE(r2),
+	};
+	struct strbuf bufs[] = {
+		STRBUF_INIT, STRBUF_INIT,
+	};
+	struct reftable_block_source *sources = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_merged_table *mt;
+
+	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+
+	for (size_t i = 0; i < 5; i++) {
+		int err = reftable_iterator_seek_ref(&it, "c");
+		check(!err);
+
+		err = reftable_iterator_next_ref(&it, &rec);
+		check(!err);
+		err = reftable_ref_record_equal(&rec, &r1[1], GIT_SHA1_RAWSZ);
+		check(err == 1);
+
+		err = reftable_iterator_next_ref(&it, &rec);
+		check(!err);
+		err = reftable_ref_record_equal(&rec, &r2[1], GIT_SHA1_RAWSZ);
+		check(err == 1);
+
+		err = reftable_iterator_next_ref(&it, &rec);
+		check(err > 0);
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
+		strbuf_release(&bufs[i]);
+	readers_destroy(readers, ARRAY_SIZE(refs));
+	reftable_ref_record_release(&rec);
+	reftable_iterator_destroy(&it);
+	reftable_merged_table_free(mt);
+	reftable_free(sources);
+}
+
 static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
@@ -383,6 +458,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_default_write_opts(), "merged table with default write opts");
 	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
 	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
+	TEST(t_merged_seek_multiple_times(), "merged table can seek multiple times");
 	TEST(t_merged_single_record(), "ref ocurring in only one record can be fetched");
 
 	return test_done();
diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
new file mode 100644
index 00000000000..eea86966c0d
--- /dev/null
+++ b/t/unit-tests/t-reftable-reader.c
@@ -0,0 +1,96 @@
+#include "test-lib.h"
+#include "lib-reftable.h"
+#include "reftable/blocksource.h"
+#include "reftable/reader.h"
+
+static int t_reader_seek_once(void)
+{
+	struct reftable_ref_record records[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 42 },
+		},
+	};
+	struct reftable_block_source source = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader *reader;
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	block_source_from_strbuf(&source, &buf);
+
+	ret = reftable_reader_new(&reader, &source, "name");
+	check(!ret);
+
+	reftable_reader_init_ref_iterator(reader, &it);
+	ret = reftable_iterator_seek_ref(&it, "");
+	check(!ret);
+	ret = reftable_iterator_next_ref(&it, &ref);
+	check(!ret);
+
+	ret = reftable_ref_record_equal(&ref, &records[0], GIT_SHA1_RAWSZ);
+	check_int(ret, ==, 1);
+
+	ret = reftable_iterator_next_ref(&it, &ref);
+	check_int(ret, ==, 1);
+
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+	strbuf_release(&buf);
+	return 0;
+}
+
+static int t_reader_reseek(void)
+{
+	struct reftable_ref_record records[] = {
+		{
+			.refname = (char *) "refs/heads/main",
+			.value_type = REFTABLE_REF_VAL1,
+			.value.val1 = { 42 },
+		},
+	};
+	struct reftable_block_source source = { 0 };
+	struct reftable_ref_record ref = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_reader *reader;
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
+	block_source_from_strbuf(&source, &buf);
+
+	ret = reftable_reader_new(&reader, &source, "name");
+	check(!ret);
+
+	reftable_reader_init_ref_iterator(reader, &it);
+
+	for (size_t i = 0; i < 5; i++) {
+		ret = reftable_iterator_seek_ref(&it, "");
+		check(!ret);
+		ret = reftable_iterator_next_ref(&it, &ref);
+		check(!ret);
+
+		ret = reftable_ref_record_equal(&ref, &records[0], GIT_SHA1_RAWSZ);
+		check_int(ret, ==, 1);
+
+		ret = reftable_iterator_next_ref(&it, &ref);
+		check_int(ret, ==, 1);
+	}
+
+	reftable_ref_record_release(&ref);
+	reftable_iterator_destroy(&it);
+	reftable_reader_decref(reader);
+	strbuf_release(&buf);
+	return 0;
+}
+
+int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
+{
+	TEST(t_reader_seek_once(), "reader can seek once");
+	TEST(t_reader_reseek(), "reader can reseek multiple times");
+	return test_done();
+}
-- 
2.46.0.551.gc5ee8f2d1c.dirty

