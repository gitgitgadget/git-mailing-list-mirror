Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8D0C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjDLKWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjDLKWm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:22:42 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F907283
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:22:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 73638320097C;
        Wed, 12 Apr 2023 06:22:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Apr 2023 06:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294959; x=1681381359; bh=LQ
        70rqnUoiQi4wFNiMWsX2f8kMeTMwBL42W0t9o6pvY=; b=SrL7PIHWlJMoOheAt+
        JY9fCikZNW1fG29UDT+aVNEvem5cNi+X2xxOCY/e8m/sWVFQCfiRmk3iBq2X5f7O
        g7ps9T7SC5362kg3rFvdwy/iKhvPfTqCRUTy8DviRujn/G4eO5zO6+R2NEST7dU1
        /twm++Nir4+d79LUa2FbuAtnWKCoPYLwfceuxonX/wijEwkEQEUO06+i/urjfXtz
        M1Iljt4uyJDO4vUmE+4t+rTQIucSXdCn0xse6Y223vpKboYf+rDuv4JWJSnHjJRT
        bqDaJy7Ct4d/g6g5kvrX27bukd4FrJzzACM9muvQdZ9qMsAoLLwz5mofzr1cdZfM
        K7Zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294959; x=1681381359; bh=LQ70rqnUoiQi4
        wFNiMWsX2f8kMeTMwBL42W0t9o6pvY=; b=Pc+vWFI1tU/3Uu+gNr46Yftojhx1+
        /unqJBOrKhycli/nD2R3M9YCGOZ+zz9WEts0xvN4j0LuSwjD469xvJdlb4qxmP/8
        kLnPA7IBA6cmV3PUo0A8pxb4dCCNRXtfjnA3EI/WTKzJTnKH2sVmsE6F34sRjiG2
        nCSTSYhsO21VVrRSjYBk5BCLIlThPc0j7uua9rmycbutFteM7OHK6RahGqf5nKFU
        i8OofoBcxVdN5SoiDoK6unto8gv945YIsyAMn/m1hVHHWuemckvLdEG6B2NlYkUy
        O0Z51OF7AeUcsE8SxfWoqTs6++kFlCQ7lGS70370RC94aQMJ0xhOI5FCQ==
X-ME-Sender: <xms:boY2ZGCrnFOfR6d4JmHu_dBmbcwwndnVNyjqEOzTUw9glaiJYfsCjQ>
    <xme:boY2ZAhUI-AD5l32MDfZcbXoTxMgO2v7NGRT03npwpJ_ImanSiNav-CsHytp9eIDK
    z43UDx76kEV4Ttzqg>
X-ME-Received: <xmr:boY2ZJlPSouQHOUe4Oen-uf_EYedCidwGnV2tcfxrSMb_H9jdWpf_aol68sl5oMPCDZlzb66zaAeOJvo4oWki8q7-dlErJhwraRTZ7Mnbtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:boY2ZEzGFmbhBZHOohYPcY5rx30Qrmmq-NWPeCS7ioZybXX7irOpLQ>
    <xmx:boY2ZLR6LuB0SjQa-N89TovAhQdw-bJllriR5igpg8hYuF1ie6ujaw>
    <xmx:boY2ZPaS3uzNnBa3l0huvqeVBEuoyc1bJmxX-mQIh1zw-6o0HpPvDg>
    <xmx:b4Y2ZGeqAgl0HUZcrVM4f_aF7YZTzfVzBiT6iG9Eunz4fXUURGucYQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:22:37 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e730a906 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:17 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:22:35 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 2/8] repack: fix trying to use preferred pack in alternates
Message-ID: <011b08f3b64f264e3abbe8b49ee5338c221badb9.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hLuHyt3cvfxDURY9"
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hLuHyt3cvfxDURY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When doing a geometric repack with multi-pack-indices, then we ask
git-multi-pack-index(1) to use the largest packfile as the preferred
pack. It can happen though that the largest packfile is not part of the
main object database, but instead part of an alternate object database.
The result is that git-multi-pack-index(1) will not be able to find the
preferred pack and print a warning. It then falls back to use the first
packfile that the multi-pack-index shall reference.

Fix this bug by only considering packfiles as preferred pack that are
local. This is the right thing to do given that a multi-pack-index
should never reference packfiles borrowed from an alternate.

While at it, rename the function `get_largest_active_packfile()` to
`get_preferred_pack()` to better document its intent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 21 ++++++++++++++++-----
 t/t7703-repack-geometric.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index df4d8e0f0b..9d36dc8b84 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -448,8 +448,10 @@ static void split_pack_geometry(struct pack_geometry *=
geometry, int factor)
 	geometry->split =3D split;
 }
