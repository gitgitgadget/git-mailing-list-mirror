Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0728AC0018C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C792023356
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLPH56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:57:58 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46239 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgLPH56 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:57:58 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B8D9C5C00F3;
        Wed, 16 Dec 2020 02:56:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 16 Dec 2020 02:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Y8skt/h+vU0SG+xVY01huWkoueF
        y0HN3e+AHyMaVz5k=; b=iBWhNFYFZTQJBpQ5exlmE9KMQegjH9flj6S5rEjmY6E
        PdzCIi8cXkooJXG5yMTQFHKuMME/UbCGLlvPDM1LehTqQyS7u5JS4gd63YnX/AJk
        y7lR6PEdSrCzDiG0PDa3RQwUb9P19ahL81y0rHziGP1Ox3yjNjFlveU0Rg6UAJ2V
        SSTELel2DeQSo5Rn+nZ9luW389bdd3a4PKtZbfiEJ8XLqWPj6SBHW+rLhQqr7nxl
        ol+7E+RAEKtk4Rx88CAYuqhhixXqS1Vp1axrz+s7ShZOPVUfMkE5fe9AW7X5Xj4B
        QIiIntKNGtZc/AhPH4rUB3PLwp6BSbR6T1lJkaxy85Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Y8skt/
        h+vU0SG+xVY01huWkoueFy0HN3e+AHyMaVz5k=; b=bonofKWFFjKHNyJ3GcEIUj
        gYa0qgxsJa1I0GOHpmeuqSsH2DuKpK5gtzciXWLFBG9pUEv38BZHyEDzw2kvGh1u
        YmbtrVneEEbWLDNVew0LhBjMneu0HzTVS8Qx2//Ii9RP+C1tHxRMTC2NPeWSo136
        8BB/F8j6dEFweU48mFiXDwqtrb1cM/Aa1OU2Q+0MFQoFwXyMITD2oxW/BGlHQTL3
        Mhm9r7qSFsVNx7V5rdop0lGMAJrzv9W7aJqOUlKUEluQuJ83/oBdaJyxXnL8X5Ch
        bzLSqXNhZ6C0OJo+g9FLPl0bzKdvfj/CtyG6SfOYJj48D+1KO5iwpGPJMSH3lfdg
        ==
X-ME-Sender: <xms:w73ZX-gq__Ahr2T2LaC5q0pk6m9VsuQdqiRWiLTOFkPH398gd0nSbA>
    <xme:w73ZX-81hwMCc35fu9U1_tvzs8kxFUh7Uqveq2A0dXVLT4Bw_oca2ACHe9uWLv5lg
    15Le5dBIz1oylYBJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:w73ZXy-mf5YW_NG-gTSKGF4GLEktZb3ASHu2KGiXk07slzwO2JN30A>
    <xmx:w73ZX_DopnoHxhO2qUTkC-woKG32TaEgVwwbeURyVHL8cUcEyGKGfw>
    <xmx:w73ZX6zXlxrmAIC397ywBm8jzis5SCBGxvgMDeoEqwxzd40DRgEIXQ>
    <xmx:w73ZX_M2DCgSV0ecokMQdhCP8tR9wjZGm__QVpfJ47k1MnnFDW4D_w>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6280324005D;
        Wed, 16 Dec 2020 02:56:50 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c8229289 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:56:49 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:56:48 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 3/8] quote: make sq_dequote_step() a public function
Message-ID: <5729f5d406311ec139b1827fc2419255e296921a.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CHOzQkrhNl3gZ/Ef"
Content-Disposition: inline
In-Reply-To: <cover.1608104755.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CHOzQkrhNl3gZ/Ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Jeff King <peff@peff.net>

We provide a function for dequoting an entire string, as well as one for
handling a space-separated list of quoted strings. But there's no way
for a caller to parse a string like 'foo'=3D'bar', even though it is easy
to generate one using sq_quote_buf() or similar.

Let's make the single-step function available to callers outside of
quote.c. Note that we do need to adjust its implementation slightly: it
insists on seeing whitespace between items, and we'd like to be more
flexible than that. Since it only has a single caller, we can move that
check (and slurping up any extra whitespace) into that caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c | 15 ++++++++++-----
 quote.h | 18 ++++++++++++++++--
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/quote.c b/quote.c
index 69f4ca45da..8a3a5e39eb 100644
--- a/quote.c
+++ b/quote.c
@@ -116,7 +116,7 @@ void sq_append_quote_argv_pretty(struct strbuf *dst, co=
nst char **argv)
 	}
 }
