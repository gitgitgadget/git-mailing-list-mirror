Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D177AE54
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707197604; cv=none; b=pvelTF4PFKDFkg1q82KTsgjmbgLChy8jlw+kfSzWL+ZHbv09nCtauVEhk0+q6eZB0MiAc1OLCSqwnycPn10Cn9XDdHrqIv3/b6C1BcTnDL97w43EOhimQcg+9Yl5sqfIidrA8fP+MdSXDpA9QbXIXlF35lixxakhqFRL4BlAhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707197604; c=relaxed/simple;
	bh=N/4pWmigTC9ps4euwi3obqUSP9N7ANuzLVJtZJSMprE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W47wl5ydroJBkyaLtF92MgH/mJ8Ar/5uztdUqUNYvBdkcYltkLFl3g9oVP7ey4d0S8kAaaCXJMprQiDmTl6gMv2wDl7cBOIRIpGsFIMe4l/EZ1L2GfUBK56CPAmPDBtr/kIObzxRi51e60pBKTsb/0O51D3LdzhTtExRVr2vUEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=agjz80g/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nlyPx71v; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="agjz80g/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nlyPx71v"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 940065C0189;
	Tue,  6 Feb 2024 00:33:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Feb 2024 00:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707197601; x=1707284001; bh=N/4pWmigTC
	9ps4euwi3obqUSP9N7ANuzLVJtZJSMprE=; b=agjz80g/6PptfcjXDbLqYYcYZc
	k+bD6psK8XuYIHZLs0uYtxMNjUqxFgOIsOKjghj0V2OGWBGAoYMpmSOEw+rKXY4A
	g1O2JHyMda1LZMuoJ1S3bvBfeooBqdOVBaz2ZEA6GMA4eqYVc7Wf9QIcOgTuEAiQ
	Sxb/i4JRgrjIAEGN9ZHq9Cyfk9UpqvbboK5IDpun+msNy4bwckhYyAFW2XsQGHRS
	UnF5GbRlyGOLaj8A26IhTnZfSYueg7qBRP1kc3sY/02NGsbuhqbhLcEll7lp0Ron
	okMQfb/7ghwG4jVcFkXNPWJDX9NXTItIvNo7P6iGQsdqZIEFe5HCjqd2DQeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707197601; x=1707284001; bh=N/4pWmigTC9ps4euwi3obqUSP9N7
	ANuzLVJtZJSMprE=; b=nlyPx71vkNdsv0B8AFTC25gbSwlQdvfyV0b7+r5Ua7aG
	uWkcgNFqpL3cBdanLJ54vxNz88W33jI3LyaOR1ZSpL9uGr+hal36e+GpEIg/08LO
	hz/U61U+nuiT/b3olxY2ogOWwJx64rACbUpxTeDTQfVxHbLEbwaB13DsgXPBU44N
	Wm0YK0VPEdwkSl4O+fmJVD8ywgu7rU+FSIVaiZhK7ilEYeYKhRwM7vhKeGxitjBM
	1VZWlD/dI6uBFXRv8f3PVw6yzymI+5DM5lXkkEJTC+lhxO3GYM/0L4S5LQVAuO7P
	bioXf25T+7mCCbGEGJFPICw+VM05s6KFqAgrEiGEdA==
X-ME-Sender: <xms:n8TBZaYTAfvIFDg_V_pK3-ns3yMDYt6-vrBR41PbSIIbbrsrOoCUtw>
    <xme:n8TBZdadGjBGd9hRADIccAVWe_1Rnlzto7XhBJ69ViMqbcR02B7euEu2H74DEO2KB
    hBLGtov6FvhNkkkKg>
