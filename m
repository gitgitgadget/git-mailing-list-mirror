Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F8314F9D2
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730232; cv=none; b=dhaR7zvki2rK3eLJFn2OR3OlCWp96mdVxgWo/AshUi1iiYji1La8kRB6zcg6ngQzPvtS2YgnKrUE0jPiXVO/nYImR8UjQAjCpASgystuGi8gG8EELB38lbyk3vFWUgnLDrwhVhVjDFHKmOtacSbj4ilTA5DfVA+cBvwQ9Ebn3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730232; c=relaxed/simple;
	bh=HWN1aA5F3PvV6hTNXqYr7lDCqC0NeQ/s0XY2odGGd74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKZgx/4KpJTrs58gHvZ9yAk1vhel2pmCtYxtLyr2ioQxhMYINyQKWdx1qgrC2CLT/60Tvyh+kKZT7NLEqYaS2A0LZMsmb1WjP+mSi4faga4/6bmE2JQxIezr9AXHfihVcK/2xliH/G6ejdOfdomzjiGU9Ei4NrulxwEMmrABGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lgFFGlE4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpAuw37h; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lgFFGlE4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpAuw37h"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2149F1800130;
	Fri,  3 May 2024 05:57:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 03 May 2024 05:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730228; x=1714816628; bh=wZn2qgAE+v
	Ww48zQWWVOqkzj7T5G7NZKAd/F8ioRbGM=; b=lgFFGlE4CwsVllB3wUkIjcojRE
	K4timipAmDHwMKGMPQ0QmMSwhFch3MDDEH9hCc3aG5VXxjOgppPFtZy6ruGNPXCA
	wMnzyI7Vxyr2jyaD2FulvSyWHjDlI2rs+QwrDT6NEz7PGmA8J5JJgJQSnKPof4Rw
	WPYKPvKzcDNWv100ri1u1/xOLiYwuXG4w7UmZf4Bo/gp7m4cqZRVH5T8/YW1cw2j
	KPbZ6PwCOR54TUF27lclIZ8a1wPw+jZRkF2nH3S1fIMtzwJCI1hPXqDf0qKU/EJ5
	R1xELiD/T6ruW/ZXnL4m8Z3rHGV6vI/8X7OJXWdh4hedv+Vqs2+Jxc8h3kVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730228; x=1714816628; bh=wZn2qgAE+vWw48zQWWVOqkzj7T5G
	7NZKAd/F8ioRbGM=; b=NpAuw37hCFOlLPHgdgb0WfbMareYmIiYy5Wg/dUpTsLL
	FvmOz39jBjOts3YwumZ0IrXXvLwf6B/9FKKTnV9B6QPu0k0cwaUeW/df+51tS560
	lFElESGGYsEDK2j2VXHGS6+8JF8Kvsj83u/Xv9+ZpFkFXCPEOI9ZSeF0/e/M8lpo
	JixC247pPlp+iogbfVneUh6a/rv7S6mux+MRUFL+bPELmwOCfcGE5AGEXylWc8rv
	w69dhVatn8wQIXI6EuwuL2Var3Wnssq3xbuIV+foCV4yshqcswuKLfUz/q69V0Vt
	3g7zDoaq8JkgcluZgq2mqGHkFskOwSDnKLUXaM1Fdw==
X-ME-Sender: <xms:9LQ0ZkBC0mkkOmaz2cc1_rCpsbY0LcI0zrUS1o7TTH-yWiSHMl19Kg>
    <xme:9LQ0ZmjRAdHJUxYEWsV9Nze_2DwXRLinHkyoPhXmG3FUt_Z7geQYSpHFQKsq5kPyy
    _hWo1PExekDFlTEGw>
