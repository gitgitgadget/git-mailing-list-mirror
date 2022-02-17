Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F931C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiBQNEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:04:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiBQNEi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:04:38 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FA22A8D04
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:04:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 2E2903201F24;
        Thu, 17 Feb 2022 08:04:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 17 Feb 2022 08:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=nXghBgG2ii8dUuVHCrZ/YenptqzpimxbU08Sj/
        5RgKA=; b=jB4RAvHKpvF6n4tOsBAD81ehWASkF3v+9YsGAy+DJPkwsNHVaWI9Cj
        a5h5Y+QUGJNiHbhG7DGh+ZfYrSxdzrmICPGP2lH5anNlThBy+QBz05smhCEVst02
        F3wjgezXCgoCEBAKiG1veD6Wwsrcrcp195bkDIs0va2/Y+fs6p4e4h7lwJrU5UrS
        1stgUIzJSTir5NBLLU+ih9CIwJ6/6K9onlL6mzggwrcIejsXW2A0e87jy8R1qUFc
        P1NSl52jRdzSh8eINp0Tpdwng+IZRSgQgcjpnSTsXx+rrfNuCoUvsnJ6cAsgp0Hd
        jeLxIxXWWt24Ypugol6neirFlMv0zjMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nXghBgG2ii8dUuVHC
        rZ/YenptqzpimxbU08Sj/5RgKA=; b=KP7i6+CMpcKjWLKXjmvPmPjYkeihmUo6E
        8etb04ZPwg1jOqFjjrfZ1AnaP/+NkSO0ctf1NpuWKQ7FvDscqsu2SPDcEJ676VUZ
        TGdX7ZyCTDi3UAQqf0V1HYogd+IkkOU2mQINdaxYA915FwXX+YNRyFEESfcrqQio
        L8O2252arFUG4t+9l7DHVfz2y9st3ygOOZhWdEKY0icgZhtOI7+8HmHc9ytxL6P1
        hEeInbhRCaCSvuh0q+Z5UOE/XTi1311pG5aEDHRDpfMZWyWaOylUl3bx26G1Kz81
        C3y++1U2Mrrzc1gCDl8AsdGbi5NfavDBX/LkV+gLD6Z8jzf9+Xrng==
X-ME-Sender: <xms:10cOYoKbcA-x-RAIeCgnmqvr6mJ5A0YLy2GDEHG8Tu_39uIX0G1GEQ>
    <xme:10cOYoIedx5Cp8OuUIyj0yXt0zE6pEZWbIz9f4m189mQD32EYp_SO_ciLlzp_njcH
    PD3ARfsYKX9sOKd3Q>
X-ME-Received: <xmr:10cOYoshWdHi2tHnkpcpGDvjzqa4b1hg7cz6p8wKwAmG01t-Fy7175eEccdaQm_ND4n2yX6zxyTD7bxQz9MTpSCqbApH56Owek9WnaSDSXIa3_-RM5tdNzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:10cOYlaWHfK-fHKIFL0rM__3fogtCZm2kxOFnINadC5ty0oMvjB2HQ>
    <xmx:10cOYvYKNhNIc2rrPatrqJM0wULQv-2xD50szADFODBXgJSkf6_Uqg>
    <xmx:10cOYhBLiqunhelVtyttz-w15fcrg2tgVmX16dCIaDraDdwGldMzWA>
    <xmx:10cOYulAHycTqsFmIYWVySTnP7RA2RjxyujVzPzWGprPijhxu6OafQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 08:04:22 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8d427bc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 13:04:21 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:04:20 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/7] fetch: backfill tags before setting upstream
Message-ID: <b0a067bbc1e7b9d3ad76acd437d8095c5a48c5d7.1645102965.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DeWDIVtMv0KG16L9"
Content-Disposition: inline
In-Reply-To: <cover.1645102965.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DeWDIVtMv0KG16L9
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


--DeWDIVtMv0KG16L9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOR9MACgkQVbJhu7ck
PpRyew/+J2jr+HbmqY6c++OOSJs570VJ7Hm/1Owwt/cPZt8RRcIiQIW5K9yFnWcb
3uPQlf2ZAbtnJuN//vX7TSYipP19z3WVgaNl3tWU3DWSECYEZMU/Aq+ZpLgRXc24
QRKyAI33vNdiLTz8OwPj+Lb63LbFwoczmKean8C0ZG4z8Q/LEEqLvlS/Wnpx0xHk
w7Hq5/M98QIK6z+zkSrILFeoHi7/tbQUSi9qZJiMedV8jCbwynC3Q0l0QxicuOxR
f+AQRymobLZVn2yfD+M5i4/btksH6RyuaYU/KJUZwOXC7sijT7k97hYAzx+q9mWa
RhdW3ziuFWlZi8U499HoOrC/f/kI2ecXrUPcEYOUuMjhh+uBf9+NaTQ1/37KBZL/
T3mjji5uouQqGwAGqZ3uIohO7u6gmVwsJ/2c3z/lQeTSUNkSRHaJuRQbnjiN025j
HVb2L3cOKox6R34xSlfCn34m4/Hbu9ZeRjLWLdK2xsGONOJMEZKZxNcDviRPAYQJ
bM75TGXo/qNlKDSUlFD6Isc6q2/rAxAd5jA3UzdGbmuFVTDS9Qz+ZVXpq0GODyz2
DxsGciz86jnK9gOitaNC9NTCmE6zg0VwQpBy0IhtZ6giAEL1vYqqR2ektkJk/wsr
fA3LU+BrA5TOAkZN1FD+PtxT2UOuI5fyirkvNX+yfXRM9M89AAQ=
=XX9e
-----END PGP SIGNATURE-----

--DeWDIVtMv0KG16L9--