X-ME-Received: <xmr:n8TBZU_Qy3FDTYQmTfQpFmv1ETC_WVt020MSUGwj8vCaaZKFpnQDqeFWmpJ4P5EIL8s3RGQyPtiSsYky_KfBS9Z2mhK-zJbk6ffYS2s43ONaN53t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:n8TBZcoXpmAh1kVt4GsunCPZju7o6xAaFQua1QBi8F-E5bnrEWTKzQ>
    <xmx:n8TBZVphk7Y7VD084V6HlEovUSxCeUgpmV93MJATPbeV9KO75YlXbw>
    <xmx:n8TBZaTrFXIIVwKufLOBin8IX8Vzyin58cMmFPTYluxKLC_jIuP5ew>
    <xmx:ocTBZcWhiiKZDsXoq7OrwxshSe9PPWQ_LvFDui8oLSrm8uicGu_dvw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 00:33:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42641cab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 05:29:47 +0000 (UTC)
Date: Tue, 6 Feb 2024 06:33:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Message-ID: <ZcHEmyvvMR_b_Idl@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
 <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DnjYM3zAHYXrSMdI"
Content-Disposition: inline
In-Reply-To: <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>


--DnjYM3zAHYXrSMdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 06:48:52PM +0000, Phillip Wood wrote:
> Hi Karthik
>=20
> On 29/01/2024 11:35, Karthik Nayak wrote:
> > When the user uses an empty string pattern (""), we don't match any refs
> > in git-for-each-ref(1). This is because in git-for-each-ref(1), we use
> > path based matching and an empty string doesn't match any path.
> >=20
> > In this commit we change this behavior by making empty string pattern
> > match all references. This is done by introducing a new flag
> > `FILTER_REFS_NO_FILTER` in `ref-filter.c`, which uses the newly
> > introduced `refs_for_each_all_refs()` function to iterate over all the
> > refs in the repository.
>=20
> It actually iterates over all the refs in the current worktree, not all t=
he
> refs in the repository. I have to say that I find it extremely unintuitive
> that "" behaves differently to not giving a pattern. I wonder if we can f=
ind
> a better UI here - perhaps a command line option to include pseudorefs?

I tend to agree, and have argued for a flag in another thread, too [1].
Something like `--show-all-refs` feels a lot more intuitive to me and
also doesn't have the potential to break preexisting scripts which pass
the empty prefix (which would have returned the empty set of refs, but
now returns all refs).

[1]: https://lore.kernel.org/git/ZZWCXFghtql4i4YE@tanuki/

Patrick

--DnjYM3zAHYXrSMdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXBxJoACgkQVbJhu7ck
PpSO3Q/+M3Jmk2LpABGrHC2BxlPWY8fwoPxkGKWpa9O5WAHDycGm275QErtr9sm1
F2kCxh53GzlFjtWZ3qTHKpbWY3pprnmRh2mCXwPNiKRF7kvvbWgGf6mS/jm6t9IF
Xs19Ft1pH1EJKM6KtyhIpaVveXnkRIa6RazDbcuu2Alsldi5yXZuKz6+XJrIXLoQ
eGEggCi//7HgZk/lQV5Otw/Mv4y3GrQIKihtGdPB+ASUFXdHyeN923hN2Fwy3wB0
r0dJEy/dk8R8xOeG7Om98whyICEr8UEOIqq9cT3UoiWBB+Zg6FXYy/haFyedDMEj
L76liNLmbEuUoANSYJqBBRUgA1gb2HM6F0neS1bYfh0XQ5vFw7Ikmhxu/GJBLKBk
A+pFWlBf71KhrFTsvOZoOtNN3YBIiChNTYflhqvB+RtZ9BRInUepycxgBrdy/6gA
0jP2YdlhVURx8hxxX6FNwLHidDl7lTW65dLq3ks0bXEil8Zn08aMEWSIiw5m2xYb
hMRs0GAodxOzCbLZVMeZnUohe8McNG2S4w6vQQorBFUEOR4jbvE+lg/ZEqvXmLxP
z2y66/Og4eKKK5OIoEqMqpfLJhquChpV2xiF9eMtn27znqwk5m3ICGoGTCdmT3aH
VTJ5oqhAiQhF5iSTJF4aR5IcE1hFxVuINQSljd9Iyx1u+mZWYPw=
=XAAh
-----END PGP SIGNATURE-----

--DnjYM3zAHYXrSMdI--
