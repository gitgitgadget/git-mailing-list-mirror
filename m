Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BC50A73
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755356; cv=none; b=jHSTidWUyqF0Z/ydKcD2xfPSH90gcQsSCHDAtJqmRvHyTw6BBTWX+WTsPqs3j9GES2hfiNZYe6EjaOrpnsqqyBOvvM7x7GOVVH4pA4PhKnoKyosM0x7lWIKrCvFhzdEmbIzm6G8vnfxoW5Xjxp7Wu585II1PpBiTka4bbOq/cv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755356; c=relaxed/simple;
	bh=b3595SbwADJ9IkOeE4hWmm0DnUAmsevNdV7G7s8bcqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2aY+8YzDUhXMz4WPlYqFlPqg+YusN4/hHow+zLvw29ofMgXbVqGRcyA3T73C5xUfZ+QObc+d27UPHWq++47BCsmtwse3g04Lonv27LpbP4g6aMbACTQsmTDRW90iWzxsbQNNji6MAQdcUt8mpCNt8QJYBBqpe584dfzvrcVMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AGih56r6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gcy50OqC; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AGih56r6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcy50OqC"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 476A51380222;
	Wed, 15 May 2024 02:42:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 May 2024 02:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755354; x=1715841754; bh=zefy4FTFRy
	nr1dyP2vvQzvFaOl1M0bcXawLuEEqm6O0=; b=AGih56r636yPeu8W8ttiBXZolk
	051mWTvHbl9nugTqPZycFeTDVrft69jnXAG+SHkbz8W2PuQV1QPzbuHOiqm5Jhi9
	UPU9+GmAOSKUqwe0u04Q3dZ5tg8aSiu/VtrqwEqfRy2erEiR5xSMSxwoUEyIBHM+
	OFGzV+FvtZA7uKnKlMh/7tMBhOm7LGvhjvMqhsBCK8jqEfp1j4erTsJIlg11oFTr
	nM2tDFXd5LyL+bAe1Jdt/lUylmEvtyq8kbcp0j5/ZEvlPVkL9H6d3+zTR2qTLLjC
	Iv0nCUU+v9hE+PNlCTZ873ZQQnPTfSzSWbARtEsCAaSsmXgaykA8K2kugZHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755354; x=1715841754; bh=zefy4FTFRynr1dyP2vvQzvFaOl1M
	0bcXawLuEEqm6O0=; b=gcy50OqC6pqKog/XKw29WLqx8T67RiVPrrq3Q80g+IMe
	B9fRDb0VwQELIrKdbX3X/CHl3xHutF2qOg+bxLRw/a4R9khPajymFJ1sp9GpdYXR
	n+CFLCNca9EepP8a3mcyFHrHQhTBDpJgyKPkwwd2ZUErrkoiGBzsZOYD8Q78eutz
	euhGtjhxd8Jw91vpnSE/q2YPYiiTc2ASFB1yh6FyjcbBUOmvkzB5//Lol7+2Zuvx
	iLM3tUNq+kbXDisXqxCAd+NLm8ILQtFAm0410mkZIYjwYnHhlM1KoNJNwoO2cKtd
	9+kWMAvto/VjxO+RfIye5qiu2GM3XsqAIVnMm2GiHA==
X-ME-Sender: <xms:WllEZquThPgmsQjsDvryuwl_-JgG6mNW-U7_JtaZjcEXIDanGPKmMg>
    <xme:WllEZveduKC0znEUT1wlI_B8urpvQSTjriJ8cwpg22ZXMbDGpvk00eujaBtqDBOsn
    eH906IypDjijv40Zw>
X-ME-Received: <xmr:WllEZlyEmxXGSDUpmglTl5wS2EOg7vTU9gwF0AGpPwytllerQRaJnbcajNhSgIbW6byFULYLy6yJWgOTK0uSbDh8Vhi4tYvophhoeZUvYxq7spFC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:WllEZlNv1f3zROy-j4qTBO3wp8NnVJUdtm85jz-E46mO8EKk_vgYxQ>
    <xmx:WllEZq-8rKyR_KO5UjgTP4oRawyw6c_NdEv__ZSUHif56qBWIedZ0Q>
    <xmx:WllEZtUsTOt36uf-1QvAp9tpjNlu3Mhd_DjxbgRNLFM5_HnaA_fCIQ>
    <xmx:WllEZjcGsBwp9Hj_i21Q7tyBkf6_bzMpooKINSt2lN9GDFqkbNI17Q>
    <xmx:WllEZuaEcWqdw5V37disOYk1GGHfjR4CS_DGivg8gtjd4CmaQJr3PSCw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1f70ae88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:10 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 12/21] builtin/config: move default value into display
 options
