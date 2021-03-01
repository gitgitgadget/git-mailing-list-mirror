Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC0C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D92F64E31
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhCAMWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:22:19 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46577 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233527AbhCAMWT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 07:22:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B22169C2;
        Mon,  1 Mar 2021 07:21:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 01 Mar 2021 07:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7hvKXCeuliUe+Sz4hQ0vOhe4psM
        aAE1nTB2iz4pkpa8=; b=Hz7+Qm6R1FnmaBmK374a1BzqNb3tUtPQRxeodjM9Vbz
        YEjObkwlv0+YWUTVWeRCoOpERRUKWoPai+oTMaZtWjXBa2rdIXTrr94OaJmzmRP/
        BIkTYryqOG7kOT7W0yHn8Ld0z/fSob4eLUo8sF0j+AxQrPPevWea9k0tp75RpFzM
        L6Ee0oXa+K+s+XQmBBNu3p+0fhA7wcEXhFv2d/AQAm2JXENW1HRndUzPh0rKa8uo
        2niU8HxVLeCf+lplmkfHHjTCBw36GXycwiNSgaRV3th6RQFiw3U35VpqDQ4wDplC
        Q5LwSNoENs6kfGWmGSey8aced2x1NPetUtAhEFcKBiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7hvKXC
        euliUe+Sz4hQ0vOhe4psMaAE1nTB2iz4pkpa8=; b=wqNj/+qNHZWZ9fc6f4/djq
        Tym7y8v/TPUE4pzEwj2H4t2PQ9vs6HprSwASihu7z4Ggw632TVHn7BHAmti1/tVL
        hQIt4H3eUzaPTFzV00BD5jYcdpoMl8WrkmZ/VLrSgNZZt7SQvbnN4JAHa2zxBzCR
        5GRigXjrOpxtHR+D+FZz2SDD1p00wpablw6bnDoa0oZH6JSEpt9/cY35wGc0d/33
        wBfm2aBxVi5v95TjEE0gRL1S1dW0QbMjGR0nQtLzgf+c0ErWbl4c2kXymAioz+fD
        w1SQDZJzfRKzvSOupRME49OniB+2Hy+kAXV13yJp33N+jY0lw4949o1kluuBFR8A
        ==
X-ME-Sender: <xms:LNw8YCOt80He8ed669SXZgndJwjrKk1AmykbCxgqMy9jEkiZQTdwzg>
    <xme:LNw8YKncJtQVa_ijjIUmfrlkdT10Qfc2_BCs6wesq4gnJ01Z76TziUByDRaTrRNcG
    _yy7o16mqVWNJny4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LNw8YJTBaeqCScsRoeJkOtzGWtE4EGheHilw2BjQfD8MgBqPARQ0RA>
    <xmx:LNw8YGBs4NPNnzRhmEFVFZfuyZVVz30XHHM_W8X_O0l_aBANwoTBgQ>
    <xmx:LNw8YIToNukagE97H8smK4yWCSbMneTF7bwL3rDuoJ4UhonQeSOBgw>
    <xmx:LNw8YGvEjnNWdxtqnCZVlPilsB0hpZmSTdxZYtCQaxDT35emwHOKgA>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id E2C03240057;
        Mon,  1 Mar 2021 07:20:59 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5c9e9b97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 12:20:58 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:20:56 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 6/7] pack-bitmap: implement combined filter
Message-ID: <fe2b7a1e552546c7048b42610047847f5948adb0.1614600555.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+MNenEy9DAvHLqqK"
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+MNenEy9DAvHLqqK
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
2.30.1


--+MNenEy9DAvHLqqK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA83CcACgkQVbJhu7ck
PpS6dA//Xjtvpr3Ntd6SmbOZpVTYOPEFN5GW9JQi955w0mKigeSm07ylp9vnFgug
hLWjihOD7BcZIQOx36M5rApyidhh+WOmASNmmrkmcPwiaReZVS5cAocPIxSsUTyw
sGrAZKBsQl3VdTMBOqFVbLnit4sxruexHrY/En+If9wyIgedjNmwc/PHbtjf1JPi
qQ8XMGZqo74MowjgLp/5jM3C0oCMRqwyIZ9YW+otCv9LwmbJ6YVJCulkduY2mLn2
4BkR4kuidm283Tnm3D2ZKsTduD8MBL6XGXUtdPHx5Mr7PnI5mgaQxPVxr190h0Hs
NVRBjwR8b6zjszp1+kvyGrbcJXeQe6uxc/VP8DiW7nbs6+Sk+QwLJvNcNP7gFpxq
2NPhRt8jJUBcm16fviHfSgliIu0fNGkcvlaHeTX9+JdMY9DV9jBZNwgA3tLR1kpR
fUvO05PPSBy0z6XJJ6Zt/Wm5PcNnxSCunjNdyOqgCR5uknax/Gtw25CSTzVB5PeU
EuKFnYGpva9b4K0QJFPLHxMQop5Jjsssq2V6SwB9u7deD4C7lt+ENvt+wGUYm62+
AM4CseEUZ7vDJSac3YtxaRHlK9AN1E9m+aXMCLVKKHtDdQhJW3EUVdOrAROUetN7
hUys/b+nBZTWizDuFOmzGHaiB9TUEdKfp186+Z26u8bnAiX3PA8=
=sZS6
-----END PGP SIGNATURE-----

--+MNenEy9DAvHLqqK--
