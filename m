Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F0EC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CD360FED
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbhIANLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:11:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54753 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344384AbhIANLA (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 09:11:00 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0661A5C0161;
        Wed,  1 Sep 2021 09:10:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 09:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=7vhOzDwM4dU7PF+O6vo3x37sYB2
        N4N1+ABlbxmsYUOc=; b=Aeao0gWJgnp/3XJcOP63x7rOZWHp5rV05BxzT+92Dsk
        JJ8l5ac8CQLuD/Sd9+yJfUpqvzA+qJP8OZ2H1kd5tFv0hMDigiY4nggSKaHK5k+R
        HxlFUOzCewYAqOq2sVVG/fQwYa8zOmxxg7Sv990ARu5kvKypFrrX17RYBrD23Mav
        Q8IbVK6cTBXvhG4WJHERU+ACIxbEVzmCcaJoWmGFxbVi1++ZvoOqqH2LZecgagCf
        ROV0AmQn/zw1poYQOyj+bQ3Emwe+EKhJ7dURUDADV9SbqjmCsHjSJ0soxDVkhUKi
        r2RZOkHjeeSQVnf6fpQGcCWZh3YwreMQSGxdQrd7J0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7vhOzD
        wM4dU7PF+O6vo3x37sYB2N4N1+ABlbxmsYUOc=; b=CC5Uh9lsJmgIO/4XzeUsKO
        cx5qbBstOAppdN/HaeGeYtk3f7xRjT+IeLeVu3xoBofmUznNvM0bIHcxKEarlN1u
        CrsinUn6I4WHttRxmkY8gSwZAM5L9VEl2Fb0XcoOMMXGxpGPLh6Zc4dlqHjlryZp
        Am0I2KuvU9hM2emkUAjZoOWrwq44NKObf0lOurXWrCfzKTcJPHRV1eMG7HKldgbM
        NWECLZVF/6gKCvJs+U/fNFBME3bGtLkXWp6tTISQhLxlMov5udc9xFQPOYz5VxUA
        c5NMuq4eP3SpXsuCy2nGkJj4GlD+tOLgl1S5mR0DesAQ33SPMoi6g9CufrWDFcCQ
        ==
X-ME-Sender: <xms:qHsvYYp0ndIqGNbshYMl6WKA-HJcpnJ6P3Fr58IyJZ48-kEEd645MA>
    <xme:qHsvYeq27IZDIVAreLTpyponzFid35sKZ2Xa2QOuslNqNtSFD628ZnAiPHGgJLtjF
    Pmh7XTqXEQQGs6KGA>
X-ME-Received: <xmr:qHsvYdN1OKI4shdj48fe1WmJuuIYhTYmqsZhvQHK3Eo1nEnhYX8jqtjf1xDl-xFZZWlLFmlrEm9lgz4d2TxIjsdz6M4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:qHsvYf4oTamBM_t-iVCuaQwee4osrMnOPCMGtMMcy7lKGwD2WRYSpg>
    <xmx:qHsvYX5sGrO98PpyLVXQYSc_Ap3-qUK-s6lrK60c2D6owHzMh4l08g>
    <xmx:qHsvYfgByMgFvYpJSPtkxiRG2o4Gtku_yLcQys5WpvjLQiONai7qRA>
    <xmx:qXsvYa1stLJHn1F_P7DRKaXOgrSnywj8cBoSmtTQvMwLsAFvdhflTA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 09:10:00 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0530a8a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 13:09:59 +0000 (UTC)
Date:   Wed, 1 Sep 2021 15:09:58 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 5/7] fetch: refactor fetch refs to be more extendable
Message-ID: <d64888e072c3be2d25372b9743cf1bd3baefc9f4.1630501732.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1630501732.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kASDZ9UD2UPGJjWX"
Content-Disposition: inline
In-Reply-To: <cover.1630501732.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--kASDZ9UD2UPGJjWX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `fetch_refs()` code to make it more extendable by explicitly
handling error cases. The refactored code should behave the same.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f67fe543ad..bafeb3d44b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1293,18 +1293,28 @@ static int check_exist_and_connected(struct ref *re=
f_map)
=20
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
-	int ret =3D check_exist_and_connected(ref_map);
+	int ret;
+
+	/*
+	 * We don't need to perform a fetch in case we can already satisfy all
+	 * refs.
+	 */
+	ret =3D check_exist_and_connected(ref_map);
 	if (ret) {
 		trace2_region_enter("fetch", "fetch_refs", the_repository);
 		ret =3D transport_fetch_refs(transport, ref_map);
 		trace2_region_leave("fetch", "fetch_refs", the_repository);
+		if (ret)
+			goto out;
 	}
-	if (!ret)
-		/*
-		 * Keep the new pack's ".keep" file around to allow the caller
-		 * time to update refs to reference the new objects.
-		 */
-		return 0;
+
+	/*
+	 * Keep the new pack's ".keep" file around to allow the caller
+	 * time to update refs to reference the new objects.
+	 */
+	return ret;
+
+out:
 	transport_unlock_pack(transport);
 	return ret;
 }
--=20
2.33.0


--kASDZ9UD2UPGJjWX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEve6UACgkQVbJhu7ck
PpQkhw/+KHoZxJAvwl4HTKZvfIASrrWzAP2cQscY6KHPRtd/aaM21vpJxo0Bow5Y
FAU01qF4T5vPKGAmuJNU3k9H2UIFpAAE3Oaor3rysmPwH7liJ4VSPlWa6oUetW4P
tnF5IIKTiwvKZUhBqcjOgAbgsObiI3NUN8AXkLrc6yq2jC16gatIBmf1sje3xB6Y
LrbPJUuHT7P20ga7ituR9P7euGlIlM0WzzhTgnZyWhuVgOlqUWmn1fc5kEb949mS
LXJJeGN0mTgWhalhpbLDDhw41hYd6NWoDTKHAW5nGimEDse/y0u+JO0zUZo6Dehi
AC0KFK+IUTzl9+MO8eDrdsGGPjl9C2/eTllJS1RI7/fFWDuElfGA5pZyg7R0Icrf
QAk7iDWosh+jf8NmBKsaUvMkb5bHEsOXu66TAQdotl3aQAUj0csD6VD9huJ4EvDD
9PKI+ZYZS8IMUD1LMyjbpZnkOInWv/09roWyGkWa+iUQZk68OyekIEuxvSOPAFyI
+CqMhTuYmYiy0rnOMF5m3E1lbhdKBJGLt1ir4dSuUySHywJrN0IGKxrVuqOCrwMw
Qg4xwQoY9ARdGl2lC4Whplli0Jiv/oYNsRV4TWAjNZ2RjRT59ffqhtG/VFByp9mi
FmUT0QaQWKIbHyBGQ+7+fbn5evVsMA4EatZqMNVH/0VXGRYk2kg=
=QPva
-----END PGP SIGNATURE-----

--kASDZ9UD2UPGJjWX--
