Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF721F3D58
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341466; cv=none; b=k/cig/RCgNd0X9Qi547nE6CEMTalAmEhcc15Vbj2OX7333A5/6Xr3h/tC5H3uoG+zZlyLaJN5WikoR40TX0XRj0mkMN/pFGMw4xKLR/TyaUWVeGA1XkkpEI0txq4b9wmfHyTtjEq8e3WryOwgC74B83ZQOF07+lVDd+Gpp+4X+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341466; c=relaxed/simple;
	bh=mNCpnod4UyhJWKwvyW17DhGf1bdVpWbuUp75i2E2v/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JYV8vGF04hswTLyvZPR3xj4hWgxMwcHrxCRRsLqjIMO5pOFtPBQqILeH0V10Qu/KNQ+8yUV2qaBAPfyWnJ1pSBSjf5SdpC4yV6gMStYnDN/RMFMpaTea++Rc6/vVIW1nMyS+ta8t437SV0OMajvAUwcXs8UFvI8Y0vqxKGAIDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gkQiWZpy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QVtAwZS5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gkQiWZpy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QVtAwZS5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F1B81140124;
	Fri, 31 Jan 2025 11:37:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 31 Jan 2025 11:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738341463; x=1738427863; bh=hhLayRpCuA
	OKnGSskbGd4f/HqGN1yEYp/QY1rpy/OgU=; b=gkQiWZpykE3ePquV7Qey+2+KZ5
	97a3vHOTgG1cbcg5V69myEAvnTaI6T3NVpRVkHSLGXazcTCWqM/+Tsl82Z+z1dkM
	bwGCvsKDUXYoiJ6md0X4PurxQvdscmsKbm+MvcR51A9h0R/UzEiAQVNftdFLCj4F
	YDUJzPmtDB0Qh2wCkiKfXdxKaGJbtHUsWQtbZBk2/uqIrdcJ+wX8x7qZHbO7lUT9
	a06PVT1bgue1iOIyZ3d6A5moMOEQPDiygILpUQw26ZGhfqkXXCMBauOuXjxBrKM1
	m75QU5ZlPG0SjJI/6C+4uxfBMhR4XSznofmmFlQukO+eTGIW2I8wSY2JoTqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738341463; x=1738427863; bh=hhLayRpCuAOKnGSskbGd4f/HqGN1yEYp/QY
	1rpy/OgU=; b=QVtAwZS5zD+YEZzx9DQHx24puu8ZqRLqZHQgI5Chxwql29GnM52
	g5QWXA+dIg1mLf7Cy6nWZH2ZjUQVVPJyAOQSqtS5RTZg7Fl5sMscbZ9+qe9/1leO
	G9bz0CqY8ihYp8CvcPAfKzcP3Z2k2qXwSbUTxY6MmrZMW0AbvGrQeMy7uIDYUwPR
	xjHYIvrcrAGnXdpmA9c2I0TAWzMGI4VoLebhS0HL7nbIPWzXif773495b8FVAfdr
	zYg7bHssaJf8vsDvBtQZG2b2kPFRWAvIkiKRY6bXGZildfZbFNusVweb6KjCyXqf
	cihBXYaCDuyFHBpXBmzPRpMVvt0ft/hfxiQ==
X-ME-Sender: <xms:VvycZ7r6yavrxba1LvlVyD3taxvNXZ0b4Dm8TxyacFvTqp2nGhZCGg>
    <xme:VvycZ1r5sFOUVdkwnbPOzKynrzGAql3rfPO4EwZs1HYdYZkLwM2zLKj-GyQ8r6hbF
    Vgq4sFd6rCr59Gy3Q>
X-ME-Received: <xmr:VvycZ4NfuYQ8MKAxuhjsAi65bTKPMiL88YiLyPkgh5oFwPkERHZ8UVhU14C57bogAL6zh0oVi6pvoqaWjur8GNUG2GFnhknaXh_3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirg
    hnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhn
    higvmhhivddtvdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:VvycZ-7IZPrz7O3VlyGj_1wrU2UOFgSHzGtdUMAmZoaNGsEUByULlg>
    <xmx:VvycZ64lGwUbMgbaxywhCOQpL-2t5wT5c4jKw248T8yYKk5HLMZw7Q>
    <xmx:VvycZ2j7t7Hpq0YqqBWqiRpXsCqf1pTg6AXAhM4hlsjfpbB6w0-krg>
    <xmx:VvycZ84Ms10vRp7n-mHSD8HcRgMtv5NloduZ2JYQBoj7Pr8SeQVcIw>
    <xmx:V_ycZyi4Y7mPPLo26CDhVt9yjzVX5u8InrAqk2sLBOK5us9-M7mxICQl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 11:37:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,
  me@ttaylorr.com,  phillip.wood@dunelm.org.uk,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
In-Reply-To: <CAP8UFD1+Qa2cRkYs8R_Lgr8Bkz7YqPUW6Q3ogKcrBSp+q-3qbw@mail.gmail.com>
	(Christian Couder's message of "Fri, 31 Jan 2025 15:30:09 +0100")
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250124122217.250925-1-usmanakinyemi202@gmail.com>
	<xmqqed0sxdiz.fsf@gitster.g>
	<CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com>
	<xmqq5xm0wa5l.fsf@gitster.g>
	<CAP8UFD1+Qa2cRkYs8R_Lgr8Bkz7YqPUW6Q3ogKcrBSp+q-3qbw@mail.gmail.com>
Date: Fri, 31 Jan 2025 08:37:40 -0800
Message-ID: <xmqqzfj77xd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> By the way, if we put the OS information in the "agent" capability,
> how do we separate it from the existing "package/version" content and
> make it easy to parse?

Do NOT parse, period.

If three "things" that talk the Git protocol on the other end of the
connection gives "Linux git/2.48.0", and "macOS libgit2/1.9.0", and
"Windows git/2.47.1" as their (enhanced) "agent" strings, there is
no "ah, this one is 1.9.0 which way older than 2.47.1 so it must be
missing features X and Y" the users of the information are allowed
to infer.

Just take it as a single opaque string, and group identical ones.

In the above scenario, we found three different kinds now.  Maybe
we'll accumulate the counts and notice that there are N times as
many connections whose agent string begins with "Windows" as "Linux"
and "macOS" combined or something.  That would be an offline
analysis, and forcing users to do the stats offline would reduce the
temptation to use it for purposes other than its intended one.

You may find "ImNotTellingYou" and may wonder what OS the user is
really using, but they do not want to tell you, so you honor their
wish.

> I don't see a good solution because
> GIT_USER_AGENT could be used, and the config option to not show the OS
> name could be used too.

That is a good privacy measure.

> Also we don't know what could be in the "version" part. The doc says
> that the agent part is typically of the form "package/version" but
> doesn't require it.

Exactly.  I would think it is a feature, and the way to treat the
string in line with the philosophy behind that feature is to take it
as a single opaque thing.


