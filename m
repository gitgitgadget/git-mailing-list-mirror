Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515658AA9
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199205; cv=none; b=t+oQzhVS60hPzIt6GTKYBhFOpWSXkZf87AWweeCebFoYDLeXyx2Ot/l41DMlqxqsHBbdryeGzFdYb14We2xNICu36SYY4VYqi9QK/ybeAb38tYfG3V6IaGyWRcN3SviBlzccpboFuHOsUMHLjgC8X6FzRdVCxQvDLo61y35lV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199205; c=relaxed/simple;
	bh=dovxGGcPiToLltauT/LmSFqcwZY1D/hyUauqZVW/IiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdAyK2qYkjKS/XttvWm5Y+wvazUpb55lxyvkDS2kY+YBQVI+bWzN3mHodOc6PNiACYVYVsbKvHOBt8G5r9DSmbM7iq9gaS0IORq0ImDYmQnWbHRhycQt3mYGSePrba8/tblaeXxChV72hpyzokCq4Brl03NXx58tLwXcQ7rhfhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c+wj2cB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SU0f9jBb; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c+wj2cB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SU0f9jBb"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BC2BC11400FC;
	Mon, 11 Mar 2024 19:20:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Mar 2024 19:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199202; x=1710285602; bh=wUagLtFGct
	ncaTkCnLw3Vbf04184theDsZ1T4I01h0E=; b=c+wj2cB8FmMMIvQQ7H2Rs+PrQ+
	hr7TQxTMYIDG0C4pr9Fj+BypNYLI3qVdSki5ts01OLKFnQsM3zVc5q9qhick2LkK
	G0EZLrbFdAmiJhJdvdaT4kktqpN7akLlWFAwvpm0s057A4FeyWul3yq+XEG1g4m5
	goOajyXyti1CZIit4RVcnoe1Dnij6+rzqIz2xjHXb5rWHLWzrk0uK+jlmXwRdfIj
	/HVQuB8JgmZyVW2MGwJsEjp8ZB9LqZvIbpQuyn0Lv+BPGF7q77EoFOBkfvNr6ue6
	0y+72jbLm5KycoXxGRLGnyZzwSW51F9EKyuSpZwLIvchExwVvra04WD38+9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199202; x=1710285602; bh=wUagLtFGctncaTkCnLw3Vbf04184
	theDsZ1T4I01h0E=; b=SU0f9jBb1d8mc7/EBpCzzSxtsoRAib7yI02MQwIYLz5l
	uAwLAcLp7YawGN6NRgopGcUdhyZT3SMPMCarrLpa25b9tIx/BZYqHX+FQl5+rk5o
	yo01vslNJES/GZBu2OIeD/kMbNO7Vw3okwwvgL06pAxrvgSbaaBR9CCQXMfxvl+L
	ycLKfC0UXgavzlvPacExiO/b2WRMPOZsMlCODhv0kGA+IVX5vagKu3DGoRD5wGwb
	OYGx+hh9HR61mNaURL65xe+Fxzk8qYm17tPla4gAK66Z4LYeyy6scpziJTbf8x3Y
	ubSu2PzuPVNQ2DsLirgOACK8LYUgvX2LSikufRJHCg==
X-ME-Sender: <xms:opHvZZRdPSFGJIRDIaH5LaL1fO3RR5EdA_hSi_YRBQX_SqQM51QgnA>
    <xme:opHvZSzsmS0WbANZwRYLv64B6Cly5ek5m1PQL21Y6iH-D0sO_cLzeXDgXjfD7J0Lb
    Ly8esiUQiE9Aa1PzA>
X-ME-Received: <xmr:opHvZe1uqYylCtZn9VfjnvfLuQAeiAhhgevX_tW-yeppOzfrQptFNVj1dp3hMpD3Dqv16GfyS_Sp3bV5C8XbY1h0XTvb7SsnsX2SLvLK84fxnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:opHvZRCVLCvzRNXRiDJlYKBlE_8go6l7XgwfIQeRE190GfNLLHm2eg>
    <xmx:opHvZSic6_bDNPf5BdL3keCaUG_1q0t68P8Etyro_4FJfIM_2Kl0Gw>
    <xmx:opHvZVoJZPZUOI3XfUBo5Eu839iSiapxLzSGhn7Ayp5q83vABa-ArQ>
    <xmx:opHvZdVPzX1HVUkhPjSZexpLut1T9DjKQ4FadYl9SVA62yBnZB4I1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:20:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a03ee05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:15:21 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:19:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/13] builtin/config: move "fixed-value" option to
 correct group
Message-ID: <54e536394a0d88449c327b47ebbc6943a34001b8.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oVaX8BuSVsFG8z1C"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--oVaX8BuSVsFG8z1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--fixed-value` option can be used to alter how the value-pattern
parameter is interpreted for the various submodes of git-config(1). But
while it is an option, it is currently listed as part of the submodes
group the command, which is wrong.

Move the option to the "Other" group, which hosts the various options
known to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6eb6aff917..fcd6190f12 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -642,7 +642,6 @@ static struct option builtin_config_options[] =3D {
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-n=
ame"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTI=
ON_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
@@ -661,6 +660,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
 	OPT_END(),
 };
=20
--=20
2.44.0


--oVaX8BuSVsFG8z1C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvkZkACgkQVbJhu7ck
PpSyag/9GtIrhNYKQRUIY+IRMKF2G1YJjIqmp2TbupZ/JELTQfJziWUjrITcJ7PY
EM5bmSaIF94LmebXTIYo7fxk7O8u7Smwi1nUHOtXREslQMLQWwjMluPRCA1qHk6J
dbHYlLDS4FCJOyWGMnUZHLjVVEAOExb3F5xQqA1GXUyegc499UEASNTQtLWQlCUz
PPajMyNZ+jVaGoSs1hBDKeXUDbmEeg9ijCdwZu5XBMB8rutWhPuPwA03xzQbWT4Y
ykm0ZXZFTcCbIMv5uZa3uIeJI38H00070w5SddRpASA4iASXnvxw1YWvQwPaCstK
JVgJK34UpFJaobqftiE7TdmSkL0MY9mq56QlDrdIkrB70ZFwvhaioF4KDmX9+BhB
viMM2KqSKUVuJndpXw2Z23LIGFZPrBkTzlrDyqWtTzuYLv8bWqVKGYL3zdXhVlgt
Iql7ZdqDyBHNmel45wjRjxtmiu4o/1r/GK4z1dXmsdLMIOxKlIDhjg5z6MXZJJOz
MSATaRjCwcxbXoe/pxZCeajp5nJORPks+OV9ZmnvDxE0CIklPuFqk7JPebQirUT/
rpTJyu7N964X46K5GMvQ12BgrIJ/zR7QvdSD+RwMtgEjtI2X9NTYjqvApZYtF8Kg
rWSS8abmO9Pb0eyMKyFcdnO7e02XPXvNBrCh9ezjx6Vsepeck0A=
=oJHs
-----END PGP SIGNATURE-----

--oVaX8BuSVsFG8z1C--
