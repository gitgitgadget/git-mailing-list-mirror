Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653714A4CA
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595786; cv=none; b=AAtb0/JnI+kEV7M3RpPkhImSE1rwXLL1gWxPfk+hxv/wYAmG9rjYxu37ycDnJ9ZvziOkcJB3LOQKbo0C6oTlKj/LhMTiw4vOb1FnjcMvbQvaMZELMBpcNllB8IU6Cx/YWmE6B710NARmWXSN1/IuwLTjwtUNmZPZNuxJxxR7Axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595786; c=relaxed/simple;
	bh=MFyrIycwOXqNV82J+PHEup9SQdk+PRWuMwDfPtUbXEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5w8clVYynXw4Oh4lKUIliVgfa+pqV6ROYCWCs/YaPx5WdlgP+vECbekCv3R9opyuruVTVFLrDf0HklL4PtJorh9qAdfK2xIsElCvK8w13lBYjjjqtmwAW4GdJQRO/+RMcEhW/SG1AKBTVeUwJqRIPziDh55vCxQa/HRDcCuLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M7qtFTE7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SK+N01h1; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M7qtFTE7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SK+N01h1"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8C35C1800121;
	Mon, 13 May 2024 06:23:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595784; x=1715682184; bh=E9mwK4Le6p
	kd1Y8vRnoFc8nNE/Ro6u5YOMD75K2fVH0=; b=M7qtFTE7uMrkK0LTCOqoiAcku6
	d17bWhGAo62EVMcLNdutzQDu5NgJ0/SP1U949yza4Y8oGB0gZvZv2uOQmNMoMepI
	aLr4dPvrwhKVBQ9MKDSlNFJtokU2MqE7T+m/XBE7Q+0Zeu3B7Z2bHQthd/wVKKOy
	bTUMDBiNp5qzb2e/SICi2ERNQ/1oOL7cMEo9ijg/kV4eanPdjHNBe2fBv1Dgs2Bk
	VMpE58t9exPRMKa/sbyd4CG4snIoQjZlYB8KLFuFwd/Ga2q1moiMYrfuDu07TdUZ
	qvzmWtX8Yz8gYP0N/QGo+IWworHNnU+EEd8XH0UyuadylWjDMXh1zS7uBR8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595784; x=1715682184; bh=E9mwK4Le6pkd1Y8vRnoFc8nNE/Ro
	6u5YOMD75K2fVH0=; b=SK+N01h1x0hgBv6OwRBOGaBGKKzrU/cf67S8aODeBNgh
	H6SiHxpI8JD1u6QhUHgQlCIzWB2O9fwoscEsH4CxV3zScQGjsfeS3+hitWCHMtQP
	PskzLntOnFEowQQboohymXUHM6bxozN6ScsN4jK9vT2/mJJh/UaXG+f6UovdbIEH
	x7BwqqOlDZN1hXMawAI0HNmN8qj6VzQxX6Swcbn37AWR3pAz9Sh/WNDlAm0WnqoZ
	HFs+ZFQwexXQx3M0b92e/oFsnA0HU8gpyOMrE7x9rbEjM8NotIa7nSvg8XAS7EEL
	exnhfETa/Tw8mcdjTuo1Az74xqPPx1kLwh1+0IKhew==
X-ME-Sender: <xms:B-pBZsmJ174Qoc-cvkB1ZKip3hQEJSVM7cS1M9fBcTEDY-fLoUMkIw>
    <xme:B-pBZr1c0oIiBfFHPs91elFCsC7t6dTIQbN96pfoCCvrVC7PQaTd4sFhmtoBCm_TG
    TVcNtcvQNewIqiB1w>
