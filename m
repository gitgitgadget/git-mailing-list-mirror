Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D417541
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850927; cv=none; b=Lnrwkdh1o5lXxapRH129ZGQ8SNh1wNkktLaO1f/5fhZm0nRl29ipQ9o+SudpH2YuVLTVr6gR00gFIypANsxo2iHSdUunwXlN6JtSaeiqVUy/FetXiTcTHNlbfKlO1+YPyhdBerPpIzTsbkgbEc59gfAia2tnygt0/7SiIo/g3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850927; c=relaxed/simple;
	bh=VQ/4LHG6/k9crYQnxhAjqysvoP0g78csMWgBH3pT5EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQHsY/6vWKoBP3bFQxnMPYLVX+jrMzBhKFa2f9nz05dFuNIarm7E9FhQj+AN6hoeCl4dDriodJ8l4vWxWi9+A4YQbmPFXG/gdfqtw0jAn+DnLTvf0RX3ZBfQjWtmdv6q3ynQmTpJJt+4XiXtz4CJ3DwvHZFa3kulnKGkeVpxtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sHcq6J+N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ki614Dhp; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sHcq6J+N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ki614Dhp"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9822B3200A94;
	Fri,  2 Feb 2024 00:15:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 00:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706850923; x=1706937323; bh=VQ/4LHG6/k
	9crYQnxhAjqysvoP0g78csMWgBH3pT5EU=; b=sHcq6J+NOyHJu/sGFIy+M2mgt2
	/Z44rKY9Ejx38eOfXRL0xGG3zaQudIHJPWlf7YTYnoIDIkPYpwIiOpAKsU3gdqUT
	JDzre4TpvnoZLuaSakDSqPS/cC3FAZBF0CFsmp+t5OKP2lNEq+ds9Iux3J5Kv8eI
	ha6PPUvYbwEhKI1IwVH84jbtQwt91Coaq9kHRyDNOXSvz6mePjzRChOn4gIZORws
	MdsSlcxiMKdGl7WsUIse8mGbdp1PofstwZzpXu3arZeiFabRQUlVL/HW4oScmiAr
	kxayQ0ictdflFxVtyye6ax2B2P4b3TMhnaax3Bcq1nFfm5mbK7weMeb6LkHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706850923; x=1706937323; bh=VQ/4LHG6/k9crYQnxhAjqysvoP0g
	78csMWgBH3pT5EU=; b=Ki614Dhp6xrlcheDWHVSzYZPKSBdRInut5PVH8lBaiC+
	ZFyJm6mFZyQyqAfbNRxBYtlGZQ7Um4Wjv3vgREAeOZQcSYe/Ni4+e8AjV2gj+MJD
	t8g/2uruEF0puknCg9RK1i42MySs+EuCaap3/af+BDzIcyILN7CRbIU+mLHUMEWJ
	CP9W+raE7/x48ISA78BCDXr1aUoVVH4vPbqDEczCqv5LsHNT1BS9EEiMRzikDrRA
	OYFx1G1YuJxGQl0//UYZku7uYvffmKb/H+4Q17HWmP+b8zDOQZ9qpRFUsz3Ww63d
	ulq4LPMzwL1l6OoNEnQ3s3tzJRM0nHoHWnSELI01xg==
X-ME-Sender: <xms:anq8ZZqOFrg4-Oobew765QeDnPLSS6NSc8pFbtMwXyZLYvI4-wQapw>
    <xme:anq8Zbovp-9m0f7DmgNNGcwFa6gsIKGwdvBkwZXC1VT4xmdWx0U08dfvpG17CyjlS
    T-NBSPQOFg3DtFwSw>
