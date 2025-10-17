Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6B30F958
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681609; cv=none; b=UHxTUDiK1AqbyqITmh/dGVIb16sGOVnU9denrBDsDoI1JI+B0N5oqGaM4KQVyItVDA0qLV4qa9AA1RJi0Toeb9cc+jXE/eOymbQEHpFGUwVGijnjp/VLlXE/YFKz1gXitWhmKh+GUNPflrTUUhOML8g+dSndDLPTo9/5SxxphJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681609; c=relaxed/simple;
	bh=JLO1j/nDO+Ux36nEbR8LI+vUehDinJMOkvdN71QuqgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuHgoBXTSHasUoUHlQfSVe13patYll63Id3YXJXxFGa1/QKbW/2ggBZHvI4al+bUo4TCMCt46QlRHXQGRXpU9LrUR4lGbsO8N3ndywncNPfqwFokNpC2NPxM5rN8JPeO0XxhDorrTZXHackHagRWPOG1U6DZleCwb5WLiLBQO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mP5rFvVT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2EaPrvr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mP5rFvVT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2EaPrvr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF70D1400151;
	Fri, 17 Oct 2025 02:13:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 02:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760681605; x=1760768005; bh=pOtZHxLyPQ
	nALo2xXn9MhBvQ/92VxYUHl5X5hvthlp8=; b=mP5rFvVTExDAlvQtbBkH6VW/q6
	7MexjPfpKgwDQgLgg1a6P+7/Jc8O06VbQ6rhP7fgAerKcKlsVD7jdEv6JngqAZjl
	jux7UNZtoWf2/8QlbSchSAPN5k3a3SII0ngQwwbkcOQrrIexbpOxwseo0ZjF2UeT
	a7NIPJXB0/OP5FUutJp8Y5uvuzFFLbVj/EYwuy4G4UgKoSSZTBIEedUviV7MUnHq
	1k1lZxrlMXTRSpI9B0pMI6Y+83FD5t+Ak3PMS0agS3LSEIGpuQr1nvTfAufSrrkP
	Yr7u7Jc8L/rUXPNrfbqIEpVXIQFCXtyX5ENb3XsMZT9m5vHsolItq4nr7Vvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760681605; x=1760768005; bh=pOtZHxLyPQnALo2xXn9MhBvQ/92VxYUHl5X
	5hvthlp8=; b=T2EaPrvrkziraErZDBChXDb25Ap4KTVU7ZDXBiGRdcUBNcdgam9
	aJnOiigs0O8cFYHl/Tts9SGyKuqeOpno7pdX5vd5FZJwR8Pkmxy2VX8nNvdDe3jY
	HbYGgOafD34AQZletRQe9tj1OEhOzkVNkCoUu28gcGyQl6RboMSWE9UdWeGkBuHs
	h+giBNaJxBHzmA+nSoN7Jiuq+ioXDOlcmPYzvSr4wvySHAUf0Wiv1O2xGP6HYOaK
	ltdCASz7/XpXy4jEqxBrNBhsagNBaRB4b65QhJvMbtaBlRfZXoO7xycO1i/AT5lJ
	/PpvEZNAsHmXycgQDdRm8o2XixzSU0TsNAw==
X-ME-Sender: <xms:hd7xaH6bfGrFu7y3WWVWSDZALh_PQe3MjDYDLxJ9JNGu5hXbh1RCwg>
    <xme:hd7xaD4pGEoroOub0amGEQHQhf4PAiVLuHUTVk_IGUyHTSs9FkLjBzqJLvUxIEdcZ
    4ZvF0QD-LTsMiZRpDh0K74H4QrXcpQZrn2SRjw9uiIamyhf1Ng27w>
X-ME-Received: <xmr:hd7xaDdRaXgUBBVArnGAA48Ru1ui7VdEZHSxEmL0e-Izz2N4c-u6HCgSIvgIRWK6-avmEu1KPTyNiNJPc53Pu5tFqJP0nrI6y9dt5E13uCa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hd7xaHAMo03UN0GrfUuEIn3Cy-GwqDSGXsTuFxZTLbIFahDbaCJJOw>
    <xmx:hd7xaG8hGtAqMhtDWDk4DCq9lbd5wwyw-WX7HchUfia4rsf21Iwsew>
    <xmx:hd7xaCJEFHi5Z3eHvrYcuWYp95DfVnL_V4erFN0fBVX24SpSMaeSfw>
    <xmx:hd7xaPihGim0OItN1M7BMo1G99ShSj91Uys5-kCKjlQ0mMHnbeSgsA>
    <xmx:hd7xaOsKviMClKi_4OG_v7LYH-TB4DNFn649Q32jjqFNZ_FJFVgfqxqN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 02:13:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d5572460 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 17 Oct 2025 06:13:22 +0000 (UTC)
Date: Fri, 17 Oct 2025 08:13:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/8] builtin/maintenance: introduce "geometric-repack"
 task
Message-ID: <aPHeflRSMpoRukta@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
 <20251016-pks-maintenance-geometric-strategy-v1-3-18943d474203@pks.im>
 <uos7cczvzlrwjgcyhzyfirck62qjnb4zcoy6ga2o3pbnba7cfj@ag2pnonze5tu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uos7cczvzlrwjgcyhzyfirck62qjnb4zcoy6ga2o3pbnba7cfj@ag2pnonze5tu>

On Thu, Oct 16, 2025 at 03:51:17PM -0500, Justin Tobler wrote:
> On 25/10/16 09:26AM, Patrick Steinhardt wrote:
> > Introduce a new "geometric-repack" task. This task uses our geometric
> > repack infrastructure as provided by git-repack(1) itself, which is a
> > strategy that especially hosting providers tend to use to amortize the
> > costs of repacking objects.
> > 
> > There is one issue though with geometric repacks, namely that they
> > unconditionally pack all loose objects, regardless of whether or not
> > they are reachable. This is done because it means that we can completely
> > skip the reachability step, which significantly speeds up the operation.
> > But it has the big downside that we are unable to expire objects over
> > time.
> > 
> > To address this issue we thus use a split strategy in this new task:
> > whenever a geometric repack would merge together all packs, we instead
> > do an all-into-one repack. By default, these all-into-one repacks have
> > cruft packs enabled, so unreachable objects would now be written into
> > their own pack. Consequently, they won't be soaked up during geometric
> > repacking anymore and can be expired with the next full repack, assuming
> > that their expiry date has surpassed.
> 
> So normal geometric repacks don't ever check for unreachable objects,
> even if all the packs are being merged together. With this new strategy
> though, when a geometric repack would normally merge together all packs,
> we instead to an all-into-one repack which does check for unreachable
> objects.
> 
> Does checking for unreachable objects in this case slow down the repack
> significantly?

It'll certainly add some overhead, but I didn't quantify it. My gut
feeling is that the all-into-one repack is going to be slow by nature
anyway, as we have to rewrite all objects. Doing the reachability check
on top is of course going to slow it down even further, but the relative
impact is going to be smaller.

In any case, we have to perform a reachability check at one point in
time, otherwise we won't ever be able to prune unreachable objects. I
guess doing this at the point where we merge all packs into one is a
reasonable tradeoff.

I think the more interesting question is whether we should maybe do this
all-into-one repack more often, so that we can prune more regularly.
With the proposed strategy you'd need to add a significant portion of
new objects before we'd ever prune them, because otherwise we won't do
the all-into-one repack.

I think for an initial version this is going to be fine, but we might
want to iterarate on this eventually and add a time-based component to
the heuristics.

Patrick
