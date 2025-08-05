Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2D219A97
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754369394; cv=none; b=goq2FXgWgpft4cLorpGMZj/yzvVzDk3zW379KNs0mZcNzZs8cV6K6QqInSh2o/0pw6q/qsGieujtuq/wv3xkw7nBxPnrIPF1obsuWhIfMvAiwybC+pzJ5dxbl375fj1eWpOeXGaks60+MlCKuaHBcV21EvfMT/80uJbCjdr5xgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754369394; c=relaxed/simple;
	bh=oTF2jErKsC8oW78s5R4Dwz/a01LEkjx7XkxHpt4meWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqiuhWXQCSFe7raA01AGZq1hgBbRPX/N29mf96zczA//GpCMn0lxqErj6pA/Q0Q2jofjvZQooO9LAC/eTsFM6HajOxytK5vbUwdjRuQx27vU0mNrAtFLeHOgGv4eiXOdpu1w2KgQl7BLq2wsO4JW+pMRy13vFrxZFwJYKj4Hj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ipqdU4ri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKcJkVMK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ipqdU4ri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKcJkVMK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BA0D3EC02EB;
	Tue,  5 Aug 2025 00:49:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 00:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754369391; x=1754455791; bh=t8ypeSrT3r
	GQNfL4cGEJV6QkOhXE+rPkwjwPM3Fjh48=; b=ipqdU4rib6mj6nW2Wc3n0hNXsd
	US8FkPtwKLNyiEAmv22pio1DjMVgqoCNLfV1c7fXMr1e0Hrry+Or/BpmZQwEYPUP
	eB9aF/wzYbwIFCoOo5hALKhx4dab9V9xoJ+LC1zAjjotHRMSOV1EZkUixbUQGOST
	A0fRokd9jmeezH9rS/RM7JxBsSoaUQtzXxNbN5pLA9vHtfzEEbMac4vXlC0Ozitp
	aEQHo1u7WBIaMu+cdNzzchuSDKqpnhThYfZboBK6gGR6+M1rGHEqkcVc5xuifUSD
	PnSnCURGgkyoC9PNHbiQIwQzFl9hTtOR+yyScW5uxmvmxndlqsQdz/QQhCSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754369391; x=1754455791; bh=t8ypeSrT3rGQNfL4cGEJV6QkOhXE+rPkwjw
	PM3Fjh48=; b=iKcJkVMKJEOOiVrIWqfVgMY8c7W6sxn3l5uJBU4Vw/fphHgIBi3
	NPbv7SoST1HznZZwL4xMPCa1xVUbUaI8w8UwJwgcsokG/F40gHoVkYfph6KjW3f2
	5YXynfpnhvHr4b+SfUBVcRBhBtNytjVwKDqa6GjRFzWgc46kAh3hng9HgW34bk/L
	fU/tZ+8yAYIR4G77knRdX88GqPT3VgSI+48m/rPvHJRL9Z14XAwDkuG6Jn45+QjP
	DjjXqv+aAhfo+sqgIdLJk4qOBTxiSKesv+C6ETDxVL8g3ke/EkPAipaxSSTkbNZF
	5+sX+54zbGCVYD50jaP5fO6j010SodnumtQ==
X-ME-Sender: <xms:b42RaLZZSA3_1OZTFxodfK2uWelZ276ViB7WMrkmgXZqB6IJIjmstw>
    <xme:b42RaCI6-hh5suPz-g7hkpYG5YTQ4gl2T3IIuV_aFTuiJ20CbzltXOmSf6AXnjDsH
    y7CwJODTt9mGB4F_A>
X-ME-Received: <xmr:b42RaBDIfvDpMiyr7mym83bJPxESzvEkn9O9XU4a4PTNSbmQ0IciagSCcXlWEON9nl5-kyXtfxZ5Fb7lISO4HYS1QxKTI6foueykYuw-Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:b42RaPoPC6fupZEIgmNEIxVF7eL9xOUfM8XYJ65I9NPAyLqLG20avQ>
    <xmx:b42RaEhzWwTQc9bKi9PUzAQci1KJ8NvHLBWNdHsK9cAYcRzr9tUwMg>
    <xmx:b42RaECGER7ny-pRLIV_P5Oj2-yS_2HqAnB4_yV2kvuD_x0tib3B7Q>
    <xmx:b42RaBG3_Tz4y4kMZCcXenWLWC1I7b71zuPkwT952AYVNbiFl0-cJA>
    <xmx:b42RaMosFA3akQKdiLMnRn5ewskz3geGPk_igUIY_wPAtzX8Wqzp81tI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 00:49:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3840afeb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 04:49:49 +0000 (UTC)
Date: Tue, 5 Aug 2025 06:49:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/stack: fix compiler warning due to missing
 braces
Message-ID: <aJGNaQwnd6_A0Ppw@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
 <20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
 <CAPig+cSeYUenjTm54higv6ANCOw0RJsF1hevS_p71=sH3c+E+Q@mail.gmail.com>
 <aJBNHzE3RQBZZTcU@pks.im>
 <xmqqwm7i527l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm7i527l.fsf@gitster.g>

On Mon, Aug 04, 2025 at 12:14:22PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Yeah, in general I'm also of the opinion that we shouldn't bother. But
> > in libgit2 we have pipelines that use such older compilers, and we don't
> > want to drop those for now. So I think we should treat the reftable
> > library specially, doubly so as this is the only instance that causes
> > problems.
> 
> Hmph.  Shouldn't there be some kind of "shim" layer where these
> things are defined per project convention and/or toolchain being
> used?  So when building for git proper, you'd use {0} just as
> everybody else do, but for others your include file supplied by that
> project would use something else (like {{0}} in this case)?  That
> kind of approach would be a better solution than open coding QSORT()
> in the longer term, for example.

We do have a shim layer, but I don't think it makes sense to use it for
every small piece. The intent of that layer is to paper over platform
differences that we cannot easily hide away in a generic fashion. So
things like mmap, random numbers, handling includes or registering
lockfiles via atexit(3p).

But I don't think it makes sense to use the shim layer for things like
`{0}` vs `{{0}}` or `QSORT()`. It doesn't really have any downside to
change to `{{0}}`, and the one invocation of `QSORT()` is trivial to
convert to qsort(3p) and unlikely to cause any more maintenance in the
long run than the invocation of `QSORT()` would.

On the other hand, it does have a downside if we moved all of this into
the shim layer, because now every user of the reftable library will have
to reinvent the wheel. The other downside is that the more we move into
the shim layer, the more the different implementations of the reftable
backend may diverge in behaviour. Reversely, the more code is the exact
same across implementations the more we can benefit from the tests that
those other implementations use and the more solid the reftable library
becomes.

Patrick
