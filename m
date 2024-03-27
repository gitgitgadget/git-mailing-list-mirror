Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1E1EEFD
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529180; cv=none; b=ICjyaaS7SQaYQ2U+OCVDrADekiYaGJlAIm12bxp8CNIbixkvUrD+ZFejNbQSzHn1+t7BbpxMEbnrWvF5PDL4ZWENxLn7ryn/HE6A9Ct3WyABRYGC3VVlt3nmmrwTr6e9n01pNVWAmqya7jBlbAaRib4cradwmfXdBvMu3as8fYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529180; c=relaxed/simple;
	bh=I5G3vy94qRTplxMvGyrt5OCUoTDI3ZLETSYfbGsZaJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miubbVZvEJHUtS8c2V8rJUxaOoUZfHElFyu9YoSEWfJoObLr7LBgd21ih0hUSMsH7/uUixFCXlYCS0BiI0ol7oL4TyqNKfsSPzdTBerPxYOz7mNs9RUTBcWwXzGd8Ai5ZqDhw0w9CDyYkDtE7UZPymcXpPK8vkV5zbv6azrSRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R9TBwe0I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FdyuQQwK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R9TBwe0I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FdyuQQwK"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3116A138015B;
	Wed, 27 Mar 2024 04:46:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Mar 2024 04:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711529177; x=1711615577; bh=Sjjwz46dNi
	ONI7G9MAMbHWoh51Pu1/RkOVdp9xTFylU=; b=R9TBwe0IuPcvsfZD6R1ZxBAytx
	pOAgc33XawSTOS2Z9TEVxWb8zacGL/jotPZG08i+4KdaIW01PHVKQjBYgabgiq0s
	T2aapUbZKkNRtK86S+SSUQC4fvFx5N8YsYQfxRkywz5rYmsNBGEWqH4esx0+Qm5L
	0FA8XcKmI5YAKyOgJ++qWOVpYOJROPGD+AFDhyGtvn8LdEByR1DW/c7Ld17Glmv8
	BS9npvRkOAqwOcxQDmrfV+pPlsMzhDVHWHiDRVjhoKK4Q83RWssglrtG2E+HA5Qu
	4eQtKnCIpuMuunqtvMU5jRRYrJFVewX/fN1kdnfEkDFPzVC3CVC36ys/3SCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711529177; x=1711615577; bh=Sjjwz46dNiONI7G9MAMbHWoh51Pu
	1/RkOVdp9xTFylU=; b=FdyuQQwKsBtaagkd2EKOYe4qrZgyhJ9q10mnauVASEYt
	vS0472Hgb/IaVdklJFYYmb1AmO/zEAfkKksMtSSF4yY2mhLtf4iSf3wL3ylxgrYd
	DXVfEPd9i2wUzz5aPtmmNrJAVamTwTBraSJJ7ePFhi6iI0BOe7GWzVjWxAQ442Hs
	mXMkXT2SMR3DXbBxlGd76jkpO3BbIMeiOtvg/2zVYN2LZ08J7+Pd+tdkQtWYpDW/
	Wlo+ymM5s2M+ZUAMOuGgvupXoeTEhfCLoLsyaz1eI0ZJSFJFisRDF5t/sAhNohfb
	tNp96Gf3HjccjYkNsSFLmt+ac8R1fPQzWiI0lXcJtA==
X-ME-Sender: <xms:2NwDZrBujkfmJro9xqiEFmQaMhBPGdXo-K-QvcUKyviOelYbkUEDPg>
    <xme:2NwDZhhdTWEVkSDEizKDAJ7jJWX6ANdpZ_J8KyiNvEuBk03rLJ5DXlZ_MtGvcrgAo
    IsfjMfzsHt7J39CYg>
X-ME-Received: <xmr:2NwDZmmLFIlQiL1ROP_0EJ8JH28XuqWBweOitPHQ85Wj6VQetPL_lYXysWBd6FuZ6npj43mN4giPKkxtalbrG4b88C6GBbAPq7Pxy7ecuMWJXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:2dwDZtwdr6pVKpLz-yF6mkw_0hf0kuDpbyY_qNFtFQfU6LIcK_4Q1g>
    <xmx:2dwDZgQjd4xisv8KR-InvKtu7dAhiy3qcMxYruOVOna1xWqUQGYvDA>
    <xmx:2dwDZgYdxhjf2ZrA8m1aFwXMrSwTU8Gu2G_fI8a-aEKPBaONI1fabA>
    <xmx:2dwDZhRRk_Lqr8zGuOL1-QMe0rokDt0mHLivPVpAWwI8jggIdh9y2w>
    <xmx:2dwDZlRdqHARA6ZbzGHuEO1MtNZQYW-aMq0RdqVn2k645GmIaUZBGQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:46:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 77862b8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:46:02 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:46:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/13] builtin/config: move option array around
Message-ID: <bfcb50e3934f3aec95d4dd55908e886c8671cfe4.1711527812.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1711527811.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1HG+/5od5W067ag4"
Content-Disposition: inline
In-Reply-To: <cover.1711527811.git.ps@pks.im>


--1HG+/5od5W067ag4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move around the option array. This will help us with a follow-up commit
that introduces subcommands to git-config(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 94 ++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index b55bfae7d6..6eb6aff917 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -134,53 +134,6 @@ static int option_parse_type(const struct option *opt,=
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
@@ -669,6 +622,53 @@ static char *default_user_config(void)
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
2.44.GIT


--1HG+/5od5W067ag4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD3NQACgkQVbJhu7ck
PpRithAAllkLFY0pdEPlQpUoxwc+kw8RlfRgHYH++4cwVFGgReXeFpvGvvuJcEkk
ZKuBX0AGCVaDnMEkvi2WclJlapt0dVDLF0x0mUnpZPHsQsGNqCnpIm5JbPpCQQhf
LvdsTtOy4m404Q1EBajzzbLCcR2hsVcSUPM6+l07gdF1FGbr3JHJbbxyAWLZ9lrz
9wLN9Vbm4aWeQLc8tFqm8M6HpGlQuqx7X2QktnEkXntkBulYcGTEdSt1Q75LHe5j
SWggoImr3WjeEVdgwpStj9eBG17KmvNcRm1ujxoKWv0yKAioToGegQSSYCDqZHwu
ZDZ9qfOW17E8CvwXhEt6w9600A6Vt4v8Q2lGysKBwrOYyP1j1a7CKWtZjefBYbaz
CKiN3KCEKVfw8JU/9G4lOCQUNBP50dM8zAQ+GwQn3HWZEUaC3WQRf5L5wb61qk68
WChY+/A6wpK+jienEEo7FxPOYHRQF8QqLjnI54f5y/Vt1YJDJxVGoiyZOsZGLqPN
miEJcnk4L0fD+p7lm6doPMceLKuDvAxrQn3gh8hEmIb+y/qFjqjTTPRCiJUrds6C
6nDqOAqXzrwtIz8ZqgcHGK3ITpZY14CRego51/Oy0xF//8XPw/VLknnsYEQCF+WN
o7ciKCrU6+B1DK0cU/TK8Xnh/LimK+WZBwvcp/Z9EaZnqQhg+E4=
=IUvC
-----END PGP SIGNATURE-----

--1HG+/5od5W067ag4--
