Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A532C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63DB22BE9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbhALM1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:27:35 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:41755 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727855AbhALM1e (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:27:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3795C1AD9;
        Tue, 12 Jan 2021 07:26:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=At9oS3BpmSJJZUD5TI3tBCfB8Dl
        OuHO+/1KiqIy69+4=; b=KoTOghGAUn8NnJ/hJy6YiHv96czxkEMPCRCiCtkEyTZ
        KTPPb6tJZWwWbXUHOQz1UTBOop8+rW2tk5Tv8DmRwdnU29VpQiWjt92xh7gE3hmW
        rmyfOYSfEE7tcE8hciPTt0NS1IeyzDao27JcgoXOQcEtAZX76riqu5vRsN3ovqr3
        i31iiYoYUgmeTEvudwtybCRDfwC7ayigjWraJfEQ1fMFw3hzL1u/bM+Qb4uiQ7KS
        LxRxcaa7bXs+kImLtUl4fe5ozceLdHO315y21TPUzeAfkJlIrrZG2dXKe9jH8vuT
        VrNyKZHRcSRr7wLdFF5UCLr875WIdjxAHYPKpkWpmBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=At9oS3
        BpmSJJZUD5TI3tBCfB8DlOuHO+/1KiqIy69+4=; b=a1jYk0ERq712cUVDGRWUKz
        I8o4HjLuHV4V9/iPEkeh+ABi5nPoERNnGDyc4qdbZdP75cAgkJiOK0/FeyoMnNN/
        YoleW5mxdmf9G7Ns6etFo13TanuKhqx87R6bud1F5AIzLs4T3PC0+j9Dg5rC1S1x
        vmoJdHOcLE9bOWHLa65gu7n30u8Gg0ZpRTPYDMPpKcUlx5iQy3IcC5D0kgL7+8Sp
        q7UCViatebXd111TJPMaSBQWle9Q5QJr/+ad+GnvU1DUef/9H+G2ik6Bj2QtTSoT
        R1N1GDWen+vOVyB4XxCeKRFC58lBhKKffsgnP8+TuNX/0RzjzhYZgA988x84oNWg
        ==
X-ME-Sender: <xms:h5X9XzBERgHQqp7lYMBgUcngnm2WNzFGlwij8BmaOgIQXVbkvik3Fw>
    <xme:h5X9X5hEZHCV8CMY8FNx8C0YKrtJxFM31D9jEGclBKB7cs7YSQISZdLf8NyhqTmWw
    pdnS8w3S2xXWBq26Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:h5X9X-kc0vOOXJdu2F9A_bsEx8Z_xW7yk5HBFpAEBAgYnsgbAacfIw>
    <xmx:h5X9X1wRH5AtJGAld3ET_8GD8tM27GwIHa7XyqU8MMVTLhNaTEyMIg>
    <xmx:h5X9X4TQ5kvOgViqE0-23DxIH1tem0wEMqrIJv9Kx-UeqCXEdDYECQ>
    <xmx:h5X9X-NHr4XGphSJrrLlweF7bZL1JTrNYMV6bOIfVz2rXG-_XtoOeg>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id C64E7108005C;
        Tue, 12 Jan 2021 07:26:46 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e20d97e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:26:46 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:26:45 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 2/8] config: add new way to pass config via `--config-env`
