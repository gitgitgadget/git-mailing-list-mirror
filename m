Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465114C588
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595827; cv=none; b=Ln+kgKRdIZ+lyER/GRS6LDZipe9VgUSqrceGUatVs86RlWqqEzZPJKdEt4zsIx8sBeQgRydJRoTHyZnC1bWY8SJpQU9dKDonaAxZ2rMrja8viD2pc4xjllwWUJfgSXkjwkYqa5I5ooeBxBsliGUZdYaXBr075SI76fCLzaUG1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595827; c=relaxed/simple;
	bh=nsIBHI3VrhrVls4sBT6lfQiJr7GZe2GYOvOJo9IOJRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQWCLvQCWAHe8I7PrMRfxi1h7RvcBkSFi/t3NzfXcoQdNvnSYtKdWFcCzWYTW8955YCZhAXzHTG+5e7hJ/3ZLUFlEQZTWJ5vh2inbA9TFq7djRydkMMcrMUF5ssa6DyCbVSIU/rBoCnwuVwUPQC3dLcYwBzXuAz5NbJc82NzDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dlFuCGE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVAp6nbz; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dlFuCGE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVAp6nbz"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id E29791C000E9;
	Mon, 13 May 2024 06:23:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595824; x=1715682224; bh=CoKr9B+tfN
	7alSnQuVPW0COjLhKGVInyuSu+7G4om0A=; b=dlFuCGE0eficxcC/SMmbDgRPa0
	JyAr45T6UZh6Id2+ceYbNTC4dHfAEplbGFGuLpCC3li6TsbzK6VOTIx8j2vBj5gK
	P9iymYzI3CJGR0IZvca1DeLKL61aZ/iU5TiK+NAPfWgw0HnvVAj6q+mcL7d9Vn20
	Bv2wHfKmRrP6fBrsTmaVO4uhYBnXoadyhLN9JYIuYSyA0tlUUt/HAvmOjr1YKTj2
	7/OsZUOd034SS+3As3PmDMYQJj2qmBVGuGaktS7hjHIReJ7P0QKL0uF7FzwFhPFD
	DzT8SUxLXw8gd12kn6jsRky2JeXee8+A2G7OQ7RnJUfXh+NjcXdDsk2jrROg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595824; x=1715682224; bh=CoKr9B+tfN7alSnQuVPW0COjLhKG
	VInyuSu+7G4om0A=; b=TVAp6nbzWQMoaSKjqpVyE56L13Hkj2GPHnRZXe7me3x/
	yH0mp6HRhU3EXCR5o8mrCfBEe76buk1J1cOvHRabH7R7JINx1xauGIz1wlP37VCV
	eUsOJDVjPWWQt2I2vcm1YK9KNG2WiIJsKEFxAhOhgGzXkcitNmXjfGxHkgg9b352
	jV2q5NOiPxoX4HHzFYIcG7melBMDbBouZhFJsnquWXMffwxoLrqvyw2uSdJqnEYz
	MdbmIdVkZjIxuucMOVTj4z8d9qb+xsfBmNVacbh3MsJ9MjY8dG3r3EjeAtl4LQ49
	TkjGUWzxtwh1vJ1v1MVkOWIi2MRvMmkrV6Irsg3MJw==
X-ME-Sender: <xms:MOpBZriuhbWyQMEA6Od_GIFdKGfjxeFgURDvNrND8cK58gYxFHDgRw>
    <xme:MOpBZoDQek5dqguAHe2OtBg5jqnhm-680RjA3VIV6A8SNclTDxZxj_YJzNGiUUdNP
    IFO4ng2iOLJp0l9Qg>
X-ME-Received: <xmr:MOpBZrEe_u4Bu5YmLtEov3l81qmrqEbfpyC2b_IyAOhcDeek0gA5_byqRg5_VbRKUaLdUHiuYhapd-gsOaNBu1m37QBwC-k_mGyeRVYOxDiIqas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MOpBZoSD1R978_QERV_96BkEDsuX7kg7pHJiAW4GH2v5_XQEeg5McA>
    <xmx:MOpBZoxbBVQ-ca1lyD8efscQ34gMn_korteHUHIIpcPgQEn7DnnI2A>
    <xmx:MOpBZu5efuRcj0oVq7qvtay3oWKX8qMZflpGPQxQD248cFnMgG92fw>
    <xmx:MOpBZtzQHS1NRXdQfFH89_YsrglYxU9TGqzw4is2RhvJqXhmp420JA>
    <xmx:MOpBZisfTn56yNpnTeZ4VSNi19CrKJSTalUHv1qUYN0d8FOYLUKvMp7e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 891f46fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:23:24 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 20/21] builtin/config: convert flags to a local variable
