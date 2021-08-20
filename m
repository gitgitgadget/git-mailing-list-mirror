Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA85C432BE
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CC1610D2
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 10:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhHTKJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:09:33 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41837 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238994AbhHTKJa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Aug 2021 06:09:30 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 429EC5C0048;
        Fri, 20 Aug 2021 06:08:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 20 Aug 2021 06:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=mBohNgS478ywCUXq1+GD9AOmMK6
        cqqhS2cUnOebg/Sc=; b=ub5Ib3xpDx6EGRro+Y5XK94qIBkV0eDkgJde2fF+5Pu
        Dic0mf0/a29EDpkS9/Eqm6H+r2qYI2ur/iIFJVqh2iLOz/TSh+4bfaHRrkjjq4KA
        POXacWtEUbjrO+EpFfigod4DteZITkdCl9k48qa8nr6uFLH3R6ASkJfTuC9OEVNv
        9WTABso+DAfz8H8U33d+VU4I9uclzBGUNrC7aKWkUWFXtAEdIEc0P115QM118FlB
        TJyg6L8/10mVpXWbrdl94vDp5GLNq4TEW01Yye7F/00X6ffM3fgXElnLQlpmmhYm
        1m+RYPiBLfTziZiXDG3Ot71Wipt2BnziUWx542++e7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=mBohNg
        S478ywCUXq1+GD9AOmMK6cqqhS2cUnOebg/Sc=; b=v/8AyZZA49zMQ7050v2/3F
        03Rmgrb0Vquf/NmRCG1eNKiiQxv9jy5zvSP8eKAwVzz7dwSpnmRyiW2HrxMaH3Tb
        4DioI70fVfrtwWTbXerIVdCmUG64pQeVPIGg1RLwZrxlSRXi5KhtuYnDlMrMaPpX
        uz9lOZnxgnapjxlfAEplf5GJRpubpWZRiWw1NmBvVrvPDSyntUwGPN3nQcAuTXWe
        faCPZStoT3TunRLKjf0OHQzey+KhKHrttSDTlMvxXe3nvR+QmWU9cJy6GeUu0lBd
        3Ken4No/czGNsSK/14n/X7hPkg2ONNO0HkTa4IbDbNmPvbglVjRydgDjffrJCq3A
        ==
X-ME-Sender: <xms:NH8fYUijCRMxaKqq5fnHwpa7JlRnpYcURQfQSinw8jq-QmDlm5JZhA>
    <xme:NH8fYdBRIwIUCMhFSHc7HPbLfx6f6JY3MMOM50WmmAot3csCn96tAVd1E4CR3Zi5W
    A9fZ-RrZvPI0jWTIw>
X-ME-Received: <xmr:NH8fYcENq2dxBGqMokEWZ2djVLV5hIaRWUjdyeYNEb-X8yOvvbkjx8L-D0MxOLIeecgeMKNniIHcFsJ2E4FhNmXDlXAjyubb8N8-BquiQIkpSP6sTLfNTgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NH8fYVSt_yKlDv_wkxTYkGAEGld_9OUEBXuxhnSOate5SF-yA1sfkg>
    <xmx:NH8fYRwJSnrFosrAO01z0KaSFyqaSQX7a-qtbHWaSyi2oiP9COdllQ>
    <xmx:NH8fYT6la8Q70CkIX_S5eEimoz9cSC5TycXkITgZUV7-kVAhUKuq3g>
    <xmx:NH8fYc-dCjGBuBs8_G0Rmlb5CaYMnz5UirJn8Z_pTTvT4BCTtsPUtw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Aug 2021 06:08:51 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 85dbd786 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 20 Aug 2021 10:08:50 +0000 (UTC)
Date:   Fri, 20 Aug 2021 12:08:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] fetch: avoid second connectivity check if we already
 have all objects
Message-ID: <646ac90e62aab4e4aec595d6848b60233bbe8c77.1629452412.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6nN37U3OJZieSbH1"
Content-Disposition: inline
In-Reply-To: <cover.1629452412.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6nN37U3OJZieSbH1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching refs, we are doing two connectivity checks:

    - The first one in `fetch_refs()` is done such that we can
      short-circuit the case where we already have all objects
      referenced by the updated set of refs.

    - The second one in `store_updated_refs()` does a sanity check that
      we have all objects after we have fetched the packfile.

We always execute both connectivity checks, but this is wasteful in case
the first connectivity check already notices that we have all objects
locally available.

Refactor the code to do both connectivity checks in `fetch_refs()`,
which allows us to easily skip the second connectivity check if we
already have all objects available. This refactoring is safe to do given
that we always call `fetch_refs()` followed by `consume_refs()`, which
is the only caller of `store_updated_refs()`.

