Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF70A23372C
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481628; cv=none; b=q5R9pzqYNS5V+n8EWyHkOGA6gVVlm52iwSoICq+l4rCzzACqE6Dzqw/hLsWX3xI3sufSYsChTCXrr4gd/T+DMoh1sUJuhsH2jVliAZHQXgd9weFh6DPF0ITNxfvnG94JghaBB3MoLnXZz7nXkncHDxN2oLHZ73Ta6pyyqC3jsl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481628; c=relaxed/simple;
	bh=F2zuRO3x5UsSwl/gmO8rG2VDE5V8mytlgns9RzYPf4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tm10Vv9yMix3RY0NcNzBh2gpgVFUiSfe/5+kJU7DT7rJgc9bZczTKTEN35vnwli6K0fKzfgBiolhjglpbtLW2kWkFCd7hBERwOQIj9A1ZNcyn3TdJ4VzdUIutj4iu/f+pyR7+I/ju6oxQ2OLE8/6faIKIUxcV/7VKpP/hXvfz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kr8bPrPM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCSmHIDV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kr8bPrPM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCSmHIDV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DF2A14000C9;
	Wed,  6 Aug 2025 08:00:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 06 Aug 2025 08:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481626;
	 x=1754568026; bh=oar9viIC0ob+u7gTtosNl4oXuuDr0u1JQiSPv45Sros=; b=
	Kr8bPrPM+ZpJ0qQ2z1TkKtXKUmm/NJ4SfqRMVVTQdfY/4QnJzuoMgzfz7/kZe+we
	YNMhLBPu83o8zNmt6/EjOA2QFSZv+EcdmT8uH7sYeZNA/lhQxsaUwwIcg8vrkZzc
	YwYTZlRWcAHsuFebffqnb3bRFI0ARqwR8zt3Fk/p9NlDW0QFHBRkX5rGD8ZDObEB
	9DgKjh+JsB0pswXqRnvj6sj/RtKDozndoz2cKcwcyJZ2gpHCZoA8gFya1RkhFmfb
	lIz1/LAIcOCfyq/ohQ5Ow01DkqLad2MXQCRGIzAzhBx8lkgIv4mQ0BdY7LHPsE0e
	WqStHkXeojLIIjZRxoq/vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481626; x=
	1754568026; bh=oar9viIC0ob+u7gTtosNl4oXuuDr0u1JQiSPv45Sros=; b=D
	CSmHIDVMkIij+P1AVpSA2XxpthT6Vp+HiYIn5wQVtCUyusjHzlRWL3S7t9d+VBz/
	XUsQb5IcdFE1ZL/YNZGeffX3A+S6o6ZVnLlVrHFWTWrAeWdU8xcN8uQraNMGXikh
	sMMbWNEPz+W3trTr+wE9Bk4+LhTWE6KhUAFyLbJiUW556Ofy0umDskLIOmaYe27Q
	etwV+vmtcP/TQR6z0bshg749DcEoQE3HZd5iOGlBnkaaECBffVn2iYa0fNvqqx5c
	Kk3/zvjnGjIQDOMafmDf31QCD+opkM/j1248RZzrYa6fGzTUJW3yZ3H9cDQ1d+sd
	VX7/p++6T/4eqGX72ylxA==
X-ME-Sender: <xms:2UOTaIxAcwMBbEp6TyETguivdhlMbkn6OGxbWfOe6PmVaJXouOvdrw>
    <xme:2UOTaHzWMpDoX9PfUUg5CdqV40YKAxzxsGQwktX8Gde70RtiCK7RJzXWTI3o6Osuq
    fh7KGuznzwsjxlgPg>
X-ME-Received: <xmr:2UOTaAzlSdo2Wzo9aLjk0p-4cVAPrX8awonm6kqAsviJwLa7FBMPeLTcDn71LFjqXbhNgVu8zivJpReYFnz_IMTJncOOh1D9ig9_JYV-PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepohhsfi
    grlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:2UOTaBYLZRk9fSoGA5QRCxOtrlEAh01E78mi4xDb9hfuZL4QzoCdKg>
    <xmx:2UOTaBXWP-htDA8fZ0YPsI3j6Oa7jQHdcEFuo0CJR_hh9qy2A0cnMw>
    <xmx:2UOTaPhMGiXaEU8GdJDUEcrxJkrMlK_22k6WfjEW8VVYUZkSHvUYwQ>
    <xmx:2UOTaPvWamlV_Pk6mA8P4veou-JkzkJ5Fx7nl_H6ZCZDp92DRFYCCQ>
    <xmx:2kOTaEPE3iFCTg1gASgDyYlMl8B5Krf34_QcqUdrPtgRffrwNTQp3scp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 773f9263 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:07 +0200
Subject: [PATCH v2 02/10] commit-graph: stop using signed integers to count
 Bloom filters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-2-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When writing a new commit graph we have a couple of counters that
provide statistics around what kind of Bloom filters we have or have not
written. These counters naturally count from zero and are only ever
incremented, but they use a signed integer as type regardless.

Refactor those fields to be unsigned instead. Using an unsigned type
makes it explicit to the reader that they never have to worry about
negative values and thus makes the code easier to understand.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index bd7b6f5338..3fc1273ba5 100644
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
+	unsigned count_bloom_filter_computed;
+	unsigned count_bloom_filter_not_computed;
+	unsigned count_bloom_filter_trunc_empty;
+	unsigned count_bloom_filter_trunc_large;
+	unsigned count_bloom_filter_upgraded;
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
2.51.0.rc0.215.g125493bb4a.dirty

