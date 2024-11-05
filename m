Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B71D130F
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797950; cv=none; b=rk+pj8wb7Pmt8PmFeid35mZJGJdDCLJJKMTHZiVEhNPT0p2Pm3+jucYA536iUMf2HdLZqm1YNQvHdC+LeEq8LPS0v1KQEuSiyU2NPq+vPDQk8P2h2JspQbrm97g2EXTpzm9o5JaG0PaSwlbwb64cnMzxG4nNx7LJ+v8xPOJlUmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797950; c=relaxed/simple;
	bh=ZSAY1M7Tc5AsE2DpD1nrqp9IAdUCqDO8+nq85VfKkqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLPyKxi1jGwUKnyDUJvd0D3cJtNTN8Wx/RLhfb5l/sY9ZZxDIFuPEIiiwznC+nHhwHbrYBnbsEoA3EdHrmwNRQgmeW+auv8ilF3+bIQ9bKlKKBq/OgtKHsJvcBpC1pIs+pJH/E1Qn59cEmpQC8zs8F/Mg+KzwrrwfLUYtJvPDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YLNc/0qD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vgl8GDN6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YLNc/0qD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vgl8GDN6"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 89EA711401B4;
	Tue,  5 Nov 2024 04:12:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 04:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730797946; x=1730884346; bh=WzSAh9sdK3
	puaQLlbTWS19fTLxfLpKrrVmPz4GTd0w8=; b=YLNc/0qD7ZrihpvlkyAQa2FXBz
	/b5uh4Du1HzVqN9piy7BqlRFiNvj8oJVwx/fFJI/ROGjaKHcRqrGjdeaFNYXX4HJ
	syfCcrAv3VuQFT9FpWZCBRqSmNmh1AjTupN/ECeJqNZ7HUtnyot/pe50zmukcjWS
	DM6utPR3mDtvcEXZGN9Bh5/e0KXH2jvDzs5M5JylzWOTwLoeUcCK4opH7hqHQkO1
	9xbHq95ngZ+IyyaS0GLDAvnL5+8WngB7Rs+UtVuj9qQUXwxVQKfucIoLVZlYzYmW
	zJv7BBSx9rwvhLmCFZ9OV5NMqRUa2ajS3vgWDY+LiroTkBeTSyeNmDnWgwrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730797946; x=1730884346; bh=WzSAh9sdK3puaQLlbTWS19fTLxfLpKrrVmP
	z4GTd0w8=; b=Vgl8GDN6UTzU658DmfthrRjFvjKp90rj1NdiB4s8uYMSUj8C02C
	8ckj6rcZSi9U9+Q2eXZTvaJ50tMAV0cvD5r+hHF4CmzLM6TUMYIoz2tVE0OSrRP9
	D+Jq641a1IyWrAjnMHNPm+KRWSM9XwJhYygjb0/bw+2CaIEIuIyojLwx6yrzzTBR
	d6kQXvLOuObQQQk43JECQHgB9ZwezupFbth6Hu0NY4k3EUiYo85oK5x7hKy3uAZa
	byoXTz1VsovRHifr3wTHI8HvtJadKJVXhDVqMRiS0/+xt4zauboiwWEvzkY5P/0C
	6m5xxXYngTOsZB1DWkZFD0VjMwD8ro5gVNw==
X-ME-Sender: <xms:euEpZ1PBgR9z26VgMsR9rjbV6rb7eEImBMwbE8wq5KR_-_2a0ha3rw>
    <xme:euEpZ3_-aXjT24nWYtHXYkNJTBDMTWHa1qqeqSOiyYQi7LHQpFT5KGsj3kJcJ6M21
    5ikUdyXirU3WZtP9g>
X-ME-Received: <xmr:euEpZ0TOOzY4C8aYXMqxGG3JPgbWncEv5m4KlX1S1m81ZL87WY3HRJCQnEBc5kCc7o0-aCai0rn-6pAt5MccJADesdnQVtU3thZN0Juvn24r-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:euEpZxtXWzazgb7IpYZ_K_VJAB9aXjjkhtPWgkIgu-t2CJN59jmIWQ>
    <xmx:euEpZ9ccTijR1XjPBrnkJmY5YWrg-Iu6BSVpu4raLdUQLR2FTDUvlg>
    <xmx:euEpZ90NRuBdSWVW9SyL0PIcE07aNWZbz7B_IG9ZGHn6whSCHFO0Bw>
    <xmx:euEpZ58Gok4NExlU89DrWYqOraIdfXdnohIzYLS-b73K-8RakuHheQ>
    <xmx:euEpZ-pN2SZjyCeQxLwEqxoO3jYiGuN-0IxZxXStXv4v7-MvWPrwcaiN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:12:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 38c3f40b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:12:03 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:12:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/8] reftable/merged: drain priority queue on reseek
Message-ID: <93efd118864c96b51eb84e46d1eff358eb007a3a.1730792627.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <cover.1730792627.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730792627.git.ps@pks.im>

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
index 5b93e20f42..bb0836e344 100644
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
index 2591b5e597..a12bd0e1a3 100644
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
2.47.0.229.g8f8d6eee53.dirty

