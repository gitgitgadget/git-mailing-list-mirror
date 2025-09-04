Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FB2FE05D
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990220; cv=none; b=Ry8jxFPs2mBQQWoxbHazCyyS/0lYbfSqJNuwIzQWFGnq8RZTZDHha0cbezsw6aKB+0FTYFWf3C5U3LT+KI3mME60HlgsAgptiX/JKRV9JCkdC7rZlsQ2iD4PDnVJHmT7DqeFarhZMW/bqGJmQeCIivKNgi11GnI5Nma6EShn3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990220; c=relaxed/simple;
	bh=pgeclTpx7JEH7x/wFWCxo8A1EDSCLowIf2Ybt5QHpoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rrrJBjvB4ZqfIwU0f0mmNN9AU/u2xywKe3VoB6xDN5y7GrAgEsKOdGfdnXAoqHu5pq76bsS5Q5Rd8Wa001p3Fc/rKLv86Jia4I6QucIGrKdw4uisQYbEYUe6O0V4KMhE8WQax5P2ZxoMUncesroWjSXhAqdUQbKxHwGvkglY/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sFTvM82I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OzMTECKn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sFTvM82I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OzMTECKn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B458C1D0029B
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 08:50:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 04 Sep 2025 08:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756990217;
	 x=1757076617; bh=Jx4eGjzi4p551kPiP0KZHn9dz/J7oBib6OH7VQAYo0c=; b=
	sFTvM82IC5h+Zt/m/iz+xFzB8hf9CuLN2Bu4uuaXUWAIy2B0OSWqu7AJoR2A9PZD
	El6Vtw7TTN+KTgZsL68MTPQGgMIgzq3bv1tVmKxbIm3nLHdrGOj7oTPUSs6j3dg4
	iK5WoyiEOPMpBCcPKLLEGup3s9UazJB8qrJ36fFczo8ysPFTJPZ3OoGtha/WBOjN
	13Em8efa83X6HIQSUyb0uud+YBCc1oXVVxnhyDx8RycPd/ZWBEvIOBCR5K30e5Oo
	1biuwWs5oXSOAF9l1bXH/yB1zMsncCiv20OY8JNaTv5DZhQdfh8LwnJH2lTQVoDP
	pII1J7xb1SJCwPh9cPnTxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756990217; x=
	1757076617; bh=Jx4eGjzi4p551kPiP0KZHn9dz/J7oBib6OH7VQAYo0c=; b=O
	zMTECKne42t7+O6vS1rKlnnxRB/yuOUHs5xGyyq6Q0CkaTnPmFNCsnG2vAOri+t4
	zoANTzvHeHWYhZ8PLjc3jclmybCJZLk/SshYIgIS50q6TG04B3HkSoK+htmtYmQX
	Liwh6dElMsscIc+bGFpvQlOm+J+ko95yPHsMscLIBLMhWsku8gQmojnJTWgF0Xzo
	nJ/XG6z16JdYWO4Yb3XAr0Q0Q7Ek8dzclL+0Bn9cgh8OeHxWWu4mIPuuu3pASdop
	Oxs3A7P0N3XT0Fn1vY0/EmuCb2BYjmANMTtHJIml3s+xdKXsguHomfz0URcRR9c1
	pdah/eDgFlX9TFUnSeNbQ==
X-ME-Sender: <xms:CYu5aKUGFe36bJEe9vj0I9bowiZPe-QkCfDGmmNi_tXm-TNswBDyRA>
    <xme:CYu5aIl9KojHJIF8nKrB1vHcqYtVEoXXjukt1P1b3koa_8WxmYFllQSE3kIbSoY-f
    f5bDJW2G_IRfyaBJg>
X-ME-Received: <xmr:CYu5aHwKohf3cTOOWuev4b14MKStp0pqK5cj1hVHLkUKnM9cLZdCNZM5TWZLa6lawPswKxD9pjrBZR4zC7APVI_gMMMEdiXMC7mPpsO9YL9UzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:CYu5aDjU3nigjfpp3p0exxSPzaEx3r6K3nruifYgI9FPLYhE21WfeA>
    <xmx:CYu5aMWY1Z557_1_IIKI8vbYaAeSA7qwy-bfvSNWRSpLRjnEihIovA>
    <xmx:CYu5aF0TzkIK2VuzoKlZGgAu9UDoPmJ5ZRV1ZiltTYPWewZfDJK2aw>
    <xmx:CYu5aCFsc-_gzHo81uEc0_T997_ZUTYYZGGKso2YvT5yPKEP6CvwRg>
    <xmx:CYu5aCd3x2m6oBg9jJmYBKJKexI0oc4TwJQ_RTkLKOPYxsW3hwDBKeCz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Sep 2025 08:50:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43b6ece1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Sep 2025 12:50:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 14:49:59 +0200
Subject: [PATCH 5/6] commit-graph: pass graphs that are to be merged as
 parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-commit-graph-via-source-v1-5-d932c2481e1a@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When determining whether or not we want to merge a commit graph chain we
retrieve the graph that is to be merged via the context's repository.
With an upcoming change though it will become a bit more complex to
figure out the commit graph, which would lead to code duplication.

Prepare for this change by passing the graph that is to be merged as a
parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 16dfe58229..0e25b14076 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2226,7 +2226,8 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	return 0;
 }
 
-static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
+static void split_graph_merge_strategy(struct write_commit_graph_context *ctx,
+				       struct commit_graph *graph_to_merge)
 {
 	struct commit_graph *g;
 	uint32_t num_commits;
@@ -2245,7 +2246,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		flags = ctx->opts->split_flags;
 	}
 
-	g = ctx->r->objects->commit_graph;
+	g = graph_to_merge;
 	num_commits = ctx->commits.nr;
 	if (flags == COMMIT_GRAPH_SPLIT_REPLACE)
 		ctx->num_commit_graphs_after = 1;
@@ -2297,7 +2298,7 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 		ctx->commit_graph_filenames_after[i] = xstrdup(ctx->commit_graph_filenames_before[i]);
 
 	i = ctx->num_commit_graphs_before - 1;
-	g = ctx->r->objects->commit_graph;
+	g = graph_to_merge;
 
 	while (g) {
 		if (i < ctx->num_commit_graphs_after)
@@ -2395,9 +2396,9 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static void merge_commit_graphs(struct write_commit_graph_context *ctx)
+static void merge_commit_graphs(struct write_commit_graph_context *ctx,
+				struct commit_graph *g)
 {
-	struct commit_graph *g = ctx->r->objects->commit_graph;
 	uint32_t current_graph_number = ctx->num_commit_graphs_before;
 
 	while (g && current_graph_number >= ctx->num_commit_graphs_after) {
@@ -2632,12 +2633,13 @@ int write_commit_graph(struct odb_source *source,
 		goto cleanup;
 
 	if (ctx.split) {
-		split_graph_merge_strategy(&ctx);
+		split_graph_merge_strategy(&ctx, g);
 
 		if (!replace)
-			merge_commit_graphs(&ctx);
-	} else
+			merge_commit_graphs(&ctx, g);
+	} else {
 		ctx.num_commit_graphs_after = 1;
+	}
 
 	ctx.trust_generation_numbers = validate_mixed_generation_chain(g);
 

-- 
2.51.0.417.g1ba7204a04.dirty

