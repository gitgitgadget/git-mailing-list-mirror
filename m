Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D251117089C
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340323; cv=none; b=Qho8beNIEuAniZeN+XEEqFnKkB0pxKT+yOeYI/2Eh2sGudVclwlRrDaBC14Ujt+sl9a3hqOSmiCM5wu0kafDbVb4U0/hwrCdZMXMXsOjmG1yKRIxw8LpNflOG0jhDbW+YSJKP1+sTPUYUUneNjKyBtgjCrIGQjyPZcac9bgttjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340323; c=relaxed/simple;
	bh=POYZhvoPzpLJCRiyUBWN0srjVqTmgQ9G42W78xHT3f8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5undl1MkZ02Wcr0IGW03WlOKW3sLAWBk6nHa3YYZmn4CfvuWMtHPzbzg0CB8jfsFB6uUww0GZ8TfdSB0oYot1FQ8GKmXvyEVrjDWyqkX75QJw2MaGPFkiXdliWwgZs6d2d/DbdIE1wm+7D3XQixyJ0DNqkPZrB+y2T+vZW+02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dZ2WO7RM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3Ca5mnZ; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dZ2WO7RM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3Ca5mnZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 180421C00098
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340320; x=1715426720; bh=YVb8TYgRuw
	HSnjN8vDiwIR1lMeaAFV+ygocaVFDh3C8=; b=dZ2WO7RMba066CRCN8hhgWCF60
	+arlwPiegYPEaE4Au7RP1ydf8BAJnSXH43FW+15gkEnoaPoNcyXVGJjCkbYM6+hv
	pt6CqWwoBiQjeXS6pmJ67feCF1GEdnCtuDXlPGbDbI8GSUW3tW3Y9qGn29oc6As+
	93LJYI1hJLM5TYJG9KpdzaLNFBhi03J1JQ2pCAIJWdNXyCErHHywBXuLSzMlSbQc
	3IqV1cFaHIPjWpPNCoi6SMThztn68zK3guzY/IKj0TDfc6E2veChvgOvAprHqPiN
	XbptEG1vM8rdhIdP6itvbnY0qEDCURRwP0CyDMhhteID6fHsBp0WHTD7qvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340320; x=1715426720; bh=YVb8TYgRuwHSnjN8vDiwIR1lMeaA
	FV+ygocaVFDh3C8=; b=j3Ca5mnZV8CjM9TRBwNDGX517r+YkJLX0wHXbmjk/fKd
	7Hb2J1b0UC1/HS/HHvVE9rM+NOJAkNl3JnIxcAq+NhjFdCi4jwJgU8rEznxcbnu2
	SIrbM18fpjOqGo3lTndISyDGVqjCkeZfQ9CJdMdMdm1kr0VOn3NZZiPoy+uo2jD9
	nmbUy/NrL+SpTPBUNCcZ6VjBxRhG4SBdr0xhXcJaG0NUoaL22up22XT9KF3ENDTv
	jh7pIU+w06wbYsYOmTXSY6E04qEw678fCOZF5QliZTq0PsgZR0UFYde0X+gbVsx3
	5Nn4pz13VyvnWJ7G9UijsNWcMKqLPr/M/JrVKBS7FQ==
X-ME-Sender: <xms:IAQ-ZhgCqLEN8M5GkZKp5R_ypIqj-TsahCd0FOE4-S513QSes9xlQw>
    <xme:IAQ-ZmCQgJxF-C1zRi75n-PDvGxXjeYjZsSY4RlHw1_PvUS3vEERI9dhrsSWm6gu4
    vI7xTJt9BLGyk6MTA>
