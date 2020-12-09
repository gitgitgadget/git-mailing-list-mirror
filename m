Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9C2C19425
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04BC23B7E
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgLILxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:53:36 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48749 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731063AbgLILxV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2020 06:53:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 96AFFAB3;
        Wed,  9 Dec 2020 06:52:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Dec 2020 06:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=aJcFpnPudnq6gziR3NCG14P8GjI
        +J6ZhsZmnz2yhECM=; b=s0ZQhT1AlyxrHTttTyf54gXIK6FGW/OZugiH/TMSlNH
        4jhHDNsPSO3AU9kbVMI/oQwzmLRA8000/vrBvlMdcI6gTJHDOKOqToaL2cyjlS8o
        urbpeoqoz7wK4nAxg1LhioJalfBYeMIit+jHHn091R+kMfyyaF7QAdWhlCDV7ZDn
        SCVUV3iNmRp6CrQxItAFAT17HTV/ShCAqEOToFfRSrsWBs763pU9Od2l2Equ5ROs
        4XTIEwDXMVrhkPH1d5LZyXq64WLtye3V+JlKb9aWI17koCgNLo7sMVH27ZGFE6r1
        z5b9zi6VcwSJzJIcSVUJZvpapPg/atmwQWJGCBajhJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aJcFpn
        Pudnq6gziR3NCG14P8GjI+J6ZhsZmnz2yhECM=; b=AUFjxAKNalz5RTRyQ5Uln1
        hd8oslpfOuLnemVhD/hlk03JvWzWADmyqkvo9Y6YDX/Z5CpnSZc92G3CBS+HJtYX
        G/+MrD+//SttfsMsAZgaAlXMCEbT/PExMdSBef5yyOuap9ARtuMcuIn5AEPmxuAi
        IPma2O9gbyGxe4EAb45Y0V4Nvav3vjys8ZLSYfv5r1NAdYfw3+XzebajuE393bVq
        UBq4dbsQ1JuYh68g2k1PoPvHe1eHhHQHZ0dy3l/y7MDNFGC7RKXsp/dPYa57a+SK
        N9iYRp3EZAqHjDka7zjojlxI1uW9ExuuyKmLoljY8Otw15N2MlbRKk1yGp5liChQ
        ==
X-ME-Sender: <xms:fbrQXw5hNctABDy4nvTJ0grU6NBRuLnmVsmMu79pTft4HcaLimBuGw>
    <xme:fbrQXx4Dy19q3a0eCZ5j7l7HPSBHWZqPGDdNM3JXR5dJz7zI2GjjtLFqocwUiw5os
    u9CSOyZyECQADIlEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedriedurdduvdeknecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fbrQX_efRQmeXoWiB_P2ck15Pzm9Az2W7h01-wI6XbLEjb6L0DZ2gw>
    <xmx:fbrQX1Jy9G5R3WkadEsBtw3B9UE6v3Mxf1Je6ZlCIVYVV8awprJjqQ>
    <xmx:fbrQX0IdppiJZut2f-bkRCTxwKa8bM4muIxwkABAb94J88VUowvf9g>
    <xmx:fbrQX42EWH2XHjYssIr7LLyMMDl_NvBVaMKYNEd1_8WzRHr-nWHCUA>
Received: from vm-mail (dynamic-078-055-061-128.78.55.pool.telefonica.de [78.55.61.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 466C21080069;
        Wed,  9 Dec 2020 06:52:28 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 78435aec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Dec 2020 11:52:27 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:52:26 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 2/6] config: add new way to pass config via `--config-env`
Message-ID: <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7/7MMyc64XVa1jZ0"
Content-Disposition: inline
In-Reply-To: <cover.1607514692.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7/7MMyc64XVa1jZ0
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
 Documentation/git.txt | 11 ++++++++++-
 config.c              | 21 ++++++++++++++++++++
 config.h              |  1 +
 git.c                 |  4 +++-
 t/t1300-config.sh     | 45 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c463b937a8..9061c54792 100644
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
@@ -80,6 +80,15 @@ config file). Including the equals but with an empty val=
ue (like `git -c
 foo.bar=3D ...`) sets `foo.bar` to the empty string which `git config
 --type=3Dbool` will convert to `false`.
