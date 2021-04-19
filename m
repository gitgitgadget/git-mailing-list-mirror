Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3153DC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1027B61165
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhDSLrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:47:53 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55079 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238892AbhDSLrb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:31 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 586A8E0B;
        Mon, 19 Apr 2021 07:47:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=51tka3J7eTCF+fhMUrHcNg991fP
        7d5aT18nIRw5XwJo=; b=isFOTT+qZXbSHNc85ckjBMsKowDfUi4oNKTd4e9CB6M
        h74gio+npB3jQbUbUkfLtxx38pDNCoDmYPoTdE0C7BO0o9/BXz44yg8NP74GAeye
        Iy1w5GDg4O9Wvj3unNshTxt8xjatCiez4Yl7nQu+2Ao7R6ZPdHIwQtCMUL/Zn7ft
        fHrTAMpeVMai7hBZNbrxuOzTFknjLiwY1dB3V54RdfQxdR3BGOjdtTIUTaQ47aC+
        mSAaUwQP3W2j5AJIZlj2Hhd8kzXseZgbPYSrR1VE6aSeB0szjjempuVE+GkCAEAT
        CdMv5SrHz1kPUDj4kaOS89FE3vFnnNBVJTSDCyHW1Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=51tka3
        J7eTCF+fhMUrHcNg991fP7d5aT18nIRw5XwJo=; b=bkLj9luyGKOcTThhrR5IE3
        xqRNt5MpjTRm0reEDp3pn+DGRhCyP2N8qFuErJAE5qEhHVI6EgBniP8gUVrbRY8b
        dTCVT0HMp+fOXiVQ9wAy3L69CStJ1oAnYP/K1nFKnD1bqFAI6QBnISiED3wkb8yJ
        2bU+SQnFdxut3XW7ennTNtUU59QYEcHwLBdRE1eUQjJJ+1HJEuJj4Gonk1IZC3J1
        lf8/XnxqmS9WNixqyot7HWbIgzXFhc0aZwNNfXiLPxtMUfzLbO21B7ereshGmI/U
        zDVrmp6OJj8oI99aZweg0S0hHr1AM6SEV2NpAXiD5P2u1qlkgdmBT+yzTGrjQquQ
        ==
X-ME-Sender: <xms:tG19YM4ITs6fZQN5IEQZvNKUvb1jWajbHuk8hf85C5zQjVaA_r5YIg>
    <xme:tG19YN7vAP2e4UpSKz_1BGzWqdH4o8D2OR6-hoDDBGImFH1ausOp3fylXMRM4Ei-o
    yHs59F4-wop-u8EEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tG19YLft7yzAo86X60YSWo18aXJDCG46Qok95aiswY_tW4A-Q0yGNw>
    <xmx:tG19YBINUs01EK30fzlTCy0-KCuNFCpWN_V8j8on2rmXquN_kWrI3g>
    <xmx:tG19YAKBiQheogKoPNovw-XmU6s0V4J_Ydmal2YzakZK_2_s55aC2w>
    <xmx:tG19YFGfG2tsKPejKwXO1oVUgzrzAs227CuMv2DjUyh_vGDdSCnqeg>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id E45A4108005C;
        Mon, 19 Apr 2021 07:46:59 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0434d6bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:46:59 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:46:58 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 6/8] pack-bitmap: implement object type filter