X-ME-Received: <xmr:anq8ZWPG6IH5aOe1I8ExUBeIvzgVNdcUG0X1uQlOdyit2DB88HtM80C1Av8ZnkFIuvcawkCHNfJEbeYUWpAJEUnfUAV2sptxo5M64c_U5MNAiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    etueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:anq8ZU7WgHRJYkjYElCOICBO8c42bA-c6wEdNIReoz2-wNKFjNx9Sg>
    <xmx:anq8ZY4XkcsovQkqJjrXJc1FREQyuDcdyBol3IW-_U97DNEUtBRkmQ>
    <xmx:anq8Zcg3v2PU1u8wGaki8uDJeC5Xoy3mbzVAx9JIZkWZJq7mk_bZHw>
    <xmx:a3q8ZWQdU5B97H6Jv7V_Apvm3NCCvfOKaUDtsrNYsFnM8SqQ-Y8GXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 00:15:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4046c8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 05:11:58 +0000 (UTC)
Date: Fri, 2 Feb 2024 06:15:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] reftable/merged: skip comparison for records of the
 same subiter
Message-ID: <Zbx6aDzXpYy4Is2t@tanuki>
References: <cover.1706782841.git.ps@pks.im>
 <0ca86eba710895f0e22fc15fe5221f5487031f64.1706782841.git.ps@pks.im>
 <CAPig+cQwgYdKCHnu1TUj2JYyQkRF6Ey4hw1MvAVpfhqcwjV04w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uTDg41tKZ+8iG7X9"
Content-Disposition: inline
In-Reply-To: <CAPig+cQwgYdKCHnu1TUj2JYyQkRF6Ey4hw1MvAVpfhqcwjV04w@mail.gmail.com>


--uTDg41tKZ+8iG7X9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 12:29:16PM -0500, Eric Sunshine wrote:
> On Thu, Feb 1, 2024 at 8:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > When retrieving the next entry of a merged iterator we need to drop all
> > records of other sub-iterators that would be shadowed by the record that
> > we are about to return. We do this by comparing record keys, dropping
> > all keys that are smaller or equal to the key of the record we are about
> > to return.
> >
> > There is an edge case here where we can skip that comparison: when the
> > record in the priority queue comes from the same subiterator than the
>=20
> s/than/as/

Thanks for your corrections, as usual :) I'll refrain from sending a v2
for now, but have squashed the fixes in while I wait for more feedback
on this series.

Patrick

--uTDg41tKZ+8iG7X9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW8emcACgkQVbJhu7ck
PpR4kw//X5WUxkXFkl4x/FDlAI4IfFtH8cDUPE4qO/Ko9q291Waal9BKzb92lw/1
0aEoEhq7rU2NyPl9v2Oniy8rv+IFwn7admQ1FSElVyyqunLPQjSLqNjT0P6aRiuc
BDrFlLajby7P3AOFcyocJHVnw5lGqgqyehWry+sNS++ymi7XvRBU6LcbdadrYaY5
q7RLStJE861VWN/pK++jhlqp/lQCNJ474Vdxpa9jlfSKe82k+eBM0qlk9rLqX2L0
rSkn06H32gkr/9HGYRZG6HdbBR5uigtVeYbeZsUqbQwHK7W0c4/zJpnKEMWL0c0r
VwZcGcbxwbd3DVsfez7mpAN/u00+PFqf6jR/+qAlzPlagh/1LcSNP6MId709PDa+
lGmxPaWa3lmNA82yXIFI1TmjA+20LQK25vfTTtV+FiWgu+t31FeZagWlVQcBZW0t
3ghZuzRjPgLtpWDSium5f8FN6u98ZfeaeMDKo5Lr4zb2MPwXHdk0v8YaDjZycdwg
pscnQoRBqg7GR3WnE/Kn5Vr/DVR7dZzjJhiC+jGw5K6qY8A/+BkSzH7fFZt0yIHP
ooLcqjov690Zk0y3GnrAyZYRsOjANWwm8r1N9eNiw+LDqHDNDPZ0d1SNlBcaWLT2
pkMmbxJJy+G1R9Pu7tzqXHcmfYxOQJe3Ayhq7YvWibAGPbKbCDw=
=IkhK
-----END PGP SIGNATURE-----

--uTDg41tKZ+8iG7X9--
