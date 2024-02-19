Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD061E514
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322951; cv=none; b=ncQzWxlM/RZmU3QOTQhNjEZNfGJWbbzQvT1SGdWFI/UpGJHT57zmHf3mDhUy3j7gLtOiCLQ5EoHOK1dyVB5apBwov427XhP0yGbOyBNlndHuLo6w2gG2lLWp09ooE/XPJjndDLw4adr+cKxzj4Y4IQZtiSVK/S6RECGRtLOt93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322951; c=relaxed/simple;
	bh=OgGrqGQJjdvO+GTYEtWtBajIVbxGdmKE3BY4rxsdEF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIPQEjldT0E3kGFDyiaLapR/+nbzL0jGvUkMvYccPNW+DW14Ob67m6bDS6xEBO5Di3zl4YXQC5y0Y4v9yfwdYiF+/KoGd+xGOjqg3hRhHW5wONUvamj1olcMpR/DBhPLTt1JpQxIxvK3+8fpwf2Zizu2hZb1rPhim/se1wNvcUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SbW02Nnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TiOjTutg; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SbW02Nnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TiOjTutg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 0AA60320099B;
	Mon, 19 Feb 2024 01:09:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Feb 2024 01:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708322946; x=1708409346; bh=eBEukXAf5a
	AsCtuqus3OMjOQ/b6+LkhtS+tuBMXSiho=; b=SbW02NnnFiG+BtJohXBX4wDawD
	gsApmpKtqkineOoGw7yHwuEyWZXaWq3PMvVaEu4BNpewK/RivwFK7vYZcRPDy1wz
	o1mCBE9WhltXcdxYwyrA/+mwfig4BjQGg0ZueEchkmHxvueAi9ThXKddP/eFPWW7
	F/P16r8nVOYJE/Sn6e94KSM5gIspEHWCRYFLGP6GoztJh12uJq4t6x+Wcis+LcRJ
	uQGWCArGzBXE2hMNTLcmUzawj1QD7YESrIEusfvzuAZn1fUcmimheRsc2HwxiZR4
	Haekdnb6zFagV63XqttFHNsyaIWCx0ZR9pVLJ/SSccBYOYt9Trmo9+cKZqvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708322946; x=1708409346; bh=eBEukXAf5aAsCtuqus3OMjOQ/b6+
	LkhtS+tuBMXSiho=; b=TiOjTutgxztTep9q2MBrp9EsU8P/TdbD+WUvmk8YzYZq
	LYu0nO+tQdK/OQpVyqGBE1H3sr3rRiMpeQmloTOaoTd7EuqgeqqMipJqDpnz46v5
	O5OGAUWSemj+0UX9j8DIPNyzmhKowSKt6vmg6UKwcBuszFXH+gf6iKek3+6z3dSx
	rzMP5OJb0HSqQxnl3Irvnv9Imxcb1zKXlZLiwO2De406uTInQfHLPikZEVNVjLwc
	Sa5ggiwBH6UE5mPahEhRQhSY2GDuN9beQUpGgF9e5TV9tmH1vb3SPmubWiKPnpV9
	if6SVr3u04GYIedZbtzZ9KTh4BcoFL0KN0OMYruOxw==
X-ME-Sender: <xms:gvDSZaJpmQpp86hcfe0pWTL2g2E6pAw9AvftSTaCzNzcD1OurSGG3A>
    <xme:gvDSZSKih30j3DWw0hRAarS0NoEduQeGEcScj2lWwNA3cF7Ll19R3sTedzlBUIAGH
    gY6XKv1or15DT24bQ>
X-ME-Received: <xmr:gvDSZavsIjloux73wBYt29nlVE6901fALXnd1uP5Btk2WekrnkmayrXBlML6CFWr1FCHkDp6thyQKnIgPSfoFGjtMI8IsFZmS7V79VkZjpQAbI-P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfevleen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gvDSZfbSB3HIszvj3sYxL_hH88A4f-OCZ6dwKtgD7qwopvEThszxQQ>
    <xmx:gvDSZRab6TLUe0UwJgKpPu7grtKLavA4LW_9h4Xa7P68bh4jNHPiNA>
    <xmx:gvDSZbBo-xvCQyl2TnUkxZw8MTLJdmN3Gq4wBSx8J2rSjenEpbUU5w>
    <xmx:gvDSZQm1aHhYurd-v3eXsvFEVA8AkaFeyOPm4N6OgWW_zazK46ypXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Feb 2024 01:09:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2a43384 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Feb 2024 06:05:01 +0000 (UTC)
