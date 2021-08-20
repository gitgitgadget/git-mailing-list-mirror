Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5577FC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39547610D2
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhHTKJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:09:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33259 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238492AbhHTKJ0 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 06:09:26 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 4510D5C008E;
        Fri, 20 Aug 2021 06:08:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 20 Aug 2021 06:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=SfCRg8AncORoKzoD8jgUsNnr77n
        /s9Y1vMAtQGdGvWM=; b=BgdjiyD1h0SZFGF4RdT0x/yL7iya4ct2/gKwIZCtkCg
        n8bHAAaooNEXXH6ztjzRTVyxqEQjIb2z1zC0VFOXHF7Nzhpz0LawRi5dMzE47VRZ
        21ANaf9eIegAxreRSxUbnrdWrrBqWHWVWB7oBTyx6WTqLI932VfuW95ieqkdTygB
        TOOCuJClrRPghMu+oagDbuYoTp0N3v3HzHAC7iyr4PbwznBW734zaJXlqk9neTLi
        FRdxGZU92YJz4AoyGUzOtZyz0+sG8fUWYj8zp72ov5lwKf655R0obPcwoCTjSd5h
        XF1x+CH6PexXsGmEzzb/S3spn6AURhbMIdyNRAkDq5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SfCRg8
        AncORoKzoD8jgUsNnr77n/s9Y1vMAtQGdGvWM=; b=LwcsfJIkUmiQrzJoEC03TS
        17w/LxMANAc2ZNb4XxtJCHaMNUBY+TGOu5CC8ygZe2Y9z/a5GdLR4IT7CqoaB6wc
        Wsdrb3Ebm6zZ2SDcTAm60fmj22wL4oLbU7bMpkkzkeQ54OZeJGr10l4PkS7BfCEK
        /ofsVUb0DnW/7XGWyz/Kbb+akZae5wr+eyKUf2QqV+rY1jmvwpSHJkfRvC+hMG38
        WHQnHxbRpQf8/q9UU0zLHdjG597ytPLauNejbv/DTOTb1941IT44OuFqlcjXNZJP
        RFcP2KNjR+X4ULiYFoeY1Vz6yT0LYdmoc1y4uUmRxYSprIKtX6GCkO20Fs7gp5Vg
        ==
X-ME-Sender: <xms:MH8fYYxvMU8o4AeN2br1cp6X0CJUjQj07AG0aIpScELM3jyldTXydg>
    <xme:MH8fYcRiSqdvO0_JgUJYK3uycr0SNPRwllcCZuI0bTjlEa3UbnThxaSO6mCWjKEQd
    ssDILkJqb5iTNh9EA>
X-ME-Received: <xmr:MH8fYaV9eAtFW4pg1buxGD8isbtowDsjV3f8GLziSkLF4dwx-HWfaNsG_fdlUtbE52xXfiE369jH5-rKrG2kfbd0ATKXQgQl9kUawX4TQcexbLPX3s4ha1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:MH8fYWgpL1K4fVGeyG0eJJhayCedWrIoWhAyxXJ0_GobKepbG2vh7g>
    <xmx:MH8fYaDVa_XhmPjKI2Sk_ZB3dSTNVPwC3OumAF82pfG582JyP0RgBA>
    <xmx:MH8fYXJRPpGZ_On6vrjADgFoq0MdzwYuFym4RLAwfJJgXmnIW6VuUA>
    <xmx:MH8fYdP2f5lUHacEhgRlOzuqLHKDis2mT-3XV7afP4d3erQKA2VhCA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:08:47 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id dff0bf99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 20 Aug 2021 10:08:46 +0000 (UTC)
Date:   Fri, 20 Aug 2021 12:08:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] fetch: refactor fetch refs to be more extendable
Message-ID: <7653f8eabc1eb9c26e06ad3efa3d7e19dc9547cb.1629452412.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xr0Wt59dw6FZ4z1E"
Content-Disposition: inline
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Xr0Wt59dw6FZ4z1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `fetch_refs()` code to make it more extendable by explicitly
handling error cases. The refactored code should behave the same.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 76ce73ccf5..20fcfe0f45 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1284,20 +1284,29 @@ static int check_exist_and_connected(struct ref *re=
f_map)
=20
 static int fetch_refs(struct transport *transport, struct ref *ref_map)
 {
-	int ret =3D check_exist_and_connected(ref_map);
-	if (ret) {
-		trace2_region_enter("fetch", "fetch_refs", the_repository);
-		ret =3D transport_fetch_refs(transport, ref_map);
-		trace2_region_leave("fetch", "fetch_refs", the_repository);
-	}
+	int ret;
+
+	/*
+	 * We don't need to perform a fetch in case we can already satisfy all
+	 * refs.
+	 */
+	ret =3D check_exist_and_connected(ref_map);
 	if (!ret)
-		/*
-		 * Keep the new pack's ".keep" file around to allow the caller
-		 * time to update refs to reference the new objects.
-		 */
 		return 0;
-	transport_unlock_pack(transport);
-	return ret;
+
+	trace2_region_enter("fetch", "fetch_refs", the_repository);
+	ret =3D transport_fetch_refs(transport, ref_map);
+	trace2_region_leave("fetch", "fetch_refs", the_repository);
+	if (ret) {
+		transport_unlock_pack(transport);
+		return ret;
+	}
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


--Xr0Wt59dw6FZ4z1E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEffywACgkQVbJhu7ck
PpSPeA/+Mb5ZE9jHmMFYTu24Qf67IaEce711rx0inwVZDL+HMj4anjhEkEoB8/HX
zNQgJW2eT3ADqQBk4f2uRrsSzv5Ebq9KWOquDgn34lFmiUaEsNtK9Ay9pAtCAG+6
aGNIc33sjhc8L3DX/7mGJuVfz9FKoQN+YmiLy2SPhscq6WoEGnRW48QCo75wcNea
X2iD6xV1XcNIOfub86O+e0J0UibWBs9bHJDyvW8WORaAj4vM9F/YB4303l1zjYjQ
5hGY7n11PdBYfa3pdDRR8M5QlIsq3vqkkF+qkFG6UT9EyC5UAMHJDszR201/B58K
2qGJJ5a76u1CSykIjTQsbNiklNVUYm63bG3qdHDrLcvW2rvoXL7Qe2/+ftgomiQs
kkQ68D8xaZOseoWgD7Lpm7PcnBnhImBkZAwh26rO/8h6T7snYoGXpwoCVmtrhOmW
N7+8uzmn95oW5nz8fdhI2Obp40My8d3s0ap+8SAndD+e4mxYHWVki1bM6lI2ZCCK
38buvkJzk38BrVB1oOlgmR6v0AkqhFHh3xnYgsoImeR4/7ztxGzKB8y/jQDaQIOr
mVea2FpXb2Gz1RFJDj1JdftnSn8Re+mmoprgsvupmPil2J8PQdPpG4D28g8PVzDP
g0P1O7MRXeK4tS9IAIYXHpPHAjgWJkq4y3yxcPSLBapvaSW+meU=
=IwKk
-----END PGP SIGNATURE-----

--Xr0Wt59dw6FZ4z1E--
