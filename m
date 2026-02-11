Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A1286A7
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812323; cv=none; b=FBFTZJQL6wgdnSt64nv4eE1pSS6pv7AV5QH7I0yzxrRkTDOGMt0sL6TugktrMQx9xyONguotP/EHWIgJhIkdfAosyq/VGdJfotiaWulQyqiX6eak7YGssMq/nnPiCQCeGC82oiaWxU9D1urhynwrHFnUOTiL1a+ystcJwu7YA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812323; c=relaxed/simple;
	bh=Li0aPw3O3WNvMR8JOMA3Ak/WgBmuznR2Zpn3UMCkX+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fdevvgf1oarB6n8Oak6BYmyDFBAIsQaHg17aQdrhhzOQkzcLQpxY2FpbTX3GuQ2qZhHJLftQjzM31rHnSdTiJJGP76GqI82w4IlqdKjT5Q3/HWrRxu44uAoI8WdR8C9oaIuhyk/n5n4K6eK3Um0FbOuF8RV8A9uphzkUAGhH/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WjjFu+Sy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kksde5Iw; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WjjFu+Sy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kksde5Iw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 44C831D00173;
	Wed, 11 Feb 2026 07:18:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 07:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770812321;
	 x=1770898721; bh=4u49LZH3WNHfRU89rUHNWmovXszjuutPmx/Gyc90PKg=; b=
	WjjFu+Syy6Vyy3Q1IIaUlWUqALGjoVCJ7NI4YRVkhToc1EAks2h3DP9lFZdE4Gwq
	hw/vfRUDd8g2AgLHIPujCU4gp7ohHkAviBxiZFMo7m0VqYZ3m3rWRgaKMd7BKOre
	zfXWWNSFRJzwB1YpFnCEJ+nOQO3g/C7aBstmixGglUDrY73dAj3mflJEfemQquug
	ceuE59aCZ8YmlJ2efbVRx7DDvmD8l+356pkewKYCWT5XJfidEEGBilVny6li4uBq
	RKP9DuDL90/4DT69NsJ8WLaeiYcwhrPmMDOnNSDJdPG2CtW4OisxxbjHh5tz5eD+
	UxG9ot3tmD/e0HvE/OvRZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770812321; x=
	1770898721; bh=4u49LZH3WNHfRU89rUHNWmovXszjuutPmx/Gyc90PKg=; b=K
	ksde5IwQvb94UX28s+Og7QtbPQ6mYxqpJd0y+sG6xDtb+Za8uftm+Hf8mE4whPiS
	W+NIsyTGXgjV9YUrIzrv6fc34bvATcB/JzO1UfhewU7VrF/FWSNJVfiGdlHtm7uz
	9+w8LD/FD37hYfzyoXlyAqp8hu4qhsMn/oKwK/QZm7cV1wdjTFZny2no0n+iEfNC
	F2P5BYAq0C/EfFg6B0I+0vXSCfFSkRruycbBuOY1zpCI7t9faWDXZeMTaSWz9gj7
	h3ZYvscRTzCOqPYWaDFpkxSMNnZ7jqWuwEnBMERD/NORhfvBox+h+oNS3J7jSDnL
	7H1midoe1XNfb9/9lrrDw==
X-ME-Sender: <xms:oXOMaTzsGlRETvrAo_thPqJQw3GJNqdNzGC5DLQT-53USe8reCqa8A>
    <xme:oXOMae--dcazL6YxRaTI1tRRoXH9zz4wMtT6Ex7AQgrWlvFe4gnp7MvLHfB1yyWBD
    sSHOJIxdihAciAs7uDPcRFKDzdih4dYo8686S5vM-Xa7QGEbw>
X-ME-Received: <xmr:oXOMaXJgxNh4REk_ViLxjInYMTvS47K6vjT8XbxNez4y4HzlP1u-bVHqwl6Dtn_8N89xYrm4dwkt_yo5KJkUEzOTW7YsD8QWaomCiqbAs1I3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeduteehffeguedtfeevgfethefhgeevfffftdevieffjeelueetkeetueejgeekveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpuhhshhhkrghrkhhumhgrrhhsihhnghhhudeljedtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkrghrthhhihhknhgrhigrkhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:oXOMaUfsSGMhWOrICLDLSHbvaS3bPOdHAkdR470BMyXCWAI2nXKHLQ>
    <xmx:oXOMaW8zPpTwoYpcsdnMOMrWPWN_M-rn57WoX9w_4sNqXTYjSQoelg>
    <xmx:oXOMaRq_NTyUG9RHZgDJ_7XFOfXEmqlphnAe-GLCdBQid3jREy0Blg>
    <xmx:oXOMabAwlLIYLGGGiTFGBhbckz3tRmSybK_L8ybfPhCr8xetpNDl6A>
    <xmx:oXOMaXj_iWbXPpXSHsGRJFGCFxpLyl0NIZYH6o1sYAgrPHtKGYyw4I0K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 07:18:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 91c8b3c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 12:18:38 +0000 (UTC)
Date: Wed, 11 Feb 2026 13:18:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthiknayak@gmail.com>, Jeff King <peff@peff.net>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [RFC] git repo info: exposing repository paths
Message-ID: <aYxzmjoxQHccqTAl@pks.im>
References: <CALE2CrTt_2-9C4zCrZPBabtsWY=+Mk-bH4Jaemk=yHtfpoLjfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALE2CrTt_2-9C4zCrZPBabtsWY=+Mk-bH4Jaemk=yHtfpoLjfg@mail.gmail.com>

Hi,

On Tue, Feb 10, 2026 at 07:41:29PM +0530, Pushkar Singh wrote:
> Hi all,
> 
> I’ve been looking at the "git repo" command recently, mostly comparing
> "git repo info" with what I usually reach for via "git rev-parse".
> 
> One thing I noticed is that git repo info currently reports repository
> properties like layout and formats, but none of the repository paths
> that scripts often need.
> 
> For example, as of now:
> 
> git rev-parse --git-dir
> git rev-parse --common-dir
> git rev-parse --git-path hooks
> 
> are commonly used by scripts and tooling to figure out where things
> actually live on disk.
> 
> I wanted to ask whether it would make sense for git repo info to
> eventually expose some of these as structured keys, starting with
> something minimal like "git-dir".

Yes! git-rev-parse(1) has been growing functionality over time that
simply doesn't have anything to do with revisions, so I think it's good
to give such functionality a new home in git-repo(1). This has been kind
of the original idea behind this command.

> My idea is not to completely replace rev-parse, but to let "git repo
> info" act as a more discoverable, descriptive interface for repository
> metadata, including paths, where appropriate.
> 
> One question I am unsure about is whether such paths should be
> reported as absolute or relative (for example, relative to the working
> tree or invocation directory), and whether git-dir would be a
> reasonable first step before considering others.

I know that Lucas had a bunch of thoughts around this. If I remember
correctly, he wanted to add logic that basically allows the caller to
choose whether the paths should be resolved to an absolute path or not.
I've Cc'd him.

Thanks!

Patrick
