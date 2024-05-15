Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0E3EA95
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755393; cv=none; b=LCicTcWTGbm4HUwxYTETxMXMIotOBBKBS+dpdWdyMfWPQegmNyCS8AOokYm4V3cTHyUpJvS8Rk1J2/k5Et6XzOsHBlcPe52ZeDBYBbJ80WhJBNsYKEVXfdOKg105VDPVZLEXU9bl5jejCEXrGga3Oo7cwLw/XQpNb5/mWwB2nBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755393; c=relaxed/simple;
	bh=emfVNH2tKq/io4fmDeGffolV6SWlFqrnkOh6sM4i4ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z03iF2uQvx4XudB/X4tBPoszHq0ku4kL2oHEj+EilBrBokuRAK2fCTuPjDmdVLkKGEdIwKKCXQHfhpfuKtineFr0oZBf/plLRMAGMJg0HNbUJE7WW6Zfbwavpa241IGOedB0mW+vMRFNznzgu3UFyp0Fx9Mo8l5zJxmYgD3JgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YddoOhpP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAyb338Y; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YddoOhpP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAyb338Y"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 630221380222;
	Wed, 15 May 2024 02:43:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755391; x=1715841791; bh=epVOIppQiI
	ZrvimJ6QRFmeZ0bCLfBkE3ym5VA+NGWsw=; b=YddoOhpPp7P4zH7bOWCGUPPV+K
	O448YueO05ZrzTpqtpekr7739TpRXlVG8suYS5yKDpbjewCTp50dzwYb/Z+xNSwL
	YMon3M1yy1narKv9jmshIDSeS3MdndCn/p0qZ+rVP/8g9gb24bgdYBBaUPqUOXMz
	BaP1vzB1/uaH6WnB178aamTNCrUWvn2Nq2tjiq0P4MRtcRW/fIm8NrsK6gEd/K5R
	uXKnBqn0Uu3eZxjhYfwdaaOFdxuCia1mg6hlX4fM9NqgIYxwQq8kJscEL5zVt9+8
	YnIX8frGmuF5OjNlJzkZ4Nc41ooOz1tOd+BCSK8m6XIDiH4hAz1+IAzIuAdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755391; x=1715841791; bh=epVOIppQiIZrvimJ6QRFmeZ0bCLf
	BkE3ym5VA+NGWsw=; b=gAyb338YQ1osLJfuUjZIDoRrPFRLMpQhX14Q/LZnyIWn
	A+AcoEwExEtyM2rOC6cvZFi6hNQizxPfH76B6ixul8jpN8RtD/Wx4F08whns5MpX
	3omTkJDZf9jh2VBYSPXh0i47k2ZMT9BIEyzpsgV2NOKpRY1Bpkd+nwWmQk3u1voy
	/N994HXcdYk2834E/S/rjMcXJ1O3HyAtG7mXT0svGtqSsfIFOdlWCh2rtV5WuPzo
	08dCMjTGSOhPRjuyC0PNXl8JDWF7rUTUnY6kIyLnOzyB2lBxYgzCm/Jxpgd11i09
	m4shOa/uWdKdHP4kxJ1BWG6zmNv0ZudTeELZ1SsO0A==
X-ME-Sender: <xms:f1lEZqrUA5mYoNY1L2RWPiimkSHoswtyq6TfhmfkW_Eaxx52l_bj0g>
    <xme:f1lEZopkYFjKf2R90PZjybVvfu0fV8wYYpivJSa69z2XD0w_ghllTCrLLWQlRDFTj
    T0FCufe1We-GjocVw>
X-ME-Received: <xmr:f1lEZvMi942MGhcW9pIrRBajKNsVCzg9WA1GldxOg3MSmE_3L5_H02cNqhEynl6lt67MCq3uaw80rSm3p7RFmugsG7FdsHOZqiUJ2RFj0WsSiQhD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:f1lEZp6fh7Lq8LL1QzG0hEtr0S3lIRHR67ratGEofPyDxiVlrgaz_w>
    <xmx:f1lEZp6uEkMGPc2eSdk2pfy8SKWCKXBa_qSEmQB9vsOaN2FaoZaTvg>
    <xmx:f1lEZpjpZNZ4ouopIVZUhN-q2WTL17EpCyesbt3_GG-20iutzYINxg>
    <xmx:f1lEZj6Xk40fwm835OFKRij-TXbVcfWykjVMQ__gJIWLuDq6lZRyLg>
    <xmx:f1lEZs2P3Z0ZwzXtnU9GPgrLAczLB77BB3911UfiMsOYO920A-6nWm54>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:43:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 783bd70d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:47 +0000 (UTC)
