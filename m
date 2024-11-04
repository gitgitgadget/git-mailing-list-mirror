Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7011B9835
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733123; cv=none; b=MR2edlE9FF17Sy7RSCPDHPOT+hdL6YvIVTsOFLL4QLOtJmYOTAxANcJQ6XHws/pv6DoO7b/6/qFo6IznprFtPrXFCApNAkQiPboq18FgTUz1vjXzNARhgyr6o1iVF46hdlA7LSIIChLkVQvliyuBG2mGiUDxr+Jd9cCugrMOapI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733123; c=relaxed/simple;
	bh=3zrfyq68pmwDzglkLG5z9b+oNsADTN/LWNFthdb68HA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgNHiunYjBIXw9X99TeCd/hIUgHAqU5M/j7Qt2T+wMoCvQL1AggQz3ifJAoWBp/RLVvUcvRPaqkN9tATcmbjr7gPK6cPJOfWzPb/zEHd47utL1Q12j7tIIAQ4CF28cvKMYmgM/5EW1rRScuJ//cDMsL7ezEsbqK1CfzY+07ttC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TVl3X4V8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZcpFTB61; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TVl3X4V8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZcpFTB61"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 3417113804AF
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:12:01 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 04 Nov 2024 10:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730733121; x=1730819521; bh=M5Gi/cJ3S0
	q4LRQZQufEFabvg5V13Owoa+RRfQwq7M0=; b=TVl3X4V8Okq2/WUmxNWpXWMSPi
	b7/0DXWbnjKBnHCkAC4Nz+EJggXARYkLY6DE7UXfu4AFRRktYyYKLwlixQpjTnCf
	Awyaya78J3g6oIJ95Pf6jLcP1KroR7rU5RPU7UZ+f/7z3Q8Nk4cDZQ/KBLqvxn5R
	RQO7174y+kebZ4uTFDSLGmxGo0W59sP2mrc5cN9SJx811yF/ozT+kjfd80rFJEVO
	DaQS41ezBx+9PCB0Ii6ZqIoer45u35GabLgrKb16SlJtEOHFTVTsGZB3ff2I7yRL
	1R1KqfSiBHQ+Rf1nANPZqSMXXQGh/olzJ7L0pyeeC2IhYZDo2T8fxQrE/dTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730733121; x=1730819521; bh=M5Gi/cJ3S0q4LRQZQufEFabvg5V13Owoa+R
	RfQwq7M0=; b=ZcpFTB61MQbSxvBFAoW+FVGcpDELf74H7KDqfSHW6JfPSba295A
	ZroEknRjCSl2iVGdxkcRS4wotORBxgaiS+giXXnQzQkGmnPDK1aMWMqquU7zIgbR
	wb4XT3uxwtj7CBvJW4LD+JJ1cASCAeytsqrxZq8YGVqkKErbbkxvv9p+oWaS6OYn
	r401vcNOdn3so1QPa6TBtOoEEUenu/wct6n/N0LEKPltoDUsSzayKUE3GjNYpTDS
	uBX89M8e7rGf2oMbwl49ufOd35SylL6DORxVKuduAObLlPaFIRikrl27TRwLLZf9
	glUtrCzNzQXOY3amAXB6DBtdDGt9T9Eqx2w==
X-ME-Sender: <xms:QeQoZ4AeEMZUqmRS-UwMa3VipIiKzE4Ir0ksFRBFFl_PsbPbYo87Tw>
    <xme:QeQoZ6gYOjaiC79FsxmPKfLOrJHEjKGvG3EpGf-4y6ht5lSnOhHEi3NdgNpiTtjy4
    Y35EkfQGNS75bPItg>
X-ME-Received: <xmr:QeQoZ7nHI6tORCvi1KBRUg1qx-6t-upw318x80HjA0JtG7MFJjIj7rJ9mTncyi-ONwQsEVkkVYAIPh8RD0cS6VoeiHAcW5OAnRQbXEMj8JiOVaJmKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:QeQoZ-yrG9WJqqb8z-JEJQryDYZxy6t0zsDS7U9jBJMBJEbrLkBvlw>
    <xmx:QeQoZ9T_EfvQjhlu5HoYpjCiLThJfgY9-Vq3xpwEYkgUmVRqXRt1hg>
    <xmx:QeQoZ5YB2UKe1l2w1NzdO9RUSvy_SNIQBn4stRskIkMaYD5Avbg41g>
    <xmx:QeQoZ2QCuGqoK_pXnEj3JuoVCpr8Bu11v3VvnFUqUtwAowLcbrFx0A>
    <xmx:QeQoZ8LIyzBM9DW3xZeLkOtK6fg2JGa_3rRiV41_bnrm_P6EHK5MRjLb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:12:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e15aad4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:40 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/8] reftable/merged: drain priority queue on reseek
Message-ID: <45f397b563fe88524a2063bde8cad31ab9a2ccbb.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730732881.git.ps@pks.im>

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
 reftable/merged.c                |  2 +
 t/unit-tests/t-reftable-merged.c | 73 ++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/reftable/merged.c b/reftable/merged.c
index 514d6facf4..84d6e933f4 100644
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
index 4c25ee5334..99ca33f973 100644
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
+	err = reftable_ref_record_equal(&rec, &r2[0], GIT_SHA1_RAWSZ);
+	check(err == 1);
+
+	err = reftable_iterator_seek_ref(&it, "a");
+	check(!err);
+	err = reftable_iterator_next_ref(&it, &rec);
+	check(!err);
+	err = reftable_ref_record_equal(&rec, &r1[0], GIT_SHA1_RAWSZ);
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
2.47.0.229.g8f8d6eee53.dirty