X-ME-Received: <xmr:IAQ-ZhERVHQR5u5q95vhpbsI_J24S27XXl93gpB8mWciRDpNDA21dXn_YoKEf0dPtYYGdiTg-tpBIYgkIsvUOoazLexYbLaB16ATYwRcBDS3wLmhOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IAQ-ZmT2r83VBOG1j8CN99siiGDCCPvgPzLwtT_z205N1171WWfumg>
    <xmx:IAQ-ZuyEvcPbCGJbS2hY1xzZ3N74roNrdSxFlnIVxNxF7OwADJvNXw>
    <xmx:IAQ-Zs48lE8MRyAdinaM6b1M69G0a85w3AwAt_nsuDkdBYN9VxNFnA>
    <xmx:IAQ-ZjyJRDWbe7UCwaTSwce50rpzIT7jgPkCaCwex_MxWTfPKfYVTQ>
    <xmx:IAQ-ZjrqgaF1TLtSmJGX0O88QAphvsWRr9IV7iTdPedOasVS5wV_AFia>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 888ecf8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:06 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/21] builtin/config: move type options into display options
Message-ID: <96108976627fbb4b650156538441e2f3f5a8a490.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OJSi1shcrZBF21Up"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--OJSi1shcrZBF21Up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The type options are tracked via a global variable. Move it into the
display options instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 60 +++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 7089692c4b..1f864f71c4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -81,13 +81,24 @@ struct config_location_options {
 };
 #define CONFIG_LOCATION_OPTIONS_INIT {0}