Date: Wed, 15 May 2024 08:43:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 20/21] builtin/config: convert flags to a local variable
Message-ID: <abe33015b73fdfebe3958574071b1081af22fb90.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qRwkljHTseDP7xz+"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--qRwkljHTseDP7xz+
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
index 1f673ebee7..3b588df8cf 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -123,9 +123,6 @@ struct config_display_options {
 	.key_delim =3D ' ', \
 }
=20
-static int use_key_regexp;
-static int do_all;
-
 #define TYPE_BOOL		1
 #define TYPE_INT		2
 #define TYPE_BOOL_OR_INT	3
@@ -319,6 +316,9 @@ static int format_config(const struct config_display_op=
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
@@ -327,6 +327,7 @@ struct collect_config_data {
 	regex_t *regexp;
 	regex_t *key_regexp;
 	int do_not_match;
+	unsigned get_value_flags;
 	unsigned flags;
 };
=20
@@ -337,9 +338,11 @@ static int collect_config(const char *key_, const char=
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
@@ -357,19 +360,21 @@ static int collect_config(const char *key_, const cha=
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
@@ -441,7 +446,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
=20
 	for (i =3D 0; i < values.nr; i++) {
 		struct strbuf *buf =3D values.items + i;
-		if (do_all || i =3D=3D values.nr - 1)
+		if ((get_value_flags & GET_VALUE_ALL) || i =3D=3D values.nr - 1)
 			fwrite(buf->buf, 1, buf->len, stdout);
 		strbuf_release(buf);
 	}
@@ -848,11 +853,12 @@ static int cmd_config_get(int argc, const char **argv=
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
@@ -872,9 +878,12 @@ static int cmd_config_get(int argc, const char **argv,=
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
@@ -885,7 +894,8 @@ static int cmd_config_get(int argc, const char **argv, =
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
@@ -1290,19 +1300,19 @@ static int cmd_config_actions(int argc, const char =
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


--qRwkljHTseDP7xz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWXoACgkQVbJhu7ck
PpRIPg//WAJjaiFy4PhmBF6JhPlGeHiZcaX/ku596E35gU4MlhkkJPmxz1tK7LRO
BEanlhFlFZt5ladCV0gwo/Hxcil35D8Z+iv/imhOFfc7LLI/uzkXnogmijkDAddy
RWMZPEYclP1ku8+z5TOk/BSiMuWq25p3AKzPtsKFlNvGwJVlc6wvSNzVLyRD3LZU
Wf/GIQ4GlWtQ87SEmkQLDpH1i5VPN+pes3/T/9IwpyNWl4tgXoWSFXo/d5t2lrAV
uwk4YFg55hQ3NNXx3+Sw4w5T3UHP/ZAikiPQnQ7DWT+MjcQYe+lXbUV2t2D7BiNH
Z48m8jGVZV2Yfjwf9kaBBOTr3l6IU8z2SyqWlryLuNTepCx5buImx5mG5tesTBzM
+b6UBSKGeqqXbn9ghkwme2aSjwo95nGI+EnKNDtDCbOLIEsdfKsBxLNbXINd6Vx0
P0PkMzSI7z0boyb2A2dpxUzYd7YhrrRqZkC9NpFCMOU0h9YcplEffT5RcfYh5m2v
q4IHqSfkr4B0N4+aazFbZx/V0t4rRhMr1T1yQctvJqhYZsWIHPG3lM5wTi0uz27o
2I91EdFkXYIt7TRH0Q32XmftwqLGLctSp9Yk5uE8iOSrkFnm8naf3HmgaWJ60anm
m1lKfVqdKwlaO2g965bRUfc33Dv9XEwAqGmKvl4suIurvWOZ+sg=
=WARz
-----END PGP SIGNATURE-----

--qRwkljHTseDP7xz+--
