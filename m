Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4451AC433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A572310A
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbhALM1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:27:49 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:40211 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726986AbhALM1s (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:27:48 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5145AC6F;
        Tue, 12 Jan 2021 07:26:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+3brR5rume6RX62PCUesBzmbqiO
        yraxM5DrGSa33K0Y=; b=St9GNoRmD7fK6F9ajgWBdSgNCD7tsWXtewSgVM8U73K
        yFsDB51n3ekABH7pRLQxKZ81JjYaahma0EzBpb3Mof/U/Fef5FQ+VI8QOZKuhcTM
        AvT5yj8PpB7ROKgh+bNuw8gh48zMfXq7E3Vl2ELy2I9yr+hNDCoKgKWmJnqReMSL
        jOoExIDJ0yxiya47d0W31fRGWFlUoF/JPlW7COyWAgZBNWM2nV6HYOo/QGcaaZP0
        Mz9+t8PAx2lCzHqYSAUZzOPJFjSAWP7Q1+nfwZyGoOvZl2KwHML0NmeOqK8HYqIz
        49h5G+rqlfdCAFZFtO+vxuVdc8+n9FqB42NV4ttsWWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+3brR5
        rume6RX62PCUesBzmbqiOyraxM5DrGSa33K0Y=; b=q7AN0P6o1224yf8fi9BYCm
        1mssv6Wgvmz9vcLbmgpRZX02ETWMGIPwVkYqjZ0Ry2rnKXz0snLGhkXFgcunWNR6
        dSG9QF72nBnFozOb7YGCTE9gKw8mbhD+92JbpAFRVN8tQ4Vncg7E74oHiLZJWkGJ
        yKqhYVtyG7FkInfDFTWqkAbu6Nmn0xmM4TRSqrbqCHKAvt+2Dsukh8WHYT6yOyXA
        xR1TgKz479sIz45gmkV6b4FUCxCaJcr6v8utd+IcQuK+s+5RGh7uZgtRyrkCxocq
        8Ez0VYJUSWa4Wa70nYn1XQhWH/3879vC/KKiF1eIVYM/oB2N4wL0+zAtf8Jr041A
        ==
X-ME-Sender: <xms:gJX9XzskMImosiRRTcvL9aRjeUWErB_Yqx0b2kCq6MOIqsGcFZdhkQ>
    <xme:gJX9X0eLZoKj_rXavWnR-7DGJkmXuC-4OeD29YuCrBZG8jzkyr0DkAg7p2pvOZ1bF
    DxvZKJxHogYxza-Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gJX9X2xvn5W_ophm8oCvgNcl7e51LhiDMlLrQQO0NScxJsi9v-BJ3g>
    <xmx:gJX9XyPlcJc0fQql-VAicQcKPsq4G5NxNihSsFc34IS7kVRG5RSOZg>
    <xmx:gJX9Xz_GdrtofyN4gzhaPnCOxhQK8IQucbL2RW3K5_cAKFUS0mJutg>
    <xmx:gZX9X_aCrgXp0W9pnihw0akIBQmk55mE203Cvydzna90KjpoTGFgfA>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3CFD24005E;
        Tue, 12 Jan 2021 07:26:39 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7f7df4d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:26:37 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:26:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 0/8] config: allow specifying config entries via envvar
 pairs
Message-ID: <cover.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BJKJE8VX8rbuWjZn"
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BJKJE8VX8rbuWjZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the eighth version of my patch series which aims to implement a
way to pass config entries via the environment while avoiding any
requirements to perform shell quoting on the user's side.

Changes were all proposed by Junio and are solely in patch 2/8:

    - Improved the error message to include the the config key when the
      environment variable name is missing.

    - Dropped needless use of env(1) in added tests.

    - The NONEXISTENT envvar is being unset now to fix the case where
      tests may be run with that variable being set by the user.

Please see the attached range-diff for more details.

Patrick