=20
+--config-env=3D<name>=3D<envvar>::
+	Pass a configuration parameter to the command. The <envvar>
+	given will be replaced with the contents of the environment
+	variable of that name. In contrast to `-c`, an envvar must
+	always be given and exist in the environment. Passing an
+	environment variable with empty value will set <name> to the
+	empty string which `git config --type=3Dbool` will convert to
+	`false`.
+
 --exec-path[=3D<path>]::
 	Path to wherever your core Git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
diff --git a/config.c b/config.c
index 1137bd73af..cde3511110 100644
--- a/config.c
+++ b/config.c
@@ -345,6 +345,27 @@ void git_config_push_parameter(const char *text)
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
+		die("invalid config format: %s", spec);
+	env_name++;
+
+	env_value =3D getenv(env_name);
+	if (!env_value)
+		die("config variable missing for '%s'", env_name);
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
index 97a04c6cc2..46a94814d5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1316,6 +1316,51 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAMET=
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
+		env ENVVAR=3Dvalue git --config-env=3Dcore.name=3DENVVAR config core.nam=
e &&
+		env ENVVAR=3Dvalue git --config-env=3Dfoo.CamelCase=3DENVVAR config foo.=
camelcase &&
+		env ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config --bool foo.flag
+	} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git --config-env fails with invalid parameters' '
+	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>error=
 &&
+	test_i18ngrep "invalid config format" error &&
+	test_must_fail git --config-env=3Dfoo.flag=3DNONEXISTENT config --bool fo=
o.flag 2>error &&
+	test_i18ngrep "config variable missing" error
+'
+
+test_expect_success 'git -c and --config-env work together' '
+	cat >expect <<-\EOF &&
+	bar.cmd cmd-value
+	bar.env env-value
+	EOF
+	env ENVVAR=3Denv-value git \
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
+		env ENVVAR=3Denv git -c bar.bar=3Dcmd --config-env=3Dbar.bar=3DENVVAR co=
nfig bar.bar &&
+		env ENVVAR=3Denv git --config-env=3Dbar.bar=3DENVVAR -c bar.bar=3Dcmd co=
nfig bar.bar
+	} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
--=20
2.29.2


--7/7MMyc64XVa1jZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/QunkACgkQVbJhu7ck
PpTIPw//e2+Dg0YIMImrn0jJto9ScAfG01jzO4Z3clE2LNGoMyhOSzH58mNFwbHB
SouXAPRyJaC/epcMq9y6DWYf7r7l18C/hDoAd7pFkC2Efi4Tt5Bc6XhAIhhy5jre
yxZXIsWNyzUEbE6s2RZGwHVF85Bi/FowBTdTFgaLRhihQfYT7vXkZ+CVJcqDbnkC
ZSylOozOhlCLV31Tpa/RvU+t/bQVvCdihNBx0eLXyZoJ+4U7CGH+DYtxffoouPDn
tt7aT+1EpiKAbYoleeztOqE5fXldotzNNcpfUaf6WJpNq6yn/VoqFg8wcb0S//yM
isnGxbR+QUnMjGiqzObwtc+Y3K6IjXpx8wzUh3P2ySFIqsM7UZ6ZZeNSsvUQpDDF
MKWY61nAeDWnaxtv8b3VLHdg1MpILThLbfl2ZSHRG7k+bFamabfsDEBpUqO8emtJ
Raqh/UD+bLy4fRQlOyO5iuOcUKxSIBpkuK2Bzw5Og7k2AqkzGdb3l/lr8Tio6M4D
Q9nsfkcvcMeaJL7jA61Yw+6Af0+BRzYcfA05Uu18QpKNAfln22I+JiMK2R3xxdUd
FoVk1sY/XKJgcyrF6KLTgmnaUVrY4uDYlwjaTPMNVlu2kDbg/aMHQIlvurblj2Zt
3vRn0BU3K/4OIx+G7cmT2vcp+8W8+NeLqqjn7kXF0il2NU13cXA=
=voMM
-----END PGP SIGNATURE-----

--7/7MMyc64XVa1jZ0--
