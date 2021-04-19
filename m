Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FC1C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4618D611F0
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhDSMbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:31:44 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:57329 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239146AbhDSMbn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 08:31:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8AC13D05;
        Mon, 19 Apr 2021 08:31:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 08:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=pKU/oS/LtxqWUQdVFa1RKxfLWJy
        AHGxcfJGxy8H0U7g=; b=SZnwihL7YVu2REj/pplPg4JQ+UANWidQowI/MkjSmbh
        3JK83w2p0b+5nkYU6r70bLvsnIJJnE7HzJVOya/qBPDqJI+tzvfTAOcYXzhVgnpa
        IsLg7W+nIMgDYzBafxxTzHe7BmOK4qhAUsOP72knQjrNM+c286lEww3MDk+u/eCZ
        F5A8JOIv042CCXS2QAfd0xvlZpXbgg2U/qsLwuc7kuVhZH2IFBFcwjHcWGjlSyHJ
        6htkMFVbmZuEo8KBZoRHF7FBjMCCHxrhZiVKbuSp1vaHNkr4qqaARb9QbdRJuLfC
        Xc7nICHq3GCOXn54XWVaKNCYc2mDaGF2/yjqKkbYSSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pKU/oS
        /LtxqWUQdVFa1RKxfLWJyAHGxcfJGxy8H0U7g=; b=eF+pgaQ+clRolk6qebdXNU
        5M1RE+2E6u58MlhRSu9ETRAs5TAIiTlATCTXUTl3fJ4A6x1fDQXxYdXyQhfmNtCv
        N5eVpn7RoITJYj3iPGpmKPusvwg5NFXUVigeXPBcO1ikzBS69wwQwP1XOM1qFBGY
        VRzPbO5WaP47xRWXh4le1iKJVDvt8LQT7YNfP+EOP/+xv0Hf1LLLQ5+Cp9i3JTAU
        aTOIEcq8uaTGgE43Ru2xXpxM7G8LMn5zQa9CVfUpGAI+aisTDUVhwrVQoSnzpeWk
        1rkjwvJQVEhgT6mrFTkpNYtacU+nSpevjDjgg2+5CepXRgETDOy9n8ic9UB7VgpQ
        ==
X-ME-Sender: <xms:D3h9YCS09jb3jwaMHyJopAHeQ37JkqUXyJJ0CCO8vu648dQSBxf-Dg>
    <xme:D3h9YHwnCZ5VEfDGH9tY-fljI9NTQ7W7u1XqvUD26k-KgMaCme61tK-n-lOPeA2di
    -kti4Jwy7u6MN6e_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:D3h9YP2PD2nyp7wbvWzCif4WafdLSvn6Jk9cfqbpWNqC0Slr5SGOPQ>
    <xmx:D3h9YOAIHR9XGEbtp4MQ-_j-JY34ua-XZ7kn0EqYN0BEUxgc8qw3yQ>
    <xmx:D3h9YLjLGQDRsEZGromnwmm9VHmxLKdNEii2dcVgHFiHqsbEzOpjbw>
    <xmx:EHh9YIvaWWkC4A8QH3AE0Uoh8RnfA3RscZcThsRmrszKmvkFtiYt7g>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id BDD5A240054;
        Mon, 19 Apr 2021 08:31:10 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c6cf9b63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 12:31:05 +0000 (UTC)
Date:   Mon, 19 Apr 2021 14:31:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 0/3] config: allow overriding global/system config
Message-ID: <cover.1618835148.git.ps@pks.im>
References: <cover.1618297711.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r4xmO7uv9PN2oEIh"
Content-Disposition: inline
In-Reply-To: <cover.1618297711.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--r4xmO7uv9PN2oEIh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fifth version of my patch series to provide a way of
overriding the global system configuration.

Changes to v4:

    - Readded the call to `git_config_system()`, which I've previously
      dropped by accident. I didn't move it into the new
      `git_system_config()` function as it would change semantics of
      `git config --system`.

    - Added a testcase which verifies that GIT_CONFIG_NOSYSTEM and
      GIT_CONFIG_SYSTEM properly interact with each other: if
      GIT_CONFIG_NOSYSTEM is set, no system-level configuration shall be
      read. This is different than the tests for `git config --system`
      which used to and still does ignore GIT_CONFIG_NOSYSTEM.

    - Small fixups for another testcase to drop needless redirects and
      the `sane_unset` of GIT_CONFIG_NOSYSTEM.

Patrick


Patrick Steinhardt (3):
  config: rename `git_etc_config()`
  config: unify code paths to get global config paths
  config: allow overriding of global and system configuration

 Documentation/git-config.txt |  5 +++
 Documentation/git.txt        | 10 +++++
 builtin/config.c             |  6 +--
 config.c                     | 41 ++++++++++++-----
 config.h                     |  4 +-
 t/t1300-config.sh            | 86 ++++++++++++++++++++++++++++++++++++
 6 files changed, 136 insertions(+), 16 deletions(-)