Jeff King (2):
  quote: make sq_dequote_step() a public function
  config: parse more robust format in GIT_CONFIG_PARAMETERS

Patrick Steinhardt (6):
  git: add `--super-prefix` to usage string
  config: add new way to pass config via `--config-env`
  config: extract function to parse config pairs
  config: store "git -c" variables using more robust format
  environment: make `getenv_safe()` a public function
  config: allow specifying config entries via envvar pairs

 Documentation/git-config.txt |  16 +++
 Documentation/git.txt        |  24 +++-
 cache.h                      |   1 +
 config.c                     | 209 ++++++++++++++++++++++++++++----
 config.h                     |   1 +
 environment.c                |   8 +-
 environment.h                |  12 ++
 git.c                        |   3 +
 quote.c                      |  15 ++-
 quote.h                      |  18 ++-
 t/t1300-config.sh            | 223 ++++++++++++++++++++++++++++++++++-
 11 files changed, 491 insertions(+), 39 deletions(-)
 create mode 100644 environment.h

Range-diff against v7:
1:  55fa4d0d11 =3D 1:  55fa4d0d11 git: add `--super-prefix` to usage string
2:  b9cf47afe8 ! 2:  470396d36f config: add new way to pass config via `--c=
onfig-env`
    @@ config.c: void git_config_push_parameter(const char *text)
     +		die(_("invalid config format: %s"), spec);
     +	env_name++;
     +	if (!*env_name)
    -+		die(_("missing value for --config-env"));
    ++		die(_("missing environment variable name for configuration '%.*s'"),
    ++		    (int)(env_name - spec - 1), spec);
     +
     +	env_value =3D getenv(env_name);
     +	if (!env_value)
    @@ t/t1300-config.sh: test_expect_success 'detect bogus GIT_CONFIG_PARA=
METERS' '
     +	false
     +	EOF
     +	{
    -+		env ENVVAR=3Dvalue git --config-env=3Dcore.name=3DENVVAR config cor=
e.name &&
    -+		env ENVVAR=3Dvalue git --config-env=3Dfoo.CamelCase=3DENVVAR config=
 foo.camelcase &&
    -+		env ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config --bool fo=
o.flag
    ++		ENVVAR=3Dvalue git --config-env=3Dcore.name=3DENVVAR config core.na=
me &&
    ++		ENVVAR=3Dvalue git --config-env=3Dfoo.CamelCase=3DENVVAR config foo=
=2Ecamelcase &&
    ++		ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config --bool foo.fl=
ag
     +	} >actual &&
     +	test_cmp expect actual
     +'
     +
     +test_expect_success 'git --config-env fails with invalid parameters' '
     +	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>=
error &&
    -+	test_i18ngrep "invalid config format" error &&
    ++	test_i18ngrep "invalid config format: foo.flag" error &&
     +	test_must_fail git --config-env=3Dfoo.flag=3D config --bool foo.flag=
 2>error &&
    -+	test_i18ngrep "missing value for --config-env" error &&
    ++	test_i18ngrep "missing environment variable name for configuration $=
{SQ}foo.flag${SQ}" error &&
    ++	sane_unset NONEXISTENT &&
     +	test_must_fail git --config-env=3Dfoo.flag=3DNONEXISTENT config --bo=
ol foo.flag 2>error &&
     +	test_i18ngrep "missing environment variable ${SQ}NONEXISTENT${SQ} fo=
r configuration ${SQ}foo.flag${SQ}" error
     +'
    @@ t/t1300-config.sh: test_expect_success 'detect bogus GIT_CONFIG_PARA=
METERS' '
     +	bar.cmd cmd-value
     +	bar.env env-value
     +	EOF
    -+	env ENVVAR=3Denv-value git \
    ++	ENVVAR=3Denv-value git \
     +		-c bar.cmd=3Dcmd-value \
     +		--config-env=3Dbar.env=3DENVVAR \
     +		config --get-regexp "^bar.*" >actual &&
    @@ t/t1300-config.sh: test_expect_success 'detect bogus GIT_CONFIG_PARA=
