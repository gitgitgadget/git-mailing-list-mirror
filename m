Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB1154BF3
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713936547; cv=none; b=uU35JVzx/6Hk5hk8axAT79ra6GD5nlv8L8lXKPaB5tMLCbEH/axwiMAF0k5G1V9XoxPK99GDOKOHoQRKe1CtwZgMSRKIaWLmksNs0Zeu1koZh7r/WJhOOX8QYwMgzbP2bi8YFpv79xr+QyLHHU1NgJg0if7Pe+qxDohw+8kE2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713936547; c=relaxed/simple;
	bh=x/3+sluGWAQToLynGSGOR8RYcpuPZru1NPLHfHD8FNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2r1Ub0YlHZwJzd61Fc//vYd49a1KfkTrIe/EEPwzOuBbfkQAGwcT8wa1Fh8Yv0juiDo31Bc1+NcwJY/c5Eqyq+WD6AY/LkL/h2HWfFJp8B8iyerEcbyUcQfaiDqJInMeaibe+8ZjrGXfYo/frZ6YNgRSBlbbfZcW6i1LtCmdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MPSmrcOV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/v7drP+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MPSmrcOV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/v7drP+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BE0A41140097;
	Wed, 24 Apr 2024 01:29:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 24 Apr 2024 01:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713936543; x=1714022943; bh=2KZ9MaLfP/
	kCXLVlxAhcnIBVWOZUcJAFTNllWZvurQU=; b=MPSmrcOVBHnaEIxcfbNHOlHxw6
	V1UOs/bxzfIBKDsxgL76sEK4bsWEz0aYrNYmjK3uIpN3kaEW7fRQ1GmykTKInNHo
	MyD40IjBUExbkHfR/DSBOUTYcaRWQRLNNNDSx7AhUE1Ut9nbkCpPX5CgaJzcfBsI
	cdjUE71fRXr5lFm0b9m8oM/ndRlC6LGj3f/l7v3wArLwBRLJh7mh0xYQIGVsiUbS
	m86G+sYWmlxiXgdvFpKborjp1BqEyDcWipphCJhzlmDhza4k7YyJkpNvIwgxzyv6
	FjPOrtnPmeL0YF8fz0x9AEOja4b8d1k6va8ioNLRnTTT/EtlqGyedcU2Wxzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713936543; x=1714022943; bh=2KZ9MaLfP/kCXLVlxAhcnIBVWOZU
	cJAFTNllWZvurQU=; b=J/v7drP+avNO9+6v/AMzuVpHxzD+hS6iewljGHVa0e5m
	Le2ruu+LO7JsNGrbFW0kbhxytfGXFZA6ulSqHJ9Hbhw5DkBacvnSQFsee9gWhgtx
	rz0IPxXNHZ8WwuvsVzsMC0HYvdj3NrjiVWwQbvmbg/HJYYFq0wY32RZrMFjCQFHQ
	maIU9FzXxSdAWM+eLZwTdHmyp0np60vYdmFF0lKk0PDHez1W/erCXJeiq6eb9txW
	7CJJGmW4Us4JXHETQ0sqPZ20qm59axRV0VrTHor40qYcDXh9NT6F2xPYnjswFpgQ
	WbdUwZH+vFY4BJNaCVrBMIAXTUTeXhJapFfiBeg4Bg==
X-ME-Sender: <xms:n5goZhWRiUd9HvBAldeYItQCmxUeFzGbheCcG5PAq_3lPW3tdpfrRQ>
    <xme:n5goZhnAPUuaXJ8LtkJnzif-KSDlg5iMMNnkUzhe-WBdZa5mO3hFmPGzVruxr3OTm
    LPlcMpGu47SqGZYZA>
X-ME-Received: <xmr:n5goZtaYTUACaFpX3yzmUKbmCtmnE1bV4AMai1YrVvyf1RAF5_VrPAWaWwjb6RJ0BBG2PRomnlo4AdnS0ntYhn5_re_kFDtHwcIMiRY9x1fL_L__1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:n5goZkXDhdY0-Jor0X-8ntmy7Enn4DLrF8UDZIDzKW0rr2SzI2_yYw>
    <xmx:n5goZrnmQ5qfsUJJVdoFs5gmQAYdb_WCfohYCSabu03DUKliyH_L1w>
    <xmx:n5goZhcPplGpvBGdI1Y6KDAf9QdmZ0c43ZfSWIN22Ksh3MowgExMow>
    <xmx:n5goZlGoFEMAvL8E_2T0_ajJXFMiD8MwJNazOq5pLZ3BjDrfJ4Tk5g>
    <xmx:n5goZgyylQugNpGouA8vfoPb1m5-AJntjd_pyGFpwkz-j0awxDjQu668>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 01:29:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 31eaaf86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Apr 2024 05:28:52 +0000 (UTC)
Date: Wed, 24 Apr 2024 07:28:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] advice: allow advice type to be provided in tests
Message-ID: <ZiiYmpk4IXg3bcb1@tanuki>
References: <20240424035857.84583-1-james@jamesliu.io>
 <20240424035857.84583-2-james@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ffoNpOEXqCXbNO4j"
