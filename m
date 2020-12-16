Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C67CC2BBCD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E848F23357
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgLPH6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:58:09 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41297 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgLPH6J (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:58:09 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E2AB5C010C;
        Wed, 16 Dec 2020 02:57:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 16 Dec 2020 02:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=sFcvO5DAwuuNPMGf+HZb7wNbRmW
        2t6VdsxgI0w+oOIw=; b=PA56ouJ0+MpiSIKMfuCUMGl3vC1vhRnOTToOu6kRJaz
        IcScT7mAHEcJam3QkirqFEcyyF/C4zK8YJIO6/SJX9ocm1Goe7T4SB5wElDxktkL
        lqOdM6Ef07tjsQNaO7YE3LeNdfDULjAUjg68vsbRJvPAPK7bppxfITyl32Zn134c
        Ho5W5krWb7527eat621m3z3b790IE9le+/FLaURunW1yUyruqpZauxm9SfCG05D0
        ri4eEhPN/aIhgPp2UQbT6ur9GNrfAyKoXgJqg630L+qQ4P3e0etD/LpqDqd21d+F
        Y8G9F6KLcSUkfeXsuKYyXB9xcCOCmeUsPiWfVRTrxPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sFcvO5
        DAwuuNPMGf+HZb7wNbRmW2t6VdsxgI0w+oOIw=; b=K5mo+u9bQTY8tL0u3xik1Q
        jQwVaiW0chEH5SyEzuCE643gyiC0FuuHAVeQ0DDtqfvl3c0izOz67GXd1vN0sgY7
        ORGNyqzkpskRA18BPEl8utX3vlRq9MPwkauj9rQvvbvdCJmI4S6SDTdHpm1Xn+jp
        VT9KYzIpI8SKNweHwjldQvHYYjpanuriDY8BqfJtZgYVV1PdbLeWu1Awpw3lMz5u
        PQoLNNwbhyg6zDjmXs4cgUE3lnd7Ac8vdr6RE+k6uHakjhpA85BSbYWwliJwqAwQ
        islaevSb1vA8MSKbRllYXqpmUc7CFubip/Rt0C3as5fBQXhA+b5HRdsor1TtP8Dw
        ==
X-ME-Sender: <xms:zb3ZXzw6VI2mE0ttH4tK4cJI_g57xO2VZ4CLGG6HPbtlpzEBJdd4gA>
    <xme:zb3ZX7TPdNgN2ZFffHU5kkDiVjSLMWMPEjDP4pUm89HV5PJwW0ahQAEt2QKstE9we
    EThyZMJZe0IfgHRBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zb3ZX9V_qKVkT-txWjpGB33HR-pUYehxJF42g9EmlpHcrrTsc_NPtg>
    <xmx:zb3ZX9g3176kbHiUW8krTzn3gQhDoL-uxg3vHmGv4aAr5Ag3ZjWwGA>
    <xmx:zb3ZX1CbMqXjHzzhnQGlRJ772dH3_PrlJVt5YWNcj5nYUIVTh4OAVA>
    <xmx:zr3ZX0ON4hz-0iqPGFY2-v96m1BD_0XVcDTCy7Ociy3S1qArS7Tc0A>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 73EC024005A;
        Wed, 16 Dec 2020 02:57:00 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3832cef5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:57:00 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:56:58 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 5/8] config: store "git -c" variables using more robust
 format
Message-ID: <ff96e59e7902419dfb76ab812bc2d6bf493109b3.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qynT46A4PeO0CxvE"
Content-Disposition: inline
In-Reply-To: <cover.1608104755.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qynT46A4PeO0CxvE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Jeff King <peff@peff.net>

The previous commit added a new format for $GIT_CONFIG_PARAMETERS which
is able to robustly handle subsections with "=3D" in them. Let's start
writing the new format. Unfortunately, this does much less than you'd
hope, because "git -c" itself has the same ambiguity problem! But it's
still worth doing:

  - we've now pushed the problem from the inter-process communication
    into the "-c" command-line parser. This would free us up to later
    add an unambiguous format there (e.g., separate arguments like "git
    --config key value", etc).

  - for --config-env, the parser already disallows "=3D" in the
    environment variable name. So:

      git --config-env section.with=3Dequals.key=3DENVVAR

    will robustly set section.with=3Dequals.key to the contents of
    $ENVVAR.

The new test shows the improvement for --config-env.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c          | 52 ++++++++++++++++++++++++++++++++++++++++-------
 t/t1300-config.sh |  8 ++++++++
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 151980e5c9..53ed048689 100644
--- a/config.c
+++ b/config.c
@@ -332,7 +332,7 @@ int git_config_include(const char *var, const char *val=
ue, void *data)
 	return ret;
 }
