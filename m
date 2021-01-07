Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2804C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC7722E00
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbhAGGhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:37:50 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53479 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAGGhu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 01:37:50 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B2A45C0165;
        Thu,  7 Jan 2021 01:37:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 01:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=BaH+qtFHtuxUF6T4VUceASwFfEW
        IwvLF9OwurXAHmXw=; b=pDmG4GKznfM3GmuSmkgmCZijgw58fWH4/DotH4nQW7D
        2JEpSZG+ee9991OobIFaQGRHE6qlnr85N7MVEhYFpQDqwD8uHNjH+mPFaGSCw142
        +5ZltovYmJKSk2WJfQHHUXQsmgWvcN5TidhmU251qeBV8wrlu5j0pyUDgPG9TL4H
        Y/LpWh2DGT5YK+Dt6SKNn30lFsxByecJVJOa8JiEOxaAck4SSRV4sqTxS4jWKGg3
        SQAvWi3YYI57nMEYWRsNwrZGtyu2KrvbALbxlcI0IaEBECWOBYJL0+vV0ST6oNzp
        qSO68XNVyktbbukfwko8EyCMdtxVGKqwhdx95MlrmMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=BaH+qt
        FHtuxUF6T4VUceASwFfEWIwvLF9OwurXAHmXw=; b=ZG4T2ygIcmMtl7MFmRwGdQ
        NbDS3qHP6+CfVvllsS0QRyz1Y4ffUlCJFw+3rgU7jSfRSrddX3BBNVxVGGoTSWSx
        bCiq7s5MrB+QJql1i/AfFzq/31zjEMufqmVuR+dlMuQ/YhaNQ31lZdnd/Sc63HnH
        9v2AX3KnLAhtI8WkPU49GqJAdvaBCBzQrENsHWzknKwp1GddJrQm1tJwqaa347Nl
        HSXhgA+3RYRHvlLMX2T/VBbXsTkP7B+B7I00xJlkrZqOLRRKdTgY4vWoKER25oui
        odnWoOPJnHXAObzNWSRIkooLq3TDkCDEYWYcIp0b9BzXgKpWw3wpYcjVDsoUNQyw
        ==
X-ME-Sender: <xms:EKz2Xx7jt8kYs80nLQgId_nuw2N1GmpHJk4PnpE20aTgZHn4_gtJKg>
    <xme:EKz2X-7D9sSJvR4PZwHr-KJi5n3KDhdYvF4utZsYjKdPxWfDl1Djf_vUu0rG3-HLj
    qZUQePW0SGg4GavMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrfeegrddvfedvnecuvehluhhsthgvrhfuihiivgepgeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EKz2X4eY4Yu8bwXEVAxHlc1pO8ur803Ka0qjqAJGSmgy7KaQx-2Dlg>
    <xmx:EKz2X6KnbjHKHZBB3pHXb1Qkkl6ripul_6V-etOizvyAnObYfcs_4w>
    <xmx:EKz2X1KwVLjFjTO43wHSMy-oTPulae8gAvevRylHLDd4IDc1GlIQ0g>
    <xmx:EKz2X11s4RThiIe0evcD5V4SlyFIl2nf37hocOFSjcd7DmYhKB3bug>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 35547240057;
        Thu,  7 Jan 2021 01:37:03 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ca731f06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Jan 2021 06:37:02 +0000 (UTC)
Date:   Thu, 7 Jan 2021 07:37:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 4/8] config: extract function to parse config pairs
Message-ID: <0a9b085fe5e2440f9c94819377985ed83bd80d05.1610001187.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="75fB0vApilMWW4oQ"
Content-Disposition: inline
In-Reply-To: <cover.1610001187.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--75fB0vApilMWW4oQ
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
2.30.0


--75fB0vApilMWW4oQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/2rAwACgkQVbJhu7ck
PpQ5CxAAn+DnrYtBSUOWqcL7BNHWjm3GG+G3i7Z03IEJ/AlTAgxoV7R2OMTOwelW
spTMJrpZ2WTyW5QOD91hx8RZNM1jrKWXG3QpEr6yXlb9G6zbgcvXiTaWH3TheE7O
J7FGipnWBbeKiOi2INbmCZbi5kFBfW0qHmcBzI7klw/DlddH7kSesteCvZVh44PO
chaOii8xnFTMrRTm2JxUw6+qiLIv7+2Lq/NcQKZfar9/minZSGCEJAzW2lpGwiwk
81rLrpFNmWOl42c7hTLp9r4Is8nx9ALZnhNE1GqiuPNAzx/NTmeo0iV8uQKVZBRJ
kKJSAE336uvLqDQdOmPMXBk4wN4pOO0kCyUqy2p2GijJU/49yGKyMpWXqR3jrwEL
ytZxDrQnFVtCmMHYejGT8F3D5flgaCy4JwyQ4Q4z87o7IR9nrdlfVR0TApBqRth9
TyzxtusSszwQyoyX4tRs2wSTP5y0pYw0S5evqjue3EERlnCF9o9mAXZu28Kq9d2C
QhPM2IauSifyvF/ne9280UuSdFYM0dlS341mK4mKbzdXCMpLTgvho9tHOUNhbc83
yUuBskHM0M6bA4gUOfM2Kiu++CpX4tBqphQM6ste7Wlk85qQ/xIuvfDKsvhED7QU
I7V7CsYuJrXNYyRGPHoWxS6bx74gJuFxyTYfaCLqUfxlVLTrwLI=
=o5KT
-----END PGP SIGNATURE-----

--75fB0vApilMWW4oQ--
