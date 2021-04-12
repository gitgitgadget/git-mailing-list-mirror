Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904B4C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60C1C6128B
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241996AbhDLNiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:38:10 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54165 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241957AbhDLNiK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:38:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E033412AB;
        Mon, 12 Apr 2021 09:37:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=I8n7sQ+mPuObR10YIz+RH6luhj5
        g+WhDmy7MZBfo8Vo=; b=i5Njnj05AX6ZZfrUr8nGlHU5R3roe3V+p49znaTYF1h
        aU3Tz6JvjxkmMRM0AE3hRNWyzyOpkPXFa3/EgFXcPBoOSu8LMSwX8MoGVzzYUPHB
        Bo84axi8TeECfEQSfmjwHsQrsHdQA5cu6q6MPgg+oQhADSFYo6UFZxh6qew9hbzI
        Bwm0XcP8Y2wepuEqL0rlDyqONcND2na+8X3ahcB36zPLWDI3ywbLEYPH2EtPnoWh
        pa5Fj8iVnIvpv+QKUk5ENM1BVkXcWGe/UnvkZad0bUOBdjDsxzRDkqhuEGyPRkY/
        Hs9xiroQhLXw6IgjTZoIRol9KLOFfZ5qdA/ioxnHYww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=I8n7sQ
        +mPuObR10YIz+RH6luhj5g+WhDmy7MZBfo8Vo=; b=gL2EhMhTcN9hN4FI0868Na
        wu7uU4tfkHA9mUJnINHd0PKAAF9cWQAhT6HTppaGbbZJ9bdr+eROWTUd8VeV3/35
        OZgTZ+b4+UutbRX+300CKI6wcbJ3NJiItFj2p9NywmM+itb/ldUOzRfEeJRDXaza
        rb1GBo73xXJgEKL+3/z3RYjZgauefcNfgvDNMqpqX6enZ64G89KCEZ8lTu3vX1h0
        P24FVKwNZhNcGrRxf8gVdHJ5DzW/7+cv6UrlrU1fk+ylt3HvuG1FIvsqbjPuEM92
        3In5F9ECOJVoIDY3sIX/F9eadPhGmIMrCL826+zOr0JzusOq+2dTN+lYqA/4MVsw
        ==
X-ME-Sender: <xms:L010YG0NqGn5kAeJFZ7v5QfUA3ec-A-EZ4ZT4ApOBUReT5YWoE8hpg>
    <xme:L010YJHBDydagw1lQ87rzgkeD2ZqHFNog3TD5KsH_f2JG6aYXq236IzhXg0Di2U9E
    noWbm_2Vn2syrImkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpeehnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:L010YO4IqvAwPrtwiM34_KLmx_7zWDcFGuHOx2v9TL3n_et3GqKiRg>
    <xmx:L010YH0NtyAE0UofIyrpLOP7J5UCGQy5gD0XvjahZLHwmAEWYFUSsw>
    <xmx:L010YJHQjnWOmH_ZO6tDdTNNjaueXKuOi4zbZLM-so8FaeB7Lzx8cw>
    <xmx:L010YOT-ssurI0O13TeFUBlqKjn9XpIZQbs9Kr8AN7rHNbfmRIMDOA>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD272240066;
        Mon, 12 Apr 2021 09:37:50 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4193a035 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:49 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:48 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 7/8] pack-bitmap: implement combined filter
Message-ID: <759ac54bb2551097d62ffeac77e6e698eeae96ec.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2+MewbRpttKB3Svy"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2+MewbRpttKB3Svy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the user has multiple objects filters specified, then this is
internally represented by having a "combined" filter. These combined
filters aren't yet supported by bitmap indices and can thus not be
accelerated.

Fix this by implementing support for these combined filters. The
implementation is quite trivial: when there's a combined filter, we
simply recurse into `filter_bitmap()` for all of the sub-filters.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c                      | 10 ++++++++++
 t/t6113-rev-list-bitmap-filters.sh |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index cd3f5c433e..7ce3ede7e4 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -966,6 +966,16 @@ static int filter_bitmap(struct bitmap_index *bitmap_g=
it,
 		return 0;
 	}
=20
+	if (filter->choice =3D=3D LOFC_COMBINE) {
+		int i;
+		for (i =3D 0; i < filter->sub_nr; i++) {
+			if (filter_bitmap(bitmap_git, tip_objects, to_filter,
+					  &filter->sub[i]) < 0)
+				return -1;
+		}
+		return 0;
+	}
+
 	/* filter choice not handled */
 	return -1;
 }
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-f=
ilters.sh
index fb66735ac8..cb9db7df6f 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -98,4 +98,11 @@ test_expect_success 'object:type filter' '
 	test_bitmap_traversal expect actual
 '
=20
+test_expect_success 'combine filter' '
+	git rev-list --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject:typ=
e=3Dblob tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject:type=3Dblo=
b tag >actual &&
+	test_bitmap_traversal expect actual
+'
+
 test_done
--=20
2.31.1


--2+MewbRpttKB3Svy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TSsACgkQVbJhu7ck
PpS2Eg/+M0CiPO5KBl7fNZvxwba00cEDB1r3VZQlPBCKB9RgDaMzvYV08EekJpJz
nEHeaB1w2l0ceONz2tukxkQ99LjL5l9A4p+iItccMi5UlFDfzwSILiRyaeF8xnkf
YWNDMaAdGs/qXoemO3EIAN8IGDyMU5b27EtE9VPakkSb/Mb1aJAZuoCImtqqtgAY
DRnfCg1Dz4GDwI66lmS+7//Mbpedsx12SI2uczQejkbkRFwQ0H7xDBl4x21VtJ4A
ASl5RGNethoRr8AGcozQTg3ckbvPWZbq30RpksPwq35DeUocZQS4xo15Cj5jHvd8
A/ODuJdZmtnSP0cQHwnGpu4yYbEZ0lmbVwp6QSM/RMxJMG3aE/+2FwZVOEFivCsB
xzsiMESYeySMnEvRgnzRWq6KjAKhrPhzM3o5MNCo3p+x8oGmOLArO+SrExkq4LJC
8JsGPFNQii2u1OjQwbzrpbEk/PHTMzoLxyCWNRqrDTWLVa4oVrUeEbkxtSxC04VL
N5r5Cl3Cx3nWPFBT/x+BbcgbICOvc+TJIVv7BnDKbP2sZ/9LFUdDuh4be15Qcp5M
5TvuN/53H4/41R3Wy2NStYvLRkojP4k1DIQQSjRpBkf6au6Esrb4tfvLR+z67ub0
xa3Rvzcz39gPrFQs39Dd/kyEgs0IUQtxAyI2D0bdk/U1E+TgwHY=
=4O2b
-----END PGP SIGNATURE-----

--2+MewbRpttKB3Svy--
