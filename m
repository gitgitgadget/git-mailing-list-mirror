Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28445948
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755351; cv=none; b=D4d2tH2zoMyASnJZGF7hj+VwCgI1uTowhSYSara1PHCuGh5qu9+Bpst1N96WGz5Ha8arNjT9ShkStd3tLrrruH+He+ghxVSSkQ80L1DWY9J7gSOpNFS1cBKFJbHN6GewQoPicZrN2qe/NN7Rb1e3apj29IattsI8wdw3GNXmSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755351; c=relaxed/simple;
	bh=FUM7vffGEVbiD1yOzczlw2VZEdIDSJ/1UlOVBYSz+TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjFab6YfD9SmpjsxUtAI4C34gmB4rbBXl89FS1xU2f+80QculPnNUMa/bxccjJ48sXXXRdlNTYadQqOGIJrQMxo89HMykozld+6s1xmzNm26IQ70sP84g8r1ePvCCgqHPSllskDwoSKe2VogqdDr28/n+LWDYCmIteQjmv+gWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=csF4SezW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSyJiY5S; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="csF4SezW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSyJiY5S"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F243311400AB;
	Wed, 15 May 2024 02:42:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 May 2024 02:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755348; x=1715841748; bh=UWwG16VCC3
	PCZ1LBfhuNdGcDADG0aVkhl8jD+naDAAY=; b=csF4SezWaoy8EM0aHz6uKAe1dS
	kf/nS9WxEml5+GeSh/W/2H0EZYEFuGylxDqc0G+DXt8BsoIbqLf6LS79HByxKuY/
	nPT0BLkuPcG4ThhHgHz/w7fHCxAjYng5VvS6UKv9yQ6D3cn1zz0ITEo1i5Ylslo+
	UV8PiW/Prz3fcFFHy25Dtx0V3ncDMBPd5JQ/XyuuSAw5YGvFgV5smv7clrrHC8XX
	17COvipFXZqTAKsEumbHkioSVsspfzGv59kfw3lW9DIffq1t6sBQTXT3kPxbI1JG
	h4CaT4S1ozcwbl9cOoLXFkola1l/YwR0AVyoFF4O55Svod5a8Hdqmco3rryw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755348; x=1715841748; bh=UWwG16VCC3PCZ1LBfhuNdGcDADG0
	aVkhl8jD+naDAAY=; b=ZSyJiY5Sa4E6DkyNgw/zLlYbjNGraMQcfBUeEZdjFdHG
	NYsy2QC2R1uugOAZQnTC9BDLoCjYbBHruqaqezDxYFb8xfIn4sfZP57qxu4tsqZ1
	V80OggNdO/dXNfi15kZpU2llH7eD+7CL1nQWvyq11vxscOcMrHzOQyJzYIPcE8OG
	g3g8ZAF0D+vdnzkqoazK7Mnv2M4TF6JZKmhdz6zjsu8dVGHEASSV9QQAoxsERadd
	r/qfrGn0qUmi8E/n/9mmDbOkOPvgqGsoQfAmtXjPMgiLHzR1iTYgIBxhXm07Qb7Q
	23BRuWUyNI7b5xmg9gqMjcY6gXHGUD7ptHZxQVZjsw==
X-ME-Sender: <xms:VFlEZg_D8KE6vO5tFhHtPhvqfUhyWnT8Q1lRoHQe0Iz9d8aLHVOBNA>
    <xme:VFlEZoujjF71REmsfJ7eQ8mgToHU0gpYesuDNHHsICnYvH7M1NKkNQpjdEBdVTyjA
    19uYOFv3Jq0KPCVAA>
X-ME-Received: <xmr:VFlEZmDcVOIg3bgtyg_OsrFIBuK_PK6LuhgMm8KdsFVW4CFxjsNDZkuynwzT8afF1r15PGeenI4TRGhdQHeshITukpjSrWgMAlVoVHC8M-qRc82Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:VFlEZgeBg0lLl9nQC6uk-Pw2nlIHusOmnW1ZvwIoEshLBf1q9rJhaA>
    <xmx:VFlEZlP-obMbXtPUmlEGYq0QfiiitNGGhWIFFddQmPLozeT78DfQig>
    <xmx:VFlEZql34vWEcEGrfNeWdOpbML91JKGhz2xOsLD2gKe06EpVr3wCeQ>
    <xmx:VFlEZntaWHnWm_27FIjSTVrQpbp-t62GfZAJY-XAhQB3kDZNzM4l3g>
    <xmx:VFlEZqqdTlK4RX1RsKF_Z6rmAxZD2Bs_uhyLXFKliVZzsQo5lKQjpjpe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d5487d5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:05 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 11/21] builtin/config: move type options into display
 options
