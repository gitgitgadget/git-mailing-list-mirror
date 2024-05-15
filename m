Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453C3FB1B
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755321; cv=none; b=fURu6rQ0QdKNZ+210I+B6Qle/cjMSG1WsdnFH83kTvF9tczXVfaL4Sg9eTdoloE1ZR2vboh3KazuAlxUg4ZNmOyutr9ZlKzwjeGwfV6QUdCjoenrtJARGS4HmTl9jA0VdwjoDRt/wUCV/hc6qhCT2+Ic7eVJyK1mZgBcbSymOZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755321; c=relaxed/simple;
	bh=jZww6FId8GQ465XEtTU+7VsAquOCDjfv63exdB5Kzm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVqsgg7+37cxR+tC/hy7yEODCIThJjAeV0BGIqGpH14O93cNszw0bbXDwVmMQpGQc/h8hC/pAiaDkMC1WN6gLMsoCASDUYiK89I66hDT/MZfj6SV9/nVuuAgVtvMJ+w6JDC3ohMnMGjRFqshj8kd3bBBPFlEKZ+R+y1S+JtYIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=klevbPJ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SxoAXMeB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="klevbPJ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SxoAXMeB"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3A33911400AC;
	Wed, 15 May 2024 02:41:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 May 2024 02:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755316; x=1715841716; bh=mXMhkp7/cW
	CX+Uty4nYse7Aha7E68Sy9RYPAAAnwBIE=; b=klevbPJ0ZxUPavKyeq421AHUyp
	u0LymzeqOwwRAAKOrjhfSCOEukJRdWGJvgD0SKMkGkU6e9XD64cv+1jOVZUJyZL9
	ELbreC6godA0GNk+n1eVX3kWkrHWIwYz9lz/+H7Gml8AmUjiFedamqfR8Z1E8izU
	4JYFEy+niI7r3HJsKqTlV/vTcRlsuIXQmcBp5xDrhcATjOedACQzTocotEG8vH4D
	B7EEYXxQsz3JL9/Zm+bYJ7JxPSec5XqfgL/JpU663K+HwEYWa342rjz3XP3bS8SG
	luVrJDY4CJ5nyUYXCFO4lp8M2UzATG7C80iTvr3sewuUi7QfC3HBg+J1s6Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755316; x=1715841716; bh=mXMhkp7/cWCX+Uty4nYse7Aha7E6
	8Sy9RYPAAAnwBIE=; b=SxoAXMeB44rYv/Rs0npIdFTRWkUECNQYNmCJRllhVFER
	FmMmP80wEVI/HysjUX3vnlw+KEX3exlCe5uJDTIgNL+NSoVpfmq+0PsNR0Xe1t+7
	SOMJb7antHnY6Yi7T6U1hNMwYh3a4GmeKkXak61XNo9QtyINKlRFcYmGuJs1sYcK
	6edigL7KVyZUNUfeBfSMTpc3VipaJ7Yo2oasxR7AUw+zEzSQAn5luelSNyQKSG3U
	GnI+OVL5ZqIxnJHebdA9vKw0Lfp1+M7Aust3IZVN3nh9kdBkhdgVvQwb+CHgklKb
	otl9F179cuM5tkLw90IVCepu/fQ6y4uyy7tGu0IQQw==
X-ME-Sender: <xms:NFlEZltVHvGbVY4CsYd6--O1fXr9tIMRWvufIrTyEPLFzg7htv704w>
    <xme:NFlEZuc1dMx-UG7C8l5-tFjCWuV_Tr6QQ1W9W7j1KQzgAUwApcROjMcqllh-k1xTU
    OiDbPTSbclsAIlqsQ>
X-ME-Received: <xmr:NFlEZozVPHDmtV1ES5LxifEVX13i8_vrqS6A7qUKfduy9SpI2YxReNpo4MDK7wIQfVI6zYXcDANYJXMoFGhGrN5cslwSUZMSXvJHE6qAOFXve9_T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:NFlEZsMgtvuyQI7WHTHmbc8W4ziTevfE4Lt8Uv9HZizQ9XMvBYdRFg>
    <xmx:NFlEZl_pAliv0DyxCrzp7phW9ZE2beUhhVttcui9Ce3z4eJjFuD_iQ>
    <xmx:NFlEZsVTYx30gXZM1MuXi4z4cUT08lFc-PE-MGJZb6ShCntVvOkVUg>
    <xmx:NFlEZmc6x0Lq1p9vjkCtAMlTb28MGXKwSXTUYYsTicsVJTgL0ya_eg>
    <xmx:NFlEZhYPyRflBfbAwhw8JLGdh1OH7US0ekt0JamkugVvCsY8kWvZ4nYJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:41:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7fcb97fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:32 +0000 (UTC)
Date: Wed, 15 May 2024 08:41:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/21] builtin/config: move legacy options into
 `cmd_config()`
Message-ID: <1a0c6a83844bf455e57db3435793ef6ccbe6a7b0.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DauKO4o2+Kz0GQxp"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--DauKO4o2+Kz0GQxp
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


--DauKO4o2+Kz0GQxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWS8ACgkQVbJhu7ck
PpRFvhAApRjzg7t6lcvdD1/7yn2nTnha4KguKavk2Hki41jiOML3HLbWiuKDVRr5
4J6pVKcIL8FN7I6BWG8j8uXRPuq19w+QLorfvVUPL0OnU6JSCjv5yjqo11j4ZPoF
+50ZxKDjEbkrALfsyJUE9nffsd/BAGCsr1tZJ3dDdCBX6TisuvfbtEP2lFaJ604y
tEzVP3qMaopoMnd0T2Xe5R54lnnsT95ISSeEkvhtd9npqoOX7+4Idgk0jFqEw83D
Qwf52W+JE+nfGEuBOXLzwUtbMDWWkDJkPd+1kirXlQLlQ32w9rH/sSgzCpBh0qQo
8mJE4R+iWWhihLC21/xHR3Mo2xHsCPHoJb8TuEFKwJQCnorat26iPWC3NuMBY9CQ
w20e2XOomjl9l7n7D/RGUFtn/Nwg5LwZrNFn+uH9vzNLPk1lnkATv11j9lEAzzNy
FOnsx8Q7VQWySMllHvgKLikqYfsL8DN+12z4DhGd4rrxN6zYhFJ0GdU8GIW7uOZl
VJeh9hhYX7DlejF/cntxHSxrUKejvzzKOZFeHgYIZCLV+3uBrMf4RiwsmDysRBgj
YxukVZlqX07OdnKk+UDgFrs5vjmPaP8y06Xe4+IPLqffBc86kmuj9+2bB/QVCs2M
IN0Lq816zjD3TNi911daDcOEXxN6DL8+Yua9f++TgXVWdgLPUcU=
=9qNB
-----END PGP SIGNATURE-----

--DauKO4o2+Kz0GQxp--
