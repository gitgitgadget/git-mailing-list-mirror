Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5D5C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0C723356
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgLPHzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:55:16 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48789 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725806AbgLPHzQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:55:16 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 178255C00E6;
        Wed, 16 Dec 2020 02:54:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 16 Dec 2020 02:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=TcxgDcvcIMp6dnvTQPIhL2nq8CL
        UXRflIDU3c2il5gE=; b=FfzvotNhLgBUqlbSRgJUJ2y0Er0En9cD1vtq64CZMfJ
        93l7AHlJdfuAcyl3UUwho20h9BztA3u+nDkEXfqV0I/qW53YVr0aSx5ZrGw5RGgb
        QO5nAqNAtX4yYbn5Qj93W/Fxn3apj4YHQ5R29O3WlWLoEqoQld3oJ+/w7ooQ/Q3Q
        +VZBUbVbaimMIy7Vo95jdD86UICwOUYlMFFb9EpmFaw+Sd3K5Bb1xWQjZQ6hItB+
        5nizceLMK0CP2bJ/AV4TjImymPsWRs8HgiblnQiwCAV6+r7ywu9BWNzlemv3EcYo
        EPylE9qzgGL1NsTGaIk7h7MC/YGy9Zpdd4lD9NHX1lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=TcxgDc
        vcIMp6dnvTQPIhL2nq8CLUXRflIDU3c2il5gE=; b=oJ6AoWZ3nk8XxTZET4Tnqz
        BSsRThrFH9wojr1nMzf9eJ2F3+fVoALE49C6lMdZDlG+j/UHEAMWtAqQXf0OgM+i
        wVUR2OwDrHGcyaGX/ABlx0NEnxdFOvfzAJ9ZZYofO5KITsZHFDcA4JZeHQfeok4M
        X9gDKeRD1+oJm6ad+US6D8hp2qol230+iEXc27s4oGaHtpLMOy9eNBjiMcS0QuSM
        XpIi9XfC/K4/2rJrrcraxiB04ibgWtR2vgD4IbajMgGZR0CYbaFQXEd+J3rrVbke
        u9m3apVnVneVcc0XfxPcEIkwYhZJVBcOknb4walekWTUovorTUmmBnq9SjaDkv5w
        ==
X-ME-Sender: <xms:Nb3ZX_ZARvpF4hqKWDuFB0JTIsFj5CL_G4cT1drsehZcDO5uoFPXVQ>
    <xme:Nb3ZX-bIBC1IQecOJtqOXll04K3BMhd9kz-RlCY-5tmMlLeGCnZvn_752M9ny-i-a
    XwtGPZsfnnEcnN2bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Nb3ZXx-G8BbDKvSSWBt-23aIIXCMEVbMBdYrGlgicFOKhm3P1YKWlQ>
    <xmx:Nb3ZX1phYKhpAHU7QDHYYaTQQfPubf-1NntcFUfdVacVU6VCjsycOQ>
    <xmx:Nb3ZX6oTvE-b28EkQ0KTKwjj4bIyWVQRv46nH9m2qEpGaNeJ-ap-Vw>
    <xmx:Nr3ZX9Xf2bkZa5YRYggXCO0c4gt50NDPznCfmYr54XuTdxcWARfbow>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 53F1D240057;
        Wed, 16 Dec 2020 02:54:28 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9c28d087 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:54:27 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:54:26 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 4/8] config: extract function to parse config pairs
Message-ID: <8c6cdd57a0f92442c3cbd5317af06586cda8d411.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NOqScM1+hKXfI9wr"
Content-Disposition: inline
In-Reply-To: <cover.1608104755.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NOqScM1+hKXfI9wr
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
index cde3511110..151980e5c9 100644
--- a/config.c
+++ b/config.c
@@ -458,11 +458,26 @@ int git_config_key_is_valid(const char *key)
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
@@ -483,12 +498,7 @@ int git_config_parse_parameter(const char *text,
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
2.29.2


--NOqScM1+hKXfI9wr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ZvTEACgkQVbJhu7ck
PpR6nQ/9FYzL//PfpUmh6aDa7QO4zZIFfxx3aN5/o11w/X9kiR1lHAh0r0zg7Q5s
XpOzz+6IJxkcQ7U3DJfcYjxF6Zs8p6HMQnYGRGpFqc1r5mOQQghqM3xnGbzLV9Wb
RtETi+AtkcSezbtiVYSVNjncyDhuS7m/bPrICIEXTX9zabO30N8QCkO8Hgh2KUx/
UBdbqGnI2C7rj0C6Sa6A+GVmE3MLGQbquI7CNHWKknMykpfwFGtdv3kRUSkGbUml
IA44q72T30I4YSe7PE8LnI+NtmqyIROIY6uAvoSNyCT7cWYjo+WlVSVldAZ+QriI
Z6ZnhfHgwSMwppE88w8FAjYSNySGid630vYKSsv0afMM/iSxWFy7Qaw/BR5jFE0X
bcXuzci+CPcgBduilfIRB3CJ7cL+IIEaf/Ej+SEC7iz7XPSsexoRbpeWZOUi25Ro
OibPnh9qrUwEUEl8uAf2TYADEee7K5REAKh0a5Sx31AJzjETfH/tnHFWWNCZ4N5s
fJJ0Faxu3WzSWHNpMJSmCyVU981eseBDq8qZ86zIChVIUmAWYxMufTr1OB2ETM7q
f1fdkH1h9IRj+CG81QCOE5kSCPUIZEJOp4Y2IZINs8wwJ0cs2b0tX/W+TmqrJTz1
kqGQ42oC5gJqtTzA/daxL+c0Pvic9mF8R8DsTFGc/LKTIKhdX1M=
=p+bZ
-----END PGP SIGNATURE-----

--NOqScM1+hKXfI9wr--
