Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47832235355
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043784; cv=none; b=mKffzddYw3PglQ/TaffeMkmu6vUgovSv8/WMIIDLhbfWBfxb4N6ws6ixGK/P5SMvJuiznkbkzjk4RjnNh5tR342W/dCP5HiqBjJmmygtv9Z8rUx49+X54rlHEEjVGlPQiYfU8g0vAnqnjb7dRMKQIz8imFJ6jyvx65UwAS3F7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043784; c=relaxed/simple;
	bh=s1G9ptVWJPu00+xYfurVbaJB+sI3RUiNOjfXcstkgiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7l/D9yXGulzOarMIcUHMjpEOkFpFnywGMf3dv9LW3vNMg2aJnhhW6zL1XdDbY/ZeAbPwnUfKmJTZyX0Ys1esUnX/eFNofizFukN+rtgVYcv+ynMvngq1Egb9qAmuMSFiFDP5s/9F0QoqSIFK2fwean6yCG7m1KzCTFh4sMqnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HOT21wEI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I9e6JSSg; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HOT21wEI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I9e6JSSg"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C7E21400189;
	Fri,  1 Aug 2025 06:23:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 06:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754043781;
	 x=1754130181; bh=GHb1/xgJOT4sseQ488vkHJk7/H1t2lOXIreQ1ggzf4Q=; b=
	HOT21wEIacVfEMySku0WSbiE7TZfDMpJ0hBP+8sMIfuX9wBSs7PnH/XJrLxn/9TV
	+UbQez1nyIJu/FFfkOajb0kdor/avKN31O9p6Yva3wXlLZfwAIrdadrj+cUqw0wm
	Epie3eo8X52aVqXnd4bi9wuJZK977SRGJdHTLEgF5l3FfibigH6kO2+1ARL9Mzim
	AbT8wwRNZK/8wG1ZVPsL2SK1/BvFsA7XqXgkJWIIT3R93EEWCqXnSEVl07KbJwgl
	ZnMsayQki0nVFbNluWyH91F7eWs6u9zHimtNwPmjXrMI0IAIKsPQZhExUZtlfm/h
	7kHeHRGSjhLGYZDJnpC52Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754043781; x=
	1754130181; bh=GHb1/xgJOT4sseQ488vkHJk7/H1t2lOXIreQ1ggzf4Q=; b=I
	9e6JSSgF2r0ePkFrzewabl5M0lYZQ/kjRlswSpOrTT67lbR+ckg+XVx29jBpgyZM
	W2F7FiZ12zXQny1YM6Ajm18Kg98HN4bWrF6zEwojVvdrTWoSaJ+h3N8dIf/LszgP
	80jskWG4O538N685hl1yemmQcNVmwv4FIXoFNJ1S7JWQYFikhIByaVpcY53OCzSo
	zSnCAObbKPMYPu+d1ua1j+0iZ2WWwlywmqBzorfUUGlUezBeGxJ62nEM3xDukkiZ
	suKvF+DL6Rb72Mu5yeO7HqbVNQeX3kXSEpSMH/KK2cAfmsJb+uuZ6jRx0Mw19xcL
	4Auw3ycnxLpTCY+0PlaWw==
X-ME-Sender: <xms:hJWMaEuGFqWiABq-WTokwoqNA4SP46mIcXApSERbO99WMEZJOF_XUg>
    <xme:hJWMaOVkgOXwFkqllst-KTBA-l3X5zRh6OzNUHFHRGT__9z0Fj3VdSey8sQWzCOea
    h4ghVvU45z49ESXEQ>
X-ME-Received: <xmr:hJWMaPho-biYKrrL0a5hu1Q2-zjSgbKNRRUVqOML1Tj8FchDLIyw0p30QCfTnjxarp6jbpqs91c8v3qBUGkiCVJu7XsCmZ0MSmfI2vXbL2KI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrh
    grsgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:hJWMaGqxoCz8Zvg0y4x6Ee9zoUeBoOTMwVTZkQtZBB4WPnzt830z8A>
    <xmx:hJWMaFF8KusS3OAdZWYY82pUQ5U6X6VPy_iowADPnD3uU1EPM6HVoA>
    <xmx:hJWMaL6weu4RN3ZZLkzMqVZlXC3IZtbiAV9q5l7ZgSG0b1yqoVpYow>
    <xmx:hJWMaNfb--8ls1I10_BwrwU_3sSEosLM7E0QqTes9XTG65Y3GuP6Pw>
    <xmx:hZWMaGssAvfmm3JEmcsWJw8jvf44SqMi1DCuPH228miF6XzcY1STEDA7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 06:22:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f690cd6a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 10:22:57 +0000 (UTC)
Date: Fri, 1 Aug 2025 12:22:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
Message-ID: <aIyVft9PdlorttzZ@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-2-toon@iotcl.com>
 <CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>

On Fri, Aug 01, 2025 at 12:18:39PM +0200, Christian Couder wrote:
> On Wed, Jul 30, 2025 at 7:55 PM Toon Claes <toon@iotcl.com> wrote:
> 
> > +[--] <path>...::
> > +       For each _<path>_ given, the commit which last modified it is returned.
> > +       Without an optional path parameter, all files and subdirectories
> > +       in path traversal the are included in the output.
> 
> s/the are included/are included/
> 
> > +static void last_modified_release(struct last_modified *lm)
> 
> I think these days we tend to name those functions using "clear"
> instead of "release"

It actually depends: if the structure can be immediately reused
afterwards without requiring another reinit it would be caller "clear"
indeed. On the other hand, if we only release memory it's "release".

I think this function here falls into the latter category, so it's
correctly named.

Patrick
