Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADAC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F83E22581
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbhAKIiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:38:10 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44855 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbhAKIiJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:38:09 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D96582509;
        Mon, 11 Jan 2021 03:37:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 03:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nrHjIpOBEC8UV5yqviyUQmMsRRX
        ZVF3QTvWMJz4fWus=; b=lglaIugPmmf0mEVQMoJwAJfVBPeXojv0ELymsyI7vi/
        oRrJrydSgcSO0Vlkqx+tb2RwEVbTkckJGJDBzaido1qkjreckj3YzTSGLNr6+9Mn
        F3IPjOq5DIeorBihcIq7rvL7+NfUW9AqFIMsps1Ix2tQPLLotVfppqKcCe6+Mgpn
        YYa+gDWjgb5z2HjuuZrYJsxFQmDgdpgg0ncZ9CW6c0WLFBFsVUVw6JOHCySHAvvR
        7V3uerIe5CB5reYL5K99XKWpO9HxrIL9ARoTzdwmhfmUMDA2MGTwiX5OqpD4dj9w
        QpuvtIjv+pH9GT6txP9nW0jA24PKkk6yFunGQGPR8iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nrHjIp
        OBEC8UV5yqviyUQmMsRRXZVF3QTvWMJz4fWus=; b=ij9VxxKR5aLLW51o5KQu4w
        F0NpY/Ch5x954ZhyW4aSAakiIx6RxH2X9Qbtl7d11pN3Cq/cAWpG3M/57tIPFJ9A
        VRprzFAy2ADcR0ESy8J7/mpg1rik8bmRZlprWLwHrzSFwiEz3UBZdiQ+dyZJzgfo
        lp37wIBFecLyt22Plo0TnEFsSbTBtcSwPH3iaKmW4T/aaxQHFw0u1k1wynm5F7pn
        y0zC5BEJN2Y+qek3iojI8OW4RqR9Imz8oQEpKSX8Q8pSCnJ5vz1UStOsPZkiajeg
        8h9k3nHi29S/K+/OV9gFYrRAjhXAVknYzvLV0FvVmJY51MUtWZM5+H0csUkDb40g
        ==
X-ME-Sender: <xms:LQ78X-GhbgjHlMK7XdnCatkNGoCly3Lu0c4L0FbBa-Cr_tO2O0Mz-A>
    <xme:LQ78X_Uu7Z0e3wmP8GxAcVoNpcDO-WdDpb4E-dRou_KNH8HDWH48953bwhiiGcgru
    9ncuu5JRltQBaSaqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpeefnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LQ78X4J0aQ3aMhBByHtXiUsaNcaWmDQyWhiph1GS0eLQcA8ffL-uXw>
    <xmx:LQ78X4HTTt1QDr5l2A4FvEqE9SIAinRDnHgdaZFRAEnU4GBgMHqtZA>
    <xmx:LQ78X0W4xSHAH4rOAHIqxyF4Md0Suh8mnWu8Ptge9ruXzMtz9O-ufA>
    <xmx:LQ78XyxcSwRt3V3kpUU31LlUS_r07HpjjagQatqUMGRDXWixw5dSuA>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7158724005B;
        Mon, 11 Jan 2021 03:37:00 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9973891c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:37:00 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:36:58 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v7 4/8] config: extract function to parse config pairs
Message-ID: <b9565a050eb7f47d985c76db7665a7936a0a89e8.1610353895.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610353895.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0aCRxEN3Z2U8gOyg"
Content-Disposition: inline
In-Reply-To: <cover.1610353895.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0aCRxEN3Z2U8gOyg
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
index 6484d13c46..aeffe4f4bc 100644
--- a/config.c
+++ b/config.c
@@ -461,11 +461,26 @@ int git_config_key_is_valid(const char *key)
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
@@ -486,12 +501,7 @@ int git_config_parse_parameter(const char *text,
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


--0aCRxEN3Z2U8gOyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8DioACgkQVbJhu7ck
PpSoCA//dA+H4ng0kn8v/BFxwTBwxlLRO6p/yRViyJNhuX/BOIHgzrmZbXIkbAuD
qlPTD26ckVbXJCQozca6mK5su8T4PNUyO2Abf2yj/TQFFi2zKTcznUzQeAJqv6Z8
Im23byCiNwsqfTwQkvEnERFEy9mMwK4yjL9qvWV3VShbuLl/m/C1O1Su2+BoZj6h
0zAaVN45bcLByl+5KuzO0AFjMH+4SN4RGX/qah3ekFnYD/MrjzIcoZFNkgC7yFts
1sS2f7POuInZC0HDlJTrtqVPrwHjkZijAWWtHvVD3/pyVd3Jq9Um6Q0EXXSlj0a1
cNnUJI4HNFowysqXRS0JeZIW/w8FiHyetAVoS6cZSdyfFmI6wRdWfBR2ZTsxvMDk
N4crODLLhALZCOlA6tX6oWILoD2QLoQ2sKrpMWsN0bU6rx8LVo9XUp04p4nCfTN1
gNyALqTSUXAmDn4LT8cG0MzbTV3/2J6ImWzVo+pGo3Xb6pJvD6B2nonRUr8tkCAU
anb58W1zOZWZjNaCYzmkW5jT5n3sFNskgPUl+hCW83KZ7YRayckcDiVgmjmcKyOR
7wRTq6uDeyEo0BEysaJYK4Qj3qhlWkkV+AlLkCJrTG9O+KlG4YsCiilV+pyJYLHz
8vOhuiFlefKzDbBu//MWv/9Ktl4fCVwuhodAOIHVdZq9ScTniQw=
=AwRj
-----END PGP SIGNATURE-----

--0aCRxEN3Z2U8gOyg--
