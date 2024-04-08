Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649C179C0
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 05:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712553881; cv=none; b=LGL7AGU5YoOw8ZmQkJWSp1i6ahefUsrBRBMMuvRiW/bnkJMZRCjvidswWgHEhUwKy7+b/lOIRbY76+DMaHwOn9YvPf/fpszOJEL3lGliFdLYVJyQDw6R/j0oNcFCj7V6eL029FvaXdXfXZvXZUszvamFJ/dS5xUPB+zPFWXkBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712553881; c=relaxed/simple;
	bh=DlT0aR3FeLz5kYSXIlYbOjG9tvYGTGq+p7AoyBIuHZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqrLRZ4kjTorR9THRoTaqybn+mfkx43YdPWwXdtaIgadcuhqBG6Hiz8vd3b1eP4abROVcA2WUnbcOKk36y2xr/kA2ln68bexpoIdOXU2DrA1jYFjpTX+UGbTyI94hxZN+cxP0TMYf5Pxw3qZ0U9NVqSrvkKogok22Ex9cWyzCLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gfcBUljw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E1vyIxrE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gfcBUljw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E1vyIxrE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 22FB81140092;
	Mon,  8 Apr 2024 01:24:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 01:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712553877; x=1712640277; bh=TV7aY1emiE
	1zaKp75vXzL5Yk3Scd8eWHiU9g8C0zMPI=; b=gfcBUljw+fIz/3c2yVYmzCWNLn
	IhQFPfOziUlqtYsUUrzdpjB4ZSQcsNyXQqNtv5WgNHiH+7XFEhW3u8wPBovsRU1u
	mgksI2fAK3sgPYN/BybP1dq9rHdzJ6LsxnPha1j3QsvAFsZe74uGmbT3CRlJvroS
	NhqYXmRVBXz1N0k9aFgHSfARi/q5Bx/c4L1trlWzCu0WwaOi0yreEjo+2bMHEkgg
	XjbC96JphtDB9W0kDcFSjJXxH2DXYwGr2uZ+5wQ22EoEQ2eyWqawT1WxY1JVvEG5
	RY3LiIUMbdePwyakwPyg6fk0JoiCC1Feui32T5dRdpB3JK7Tpi20+g3o3voQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712553877; x=1712640277; bh=TV7aY1emiE1zaKp75vXzL5Yk3Scd
	8eWHiU9g8C0zMPI=; b=E1vyIxrEwsrnoHDsAKJiUeQ0MJ0x+JZvPHUKnqLUCgBI
	HPxirzteIUQLWZixCZctmFdM9KkOBSqgRHkUSRS1p8C+aC6JmmyfBtwGC6GZpg/1
	E96zUEVqSFvfrifRBDkIdUw4F01HawuSINxqP1RFIDk+t4NRiXAv6mdI4FRmA9j+
	7ixgsvlXXvnbWMI3Dwr4Lh/E6OkhgBVXouuJRnY0Dn270kIjD5RBGvQGiIy6/fdn
	SR3vvnEjcxzwEpFGyWUCKnN4CHFJ9I9GjltN1weEjoXWwbAl1tJPZph8Xz9IJofm
	RmgFZ0uUFixqYkFPBHnLnu2pUwLpsc35EZD9PU0igA==
X-ME-Sender: <xms:lH8TZoQxQ2U5dEiG4Hl3P0WEMmd0A9nAmzXrTe5xbWQfqfqKxpWZDw>
    <xme:lH8TZlzJvuEMl1QAwIZ9oH1NNVq9i_-hnC9pjN7jVuvrRkomC5l1IoGlbibzPVwNZ
    TYBOWqI8zSGtnPhkw>