This gives us a nice speedup when doing a mirror-fetch in a repository
with about 2.3M refs where the fetching repo already has all objects:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     31.232 s =C2=B1  0.082 s    [User: 27.=
901 s, System: 5.178 s]
      Range (min =E2=80=A6 max):   31.118 s =E2=80=A6 31.301 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     26.616 s =C2=B1  0.100 s    [User: 23.=
675 s, System: 4.752 s]
      Range (min =E2=80=A6 max):   26.544 s =E2=80=A6 26.788 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.17 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 20fcfe0f45..088a8af13b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1068,7 +1068,7 @@ N_("It took %.2f seconds to check forced updates. You=
 can use\n"
    " to avoid this check.\n");
=20
 static int store_updated_refs(const char *raw_url, const char *remote_name,
-			      int connectivity_checked, struct ref *ref_map)
+			      struct ref *ref_map)
 {
 	struct fetch_head fetch_head;
 	struct commit *commit;
@@ -1090,16 +1090,6 @@ static int store_updated_refs(const char *raw_url, c=
onst char *remote_name,
 	else
 		url =3D xstrdup("foreign");
=20
-	if (!connectivity_checked) {
-		struct check_connected_options opt =3D CHECK_CONNECTED_INIT;
-
-		rm =3D ref_map;
-		if (check_connected(iterate_ref_map, &rm, &opt)) {
-			rc =3D error(_("%s did not send all necessary objects\n"), url);
-			goto abort;
-		}
-	}
-
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
 		if (!transaction) {
@@ -1302,6 +1292,18 @@ static int fetch_refs(struct transport *transport, s=
truct ref *ref_map)
 		return ret;
 	}
=20
+	/*
+	 * If the transport didn't yet check for us, we need to verify
+	 * ourselves that we have obtained all missing objects now.
+	 */
+	if (!transport->smart_options || !transport->smart_options->connectivity_=
checked) {
+		if (check_connected(iterate_ref_map, &ref_map, NULL)) {
+			ret =3D error(_("remote did not send all necessary objects\n"));
+			transport_unlock_pack(transport);
+			return ret;
+		}
+	}
+
 	/*
 	 * Keep the new pack's ".keep" file around to allow the caller
 	 * time to update refs to reference the new objects.
@@ -1312,13 +1314,10 @@ static int fetch_refs(struct transport *transport, =
struct ref *ref_map)
 /* Update local refs based on the ref values fetched from a remote */
 static int consume_refs(struct transport *transport, struct ref *ref_map)
 {
-	int connectivity_checked =3D transport->smart_options
-		? transport->smart_options->connectivity_checked : 0;
 	int ret;
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret =3D store_updated_refs(transport->url,
 				 transport->remote->name,
-				 connectivity_checked,
 				 ref_map);
 	transport_unlock_pack(transport);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
--=20
2.33.0


--6nN37U3OJZieSbH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEffzAACgkQVbJhu7ck
PpT5ag//XQLajn12i23/Nf49R0jviD4AHd2Nq+ZfExA4ZHG2YQZ1Kk/Ew/24iF9W
/hlaNZ5BbrIuMOXrVZcuUvknSfmAs+MMzToukTj0SJlbBJtsGV8xAfjcucg3N/eU
cgBIGPKXdxlSObKmA9sE61wFaiCNC1YynmGh8WwTwDGBYCXS9frD12xsRIa2EgFX
ned2gGZ217G9iDAs2CbFP52Xu9SyrrhqZfCzJZVfXy9hu738W++bdF39RI5Fvkc8
6hRHsNDaK4vS6mHc2Ed8qz8Jn0RNXKn02rl4uSLS0CH8prf8Jox9a9c8QNMPsI4H
Z61McSYoL80Pr8izOaNeWiwKKv4P5SUbH6LN0SpSx0BPdUsHScqOkFNYqMHV1nvX
aWQuL5zt7GU/ugy076GlKamjII36wg0sXE0fJc3ScWxDVFAk9MYJ499Yacr+RJQh
DFEmNfzKsLq5WVETOP9YaOtAb34oBQ92p4N4NKnixv2e/y1uGRN0zo7xEp00pJpn
kR33x+WTOw7iw7LVnxKmwxJH56gMC6tLSG4nJgXrDt6y8lPj+VBvLUjCsV6KrHgl
/6WDDCI3vPS4RZcsKPAsE+rY2OlDiaotI9K6Jq2U448u/1fR6IQnPZQNJIIzx9kA
oJYZBY4GTAbpfOyJMt+/7oQAgPFf8XO4djYPr3Ax05HoUTHGKbA=
=a+xe
-----END PGP SIGNATURE-----

--6nN37U3OJZieSbH1--
