Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A43C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F1E6108B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbhDSLrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:47:20 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56101 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238853AbhDSLrT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:19 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 59D92E11;
        Mon, 19 Apr 2021 07:46:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 19 Apr 2021 07:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sDDJEG8WaKOB8DgW61tKtMmQ7f3
        ifwVRtzy5Mdd2fzI=; b=A6KF7FIGubILHBwh24BeAMLKxtSfSLbvX09tSthzS9q
        39RZ5Akq7FN4n1RLEF0qif3s6PLpyORZqFYqz0rkc2Ubg0cY4VD8AeGewEGhOZun
        viPmTqr/iKYLXa1FAH9YIJqrc2l6no0mZy/9+jRaRhiAsH1qYgKypS6VAphRzDiX
        Av97yYgeT3CsMkqIuD7xw31lwy6pQgsD9rCr84XSEVDfaPodGQ6mfInvT4PnXkra
        U87Q7+EGcXaEeB0fe13YuJxadOrucSFRAB6PUpz+4mJFbApwTJ+tyNQQx59upitB
        xfV7Px9hBtcjaBrkUp/yKFv6QCAIKB9SDRtOp6ZFzrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sDDJEG
        8WaKOB8DgW61tKtMmQ7f3ifwVRtzy5Mdd2fzI=; b=j3pVNHci4hmrkUyJq1T6l7
        h3+jI5cV/VllPJiscFatmB+i1e95F5OVpLL5TifzP8domzIWjYuO9D+ikiEM8aHq
        d0du7czBhLumqXTQoRdYFzLCb6e3XukS9UkFnZaPHouXstt9RYfujTgYn20cHzV7
        m3o5tiCui3sB2j46ifbgKx9sOF7ffmehWINwTy6cUbBwZeOwgJXacAcxZ8hAl3j0
        V6M95idQbUo4PZ7ksVyGmjHbIks0uFd4asaIkLG1Y+Iuo2DIdkJx8RlYG30nxZWU
        Q+lC1QAzdnvovPOSEub/G5fw8HMrz6ZOgIUfpEIvzFsx/7KlkNXvRjvhkT3xkHPA
        ==
X-ME-Sender: <xms:qG19YJS-12aqOzXAsNFmiQ6Wdtq9CqYWk_-Va2j9uqtmhu-f_XAMqg>
    <xme:qG19YCue-g91JzaYE6_ZX4pNbxhoxwCtsmKVLKuZXIGmsgfmp8FK1g5i11230vvSr
    S_0KkLxrxSaCPdwJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qG19YLvvmLK3rpvXPHRQIt_53QavVi81kfqtvEr-sCF2jKGFAd1GIA>
    <xmx:qG19YIwBj14rJZOVve7mc5SuGArtqek_FzAqo7wi9fv64oYxQEx0-g>
    <xmx:qG19YBh6VqLkHooN1uf46-f6_dmNqc6R27411Duogf-LD39oleu3wQ>
    <xmx:qG19YNkGMHaBzQiZdmb7UOLguRO81v0Nj9b8J3MLk3a-BJ4S4_RB4Q>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8CDE51080063;
        Mon, 19 Apr 2021 07:46:47 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id de706fe1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:46:46 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:46:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 3/8] list-objects: move tag processing into its own
 function
Message-ID: <21d7f06d0a94fc8b4f48f90007adb30fae18aa28.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ojc5Cihc3g6YI9vE"
Content-Disposition: inline
In-Reply-To: <cover.1618832437.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ojc5Cihc3g6YI9vE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move processing of tags into its own function to make the logic easier
to extend when we're going to implement filtering for tags. No change in
behaviour is expected from this commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index e19589baa0..a5a60301cb 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -213,6 +213,14 @@ static void process_tree(struct traversal_context *ctx,
 	free_tree_buffer(tree);
 }
=20
+static void process_tag(struct traversal_context *ctx,
+			struct tag *tag,
+			const char *name)
+{
+	tag->object.flags |=3D SEEN;
+	ctx->show_object(&tag->object, name, ctx->show_data);
+}
+
 static void mark_edge_parents_uninteresting(struct commit *commit,
 					    struct rev_info *revs,
 					    show_edge_fn show_edge)
@@ -334,8 +342,7 @@ static void traverse_trees_and_blobs(struct traversal_c=
ontext *ctx,
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type =3D=3D OBJ_TAG) {
-			obj->flags |=3D SEEN;
-			ctx->show_object(obj, name, ctx->show_data);
+			process_tag(ctx, (struct tag *)obj, name);
 			continue;
 		}
 		if (!path)
--=20
2.31.1


--ojc5Cihc3g6YI9vE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9baQACgkQVbJhu7ck
PpRS0RAAjoC/3bIzJwykxCIX+itTrjJUNUF5BFlP50/MojlTfGgpnOZimvFOmek4
XpeLyxW7lY0pk1u1vYBuUAMKeAdKBppLzVgBOZF7dnephzzPIu35nZEM5GPZt01U
G4tZyAXsiBa+1kqX9YM0065U+FqQE4sb1BPGZ60Gb7yBSsUFrpNowwySP2oWVDc6
VaMuOq/9VJeMwzE3nZbT8cZyxWG53WI1TkP5JOTUEBVWlF7FyZHz6WzGZYfQSRXH
AGwzryix1xtMrK1y11/R5e/eths2cl1fNffneYgsFy219IMf5BWCe8Cnun50AgUW
QTM4tzLS0acAHK6EaajDYAkjS7eI1O3BIhFLfxxSLclQvM4SvXJkL0y0SpZ/AN08
Sxh/9eXRMGb9IfegpeU3X1/huk+gqA3IPEdvhPGAoj2dk6IhM+/U45CFPN6azsmX
thgIodasIX+0GB9SUiCRUqk+yjA/srbwZ34Tn5wrBwHrqvzO5b10hP159A67zq19
QMoyQBGn6jh/X9jntnLDdLnwUcER3fKY7RD2aHbKNXbQXQqVhi3Pkirz5OVGaGNE
UKhrM+cLYUcVkJEC4uARJhFK/Yn6oWuky/ioE2E17Kv+xckO7NwtXZVX38p0r89f
BuXRHubqqJyTbOqjm3zDhUz7DoHmkPipq3/yjr3YvW1SrphoW4U=
=O1N/
-----END PGP SIGNATURE-----

--ojc5Cihc3g6YI9vE--
