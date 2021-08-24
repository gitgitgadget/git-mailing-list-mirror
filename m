Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B37BC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1377E61008
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhHXKi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:38:26 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52065 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236285AbhHXKiA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 06:38:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 656BB5C013B;
        Tue, 24 Aug 2021 06:37:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 24 Aug 2021 06:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ydwJQMST+meK/8kus6/KfBJhg1U
        n+26LX7CfoObwmbc=; b=UWaBOPIDJpUC8BggSOHnJ5TARL4VCvAjC2kPcqc2byS
        R/rBOfbAN0SZs2XLXTZnIRIVYd2rLwPn5oYy4tG1a3syRTPyDo1Ec4+TpvGhicP7
        qiby0bW2DeNu9Jl9auffvTetLr8irvYtc86Lk1FYyvZgQYmczJhncXTOzHVTw53+
        Lk84eq8oVSrZNOFZ9VAVuHBMBSl0atINNrQR5nB9meOpSaJZBVeabTMfDcR5pk3K
        GdC+o/mVIK5DrnFFVP4lbAQ/Rk8cUTEzfa2e2CBozgwUvdYocHkKbOw3t9gZJXsL
        uFNpgsPGNUYlp+GSFB+VBvAYsyy1GSgfKY+ZlYEIFvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ydwJQM
        ST+meK/8kus6/KfBJhg1Un+26LX7CfoObwmbc=; b=ILk+mvAMiJsFGZ0JgcY0iI
        At09Kby4cODHH8/3G1BuvLcnJXEewYjPkArw3onR3fVonudwb9I89FDv9fDzvSV8
        x2k8qbjcA1pzNjD4wW8HewFQPcx7jVkB/jVZsu5YAIT+kwUSZ2UOG1lMRkxuOxQI
        Okolub+RtLU6Q84wKF45wdCje3Ny3d87SnpNCcqJ2iHFnngE90PV19zFqkm1NUrZ
        6gdwk8yA3FUSiQDpLZTK32jfMFse/tQcHAAdYGPCPhoNB0rORWNbJpJxPpAtvcTL
        vApEAxu1Sh4fn4gi0N1WStjfVh4Eol/j4gTnekXEss9Pi6R6B03EyhkTZffIUFXw
        ==
X-ME-Sender: <xms:3MskYTMw2YZlULATO-MDpBrKDdTO5DDer9a1w6ma-0DbnRcqW1zPOQ>
    <xme:3MskYd9zwXzUPo2oI44j7mop6MaJ-Et4F-UHmro4HHNAt0Y_985Tj5SNemmIkZliT
    vLFZOWTqjmXiJxewg>
X-ME-Received: <xmr:3MskYSQIbReyWJZpjY4wShGGjm_0cfWmwTPdUFQg2R250J4yxue3LjuBVhzku-x47hquhISYXMk7ovWlQnZc6-kIxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:3MskYXs70OzofDY3IRu7CnALdKSLCbR0KIjD5MrcLuKO8rQCT8_dkQ>
    <xmx:3MskYbeZwaWCKfRQ5sErR4pwyYLm_F7CDEP4e8kmaLTydEoR2nVQhQ>
    <xmx:3MskYT15I2tb6KKtIVLPXqvDDB7DjlxTculSopedxJJuXV5S3ZGJFQ>
    <xmx:3MskYS4-XpIpX_9zvFH2HxLEArhFWWdReFWzswyV6MQhj7YDD7iJsQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Aug 2021 06:37:15 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id dd71eb36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Aug 2021 10:37:14 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:37:13 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 5/7] fetch: refactor fetch refs to be more extendable
Message-ID: <56a9158ac331f9911a4347d7d4afc2bbd2cf4d33.1629800774.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pVr8OgdlVqr5gYn1"
Content-Disposition: inline
In-Reply-To: <cover.1629800774.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pVr8OgdlVqr5gYn1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `fetch_refs()` code to make it more extendable by explicitly
handling error cases. The refactored code should behave the same.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index cdf0d0d671..da0e283288 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1293,20 +1293,28 @@ static int check_exist_and_connected(struct ref *re=
f_map)
=20
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
-	int ret =3D check_exist_and_connected(ref_map);
+	int ret;
+
+	/*
+	 * We don't need to perform a fetch in case we can already satisfy all
+	 * refs.
+	 */
+	ret =3D check_exist_and_connected(ref_map);
 	if (ret) {
 		trace2_region_enter("fetch", "fetch_refs", the_repository);
 		ret =3D transport_fetch_refs(transport, ref_map);
 		trace2_region_leave("fetch", "fetch_refs", the_repository);
+		if (ret) {
+			transport_unlock_pack(transport);
+			return ret;
+		}
 	}
-	if (!ret)
-		/*
-		 * Keep the new pack's ".keep" file around to allow the caller
-		 * time to update refs to reference the new objects.
-		 */
-		return 0;
-	transport_unlock_pack(transport);
-	return ret;
+
+	/*
+	 * Keep the new pack's ".keep" file around to allow the caller
+	 * time to update refs to reference the new objects.
+	 */
+	return 0;
 }
=20
 /* Update local refs based on the ref values fetched from a remote */
--=20
2.33.0


--pVr8OgdlVqr5gYn1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEky9gACgkQVbJhu7ck
PpQY5A/7BV60wJeytz02BExOEsYLE7mgBM+69ntAFTv7DLJafrk6/+BIhF8NLtnO
H1peipVVtznRhhqrBFRjJ7lDH9jd1ZaRN8qmlUG5gWZqEwRhikN0NijpMykab1X7
SKMErPx+3LXMymOoJ3+JriedtfOx3B2y5YOXcCdl+uoadmLMtjg2i3A6tSzTc5kY
mQOAfbmirCsfFIMAq66lQSMXskqbZWy3+xWGRO0a6g/br0lc56tUEox8TgKikP8m
JaUDc0og8Uq1RIw+ZtgxdmPpAmcwm6pK3YcL/zJJQWtTLqpqz+qOLCLi3wnC7oY0
vRqyPH1NckxEoc4MlqQvC8HykhFWRSkNADerHIWkDquWRvx9GG2AXKwXSWZw3nGS
ybQ707yFy5qnSh+Y99KU2G9B+0GrI5odzk+errRGvzy2SuXfhD3YoqTvP4ohgrqk
pfyxXD5x7WJ0QKJXMEuGh/BPk9vGQhRatLUfSuXUCpJ7hekC2Ss85YmcrXG2rDuJ
So7thbWZ0KUx7c7OC6NnGgB1ANw+O6/lyf/5t63S/Ohj4pVdNoJXXxSaDBYB8ZKh
VvEZZtNS2asT9Byl3dKItfUo8ireDfGxyOS14BHHoHekLe7UjSM6t9WgfVG/jiMw
CGK6yDm7gVVQUWoWuok3oTwSxoOHBZ8nk6e680p5sRIRhJqkBIw=
=/46K
-----END PGP SIGNATURE-----

--pVr8OgdlVqr5gYn1--
