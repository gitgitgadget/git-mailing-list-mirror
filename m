Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC21957FF
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603399; cv=none; b=IbSrdciR2V+vjOtbpQUJVaP/HQNzNIZxPTKOTbWcRi7s7OSrGe40juS0kFWb4jIHCpQZl+QgOqjS0vfrg3pWfTBr/FFBwmwdG/pWfWy1ci6bdWIaYqeQ33p+xp54COPIoTti4UsvupHMOV++O2cJSCjtvA4DK5xCPAS8x6oKcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603399; c=relaxed/simple;
	bh=uUPaBBPP0gxrd2yBLKHUDE++1sBdqt0WVcimtJ5GcFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkT56YmwSLsTLNnWCHAG0c9zBW+MoG/MTEdHJgfJO1lDVz6MWi1qAYyMm78L4ZuNIbNx/7REeR1uF5YdMVfWarDdu4zDtJ5gezIzG4eS/cmZnQzzWfY4iI4mLvVkDacRaGwzLdRU1nx1oQqjhPDBqI7+zVLFHGC6A8YYr/du4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gON6qz5q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r/hQX59w; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gON6qz5q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r/hQX59w"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E11C11401CA;
	Tue, 26 Nov 2024 01:43:16 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 26 Nov 2024 01:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603396;
	 x=1732689796; bh=dX17a32p2VvqyhiVIIa/68qE5g0l3FBuVpmR3eWFDyQ=; b=
	gON6qz5qfn1ljjwznz/b2gcMI8yKfIIsYmDNUuGcDVqg9GYCbV+TMz6bF7ANW2mY
	3YrvRAhIiUYUoBuchpd4tM7aGt5qXkz36tuvnO6YXe55MTPcv6vpDVVge4bf2P21
	dWyqjIEVCj/qZpNcynYrdLrqimFuOIfugek2pAFHeGV49rtzJVDjCbLoXKFK5vae
	dNEaBSuXdDNTrD9UkjtGtbakiXvXsra/hoT4275szbSNryNFKRpEauw3Y7pr2Z7q
	qwpc/g2dKkoQMpMQF213uNLUPoEnMl8qMqcZrgFubP1RvQ+2D6+YAeZ5iGPGPnrx
	IaphyMUuArM5NjNrjUIPLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603396; x=
	1732689796; bh=dX17a32p2VvqyhiVIIa/68qE5g0l3FBuVpmR3eWFDyQ=; b=r
	/hQX59wW81BDMo+PtAV6qHc7qU6DzDcc6BwWdrOFinzNia9ZE7QGD8tWz1sWJR1V
	2VdjAVTss5I7gxMapjWWCYouN805crqCiuy/Jzscf3xcn0LQGcu5lSeNLZxbVlDN
	OiwG+Vu52J41tW1OBKCfrBEGj+n5FTY9jerbaEGpnYiY1yj57d6afjL8f2kt75KW
	QUx2phQ1K2tdwtCIGjk21ccTlamnuBv/YeYHv6jbKLkYBK/3EkXMWYnK9OjzySBB
	Xc4RnHnvnH3ANP9HVShB/SrAqmKtLEPOiYha6Cm54T5zBYdhUO/i/2h+iBqf+2ly
	HBKZF4bqKZy9S7Y+SnwLg==
X-ME-Sender: <xms:BG5FZ27Ew_1twhGJB_Hh2vMfsdyJ_D9Xp5Hg8Ofh9LtVwXSdNY6tfQ>
    <xme:BG5FZ_6SM7Do1uIybUAT90jkt_bVqQyEAfCbotXdw2ii_nbq7A_8gimr12fy-hv_M
    ZpLVc5D0ric16opDQ>
X-ME-Received: <xmr:BG5FZ1cijhl0o_-_A0JNxWNQlhosME2k72GKMyNxdMTri9_nsLhMocUmZofFjLF1ufMaVyCVvh6CAkTOtzmLjReneljieVUoppk9awrGXM4vB4or>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BG5FZzI1dvO4bl1qTL4DLs51hTG_P9eTolzbwxAhYsxcdv4p32Vy0g>
    <xmx:BG5FZ6JWe38iu88k8qOPqTFrdB13QgaKdw8A_iSRrWAIYn-I3D19Jw>
    <xmx:BG5FZ0wLmPEolQ3kYJQtqjjIOWedlvkE5Z5xv4qyqkTWe4b0cDI7FA>
    <xmx:BG5FZ-KokDzlC1ncrdC-cKXkGPCBwUfbq3ctNoxayub_fXXrfVBSMA>
    <xmx:BG5FZ20OQk-lI2-B-ETI6ycXrIvQw7b_am9XDqSEPS7q0yk-lCxkdfX0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98dd281c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:43:00 +0100
