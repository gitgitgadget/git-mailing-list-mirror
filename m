Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA461422D0
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985768; cv=none; b=qd4c32wDURYgy9+KWHe45I0irzyvCT2INFFrcOeEuiUBvgFNSCcbpVs3KgYJUJcxqhnOKuk+V4GTS1qRaomWa/Z5uQC8BisDyY6vg4I1Ku1jSyokBc/7YEeYKgWQGKLBR3YA3kjh7Pb0XBVfkQYSSCH65qzaTmn0YWPDOmU267Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985768; c=relaxed/simple;
	bh=6etdAgSWj4meRdjK+uVxCbS5oItwKye7W7wmWYmb8Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMW2Cgtdsn2Nyp8wswdV+oDCTsDXWBrtXYpJ/5LmDoA3LMn1tb58XX/lKFla7oQvTCOR61g3uYKA00vhu66J+xkZh01nP+Wsr/LeFeDo/uc1fqcHgFN9oOtW+2bGhupMPn34klya2Hdy8Mo8CCcSwoC3gYQesF8+tG2Hjp2CX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kItNCuFF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vb1VM/oE; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kItNCuFF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vb1VM/oE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id AD2EB18000CA;
	Mon,  6 May 2024 04:56:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 06 May 2024 04:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985765; x=1715072165; bh=Pqpduzf8+t
	fwg9m/QAtvDiTyGtH7lLI/oHaS37Sw7k8=; b=kItNCuFFDLd4NIukLZD0Zv45t8
	7V07UYZdWVobDSX4mu8ErLclZ09kD455+913leP7CICYZ/6S2MIZkn0+dkBDBMD+
	fMuR5b8uJOem8liqsQWRe2+xsqsq0kMFX9mA580WNDT8k+alTbYiXWNekF8XJpDw
	z9jl1DXHmqIahC7eq72jfxqC4hA3i4hcBigl9P7s/S2g0Khr0VSBFd3NGxRWKME5
	Y/CQIH0P5fr88NZHW8BLz3TE3jcRwm7elYkC/UK1rzzzLCDxaz9uUgY0azshyogs
	sm/iqZiw/w27HA0UB/mAx1j9Joe3I4l9IX9w3b9Ndh3+hSHbfgbe2mr4pMVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985765; x=1715072165; bh=Pqpduzf8+tfwg9m/QAtvDiTyGtH7
	lLI/oHaS37Sw7k8=; b=Vb1VM/oEEZT2AAufHKXz2ga1emRqh979xjMyo1hkkkEj
	hn8GgeZ/cjYt1meossE8w46mzuVQvZUGbDK4LHXDE2zsF/bsjR0AQbzTp5otL1Sf
	vq+qxKCnajdKxNh4r627uKycF+GATY5Urqw9FZXk3lAbRj69lo2MBFex9la12Kru
	8w33VOjTDnGTNHwwH/vT0TiGyDAQlXq+IjIFAhDc9X44lq814YU42CO4Ek+6KiWo
	Wc1rbnKtMfgyoV/iIo/jrZIHQNq7kqa9maXaJoss5nz3WA+D2Su318i+f917+8sl
	3HptGfPWOuVJbUsADJo3vCP9YozPJocJXxuTVHEO4g==
X-ME-Sender: <xms:JZs4Zj3Ym2Gd0O62r5TAYYFP4Afuy9U72Da60ulVnsRID4sV-6-ifg>
    <xme:JZs4ZiH80xmDiZNrTVjtz4NsSO_MZyZ7k4feUVNrrRbR4gHzoOpi4Z9k1sEGve-jE
    b_fZCmPnE0SlHrn3w>
X-ME-Received: <xmr:JZs4Zj5YlHc6-ciq8st8HRzCGrVdF66q1ziMomwufVpcQKcMPi0g1EtgP3HKio65lOdrsqqZV0HGmxoySXDCGtPv6HXmfo_Y20B3UUWlhT-5X78a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JZs4Zo2yfJMszbhW6BSJfgdEanO4a-LvPt3k44qdEZX3_H4c1qnjAw>
    <xmx:JZs4ZmF4wvBbsWG-_2uaDs82-j7Zs4DzyEl43SJ3IwgdyhVo9bV5EQ>
    <xmx:JZs4Zp8DR9PjHewzXsG7WI-0xtiR9Zq6YXfxoEkueq0fUC3WVs6WLQ>
    <xmx:JZs4Zjn2rm0Vir5ZZO3wrGWCqm-wRBeDRX3iOicAyZy087DZMcsEqw>
    <xmx:JZs4ZkbMIfli2MeNqxeZftWWVna_oKW6OdJJGlIFLhfX_7MJsRPeWxuy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:56:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be89370b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:55:57 +0000 (UTC)
