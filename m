Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F5C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 10:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346582AbiA1KRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:17:34 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54939 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347467AbiA1KRH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Jan 2022 05:17:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 094A332020B8
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 05:17:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 28 Jan 2022 05:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=khyC3E3k6PB1acc0N8tSw3L8A8FjOL4+mYr16K
        7y878=; b=q+vrHhLIj4SQOuFMWOn+vBmkoZIN3CtXeXyWIo5cI2dMmLSEP3D5mP
        9tigWezp2cX+9zGSnZTF9BjZhdX67i8q6Q6XWy021wV9wyarP8S9vb3cZ9dSQIJ3
        I5cbNjjmvTp+dK/HuD34Qsn57HOQ7ji8hWz2YQXM20GltuZnny91y9eV7ilFP8cp
        lgIf3mPO192Fvk9aY/ADH+StJY9RW2H4hTZhV/2ZG9Un42E+pEEmkFGDCnxxCdSj
        gP/o3V8GFmJWuhIi57mTg4Ybzxb3mnQcWZM9VW5tPhcvYz7N66UOPLtyymusFPY+
        Cfq1gbj7MmeM4bxn9nGJLLcs+g5t7ipQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=khyC3E3k6PB1acc0N
        8tSw3L8A8FjOL4+mYr16K7y878=; b=DvbQIjVXmtVLZK/+hq4d0yDLZWyZRy8IT
        8N+kmEhYapMKWSGNBludRiPA9J8uz2y6Qj2OZoeKUbKWSK5qASOUxKl5g1pjFKPq
        rQ6EzY97+2q+ZfuQBn4MMaTW7xflktW/sbWoJE1vADyhBAYxBKAQbe/20PEC1rx5
        boY+0it0Zj7oino/BdQM4Oqjwc+aFr0WPk5UwPpFq9gM+6WzC2TMHwPiiWjxQM/U
        6Dqj99bwtZEluCGRefIaeOUTO8fQCwAyIO/VxK0nzBSzxsuIM/44yjKCykpxRl6n
        Lw2wqbo37QWfxc934pLQRoDtZrmTUANuzpppTiWVeS/k53g5zg1jQ==
X-ME-Sender: <xms:osLzYeKLiWo8NS9f2NAF9R_e9Axyl1tCJc98JfjTpyUwFpNWLNVFGg>
    <xme:osLzYWK3iyh8IFtJNF7dpXBVpopYcrDh62IcGt7R0BHnlJFBcpftrNrqCRybjehkU
    -EsnDIJTYYV07stcg>
X-ME-Received: <xmr:osLzYet498tww4nVts-GBGyDCdIMGCJrTfYPlzOcxEbcR8XOWBBniWztSCRKwYt18dNFYTs57zTDbV82JUvB5QHp3CKaSpRFAbAnMQdyCo-mxQpeuAHp3bY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfeehgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:osLzYTYKibZ_o2ZiMTVK8LTyxZ-ISvQbg9grnmKw0skaLV20X9iyrA>
    <xmx:osLzYVahkVHK2zlTebSR4xZQY3V86WUrrhXM_EbO7xRQOfk28ORBDg>
    <xmx:osLzYfCRI2Jzm00nTzwGUK4O1oogM6o3-NhB5blNTMjgoqkRKOQsvw>
    <xmx:osLzYX201s9WqTOoFyMfk1A7m-USAlfgF_C3uIehfsnkSonMvQXRPA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 28 Jan 2022 05:17:06 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c8475f5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 28 Jan 2022 10:17:04 +0000 (UTC)
Date:   Fri, 28 Jan 2022 11:17:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] fetch-pack: use commit-graph when computing cutoff
Message-ID: <31cf8f87a149c0fc8013b869e0e30364f3c60e01.1643364888.git.ps@pks.im>
References: <cover.1643364888.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bwor5V1UddUBLlyS"
Content-Disposition: inline
In-Reply-To: <cover.1643364888.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Bwor5V1UddUBLlyS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

During packfile negotiation we iterate over all refs announced by the
remote side to check whether their IDs refer to commits already known to
us. If a commit is known to us already, then its date is a potential
cutoff point for commits we have in common with the remote side.

There is potentially a lot of commits announced by the remote depending
on how many refs there are in the remote repository, and for every one
of them we need to search for it in our object database and, if found,
parse the corresponding object to find out whether it is a candidate for
the cutoff date. This can be sped up by trying to look up commits via
the commit-graph first, which is a lot more efficient.

One thing to keep in mind though is that the commit-graph corrects
committer dates:

    * A commit with at least one parent has corrected committer date
      equal to the maximum of its commiter date and one more than the
      largest corrected committer date among its parents.

As a result, it may be that the commit date we load via the commit graph
is more recent than it would have been when loaded via the ODB, and as a
result we may also choose a more recent cutoff point. But as the code
documents, this is only a heuristic and it is okay if we determine a
wrong cutoff date. The worst that can happen is that we report more
commits as HAVEs to the server when using corrected dates.