Message-ID: <05a072d5d1b26c660f2467478fa75ba5373ac928.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oB2F21MR+8jH2l6p"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--oB2F21MR+8jH2l6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The default value is tracked via a global variable. Move it into the
display options instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ff111d83a9..8a327e770d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -108,6 +108,7 @@ struct config_display_options {
 	int show_scope;
 	int show_keys;
 	int type;
+	char *default_value;
 	/* Populated via `display_options_init()`. */
 	int term;
 	int delim;
@@ -126,7 +127,6 @@ static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-static char *default_value;
 static int respect_includes_opt =3D -1;
 static int fixed_value;
=20
@@ -416,7 +416,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (!values.nr && default_value) {
+	if (!values.nr && display_opts->default_value) {
 		struct key_value_info kvi =3D KVI_INIT;
 		struct strbuf *item;
=20
@@ -424,9 +424,10 @@ static int get_value(const struct config_location_opti=
ons *opts,
 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
 		item =3D &values.items[values.nr++];
 		strbuf_init(item, 0);
-		if (format_config(display_opts, item, key_, default_value, &kvi) < 0)
+		if (format_config(display_opts, item, key_,
+				  display_opts->default_value, &kvi) < 0)
 			die(_("failed to format default config value: %s"),
-				default_value);
+			    display_opts->default_value);
 	}
=20
 	ret =3D !values.nr;
@@ -850,7 +851,8 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
 		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
 		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
-		OPT_STRING(0, "default", &default_value, N_("value"), N_("use default va=
lue when missing entry")),
+		OPT_STRING(0, "default", &display_opts.default_value,
+			   N_("value"), N_("use default value when missing entry")),
 		OPT_END(),
 	};
 	int ret;
@@ -861,7 +863,7 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
=20
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
 		die(_("--fixed-value only applies with 'value-pattern'"));
-	if (default_value && (do_all || url))
+	if (display_opts.default_value && (do_all || url))
 		die(_("--default=3D cannot be used with --all or --url=3D"));
 	if (url && (do_all || use_key_regexp || value_pattern))
 		die(_("--url=3D cannot be used with --all, --regexp or --value"));
@@ -1127,7 +1129,8 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: sl=
ot [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
 		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
-		OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, us=
e default value when missing entry")),
+		OPT_STRING(0, "default", &display_opts.default_value,
+			   N_("value"), N_("with --get, use default value when missing entry")),
 		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable c=
omment string (# will be prepended as needed)")),
 		OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when co=
mparing values to 'value-pattern'")),
 		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
@@ -1172,7 +1175,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		exit(129);
 	}
=20
-	if (default_value && !(actions & ACTION_GET)) {
+	if (display_opts.default_value && !(actions & ACTION_GET)) {
 		error(_("--default is only applicable to --get"));
 		exit(129);
 	}
--=20
2.45.GIT


--oB2F21MR+8jH2l6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWVUACgkQVbJhu7ck
PpS1eRAAidR1keoWwPZQFmWUdJcU1ZK28OK/vXuAoGsTyjTo57/7nHVyK76z4pwq
9vDoDeUoNz/5HRDsY1pc/kSDfNdboHlmhVhHVLjaMeYHXchf5fQePCtUjsv9P840
7HZQfi4I2IXJ7wWKKAzLnF7FL4l5np5ztk89+5/R8XOLUfoTaxdJ9G15eTj0O3tZ
ar7To9zwFusI3OfinB2ghvDgN1IpnT6Ao271BWq/Pn7FHQ7LpWg7dkyUikigfN7X
CIbkGIAqJHrhkSrwJVygoqp4L2qUU0MYmdyUo8TOdI0DZ5dlu73LR/DPUv6xscHG
EpL7KYLAsbWT8BVJsZscj5yyaYpqPqmDm+hLAIVXWsXBD0XYo9LfluFhtweQZOir
x7WqlClXkK6CKoUJRpZWYG7witOCAoFOCLoAEWMWKBl9esakP+Z2QSB81lakmzlo
ky2UmiofP9lZh2ScGHvoPqxIE4jYkX0c0rMX53ApWdXUIZknJ6yxXUHvU8YMtHbg
XI9Qf8c0eEjpapiwgc9mS10gDl8SZpHXEwapdt9fVQOW6AFmYiak7E1/F3xK1YhG
0C0vgopJUBGnjxpu/o0OPauCcIP1PZjI2P7BRY4c+2pu3WHeYIZANJRDlcbiDkuG
UL1yUnKQzaRXW2Z09iUtAXFx+uFezc2DpNzKBkAnpacRfheVAZ8=
=Vw9P
-----END PGP SIGNATURE-----

--oB2F21MR+8jH2l6p--
