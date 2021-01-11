Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC40C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A023A22581
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbhAKIhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:37:53 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:56621 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbhAKIhw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:37:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1E8DD2486;
        Mon, 11 Jan 2021 03:36:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 03:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ctBB26mAkTcdgZIgm1IcYvI4Pyy
        bfN7Vhbn3CUMD9Jg=; b=MC8um5uJRnVklc5jAzhB0MdKRoQlCb0fEu44HaytRIp
        06hQ2LqLc0CF4Zuslzxr0fQwW8uuS0jYN6JzZ8HmCdkmgbXIrFoynWydRY5z8OxU
        msYBHy1nfHToEp6Cb50I8vE40icr3c5H87hli2q1lYKBhsGlNqEAK7pP2kxZ4QnR
        KQb8LdbiTOrD993KhfvvlB1Ipsd7G2A60AcCw63tOv2bCinPY0ytlXnrMGw6h7PD
        3jONdKxP4xYud30p9umBRWbYqa88slt0e1GEvr0MPCo1NYuuJSssqgVN1CNbAigM
        xkyaBog8tCIBV5qEYKufTf3EYDiV/ek3iE5J7b6fusA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ctBB26
        mAkTcdgZIgm1IcYvI4PyybfN7Vhbn3CUMD9Jg=; b=KQohcq/sC0GMw3yXiG2zl1
        wNQkagqLkcXm5Z0qr1HRvxbq+a6dcmsjnuiUkWxnW1Kh7hcIh01G3FmYNt6KTeCA
        bjV9cLq965IEMGqW1EwrB26acjxa/T1EHtOmzR8v7dPR01hjSxzD3Rl5QUKdlOQ/
        5ShBzxxa/vjEUQ4evzH1Iinfa9hQOBNZKY6HcI5CHwisXGm1Rfg6FV+8R4WPhHGu
        FfSZoXsuOzmVnyLfkxFQRR7WO82CQlM6WY9UUoo5Nt9HQGwugt09/EDDHP5nyWNu
        7BbfE8+CQJZPANAHRdwl5U2YQwfjePfe8BISFjmjrSWBEhswtFLvWM72dH4Cv4eA
        ==
X-ME-Sender: <xms:HA78XyTgqwMv4IouPMpKiyHJTAf9NPVygst_JCoOiMZGWJuALYy_Zg>
    <xme:HA78X3zjtBwCeGO18FQavz57fMaRwgbFryM8W_3k37Xaw4Gs5DlIO8iiiA7Q0TAun
    q_giFunQCEi4Vynxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HA78X_2bFvNLeRHwHo_45vIAlPZDUzSiCG6PalHl_mmlunpLGP6lFw>
    <xmx:HA78X-Ak5Ui_JxieR4DC7BNFzYrc5Ot-CVbnb6XA-Ofg34y2TTdR4Q>
    <xmx:HA78X7i3dWP6EICapxxmEBhpc8ixR09a9-A0au_k_xfmpa24VU0qPg>
    <xmx:HQ78X7faazV_-ECxqqqcyl4vBUgI4s5hl6K5QUqNuetNTuEkLVEh5Q>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id B6B5D240066;
        Mon, 11 Jan 2021 03:36:43 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 491542e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:36:42 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:36:40 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v7 0/8] config: allow specifying config entries via envvar
 pairs
Message-ID: <cover.1610353895.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ycCPYNrFQTor/cLx"
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ycCPYNrFQTor/cLx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the seventh version of my patch series which aims to implement a
way to pass config entries via the environment while avoiding any
requirements to perform shell quoting on the user's side.

The only change in this version is improved error handling for the
`--config-env` switch:

    - Error messages are now correctly marked for translation.

    - A separate error message is given if no value is passed to
      `--config-env`. Previously, we would've tried to look up the
      empty environment variable (`getenv("")`).

    - The error message when the environment variable is missing was
      improved.

Please see the attached ranged-diff for further details.

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
 config.c                     | 208 ++++++++++++++++++++++++++++----
 config.h                     |   1 +
 environment.c                |   8 +-
 environment.h                |  12 ++
 git.c                        |   3 +
 quote.c                      |  15 ++-
 quote.h                      |  18 ++-
 t/t1300-config.sh            | 222 ++++++++++++++++++++++++++++++++++-
 11 files changed, 489 insertions(+), 39 deletions(-)
 create mode 100644 environment.h

Range-diff against v6:
1:  cd3de0743a =3D 1:  55fa4d0d11 git: add `--super-prefix` to usage string
2:  9b8461010e ! 2:  b9cf47afe8 config: add new way to pass config via `--c=
onfig-env`
    @@ config.c: void git_config_push_parameter(const char *text)
     +
     +	env_name =3D strrchr(spec, '=3D');
     +	if (!env_name)
    -+		die("invalid config format: %s", spec);
    ++		die(_("invalid config format: %s"), spec);
     +	env_name++;
    ++	if (!*env_name)
    ++		die(_("missing value for --config-env"));
     +
     +	env_value =3D getenv(env_name);
     +	if (!env_value)
    -+		die("config variable missing for '%s'", env_name);
    ++		die(_("missing environment variable '%s' for configuration '%.*s'"),
    ++		    env_name, (int)(env_name - spec - 1), spec);
     +
     +	strbuf_add(&buf, spec, env_name - spec);
     +	strbuf_addstr(&buf, env_value);
    @@ t/t1300-config.sh: test_expect_success 'detect bogus GIT_CONFIG_PARA=
