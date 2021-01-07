Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0C9C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9540C22E00
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbhAGGif (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:38:35 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59889 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbhAGGif (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 01:38:35 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 30BFE5C016D;
        Thu,  7 Jan 2021 01:37:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 01:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+4Zzw0UC/dA6L9NOf7gcYXgDKls
        7InH65dKhn3xqsKA=; b=t0POToXRKz4syf4GLx5D0EUKxt++Jb4I1URTFC02rTR
        x07E+O9mFenKhXbkNoLLpPokqSoF//7wDyMQDrVymRTt+2473+XeqhCdNUGQf7VZ
        BfopIbbC90qm6d4rEwLAWWdyqlbIs36aVrxqkt2lCScaDgEu6oTCwlIdzgfl0DBW
        oH6b8FZHRbofrIvdJnD8jetyrTKZ5ELCP4YkKGPmGS3yxvzv1A044zpMWGpAAJt/
        m+4lVdDJ2B/BVj3hKTe/KXyYTj2jlOkupJQP1H8w7Y2mXTWWbAzxc0+cOAnzEphZ
        lrQMekZOYy+O3hu7oPa1IK/JBKua96eQh6SnawZnZnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+4Zzw0
        UC/dA6L9NOf7gcYXgDKls7InH65dKhn3xqsKA=; b=L8zLn4YmkHn10N0BVGi6Gk
        kd1XDxB4IY/z9npTGoNdHrqQBfIdPUI7s4Q0xV/9woepNEIPtp3zc934WZhy3mHV
        dHRf4M1+B8xQCfKq0OeKwkI/POUncpDPdUiGIYhsHIIzEn/YCAO/6blgicI9q61+
        tuFS6oZKHNxH30uJ3yNOsu16QOOmcEl9KMG4EqqFm2DwLmyyzHwr9B6qWu+jazgX
        nIsGRQzA6+gLcJiThkCcYily4U/gzvQDFvF8rdXTGCQkQcsmmRjMAztpFU6+iWlR
        fe74F1G+PqDNCNk0gzdtESqGqZRTP162pPTJa3MHz0f7dN45o7S9vtMravU0BcqA
        ==
X-ME-Sender: <xms:FKz2X4MkFoj-3z893tNyLlu4et7PKicfyX3LF5tfsdHsNavUsc45xg>
    <xme:FKz2X-9Z9WCUdyk75TrGTsFw7YvRr7s3eTNFh9B-syFEiXmYMKAO7nbiU7qCPu3Ss
    5iuK2lY-L6bEz1oYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrfeegrddvfedvnecuvehluhhsthgvrhfuihiivgepgeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FKz2X_Rc-NgId_yadKRPxknBbJhNMNDX0sJrEYlmmZlW9IeKBRf1tg>
    <xmx:FKz2Xws4FhOsvmUs2bjMVolHUwi6BocW_UgQ1VkBQYyrKkvUeVsrNA>
    <xmx:FKz2XweDN4cTtdx8Fq-0Qa5DqD0N1URoeyF8jyO4ABKLaOop9C5zmw>
    <xmx:FKz2X47ytNLC4vb5uCbiNCWEU0HWYFd-48JjYvTO3gTOhB1vQI7XnQ>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E8CE24005E;
        Thu,  7 Jan 2021 01:37:07 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a2280c3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Jan 2021 06:37:06 +0000 (UTC)
Date:   Thu, 7 Jan 2021 07:37:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 5/8] config: store "git -c" variables using more robust
 format
Message-ID: <b96686c9cdaba5b07c0712a6eeb79a2c6bf00857.1610001187.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N4vDheUCnki5SCRE"
Content-Disposition: inline
In-Reply-To: <cover.1610001187.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--N4vDheUCnki5SCRE
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
2.30.0


--N4vDheUCnki5SCRE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/2rBAACgkQVbJhu7ck
PpR9PhAAorlWKnwBslBvIrkudTQ47f79FO44W3Zzeqq6VGP4vQW6No/JKSae86b6
pA4J+pfhBXpGHUvH9nX1btMBzm+oDWmQhXMK35RpJmf0VVij0HgOO6UZJyEkHJkw
LbDRPo+SNVyXFT1GFqe2OQCycBTrLY6CIeBduq3It5mGt2xy9OsvBa96s40apttn
qHIPXrkHb/RnPmroG4t/Kgjs7N13BEcwM4NiIw8gWVuefcZEvmLzJ52D6EqCqRCJ
i2K81jqntJ4OhR5suO/6abSKWdcRECetcS8d3gkmCM2EnvEH4shA22qGg1SNBQ7x
yhcyGACYkgj67JIMcLFN9rQZ7PuUi8Z3AsWHQr2l9xzH8IuH4QAz4Id1/ExOGVm4
Ff3ruAdlDYy9TEWyRKTIXNxN978p0IFESpLdjZCYVCsXBZkOqRDonteXHTmSJieQ
0Q8z17JMZySUW5pJTuZENxeiwHU2KB6knWO97U3Z+wgeqFGI6xK20TER5fxEe7u+
Onaxz2ymTQl54Z4PAMNeOoiouGXwNlrK1/NxgtbJ4DkwoBFZtkimyfTBRQDtesnE
G138pbtNm6xOc/xWWe11y4XyWmYzbbgi7ZdsH/uH97pWKBgJqyX9mnZZfRsy6BO0
qySPBjBJjjlhQe7G2y+Eh/3ofhSlDiHZ/zzi0WSCv3Aju+PPcCc=
=J4wQ
-----END PGP SIGNATURE-----

--N4vDheUCnki5SCRE--
