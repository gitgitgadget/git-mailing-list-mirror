Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE367C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiCAJev (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiCAJeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:34:44 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1F8A6DF
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:33:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 539CE5C0166;
        Tue,  1 Mar 2022 04:33:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 01 Mar 2022 04:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=0Y4LN/xtCIDLx+DPtptCrteBEg3LAUq/Lbl2II
        Jada8=; b=X/8RD3ILUiH73kqgnh24lJLrxPo5ulV1UOXyk3f8HVHT5ZW3WOmd9h
        YQw3pWj/YDlPrj5P7pZCYZABy/o2spPzCQpop9dTdq0zKO9FBT+G8Y+nXfDoYcLO
        IcFsodYkARmTjkXBh3Rt4bE6zsUloR+bX+8h1ZaEqjbP6rLsZ1pjRgZKB5f7M7QO
        oXmDOyX/g8yuQW8wf3GSGXOq7iE/ns1Qd2llYMajljsuc/ZLAT5g7xKisDp3c3g4
        WqqBC3NJ/o9UU9tVE8veBlZEbJglgd2cJa77AroKW/nTANhLrAp97fBaP3JuZQ/E
        l61X5twuHycWtG3U44kQNpO6LDzRRK6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0Y4LN/xtCIDLx+DPt
        ptCrteBEg3LAUq/Lbl2IIJada8=; b=QbMxItfh6tN4bQCorTK0RV5deOL34UNTn
        PXi8psVUZdMGGoPWT7F5ijR1NkxEDGvlZRcuzl7nstXd5rXIg47X7jNPLB5rcCrW
        7cMrh4YOHaMX0dMfcnS0XBJXB/HArOHBO605AeHnZo62K7NM+BLok4K/JE31K1zw
        tg6s+glgRjPOvcikOa0o9u4cvRj985KJENajgRtQ87BdVqqHzDk4KqyGeWyteFGC
        LOmrD5xeIUd3DcqB8vrB6eotrx/+80MizavreweLFeebrvoDGHS5iy+NqygNDh6T
        ZrZuq1aObsYIYXboLh0dKGqN+NywnqxyKH3X7QM3hTRTKH5rpBkoQ==
X-ME-Sender: <xms:eOgdYniByXZYGtlhwq28o3IaCdLMCD1rLgZRHla6ABScsWTa_ICeTQ>
    <xme:eOgdYkAMtFAo3PaiDaOiHdc6XrTFTp88Sj-ouyTUWfzjSMg_KoCLCf91EF1V3jnqX
    K9JpI25OnHDnawaIw>
X-ME-Received: <xmr:eOgdYnEPC-LMhjA2vpSyFpg2lCuduuPBWDxs1GhgFp3Rh7YVLm3KLlAYRXF1HUc7oyROTw7Ifbdc8w2Rv-HQmqLIeFb92uv7HCiqHFUwRtA0Y0bpobxsdBg5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:eOgdYkSFpK1w7y59t4dHzcbLoops9oE9idm2GUXGCCtXLcYJ_j1UuQ>
    <xmx:eOgdYkyau820Xr78iVSeoq16tjrE9r599Rw7fBU6_kkomTIDStUPqQ>
    <xmx:eOgdYq6Wd8ysRm-n-pevJuX9bA-eEVY4aEk5aw1dPTpRPe_l5ed6dQ>
    <xmx:eOgdYqZJppRmLYp13MteLHZXfXF5YnyDyb0RWHaV2xsGWPGNISP0tg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 04:33:43 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b805b5a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 09:33:43 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:33:41 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 2/5] fetch: avoid lookup of commits when not appending to
 FETCH_HEAD
Message-ID: <fbe76b78c30d98f1b10c474b1e0ddf6fa4db44fc.1646127015.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
 <cover.1646127015.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hfZeslaEjmYcJRkd"
Content-Disposition: inline
In-Reply-To: <cover.1646127015.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hfZeslaEjmYcJRkd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching from a remote repository we will by default write what has
been fetched into the special FETCH_HEAD reference. The order in which
references are written depends on whether the reference is for merge or
not, which, despite some other conditions, is also determined based on
whether the old object ID the reference is being updated from actually
exists in the repository.

To write FETCH_HEAD we thus loop through all references thrice: once for
the references that are about to be merged, once for the references that
are not for merge, and finally for all references that are ignored. For
every iteration, we then look up the old object ID to determine whether
the referenced object exists so that we can label it as "not-for-merge"
if it doesn't exist. It goes without saying that this can be expensive
in case where we are fetching a lot of references.

While this is hard to avoid in the case where we're writing FETCH_HEAD,
users can in fact ask us to skip this work via `--no-write-fetch-head`.
In that case, we do not care for the result of those lookups at all
because we don't have to order writes to FETCH_HEAD in the first place.

