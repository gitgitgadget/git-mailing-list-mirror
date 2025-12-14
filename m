Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B9632
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 23:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765754402; cv=none; b=t+gniHseTchErA5lURkeQRF4h6UsNdGU2fSzK5/B3tdkYwZim69t97WAqHLQQU6oYO6Jnz7aj9sz2GX4yQWLRQwFfv9OD7wKPJlgz5nxOFn++DBA09OwUQpLY52nLriQvETeXiwKof1HiBN6tEKI3uA15S61wTo+hHC1qt2Qfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765754402; c=relaxed/simple;
	bh=I0JPGjN/q359r0xBFyBE/UaAgFZ5ehyz5nxtr/tuI60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UFhw0f75VY1+8liUO6eKeaXA4VBr60hAFdvSKP9B5I/Yf+ZXm187+Oe9h1RGknBsycMpvp+IC3IlHiItsclInJpYR6djbwZ4bvJghy0gILQOFLdsrz/vFJ56oYL/PhlYdB+o5OL9AaETn/n/eB9af2cv+lmeUZLIKc1YHxuxTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PQWefBbR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RbHfoc6k; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PQWefBbR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RbHfoc6k"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A7707A0074;
	Sun, 14 Dec 2025 18:19:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 14 Dec 2025 18:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765754399;
	 x=1765840799; bh=9ns8eJaC8O/WCjzXZwn/yPnIsHllD+6IhYR+iNJ7Caw=; b=
	PQWefBbRlVLkIb1DwKAypEBcf9GJwgtY7iwlnfKjw2gYwOPvDas7SadST9431+Yx
	052d+Fe7B3q4WeBmuuuw5PKX1Nq0yU5/cdWlDbCQHOJS5T9+RgUdE/osPsjM+L0h
	TuV0Ok6tuwTo1W/jjx7XPwPyM/4WBIx/HswFSkBnJHsxewqIh2x9N2B9w2aentK8
	PpFdLuPZ5qX3cCgzOu1m2w/6uj8w21B+6UHf4joidgWrulI7mPJlZeyBhDbuB0/3
	1oIrd2aQ9OLXja62hVpc94EBnUsGorwDZN4n1ITHHW9vaaTd39YmZYjailjO6iSo
	zPtWmdiJPpVkMTEyqKsXyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765754399; x=
	1765840799; bh=9ns8eJaC8O/WCjzXZwn/yPnIsHllD+6IhYR+iNJ7Caw=; b=R
	bHfoc6kQ4vrKAhvyv/TUFSIiufGdWKbftcGjcadnghlnLdGZGWwrrjZhYtP2iHl0
	WfxnL/Ydy7P1tnuJXtXW4S+SVYEubeTf/Y1xYqkDnQwDZLSuXS2qkVI9M8hUPdS+
	z+o3nF6bhmQ3EUd94m/H94RnMmXHDYvpZj87PKk+L+cBIRhHoxiHbeObbCzC60Vu
	7pxIawd2sGMwj6uaEzzwms97E6kH3C5qkW4A1T1bVZMeq5B843uLry7fDskidDGL
	1CVjBPXv53AR2odtHgCneEWrtRQ4VGEz+rNSohzES0awTeYmEbGLGF6x4Lm7GEka
	NyqycjSQwQNw6VFRYFBzA==
X-ME-Sender: <xms:H0Y_aWXRUMTWQq42fmbaUlTKBS8C--qUDtclEimg-kbPcp_52OUWZA>
    <xme:H0Y_aRrhDmByGdEttOYw9PbvnDc2M73uGd692FijasEkds8cLgRvBYwdM3KcIcM6-
    Ngwfn0AMKnEnEUKvPZN9UXJPa_Z7kfcTgWN77qkgpnestPUJxntdg>
X-ME-Received: <xmr:H0Y_aQnyF-jRQInyXgUGMrkjMAT2uxLqHzkxG49BPrF4wB4b_Q0MQEVSxHE2HXsiSjZkhih4Ypb8r5FwVr5dZavh2lnMLQXOwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefhedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepth
    gsohgvghhiseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopeihtg
    hhihhnrdhmrggtvhhimhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:H0Y_aZ1B27iGCL_LV2h3Yks4apIRwXCi7YRleVjzGhQj925m5kDNJQ>
    <xmx:H0Y_aVSMSH3xLxTCv1urJ91JqwIT-XEKbfpYlKq6VusVjIJH2ZBw-A>
    <xmx:H0Y_aaw1H5ynQyvDXVeFyj4Kc0aZ2gnA5GAOsN1fTqhSCYFl23n1rA>
    <xmx:H0Y_adCy1ah3gwm3otduAET0j_ZVh60heFIVCUvTbtFt0grwP60OVA>
    <xmx:H0Y_aaY36vOV5LhRRHJ8JIECkGcNafF5qRCxh_bWomTMMX2bCXbcXlkQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Dec 2025 18:19:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Git List
 <git@vger.kernel.org>,
  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,  "brian m
 . carlson"
 <sandals@crustytoothpaste.net>,  Koji Nakamaru <koji.nakamaru@gree.net>,
  Yee Cheng Chin <ychin.macvim@gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: add NO_HOMEBREW
In-Reply-To: <435e4190-6c46-4404-b769-234f704f608a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 14 Dec 2025 12:13:45 +0100")
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
	<fe00aa37-e929-4ca6-ac23-84a693a48bc6@web.de>
	<20251214064544.GA26358@tb-raspi4> <xmqqecoxa645.fsf@gitster.g>
	<435e4190-6c46-4404-b769-234f704f608a@web.de>
Date: Mon, 15 Dec 2025 08:19:57 +0900
Message-ID: <xmqq1pkwabxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Sounds useful, but before this can become a documented feature it
> deserves more research and refinement.  The current code uses what it
> can find in an ad-hoc manner, and the patches just extend this behavior
> to libiconv.  A user-settable HOMEBREW_PREFIX would require a more
> principled approach, so that overriding it affects the search for
> gettext and libiconv.

Oh, that is so true (but the specifics in macOS details is a bit
beyond my depth :/).

> I guess that would look like this in config.mak.uname:
>
> ifeq ($(uname_S),Darwin)
> ifeq ($(uname_M),arm64)
> 	HOMEBREW_PREFIX = /opt/homebrew
> else
> 	HOMEBREW_PREFIX = /usr/local
> endif
> 	USE_HOMEBREW_GETTEXT = IfAvailable
> 	USE_HOMEBREW_MSGFMT = IfAvailable
> 	USE_HOMEBREW_LIBICONV = IfAvailable
> endif
>
> ... and in Makefile:
>
> ifndef NO_HOMEBREW
> ifdef HOMEBREW_PREFIX
> ifdef USE_HOMEBREW_GETTEXT
> 	# magic!
> endif
> ifdef USE_HOMEBREW_MSGFMT
> 	# more magic!
> endif
> ifdef USE_HOMEBREW_LIBICONV
> ifeq ($(shell test -d $(HOMEBREW_PREFIX)/opt/libiconv && echo y),y)
> 	ICONVDIR ?= $(HOMEBREW_PREFIX)/opt/libiconv
> endif
> endif
> endif
>
> Perhaps the magic parts just need to check for the existence of
> $(HOMEBREW_PREFIX)/opt/gettext and use that, but the current code is
> more complicated for some reason.
>
> René
