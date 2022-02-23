Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D792BC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiBWMgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiBWMgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:36:04 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC779E9C0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:35:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3402B3201464
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Feb 2022 07:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=WNrVd9TZw72dp++gIuub95XhC9T4rkzfYLy0z/
        VuXjk=; b=CXj2cSbzj36fMGua5pyNbBQb6t6zfuENxnlDGzH0VYVxKpc2mCthj+
        0tOY/aqmAus8LRCYcBWhWwM4WCBKqFNVtmBYpizjBd9+HKqPNuef8b8/BPs4Dd0X
        mlLQuuuSM5g5vebpBWY1/XN1CWjAwfYfZynTe+942oHlWXvAeTxO2obl4mhTzfpB
        +C4SbZ0Sin8PS52M0On0UdR4xkt6m7WwyXizgR0uLmkzGjipG2eQYE4KOPX8vS24
        g/pOD1ObRu5A0Sq6oD3NYNjfAbWF47rhAcrR8Wq1oEmW13LkekKNPXn6pWnrA1Vy
        AWTr5LZNXBsEEZFxQ4eCOEtdAMCPqggw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WNrVd9TZw72dp++gI
        uub95XhC9T4rkzfYLy0z/VuXjk=; b=dQgdHMoCHkR7iNLnxAanX/IdaBCcGn4a2
        EF3f2wtJWfA001W1QbIIv8VE1ttFAc+6hua9E84h6BRBBWaeLgjC3Ral3Ito4wUQ
        u8wrAmNdO/2S6CxxrPdkG106JTNpfRVkE3Wtw/41o/DwCp44qEZKpwCqjsnqluYr
        3WAFOGFpEzeAoFVrnT4PRriBkJ0ehbvDsFkH4gda2U+53H+DsIblJKP02JW/QXto
        8ubtqZEwyh5kFle6BXqIVU3m8OobT77mARc53Za91BdOZau0FqD1TgrOZ//Q4eEN
        AwQBiPGQ4jGR+0MSlE5bOydXRpI15RIAUEObKq+lG0dfxwj8q86Rg==
X-ME-Sender: <xms:FSoWYgjyZBMh8ga1GHOcUhHlDERaEWmXXqRBangq_oNry7_ZraBIQA>
    <xme:FSoWYpBZxEpnj4KIomWgrRmKekrKEDStmWQfcuvqSl8H9kXwkWIae8ic6p6r9rjL0
    jOpmRNV2c7oEGd0Ig>
X-ME-Received: <xmr:FSoWYoHaMaajGH3SWM012q4bT4U5FTZGlxHWyLsf8mDkNDfk8Bkpt6v8i7GA2kzY4wVx1Jits8pE48R5Rmv4kxWPFk9DpHIhpzGD3DiL3T2bUV0OBdkpKmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FSoWYhRbWR8d7uI7BsIrflkkZ34oUv9kJd02743LJIz7RMFz8THQLw>
    <xmx:FSoWYtyDkyv1ncuNOpbGdX_Kg3PjyyJoTh2dZcOiNmW3JzYbUO_gZA>
    <xmx:FSoWYv5o_e1EX2s3s1MRE05r-UKnbWYWuI-PnSPfymIl1hF2bz1CkA>
    <xmx:FSoWYmsuhGgPFZSQzB_eqte85LnqV6OXVLlEuoYrJ2nCGfeX8y6F1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:33 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7b2604ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 23 Feb 2022 12:35:32 +0000 (UTC)
Date:   Wed, 23 Feb 2022 13:35:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] fetch: avoid lookup of commits when not appending to
 FETCH_HEAD
Message-ID: <80f993dddd521133154a751aeaab86adee409eea.1645619224.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wMczwc6dhM75p+2T"
Content-Disposition: inline
In-Reply-To: <cover.1645619224.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wMczwc6dhM75p+2T
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
two million references:

    Benchmark 1: git fetch --prune --no-write-fetch-head +refs/*:refs/* (HE=
AD~)
      Time (mean =C2=B1 =CF=83):     75.388 s =C2=B1  1.942 s    [User: 71.=
103 s, System: 8.953 s]
      Range (min =E2=80=A6 max):   73.184 s =E2=80=A6 76.845 s    3 runs

    Benchmark 2: git fetch --prune --no-write-fetch-head +refs/*:refs/* (HE=
AD)
      Time (mean =C2=B1 =CF=83):     69.486 s =C2=B1  1.016 s    [User: 65.=
941 s, System: 8.806 s]
      Range (min =E2=80=A6 max):   68.864 s =E2=80=A6 70.659 s    3 runs

    Summary
      'git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEAD)' ran
        1.08 =C2=B1 0.03 times faster than 'git fetch --prune --no-write-fe=
tch-head +refs/*:refs/* (HEAD~)'

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


--wMczwc6dhM75p+2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIWKhIACgkQVbJhu7ck
PpTL8BAArCltknS4GW40YRolowxQzF7wo2RGPFleepDOK5SaeYJg2nrbrJpILGkJ
DnFbHbft7250Tj/gqaqQiWmzAjkqc4OJ6L6Do2Pos2c4mQkzGwONeEm0+7JwaA31
zxwISXMtjX1gWBsrDHQ4MVy5o2xXR0p7MdGmTFDkNGUNLX2Ho17cVYU7TamswB5/
MzBfxXft3+U4rcZ9P7dPXehtFF2yqo4ka+et5DBRS/TkulvoxidI2uwQ4w6ZZ3xF
Is+A3e0Y4xP08l4tmYgD0oePImJu1vuc32vKd6ZLVrOOJFZE7A56j5JbmXqvtt8m
xvQSuE/UlMTKdE0wIVM+QfGLrrWOatQgoFDVvVoaE2d+t9sl0ThnFzAf/2dKP1bj
ZP87NQaor+3yOuQb5K46qp6AJNZPTjpwLjWbJYqPBionwiPLUAFcK63+7o6XXb5l
8XuE/hagd1z9k3lGDAWiZe99Ad0jcmk1ZMNKXVMg8oEmA5p6Hwwq4z8t4u9iErnA
3Q4eMAu7oAz5vxwedF8l6C82COInVZwqD2r5hyhpwCAbRFp4z0DPW+E1L0toRzPI
xCo7eWa1TpTE1kJw33M2xx4Pu3B0A9hVCTZwFSmlmICktdPOcZoYTueEvK4Ulo3f
C0f/aZS8uNAJH0XDkDJlbo7a8iTNTM8vt8aC6dE1fKuHA0SqTKY=
=HOAG
-----END PGP SIGNATURE-----

--wMczwc6dhM75p+2T--