METERS' '
     +	cmd
     +	EOF
     +	{
    -+		env ENVVAR=3Denv git -c bar.bar=3Dcmd --config-env=3Dbar.bar=3DENVV=
AR config bar.bar &&
    -+		env ENVVAR=3Denv git --config-env=3Dbar.bar=3DENVVAR -c bar.bar=3Dc=
md config bar.bar
    ++		ENVVAR=3Denv git -c bar.bar=3Dcmd --config-env=3Dbar.bar=3DENVVAR c=
onfig bar.bar &&
    ++		ENVVAR=3Denv git --config-env=3Dbar.bar=3DENVVAR -c bar.bar=3Dcmd c=
onfig bar.bar
     +	} >actual &&
     +	test_cmp expect actual
     +'
3:  1b47f0db98 =3D 3:  7a7a4ae234 quote: make sq_dequote_step() a public fu=
nction
4:  b9565a050e =3D 4:  39552eb8b9 config: extract function to parse config =
pairs
5:  8f998ac81a ! 5:  36c2a51b13 config: store "git -c" variables using more=
 robust format
    @@ config.c: void git_config_push_parameter(const char *text)
     +	key =3D xmemdupz(spec, env_name - spec);
      	env_name++;
      	if (!*env_name)
    - 		die(_("missing value for --config-env"));
    + 		die(_("missing environment variable name for configuration '%.*s'"),
     @@ config.c: void git_config_push_env(const char *spec)
      		die(_("missing environment variable '%s' for configuration '%.*s'"),
      		    env_name, (int)(env_name - spec - 1), spec);
6:  e7b073c9dc =3D 6:  d67a3c0f9f config: parse more robust format in GIT_C=
ONFIG_PARAMETERS
7:  6c1800a18f =3D 7:  28cc229ade environment: make `getenv_safe()` a publi=
c function
8:  ac9e778704 =3D 8:  07697b0c21 config: allow specifying config entries v=
ia envvar pairs
--=20
2.30.0


--BJKJE8VX8rbuWjZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lXoACgkQVbJhu7ck
PpRPSQ/9GcHVyljwZ8AJM8vrWd87IDlK4g2X9kpiMGF1RCDDD9ZGwWRjvmrE4lwQ
CMxghDiDKX9S6pT7D7TgVwOUafHVPkYnWAaD4WDCxOjHtHtIFjHIBWGiWWezt8Z5
5hJuy69FwfO0IapEfuk3T9FtEfHjPY1sfmkc+EX5RxFv/UDkQADMWaOWZtQQx03d
xXsy1vJWYNlIql7tPZxfOyjjP5cPObvXCwLHr3v4ZbzzX4/vemDTIINGIEwSG8Dj
7x+zmPcQ6swlTox0sz1nQ6TbVNirWqDi8BIQFxSVpy/KbVcCyynIJm/U3ov4pJG7
SOrQgCM4vzdKIUsr1Z0DsG3LChtD4M8hbZx77BTzH1nASAzfkVvdlvm0BFf7MeRe
20kEvi6wxSwMFaQzwoVcJw0fyzXOJ50gLcpEOzOyPdypw7SIbly0XiXbChwi8CbN
3aMuoG11txHwac25VZ2IhOYdhBvJ1mr4jX7UNcJSmQysDMnyY1HtOFh7kEu76ygP
2RxtfF/9iej4Q7aW6x+mM7PqPNsYzzRD+HbbfCbsHHtKvB+NoYy4tl1Gq1kMOeeT
uwXRyuX0VTajOsETYRidt+Trf/oMXDbQ5L3GMq/VE/9Bq8IOdDaoPbp7FzfjGCNr
k8sr7fXgjuklRptzpCGLU0LqvPfr+rnJpHnZPTDUcUeXlCJCeyw=
=D4P1
-----END PGP SIGNATURE-----

--BJKJE8VX8rbuWjZn--