Message-ID: <294bcd96a4ec1d27e58a5faf22255eb60d303fc6.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtQa++LrLX/b9vns"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--jtQa++LrLX/b9vns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both the `do_all` and `use_key_regexp` bits essentially act like flags
to `get_value()`. Let's convert them to actual flags so that we can get
rid of the last two remaining global variables that track options.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2ca23a35d2..2ab7d24b62 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -122,9 +122,6 @@ struct config_display_options {
 	.key_delim =3D ' ', \
 }
=20
-static int use_key_regexp;
-static int do_all;
-
 #define TYPE_BOOL		1
 #define TYPE_INT		2
 #define TYPE_BOOL_OR_INT	3
@@ -318,6 +315,9 @@ static int format_config(const struct config_display_op=
tions *opts,
 	return 0;
 }
=20
+#define GET_VALUE_ALL        (1 << 0)
+#define GET_VALUE_KEY_REGEXP (1 << 1)
+
 struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
@@ -326,6 +326,7 @@ struct collect_config_data {
 	regex_t *regexp;
 	regex_t *key_regexp;
 	int do_not_match;
+	unsigned get_value_flags;
 	unsigned flags;
 };
=20
@@ -336,9 +337,11 @@ static int collect_config(const char *key_, const char=
 *value_,
 	struct strbuf_list *values =3D data->values;
 	const struct key_value_info *kvi =3D ctx->kvi;
=20
-	if (!use_key_regexp && strcmp(key_, data->key))
+	if (!(data->get_value_flags & GET_VALUE_KEY_REGEXP) &&
+	    strcmp(key_, data->key))
 		return 0;
-	if (use_key_regexp && regexec(data->key_regexp, key_, 0, NULL, 0))
+	if ((data->get_value_flags & GET_VALUE_KEY_REGEXP) &&
+	    regexec(data->key_regexp, key_, 0, NULL, 0))
 		return 0;
 	if ((data->flags & CONFIG_FLAGS_FIXED_VALUE) &&
 	    strcmp(data->value_pattern, (value_?value_:"")))
@@ -356,19 +359,21 @@ static int collect_config(const char *key_, const cha=
r *value_,
=20
 static int get_value(const struct config_location_options *opts,
 		     const struct config_display_options *display_opts,
-		     const char *key_, const char *regex_, unsigned flags)
+		     const char *key_, const char *regex_,
+		     unsigned get_value_flags, unsigned flags)
 {
 	int ret =3D CONFIG_GENERIC_ERROR;
 	struct strbuf_list values =3D {NULL};
 	struct collect_config_data data =3D {
 		.display_opts =3D display_opts,
 		.values =3D &values,
+		.get_value_flags =3D get_value_flags,
 		.flags =3D flags,
 	};
 	char *key =3D NULL;
 	int i;
=20
-	if (use_key_regexp) {
+	if (get_value_flags & GET_VALUE_KEY_REGEXP) {
 		char *tl;
=20
 		/*
@@ -440,7 +445,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
=20
 	for (i =3D 0; i < values.nr; i++) {
 		struct strbuf *buf =3D values.items + i;
-		if (do_all || i =3D=3D values.nr - 1)
+		if ((get_value_flags & GET_VALUE_ALL) || i =3D=3D values.nr - 1)
 			fwrite(buf->buf, 1, buf->len, stdout);
 		strbuf_release(buf);
 	}
@@ -846,11 +851,12 @@ static int cmd_config_get(int argc, const char **argv=
, const char *prefix)
 	struct config_display_options display_opts =3D CONFIG_DISPLAY_OPTIONS_INI=
T;
 	const char *value_pattern =3D NULL, *url =3D NULL;
 	int flags =3D 0;
+	unsigned get_value_flags =3D 0;
 	struct option opts[] =3D {
 		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_GROUP(N_("Filter options")),
-		OPT_BOOL(0, "all", &do_all, N_("return all values for multi-valued confi=
g options")),
-		OPT_BOOL(0, "regexp", &use_key_regexp, N_("interpret the name as a regul=
ar expression")),
+		OPT_BIT(0, "all", &get_value_flags, N_("return all values for multi-valu=
ed config options"), GET_VALUE_ALL),
+		OPT_BIT(0, "regexp", &get_value_flags, N_("interpret the name as a regul=
ar expression"), GET_VALUE_KEY_REGEXP),
 		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config wi=
th values matching the pattern")),
 		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
 		OPT_STRING(0, "url", &url, N_("URL"), N_("show config matching the given=
 URL")),
@@ -870,9 +876,12 @@ static int cmd_config_get(int argc, const char **argv,=
 const char *prefix)
=20
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
 		die(_("--fixed-value only applies with 'value-pattern'"));
-	if (display_opts.default_value && (do_all || url))
+	if (display_opts.default_value &&
+	    ((get_value_flags & GET_VALUE_ALL) || url))
 		die(_("--default=3D cannot be used with --all or --url=3D"));
-	if (url && (do_all || use_key_regexp || value_pattern))
+	if (url && ((get_value_flags & GET_VALUE_ALL) ||
+		    (get_value_flags & GET_VALUE_KEY_REGEXP) ||
+		    value_pattern))
 		die(_("--url=3D cannot be used with --all, --regexp or --value"));
=20
 	location_options_init(&location_opts, prefix);
@@ -883,7 +892,8 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
 	if (url)
 		ret =3D get_urlmatch(&location_opts, &display_opts, argv[0], url);
 	else
-		ret =3D get_value(&location_opts, &display_opts, argv[0], value_pattern,=
 flags);
+		ret =3D get_value(&location_opts, &display_opts, argv[0], value_pattern,
+				get_value_flags, flags);
=20
 	location_options_release(&location_opts);
 	return ret;
@@ -1288,19 +1298,19 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 	}
 	else if (actions =3D=3D ACTION_GET) {
 		check_argc(argc, 1, 2);
-		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1], flags=
);
+		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1],
+				0, flags);
 	}
 	else if (actions =3D=3D ACTION_GET_ALL) {
-		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1], flags=
);
+		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1],
+				GET_VALUE_ALL, flags);
 	}
 	else if (actions =3D=3D ACTION_GET_REGEXP) {
 		display_opts.show_keys =3D 1;
-		use_key_regexp =3D 1;
-		do_all =3D 1;
 		check_argc(argc, 1, 2);
-		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1], flags=
);
+		ret =3D get_value(&location_opts, &display_opts, argv[0], argv[1],
+				GET_VALUE_ALL|GET_VALUE_KEY_REGEXP, flags);
 	}
 	else if (actions =3D=3D ACTION_GET_URLMATCH) {
 		check_argc(argc, 2, 2);
--=20
2.45.GIT


--jtQa++LrLX/b9vns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6isACgkQVbJhu7ck
PpQGfA/+KfvVtJVd3i57+JEyBI0ZU355BQKDbw7IZk782msYT2s/unafNYH9GfD7
vmCqP16/APN8dIK72De+8gGv0t+z6s5WhXIUfrQ2v0r3LXAfjbDyKy14i/4qSnt4
hZ4SHrlyNyH+C4tHdLpNpe3aJ1B/qnl7QMy6/2wgxxCZiWCGHWtCEgkt3pWvR8gO
OiwUTMQ5PGi6qCeQjqL6FH1vdtTZu4GHNOBoP3QxXQj0nS5HX+SMcgcrtovN65oF
eZLL4obl7q5E9WHY1jE0tMuc7ENJJPJyblNZdXuEv9SQzYQK2lwg1P4U8xx8TYbT
n8xcLntORx4tIOL4Dp3/VVMsbuORPnTK9rrO4cvXenoi3dbwbdLaQkZoVG5B1E/+
4sSW1+zzfJTl/wOpLVwScaY/RnwrKyGU+PIwV+kGgUnBE1I5g9IDU5GwZzHvSlMv
xJi8eSUY0Dl5FZaKNm1I6zQ6VkMsPc8iI3wKqWlLYmvimfl3IJG6Ku9+7LFYwyLT
TI+X9zYGTvSHoDvKtLsgrpZL31urBTw3ZWsHDNnBjXzVO5ehzuIW/c6H9CHu72aL
vSMTVqmC2Qao+qoSMh45ELQ9dey6DeM9uuI7yCpWWJlaZ4TgXXlSMnHvH2fsY+TV
B6CtXxGclQd+vL03KqbmQKXWGm7BFzTkh31SshFNrFDoK7Dswhw=
=83Xg
-----END PGP SIGNATURE-----

--jtQa++LrLX/b9vns--
