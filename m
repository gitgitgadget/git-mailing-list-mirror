Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4537BE7E
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078053; cv=none; b=XUpR3wyT/JmMllwBSp5oS5XC1slycGwOC0nEEFAPxFngI0UaFqnZJZ7PGvFEhMO1zcvrnwn9cGp9g9aqaXuLRBulCT97O3LINObfs30VMQVm2ZBJ9eGZx5hwSabq/1+35WYPML7L7QkW2csUYDiZ1nmi1HK5BG5Fif5FThxwRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078053; c=relaxed/simple;
	bh=Qj5ImV2aQ04e4A1pYzraXpaNGQ5/Ts7Byel5Eqh4CGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stdpnKVkYfLpDmeqqQqK7o0EDhmuuLmAcuXuXbg3AdN7mvwDKTX4mvnqe2e/IDYa/bv7GCKiJzN+xBhRPz6pmrDxaNMvkBZ/e7X56qBnBlX5cQ0pxDRMDdi5wX5tb5pE1HaGyko/06Aj0rzq0sDFjMsLlEbZFH74f004t2GozEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WhcCghBo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZoQCibU; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WhcCghBo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZoQCibU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6FBB21D000D2;
	Fri,  3 Jul 2026 07:27:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 03 Jul 2026 07:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783078047; x=1783164447; bh=Qwcw00koi4
	SAr/XxMUkrA35oaJu2rCdrSB5KR8zuxDI=; b=WhcCghBoXsFOuzybMl0bYUvhQl
	oBp9jdZUwdsdTCITtYdksDG5RQ/c8Zr7m2LZBKyrGTbKMmJ2w8dzonHl21onuhzL
	Bg3G4EludapjlcygEEgK1C66dyrswmQ+axSep4DnKXc/dbfQ2LEfjEsIzX6/tdhc
	iWlGtgHL3/5M/O+OhZkccfcL5N1lQ+LQsBLpyy4v6fqnakwQXQNR890MkRwKHpZR
	rNkjHCBAAeVGAHont5XaUGU3QdsdO7a0hympt9veeu7Bt69ASlk1+nRC5sCdlgOe
	lPeZJFMyAoue2mG8nFrXTlgSBDbpiW1G3ZL4aUaRlgubn6T7fFeHidAMcWCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783078047; x=1783164447; bh=Qwcw00koi4SAr/XxMUkrA35oaJu2rCdrSB5
	KR8zuxDI=; b=bZoQCibUz8nR8nQuSMLrhj9vjvGPh297yJ9yjk1gDk8/23mD0YN
	WnaLGGUaJ9f4+yicpQlbzOZ3tv9I2K2+vX11+980tCG+qQruKr6Fr0yTIst7+7A4
	8jf3+g6LBYS5T//+oZBB2dZkqwX7DkYwf9NJ0R5CcrMoApZn/RkTqkjW5JavCF4B
	JYYh3CIBGeG2c1505ZxowHMvAlzZ1nFSTuuVWscYVc2fEbp2BwujxeQZSTGDSoY2
	OGTaFRvWqeaaoN8nx/k6kgI5e6WO8YsLUOEZwVVwBgrQWQjy7UOFMfFuW4lTPOU8
	s5wBqos0EV2j8HSHuOiscUO2XK59/ATp+XQ==
X-ME-Sender: <xms:n5xHakMOs5QPpYWJb6XxGnu_uS2tMSYR8gW6bR2Od8rnf5P7SgLB8g>
    <xme:n5xHag_kZEfuK5NghZJ9fpXt0HdNllAL8IPtIiaa7FlLZdDKsMlVOjCbWZ6XgcnXT
    ydzXprT35RO3CVLC56Cfl2sZTNiUVPO_OGa3mhpc3Qvfou33fsUhA>
X-ME-Received: <xmr:n5xHao6K935ZK6UVq1mb7EY3_tkAfOT8sxrrbnd82nENeyLSPhyIEW5a3mfRGpXHNVgu3DNf8A7gNU1-4aZ92aGRr0VrCMIWeY7bH-T1ug>
X-ME-Proxy-Cause: dmFkZTEgNGWLPxPW4eZBYp7AQjK/Ekp2jPUCzBVhxCfpVqb4mu52309vTk1wEIWdXDToVx
    L6fe7ppwbta6FlE7XC2VePXBNRhEQWLEdXnI8Tf0Eu8knNOYGaTPkDq6d0nho+2H2Yeh5h
    PG/emKOW4X+WbcJWDenQHqf03xch9aRXrIvv6WL1jdZ6p7das5hl1YXSPSqNknbt5ELtft
    ebROM+UDQ23ybCk504sgtrI39qpIjVsz/3BxXR+QLvE2C/qQAYHHVbHyAa1ekBYMMb8r7c
    kYzL5n7fLv2whbAbtfHN7fIXWF7ewRGfX1G1cbOwS/9/UxutiTS8RKduoCgpxmKwS9MUqI
    FPeKzAviS0b/GC8u5oRaC6DSF2BpQjxBWhLB8Istt0FExC+GZA+mxrX/D6wAKWA4Q3Mhuv
    mpiPK+uyLZCZx0Lf9hxMttTYu4mmGIh/SdMb41TJDJdags1o9pEeNtTVJFfskTPFXmnHtU
    AB+ByX/sjIsJiQ/4J1A58L9KO6XqBNGbGhnnGD0YTMX2s/9ZYuZ1L27WBk1likT9+6bTwE
    e9dbqp3Kug8DsLGIvnnFIaBRC9JPrhSL90IvZAoK69tgqK2Ui7xaaHw9brz5qsxBU/I97y
    sHGigw13Dmmu5UrdzaoauZQIVUbhNt9hNt8HKI5+HDw2WFPCPU9i9hJNK1hA
X-ME-Proxy: <xmx:n5xHan3bo3x-KHzvgSGcIdNzXLgpjYYyHh3DbEPP0Ia7fRCeQpPpgA>
    <xmx:n5xHavA_-e_fDmnX_PRTq7oMJkH6-825edqh6JeVQ4EngRkrL0CxJw>
    <xmx:n5xHap3EacvaUYk77v_-91To3tGmusFktSeQ0mXy1FRuPRdrd7yOTA>
    <xmx:n5xHapt3_uSK_V2a1BDPItH9ydZBD-Uj8QpnacDsoMshfERQRUgtEw>
    <xmx:n5xHahtespG2LiDLYbLH_OqwmGh3YdgRuO03fqe96paH7ju_96X6hSJm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 07:27:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55d8b24c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 11:27:26 +0000 (UTC)
Date: Fri, 3 Jul 2026 13:27:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] hash: add discard primitive
Message-ID: <akecmzUCO7RyrQcO@pks.im>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702075953.GB2029434@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702075953.GB2029434@coredump.intra.peff.net>

On Thu, Jul 02, 2026 at 03:59:53AM -0400, Jeff King wrote:
> diff --git a/hash.c b/hash.c
> index e925b9754e..63672a3d22 100644
> --- a/hash.c
> +++ b/hash.c
> @@ -283,6 +283,18 @@ void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
>  	ctx->algop->final_oid_fn(oid, ctx);
>  }
>  
> +void git_hash_discard(struct git_hash_ctx *ctx)

As the resident naming czar: shouldn't this rather be called
`git_hash_release()`?

Patrick
