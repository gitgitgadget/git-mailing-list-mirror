Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69DAC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 07:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347812AbiBKHq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:46:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347800AbiBKHqy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 02:46:54 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1DE2E9
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:46:54 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8954A3200F9C
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:46:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 11 Feb 2022 02:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=vUyLctEfWXVyMvN+MP3OM1lxjFFtN8epMFqk9M
        Z2S/w=; b=DpH2g8ww8cyjrGFrpC/6cCqB2V1hV4wSmvbRFjYeV5rWzttxpkC8bn
        nc0UZxUcjorRfPEQZpkeFhOpKJ6NDIT10+R2PwklTlrSEy3GrY8lkcj4pvGvAvqP
        EchmiQgIG0axES7FyG7OkvW1NBiP5hkngikIyly0IRDaKrV38mserbp+tVI7UW4E
        lCITQqfkCeC0i4Di/5BjtbPBnQ+8parSRDrwlzFxx8Z6Ixl1PK1jztWz/CeqPOyp
        2bogtE6M5VbRrwsWo7P87fyoHblw4Cg6zlIUpdI8SVhxHJLUPsRc6qoCHI38YGJi
        S+mixwc+muvwlhcBJbB13ha/BFsTdaMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vUyLctEfWXVyMvN+M
        P3OM1lxjFFtN8epMFqk9MZ2S/w=; b=RhSqBEFudIix27X0kvfGcI8W7FR+RaIKc
        mUVdWdzoxm6mo1ePd848oEeApgiUMDWnP0jP6CsDsPjqwNwpmRSSk7PKZXoBqaxv
        NPrR7O3+SF1NpT/rU+d3h51BHFBbZnnGBnPIgB3kz2QqVfK/zvH+mXxJ3/8aWa3k
        Jjls8UM6znmkFUUem6OZbx+0WDNCXq0imzCj1muuJSkRyTtaR53TteCbGvRccQLO
        Knk6NSt7tWac4j6AvpTGbDjI5vjkLR9hmnRAQ7i8jqgZ/iHIhGdwRUt+YJIUqzr2
        ds6b1tq+2gVegsIu1cXM2fAdQO+PhFdZsjzv15cX/PuVLAof/bnZA==
X-ME-Sender: <xms:bBQGYoi62m9DYC-iKAaK4mB-ZbVGMJF2y9B2W8D-MoVC8c786fIsSw>
    <xme:bBQGYhC4DVHMe6k8T5xsQ_tND0gKTq50KQ6KfdblMgEUIyZFa_BP3T1KRhraIjMiC
    C-nP2L4xImPgWiqUw>
X-ME-Received: <xmr:bBQGYgEXVlzym41Gec3qs3M3Yc_d524DdmZEBmn6WWyPXjSknYBSYN23008ZrBAOQIrzYerVExxeLd6KziFA_82Y_xubfDAGl1_97G5VW-D2A4v7MNH-FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedvgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:bBQGYpQdIgGbFOCyaxbpm0DiGBTcuMcGR-wslzaknBX4amFHPIl4FQ>
    <xmx:bBQGYlxUzfqYEy9prhoSYB5oRPeYsOlGfNePO8R1SDePCAFuFMDzpg>
    <xmx:bBQGYn4v7lB-XD1eYzXGq3alsK-gVofgp2KsEIjdk3m1ylRQqd2N0w>
    <xmx:bRQGYuvcKvL8Ca61cbLu4ijpk19AGLIX7ScIwTXkdkpZsiUDMJ4cmA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Feb 2022 02:46:52 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8eea7706 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 11 Feb 2022 07:46:52 +0000 (UTC)
Date:   Fri, 11 Feb 2022 08:46:51 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] fetch: backfill tags before setting upstream
Message-ID: <64c94e7a28d83fbaa1b6308b034d07c7be10e767.1644565025.git.ps@pks.im>
References: <cover.1644565025.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgqRuPIJr7fAmblh"
Content-Disposition: inline
In-Reply-To: <cover.1644565025.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wgqRuPIJr7fAmblh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The fetch code flow is a bit hard to understand right now:

    1. We optionally prune all references which have vanished on the
       remote side.
    2. We fetch and update all other references locally.
    3. We update the upstream branch in the gitconfig.
    4. We backfill tags pointing into the history we have just fetched.

It is quite confusing that we fetch objects and update references in
both (2) and (4), which is further stressed by the point that we require
a `skip` label which jumps from (3) to (4) in case we fail to update the
gitconfig as expected.

