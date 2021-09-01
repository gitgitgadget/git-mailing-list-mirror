Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62232C4320E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCD960FC0
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbhIANLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:11:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34169 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344395AbhIANLC (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 09:11:02 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 35CF65C01DB;
        Wed,  1 Sep 2021 09:10:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 09:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=5jvutvsZjig5pcuWKaPZlw5fQWV
        hdiBX/ijikES1MCU=; b=iJt+9mo7Pb25GD/qeamoS79hVdkoe037lit2zVCnkaZ
        1kijqcen1roPEECKHBjq+mVIgMSSy4CnM6VbqGnrIr1H9MntUibBJkbomSuXAeDs
        uBnO731lnCGWv7NL31rVFX+fIU3wLo5l4Y1jkXd0DCPI5IAiDuXCTb/DygtA+5jU
        bZOzZxiWCqsD3q32ssa2aXEMWEvlawA1q3MUizvUxLl/++osSMf7uOC0/ncS94Jx
        941X6kfgKcDNspSohyxUwTeWGH9BWdbDOz6ZumCgEvEUyoKZ4xPwCzl8AiN/EkEb
        MoR449+sbrlO3pCzev0FvRsogy1CNW0mNLVLf5YC4Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5jvutv
        sZjig5pcuWKaPZlw5fQWVhdiBX/ijikES1MCU=; b=mGhqjbdXqJEI2nGleLJLMm
        s/50G+C/jAhieFYkG08o7Ch341cFY+J+wRdWm1OsNx7pFxjibuPB7nIF0x1VbUlc
        rBvTGgPjT8ET4GBAQzv1WS+yY57HPDtG4UA0Ni+gB8KECgoUcHgSn9Z/A3Bsg1wU
        nikhoL13yS5ftZczopM/irXcpIpSx8u/klvgdGzjDn0g/lATVme/AXfmRRxKHjr2
        p6BMkK2bMpLVSBb0eaqXD7vw0Wo7TE9kpL7glzKmwi2Iu/bpW/DPK8QXf0WIS/zR
        lkEZQ5sObItkmLz8PFvxc3XN2esGQzJ/2uyL1GHJOzDvIfNOSQW+xaSjcb7qHb1g
        ==
X-ME-Sender: <xms:rXsvYSVGY6BPB_01np1lNn6p3UJkVLDG_mRm4WneCSciDCUsdNrogw>
    <xme:rXsvYek3XINPoLEAyzRSIidsO7wlZoO_QGL1IED_MMSw1Qy839_xLOMvfuomFbtnR
    rDR34CUDWZ64AHaiA>
X-ME-Received: <xmr:rXsvYWZ8q1jciqxb7fSpsXfcUlykCI0SFHwi5a4L9mV2zMEw2Atv9MiENd-FY6Y7IarIrtrPmQ0sTxyTLLJJz1PI5yE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:rXsvYZUHszktNgJi-uUnAVIjyT3B2em_jusv3cufEe_6Y6H-YFcwwg>
    <xmx:rXsvYcncqdlQKAPvCf9dtG7nEGLXDJInOm-FqpIfI4fxeB7f79Z9PQ>
    <xmx:rXsvYecz4qGLEKWZC5Z_Soc_gLQwaTrzb9LX4jwfKsGNALSIf14XZQ>
    <xmx:rXsvYdAeOKz8T0x8okP8198w-ffblCqXpCGWIP27qRzQElHrOmIE_w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 09:10:04 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5d39a4a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 13:10:03 +0000 (UTC)
Date:   Wed, 1 Sep 2021 15:10:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 6/7] fetch: merge fetching and consuming refs
Message-ID: <56ecbfc9c3ac03ae751f83eed7ff0b45966f9297.1630501732.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1630501732.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8CObKLU4AfBvGVg5"
Content-Disposition: inline
In-Reply-To: <cover.1630501732.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8CObKLU4AfBvGVg5
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
 builtin/fetch.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bafeb3d44b..09f7742d0f 100644
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
@@ -1308,30 +1309,18 @@ static int fetch_refs(struct transport *transport, =
struct ref *ref_map)
 			goto out;
 	}
=20
-	/*
-	 * Keep the new pack's ".keep" file around to allow the caller
-	 * time to update refs to reference the new objects.
-	 */
-	return ret;
-
-out:
-	transport_unlock_pack(transport);
-	return ret;
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
@@ -1518,8 +1507,7 @@ static void backfill_tags(struct transport *transport=
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
@@ -1610,7 +1598,7 @@ static int do_fetch(struct transport *transport,
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


--8CObKLU4AfBvGVg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEve6kACgkQVbJhu7ck
PpTKDw/9GNxLLkf/P6Yy+kvs6QNRdF0nihx46ru+XuwajAku486uuXl3KBbs54Uv
379ZVSGZT3ONryer0FZpWVKxCitaFdx6kXehQcOMALoYxFFkBy7RpLrDHOMQy7s6
juiRMnEqE9eM47aDC972+XTr6LiZXKcp8GiEEYP3OW4xDhuRqhUAkTw/7qd/4eud
7R8wwhZr+082IcOhgH4Ne4gyOxKaAQoL/9gFvHhZqXkybLpgDCLAE6l6p1LAIIbB
xdSvqGeqZ/wW/xlj0sU74vUgXJRGCmeyteUbMBtjROlEU7ZgZINGmOxV+i5MlJcA
Oc2AH+t+CwK6s+2/mdNFg2dvxDzftnUdwG99EaqTrT9kvhI2e46aPUyT1ywZ2Ts7
XV8q9BtPVMzjpD3b+6kpxnXyvdFlgaXu2eoeiPL0TtzVk0ytFAZEilPWemZNwgU+
IlMIO4TjmJXXMHQevGchWEVObeYBaCZT/7lUcp34LBnOmQbre2yjYCfw5F58a5qy
76oMtCR72Zm0s1LNBYOivMuehFl3IocxNtKtNsOQD6kXA9cjaP6dTdOs/qLP5wxQ
VqmLf8gl2XQQWCB2lJrC9Of85P9pR4mikEREe96z/4RYzAi3ITqrr8W5KkSB+8l0
WVofHZsoEsm30BJiKfNfoXebWeW4UhYqHdXT9GqLGHFeNdD/Ybo=
=eiVG
-----END PGP SIGNATURE-----

--8CObKLU4AfBvGVg5--
