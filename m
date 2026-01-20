Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCA299A82
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768888067; cv=none; b=GA2Y/bfGEFFQeU5mTQvo70Tu1fp07GLXkiP2pTPwuCtC3VQR7w+uL7wqvEtuhg/0+YU4LGdQMxFherS4Rd9oaRyXXCU+k4VJ7MhgEvrmfMwKtqHW7M5kZRgrCGg7axQaBaDd3ZtDUMW7bGiGQqfTQ7iBaxI2IvG4VtdLBV11BJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768888067; c=relaxed/simple;
	bh=dHmG43kmD+rC9wpHm/kgHS+vwivyxB/mSpZ+YjNo2T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gyqmf8cHz7xg5wITc+oAS1ylTYYFwTNhle0PXTsg/YkRYwApgKJJuegdaAi19dQMDDSvbJYmt1PDE+nZM2bgSY3wSjB4EyfqcqLbQ/ZIXKYR2TGOTDYYLwf/vgUWXr1vc3ghDwKaTocEc3EVuG6PHYmdBDopFKCZZlqEuz/ASGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wa1Um/qw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ieQkb/HU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wa1Um/qw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ieQkb/HU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 00C4C1D004EA;
	Tue, 20 Jan 2026 00:47:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 00:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768888063; x=1768974463; bh=a7uFqLJliI
	aeD1cxk7h55qjkqtQNcknWUmmPnw7evwo=; b=Wa1Um/qwQGwkzfHa2MkVfweaQO
	akavoFktVGRY2fR31cZBNFYaNSdxb25AkjXoD0PQFW8HPpqwdT2iNSuSgF7BN5cc
	NxbDuN2u6oPxzLHpAreT6Xo/GW5ijrmvNd2nQb3b2P59c565BfDyr4v98nOBiy1f
	29Q+CBhRcVYIJF1eZXT50heeTL9VXp9CW7XrJJTy8YMZk/mRts1JbRcBKTC2L3bf
	mV00s/7Y1epbuXQNp4F8wp1sgNFEE8sUx1UL807Gd81Zp6oBItjZIvzoOXyM+dER
	NAMFUUIDk2W/wnzPxdlMNFM+/SMn3bsKadpVSu4UE9DywAHQ7Ufnq+mJYDqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768888063; x=1768974463; bh=a7uFqLJliIaeD1cxk7h55qjkqtQNcknWUmm
	Pnw7evwo=; b=ieQkb/HUQy18lvob2T7ao16rj6t1ni06kZzKEGsvEzu0MpDfcpc
	2bVP1Fzp/NYp4f59TC6rMMTUAYqOAIYhziZao6x3xQLdf1m7WTGZdfEXCmrTJ+68
	1/2C/SGaS81EXR0xR9oz+xXjiup1KUH9GnT//BNj91FDCUvxVGY6vOYdLLv3LiY0
	3CByBpf/GBeTkcds1AWSGmShjXB+z16NI0BBcCoYFQQSL+kUZkyT+2oH63rOFP+F
	6q8W2xHpGTVpWNweoxlvP7eb106z0dHx+LUJuXP6FaoNY2gnto4lYO8dbrkCu9FX
	aeGM5B8KjFz4MBKshh2GJbLnXWyCj0+tcUw==
X-ME-Sender: <xms:_xZvaaJZwhoJvuTnpUZs70NzcjVWH3138zalhSzkW-rmZ0yHd9keXQ>
    <xme:_xZvaZJ2zoGkjw7RnwHcWbgP2jHZhlP1Piw4hUrh0KmBcyfTC-UbVJvBiI9CTiJa0
    B2Ur880WCBFVMTZpc2jhQj9Z-yojE7OuKO4xENkK24QD2wo-360FZQ>
X-ME-Received: <xmr:_xZvafu18Rt_TYv3spBjXuj0oxmfZxAWp3QD318fNgvI15xtwPrkyf-bahqcP50G-mt_CLI72LsEknxxP5IjCtP34PRmqMZWGH94PXRZpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeliedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopeiihhhi
    hihouhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:_xZvaeQL7lWtzX_w5cGzmDuS-GlF_lVLW3s1CzrsZuzntSNXC3uc8A>
    <xmx:_xZvadMde9Drj55nRTzjpwr94JUI_eHtvuauhwz9K9KGFOUy9UszFw>
    <xmx:_xZvabaSUSi76WR05WnP9GY7wE8NZ6Q0cVnI_12MbL7GWWp_t_zaIw>
    <xmx:_xZvafwOPhAwn60x8dFNLMEZqbgUnXXBzHdjzpiMli8aFBmnUW8BHA>
    <xmx:_xZvaYsHeYzKD2awl94ZDvHjYr2ugfSYQU8F_Lez8CXsseriSUtXrGLb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 00:47:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88ffb5fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 05:47:40 +0000 (UTC)
Date: Tue, 20 Jan 2026 06:47:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] help: report on whether or not gettext is enabled
Message-ID: <aW8W-SzorzDC8-rg@pks.im>
References: <f3500e698fd40297d2e2634785529b76d49ca470.1768530514.git.zhiyou.jx@alibaba-inc.com>
 <xmqqo6mta7bg.fsf@gitster.g>
 <aW3XUxaomqGbtpEj@pks.im>
 <xmqqsec13zsd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsec13zsd.fsf@gitster.g>

On Mon, Jan 19, 2026 at 04:15:14PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Combined with the vintage of Git binary that had these help text,
> >> the fact that an "enabled" line is missing is enough clue to
> >> diagnose.
> >> ...
> >
> > One reason why I personally prefer to have enabled/disabled is that it
> > allows you to discern the following two cases:
> >
> >   - You have a modern version of Git that doesn't have gettext.
> >
> >   - You have an old version of Git that doesn't know to print
> >     information about whether or not gettext is enabled.
> 
> When you see no "gettext:" line in the report, you can tell between
> the above two cases by looking at what the first entry in the same
> report "git version --build-options" produced, which is the Git
> version, can't you?

Fair, that's possible. It still feels roundabout though as now the user
also needs to know when this feature was implemented. That's why I lean
towards just adding the info in both enabled and disabled cases: it
gives you the information unconditionally. We don't really lose anything
on our side, and the end user has an easier job to figure out whether
the feature is enabled or not.

But as I said, I don't feel strongly enough about this to request any
changes.

Thanks!

Patrick
