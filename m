Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C42C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 990CE60FED
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344395AbhIANLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:11:12 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58879 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344396AbhIANLG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 09:11:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 76D545C013C;
        Wed,  1 Sep 2021 09:10:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Sep 2021 09:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GYOU5gPPQF+G93mSqq/ZTCNWbmP
        RnjC6KRfDlCIwuCo=; b=m6TBa4plOGHZ75u21Utbds2AD2giTJ6445tntTRbxOb
        b5Hq7dMPRTVV/MFmG1oymySI8NLn5Vih1PfjrMtdI+K5tYQ6a/ZUjQJkiWSrs+SD
        Yey9m01fBRrIaxJx2egeDBjqr31R/4xtpH7Db7yxIXVjq55/8xJg0IkuyynNtnuN
        GGMVHX2yx6Vo0HSxcUJCbtUALC9iuci2J99IezqhK1dQa6Nmgtbmd9WrucODIivI
        +9RIhgld2cWc2zdzp9qTUCgOXf2bi7nWQLFThvpiudrPLBuwWx9GYEGFTy5V4Ji7
        hMIoHvuId6M2XMcBtb8Umuqbe3nuFl7DtwOJ0JBq9fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GYOU5g
        PPQF+G93mSqq/ZTCNWbmPRnjC6KRfDlCIwuCo=; b=afkSZVokY3m/yzRrHEI+Vz
        tMJu5v8b2zpdoC4SsGNreb/J/cq6yrIPyPD5fUdWxoXtJXeMEn25loUNiL7N4WTO
        Gq+h7oreoU8L20dlOrvH38dUDYW+nej0lp0ORar0G9W0GhrV5xM+32YdRZQeq6mx
        3CRpx1CgOL4LZCM5Yp+ZL90wptshuCQ+hO1w1xcQxFdk3KW7mdhNjamcepXuERbk
        acOESMWg7TuGLJv/7snvMErWE0CfxlTTI5SrC6hybFZEMREze6MxmkKXTwUHmME+
        aKPtqOKvC2RpRkFxcKdyw45nozMg+ec30DzZoK7gp151LiBjQwaRL+VGQvmU0ZLw
        ==
X-ME-Sender: <xms:sXsvYQDMAnJbiJCC7W3GOVnZeWTqN73ci4l6Q9NO0zZ-audP9Ixfkg>
    <xme:sXsvYSj4bmb4vID61alB_A_sdkPF_eHQY77s2IkJG1G2uPBBnLhlU1_YsOrDMm_RK
    FxlKhxOC7ZjQDgJCg>
X-ME-Received: <xmr:sXsvYTnxc7xRzLN_uH2aMVY9C9upclgD9i_7Dft55tdu8ykQjI59S9zp72U5YphNfBsjqc0QsPT6ZHbpNaCdO78q4mc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:sXsvYWxXhnvu3mPyZvV69Phq09RjuYuUd-v4xybacNlXZSinOtT4mA>
    <xmx:sXsvYVQFksb9co2YI3TVO1mrYQb6DcuNjIQRqX35O8IaMsSEPal-Yw>
    <xmx:sXsvYRZZTP_cu2Vck5NU-4Y259yWR0llR6tMp47pSuxM-aOQgpUgHA>
    <xmx:sXsvYTPrqVpWoePY--M6KKLmL7ofq_mXxQY1gAhBG4p3sGYreMjF7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 09:10:08 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9092f07c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 13:10:08 +0000 (UTC)
Date:   Wed, 1 Sep 2021 15:10:06 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 7/7] fetch: avoid second connectivity check if we already
 have all objects
Message-ID: <c342fc0c69226d4be8692f2311544a440c67a76d.1630501732.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1630501732.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6VIiKCK5GGyn6euH"
Content-Disposition: inline
In-Reply-To: <cover.1630501732.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6VIiKCK5GGyn6euH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching refs, we are doing two connectivity checks:

    - The first one is done such that we can skip fetching refs in the
      case where we already have all objects referenced by the updated
      set of refs.

    - The second one verifies that we have all objects after we have
      fetched objects.

We always execute both connectivity checks, but this is wasteful in case
the first connectivity check already notices that we have all objects
locally available.

Skip the second connectivity check in case we already had all objects
available. This gives us a nice speedup when doing a mirror-fetch in a
repository with about 2.3M refs where the fetching repo already has all
objects:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     30.025 s =C2=B1  0.081 s    [User: 27.=
070 s, System: 4.933 s]
      Range (min =E2=80=A6 max):   29.900 s =E2=80=A6 30.111 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     25.574 s =C2=B1  0.177 s    [User: 22.=
855 s, System: 4.683 s]
      Range (min =E2=80=A6 max):   25.399 s =E2=80=A6 25.765 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.17 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 09f7742d0f..6fdd01fb01 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1293,7 +1293,7 @@ static int check_exist_and_connected(struct ref *ref_=
map)
=20
 static int fetch_and_consume_refs(struct transport *transport, struct ref =
*ref_map)
 {
-	int connectivity_checked;
+	int connectivity_checked =3D 1;
 	int ret;
=20
 	/*
@@ -1307,11 +1307,10 @@ static int fetch_and_consume_refs(struct transport =
*transport, struct ref *ref_m
 		trace2_region_leave("fetch", "fetch_refs", the_repository);
 		if (ret)
 			goto out;
+		connectivity_checked =3D transport->smart_options ?
+			transport->smart_options->connectivity_checked : 0;
 	}
=20
-	connectivity_checked =3D transport->smart_options
-		? transport->smart_options->connectivity_checked : 0;
-
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret =3D store_updated_refs(transport->url,
 				 transport->remote->name,
--=20
2.33.0


--6VIiKCK5GGyn6euH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEve64ACgkQVbJhu7ck
PpQ5UQ/9FgtO0o1FUEHBN55FfRnCDgJMdJ3I/freV8wNBdjaE2A6fLo1JGEYSLjK
TRWv7fXPe5z4z4SnbsD2S/EZGjg4HPsnseh0JgT5ZOmWjWjOjKZZY1+M7RM7jyOP
WQFWbhnVqd1ONiOVDGJHSush/xrjf88QgJxD2IcX3WhyIDVrhLMeG9OgBBBIgBR8
ezBsT4JL2iN9evFrChazGvGmwotqbLPtI8vfUb2CJYBI6H4LAOvpj1azbLnIxocs
0CodaL0Mo9g57395yJL/+0cC2GD2CJZ6MMqg7icesEWnUMENFrSo7f28VVk9NFob
QgP3Pj6sSvMjiBQIi3L467CD3WHUcIoGEtHX1zhQ4n4RCS6edPjQ9R12dMuWzAUY
21eaerGdiTY4kt0h4Pal0V6lFn0OQfnBkfxyYqQGXjNe6i1Wxr9gQsie3v8B45tx
AvGMgqZqhgPE8i6HpSlnxysbMKwwY+lLqEhjuEOcSFvaOXO3Vxr51ISE8Cdc/U/W
S8DiTlToWuTN8OVv+vKFrFiG4xYr2sVA94whLVtem4Iw2K/jMjj84frCxZd4NXYy
Qu2vxkUednBlmYItsxb4uQhAwrmHVsW7asf+SvEZN9poUb+hhEbIkuEHHvKvZCd+
5unPwkz0VVM+vmfBQtYcLH8lbDqT3SjWpPXD1J6XWqqijenJStc=
=18a9
-----END PGP SIGNATURE-----

--6VIiKCK5GGyn6euH--
