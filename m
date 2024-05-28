Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A413E487
	for <git@vger.kernel.org>; Tue, 28 May 2024 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873240; cv=none; b=gDl0RZd9wR92vnna++8wRtxcF7sTvejkQ82iCfV8uOCjY0ApZnCdR+CR9QpVw2n8HLqFHF2Z2sJCol/VFOa/So5hjjX0L5KmSOkNEUYMuhEhl90QHyTuZqluUCW3LsQPY6zztkZs3mKNr8FX6lTZELBVA2N0ZoeFjlcfe7pVUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873240; c=relaxed/simple;
	bh=JzvWd++5wQEFad4s6Xx+PBRZqDxa0DSTqYwBz2cDjh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWluz5Cz4xstpM2U0ZRuAzDi9mb88sCWIfqHQJRUmDCFsEx1s/4x7LyGm3e5jAvgUPimxU8WFVicmwV5EqnOzgahoVpm13COmxuTro2+V781Lh7TK+oCE086md+ugDhAF/Blb8+1A70odT7HBR/qm1LEJg1357XbY6TyBDOaUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g05bE3aA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YE9Suxc0; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g05bE3aA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YE9Suxc0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id C95CD1C0012D;
	Tue, 28 May 2024 01:13:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 28 May 2024 01:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716873237; x=1716959637; bh=JzvWd++5wQ
	EFad4s6Xx+PBRZqDxa0DSTqYwBz2cDjh0=; b=g05bE3aAjKpLLMei9uq8N15tIO
	M4K/dbrw5wbjILa4S5sMk75JaqV1p2nnNWJjnoQ4yI9waMYr+wFOLwEs07aLLffz
	S0mhD+c50a1AHxKHg4LkuQHWBJ+4BbmgUEBPB6Em/U8Pb9Sp8MpvNvGi96GEHwSP
	dfRw8KuvmeXgfobBvtOI2B7hzGyQjwGGggM2zlRnhNkRHkVqsi/32PIeL2qVSl6y
	y8ixAbJev3N+1cXVuxuZ7uAGU2cj6ZievZXMxQR4v+xqhy1J91w7TKQGHuk2dRGV
	sYbQsg1MpiMx2Ct0ToxzyCVA0YIJCJw2a/LDdTFjMhbstq/TpHJnwzgBWDaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716873237; x=1716959637; bh=JzvWd++5wQEFad4s6Xx+PBRZqDxa
	0DSTqYwBz2cDjh0=; b=YE9Suxc0/n94tkP6PysMrgEyQn+1PlYypasQpBZGQHZl
	kYVPcNqZ1edToeXpgm/6Hpl6xhIbKk/b0hrh8QoZD6mghbM1DYzFJVhkRsyhrnpQ
	WzNtgOMcIQd/f+Zt9Sk1mJw9SP6hszwxknZY2J+MHx+Ax0Q8xgiwk+NZdzOIi/bN
	eK2e6g6OQps/WC3+0Ap0bjySd4MlVwVIOf/ZreDMME9gQDp9HMHM4OnCe7aNAD3c
	eHdqLYLc1LrnP3H6cQ3w0hd0bYb1rDxO83ijw1Rx97h3oMqnPOXH7WQp2x8l/Dbb
	PXs76M6ljpsF2vg+1EANylrRALCYoQztmPrFGEZF/Q==
X-ME-Sender: <xms:FWhVZlChqU_FmlyP2T1pExZWFvIYp4fLTEsbTwpjvkJ78av8bJjeeg>
    <xme:FWhVZjir3a8YVO3UqGVGMYzGkiLyufDvvN3_43PXIqIFBWo0Xzpjb_9KNIBluOJBu
    tGqwZ3ZKSHWaRXNTQ>