Message-ID: <90c80c1efad7974d5f1d87970c0c7918c06808b5.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/F1NKMz18jQ/gc5N"
Content-Disposition: inline
In-Reply-To: <cover.1618832437.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/F1NKMz18jQ/gc5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The preceding commit has added a new object filter for git-rev-list(1)
which allows to filter objects by type. Implement the equivalent filter
for packfile bitmaps so that we can answer these queries fast.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c                      | 29 ++++++++++++++++++++++++++---
 t/t6113-rev-list-bitmap-filters.sh | 25 ++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3ed15431cd..e419f4206b 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -780,9 +780,6 @@ static void filter_bitmap_exclude_type(struct bitmap_in=
dex *bitmap_git,
 	eword_t mask;
 	uint32_t i;
=20
-	if (type !=3D OBJ_BLOB && type !=3D OBJ_TREE)
-		BUG("filter_bitmap_exclude_type: unsupported type '%d'", type);
-
 	/*
 	 * The non-bitmap version of this filter never removes
 	 * objects which the other side specifically asked for,
@@ -912,6 +909,24 @@ static void filter_bitmap_tree_depth(struct bitmap_ind=
ex *bitmap_git,
 				   OBJ_BLOB);
 }
=20
+static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
+				      struct object_list *tip_objects,
+				      struct bitmap *to_filter,
+				      enum object_type object_type)
+{
+	if (object_type < OBJ_COMMIT || object_type > OBJ_TAG)
+		BUG("filter_bitmap_object_type given invalid object");
+
+	if (object_type !=3D OBJ_TAG)
+		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_TAG);
+	if (object_type !=3D OBJ_COMMIT)
+		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_COMMI=
T);
+	if (object_type !=3D OBJ_TREE)
+		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_TREE);
+	if (object_type !=3D OBJ_BLOB)
+		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_BLOB);
+}
+
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
@@ -944,6 +959,14 @@ static int filter_bitmap(struct bitmap_index *bitmap_g=
it,
 		return 0;
 	}
=20
+	if (filter->choice =3D=3D LOFC_OBJECT_TYPE) {
+		if (bitmap_git)
+			filter_bitmap_object_type(bitmap_git, tip_objects,
+						  to_filter,
+						  filter->object_type);
+		return 0;
+	}
+
 	/* filter choice not handled */
 	return -1;
 }
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-f=
ilters.sh
index 3f889949ca..fb66735ac8 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -10,7 +10,8 @@ test_expect_success 'set up bitmapped repo' '
 	test_commit much-larger-blob-one &&
 	git repack -adb &&
 	test_commit two &&
-	test_commit much-larger-blob-two
+	test_commit much-larger-blob-two &&
+	git tag tag
 '
=20
 test_expect_success 'filters fallback to non-bitmap traversal' '
@@ -75,4 +76,26 @@ test_expect_success 'tree:1 filter' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'object:type filter' '
+	git rev-list --objects --filter=3Dobject:type=3Dtag tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dobject:type=3Dtag tag >actual &&
+	test_cmp expect actual &&
+
+	git rev-list --objects --filter=3Dobject:type=3Dcommit tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dobject:type=3Dcommit tag >actual &&
+	test_bitmap_traversal expect actual &&
+
+	git rev-list --objects --filter=3Dobject:type=3Dtree tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dobject:type=3Dtree tag >actual &&
+	test_bitmap_traversal expect actual &&
+
+	git rev-list --objects --filter=3Dobject:type=3Dblob tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dobject:type=3Dblob tag >actual &&
+	test_bitmap_traversal expect actual
+'
+
 test_done
--=20
2.31.1


--/F1NKMz18jQ/gc5N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9bbEACgkQVbJhu7ck
PpRvbBAAqKtNQ8DlVKWDACTd5GCfASgrwEnUFcPXbzy8i+PwGgpjAxO0hfMDLVL7
OZwE6Nx727VeeJTfXy+xFV6sts7DM4UDF/xT0mjIulBaf4965Jg6oQstQ3NVbNdA
QndxdzaVucxhVV6RQSRPjTDcV8wEtZV51OJ5/R7HoVOg2UM2kJhGWMaW5kfo67q3
vY0Ai/de0a1VVa1gwjD5K3mT5Oh3xneKOmlG+x+ouoTXChCcYd2wrBPS8SqZxusA
+WzS1rVDzr/Qz0FHun6AdI3wnoWXY7pa1u7pPj627ydphK40hO7TGOeW89lq/J7n
kwtVeYD69tR+kSMpCJ/Ta6H7X7DBVETyXfgtffPkKf3r1DOSvAAdPo72ATK6LJhd
/T8bRdC+eanMFe06rm7n3BhsJlDrIWggPfZ3zkCrlw4wGdAlAvCur7DUgXuYgzdI
LdxfgEja51qRt5JJ6pNrXumyP3dQQVbsvGLlZ7iUJKKvizUAC64WSshgHCuytu5a
QQzzgaOhf3hLLmqxDBwo3+KV6A1cuMKU+CVz3a0xG/ToyF5MlU8dVHzGpuqBDGDm
s9yZgydXTfn1y/ibhg+gfyu/8UUmmJo+6fAwp3y8dZP8KMGe9zRae5JjmM9IpoAS
+716F+stXgMKjrWmpYSBHg2bIKhIGHXWyGYIgKASH3dz4ZbsGAo=
=bVhS
-----END PGP SIGNATURE-----

--/F1NKMz18jQ/gc5N--
