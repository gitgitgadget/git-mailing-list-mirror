Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC00C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20EB761265
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhHXKi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:38:26 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36049 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236330AbhHXKiJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 06:38:09 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E0F7F5C0079;
        Tue, 24 Aug 2021 06:37:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 24 Aug 2021 06:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=k18Br12CNucwD7YofIHElFZk1j0
        GF96LxxbqLusIaug=; b=GRvVWx+1B+puwpbsrwW5v1fi3e+g8Q68umk6hxgc7oz
        sHzdrQqRa8cmnbgcTOMWGJvvy93Qn421WD348uBurG5X4QtRfUCXjtPPZEgwKBRp
        c/lpoDCQw/yl3QWEbfCdpZGuWOCzS47EYbBf2L8QAUto8BExKtTmBunbGt4BsxjG
        AiqHutmjThQ20l1amoalHMbp8mknPeJe+mgLjugCVz4ySty/qDe6OnWQ2cSsvhGG
        6z5UjUspIJPIwWFwZJGqCeNWq6x2jfjb1OwsCHvVJd1p5FMNqD9/WJFelq/Ji0fC
        LiE1uuuxFj/oR62QXuQ7ks165y3Wd0eVLauGdicQmfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=k18Br1
        2CNucwD7YofIHElFZk1j0GF96LxxbqLusIaug=; b=eZrZqxoKx+9wDl1RCr0Tzq
        N8u7Sxsm7P08qY+uwN7diuMKcgIF52Mwk1+PHYwBVr0mLtL2vAnkjOtVSmUAJkn/
        N4R1IpNH4Spa7kTw4NBOx1T4ikHtmUdAcg5F5r9/ziN+HBFTN/1kHF3EQo6nDjsF
        I7zZhXCOnf4BEV2KNzq94mt2Oj3oeiacByd7yEdbCaZ3D/Nq/pfc9eyljsh5yG+N
        wsXkoqwyQJW+Lxjqs1LHgxIdxJjHnUElkKzdcaNJ1hsNMeQW3+OOoEy22uz6RTYt
        dZn0JFgBlAOcvDcBXpQNCKwRSjAcyet29WlQnZ2+Ziu4L//3BB8oWKd2LAzYiwNw
        ==
X-ME-Sender: <xms:5MskYfqOmSubp3deqTGTmjtR6hPLnhA5NCS3x7j6_USsUXoRqwRxXA>
    <xme:5MskYZqYRGmjrkeWZlcUkSjD-yNj3wgakvkSsMwPkMz1jWUdGRbUy08L6sXPGBxls
    vkd8FEfiHYyJLAi5Q>
X-ME-Received: <xmr:5MskYcOtp6R1bU9G7QhqiO5e32goJN6hzwol7w6VRoLBKhq4hxVYdUGPuNj_Oy_E6ESFLLyGPVScMRhlu8KZl5NfFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:5MskYS6aKVBJVa8WYsC3PcIwEWYxiFiJwGvr5B-pbywgwlrG6idzOw>
    <xmx:5MskYe6958QwAQGdqp6J17ReD0uRJALYkVRpxfR69zDtpjjREzyjLw>
    <xmx:5MskYahOngdLhhxm0IpQjXPYms4VRDuV6iiVwHO33mdo8VpEAtR-PQ>
    <xmx:5MskYZ0h8UNIg6WVALH4sV0Im2yYYVJveIirJSSZU7KgzNbvfLC8Jg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Aug 2021 06:37:23 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c27ad34c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Aug 2021 10:37:22 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:37:21 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 7/7] fetch: avoid second connectivity check if we already
 have all objects
Message-ID: <84e39c847f8258f0a0b392a2752dab00237c9e8f.1629800774.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="elfM/NHwgziGW9Rr"
Content-Disposition: inline
In-Reply-To: <cover.1629800774.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--elfM/NHwgziGW9Rr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching refs, we are doing two connectivity checks:

    - The first one is done such that we can skip fetching refs in the
      case where we already have all objects referenced by the updated
      set of refs.

    - The second one verifies that we have all objects after we have
      fetched objects.

We always execute both connectivity checks, but this is wasteful in case
the first connectivity check already notices that we have all objects
locally available.

Skip the second connectivity check in case we already had all objects
available. This gives us a nice speedup when doing a mirror-fetch in a
repository with about 2.3M refs where the fetching repo already has all
objects:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     30.025 s =C2=B1  0.081 s    [User: 27.=
070 s, System: 4.933 s]
      Range (min =E2=80=A6 max):   29.900 s =E2=80=A6 30.111 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     25.574 s =C2=B1  0.177 s    [User: 22.=
855 s, System: 4.683 s]
      Range (min =E2=80=A6 max):   25.399 s =E2=80=A6 25.765 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.17 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a1e17edd8b..e2c952ec67 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1293,7 +1293,7 @@ static int check_exist_and_connected(struct ref *ref_=
map)
=20
 static int fetch_and_consume_refs(struct transport *transport, struct ref =
*ref_map)
 {
-	int connectivity_checked;
+	int connectivity_checked =3D 1;
 	int ret;
=20
 	/*
@@ -1307,11 +1307,10 @@ static int fetch_and_consume_refs(struct transport =
*transport, struct ref *ref_m
 		trace2_region_leave("fetch", "fetch_refs", the_repository);
 		if (ret)
 			goto out;
+		connectivity_checked =3D transport->smart_options ?
+			transport->smart_options->connectivity_checked : 0;
 	}
=20
-	connectivity_checked =3D transport->smart_options
-		? transport->smart_options->connectivity_checked : 0;
-
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret =3D store_updated_refs(transport->url,
 				 transport->remote->name,
--=20
2.33.0


--elfM/NHwgziGW9Rr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEky+AACgkQVbJhu7ck
PpRtnQ/+NiagNz8SxLf0ryJ4cGm77nFpLAVlIVEsqh/W7GKQG8HAOJgOI1U3dhey
3YdlZKPdLP4TPK5Xp6SfZoVpRzGEaX/7fXsn+1YUhfvKZml5AM50Bd1TUZEIPqNn
pLm00E1Fb+xG4itSZZi1DRYoNrToGWhQLoWjQGosmZWJWmbMzJyIVkmai/CbSccf
gIk1tN/NjYcWS7Yqc+SOX5o9sDdZysD6iYrD1Jl6uRIDQWzBlihjrJrlUdcydkSb
rr3YVJM2X1/0TDghkh2TpxiYBfBHJL6nuSx9KuLqcPurHEdxdSVBmfKccW51bIX1
TjAl9HnBEMo6tvGJ7qv+E81M/8dwxvO+EbA2hWCt3dja10FG3DWDTV+8IMwxAO3e
2ptBkZpPrsQZXzcX9/QFhep/eUOPMUM6LS2bvjM5RvNmvtiKg1oyWHjSQCmssxag
kniaVIUqvBQWgERmnFGjcvoSsp2GyzP3AsWBtSVa7mv60M4b9+U91oKyNRQPmUjC
Pbqramhd93pae2uURwyaGfvU+ghD+/GPxPDcvxbZ3o5CEkt8qzKWnPOw+UznGpqi
cC60s4UYq8wwCmPEREnFYQmGwxX+pDde//vr9w3J8fibl28jIFiF+VBzuR5LhliQ
Bro7KAjgc4KS+SSZCiEe27UWSV32AdOXIB77pN5wz8dkYDv5GzE=
=nUiO
-----END PGP SIGNATURE-----

--elfM/NHwgziGW9Rr--
