Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC311184
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717733231; cv=none; b=AoAuFBfGzGDm5m6vgeZGlBCcStAKKofDCHourb7ll2Jry51AqoiLkjZJoV0mc4nAlklju19sFEcLIGv25R6/WKLPqL/GlnzJQe84elGWVnk+/SUizRU/otogUpXHQvRwL6i1ig6qtPOBriLfOeFWEjqTosjFezd3Xc3jzCU9GCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717733231; c=relaxed/simple;
	bh=ZncDigH+K52v2GuisklEuFRn4TfGO2nzP8347Kielko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWbBPFjv5jEWdxl4kVZgedQg2/ePms87v79tx/0CKXC3ioZMj5r4TzkGGXVO/vzrUA3XSsB+pomd8KtaGbH9nOweoId6Fp8MWA7XfMNgvoc4H9UvrWAgExVZnIbqhg5KYKwTbWjqgoIfX1b3LUajRNOP0dV1Iq+sg1P0goIqtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HEOSq2ri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=frPMeOVe; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HEOSq2ri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="frPMeOVe"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AE5871380219;
	Fri,  7 Jun 2024 00:07:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jun 2024 00:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717733227; x=1717819627; bh=ZncDigH+K5
	2v2GuisklEuFRn4TfGO2nzP8347Kielko=; b=HEOSq2riznZo5xB4D9vKgpWfPI
	Vd/TGtQhVs+sDQia2RwAlEgKSPNNHz8ufUVZcw9I0XeRjlB380IwBMvuQ7/kdE9+
	6MWsjYb2PXttjNnyIUbcH4qnLjb+GBK2D7MG+BHRI+5PVelMeMcp/wCwUhx5TAVB
	wzzrvzcQTdA/hDAr+CGf2psWjk9grlRGWXjOKnau+84XF/ifBkjZMIWm/Agsxeqm
	MppPNu7RE//JjpXwfiS2FdGzZ9+WQ1ayTLqdEo2Y/+CFn5wS+sqjj51oyxT9WPbU
	bz3IrZBmm2H+I812W24x/TIayh4G4h645VW9kFoGBnJcGWsNT0oZb5I7Usdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717733227; x=1717819627; bh=ZncDigH+K52v2GuisklEuFRn4TfG
	O2nzP8347Kielko=; b=frPMeOVeZtzPtqB2wiZs4OTNxoune4KNslNWT3or43aw
	BZro0Cow0kkrIry/JCyTiztgwEN6OFtYeslGEcO6LeDPWFvwrJHt2zqFCmJL9rmc
	ATX3lAKzF78sZgiyB+aDgALHMUqRchNYuzHIYTttTlVTp6wC72m+dfl0PYeY9doP
	LmFsoXg2yG+5mGjYsT7pyXX2Z4zwKtWjFtlHF1jTn1H5YV6b/5j5IhWHjK/oMHmd
	/S48rGHq4Yjm5O+mvyEfac1LD0flrmHcw72SalfYbk4xtr3IBb1ajzdzhNjG7Uvx
	yRnKzDhejJ8+WXA6yR5SjhPyO5BK8PjCn8cwB1R4iQ==
X-ME-Sender: <xms:a4diZjLzBeVzlocVnWCcg2ePnpaxmN5DaCVZqSm7IJGJXlXvgBYHVA>
    <xme:a4diZnKUFbI7dr6y9YfPCWcsjYlxdZzwxFiPuYni_rWR5_lgWa3RTqSxxEoBVlBeo
    1b_8LjMsaGW-EDJmg>
X-ME-Received: <xmr:a4diZrv4BuNo2sSYJhsB0J1kQIsf_2ocLc_3p4zat1uu2BfEjPe2UtbUhsjvOVR1-hex08RiKGMk-MXn_U8dPFfPUPHg8SPBdGkxA-5WURyPPvNx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:a4diZsZVt6j5SyQHzmf1yfT0cQDu4n0Uzr4Gt_HRWFx0nJRbq6epOg>
    <xmx:a4diZqYt649Xt-7gYGxOy6RRMVIXdnqaZ5wqCF_P3F9e65nm8WXpNw>
    <xmx:a4diZgAwFBwRxDT0P1NZlgpskdlH8aX9kQCyzbZfdtzDpfafsrwCZw>
    <xmx:a4diZoYBVsq5EaSrGcglEmFuIPILkmDqgad2plGkgIOFJeHRXxINXg>
    <xmx:a4diZpkJdA6zWDesHFde_cO95gnr7C34Q9JOyL99f1OCcjnvYEn2D5us>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 00:07:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9ca9021f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 04:07:02 +0000 (UTC)
