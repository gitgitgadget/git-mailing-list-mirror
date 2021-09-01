Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811FAC4320E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6095A6108E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbhIANKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:10:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58581 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244182AbhIANKl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 09:10:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B43AB5C01ED;
        Wed,  1 Sep 2021 09:09:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 01 Sep 2021 09:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=S+iORiJSq+O9mauh7nhC1KPkPx4
        ePloJrZEVJJQhN9w=; b=bTriAwbG70Hk3cQJAe2nIh0OShDtBli2k7ngfOKlHPV
        UYpVmEJeDpIpuUrWO6qyjoSPMVQo4ZnyESiaBfgLnB1K3H3NLCkNsZTkHkoNUrns
        xvjT2h82k8K7EZrgH1QILJVaeJpFstGYMg8VMvbXkQL68Exuvg0smHwbnZmBMb5y
        ivrXFNtnc1mCJdoDSE9bTfNBCp3YIk05PHo5AKDdbj5q4kjvf2lZwIhDCm6OWIUz
        OYD3p1MYYFncIaTRZ8QthdSYtAjuWH5Pq5BGn3ICt86C8120Tbso2CCt49j1O+eS
        OmKGcnZ10a+reoyzjIwXe/mTDkdTxaov2LJV0bjuDyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=S+iORi
        JSq+O9mauh7nhC1KPkPx4ePloJrZEVJJQhN9w=; b=HeJ0OozaI8bJcauxiESm4N
        hhYigzNKwhzvbA/5EyzzWtlupbgBaIH2j4nAprUZpvtPyZ4RNxa0rvU+VB5ypNSf
        qGBMUaXuMs4wkJfACDG4ylDV9N0J3z2vkdA4vCgFEJhUlt4Wibc45v6ptEYrbpQt
        +O8DaPmHuskyCV7ZdDMhU6yS9K500Oy51b0rujYVosGET1jLZ1qNw16Datp+Duee
        xwhBuaZ4vv4c5ajUiVd6rdKNquDV4dSIg5nPQo+BsNeA3f2J2mNKpR6kaSLWaNLA
        0XKi8uNTxtErU3JZDPL9YUvl4EapdO2W96TCLR64MJhObyc70oIjRHBuap8lBydg
        ==
X-ME-Sender: <xms:mHsvYdw8CDqNhJuxsEYGnbqER56j8oJYPe3NHicqqhuivth1zjcJ6w>
    <xme:mHsvYdSt9UYo4etyYyxl1OmQxW59lqzSeyHYVP7ZkUOh9s7CeRp8GLUcy6XzVsfa8
    W_t5XrJRaur_Ayg7w>
X-ME-Received: <xmr:mHsvYXXTl_8O1K1WaTWQqYzg3sz_wZvZh9AVSGxiXDN7nwVZ5VQgn936A_TRnBFYzRhtzcZqy23ELCrQgqZyzlofPpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:mHsvYfiSX-ZCY5ioIAU4gGBCGBtpo6_CYkGr6f28fCFj2G0piEcKxA>
    <xmx:mHsvYfAnoL2z_Xp-jjTcvsg1ipONcRle7mufpQxq8qMhYBh1h2iSvg>
    <xmx:mHsvYYI9ORNUnZ7lonspWFeh2YoWfy7oeHtf0HAHvM2A_2L4G5NTUQ>
    <xmx:mHsvYa_4ePkrAPBbXcKSht9M5EAUQjIIdg009AUd6yoy4Qfm697zAQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 09:09:43 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id baa47f15 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 13:09:42 +0000 (UTC)
Date:   Wed, 1 Sep 2021 15:09:41 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 1/7] fetch: speed up lookup of want refs via commit-graph
Message-ID: <8214f04971c4ea628f23d2e9ea143d87570c29d2.1630501732.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1630501732.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oRcz/+Hucb3lJp2F"
Content-Disposition: inline
In-Reply-To: <cover.1630501732.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oRcz/+Hucb3lJp2F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When updating our local refs based on the refs fetched from the remote,
we need to iterate through all requested refs and load their respective
commits such that we can determine whether they need to be appended to
FETCH_HEAD or not. In cases where we're fetching from a remote with
exceedingly many refs, resolving these refs can be quite expensive given
that we repeatedly need to unpack object headers for each of the
referenced objects.

