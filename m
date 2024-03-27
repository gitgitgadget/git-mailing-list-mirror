Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698C23754
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532853; cv=none; b=InD/kPFYTwsvULJ11QFic1JuS659odz1lfTgLlUboyu076BwOn22jh9/58Aly4Mc2QKDSUX6a9P2mKYZ1Oe3jbPKFKEMnHGOvy3sEyDBPP9F6h0Gw/Sf03r2qkDHutUPtYYAPLFOLiKEvjXVZ+TXHjne68vNYXreXlETRE0EVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532853; c=relaxed/simple;
	bh=Balw7z2aIUUdDzmf8xw5DUy3bNUWOvyzoWmmh6qJTzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5VTXsx8bcBasv96neDjlZivlB7DgztAqns332NxLXcqoEfZYAEAVTBUtz8fsaLPLEjAD6gERccr6cGirVa4iHXoCVd1ttvE/1Uy9E9d6r4IdQtu/MfK3qLD27XEfxILZvuOssWPXrXFV01gFG0tj+CB7xo3wuLbNze0u01wt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G99UD7OC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flpM8GxA; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G99UD7OC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flpM8GxA"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 052155C0060;
	Wed, 27 Mar 2024 05:47:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 27 Mar 2024 05:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711532850; x=1711619250; bh=Balw7z2aIU
	UdDzmf8xw5DUy3bNUWOvyzoWmmh6qJTzg=; b=G99UD7OCfkPOSE4tFhYot7+Vdy
	bkDeFihmc7KT92PZZ7IbSrdlSqs3QHjprhFWqCtnz03CPwRmBNT+aIO4qH6QWcqZ
	8aDLC7iaqPXNDfCbaJ4OYRILpGlCKYciKy7EUhDJ8QF/QNk8zjT2hXrIJMT7B1d2
	dCU8XFq+ZCubXDUKaJCASKF8vD13nM8B4Gx5PHECK6ZAXD3yTzan3o4FOA/FzrKM
	oTwWJxKFNnJHX4UtC2SndJRzoAa7a13PZy4BL+etPchRxqn2/3/25e/t/ZeirSrd
	ljJ+/1LC16falVbgxVKFvIl/1MzUXTbhFY0KfPK9gMohc4/NYtYE8BAdUwTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711532850; x=1711619250; bh=Balw7z2aIUUdDzmf8xw5DUy3bNUW
	OvyzoWmmh6qJTzg=; b=flpM8GxALw74gyOee2ZmirZvXo3B4+QAPxR/Ejb2xJHT
	tukGK3Ox6YoQL+6EMaX8DwdaXg3oIZADJAj6qiZMkgJ5xOtn7LAfbKtJODxaAJO6
	FlLGds0q8xLPBHHdAL5THSpqiyjb+nLH7kCh+F+zoBvqNlpWp3whec7bEeSRiwXi
	URKEV81rqwhfw2zfP9FS7BL6YBEzrya17guhG0xRHl0/WcNkQj5CHID16YZP2LYR
	fdggqLeLPJiNQrUrFxGU1KyGvk0quFinlbyakK5QMXr2Vugrcxo8rbzzUje9gqoq
	LYiZlPe3Tx79pshKGE7mVZyXUatd1LbyIFEe+a15ZQ==
X-ME-Sender: <xms:MesDZsUl_iPBi4Y8lUE3ZjdKar5vn83EQCpCG3akpFUjJalr55zKCQ>
    <xme:MesDZgkvt5jhDxqKDHODPmXnOmNejL0BVF7rDLFKXFG3gdicolj2kyCLMDQtz6Jsh
    4Z29l5MQ-5TUyQuQA>
