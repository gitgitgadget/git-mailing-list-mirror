Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1E3D9028
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418390; cv=none; b=YX2lkhHWZBjG0mvMPFMQuNek4byaAuer8SJAtn1xpksj6UVcWOTqLxq+YlkpWDuV3rEgb/DNmJhFePB2b7IRqdgaYtO/Z4w5OMQinEDNbPUMgIcDrJiDZUWdKm9/fP+7O2CG+3BECq+rwa/StMJHRuIPWCXQFJ9/bdqFWLsQ0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418390; c=relaxed/simple;
	bh=U1tb3kPJG+IgKAoqVn1UNW/HNf9H6w362zsZp1AG/Dw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ir/k/P+7gGKe0iEBsHumpeV6sGAigTvdXP0UeCnA9bBE2ySg3aVIhlRFRQ01oPxzcRMzuccZYHbe04XGv+esvMPo88fngkqpkeh/s4elOObTNfllRWDCnC2G7GpF59qJTokrjNcxvrKBTnc3fgwSI69PZYR00GVuwfHZMGTA6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceK/3hbS; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceK/3hbS"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-847921eed4aso5432780b3a.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783418389; x=1784023189; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t7xWezMFj4tM3BDr7TvlyYGZNyVEv3/3zk5sbi8EBak=;
        b=ceK/3hbSrAa0058ognt0zrmAe7ViE2p/jnb/5jiNJ65iGo+6MJQSn7w3NicMG3MToP
         0H7Vt0KsTvMGjEwLCrY7KPde7gkcAoX/px7Fgs6z0PiIsskI9EPDDa04ZU8UB40N5paj
         KSHBy8TSfaGWVPKfcxSBzbyyA/eudZVzdHu+G15wQrttFGwUMxW2wPKU8Uh/q7gcT8rA
         VJ7835l3MAE8Jky9Xq/bG1uZUXXS+/KCXc/0C1RljbOBPresrG29SlB1P9IhvRfS5qGT
         2tlz0hQpsC3KcJPuuO59FtsQye/eyGDXJVC1Z4Twgx7fBOvIyQNFVR+tt1kkyultLsUJ
         6Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783418389; x=1784023189;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7xWezMFj4tM3BDr7TvlyYGZNyVEv3/3zk5sbi8EBak=;
        b=qRof3OTbf+ebCo1+kKnCXRjLqh9/AVvpMBxHPAeVHkX24Q9golnO7xJ2McUKROpGa+
         NoB7zWdzTyB6XMvuUXjz3k/XlVTmgmSkEQMI12FemWZmngVVZSQ8WgPdP+VbffVLLIWR
         sml5XyOIZLvH5s9wElqOpiF0JsPBH782Fz1DEPAagKgMlKn0MNh5HAvumO4U8fTN+Lq9
         bJh9Syd2URocbBFCqog6TN4b703IouDqVYBOK39ROw9v8tL6pPSaW0EwgyyyA7o5KMuq
         dmKoZeo4+3+2USZaEMjyuzCuhvmuq6JYDRKKlvDx/g7E02hsuYHfghEjcnBDLDO/RhVZ
         +M+Q==
X-Gm-Message-State: AOJu0Yy3SnIX6x6bkz5ON96Cv7TCBR4dBrziBXx0euU7K8RcrxHHqrC7
	J52Y98umK0g5oACXLl4C0AynzSQrmkjdBBLq7UFHjnwsZ9Jv3TdOflhoVDthvQ0j
X-Gm-Gg: AfdE7ckLgmNgaAb2y0VoFKCSAaXcTL7d5vNy7/Ou3wgdOuvdLmzAzjEkjl5Nw+mYTZT
	ZLLhep2FvX0TzRLnQKWUbxBcN8MROvSpO6ZtX+ka3cIbwfY3Mq5Yx8lM0TvKU8tO/9gc0ewciQR
	bOQsuEszRZPe0GN61WHPxmpjlI/jZNMygQ7vvyzPuaHCcJSY41tB1EQr46qoMwEHKPI8hpteCEz
	bHMnI/4W80jRWDZCc43j8QXdGADtDdRPCaGWT+LfrYeDzo6fbqRkl4JTkMq3MhPjpUGRiERFn3f
	jzP8/MWCRoKPr/eyLxYiS/39IOR0eNZMBxZIHZ1FnyE8oIi9DVm4PtFRm7NQn2+gEM8cSVuLfLz
	QRDMNcjHoXubuUZCMMUS8Y0UYUvrgFYMuhtKdhNJfTvubacx3GYh0xfdpJwUToZ3GLS6OS/qzYB
	hBNW7ndZHDbqoMBQ==
X-Received: by 2002:a05:6a00:4b0b:b0:842:55b6:f5a1 with SMTP id d2e1a72fcca58-84826c1e0bbmr4332605b3a.6.1783418388875;
        Tue, 07 Jul 2026 02:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([52.241.30.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a935sm5087415b3a.47.2026.07.07.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:59:48 -0700 (PDT)
Message-Id: <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 09:59:43 +0000
Subject: [PATCH 2/2] commit-graph: propagate topo_levels slab to all chain
 layers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Fix a regression introduced in 199d452758 (commit-graph: fix
"filling in" topological levels, 2025-04-07) where the loop
propagating the topo_levels slab to each layer of the
commit-graph chain always assigned to `g->topo_levels`
(the topmost layer) instead of `chain->topo_levels` (the
current iteration variable).

This meant only the topmost layer had its topo_levels pointer
set.  When compute_reachable_generation_numbers() ran for an
incremental write, commits parsed from lower layers had their
topo levels left at zero in the slab, since
fill_commit_graph_info() could not store them without the
pointer.  The DFS then re-walked the entire commit ancestry
instead of stopping at commits with known levels.

On a repository with 2.78M commits and a multi-layer split
commit-graph, this caused a single incremental commit-graph
write to spend ~3.7 seconds in the generation DFS instead of
microseconds.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-graph.c                | 2 +-
 t/t5324-split-commit-graph.sh | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4e39a048c4..c2a711cceb 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2610,7 +2610,7 @@ int write_commit_graph(struct odb_source *source,
 
 	g = prepare_commit_graph(ctx.r);
 	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
-		g->topo_levels = &topo_levels;
+		chain->topo_levels = &topo_levels;
 
 	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
 		ctx.changed_paths = 1;
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index f9c57760f4..9e5ab7dbd0 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -738,11 +738,7 @@ test_expect_success 'incremental write reads topo levels from all layers' '
 		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
 			git commit-graph write --reachable --split=no-merge &&
 
-		# BUG: topo levels from lower graph layers are not
-		# propagated, so the DFS re-walks from base-3 down to
-		# the root (7 steps) instead of reading topo levels
-		# from the existing graph (1 step).
-		test_trace2_data commit-graph generation-dfs-steps 7 <trace.txt
+		test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
 	)
 '
 
-- 
gitgitgadget