Skip this busywork in case we're not writing to FETCH_HEAD. The
following benchmark performs a mirror-fetch in a repository with about
two million references via `git fetch --prune --no-write-fetch-head
+refs/*:refs/*`:

    Benchmark 1: HEAD~
      Time (mean =C2=B1 =CF=83):     75.388 s =C2=B1  1.942 s    [User: 71.=
103 s, System: 8.953 s]
      Range (min =E2=80=A6 max):   73.184 s =E2=80=A6 76.845 s    3 runs

    Benchmark 2: HEAD
      Time (mean =C2=B1 =CF=83):     69.486 s =C2=B1  1.016 s    [User: 65.=
941 s, System: 8.806 s]
      Range (min =E2=80=A6 max):   68.864 s =E2=80=A6 70.659 s    3 runs

    Summary
      'HEAD' ran
        1.08 =C2=B1 0.03 times faster than 'HEAD~'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e8305b6662..4d12c2fd4d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1146,7 +1146,6 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 	     want_status <=3D FETCH_HEAD_IGNORE;
 	     want_status++) {
 		for (rm =3D ref_map; rm; rm =3D rm->next) {
-			struct commit *commit =3D NULL;
 			struct ref *ref =3D NULL;
=20
 			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW) {
@@ -1157,21 +1156,34 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 			}
=20
 			/*
-			 * References in "refs/tags/" are often going to point
-			 * to annotated tags, which are not part of the
-			 * commit-graph. We thus only try to look up refs in
-			 * the graph which are not in that namespace to not
-			 * regress performance in repositories with many
-			 * annotated tags.
+			 * When writing FETCH_HEAD we need to determine whether
+			 * we already have the commit or not. If not, then the
+			 * reference is not for merge and needs to be written
+			 * to the reflog after other commits which we already
+			 * have. We're not interested in this property though
+			 * in case FETCH_HEAD is not to be updated, so we can
+			 * skip the classification in that case.
 			 */
-			if (!starts_with(rm->name, "refs/tags/"))
-				commit =3D lookup_commit_in_graph(the_repository, &rm->old_oid);
-			if (!commit) {
-				commit =3D lookup_commit_reference_gently(the_repository,
-									&rm->old_oid,
-									1);
-				if (!commit)
-					rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
+			if (fetch_head->fp) {
+				struct commit *commit =3D NULL;
+
+				/*
+				 * References in "refs/tags/" are often going to point
+				 * to annotated tags, which are not part of the
+				 * commit-graph. We thus only try to look up refs in
+				 * the graph which are not in that namespace to not
+				 * regress performance in repositories with many
+				 * annotated tags.
+				 */
+				if (!starts_with(rm->name, "refs/tags/"))
+					commit =3D lookup_commit_in_graph(the_repository, &rm->old_oid);
+				if (!commit) {
+					commit =3D lookup_commit_reference_gently(the_repository,
+										&rm->old_oid,
+										1);
+					if (!commit)
+						rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
+				}
 			}
=20
 			if (rm->fetch_head_status !=3D want_status)
--=20
2.35.1


--hfZeslaEjmYcJRkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId6HUACgkQVbJhu7ck
PpTtNQ/9HDTxSdLBA4OL9OsRf3zQNW2Nqi4N/i8BZ3HoYZenDL9wBvoP0y74jf3W
sockIX0V+FRcCBXeHYScOGO4ByIb2iEmLWONHYq/6kl5FW/ogzm45Sfm2SRNUy3i
6qgKVgxx4MnRqqPjEl9GyfyJATBcPyTXFFfwDuAVWfEkL0+W9/4zdSqDtnUt1Ziy
tBWg58tKqF5XAfsW55urbN2Ih9IKqiKcv7NNOr9vTiUOoDuIvK/L/BVoMaoocby+
l7NKA8pF+hnsfvX1dGylj+S/gUtpZc8DA6jQyi3Hj7+E0yoL1O7si8q3Z2ebC6P/
sSxoseZ7OSgADa4ImvCTLwXPfWUJiF9zDP4ho32GflYjOeTg54mlQQjWvBccoMu9
puVKRHRDbNoAAx325xi/4dKkHOojAF76k4qgmIfKitLADnaJfUE3Qfu2Y2k9WAXK
EEqXWAqtgfrk6gJKI62WkmJc73ZHIg6gBXJC3j6p+JOg7n+zNTJFeULG9qfyORJB
uF2dWewYqccX+wlL/YFlQ9m9emLIHUf0BeGSr9AeoUAzx1njmFxo8+igEa4XA2/P
NWxnWq4pwl2veneWJvYnb+BsL2UqiJAZeOea+QqsxZRTI2ofAJ3Wi8TTlimzlg7k
ZX4TDdbb+snAedm+muxRPjRcW8/YiOWgCPZ2BMddDX98Jb3cqMg=
=Ndfm
-----END PGP SIGNATURE-----

--hfZeslaEjmYcJRkd--
