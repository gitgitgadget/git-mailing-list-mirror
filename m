Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF87C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1A322581
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbhAKIi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:38:27 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55983 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728045AbhAKIi1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:38:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3C1E42520;
        Mon, 11 Jan 2021 03:37:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Jan 2021 03:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=2hk89cnWlfsZOdy+1kLd0vRcI+V
        BFsuBTK+aV5sXsrk=; b=oWXiaibjc5FX1eRl4cxj1PzJ/z0hIJB2pTkHdBmv+iM
        DsFjUqT8yZ9fH73VYdyQYaGPuj2vPGGj6nxfIIgxTXDuSIOShYcDXuRDYYO3FZ4D
        GJhsiQua/kY3vhkH+y//Y8uL7m6itl1OU5RrazbydcZOh77Q5sExRCkQykT2lj+a
        DL5ox9CHR8EpdZdWwiENTCXwwC0jvVG39gd4qhLoBVeO1j+8dQEE3cwZMNBNS17P
        TnH5SbS+8Kv6CAMS2TbaPn1H7yRJi7oCUAlVHBiOK8ClK/i680tU334hRX/1pEdd
        fKGy9KqIa8c7hwsyi192iS24sBYW+W324n7PFVD1O+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2hk89c
        nWlfsZOdy+1kLd0vRcI+VBFsuBTK+aV5sXsrk=; b=ApFlUyr+xxVrM5Fk8DeFfB
        da6YeBUIASG/ceFTBCY6cphCTJtl8efSNufF/tB8dB8HifL9Rxtgv2RBjnRNsuXP
        Y8b9g9cIvCeL2g4iUrhQK/Ty88Jp0JXw+CC/TOuQD45g+VVeuvPbqV5oVi2NWS8U
        jnasSMtnP8Q91x8X6rVlmf3ltvlprSyF0+E2uWy63PBdZ3+1CDLLtfeGj/X8Xe/x
        ApBDZXkGJ2JpwbehFb15qz9tGCuUwhw/sxFXMIVAGTsNGGhuHd6lSsjwwM2JTNOQ
        e4pS1FO3fS8geDN4NIs+Cw1vUvf1zxM7GWj6A3+6eA6SzafLMaGx2q01Ze6nFD9g
        ==
X-ME-Sender: <xms:MQ78X-LFfLVk_d7tQzBtMAtDS5IU-KJf-iTlMTSkfm4NuG_uKVlbRA>
    <xme:MQ78X2HOtjAe2w2EAnvIL7uYL42O6jarg38DDA5HvL-9H-VKNO8eWHv-PmyzYL9FN
    oSlgku3QcHgW8Eupw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MQ78X7n60fvUrfdgZ3M0vMs_j1eZ5KrNXfEHcptGW_zIbAUAITsuBw>
    <xmx:MQ78X7Lj4DHxY02uR2J8noRf6xsKgGFqdYupAcrlQTxX8dEmSANb-A>
    <xmx:MQ78X0boaZzjB5ZkfkaHbL52RJceuTv2X4I3k534rQkFHJgccp1msw>
    <xmx:MQ78X3eBmcpORk_DIzIx5XE6gscnQXDF_GoUpbwoCxAbN2mYeR2Pdg>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 98699240062;
        Mon, 11 Jan 2021 03:37:04 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8dbd6612 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:37:04 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:37:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v7 5/8] config: store "git -c" variables using more robust
 format
Message-ID: <8f998ac81a53a85b16029eed0fdf07f05d1e47f6.1610353895.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610353895.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8pAoY/Vnl3G1m0Tz"
Content-Disposition: inline
In-Reply-To: <cover.1610353895.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8pAoY/Vnl3G1m0Tz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
index aeffe4f4bc..b5475c28aa 100644
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
@@ -340,20 +340,60 @@ void git_config_push_parameter(const char *text)
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
 		die(_("invalid config format: %s"), spec);
+	key =3D xmemdupz(spec, env_name - spec);
 	env_name++;
 	if (!*env_name)
 		die(_("missing value for --config-env"));
@@ -363,10 +403,8 @@ void git_config_push_env(const char *spec)
 		die(_("missing environment variable '%s' for configuration '%.*s'"),
 		    env_name, (int)(env_name - spec - 1), spec);
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
index 1e23eb8213..24919d5445 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1363,6 +1363,14 @@ test_expect_success 'git -c and --config-env overrid=
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
2.30.0


--8pAoY/Vnl3G1m0Tz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8Di4ACgkQVbJhu7ck
PpRfgA/7BMKO1DxOkYfqOPlBSya5YXk6z/jnMm6xwz+rkoI+9KAI+2Kwvj7YZ0jt
KQrBlSA9YfuFUYvGKaDMgASP6p/x7g43Bx4NFPujAoff/2jCPly+pb29T1txM8uc
Gu340U3RRmhPz0MwCU7wFT83WhDQJOGGuDT1838Q2zGgEl1QIcul9dsTD4q7jSsA
UsdmtbW5kBRJjlwEvDyWCmh3kZ9EfC5avD0gzMWCRWeVt0LyxNLGSsflxsqtpWYd
Vx5GjdPkeHQ6N650n6vMzZ4cgY6EOSaWxB+xxAmvOQXd76MBLAB2j8l4qpFwCTkW
D2pKP57HoD+Iiq4k1T5nSFyASeWxFIqBMPKFR6nwMQqi4EW7GDE+dBAhpfh5bnUN
ODAl8del8mM5lN9JDhc1gya5EViJvI82ZL4fvkLyj9EPl/g0wJWbHh21/JguFeyA
FGRsPA/btp16ZNYx+qNdjrzyvlIcAeDrKoo74Il4QUTmin+2qDzWn2J42fwV2BqH
ZPEshAPO07YhiOnUlK1V1tLolrG/71+P9ro+DGQ9w5pAyfd1qF687gmDHtniJK7g
y9/XyLoBsycRUdAJlBSJPP79zUeSFa4d/dqj+LfrtSqSpnK4ldqy613l1Kd/ei7n
Xz6VrEFgrK5uj0pahuayRrOoPh9GbuT2RNxMW21P792XQQqhpsI=
=E7rD
-----END PGP SIGNATURE-----

--8pAoY/Vnl3G1m0Tz--
