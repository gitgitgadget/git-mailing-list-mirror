Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC7372EF9
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914095; cv=none; b=rkyU+rEwruHbIl8HAT0PVwkCVdw+LlFR76ZjSThz8i6xfNQx0xXBcpl3GI4XR8CyFi/UwyiV8Ia4cLAZgRa7gVkxGuc07o6QtRLLPCqD4s+7gPdZYJdNd7ZL1QknZ3gXgJZ9zc0k6A/bqNgObyohmU/NbEgSCjXOmSJFtUTkpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914095; c=relaxed/simple;
	bh=AaaEVE8WGwFFE91AwH43N8QzXBvWSl/ept20CShx2k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpFDWqCY7a6K7WrBHyxNAdlHNU7fJoU7pOB5+jpRTQCbnxqcX15ehLj2ZkrhbH/KQQl2yZ5qD2svezuVo8rLPJRuv0cvsYwEU8v538ciTQfGMjUr9ilsr8Ndnc8nX/khr4XGdQd+c2S0avzSvXuNUXSFOTzBBNpk0d9W1aBPecQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A2CmW8Le; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HknakPDM; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A2CmW8Le";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HknakPDM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FDBBEC00E5;
	Thu, 19 Mar 2026 05:54:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773914092; x=1774000492; bh=/WtBOzDgDv
	e+HZxcMhzpkwAFSvvGwJvABKgWez2n+a8=; b=A2CmW8LeIvnXuhZ3UyiYKUcQK3
	96NDrACekb8rYXT6IVHvrnSt7dQ6NYA+P8CzVugcVGP9gTYs02evzFTZasXPd18U
	68xYoEuBdYHhVQkGwLQXt3ngtpUh+F4QZx3k30gLE7cPRd+LhE85G/ScVM3rzuyw
	+vEKG0paUGDd/fsWamb8L2j9DW6hZRpprwwqmZPb/Sj10Z1tHZqoSjvPTI7Y+XSD
	5bcFyHtZDEIsuFCgcpK/rLdzYnP7fOfHE93/VFVTKLDinG+Vv1iEiXRhllajgae9
	pq2pI1bHxwVOUAW88rSataTpWdKlVasxY/3JEnxevmnDEcoMY08tpgU3LwzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773914092; x=1774000492; bh=/WtBOzDgDve+HZxcMhzpkwAFSvvGwJvABKg
	Wez2n+a8=; b=HknakPDMrou1gNV1EesiO/D/Ys7zLgD7ShZRiZO52FxARCH4WyX
	CVDB0THtfGCTuoRFEn8jFVHrYaxw0ybyLQzr+E9RJyuqIw3oJIgLxT8mha8EevVa
	CqYaPmDdEO7RyZh+cA5b96HuyX39opREU9LxubaKLBHwSeuAV0pgtRZhD6Z1gWR9
	lFTTj1EaOS8ZF4VJh91eACphQT7JaAWCL6FjHmsiC2NIEdw5jeoxgIS+LFrpX2BK
	7XzmcIbK/bI1zDgehMUJYeRQQoGY6qSte/0lyb/zHn8IlK97RHrI24p344WcEXmJ
	eNi3n8K+hF5mxxOxefx0wVqzBRJPQzCCgiw==
X-ME-Sender: <xms:7Me7aQ9K4ez09paXeaHzhRZYGraW2gJX91-Iw9tqgmNPmxQMi6i0ug>
    <xme:7Me7afvCeO96W6OEElm25-r1LY1ndfLQaguz3ZbiQ7C_7N9JdxHsgQkH8_kbQ-060
    zsp2Gd7yeSxaIe2iM2WCDyPnlt_vrQZP6CHBOyWPaocGhavhAm7Hw>
X-ME-Received: <xmr:7Me7abCU5kwaGI0USmV8afSRkpR8MrkjpI1FHkKcoM_ao8QE_hcPgVU-EP56YEDvfTJiRcorDMRSBJs4Q-DtKeGBUT0yyooxJn9rt13Wc4en>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeijedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveelgffgkeekhfdtvdelgedtfeeuteehtddvueejueehleduvdevgeelhefhgeefnecu
    ffhomhgrihhnpehpvghnughinhhgrdhnrhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7Me7afV8I3NxlcG9Z_R4gcGmZx5JCHba-7HspiXUi3lmKTHZeY7qDg>
    <xmx:7Me7aRCIfT1GjCKhQhAIaFaNBYNAHyXdn_tX7042IgJF3y4y_g-AWg>
    <xmx:7Me7aa-cB5QDwNXMohTkJEC8USuC4lTJh4WQyN0yyRJ5S1bdmBUknQ>
    <xmx:7Me7aQEEQpmwReRyFyiE_2zbeKJUjmBkLEnA0eZBpraRuOXiVJp0qw>
    <xmx:7Me7aeh2IG_nU0Ci8AzlmlexY11tac5qn3adAcAZhkytIm4RHM5quUJc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 05:54:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9bf8e054 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 09:54:50 +0000 (UTC)
Date: Thu, 19 Mar 2026 10:54:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/5] backfill: accept revision arguments
Message-ID: <abvH6LUu953rrQzS@pks.im>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
 <dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6652c84c8d37b124eb76c2a9cdfdc4db4a149d.1773707361.git.gitgitgadget@gmail.com>

On Tue, Mar 17, 2026 at 12:29:19AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> The existing implementation of 'git backfill' only includes downloading
> missing blobs reachable from HEAD. Advanced uses may desire more general
> commit limiting options, such as '--all' for all references, specifying a
> commit range via negative references, or specifying a recency of use such as
> with '--since=<date>'.
> 
> All of these options are available if we use setup_revisions() to parse the
> unknown arguments with the revision machinery. This opens up a large number
> of possibilities, only a small set of which are tested here.
> 
> For documentation, we avoid duplicating the option documentation and instead
> link to the documentation of 'git rev-list'.
> 
> Note that these arguments currently allow specifying a pathspec, which
> modifies the commit history checks but does not limit the paths used in the
> backfill logic. This will be updated in a future change.

Makes me wonder whether reversing the order would have avoided this
slight awkwardness. But let's just stick with the current order, the end
result would be the same anyway.

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-backfill.adoc |   3 +
>  builtin/backfill.c              |  19 ++--
>  t/t5620-backfill.sh             | 156 ++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/backfill.c b/builtin/backfill.c
> index e80fc1b694..1b5595b27c 100644
> --- a/builtin/backfill.c
> +++ b/builtin/backfill.c
> @@ -92,13 +92,14 @@ static int do_backfill(struct backfill_context *ctx)
>  		}
>  	}
>  
> -	repo_init_revisions(ctx->repo, &revs, "");
> -	handle_revision_arg("HEAD", &revs, 0, 0);
> +	/* Walk from HEAD if otherwise unspecified. */
> +	if (!ctx->revs.pending.nr)
> +		handle_revision_arg("HEAD", &ctx->revs, 0, 0);

Can we use `add_head_to_pending(&ctx->revs)` instead?

Patrick