Speed this up by opportunistically trying to resolve object IDs via the
commit graph. We only do so for any refs which are not in "refs/tags":
more likely than not, these are going to be a commit anyway, and this
lets us avoid having to unpack object headers completely in case the
object is a commit that is part of the commit-graph. This significantly
speeds up mirror-fetches in a real-world repository with
2.3M refs:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     56.482 s =C2=B1  0.384 s    [User: 53.=
340 s, System: 5.365 s]
      Range (min =E2=80=A6 max):   56.050 s =E2=80=A6 57.045 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     33.727 s =C2=B1  0.170 s    [User: 30.=
252 s, System: 5.194 s]
      Range (min =E2=80=A6 max):   33.452 s =E2=80=A6 33.871 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.67 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 25740c13df..bd7c0da232 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1074,7 +1074,6 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 			      int connectivity_checked, struct ref *ref_map)
 {
 	struct fetch_head fetch_head;
-	struct commit *commit;
 	int url_len, i, rc =3D 0;
 	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
 	struct ref_transaction *transaction =3D NULL;
@@ -1122,6 +1121,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 	     want_status <=3D FETCH_HEAD_IGNORE;
 	     want_status++) {
 		for (rm =3D ref_map; rm; rm =3D rm->next) {
+			struct commit *commit =3D NULL;
 			struct ref *ref =3D NULL;
=20
 			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW) {
@@ -1131,11 +1131,23 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 				continue;
 			}
=20
-			commit =3D lookup_commit_reference_gently(the_repository,
-								&rm->old_oid,
-								1);
-			if (!commit)
-				rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
+			/*
+			 * References in "refs/tags/" are often going to point
+			 * to annotated tags, which are not part of the
+			 * commit-graph. We thus only try to look up refs in
+			 * the graph which are not in that namespace to not
+			 * regress performance in repositories with many
+			 * annotated tags.
+			 */
+			if (!starts_with(rm->name, "refs/tags/"))
+				commit =3D lookup_commit_in_graph(the_repository, &rm->old_oid);
+			if (!commit) {
+				commit =3D lookup_commit_reference_gently(the_repository,
+									&rm->old_oid,
+									1);
+				if (!commit)
+					rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
+			}
=20
 			if (rm->fetch_head_status !=3D want_status)
 				continue;
--=20
2.33.0


--oRcz/+Hucb3lJp2F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEve5QACgkQVbJhu7ck
PpTHDA/9HJ/tQfZSpP2NcaSEMIQIRAoh/CuXrsPs7joXKLmlXKETCSabu8mjQizi
liQUmlvu7yPrQS4+oRGsoMkrV4rzkLfE+PbP0cANIe5CeRKKnLJ2uOBotQ3GF9oE
TZO3el4yE30sw+tv6QKIWUKRHf8d2yIepKCyYsi+wHw26teYzj2ZcZZK3zHKcPj9
6Kt3qQIiFqDw3GHm0ewIjfwI9ss6iI6+S5UePphkeS177hTAoqj9bZ2mbdHBu348
VblTBHUPExWIYe8wexWMyJ9EOJhQzy/AtOR0JMcXjui3XCLQeYpZQypfP6AP0h/v
aL0anlphWV1MX7HybUVn454NyCPSv5qGMPlz84q2FlTf4YBRGvDfAMOBPiNvN65O
l4rBsCm2X2s3+Cath/ymziQ1NcZcDxDF8MSo15vjRNlUg7Xj92j6Aj2Dn5yX0JeM
6Pv2iTyw3yDZEl/v+1kIqCRvdFsx1jR6kaVSwWPuR3FYMKFJ6isF0yrRHuZXGFpW
F5nWxJwSBBzAnRIshXmcSqo1XYueU45QAE57dwSPMRXUZnUp4PbpTdNFOYEsWHMD
mN3FOlgncNNgYoq6in9V7TwO9hB3tEAfi0NQ/1SVvvNH9BXsn6Cgs1y76BFRnHiu
52O8B2GhwEv6P335LzbXxWZkDTP0LA5O1nPQ9bqrHNKGfk5h8aE=
=HHKQ
-----END PGP SIGNATURE-----

--oRcz/+Hucb3lJp2F--
