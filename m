Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0936A17C7C5
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111691; cv=none; b=MOd9CjGcwV0IlbXPXVc0ZCqViYxdqSm+slZ93nu6bs2nbFW1+Q3nxJEo6JaS0evNZAcYu9AxfNzyNPD+th2Pz5ZwKYb7UCDeC3eY0il71G+doNEkDjUl97JxLf0I981uRGne5aj0Xd74amvm3h4FMYVSBQ9bcDPGtw3D9oRKO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111691; c=relaxed/simple;
	bh=f+fLI/aNOmbpwMVq5dGe372Vn8tbzecVKEfPVWOCw5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdbPpJ0rN0Q7F//QwCTLSrobvep0p8QNtXFamDx4ZTLMNIgZnItXwIHSEeW0PiTfXVLBN17ow0OFm/IOd3wIuoKcF2LvhQvvCV1uxuwmxQw49UlVEXb7FZV9aTAkz5izhX39Th1B86BJZpF2z2oiFwrIP8u0BhdvSti6lYjAH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dHQ+fBcn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPUSk1e2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dHQ+fBcn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPUSk1e2"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1A65813800E5;
	Tue, 11 Jun 2024 09:14:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jun 2024 09:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718111688; x=1718198088; bh=qgx/M/r6Dl
	jrGK1XhS1IdRzmiX9abJ7tvgaZ5I4Y1nE=; b=dHQ+fBcntD7dw/ohrEYEvxBn5V
	amoziCkOryXKR+w8RAKWhDhF6Rs4bEGOosisGvQ85cxtJrslZQGikxTym993X4LL
	AonGoHydB4A+K/UPcoZ8bsJT7Bk4OjFgioqStVar0ILmluEuUVl4SCBIQA0MyRJb
	LtC2eUIwumDyylRVJxpv7I54d8p5H9cDFHEdJPLjDdQQYrAaxQ+wOhqVB9QWDR3L
	T5Tyu9c8a9nm8YIyO5AFVVrwZm83gw+vSu84G5CtjGUnz5vnl9JQLl2MoIfmFII6
	YZpBYNEgRTjf+YoalH/SdLYIjN6R7RXaHZAqnkGzBOE9fa4qD7Idrn0dQ9qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718111688; x=1718198088; bh=qgx/M/r6DljrGK1XhS1IdRzmiX9a
	bJ7tvgaZ5I4Y1nE=; b=YPUSk1e2665FSx1GJ/Ltp3yMih3eWkgjmEbf7E6wl6YF
	rZ4gVSgGJulcGSDd6Hpo/qBI+UbBHYvr8KB5UHwjrIDPQTdZl0SPSMoEsxQu4P3J
	SwaQMrqTeTvyLXGScr+U9kxzue5NYfNCAsdqHddhQ+qKI5Likf2nYOPlaXa1hzpb
	vidut02hI/Q2iGtSWPg1HGl59XQPvaMoEhHINn+R29lMagFMiJUxwIc4r4QYv8Yl
	EnZcjPLj6m6Rb1yQqNNq+AyJTMToRqE2njxS4TkmldNK2tyLAjk/F9hfZYAollUp
	MD0etJv/mJ0l+XvRvAOUevD5WEss2omSvikvVqDHJw==
X-ME-Sender: <xms:x01oZoe9Qz3o2kRI5oBKdsExwHZRZeP6HJnPI0CnftuZ2VUZjO9PLQ>
    <xme:x01oZqMYiQRH_hKRLQ-N-0mZPgFPVS34Fdq3MR6XuGq-dzqG_BnrcyOicEodo8ycg
    aLHyVo4cLNJdtPK1g>
