Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEDC14A4CA
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595780; cv=none; b=saBwhetbaRrGl7eCdkO+K7OKr203Fbl07DV991vD5cHEskoOB//OGO7jbSKXXQC4EGHZqgg2lDySbjbhSNVBrjLR6ocHM/8MTbXazXHFmetOBV0EQW8LmvB0m28ejVtVl4q+2uS31WzOjWA185uTZVwo21PcwpyWrdspfkmV2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595780; c=relaxed/simple;
	bh=8dH4/LJdgeUQg5AZ4zu69//iNp/m78ZjPSua3VU1O2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obgY2DYGU0iPMvyHJLyEYgQfS4A2f8o5kpCZhQkLaSb+DeVBi0athDgc65+RUx+T3uZPbPLP3Lsve/212Gffst8g/R5NZOf4sqvxHTJs4HiBJP22NB25ko+Jl+gAStDpHBMs1SWGd6RIJWGN+H9NILCP7cFhEwjjIq1OtTwsn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O7cAugtP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dod9ojQz; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O7cAugtP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dod9ojQz"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 7F2001C000E9;
	Mon, 13 May 2024 06:22:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 13 May 2024 06:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595778; x=1715682178; bh=yyIm7/COQn
	knrxI728aNrPJ95up8bik/H9b8prU42dk=; b=O7cAugtPc9ZLqEKH14B42uTMuJ
	ZPfxlOWP8MKEgBSC30oCfen/l+Lk4Ay8rUpD9cA8RawX+7kPAV9hNanNmNR8VdVf
	x5JcpYvUQa2GiXQOL5WTi7bm0/vBd7wfOlX/K+CKvHnY14CbMRhTQspa+mcTH29G
	D8Oh6z1+kujdEqoClExVxM/upiVbEf2gQDhhz8+y//+4NWHEqQ4pCR8zR3vqjz1x
	t+9v5HaHQ0n0DaPCCuAwySKtDEjZxjaNVD94wBLpAOBWj/muVIg0TTJrscuMYmzv
	gRgIR0gduTlQ92DITnfN4EyGQZFNOfprfNdjVDqpIEVvfJWV1+Nf8hTb1gBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595778; x=1715682178; bh=yyIm7/COQnknrxI728aNrPJ95up8
	bik/H9b8prU42dk=; b=dod9ojQzeWNOG8efAKqueTg3H+dILPspJb5wJlgiEAcB
	0C1xlzSZq/a+8ybqudOyO0BBIs7uXdiFGNMoPufPOV7Z4HbgeW64TfXWz8NetTXN
	iwXJFTwagCHGpl6gF7WFmd9k94XEGo5ZxJkx2/wkEr0/DzPnEWWMM4UeK6bsUNsn
	8zpJiEQVilCfCyC04Foy+ESM9QJHmJvLNrZMhzNES4AfWnbhK9CtPSJTkTHMLcTi
	jRcPajR7eKR9NS6YL91yINfX+zm41pLh27/fO/mEyTHr9VWHFKMgM2EpUK7zxsT3
	1aiYoNNopCoCAgklIiOlw5j1HpcrPU/Yqb5afjpeJA==
X-ME-Sender: <xms:AepBZpTIw3-d6sGn6NOpzP8mZF-wdqBJBNqg4Gn7Z5_vceJW4CPgKg>
    <xme:AepBZix799S24HZp9b41-z20f6aNO-GerdPrYYgFRlRLJRNH_3PqDhuuTtHFhLHgL
    ikrtuCQHObZkju0Nw>
X-ME-Received: <xmr:AepBZu1R-bHNBhy0eKVbXOsENUDeFkK1w4FQl-lRnlybGFvOK-RnGwaiwAhFC5fhVs63fwb3IovGfw9K0fX7k6_9gR0yWlBGnOfsR__EAop4XVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:AepBZhA8IhhYJgNxY5Jd3G6nyv5irl44SDjYXygmy0oStqJonlBzSg>
    <xmx:AepBZii3jYOqeNW7GKNacfXo4svm98avktbYonzB-LQO46lCmC-XMw>
    <xmx:AepBZlqIq18WYKSE5xk0PGRoWxRpRS3uXHk-LByqfka_sqCNZF7F0w>
    <xmx:AepBZth7Hwrnbg7Jcmr-EYHplLYsfBfPUMY2iANpDgjxx8LiaICd8w>
    <xmx:AupBZqetIz_3h9uJ1yyvCmEHf1sThu49Y_cbUCDut9i50BbwAHVB_Kea>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 76baeddd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:38 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 11/21] builtin/config: move type options into display
 options
Message-ID: <63436c34165ee6744cfa15aea5c53adab361d07c.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZDt7sTZ/FkPN6Yod"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--ZDt7sTZ/FkPN6Yod
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
index 24ad8e7476..6d2597f7c2 100644
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
@@ -1246,7 +1244,7 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1255,7 +1253,7 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1263,7 +1261,7 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1272,7 +1270,7 @@ static int cmd_config_actions(int argc, const char **=
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


--ZDt7sTZ/FkPN6Yod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6f0ACgkQVbJhu7ck
PpReeBAAm349V76lnepOesAWd3aC3988JH0Z1lE9vYagq06kCkP1aRTcOOewQpaV
iliS/74dn0RAeD36R1mQbQ6mzKAGH1U5bLC6Ii2ue94piGXmPyVBMzFCrZCRqCbS
N56rEh6y6tErJg9gc7bgOyiQvxUGE2SEfrsX+DEV24ZBkcC6hoeAqh4V6r9iuGOL
0Uzz7t67KDS04Cx2kN4ZC6YTv+2B888+PWdsRVX6YjtOjIGkNWxsoCMXHF+iVtF/
P6TPCBICU6TTbE9otcY3IjUhen+EH/1m0U+6zECEGnfXG7w2sPamZDlAnEb3e7CT
XVYF4fJ3iInAGVsttJ++KfdBQK3gCsn/hTWYVfvGyjNvO6GmagEI30+D7c/lCAVz
aa8Wvu4cJYfu13wZcf5rqAHkZUWWqjrQmrGytUU0r6VWg0FVFHOkCz1XlT9TQhzG
Z9yD9e2andqUmb8gfkpUQzO40Z+ejXA1V0H/++viFC0KTlx2IF0fP1+XVhVtGaDk
1nioJv8v6zV7D84TL2xBsukrUTH6OmjVg+8Vd+jsR8bDMv7r5dL66U7VL0AZKfVc
o5ljmHxOasdDGlV4racy5AfJ0XJvZdqG4jHnt2JcGFIv+za8Ox6Hps0TPygv2rol
8trb7uQEHZzqXU4z6BPXEY8rp6S3fLhCFjYwuKV7D7iYCcGkHcE=
=gocw
-----END PGP SIGNATURE-----

--ZDt7sTZ/FkPN6Yod--
