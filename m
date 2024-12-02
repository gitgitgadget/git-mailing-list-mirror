Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159831F9ABE
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126062; cv=none; b=R0b7XfnDNqeEjbMjfHc+8nspAzu3dMOPsLauYAem5flo4SsUSLO3JHdpYdARQdyR9BlUj+k2a1pfnLkwJL80waV5lQufvcXUWuzNsD14+m9Oj2S2MZUOPMtHH5U0dMwP/GSxfYW4JX/InyNpXkgp0VzESnYsfvTC60AvKGP+3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126062; c=relaxed/simple;
	bh=XeXmjnBJi9zrj4Ld1RMfAElFATqwONPmYldIQ6+dzqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf4VcSzeI6cNIUMAHAOaroo0AD0EWwQSWbh8o6aeV4NMvJWhzMjfCSTimGPyuSVciAgVs7RL/Uy3ut24L3p0kiOYHjHt8iqy3zYG6a0j6QnUdRWpVedvO4uydToTlDdAywUrNJ7xWpb4aUStzg+EsQRQI8d69xhaLDC7ekUtKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jOxP+ip5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wha7l/H2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jOxP+ip5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wha7l/H2"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 296F71140156;
	Mon,  2 Dec 2024 02:54:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 02 Dec 2024 02:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733126058; x=1733212458; bh=E45MBeYWLq
	HhlnNRkRZGuRi5agKU/sc0D0AoW8nulEY=; b=jOxP+ip5nXb/srAPhfRpYrZgWf
	BmAixTIK1PLWXVoI4QT/q9Q5QjB+7Pz2QKA9S0XFy51fuZ7qYeM57kkqrke8G3dB
	4RUFX5fWmLcTwRJ+CtJF+To1oqnrTK0a6A3oXlFKp2ttMtJYpozV10nLfBcNF5W0
	gF8kfgjnQ1n255XvqqGwZabfR4xHEtwAKcxssLJtvaviI7wBWNkP/YAGc+UugszV
	BXUS64NvnGA/MzADcrhkZvrVmx/FivC5fYOL6vJRdfzPLfpeVuCw3WZN3KA9PtQ9
	FnybD9CHgLDrMH8JjfZitRzHfDEJq/sUxFN9QYKM74ww8thte7IjjHSYMbIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733126058; x=1733212458; bh=E45MBeYWLqHhlnNRkRZGuRi5agKU/sc0D0A
	oW8nulEY=; b=wha7l/H2npm/c9OsJGXWYbfwVWVWkykHh6VcPXWf9hgSlhiQobH
	SR1mvDaQ4/tS7oxBk+a/gE/BhGkl1qoyUDTG3qDbdfm2M8x6JedMy7WuO3uEZCAP
	WRNEpDstV0qL9zy8Iw+5EocgMlZtnz4dBSW8vViEkV2Y1YypfZZPAAXr71n4pd2t
	dOH06zv/NKKZARZrKSxFtnxm1903M0Cb71UBOxpKh83cicnxqE/Vf3m8efv5sU4G
	deap6PqsPUrWkD2o7uxpQZyBmszl0yrFSnoTGPhzyZ2C0pu2bLIgxGG0Q/sHNFYr
	WGVyE6Kb6VbeMDKRruEiHkDPV30jdUoBfoA==
X-ME-Sender: <xms:qWdNZ3BeMRVqbWi9FlSoma1oi3jRPJpVxL5GNKZNn6Acx4YcSIn-Cg>
    <xme:qWdNZ9jxE9gxvmiRHFk6z8uz0lUdqyvaL7cRP8pDITVgQg1LXuM-bBOFbEcFy5he4
    SwopoKOV9On3Bh0lQ>
X-ME-Received: <xmr:qWdNZylhRiYudptP74o0YOBmStKnbpsMTuQiwzsPlk__V-SMw8KWc6yj2WupvzCub9jMVTr-EX_IjwNf8pJl0FcDjtNE36G-Qlgu5uW_j6Z6oesL6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qmdNZ5yg8esbf1feLSU-SxwV_C46x0CRcqujNpMu_OKDok0u-T_ZBw>
    <xmx:qmdNZ8ROQSBNUOpBhGs4p4L3YWzgeEo5vwpfoU1tQJriEdNelcHQ8w>
    <xmx:qmdNZ8Y9KX6LNqCI86CJ46OzBlB5eKJLdttt9NQ4CDAuh9B60szI_g>
    <xmx:qmdNZ9TCNN7MiBu-GlPbRowckPUt1RBdUs93lrLd8Lozj3VWm4ZLLA>
    <xmx:qmdNZ3fwdZOiF1isw2UJIKcUanT089CANX5tdU5zj2PG9GHnZEA9x31z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:54:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7a52a5d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 07:53:02 +0000 (UTC)
Date: Mon, 2 Dec 2024 08:54:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/10] daemon: fix loops that have mismatching integer
 types
Message-ID: <Z01nm6C5FEdy2nEW@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-9-fc406b984bc9@pks.im>
 <20241201220802.GF145938@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201220802.GF145938@coredump.intra.peff.net>

On Sun, Dec 01, 2024 at 05:08:02PM -0500, Jeff King wrote:
> On Fri, Nov 29, 2024 at 02:13:30PM +0100, Patrick Steinhardt wrote:
> 
> > We have several loops in "daemon.c" that use a signed integer to loop
> > through a `size_t`. Adapt them to instead use a `size_t` as counter
> > value.
> 
> OK, though most of these, like this one:
> 
> > @@ -503,8 +503,7 @@ static struct daemon_service daemon_service[] = {
> >  
> >  static void enable_service(const char *name, int ena)
> >  {
> > -	int i;
> > -	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
> > +	for (size_t i = 0; i < ARRAY_SIZE(daemon_service); i++) {
> >  		if (!strcmp(daemon_service[i].name, name)) {
> >  			daemon_service[i].enabled = ena;
> >  			return;
> 
> look exactly the same as the ones fixed in the previous patch. Is there
> a reason I'm missing that these are split out?

Yeah, they do. I decided to not touch places in the trivial conversion
where we couldn't also remove the macro in the same step due to warnings
that require a bit more though to fix.

Patrick
