Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2F24A22
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792251; cv=none; b=HuH4L4Bz9DNQmMd+O0f261rCB7QngxZpK6dq51fzVtq5NGaezVwHetlR/Izu4MTofmXfjdGbNhW6YwpKUA81sZgufqibpbOvLU32K+8p+FQwjF7XXdBSFEJn7VCDtzjQ5zy3cwS6ImDT3ByvrYRgrCHMH2z++SDW2Bvt3iQYBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792251; c=relaxed/simple;
	bh=WkMAKkoNDgcskV8c7R6DtEXv7B2l305qh5Pasirza3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrHMcjxnWX3+7LO8ZMkbp2t4uEBKFAAd/bpp7o9m2k1WQcjTe1TR3vxydvUBw1U+Dgx6gDM+Sb+xvtFdSvHEAu9gzLufQtLvBmY8pdu7t5y+yComYDUpJas8dsTadz1ODMKZ9d7ORS2Dp61vFYArcgb+e4GEAJ55wCuPJfnxnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fgIhT6Rp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=imlCDA6n; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fgIhT6Rp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="imlCDA6n"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id AA5651800095;
	Thu,  7 Mar 2024 01:17:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 07 Mar 2024 01:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709792247; x=1709878647; bh=WkMAKkoNDg
	cskV8c7R6DtEXv7B2l305qh5Pasirza3Q=; b=fgIhT6Rpsv6BdeBRD8R4BFGn24
	zKTXq0m7lSBWeh2AD8XjYY62W9J3CDQYjhJ5tVYTkD9ZwfEjxQRLYl6ZC4FXkRjJ
	y6nNmUvsVLhe5uS8L4vWmgE5VWlxtKKQLGHzQVTyQV51lyeQ4s01urhqB4urHCY0
	TSIw87XKvIJxF07JyKqYGlMWk7dGtDe8mWQsjDCUF1vi8qGSKhTbsb/EvyvY0i9f
	n9AZD3oHWi8hUUBe+BRNl2CZilVOi1whW6BkEqs4ndrZJON8Z5jXu4EqB20djcBz
	23GsLvN4+DlL2M42jYh3re4hc+uib3qNW5m6zLfTNHo0aqiYLyeBcEOB3s0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709792247; x=1709878647; bh=WkMAKkoNDgcskV8c7R6DtEXv7B2l
	305qh5Pasirza3Q=; b=imlCDA6nkwvj0a3TUpNl9l790ceygrjxrFcE2PGzr2cT
	fJcCerJ7jojdWeOpL5ag2yo33wNbCVtcGDR6uthaLKKoBiuHgx834HzY2Q/2+e0z
	fnwfrI/IyFXvh5l1ArNE0E9t+FSvnrMFHjCNKxZ3EVcfqAURH1KA1dhe5SByb3kJ
	VhmGCHA+QruxAZK9OVDD7SGjVfoyNcsojhDG9wE2RYDzta+cG08hspKPS1KEMT4O
	5ex4QylVCbghGxUNaBqH7FWwb/1iIMmavNHHFI/gk6CJ68+fo8lzY1ZOAtR96hFY
	dCswyto/4HdGgR20ZJpRNXENHBiEFVEG0QjGqOQl6Q==
X-ME-Sender: <xms:91vpZcYqUqD6O4Beu-U4tSQve_OvIj1ZY34X_pC5sQLwU3PYvhH1cA>
    <xme:91vpZXY26H-hNcpdLDHo715Q_NGAFdu6-CAzNHnhi5-rk99bxC7qZL6NhdVDCVC9T
    fqWyOJCJe9sLFTSsw>
X-ME-Received: <xmr:91vpZW-M9ZaYzATj2-A5E6srap5DM_5grF4W1QPcewOUaAPM3vlI3E99QvtYNYfdJRKzoxMgJV5TKnc1fLA79f96suby80qPQbGUwjNnYctXig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:91vpZWrx79-tLc1VTDH1THgOUBUIFRhQ50tsmDAYbihZFLpvyLEQ7w>
    <xmx:91vpZXrKCqJl7wkzRPqLHmtns2fCrFslxyLHoI-av6mrKmYlGrG66A>
    <xmx:91vpZURu4KU82ibaSNrBuHk0r8B3IbR_C21ZCQ8MhMBjomQJwOeyQQ>
    <xmx:91vpZe3skl1bSdtkBjb-_zCu4S2-x01SoYfi6eDJTwhrDhYs-jK-f1-h2ow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 01:17:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16065e96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 06:12:53 +0000 (UTC)