X-ME-Received: <xmr:9LQ0ZnnxKdM0PuuPESEyVfqvGuu5dvvg0nr9DRjwyKIXoES4Bl4kb1I2J9ErjNrX1LJvuOuZK5zVSlG3EuabV0zvoTXqoXyui3PuCOB2CbH6my0P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9LQ0ZqzyPWYeT4fQnls4UsFsTDXlNna9fxkntbzDoQcFfnY6JVQJ2A>
    <xmx:9LQ0ZpSfOkvUNtc9qqg0qwIgguRBcIGYpBI2CjC_ENZT8K-P96oasg>
    <xmx:9LQ0ZlaGq6jXVNr1evPE1b1p8rb1tUnd9TDvYE1vjRhNgi3ZzZaxmg>
    <xmx:9LQ0ZiQIn8me40t3S_cjypWPs6sVoiEPEyeVTCcZgtrwRgt3PzRbVw>
    <xmx:9LQ0ZoG3VDPL9AAZLQU_2N4Xvq1VA1CIg25IydVlgtR08Upk57pNIV1g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:57:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de4f4577 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:39 +0000 (UTC)
Date: Fri, 3 May 2024 11:57:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 05/14] builtin/config: pull out function to handle config
 location
Message-ID: <3754812309ceb1dd0564e2cc7096b487acaf484e.1714730170.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w2T8/HlBUd4PPatO"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--w2T8/HlBUd4PPatO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There's quite a bunch of options to git-config(1) that allow the user to
specify which config location to use when reading or writing config
options. The logic to handle this is thus by necessity also quite
involved.

