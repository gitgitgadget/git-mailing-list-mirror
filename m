Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AA224B06
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581930; cv=none; b=f68jKbiglW6+ZU8lBDmsbuSgLtnq6L/Lo0hsK+hNZjwpG2tyVR79I4SVwDenmpUk/4K/t6DUkPavKVjxzca1GSCG+KrYz3O3USJby/AWhj3IG3M+jv5rqJUSmQvaqo5fRTCoEgZ1Ovta9uzDJiYmbQCnT2QwivPoUv13BbgoXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581930; c=relaxed/simple;
	bh=SDx22qibWGFG4urIsGQPousp7OCs0QNcTOFj5tIW5R8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2Hbk8w/9MVJo0Io2/btJRoIa9u23Xd/fm0PUG4yrMASotOCMLkiBmxXsPP3A9hQMRr5/t0zAQsOnQc3nQNMRDk0eu2d6ZTIK3tbLztKVb7nOHjtDo//JxSYSS/PmtB/R5NClejQ+ERWxqLcSsgEZS7zBswKYUaR62ZycnI8HSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IVuUEsOO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bDEpJDQm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IVuUEsOO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDEpJDQm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CA0B11401FB;
	Fri, 25 Apr 2025 07:52:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 07:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745581926; x=1745668326; bh=f11pbTsgn6
	eZSLTCuKpxrbwLl5FolpOx+IVRfH96614=; b=IVuUEsOO5kIjExhXJQ+e+du+4L
	qgbPQq2jac0J3BGa3/oAOJUPqUq4c/KVp0rZoykkD5MNg2uZYZhtCNvMniGNDJap
	FkKQNaxWcFFK57rPXk5dRoyzETRCYYhOZLPPitRZ08Knu8+A2Hui4u8DFfys0lO+
	vqjjESzh8GXTnV/neCwFEhPmwAq4ludPluT8u6V6MKM3juV1uBSAVSu/JGqy/ArU
	SewWHAckfqS/6C4fXU6iqqdFJS5mRsagOy1JsDOjHVyAMXh2n6bML4Ynul6q9+Qr
	DI0sg9n8SAZsMA80gQzlBqxnTt18o2lyT27SPFpkqhDNr4AK335V8YcXfSuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745581926; x=1745668326; bh=f11pbTsgn6eZSLTCuKpxrbwLl5FolpOx+IV
	RfH96614=; b=bDEpJDQmdobMesT6lwazSB7ZEX4mWH/TiWMPm39YfePAjX7axtl
	hj/cBdkScXUHrrudrrDIxl07ifdP2P2gutG+HFtm1Y2omhIe3uJicgvFJWYebKat
	4Slxvf3b6DIeDc4V9GoYDCBBwCIZh74xqv5tylGw7uotTJ8mhQkDHqIF16pRgn81
	5hOm5qG/ogrPVumxD70wCUzsi5tGg+yCUksXkzgRTXCtj9caHgzBm7OEtQ9PX/tG
	s90HzbhtTM81cO1aoJs5rQ8HlvKScdi7hEMorxZ02ep65RRm069z/LNttdgVQxXl
	bV7BJRwNfGqtcNQNLrV7fjiZN9eClC99X1Q==
X-ME-Sender: <xms:ZXcLaCqCvVTkFiN3ti76-wps3Cv1f4xpkYTnpOP-Yl4XKZnaf28NKA>
    <xme:ZXcLaApEUArsIs6cNjn3BH3w_4rOErcE22PgqUhHa3Mqc6_YGNWNJ9pCuGqOmGtIP
    _7Ghc3mIVZY-INbKA>
X-ME-Received: <xmr:ZXcLaHNM5t2x5qHVAUlZ76EyJ-YkBJVz3fFPfI2YFhleXk9n5e58EJfEnySm_vvye898SgbhMB0LsNOUYEZVNJwJKT1RnjRtJZJpZl_y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejuefflefg
    gfehfeelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshdr
    rhgvphhorhhtsehgmhigrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZXcLaB5Lpdx6thVGxCmeVk9eUEMtT-I48LWwoIJeNqWjANsT1hKtAQ>
    <xmx:ZXcLaB60yfNQAgb0Q1zrlwXtQOzpxDE1irHcz0s1HpLslUb4h73-Tg>
    <xmx:ZXcLaBhBQ5VGP3CGxptLqjwdZk0o1GWPo9nxZhYdIi-EbBMR6oFZaA>
    <xmx:ZXcLaL7Y2z6GFlXRST_wTZBDjHi_kUb49i7Q96TeoQafCxLbFqvzXg>
    <xmx:ZncLaINf8wp2zC4fe8DfRH49urVrd7rDS-N2ew9N20aaGEf3AJw01UIE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 07:52:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd41f6c7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 11:52:02 +0000 (UTC)
Date: Fri, 25 Apr 2025 13:52:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Peter Seiderer <ps.report@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/2] meson: prefer POSIX-specified shell path
Message-ID: <aAt3Yc1NVZxsvSVX@pks.im>
References: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
 <20250425-pks-meson-posix-shell-v2-2-fddc6123511b@pks.im>
 <aAtopiMkJpF2RdjG@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAtopiMkJpF2RdjG@tapette.crustytoothpaste.net>

On Fri, Apr 25, 2025 at 10:49:10AM +0000, brian m. carlson wrote:
> On 2025-04-25 at 05:47:45, Patrick Steinhardt wrote:
> > Meson detects the path of the target shell via `find_program("sh")`,
> > which essentially does a lookup via `PATH`. This may easily lead to a
> > subtly-broken Git distribution when the build host has its shell in a
> > non-standard location that the target host doesn't know about.
> > 
> > Fix the issue by appending "/bin" to the custom program path, which
> > causes us to prefer "/bin/sh" over a `PATH` lookup. As this location is
> > specified by POSIX this should make us pick a better default shell path
> > on all POSIX-compliant systems.
> 
> Can you provide a citation for that?  I don't see that in the POSIX
> 1003.1-2024 directory structure document[0].  More specifically, I think
> there are some proprietary Unix systems where `/bin/sh` is the original
> Bourne shell and is not POSIX compliant and some other path is the
> POSIX-compliant `sh`.

Hrmpf, you're right. I feel like I relearn this piece of trivia every
couple years. POSIX is quite specific here:

    Applications should note that the standard PATH to the shell cannot
    be assumed to be either /bin/sh or /usr/bin/sh, and should be
    determined by interrogation of the PATH returned by getconf PATH ,
    ensuring that the returned pathname is an absolute pathname and not
    a shell built-in.

Anyway, given the following...

> I'll also point out that we require more than POSIX compliance in that
> we require `local`, so even if `/bin/sh` is POSIX compliant, that
> doesn't mean that it's suitable for Git.  `/bin/sh` meets our needs on
> all the Linux distros I'm aware of, plus the BSDs, but if it were AT&T
> ksh, that would not meet our needs since it doesn't support `local`,
> even though it's POSIX compliant.

... prefering "/bin/sh" is still the right thing to do as it tends to
work on most systems supported by us, even though it's non-POSIX. But in
any case, the commit message needs to be adjusted.

Thanks!

Patrick
