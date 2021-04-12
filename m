Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA67DC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93E36128B
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbhDLNiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:38:05 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54535 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241957AbhDLNiE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:38:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E720D16D9;
        Mon, 12 Apr 2021 09:37:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=MfGzchl8ejzqUJAct36DPIA/bMj
        0w1zRuT/YKuASZ0o=; b=Be+hke3495Yjo6NaNKSYzO7tAs4tu+B8m8aK597Nq2U
        r2ooHRgIksh7TFCWsms7d/4LhQDA0/SOuNixxuT9i/I/xfqh6LC4Ru7fKH3MQbNB
        3tQfNEyqy+uqkK4oOtphfEhHfUFCUd3nWmtjcJVlaGJMwT1Cgru6DC8oJ8wHs8Rv
        NhaLk2s4PjXIuCNXwWI138ZD0MH7vBFY6RqoZd7kOAc0IhWwd8OJFL91uBJ0FvRX
        LsPa9pvoSSmSdIA+hsLyEN5nrcxUwIVKLB55u+0XUhujlu5ekU1OeqZnW+5Tsh0N
        MqXCrwTX97BfSurpF6/MWWjSysza4egX3eVbMxDgqxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MfGzch
        l8ejzqUJAct36DPIA/bMj0w1zRuT/YKuASZ0o=; b=bLKpvDYY+UpegRPVbUj8Re
        WEQeycX1Cs2SgCOpx7BUXHfqouUoJ2EaCfH1SWYBvy0Ucva2jI5QYsKvqGS+O0n1
        OZT3YtQMCuWh99GotJTPzlk4ofEHy8GLqL/4pkxVWJh6+qGp2SVG9ZAhpctLfZXX
        QLDvijF9Nive2tJ9w0VcdX7ISdT2MBdbKdnKwXcjV2fuCbVVG4f8w89ldotY3lKm
        H68/W0MXUsX0/cchjGdlM7tNTEpACToLCgp38HrgjeYqAhZ6rCZRXjnhi/khZkdd
        6TSClggwZw6ItufHNWBegVI1ukDZPhbWwvWShh3z2epU/+9TQ+gxVHSi9KA3wLmg
        ==
X-ME-Sender: <xms:KU10YBGsII17l1mQ5Ga6jNV7GAdMdTitBSvFWR2oZkyXIpurGOiAEw>
    <xme:KU10YGWlIhdlg2e4BEpKJ4-PucYZMdI70fX_ZWbgiIlnxbXE6XQeQndwcMXLu5VKL
    bZQev-egdo-L5vVCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpeegnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KU10YDKC1QD3kQVZaV_uf8xDrhGekKebZC-UXdD9ey0b67lSgWFV7w>
    <xmx:KU10YHHH3NSolup9fAh2Px2g5buAR45Q610_1Q1T3vSKfM8nxBJWwg>
    <xmx:KU10YHU1oBMzEf1_KOCzD1k-7tuOzLgu266vGB87tU-NJ9GCOrIf0A>
    <xmx:KU10YEicjipNs_7mn1RcnGWqo2DASV3QwRcVHTb3xFP0PuWZANmWcg>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id AD03B24005A;
        Mon, 12 Apr 2021 09:37:44 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b36a959b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:44 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 6/8] pack-bitmap: implement object type filter
Message-ID: <17c9f66bbcff1f949caaf928102fbab7b96685d6.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2QEbErAYRvogRS3Z"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2QEbErAYRvogRS3Z
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


--2QEbErAYRvogRS3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TSYACgkQVbJhu7ck
PpTjjw//fTpY3d9U8C2R5mcS9AaHqrVIA6TIi+lUbqlWptSG9Ac+jrVTomhLThFw
BHphCZ9MdPm/JjEccWlXbotlBPpAQUVn2Xrbig/05RFSTenm6t9WrxYBHriNdLZR
Qss4Jp3iJyOkJuqva3kbFsPzOr3evZrivmBFtf69UPA74IKw+m/uxeXR6xNcORmr
g5V0hNT2dXepOZd/dh1ZVH8hy3ENd3uZdFu7oiG9/AyWMD8JiseU27dLyAjq2Mqo
6c9qrLAe/bVust8eJOEVtDITJ8vENummkUTheQWgM+vRkFsr/NMYT+v/X8h1kHad
qi1s0a7nRlIS/zvfLzyAQxm/3aE61SGKHjwKIEcy1h8cyIggm+a0woST76/Ea7+L
6/rcSfhssJHzlIuJJew3p6h1M1ufHAGfYFNWramR1XNruV+lyB8EcDFVeqc1e2Qx
XUTi72Ix3iHUd0LaKllW+F/PE1Kl+cQ87JWi5kXFDQJZ2MZmwiNjP3hA+0RFS3C5
HmCU+z2uYIWdpChXxQ3NwVOun819lun6GGYzrXWaS7Zw17RE+Ph982m5agTIyqMa
5nhcEPoWoIzxpjLr5FXXUXgzpbVjx08Fu5SYVLpbheFB+Nn1kY43X9DoxsaXkWVE
83/Vdn8/vBgsu87IXnDXCPXjWam8qk2ZDOOCbl0v4sU9P/la4Y8=
=gzl8
-----END PGP SIGNATURE-----

--2QEbErAYRvogRS3Z--
