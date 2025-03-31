Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D3172767
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743404110; cv=none; b=hw7Te9FDQ9djUmB9bJ3haVLJwMluXtuCnIvcgl7VrJbyllEXShJYFPaqZmFY47uytjcjFf0+kBZIGucBa7g1qDzzO/VJfJc4zFBj0UzGIxUfaGVjXQmVYBa039eY6yuQL+c2nghhMVwknuCq9lFkUnWfx78piHyDaufjK/cAMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743404110; c=relaxed/simple;
	bh=WzWKfweRW4KlGqknRNfo67jYcU3Rv+OVQfYOdUXq5Rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/aUwcuHE6UhJdsJRMQZZIXspnnbvLOTY5ttw/N6nj9BtyNyzOc1XU8OaeJn6wUA15Cq5It0Z08souroe7JWM9XO2aK2BJ9KY5WrlmXgYi+ochs7rilkoSu8YZm8bdoXpeEGgpZp6SyAYymtKb7HIsxj7xJSzhCZDKke7l6WzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n+RTTG+/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZDDNsqVL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n+RTTG+/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZDDNsqVL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BD571383DC3;
	Mon, 31 Mar 2025 02:55:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 31 Mar 2025 02:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743404107; x=1743490507; bh=MPU7ReeTnN
	e+it9qBGplNf0z2jMlepWBAzmvB+n5y/M=; b=n+RTTG+/Vu29Dput3F6TfRL3uF
	28j0vbZg98yN3OH8AcYQUXttXP3iD7m6n4BVrY/gS0M09dmFTUAmWRO8GwPj/AIe
	gQy/HsyNasKNsq/NsOmpDz1cdv6bgsjxCEcRPShV1oB/RvLOSPP1VHT+XAluITH3
	I1jZWCidRQNAEzsln2XUMqY2cBKhHfTmhWFl0Rv6ebxXueFQHD0IIr/ujkfn+OW6
	xSRWobLe7oQNaQ/ldcA0HD1INYVnWCdJheAWPDEEU/M7NsqBDp6gEVNFJvMzkjYj
	cn8HShAqRzHvlwRTZSZBwh8WKQ0tWimAQIWrlors83/H8aZ3NCV9inbXxujg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743404107; x=1743490507; bh=MPU7ReeTnNe+it9qBGplNf0z2jMlepWBAzm
	vB+n5y/M=; b=ZDDNsqVLuR/jfYidP4I/Ny1/KSYQnS/dSkilqEKXC8yGUbwDLx4
	TAg69JVWVW5Zssq/bXQ0YFlgqG+IXXQ4teFiZF1NENuTTNizCSNkeFQtW3wcklvS
	IPZEvJkivOezjUZLoHFmKXiefBZovWDSvViQLH0qLsMNyyJ3koB2qic0ih5rXwlX
	mXLlCn3P1f5kewpvxjjfzc6DydNtY4TH2+t1noZEggCaFXV/T2UHb5WjDvHY53kU
	GUjygEeWeLqCqpTjIxQ971nWu3LLm2FZe2AjWLdm9vdWTkmfs+B5gJvuZO+AmsFY
	m6YvKh9e0WhwvtmQuLcsHYfgVNZzTta9/fw==
X-ME-Sender: <xms:SjzqZyF4j8L_rAfpjGD_see-yfI1xXMdguU5atLyn7NxiNDiinDGuw>
    <xme:SjzqZzXoZWFsu46efoAAYODeKVkuAlTNW0vdnoR0H4aKM_EfOsWxmnpvv9BanQ5_9
    NoRrG5jfuLWBsEeEg>