=20
-static struct packed_git *get_largest_active_pack(struct pack_geometry *ge=
ometry)
+static struct packed_git *get_preferred_pack(struct pack_geometry *geometr=
y)
 {
+	uint32_t i;
+
 	if (!geometry) {
 		/*
 		 * No geometry means either an all-into-one repack (in which
@@ -464,7 +466,16 @@ static struct packed_git *get_largest_active_pack(stru=
ct pack_geometry *geometry
 	}
 	if (geometry->split =3D=3D geometry->pack_nr)
 		return NULL;
-	return geometry->pack[geometry->pack_nr - 1];
+
+	for (i =3D geometry->pack_nr; i > 0; i--)
+		/*
+		 * A pack that is not local would never be included in a
+		 * multi-pack index. We thus skip over any non-local packs.
+		 */
+		if (geometry->pack[i - 1]->pack_local)
+			return geometry->pack[i - 1];
+
+	return NULL;
 }
=20
 static void clear_pack_geometry(struct pack_geometry *geometry)
@@ -591,7 +602,7 @@ static int write_midx_included_packs(struct string_list=
 *include,
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct string_list_item *item;
-	struct packed_git *largest =3D get_largest_active_pack(geometry);
+	struct packed_git *preferred =3D get_preferred_pack(geometry);
 	FILE *in;
 	int ret;
=20
@@ -612,9 +623,9 @@ static int write_midx_included_packs(struct string_list=
 *include,
 	if (write_bitmaps)
 		strvec_push(&cmd.args, "--bitmap");
=20
-	if (largest)
+	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=3D%s",
-			     pack_basename(largest));
+			     pack_basename(preferred));
=20
 	if (refs_snapshot)
 		strvec_pushf(&cmd.args, "--refs-snapshot=3D%s", refs_snapshot);
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 8821fbd2dd..92a1aaa754 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -281,4 +281,35 @@ test_expect_success '--geometric with pack.packSizeLim=
it' '
 	)
 '
=20
+test_expect_success '--geometric --write-midx with packfiles in main and a=
lternate ODB' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Create a shared repository that will serve as the alternate object
+	# database for the member linked to it. It has got some objects on its
+	# own that are packed into a single packfile.
+	git init shared &&
+	test_commit -C shared common-object &&
+	git -C shared repack -ad &&
+
+	# We create member so that its alternates file points to the shared
+	# repository. We then create a commit in it so that git-repack(1) has
+	# something to repack.
+	# of the shared object database.
+	git clone --shared shared member &&
+	test_commit -C member unique-object &&
+	git -C member repack --geometric=3D2 --write-midx 2>err &&
+	test_must_be_empty err &&
+
+	# We should see that a new packfile was generated.
+	find shared/.git/objects/pack -type f -name "*.pack" | sort >packs &&
+	test $(wc -l <packs) =3D 1 &&
+
+	# We should also see a multi-pack-index. This multi-pack-index should
+	# never refer to any packfiles in the alternate object database.
+	# Consequentially, it should be valid even with the alternate ODB
+	# deleted.
+	rm -r shared &&
+	git -C member multi-pack-index verify
+'
+
 test_done
--=20
2.40.0


--hLuHyt3cvfxDURY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hmoACgkQVbJhu7ck
PpSmvhAAkq53y8wVg5xy9HvJGBQ7EBhaOpyzWSLDK4s5RNu6U84YG3F78z4zRfHl
rTwDRm4nQe/8CpGxmNbeHJVTDPQKQkL/pNVQbQQexmPVDq//eqXv+e7koYneQ8Vp
dRFykXzynyo4Wu7a6QJgUAQL4i92y/AWHIeY8SxAqbOOjbEKV6PEGaJ/vNn2L4Dj
uJkZUYBLlq6K9qnrjId20Ns3b6n7DGOP9f/c3mbCvMrr3g20m/e628jvcf7XNdtu
ojiAcbFCQJdO8aYd0IzzYJxpx398xIyLvAoqfNtyGdRp3BxOt2Y3IUxtzlDQLYry
JercyoMbe/PMpzMNtgvuow/1ifSYh1P7tS33arrV44TLswNAhW3I32kU2V1cR3CY
I1u697rW1Trk2ukq8g/o9BU3nBc9T9pHPXYiftuNXxXuJe1WotZF1phMyb/EIPfX
1cB+UOE7i3jb78iBme+HFTBrc3aX65pu62DMUbp7acbj4fVxic/pgXdYo4nLEU7i
OBuVf5tEzt8SbQFVu5Dw1fZfDCQKExplLneXP9Cdz8Z2rf/X86kMWyky+ugFPNFa
nLbI6JZDgQQL+WfTJ0XihiBk26KNqOy0Iy12kMJxZB+M23aZxacjxyzillw7ajd2
76aFimpZ1O+EtzOcdWPh1jqfBwwT3hfPt2jSjE3htHRrXJodjGI=
=0u0W
-----END PGP SIGNATURE-----

--hLuHyt3cvfxDURY9--
