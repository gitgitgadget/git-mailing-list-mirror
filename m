Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436B2D7D3A
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758004897; cv=none; b=ZQK389GwvAiLAdFT4LrS0LGFydDt+9H4JU58DxDKsnvwoon2vyag/KRp+5xLOegtNB9ceEFfc7IwqQ0ZvKbpKBHCDvY0LiBvNpZWT6wUXF7oLIdeKpA2qucNGrQSvN4BAlPUDS8eKhEcJIeb1GQKcb24zzBdfy/OyH4ogZ9xAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758004897; c=relaxed/simple;
	bh=88WaWSYXvgQt8tsJSxSmxDiVYxh6pFI9dzv3OmJE2us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvUWrRgBDTHdMg3BvResKsdf9AmqYBiM7Ph0DJACMu4G2B6DnTU+XjkgDvgFDEPUAowS1zEW3QZq3kEnGwn9YXusS9MrK7LKuR1uo5ORZDOk45dYFim62T69+f69mn/JmVDCgYbKrzY7yVP/HcSpSblm28UEyRsq/l0I69TftPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dvBpbNKm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TdnU5eG3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dvBpbNKm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TdnU5eG3"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C10CC1D000C4;
	Tue, 16 Sep 2025 02:41:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 16 Sep 2025 02:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758004892; x=1758091292; bh=KpFOx+wcmY
	yDvaZwSAdaM8XGbyI5T/o+yO6F7T4t7Ss=; b=dvBpbNKmBidpMxT+wWYF0EiHoe
	w07EztK0aD4DibGqeTymTQI6wUVelXTNnN8RH3oozTktlmvq6ujZqSV0WHd87bNi
	Zy0SEE3vA1sKEJzQ+MRUyH6IofeFPMFW1qXsgSe1n4MQEMnU6XEdoeKzY/gmvVU+
	FWbB0iXlkGEfHDgOXP1KB2XVAHcegpi0Vl4L+xdxfKX6rDfakXITp5SEJVziuaXj
	PhuKKBfWE3zXgsgXjZJuQahBcNCDcVbw1ReZapBubD18bsF9Duw6JaOKk3in1KFo
	NnCbjgEc7eurFCWaEXTdlAy25nYE7sWpxqKk8us2Pf8+a5zK1ZJRhCE3O9TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758004892; x=1758091292; bh=KpFOx+wcmYyDvaZwSAdaM8XGbyI5T/o+yO6
	F7T4t7Ss=; b=TdnU5eG3hlQVNRembndXYx0XU2+e7VIIsNp475dxZ1Ikoe/VHZR
	DiaoroKBrbdkDb2xiyoN0/M9dqrXYmBsIu73+p0mFEtyYWHDZ/2s0tdjdxI5D1Jy
	lJXvuthq0R/JLtyu+VV4QCJ/1I4f4G2zzZvjjMOzvAJdvghnKHWqj77J30BjZQMU
	4H0bxsgpymgk0a3DMnn/kDm4hImeVntFRjpu+hEHtZuTvH19mnZkT8rd9B+CDkzX
	501kYttZyV/bZEDdsc+JSyGs/08xJtLh/Jkgwr7S7F2b1IRjMJ5BzvuC1H5OvM69
	j5PmrJpEA6apHhA5hlXhKzvGC6Fkj+g0qcw==
X-ME-Sender: <xms:nAbJaGOhkclpwaqzY1MuqaE8_ATUiKzmbVb02sVZDHGPiGwyOkQJtw>
    <xme:nAbJaIOxwn8MDHQ5_CRmaIdNDV2BB0SSYd9V3RHBG-43YD4E67Gg7cuLsijOGL-86
    k5YMeXdd3ACYMP1xg>
X-ME-Received: <xmr:nAbJaGvK73jHCiUtpvg9PvUJkNJXWcAKbef5tqygivgR1qjVb3Etg_O6sV9o00fnT1oph2NrnfrpG5wi1CiGtfh2Lp-OYgSgptxFDGBzX4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nAbJaCXN-rxsY104xaBXKvJmXCXXJ-lU9xoPh7C0miLZt-wiFp12gQ>
    <xmx:nAbJaOsXxgnmjGCWQgqnxv0Rzq-uU7p-wkkwn7JqWhkwSsk1pIDLXA>
    <xmx:nAbJaOVaTGfSzl65yd2OXEffWlo1qEerG8eIadRJVcpVYA8RGzEoMA>
    <xmx:nAbJaBkyd1nrcICxyrZULB8UF-J7SOCGrfZOpukDAPg5gxhcGdSJKA>
    <xmx:nAbJaM0H0BKlmcZpHePu0MeWC65EuZHu4GYemZts-UUJJCOeuey21Qtd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 02:41:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d86159fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 06:41:29 +0000 (UTC)
Date: Tue, 16 Sep 2025 08:41:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/3] ci: don't compile whole project when testing docs
 with Meson
Message-ID: <aMkGluKUBfq6VNOQ@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
 <xmqqwm64orc1.fsf@gitster.g>
 <aMeshpRtFWyE0ja4@pks.im>
 <xmqqcy7re2df.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy7re2df.fsf@gitster.g>

On Mon, Sep 15, 2025 at 04:13:00PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> I wonder if we want to let people say "meson compile doc" to match
> >> the other world?
> >> 
> >> Will queue.  Thanks.
> >
> > The reason why I picked 'docs' is that the accompanying user-facing
> > option is also named the same way. It's thus a bit more consistent with
> > itself to call the target 'docs' as well.
> 
> Sorry, but I am not sure what user-facing "docs" option you are
> referring to; is this some earlier mistake we made that is way too
> entrenched to fix?  I do know about the "make docs" that barfs with
> "*** No rule to make target 'docs'.  Stop.", and I would call it
> user-facing.  I would say it is a bit too old to "correct" without
> disrupting existing users.

I meant the Meson option `-Ddocs=man,html`. I feel it's more natural
there if the accompanying target is also called "docs" there.

Another option is that we could also just have both. In that case users
of the Makefile could continue to use the "doc" target with Meson, as
they are used to. And users that are used to Meson can use the "docs"
target.

Patrick