Date: Thu, 7 Mar 2024 07:17:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] reftable/stack: register new tables as tempfiles
Message-ID: <Zelb8ldHh4Lnlh7Z@tanuki>
References: <cover.1709549619.git.ps@pks.im>
 <02bf41d419efd00e510a89a405e1b046b166ba20.1709549619.git.ps@pks.im>
 <6cw6d3ubo2kbogzdbniyoznij2zfoh5t3htwb4oaghaltcgeqg@kkrw4g6atr2k>
 <Zehav4V_8GGZG94Q@tanuki>
 <xmqqedcntj06.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oHdh6gDf+5aRrctb"
Content-Disposition: inline
In-Reply-To: <xmqqedcntj06.fsf@gitster.g>


--oHdh6gDf+5aRrctb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 08:36:25AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> Since the tempfile is now being created through the tempfile API, I
> >> think the file mode can be set directly through `mks_tempfile_m()`
> >> instead of creating the tempfile and then using chmod. Just something I
> >> thought to mention.
> >
> > Unfortunately not. The problem is that `mks_tempfile_m()` will munge
> > passed-in permissions via "core.sharedRepository", but we already pre
> > calculated the target mode in `config.default_permissions`. Thus, the
> > result would have wrong permissions if we used `mks_tempfile_m()`.
>=20
> I somehow found that default_permissions thing always disturbing.
>=20
> Even if we keep a separate mechanism for determining the file
> permission (perhaps in order to give ourselves a better separation
> as "an independent library" from the rest of Git), shouldn't the
> permission setting that is computed by the mechanism and stored in
> config.default_permissions be consistent with the permission the
> rest of git computes based on core.sharedRepository?

It is consistent. The problem is rather that `mks_tempfile_m()` takes a
mode as input, but still ends up applying the umask to that mode. Thus,
using that function without a subsequent call to chmod(3P) would end up
mishandling "core.sharedRepository".

Patrick

--oHdh6gDf+5aRrctb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpW/EACgkQVbJhu7ck
PpSdkQ/+K6HXMzmGCJOQy0SM9GobO/NdIHAuaceqnGNZdBLlxrTVdU629q0LI/5k
9mR20d6GQ7HVugly3ItAcND69V/8HMqrFQ8ZK17h91YhDs6mxZew+tUjReCoBVbn
zF9kQKLh0jGqGaVp9hfNEAY05pIeS0NDTpYqNAZRI0kAaGecxS/MYFGLvWEjo/Dp
AIAeIIGuUpmv8OMQq2OUUu91SUB71mcR1K1QGwHo3Z1XLV/hCGPI/pz1iRDVJEvv
/tXzYhjVLk9A2iFnP2unT/whjBxhh6DCUMBhAhaLTpOcNamzG1aCC9P+z+u+gKK4
ZOP1+oZkgTzTUGOSFSaDShzNqFof91H8smuM9Til7hTji9r1BeqLrNOxMI40lVJz
E4gNtAjzJ5EASltOLa3ItQ4Li/pTtx8lm40ii9x0RUvJ4JKi3fAjn4Kd6Ldl9Cdv
FNvUjVVkqdwpEn1qEz8MC26QBmKqmR9ogWCxa3NWk+P/7AH+IEAU+SWOix403j4m
r2MddAPyIByD5rUO0vaNix5lrPGAO2PIh4WMfUHjJJg4/JNVtqF1m7Sb8Nn3JOmu
UOjM9vH3wsyBq+OjVE0QZJcRp7ciDG8i1Umis0Ufdtz4xvWJTwQ7U3joX2/KkhQ1
HIKJh7k4mJyxznoh30Yle5mE2OBe0HNJg1PjUeuVWE5yLjniu7s=
=U/B/
-----END PGP SIGNATURE-----

--oHdh6gDf+5aRrctb--
