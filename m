Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709FF17089C
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340289; cv=none; b=ARr0t8ydnW7hHxiFWVZt7ga8V+mLqC+rtx+FDAt3Oz7XeDVyskBCpIKt58LIOht2wiyDLcqE2Wm0wLr/BH6LNXKmhF9q81rNR60M2mLJg/nQ1k2nB1lGexSVVM788iQ5FVhjMQGxIaRpm2VkLoxQ2wN0ttPdFb6Rl9BrkxYnClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340289; c=relaxed/simple;
	bh=P1hxI3gOCpZdJeE4dSFzrTnwvj2DQjiQLOzSzookjBU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdmf2kofPOW77WP0Lrre4Lmx4WuPLsgWxglD4kII6oyBnszfhYmPp0ABoMEuQ0tNykthMtJ4N0JUYElUiIfQg02CErhJ4/AVApUSPb46xlI2Khozk47onO+hE0rUQshmbRM9Lq9U81BixabYKCZrzphWDvTSMZynU9X8dc1TLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ggbSjmay; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JJ2Zc/JK; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ggbSjmay";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJ2Zc/JK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 79E8A1C000D9
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:24:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 07:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340286; x=1715426686; bh=bLsm3EJq9b
	J3LMannPadMNlENLUo56cdYQsdTJoB3Ag=; b=ggbSjmayvW2VEsxpe+UknktV31
	Z5dxfwPrrmmVE0dKNEzNyxWGxFP8R1i3qSHRM4SJIcQbTRN8PX/KeCnl68VjEVpK
	jcHZrm0rC5Wcn/8XSnV2T2WiP0V5KQ/MJ3FW6D2V8EzQb+Y3crP26LC1iK4jju0Y
	sgeK0R37uER2Z0NIrOBV3mTYLcrAmPLO9kno6Sm9xQEvERCKJ/QvDCK07x7sBNRo
	Kv1ys/Sqre51Aphn7/9BLCqJ2xw7kMXg0QDcqcdvc0NB/860rRq+TnNfW6FgBl2C
	pmgFbIri6CY1IDJ3J0PwjvaPxZ9LEecxUHyVGyO8pMAaUSCn0aIDXtxgzTww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340286; x=1715426686; bh=bLsm3EJq9bJ3LMannPadMNlENLUo
	56cdYQsdTJoB3Ag=; b=JJ2Zc/JKqqFbXcHuuVVBsB4lM/qVlPgl4+Ih3O+stBlB
	pPIJMjSFbQhw2o4zksyr9Bi8150Td2QIMGLuOUzI+QCY5vlp+iY+BwzAJlfifMr3
	QzeN3YDEix66sVxjPoSPzn3NvKAuv5yCXYkJnNfOgjeLrNj7ZIu0s11PQU96jyss
	MhFfyLa0BE4hhNIfwIAKxRqJPApZYvsC2GfRSq2N+sVF/SougVsJwUzL400pKDfK
	lVIAKAKp04NH7GKFd8IVNEzIkGzfOZJBF7fKGYGyjcSqClJ2xLVFrqfQXnzspTkl
	9dmLbMAwrmd6midA+BvT4vCEhm/fBytrQq874lnaSA==
X-ME-Sender: <xms:_QM-ZhqUqK5JCAlPb5Mu5MYbnRcDAZLldW_5U989osQ5KHdrlTHd9w>
    <xme:_QM-ZjqHxC4UFzMC034PZZIRanPbzoGGwlaM0aLajS5wEcx0GJBhRyLY4nx-9F7AT
    PvQCdiKIvgEEIQHOA>
X-ME-Received: <xmr:_QM-ZuMHBGgkAxFSMhX2V4Tb_NuCzd-vYpoVQCZ-ja-VtjcQqcpgcKR54c7G2s1osp55i_1CLMG5OfZYrZWZIUcVQ_zma7oXDglPhtFGx2eHNgrKFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_QM-Zs659EyTQAWIDcV-KwccQQl4-TqWJE6Mw5kbDbyIN1v33xUY_A>
    <xmx:_QM-Zg71Tc2jU0s5lhNM0q9JdBLHV1cdfAODnMr10nO30bs67Mr9NQ>
    <xmx:_QM-ZkiHKgKapsuv1lspdZeZn0bf2OFLRF9RtY2JoWmRuST2uy5gJg>
    <xmx:_QM-Zi7bo7p94rQF1BVQKPJaK5IrKzJOtZ-9G3auAH_cKm31Khf87w>
    <xmx:_gM-ZuTwD9N-AhvHAXxnKVFQN7sTX-_yd2SQ7lbsuTl2AiPL13rOx9NF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:24:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f817d873 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:32 +0000 (UTC)
Date: Fri, 10 May 2024 13:24:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/21] builtin/config: move legacy options into `cmd_config()`
Message-ID: <82964510c557a398e2713744ec75bba3ba5edb25.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O0iedDOmhXXizgfr"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--O0iedDOmhXXizgfr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the legacy options as well some of the variables it references into
`cmd_config_action()`. This reduces our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 60 ++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 58c8b0abda..e9956574fe 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -78,7 +78,7 @@ static char term =3D '\n';
 static int use_global_config, use_system_config, use_local_config;
 static int use_worktree_config;
 static struct git_config_source given_config_source;
-static int actions, type;
+static int type;
 static char *default_value;
 static int end_nul;
 static int respect_includes_opt =3D -1;
@@ -86,7 +86,6 @@ static struct config_options config_options;
 static int show_origin;
 static int show_scope;
 static int fixed_value;