Message-ID: <5579371ad192ae4650e9598760df3350dca3b9c9.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lAfMLX8NJqPH11tP"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--lAfMLX8NJqPH11tP
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
index 1a67a6caef..ff111d83a9 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -82,13 +82,24 @@ struct config_location_options {
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
@@ -96,6 +107,7 @@ struct config_display_options {
 	int show_origin;
 	int show_scope;
 	int show_keys;
+	int type;
 	/* Populated via `display_options_init()`. */
 	int term;
 	int delim;
@@ -114,8 +126,6 @@ static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-
-static int type;
 static char *default_value;
 static int respect_includes_opt =3D -1;
 static int fixed_value;
@@ -265,13 +275,13 @@ static int format_config(const struct config_display_=
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
@@ -279,24 +289,24 @@ static int format_config(const struct config_display_=
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
@@ -444,7 +454,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 }
=20
 static char *normalize_value(const char *key, const char *value,
-			     struct key_value_info *kvi)
+			     int type, struct key_value_info *kvi)
 {
 	if (!value)
 		return NULL;
@@ -789,16 +799,6 @@ static void display_options_init(struct config_display=
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
@@ -841,7 +841,6 @@ static int cmd_config_get(int argc, const char **argv, =
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
@@ -886,10 +885,10 @@ static int cmd_config_set(int argc, const char **argv=
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
@@ -919,7 +918,7 @@ static int cmd_config_set(int argc, const char **argv, =
const char *prefix)
 	location_options_init(&location_opts, prefix);
 	check_write(&location_opts.source);
=20
-	value =3D normalize_value(argv[0], argv[1], &default_kvi);
+	value =3D normalize_value(argv[0], argv[1], type, &default_kvi);
=20
 	if ((flags & CONFIG_FLAGS_MULTI_REPLACE) || value_pattern) {
 		ret =3D git_config_set_multivar_in_file_gently(location_opts.source.file,
@@ -1126,7 +1125,6 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1147,7 +1145,7 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1248,7 +1246,7 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1257,7 +1255,7 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1265,7 +1263,7 @@ static int cmd_config_actions(int argc, const char **=
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
@@ -1274,7 +1272,7 @@ static int cmd_config_actions(int argc, const char **=
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


--lAfMLX8NJqPH11tP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWVAACgkQVbJhu7ck
PpS8TxAAgB0kvUm7tt/kmf2vlJECNvu+3GzdQBoIZKPYs4pXUGi15VlpkkChElA1
CYh7rA/UiELbgRZ6gRU57gJEbv4/3xAOkpodP6LcnyIkEYIShLDZG5sMqL6XxuH5
BIi8KCD45zPaNpQQokl7vdR+wanVg6nV1XN7xj8Nr/QhWsNBChGHpMa9t8nGL/i9
pIC4TwbO0S9nIRBZR1RTmtjgr1MkpwXAmhvbcPKKfo/qTS3BzDFj+QguCSCcxXg3
g+VZPxoHgE4qbTWW9POxfqbIiGbhUaQpuxbcNS4X11I4gLwnLLtsTrGdmTwIEhFa
7yVuSHp89Ma7ZWpZuuUdKrlHv5SOnPieLx5O1Cw6u1R1IF+hBGkwCxkAOcDNp0tp
+cA7fUtjok9cjMKRjA6dgQAQkkkHrhdj2noveoO7YQ2XD909LI8FlqjQVxV65wpy
cSt6aF5Cwz4EtYjfcUBNMryWgUjloIXTK0Hd6iGDFWayelLN+Vaawr1EkRnYQ89W
d8cx2jlGXbpgTkXGGnUt1vM5WzXqD55kJ8+724oWYlIP0WiuWvThRBPZXq6IHD1U
ToNZpw7kDFoT916ykBTYewimU0RMif/sRbHCvISNnHmKXeDAZqkW7Z9jKqbjKE90
l3D1L+o7QzcwTLOn+s2FN4cXrgtiR2YPlvMUMRHGmhk7ufHRpP0=
=w6ci
-----END PGP SIGNATURE-----

--lAfMLX8NJqPH11tP--
