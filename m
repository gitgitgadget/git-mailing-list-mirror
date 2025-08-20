Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718932C11C4
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672887; cv=none; b=Grx/uGtUJxipZd7qxzqxXn2uhZ7p5jHUCmTPF6byxFjk0iV3heaOQpKTtbR7h/HmnkfBGgiixt3TTK7z5VSzgpJlH7pt6rdZWFTyVoLoaGlQdLukyosC22oX0ZyalDpbxOY4sp7wNOU91j89Z8nlzAiRbnTgg4JFCvmxQY2RC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672887; c=relaxed/simple;
	bh=wKLKmZUt02ULmyXx/v+8J0EwmNvUuavMmZaeHgYp7cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGutiaYOPW5FZ4R3XR2ceKyMn7//M0mH/ibmaVYoeXUXDQuZ0saBn0UHMls4638CNDBN1LfnoijaSjTXGJf0S7o99p20nfQndJCNPhnndqb+9Mm1thqi9XAX3SJ/DR58F3BfCCb0kFTpeCevtQaBUQTPpEUmGht7GLTVi+H3QGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0g0HeJR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PgNt2gL4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0g0HeJR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PgNt2gL4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4311F1D00178;
	Wed, 20 Aug 2025 02:54:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 20 Aug 2025 02:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755672884;
	 x=1755759284; bh=uQ4IhUUXkVeXovEQWqKHBp3iTc3LNi6Aw0GlS/LK9Kg=; b=
	W0g0HeJRFv74jiCf2pCLswAYcPNutpNmcsO/URl2CrXpPcyyzz886s7Avexp8oFX
	6Z5GV0L7HJQ3lDSHstKmCOp0aBA17LA23jOIo196w0pFhtClnrB3cJLqAXSKnYI/
	x+vNSYa3iG4DhWOxlEV0rEkpvh2V9ev4vvD0AaVY52q/T4kb7eGJ4kFdlE9EPOgK
	oXF4eeaE3ElwIGOC3E8U9eqTRvo0btf8xPo8XNYypmaFpGZGTXwYHwo9tHsGwgK/
	iHT9gzlqi5bK2N8gMie1yzHVClv+5x1LZZ+CEQnqnnF1m05XFtcJDtCWtlvRtq9w
	VJF5Jk6GVGuoTT/X6zeUBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755672884; x=
	1755759284; bh=uQ4IhUUXkVeXovEQWqKHBp3iTc3LNi6Aw0GlS/LK9Kg=; b=P
	gNt2gL46AtryNqm2M+eTgS9qINyYEAXkkQjx+G+2yQupNyLpWrJJ3GBrfBz2pU2Y
	XOk95c5Qu6tsfghNMtlkzbU6UZtMa9Vz5xHgoDcnwCt/4B9kcFizN/5SHiZszvQ6
	NE+DEBBZMa6JYeg7YDerOj/oiLiGsrQziUnbo8d2CIbkKZ1rSHlS0+hP8sJMoErc
	EAhzhWBmAYDpP6XWt6IJl376HiFKtYOrvWOkIhxLX3gewR6wIKpbs7wPcmb3xK0C
	PG5lHuWo2pqbQRb2yThJSxb4ZAoNjaWkHyO7rLL/m+7bm4x/QES18Id+IExoqswR
	j5nm7vX1K4WM99bpOUH3w==
X-ME-Sender: <xms:M3GlaPy5DVAK8GxPv0Ma-PGmpSyQdrbxjcRIzqbDeHHllvxIhxPQgw>
    <xme:M3GlaHeOiZv3a-xECPBBrIBZLjnu4wkqHdvVExRBUrlFRx78uvSCCqK3yxAYOQUQa
    l5pjtAMlwo7H_p0ug>
X-ME-Received: <xmr:M3GlaLLbHn_LvZMMNptT4tKaAn6JLmAz27oqqe4Lsk5XCKvrOl-lt4Gth9qMioNN7XerI2WrNIUkf_hiB3jXzXy_9iN2nZVejdYnuUC8T850>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:M3GlaIH0Y6dRUV_KrA2cXmKS37nu6qJ5ZrFl6dXvzqANXQF7F8O_zw>
    <xmx:M3GlaFrsvvVAj1u_k5-7CkldD8rh71XTzcIbCE_T54ivT7qaKJMmiw>
    <xmx:M3GlaBQxMPUMaFydpsb7WKjr5ciGzd6mxLKPrIYI1zom0qPJw8xNlQ>
    <xmx:M3GlaCPV3vm0bSo_pvu6ornIVcfZgrPO_AgkwjsX8LuVRg1GVeQRkA>
    <xmx:NHGlaJCG2KGFK6QT1Qi4izyNKFizZB9EraOf7ND2osXviONBUpONXkPn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 02:54:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46004668 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 Aug 2025 06:54:41 +0000 (UTC)
Date: Wed, 20 Aug 2025 08:54:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
Message-ID: <aKVxIYBqA2nPTFYV@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CALnO6CBDu14P8chvJ=1QfZ2apVg78E5P+d+P+4=8Whpu_EMi_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBDu14P8chvJ=1QfZ2apVg78E5P+d+P+4=8Whpu_EMi_g@mail.gmail.com>

On Tue, Aug 19, 2025 at 05:28:48PM -0400, D. Ben Knoble wrote:
> On Tue, Aug 19, 2025 at 6:57 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > over recent months I've been playing around with Jujutsu quite
> > frequently. While I still prefer using Git, there's been a couple
> > features in it that I really like and that I'd like to have in Git, as
> > well.
> 
> Excellent! I'm looking forward to reading this series and playing with it.
> 
> Unfortunately, patches 8–11 got dropped on their way to me (but I see
> the lore archive has them). Odd. (Not in spam or deleted messages,
> either.)

It's a common issue with GMail that mails from the LKML get rate limited
quite aggressively. Konstantin Ryabitsev (kernel.org admin) often gives
the recommendation to not use GMail for mailing lists.

Patrick