X-ME-Received: <xmr:FWhVZgmPNmiF_nlBWyHNoKjAWS1_GJpVFBlhaVY9Y4gUAe50VA8H7vCTlt1dafF3_wXvyJuVt3XbAKzeSxYDXrK1sVjdf23rQvCyZas-kbPslzkN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FWhVZvxo7FJ0RU7v7Y-ZUeIDK24Yjm2_8QZkGx57pcEsBOvk1Wn7sQ>
    <xmx:FWhVZqTfjkFX0C3_W1CFKWPsH_IKSzlt8IVsRMk6xsN3msYhLcapGg>
    <xmx:FWhVZiYt2Soj0L1qwi5XkQYXAtyfFP86i1zhPvuLu6kbyQRd0hNO3Q>
    <xmx:FWhVZrTurWI5I60x6Zv8tG5Ia7hT0RSWDcTpVwp8rWPC3raNk4uI1A>
    <xmx:FWhVZgMgo2ARO0Vzu0rIC30oh34CHsFcFYXnKmcZAX1s5lW60Kybd_X9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 01:13:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ac7e3693 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 05:13:44 +0000 (UTC)
Date: Tue, 28 May 2024 07:13:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] setup: unset ref storage when reinitializing
 repository version
Message-ID: <ZlVoEi2gi9JQSzSO@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
 <8b11127daf4c1d06eed4a0c83dd3dc981ffdc728.1716545235.git.ps@pks.im>
 <yl4wqgtcfapjxuknb57sevnoi4jbcjnp3l6vqa7criqv2upq5p@x4hm33ymxukk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+etIq/TZ7nwITumb"
Content-Disposition: inline
In-Reply-To: <yl4wqgtcfapjxuknb57sevnoi4jbcjnp3l6vqa7criqv2upq5p@x4hm33ymxukk>


--+etIq/TZ7nwITumb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 04:33:51PM -0500, Justin Tobler wrote:
> On 24/05/24 12:14PM, Patrick Steinhardt wrote:
> > When reinitializing a repository's version we may end up unsetting the
> > hash algorithm when it matches the default hash algorithm. If we didn't
> > do that then the previously configured value might remain intact.
> >=20
> > While the same issue exists for the ref storage extension, we don't do
> > this here. This has been fine for most of the part because it is not
> > supported to re-initialize a repository with a different ref storage
> > format anyway. We're about to introduce a new command to migrate ref
> > storages though, so this is about to become an issue there.
>=20
> Ah, so this would be important in the context of migrating a repository
> from "reftable" to "files".

Exactly.

> > Prepare for this and unset the ref storage format when reinitializing a
> > repoistory with the "files" format.
>=20
> s/repoistory/repository/

Thanks, fixed.

Patrick

--+etIq/TZ7nwITumb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVaBEACgkQVbJhu7ck
PpTtgA/+LgBCudlvpynljxXC6rxZgrTHOf0LAiLfebCb/UDgN4eivSz3d71qikZK
JE5Mv7iZv+i/9tNwWE5VCbYmBILLMBuh+JT35pYT7BEdRT0ywcO8J/TMRu7PWBLv
OjoQ9zPiP4etI1kSmtbWeqgPWz3xALdvoYahXGXcFh6jo+0MFWcLYIt6yQR2Hlnj
T+j4KIzbm1qXOfopzGOXFUWIFUY/mPHXHpC8ZVT11zrdchj3KSuELW4BbZGSckRZ
TYR/DSp5WUCkNo6V3umx+YmwAaYIyOydrK1R/8rfyjIN+GP65UBAEOHoytLSsUYo
XDBkrnzrYVg+rrq/4ARrCXkueB11aw88dnIg6X3g7MZr11gyGmfvv1QISUY5ueF9
xLeRc+UPiV4i2fuQPuWHBSdsDA8kSmM4vVyrRuplf+lPnOWq2ix6xqudDqyxpaVI
CkCEGEguGiz54uwm7cCGKxlufpqZd1i8oo3ZJBY+eHpXQZF3zJ3aCXQYIejtYNzM
J0GzaRnlkKe64RbOanXY/i4jgesRU0q8m0JcSPzq/1onObsv5MMr8XJLVwx0pepD
wChs48RzNi12hBTD4brsqacBaL9EjFsRY7wzP9Ai3048T7gfuNJwc0Bw/Ercyfam
LBfyrv2IGO3uIMoTJxITngMNmSDBZEXQoh+uy+wEKS/ufKl2/Mo=
=6eU6
-----END PGP SIGNATURE-----

--+etIq/TZ7nwITumb--
