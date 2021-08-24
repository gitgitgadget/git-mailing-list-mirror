Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15226C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A1761008
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhHXKhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:37:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56303 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236175AbhHXKhm (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 06:37:42 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 8970B5C014D;
        Tue, 24 Aug 2021 06:36:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 24 Aug 2021 06:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=MVoPtfxc8OADHhfUfTIB5cKU4jF
        DTPrEfIRAf/D+U5c=; b=atJlw8Kd5PeodWHqki3FqCJwTJSQ0U0t9lH9qu4LUNF
        evS1P6SlhsZsbi2sPRm3UbNxbZOqYs/JdzobhAhREbBuL28mEF9pdBRq6AouZ4Kj
        N6gGKY7BUZPjUDYCjFGfOraJCV4RGGcDXn4DACNMkuNxyvJViaF0vuSq5ba93vIX
        BxqhTnOXqgHJ9LOBqM8gzeCQeOA5pZoKRactjxOs98JM+hOGscgNLp/o1N3MZY8m
        jTZ7wi3vGh24ibsxO5llms8O7Dw35OYWGD5FgIBtobvnUi/AE0lhybDRDDOiW7iq
        4p92EJCYbLE1HDS0QfauKZpkCmgqrcKQPEp5C8LW3qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MVoPtf
        xc8OADHhfUfTIB5cKU4jFDTPrEfIRAf/D+U5c=; b=iyswFxxJZ4g8+FyhSJylBe
        nRmbrWzNXfLeK2p3wGJ/kOuEumCVbdj5QDSPeG+CArmtbYj0O03Oj8TJmzDKkKj0
        2axuAsxQkQM9CB6Wgx5KXHcdbwgYpxnP3YPXJg+80ylJWY3SPAMWABTJghf47u6W
        L0b8NKUOdvzvNNudU+bfIlWUk42AFx+o8lWzd9ZMD2VYMO2x/bKFwmr/+RS9UPqS
        qBW5t+nLAK8Bhc+tzyFv4xK0XAHwa+NxGxnRSxjLLCBXJZ43bTJXX/3sj9ZNstf7
        Mny+zH4nsl6Lwp8srZY8uxepKv/X2TTEU0uIsk/Od67G2JrUtm1LDwYGdSNoxWSQ
        ==
X-ME-Sender: <xms:ysskYTbvYtgURx0Ub_rakvT0Xs0dihOm2Nxpbj0XWgSp4tA_GVtYLQ>
    <xme:ysskYSZ6yKb-TbUJlm4uQRpz_Iq8TlkPRgArUri3Jt5NOfTv8rWeOHQh-ZPrrjs-K
    pvWsRyEgcodiRlz0Q>
X-ME-Received: <xmr:ysskYV9-gqcA7JrXeILLPZC9gHD8KD5zUtUelTdraUsxhQi8YHdfu3cI_PdAHljRfztlmMiJ_upIfOoyjhxxdZ8uRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ysskYZqUkLZh-hnG0oChJf-F46J1x4N8LzxpAVNBm8E51jkgTdSNYw>
    <xmx:ysskYeplTWe7FHn7QAXzSlcO6snB9AnBgfUOdf1hWN19Hug-Dr2AJw>
    <xmx:ysskYfQ8I-YV1EGFfvC_t9VX3g8gjhBpdVklnIffpKet0Co4mkmPMw>
    <xmx:ysskYXnPcVs0CmnwWrhManaAtlOwflyvm-lbVTsGawv1UVivz0KaWw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Aug 2021 06:36:57 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 13460ce9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Aug 2021 10:36:56 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:36:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 1/7] fetch: speed up lookup of want refs via commit-graph
Message-ID: <4a819a68309bf03db2d9a5e5be070e52c3542af8.1629800774.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rqKR8XC64N1qYJqd"
Content-Disposition: inline
In-Reply-To: <cover.1629800774.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rqKR8XC64N1qYJqd
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

Speed this up by opportunistcally trying to resolve object IDs via the
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
index e064687dbd..91d1301613 100644
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


--rqKR8XC64N1qYJqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEky8YACgkQVbJhu7ck
PpSM0A//WggCYrmeM/WeD8ygmfcmDHPCgnzaJ1KyXmMkH4IQoBGikDFhSTo+FGtJ
EJRsucl5G7K31SSiZRrRNpZyrHfl4FC5O27id1Y4TgChFTQRkYco/+DQfQJjDxfB
C4rqFllb5RA34F4HVh08iTWbNOamgJ7PCw36RPeA+HRTR7QmUBAh7MuNjlfL4Tjg
tdjk4YW18lb5fM8Xd0+i4jhdomsTZQ0m9DIz+MzMfcVP5D/4R3aWB0XMngU8ahKv
LrcuDNr9uJz57VOZ7fyjktWMG/VoslOVpMOjnFD9TPUuGNzUYbayCtK6c6WSWCws
oxMugGT1LkOVlzBdAcLj7FtnVOMDKCL3AvhUZ3fl8iptX0K1yUK9w/cFUCkRWm//
3yZL2HBIR1QH4FyV9f9x+KoQzlHKN5vthSHQFtsPVBgJ3O9u09CtTBe+79uV9mHR
BsB7wUqcx2RKpBVp1LlsKsoCXn5yIFieo6+qz5Y+xTCT+FtuL0bEytVByQcVCjnd
MenJuQDrWV213LuvjnMpXpRBAj3EcSOp/YlJdZYw7pVQqEjG3fhzMYmSSSCbGpgV
yXoq0hZINVlgk7Mc/RNDLDcihj3+KQnZBMSQpQG3zlrIkMItf+KC6CivcIFHzOz/
ppMx4+J1GtT9noMXLiiiZRpbudQ18QK1PeAdVhdMa499cKp97vI=
=Kb8u
-----END PGP SIGNATURE-----

--rqKR8XC64N1qYJqd--
