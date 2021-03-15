Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1089C4332D
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FE564F05
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhCONPa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:15:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41131 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhCONPC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 09:15:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F3C85C012C;
        Mon, 15 Mar 2021 09:15:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 09:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=CYpq74jijYigs+yUJvwYq2iXL4i
        R0X0K3wAHbtNjmOg=; b=WFkZ+ZCBjX3YWoOMRYr/3edaj6AKif+QTuOwfdLNCrN
        rLdqC9JXaPoUHeFgenu0syn3JXVlbjvl+6ros2XDiulO9q3SGhhbEhVVNU0gepu2
        rkRWjydeock8R0MlxD/3alzl2QtXMVr61M4MaZI0RtcMoBZH4c/k9TQyWnUWl1fu
        RQHeeHPbWdbQ+Y9ZKjDbRrSzS8+hhI4DtE94axvYrvdTYTFyww1e22v12R19TIMw
        +D0EMdKv3C/uc2Kk33dMKjpj/ZcZh+Y12S4EIWo2u1epvIFQ6ftUr9JiTTpffFlc
        hgAtJqPohM0w7+ln7O6R2iiTv5JG1oSXN+WNPgPy9iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CYpq74
        jijYigs+yUJvwYq2iXL4iR0X0K3wAHbtNjmOg=; b=EQZCQ+Hlk/uJ+PJLFRP7wE
        qIxmAGtHdvzvA/z4qzcP9b6k79iiIsuxolm8aPTmSOTLQLlgBD1Oejr89mnxYSQL
        jaOsIQRZxBiPCuLj+U6xlaCiccvSKBCo4U6AWlSYBYZat092aYupuwxYBHHjlFiC
        xvZloNwKDdgwwjodlqMFcW6Zs9ouXB+nVRL3hYkLFXnZ7ryxGlCaVSRrNIjK/ksj
        CArQlFpnLN2rS4G77dSWcFyMFsoD+iCSyvIK+1PXYu3H6c5bE7oPv4tGCePl/HMp
        wbaQNm3+X1VdPhAd6sZPxAbF4FmkgIer1YlP9NXFr7mcw8kSTPT2cC1YvSaE+yfg
        ==
X-ME-Sender: <xms:1l1PYLupErNFzTStM0YRj78cfY7-FA5dUPh6_vwYP-uMpWK-C_bDBA>
    <xme:1l1PYHZlBDUVSRUasqYHysnm1ND2AXaN3rtH5NOxmfQHQW2Mb0SABPVcbZkNajh2S
    p7CLVKcuHdWXhtygw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrleeirddvgedunecuvehluhhsthgvrhfuihiivgepjeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:1l1PYNyt13BX1kBp9gFc6AAVKBZHMtk4YTBRMZiMaPXOWjjxSm6WXQ>
    <xmx:1l1PYPiypt9dvy-EpfZ0_0oVERReXmKiZUpx87d0867CNOwaQlbvpg>
    <xmx:1l1PYJnfqPYCgR2jCIWuSwMzJbfHULed-2eya3VVIUMBUTQfxKmhhQ>
    <xmx:1l1PYMAXlG4svySUZ_HASrlT7x_rROsbCfxGH1spyJ1UukWCjDAKyw>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4DA391080068;
        Mon, 15 Mar 2021 09:15:01 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 37188f0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 13:15:01 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:14:59 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 7/8] pack-bitmap: implement combined filter
Message-ID: <fac3477d979058da0430b974a34f7c7f866bf456.1615813673.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GfN96pOOTnXUjesb"
Content-Disposition: inline
In-Reply-To: <cover.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GfN96pOOTnXUjesb
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
 pack-bitmap.c                      | 40 +++++++++++++++++++++++++++---
 t/t6113-rev-list-bitmap-filters.sh |  7 ++++++
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 196d38c91d..e33805e076 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -925,6 +925,29 @@ static void filter_bitmap_object_type(struct bitmap_in=
dex *bitmap_git,
 	}
 }
