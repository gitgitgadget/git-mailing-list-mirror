Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E615383D
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520332; cv=none; b=aOEvHKC1kHsJ+7aiPy3sXugJvixPiJaJ9Rxfaw657dk3g1OEetEDN+geMExQ4w99hastzeiieMg14+taXFDGlZszdaYY9/Q8smbx9kEMmoxxxnVG+K4ps38xUEYem5CGIrftT89dRlCk39lMo9Hy/k4ZLfvgKZY+tPyUh/3Em+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520332; c=relaxed/simple;
	bh=XFjnjSRlCgp96YgYgVf2q27MaHH5jZ1Kxxnvdj3IHFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMvBZkEKlA4TI3IEbeu+mgzZrbeDcs1JLBhsrbXxMPVN6s160PtevL+l9rL9AewLCqXgWnl4nn74b3PXsD7OHhqLJGJyYbMIYfkjXEn3zpmMwVLIif5+9Jh+JsweYiga1caGzsw0Wu396bp2+OBNJZiCORRBdDH5h+7+xn2b6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hZIJ6/h/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=28teOlES; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hZIJ6/h/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="28teOlES"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 461C4114016B;
	Mon, 25 Nov 2024 02:38:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 02:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732520330;
	 x=1732606730; bh=dJYwA6RcdVf0tz64LFuu7NwOsT/M7px/2LV6VSnbSkw=; b=
	hZIJ6/h/9R/vN+QCWS/IlpbLXRarHGOlL5o/e+Ag2O1yD/X+rJrTwipkBCCrIgkT
	7dXEIVgnZQkvvuq3AE7G0E4MQnqQNmUbNM7KRc2F/XtKY6tZVaIpQSSFf/++CVoL
	GsDbxc9A0f2A65nxTbC5iXYTEpZovGcSSHNN4i7iCWmpQrl35aKmNtiD1iyS+/xT
	aIDYq0xuoH1rPtJUcY/FnwsUoYXUvW0xcogiUZQJZNhLiv+M/Vo3uIypKh0g1Q7q
	RWr4ytUxFVEwK7Xk0bqhe9FArlMUDRCaTpjkBpCD7YdeSUvigGr44xzaSha9v7M6
	wK1FP62LfozRh7YyQ/F5ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732520330; x=
	1732606730; bh=dJYwA6RcdVf0tz64LFuu7NwOsT/M7px/2LV6VSnbSkw=; b=2
	8teOlESyC2yZgeU60QrR2t2qAlyDM3xVxI/fkVx3WEodpMQU1RKGDqFihaoTYbH3
	3JhXb/7ter0eF+s2JJKMqzlv8ahD57zG6oQgetNHoHRBdfEudRMMO2W+l2oJL6YQ
	1cLnsaCRExkPCUQIPeuJkHVLBPG9huK7qhSR6SooCtnqa5Xu1oE2K0rQVEA7UngG
	ruD9ZQ7dZUSiyS6VcbSBF9wFbUPPu28T5bhqSxWKWrgRwPBtHrg+F35ydE+om54F
	SvyRozAQ8yKCjHcKMa61953h051M97HcNBskhiXFOwkF916xN2Vtsz6XMLExafsa
	FlmVaseNKwrgZzregCQSg==
X-ME-Sender: <xms:iSlEZ_QJio1ug-pwKBjW80g4L1BEcOsvsumwriUOkYW-A0JsbE3d7w>
    <xme:iSlEZwyRnVV84EWU_o1tZ4s4zuHbvF5FuJhj5Izh6lSleuUu9U0zrBP3PjlxjEnrB
    Lwt-o3uAWN8n3cd-Q>
X-ME-Received: <xmr:iSlEZ03i1xq2pMMqDDqmsPIjhHkkxBoR85gUw0_9lC4RCUMG7Z_ruVDNGU-AgLgsubafgbt1L-d7X1C21JK3IhWz3z1vR9mXTueJIT_Ejbqbzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iilEZ_D0Gw0qYR2g80D3Lmz5lZt0hhMTQ-3RwmdmQgvjjnhWoHD3_w>
    <xmx:iilEZ4iuetzhmaeZyQy3kbOL-GdoPcKARJ828puqFzKjwERfekYRWQ>
    <xmx:iilEZzocUW8gUjU3V-SBEEz-TvjDwey2_cOCKpJwzdNST4g91di1_A>
    <xmx:iilEZziy-ggrMiInWab3X7EVaGs8ge8ilAy9HBIwU5C7p0WMKWX1TA>
    <xmx:iilEZxsPB7rC_2aZ4VVq3RZefwKvIu8_ap8_TI-B3cj8XS9BbODX_ueW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 02:38:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 010009ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 07:37:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 08:38:30 +0100
Subject: [PATCH v3 8/9] reftable/merged: drain priority queue on reseek
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-reftable-backend-reuse-iter-v3-8-1d7b658e3e9e@pks.im>
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
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
2.47.0.274.g962d0b743d.dirty

