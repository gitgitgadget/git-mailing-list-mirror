Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56788136E37
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 05:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745558477; cv=none; b=eeBI2VmGcEs4ytQRWJwaLeNMc8GHdwdzS8bRociHiCL4U++11S1hY+Dy6lgcLiVT28qpTzy3Hz2GNENZFfoLbTrLudeS6C2i1gL/7tqiooyVcsufP3fTJxUlxp5cniE29IE2vqQ2IKO6Rqy791nNfxTN4VseJMCYxm8jq96USbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745558477; c=relaxed/simple;
	bh=AtVQaDQwvTMi6beKQ7VPpNrrzh1t62sqCL6wlErynfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btOCgjJy02rJuerfBbnMQVCqBcrKB8YTEynDF5fnvj9SIl9wbrXodchlTIwEKfQasrf1AUxU5KE0o9bha5PQZCwi850JNeU9UQPNhRnWz8c386Wtiv7AQzY8ZDeeOjzGXjiuGrTMtsJNFmOAMONc8edN/DGxtC4V3BMvBDXrR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yc5nSALp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0uJqeTx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yc5nSALp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0uJqeTx"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5072011400D7;
	Fri, 25 Apr 2025 01:21:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 01:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745558474; x=1745644874; bh=bYchWRbZOF
	4RWLBT2V56tk4eogZ1YFuZ37DZciMcy3k=; b=Yc5nSALp/aOus/CNM9pEe5569y
	DA642/iLEUviCyZtjzSaWkpGR1MTapUJC8xENlnUrVJujIhQYn1y3EOZo2LbHODR
	7MVoCznyTmG0Em4k84XNIqNLWKaeqeHp4/6UDsr5R7WHdiYu5bnJbM1XbREUgka0
	irLu1TCuZHFLfGmn2t82uYhLBA/LNYGKo/VTOmvkuPZse3p7Hbj4v+cLNtcpbjl6
	Z6bSuCq5qY33ZdfrDpd3swUWEku5+ys6XI69boodSXcQX7Fus1/kJ3UQAlC6Gw11
	nG2ODrTIFQ8+RnhkTwuNeJA+b+Zv3LJ3M3x2y8iOU/xCY7Ai7VUizEI03PWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745558474; x=1745644874; bh=bYchWRbZOF4RWLBT2V56tk4eogZ1YFuZ37D
	ZciMcy3k=; b=D0uJqeTxtCT61FKD2gwk36ZoCbjIx/TJ191k7y7/xRpjzUMOkHe
	Dii3HRu3tmUcObb6bumWc9UGZxrYe7wp2UbDhLTw6H6rhIK7ln0D17w9YGn6gSj7
	Bctg/+5Bs1nqiDmWWR0UET7UhnywSeOS60jMWXn/jmCETKh4Hmu7q9ZAyST1qBGd
	q6Ead0Z3uszBiQvEFL1laQ27A1o6vScYU5ZNkb9xu0cSY3GjtwJdOgoWduZ1UrpG
	C4AUBdsoiB31YVh23wLk7Psrecd2rqjM0lrvmHZmDu0j6cG1NjBd0DDHPQZ4Q2X+
	UjEulvX+5TohMEB7dEPF5PCsOGi9gllMHnA==
X-ME-Sender: <xms:yhsLaH1BgJ-3OO3wXx57JxvScEp_TJeFxS6i7bpgJat0Q8vByIGP-A>
    <xme:yhsLaGFMpDGOojCYpg1ZqVRXVhwsrsNY3Ix62U7TaZTLdghqDXV1u9AVvtnO2ysoS
    hFX5CR-_EOLfnw00g>
X-ME-Received: <xmr:yhsLaH4DYD5s-33SVAml1Xjt6sz59Ouv4E_GevdqzSCGMKvuL-DZEMvQ5ROtjzS3qfakFo8DYMlsfmPkZI_2I7E-q-nj661cRp6G-Vsp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhsrdhrvghpohhrthesghhmgidrnhgvthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:yhsLaM0cEJPV2Mv0VDUtOep5E1fFrbQNb37wg6Al_KzfvaL3mfn1pw>
    <xmx:yhsLaKE1_KbAfKRuWsloIWG9h3jm-6n1SpHXcx4hifQZf85hIvuGYw>
    <xmx:yhsLaN8X5EAhTzGH7BGfsnrZw8URTlx34ZMxGUWysEoDawTRmb2Vog>
    <xmx:yhsLaHkVwmQ3X5nV0RKutWL8W6AK93cy4cvTVveZ2EyyRPB7ixsYgw>
    <xmx:yhsLaFEtwJjuATTShi5JsvNBIga6YT1akTXg11EesK-FH-YsFBtS4rRB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 01:21:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4983455a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 05:21:11 +0000 (UTC)
Date: Fri, 25 Apr 2025 07:21:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH 1/2] meson: report detected runtime executable paths
Message-ID: <aAsbwvtKTiZFRnXM@pks.im>
References: <20250424-pks-meson-posix-shell-v1-0-45e06ee4b6ad@pks.im>
 <20250424-pks-meson-posix-shell-v1-1-45e06ee4b6ad@pks.im>
 <43e86c8f-904b-4572-b84d-009c203fda11@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e86c8f-904b-4572-b84d-009c203fda11@gentoo.org>

On Thu, Apr 24, 2025 at 08:45:44PM -0400, Eli Schwartz wrote:
> On 4/24/25 9:38 AM, Patrick Steinhardt wrote:
> > diff --git a/meson.build b/meson.build
> > index c47cb79af08..8f04534c7ff 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2080,3 +2080,9 @@ summary({
> >    'sha256': sha256_backend,
> >    'zlib': zlib_backend,
> >  }, section: 'Backends')
> > +
> > +summary({
> > +  'perl': target_perl.found() ? target_perl.full_path() : 'none',
> > +  'python': target_python.found() ? target_python.full_path() : 'none',
> > +  'shell': target_shell.full_path(),
> > +}, section: 'Runtime executable paths')
> 
> summary({
>   'perl': target_perl,
>   'python': target_python,
>   'shell': target_shell,
> }, section: 'Runtime executable paths')
> 
> 
> No need to check if they are found. Meson will print the full_path()
> already, if it is found, and if it is not found, it will print "NO" in
> its standard color code (red) for things-that-are-missing.

Oh, that's much nicer indeed. Thanks!

Patrick
