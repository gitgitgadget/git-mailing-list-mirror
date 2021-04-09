Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220AFC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04E761108
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbhDIL2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:28:33 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55429 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233629AbhDIL2c (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:28:32 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 75B6C5C00B5;
        Fri,  9 Apr 2021 07:28:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Apr 2021 07:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=57YpcIAe/DWtOj5HCNhv4xd/9yD
        2lFb51gVa2UMeasU=; b=sAk8Ab4vqdyg8EzmEQDW7i0gH2hgX75S3VX7V8iECbG
        FQrd0PZyTAhgrY+Jvz0CUR0yltfPrP3XvDb4A1nTYqprPthQ0aEgBqIRsh17F5Lp
        D6m315pWYvgdSi6f2JbSMeKKFitKDsthkCdMVhHs0953RRFWuyTjKFq1Ny3O5ZeJ
        G+lcSDQuaL7VulpDF6uBLz7Aa3v8dU+o3ZqvcoOvFU0VpenCweejUEMdknh5gLeB
        4prqzTOOeWma4+n6OUkLolzwxRSLMVON+NLlNCpcn/Ks80IBdakEFg7UVfehfUjG
        Wq97y6rqFqf+nqvOZQxp08oA65FKpxtZ5Uj1dj3sJIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=57YpcI
        Ae/DWtOj5HCNhv4xd/9yD2lFb51gVa2UMeasU=; b=EMq9N6efmCmQIls+yDZRPB
        rLL2aFGY10qUzQAo92UzreMRElcnc76+vuFUXcvaY2IywrgtFBGY8S9wMKiqdcPw
        hTr4QllLIb9S4pubbrGfCZdYZja5ZF4M18UDwy4KCp5BbWWt/9SIq9i3NKb6FOkg
        eIKcoWQQgrzKkYKb5BdHCuM8DMN8ijcps585vnLAl/SEvYRUxPX5voBttTL1J95+
        Dhmn/rPRALtCV/TpyFo62BMMYRd0Y7hoIfD32ReRgYU9WlC1bBkF1pppSt/CR4rR
        ZZS0VRtUsv3pdP7dFYx+++cEhDl5PfJjD+4bUTQ8aWCh/iQjjNwjOB0BVO0qldNw
        ==
X-ME-Sender: <xms:UzpwYGaf65s4y5gSkV7cnMOGfD_WAybHHHqIH8czVLLS6Y_b0j6OVQ>
    <xme:UzpwYGHOOoje1tBSD9ruEQawZASUo7SHdmE4xydejW8bQuwdsPnssFyKCsfy4xg7e
    BuKlGi4D7Yfuoecmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:UzpwYE3ozq_mOWFIX3oHTSSG0vNP5Al9iuNb157rRhegRFbBRmPxbg>
    <xmx:UzpwYCwKkEoG-EcAeYIXQ8XClqC1iPfwGTeTSBf72-7A0EO1ZGukZQ>
    <xmx:UzpwYFgqf3jYTyrlxFRA9ZNUHEjgCdxh34EWIOaBigHRQulDxZsjnQ>
    <xmx:UzpwYI_iNhjUVeFGH_sb6btuFJWvG_6DRqLociKhFI2YgCqKAZZ5Rw>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6713240065;
        Fri,  9 Apr 2021 07:28:18 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3ff22a19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:28:17 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:28:16 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 6/8] pack-bitmap: implement object type filter
Message-ID: <46d4450d38231d1af0b17c4855b9671ad3446aef.1617967252.git.ps@pks.im>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HOKwriVWpsFa2r9s"
Content-Disposition: inline
In-Reply-To: <cover.1617967252.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HOKwriVWpsFa2r9s
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
index b4513f8672..cd3f5c433e 100644
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
@@ -911,6 +908,24 @@ static void filter_bitmap_tree_depth(struct bitmap_ind=
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
@@ -943,6 +958,14 @@ static int filter_bitmap(struct bitmap_index *bitmap_g=
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


--HOKwriVWpsFa2r9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwOk8ACgkQVbJhu7ck
PpQcUg//ZsmsKyZ/Mq1RMOnSxyun5VAX098b2dVuwwq+bT0IbIkMZcU67EOIGQdJ
HbA1qjutjUF220AwJHsRCNvk9bs0ObFmml1lPzhrANGH5hRJuUlraZqjgSTwSMCU
9kpDMA+JgPFaeKp1tiP/M5Du0sW/IuFm2j7LLFwTlsRjCq9wSH48AcpQpHrelR3p
hhwjfCMzofS2b1uRuk1gV9C4u68rmIgiIzigVy1C2UbRJS97WFaSqwhX9c1Nm3xH
zU5yTFMqB9HB7PrKYv4sA3iBDA8/XoRxNSlSmLxLF+Cha5dXEYrIJy8Ak87Zc2Ff
2aIhxCvlaU2N73jEUqwfsxAFlbWYhiEDNlxiCufifksxaH6c0w9RXpiTl8eC0AbI
ldNGCF2hM2deE2QBTxL65vIx1xHCnc71smYqkDLUVuXANT9kfkOS65pC0TrpeO7C
YUWAOqHGUbf6jlNXbPppxkvHQyzoOsZDvEG3C7JRzmI7RTNLyBd5BdM+e7HFeA1z
gQp8x4uJK3+IWqwqF4FZpEdhxIyDdUU+s10YK/LldbTDChBN782leFD/tG+FYxOo
c4v1Pnpai+2ZI5w181DISrwDBwWMnlx8VE6lATw2u7Wne2e56MYj3SnP8R/tonuQ
LqBi6h16YeHrYcXjTrppBhUilu/8VK6JFT5hjxKIj0aXKtfRWRY=
=zGtR
-----END PGP SIGNATURE-----

--HOKwriVWpsFa2r9s--
