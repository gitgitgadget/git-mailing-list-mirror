Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F70212B2B
	for <git@vger.kernel.org>; Tue, 13 May 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127178; cv=none; b=LAePSasszawmTfSNkNsCQmNi+nUQV5KpOoh+Kyn504WcpbLfD+8d2JUcGrPx2+KfKsKaESE7VXYCYc1knCIZt/668NjZZdb3IjshN7J55eVgPqMSS2xd+VigKpxcwYw6DGmBEfLIPL402gT/NmzeKmsn2sAUfZRZjsjsnL3TUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127178; c=relaxed/simple;
	bh=sTjJVthAeY5vGFWY2Z6M0IJNEje6wWBvEhJyaLde7yI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1bXc166Y+eRzVqQ7v2T3IOIT6W4Rj9rLo75Wli3iRGw9jAjB/KjQhT+wfHtjxOjKbgM0PAaOXNmJWtqWJwz2X10anQVw6JjykatI4Q9QdTerOn5Zm6h5X95/LGLNSxL+WJ4ZMlNft6Pn35zZ6d/9dcA2Mz2waVXffp4N8YibLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FGnYQqTf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZqIhQ2a9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FGnYQqTf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZqIhQ2a9"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A77311400F4;
	Tue, 13 May 2025 05:06:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 May 2025 05:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747127173; x=1747213573; bh=o21BIMAMXw
	3H2liXnWTFiQ3wSHQI3kzya8WoLtjteuY=; b=FGnYQqTfANyTToI9F9nqUXuihK
	hNLYVKHDLDggQnW0hKp60Dn2ylGymj+dD2KqPvBP4CzNVD4N5NFB6FkqAcVs8Abo
	6Bpd0aFJPLW3bB6lvABqHuJ5lsozDdxMgO1Gu+fmwDyLfDAUH1K6MeBGg8uu4f0c
	fOb6G2Ug4L5mzTR7CeX5omc2sy5ZDM38zVCJI7622qBEzEfmZwA0iypGnz2NKIIC
	TKKGE64Kdhe5kOI97XC7GuuBxGlA908X8Ih8f1lzF8xLsLcqXanwojGQe8MkcaBN
	CZl3OW4oLxi613z2VKJ7eBEVF0i/2wVI8Znjw0ApD/KVpvEGKKtqTsX5notw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747127173; x=1747213573; bh=o21BIMAMXw3H2liXnWTFiQ3wSHQI3kzya8W
	oLtjteuY=; b=ZqIhQ2a9fGh4JW/8T+W8sB5ds0Er/G2H95kj+zbMe4bNmCNBzep
	1G7/SsDFZNkZOGhCgEfonP+4veYn2eEi7P+qmwImEE437yUyspmbHPizwWbsYZPc
	q3xLQRY1zPm7pqQFku11GlTStlmUxCSvltWxd7hkoNT3YG1eClSGa4RI1QjZ5tQ7
	RNhGBMsMfDmEqYMgaxuVe0Z0ooBSEHVx5Wp36s5q59JGpC1bzi37X541QtU8vLt+
	rTEaqnIaI+inR8NLCTvRG5BsUzqAeOU26n9miA5bIK2u/Z0L7lby+AJtOeBsLJRl
	VSiCxXdgsi+rzNocRB5Isy1fUmzGbpwn3+g==
X-ME-Sender: <xms:hAsjaHw84eQm6pXr-zQ9IdnlcWiQ1kU9DP6kdYtC5WcbLXh8Fg8dDw>
    <xme:hAsjaPREhGIAxmDUPDZi4O4bne8bRGiGfZFlKexnPKiUVD9r14a1RR45q80gR5E9R
    2N-2jzU6kBX6D9VnQ>
