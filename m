Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9886EC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D15623356
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgLPHxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:53:37 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55707 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgLPHxh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:53:37 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 725775C0108;
        Wed, 16 Dec 2020 02:52:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 16 Dec 2020 02:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=07YHmD6le/5VvIXUHrHbb1hlFbh
        5i3RcLiaiDGl4wBA=; b=yE9H8kULMDWfGfxyWqr7GF5k2Mi6CCpqvenBYrrChLs
        bqf2TGgDsL3fCn2+3qUREsGybb/1UMyGL0UFvHA9iA0i7qezoL59RL3vf0gWiOUS
        Br/wcVnq1kpkcDdzzf2B93VIAWMLWCx599cbNcIqs/6bsUioXYJEoSVcq8Ys73ML
        68GBIUjOPpv88LzCEz27lJJ2k6DfXr7GIyqN8jzzNYSkFizE9e8hKOssBorBMuiE
        ow19DrvMrcD1y/U/VGrMe82yJTu7hcwZmRkGoskih4kiLvSXdUyMbVlyh06N7IwH
        BKamAfgj4SobaZ96LG1rAArMYPa4CC7i/UrTyFWwo4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=07YHmD
        6le/5VvIXUHrHbb1hlFbh5i3RcLiaiDGl4wBA=; b=bS8lPuAsBWEp8Ali5pjla4
        EqSAM6Wkcgff1CwK4E73enRTUPtVWKAINYhDSTm/YJ1yfW+64ENZAyb9aALmNYtu
        SOnMmkRHBM6ozWw1l2E6idCNSbySPCRBdl+Y5cWwOqd+aRq/dBZOyRxE8RYjSzJC
        PrKVx6C/A0nmELGtUhrtB08tokqXY+mUXLu5BgMzxWa1iroKk3pdwmlDuT5OJjgZ
        SvpDGl34aS2uhqg8/pBO3iJe4NqlKSJYIZ4cJBSOKTdhLUk7W9Z7Dqgbr5wuP+un
        oZboluPV2vOsFI9//YJ3Amkc4mN2qYnHb8Nwhvd17oBUjV/+pLgImYE3Jiki8kcg
        ==
X-ME-Sender: <xms:0rzZX4hGHD9NomH-UlnaPW2N-t-3CQeisCgko5nTPc8EcKesNaaDuQ>
    <xme:0rzZXxBUvoO3JdLB2CwPbpq4TEGLAUAIRmnnUAGYXvKQwlPYI_Wh4v-9eKtQce9qo
    8ba6SntnHkoSAtUdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:0rzZXwGDsG2P4laKv7Y2Eyl2jED0_dhXHxvdOvg8Pe10-3VwUeCE3A>
    <xmx:0rzZX5QZqjFtukO3wvCfv6TxW2ttttefqh4ghM4EvY02fmqBhf-c7g>
    <xmx:0rzZX1ygGyHIOkCXcqdfHNghZhyQnVyGcrmUmgqQ1qL3FiuGrSf5Iw>
    <xmx:0rzZX9-in7WPWTp9kDGI1uqhi6fXFmWjdxjowtg5q2DxRmLyMX8wxQ>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 753321080059;
        Wed, 16 Dec 2020 02:52:49 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9bf4b233 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:52:48 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:52:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 2/8] config: add new way to pass config via `--config-env`
Message-ID: <56c9221c4cc8c3e52823938938e3f65a3433f9bf.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BRbVKgc5qaHZfp7g"
Content-Disposition: inline
In-Reply-To: <cover.1608104755.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BRbVKgc5qaHZfp7g
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
 Documentation/git.txt | 23 +++++++++++++++++++++-
 config.c              | 21 ++++++++++++++++++++
 config.h              |  1 +
 git.c                 |  4 +++-
 t/t1300-config.sh     | 45 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c463b937a8..80fb8fab11 100644
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
@@ -80,6 +80,27 @@ config file). Including the equals but with an empty val=
ue (like `git -c
 foo.bar=3D ...`) sets `foo.bar` to the empty string which `git config
 --type=3Dbool` will convert to `false`.
=20
+--config-env=3D<name>=3D<envvar>::
+	Like `-c <name>=3D<var>` except the value is the name of an
+	environment variable from which to retrieve the value. Unlike
+	`-c` there is no shortcut for directly setting the value to an
+	empty string, instead the environment variable itself must be
+	set to the empty strin. Errors if the `<envvar>` does not exist
+	in the environment. `<envvar>` may not contain an equals sign
+	to avoid ambiguity with `<name>`s which contain one.
+
+	This is useful for cases where you want to pass transitory
+	configuration options to git, but are doing so on OS's where
+	other processes might be able to read your cmdline
+	(e.g. `/proc/self/cmdline`), but not your environ
+	(e.g. `/proc/self/environ`). That behavior is the default on
+	Linux, but may not be on your system.
+
+	Note that this might add security for variables such as
+	`http.extraHeader` where the sensitive information is part of
+	the value, but not e.g. `url.<base.insteadOf` where the
+	sensitive information can be part of the key.
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


--BRbVKgc5qaHZfp7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ZvM4ACgkQVbJhu7ck
PpSsdA/7B/psWeS6wYLZvzaduDRmzmU4fJRsWAYKtFroGqQsvbtY7xTajGno7K0G
1noj1kHHA1WbjqKEv/caovtrTC3Kvo2EaR+KXj1V31ziP0VKZdJcB3OmfeEBghV8
gstYBgCOXCGSqlytKkvaZJiH3vfuEWaf0/O2+ZFi8yTYczfdCatLFbmtb+VmDZK1
/hDJUnOhqzPQeQbOWwjW7AyP9zbxwtGJxb47h37o0hCeQMo8zSIUM1zX/WS9u0Oq
YR+zbnSC/i8m8o0+em+u3CEIhtkFGg1HbCbK+2ISWMEEo0qW1bkVvrvHdHkpO4oX
+SIZVqdTg37D2W6QMklNE0PrHjC08uYmqDx6YAf2PxBtP0zDRfp+QmmVxMpQw00d
vOmglqfE0nM9HgT6gT48ysInVJ9Pquq0aMTTaFOCvkeorvWtMyGyiy4nyH9ulMkm
2Xw9Ygf7EOkSaRwMZGxS9+8/nfzZWad2r6TAqRy8EgB3PVdGwUpIO0dcPggMcCZy
qTL5+T05n9pNsyRNllZiE4/b9rnpBYj+ff7LfyFacTFSB1oOFYlB1K8ZGzM15mlQ
r6CkoIDiLps0XKL5uY4p6QYA/eva+J4YkXeFAJDswVdQ7IMQEwCirNp0EMlvRKj8
Dzf3uQU3z2y1pIKJSWrt6YrPFMMl7SmosAEO0cD5IW84uS9uPDM=
=7grc
-----END PGP SIGNATURE-----

--BRbVKgc5qaHZfp7g--