Pull it out into a separate function so that we can reuse it in
subsequent commits which introduce proper subcommands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 133 ++++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 65 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8991533e08..8c7cd30cb4 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -623,68 +623,8 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
=20
-static struct option builtin_config_options[] =3D {
-	OPT_GROUP(N_("Config file location")),
-	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
-	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
-	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
-	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")),
-	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
-	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
-	OPT_GROUP(N_("Action")),
-	OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"), =
ACTION_GET),
-	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patte=
rn>]"), ACTION_GET_ALL),
-	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [<value-pattern>]"), ACTION_GET_REGEXP),
-	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [<value-pattern>]"), ACTION_REPLACE_ALL),
-	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
-	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [<value-pat=
tern>]"), ACTION_UNSET),
-	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [<valu=
e-pattern>]"), ACTION_UNSET_ALL),
-	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
-	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
-	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [<default>]"), ACTION_GET_COLOR),
-	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
-	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
-	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
-	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT),
-	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT),
-	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR),
-	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH),
-	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE),
-	OPT_GROUP(N_("Other")),
-	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
-	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
-	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
-	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
-	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
-	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
-	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable co=
mment string (# will be prepended as needed)")),
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
-	OPT_END(),
-};
-
-static NORETURN void usage_builtin_config(void)
+static void handle_config_location(const char *prefix)
 {
-	usage_with_options(builtin_config_usage, builtin_config_options);
-}
-
-int cmd_config(int argc, const char **argv, const char *prefix)
-{
-	int nongit =3D !startup_info->have_repository;
-	char *value =3D NULL, *comment =3D NULL;
-	int flags =3D 0;
-	int ret =3D 0;
-	struct key_value_info default_kvi =3D KVI_INIT;
-
-	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
-
-	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
-			     builtin_config_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
-
 	if (use_global_config + use_system_config + use_local_config +
 	    use_worktree_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
@@ -692,14 +632,13 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
 		usage_builtin_config();
 	}
=20
-	if (nongit) {
+	if (!startup_info->have_repository) {
 		if (use_local_config)
 			die(_("--local can only be used inside a git repository"));
 		if (given_config_source.blob)
 			die(_("--blob can only be used inside a git repository"));
 		if (use_worktree_config)
 			die(_("--worktree can only be used inside a git repository"));
-
 	}
=20
 	if (given_config_source.file &&
@@ -753,10 +692,74 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
 		config_options.respect_includes =3D !given_config_source.file;
 	else
 		config_options.respect_includes =3D respect_includes_opt;
-	if (!nongit) {
+	if (startup_info->have_repository) {
 		config_options.commondir =3D get_git_common_dir();
 		config_options.git_dir =3D get_git_dir();
 	}
+}
+
+static struct option builtin_config_options[] =3D {
+	OPT_GROUP(N_("Config file location")),
+	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
+	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
+	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
+	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config=
 file")),
+	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use gi=
ven config file")),
+	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read =
config from given blob object")),
+	OPT_GROUP(N_("Action")),
+	OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"), =
ACTION_GET),
+	OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patte=
rn>]"), ACTION_GET_ALL),
+	OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [<value-pattern>]"), ACTION_GET_REGEXP),
+	OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the U=
RL: section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [<value-pattern>]"), ACTION_REPLACE_ALL),
+	OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
+	OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [<value-pat=
tern>]"), ACTION_UNSET),
+	OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [<valu=
e-pattern>]"), ACTION_UNSET_ALL),
+	OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
+	OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
+	OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
+	OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slot=
 [<default>]"), ACTION_GET_COLOR),
+	OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: slo=
t [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
+	OPT_GROUP(N_("Type")),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type=
"), option_parse_type),
+	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\"")=
, TYPE_BOOL),
+	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_I=
NT),
+	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"=
), TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-str", &type, N_("value is --bool or string=
"), TYPE_BOOL_OR_STR),
+	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directo=
ry name)"), TYPE_PATH),
+	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date")=
, TYPE_EXPIRY_DATE),
+	OPT_GROUP(N_("Other")),
+	OPT_BOOL('z', "null", &end_nul, N_("terminate values with NUL byte")),
+	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
+	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
+	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
+	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
+	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable co=
mment string (# will be prepended as needed)")),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
+	OPT_END(),
+};
+
+static NORETURN void usage_builtin_config(void)
+{
+	usage_with_options(builtin_config_usage, builtin_config_options);
+}
+
+int cmd_config(int argc, const char **argv, const char *prefix)
+{
+	char *value =3D NULL, *comment =3D NULL;
+	int flags =3D 0;
+	int ret =3D 0;
+	struct key_value_info default_kvi =3D KVI_INIT;
+
+	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
+
+	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
+			     builtin_config_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+
+	handle_config_location(prefix);
=20
 	if (end_nul) {
 		term =3D '\0';
@@ -858,7 +861,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 		char *config_file;
=20
 		check_argc(argc, 0, 0);
-		if (!given_config_source.file && nongit)
+		if (!given_config_source.file && !startup_info->have_repository)
 			die(_("not in a git directory"));
 		if (given_config_source.use_stdin)
 			die(_("editing stdin is not supported"));
--=20
2.45.0


--w2T8/HlBUd4PPatO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tPAACgkQVbJhu7ck
PpQhgg/9E053IfQNllvw8s9VcMYDAUBVO+VC6USltpMlFq3pHvnoLcdK91Pj1GrE
vcZsZx9nSt9M6Qk8aH2UD14Kc4B82ihfbMlazyth9ZU901YEktW7q0R0ApiQkrPO
lTXP4w5fEHJHC6HqvKQUqCXOVDd8kpaJvwJxOWrkel1iXifJn82GTsLo3pAAl5xq
HP/6Qoyx/A/5fgZ78skdaHGgIh49dKBOHtBZY9Wgs9NeqhMW/PPUgQA8h0P1WKGM
Twv4pEpEiihY74tkSu5Jjc9QfcNssc5zTqaiF55mNCCTra5zvAzSeMo7WtjEQl1T
ljd+cK81DuGTSyY1UE9tdG51NMJvVFaTK9vT5IiW8LZyMVsyjYtrJ5PYlwaBsRmV
akEgG2SEkgSbOFIBZLNKm4STcNEIL0ild2tPC2Lv7/xqofDcsn4J0w6gTX4FnmRC
NvacYk42Y5bnQSZABzQZT166J5dtb+rV7FcffTmTB/sJFv7HWjSxTCxODOAnj/2x
BzYS01nORpVHv1o3rqCctuFLHA025e1MCHFSd7vKsx0tJDyaOAi5P2KS6ATTOblY
BdFf/1Pxmy1HRmZrPzskcdjUg9LhSWbOKnrubEsoz1CEQECvToFm86Q16UiSfACJ
lYTUA5T6AuoTmip/zM4W/kXFWXqLpnx0bnsXe/muOUzgsW0OyT0=
=Vb3W
-----END PGP SIGNATURE-----

--w2T8/HlBUd4PPatO--
