Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51714C5A4
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595832; cv=none; b=hxqgVUu0yB6dtAB0VFACnEAgEHPnY3PyudU5sIfkOvzBPpOUrpSZsUM11G9z7a4hJHBgMACGjj0uAzIoY7CVZf34zWIvlJ+d7ddOVJBU0Q3/F3YwR2Jhn7FKLr4O2HcQonYHt9kg4mzSzkPuAlOwr+JScofcHYMlc3zylSgj36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595832; c=relaxed/simple;
	bh=LakW0QPJ72Y9w+9TXhiZmRaiwz3ZMgeJ1dxmYM6mCR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndU0gHo0ubriIfFFa/0RuO1KY/EbUEX4wqTxNwfSTu3EGobbKyn71FkwoAdLDsQYLcqdVd5h1wq+EXRVTM3w7D7acdd49+DOH0Qd+lB2duFwRz69vpqh8z9xzTKT01obR2/Fq+YQfgG9o6QKWjrAEEom9Pq702K69w+9L57vdjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jMaS8k/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5kcipnq; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jMaS8k/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5kcipnq"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id DCD111C000E9;
	Mon, 13 May 2024 06:23:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595829; x=1715682229; bh=PN+5w1nSra
	jxn1EU0stqW8VQU2ibPlKXE7+0ayd3Rb0=; b=jMaS8k/H0CBXHLitZs3l6GDqiU
	yrycFBXTmrgMxlElBRMpwRUwd12l7rQLduHBjwmMi8X2/HkyOm/5iO+WZOp7cEh6
	hx3apKqFfJ/Am7R7z3shjk5+XOypJ6IH1jaoUZBFFJOS7LtNSGtagUwAY5mCliSP
	LnSjoli+Uyv3hOOU9ysUUA3TDQa2A74uFA3YYeuAwKK/n0sgBAs+EZPI3cGjmMFc
	nWD+OdfGM7EODzywT/Y7ekQu+BiGe1TgKaGya9NFga9djJ6oS/AcRs1M5SSnudek
	CfuLX7CeIT0w/PqwsHprIqB90yKh4fBoa8lHKUCVWevo6qQqyo8fQNyZwx2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595829; x=1715682229; bh=PN+5w1nSrajxn1EU0stqW8VQU2ib
	PlKXE7+0ayd3Rb0=; b=Y5kcipnqNzxUs7zdd3c7SUm9Rhg+XPGgeLjgQln9a6n6
	aj558KX86nw9Vec/UrD6jV0gTqmNSN1cVVfDkFYS/BFoTibtG4HKGPDsR7hJqy9o
	aqi3LHZ37FI0c9NDP5ofHMN7RnElNhM/6205ysJ9s4w0SjukZrhR4+vUAOL+JUgL
	ZMCrzpdC0/wBJZzNSXZGvzYjBbVrNQW5vb/ddak2bpZPOlIhDNLZn5kw1Y0cLAb4
	7U04byf+q0poV/vMhBo0+hm+PBMGcGUnrnIC4guyWaN9dwPL7t9Y2sU2++x/MvcL
	CEM47EK6Ww1JsdKa/t9h2cjqvqTyhQBWhR/uAumHWA==
X-ME-Sender: <xms:NepBZjGf8vxZp1JsP3SMEAkbvUXtRpo2DzZ6qdw4kvuF7QB1Su-rBg>
    <xme:NepBZgXqdTWDSQMSvTmwF8my4PXr0LWiOAf2TvlGo3kA5pAhYNPz1YEcXadY6OPe8
    UVHkV9hys2mJgA2GQ>