=20
+static int filter_supported(struct list_objects_filter_options *filter)
+{
+	int i;
+
+	switch (filter->choice) {
+	case LOFC_BLOB_NONE:
+	case LOFC_BLOB_LIMIT:
+	case LOFC_OBJECT_TYPE:
+		return 1;
+	case LOFC_TREE_DEPTH:
+		if (filter->tree_exclude_depth =3D=3D 0)
+			return 1;
+		return 0;
+	case LOFC_COMBINE:
+		for (i =3D 0; i < filter->sub_nr; i++)
+			if (!filter_supported(&filter->sub[i]))
+				return 0;
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
@@ -932,6 +955,8 @@ static int filter_bitmap(struct bitmap_index *bitmap_gi=
t,
 {
 	if (!filter || filter->choice =3D=3D LOFC_DISABLED)
 		return 0;
+	if (!filter_supported(filter))
+		return -1;
=20
 	if (filter->choice =3D=3D LOFC_BLOB_NONE) {
 		if (bitmap_git)
@@ -948,8 +973,7 @@ static int filter_bitmap(struct bitmap_index *bitmap_gi=
t,
 		return 0;
 	}
=20
-	if (filter->choice =3D=3D LOFC_TREE_DEPTH &&
-	    filter->tree_exclude_depth =3D=3D 0) {
+	if (filter->choice =3D=3D LOFC_TREE_DEPTH) {
 		if (bitmap_git)
 			filter_bitmap_tree_depth(bitmap_git, tip_objects,
 						 to_filter,
@@ -965,8 +989,16 @@ static int filter_bitmap(struct bitmap_index *bitmap_g=
it,
 		return 0;
 	}
=20
-	/* filter choice not handled */
-	return -1;
+	if (filter->choice =3D=3D LOFC_COMBINE) {
+		int i;
+		for (i =3D 0; i < filter->sub_nr; i++) {
+			filter_bitmap(bitmap_git, tip_objects, to_filter,
+				      &filter->sub[i]);
+		}
+		return 0;
+	}
+
+	BUG("unsupported filter choice");
 }
=20
 static int can_filter_bitmap(struct list_objects_filter_options *filter)
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
2.30.2


--GfN96pOOTnXUjesb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBPXdMACgkQVbJhu7ck
PpTZ2Q/9EGKy2xT9//3TZzuKXxgteeBePj9rJc6Ks74Ui6A7zdkQRqYYxVQMW+2u
7jOLHko20CJsGzRd+nMPs/2DXf0hIPKE989gLzXLk1iKlo5LR9D2zdRCvxLoqzQR
zeA0Eq99W585DOmObRAG+ytdDUWd2gr9h57BcezVibmmS+VPv2gx6cAm6dsXd4RB
8w76sFUntA8YTKt9yejU0Af+vWkG4Q3GrYL/p2ovAIF0cyzO4Qsc9edG4+wxDgY/
8ZK6rb37+rUcDRBq8faQ2ja4IakNw733kke/dNj5UmpPinMFuN0QHYiHdmWONLNg
jQBOryUoOYtecAItpDblKO8Vr3r8qQMPxqGWEgj8+NKQe9/sY4arMixQcCQmozyZ
CmJEePTGjN9mwoXhXaDwQOVgQXho/2eStRGDSnBs65LgAGW+hYYkdNWanr4QJ8CZ
6NtuKuzFmg7QkjKIbAT3HvvRq5ytsx2B2kc/VsEtUre7DmCoML53BjZogiTSFWTi
QmPXYtyqms3RHO47CXXlNpHC12hZyf/yt9TdBPIX5zAN/SU7FwZSotWRkOqtCHHs
cZzSjN2+CsQcXmHj3xa3UDW299ZIUCGy9EtNuJ9WneGTo+MW8MDV0i3dpY1XpzGW
3xZJhgOMpeQNDpzpTzUAIJsUkk0CeOJhV7p9ktiQReowYMFU0Eo=
=uA7d
-----END PGP SIGNATURE-----

--GfN96pOOTnXUjesb--
