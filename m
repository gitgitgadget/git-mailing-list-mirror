Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F80C433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346763AbiBUICw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:02:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbiBUICm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:02:42 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267C1640F
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:02:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BF76F5C01C5;
        Mon, 21 Feb 2022 03:02:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 21 Feb 2022 03:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=DDmoBpZCGGsURk2U4IHK66lrUTM95rRaioMUfT
        iBqaI=; b=N9Hxu0p+/I9jqxNoYg8vW4wNcytjwvCdoCVkjDEoNnEv7/+yrwCGDN
        3lXIrk+j0pJXZ6a72Lv2n7/fT0zraaWHGmJP2i1n+0HHVoEvaTIuzXFyk30RqYln
        6tHROw0+D0UoMInFq6SJDzuOIzVWjdS5XxJYvqPuBZ0VmVrc76g31tfUPh/cuhKN
        Ji7FKXyl+NnyTznZFruO1P9CY6EqdSnFdaDwcSZRU5DkHDQauhRQ9aDrD1Zkc2D2
        cf1inWg9PUSaYH0DJuX0hF7fuFdLU3oj0/fMlFdd7bU/rn5FdsYSuAf8p8gyMyN8
        s+wSaCC5NVhlhrQPptJqXFICBy4tqerQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DDmoBpZCGGsURk2U4
        IHK66lrUTM95rRaioMUfTiBqaI=; b=T8XQCo3WkAKhxXL9hP46NslirW6x5aGQN
        +43EDBXc54uNFdO2mhvfh0wId0ljHsTFKJLbXK65lA10BUIjI2nBeMN6Dl30QTN4
        ucZTsA4qCREpQ4w6Vh90PZwFU5BN+2e3w8mnJCbmL+PXrPasbUALmx4a/nJUMH8t
        ZE9O155VQ4dbT2Gb2wNXPFqGiCKg+oN5BWlnz/Z7Uf3sipec9KO0LmLrRMjuHZRr
        YntxCwvwhRFcYPLFdK8auonVdUYBmiEBj/z6k8FfxEmO0pqHfzuyVQx3Mj7V17r6
        q7JDcFUd+/OdU6YME//3R2Qvfs56wDhoVaVwc5URDZvDpy7Fq0udA==
X-ME-Sender: <xms:CUcTYk5Mg6tm7P0BQypW968R4ediy9U62VDW8fn9pRwhzk8YbhkvwQ>
    <xme:CUcTYl6tU0Exh8O38Wgt7bCKNnlcuVMjV9gBpNApPnFQNlkl1B3qdL-3a-zuprERq
    YaskLcLRuEaumh1Tg>
X-ME-Received: <xmr:CUcTYjeda0zxSZo6MUHpexTFEBLajirj5QicVsun05kLTcHzNhxkpunX0uoPkacIHz4RsjDANRhH6auC3GLjwyxj3_wzFvJ9ZdkrYxMl9P2TSVZTtFSFHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:CUcTYpLGqB5iBAE98Q0KGSH2D2_RTNn9kN6_pvDLANRfv3mTm4ailQ>
    <xmx:CUcTYoJ8H5eZGnLF1UDbBBOuK0gbKEqxgdT14idBHCX_PEsQROIETg>
    <xmx:CUcTYqxrA6cOzqkKm76H0yFbogUpI-azeiP30pBk_kH380GInGto3g>
    <xmx:CUcTYs0a1fB76yjmOS5iUXZeooq3P3qVkb_Z1h-YwdKl7sy8Oh7ciQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:02:16 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 60f8c235 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 08:02:15 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:02:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/7] fetch: backfill tags before setting upstream
Message-ID: <9867e76ac70c51cc6ccaf3ad7ef64250dad24920.1645430423.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nkOFV66X6ZrnGKCx"
Content-Disposition: inline
In-Reply-To: <cover.1645430423.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nkOFV66X6ZrnGKCx
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
both (2) and (4), which is further stressed by the point that we use a
`skip` goto label to jump from (3) to (4) in case we fail to update the
gitconfig as expected.

Reorder the code to first update all local references, and only after we
have done so update the upstream branch information. This improves the
code flow and furthermore makes it easier to refactor the way we update
references together.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6f5e157863..904ca9f1ca 100644
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
@@ -1620,11 +1620,24 @@ static int do_fetch(struct transport *transport,
 			retcode =3D 1;
 	}
 	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
-		free_refs(ref_map);
 		retcode =3D 1;
 		goto cleanup;
 	}
=20
+	/*
+	 * If neither --no-tags nor --tags was specified, do automated tag
+	 * following.
+	 */
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
@@ -1644,7 +1657,7 @@ static int do_fetch(struct transport *transport,
 			if (!rm->peer_ref) {
 				if (source_ref) {
 					warning(_("multiple branches detected, incompatible with --set-upstre=
am"));
-					goto skip;
+					goto cleanup;
 				} else {
 					source_ref =3D rm;
 				}
@@ -1658,7 +1671,7 @@ static int do_fetch(struct transport *transport,
 				warning(_("could not set upstream of HEAD to '%s' from '%s' when "
 					  "it does not point to any branch."),
 					shortname, transport->remote->name);
-				goto skip;
+				goto cleanup;
 			}
=20
 			if (!strcmp(source_ref->name, "HEAD") ||
@@ -1678,21 +1691,9 @@ static int do_fetch(struct transport *transport,
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


--nkOFV66X6ZrnGKCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRwUACgkQVbJhu7ck
PpR52w//XM6WUNmbfDG1Kri4nY/dw/SU5fNHcREpPSiqd1e2V+wg9BhEKqdxLex1
3K8Kax05bBcpkE0eTFPaVm50YMHsL6z2oXQYqon2mS/I6HADzKfDZK+EXaEoFPvk
/ytGnniW4mtZ8h4M749EBohJzCUbaewS6GW96zVKNCNlsQfV753fyd5XdcQd9i0a
N1CNR6DXSb15FE8/QjzZ5abu4u528gbnpIQ1Gp5mrKGxej/mPbI6dFpNirTnSsTP
eFUxZXD0mg+NkFdSOftOD3Lw2tn22lu2c2wqvVjqFWQLJN5n5NmkDxBLewzH6liO
3vkukI3ZuP0R/OmnRWOUre3tmFgZRjtOC1yYwY+HIUMZ3Cmed+RmGX3M6d60Li71
OE2beeiTjNXBf9a1JJCePVVA0w4bvT/tBqS4KTK5IyeQjm+WHFAKYWwKcFJGJYH0
LMR1GxUBvJHFmU2Bq+jXqDKgNNVf9EZm27KbKc5B8wTqO6zcoIrdkN5eD8Z5SWeN
3p41GxQBCOHI/jbLE5Pvj7/bYnJhbrEvECx+U2ytKvpLBkAfM1q3IW7VhlP+Dwr4
EI8j67RXtF3++OzwJZppYc1J1hDKgkxOqgZ506JRZLzk3dmF9Tlw9B6cBKobR6+R
bH9Cxh/gbTUtRLkq/lkxPoftkN8hvzgTAm43lUfm5P/5rFmhlk4=
=azyX
-----END PGP SIGNATURE-----

--nkOFV66X6ZrnGKCx--
