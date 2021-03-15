Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415DEC2BA1A
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218C764F23
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCONP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:15:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55021 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229735AbhCONO6 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 09:14:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D7365C0181;
        Mon, 15 Mar 2021 09:14:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 09:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=CO8sHZpWCOvOkCZLg12P0W2i+uC
        a8Yy9gmypQy7z53I=; b=dj0No030ZcjKlIjoznC/CNf79z5MJeXMkWVTlZCeEtX
        KNzh8Zil1I2JwsY1lltuJKapB+I2Z0k8a3La4nuyXcK1IqGPYXQ3CYJSxLmlvzkV
        AIAilX3iRx/LT6KpUKVh7NXrZmKkXPzfFhmTrEGyrgY7hgbUW4P6F09PxjZ3VOn4
        aCy9wkwdrDCGPtKiaA9pt3fjfA8zAvFszLpghYV88VywaS8T+y6zMbHTq+lfst2r
        K/xAmoRTwRjWl4BUHGISKtKYmeuQ/u2aHPOVLE/u8GUhQzL03X8QZhbqKYG+1RgC
        cXdXPvvnfQRWYijqyd3R9TD6c7DK6gNQPy6JohPdsAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CO8sHZ
        pWCOvOkCZLg12P0W2i+uCa8Yy9gmypQy7z53I=; b=lTzUW0VUjmm3pbuk5jPKAC
        m9qrLOZtbrbH0L37d8+/fglIHNiQIYYXPOYLGt4VaJCUMDxIzQmngVlNuXPVOnje
        kitMI0PewT+fbF06cqS9tDNeI6kLcUMetLKNZcC6bCNuo/vWpNAlMSBLh788Iv9m
        C9Ooc8K3b2Vh3OQTeIScMt5D4hNL9JMMnYc7Qa29w/tL2F4uDmr7wwVcz3PLUx66
        2aHsGc1xT2OisqFCZcBOjzjg3nxtlJByRyQn+64A9/gjY4FdnUrGjIgWen80D0nj
        2hqN8dSBIcaTfhayUHuT3gA+rwj7IUcUEAsI2iZSJeQghMy5L3sVX5Cw3gWZmvVA
        ==
X-ME-Sender: <xms:0l1PYFwxl4XgnEqgDOFDNcaN8McOq1btI54I4QmuRaQ427vEbeFIQg>
    <xme:0l1PYFTIfkjzETBpye8-Kj3mC5d6c9QTSe-AcY49asTLgLtqUdF8xmXZ-Ya2P6gUY
    fFK3s5beecg0HQ6OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrleeirddvgedunecuvehluhhsthgvrhfuihiivgepheenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:0l1PYPUbx0KtqByHJDiZVyIX59WpMe81nD6Nfo-ZZZ4WB4BIv77pAA>
    <xmx:0l1PYHhxpNLjXB15qMN9ullimOsNMKdnp0TVmaJl4fHJcr8r1Jq38A>
    <xmx:0l1PYHDk2VRKgzauYr28KQ4U8WOHWsYi269fUSBOgtgPmxLjN6kpkQ>
    <xmx:0l1PYM4zW1OhPsayIg_Qa_Fy_5kQ74_qL4sqj0V6WhWFivS_SPBrfw>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id 705A61080067;
        Mon, 15 Mar 2021 09:14:57 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8e93f94a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 13:14:56 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:14:55 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 6/8] pack-bitmap: implement object type filter
Message-ID: <8073ab665b07cf653478482f801a06e072233230.1615813673.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="plESwGU/yN/XdxGN"
Content-Disposition: inline
In-Reply-To: <cover.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--plESwGU/yN/XdxGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The preceding commit has added a new object filter for git-rev-list(1)
which allows to filter objects by type. Implement the equivalent filter
for packfile bitmaps so that we can answer these queries fast.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c                      | 28 +++++++++++++++++++++++++---
 t/t6113-rev-list-bitmap-filters.sh | 25 ++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1f69b5fa85..196d38c91d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -779,9 +779,6 @@ static void filter_bitmap_exclude_type(struct bitmap_in=
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
@@ -911,6 +908,23 @@ static void filter_bitmap_tree_depth(struct bitmap_ind=
ex *bitmap_git,
 				   OBJ_BLOB);
 }
=20
+static void filter_bitmap_object_type(struct bitmap_index *bitmap_git,
+				      struct object_list *tip_objects,
+				      struct bitmap *to_filter,
+				      enum object_type object_type)
+{
+	enum object_type t;
+
+	if (object_type < OBJ_COMMIT || object_type > OBJ_TAG)
+		BUG("filter_bitmap_object_type given invalid object");
+
+	for (t =3D OBJ_COMMIT; t <=3D OBJ_TAG; t++) {
+		if (t =3D=3D object_type)
+			continue;
+		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, t);
+	}
+}
+
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
@@ -943,6 +957,14 @@ static int filter_bitmap(struct bitmap_index *bitmap_g=
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
2.30.2


--plESwGU/yN/XdxGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBPXc4ACgkQVbJhu7ck
PpSRihAAqZJ1gBKLVraDmYqafs3X19UtEXo4UjDLwA8In6s/eqsZ695MfQdaeNz4
+Q5BCjZWE4NcyfEvL4heEgqeKAA8k2dCnLDCZ9NN3+Q70UxEn9hdhMDhu5px4Ewa
2Kwrp86BZX7UBv3vFSi1+hQ5GwJpIPpdTZvsbWlOi9nu9nQXJE5VYec/JNFk8PN5
ksh89Vp6AROPo3oQGE65nl6NdLX7guTowhQByiYGuWFlRsAus1HiIXXJwyJIYhMh
LRkpxnq1+VCqcQGZpFFzv577UUcWNVxzeKNub5jpffOFi80eW/c4D1FItI+99K9N
6FMSRyF61hV6zoJE2A6Jb6CCJkleWdSjmCuPYcHoOwNE/6+tOsD7SQ3nkNbYRu8d
JyWl2J4o1usYbC7IKPQPQ633rvt9ReyE503JKJVK8PufrEw1dKq9JNXPBSdYuP7L
FkOSFEDFkNCiMAYk/j0SiIJtK0Wf2JstRc85t59QmeIdVpuOn/VIqZxZNOpKjHxf
jbNJey4fC1ROv8cg+l4mAwtEuAvf4cByZSj6NoxOylPjmkTtfM+jcrfv9uhDh/FK
umrkF6DcQfXNkdlP/cPaJQBDdXKt9qHzwxJXot84ToAnQtulkLYJ0fqc6/HRdOGR
arghv0tWbfizWoSD3UI27p16hJfhiwxtoFPH8sOdlNSzfKnaOhk=
=4kqI
-----END PGP SIGNATURE-----

--plESwGU/yN/XdxGN--