Reorder the code to first update all local references, and only after we
have done so update the upstream branch information. This improves the
code flow and furthermore makes it easier to refactor the way we update
references together.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5b3b18a72f..9c7e4f12cd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1536,7 +1536,7 @@ static void backfill_tags(struct transport *transport=
, struct ref *ref_map,
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
-	struct ref *ref_map;
+	struct ref *ref_map =3D NULL;
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
 	int retcode =3D 0;
 	const struct ref *remote_refs;
@@ -1618,11 +1618,22 @@ static int do_fetch(struct transport *transport,
 		}
 	}
 	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
-		free_refs(ref_map);
 		retcode =3D 1;
 		goto cleanup;
 	}
=20
+	/* if neither --no-tags nor --tags was specified, do automated tag
+	 * following ... */
+	if (tags =3D=3D TAGS_DEFAULT && autotags) {
+		struct ref *tags_ref_map =3D NULL, **tail =3D &tags_ref_map;
+
+		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
+		if (tags_ref_map)
+			backfill_tags(transport, tags_ref_map, worktrees);
+
+		free_refs(tags_ref_map);
+	}
+
 	if (set_upstream) {
 		struct branch *branch =3D branch_get("HEAD");
 		struct ref *rm;
@@ -1642,7 +1653,7 @@ static int do_fetch(struct transport *transport,
 			if (!rm->peer_ref) {
 				if (source_ref) {
 					warning(_("multiple branches detected, incompatible with --set-upstre=
am"));
-					goto skip;
+					goto cleanup;
 				} else {
 					source_ref =3D rm;
 				}
@@ -1656,7 +1667,7 @@ static int do_fetch(struct transport *transport,
 				warning(_("could not set upstream of HEAD to '%s' from '%s' when "
 					  "it does not point to any branch."),
 					shortname, transport->remote->name);
-				goto skip;
+				goto cleanup;
 			}
=20
 			if (!strcmp(source_ref->name, "HEAD") ||
@@ -1676,21 +1687,9 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream opti=
on"));
 		}
 	}
-skip:
-	free_refs(ref_map);
-
-	/* if neither --no-tags nor --tags was specified, do automated tag
-	 * following ... */
-	if (tags =3D=3D TAGS_DEFAULT && autotags) {
-		struct ref **tail =3D &ref_map;
-		ref_map =3D NULL;
-		find_non_local_tags(remote_refs, &ref_map, &tail);
-		if (ref_map)
-			backfill_tags(transport, ref_map, worktrees);
-		free_refs(ref_map);
-	}
=20
 cleanup:
+	free_refs(ref_map);
 	free_worktrees(worktrees);
 	return retcode;
 }
--=20
2.35.1


--wgqRuPIJr7fAmblh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIGFGoACgkQVbJhu7ck
PpRJaA/+PStGyIoV893sZd3+heDMtXL56fbxSTjL3HiSJjqTw6EQRKJDBJJlZVw2
H2pcitGygcc9sQxkgGZBsQ18IerDtsPtp+f4PmwkmgR1bARhKSKV5LQHycbgUNyp
1cvpoCwIOeNh2ml0JXlLe+7g8UPkBzb2e27D83eaAvFmdswDvH8+fms0wbNFjI6B
sbaf23uN9KKJzUlp8X6EpOEQH8QUlmK357tlW6KzMatbHy6m/Dz6H/fKKUiLNDg3
bytbsMjpsIIzNXonPJ+c/AtdnD5fPcrbBDBr++/AZDRDIBlvcjs/lLYh2CjOZhED
FOXRbj7itGm0PsV+Ik5r0gciuoWubxKRvL/kW+QGRVQK0l4ZfjiqfHbh7NmjNWNm
SKBq7MFx813etJC24sa9d46482JyFdqhX4EO+HaSN1h/yw0crXffCIh7dsEWkM4w
tR3BLAtShh0vAomWlxaOsNmqzttzzGNqC6nUPDWfD6j3NJac87oKYMgpETczOv7O
mh2gXETnMbwEUHXtY/QEI+lqTQLYde8+edCJyeFBJ+tdiC2EMHTHlYttLKhOm8Iq
K4HZxNavTkuKXtdbiPvEuVSoTel+nup9CQoQtQG07Ac+tOBdJ/0C3lYzhaPEB3yw
NFHlJQ0fLwjQGvWXOBsgg3Hx0f7TJrDoDmPEXIpgiKwFLCL4WiE=
=PSeL
-----END PGP SIGNATURE-----

--wgqRuPIJr7fAmblh--
