Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2936604B
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920919; cv=none; b=MeDI3w1buuLr9jrBz7E/FQ0LJ94msp3MfL+yKiyBt30cbCb0MSVQngXIJJUKVMJdKSG9pSPNDwc0bHjolgGTIMg7/SdXtk5Xd06BgsBi9gWgahl1xo0ajso14tgA+B/udvyIaACrs6ucU/Vf/X0k7Ok0sDBVpWwwtu3Wc648Htc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920919; c=relaxed/simple;
	bh=HRlu0ZcjMJxlg/XAoVqdmwFW/NBvlvHHo0p9ltqWpgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC9n4BOWnR3bJzyK/JQ86CCnKARyspQcdUaHQHvgCmTkOxMtETM38v1RKngam32qMW+fpjjoYFUl/5XKjebNbOKe+Via3/hMWXzFXZhwD05SDrAZ3vPe2UFojb6ArHRG5EA+iXD4QY9GYUAfwFWFlEQyS1bt7hMVcVKbQB2Smjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b0yqJ0Ri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ppfj0GSz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b0yqJ0Ri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ppfj0GSz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 94CE0EC0547;
	Tue, 24 Feb 2026 03:15:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 03:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771920917; x=1772007317; bh=1lTd/u+7r4
	krUby2z8064Tf8TvbwtwJPYGH6j9AAN/0=; b=b0yqJ0RitwL0oVFzb47P6rXfG/
	6/cG4yRwaVgAJ3PPlpNYeYzJ4whcRiQ6B27TjPfrI9521ri2ukhyr5SQgIqP9jB/
	+xfz1DXMcsIWDNMxuRDqnz8BvIE01NNEOLiQmZtmOaAEXKWE7SWDBIfcHVwMDwKB
	VM2KZnUql5/Yh2esz2w7Ay6nB3mGA/4uQ47OASdF6wEDQZgmUtNibhIWTL6uw/YG
	g71IKH6AMvsHhgb/jb57oC7HtPT8EjSM0c1R9+7xoCtEcSdfGKADZ5GAHtDr7oXN
	+4u1/DeRIT0jzDxhDWeYbv0KMRGFbls8ARqZSZCRi4dN/fPLtvOp16fCXN3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771920917; x=1772007317; bh=1lTd/u+7r4krUby2z8064Tf8TvbwtwJPYGH
	6j9AAN/0=; b=Ppfj0GSz4ootJW2q808l1WEcK5n6lsBxa7hsoi0CJLH0bmysDTF
	RJfUhV0PFIotsBpYxwRTF4+r/tcMaU5H2syWu450COxMNuL2slw0DGTfeywq8ocs
	4CIUBOIaNw62a6bezaKE2AHb5W68oSjEyQw4qk+Rzxfd2y89JngIwrk3a7JUaANh
	TDEicRD7Vp0rGOo6rzKd2tGh0MSvpE0+NoJgIqAsS9CDiZ84RrTF7wlp9xeqWJ+2
	Kj1CjYItpABOp/Q/d1miAKj9ZZEcQkZy5oJ1t6t+raHpGlgG0IJ2aQbTNf+PuYcT
	VRL36xrO5Bp/gDeoJbJq8FleBGjo0R1FBxQ==
X-ME-Sender: <xms:FV6daSZY2wAK5Pe-jhoEPqciANZCErJRpcZXaymjGvXca9SRrRPy1g>
    <xme:FV6dacZszQgeVGPlMynqPbNIIvMTAfV-HSvl0-XohQwMZJ4c63hvx2FJpw5X7BfsW
    cNrXFJmp4fTMaJRw0bzAQYIlLiMY629yiaZSi30Ts2wlSde8mOzpQ>
X-ME-Received: <xmr:FV6daR9Co7cRqx7a6frZvLeVKEYlHCjNrUNmvJJG0qI7WZE0gSfnx7hRjeb_uMNytzKlYUuPFSfZSXo3eyWPoG8MCMd4wX5EDcl3BmrhQARkwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FV6daTgPn42REjcoXCFUDGdQ-jOIXBx1hfyEdSlxXZTl7SlNFgc0-w>
    <xmx:FV6daZcAR3kOf3Cb8_kqV0F5iUntGvMqJ_oBNb4EZ8uvDFGN-W2TVg>
    <xmx:FV6daSo4jTm7hKenDhhi00QTQJW_32hiEGp21o7LSt_4FkmwzE2Mcw>
    <xmx:FV6daWC5ORzNyKaw34Wptyu6HCU_F0nanLOiUfd0Sux74yV9-eUEpw>
    <xmx:FV6daTNfCFf9dk9njENvmBlLkniJQiDuEYW2EB7xi0P8EQZ87T3sehde>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:15:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3c923bee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:15:14 +0000 (UTC)
Date: Tue, 24 Feb 2026 09:15:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 8/8] builtin/maintenance: use "geometric" strategy by
 default
Message-ID: <aZ1eENpDpagp77dN@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-8-faeb321ad13b@pks.im>
 <aZyAOsRX5484naIU@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZyAOsRX5484naIU@denethor>

On Mon, Feb 23, 2026 at 10:48:59AM -0600, Justin Tobler wrote:
> On 26/02/20 11:15AM, Patrick Steinhardt wrote:
> > The git-gc(1) command has been introduced in the early days of Git in
> > 30f610b7b0 (Create 'git gc' to perform common maintenance operations.,
> > 2006-12-27) as the main repository maintenance utility. And while the
> > tool has of course evolved since then to cover new parts, the basic
> > strategy it uses has never really changed much.
> > 
> > It is safe to say that since 2006 the Git ecosystem has changed quite a
> > bit. Repositories tend to be much larger nowadays than they have been
> > almost 20 years ago, and large parts of the industry went crazy for
> > monorepos (for various wildly different definitions of "monorepo"). So
> > the maintenance strategy we used back then may not be the best fit
> > nowadays anymore.
> > 
> > Arguably, most of the maintenance tasks that git-gc(1) does are still
> > perfectly fine today: repacking references, expiring various data
> > structures and things like tend to not cause huge problems. But the big
> > exception is the way we repack objects.
> > 
> > git-gc(1) by default uses a split strategy: it performs incremental
> > repacks by default, and then whenever we have too many packs we perform
> > a large all-into-one repack. This all-into-one repack is what is causing
> > problems nowadays, as it is an operation that is quite expensive. While
> > it is wasteful in small- and medium-sized repositories, in large repos
> > it may even be prohibitively expensive.
> > 
> > We have eventually introduced git-maintenance(1) that was slated as a
> > replacement for git-gc(1). In contrast to git-gc(1), it was much more
> > flexible as it is structured around configurable tasks and strategies.
> > And while it knows about the "incremental" strategy that we may use for
> > scheduled maintenance when configured via Scalar, its default still is
> > to use git-gc(1) in the background.
> 
> I'm a tad bit confused here. git-gc(1) by default uses an
> "incremental/all-into-one" strategy and it is my understanding that this
> is what git-maintenance(1) is currently using. Is there also another
> "incremental" strategy for git-maintenance(1)?

There are three strategies right now:

  - "gc", which is the current default strategy that uses git-gc(1) to
    perform the incremental packs followed by the all-into-one repacks.

  - "incremental", which is set up by `git maintenance start`. This
    strategy never performs the all-into-one repacks, and it instead
    creates packs of a fixed upper size.

  - "geometric", which is the strategy that'll become the new default.

I'll try to clarify this a bit.

Patrick