X-ME-Received: <xmr:lH8TZl28VOfoHvcU3H7GpFQf2owmxrDORvs_gxtONuPOQgo_Qdjiqz5RoITRszEgqvOZoPBFU5TmquY2VD7V45XR47d12wk9XX4YTdbylImb_g_FXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lH8TZsAt7zDNNjlxnRqSGKOjHrR1QRtLgyzeOUaPxoC_8aJccRctfg>
    <xmx:lH8TZhi_NKKAM5pdV9cMlJllH0Vf25juNpNfsk1wThhwjCXSkh4KrA>
    <xmx:lH8TZoqJK-9Z7G1F-z_3OfX5LF3jeTlX_TUQ8p87Uier1uhyEfsnxQ>
    <xmx:lH8TZkgd8dx5d-t93suZtgtJhxFXd1e-FhjqlGP4-ZCsxAI_gleKrg>
    <xmx:lX8TZvYyi66uP_VczIcdZ_AI6zmS0A-eal6JHWMfGjQbiH_JlMURSO-0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 01:24:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 950c7cff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 05:24:27 +0000 (UTC)
Date: Mon, 8 Apr 2024 07:24:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <ZhN_jwNAcR7UhCc3@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <db66dd4155d80b714719e80ff90f64c1d36b97d0.1712235356.git.ps@pks.im>
 <CAOw_e7b5wDKOcY9hSty+c+z-NWVUgri3h3ScF0qd1Y6cmfsyVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37dh4cwywA8ZhFfH"
Content-Disposition: inline
In-Reply-To: <CAOw_e7b5wDKOcY9hSty+c+z-NWVUgri3h3ScF0qd1Y6cmfsyVA@mail.gmail.com>


--37dh4cwywA8ZhFfH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 11:40:29PM +0200, Han-Wen Nienhuys wrote:
> On Thu, Apr 4, 2024 at 5:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
> > +test_expect_success 'JGit repository can be read by CGit' '
> > +       test_when_finished "rm -rf repo" &&
> > +       # JGit does not provide a way to create a reftable-enabled repo=
sitory.
>=20
> You can do "jgit init && jgit convert-refstorage --format=3Dreftable"

By the way, the above command does not work as-is as it will end up with
a repository that has no "HEAD" reference. I can work around that
though by first writing the default branch and then converting the ref
storage.

Patrick

--37dh4cwywA8ZhFfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTf44ACgkQVbJhu7ck
PpQkdhAAgjYe10XC43WPMKWcRsrvYDVCN7tHn46+M3uz9XWGKS6xgqDC34WkD5TP
OYKCeXY3N/iCY18sZV33oEeDWuit7gz7VeKd38kegWj5CiUVhUK4H66b8pEKfYy5
BmEkRxTolw5NmE3JFhe11OpzoLaNiyVbF+2bhQdd7oa+Vb7rD5p2LW5PhOjP3pXI
KLVTJdLoFe4pXwQD+wmsFrlqFOqwZhd7Z8TX6Gj3F9/R9Sbyt+mkklebMaRVaQCg
TJc3978980zvikfNUl/wbnbqAvb2o0tJBj962oEUOm5u1myYii1t80KChjnWJh2E
c/+YE1LW2kc2OqavEuNgMbpCbnV0djbM8FhwDU4b6TqLX0yE3Ywt2p++gO6+2aOF
UxAW/ZA6uqN2MJRw7t4mloUH4DrMQOrXy1ik8+dUKPlQfbgTcAwru6iZDTsbQzd8
m1sDdSONmG1S/396O+MHIkUGZmjAruJ6JcoYIS5dKoyEec1Nqj/rAVX9tl/1vtFe
XdNaHsLCgkyDvBioO9asdWYI75/E9fKfMmlUNxYlutCmwJ+DGrYF0u2Spe6g0g2U
h9cZexGXfzBcJwQFAZFjdF1d4PDENYJgYG8BtnAjDVWPG3UyBiWuN4CAeFm8DX5C
ZsSUoqID8AS9iG1LqIZistC1n7g6fvTrNBb8ItqD8ieKcwCarpA=
=U0jZ
-----END PGP SIGNATURE-----

--37dh4cwywA8ZhFfH--
