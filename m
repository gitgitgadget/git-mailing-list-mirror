Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF71422BB
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985782; cv=none; b=M0EZjA0+GFeFMGfxwL86BCmWOvN/XEY3pNnF+pi7pH3WH6hnwbqEfHfoplWKy58Pb9EQNazlQ1zDcFf20LR7tuEhDrJXNuJOAks6WdgwBIB0d9DDxHM5cVeo6ibndxk28PnjFYQudOlBLM7+sNIUju5fgWyRJfH5B77FYPh8//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985782; c=relaxed/simple;
	bh=5lyJ6vVYyly7E8JLl4SWsIZUkBdmbHcJVcZsl8SWNso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBuTRHPIwU7ZUmjShMhlSIv/vaZUqH7TPLkiPL0BCfJ3zxFZOQBHjk/zXVXUCsbm2mI3nZ7gN6IPNdHhDzrG4m3O1rm/sboiCNs1W7cJop5GJbsDMG+MBg6ZqidkHjzIXbHbsd8zqDP4yn1qjt0bXYBuIOBUsCco1nnRGdnJGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=odJoklYE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YeBJulHa; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="odJoklYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YeBJulHa"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8CAC718000C6;
	Mon,  6 May 2024 04:56:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 06 May 2024 04:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985779; x=1715072179; bh=O397vy0AYg
	/sm2vKfOCqFN++sdhBoXRPus8fWC+6kwQ=; b=odJoklYE3e5a4G9C46W5fdVKck
	gKVZdysx3aKQRm/OK/VCmqu6oonn2L8V+hviIHwjW6eIzMqhIeUgCIaM7qRL2JR+
	4MXjc+3+Oy+eq95hsSp0XoKURqk5YiM3iHHj4VFzwcKKHedVwDiW/fA2wyQKvWLv
	Al7g6ab/KKOySpqOCOCcllu632bqz3fJH5xCjyfWs7L66Onpn6keq2DuuwaQXHR7
	iiDq0bYCUi3+BvvdLekdGr5NdmqE443JimMpebb5TnkrjIuALfgX3dR9Fn/zfMZ7
	eD/92y87p3D3U6e3gann5PhIt7Wo1QXfbWBUN5lr5h44MSQa3HyC4KH4yhhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985779; x=1715072179; bh=O397vy0AYg/sm2vKfOCqFN++sdhB
	oXRPus8fWC+6kwQ=; b=YeBJulHaHnm4tkeyWpG+/TRK62dtU8Qq0s2F+WB0DdNA
	k3NiLLdENiyNep6XWo4QkIzQcys5634W+EgXpnJBft6am+YG+8KQDV1RbrHd/uuc
	sLOGknnr6ZBUYimI1cK6WvHfxZrXi+BxJJLIDCwpk+9byXSItiZXgfzgrLZjPjqP
	5BAliJ1EXd5nF8QxWfNryCKMdUfYMjNUO11kNqHgvsaT0yTKfi1t2gz0Ag2GysWH
	qXbhvBahO9ypuOuVbFj3jQjZ4/sqXYeu2Ian5nd22mRcuYAJwHF3D61dmWT7UlOi
	BP1iYx/akmbKJ6++3k0uloYR/Mb8L/k4T92EQdXrbQ==
X-ME-Sender: <xms:M5s4ZqUIB91HwrOrsm7cQd3Naj-rZfuV484-cnCQtagKCrFkCsyV0A>
    <xme:M5s4ZmkI1cMA1OzAdNVUR1kHuxiaHJCgbp3fE_BJefVYykKujmnpU6HcMBuEK7dTn
    q2MLX4L30b5JCcbPg>
X-ME-Received: <xmr:M5s4ZuZCb40zzl1ECCs8eFSn040HAz_ay85G90CoRAsUBBi7TMwmzEqWUEfXqKhZIAJqIzV5YbaN-xBVlA-PXsKeLmfga9c55147TXXodOHHgzLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:M5s4ZhWMZZNzXWg66cwJ9p6e728SwWzqGSd4-iABZwE7eHCxZv_sUQ>
    <xmx:M5s4ZklHt5NNeUV24sotdhrIEV6Fz-48KYMh5NM9WQauxwQfLa_aJQ>
    <xmx:M5s4ZmeMRxUMh2DkpzrBaQE17I8FMci372Z3C2ISnvJDlSG987dGXQ>
    <xmx:M5s4ZmHjLIsQ3tmVeKgLKPRI5NzOq7HKoKfive_E87tEtKSpwgsINw>
    <xmx:M5s4Zu6wrI8qOJALCURoy_-CE1DD3amKZlG2wZi6uCSco9xMNe_Le4nb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0de3fabd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:56:11 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 05/14] builtin/config: pull out function to handle config
 location
Message-ID: <4f90f206e70ca86f26a96c2db7cffd0e97a8c39a.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VALW630kz2HIJE4d"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--VALW630kz2HIJE4d
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


--VALW630kz2HIJE4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4my0ACgkQVbJhu7ck
PpR0Zw//enH4meFQ3tpJ7h4nvGrv9y8eLGSY6QW32O3WxXW31D00r+6hksRYSH/e
z6j3Rm4qZQE6f67ecKXeK2wyZS7AGZQAVdc4bOz+b6952rYcwxPhKUiCEk9VGIZS
3TapsyFxg83N03v7CglJWj4u8VVD7K+QpJNTz7lKUMQ03a3gQ1yrwvuRaL9ry6Zv
5vwTvBcQwU2Bjo+zfwaO45DPwdbha6kTbn+aenV0lv4goXp6I18klAeEFb6PTEnX
3Y2uoqBk3BLxRosnI7JSnSb+MC07B481ZCRKFHWrffJbmQ1pLPlD4ZB/LEAnSXsn
Wl1ETGRtABj+xWpFpxXSpfsUkeQ2pV6S3rJ6Ea4MAiuA5BHiqI65UF3BNtah8F48
opDUDF7C3F0DnzXv4PNcf12JmQv805AOUH5DKgiKuS/74ok1R9cibG89amCFP+Qr
LAvSWM6b2KhpVKv3+62iEUB8CdPOvO8brINBnUWXqqyGqLP+D+WCH0JgcJUgW9UO
d1WeeApoWA7Z1kHR69iDkCWXZZHabe96x3xuc3/ioeXiMtZ3LyTrfPs/eYGlHhmu
qnibVmZXVk1cDbQbcFRWQYH5q1H07cqfz7qbg8wDmVS12GFDAYMti/nKQJvQAo9i
80bg2iA6z6A8x2UNrE4BvQgs+2UfsyAmNxThNrW0JFbiuYyq5Xw=
=hyxH
-----END PGP SIGNATURE-----

--VALW630kz2HIJE4d--