METERS' '
     +test_expect_success 'git --config-env fails with invalid parameters' '
     +	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>=
error &&
     +	test_i18ngrep "invalid config format" error &&
    ++	test_must_fail git --config-env=3Dfoo.flag=3D config --bool foo.flag=
 2>error &&
    ++	test_i18ngrep "missing value for --config-env" error &&
     +	test_must_fail git --config-env=3Dfoo.flag=3DNONEXISTENT config --bo=
ol foo.flag 2>error &&
    -+	test_i18ngrep "config variable missing" error
    ++	test_i18ngrep "missing environment variable ${SQ}NONEXISTENT${SQ} fo=
r configuration ${SQ}foo.flag${SQ}" error
     +'
     +
     +test_expect_success 'git -c and --config-env work together' '
3:  9d4c8d7be9 =3D 3:  1b47f0db98 quote: make sq_dequote_step() a public fu=
nction
4:  0a9b085fe5 =3D 4:  b9565a050e config: extract function to parse config =
pairs
5:  b96686c9cd ! 5:  8f998ac81a config: store "git -c" variables using more=
 robust format
    @@
      ## Metadata ##
    -Author: Jeff King <peff@peff.net>
    +Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
         config: store "git -c" variables using more robust format
    @@ config.c: void git_config_push_parameter(const char *text)
     =20
      	env_name =3D strrchr(spec, '=3D');
      	if (!env_name)
    - 		die("invalid config format: %s", spec);
    + 		die(_("invalid config format: %s"), spec);
     +	key =3D xmemdupz(spec, env_name - spec);
      	env_name++;
    -=20
    - 	env_value =3D getenv(env_name);
    - 	if (!env_value)
    - 		die("config variable missing for '%s'", env_name);
    + 	if (!*env_name)
    + 		die(_("missing value for --config-env"));
    +@@ config.c: void git_config_push_env(const char *spec)
    + 		die(_("missing environment variable '%s' for configuration '%.*s'"),
    + 		    env_name, (int)(env_name - spec - 1), spec);
     =20
     -	strbuf_add(&buf, spec, env_name - spec);
     -	strbuf_addstr(&buf, env_value);
6:  6597700ffb =3D 6:  e7b073c9dc config: parse more robust format in GIT_C=
ONFIG_PARAMETERS
7:  cade8fb12f =3D 7:  6c1800a18f environment: make `getenv_safe()` a publi=
c function
8:  4e3f208d13 =3D 8:  ac9e778704 config: allow specifying config entries v=
ia envvar pairs
--=20
2.30.0


--ycCPYNrFQTor/cLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8DhcACgkQVbJhu7ck
PpQtVg//dtxqBP1F1Knt9wNIwEqq6ca7RJx/Wo5DGIDbLnxMXI1gmheQ5hp0XqP1
iWWrYS6MzzVz4apc8hP2na75jhL2SK2MOiU68ggzo2pd6DtNZcjhGCU+8RJlGM3a
yV1w/qZSpcOoJ4KUz3kpoD+n/JwdGYykB0d+dOmXHv9J9JvaEuspGMqq2ojh2oaf
I4lSaqR9SESg68qY/OhcazaGcM29mXsMZAHogYDyXN7YE/z2yt55oXTCXGlXRDTs
2OemJeegwQf1vxxTR+/Az/ftshGNpKt1zRIAD0edtMCHw/SeoQ3uGI98e8MGZxmO
8mGZDm1mgwiRjQQSoOf/J/zsRqmbPVHLZGbBiDqUl95ev3YzoEuVmsZ+JvLMJ6j2
Ucq7EUAraLIkFzWcaXooKI+GNzrQ6Akb133EwTqNENYw8o3xOxRixBaY8kdeOXnk
cu14CP7NEL+AYP0dKsQO0jkK/utCQU4ye0VyazMNMtfOLx3o39kev6ApwcTMZ2g9
Ib21iMS3Fxro2YVOFJpEX7G8aNmckDl/s7q8xijwqdqmphrIbyJb6spO4bIzJ7A0
MDJQF9GhU18WRkhBdb+B/aO2W9Eugx+8J6ug/pMk8CgVek5MGNEbrQ2/7A/Q5bIs
gMYFbuoz/uKZSOuoBnFV5i03Au5L2sBnc2a1raD+sviE0vxTrE4=
=p7GD
-----END PGP SIGNATURE-----

--ycCPYNrFQTor/cLx--