Loading commits via the commit-graph is typically much faster than
loading commits via the object database. Benchmarks in a repository with
about 2,1 million refs and an up-to-date commit-graph show a 20% speedup
when mirror-fetching:

    Benchmark 1: git fetch --atomic +refs/*:refs/* (v2.35.0)
      Time (mean =C2=B1 =CF=83):     75.264 s =C2=B1  1.115 s    [User: 68.=
199 s, System: 10.094 s]
      Range (min =E2=80=A6 max):   74.145 s =E2=80=A6 76.862 s    5 runs

    Benchmark 2: git fetch --atomic +refs/*:refs/* (HEAD)
      Time (mean =C2=B1 =CF=83):     62.350 s =C2=B1  0.854 s    [User: 55.=
412 s, System: 9.976 s]
      Range (min =E2=80=A6 max):   61.224 s =E2=80=A6 63.216 s    5 runs

    Summary
      'git fetch --atomic +refs/*:refs/* (HEAD)' ran
        1.21 =C2=B1 0.02 times faster than 'git fetch --atomic +refs/*:refs=
/* (v2.35.0)'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index dd6ec449f2..c5967e228e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -696,26 +696,30 @@ static void mark_complete_and_common_ref(struct fetch=
_negotiator *negotiator,
=20
 	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NU=
LL);
 	for (ref =3D *refs; ref; ref =3D ref->next) {
-		struct object *o;
+		struct commit *commit;
=20
-		if (!has_object_file_with_flags(&ref->old_oid,
+		commit =3D lookup_commit_in_graph(the_repository, &ref->old_oid);
+		if (!commit) {
+			struct object *o;
+
+			if (!has_object_file_with_flags(&ref->old_oid,
 						OBJECT_INFO_QUICK |
-							OBJECT_INFO_SKIP_FETCH_OBJECT))
-			continue;
-		o =3D parse_object(the_repository, &ref->old_oid);
-		if (!o)
-			continue;
+						OBJECT_INFO_SKIP_FETCH_OBJECT))
+				continue;
+			o =3D parse_object(the_repository, &ref->old_oid);
+			if (!o || o->type !=3D OBJ_COMMIT)
+				continue;
+
+			commit =3D (struct commit *)o;
+		}
=20
 		/*
 		 * We already have it -- which may mean that we were
 		 * in sync with the other side at some time after
 		 * that (it is OK if we guess wrong here).
 		 */
-		if (o->type =3D=3D OBJ_COMMIT) {
-			struct commit *commit =3D (struct commit *)o;
-			if (!cutoff || cutoff < commit->date)
-				cutoff =3D commit->date;
-		}
+		if (!cutoff || cutoff < commit->date)
+			cutoff =3D commit->date;
 	}
 	trace2_region_leave("fetch-pack", "parse_remote_refs_and_find_cutoff", NU=
LL);
=20
--=20
2.35.0


--Bwor5V1UddUBLlyS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHzwp4ACgkQVbJhu7ck
PpRHPBAAqymRE8wUeWpr4GZYJsUWSvf1gND37iP82/5j23kcu5vrnJpDThogKKsR
GKgo+vjrcDElT7AhvdJmOdySdCPRS8I2V3Baq0Z178SEvWeOZHWHYh0y12mqCS2K
vmNkGr55Tx2E6m701T5Dsj+IXebeA/RcsdKUVkbMhkyGFZa3lNYFZIfp5h+aMbSy
nBtF/rUALCAR2wPtoWeQm5X/0xZrDrZyfq8jzXGHwQolACpzZ7IKkju5xC7BVTd5
j/g/0PZHTITu5aahrMaYiirxZoZU35g/84o8J8Mls6bglclvPRf/zDxeeyNnzGPL
hZY1rgopVODaUMt5iIH3Y21PPhYce9luV4Nk7pALnAibsBVwDe7m/lt5SUmQK5sS
LqUaQJO3nOWZWKxjnjj+bmQyCLdGhG11XkEUYiPFjrGkNe0BpA/DLPu6b/ptaMbt
FXXYX+lqHl0va9ucSo/yUBxDCKdeGnCwrC8fSLC75eYN2Q0t4YnKW83btI5SOga8
OEQh/gU91EoexYal2qb6SnHV8C0pNZjN46iwvphN6nt2+InOAcCjM4vl4iMUry18
qj6GVzWJKsMLmzmg6I18O8wffswGSGJvvLo5SwF/K7Wf3EO4iSg1LF7tAvQWpVBi
Jfncq/yw+0s2ZWkUqzZK88999T1rGEc5xbzQ4JaYav2wtPkeHiU=
=cwMT
-----END PGP SIGNATURE-----

--Bwor5V1UddUBLlyS--
