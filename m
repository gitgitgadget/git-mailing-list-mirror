Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB62C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B7023B77
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgLILy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:54:29 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34677 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730836AbgLILy3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2020 06:54:29 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BF922AFB;
        Wed,  9 Dec 2020 06:52:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Dec 2020 06:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=3zWg1KeVrbfxMY/F8qBmTI/lfPh
        qwCFOKLa4/AmfQdg=; b=bZtPtNsVc77T9En9e+h/mnonPkRnhA7blU2fx4rI++f
        BXvsemv4W9P/Hr5d2Z5frNEr3gyIXJlW/kK2+h71VyCA+jdbceG6UC3L8svP/lKn
        2USMIEmS0HIAS0xkSVOZAuIaQE8qTcTgHCTER3kLWWa3+xFnKbJyvNWs8wiVLzQG
        Ww/Td2BVGsP01n6Sq+ye0h1RprXpi4ecj2WO8nF7P6kIJ+yN4Ov83VmSOLZ8DvFc
        JCmBetWDPNMr012N0U0YmyhvGl0cdc+YdXy1LlJHB/qdWP0WsH1Ny7tPkxEFO6lJ
        wyDKND6oLgnUR/meeKKhyb2rQ2sPa2cdexF/CpVWqnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3zWg1K
        eVrbfxMY/F8qBmTI/lfPhqwCFOKLa4/AmfQdg=; b=O4SOobTpYXVBNjEVh/DV5T
        AUL/U3P/SsJeUCRhiUIzYCFUHvpaf93yb80Hz3Bq0aJlA8xJ7ff6n3lvZQUsIiEy
        mQAW6rftbUBIfy2ozHPoC5xWAzbjsQnwiMVFUlhoX4kMXpDNW2zAJzP9lXuy1X6R
        dJDRZssnjmXMQgxi7odr57aWVU4hY2yG3xNDYjCC6a14lCloQsr4ZrJcU8c9AefY
        jiVIzT+p234aIny6IeYhEDYD9Q7BpsOWe16WogryclqOObWDAGECRzGsw15/jfDC
        AziJn+iR1WWMbGLHrjCjcwO/HqPyhY+BYjKo13dQMr30+zmM+W3w8EPXxT3delZg
        ==
X-ME-Sender: <xms:ibrQX15xVDJvlXRgEvhYYli3NVQltFRffOj72degqGrAuaqzW_Y_wA>
    <xme:ibrQXy7VbJqHE89h3lebTdcVJhrEN3TaFjv0xxrka3g0MdreP4HbbCjkstrWZIlTi
    uPKCW4OyAJzEF1cAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedriedurdduvdeknecuvehluhhsthgvrhfuihiivgepheenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ibrQX8dwpumJjIaIdlYfUQ9FmfUkyKvJnyQYlwTZm5PCgf_Ua3XEdw>
    <xmx:ibrQX-I6iNPVA5_yo6qfa6KE60kBxTl812w0h3lek0FsXy2Mg1ahiA>
    <xmx:ibrQX5Lig_ZRbtY90AlPAxrNTWIdb8eSf17QfGD3Adx8_W_ftjWx5g>
    <xmx:ibrQX525fqRSH3wjzklzKlxjT7Ck6fIs_E-DY2ry43qEqzFUJOe-0w>
Received: from vm-mail (dynamic-078-055-061-128.78.55.pool.telefonica.de [78.55.61.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6CEEC1080063;
        Wed,  9 Dec 2020 06:52:40 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id d9dfc387 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Dec 2020 11:52:40 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:52:38 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 5/6] config: refactor parsing of GIT_CONFIG_PARAMETERS
Message-ID: <1afda0a536bb431a4acc8ca312c2daf5ff26e5ef.1607514692.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9nxxHfbtY0VJcXY"
Content-Disposition: inline
In-Reply-To: <cover.1607514692.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v9nxxHfbtY0VJcXY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce a new way of passing parameters via environment
variables to git, which will require us to change the way we parse
config entries from parameters. Currently, `git_config_from_parameters`
is written in a way which makes it rather hard to extend.

Refactor the function to make it ready for the new logic as a
preparatory step in order to avoid reindenting code and adding new logic
in the same step, which would be much harder to reason about. This
refactoring is not expected to change any behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/config.c b/config.c
index 151980e5c9..8162f3cec8 100644
--- a/config.c
+++ b/config.c
@@ -505,35 +505,36 @@ int git_config_parse_parameter(const char *text,
=20
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
-	const char *env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	const char *env;
 	int ret =3D 0;
-	char *envw;
+	char *envw =3D NULL;
 	const char **argv =3D NULL;
-	int nr =3D 0, alloc =3D 0;
 	int i;
 	struct config_source source;
=20
-	if (!env)
-		return 0;
-
 	memset(&source, 0, sizeof(source));
 	source.prev =3D cf;
 	source.origin_type =3D CONFIG_ORIGIN_CMDLINE;
 	cf =3D &source;
=20
-	/* sq_dequote will write over it */
-	envw =3D xstrdup(env);
+	env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	if (env) {
+		int nr =3D 0, alloc =3D 0;
=20
-	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
-		goto out;
-	}
+		/* sq_dequote will write over it */
+		envw =3D xstrdup(env);
=20
-	for (i =3D 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
-			ret =3D -1;
+		if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
+			ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
 			goto out;
 		}
+
+		for (i =3D 0; i < nr; i++) {
+			if (git_config_parse_parameter(argv[i], fn, data) < 0) {
+				ret =3D -1;
+				goto out;
+			}
+		}
 	}
=20
 out:
--=20
2.29.2


--v9nxxHfbtY0VJcXY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/QuoUACgkQVbJhu7ck
PpTHyw/+L+8Z9ckh/x+iSv2hgaLpAnlxwEcrAQxU3d9RneagCjmuSWU8d6prkBKx
1rcP5IUX81HPxQum6GhMKQsk8TAks9hXM/+Rr+dNBrYNi3Ihss9K6i2lFO3vQcKu
YSdzl1mLS4D43bEuO/wrPI+ZTl+JDj2x8AjrB6N+qdjDwxHOt8YGZdiPRSPegcAK
cEqCrZ+8hB7fpIwusvSS3mMz558cXWGcEarNSIty7TLieOBPaZVwZ+LohasqtHJa
GvrHgBxq2dRzd2or9ZzM5l3yP/cw6qAcerHzmfIxmzDUDW3AgfUBUKOm/sDOegK8
R+lxb2bZzUb0zef+MxVgUUMAsQEH69l/GkDnJ/Uz6Mfgpi7cOjBURX1BIMwkCo8x
NaMHSAu88Lu7pQig9loNjaAljjTgXYkynXYjvg9greDQ4l0BJDJM8EJDAoc6sJJ0
qJTuEMXvaxoHqpUIlLB9EKkL8+Zjbt9rKsjc5L1qI3aTJKzH6FTn0vRsQ2FA0NVO
773iOlU/PZRhP9ioCchx7c6fL9mmkY8NnoPVAE3z/gU4ParYfqnXuX0hRJIH/eZz
C9bfbQw19En9f8rHLX+r3z3OyS+N1MpodXNEfAyRKXcEZgUivi5MUfSdv/fKVBvH
iTti9dEychQLcwIqXYNia5wEICryS+4c8QwHEQA1CocaF+6EsJs=
=RvDm
-----END PGP SIGNATURE-----

--v9nxxHfbtY0VJcXY--