X-ME-Received: <xmr:B-pBZqqifw4q93CdnYWzT6wOzeJjo6C2L7_dFfZUjzapoTV-G6137PZFt2rp3EAXtn3dQn1l-EcVaKnWSS0zt08pIB0V4yh8BSHpXShsXM9bBu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:COpBZolqGH5DEpfHedzVuEXPgYVz99NnIWKYB6aUN5iUle1BogBMaw>
    <xmx:COpBZq02rOD0LxKJ45UXD0Rk3UoGWsueH3KiR7DYK_YbXk4ch1DFIA>
    <xmx:COpBZvtR1VBhD4r7EEqTXPeqXsRloNcdPhKxJ4P51F0-Kas2IvetaQ>
    <xmx:COpBZmX7fMKDlz1GpAmBiS1rxGG3GfnJ4LKjkxeZSqCuIFFmDgkz-g>
    <xmx:COpBZtSxyhcFL-jK6krG24M0tOa5g9jbvxYXr2obDBbzbZh5SSLG7DBZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id da5514e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:43 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/21] builtin/config: move default value into display
 options
Message-ID: <106b8ac8a2292b9852c6fda23a796787b6e72ca4.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cy+SYrx6fOLL9tyd"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--cy+SYrx6fOLL9tyd
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
index 6d2597f7c2..dcccb89037 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -107,6 +107,7 @@ struct config_display_options {
 	int show_scope;
 	int show_keys;
 	int type;
+	char *default_value;
 	/* Populated via `display_options_init()`. */
 	int term;
 	int delim;
@@ -125,7 +126,6 @@ static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-static char *default_value;
 static int respect_includes_opt =3D -1;
 static int fixed_value;
=20
@@ -415,7 +415,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (!values.nr && default_value) {
+	if (!values.nr && display_opts->default_value) {
 		struct key_value_info kvi =3D KVI_INIT;
 		struct strbuf *item;
=20
@@ -423,9 +423,10 @@ static int get_value(const struct config_location_opti=
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
@@ -848,7 +849,8 @@ static int cmd_config_get(int argc, const char **argv, =
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
@@ -859,7 +861,7 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
=20
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
 		die(_("--fixed-value only applies with 'value-pattern'"));
-	if (default_value && (do_all || url))
+	if (display_opts.default_value && (do_all || url))
 		die(_("--default=3D cannot be used with --all or --url=3D"));
 	if (url && (do_all || use_key_regexp || value_pattern))
 		die(_("--url=3D cannot be used with --all, --regexp or --value"));
@@ -1125,7 +1127,8 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1170,7 +1173,7 @@ static int cmd_config_actions(int argc, const char **=
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


--cy+SYrx6fOLL9tyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6gMACgkQVbJhu7ck
PpSfZQ/9ENjKCgsF7z+jJtQ/cBZn58/5rxiyw/MQfBd5SL0seNjT0+I2DnLMilZW
yNKd2CY1S6tnFnzmVRpAgVZWzmQoFKxQJjfORMDvTLhSnuLVr7dogLZFxnjDokps
4XXVYJIZUNPFRYmX91HrcebcrOIkKxh9JD+HwYb472AP6uQfOyRufrcXBaHFIHFw
h7u6b7dHxFQEB9fykiy3uigNK6KM9nzj8nKXubjB2gmS94n5xuqjdk+wCTeODoQ3
KnXAkvVDg3wqTm0pT0pLgh6iVm+fQuuaaR8qY5DU8JfimyOSgAs4BU6nrwnfooLc
TR5/wxsIVIOHFaWOrt2XGFTNR1ZStdVx9/AmbaB/4J2M/Mk1o3AWOk9MftNBwvkF
KOy/m/fZMz5CX2/n/FmrUe8urMom3alQvCLx8+PF9CxZcg5zkWv4XdsAFclTJezw
Z0HdGq3ADtd3f765COZOe37B/9XiAR2U4aaa9jMPM2GeaX3gK6fyIGKOSWNzTp99
7Htqivhm5XgFJgIPTZ2awvNeLFIMiJUoXbhAE8qsTVCJsFLEStKVT7hx2gD2FGsS
Izc2z4CEWYqm7G7i9y275XuO8/JFbfetCAj4D1f2cjkauja09m9SbJrIUjPi1CI3
SKBfPEdLIHFEhaq5JFnubFjCrJKXTo+DBGbkIhPUzRy4EMnAGkA=
=kUrz
-----END PGP SIGNATURE-----

--cy+SYrx6fOLL9tyd--
