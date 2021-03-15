Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD122C43332
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785D764F0B
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCONO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:14:56 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39355 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhCONOo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 09:14:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A195A5C012C;
        Mon, 15 Mar 2021 09:14:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 09:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=utpoRoEnTPrLeARRCbgslW7vCl1
        TYcgixior6fr3THU=; b=rELpKV5yKQwp7gXhijzWjZsiWZOj4PMdHP9y5ttVSRd
        dCipsYOYvVx7l0Ewem3rHQEniHhgmJClGB5y1aQGJAbU7N+OJl4dKLq1dGkiEFi0
        DzWxpIuVk+7cKNNSvQabuK9RfgMIxcYjl0M8oHWi3gATLiff3SeVg8f+6QpX/aPb
        hP9xscyeA4QMjkT+9SychA+f3i5dRj2SkbibcfYjvBezoidnlUO2JzeXldPU7sak
        zMXCLsgc/mgC44kpBOIpPgxNGV5LP5hz0R/Ah/SJhDSWs95+PA49zaHa+wUSX+km
        ZBuimE7ncrNLUls0bKjCy53rCfafT8UdqWEe8yDEDpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=utpoRo
        EnTPrLeARRCbgslW7vCl1TYcgixior6fr3THU=; b=GOS0zSRzXjuzSdhcZg348b
        Q9cZlzu2GCBcjrr0L96rlMxQyEDi5hBjLc/+rWM6YvnzqdTlicUAJXFP3nQ+dkjU
        z462k/DSgNEvVAYt6s4OsdUMYQf8KKG+3eFmirDIAfEMltPb0BUyMeS7y/MMy1J8
        imwSHq3Qcqo6KfjUT+gEZ1wTRtHDgvudC+D3Zn/jaczPhjJeYfL1ZxIBl37znoP6
        EYUGwByxmO5cHf9OXrrhZ320w1t4Dzv4YZNcd9lqZ7PWNN2u1ZLsxdtE+cgjBHbm
        Pa2tbmRSe4YlElQS5zUIlfkJAoSceuI2ilkHZfqo8hNqdZqDHVGGse373DwBeEcA
        ==
X-ME-Sender: <xms:w11PYJ1hGnX4qE9HwwUdwTFlp0zs0agLUkMb0fZHovJ_Y3TOyO7AMA>
    <xme:w11PYAG6oPqOsHC04yZV0E1-8FSwCVq-OGW0BZQ5E_CZhLvJqtxBIbMnv2q680Tq0
    WuNbSAIeRH15oTzhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrleeirddvgedunecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:w11PYJ5w2Gs99-j15N7YqmQsLcWZA_dnCmi4UJUoGx-EX5VOpeTJ9w>
    <xmx:w11PYG1T4XqijFCXIVS6d72XAaXhZOmYPZyUi6azKbYWYX7c7aS-Cg>
    <xmx:w11PYME3pG28_ruQkrShYG3wRpYvIinEB-lppQbihnd2buHthE7PeQ>
    <xmx:w11PYGN_9KZF1ankQXXqLcqBonNokrD2r4EfGQWJ7jkmLiJlSikcQw>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id DE96A1080067;
        Mon, 15 Mar 2021 09:14:42 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ca555be9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 13:14:42 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:14:40 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/8] list-objects: move tag processing into its own
 function
Message-ID: <d8da0b24f46cd305cb1be304251745b6d9da641b.1615813673.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DeYHNGfvq3eKA6dC"
Content-Disposition: inline
In-Reply-To: <cover.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DeYHNGfvq3eKA6dC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move processing of tags into its own function to make the logic easier
to extend when we're going to implement filtering for tags. No change in
behaviour is expected from this commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 list-objects.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index e19589baa0..093adf85b1 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -213,6 +213,15 @@ static void process_tree(struct traversal_context *ctx,
 	free_tree_buffer(tree);
 }
=20
+static void process_tag(struct traversal_context *ctx,
+			struct tag *tag,
+			struct strbuf *base,
+			const char *name)
+{
+	tag->object.flags |=3D SEEN;
+	ctx->show_object(&tag->object, name, ctx->show_data);
+}
+
 static void mark_edge_parents_uninteresting(struct commit *commit,
 					    struct rev_info *revs,
 					    show_edge_fn show_edge)
@@ -334,8 +343,7 @@ static void traverse_trees_and_blobs(struct traversal_c=
ontext *ctx,
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type =3D=3D OBJ_TAG) {
-			obj->flags |=3D SEEN;
-			ctx->show_object(obj, name, ctx->show_data);
+			process_tag(ctx, (struct tag *)obj, base, name);
 			continue;
 		}
 		if (!path)
--=20
2.30.2


--DeYHNGfvq3eKA6dC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBPXb8ACgkQVbJhu7ck
PpTnWg/9E3mgHqG3zLo0VJsgw01JwAx7z91H5S8WPTpT1/etoXNZekH0QPFZ9yQP
ebQXKhdnsVISklB3eI8H3RqHlMqhUGOnWtrJezCJurkmVY0z3ZhBl6lV8c55romF
t7dxPvmGmol1zt9xJr9esMjA4xlKfy/oonewX4XEFboyEbp/EiCryZo42wYzR3j+
Mn9DcQe6G7Tuexmd1OTYVkd98A8KGhnhglDqGKrEY7aF8R+JxzQplueH+o+ygg0V
zk8ajtkH740tsl5l9Ah9vr8yQrfbBmc/OXFfVdwakyudosVqvKUNa5AHzK9Mst6x
sAJwINXmdoFN4/3Ljqpjhv+znpwMg7D51L5L07W2RAno8SwLaQLvgAc1VV6VyqtP
2ZKNSucjz5iY/+sjSlu3en+mWX7rfEyj5amaoYKmOaNM7kD1vYVcIIfGmUdSDX+w
dnurdwMapXqdoHuJTRkC1G5wNbkAsIUsLH/IOqm5oKNhTxansjd+yFwRLYhQNCSS
CSlN9xZPrAaa8rX+muKWkmVN69FimrWj9F3A9tRGif3dSc8o+nOibByk7nKGY//e
S5D66UPnQ/MwyFb2+/zECK7uojFE4BRP+5bKOIDy6iKD5FRXLHvzRm+xcQAGScCI
50hw2uwl+kr1tWw38jd8CI1H9D1s9MppzNAODQZSt9ujyec7pwQ=
=NhC9
-----END PGP SIGNATURE-----

--DeYHNGfvq3eKA6dC--