Date: Mon, 6 May 2024 10:56:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 02/14] builtin/config: move option array around
Message-ID: <66dffaa8f2e4c717ca08123bad70093b25360a2a.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YC52ghlzI0DHGsfM"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--YC52ghlzI0DHGsfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move around the option array. This will help us with a follow-up commit
that introduces subcommands to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 96 ++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 40456c0770..59ae5996eb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -135,54 +135,6 @@ static int option_parse_type(const struct option *opt,=
 const char *arg,
 	return 0;
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
-	OPT_BIT(0, "get", &actions, N_("get value: name [value-pattern]"), ACTION=
_GET),
-	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-pattern]")=
, ACTION_GET_ALL),
-	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex =
[value-pattern]"), ACTION_GET_REGEXP),
-	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: =
section[.var] URL"), ACTION_GET_URLMATCH),
-	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: n=
ame value [value-pattern]"), ACTION_REPLACE_ALL),
-	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_=
ADD),
-	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-pattern]=
"), ACTION_UNSET),
-	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-pat=
tern]"), ACTION_UNSET_ALL),
-	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-n=
ame"), ACTION_RENAME_SECTION),
-	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTI=
ON_REMOVE_SECTION),
-	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
-	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
-	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
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
-	OPT_END(),
-};
-
-static NORETURN void usage_builtin_config(void)
-{
-	usage_with_options(builtin_config_usage, builtin_config_options);
-}
-
 static void check_argc(int argc, int min, int max)
 {
 	if (argc >=3D min && argc <=3D max)
@@ -671,6 +623,54 @@ static char *default_user_config(void)
 	return strbuf_detach(&buf, NULL);
 }
=20
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
+	OPT_BIT(0, "get", &actions, N_("get value: name [value-pattern]"), ACTION=
_GET),
+	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-pattern]")=
, ACTION_GET_ALL),
+	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex =
[value-pattern]"), ACTION_GET_REGEXP),
+	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: =
section[.var] URL"), ACTION_GET_URLMATCH),
+	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: n=
ame value [value-pattern]"), ACTION_REPLACE_ALL),
+	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_=
ADD),
+	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-pattern]=
"), ACTION_UNSET),
+	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-pat=
tern]"), ACTION_UNSET_ALL),
+	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-n=
ame"), ACTION_RENAME_SECTION),
+	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTI=
ON_REMOVE_SECTION),
+	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when com=
paring values to 'value-pattern'")),
+	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
+	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [de=
fault]"), ACTION_GET_COLOR),
+	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [s=
tdout-is-tty]"), ACTION_GET_COLORBOOL),
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
+	OPT_END(),
+};
+
+static NORETURN void usage_builtin_config(void)
+{
+	usage_with_options(builtin_config_usage, builtin_config_options);
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit =3D !startup_info->have_repository;
--=20
2.45.0


--YC52ghlzI0DHGsfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4myAACgkQVbJhu7ck
PpSdjQ//bgQrox3qT5UZ+iVXqAGc8gF0kqTjUIYpc70zJqZuXLNhKXSl674LBuVZ
QUp9+M/X4Bq3ozva6GrjukLkEM+WmM1ja1hp7YBqboebwGQFRvXj7eEnZVKD3RH2
pLLVCPXkYbZm4zPSfx+MGEO9cJ+1isySWL7BfjFp76y4QcVs28I/ZitTDl6uyJk8
bAS5kIxrCZ0/gPyWaDNRqEFt/aTJd6owUQtu9IL5lgAUenHqmc5/Kjt9N8dqDyd3
vIgzi0YUSc2OwzZU4OvRyMHCQK4k5kw/XwpBPdmI/Aoy7g1nVnitY5eMIoZFPdvv
6dRAmil6oIX/SfNWDyAfCsPtIDnW/M2vG0doxr1ohH0H1R/aP30nXVOs3v0edskH
DLsuPF0LB4dQa/85mAUbnYxR7AlxlusPbDpDG/WfGrTdnvBZ28jvoqUd7fjLCbT/
C8mjPfgueIOlgnod9qxZJiuHv6j4Sx9oMIQLAx0NXaFSLN5GrNTSrorXLEY7Hkk8
OydUDFxvfka2/W+QvNhF72MAOoRmSNCnXNoqODO3SX1vEVJTTtWSEkRtw17n1Wpq
oBjNgP5EpHhxN/y9DTrJ6N7yr0AQ7eItrM3ZTDWa96rYTzQd0TjhkHIUJgwWTOkI
d3yvWJ+SXThmEvF+UuR74GgAnyCNaHNvMSSKxlN5SPtG9vgkFQI=
=Yr4z
-----END PGP SIGNATURE-----

--YC52ghlzI0DHGsfM--
