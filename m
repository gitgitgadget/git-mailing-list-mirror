Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2D78682
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724700; cv=none; b=KvFdePHFxtnvYfhUOXeYHwsQo9/544UhQ0IUpUckxysq6WRtonLqrUle08Bp7eaztNy4lJ/XE5tPHSzqatxKYmUWNBEAmLycyAaoV0YgqL4LbJtkTj0BRt92mrHZ/hs1bm3V/m5iGd3Hl7RMAOuic3u0DDtVBjX9Z0QSUq7lsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724700; c=relaxed/simple;
	bh=Z9ZMYQtjkOdsKMzcjrrJXMViLvmD32EUp95zUhLjR8E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+gmWi9And0cVC70MK1hBvnOX8AeB1vl+lBDbUFoHh51jCRQB4KWzHDoBtUETwKeNKe45lNn7+OjHiZibn6p44+waPxTN27p6FeP1V0iyH36jG6rukT0AQwDX+jUmEWFGhpS+ezQE8C9wmHwYJ2OVyBTAldfyTzZ7AF2mSiFeF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C6Z82Prw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsOJ/91v; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C6Z82Prw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsOJ/91v"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3CB261380125
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:31:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Mar 2024 06:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709724697; x=1709811097; bh=twsR/+TCFo
	DauGIieTaIXEK3VOhuj85N2hWYIfa0Bg0=; b=C6Z82PrwS8pa8VhBu4uyWbu0JZ
	cj2Ocr+I/XGhV7ydtv/M9nyWOxbHvqxRWZaDawIZipNBTZ6woLsRMtxtIpcfGGjk
	hetdSGPNCIXg52lZal2teVtE27YUPUOTGGXN8XXkQ78GxuNL+ADIXkmIVrjIP5mh
	8qpSQ+fDEaDtYrJwBbe4edA6cdvNxDUWvSlFTmCE9+g3zu3potLsjcYUBL+3kGrR
	p9fHGMVIIp5PmBQEkQ7qLaNq5uGvb2z1Y2J2f7EO+lf+c4yB1OrapI0+K1WybRtR
	xijyc7esRZHKpSLeiXgNfHJLZy7VVkuZR48NMGbny7f1l6QAD7Zlpbuhi/9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709724697; x=1709811097; bh=twsR/+TCFoDauGIieTaIXEK3VOhu
	j85N2hWYIfa0Bg0=; b=nsOJ/91v8owS2se7yuDo03lfatE/9T4EOQqM9TerxH7P
	q/xJ7nBUfikapTBKOCh+igDT1FVUjNDL0MAvHwT3tk+Tc0diH6kYuBvGAJUv3z1L
	pXezMLT4NZHo58wBZYlBU3Mjhx+k9DvAbhoEn6U8u2b5KHUl3OJ1yGYPJ+6YJ9fD
	CE8QoiS5KBqQUGlfqJcCNbWH3MrpUfu8bJoDm1RB7bBskMGV2wrNRmQxruIUHJxJ
	YLb4m2OkIUnFKl9eDXYai1RbjiOqDZN0n8bWiTMR32uBC9Y2QcWJZAgiI5v3RvgG
	NOYI9to0E9G8q7779SqZvh8s6k8WAyLIqJKWQ5PGEA==
X-ME-Sender: <xms:GVToZVVUwydn0xRjC2ziT2vQpUm0hm50GyivYZ6OgoUO8IEwC9RBIQ>
    <xme:GVToZVliQSjXQXq49lxRYLr9KhlhAnYZOK2XO-y_nXxc3XWAQ4z0TtJ8Be7QblCGl
    10E-1MlnjQwBhKAmw>
X-ME-Received: <xmr:GVToZRYun7F0VQqu8HpXTXuznmAtarEtoDbatu3Nizen3QIMDY_OI2Gwh7MuD3da9OFxVSGbQ94KKPW4b-9didzjSTyWWPL9m0o8-4I-XNmqY_8ptA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GVToZYXPWXnQ6rBQ78KfFUQJ7jnqqzU4eQGARL7GxuNveSqzNOJ6XA>
    <xmx:GVToZfmdjjwmOG4AWAWdofi0FIYZAUPXw8Vfa4ANnsFycSYen1eiGA>
    <xmx:GVToZVeVGfufBa8PYclpzu-SCl4fGoY7lDruWMJzOgIxsVt6INpypw>
    <xmx:GVToZXtmByFYBTwyAdQbVhRQXUyDkqJsAgrs0lENOY2sj-XJxco0eg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:31:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 012f78e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:07 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:31:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/8] builtin/config: move option array around
Message-ID: <04210c1932c7df1b2e336089e49d50cf422e9da0.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0KV7WzQ9yAOLaaj2"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--0KV7WzQ9yAOLaaj2
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
2.44.0


--0KV7WzQ9yAOLaaj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVBUACgkQVbJhu7ck
PpQ06A//ecGD1+t0i7QWLmzo8pw9w58gA5VDD6JfZnXtJfDjWw2ycZnCxnEZAEt6
U7NyVl5fIf5Qb8G33cf4YT3ih1g4UT+IKXm/YzkJ5rJidW+UXYNPTf4r8k8iql5J
xm9ZkiKyuAyUEsmDh8suW67XRF1NXzDQCMRjxtcSxRrU0jEpcBmPF9D+x1aDGmw8
xzRUwpZutJxOZUQP8MRIvZpzykxQTWw0vxNC4/4a305X2VjlP7tY9GpxX3HsbcKQ
BZYq5HbpD28VWHuKVpHGUZh8pTQIk7MiIHCINuz7FQK+80Utk+EIKbuqozepH/Ph
eIlVR+tnrV2y/iZYOtJwfZrjq1WSqMY8SpTVqv7H9pV3QAaFCmJfp01cH9uRRNO3
q2MTft7R9xPjEhl9uwq2rEykjvFhQ5W1ZfdaUQ4GS/xo/3dlThy84locVKtwV5RA
uRx0Y/RXHPoVMntM9EeF3uJduiOcD/efPAz5IgMHYPbEpg0N/VsQogvyM4SqDxAP
Tn3lR6FdE3QOtsrhscT9C1+KZa5N6HS1MKbJxCV/u6i0sZCPDibieWl91//B9ZCF
y9v/eggJd05lddaRk0xjAVwY5sU2XjbouuifZYTwv6fslHuoSU5yNxowtR3bJYJw
GKmi1n0v3XPmqvEB9PdsF3BPUXxda61RsKg8sdm3wE0DWKoAkQk=
=pzGF
-----END PGP SIGNATURE-----

--0KV7WzQ9yAOLaaj2--
