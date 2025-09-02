Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511C270572
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803042; cv=none; b=Yxp2Qx2VGRwXo6vv9XfT47QYz4EiHwXtOtE1EXwCaNP6zKPPPk4r6shW3QsWRPh/IscIB3DyN5c5zukFmJit3z2qZoSnfhRWOOGUn3sUI0tvHMoU01+vDew/Zh5FTnzi36+Fy5YTYuGdlOkwZEUZg/2T5i2SDFl/OyLnEOSVISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803042; c=relaxed/simple;
	bh=av5ndcztbMY7GjwTrExIDylwcXbYLYMNqzNSmAKzx2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVsaoHk3SUGu4nQIdYmGrbH4UzttdXQuvYPsEVbY0+GVH4LQtnC9zf6TDwhkF1ARlk3Hv4tqqTsxj9ZywMigHtw/NTWDiyHu21uW+QGOwGDY7Kl7cmh0NCj7BVMdniWBfDSwHQiVb8YqXpfCN4d7FY69KwoGPoUxhDOpAEc1pjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DVegJt4m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PlQKEweJ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DVegJt4m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PlQKEweJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 578ABEC0540;
	Tue,  2 Sep 2025 04:50:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 02 Sep 2025 04:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756803038; x=1756889438; bh=UP7hFXJS9X
	St5cXnYyFeKsANiD2CWws+/dJN7SnKG3s=; b=DVegJt4mUMR46M9s8OMz12TdvX
	j8waudOMeXyWfm7VYTzRgwTR5Nq22Cx52zug2UGskLHQ+6r0qd6q8Wil8wOoenZD
	JEbBK0zdHOsz48lwMXokgxTD7lStyFnFn1k74F7q0+E/5zYMbMZjzoxZhLdo5JAV
	YnA+DGcrmC1gcMxo2pBOY+XlZew0usKZLE0lwCGdOoB/hTcDtP1WdVTPnxiqQDYo
	FmYhtvzakwcYFu7iFxaXGr6Cyl6o/1g1v0znsZIsQAzegiJ8jgVPKmKHwOD/iqcl
	C/6zRMOokk4hSJHFHUjYoeu3FamluLQUe7eP62PSOqR3VXxFQDTbWKd0sang==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756803038; x=1756889438; bh=UP7hFXJS9XSt5cXnYyFeKsANiD2CWws+/dJ
	N7SnKG3s=; b=PlQKEweJUGhhIcbE21hBNMxyZU7Z79DQUzAOrc5ktd6a8NoRAAb
	roaC7QxFB67OapBBQWLOZU9QuWMxlJJnoLA/b4q3SMT0mJsNSc07aS+K13mqpKrH
	RnZ81XFGnoXjuJYrOBhROtQEhLJwSA7v1lA2um+9O+Miug/AqIDngEAtO0rMWNH1
	IFRtG7RAQdC5t30/mBAwfCpdrYyaQxqSHfNY0CAoeiDsEmRlhN0y02mWFS2GATiU
	7VNqnlRh20IGkOH8CsvGDHG5VYKhlv8YCpE9Amw8UjTRfXb/hfTp/ONpLx5kLU8t
	hIDBIrGVlfEQ5KU2YCbf9cEi9qn8oaxaQhQ==
X-ME-Sender: <xms:3q-2aIBHiGUWoHF_4_ZaD5uKgmgDZl9RMsU6_zUJBVtVK6f1lKL-_Q>
    <xme:3q-2aFF_LQOquLFxnA51jJ51L7BeR7Bh6IKEmKUXKbdNcT-CGatDyyLmY54CQfBys
    9FuoTw8WhNLs2YT8A>
X-ME-Received: <xmr:3q-2aIIJjrA8U27DAnh51cNteCQqIivA1Kf5T5bw7hp7HW131qtvozyoUJnmDTNumCG_BVfSISW2PJw1bM1mRQ3PFL3psy-dVWUPJZ_VVOzsXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3q-2aBkOHva6QSaAnGBhcCQwCWCqSzOpP0Mlyx6PLQvGJ5LZbZwFvw>
    <xmx:3q-2aITEGMeX6SYm3ee6g9MLldrVVQPe8Peox_9cRauiNK_enF1aww>
    <xmx:3q-2aLJXtS_BLyz_d20D0JenLMwY8cHZ7ot-KDm61pEjQshQzEwIOw>
    <xmx:3q-2aGApRYyQGqytfyHb2hjGfz76yen3H6Pxag3poJUhUGGRy4dY0Q>
    <xmx:3q-2aJatrpL0Aaqm88kanEyxj6LGNAvs20Z9eqBcjU4csTtC54LDbh8b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 04:50:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27b67a8f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 08:50:36 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:50:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/16] packfile: refactor `install_packed_git()` to
 work on packfile store
Message-ID: <aLav2QQgO8dRJWNY@pks.im>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-10-d10623355e9f@pks.im>
 <aK0X6FF/vX9kujFR@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK0X6FF/vX9kujFR@nand.local>

On Mon, Aug 25, 2025 at 10:11:52PM -0400, Taylor Blau wrote:
> On Thu, Aug 21, 2025 at 09:39:08AM +0200, Patrick Steinhardt wrote:
> > The `install_packed_git()` functions adds a packfile to a specific
> > object store. Refactor it to accept a packfile store instead of a
> > repository to clarify its scope.
> 
> All of the refactoring here looks straightforward and correct to me. I
> admit that I have a vague preference towards keeping the word "install"
> in the function name here, since it (to me) suggests that the packfile
> in question is going to be used for lookups, whereas "add" is a bit
> more generic.
> 
> I don't feel strongly about it, though, so if you have a preference
> towards "add" then I'm fine with that.

I think "install" would make sense if there was a mode where you can set
up a packfile via the store that is _inactive_, but that's not the case
anymore. It was before the changes to introduce the packfile store,
where "add" only instantiated the packfile whereas "install" added it to
the store. But that difference is basically going away now, so as soon
as you add a packfile to the store it immediately becomes active.

So I picked "add" because it's a bit shorter compared to "install", and
because from my point of view the previous distinction isn't necessary
anymore.

I'll keep this as-is for now, but same as you: I don't really feel all
that strongly about it.

Patrick
