Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F270378833
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673227; cv=none; b=TiyCCUY3Dh8SPLmbudUQNVa8B2RoCn35ErBu79gvrY7ZmgZXYBSrF9UR8pw4KDCwoqblscZCzmMEPuz0MO1mlSvPS3CVGFwKF/Ktisyx4T2Tippw6Ju7DrJv+Kwl4lEaM6nqVAQxdjdhrNdwvBs7oyJVe1nMPdik8kPpbWF9dDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673227; c=relaxed/simple;
	bh=jCpCtLCUcjGGqN1oezGsY1m1fRxok7tWR16migOKJKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8E8WLrVkOJUeVQWndK53IiFPk3WbwIQ64j0znJjnvEpWuvJTOhjZwdJSm/8qmjzm9DbQMJlE8MU5V9UvD23qLa3vZOBUHl8S9YPL1+VvmxkGZll6HGiEyhv+qm//J/zkgNXyd1NkB5maT2TUpEec3SesaBYkbO+LWmzQw36A4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nQ5D9sAZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+V0j5TM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nQ5D9sAZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+V0j5TM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A913214000E3;
	Fri, 10 Jul 2026 04:47:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jul 2026 04:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783673224; x=1783759624; bh=QvGnDDQqHW
	c4O4pCpIjOFvH49UkYdAdZQMIwoioKfFg=; b=nQ5D9sAZDaeqK3BOGrbVHN7XHv
	Jfnx7OAUb6I835Ivyh6ir8gIidKAkQKJz4UPZ5cj8y1MaaG94GAYYi9uHBlI+uAh
	OyPXTritJR4lykqljnmHp/npOo24xRXrHUePLZaRwUfR3MK776XrKhhEml53UGZ0
	Kc2f5NgwvPE8L5ZapBtY8fDNeEBt+I0N+oDdSfTEK7KeR2WYt84QmD+krRJ3Agw3
	oNRmNp4ZHGrz09zi2mu6/5ChilyJnp3PtMiyX24S9tilc5/wUG8jBKdwwkAhiE1I
	gAINymUD4DcIP31txOEaWhKdbtbc5ZcA6WvQyH3WhFTYi7w0WTY3Ok4cF7kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783673224; x=1783759624; bh=QvGnDDQqHWc4O4pCpIjOFvH49UkYdAdZQMI
	woioKfFg=; b=a+V0j5TMRfO9f/jpE1TJwvbpHRk/nxHtdiOUacksXxOV0/d7vF8
	hBH5BA1sz8pwR3FWPKgSjpg2GNkh6BL5XofhUnSv2LzqcLdaIrMlzcY6yZGB12XF
	S7SJDeMFwoD2OjgFnVmyIRpNGFnb2by9W5IB9bVlt2JjxXLR68UtCyO2PX2DIhTd
	W8sG2o4PuHqZhJ6Q7Z7lrVsBbk/2uaWtrZQ1BVJrLTJrkpPWK6IUuCLb2tU3D+Kt
	XePJsU8/3YeB6Vn88hb/HUlqVZpt+1PpwjGxEYtiTXim2EdeTNkULdqdsH8Fd015
	+iqBAhG/dPg4SGJNYFYGYoNdS/1iFmr6Ddg==
X-ME-Sender: <xms:iLFQasSKzjqJEx-7KR0SfZIUVUCZARXDyo9DGZUtyWxBd6E2rjYpUw>
    <xme:iLFQahMlHzE9V5ZGRhPg-kVxwBojcGDsVXz8kYufK5zORpOnBBrrmUD2UAcniZSBm
    ipryKJL_dLkMLbkwYfO9AXIYe1rom9CRWvI3TvRYSZQvVGPwLw3>
