Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C9834CDD
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649469; cv=none; b=DoGMoLrisC6lYDITJ7+PFFfUW2lmSzMGRcCpuKjZha1YLCczWULayA/oTwWbRhNdNaxeoGO5nfGStvezonWBlgBgm6/oxOKvhVw3YjbBCZuwS/eSkbsKZ+lhWkqXnxsCLsU8lHGsVfxRphVVyzGVJnSX7slM9yPZGbfC+sCRr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649469; c=relaxed/simple;
	bh=2A287mDdiwEsDKjZ8086IwBPy1hhbytgixaPQwuddZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iusD6G8igYKHNqq4HS9IcInmGEt1J68dJSw7OXPvDjOj9xRBKEk47Moxb2XMd5/ldr4Z+E5JQjOD+OAyN2rCieb8G8n6mpoM89NMHvrXQy+b99eRKSKfhwP4i0fg1bC/7A83kjhdZehl9HGUEE1NqoE4LreQ68t+IRb1rNMKqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B4n7FcB+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aWcj6gpX; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B4n7FcB+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aWcj6gpX"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 1B0831C0008D;
	Thu,  6 Jun 2024 00:51:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 00:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717649466; x=1717735866; bh=jmNxkWYOsy
	wZIN2cHrl5kYe1XCbqLnyuPXxYauDVvnE=; b=B4n7FcB+KE6cR3vTqO3+qUO2g4
	nSlUG8ZnSVUn5sVBraoY0tprYSXWBctmVlR+7D9X0qgTyH/VMU8heSRhLB41vWCZ
	bgUntPXmvTY2CNXh6BL1WkDc6psDC0T2ui+BZdsh5FlSr5TUPfgJG9YvuDHm+sxq
	zBSbFT+z5eW75JAaY1VmCLmO3OX4YeRlj62vNs0kHwDPaQot/4ToDMFhI4/bZDGJ
	0mfVMJRwuJPC2yzXq2umbO8vpovZeyzFhBfSaHosssLp4wNMXIpAF005hPRc1/8d
	3FS0zVzuS9AFjNa8wa6yC+NZ+x3CaEHdgXOWAzsuIrwa3KOFvq9XFarkij0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717649466; x=1717735866; bh=jmNxkWYOsywZIN2cHrl5kYe1XCbq
	LnyuPXxYauDVvnE=; b=aWcj6gpX29mRzkQm6vrHnZOVxrhCdkbG9zE3fI9BU6PX
	xREITktOJel9iu8t8tFUNeS3w5vILdYB1G7dfId2nIbOCcnrH/Bo0JDSLHV6ERuO
	su+4P+rSQT8z7nqCDrzlTIH+/F39dwKrPusYZpBAmuB5PgkXVYLcgQgcO02RzTQ8
	5Mdo6OUwwJel22wKj2UdGaVNIOSepSsIeIe2FmzxejGF19z7qqQtVU6tAEsMWtvZ
	8xDrSt5CMH8RgL2vrvheoCzxR1BGtYnjDGpfmPZtZX/G+XqSm1CumENSQeR4yvp7
	U9ZBMkVqMnhcW5jjww7p9kssld3qLJ4JQGPNeIZdMA==
X-ME-Sender: <xms:OkBhZm4SEsbn6Im4fKc47gTl5J1_fNjiiq-vzyxPYPN-n0Dox5fRQQ>
    <xme:OkBhZv7Injs2VMn_Dp7uhJjlQncSFdGV8vAmnY4aFh3_dwm0nRNbb0pZSBI9b1rkV
    uKDv7jdS6gLzZsR3A>
X-ME-Received: <xmr:OkBhZlcguJAgb_mQXCWx44HtcDG2qN_Jaq7po3b3IOL3Nvfn9okHxYXLb-yjmROXo1NWksmEsBeFIDRSpkRkxChkanZPHkDD5204QXB6qq93yM6L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OkBhZjJbi5LVvWNtnIPUg1rHntKVCQalxsRCb3NlmGT7xUPCJE_XVg>
    <xmx:OkBhZqKEoEP9Nq84txRwqPCjz6S9LXf5Kc5tPCbQ54AzMZrgLb0xRQ>
    <xmx:OkBhZkyhwETli82sn8EmidzCgPWqkL74KinBja444kIGkpdYliPyFQ>
    <xmx:OkBhZuKGnGNrtIvbnSyVdli9dzjHS3lsYzbJCEXtv5kRF3dDXdvgAw>
    <xmx:OkBhZi_vALQfNfnhdhWeF0V9ZOZbWozXtQJGlyDR3qpyvaFuuQxZRn18>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 00:51:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f014ad57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 04:50:35 +0000 (UTC)