=20
+#define CONFIG_TYPE_OPTIONS(type) \
+	OPT_GROUP(N_("Type")), \
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type), \
+	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL), \
+	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT), \
+	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT), \
+	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR), \
+	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH), \
+	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE)
+
 #define CONFIG_DISPLAY_OPTIONS(opts) \
 	OPT_GROUP(N_("Display options")), \
 	OPT_BOOL('z', "null", &opts.end_nul, N_("terminate values with NUL byte")=
), \
 	OPT_BOOL(0, "name-only", &opts.omit_values, N_("show variable names only"=
)), \
 	OPT_BOOL(0, "show-origin", &opts.show_origin, N_("show origin of config (=
file, standard input, blob, command line)")), \
 	OPT_BOOL(0, "show-scope", &opts.show_scope, N_("show scope of config (wor=
ktree, local, global, system, command)")), \
-	OPT_BOOL(0, "show-names", &opts.show_keys, N_("show config keys in additi=
on to their values"))
+	OPT_BOOL(0, "show-names", &opts.show_keys, N_("show config keys in additi=
on to their values")), \
+	CONFIG_TYPE_OPTIONS(opts.type)
=20
 struct config_display_options {
 	int end_nul;
@@ -95,6 +106,7 @@ struct config_display_options {
 	int show_origin;
 	int show_scope;
 	int show_keys;
+	int type;
 	/* Populated via `display_options_init()`. */
 	int term;
 	int delim;
@@ -113,8 +125,6 @@ static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-
-static int type;
 static char *default_value;
 static int respect_includes_opt =3D -1;
 static int fixed_value;
@@ -264,13 +274,13 @@ static int format_config(const struct config_display_=
options *opts,
 		if (opts->show_keys)
 			strbuf_addch(buf, opts->key_delim);
=20
-		if (type =3D=3D TYPE_INT)
+		if (opts->type =3D=3D TYPE_INT)
 			strbuf_addf(buf, "%"PRId64,
 				    git_config_int64(key_, value_ ? value_ : "", kvi));
-		else if (type =3D=3D TYPE_BOOL)
+		else if (opts->type =3D=3D TYPE_BOOL)
 			strbuf_addstr(buf, git_config_bool(key_, value_) ?
 				      "true" : "false");
-		else if (type =3D=3D TYPE_BOOL_OR_INT) {
+		else if (opts->type =3D=3D TYPE_BOOL_OR_INT) {
 			int is_bool, v;
 			v =3D git_config_bool_or_int(key_, value_, kvi,
 						   &is_bool);
@@ -278,24 +288,24 @@ static int format_config(const struct config_display_=
options *opts,
 				strbuf_addstr(buf, v ? "true" : "false");
 			else
 				strbuf_addf(buf, "%d", v);
-		} else if (type =3D=3D TYPE_BOOL_OR_STR) {
+		} else if (opts->type =3D=3D TYPE_BOOL_OR_STR) {
 			int v =3D git_parse_maybe_bool(value_);
 			if (v < 0)
 				strbuf_addstr(buf, value_);
 			else
 				strbuf_addstr(buf, v ? "true" : "false");
-		} else if (type =3D=3D TYPE_PATH) {
+		} else if (opts->type =3D=3D TYPE_PATH) {
 			const char *v;
 			if (git_config_pathname(&v, key_, value_) < 0)
 				return -1;
 			strbuf_addstr(buf, v);
 			free((char *)v);
-		} else if (type =3D=3D TYPE_EXPIRY_DATE) {
+		} else if (opts->type =3D=3D TYPE_EXPIRY_DATE) {
 			timestamp_t t;
 			if (git_config_expiry_date(&t, key_, value_) < 0)
 				return -1;
 			strbuf_addf(buf, "%"PRItime, t);
-		} else if (type =3D=3D TYPE_COLOR) {
+		} else if (opts->type =3D=3D TYPE_COLOR) {
 			char v[COLOR_MAXLEN];
 			if (git_config_color(v, key_, value_) < 0)
 				return -1;
@@ -443,7 +453,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 }
=20
 static char *normalize_value(const char *key, const char *value,
-			     struct key_value_info *kvi)
+			     int type, struct key_value_info *kvi)
 {
 	if (!value)
 		return NULL;
@@ -787,16 +797,6 @@ static void display_options_init(struct config_display=
_options *opts)
 	}
 }
=20
-#define CONFIG_TYPE_OPTIONS \
-	OPT_GROUP(N_("Type")), \
-	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type), \
-	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL), \
-	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT), \
-	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT), \
-	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR), \
-	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH), \
-	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE)
-
 static int cmd_config_list(int argc, const char **argv, const char *prefix)
 {
 	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
@@ -839,7 +839,6 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
 	int flags =3D 0;
 	struct option opts[] =3D {
 		CONFIG_LOCATION_OPTIONS(location_opts),
-		CONFIG_TYPE_OPTIONS,
 		OPT_GROUP(N_("Filter options")),
 		OPT_BOOL(0, "all", &do_all, N_("return all values for multi-valued confi=
g options")),
 		OPT_BOOL(0, "regexp", &use_key_regexp, N_("interpret the name as a regul=
ar expression")),
@@ -884,10 +883,10 @@ static int cmd_config_set(int argc, const char **argv=
, const char *prefix)
 	struct config_location_options location_opts =3D CONFIG_LOCATION_OPTIONS_=
INIT;
 	const char *value_pattern =3D NULL, *comment_arg =3D NULL;
 	char *comment =3D NULL;
-	int flags =3D 0, append =3D 0;
+	int flags =3D 0, append =3D 0, type =3D 0;
 	struct option opts[] =3D {
 		CONFIG_LOCATION_OPTIONS(location_opts),
-		CONFIG_TYPE_OPTIONS,
+		CONFIG_TYPE_OPTIONS(type),
 		OPT_GROUP(N_("Filter")),
 		OPT_BIT(0, "all", &flags, N_("replace multi-valued config option with ne=
w value"), CONFIG_FLAGS_MULTI_REPLACE),
 		OPT_STRING(0, "value", &value_pattern, N_("pattern"), N_("show config wi=
th values matching the pattern")),
@@ -917,7 +916,7 @@ static int cmd_config_set(int argc, const char **argv, =
const char *prefix)
 	location_options_init(&location_opts, prefix);
 	check_write(&location_opts.source);
=20
-	value =3D normalize_value(argv[0], argv[1], &default_kvi);
+	value =3D normalize_value(argv[0], argv[1], type, &default_kvi);
=20
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern) {
 		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
@@ -1124,7 +1123,6 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 		OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slo=
t [<default>]"), ACTION_GET_COLOR),
 		OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: sl=
ot [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
-		CONFIG_TYPE_OPTIONS,
 		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
 		OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, us=
e default value when missing entry")),
@@ -1145,7 +1143,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	location_options_init(&location_opts, prefix);
 	display_options_init(&display_opts);
=20
-	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
+	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && display_opts.t=
ype) {
 		error(_("--get-color and variable type are incoherent"));
 		exit(129);
 	}
@@ -1242,7 +1240,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	else if (actions =3D=3D ACTION_SET) {
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
-		value =3D normalize_value(argv[0], argv[1], &default_kvi);
+		value =3D normalize_value(argv[0], argv[1], display_opts.type, &default_=
kvi);
 		ret =3D git_config_set_in_file_gently(location_opts.source.file, argv[0]=
, comment, value);
 		if (ret =3D=3D CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
@@ -1251,7 +1249,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	else if (actions =3D=3D ACTION_SET_ALL) {
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 3);
-		value =3D normalize_value(argv[0], argv[1], &default_kvi);
+		value =3D normalize_value(argv[0], argv[1], display_opts.type, &default_=
kvi);
 		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], value, argv[2],
 							     comment, flags);
@@ -1259,7 +1257,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	else if (actions =3D=3D ACTION_ADD) {
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
-		value =3D normalize_value(argv[0], argv[1], &default_kvi);
+		value =3D normalize_value(argv[0], argv[1], display_opts.type, &default_=
kvi);
 		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], value,
 							     CONFIG_REGEX_NONE,
@@ -1268,7 +1266,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	else if (actions =3D=3D ACTION_REPLACE_ALL) {
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 3);
-		value =3D normalize_value(argv[0], argv[1], &default_kvi);
+		value =3D normalize_value(argv[0], argv[1], display_opts.type, &default_=
kvi);
 		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
 							     argv[0], value, argv[2],
 							     comment, flags | CONFIG_FLAGS_MULTI_REPLACE);
--=20
2.45.GIT


--OJSi1shcrZBF21Up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BBwACgkQVbJhu7ck
PpRGHw//W+t1vMWeoUqY3ODZ5I7hfTh3G6sZxw1DFKScNT6d8cuTDvBNum7EqSkD
GuaueXa0MthwBvmIe9VZ5SZdkTQvZnBNG/+97Vow40stvo4AZQW5c1VbIMZ4nOOs
FwS3l0rpuoBq1yzHZNVMJPwj6JraIqvMk8InJdsHEAms7f0fublRbVTbtkWKJ29+
67wnJtf3jKSW9dYQHSNzvACgnTV6V3LPSzkODBxvzhpPZRbXYvzoJ5TMvzjm/Shv
ujKb9a5QF+AKGFx5F5hAN2IcocwXNCNhlsIsYn8ZZsZBlNBUGgDjK2h1bEJouRi0
xd7h2kVx0eDhTsvgwbpP9GlUNnvBVB7WvXgvgE9JU+03avbxhtLBa9fcCgQEuran
hf3fFTLpHYSEKQbMQbJDpIfzEUOr9U3+sn7oDWyB64CUJwXbL5JkUGTodkDaNhf5
mpaQX/998E/r5aFF8A4s0EI8v6BXEBPSTa7PVJQ+CAEACBPrXPhKqwwGMpVEAQit
XeJnPWFRdwZdRSwXSkq7q6B1Bb0y19Ydod8GynssXCAkwKnZ5WuNGN6RsiA4DCQm
USi3EgwZSQtDr6FPhYNlTU6qOzWjgFN1bp50/tOXHq/izut/5C9+dogBtYe6xsLq
xv1lZSC89en+nYQZxd1VCjLNkC1jP3JXtZkgUaY0lg4PYIl/LKU=
=339B
-----END PGP SIGNATURE-----

--OJSi1shcrZBF21Up--
