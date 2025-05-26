Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5B192D87
	for <git@vger.kernel.org>; Mon, 26 May 2025 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748263482; cv=none; b=MGOwQrTbDWefi2+Fz+K1aeO/TfdP7BGl+y6s5b8tb81iuE1RtaZvtgMZVLeR6AxyQPpnDuUms3B1enRevYifxUw6fQ/1NMVo+ekJWoWNTRM1suJkp+0ulgMYcM+Bz1OPwmLCWF1RsO56UGZlzdUtR6xcm9HVWdmXuCoBQ+/a+n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748263482; c=relaxed/simple;
	bh=nf7lwgtPtIxNY0mRvNc/VIMryqfI1JSxVnumdMG41qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCIp8FHA3iJGJFFP3fdkApOi87quN3GkEqFHm8m1XgjUkOu/XWQ1XnPrVugw7tqRQI5mHs7lf8OwBs92vwTjqgmvE1MPAO58BIo8j2czXZJsOLCVqdxerfd2W4GBEyZDqJDzJ2oiFyv4+H0EXOK9Iwu0+3UiTAr/XQ7IFuqQfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dRDyvYQT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LX8c2j8v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dRDyvYQT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LX8c2j8v"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FA601380659;
	Mon, 26 May 2025 08:44:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 26 May 2025 08:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748263478; x=1748349878; bh=cN961JcUxd
	H8lHssHZ5Oa6uLhmDjjgcn8D655Sa/MEk=; b=dRDyvYQTxaRvwaWBfdhiRxd7ti
	aBpKihpNBUivTxJLbcNgYqfwd/BDV0BspLX2sR/QRBtk9UCGYox9RBekTqtsAsfr
	/r9799U44sDw0x1xS3+Gam4O9IkAFtnAyqbglouSn7L2XpjOFraFm3WcQZfuJbUS
	J7cKhwaYnu+BMxcT+QAiqrt1zub+fe0kgmPIJlqW27q09+IHZmC9Ql7P1x5mhci7
	qycR72X6cHYXhNsRKM7+vmGOS1YkANP5V5K5EH5m1fFTw+Xh0c6HSfDExgesw1AS
	caapIPxGXAhKn4CSckcMPDVIw+aq4ZTg7rSiPma8LQVEh3JSV/ClwxUZUt9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748263478; x=1748349878; bh=cN961JcUxdH8lHssHZ5Oa6uLhmDjjgcn8D6
	55Sa/MEk=; b=LX8c2j8vUzRvYgCvKa3XLPIHN8V/6XLmdIfG89PmNak9LNPbmYY
	P6VVPF105FlsktVJSul9jcEQTMu0hYD1VSWdz9M5CJzmSDisH5s5e4mH74/snG9A
	IilXDqwKj0Gia7G3HUzN6Rj1lDRTJHlbqaVXD5NZhgXIJLBMWS6UigZjipwr80NW
	OWnQiPq+H2lBT3YUGe2BHiPKtaOHSf2jYCDxx2LNul5B0WPHc460cQNxMPVf1csF
	v9NydbxH2iU46X0AqF5rT4kxU98BNKOSw0bmgQJ8Iqnyt4XenIL0zwwNJRV0ZOnl
	P5TEeySXRSHSCL4waMsRPEwkZ1szRkKgnkA==
X-ME-Sender: <xms:NWI0aGc7HszbRuxSWUZVx7VvrNg6dx7VDPn1pNnfI-_lvo_l_d7DhA>
    <xme:NWI0aAPxJ28U5K0uyB36LJ-MGUNPnBFYRvOd_I9bHBTls6LCuoOkmTAkliuEy6DKW
    WBVCUamTv0YNfHSAQ>
X-ME-Received: <xmr:NWI0aHiorvb56qwLpyKqRD_y4d8cuTkGrsGr8rHpLp42qqc2ejZ9FEVAjXsrtgoe-AwRrnGPQBBP6iVShx6rp0cqSBEJtSFwb90vRy1YC3vKEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddujeehheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrh
    guthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeevffffgeeltddt
    iedtgfeuteettdehheehtddtvdekgeegleefkefgkefghfenucffohhmrghinhepthgvsh
    htrghnhihthhhinhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghs
    rdhplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NWI0aD_3PJfMt_uTHfjkpN2ili1L_dOYfd4E1T3kQUtDtDMmp6Kllw>
    <xmx:NWI0aCukb_eq4jpG_gTA9N8nGR6glwIy4_jbQo5buQHOi8nk2YrDmQ>
    <xmx:NWI0aKEkksoYyBPPEEfpxENGBv-NpiFRYMQqGhhnXfOplECDysTbUQ>
    <xmx:NWI0aBPQK2IVVMswhos0Fd-HWvaKLgYnf4LhdUbjdG84JrjozvsGcA>
    <xmx:NmI0aC3d_9lWlz-A2upNEl-oaCVMBPLkVaXEWmYI3xGJGVAQM86_3Or2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 08:44:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d37347f1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 12:44:34 +0000 (UTC)
Date: Mon, 26 May 2025 14:44:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
Message-ID: <aDRiLdUCEVQHq26z@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
 <aC2xp4Cdb0j6OX-G@pks.im>
 <xmqqcyc2aqy7.fsf@gitster.g>
 <xmqqfrgx8xkw.fsf@gitster.g>
 <aDBH7G-oKKxAXWBp@pks.im>
 <aDCNqRAoGygwnAbq@pks.im>
 <xmqqo6vjz5cn.fsf@gitster.g>
 <57de5690-f683-4e8c-a05d-a91198b352ca@ramsayjones.plus.com>
 <xmqqwma7w29o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwma7w29o.fsf@gitster.g>

On Fri, May 23, 2025 at 12:33:23PM -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > Question: should meson (or indeed prove) fail the test because of an
> > unexpected _pass_?
> 
> Yes, it is a very good question.  I do not mind if the answer is "it
> should, and the make and prove shouldn't let unexpected pass go
> unnoticed".  The difference between the build systems bothers me

Indeed, a good question. The TAP specification [1] has this to say:

    Should a todo test point begin succeeding, the harness may report it
    in some way that indicates that whatever was supposed to be done has
    been, and it should be promoted to a normal Test Point.

    Harnesses must not treat failing TODO test points as a test failure.

    Harneses should report TODO test points found as a list of items
    needing work, if that is appropriate for their use case.

So if my reading of this is correct then Meson isn't wrong in reporting
this as an error -- "in some way" basically gives it full permission to
do so. So this is plain old undefined behaviour we rely on :/

I don't think it's inherently a bad thing to fail on unexpected passes.
After all, it shows that our assumption that the test fails is broken,
and that we should have a look why that is. But I can see arguments both
ways.

The pragmatic solution would be to just fix the unexpected pass and then
proceed with wiring up TAP support.

Patrick

https://testanything.org/tap-version-14-specification.html
