Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEB31A67
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595744; cv=none; b=smZMN6ukc3+L5k5Cl9d8phMfgZNikMT3B/t6meNW15OAtYG5cmt2HyIH+wa99CoQ7bIHa4D6VqhmsmVjbkOcCUXZLzGeh+/vVqaBMi4zA5P+zcqTznD5f6FDbbiMs/Ty45sXSO+rc1xuPQs+dOZCTje/7YCm9z57JAzUBDeYbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595744; c=relaxed/simple;
	bh=gnAU20Jso+2U+GPcCmxMvM5LvjhM5edFgru5bPRkg78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxTyPzYBGJOCuF0mf656R9dSpa2RA+77OK1VsPuff0mBXme3/oik3y3RMzVASWHlVDpXd6CfypYah54JSQXXL+xgbCzIYt0MNqjAPMWO5OxWU/Pnb5Iop1vle/bxxyTd6GLBx21tp7l0UrDfqJd6JwRA3cErGo5uVYu3JcY26Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vNbKrl14; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ea8vqcLg; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vNbKrl14";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ea8vqcLg"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 229B31C00127;
	Mon, 13 May 2024 06:22:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595741; x=1715682141; bh=Wn/d7H0gBF
	2MOrPFiB1la/BsyGbeImQCk5d50ql9KRk=; b=vNbKrl146E0TYrhx31p5Q8fpUC
	HjWv3GNIFQizmCo7wamh9Vce5OO0HGemSDZTO/VkHnOsO76JvLWKCXjtkRyIrNjt
	5lwA9ZaM/d7G0yLCP3ZvTwnBM4IpptGY7IOPjz28MKGgqk89Rz4uW/L2HtLV4NfE
	w3pP/m3Zt752qIQTyAR38TmlE7FaU123P5vJQICmqmMIqlHjifJNBFTvhuPd85ta
	JoBcXoPbojMcGo73hB+ZQ+Ku2y8aaRry3xITikRv0ydxPa6JgQoaJH1yyMheARnv
	A1WOTWamjop15vX6agmGWg9aLSkH823e2IcdG23ZOeI6IL9IKqOppTS94nuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595741; x=1715682141; bh=Wn/d7H0gBF2MOrPFiB1la/BsyGbe
	ImQCk5d50ql9KRk=; b=Ea8vqcLgD4KG1RvjuD3oOX+2m2O02aITfjNeRM+TJvok
	DV4guZjHZ13Uq8x98RUq227uuvHFDfSpDl/V9eA836AMWF1HcswuzdtgnNlbhkZ7
	rZcEBDxSpcR/LwNJ6b8PSA+/R7izWrSXDQpKEC7f1XDjTuVI3LUu7Js6N2kjZaAh
	dcJAU5azaPdMZGLNHxmb/mXvjEyrjNJq53kadCNBHebPg6PrGILECOgxX+n6Bxy9
	b/VKIlNdw4hD28A/J/wv5eicq1mmZefK4UWZZiO3olq/r7S9sgXQNqJZIIHkg7As
	c7Vo0TAYmbgaiTJ9pj9ZN/RGAFKCRoe/EClR3PuJlQ==
X-ME-Sender: <xms:3elBZtZalWki86vxovUvu7h8neMuy5nIifpqEFFMniQoYj-KVHCQpA>
    <xme:3elBZkYNcr3-D-yl0Ei2-OyxOm015QYcJ2ZaXbYp_jizEduo7ylP76uavxToodBTQ
    ohjW0nKY8BS-b3NyA>
X-ME-Received: <xmr:3elBZv_iZAnNTbjXJQNHcb_Jgm1r8XbEKuNWgxep6cQOXi6MZ9EZi1xxpREYz-AlS3ZFFCrV9aIylXG7ZFyHRSxZex38-TGxa7IwC5PGYiVK-Ro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:3elBZros3U3G74Qw_jknCxuv9vt94cD2WfA_uyD4o0WoswURqr-7VQ>
    <xmx:3elBZorrFqEYYJxuERQdp-6zHOqBCSHzuEmh_anImOZ_d2bS3I0bCA>
    <xmx:3elBZhTifn6Qh8OzEZUyYoxwkuAdy7sL4d7AelDaVwHYuqHD_7KLdg>
    <xmx:3elBZgrMMRDo6ffiggjxHhyG1spOniNBE568XKEGa0kXlvPwIkRiQQ>
    <xmx:3elBZhkSiQxCiqUWY4bMJ5GeThZpWI6fadaXIp_cWB_i5ct23zZlIexG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c7108464 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:01 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/21] builtin/config: move legacy options into
 `cmd_config()`
Message-ID: <82964510c557a398e2713744ec75bba3ba5edb25.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QoQcY0ZrqXTa6CyH"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--QoQcY0ZrqXTa6CyH
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


--QoQcY0ZrqXTa6CyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6dkACgkQVbJhu7ck
PpSujhAArHASC/0ruiKg5b1SDwQ9QEXtkO4RKC+zGgaLib+tQln4j2SlcNlhqkGD
4NEWJ3nsCk35OdeI3BjGFduz7E0zqImLprZ5dghwHOX8EpHHq4TXvNo+GvUtutyd
mgeKkDTiGMLiZuhzS3KAAWNkR0ad9IizRHO/W8N7YR/Qt/3RfRAvyPRjqy5u4EJ1
Vn+3uurnYFRejG9nBns0NwN+COIwj6PyNUlbl9v0HZgYl985WgnlXRhez2cEYLmV
wLuLsazXPeYuQZD4ql2itYOihP7iU1hoOcgL17SaOZ8t+YZM02aKEdeZ6cgTwkvY
57FV2VrXwtSRY7CaH0RU7pw+guugrSLTHg89UaPXDS2uNJ3guCsHgAHoZoxITRW7
qZgXMxB8Kkjedx2+0wkoS7zfJ+CZRDQyvg80xljgaTiDzLtqylGUp2zT0W3P+O9Z
h53aJq31nyFFnDb0vk28MwQt9PiAzGdut9uorMZMHI0NoTgXFERuBRVx3F8/Xjf8
/9DdFEZBuZBkjROKxDxTr1o14u3Fc6c34JQK5eVI1fpeliV/DJ4rue412aX8dI+w
IacwUWQsYTD1y4Q1RdqxCO/R6g8OWA0MkfHkZEWTHio9c9E5dGV2PaAOpPAjXlwO
yJtlIU6N9Ga2dG/Qtd1YIRyXOUHMyfa6DbqSEK5fwpxI43EnIN0=
=Vow0
-----END PGP SIGNATURE-----

--QoQcY0ZrqXTa6CyH--
