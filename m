Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262935E1AF
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443627; cv=none; b=mIduyxGZ3VruKJzRUl5hOkQ2nHttpCq0GEZwHIqnC25/4VHEqGaJ96OB2oYwMTuYKFl2b0aoqjanzYol6fHwAxn/xtiX9tOeq5xeBk/xWhNu3xvyHfZHk/PgsFXYG+dMlRJFXh2O5L4DQQlKyv2WoTahPEFv25MS81j+R23T8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443627; c=relaxed/simple;
	bh=/nxE/w0wQTvZGE0FINvw4xl5HHeeHIjllEOALT3oa1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jtKfmAa5JAVqtSmfP3Sl9CxuirJ25NZbUCxT3LZ9MY+lIrg/kQu3bnflNVFdtfzKXASlCtdVRdRZvbZggDBy8B2NTgUxrP1u+9Z4JGO1wGHNMqwUERpwQzFn615TM0pXZmf8t4B0T2y6kLVTDeHeCpVF5sLxtifgdHuesF1t6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JNRiWSiM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q8Zqf86O; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JNRiWSiM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q8Zqf86O"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 12E1D1D000D6;
	Tue,  7 Jul 2026 13:00:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jul 2026 13:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783443624; x=1783530024; bh=JSnVIwZJJg
	6U3078ZRpQ7vdKjc/WOR7F40mUb8Av+GU=; b=JNRiWSiM5a55Sxd5nP/YR+L2Jb
	MWT58lp3sjwdgy73ReFPB7NucRhJ6Gim6xC9v9ppQ6AlSSo5SZ0wtmXdja07nBvN
	IfnboPb7PG9Xrjxbi7b/rxkPGndgaH09cX0m8LkVY5DQZ20cHzt6iDRqZni/7VlZ
	bgZiID3NS24WTB4W4ABs5ghEQSTs4pLmho+oli46XTqGwUvaugG1PBA6ZBFm+XbQ
	b+jPwyNFFHo1qsXgLr2Maeb9jM0yZOOki9tJD9hwL3P/6r35U9n8CJTV8W1JM4m5
	XwiqIbaaWxkq7VoIltiDxjMZoiaSPQv25EzEOO4INc6wMnEe8v/m48RrqPoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783443624; x=1783530024; bh=JSnVIwZJJg6U3078ZRpQ7vdKjc/WOR7F40m
	Ub8Av+GU=; b=q8Zqf86OMSsxVRIU/Vqrocqg8h9Cnq/FO/3fOJeclRn+X0Z4JEE
	yNBasulZsiQChXi36LslASUsb8hv4u3SGL2sdYx3GH+cLNwgDFckFUMx58Yxz+Ep
	AZsHtHzfche40necfHuO5k9f+DTXhASbBgmAIBVhnFGXNRC9eytP2kuGgK9bZtu9
	3V24KUia95CjqvFwVMJwYgEOIH/cEUJyotdBOyyVy/thEjdpsW+bVL8alsrkf8wL
	ypYiIP0OWM+vLVX9OKJ5pzy8QTsFOa8kZCoxIbqyPgCzmQ8Gfkrq8pHiRd99Qkk3
	euvvyvx0OQ6K6A9IZJzgyuTxUyIzLMskxPQ==
X-ME-Sender: <xms:qDBNajKbp8EDvI12NdXC2QgFys_wanojN1DBKnjkEkNhGTLUI6K9Lg>
    <xme:qDBNauLAEts9Yq7r_3vGXC4ZsAgutfSdkYL8D5fRtJEPSTetyw-jfZqGZAUrTPu7U
    uotlh-Gr_qZwlajf7SIi20dXSyCo6ZYAEfxRGa7Rh3QpefESypOhN8>
