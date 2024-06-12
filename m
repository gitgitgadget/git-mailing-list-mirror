Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E1F12DD9B
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177932; cv=none; b=Wao70kELUqkV38ynD+DvNoaaQyU+6DmmjLae7JXTKjc6wGPAzGMV36mNtPxMTtfMDmRW6bmfLHPa9AAuvevTlU7c+xIBAKeP7g5RRBDlky9D/CnkOARyc9DwhmYce9udbN0V1U/nwV80W4SYVQlTcDNH/O7yp7fChl5QfWMA7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177932; c=relaxed/simple;
	bh=eAFp+NJr4FFyi9SvU/3P2GszYsbBvzW7sUiSinQhxE8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9tueLG+LtXuhhaBos/SOboK2HPvgQO+06fuju6cGQNiQ9Jh1NwdJmqTX3oiGCW2fXkNL3H3xd9w0IeBJ4v3cCKabDse/XLcDnTjdyxQbVhs94vB35K2SAvwkB0/7BL9Jr1+qtrcxJ6fx3oWmaZfWMybB/TtCk2LH4NnZXsN8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=krkwFsjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuIDkKlJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="krkwFsjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuIDkKlJ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C8E5C1380159;
	Wed, 12 Jun 2024 03:38:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Jun 2024 03:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718177929; x=1718264329; bh=Iu1jWVNr0q
	WpZGopXFRTp1yLTnoJ5xxu8lpCFn0hdug=; b=krkwFsjxnHSgpC5thZLl8l2sWV
	Cissu0RNWNpUKMkW1GtufroDrnVSbzZ7BdOKuIZMNzmS0rSDIwlHu7QXx7FD//Y4
	SyKT9GRCebmwXMVH8LBjcqd4CN7G2ph2RHL2x3k9DSHfg1AZQsGzsmCpKZlnsalY
	m8CEO7b44qSUov27AGY7He5nOijZRtdSBSofn6d0tqq7O40FBGziap29dwPmFplO
	MmAF0H2EsJI6TvNEzu76nG/U6GKNhIkXHzN0FLvTHhHoxBjQph1XMQMlqLcBEB1g
	Qr1NywDCFSrDidBDkObFA3v6HhxXpeyXHqWlq7galGt0WBzmW3dCWYJv6ptA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718177929; x=1718264329; bh=Iu1jWVNr0qWpZGopXFRTp1yLTnoJ
	5xxu8lpCFn0hdug=; b=fuIDkKlJJdBAp4mx3MOFFMsk1MhOBIp1810b/2sGwPfy
	YMNSwbjRHyToEpypb+ZTvnXwhTLHTyMTcWKOVB+nHRd+Fun/tbP2FvUAprOORQPk
	05x4P6ftizFLLFITnK2Ui2AP6L6h6c/xjiJnzxSFlxuHxDV4bYe5cowt+UYbqVRq
	rEk8MQ2SQnoUdTOlYHydiffRgDHTQxrUTCAt3DHKKdfZSg++55ekm5eVK6i5Gqyq
	Z8qTfuyKAhTpcrTS19nqxrL2katt9kym+y9BYurRmVCM08s6UovtzYH82+LSgi3x
	/YS7/XmPcH2lV+JxpKJQdv4ACSZO/OeALL7dWk2S8A==
X-ME-Sender: <xms:iVBpZqwTxpHRrO1P1Fb9nnQIcILJSAYqrb0oxIke1MlUJu3mAr6AvQ>
    <xme:iVBpZmQEiZnuJQYg5965GwJGZ1EGP3cP4CsxoDsHOt0uuLlDVtotL6BL6GggFlYCk
    hto4LQkDk2GusllZw>
X-ME-Received: <xmr:iVBpZsUO2TSGXzAI76CPey35DhBEA7yQimXuj6Qjh2ZZekhYUxB4kW_-oPThKUEiWwmAfAjca63Wh-DpsM_MtOvcivcHsXlxDx4RaZn6_MuD0V6cRwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:iVBpZgi0LzwjifSbZF86E7wA2-iLpu2tUpVCFDVaxppI3DOkZ9WYug>
    <xmx:iVBpZsCbsp_ZkaoyHS_4L_UPGGbWf8RbKekSGedksLaTXUsk-nuvRg>
    <xmx:iVBpZhJt4QxO0ZQ7C8mJAFAmJNPSs8FDI_oNh0Ypg2-rCxoXVIWNEg>
    <xmx:iVBpZjAuL5-SDyg6Vsn-ZXVECbFGgzAJHZ-VJVHYGgr8aLjUzIbMag>
    <xmx:iVBpZvNgTQT4KOZAXnvgWcKIuZ_MtK8T4KynhBULW3X1ixO_XSHK4DmT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 03:38:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3412206d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 07:38:37 +0000 (UTC)