X-ME-Received: <xmr:NepBZlJ6cb20iMnV970EB0uRmfMBAYrje6xQre2LCZV7hDT1orqldCsKweezBjsKf5LPC_36dCWVAVvtu_U0Bvp4RTtyaKqbWZFAOo2Vn4DjXvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NepBZhEtssEWXuZz0a7_VHifliF4dJ3VVUu_LDqLkgi8h23zre0x-w>
    <xmx:NepBZpU6ShORSJYSSp9zJMtyQKd-6pHOIRbJ1l_ps7ot46ThzqJ18g>
    <xmx:NepBZsNrf580jVH7g0xP5du-TuWeenRHGm_5wEcUBjk40uvHZ8AR7w>
    <xmx:NepBZo2lc0iMDyv0v-ln7DlmIDmrVtOAxbbySDg8z8AGu1KWWFy5bw>
    <xmx:NepBZvx4DQCn1a-CFmAOST-8Fslg4b3_EBrn9aFBrelkgU4i40vuNM3A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a12007ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:23:29 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 21/21] builtin/config: pass data between callbacks via
 local variables
Message-ID: <0496b958e24a4d0191821d3f6c8c0d2028f36452.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f8P0wlRgdY8wzPL/"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--f8P0wlRgdY8wzPL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use several global variables to pass data between callers and
callbacks in `get_color()` and `get_colorbool()`. Convert those to use
callback data structures instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 90 ++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2ab7d24b62..945a1fd82d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -517,21 +517,24 @@ static char *normalize_value(const char *key, const c=
har *value,
 	BUG("cannot normalize type %d", type);
 }
