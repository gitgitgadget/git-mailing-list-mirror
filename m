Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBABA16F0E2
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340368; cv=none; b=jwxLQildDwyOwCa7WH2TDHLONVeMzFMEccIkR4yr3m/33m3aEzpN7OUTY4K9O8yj/YGWs+NCPHV6k8XByavmKv6IAdrscOI/ppaIUPTqp30IMyRtGpc0uZNoxPnOmMMXoLELbtujyvJeAgszbpa7qWP70rXtT4EKE/zMO5RB0u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340368; c=relaxed/simple;
	bh=MxKIiFAXuNJAqgY3aFGuLoocQ2f29I1cdf7pOqLQ2Fo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AfzTkIgNdvkfrLS7QsLIUevEGVGVd9SWrXfjG0zlfppa8Q9SAXDILN5yWFV2QX+p8NF1d9hixn6pOoj5+FVJcKqCX1v6U7QX6ARKmvlGpyVPg0ngz51mX0dOx3H7ZpVnjKolEoUbIf9NR9iM28Lr10tRC0I53IO5Bxsy+/6OQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S+7wEqHD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuH2QGis; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S+7wEqHD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuH2QGis"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id F0F091C00098
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:26:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 10 May 2024 07:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340365; x=1715426765; bh=qlHTwjIUH1
	pJBXS8vxqTp7ptIH4W4kfh6uFCNIHKqIo=; b=S+7wEqHDC85J1+1SsbGVUZjoYq
	X8OyfgmkKakd9tTi2twjgQxmBRtcl5Bmc5EcUEIbW4dLFiL8U48iB6HsXk5m6IG5
	l/07di1NXDfI0DJCNAg3xhcjzR2TdOhvrwJh74mCHhyacN1oSuhsY+r/QMqu1N6+
	dNyn4RbBTrRrm0t4QNamSa1dtp+BHk/lj92TwPLgIZXsNG8hUuPqXOhThv4+psv7
	IbZGKI2HHVU5EmSeLe4rLIpamo5xTiysmRrNhgwrrmy0tKlUKQRkaA6rt+g8vTKH
	6y+UcqLCwQfK/U4EMVt5zRMLWdaFni3SQSfwa4QjUrOSzLpo3uv0irB7EEVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340365; x=1715426765; bh=qlHTwjIUH1pJBXS8vxqTp7ptIH4W
	4kfh6uFCNIHKqIo=; b=JuH2QGisdmSTpNGhRSAkUsKyigCczy2tx1Yn+NFeuSph
	9fnU6Q+A5IvMLhNElrMsZrqnQVkiyaok0YoXRhk96lwuLGI/AehYSbETauWLoD9y
	YQWj1ShVyj8Dk7rRpsJJfn8AC5n3hMuBXUc9p7JAL9Rtp1M6ikO8qx/GZZFf6i0F
	X9x7j0Pel6TU9ZFEXOXS9GP6lL3WIq+bwJZiW1pLDGv6E1siTeFhv+5ZtLwVIUPc
	pmORR4WeAm31fJ6KyVMAGZ+fWder6y4nUBMOKHzYB5Dboq6ASa9bZVpX+sWRRtXP
	sJj5fcn4p8obvOqMkIKWMS03Q8GOfF5Ydk/8oAOb8Q==
X-ME-Sender: <xms:TQQ-ZhA98-MBSL5OytNHQbVASvVoBo5fgOu9quFE_6V2lMfC-nECWQ>
    <xme:TQQ-Zvh7IwqHi1Zokr9SZFkHtGVva0quYbg4yVPd_Vrrz2OxpiHH-n2Mkj6f-h6n-
    avJz8v272sTnQ6Msg>
X-ME-Received: <xmr:TQQ-ZsnwfIJZwAQ65zLeqi0sqO8rBg4ZKMd1zYD1O2EINsrfIuTQi_rB-_QN-fM5Q87Lo4bfKfxFLYmm0-M6FRqlNE_TlqlT_Z040pBbLxklUteyGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TQQ-ZryHtltmEM017DVFZjHgFmSCCYvFd2OEh9tEKeYoEG5BOsXUHw>
    <xmx:TQQ-ZmR3PnCMtOvim-i-9cBetbhTwNB4DjiOPGOfP12LA1Dumd8g4g>
    <xmx:TQQ-ZuZJ8zJe-PXgNVmV9oX0sEDAArTxokzvKW87RiTAtjhjpd72Ww>
    <xmx:TQQ-ZnSsoExO9Tg9BablLowXJc-Qer3M3-3KB15RXq80mHP7nMzpag>
    <xmx:TQQ-ZpJOWK4VP8A-bs8peDjP9tGD9wS99SShgCY396loljC6XJGegFPq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:26:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 84b0150b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:51 +0000 (UTC)
Date: Fri, 10 May 2024 13:26:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/21] builtin/config: convert flags to a local variable
Message-ID: <05254d512b890b4422a72f0fa17794a237a5bf8f.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q82qCbYaXa0EkYRU"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--q82qCbYaXa0EkYRU
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
index e6bc283751..bbb6864453 100644
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
@@ -1284,19 +1294,19 @@ static int cmd_config_actions(int argc, const char =
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


--q82qCbYaXa0EkYRU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BEkACgkQVbJhu7ck
PpSoZQ//fcdiMWHm2US9j1lOcJ3DP3RG2rOuyDbPEAByazVNRHGEq3WPyPWla7wZ
CICy390SVJKoVPMepnf7OX06PiAyQZ6Bcc/yq6vi1N7lQnfeke+rLvJb+PZvYL8l
3s6FRMuafRGVyy712emE/ihy6QBVRHW58/W+9CERzvvbQQN/qdErAQo88FrXqbrP
1WscO+FSCOIP2zQCMmy29xVPqNvabaVtTRNAuc6qsSIFJEyNLzQ89CC79zR4UF+j
DIW4WjCs02fYoMf/g/kCgCARXuW52rxZrBOHrHWAv3gM4yYfPC57wTZK1P46pmZp
/OJQ7JiziGx20JPDEwYrEQz0KH2HrDRZqbXnqccpWzMsJMyfZjNTAsqjzQaOSO0O
BMz39w3H0ceX0GlRbw7K6LpncfkGMnZeuBk+vhB9BUQJtiSd850FuS2wgTtQGUyO
UBz7QTfau1lLmLN0g7ZiGuA0h+PKuR9D47XIATAYRoTI+Uxuk776utePuYyjO41u
3Ilq+z8tfMQpoubnonEIn52qcA3MpU9BTzTOBYPchFugb7FaQ/K/9cGoEnAkpYPW
4YeKgozcmivX1ITIayZDb+KFCX5G76gZt1d47Y5o0959nVDYM+2jAKw5yptiBo1J
Cx8mgEgQhuZpZq+6I+TJHrcWskoEtjQhjc0lL7hYC/nqb5Mpptc=
=nEwU
-----END PGP SIGNATURE-----

--q82qCbYaXa0EkYRU--