Content-Disposition: inline
In-Reply-To: <20240424035857.84583-2-james@jamesliu.io>


--ffoNpOEXqCXbNO4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 01:58:56PM +1000, James Liu wrote:
> advise_if_enabled() has a special branch to handle
> backwards-compatibility with the `pushUpdateRejected` and
> `pushNonFastForward` advice types, which went untested.
>=20
> Modify the `test-tool advise` command so the advice type can be changed
> between nestedTag (the previous behaviour) and pushUpdateRejected.
>=20
> Signed-off-by: James Liu <james@jamesliu.io>
> ---
>  t/helper/test-advise.c | 20 ++++++++++++++------
>  t/t0018-advice.sh      | 30 +++++++++++++++++++++++++++---
>  2 files changed, 41 insertions(+), 9 deletions(-)
>=20
> diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
> index 8a3fd0009a..c18b18e059 100644
> --- a/t/helper/test-advise.c
> +++ b/t/helper/test-advise.c
> @@ -5,18 +5,26 @@
> =20
>  int cmd__advise_if_enabled(int argc, const char **argv)
>  {
> -	if (argc !=3D 2)
> -		die("usage: %s <advice>", argv[0]);
> +	if (argc !=3D 3)
> +		die("usage: %s nestedTag|pushUpdateRejected <advice>", argv[0]);

We could retain the old behaviour here so that we don't have to update
all tests. So in case `argc =3D=3D 2` we implicitly use `ADVICE_NESTED_TAG`,
if `argc =3D=3D 3` we look up the advice passed by the caller. The usage
would thus essentially become something like this:

    usage: test-advise <msg> [<key>]

> -	if (argc !=3D 2)
> -		die("usage: %s <advice>", argv[0]);
> +	if (argc !=3D 3)
> +		die("usage: %s nestedTag|pushUpdateRejected <advice>", argv[0]);

>  	setup_git_directory();
>  	git_config(git_default_config, NULL);
> =20
>  	/*
> -	 * Any advice type can be used for testing, but NESTED_TAG was
> -	 * selected here and in t0018 where this command is being
> -	 * executed.
> +	 * Any advice type can be used for testing, but ADVICE_NESTED_TAG and
> +	 * ADVICE_PUSH_UPDATE_REJECTED were selected here and used in t0018
> +	 * where this command is being executed.
> +	 *
> +	 * This allows test cases to exercise the normal and special branch
> +	 * within advice_enabled().
>  	 */
> -	advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[1]);
> +	if (!strcmp(argv[1], "nestedTag"))
> +		advise_if_enabled(ADVICE_NESTED_TAG, "%s", argv[2]);
> +	else if (!strcmp(argv[1], "pushUpdateRejected"))
> +		advise_if_enabled(ADVICE_PUSH_UPDATE_REJECTED, "%s", argv[2]);
> +	else
> +		die("advice type should be nestedTag|pushUpdateRejected");

Instead of singling out these specific advices, can we maybe expose the
`advice_setting[]` array and make this generic? We could for example add
a new `lookup_advice_by_name()` function that you pass the advice key,
which then walks through the array to look up the `enum advice_type`.

Patrick

--ffoNpOEXqCXbNO4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYomJkACgkQVbJhu7ck
PpRWuA/+Ns2ctN7LfXQeXkoLZo5yNGwqkWsvgihCzlEcQx1QBtOnaDyng11yy3Ap
hSC1gvYE0YwUGnKbg4d1ZU9vU0eXUHYksiNhQqR9slAAOLOFnzIMaz2Ob2IU3n51
6G0lA4J+OKSGTTKhyXa2gfUnoxXBbhB7LRH6BakFXTI9Bgew1R8qAquZO8ljviax
k8aREFcj+KeXUijUbHLaSxHrwDv3AY/8/cLAnLZlBV9sXftODOb3e8HK9ZEtuAub
yMOej5HUdScZghtUjqrFG5pHyVIZfYWf1L3qZibj6eDDq1Uy/RyMysIZJS8ig9CW
BRcAjYqT/hmBUrxrmJo3NgWNDK82oZd6In8WC4FlWAhP4HTNFLPJODJ5spPuTJa4
Gsbq0kFQRhjmfyWa0L2Vr+4yfyKwoG+vhA9zWk8HIb126Rw8OZgKMyzU5n731WDH
szLLfsOkt6J3L3kDUfJd51bFq2EsgAcNjs+cdqQX/q86yQ4+EwofUuM3wL8hpsNQ
fU2Qqgv8mu8dGubVnehYkCXKjnBdOP5ctOWxovu/ZlZsi5Jyq/Dm1qYsZxuoRuYJ
kTenqEkQRFivoPBdyA1+OMWCMT39RtGiq9tp4z4ud5J9DWJKUIr6xZfxeCnY1AsS
lvXlPiMjjDXjAVtU5snoPBrudQNXicGslEU4qChLYS+802IzAr0=
=DXts
-----END PGP SIGNATURE-----

--ffoNpOEXqCXbNO4j--