Message-ID: <470396d36f938f0070b8c849a85b1a30949056e3.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8kDk4fJgTBeViDMS"
Content-Disposition: inline
In-Reply-To: <cover.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8kDk4fJgTBeViDMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While it's already possible to pass runtime configuration via `git -c
<key>=3D<value>`, it may be undesirable to use when the value contains
sensitive information. E.g. if one wants to set `http.extraHeader` to
contain an authentication token, doing so via `-c` would trivially leak
those credentials via e.g. ps(1), which typically also shows command
arguments.

To enable this usecase without leaking credentials, this commit
introduces a new switch `--config-env=3D<key>=3D<envvar>`. Instead of
directly passing a value for the given key, it instead allows the user
to specify the name of an environment variable. The value of that
variable will then be used as value of the key.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git.txt | 24 +++++++++++++++++++++-
 config.c              | 25 ++++++++++++++++++++++
 config.h              |  1 +
 git.c                 |  4 +++-
 t/t1300-config.sh     | 48 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index a6d4ad0818..d36e6fd482 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -13,7 +13,7 @@ SYNOPSIS
     [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
-    [--super-prefix=3D<path>]
+    [--super-prefix=3D<path>] [--config-env <name>=3D<envvar>]
     <command> [<args>]
=20
 DESCRIPTION
@@ -80,6 +80,28 @@ config file). Including the equals but with an empty val=
ue (like `git -c
 foo.bar=3D ...`) sets `foo.bar` to the empty string which `git config
 --type=3Dbool` will convert to `false`.
=20
+--config-env=3D<name>=3D<envvar>::
+	Like `-c <name>=3D<value>`, give configuration variable
+	'<name>' a value, where <envvar> is the name of an
+	environment variable from which to retrieve the value. Unlike
+	`-c` there is no shortcut for directly setting the value to an
+	empty string, instead the environment variable itself must be
+	set to the empty string.  It is an error if the `<envvar>` does not exist
+	in the environment. `<envvar>` may not contain an equals sign
+	to avoid ambiguity with `<name>`s which contain one.
++
+This is useful for cases where you want to pass transitory
+configuration options to git, but are doing so on OS's where
+other processes might be able to read your cmdline
+(e.g. `/proc/self/cmdline`), but not your environ
+(e.g. `/proc/self/environ`). That behavior is the default on
+Linux, but may not be on your system.
++
+Note that this might add security for variables such as
+`http.extraHeader` where the sensitive information is part of
+the value, but not e.g. `url.<base>.insteadOf` where the
+sensitive information can be part of the key.
+
 --exec-path[=3D<path>]::
 	Path to wherever your core Git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
diff --git a/config.c b/config.c
index 1137bd73af..fd8c0c4dfc 100644
--- a/config.c
+++ b/config.c
@@ -345,6 +345,31 @@ void git_config_push_parameter(const char *text)
 	strbuf_release(&env);
 }
=20
+void git_config_push_env(const char *spec)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	const char *env_name;
+	const char *env_value;
+
+	env_name =3D strrchr(spec, '=3D');
+	if (!env_name)
+		die(_("invalid config format: %s"), spec);
+	env_name++;
+	if (!*env_name)
+		die(_("missing environment variable name for configuration '%.*s'"),
+		    (int)(env_name - spec - 1), spec);
+
+	env_value =3D getenv(env_name);
+	if (!env_value)
+		die(_("missing environment variable '%s' for configuration '%.*s'"),
+		    env_name, (int)(env_name - spec - 1), spec);
+
+	strbuf_add(&buf, spec, env_name - spec);
+	strbuf_addstr(&buf, env_value);
+	git_config_push_parameter(buf.buf);
+	strbuf_release(&buf);
+}
+
 static inline int iskeychar(int c)
 {
 	return isalnum(c) || c =3D=3D '-';
diff --git a/config.h b/config.h
index c1449bb790..19a9adbaa9 100644
--- a/config.h
+++ b/config.h
@@ -138,6 +138,7 @@ int git_config_from_mem(config_fn_t fn,
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     const struct object_id *oid, void *data);
 void git_config_push_parameter(const char *text);
+void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
 void read_early_config(config_fn_t cb, void *data);
 void read_very_early_config(config_fn_t cb, void *data);
diff --git a/git.c b/git.c
index 5a8ff12f87..b5f63d346b 100644
--- a/git.c
+++ b/git.c
@@ -29,7 +29,7 @@ const char git_usage_string[] =3D
 	   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--inf=
o-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects]=
 [--bare]\n"
 	   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
-	   "           [--super-prefix=3D<path>]\n"
+	   "           [--super-prefix=3D<path>] [--config-env=3D<name>=3D<envvar=
>]\n"
 	   "           <command> [<args>]");
=20
 const char git_more_info_string[] =3D
@@ -255,6 +255,8 @@ static int handle_options(const char ***argv, int *argc=
, int *envchanged)
 			git_config_push_parameter((*argv)[1]);
 			(*argv)++;
 			(*argc)--;
+		} else if (skip_prefix(cmd, "--config-env=3D", &cmd)) {
+			git_config_push_env(cmd);
 		} else if (!strcmp(cmd, "--literal-pathspecs")) {
 			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "1", 1);
 			if (envchanged)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97a04c6cc2..853f2509c5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1316,6 +1316,54 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAMET=
ERS' '
 		git config --get-regexp "env.*"
 '
=20
+test_expect_success 'git --config-env=3Dkey=3Denvvar support' '
+	cat >expect <<-\EOF &&
+	value
+	value
+	false
+	EOF
+	{
+		ENVVAR=3Dvalue git --config-env=3Dcore.name=3DENVVAR config core.name &&
+		ENVVAR=3Dvalue git --config-env=3Dfoo.CamelCase=3DENVVAR config foo.came=
lcase &&
+		ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config --bool foo.flag
+	} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git --config-env fails with invalid parameters' '
+	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>error=
 &&
+	test_i18ngrep "invalid config format: foo.flag" error &&
+	test_must_fail git --config-env=3Dfoo.flag=3D config --bool foo.flag 2>er=
ror &&
+	test_i18ngrep "missing environment variable name for configuration ${SQ}f=
oo.flag${SQ}" error &&
+	sane_unset NONEXISTENT &&
+	test_must_fail git --config-env=3Dfoo.flag=3DNONEXISTENT config --bool fo=
o.flag 2>error &&
+	test_i18ngrep "missing environment variable ${SQ}NONEXISTENT${SQ} for con=
figuration ${SQ}foo.flag${SQ}" error
+'
+
+test_expect_success 'git -c and --config-env work together' '
+	cat >expect <<-\EOF &&
+	bar.cmd cmd-value
+	bar.env env-value
+	EOF
+	ENVVAR=3Denv-value git \
+		-c bar.cmd=3Dcmd-value \
+		--config-env=3Dbar.env=3DENVVAR \
+		config --get-regexp "^bar.*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git -c and --config-env override each other' '
+	cat >expect <<-\EOF &&
+	env
+	cmd
+	EOF
+	{
+		ENVVAR=3Denv git -c bar.bar=3Dcmd --config-env=3Dbar.bar=3DENVVAR config=
 bar.bar &&
+		ENVVAR=3Denv git --config-env=3Dbar.bar=3DENVVAR -c bar.bar=3Dcmd config=
 bar.bar
+	} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
--=20
2.30.0


--8kDk4fJgTBeViDMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lYQACgkQVbJhu7ck
PpQEnQ//Qe8GKF4jmJuC3Iq6WXIQQ+w/apzhb56FQAjL6upp6O8P/stoq++vPVO4
WdThrs+wrVTwhA49kUC9iGf1OnTfQ0+WlmNKJ4360DU/w89JgoIeltdoZX2v+hPW
FpUQF2gJ9i7Fr9tn70jjocFCJeZiHrs16CkKcNv9EL665zPRPlWW33oigtf/LJEM
2vCxCeQ6P3BU0Z4uOU5Nib4CjLa4TegPr9Tv2XXs4fHbIEmcWPQMcmDYV0a2qf1n
sLvMm0VhDy50u0CadG0efIr++okMF/P9mXVK0hgOJorX4huhPqerRPAg+ItC/tTu
pRNSsMFY7zFBXdKP1vMarETF5okvJGu8Ly277OsAaVmFSBI952UFV2579JkeJo81
OTMUp0oprGmNRog+1i1ynjpY5DcPhdTrNcSR+2ih2vX5KMqPXURJjrbdaiYyKrv4
/XcZEkp8eNb/5dWAc5wh+14/akxKRfzymSquUv/gHkl1iUtfSxBr0rMAPr6aRtbk
sLNCOusDSHxPBFuZj6fQTzodPxbpJcSuA5DoD749G0ZLX9ubQbuu6a5phyiXv548
sSYTOXA/UWLirOQCxgAtpsxzVUu3h4BuEQF0jGsfCK7xHv5cVZm9Cg6YgyxRTbdF
2zRvSGQUPiTJnaaidtrXjvrYf5SYNtv4FLjsIvBS5P7RfvICH5w=
=Qbxi
-----END PGP SIGNATURE-----

--8kDk4fJgTBeViDMS--
