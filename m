Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB71EC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A192264E37
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhCAMWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:22:22 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:39001 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234226AbhCAMWT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 07:22:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1F1149DE;
        Mon,  1 Mar 2021 07:20:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Mar 2021 07:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wE4Zhci9BrzUGU/mnn4b5fE3hYF
        2xTGVCGFeRlZOc08=; b=RA2L35wKOv559tT9RyDl4FNxm6VsWp/z7bUxjplaQXj
        sucHnYCcJyjWnNUV9SbHz1xTRekr5LWoyWUaB1CGDVzHtETYuWWjq4cgKWCNo/VM
        Nx6c9wNa4l745R3B4dDSNmWw27lswZa+3kUPOPS+fqS4tylBxMBCEZrZ0xTMFJ2A
        DvsfHe64vxMdgUSQQyFwR/zH3DfXNQoNbZ2yZZ4rBxGwWXLZ/nRzAYlyT4hZJ5yr
        3Y9fOZCGC0RFD1rVGbZaCr3n5sv1vOfMZ1rZkaukalG7wclqbty2mhonufVgt4MC
        EuEnGzRNiljFLdGYD6BvenB8/ZecE/m1fadwqgVvsKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wE4Zhc
        i9BrzUGU/mnn4b5fE3hYF2xTGVCGFeRlZOc08=; b=OrOe9wzTpFCL1efrHonu5g
        jSGHGKabrcBjrjazVSqM/xcXjVdzctGnt8QVckrZ2tvyn0uB7grUEitwF+l2WLhJ
        9YzGkk0ZJt2lWgQQkq0eJS6mqfAgr6qAc1SwcL5OKsedgQWLLB6skT+w3lbZK96A
        TVcQKA+XDaZOemOQKS6fTdW+XOkZtbKsmO89oxkfoTXi0Ayxd1Lt8zMCeYKvnIPw
        lO6EIKLmy60WJOp8ZTBcHMsz4vyhoGuuOr4z3cS5AHfaAJK17zRu0UvlR0J/gwP9
        TM2gwm5lO9Lo55IJRlB5PcMPwvKu0cSUWUalJgCfPTncvT7OB1JTW0XcDbmNpAaA
        ==
X-ME-Sender: <xms:Jtw8YP3b9YF9GsTeA3VdJZFHF1e3WWQTAw46KDyWosDMEZmh17_SSg>
    <xme:Jtw8YOEUhrQ9O70I4-xprs1Fvs6tjMBNzl6gdNnzaGDrArSw7M14FYEmh8xxP0kVL
    cKpq85CefFu8XCUzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Jtw8YP5hpahmyFJkArDRSl8_UzE8CPSKUtE6TLVxGKQg8sX_cdh1IA>
    <xmx:Jtw8YE1ZgEN7ldDNAjEaCg5waIChFoRZPq02rOeNu6QGtCJrdxGfeA>
    <xmx:Jtw8YCH4IGPhxpN-V2kPUVByyDtSFLQjyaMWfliN9KXhOOh9DaCQ2Q>
    <xmx:Jtw8YNyiib8lVJ7b3hha_CVCBoz8F9rP1fkLcE9zzvguLUbdL-RSaw>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4AE1C240057;
        Mon,  1 Mar 2021 07:20:54 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a09cf550 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 12:20:54 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:20:51 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 5/7] pack-bitmap: implement object type filter
Message-ID: <c97fd28d8ff3ef4f5a841e5d86a64e332579939a.1614600555.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jjV6MyRrJ2BG2N4M"
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jjV6MyRrJ2BG2N4M
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
2.30.1


--jjV6MyRrJ2BG2N4M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA83CIACgkQVbJhu7ck
PpRQLQ//RFKztixenK6K1ZQWvsSc77LREYOPDvhF2BFFqtJvKb4V5LMp6EVj+YEc
lkGc8ARVrdrLvWG8X9NuG2ruIjhcUyRD6iczvIsFd9kdHpMnjr9syJQNl7fptUP3
6iXcGnBIpesFbqyUY7fLH1FeEq/oQbXNhUssdMOeI4jr4E5aknLkn1llrupJR5bp
cTgEGYw4ApcafOEEdepicQHTsv4LsV3lzfZuuSTkCJwJ5g3fAkIkYegfICOZuddf
YiIWcb1plEZ/PEigfe+j8VNOyGF+gkUJ8FE/amTntHq2Ln6GJ+05FZBRGqykjkYN
OW8qSE1a4gw0rfgpZI//rPDekLQnQ+o1Rq5JL45b7QKKP4U5cTbsZeRkb2V+Ew0E
GWqqzhqf5/GKbmYjX/rpC4sJ27m0PAaqih+0FeUjx1fBoarZM3V0PS4v6BCvDmEf
RJsIMBjq4RpNGY2Ne6XWvXISK6OWYssLLdVyBvFnSuIa3axRgyH3rmeRSZzwjsY+
ZtRHnCvr0GC8diPqMNTOsnDb4kvwv4FxNuVtKseKEc+g/9WkkVNvbG+E1LkwT5yT
B17FdLKLwc76cGe48jRtdqkvww9lSQza/QGH4FdPqU4q2WMFyt3NheraMAkn+sx+
YPcktHHFxxVxu4iuluIBGCpYgDKbJ3Spmiykebi5t+qnj+DLfgM=
=ZX3J
-----END PGP SIGNATURE-----

--jjV6MyRrJ2BG2N4M--
