Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597511B533B
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881511; cv=none; b=fEHsLmW91xlxiSDaY0x/EVkyw0J+yyKsvxVHFeD7Oew+mf/18l1tgxZUNk7j8e5cewidcHyD7QB+9f/eKZl7npZh76xxOO1rvVn5ZcXilNfdc06XC8E69oOxQh9w/7domX2baZCgtUJfmvYp5OV4GH04NVwq/SPpkiIejggh54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881511; c=relaxed/simple;
	bh=TzSapjE4Ef2XMswpfqljc6b8cdN8wrCforNZf8O0UE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipdpin0uJ4WA42Pbgq+MzjiQsf7114nbmXwjxjlO23emx2GknoYyw19qfbCCKflaEc0NPEatjO2nyhouk1FDCxq2ZIhvHU2yYMl9ARxoFxYL7t3nQJYAe2ceu1120tklV/dXXAZzeO23sAxLFReXtFp9CHL1bDemlailGeuYS0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AnpYlefF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SbJUwIq/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AnpYlefF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SbJUwIq/"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C21411400E8;
	Mon,  9 Sep 2024 07:31:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 09 Sep 2024 07:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725881508; x=1725967908; bh=gBZyuxLWPo
	67HU1BdFpCcCu64u7sGkIAGUiVmo6Y6O4=; b=AnpYlefFcB6Vv3abukSWallwsM
	qXv7rJd65RlbaN+hDHGaW7CUWmLs5uXcGpcGl8ken1wqc2r/28+IWrByLFQ+0c9A
	RZbrAv0MbqBTCilfMvCT9xwbb0kZ4J9PX4eoIP3MZP+I5/oTMt+3i4aLq1H45J6u
	u+MZSpVkkYJj+Kq72ETBLa0ZiOAWCaERLQobmE7e+yWXhTTigGZNUL06iQpR6Ea1
	0qHYqWyuClFDApNnw+yTasAYbLmpyypWRWtvvjA3eYNjU9GLSbflf5q/RywTfmnW
	wJ3GS/7fxtcpxyWFMtG081lFZ5bUy+HuDKG/6ZG3dYLP42ExC1onq29Nc62Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725881508; x=1725967908; bh=gBZyuxLWPo67HU1BdFpCcCu64u7s
	GkIAGUiVmo6Y6O4=; b=SbJUwIq/ESSBwiOXF/DIucEgrvo7MYFOQvnD+wG1VXhf
	VORWir/GjTQEuldC7e/cwWVKHSrTc6yZPb0kqugnMEUUlqytqrDihY8gJ0K3OvEr
	Zzk0oyYkoxrehu6Iy0NhFoVXtTLnBei72Xxrz6yg7OwPsgNbRaQvwpFhdun1ZWIH
	6SQWvrZK4YmS0TOIvLA52jQWx35ubIw9Wj1qPn6gzk81uiOWgU+jcHaASb+gVjdg
	TUN4hJgPXkAs8+lzcSOZRb3IRHbpcAV9sGfjDP/IJ2juF1EZGkM6OLu+2DsEnBhp
	UyWy54aToeDgW91n/zNiOJweZUH2OSNfTW4b5gMFUA==
X-ME-Sender: <xms:pNzeZownRJseVG7SWZptB_GzPjHy9XoDqcHbsdqYuSkW4KCpUeYbPg>
    <xme:pNzeZsS6knwiDRDMGJM-lENMdQDN40UbYbo2NTWDFaW0Plh95yhkUq8fy0whZGlaQ
    sI8tBCAMyw5gvjeKA>
X-ME-Received: <xmr:pNzeZqX1VfoLRClm4SY29VYLWUwi4BIM0FLU-MJaevDqf1s6kw3NnqUypi-dCoOjqXdB5aBBrcKva_FWDqCyywyFK0T5oVxyf2zYgATYwzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:pNzeZmhBS6CAEEoWrY2VAZmpFM6s049vupeDj4EHnaQv4bQULMB-Ew>
    <xmx:pNzeZqAN8pRZU-OHA4DVvFLjgcQMpmo5hsX4u2_LuKme8JVaNdHEkA>
    <xmx:pNzeZnIptLNEWanG85uO0QcXNQs5ND93CeO2vApKPJElaif2eGgycw>
    <xmx:pNzeZhCjp-SfSHzYiBizt-3E3X6yBwdA1Dl1BtjRVxjOEZW3kQSX0g>
    <xmx:pNzeZtMulZ4MUFM_5RGrAoHSthKp5A1vchRiUlJ7GgPcgDwqKxiTgzsd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Sep 2024 07:31:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d450b42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Sep 2024 11:31:45 +0000 (UTC)
Date: Mon, 9 Sep 2024 13:31:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 5/6] reftable/reader: make table iterator reseekable
Message-ID: <a281f936a2b3a697b32f57652a2120afd54f7e4f.1725881266.git.ps@pks.im>
References: <cover.1725881266.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725881266.git.ps@pks.im>

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
index 00000000000..7a46580b6f1
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
+	check_int(ret, ==, 0);
+
+	reftable_reader_init_ref_iterator(reader, &it);
+	ret = reftable_iterator_seek_ref(&it, "");
+	check_int(ret, ==, 0);
+	ret = reftable_iterator_next_ref(&it, &ref);
+	check_int(ret, ==, 0);
+
+	ret = reftable_ref_record_equal(&ref, &records[0], 20);
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
+	check_int(ret, ==, 0);
+
+	reftable_reader_init_ref_iterator(reader, &it);
+
+	for (size_t i = 0; i < 5; i++) {
+		ret = reftable_iterator_seek_ref(&it, "");
+		check_int(ret, ==, 0);
+		ret = reftable_iterator_next_ref(&it, &ref);
+		check_int(ret, ==, 0);
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
2.46.0.519.g2e7b89e038.dirty

