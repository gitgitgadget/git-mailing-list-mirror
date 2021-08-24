Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD968C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7BE61008
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhHXKi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:38:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48837 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236310AbhHXKiE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 06:38:04 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A510F5C006F;
        Tue, 24 Aug 2021 06:37:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 24 Aug 2021 06:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=/TovEeBDFb13LAwZ91p0bt3lWv+
        rkQWZXQq6biNwZTE=; b=GRnTv1Y+TRZiKo2saQYxcUua9wLP0Xq2aQcVTlmZXct
        cQh+8h8srPLZe2z4SxOFb2c5yaIGdBAiJLsAULSoGtmolGW6D+Qra/KKZ4/cLozM
        LIOFQBHJ9ymc1CikCrbA3zXX8yp3VtvVzeie4+3XW4A4iRufYCum6E/d8+yCqQxl
        kfd7Vuze0khCtFRjHywWjM9lzDmyZ+/yfVtMufk1fkF85zADT2UxnmvrcuKFg6vf
        euW8giROgUatOnqDIBSLqBrx+Y6bPmyOB/2/dM+2D/Jr6b1zdwPSEZFi/3HhS5SU
        1ErgAnw7qIb2VECq3nfaDloBPgBf+NjhXrcQnMpHoVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=/TovEe
        BDFb13LAwZ91p0bt3lWv+rkQWZXQq6biNwZTE=; b=izmk3jPgjwd0MG3Rl3McKB
        vjPmH3VueabQQ5EvIginP45Fjgzv4ivZ+moSaXMQgzGmEjIGYIKg0GugVHnbSaf3
        QgKv90hwxG6+CjgGJPXFReKkpUmA40xdbmKTK/oKl5rMGFrISw0oBq2DMKvIWQlD
        4125HaJ5SCZqL7AFSgV/3x0DW3ZwjieyTHFBq4dXhmmI5ZOdsfJ5xIqYUA4gR9UL
        viJGPt9WviDF0Bmol383+TruYQ3YZuluZT2HtOqB5K7b4Bzyp27b0qmZuYZM8yPv
        Rw5DTOwvLeslwjedvKyYmojUkLqUgXGrEx4Im7kfOnZ8RCghwn64MXdZx414R+BA
        ==
X-ME-Sender: <xms:4MskYWPOLVd8oGRfK8CCWTEErazRgJ28pk57foQETLMIbUL2GqvGjw>
    <xme:4MskYU_uJ6uvej6-Pu3Gy6DUIuR0HmIoDHqDeughJG9ovq49hDzoeFR18RluYCqq5
    cmytWqmZLRM2Ozj7Q>
X-ME-Received: <xmr:4MskYdTJT-pebbExVclbBBKziN6OsnTQGz54DkZv1BS3KB8h3WXsUZPFcU9Os1j0S4Cc-zkou5HY_cQeby-Whh9SRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:4MskYWvToJ9EvgTVWiQWKqafmOMh2IoL7PRiBnrVsPGuxxqCUR21kg>
    <xmx:4MskYefqU2Kb6IQgBwOwWfpB2UzzyKlzfwGClu_p-Cc3GqkQVxVO-w>
    <xmx:4MskYa0qoaLnJiTurXpZetfGmiT5hTPOtw87f3EypQSQFPfkEs29WQ>
    <xmx:4MskYd5QpAtBsmIFugX0tjejre6_21cP-eO5uXNEpscf4OZXVsVEPw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Aug 2021 06:37:19 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 37514157 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Aug 2021 10:37:18 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:37:17 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 6/7] fetch: merge fetching and consuming refs
Message-ID: <31d9f72edf5c178b2e80c30bb7c0a9bc164ca5eb.1629800774.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uSPxcyLm1KIF268P"
Content-Disposition: inline
In-Reply-To: <cover.1629800774.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uSPxcyLm1KIF268P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The functions `fetch_refs()` and `consume_refs()` must always be called
together such that we first obtain all missing objects and then update
our local refs to match the remote refs. In a subsequent patch, we'll
further require that `fetch_refs()` must always be called before
`consume_refs()` such that it can correctly assert that we have all
objects after the fetch given that we're about to move the connectivity
check.