Range-diff against v4:
1:  34bdbc27d6 ! 1:  1e8899408a config: rename `git_etc_config()`
    @@ config.c: static int do_git_config_sequence(const struct config_opti=
ons *opts,
     -						  ACCESS_EACCES_OK : 0))
     -		ret +=3D git_config_from_file(fn, git_etc_gitconfig(),
     -					    data);
    -+	if (system_config && !access_or_die(system_config, R_OK,
    -+					    opts->system_gently ?
    -+					    ACCESS_EACCES_OK : 0))
    ++	if (git_config_system() && system_config &&
    ++	    !access_or_die(system_config, R_OK,
    ++			   opts->system_gently ? ACCESS_EACCES_OK : 0))
     +		ret +=3D git_config_from_file(fn, system_config, data);
     =20
      	current_parsing_scope =3D CONFIG_SCOPE_GLOBAL;
2:  30f18679bd =3D 2:  39468f45d2 config: unify code paths to get global co=
nfig paths
3:  d27efc0aa8 ! 3:  7e7506217e config: allow overriding of global and syst=
em configuration
    @@ t/t1300-config.sh: test_expect_success '--show-scope with --show-ori=
gin' '
     +'
     +
     +test_expect_success 'override global and system config with missing f=
ile' '
    -+	sane_unset GIT_CONFIG_NOSYSTEM &&
    -+	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYS=
TEM=3D/dev/null git config --global --list >actual &&
    -+	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=
=3Ddoes-not-exist git config --system --list >actual &&
    ++	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYS=
TEM=3D/dev/null git config --global --list &&
    ++	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=
=3Ddoes-not-exist git config --system --list &&
     +	GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=3Ddoes-not-exis=
t git version
     +'
     +
    ++test_expect_success 'system override has no effect with GIT_CONFIG_NO=
SYSTEM' '
    ++	# `git config --system` has different semantics compared to other
    ++	# commands as it ignores GIT_CONFIG_NOSYSTEM. We thus test whether t=
he
    ++	# variable has an effect via a different proxy.
    ++	cat >alias-config <<-EOF &&
    ++	[alias]
    ++		hello-world =3D !echo "hello world"
    ++	EOF
    ++	test_must_fail env GIT_CONFIG_NOSYSTEM=3Dtrue GIT_CONFIG_SYSTEM=3Dal=
ias-config \
    ++		git hello-world &&
    ++	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3Dalias-config \
    ++		git hello-world >actual &&
    ++	echo "hello world" >expect &&
    ++	test_cmp expect actual
    ++'
    ++
     +test_expect_success 'write to overridden global and system config' '
     +	cat >expect <<EOF &&
     +[config]
--=20
2.31.1


--r4xmO7uv9PN2oEIh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9eAcACgkQVbJhu7ck
PpSrpA//fdapdKvr8FnhCACdpYXiB3PuFI9pmsuueXJr0gbMNC1lhY1Hqhk2U4+/
zlDcidCqmga6WCO3905gVuSOQ27iJzkEYKv+ZwbaIsyFU/Sc8BPhaMQB/DJB3FSf
jbJBUfvBXX+EZchhjdHGPt+GT9u8oRWWX55q87ZkTB9kL+8vaPyyCoBWDNerW7t1
AU5S9rlOGt+++8fHBQqr9dt7UBcpKy3VFeL7Lw4EiGu9tT6/p0nd5IlO8kT6OPVx
YJskK6qJQMxpfZftKy1RE2GCj6U7E8/oXecZJ37R/h6TtNX6YZ8I0NuAAPzVTdIv
/U0fPhT4mIPJt7eaoAFVBcsCM6QiOaSWuoTaVxh+9UdPfHAJVhdemgQwPgkEFCBb
g4nUdw9RNpHnQn8mO5yhZTU9/5b82JuSZE5NKbuRvpA3jAO3Pt6Q94/y0SPVF5om
Ipe7zKxXgs8CD6FtTl8k5urpFXt8h6QqrElnwc2gnQwzqPc+CCZcj9At/pZK6IeF
NgPzdOrEBIUWRMgNdlmaqvfWN0hfXn2k6Nd5ZM/6MehHiKDb538eG1553VSoZtn6
6CgG/jZmTomIz4QJpYH1pfqc3U8/mNuezEHyI1SmxGs17oNd0A2P6Tm+Up6vzSlx
wPnz33fBvnKGgdfKKNbUMYH5FP+BIVfCfiK1nPnRh0y7bRBDtrs=
=8R9B
-----END PGP SIGNATURE-----

--r4xmO7uv9PN2oEIh--
