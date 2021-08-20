Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1ECC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65861610D2
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237446AbhHTKJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:09:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38183 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237267AbhHTKJN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 06:09:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 204555C0160;
        Fri, 20 Aug 2021 06:08:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Aug 2021 06:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UHLSZZnC1WCALUjKpySHxFjKozS
        5TnlJWoHn7EgNQF4=; b=G6ojw3pPvG22PcGYzAdD+TlsYxqTbrp+Ka+63QTK+0s
        8Fr9HFUrHBZmNcgUlULNcZlcg349fe3Fk8gFTMHiRPUK5yyXGUllBd13Y1DnBpjO
        6FdIBhdFIiqL/lCB8nx2CnMli5XQbpk5A2Ef50FrAvl2NswSw+V4/qMwianLS9WX
        RQ99QNrqHwRqrFb5y9mliYH2Ue3wmx3X2TnnLWR+Nxm6jaDPHW1S6dOuhtS/+ABV
        ia9+0f8ACLXVw4ph21e8zIbLssEK/8SiV/49WeapEV9aYwgKzsgzVzNdPuQZ6H3H
        6DoyRIYCFujDD1fJsySYBcNO4dkd6cH+1deOLto4cVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UHLSZZ
        nC1WCALUjKpySHxFjKozS5TnlJWoHn7EgNQF4=; b=in/QuW3Nh9rgh12sZTYsti
        S21IHg/zOXX515ssysW5EZ2AfOMWsWamlRYtXlkq9u7eADm70nbIHg7EZF4PLKFN
        efS+Dj5LI2+4IO0NPMKRkND7EskULetqA2RZhxmOJjchPuwJ+HykDFQDILjW944r
        eSgKVXeEq2bG/2JNqdaXKlvXbjJM8DtQQ3msQptJP0AWscK2uC5oA3gYq9Ycnr1/
        hSQd7JsBelTKt5qdXIO05s1p8Io9UdJHbS4ETNmS8Mjhu9FeXtnk6VVOOr2Oaore
        tk1gM3J2FzGQzb7pcMhyq3UXMe4fchocGDsq0QOCa0Z5IcwB4TVhUGO7lN8+pWHw
        ==
X-ME-Sender: <xms:In8fYdEDeX3Xc-uqH4atfg-8gu8EW95MEJNq0VOQKCscRN359ZP9pg>
    <xme:In8fYSWCljDHoejCMI6I9SyaLYWsSgaQW8UjU273EvLusodnIpHmyznFNSfrR6Hrv
    xine2GY0KKZBFd5lw>
X-ME-Received: <xmr:In8fYfL_fvBQNHhjdeCZt4frEKWsL2TQMFQ0DeQ-bz4MQV4269Fokjrp-XmSDicXzDjRPjoq41qbJL18CUi3TMBerr9WeZCvW2Y9JjpV7kei64mQRiaWBOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:In8fYTHSAZRLz8R3lmWV1Db0JCK0ebuvF9k125NfjIUj9Q28l3rsyg>
    <xmx:In8fYTVJDifF-n0XI442Y5qo36gzYvz1IyhNTEI5rsHHcXul_sOZQw>
    <xmx:In8fYeNlnWrECC-UTsA4qPL-II6g52Mn0ibv02Wi_EgzqiQxomQkRQ>
    <xmx:I38fYQhowyQsJTDMFCt07mG1Cud109071bk-_ayyoqWoBzvrbBJtMA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:08:34 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6180f4b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 20 Aug 2021 10:08:29 +0000 (UTC)
Date:   Fri, 20 Aug 2021 12:08:28 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/6] fetch: speed up lookup of want refs via commit-graph
Message-ID: <6872979c4557204821d788dc3f5e1c8bef0a773c.1629452412.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6cs/NpYv4rCSFVOY"
Content-Disposition: inline
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6cs/NpYv4rCSFVOY
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
commit graph: more likely than not, they're going to be a commit anyway,
and this lets us avoid having to unpack object headers completely in
case the object is a commit that is part of the commit-graph. This
significantly speeds up mirror-fetches in a real-world repository with
2.3M refs:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     56.942 s =C2=B1  0.449 s    [User: 53.=
360 s, System: 5.356 s]
      Range (min =E2=80=A6 max):   56.372 s =E2=80=A6 57.533 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     33.657 s =C2=B1  0.167 s    [User: 30.=
302 s, System: 5.181 s]
      Range (min =E2=80=A6 max):   33.454 s =E2=80=A6 33.844 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.69 =C2=B1 0.02 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 405afe9bdf..73f5b286d5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1131,11 +1131,14 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 				continue;
 			}
=20
-			commit =3D lookup_commit_reference_gently(the_repository,
-								&rm->old_oid,
-								1);
-			if (!commit)
-				rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
+			commit =3D lookup_commit_in_graph(the_repository, &rm->old_oid);
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


--6cs/NpYv4rCSFVOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEffxsACgkQVbJhu7ck
PpSO6g//bPSAIzhUGxVEhRTSV6D0knrOBtrA/1Ldjpab3DOdUMuO5ldRQHlJke5D
/3l6nc2tOnWVS6soFQB5ZE2RTpvjZHCRE39I57M/jyGhJA3yLrANKMgJoyMKQD0e
gmzt2iV57FHn5HAgXwb0GwOTusUGeuARZtK3Yqh6i6Wb7xrF8fjZ60Up5+SR0pqK
xXD31ka0pgZq3De6V87L8Q0cd9KqAO9QKwBqOlsxFzFCj75ETr0IZ9yDYWW7XfV8
e5SPHopgsALguxiC0fZDHWKMKQCQFS7Yj/VhNL5JQLtSMp/kUHPCi5JRNyCTEsfo
Y42SjWNY9rYygNvLPzxY9F5DWN+mJAIQdoWF9F1L4Ct7aWJIK4bWB89QT7NdPurd
IaqIJbVEIrR5Vse8n9lfBmJoypHCTsE+0CvkxJtMTvOXsAsFyOTkVB6Awfz1mJc6
CVesNG/8SvSA7s7ZLoIO4sgOhFzFv7e3HS7NREJ5TrQDkkFphDY9bxHfMe3HvAOb
Lw2a4yuHB+69GJmWgmMjQwCZu+WdXz2JUIlJ/DEqwQ1GVLdAej3ATARcHLCkE/Hy
kq3KXRYyVF/sCvlhgc5j/geBJwwbj+V2H9bRxk+4vJ0MDcmBoMjzrl5JCvTE+nQE
OknWPShLGTCcf3gQ69Tn0bw0ewGNU0QedPMaB96U0aSYmqUu85o=
=+R8H
-----END PGP SIGNATURE-----

--6cs/NpYv4rCSFVOY--
