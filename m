Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393914A60C
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958336; cv=none; b=fOW5xy1BMKjC48S7DBiJBEf9+VEV6i3eoFGLlt8gLUFOY/UjGyZ/sb6th4dv9Hfeof4QA094f6oIrfgXqBGyDMkRYVzIr204y+PPSf4cRt/BucNlCbm4SK0c1ELnGYUmFmlcAVCJW2mnmusBV9dQOLNAn0SnDZstX0AuW+k4wiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958336; c=relaxed/simple;
	bh=k1DNyJ24WuUSvttXEUcVw8WOWtGz9WemHlLkQSis0OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnGuHgX6P7Ffcl7kYi5Y+7u+bm6hlpOhXwt0sjwe5FVlPOK3XVraQJY0/wF9YIbY6Q1EXjWbwXElZCIX5+iTTNs6rWgzlrXbf/k8X9vAgQRULW4uAKROpyieYeFg0VvZ9HO/DwDoEUU7VWG/u3OUKjwdJkH0ofGcnpPhTUQQtIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iQXqX6iS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ht/01aFt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iQXqX6iS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ht/01aFt"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 201D31140169;
	Wed, 15 Jan 2025 11:25:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 11:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736958333; x=1737044733; bh=FyhdzcndW+
	qjCfxG1HW4fb75SUCLqBXUkgZoYyEo6D4=; b=iQXqX6iSLKJ/ne1pJtCCI1y+ci
	ty7kHXIq/8NN/ynP6yKgkywjoRSW3bceQu/0GTy3Ej26U9qkip0Bg+HhU0dz3M3o
	crqsCdFBFBku7emRQgbKKsQ6OHLwPcHysWhwAiRmY5yHe/sS9u6AV0UsUPzpDfjw
	gdkaZm7vjKYjt1eh2liXPzIYouayXM8IietYERku6ca8sVdkjPGdaH3UnxsiBBO4
	LJ3WodlPkysI4LPOeIiWbAsTDTA0nqhd8BmKlrnhgUwBYQfalnnfYaFe0PxE7PzH
	th+Gh0AvTgoAso6mUfiidJnt/nd9aFPOVP0rf2FrX3F2Kewh12SW+sVyicSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736958333; x=1737044733; bh=FyhdzcndW+qjCfxG1HW4fb75SUCLqBXUkgZ
	oYyEo6D4=; b=ht/01aFtOD+lq3DG1vRhRt/WhthAHQXHUIGV7pImV591SOrVYPD
	4263cQjPpXqRS+gUKTWMWIlz65M4WUCu2hjuon8u5jiXKRYSl7oNGcCPwOOYfK40
	+a+wnPe6igjm5/d3gO6s/R310GROD05RrpOv8dxalI3kXx63so4KtnpEbh1aFWmP
	UzbX01HMMEWMWoNWOhn4T+RC78MLk/WGgxjIvJofhvSS/lXvM2DpuUXnVC6ffblj
	zKvMfxcWOFi8rEf0Sr9VapZRuB+S0BNJJ7ONl1y3a9+F+dIOSVpGar3iesoW5Vre
	LH0zsJKrXjuQZgJHdRD3V91lcpqt1hhq96w==
X-ME-Sender: <xms:fOGHZ7ux_q3GBYi25sFsB-9fmu5Xq2BI0RBN20yBYQyIlcKEEL3Efw>
    <xme:fOGHZ8fKeTPTwbeRHpXaGmTVBDS5owIBxTmQyvTmkO1aE8LgI-uADft-XRP9F1d_H
    Q50GRlDuGP8-dwRJg>
X-ME-Received: <xmr:fOGHZ-x43s9mMQMckmmLmd32h_CCSsp50z8CmmPBa5lj_H7h6oVg4OIrYxUpfQj9n7ktuEdrLeAXK1IHYQV6VIyHh1pH1kf1IdEufAwME-hoaGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkoh
    hnshhtrghnthhinheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fOGHZ6Pw0MgP6O-oO9j1bguyQDDDjCRLjIYPjTNSpEi2SlH8P-ToWg>
    <xmx:fOGHZ7-rsKXIU5xnsSQSPs0zXr7YB0f9G19QUYqn_QDVnjP1nIuMuA>
    <xmx:fOGHZ6VWgb2onKDkuXwvcNgL8AWYSVDDtZZPn2p_9M00sL_umycwLg>
    <xmx:fOGHZ8ezo0xwFK4n5TX4z8_M4ITCbG3D3TEaonluLIAhbgf7IH0FMA>
    <xmx:feGHZ3ZUd3d1JL9sSDh3D9kZM9Lpmg6jc_0MprKJRaKI_Z0yS2ZzIShj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 11:25:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 91bf0916 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jan 2025 16:25:28 +0000 (UTC)
Date: Wed, 15 Jan 2025 17:25:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
Message-ID: <Z4fhd9UpI76vb6oB@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <xmqqjzax2nqw.fsf@gitster.g>
 <xmqqa5bt2jc8.fsf@gitster.g>
 <Z4dLeyF8N8PhYAZq@pks.im>
 <20250115-eccentric-zebra-of-hail-c22ba0@lemur>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115-eccentric-zebra-of-hail-c22ba0@lemur>

On Wed, Jan 15, 2025 at 10:50:36AM -0500, Konstantin Ryabitsev wrote:
> On Wed, Jan 15, 2025 at 06:45:31AM +0100, Patrick Steinhardt wrote:
> > I have in fact started using b4, as it makes most of the tedious
> > housekeeping around patch series go away, and it indeed uses
> > `--full-index` to generate patches. There isn't any way to change that,
> > but I'll send a patch upstream that gives us an option to do so.
> 
> This was done as part of this change:
> https://git.kernel.org/pub/scm/utils/b4/b4.git/commit/?id=23a9ddba10a057bfa9c438c0b50ac36d278ae022
> 
> I'm not sure why --full-index was added there -- I don't think it's needed for
> --binary? Please feel free to send a fix for that.

No, it shouldn't be needed. `--binary` implies `--full-index` for that
particular binary diff anyway. I'll send a patch.

> > My last patches haven't gotten any feedback though, so let's see how it
> > goes.
> 
> I had to focus on infrastructure needs over the past few months, but I'm
> starting on my b4 backlog soon.

Fair enough, thanks!

Patrick
