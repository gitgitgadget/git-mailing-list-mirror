Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D12FCC19
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902007; cv=none; b=F3bR83TQpKQEfP8a97gNep2r9piLNP70MqgAoCBw+zbOERjIk7IGedb1Aq27A4YKJ39txX407fEwrqDnXIJ6Km0hkcA7ZezHND9M6Nfr17j1y/y33+8Mdc6RGRGxsZinsRG9teqbwhOvim5xbGqC/FqCho28+U/FNvz7w6Gel9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902007; c=relaxed/simple;
	bh=s824w9OLK9zIgEz3qrQklsMoyA7DiYh8NV8cTJxyjkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3W8kK+XnPBsJbdcVqZ3myJDVNkwdQ4zY70dcYaa2vl5f6IMKrVM8f9XI65N8eyM/h4uP0W9qtak3uuRSjld6rF8InBNsuscGvFCQzf59/IHuD3p5mzWeD+bYMmPWWNzQv+16TchUZ7OkpUKI1ANSSa5sVVoDnzhWl+s+aW4q+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WPiNQ2Tp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SAmRsgi3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WPiNQ2Tp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAmRsgi3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 8943EEC0379;
	Wed,  3 Sep 2025 08:20:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 03 Sep 2025 08:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756902005;
	 x=1756988405; bh=1kwPlGnkcF4kF9D2rwackAP3RWHrl1lgwsPXNnLq2mY=; b=
	WPiNQ2TpKhUm8j9NyCeeDw56FlzIkez7jBHm6KHZBqNs+NjdbVgXCWhe8j4OeYhp
	u5p3F8D3laeJlGp8BUqK2p26hIBwuiDoQXPOUOFQ4MQwBUCTfx6sWdCS62UcCcnw
	6+6sONngziCYxoTYt0aXjkjkebvODaGJP9M4RFUu5zsbd9nhJbwIAhmf4+BEMEJc
	I0FZZKLgXqh/PaqHcolliSuWzV0+pbV/buO38JjNt+a9Zge7jUEcYJGMby6lVUpY
	HYEdZBiffmLoceZJ46F03MQtFxG10XI/n3yy23khR3XSqKDQeFwz7SiOvL4hTDOY
	dDjG5NXNIdUcQEzSkGDpvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756902005; x=
	1756988405; bh=1kwPlGnkcF4kF9D2rwackAP3RWHrl1lgwsPXNnLq2mY=; b=S
	AmRsgi38AEHPXX2J6wezT+S+yDym2wuYJ42AIiHedzyKQ1JvaWozU+yC4bADLXOX
	hDphCUmFb3FoRIvQMX45eKCCEl2spetkYGzZIC7xQ3P6S/092Ykto8k1c20xojwJ
	pnUTumW0kCsnLyhtApk01L5EKyPkbm3Gj4JExG4NiUMZxwO9m1uyq6+2kUUrAq7v
	thtxOVw+lPMaWdCo3TmJUBtklkID8fcdLGjPNazOw8mKEm9fC0DJ3iUUOzyGfeKb
	0TLv7YFuDDcwMV/1o4/B8iFvClrlcfa8IgQt6rzxj0xa5J5lZTY+sSRQQJSkwP3j
	jfuQpxC9vD/LB2eIoVHaQ==
X-ME-Sender: <xms:dTK4aKeGH88hsRuKjE8dLIO0811Xrqo-th9SwhIqiU-4-CL2FmGhUw>
    <xme:dTK4aBw7nmIxddIst47HDbshtCmxoCIbkyOJjh6L2YWVQEogdtgatoezLEZWAgKxy
    y_CNDihvSH-9UNfmw>
X-ME-Received: <xmr:dTK4aB_B-XqLrUC1saCM59PGzaKT5ubwWz5AbgKD5F9_z03a91Rs_io7N5eiPcA5uEyxfxdsEgRUBwJc1HZjMCpX9vJ8eyOHAHLNYo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:dTK4aJjoIfIEI4nPwqROaTRHfCNDVug8Yc39qHRw9lDcZnIyGCNSLg>
    <xmx:dTK4aIH41R3NOYKnMpoKwqibXBESLsr-GfCQlAQf3UVkrYKSlMsoYw>
    <xmx:dTK4aI8QJVpHvBZLeB5gPyUYf085LKB4WescJh33y5W1Mu6yxl1k1A>
    <xmx:dTK4aPyB5YJSLBLjXso-2ts576EpMAPOs0tFaN56LMuBhfYnt7e6vw>
    <xmx:dTK4aPp5tejN_VF44UxWXttX9caRHM57jGSCCJj-ZQ41AvXu083R674Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 08:20:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2c36f5d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 12:20:03 +0000 (UTC)
Date: Wed, 3 Sep 2025 14:20:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split"
 subcommand
Message-ID: <aLgycInNfe44RmgR@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
 <602e215c-be91-458e-9961-c78cf6aed2a9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <602e215c-be91-458e-9961-c78cf6aed2a9@app.fastmail.com>

On Sun, Aug 24, 2025 at 08:03:18PM +0200, Kristoffer Haugsbakk wrote:
> On Sun, Aug 24, 2025, at 19:42, Patrick Steinhardt wrote:
> > This is quite complex, and overall I would claim that most people who
> > are not experts in Git would struggle with this flow.
> >
> > Introduce a new "split" subcommand for git-history(1) to make this way
> > easier. All the user needs to do is to say `git history split $COMMIT`.
> > From hereon, Git asks the user which parts of the commit shall be moved
> > out into a separate commit and, once done, asks the user for the commit
> > message. Git then creates that split-out commit and applies the original
> > commit on top of it.
> 
> The interactive mode here seems just-right.
> 
> • Split in two, give the commit message for the new one
> • I can use `git history split :/'The second batch'` if I want to split
>   a single commit multiple times
> • I can use `git history reword :/'The second batch'` if I want
>   to change the original commit message as well
> 
> But it’s interactive-only, correct?  Would it make sense for a stateful
> split session so that other tools could be used to split the patch?

Yeah, it's interactive-only. I see git-history(1) as part of porcelain
rather than plumbing, so this is kind of intentional. I also wouldn't
quite know how this would look like to have a split session.

But if anyone has an idea how such a stateful split session might look
like I don't see a strong reason to not add this in the future. For now
though my focus is to get a baseline going that helps the user to
perform common tasks easier as opposed to before.

Patrick
