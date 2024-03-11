Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6F58AA9
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199225; cv=none; b=AZtW82UllLCF03VvqYvA49thS6v5S0dSim8n16sUUiEc2t0gk7DTLqFpY1IxZ1YzopveWA3Jh3/vNO5pXYAGAANka+SO5RG203hG58AJwObLJq88/Rgoo3wNIGuQD8WzDkO/vhiK8LFKWB15COk8WYcgJ12i5DuwVgAW27uFm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199225; c=relaxed/simple;
	bh=yNkRwx+DUry6xU7BgBiOxI1ugkmt9+t9Jsdq7iBn4tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSord/SuP4uMLguU+ienO81W09MeJDSS22i/ylZD7Iz1atL+SLvmx9GBwgD+PDeDxEi9mKP1C8AH4mlLdddj6gz3FMfEzmqHETLzfoPf3v7bk6dPbHZ5JvsAjrLo0rsvIP8MqmqTTgE+BlpDaybaeIoC5WjG9RHTxl0peMicKh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a5fHpqlQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyKuKUOv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a5fHpqlQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyKuKUOv"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1232C114011D;
	Mon, 11 Mar 2024 19:20:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Mar 2024 19:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199222; x=1710285622; bh=gx35FmcYKu
	ISXHVeqrqRQehiBHLDQe4PseZaN+iLElo=; b=a5fHpqlQng0efPX4ML1Iend3kL
	ewRSmaaXAt4ONh6q681/PhLcMetRry0fVlYbdFcXtW0oQIL/s7AE4f/6Vfd0AKFt
	tb6Y/1DX6cWLnfU1kFnieu+IckUFPuGlnP3hXN8EYE7I+bzGZeOerKGxoJ3yWhJ0
	2ndwtdeGxz/DcO2bOsa2MUZTN0EsKNtKfXn+/ba05O/tS0rTyHXQ7xej4OCHk9f+
	E1QrSBRGkewc0Dbofgs5Vc/TgFfO3X76iuAInErv2YqlGrxLrO4dIFWE3NtxeZeK
	r7sQih4HzSYQFKZYffGjr/AnsCBMGtV0uPr26Xc9/n6oHtyCrQqVllGZxfzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199222; x=1710285622; bh=gx35FmcYKuISXHVeqrqRQehiBHLD
	Qe4PseZaN+iLElo=; b=HyKuKUOv2Mslez6U3G2lV9xq5OonBJM5/13bFQHgaLqQ
	mqdtHmGGxRJKkMa999XzIGAe5Q5gkrt2pNytnmxYrNUsr4OjB6aay8kjv0Esk8+4
	sR0ejxUBE4ucpiNEeqD/RTYS826rEpu+NwVzNPq/pGmidsro7n+TLAVK1M4ZoGkZ
	hgYun8eJ0YXJktc15hLueunY7NI6Z7hf68JfuIzbo2tbS7nag4RlNbiuijqWX+ZA
	k23Ek0rSlAOWLPYOu4v+lyOpWcbWB/cg2AuvW7kjbHboQuH2iQ+sNALLMLvpH+Fi
	56ROZ5UpV/s1z8JfJXyFOKOZTiCAcpn9tVRg8k1TWg==
X-ME-Sender: <xms:tZHvZbasGeP_zpBAijxncZcA0DBn2BA8c12hIJeVIE53SeGOxHvY8A>
    <xme:tZHvZaYp2Ba0cSCvyUZDUfA6JIS0OK-JsNnpGg3nqCeHCGGz0dBcKCfaprOWY6bZY
    FyGceCbdmKj7yHa9g>
X-ME-Received: <xmr:tZHvZd833T9qXuwoGroTEOgjlEMol6SsQ-XYk3PPwST0_RL_Dg5DEsU5SPQdzmzH3b-kGpKH4G98Sv_e3J04rYjxgPhL_TztqI3tr45Kix3JeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:tZHvZRqQ2hlEqtULTqqZc4jlTkgwqd2ZMWq16D4-znHU5LSzmiCh0A>
    <xmx:tZHvZWp7wv8ZTdSr2Vz5g3QioBrJAZW1kxE9Bys8ukKcDKIAr6lNrA>
    <xmx:tZHvZXRkTtOjQ0kgJDHnzFDqjR-D28zBzMEFxyKBTXarh1um2dzo9g>
    <xmx:tpHvZXerwwqY6tKSJSiGa9BfymqcdS4nZ5_cRe6uBxfIJuJeGMeTEg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:20:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ace52408 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:15:42 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:20:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/13] builtin/config: pull out function to handle config
 location
Message-ID: <80093f39082e8429381ccf30967738b892a8ed28.1710198711.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="igmBbABnr/SLozSt"
Content-Disposition: inline
In-Reply-To: <cover.1710198711.git.ps@pks.im>


--igmBbABnr/SLozSt
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
 builtin/config.c | 131 ++++++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 64 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index a293161be4..693df32526 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -622,67 +622,8 @@ static char *default_user_config(void)
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
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
-	OPT_END(),
-};
-
-static NORETURN void usage_builtin_config(void)
-{
-	usage_with_options(builtin_config_usage, builtin_config_options);
-}
-
-int cmd_config(int argc, const char **argv, const char *prefix)
+static void handle_config_location(const char *prefix)
 {
-	int nongit =3D !startup_info->have_repository;
-	char *value =3D NULL;
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
@@ -690,14 +631,13 @@ int cmd_config(int argc, const char **argv, const cha=
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
@@ -751,10 +691,73 @@ int cmd_config(int argc, const char **argv, const cha=
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
+	char *value =3D NULL;
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
@@ -848,7 +851,7 @@ int cmd_config(int argc, const char **argv, const char =
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
2.44.0


--igmBbABnr/SLozSt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvka0ACgkQVbJhu7ck
PpQOhA/9FNzKKK43yR0EnEwAfmMgvIp+f5x0OWR4sxpP6sauCCZMucbC+olxBRv9
qPe33tTQyQguw2JjVD3d6+gfGAyKfQayq3rc7vpWywudIW+OWfl45HGe4LEUUlz2
VnNNB8lERe6FB2mSMXCTmiUu1b1BeZrvfpCGcJi/l4lBXNSAv191jJhgRUuDGovo
+6aHKUBmmv75cwArTjs2HtA/XpFsmYg8TuS3EcZvl0Up1+q79ILgiFUMYoth5UO8
fI022UPEW/BiBRhXN2qtc3OQ/rItmTFgXXuDjzRyfaFIMRtwSboaLPM8QSxTL+ms
LV14tKebY2BoErBldP3XDtdJg3G69A5cE7DXEj1M9KUCNGfdaM5c7bxIczMwXtJ3
b+XLRHtVdgBKkoQ4Ujmkuhe3RQ+UpkFRlA5nJu8M529rfx6eULVycdrR6xsqc39n
srrvDwSgEIWsiv2KA3xKv+mXDn9WUxgz+b/GhfPs8TbyIHt2NYk+yXdQbr+Pw41H
nDzqE2TZJRVpqbMhpazGzVqM6p1IWU/QHIj5DT3uKHqZA/7Z5fAFKnJUbEyk/LSd
RAcH3wRuyzEV27MM2T3XHJI960sd3VqijZf+P3ulJ2lehD39VyxeAfjtGco0u2eR
XBhb2ezPfXnEKN5/mChNEz7F7FTxeHOllj+T267uUKdwVzt6aos=
=P8NW
-----END PGP SIGNATURE-----

--igmBbABnr/SLozSt--