Date: Wed, 12 Jun 2024 09:38:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 19/21] t/helper: remove dependency on `the_repository` in
 "oidtree"
Message-ID: <ZmlQhSr_nCM-O7IT@tanuki>
References: <cover.1718106284.git.ps@pks.im>
 <339d668da837ab5b4b11399ece4efaf5bc27d313.1718106285.git.ps@pks.im>
 <ZmjbJU1Rnnx0ggHt@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hXuZgnkKzAJNFtEf"
Content-Disposition: inline
In-Reply-To: <ZmjbJU1Rnnx0ggHt@tapette.crustytoothpaste.net>


--hXuZgnkKzAJNFtEf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:17:57PM +0000, brian m. carlson wrote:
> On 2024-06-11 at 11:59:01, Patrick Steinhardt wrote:
> > diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
> > index c7a1d4c642..04ec24cc84 100644
> > --- a/t/helper/test-oidtree.c
> > +++ b/t/helper/test-oidtree.c
> > @@ -30,7 +27,7 @@ int cmd__oidtree(int argc UNUSED, const char **argv U=
NUSED)
> >  			algo =3D oid.algo;
> >  			oidtree_insert(&ot, &oid);
> >  		} else if (skip_prefix(line.buf, "contains ", &arg)) {
> > -			if (get_oid_hex(arg, &oid))
> > +			if (get_oid_hex_any(arg, &oid) =3D=3D GIT_HASH_UNKNOWN)
> >  				die("contains not a hexadecimal oid: %s", arg);
>=20
> This is not a problem in your code, but this might read more naturally
> as "does not contain a hexadecimal oid" or "contains no hexadecimal
> oid".

True. I'll leave this as-is though given that Ghanshyam is already busy
converting this test to be a unit test anyway, so I don't want to make
his life harder here.

Patrick

--hXuZgnkKzAJNFtEf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpUIQACgkQVbJhu7ck
PpRX+hAAjXaEsNx3sEAvyUCH9+q2NSgJWAWzzmPtExDCMrsDhyMGHvgOkzIv7BQb
vJIO6Iw0M0mYpjNNX+NyPG45+8eJtKM2WHW3vbGosq0uC5hDZOITraKpTR4XF4vz
vlHqx0vfuZ3WvVsjPm/qu65VVDwdvQrq0dHGsZLzEgEbvkzjanvySaTvtd/u70uM
NhqiBI6H9uM8VT9XOeCepiz0S2C/bL8raxWIk5NUw5D9LAWeayMMqZfS3hT2NMWe
PvmUfTjqpg9OwJ1ztoi6WRqrjPo+zjJdrhQ51eQINRBJJfQfX0z+goq9AgP0ZJI0
qn0qgzzqE7HDG27zeVHXjKHWasZqrnKMOcVL/OqGxZEWUAQDuVH2goou98FkGXne
RwHSXxlW0O4ZjT680vkTAuZ5iNNSNMgOfbdxRb7qgXOS+m/Ila7sun97HSw20TMl
P8sHtkkYi/eUGajQW9mqwuStEnbzTJzcauHji7T4OgZ9EdXSzC0Oxft+I1vhF41j
ikLGjtsgoRNoIYTcPQEONhJf/326dgKquwcX1PgIlDgBX8Id6Xej8nNZo67nK6PM
wVoeI7Qk+89qr603KWv1oxawQJF5lLrhFKp8cfSFKClZc/fQ5Crh4eollPoPtRZU
n9DC3SPe+C67Y4Eh/v0w57UjsPyzr5TFfOh2uHG4ly/mrb79TXc=
=h/bO
-----END PGP SIGNATURE-----

--hXuZgnkKzAJNFtEf--