=20
-void git_config_push_parameter(const char *text)
+static void git_config_push_split_parameter(const char *key, const char *v=
alue)
 {
 	struct strbuf env =3D STRBUF_INIT;
 	const char *old =3D getenv(CONFIG_DATA_ENVIRONMENT);
@@ -340,30 +340,68 @@ void git_config_push_parameter(const char *text)
 		strbuf_addstr(&env, old);
 		strbuf_addch(&env, ' ');
 	}
-	sq_quote_buf(&env, text);
+	sq_quote_buf(&env, key);
+	strbuf_addch(&env, '=3D');
+	if (value)
+		sq_quote_buf(&env, value);
 	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
 	strbuf_release(&env);
 }
=20
+void git_config_push_parameter(const char *text)
+{
+	const char *value;
+
+	/*
+	 * When we see:
+	 *
+	 *   section.subsection=3Dwith=3Dequals.key=3Dvalue
+	 *
+	 * we cannot tell if it means:
+	 *
+	 *   [section "subsection=3Dwith=3Dequals"]
+	 *   key =3D value
+	 *
+	 * or:
+	 *
+	 *   [section]
+	 *   subsection =3D with=3Dequals.key=3Dvalue
+	 *
+	 * We parse left-to-right for the first "=3D", meaning we'll prefer to
+	 * keep the value intact over the subsection. This is historical, but
+	 * also sensible since values are more likely to contain odd or
+	 * untrusted input than a section name.
+	 *
+	 * A missing equals is explicitly allowed (as a bool-only entry).
+	 */
+	value =3D strchr(text, '=3D');
+	if (value) {
+		char *key =3D xmemdupz(text, value - text);
+		git_config_push_split_parameter(key, value + 1);
+		free(key);
+	} else {
+		git_config_push_split_parameter(text, NULL);
+	}
+}
+
 void git_config_push_env(const char *spec)
 {
-	struct strbuf buf =3D STRBUF_INIT;
+	char *key;
 	const char *env_name;
 	const char *env_value;
=20
 	env_name =3D strrchr(spec, '=3D');
 	if (!env_name)
 		die("invalid config format: %s", spec);
+	key =3D xmemdupz(spec, env_name - spec);
 	env_name++;
=20
 	env_value =3D getenv(env_name);
 	if (!env_value)
 		die("config variable missing for '%s'", env_name);
=20
-	strbuf_add(&buf, spec, env_name - spec);
-	strbuf_addstr(&buf, env_value);
-	git_config_push_parameter(buf.buf);
-	strbuf_release(&buf);
+	git_config_push_split_parameter(key, env_value);
+	free(key);
 }
=20
 static inline int iskeychar(int c)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 46a94814d5..36a60879f6 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1361,6 +1361,14 @@ test_expect_success 'git -c and --config-env overrid=
e each other' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--config-env handles keys with equals' '
+	echo value=3Dwith=3Dequals >expect &&
+	ENVVAR=3Dvalue=3Dwith=3Dequals git \
+		--config-env=3Dsection.subsection=3Dwith=3Dequals.key=3DENVVAR \
+		config section.subsection=3Dwith=3Dequals.key >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
--=20
2.29.2


--qynT46A4PeO0CxvE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ZvcoACgkQVbJhu7ck
PpQehBAAiyA9ykU86rCcVcuoklbO4ezZfA/Xr5DMwMBSLY+/No+f+xLKIj0ziwzd
R8CzAZxYHHum+UOPAlLZEdIpW76lQS/9+jP0zE/pQrFvadfuPAbth/fhGYrpxV5G
PCyxifMAtuVBbn/3dELbVpfCH9+nJZaV/BPwm88c/+/JI/eajZVHq80yYxjUF0Cd
1/Vd+1RsiNxV9lpOc3lHSNERGG6qn9FYocw0yxUzlgnMiMcfQ+BAoLGPvJT/6ggI
PYeL89xqwAXYdXE7B1MuS1u9fhGIWVBwsUlOVzk8cnwTkKnVUECp6e0aLTvSj8lk
wlCCJPRuLhmOlNkoYsGb/GaFMx4rJdrxPyiU79L6528ZukCrxOKmRpKyC9C6AKBs
Lx9zkd0RKIzgqX9zdqvXW1oDAu1GtKs0wcxsBb1rQExWv54MTn6cynYbaULxpnRV
WfC6zEtFUwLxxCBnIM97JEDE/q5k6zQxOimvgeyiAm+NJJG5d+qPBRduQW1EkFgP
4gO39GkAAoDt2rvgE1ebIjYnkdql/YFOmrmztB59EjLBcKMcPb51hB6qcSFdELMF
qEkgJ4JQMCkmSZNp6RkBCaJdgN40rNwJSlwdqGmJ6IT90jtR8XqgV+tSlihqYw31
rME4VvhV/xjf1rpehYOvd0aHj3CDC4OhmEPoQYw1AbDMOZwEZU4=
=Y7XA
-----END PGP SIGNATURE-----

--qynT46A4PeO0CxvE--
