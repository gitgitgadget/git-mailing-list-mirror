Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98F7C433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9059522527
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbhAKIhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:37:41 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:39525 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbhAKIhl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:37:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9743A2512;
        Mon, 11 Jan 2021 03:36:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 03:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Dux9L/dN7cYT8Cor70pLsw1PAQg
        NnDyKv8GSXazN964=; b=UwDHcKCMgNKoPF+3osN+02Vpfc2sW313/PzqXQygJiz
        IB/WwCdufLYOa7oE/yBuE4MljFiILhjP6tDox5vHR2SfG+tnDOjKos/MQ7JgCDh3
        ALPURLZYg+xsRMs6hD9V4J7QjsGBDOIwxLSRp4l7KesGLXDeHGrfoYi4UFYl62/U
        AiNCDqdY8iCIzpNJbcFmWaT4TVWFNVEaMyf/lLBC8+/U0fp9+IL5Vs5D/oCLx4lS
        mf09B9hhw3en283iWm1nPvM8lokwXqleEtRqWnMS3qMvv9Xcjx1p7BAg+CjerRkF
        jQYsvfAZSPb2V28dox7xVWX6NSFPOxIfGx0rQRypAKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Dux9L/
        dN7cYT8Cor70pLsw1PAQgNnDyKv8GSXazN964=; b=PyDKrADmjGoFo2xRUufa4M
        bcqAmSLPwAu7v9ddN7ugpsLthzN5y8O3lGl1oU+Zruo+hPqE8M5kXx3u4v7XNSn0
        kmT2NYan+L3EcCcmi2jUYzSLvIEDU3Uwv5BIx/ZVWtzHCOLMj/nNk4H6HSrvm4v9
        0SvXU6iz4EPU6NGPHC/oZlHOT6A54O6MGZZ3Dc1amC3pAiwbNmBDJ8QOWAue2DGS
        YLmer5SLvZbHXrUKLjVWzBjIZgLQaE1Zy55XDlCSk/xGYRisxXofloXtD+Kl+Zyg
        4zx8oBiMHcOnTwMmmDZzkzvLH/a0E5hqUoyBROiqZnzZtCYX8kn7aj35IiMqZssQ
        ==
X-ME-Sender: <xms:JA78XxYYtDmY-9axVQ613raYDcTcLziCcAKH1KMm8zyuKiGD8wFySA>
    <xme:JA78X4YhkO_tReYfEQUKF5l4fI1KBFgcTnx9hA-P-7MDsJOAX7VO0EUjoAe6qnjpZ
    YZSQAyIaJt-IUChLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JA78Xz8CZZEAMBtPn80HMjD3iJxwgvI29y6SQ_hesrfEj2tlGn0itA>
    <xmx:JA78X_r6_aBeZNX1jQI5ihX5gRxq-IPm6BK2rri5XnIh6de2AXnyQQ>
    <xmx:JA78X8o8XCJwyk4I0wBYvZG_0f2W_yqL8htmPt9ZR1_pG6UASq0GuA>
    <xmx:JA78X1kN8wPyedKWDb3W8U2Iddd8ydYXGVE4ONNiCM8xyYXIU0S2Ew>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B8AE24005D;
        Mon, 11 Jan 2021 03:36:51 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f6887057 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:36:50 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:36:49 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v7 2/8] config: add new way to pass config via `--config-env`
Message-ID: <b9cf47afe896f8a6a76ba2e8aa87155e147ff31d.1610353895.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610353895.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I2v61ReXwIPe0A96"
Content-Disposition: inline
In-Reply-To: <cover.1610353895.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--I2v61ReXwIPe0A96
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
 config.c              | 24 ++++++++++++++++++++++
 config.h              |  1 +
 git.c                 |  4 +++-
 t/t1300-config.sh     | 47 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 2 deletions(-)

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
index 1137bd73af..6484d13c46 100644
--- a/config.c
+++ b/config.c
@@ -345,6 +345,30 @@ void git_config_push_parameter(const char *text)
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
+		die(_("missing value for --config-env"));
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
index 97a04c6cc2..1e23eb8213 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1316,6 +1316,53 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAMET=
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
+	test_must_fail git --config-env=3Dfoo.flag=3D config --bool foo.flag 2>er=
ror &&
+	test_i18ngrep "missing value for --config-env" error &&
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
2.30.0


--I2v61ReXwIPe0A96
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8DiAACgkQVbJhu7ck
PpQjQQ/+JOyWWyHKWtAvrp8nY8FWKFcJ87iz3s4E0x4dLK5mTR9KOk8vo5nsruFP
bwL+eqUdyDae+Eoh/+wIDeJp+pPrKRX6PSMe8s8OSiEoKo27sXwSFHdv1VP0IsKL
GbNxN3AymgQJPZmkOZQbbhv3+05+qfvQi+os8BpcVZNeI+HA4iki01UVk6lwwtRX
+NymRdrs64tvwRxq40IUTsvOECEVmqhmfXMRd4gWlsHGXejDKJhoNahgpzJFxo4l
9BgtVoUgkzu/UR1GbDAiAu/pU6JSFEJGphi3Yy+nGbyYKGAKNQ1KrBdWJrQkKOMz
SwTzm1sAVtCKTz5iAhSoDC8LzlM+gTmXhWdNAiXufDvV3gh64SqNewBG8SNQQOZe
2rorWfgZaw50dOmJebBeT+GqFmlAy0w7F7wdss6x3Ch5Kf+w+8AN837v8nJOBLbV
hM7vKG3VlZ05mChMKq/Fd7xWVX4BaD+MXuyedUftfIA5TC/Igr7UBt0Djj4qZc8g
OrC7Lw6weW/pbXdD7xrnKnN3STHlUPn4kMeZTMpO+GWSZVsEk9CKq68FLj4oLt51
4mgqXF3jOxBki7oSd53yzqVT2LkZsmiSpaI3pB5Ywkp4heTPdSIoRX2tYNPTMxsz
TKpuRacnOp7tpnqCMCxZSJCGjID74NWpMVHS3eMLTPL2FO2fe4g=
=zY5P
-----END PGP SIGNATURE-----

--I2v61ReXwIPe0A96--