X-ME-Received: <xmr:hAsjaBXslOg0BMaEIVjIg7iOWWbdBSMYrAETwqsWz7UEWxbms4UwqzbqsZ5nzM6AYS11ub8AnWbZSoTdfMaGG7_8tl1C6rP7uWkY1ueSrGrOoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejuefflefg
    gfehfeelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrrhhnohhuugdrsggvrhgvnhgushgvnhesshhoph
    hrrghsthgvrhhirgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgi
    druggvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hAsjaBjPwvHvATQ6LnswtaeQDzJ9i-QvVGq8M_3kuUAysTJ9BcxkZw>
    <xmx:hAsjaJCBZeyO4QnfxjvGvLYGGj07Vm8P8sb6iGcNc7oTkC94SaoyMQ>
    <xmx:hAsjaKImRquDfKbflF70x7aYmbtg5VHNdUKYFt65oSWjNpyYR-3Oew>
    <xmx:hAsjaICQiX-L7p0V7UDw98Gkea0WquCFmxl9bA-SncaYEpRGySpgGw>
    <xmx:hQsjaA1HOmmgDGEGiKKPy3hGYZgfBK5LgCcmVI2ZbPHq7CUmJ2KhfiiY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 05:06:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23a9e1b2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 13 May 2025 09:06:10 +0000 (UTC)
Date: Tue, 13 May 2025 11:06:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/"
Message-ID: <aCMLgaWXr_gM8g3l@pks.im>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com>
 <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de>
 <aBhZHA7av8bWH9Ac@pks.im>
 <xmqq5xieq3fs.fsf@gitster.g>
 <aBmg1_wlF2fuk96M@pks.im>
 <20250512135017.GC1191957@coredump.intra.peff.net>
 <aCKOqs52TDZDvAXJ@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCKOqs52TDZDvAXJ@tapette.crustytoothpaste.net>

On Tue, May 13, 2025 at 12:13:30AM +0000, brian m. carlson wrote:
> On 2025-05-12 at 13:50:17, Jeff King wrote:
> > On Tue, May 06, 2025 at 07:40:39AM +0200, Patrick Steinhardt wrote:
> > 
> > > Other than that we also have some bits and pieces that _are_ actively
> > > maintained, but that just don't have a better place to live:
> > > 
> > > [...]
> > >   - Diff-highlight.
> > >   - git-jump.
> > 
> > These two are due to me. I don't have a problem moving them into their
> > own projects if we want to clean out contrib.
> > 
> > I think diff-highlight is something that _should_ eventually happen
> > inside git-diff itself (because it would be more efficient and we could
> > do a better job). But it wouldn't share any implementation with what's
> > in contrib/.
> 
> I think there are definitely users of diff-highlight.  I remember seeing
> a reference to it recently and not realizing it was in contrib, but it
> is actually used by others.  I don't use it myself, though.

Yup, diff-highlight is something I see recommended quite often.

> > >   - Credential helpers.
> > 
> > These ones are tricky. In theory they could be spun off into their own
> > projects, and we already have examples in the wild of things like GCM
> > which are maintained totally separately.
> > 
> > But I think we may need to find people to step up as maintainers. In
> > particular, I think osxkeychain is probably used by a lot of people, and
> > probably shouldn't just go away. But I don't know how the maintainer
> > would be. I wrote it originally, but don't (and never did) use it
> > myself, or even have access to a macOS machine.
> 
> These are often shipped by distributors.  Apple ships osxkeychain, as
> does Homebrew.  Many Linux distros ship libsecret and it's the
> recommended choice for desktop Linux.
> 
> wincred, while not super popular, is still used and is smaller and
> lighter than GCM.  It doesn't actually look like GCM is seeing a great
> deal of maintenance either at this point, so I'd say they're about
> equally well maintained.  Since I don't use Windows, I don't know if
> there are other usecases (such as noninteractive uses) that are better
> supported by wincred, but I'd recommend keeping it.
> 
> I definitely want us to keep these somewhere since they are quite
> commonly used (even wincred) and getting rid of them will break a lot of
> people and leave them without a secure credential storage option.  We
> could promote them to the main repository and simply build them with a
> Makefile knob (or by default on the appropriate platform) and in CI, in
> which case we'd at least know they build.
> 
> I'm not volunteering to be _the_ maintainer for libsecret, but I will
> definitely contribute to making it work since I use it.  This is much
> like I am not _the_ maintainer for making Git work with Kerberos, but I
> do certainly often fix it should it break.

Yup. I think safe credential helpers should rather be moved into our
official tree. This includes at least libsecret and osxkeychain. I'm not
sure about the netrc one though -- it's unsafe by nature, and I'm not
sure I would feel comfortable with shipping such a credential helper
that is known-unsafe.

Patrick
