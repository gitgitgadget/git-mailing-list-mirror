Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E442405F8
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295450; cv=none; b=NOjyL2w5ZA7ploEkfRiaF02dH87nxSYOe/RiEoHYKVghDHnNb/VNLvjrL2UCCxbjbdJ1ao6Vzi0vYQkLPM2Qi0KF/i+9aHPhaU7GFbiMbPIgaTBjOPsbe2hmRNyFgO5SEAS+BaAdMUf7JEptaa1SrNpI/fke7BDgiguXbCK5bAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295450; c=relaxed/simple;
	bh=SYVur6clzIqnHHKo7pZQb3d2tLbms0vS52ZsjydTIwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkUs8gu0TFjfH933hSMDnFwVjAaHWrsm1Cd4gGrU2vIj9Vh7wYcF2OPSaGQS8J9pXG5JgIfg+c+VgMOVVGNNqYTx18J7RXfllLojGDMrxiV9pTC57mrfjetXZdAcirZUGXokSJTyK4FzXx1ecVQBDwLD6I3a9d9UfjeaYEg0ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HJGYJ1wL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cgT+WTDH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HJGYJ1wL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cgT+WTDH"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A56D61D00142
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 04:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754295447;
	 x=1754381847; bh=+lJCz+cehtoCbkqyH6/hBkJRX69VsZqYM0WWFAWaBkA=; b=
	HJGYJ1wL5bZ5eNAuzbQIWK6WUiPOiWcAw0iQ6UHnO94TPVGIaM3OlsGfjRKhgnf5
	oRfq4yBY7NEA1C9B2l1fy6vzQer6gP3ZTjHOJoiKQ8StKbDISlfWRRxDQOekm7Dh
	+c5J6nFAohNGx4yITT6Kj0BEKfmDgdkaB0/0XT9CKwGUnT9LkSDLxdkrzrkD6JnC
	Tw6TzsPcQkvuxsP6UeyDn58tg/oQKjtqJLamrpMWjhbZBm7Pf6m79T4N4aZzCcjE
	XVNmdMlgVfHyzToynvgqUIoGGg/6QTHn9DU/gUi1RoAdHZqSOcg9WnQy/d+91h7Y
	C+SMVXaKj4G4fQJK5mGSzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754295447; x=
	1754381847; bh=+lJCz+cehtoCbkqyH6/hBkJRX69VsZqYM0WWFAWaBkA=; b=c
	gT+WTDHvsoK2yEMl2ruwldI851aLLfA9taAyEwqzcDyTx2qwuXHQE35ouVZPjngM
	+5VKl6l0VsJ6DkeRvRpNzviQmAKSDCX7yj8LsgPuab9sbEfsCzUXsg+H0lfgQjqB
	bvNHJCFRzxzwIru0a82iPK4/exG6XPOGnHJOiplp89oISja6I7m33EOUPtZJ94MB
	B1l+pWRK0yvjFkwHhQ5+AhiqYwmXmPk3u1ePl0DMnOREQU2DqfkmOZ0WaWZat5+N
	x0TlD0BaDrfZGZWUZ//n6J+PnVceglK7wEW3Q3BFYW2KdDfocTJ7MJ2l8dqMgZHt
	MvpV1+Nc9h4aMbQIM50Ug==
X-ME-Sender: <xms:l2yQaExbE3epYmg6MPvNhrdUfGtOYOmVu9B18I9Q9gCIq1ejOAVnqg>
    <xme:l2yQaKSSdqWau3niWDMQqhvBuE5PwMo4d9elm9GmiSr6RE__VrSZAKJfU4agwi09T
    XYtdfWS3wWDRq9Iqg>
X-ME-Received: <xmr:l2yQaPtI4cpURKrfwqF4jMhNi6bTKym4DB02ufXsDKR7rTgfMtOWeyoOIGxsgGKMfGaUAXuY4yGQ5DHcZiD0XHw7Xx-6bH7ayJFQ5ohZDnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:l2yQaEuKBlxywk9HBREOp4jmFcB7C8v4cmdE-6k6XtaTMthQgefe1Q>
    <xmx:l2yQaNww11eGI3NHiox4-rr2jroWJEtb3Z-_nofSnFqBZXdMqPacsw>
    <xmx:l2yQaCh_VJ7u7-K4iTJdbaFp4fdfQTAKFagYAyRgNivNdZ_fYThx7w>
    <xmx:l2yQaJCzqxWG8apF-bKuvSQvLN8YtnyuL8hJBEqa3LVYHoaU146hLA>
    <xmx:l2yQaPrX5AZG1CUDuf2363LP6yS42WS_JctXXez01oFED3fIoWVXD0iR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10b5ce1a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 10:17:18 +0200
Subject: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When writing a new commit graph we have a couple of counters that
provide statistics around what kind of bloom filters we have or have not
written. These counters naturally count from zero and are only ever
incremented, but they use a signed integer as type regardless.

Refactor those fields to be of type `size_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index bd7b6f5338..a7a1a761bc 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1170,11 +1170,11 @@ struct write_commit_graph_context {
 	size_t total_bloom_filter_data_size;
 	const struct bloom_filter_settings *bloom_settings;
 
-	int count_bloom_filter_computed;
-	int count_bloom_filter_not_computed;
-	int count_bloom_filter_trunc_empty;
-	int count_bloom_filter_trunc_large;
-	int count_bloom_filter_upgraded;
+	size_t count_bloom_filter_computed;
+	size_t count_bloom_filter_not_computed;
+	size_t count_bloom_filter_trunc_empty;
+	size_t count_bloom_filter_trunc_large;
+	size_t count_bloom_filter_upgraded;
 };
 
 static int write_graph_chunk_fanout(struct hashfile *f,
@@ -1779,16 +1779,16 @@ void ensure_generations_valid(struct repository *r,
 
 static void trace2_bloom_filter_write_statistics(struct write_commit_graph_context *ctx)
 {
-	trace2_data_intmax("commit-graph", ctx->r, "filter-computed",
-			   ctx->count_bloom_filter_computed);
-	trace2_data_intmax("commit-graph", ctx->r, "filter-not-computed",
-			   ctx->count_bloom_filter_not_computed);
-	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-empty",
-			   ctx->count_bloom_filter_trunc_empty);
-	trace2_data_intmax("commit-graph", ctx->r, "filter-trunc-large",
-			   ctx->count_bloom_filter_trunc_large);
-	trace2_data_intmax("commit-graph", ctx->r, "filter-upgraded",
-			   ctx->count_bloom_filter_upgraded);
+	trace2_data_uintmax("commit-graph", ctx->r, "filter-computed",
+			    ctx->count_bloom_filter_computed);
+	trace2_data_uintmax("commit-graph", ctx->r, "filter-not-computed",
+			    ctx->count_bloom_filter_not_computed);
+	trace2_data_uintmax("commit-graph", ctx->r, "filter-trunc-empty",
+			    ctx->count_bloom_filter_trunc_empty);
+	trace2_data_uintmax("commit-graph", ctx->r, "filter-trunc-large",
+			    ctx->count_bloom_filter_trunc_large);
+	trace2_data_uintmax("commit-graph", ctx->r, "filter-upgraded",
+			    ctx->count_bloom_filter_upgraded);
 }
 
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)

-- 
2.50.1.723.g3e08bea96f.dirty

