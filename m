Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7228C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1F42310A
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbhALM2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:28:42 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54727 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729397AbhALM2l (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AB9871B60;
        Tue, 12 Jan 2021 07:27:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=YB4u0NXLw90lWxeelLCT8WpXruF
        WLhCxnbNPe5goKYc=; b=Q2edbXG0+KJZwsIKqZqZeEuTDG3HV/hDjex389AHdZC
        cnDMbD5ZR5woAlMXgAJYCbt6h8F6+rVY0MVfI35US7VBpaP27IjCbSQy+F0Rgesj
        p0wSTMzMmPRuEZivI8fRQg2+Grp/KsUbzHaVbt7QkdmcZ/4uLSn9td7PE1fWb875
        aqkCGoAbmL2mxe+iV5EsgCU9h2V0Jj875OA8Poy3iwImPW+329oMRheBzRnadOeK
        p1vvclDcNnnmIolINzm3GXkQ1sDkXxWvieLBRxsKrmN8nJ3fNCmNJ0WBVOarrOQ+
        sC9SO9aqy+kl6R2aF8eNVLOmbgzARsrU7quCI3YKfQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YB4u0N
        XLw90lWxeelLCT8WpXruFWLhCxnbNPe5goKYc=; b=TPVFer6iHRCya9fwVlMIiG
        YYLRwHSjCUj7puVxFyZ29haDCs3DrhWSldj1QT/MQJ/he0MkNSf2A88uS4OJ6rET
        jEd7mZtu8oANyUXhKL7jEU71LJHuPeApKmqm5Gv8tKyLG2YEadR07ZEx/L2xZJUk
        kCiimmExLAowsVCf6d3IEkPQqPf9yx+fuXmACb4n8TATU1iMgqTuRXQpnrVGmY3h
        ZfEuyKFHi1ueCOLZ7tCwtQo+7WBVXAqla9/MYoHNMXItfPaP/MmB06RO45Ra1v/M
        PiooWYlpTwmVBGuE4SmZJZvvKp1bEZle2WpkdGxezJ1jqvbjOeZBc8Yn8xlr810Q
        ==
X-ME-Sender: <xms:mZX9XxPGMBcwcjEGaWyd1I-sz_SkST4EiV-SpjOzeo5iw7R6kwj6Cg>
    <xme:mZX9Xz-EMw2bI1W8maKm6tvJFuhu_xsmQqiBQxsvg44r8JLqrDY-ygRYdoWhNpH4v
    CLORZ8ZR4WrX-qpXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:mZX9XwRBNGu5I4pfbpsA_cegYjqxa5e7-1qbjrkEGoWMC5rZrcWMJw>
    <xmx:mZX9X9uyPEQwbQIlttDEtxXRT9ZicYoQHdi0JJ35idUrZW4qChWdCA>
    <xmx:mZX9X5etsJ7U5foay0lQV_WZuuEbOaH0kPJmbKNWMDqW5BAR0SgBNA>
    <xmx:mZX9Xw4htupnNm3RVwtRn2V86HsrjuVClNynSfXeWZWdBcPWwToUZg>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46FAF1080063;
        Tue, 12 Jan 2021 07:27:04 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b717d6d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:03 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 5/8] config: store "git -c" variables using more robust
 format
Message-ID: <36c2a51b13e463a4aa8e5316447336927153d99d.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rbs5wy9C3JjrcSw2"
Content-Disposition: inline
In-Reply-To: <cover.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rbs5wy9C3JjrcSw2
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
index b7a8129f6c..7f7da60574 100644
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
 		die(_("missing environment variable name for configuration '%.*s'"),
@@ -364,10 +404,8 @@ void git_config_push_env(const char *spec)
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
index 853f2509c5..25437324c1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1364,6 +1364,14 @@ test_expect_success 'git -c and --config-env overrid=
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


--rbs5wy9C3JjrcSw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lZUACgkQVbJhu7ck
PpSnRA//SadjwEbE0nUxBtSa3f21hlA7cBLqVI952jo5yA7/o4ajlwaIni9JebH6
tGCJY+7JNglFi3PvAspth6A0mKeAt3K2BRDKixRHyoz5+nx3DUmPKp8g4Ruenudc
Q+KfBGReAaWI1FobfVx3OzqMlfI6dxusxbKiLgZDsatRPmJ3oNl8enquOIh2AY2N
3uX3vBvDtgYhGbp/+efABW3cjuh/Bt9LJqxl993l48QGWK6HEVCQkXfkbHxwZmMd
tU0o69dT7kyj/vDoZxIQ2/KZfeFK69AKQF6gU1daIVFEo8m+f8hco+c8c8X7ZKRX
TafXbjZPsy3vfhK5RCxEZNdjDQbSPPtJOlQ+zx2uLQ5vbnu+bMiznKso7rmU8VdM
gZyNdtUdJ3Uj2UQxkJDgtUEySzShEbLVfAEZjia1Dp4JjwpDF/VTg4ts5speYUMI
QKD6ETDOD8qtuoT8GRZuvXmeUTrz8qzdmIZmJ1AMbEIIHEOePHkeDIJ272bvrWoQ
cnxykC2ZBQbuE4KnNNdEBN+l3vEGDCSphQ8vQpYhu+4mqp2/gn/g8oX6bFgMeJUI
IoEwE575i+TBGob/QWSB0Oc6oQFPBk0W4G0DOf08jKDtbxy6GiNqFQLAjTVtnGmb
X38cuC6glPiTaYnQF3Z6sl6eAo5DKBSjWpQMv/HXl6tOitoUfAs=
=eUMt
-----END PGP SIGNATURE-----

--rbs5wy9C3JjrcSw2--