X-ME-Received: <xmr:SjzqZ8LUPwXrtIX2d8uNf6pCXuxj7aougL_bMx7qCLBHu7flBNZHpqVQb8LMHTCcQhmpRuTPTnvn0B6FivSxB7ZhxQSXVDsRnMqEL8ib_aIJh9gS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffdvieeuheehjeevledvjeffteeihfduffegveek
    vdfgfeefteegveevvedtkeffnecuffhomhgrihhnpegvgigrmhhplhgvrdgtohhmpdhsth
    grtghkvgigtghhrghnghgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SjzqZ8FODznu_pj-BG4pldbmvAKqDuQVkDu8Fx-aONWBd6G_vQjYZQ>
    <xmx:SjzqZ4WydUCks-p22jVgpbQdOhMxYgIhkzN2fW8sZwl91ZeaIj8zBw>
    <xmx:SjzqZ_McA5owwxgZihywBMK6NhGeO8IXMRXThbQU10evGLF7Gl_IXA>
    <xmx:SjzqZ_029zt54Fp8iaubOfXdLsYK7ejh94AK1HAFYOW1KS2fXBUj6Q>
    <xmx:SzzqZ1irEI5WdpFpkoFWgokfGIplaYCYZZR1dOn1XrfXckIbU1FzrnbV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 02:55:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b4b96a0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 06:55:04 +0000 (UTC)
Date: Mon, 31 Mar 2025 08:55:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: M Hickford <mirth.hickford@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] meson: wire up credential helpers
Message-ID: <Z-o8Rwkp5zy-eXPP@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250218-b4-pks-meson-contrib-v1-6-c3edd292beb8@pks.im>
 <CAGJzqs=+mL_GyXfR44iQ6o6L+gb=D7DWm2Bq4eW19XhuEFuHew@mail.gmail.com>
 <Z7RrbZqq9VrTg-Bz@pks.im>
 <CAGJzqsm4c7b+mO=Gya-zzaUsQ0c5CSrtG08Wgshu7-6epH6J3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGJzqsm4c7b+mO=Gya-zzaUsQ0c5CSrtG08Wgshu7-6epH6J3Q@mail.gmail.com>

On Sat, Mar 29, 2025 at 07:15:00AM +0000, M Hickford wrote:
> On Tue, 18 Feb 2025 at 11:14, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Feb 18, 2025 at 10:11:23AM +0000, M Hickford wrote:
> > > > Note that ideally, we'd also wire up t0303 to be executed with each of
> > > > the credential helpers to verify their functionality. Unfortunately
> > > > though, none of them pass the test suite right now, so this is left for
> > > > a future change.
> > >
> > > Out of curiosity, which tests failed?
> >
> > Basically all of them. I originally had the patch at the bottom of this
> > email. With that in place, we re-run t0303 for every configured
> > credential helper, where `GIT_TEST_CREDENTIAL_HELPER` is set to the
> > respective credential helper under test. We have to disable parallel
> > tests there because the test state directories would otherwise conflict
> > with one another.
> >
> > Now you can for example:
> >
> >     $ meson setup build -Dcredential_helpers=libsecret,netrc
> >     $ meson test -C build t0303-*
> >
> > And that shows failures like:
> >
> >     --- expect-stderr   2025-02-18 11:09:33.323668205 +0000
> >     +++ stderr  2025-02-18 11:09:33.347668278 +0000
> >     @@ -1,2 +1,4 @@
> >     +
> >     +** (process:75536): CRITICAL **: 11:09:33.339: lookup failed: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.freedesktop.secrets was not provided by any .service files
> >      askpass: Username for 'https://example.com':
> >      askpass: Password for 'https://askpass-username@example.com':
> >     error: last command exited with $?=1
> >     not ok 1 - helper (/home/pks/Development/git/build/contrib/credential/libsecret/git-credential-libsecret) has no existing data
> >
> > I might be missing how exactly to set all of this up so that things
> > actually work. Maybe I have to do something specific for each of the
> > helpers via `GIT_TEST_CREDENTIAL_HELPER_SETUP`. But t0303 isn't wired up
> > via our Makefiles for any of the helpers, as far as I can see, so I'm
> > unable to figure out what such a setup would look like.
> >
> > Any hints would be welcome.
> 
> Before you can use git-credential-libsecret, you'd need to install
> gnome-keyring, run gnome-keyring-daemon, and create a keyring
> (choosing a password, can be empty).
> https://unix.stackexchange.com/a/548005/7732

Hm, okay. Ideally, the test setup should take care of all of this and
also depend on gnome-keyring being available in the first place. Anyway,
this seems like a preexisitng issue that would also be the case with our
Makefile. As such it's not specific to the setup via Meson and I'm going
to leave it at that. #leftoverbits

Thanks for the hint!

Patrick
