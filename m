Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E6615CD74
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748845213; cv=none; b=J5G/uhPH87mGyaPgAiDuU+KK7V+8HWREPmdayr55e/4ELc4SC9YtFDDNYWhfD7xNHpiPLvbQJ67mVwxt8HG7zJDHPKU+Pg8PeWuWCqF4emN+lMXkAX+3TbE3UhdSHUhSniymdCoGN3UI3dEdbY/kOzJ4QVaiTY13usHrwKuaex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748845213; c=relaxed/simple;
	bh=8TWiJAa/WhTZou1n6NEQWuxUh0052yOpp+bz3I/KUUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYbXLXeJ+J3OCCgxaVXvwm/6atNyM3USIbst0Go47yszIm8nzpb6TMiin+wr0CkOyUFeQrra4jjw/+3s6fLkd9Ov3dbQ8s3bBtu2NbwRVStgKa3BMjnlu7dqLfq20H18pzoOgtm8U+gjHEytsDMZ+UWHutFlMwWiWSRWpQ6PEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DgXWv2+4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQVjzmxI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DgXWv2+4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQVjzmxI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 059D8254014C;
	Mon,  2 Jun 2025 02:20:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Jun 2025 02:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748845208;
	 x=1748931608; bh=pCDXnb55nbpVb+OQxFbNBmQIq2oH2L8CjS9XDhPs0F4=; b=
	DgXWv2+4JbjgfGOng53qMCi26JQnlEBaYCXCzlUVb8gMt0EqR/hchLKQIdKRjbFB
	gPMQu9ooghvs9M1eB71Y95RI3DG+0PKsfHaw3lc7QB6dxIpncUdpu4YPvkBsY/HC
	yIAKC+fC7U4PzGLhGBy1egsHT4M0QlhYJ2x9TS8X7u4/C58Tqb2TEVvh3qBiRK6C
	oJjKrm1DEUA7WaCxg26oAGKUflwq0eJz7qV2YLQ4clfwOK6r+sQsDqxVMdzkIWlH
	CtbqiR1Pn9YHGT6Lj6HHoOxISCWkghFuD4OZq8lxeQrfamK65qPh6aXSWP3NaO5s
	f9zQWzqwTHnywPmGUWZNvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748845208; x=
	1748931608; bh=pCDXnb55nbpVb+OQxFbNBmQIq2oH2L8CjS9XDhPs0F4=; b=n
	QVjzmxID7M7MbsNio3tXPK8JBnh/GQ7U7+HZhnnd9T6jaMrVxORc9UjWP3MI9ELy
	MJmKDwbn3efyuW3utkYAwAHKxg74MtjT+EgylgZjDOixDZBbg6esg1b15QH0ucso
	22DD+7NToLCDORGZFSuRRDgDGDA7NnTnVwxciz2Stj6q1cCQkZMI3Sr9gUQQD6dv
	6fb1Pi5UYhuSqo8Np+OF0w4Ag7pCt69jtmWhGdJA2OLoIA0Iif3vsvc9RomN+P2c
	VvbPhIQaHB16yWPd75820cQl8DS0Ex407/XnmjzsW1wU/+fjHuByQy2LeSImqHEc
	x0xwysf0eQxEZa5e6Tefg==
X-ME-Sender: <xms:l0I9aL7eDlFuJd8wWgATFMkFNS1cu3nqYtqZ1HH9uvWpadOKpchMoQ>
    <xme:l0I9aA6nkULue5ppQq7IadlT7yD4uG0w90oEFb1p0XpPAlmZ0Ocy1l0SqW-SfJXbc
    leqyvuf98e6DEjQDQ>
X-ME-Received: <xmr:l0I9aCcNY1Anhk3L03F9uX7BE2kdN1Um-HDDj667r2L6FruUTeBzjTG6AGBkX4qnzi3RGtzTUbCMhFwUv9twn4XAG-FPBzchLiWjjF_jZpwS2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhr
    tghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghh
    figrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:l0I9aMIP1W7GWtamlT90S4IRoDyfwKsTwVvPHGepQSTvfqS77qLrLA>
    <xmx:l0I9aPLF-5vEuxgGxdB0jyRy3RjntgrnBWdpjtpBTO25pggE-qZGcw>
    <xmx:l0I9aFxQCXZ1D6Dt_mMeYwRJvlTube5sFfzQ7A6IxarY_3aa20TSeg>
    <xmx:l0I9aLJwl-_evp-9aVKptWFZLjQAWw9sejQx3SsGkBIdmt9-qUPxCA>
    <xmx:mEI9aAsbJwuQeqaieIYXNvEDzw5T8UU2REQ08oTVbJfGMkKiW9rnsUv3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:20:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c8a3301 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:20:04 +0000 (UTC)
Date: Mon, 2 Jun 2025 08:19:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 07/10] t7815: fix unexpectedly passing test on macOS
Message-ID: <aD1CjGra_GtUCjyU@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
 <20250530-pks-meson-tap-v3-7-676f5e41f2e4@pks.im>
 <7583b751-5380-41b8-8353-bba2618a0bad@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7583b751-5380-41b8-8353-bba2618a0bad@app.fastmail.com>

On Sun, Jun 01, 2025 at 11:19:21AM +0200, Kristoffer Haugsbakk wrote:
> On Fri, May 30, 2025, at 15:31, Patrick Steinhardt wrote:
> > It is unclear how long the test has been passing on macOS already.
> > 064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
> > 2025-04-17) mentions that the test started to pass for Cygwin once it
> > has imported a newer implementation of
> 
> “started to pass” followed by “has imported” doesn’t sound right.

Hm, why exactly is that? To me it reads perfectly fine, which might be
caused by me not being a native speaker. Anyway, reworded this to the
following:

    It is unclear how long the test has been passing on macOS already.
    064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
    2025-04-17) mentions that the test started to pass for Cygwin. This was
    attributed to a new implementation of regcomp(3p) and friends, which was
    inherited from FreeBSD. Given the BSD lineage of macOS it is feasible
    that it also inherited similar code eventually that made the test pass
    now.

Hope that works better. Thanks!

Patrick