Date: Mon, 19 Feb 2024 07:08:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] libsecret: retrieve empty password
Message-ID: <ZdLweyFLDtdMAq2x@tanuki>
References: <pull.1676.git.git.1708296694988.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vq/Km1YizR7A0T31"
Content-Disposition: inline
In-Reply-To: <pull.1676.git.git.1708296694988.gitgitgadget@gmail.com>


--Vq/Km1YizR7A0T31
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 10:51:34PM +0000, M Hickford via GitGitGadget wrote:
> From: M Hickford <mirth.hickford@gmail.com>
>=20
> Since 0ce02e2f (credential/libsecret: store new attributes, 2023-06-16)
> a test that stores empty username and password fails when
> t0303-credential-external.sh is run with
> GIT_TEST_CREDENTIAL_HELPER=3Dlibsecret.
>=20
> Retrieve empty password carefully. This fixes test:
>=20
>     ok 14 - helper (libsecret) can store empty username
>=20
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     libsecret: retrieve empty password
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-167=
6%2Fhickford%2Flibsecret-empty-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1676/h=
ickford/libsecret-empty-v1
> Pull-Request: https://github.com/git/git/pull/1676
>=20
>  contrib/credential/libsecret/git-credential-libsecret.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/co=
ntrib/credential/libsecret/git-credential-libsecret.c
> index 215a81d8bae..d9e9e4fd524 100644
> --- a/contrib/credential/libsecret/git-credential-libsecret.c
> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
> @@ -164,6 +164,9 @@ static int keyring_get(struct credential *c)
>  			if (g_strv_length(parts) >=3D 1) {
>  				g_free(c->password);
>  				c->password =3D g_strdup(parts[0]);
> +			} else {
> +				g_free(c->password);
> +				c->password =3D strdup("");

Shouldn't we use `g_strdup()` here, like we do everywhere else in this
credential helper?

Patrick

>  			}
>  			for (int i =3D 1; i < g_strv_length(parts); i++) {
>  				if (g_str_has_prefix(parts[i], "password_expiry_utc=3D")) {
>=20
> base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
> --=20
> gitgitgadget
>=20

--Vq/Km1YizR7A0T31
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXS8HYACgkQVbJhu7ck
PpRy7Q//WuqpzUCKtRpAp7a8XMTXkdTIqkc4js3tfy6NddRBRL5M+2V4MH95KgBo
UM/RXk6//SjJ6ml1lnGH3LcbxuUROj/2rumQnyW6SqgA/dCKQDzea7enrGH1V7MN
h/eSOeDcGO43poVsjFlwWP/dhnatbzj1cKWF+fqaLMMTGf+JuZoj1mvfzw3RvR/R
xRzmOKRqom2EOo0tF4OJGBTed4M1JmWHzpmJ9CrnALFpa6YyzlGLnDSPKMMtHtcH
R2zjSZSpbTbVEyt063C9ljWTwTHUUiVrBsoiqhs1wYcYLxlk5f+mz1Tvfd1yDa1A
av9yDaC1R8jBDhqUiudN/WCoHmurjThvGRa7w2xCK+cnF/fSfpK5Y39CW6mqzCaF
cTy+WIF+aC7vKiYoMajuqLeHHoCrJm3v7bkufMIF7HmXM442cz8YiNuJXxL/tr2Q
jedTZbOtEOiII3mw1JaQNeIvy7lmZIfA0tIJveOqelCDntvuDOJ/HJJ5OotTxsur
27YtUACrdiQLnxtEofezAqlPSmnEZwhwCpEjqGQTQqq58hKCzNROtnUhvUYHsQxY
BngAUj/BxrMXgOe91mIob92mg91172SWelY8KLIp8Oo1tILjgtGHBb+HaVhtNuke
l+9jXbAwSJoh2x9298KEQSsbMnbr2VnyTQ9O8rL7nhgMmNo+398=
=daPJ
-----END PGP SIGNATURE-----

--Vq/Km1YizR7A0T31--
