Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E772E62B4
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910069; cv=none; b=vD2ors6WLUsINSjNDd+hazM3qb1Dn8TR9UV1FwqNmvoh2qDfSRFWxVB+MSYhnDZN4MZP/EeIAbzQmf10PJrZvyGlOZvn0rpMo7n1UqBV97aBUCsceuufCIWxQbnuxHlxv4Rt0vepuvlhGHov3/ffZgmGGVGw24tmFbmJpp9JGX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910069; c=relaxed/simple;
	bh=sHpVizjGa8D/fwatQt2XTb2MESGhhrFWm7Pw9B6RsjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haAwkkZZBinu9dg0K3Bd8A+4H4Vr8mnpQFqwVsMhvGBbJR6OVbOoElJW8mE7i5LUku2ofzBUvFmzCYVbaOy3BIvs1nnD9zZNHDOxngwvjcx0ZM6LV0q9HKH/VVgeiqog/NkxPOz/DYEVXfAbj8jJE55tP+x9zYXG73rFxTBYnFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GcNBzIFw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FaC9yy/l; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GcNBzIFw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FaC9yy/l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1EB531D000E7;
	Mon,  8 Jun 2026 05:14:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Jun 2026 05:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780910066; x=1780996466; bh=u2qkqVXqkj
	Lgek/t1FWDXpLbO9HnE/PZwwmC2AahvgQ=; b=GcNBzIFw73YXr5Whr2Vfc/R5sY
	TjoUTs5UxOGpPpdNEZ91z9VZlCR/ddU3nFMIoOmimeJyS/Yw0WDUUOf7K3GckC4u
	VsmncsO8Lp61OnH8HmsQvVmWQXm37s0FEgaXic8Y5vhna1Lx1uag0BD78uevf5gm
	CE1n3YuWwlsc7gy7tqPIuxXnKgpq9ah6T9LaBxmdLi3oAD/urenAGJKjczY0iYWd
	Jj1uBdd+f96BWGDMWGwqvB7u9NJDyha6escM2hdsI3M6tzODGb/MZ1LbJMdjPDgN
	994AA4u3pGYeXMkuBX+D09zjCgz3GBXB/AjneWYVCsnjDM2LHrqgRb+tRJ9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780910066; x=1780996466; bh=u2qkqVXqkjLgek/t1FWDXpLbO9HnE/PZwwm
	C2AahvgQ=; b=FaC9yy/lgkNgM/2IMzGJHbUBilXzUVcQ+oNiq3JMql+D3Ei4iBw
	3Q2wFhtkkrQrp6AsaqwV6OxQdmBr6qZ0Xs6sS6/LZbJoQcH89vVKX1oFrpW04O09
	iqLldHj2rYxLBDFQLsRYHZ1t8SUWZyZH/ZRHANpLmWMM8RWOEHtkhTiqz6TAj/bT
	GJkSj3BgYi1TL/I87cPXH8sQbFs4UioOASTZHvXJln/1zZDG0Ohu+SWF/2KYQFeJ
	LY+PDWKeotoMr6IrrQrC6u8cNNuF8X7aX0+x2ao56x5qUxrDfSQJZX+Zpmv8MXb8
	kObxPMtWEE0RPS+lS+Xvrzu/H8ocLyRoaKg==
X-ME-Sender: <xms:8ocmahPotsb6BM-fDHUPeHa9vhHEKsiwzu6Ndm3XcXH0YhJybLwqhQ>
    <xme:8ocmahzwBTULVidObfI2IAeh2qGwvBG9JXAKAOEQt-2pV0RsNNDNOtrDMVyamE9jV
    lseH8UoGj0Wc4Z9eGh2DyTBWjM-NAr_1egEVqKSoL7gOEq6arhw7Q>
X-ME-Received: <xmr:8ocmaquZUTgG9qQrdQmABfNGWA9kcbj3SRW-w3YbSoE-k9PFT33E-RMfy1ffW6Epr2HWnealpdE9N2alBYS9os0Lt04w-SCnbErpQ9y2mw>
X-ME-Proxy-Cause: dmFkZTGTM3U4ptcEJKQkwsgBfB16Wne/YXTN0gy9AQtWQh4/B8HfWz+QxhQqvLDL4b3T7y
    hg3x76ab9HIYpXBEEf4+kajJZQJ9aHsRVWA44M6gxHNUtf5ODCqe3qAwBJnT1EVkcz4Zfk
    ZNurcSo78iuC1YyMJtSbn10bsUHUBWZkmlvXgb1BkhLXN5+7c8LoqBuYz2EykbQa01cHsH
    /AG2MmPBkY35yPwWEpV2HlRU70R9f46TdQr8X1KJDqVHBRcbSguBDppT7stLtoQY8/cAHm
    zUEjXhUcDSLuxLb+uFZ64lh3UcyJltb39W/MmX86hc3hOKWCrRZ3Awl1mJhSgxHERYfBcS
    89HiBnX3EOBfew7jcXLZjtNTcXUASRrHEY04rdpcKs65eBt7kODRM/0aCUnf/jFhmyv0zS
    Rf/BDvLIEqsVVCTnnxu992Bk43QtL1sgT9I7+HgR+IlnnL4Ym7uqM1RVKfN3vc0i4KXVp5
    pwMnA24XHMDCWQXXOiMu6+y8dG5UElfU1d4waivmbLEVFUQ3asieGEPhdDzHPxqrC2ChEW
    OJqDOxh1g7bthH8VkkY0HzLRfA4mEEDuq2qOjq/e2eat9nWQYGchxO1k9a7uqf8U6OYlNR
    HncPyI+hibytKkC3G9cv6P0nN0IKfR8bNew4BK/3DP8LAy3f/tYq2DIOUwig
X-ME-Proxy: <xmx:8ocmaq5dCI3zCqWZcWJzcZKmLwglwmJUdE3Ou3v0UbP0DWsVnY7r7A>
    <xmx:8ocmapRKDVnokfF82Ryv4mApL3ePaOy8TEsiLGvmDmBCaRJbVQpJVw>
    <xmx:8ocmapqfRg8EQcwXTImxhcU-tQJKbZrf2lSGysYnHYrwNVbTWTBenA>
    <xmx:8ocmanLjgEV2g4WB6t4yyFU8KcC0P2-qQFCtT8Nw64n0cz5mkb9LWw>
    <xmx:8ocmamo8jGPkh91o9pwgZ7fk2qYudLkKZaQV_xor4xItPPFJGWCs90dV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 05:14:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4362adb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 09:14:24 +0000 (UTC)
Date: Mon, 8 Jun 2026 11:14:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/9] reset: modernize flags passed to `reset_head()`
Message-ID: <aiaH7pMleQmnzmTc@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-3-742cb5b5176d@pks.im>
 <9e2cb34b-97f6-44f4-be44-60f44760e601@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2cb34b-97f6-44f4-be44-60f44760e601@gmail.com>

On Fri, Jun 05, 2026 at 04:08:57PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 03/06/2026 17:14, Patrick Steinhardt wrote:
> 
> > -/* Update ORIG_HEAD as well as HEAD */
> > -#define RESET_ORIG_HEAD (1<<4)
> > [...]> +	/* Update ORIG_HEAD as well as HEAD */
> > +	RESET_HEAD_ORIG_HEAD = (1 << 4),
> 
> I'm having a hard time parsing this new name, if we must have a
> "RESET_HEAD_" prefix can we call it something like
> RESET_HEAD_UPDATE_ORIG_HEAD?

Yeah, that reads better indeed. Amended locally, thanks!

Patrick