Date: Thu, 6 Jun 2024 06:51:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 10/12] refs: implement removal of ref storages
Message-ID: <ZmFAN_r3BF8p0_4o@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
 <f9d9420cf93025595e00aa4287bc0cc1a1c067ab.1717402363.git.ps@pks.im>
 <20240605101200.GA3440499@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="57JOLRTl9btT2rfK"
Content-Disposition: inline
In-Reply-To: <20240605101200.GA3440499@coredump.intra.peff.net>


--57JOLRTl9btT2rfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 06:12:00AM -0400, Jeff King wrote:
> On Mon, Jun 03, 2024 at 11:30:55AM +0200, Patrick Steinhardt wrote:
>=20
> > +static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
> > +					  struct strbuf *err)
> > +{
> > [...]
> > +	strbuf_addf(&sb, "%s/refs", refs->base.gitdir);
> > +	if (remove_dir_recursively(&sb, 0) < 0) {
> > +		strbuf_addf(err, "could not delete refs: %s",
> > +			    strerror(errno));
> > +		ret =3D -1;
> > +	}
> > +	strbuf_reset(&sb);
> > +
> > +	strbuf_addf(&sb, "%s/logs", refs->base.gitdir);
> > +	if (remove_dir_recursively(&sb, 0) < 0) {
> > +		strbuf_addf(err, "could not delete logs: %s",
> > +			    strerror(errno));
> > +		ret =3D -1;
> > +	}
> > +	strbuf_reset(&sb);
>=20
> If removing either of the directories fails, we set ret to "-1". Make
> sense. But...
>=20
> > +	ret =3D for_each_root_ref(refs, remove_one_root_ref, &data);
> > +	if (ret < 0)
> > +		ret =3D -1;
>=20
> ...then we unconditionally overwrite it, forgetting the earlier error.
> Either we should jump to the end on the first failure, or if the goal is
> to do as much as possible, should we |=3D the result? I'm not clear why we
> assign "ret" and then immediately check it to assign "-1" again.
>=20
> Is that a mistake, or are we normalizing other negative values? Maybe
> just:
>=20
>   if (for_each_root_ref(refs, remove_one_root_ref, &data) < 0)
> 	ret =3D -1;
>=20
> would work?

Yup, that would work, good catch.

Patrick

--57JOLRTl9btT2rfK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhQDYACgkQVbJhu7ck
PpToZg/+LNvuoxObaBlSdG6I/9R1cz/zLG+NCwhqRPNazrcV4Wg0qv7Q09bKNiX2
qHl5Vew16ohYMbA6OMJul5iKrsd/mzW5NZnyVSD9Mc+hlAGLau3QQXe3oW+a5LC1
SlmRjQrh3dyKlzUJMcVcK4dyEsmd/2SG26rh0IR0fTAMv3lay0e4fQdHhmYaT1H4
bEa5eMBRhGbJ4vu9DeUS/OX1IWDS3zrBxfrPFhOVhmit1Jx/mNy9qtRBayzQAVRp
c4vPScBjXKe/rW777JyNtVaq13Zonq9yYWV8hNpO7NXQtbukDVnMd75j9EKmgMn+
gIPIm24H26m14MqD2l11tv0hdgk6l6YDraZixFVhKo9JgS0xVZAtugAyd+se5ZeK
Soj9jHZdKyEvyEO6dNIW28P54bJEMYJgtH0YMZyxPsMtedT+Nnm82+ey7Io5GZGk
WJEoq0K/ZYTYK1SchgeCwGGLU72OF1sq65VAf/tqJ3k1Im326Gsmk/wkLEjBOXBd
F81esDcgcPLzx0uEWFzFFho9Q9rITZvIMdDD6hAQUR6xIO/itARvLb2nFhgI3Z5I
F1Xzy9SeW80GS1YBlAzIh7QyLRpv3Gok3fzI7rLmzb13qzqblNdHo0iNI29DbyNi
5zUG7IOyfKyEDYfNuw/0BJxR9WLFdRdQ/kEPBiLtoTHjgUQKVoc=
=cIFP
-----END PGP SIGNATURE-----

--57JOLRTl9btT2rfK--