Make this requirement explicit by merging both functions into a single
`fetch_and_consume_refs()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index da0e283288..a1e17edd8b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1291,8 +1291,9 @@ static int check_exist_and_connected(struct ref *ref_=
map)
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
=20
-static int fetch_refs(struct transport *transport, struct ref *ref_map)
+static int fetch_and_consume_refs(struct transport *transport, struct ref =
*ref_map)
 {
+	int connectivity_checked;
 	int ret;
=20
 	/*
@@ -1304,32 +1305,22 @@ static int fetch_refs(struct transport *transport, =
struct ref *ref_map)
 		trace2_region_enter("fetch", "fetch_refs", the_repository);
 		ret =3D transport_fetch_refs(transport, ref_map);
 		trace2_region_leave("fetch", "fetch_refs", the_repository);
-		if (ret) {
-			transport_unlock_pack(transport);
-			return ret;
-		}
+		if (ret)
+			goto out;
 	}
=20
-	/*
-	 * Keep the new pack's ".keep" file around to allow the caller
-	 * time to update refs to reference the new objects.
-	 */
-	return 0;
-}
-
-/* Update local refs based on the ref values fetched from a remote */
-static int consume_refs(struct transport *transport, struct ref *ref_map)
-{
-	int connectivity_checked =3D transport->smart_options
+	connectivity_checked =3D transport->smart_options
 		? transport->smart_options->connectivity_checked : 0;
-	int ret;
+
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret =3D store_updated_refs(transport->url,
 				 transport->remote->name,
 				 connectivity_checked,
 				 ref_map);
-	transport_unlock_pack(transport);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
+
+out:
+	transport_unlock_pack(transport);
 	return ret;
 }
=20
@@ -1518,8 +1509,7 @@ static void backfill_tags(struct transport *transport=
, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	if (!fetch_refs(transport, ref_map))
-		consume_refs(transport, ref_map);
+	fetch_and_consume_refs(transport, ref_map);
=20
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1610,7 +1600,7 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
+	if (fetch_and_consume_refs(transport, ref_map)) {
 		free_refs(ref_map);
 		retcode =3D 1;
 		goto cleanup;
--=20
2.33.0


--uSPxcyLm1KIF268P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEky9wACgkQVbJhu7ck
PpT6Fg/8DXCKGBPFUhUE12z3wk5M3CDIg0ZATrFaWVU2ou25cTWiuNagpz1V66SU
E05zuNyM+BalTzZZwfkAeW2eIcf6eibVplq+t1D1BEJLUBpP2rr8AxAYspW0tWiB
0gDo1e7SX1fz87vdB/DFLs1W934YdV+xzZe/Y9+7ssSCnQsvFDm4x506d0YX69c+
yJnwEOlJtHmKTm+K+mDZ6WsYox/UZyAY+sVsljef/XfZc9gFht6gbvhgH0hmOoSF
BNRh2dzYCh6lAHUhdpy3fhL4fGjWY4jP94OaBACoZxAe30t/Llaw/xqGqtEfPRMA
Ba5E5/rzmt1mhkMuMQQhqTXOxrGxfKjijEd1263ujA6Cd7R2bvCn+gCMKvHCH+HF
TUK5Esd4bHjId7TC9KdvkIdCK7gZ4/iIEPDeOk8EE4hIIhhuUTLT9Z51QGPqNgch
AMAazuOhaZdR0ZdmN+T4+RmW/nFqtC+BJ5zLOpGJnD21Wy2oKrNX6DofoMs8GDJP
FJdY1OkMDgPrQidqKS0PvmPVC33+MsAO6haDTOQOBt61POV1fF+oK8vzyYqFyCZe
lknidlDEt3epkZbrcqZHPuf02yccTxIv7/yja4l7eaBBHQR0bDOGvz7EpXUdQ9qG
6ItQA5SebkCo7m1XgJCyzrs5ys0WKqNLNkDEszIXVoso+icPfu0=
=c4bx
-----END PGP SIGNATURE-----

--uSPxcyLm1KIF268P--