Date: Fri, 7 Jun 2024 06:07:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/29] Memory leak fixes (pt.2)
Message-ID: <ZmKHZaQHHIDpBRMQ@tanuki>
References: <cover.1717402439.git.ps@pks.im>
 <CAOLa=ZS39hobSHXzyq=vAL9KqBkr9PaSZyqyELvFxvAA=uSofw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JaR73ZxEljTeTZwP"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS39hobSHXzyq=vAL9KqBkr9PaSZyqyELvFxvAA=uSofw@mail.gmail.com>


--JaR73ZxEljTeTZwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 07:33:34AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Hi,
> >
> > this is another random assortment of memory leak fixes for Git. With
> > these changes, another 77 test suites start to pass with the leak
> > sanitizer enabled. With that, we're down to ~270 test suites that do not
> > yet pass with the sanitizer enabled. My goal is that we can reduce this
> > number to 0 this year -- any help here would be appreciated.
> >
>=20
> I was thinking of picking up some here, how do I avoid not clashing in
> with the work that you're doing?

You mean work that hasn't yet been posted to the mailing list? I don't
think there is a perfect answer here. I guess the next-best thing is to
not keep your patch series sitting for an extended amount of time, but
limit the time you are working on it and then send it out early such
that others can see it and ideally refrain from plugging the same leaks.

> > While most of the commits are trivial, I realize that the overall series
> > is quite large. If you think that this is too big, please feel free to
> > speak up up and I'll split this and future series into batches of at
> > most 20 patches or less, if you think that's still too many.
> >
> > The series is built on top of 9eaef5822c (Sync with 'maint', 2024-05-31)
> > with ps/leakfixes at 164937678c (Merge remote-tracking branch
> > 'junio/ps/leakfixes' into HEAD, 2024-06-03) merged into it.
> >
> > Thanks!
> >
>=20
> I only have some small typo nits apart from that this was a nice read. Th=
anks!

Thanks!

Patrick

--JaR73ZxEljTeTZwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZih18ACgkQVbJhu7ck
PpTWsBAApCUNX6fTE1tzE1/jgVkibFaf7KedKpfTGOWRpHo99+niAoXM/JXvd2mP
W+RBxdKIU8EmbuomlYT9n+VeFCGt1VjJq67DfPEkOYeWfCRfTkrevpXaU1qTmQeA
1+gCBAHyGmY/rzj+GcFa70qHg96in57AEDmvj7KsHaLvA6QhX0NQ2Oy5le49RqUl
DNJBdUMM9Ntu7u44+YQld0sC5eZ04nH63s1hjqyokSgRRHmUkEOo3riv2mDhZ8yO
IJ3H7O7nfwdFOsy5zkwNgFXJJ4jQ+SP9wlq+iYmPfTHry2e7wIjkSK8jVSCRaa/2
HMyrCrqKe05J1kMtnzt8hfUTsJ2T9/Ekklxu2VgaUZfj23RGNQvoy3OptBzb4m/B
vCH9GHbXa5jJsFBxkYLsrGe1iBTC8lT0g159nODEG3d7R5uCpSdCzqDIrbUkyaQH
8NusTInK/i6PoFRF5KBEgHJ9HNqDaoZAsxJmAhnkAQhaG2JjueHg9G9puepfolgn
ESsB3UUtnxbRjMxRxfqmDHfooOf0s6I3jgFxoMiWz6PdYEuqFDBh3H8tIg2j6/rR
ZQwXyfH/iDox2S3B3E8PieoYgcBENQTHm0z4hSv1X7Lb2pF1+U868yaQyssnFe36
kgZc/8G4MUx3IUYkD1sWyOKR3U5ZCEfLc30EnmnOM6/8UypCnF8=
=iKA4
-----END PGP SIGNATURE-----

--JaR73ZxEljTeTZwP--
