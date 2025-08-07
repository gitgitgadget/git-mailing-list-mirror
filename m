Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB8724A049
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553898; cv=none; b=AAEkaxGHgMNt3PF9fgkT1gqVcGP/lvzPn+YnvBG0+7Dp4cq344FWLlzl6o5SqrFLxU1+Hxp37qrTcFudgW7x6B47Aqc9SeonY+NEc4E73HIOWZnu1p4GYQEnQvhJkWwLVIsXbKos1cqdvAPZcTlGfm6RfdmZHQSRlO7W0rKhNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553898; c=relaxed/simple;
	bh=F2zuRO3x5UsSwl/gmO8rG2VDE5V8mytlgns9RzYPf4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVn9hDpZ3Fx/WKUrrVFYzqjFklxSm1L5hMosdoo7bKd+GoKHOT3o5uMq+ezeuALg/hOlCYdxx8ZQFSILxksAYMUtwDFN+IVQfzMq3xegLMU6iGOJTxsNtZUdRttuJAV/p7B9+9MV0grS8AnYKo0SSHfdUeB3lA/K1VEyqGMlfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MmaGQzZF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dPBmciub; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MmaGQzZF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dPBmciub"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id DECAFEC0015;
	Thu,  7 Aug 2025 04:04:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 04:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553895;
	 x=1754640295; bh=oar9viIC0ob+u7gTtosNl4oXuuDr0u1JQiSPv45Sros=; b=
	MmaGQzZFQUWBhTjTANeXFqMMoa5OfGnQDekJUZpdPJYcL/FCnqc37JzPb+sttvqc
	j70AzG0tsBrsK6ib6MBICKgIjpXc44wjhCPSWBhWCWDh+FinW39U5EmwMgUTAcRh
	4XD1oPX9yADh9EsKJq/aW6/WxCTM8lKf5o72j+8mEoFLb7zo7pNU1EbL8JyyhnHj
	andLrgAf8UFT4O0fAqKYWQrGVxu7Dqhrl7V9Dbld9D35Fntsheon91JJRLXfLTyQ
	+FNri4fUThZdDJuEbWSjb625OCudda0s28HDOoGMlTWPMo1o5DKRbg5HLNDSF8Gk
	01uhhg5blsh0zJ+8UZf/pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553895; x=
	1754640295; bh=oar9viIC0ob+u7gTtosNl4oXuuDr0u1JQiSPv45Sros=; b=d
	PBmciubaAizHt+J6SLWMdKPsZHpGRr+9rYZxqHD7ZzEMhwUtY8kO5+ZbPjwV4YUS
	WGyLJ0ae07j3WfktWGSFWSBpvhzLfK6mBFfLvMKVICYMyHt7CqOlzHe6axjUD4cd
	2Q1DQ4GDibWI6hIhBEe7T1xHnPossKpwQEL4We63xgHgtvdVmWqXh3DvT/RNRtpP
	Q+lh52VroUaZrTYRa6ZA25ARcx8t3eg+XSeVM+QksALM+iPT51DjfwVAfIYKRvLS
	YwsHmdlru9GjJ0T9oCgtY4+f0ZnuhAC5i+8trQ6xXXT9PVQY7V4ZgNiv3TeLf/j4
	pY+KeHt5jFkQGFkVDjuvw==
X-ME-Sender: <xms:J16UaGqi7r1BIM_Vh7feuWTLmbEhhmckuoxNLHv6CZ6Ce1YHP2f6Fg>
    <xme:J16UaAL2UI2i_si9x32a6rBJfPnwUvCE0vAZdSkIDJtlzZ_O6-JrC8A9MEUSOIeEN
    ZNRNp-nRZxkQ_zyxQ>
X-ME-Received: <xmr:J16UaBq19_N1b82c7-o0IQPl69w0WN2EEG4-2hs7Q4e-Y0E_639GeF8Ak-HY0pz6m3fBLSS0IssH6IYtFLACLF_5ZJUKainkPVb5eZW4bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:J16UaAw1OyKPwHo72HJkGD_x6LBSDvXqfybg4SiqV5TpjvQpCts0XQ>
    <xmx:J16UaNO36hciFd_4SCsy9dKKaO4L3-mJFZo99GFotkWzSdhgjl06PQ>
    <xmx:J16UaN4e1darQHPXvGIXxD3JypEFoTAbo9nWLEs0fKiJxL8hBiCUcw>
    <xmx:J16UaOnZkuKhNEHzf-iNlZoa08cCSPrc8XRRuMAc5ieXiPkmAokOqw>
    <xmx:J16UaPlC72JocGhZlDj4K4gzwofAwL8fV3oyOYFTo5vfhGIX5d86MuGD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:04:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb98b5db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:04:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:04:44 +0200
Subject: [PATCH v3 02/10] commit-graph: stop using signed integers to count
 Bloom filters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-2-82edef830a1e@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
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