-static const char *comment_arg;
=20
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -772,33 +771,6 @@ static void handle_nul(void) {
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")), \
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)"))
=20
-static struct option builtin_config_options[] =3D {
-	CONFIG_LOCATION_OPTIONS,
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
-	CONFIG_TYPE_OPTIONS,
-	CONFIG_DISPLAY_OPTIONS,
-	OPT_GROUP(N_("Other")),
-	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
-	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable co=
mment string (# will be prepended as needed)")),
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
-	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direct=
ives on lookup")),
-	OPT_END(),
-};
-
 static int cmd_config_list(int argc, const char **argv, const char *prefix)
 {
 	struct option opts[] =3D {
@@ -1059,12 +1031,40 @@ static int cmd_config_edit(int argc, const char **a=
rgv, const char *prefix)
=20
 static int cmd_config_actions(int argc, const char **argv, const char *pre=
fix)
 {
+	const char *comment_arg =3D NULL;
+	int actions =3D 0;
+	struct option opts[] =3D {
+		CONFIG_LOCATION_OPTIONS,
+		OPT_GROUP(N_("Action")),
+		OPT_CMDMODE(0, "get", &actions, N_("get value: name [<value-pattern>]"),=
 ACTION_GET),
+		OPT_CMDMODE(0, "get-all", &actions, N_("get all values: key [<value-patt=
ern>]"), ACTION_GET_ALL),
+		OPT_CMDMODE(0, "get-regexp", &actions, N_("get values for regexp: name-r=
egex [<value-pattern>]"), ACTION_GET_REGEXP),
+		OPT_CMDMODE(0, "get-urlmatch", &actions, N_("get value specific for the =
URL: section[.var] URL"), ACTION_GET_URLMATCH),
+		OPT_CMDMODE(0, "replace-all", &actions, N_("replace all matching variabl=
es: name value [<value-pattern>]"), ACTION_REPLACE_ALL),
+		OPT_CMDMODE(0, "add", &actions, N_("add a new variable: name value"), AC=
TION_ADD),
+		OPT_CMDMODE(0, "unset", &actions, N_("remove a variable: name [<value-pa=
ttern>]"), ACTION_UNSET),
+		OPT_CMDMODE(0, "unset-all", &actions, N_("remove all matches: name [<val=
ue-pattern>]"), ACTION_UNSET_ALL),
+		OPT_CMDMODE(0, "rename-section", &actions, N_("rename section: old-name =
new-name"), ACTION_RENAME_SECTION),
+		OPT_CMDMODE(0, "remove-section", &actions, N_("remove a section: name"),=
 ACTION_REMOVE_SECTION),
+		OPT_CMDMODE('l', "list", &actions, N_("list all"), ACTION_LIST),
+		OPT_CMDMODE('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
+		OPT_CMDMODE(0, "get-color", &actions, N_("find the color configured: slo=
t [<default>]"), ACTION_GET_COLOR),
+		OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: sl=
ot [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
+		CONFIG_TYPE_OPTIONS,
+		CONFIG_DISPLAY_OPTIONS,
+		OPT_GROUP(N_("Other")),
+		OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, us=
e default value when missing entry")),
+		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable c=
omment string (# will be prepended as needed)")),
+		OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when co=
mparing values to 'value-pattern'")),
+		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
+		OPT_END(),
+	};
 	char *value =3D NULL, *comment =3D NULL;
 	int flags =3D 0;
 	int ret =3D 0;
 	struct key_value_info default_kvi =3D KVI_INIT;
=20
-	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
+	argc =3D parse_options(argc, argv, prefix, opts,
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
=20
--=20
2.45.GIT


--O0iedDOmhXXizgfr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+A/kACgkQVbJhu7ck
PpQTKhAAnMN9YXRcaBhA9dvkEE02uickn71JdvShpTQNA6KRvM8ZNnySCwWMsXxU
S29GDoXJRL0AnUUE4kuu/Y5EpZ2g2+Zb7NI/9AQhX9CU+6fz7yEObC2cTMssdJkA
iJ7kUkKxTLtqn9V0DIasO73256mGOOfDc3vJ7DuU5hKNAbXD1Q1+9J2QqCLqPrkW
w14qlYqjL2FOb7IiDn276UqoU8sUWKb7iCwsQh0SDzRKKCS9A/qObP/nX4nBI/NA
+O7hcTKH+D5Ec/uDyqm+gWMWkikxdikEUbZcgkvqGfTNr2QLqhYHexP8XaqYsxYy
L8rD3yjG3OAGe5TgEgaYvwhfLsUNoK4BebK9NqLAZMaMFKanyfjdvqSBt3f+TSXp
3elSbuQV8b6b1zrKvfzMBAk9LPrsrkXs7rDI7XPykRjE2Mi8ba4s1cZGQGSh0dnQ
2LbzjI8YeWqTbfLSUgb7G8GRXLU28gRqg1zhqpQgEoc8wIx0HYgJix6VAdUPo+cp
qceCuCnQmv7yPnjRZuc7liDzvJghVGLa3fOPxCQCkLbXcA5hErvXZpRGNgbnWBxw
I1ORdN+w73Plw3Ah6GEzjOcI+o7RpT2kA4pVuoTuLQZ7jvxEGFPO+PP6MWupCgpf
XlGchzae+RVAwGOxlMabXsaxFHIDI0lPwHdOtAq2mUP7mL3GImQ=
=bJ3Q
-----END PGP SIGNATURE-----

--O0iedDOmhXXizgfr--