Subject: [PATCH v4 09/10] reftable/merged: drain priority queue on reseek
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-9-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In 5bf96e0c39 (reftable/generic: move seeking of records into the
iterator, 2024-05-13) we have refactored the reftable codebase such that
iterators can be initialized once and then re-seeked multiple times.
This feature is used by 1869525066 (refs/reftable: wire up support for
exclude patterns, 2024-09-16) in order to skip records based on exclude
patterns provided by the caller.

The logic to re-seek the merged iterator is insufficient though because
we don't drain the priority queue on a re-seek. This means that the
queue may contain stale entries and thus reading the next record in the
queue will return the wrong entry. While this is an obvious bug, it is
harmless in the context of above exclude patterns:

  - If the queue contained stale entries that match the pattern then the
    caller would already know to filter out such refs. This is because
    our codebase is prepared to handle backends that don't have a way to
    efficiently implement exclude patterns.

  - If the queue contained stale entries that don't match the pattern
    we'd eventually filter out any duplicates. This is because the
    reftable code discards items with the same ref name and sorts any
    remaining entries properly.

So things happen to work in this context regardless of the bug, and
there is no other use case yet where we re-seek iterators. We're about
to introduce a caching mechanism though where iterators are reused by
the reftable backend, and that will expose the bug.

Fix the issue by draining the priority queue when seeking and add a
testcase that surfaces the issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                |  2 ++
 t/unit-tests/t-reftable-merged.c | 73 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/reftable/merged.c b/reftable/merged.c
index 5b93e20f42945300abbc1a036bbdf067fced7854..bb0836e3443271f9c0d5ba5582c78694d437ddc2 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -66,6 +66,8 @@ static int merged_iter_seek(struct merged_iter *mi, struct reftable_record *want
 	int err;
 
 	mi->advance_index = -1;
+	while (!merged_iter_pqueue_is_empty(mi->pq))
+		merged_iter_pqueue_remove(&mi->pq);
 
 	for (size_t i = 0; i < mi->subiters_len; i++) {
 		err = iterator_seek(&mi->subiters[i].iter, want);
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index 2591b5e59745536a205271491f747875e04c5a3f..a12bd0e1a3bdeda82bcbc6259e679df4f232e3e2 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -273,6 +273,78 @@ static void t_merged_seek_multiple_times(void)
 	reftable_free(sources);
 }
 
+static void t_merged_seek_multiple_times_without_draining(void)
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
+	struct reftable_buf bufs[] = {
+		REFTABLE_BUF_INIT, REFTABLE_BUF_INIT,
+	};
+	struct reftable_block_source *sources = NULL;
+	struct reftable_reader **readers = NULL;
+	struct reftable_ref_record rec = { 0 };
+	struct reftable_iterator it = { 0 };
+	struct reftable_merged_table *mt;
+	int err;
+
+	mt = merged_table_from_records(refs, &sources, &readers, sizes, bufs, 2);
+	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
+
+	err = reftable_iterator_seek_ref(&it, "b");
+	check(!err);
+	err = reftable_iterator_next_ref(&it, &rec);
+	check(!err);
+	err = reftable_ref_record_equal(&rec, &r2[0], REFTABLE_HASH_SIZE_SHA1);
+	check(err == 1);
+
+	err = reftable_iterator_seek_ref(&it, "a");
+	check(!err);
+	err = reftable_iterator_next_ref(&it, &rec);
+	check(!err);
+	err = reftable_ref_record_equal(&rec, &r1[0], REFTABLE_HASH_SIZE_SHA1);
+	check(err == 1);
+
+	for (size_t i = 0; i < ARRAY_SIZE(bufs); i++)
+		reftable_buf_release(&bufs[i]);
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
@@ -467,6 +539,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
 	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
 	TEST(t_merged_seek_multiple_times(), "merged table can seek multiple times");
+	TEST(t_merged_seek_multiple_times_without_draining(), "merged table can seek multiple times without draining");
 	TEST(t_merged_single_record(), "ref occurring in only one record can be fetched");
 
 	return test_done();

-- 
2.47.0.366.gd4f858ca17.dirty

