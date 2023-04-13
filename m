Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B6C77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDMLQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjDMLQX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A024E93E4
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 08F855C0138;
        Thu, 13 Apr 2023 07:16:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 Apr 2023 07:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384574; x=1681470974; bh=gW
        PRXT63q7Y9UyTU1uylUeB4M2Uhh+kvmwTnBeCnWiI=; b=p1G42qI92NNtUH8ZAk
        ZKEnCxP2abEsl5JCjQIOXVNiwXQmSAFKeH8n9V8Kx8/PpOepv4VQ0lCQPfiGqbcM
        SLsMP9QRBmwAOommtPIANHyEC8ZZV/71eKQnurs33rpNP/Gngh+6xSNJxjPcyn3h
        Oaz5sQ3espP1bOv2NVYCrBv/e9+WpsNAzGBgwPHIAvokmzI6jYvFJoVsdtd6Vu1b
        ylcUoFohoIZRwIuo+xm3bVKgDwOkhBOjekQqiiYW1iM6b+KQZxFuR22oKK0GvN3t
        1DOEkgcI+wkpZJ9q07xCEac/Ernd1W5Jg6wrntlVAwkGwy1PY9O7HA31vDnotjSF
        IEMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384574; x=1681470974; bh=gWPRXT63q7Y9U
        yTU1uylUeB4M2Uhh+kvmwTnBeCnWiI=; b=DH5IawQlTgnipDgeMX9+eQvV43+6D
        IwG9oGwY8jAXwWK3p2I/uvzaAo5mCATB445vp4E1X5lIbSFIjqcu5EyHVf3ydWDv
        FQBhvkYXqlskGq5POD50GRhZ5luPEVAENxF6Z6fmtfeia241xjj9LKUvl969YzmN
        +Z8aieN+yfqZ7dN9UU1MYgc+QHjf/Z/lxCWmlI/OVgTL9kwZVCVmc0yslH/BHXTL
        RXoH+6aIsjKTUhPQa5Mj6L5RLrzU96WJkvdVSqpaRZfG8+5IImhUG7oXoG2yR1Tn
        PBXFX1QdMh2iRk9whAY+m/1Fa/dW+l5GvAefWAWlsxSmaG7WciAa/VJQw==
X-ME-Sender: <xms:feQ3ZKutbgjz4sstWdK6q-TQ19mJtbpip2iCoEQbVw-EyKi7xMOggg>
    <xme:feQ3ZPevwbKZbsS4ITa5AyRt8bMqEsHBI_Gns0AmUuCf6OQq_xwnEX6I41zodMzu-
    D6mwEnJE4dTkGUZ6A>
X-ME-Received: <xmr:feQ3ZFwupIF6_PHWRFQQ0bjTyh7wWZbj4Q7mDPVn80AfY31Jcs9GLrkM_nKfjabCARR9v75TomITAwWJPNHdmiScSyvud-Pyb-0jkBIvz0sHtMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:feQ3ZFPRQX45PZNEUfVXl93ImcfmvnTYR-uSprwwtEto40SSTOdu8A>
    <xmx:feQ3ZK923hKDDQwAFZC5ce6eibynsgY8XCq0ecCuuOcmZS3x3LAD_A>
    <xmx:feQ3ZNVelJPiRqs1PRrJCvRj57myn1X8DjwYGUNZ0wvVPGSUGQuJrg>
    <xmx:fuQ3ZMIKei-FdByEMbSGJBAxPB74yWaX4GTv91jC-ciVYDxv94K6bA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:12 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 82dcf232 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:15:50 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:11 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 02/10] repack: fix trying to use preferred pack in
 alternates
Message-ID: <c5db1bc587701df35f2cb32270ab734ffdec2e32.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/iHh7k078AuzJ+EH"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/iHh7k078AuzJ+EH
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

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 26 +++++++++++++++++++++-----
 t/t7703-repack-geometric.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 87f73c8923..687419776d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -446,8 +446,10 @@ static void split_pack_geometry(struct pack_geometry *=
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
@@ -462,7 +464,21 @@ static struct packed_git *get_largest_active_pack(stru=
ct pack_geometry *geometry
 	}
 	if (geometry->split =3D=3D geometry->pack_nr)
 		return NULL;
-	return geometry->pack[geometry->pack_nr - 1];
+
+	/*
+	 * The preferred pack is the largest pack above the split line. In
+	 * other words, it is the largest pack that does not get rolled up in
+	 * the geometric repack.
+	 */
+	for (i =3D geometry->pack_nr; i > geometry->split; i--)
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
@@ -589,7 +605,7 @@ static int write_midx_included_packs(struct string_list=
 *include,
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	struct string_list_item *item;
-	struct packed_git *largest =3D get_largest_active_pack(geometry);
+	struct packed_git *preferred =3D get_preferred_pack(geometry);
 	FILE *in;
 	int ret;
=20
@@ -610,9 +626,9 @@ static int write_midx_included_packs(struct string_list=
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
index 8821fbd2dd..d6db362541 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -281,4 +281,36 @@ test_expect_success '--geometric with pack.packSizeLim=
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
+	find shared/.git/objects/pack -type f -name "*.pack" >packs &&
+	test_line_count =3D 1 packs &&
+
+	# We should also see a multi-pack-index. This multi-pack-index should
+	# never refer to any packfiles in the alternate object database.
+	test -f member/.git/objects/pack/multi-pack-index &&
+	test-tool read-midx member/.git/objects >packs.midx &&
+	grep "^pack-.*\.idx$" packs.midx | sort >actual &&
+	basename member/.git/objects/pack/pack-*.idx >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.40.0


--/iHh7k078AuzJ+EH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35HoACgkQVbJhu7ck
PpQaBhAAjhh0i/0ilosYDQK5YqsMLnQhbAqZA0ZC41EXoY4bVFmQZrr6Jpa36zLM
KYr7LU1d7Sf8apc/9AcWsPqC41Dn6Tzxh+5y89epQmEm6oLX0dL5vOaUhOPpUmNm
HrUtOJS3keMsxcZWtFqbHhB3XXgyI6GqRhNJ3YGWAFaY+HJZb/JcApFAKRozEDSs
qJD/oHUTzMeACAY7em5HG8yyMS8Q3u1ljhoZ3E9G7jnrZJiSoU7HyHlATfzmF228
pdJ9uORBwOwf0MHKJK4XyRbpdQf5V6fWQ5qLc+eJxuIf4WbUaoQxetP4DWIyQfNi
5hbJ6lQrOWLFxpnJeM4CaweHA8ND7n7B6JcfCOpBse5/IKy3ITkCf0e7SaXKAPwF
YBMZXwGZP30FsDiHE1vlsikEMJQRlj9AQ1cFatQw1H7xL6IUnwWnpOS9HYdn7123
hSAn/7oO1o0TfjTgEJEZfXtD5tnEmIdnrKt//uLtCBvyhXgD2/O4MaWOXEPZP+de
S2iUxmSecrHoPvZHOV5cCcnxhuZl68NxxHMg/0ZOlq0uq6lupLXFdptbpMBYSxe/
+vcrhS3Y6ybjJIq1VBPN/my3vrQAGzRT91Yurbg3WnYbJS3QF6iweBmIqBpUdGIv
FwP90/2PDmD8HpGA0shquHzh43S3n+QsFqZGgU4dM8Yg/RR7aPI=
=gIns
-----END PGP SIGNATURE-----

--/iHh7k078AuzJ+EH--