X-ME-Received: <xmr:iLFQanPjk8EHE2EPs7jJFsK4cgYpQlVjTZrRSdDFlIBhTNrB4D6VKh3o5xFhyQkgQTTLBLK2NzFbgrEZjXSyvosG810WM4cITvRnPXdIm-AEJQ>
X-ME-Proxy-Cause: dmFkZTEEZuNUkAKoctoLdJSTh+jU7VJXmPgtrxmi2KdZ2SFnW1EPyV5Vrg3rnfTHp6mi7j
    3+aXiuz4YjDX/NkbuoPUVM0swjK/84s48mTsqo1P5Fn0IVmu8K+V+GmMx+lG1J1+pfTm/B
    d0m0v6I3DvnSjTfMPKa8sxiGSFzyObSYT7bkHqWaR8t7MeBBqhazY4tVKaaAUDSN1YhRrf
    fsWnP/EK+/Vec15eSSiIUM+W2v0INCOx0ikXtuTeQR8/gbOzMBw5E1Pzu5Hiorm5Mu6ypf
    pr4uHCPQfs4Qp9Co6aYLfc4PRotsfSuQfBJfztIoT+DgmeuZ6IKqh4TKBqpY8zcCQv1WVU
    IXxRqB3kJPL6YUwGfY6m6rEE08P1OHeIV7sQM6Qrb9/6V1vkw7sronjHdxW6xEa34112yE
    8GLuKyORbGChaghrYM4eSpWzGZIudN6h/rS5jEN0LNzBwKwH4iBOWm0cz9SYx7Jdqspkyp
    JBAOe50Ahd4IOPQnhAWi/YMqkVeFb7tsMHBw2DACEvU2+pkl/wnZumbUQ47CMDDd3X5GnP
    iypLNCQEkCvy/XoHfJJ82ykooXM1Yq2ogLeYGZpwdhJRBcDrGcdzh6+TGOc/a5ijp+/rJ5
    DYEqUutyl6HWph2uP8670OXNsPTwyGjKpLpiNXD83ShhhOg0Qm2ERvYfbXtA
X-ME-Proxy: <xmx:iLFQaputH5uziZxUjfshkwb6tD0R7aAJjQys20KP5oAOpB9psjWgaA>
    <xmx:iLFQapWou2GQdVFZcyYnT5K_1SQmng3PRl4Gwnvt5u63xgqwmd9YsA>
    <xmx:iLFQapsmSuDaUCOvKtNRx4UzMOpFme0hr7qyX5ZPlO_X7wghbuqgIA>
    <xmx:iLFQatW7-IzUhxieErL-_X6ij023fuHiYdVGJ7tPhKZ3nZ62-oKPlw>
    <xmx:iLFQaqJzi881sy8-NW73usBlnPUQNcF2CgOIk4VLJU69TRXLd9MNO7m2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:47:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5d88f6b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:47:01 +0000 (UTC)
Date: Fri, 10 Jul 2026 10:46:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: me@black-desk.cn
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] b4: include change-id in cover template
Message-ID: <alCxgqybWb9eDEG0@pks.im>
References: <20260710-add-change-id-to-b4-template-v1-1-1bd37a25064e@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-add-change-id-to-b4-template-v1-1-1bd37a25064e@black-desk.cn>

On Fri, Jul 10, 2026 at 03:22:13PM +0800, Chen Linxuan via B4 Relay wrote:
> From: Chen Linxuan <me@black-desk.cn>
> 
> With b4 0.15.2, I hit a local failure after sending a series with the
> in-tree cover template.  The generated sent/<change-id>-vN tag contained
> base-commit, but did not contain change-id, and later b4 commands failed
> when trying to read it:
> 
>   CRITICAL: Tag sent/... does not contain change-id info
> 
> Looking at b4's source, the sent tag message is derived from the rendered
> cover letter.  The same code later parses that tag and expects both
> base-commit and change-id to be present.  The default b4 cover template
> has both trailers, but our in-tree template only has base-commit.
> 
> Add the missing change-id trailer next to base-commit so sent tags
> produced from the project template remain readable by b4's reroll and
> comparison logic.

Ah, that's indeed an oversight on my side. So this change looks good to
me, thanks!

Patrick