X-ME-Received: <xmr:MesDZgZ17bsUyPO-OgoPf5oSl8YL3nqRQMi_4X_zOcbYU5KtzGa2iBdiArc6IhKqTwtXNI1y06uXvsRprAPsRRxI8385y6B1VrOjbumSQHfG2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduhedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MesDZrWjqbVooI1fOcsWDfaw4cPJLEGOU622DN3d2u3en8xOZTGm6A>
    <xmx:MesDZmkWb9_dRQRGo-MW3bsSJzH_9J8-I1gc0QCPgwjgtRFFO0uCog>
    <xmx:MesDZgd9ISj40kcHs2PNNaKCKg628I8N0AIvfddqv0FaIb7oHlnNUA>
    <xmx:MesDZoEXqPMHxsDy-NxvOFRJL37zlPLSCGLcMiBVkdNuA98_f6IzhA>
    <xmx:MusDZojco0lCl6nS9uh6GMoysIhTqdYgRoIgW8w1cS_57p0-bepdSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 05:47:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c761c71a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 09:47:13 +0000 (UTC)
Date: Wed, 27 Mar 2024 10:47:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aishwarya Narayanan <aishnana.03@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: GSoC 2024 [PATCH]
Message-ID: <ZgPrLXjB5mVXitXu@tanuki>
References: <CAHCXyj3Now+ZrA+w+L-sQAtAMZ8REru=3uF_Y3Xdt=7CSf=pYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="th+ETBWmkRCA2AWB"
Content-Disposition: inline
In-Reply-To: <CAHCXyj3Now+ZrA+w+L-sQAtAMZ8REru=3uF_Y3Xdt=7CSf=pYQ@mail.gmail.com>


--th+ETBWmkRCA2AWB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 03:05:57PM +0530, Aishwarya Narayanan wrote:
> Dear Git Organization,
>=20
> I hope this email finds you well. I've prepared a patch to address an
> issue related to the handling of exit codes in our test suite
> concerning the Microproject idea Avoid suppressing Git=E2=80=99s exit cod=
e in
> test scripts. The changes ensure that the exit code of the write_utf16
> and write_utf32 functions is properly captured and not suppressed,
> improving the reliability of our testing process.
> I kindly request your review and any remarks or changes you may have.
> Please accept my apologies for any mistakes or oversights. Thank you
> for your time and attention.

Please not that patches are supposed to be sent as mails directly
instead of being attached to mails. You can use e.g. git-send-email(1)
to achieve this.

I would recommend to have a look "Documentation/MyFirstContribution.txt"
and "Documentation/SubmittingPatches". These resources should get you a
better picture of how a typical workflow would look like here.

Thanks!

Patrick

--th+ETBWmkRCA2AWB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD6ywACgkQVbJhu7ck
PpQ+mA//YvPnwMaxmljnJk/PA9mD0pt0UFpHHxYk6eIDnMhUxO3aBaF71l2QMKrC
wHqijuKfh/ncrqdnglbmTkBGLObqgFf2KL74OMITvMzaMHBW2b+qhposxKJ4Uw3T
mODnn79mEd7QiPXUtd8Jna6hf4RWrIg5cshRvEAhsSS/IPW9mJlMakcf4KPBUn5T
RunwB5g8zGudLNWxhG/kgGxQ91/cPARSwN0f5edZZ9NixYmgvowew3HagNTqNakD
XDGFqECZemTBUgQyI3GarVteaEtHNd0+SSuQ4HiOywSfcW/exfioOC4BHVF6QmEB
rtfrICrCFPvBMK+l5xqXzvg/V90v11FKmloidmAyNL1MumGfafCNi/5dH593s4k5
8i3nepXsGSZZdcH4zwNN2od1WiLeu66EZBtPRZahnDE5LGOPsUMszr5NTUU5cMMN
xU31QujLC1TvYR0wRlyG74eR2pU6dHOwRTv31FdLOYo2kxOhw00x/mX4iSHufBaS
y87geazz4s/Ey40VdPZbVCQeODwALsRg046U+00mlqIba+P32VHvIm8mvlDKMtCj
tX2jrtiIZpEXVjy0l7grEgq2SD0cgsHsUNZ3LEJEfjt/trN9xf5HcbIHANxP6Evu
/41iQmnuCmjTzSUXuJAZCGr/b18rRpqO0cDTtGVMOJ7KmMRNZC8=
=OHIw
-----END PGP SIGNATURE-----

--th+ETBWmkRCA2AWB--