X-ME-Received: <xmr:qDBNags6iVpPVOunovJeyowm-CE5Dx6u0-vSZtG_SDGvT60BHXL3yT8YgrVXQcSLx_LRV8QY_jLn3nwRW1-AxCCox9XJ7zW-LTWtjsQ>
X-ME-Proxy-Cause: dmFkZTEOxgjeT62w35SkhXEOAkiXwhyLK9pG598bfXSVf4xXhj3lyFNj/Js2eXyhpKEnag
    b7GpTAYKpZKzO0VNZh1W3WHxSTcferywFiMn+ouvHc44rPQoCBWE+MoinxqUYDlCrmEFbf
    1QmWuJKLMfg6PC8tRKpazaERkVHk2zhkqvFHGKwvg7uqih2G2GSjCviIByByGJD2SQdaab
    UTHMFyJDv+aGdkQz3reJAWW8pMh47Bns8NTc7HUsn0csY2QM7zP/2cAJBuZSSSUhOsm3/S
    SfOh4gmw0JKfjjdFj87TEsXY/gE7+7B2s/dKBZkL+jxVABpa4GKBpRSHhENyNydgfU/LkJ
    OZf7CQSdVWHPy8qqX15En9j3RhgCbKNqUzgCk5KCOR08+gZNeRO63XHvl62VrBJWqHneOb
    XyUm+Hh6qR1G5mpxJYFZwO+cJqZA5QmHZltx3lxjwcZQT1foeE7jBYRZpU0kRBBOaiNrS2
    YoWQdO26udO0sX5TxhwNDtP4xsnz0chQBqEtxSRrvNCT91yRX3Bhuxm2SxeR053i9zpEDT
    7RhPtylZh/ytetPGsiLZv2WLGUc4qVH931OICeRJzsPgT3/ALJ/WddMDOnGBW5rR+8TAaO
    ASi46NHuTbhq5mxqD/6X84F4CLqfSLRnWSDKeX4lWzSkvwthrKvgluZc9Y7w
X-ME-Proxy: <xmx:qDBNarSm17vwb43qVR1rd7BNcEzisW1WBaGJ1b9BvCXarMGWiBf0nw>
    <xmx:qDBNamPoyC2vZ0BDhvvu5xPuL_8afE-9EnGs6EOuHZ63tnBOu8lGeg>
    <xmx:qDBNagYyLmNvXUmn8f1FIM4RgFT_ltCVt3I-IlWqfBQ8HyHDD1BvoQ>
    <xmx:qDBNagzED5XEuJcrRznq3VmzuoVRRla0S14qgqQDl7Wg0ZPCzsP_Pg>
    <xmx:qDBNap1PU2onQ8QZyZFrtzRpqrjuvRuFBF8CWr6E-_VgK57-hA8Gqe0t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 13:00:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/2] commit-graph: propagate topo_levels slab to all
 chain layers
In-Reply-To: <f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Tue, 07 Jul 2026
	09:59:43 +0000")
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
	<f9c1482a76493520b948a2e918de7a5481fa1043.1783418384.git.gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 10:00:23 -0700
Message-ID: <xmqqo6gi68go.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> Fix a regression introduced in 199d452758 (commit-graph: fix
> "filling in" topological levels, 2025-04-07) where the loop

I guess the same comment from [1/2] applies.  We might be chasing
ghosts here.  Is that elusive commit a total hallucination?

> On a repository with 2.78M commits and a multi-layer split
> commit-graph, this caused a single incremental commit-graph
> write to spend ~3.7 seconds in the generation DFS instead of
> microseconds.

Nice.

> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  commit-graph.c                | 2 +-
>  t/t5324-split-commit-graph.sh | 6 +-----
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 4e39a048c4..c2a711cceb 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2610,7 +2610,7 @@ int write_commit_graph(struct odb_source *source,
>  
>  	g = prepare_commit_graph(ctx.r);
>  	for (struct commit_graph *chain = g; chain; chain = chain->base_graph)
> -		g->topo_levels = &topo_levels;
> +		chain->topo_levels = &topo_levels;
>  
>  	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
>  		ctx.changed_paths = 1;
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index f9c57760f4..9e5ab7dbd0 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -738,11 +738,7 @@ test_expect_success 'incremental write reads topo levels from all layers' '
>  		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
>  			git commit-graph write --reachable --split=no-merge &&
>  
> -		# BUG: topo levels from lower graph layers are not
> -		# propagated, so the DFS re-walks from base-3 down to
> -		# the root (7 steps) instead of reading topo levels
> -		# from the existing graph (1 step).
> -		test_trace2_data commit-graph generation-dfs-steps 7 <trace.txt
> +		test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
>  	)
>  '