=20
-static int get_color_found;
-static const char *get_color_slot;
-static const char *get_colorbool_slot;
-static char parsed_color[COLOR_MAXLEN];
+struct get_color_config_data {
+	int get_color_found;
+	const char *get_color_slot;
+	char parsed_color[COLOR_MAXLEN];
+};
=20
 static int git_get_color_config(const char *var, const char *value,
 				const struct config_context *ctx UNUSED,
-				void *cb UNUSED)
+				void *cb)
 {
-	if (!strcmp(var, get_color_slot)) {
+	struct get_color_config_data *data =3D cb;
+
+	if (!strcmp(var, data->get_color_slot)) {
 		if (!value)
 			config_error_nonbool(var);
-		if (color_parse(value, parsed_color) < 0)
+		if (color_parse(value, data->parsed_color) < 0)
 			return -1;
-		get_color_found =3D 1;
+		data->get_color_found =3D 1;
 	}
 	return 0;
 }
@@ -539,66 +542,77 @@ static int git_get_color_config(const char *var, cons=
t char *value,
 static void get_color(const struct config_location_options *opts,
 		      const char *var, const char *def_color)
 {
-	get_color_slot =3D var;
-	get_color_found =3D 0;
-	parsed_color[0] =3D '\0';
-	config_with_options(git_get_color_config, NULL,
+	struct get_color_config_data data =3D {
+		.get_color_slot =3D var,
+		.parsed_color[0] =3D '\0',
+	};
+
+	config_with_options(git_get_color_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (!get_color_found && def_color) {
-		if (color_parse(def_color, parsed_color) < 0)
+	if (!data.get_color_found && def_color) {
+		if (color_parse(def_color, data.parsed_color) < 0)
 			die(_("unable to parse default color value"));
 	}
=20
-	fputs(parsed_color, stdout);
+	fputs(data.parsed_color, stdout);
 }
=20
-static int get_colorbool_found;
-static int get_diff_color_found;
-static int get_color_ui_found;
+struct get_colorbool_config_data {
+	int get_colorbool_found;
+	int get_diff_color_found;
+	int get_color_ui_found;
+	const char *get_colorbool_slot;
+};
+
 static int git_get_colorbool_config(const char *var, const char *value,
 				    const struct config_context *ctx UNUSED,
-				    void *data UNUSED)
+				    void *cb)
 {
-	if (!strcmp(var, get_colorbool_slot))
-		get_colorbool_found =3D git_config_colorbool(var, value);
+	struct get_colorbool_config_data *data =3D cb;
+
+	if (!strcmp(var, data->get_colorbool_slot))
+		data->get_colorbool_found =3D git_config_colorbool(var, value);
 	else if (!strcmp(var, "diff.color"))
-		get_diff_color_found =3D git_config_colorbool(var, value);
+		data->get_diff_color_found =3D git_config_colorbool(var, value);
 	else if (!strcmp(var, "color.ui"))
-		get_color_ui_found =3D git_config_colorbool(var, value);
+		data->get_color_ui_found =3D git_config_colorbool(var, value);
 	return 0;
 }
=20
 static int get_colorbool(const struct config_location_options *opts,
 			 const char *var, int print)
 {
-	get_colorbool_slot =3D var;
-	get_colorbool_found =3D -1;
-	get_diff_color_found =3D -1;
-	get_color_ui_found =3D -1;
-	config_with_options(git_get_colorbool_config, NULL,
+	struct get_colorbool_config_data data =3D {
+		.get_colorbool_slot =3D var,
+		.get_colorbool_found =3D -1,
+		.get_diff_color_found =3D -1,
+		.get_color_ui_found =3D -1,
+	};
+
+	config_with_options(git_get_colorbool_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (get_colorbool_found < 0) {
-		if (!strcmp(get_colorbool_slot, "color.diff"))
-			get_colorbool_found =3D get_diff_color_found;
-		if (get_colorbool_found < 0)
-			get_colorbool_found =3D get_color_ui_found;
+	if (data.get_colorbool_found < 0) {
+		if (!strcmp(data.get_colorbool_slot, "color.diff"))
+			data.get_colorbool_found =3D data.get_diff_color_found;
+		if (data.get_colorbool_found < 0)
+			data.get_colorbool_found =3D data.get_color_ui_found;
 	}
=20
-	if (get_colorbool_found < 0)
+	if (data.get_colorbool_found < 0)
 		/* default value if none found in config */
-		get_colorbool_found =3D GIT_COLOR_AUTO;
+		data.get_colorbool_found =3D GIT_COLOR_AUTO;
=20
-	get_colorbool_found =3D want_color(get_colorbool_found);
+	data.get_colorbool_found =3D want_color(data.get_colorbool_found);
=20
 	if (print) {
-		printf("%s\n", get_colorbool_found ? "true" : "false");
+		printf("%s\n", data.get_colorbool_found ? "true" : "false");
 		return 0;
 	} else
-		return get_colorbool_found ? 0 : 1;
+		return data.get_colorbool_found ? 0 : 1;
 }
=20
 static void check_write(const struct git_config_source *source)
--=20
2.45.GIT


--f8P0wlRgdY8wzPL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6jAACgkQVbJhu7ck
PpRc0Q//b0vHpvh46X5+FId/bh402zlNh8LCgelfcQj7Cv8KVnBhubzZvOwwboJF
u1FTD5heBI4qeXIP9z4cCe4VWPdCGbjOfpkGt52IAJxrz80k97ndFg6y9tR+HXjH
lMvjVC4rJiHYMYONueKbRYMr51IqxV8qjSktEvrCRnVlMpOAHzH7uLDSR9WN0B4q
UZHb3wbTTdLpFQBtpSDubs4T6JRnf/QjpXb2RUpHMVxxscxs2Q1qaOV3fS45hu68
/KYxhAMvAp2rKQT7AKBABg+ogr4ChFutYH9RT9w9SfK3cRoG31cRnScA+IA/ySpr
Q6ebWN/WrbgexltAcH+ZO3/8Ggai8q3TCmIJLxWg+Gc4Xf1rP1W67ClcCVzAOYui
8YejskzIOzPcxIydp7Oy6i/Mt4oeN7Bgsv/6l3yGFMn62pLeD66WmVZaCzaJXQVL
euraGtB2XB2T8lpKQ+Fug4lv2qlQrBut/HQeM/1JkTwqDlp1O9HoAeb9CiHVoUU4
kzjq7APEnSeKXCoNh1g4xclcmJt5NSFhC79oS+I42sU3N/+ja+yiilIWLMXlX8we
7e805T6iI09TGvgMIUCF51x4dv2NZMro7rUY05Dj3Wt2IstV8Rqwe93QgkwIxT59
T04BtwZ6SmwPbjokf1Dz31USWDilThGUNv04ds/lbS7m6ZlbaOg=
=Y0+9
-----END PGP SIGNATURE-----

--f8P0wlRgdY8wzPL/--