=20
-static char *sq_dequote_step(char *arg, char **next)
+char *sq_dequote_step(char *arg, char **next)
 {
 	char *dst =3D arg;
 	char *src =3D arg;
@@ -153,11 +153,8 @@ static char *sq_dequote_step(char *arg, char **next)
 			}
 		/* Fallthrough */
 		default:
-			if (!next || !isspace(*src))
+			if (!next)
 				return NULL;
-			do {
-				c =3D *++src;
-			} while (isspace(c));
 			*dst =3D 0;
 			*next =3D src;
 			return arg;
@@ -182,6 +179,14 @@ static int sq_dequote_to_argv_internal(char *arg,
 		char *dequoted =3D sq_dequote_step(next, &next);
 		if (!dequoted)
 			return -1;
+		if (next) {
+			char c;
+			if (!isspace(*next))
+				return -1;
+			do {
+				c =3D *++next;
+			} while (isspace(c));
+		}
 		if (argv) {
 			ALLOC_GROW(*argv, *nr + 1, *alloc);
 			(*argv)[(*nr)++] =3D dequoted;
diff --git a/quote.h b/quote.h
index 4b72a583cf..768cc6338e 100644
--- a/quote.h
+++ b/quote.h
@@ -42,12 +42,26 @@ void sq_quote_buf_pretty(struct strbuf *, const char *s=
rc);
 void sq_quote_argv_pretty(struct strbuf *, const char **argv);
 void sq_append_quote_argv_pretty(struct strbuf *dst, const char **argv);
=20
-/* This unwraps what sq_quote() produces in place, but returns
+/*
+ * This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
- * produced.
+ * produced (the full string must be a single quoted item).
  */
 char *sq_dequote(char *);
=20
+/*
+ * Like sq_dequote(), but dequote a single item, and leave "next" pointing=
 to
+ * the next character. E.g., in the string:
+ *
+ *   'one' 'two' 'three'
+ *
+ * after the first call, the return value would be the unquoted string "on=
e",
+ * with "next" pointing to the space between "one" and "two"). The caller =
is
+ * responsible for advancing the pointer to the start of the next item bef=
ore
+ * calling sq_dequote_step() again.
+ */
+char *sq_dequote_step(char *src, char **next);
+
 /*
  * Same as the above, but can be used to unwrap many arguments in the
  * same string separated by space. Like sq_quote, it works in place,
--=20
2.29.2


--CHOzQkrhNl3gZ/Ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/Zvb8ACgkQVbJhu7ck
PpSsuhAAkbiyfDJ+LK/SPfHicH3bc8y7h+zBhSgaHEezn+8IX0Ivb3WvK7vWoiqr
6UF2glXVbcdvy5G5D4NynAqW1s7BHOKwplRWvJCuCi7IuE5nJkulM2WzHiGtVD3q
Pa6+8B7raR1Du2X8VSxvn95a8DGoOH6yFvKtjLq9bK8BF2ZHeJxKp+XGmz8Y04DC
Pfi2xrhpoCfxPPOr/9zGxksmqATRVGa6zTIBmYCPtN/f9Jj9LBJM9Oftn6mekT5T
3UIh73WZDjIyaRavNdi+0hc30j7/PJLMUOnCXQLhEbOKTJv/OyHwRz8nKW8jnR5q
UwMVfH+2U0o4EqILlNbyQZY+jX2XSDi1wINAny1wO8OSM+wRsrlhzqcdUYlU2sO1
qiOALQOJ30CJFlZ86X0PS+lXGh4Ib0fXk6HP4TQg/wCBQu/aIFj5JgR/R37XZKaY
DSr1YVecrwal83sDrl/xfQalGI6dgGPVX+sZwKlx7O9vouuCVokXpSriobIg5Slj
DWsOdz1VLfyHDN6UE4BPKgUEoiz37ebRiOllcn+7nRVvdEbNWRFngNbu44Js+e4x
5qtmxWaCSTz1hydVyCBE1Isp6qJEED1fVSr6RpPurgCpw+vrgU0izcajBesFR+uC
MAYM+qVyv2pM97Utfd/NYRSdaDfzm8lu0uaOxFYkCrOevL8rQFE=
=FqY1
-----END PGP SIGNATURE-----

--CHOzQkrhNl3gZ/Ef--
