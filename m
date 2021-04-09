Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F7C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81C9610F7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhDIL2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:28:19 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40529 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233569AbhDIL2T (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:28:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1227E5C0093;
        Fri,  9 Apr 2021 07:28:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Apr 2021 07:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=0Ib9k7zztJ5PEPwoceqdhosrSXz
        QoKBTCD3p7JL90Ag=; b=OGNShehybGVvs4VgxxObjF2ybSlOPOGyQvcrLkFgjgn
        kerHwRCb+8xep7i+kIuALesS69cEf1tnoqh/l0YohylIf6QugYrkzOUYkSPEZqtL
        2LEd3nlDVXteb/lpr8QHp6BAHVnyQ11A+1TP+lbqKdLoLc4btd7NL2HruqPdM/lW
        XbEN0f94IpeQ5qHe9qQ0SA+EW5eLBQgPzeGgSwonDx/gAaF/KyGhc4v8sGaM5uyL
        aUy59rIz8NMdzXdvWiouIvd8sy0cYa/Nnz4g56SorVBgJRRddegi8wlTOArGxmTz
        3VgCKMrCOGyzmfXsYrXO0hpGLZ0Ox/uvYnSFd/Boa6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0Ib9k7
        zztJ5PEPwoceqdhosrSXzQoKBTCD3p7JL90Ag=; b=gAHiZQT6Iby6bdYiAjywm/
        EkBMhSYoclLbhH9i441McNCSXpXt3y6PTtLvenC3ZZIj9tzcDaUJRjOaDl9xtDir
        Syac21+HtQ2bKT0qekdSuUHazZ1b2qVpY5PLmDZZCHZz6WpyKlLe5/T/pdN/FZHo
        Bug8lMiIZcbGPq09uAPR2foZpE8GzLqU9Jh+tCu10qlzPQ4xQ2C3AJAA7VL7XRTU
        QTKo45Zu20Yx9RfG48znPzFNLyxUhoFyPEZI83SvISr7or+YJqgKJfhJcczjXZ0G
        nLay4U1RXfryxLXYq26/8v39UV7w2666L9qFmbSxWUV0Dl7ZZJJ2XXgYqGpJVhMA
        ==
X-ME-Sender: <xms:RTpwYCUU8ZXLJUoO3qfeSEnaC7Rg4Gb5zwbufwz2mTs84qhkWhiqCw>
    <xme:RTpwYOhSUIBbhQEyZFQe-6Xof6_F3zyNsobvMD3X-s7lgva2KUbT37iT-9ph9Xx8U
    ZPhUt1DTMum9eT-IA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RTpwYDSytAtyqLLGJSu_rC5Xd-3k2NB33XWzl-rTOon8fGNYmcctaQ>
    <xmx:RTpwYBGFpXUNH6efgLDVDbv_DnjuuQvAx-6xkO-au5_36pngGVXdWg>
    <xmx:RTpwYLn3sUURtRrL6ZtvGXBwEPgLl0ivHeAEpDbw9-WVfXK7iSPMNQ>
    <xmx:RjpwYOznGErpI4H3jPr3ACVO6UmvgTGip4dRjwPoDq0f5OgBNuepDw>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FC9324005C;
        Fri,  9 Apr 2021 07:28:04 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0721b4c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:28:03 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:28:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 3/8] list-objects: move tag processing into its own
 function
Message-ID: <3d792f63390da79a6d225de51bdfc651234cf893.1617967252.git.ps@pks.im>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37YPMUmw0w4Oypx0"
Content-Disposition: inline
In-Reply-To: <cover.1617967252.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--37YPMUmw0w4Oypx0
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


--37YPMUmw0w4Oypx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwOkEACgkQVbJhu7ck
PpQ/8w/+Jwj50CyefEdt0rv1QYR3rfWo3rwcdTUDSFDI36Hgxo4aPnqrqstgA7u6
BHPAlcco7j71hKZjlffbs/Jk4zyUs325+LtjcpT/JFi4W4xoXVZ9/4FB9ZnlNj/K
qtkH9KzjG0T+sdQBrVA4KiAkOmqrSc9Xk9AkLUwF9hDkpDM1S9RJeu3NrH6K72M9
YiuzafY6Zp6L1SvktzoOMDIRsrdHNpYqMRmlkZ1OIW+ciFE4es3rXJqA4/zOc10m
Yzpwb+khZPjFYWXE+lLinBcrxEUpYT4cMeCRpPSATL0Oy47i7pmywgui4pf2G/fV
LcaTGYP1xavfyLc3CbP7h+rDECngd+vMbWqPXbat6NJKOZj0DaA686xYFKFXUZrv
7/5eKV72/lkM31jaziTeZB2uf8QsM5dEROeYjAp05HfGZP1Qjh1puIybhNBXMNY/
f01XuFIOonYZy/P26w5fD8sWwbDksLSJnITyz4xGAJZRCIhpwinV+Z14viA97ZGB
r9etElzloZLuJ77ATMNrskkEMYGHDNZhX/ChLTDkPKWWqyNvlGPSkfq3x/X9CI4m
b78C7o0FfOj4g7ifW/XlcmQk5loAWSQ8zH+7e0V/JQBvDjsB4FbIWaQQH8ZuNsm1
8rqSxM+UeH0dk9xwXe6mQh7rE0ZuPDl+td3mh+pH7qEgpz9HCZI=
=+sVF
-----END PGP SIGNATURE-----

--37YPMUmw0w4Oypx0--