X-ME-Received: <xmr:x01oZphHJiKpKeexGCPbC6x0SRMwnzwC7Re23qZFtQexL8u6agqr1B3_ol82nz_E0es2CLfZHIzLZvAIFXR5FeSE79K4LDV9fgBM4uGe6_tJRo0OUGf3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:x01oZt93ogPWQC1pMD5MP6TxHjcpwk0ZS59euCugf_qLGB_i2JQbCQ>
    <xmx:x01oZksot6OvSEv4MeJNxEODJ_dAn1c8M59T1AVLda81w6J_BLawCQ>
    <xmx:x01oZkEmOvMO__ih7lkR6I_SNDxUT18WTJqySzAR17Pk89p85sETiw>
    <xmx:x01oZjNBquKZcJMA9lK_cEEz4G7O7a2G7dii2R9dYy031XP9G0Fz-A>
    <xmx:yE1oZmKjwWQlUHf9zlr5PD96H8EdJLZxcKIydaeFG5czaYYREL3zTqZ4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 09:14:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d2dbf360 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 13:14:34 +0000 (UTC)
Date: Tue, 11 Jun 2024 15:14:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>
Subject: Re: [PATCH v6 0/3] object checking related additions and fixes for
 bundles in fetches
Message-ID: <ZmhNwevTExnbvIdH@tanuki>
References: <pull.1730.v5.git.1718088126.gitgitgadget@gmail.com>
 <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fHE0vxg/fVIJkx6R"
Content-Disposition: inline
In-Reply-To: <pull.1730.v6.git.1718109943.gitgitgadget@gmail.com>


--fHE0vxg/fVIJkx6R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:45:40PM +0000, blanet via GitGitGadget wrote:
> While attempting to fix a reference negotiation bug in bundle-uri, we
> identified that the fetch process lacks some crucial object validation
> checks when processing bundles. The primary issues are:
>=20
>  1. In the bundle-uri scenario, object IDs were not validated before writ=
ing
>     bundle references. This was the root cause of the original negotiation
>     bug in bundle-uri and could lead to potential repository corruption.
>  2. The existing "fetch.fsckObjects" and "transfer.fsckObjects"
>     configurations were not applied when directly fetching bundles or
>     fetching with bundle-uri enabled. In fact, there were no object
>     validation supports for unbundle.
>=20
> The first patch addresses the bundle-uri negotiation issue by removing the
> REF_SKIP_OID_VERIFICATION flag when writing bundle references.
>=20
> Patches 2 through 3 extend verify_bundle_flags for bundle.c:unbundle to a=
dd
> support for object validation (fsck) in fetch scenarios, mainly following
> the suggestions from Junio and Patrick on the mailing list.

Thanks, this version looks good to me.

Patrick

--fHE0vxg/fVIJkx6R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoTcAACgkQVbJhu7ck
PpQmkQ/+JBB4VXh/ek+kIeImOZcL5R4CeomGN9OhtnhkEat3i5K3v4wBrGfmdNp8
eFIhTD9myAh6kDs7Z+vumm6a5qr96/NQKhrieATOyv1jUee10OuJKoJ4PZrPMhgy
2xOIJeHYZl1iZ8DK4WUec70E1twlQo6IVLSdcHSBMAr/sz1cznrOPDuUIGtlc3Gm
w/KGI9uWMrjN4AsFnBM9Rr/TX5MS/RQquQyKDhZWMFCE9Vk9XRKbngQMZV2FGgKd
4dweJ2uLw6YZz9PIntWVkjCdUY9uasadbmGg1xojwOoxSYPw9+e3voRXoOtyjxxi
+nVLtJSKw9Tsnk96dlOjShUOh5gr+x0Db831pu4dpqYwwsuBtcVEbSCQaV3KrhBy
Iw80xORrgp04pkuvRX2jSw4qmlmW/0h5DBWtz2/OFUV008Bu+H+hTK4AydzDMkLl
lwcdSbv57DFUz52km8Ba29ebjmX9mFKI+nguJxFuGP7P96s/ig8AuqFFd7C7WY3g
ZOuE/eIeDV/x/SMvkH4zWYGeDvhZrSJRPORl+si9MH/LrHYsxKDcifAVqVVAzaBf
PkZ3FlUK6jGbuyOHjR19tHfbsAr/Bb4kzfrxlgXJhYQM6Oj6uBjAkI8C1rR4SKlE
VNzFindjFY6KybojCKod/xipFkAduJfOfOY05XM9eu7aLlPK5pQ=
=QkpD
-----END PGP SIGNATURE-----

--fHE0vxg/fVIJkx6R--
