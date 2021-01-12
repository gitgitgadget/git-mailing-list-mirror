Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A43C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163512310D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbhALM1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:27:44 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:58719 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727855AbhALM1n (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:27:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 899BD174E;
        Tue, 12 Jan 2021 07:26:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=2+dg0QZPrPQRHWyaJFhjhjDVGMA
        9rAliLC8XsYCL8O8=; b=sRc+68NPa3MepfFLQphzGI8F9xPk+zP3b2cCiaOYPtS
        pRdPKMO5SgCNNdULeFsVKJt7/W0CqPrYX9C9JJY5erdxVzY4QhGCr1D/scFRadsi
        1FGjykn8yO30jZsjvWkwoHF8xJlfV8oz5Om2ho6sxDDMkcHcWzVPWK+tXZ/KpfPh
        aU/RIx055lbCV8cxieD5jyhJho0vThKh93zmtjnN/Al7J+0BWUtz8x0mw8+956W3
        sGz2azIQ/JKlL3YYfLS/W5QrmCOG8GYwfOuFNK+SbstWFjByXlz2sOkpMK6CDbNK
        hncjjv8y9VSRWSi6fCcWnU48S91zlgJIRu5nFrnZ45w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2+dg0Q
        ZPrPQRHWyaJFhjhjDVGMA9rAliLC8XsYCL8O8=; b=fg9Wp9D94oY3HNblRkdEgC
        GKKimhPdC9zh1ZB2JRKZ5tQj64AU8RlhOgV5Ke4ysbBMjLPL7LSB9I9lX4G+4FOl
        TBwcS1XaA2TjXrwjwd7r4iMPW4/FasamT4EAvkt1Ftw7GNtUjF/mqRkCiK5phjzW
        iVdpWG2OdWLbdZdDoYSIj1AqLlmELRTTubNTwEicx4MJiv4EXCTPdSSYIPIV2m1G
        ++CJtBcB91JwvAgQVadCmu1PtkXOlHXrNVawG23qdh7tQQgOUTIcEZEUnkamAzYe
        jwUkB2L88Fs+4aU6333gyRB+nHoQtuUZmImE/Dxw6/RsPKKFO21gCTTW5Spt5tDg
        ==
X-ME-Sender: <xms:kZX9X6jJIYm1O189PQZ3qX1RqkYCQ6cpXnGb3bpiyz2PrztFV4Chjw>
    <xme:kZX9X7DoZZ2JomEX-Hg_9J8FDa-LLKJJBVarriuHuEDd4DNwvKZoEXTm-wL_ACykH
    vPzbqM4tR8b-BDfpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kZX9XyGLEq3VSptXMwB0Epy6hzbBr_Ch_hpZ9zmkBHUS1XTo1vuozg>
    <xmx:kZX9XzRPNH-LvjB9ANdD9BLsVzj23CzbdPMt4SEjq9Z2EKqWHQxPcQ>
    <xmx:kZX9X3w1ooCICUtbYfmLZG6k8hd4SVr_8Altbbwt13AThh3g9pe_mg>
    <xmx:kZX9X5vg0bDZc_rgGNwy_9eQM19OmRSap1NaxKjOZyr-mdmWpUoPyg>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15C891080057;
        Tue, 12 Jan 2021 07:26:55 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5db12c59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:26:55 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:26:54 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 4/8] config: extract function to parse config pairs
Message-ID: <39552eb8b931442e656d0287447fce3b2cffa87a.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9hDjZ4jj3ilUXNyv"
Content-Disposition: inline
In-Reply-To: <cover.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9hDjZ4jj3ilUXNyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `git_config_parse_parameter` is responsible for parsing a
`foo.bar=3Dbaz`-formatted configuration key, sanitizing the key and then
processing it via the given callback function. Given that we're about to
add a second user which is going to process keys which already has keys
and values separated, this commit extracts a function
`config_parse_pair` which only does the sanitization and processing
part as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index fd8c0c4dfc..b7a8129f6c 100644
--- a/config.c
+++ b/config.c
@@ -462,11 +462,26 @@ int git_config_key_is_valid(const char *key)
 	return !git_config_parse_key_1(key, NULL, NULL, 1);
 }
=20
+static int config_parse_pair(const char *key, const char *value,
+			  config_fn_t fn, void *data)
+{
+	char *canonical_name;
+	int ret;
+
+	if (!strlen(key))
+		return error(_("empty config key"));
+	if (git_config_parse_key(key, &canonical_name, NULL))
+		return -1;
+
+	ret =3D (fn(canonical_name, value, data) < 0) ? -1 : 0;
+	free(canonical_name);
+	return ret;
+}
+
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
-	char *canonical_name;
 	struct strbuf **pair;
 	int ret;
=20
@@ -487,12 +502,7 @@ int git_config_parse_parameter(const char *text,
 		return error(_("bogus config parameter: %s"), text);
 	}
=20
-	if (git_config_parse_key(pair[0]->buf, &canonical_name, NULL)) {
-		ret =3D -1;
-	} else {
-		ret =3D (fn(canonical_name, value, data) < 0) ? -1 : 0;
-		free(canonical_name);
-	}
+	ret =3D config_parse_pair(pair[0]->buf, value, fn, data);
 	strbuf_list_free(pair);
 	return ret;
 }
--=20
2.30.0


--9hDjZ4jj3ilUXNyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lY0ACgkQVbJhu7ck
PpT5LhAAiLHA4Q8HFX5Je0NwQ/wjJJaThgKgarSxWKWC2WC/vbyyiWDl8+KyykS/
mT1TOCJRz21/meEsvayJhS0QQxp0nyN22W1J85AQ+nAS34BL7k6k5lzTayaPF+sG
2JZQ5OpFFe23zvBEDzyAfXKupMw8jmsIysrxM9ztOL/HQARukkTnTAt7Lh6KfIR2
9vTtohkmkdt9A9ARuaygQzFkHp/vhoyRs0PbadU3FXjnBMVV7ntlPGudzhubSJL5
4F7wsMCtShp9VK4UoICY49+BCLOG3FTMVmdv3m5Zl//4OdUbyRykajE5eJi24vXM
06ncKsHOVFRp5ciAQj/eKYJLsRq+F1Gdh8NNlR+CJQoCThjlwcQjIUJJTJPx5C2o
9DG8CAL/k4vRsD/lHmWvmHO6avam5OUjCaoNf7f0QxFUQqJLVtlhPjK6QZZ5JnQr
yfHxLHy1Ieqlbz3RMNJnMJ7GMxeey+2Yoj5K2KuVPIWQgkJU7wQ57dwRUOD3gBlr
7tRf8YKZr/o+WGnbiqGAT0qVrwm+mTp/QrLvAD/QjeMGnD8Cyqk0OzPrSxkfWRNG
T5SqKwOwwEAc9p6oabuu7kxW9PlIB9tC6AiuSwsQzio7ZAzbOQ1zVdMZsHI0t1Wb
bX4DucwSb3euzVEdF5nngiic9/mWmKOhujvxduXJGdNKySYTS/g=
=O9G/
-----END PGP SIGNATURE-----

--9hDjZ4jj3ilUXNyv--
