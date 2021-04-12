Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D363C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA096128C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbhDLNhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:37:55 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50367 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241957AbhDLNhw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 09:37:52 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id ED6531681;
        Mon, 12 Apr 2021 09:37:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 09:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=NylQZS62uBrE3ZBQTRLMOEeAaC7
        haJOlaQ328Y77S2w=; b=CJhwHFw6Skmqvj9zv09/RdGt/4BFs9YZwKr8tZ3rAGg
        FJkpeiE315U6Gjuk/tUcYXiChsCJdMuNGTn0mfUXO9vcSB6X3EpNplIGJMFEXr4j
        zoljdbczugQ3cVnHosx7QspCsq8e3GjKcU664/dDe7HhwgQAd2x1tPpX6Bl4auuz
        AB8RQEdZ+6Kmtchkoz7hvEtcrcEGcR+NJAPjEvygh57mZ/jibHFAZd/D0yWNEN5W
        WTtWLzyJlviDV34JnQbUm9/lrSHnZroUJ4Fsq0mWtnGCHlMfUF7wgl2yoJFAbvOC
        XMrHxqXdtRpI6rqDQXBIazqbXorsYudmEroIO0ThTrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NylQZS
        62uBrE3ZBQTRLMOEeAaC7haJOlaQ328Y77S2w=; b=Yt/BALkIefaXNYgONy0ppy
        XOhIX0zFMtPrTsf1K/ZZz4bMXRIlh4qY4OCmciM4GRqb9KOobEWWneIm5b9tq2vq
        CL5I0f6JSF1lWxNl4vySa8psojJQ60RW9C9OgLVGDWHKuSdC3PltEd9ekHAwG4Ps
        zYihn4dOU9NJxeKK3CghgNhBHoq7knfFW/yL5FmTxdzOQ1RUywVZpu7VocNYG2Mj
        60AiFhEM+BGjOwe+XSe7YUN42BGV5jTxZ1bAxsuzGG5yO0UjnGxpCF8ezTBH/+/5
        xyGfrA3e7JRsuEi8Ttf3HpJRON4aKuGZBvl7S2BOJmKEHvrfRyBaOqip2bzKPjjQ
        ==
X-ME-Sender: <xms:HU10YCjvurCDFlAkHnXgBvhxKsTD2OqRwd1pm3rbfa7yDzTxMBGCdw>
    <xme:HU10YC9Fy8OpzMbw3B7lQjxflDnE5mKu5Wr2VXqu6EIY9m0jl2qKt1x2_eC0IlQYU
    vYrQxfhkp4qeTqvVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedvnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HU10YG-kLSiU6VFCzAEx_ePiZJ0OZjJcte9u1zhNWDq15HNzRDpsqw>
    <xmx:HU10YDCqKbdug1CEmDhUewz7ntxugIjFMB5neTx8stogGjSsmOL-lg>
    <xmx:HU10YOyf4_7mOD1uyM8o7tnV1Rkhy190YO3MQOiFnj5V9unt6DbgEg>
    <xmx:HU10YGsrRErHvV0BqGu0oijHp5Io2JHKVCc0tBdxeiPVSWCaiIOHKw>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id D4EC324005B;
        Mon, 12 Apr 2021 09:37:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1a8f906d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 13:37:31 +0000 (UTC)
Date:   Mon, 12 Apr 2021 15:37:30 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 3/8] list-objects: move tag processing into its own
 function
Message-ID: <3d792f63390da79a6d225de51bdfc651234cf893.1618234575.git.ps@pks.im>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8FwJpsqGWnfD0hha"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8FwJpsqGWnfD0hha
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


--8FwJpsqGWnfD0hha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0TRkACgkQVbJhu7ck
PpROIg//YUE/a+R7JQiom2PeCxUHsVvyrperTKt1KcT4o6DPW69dnTtozM4dIwER
vVdamPHW06yEN8h0Dx3ezxwcnlxiMgXJ4Rgc1XMlyvzfJKVMCE302osfchpNt4vk
wmqXfVgon1gSRV4DfBZbwhw9O7Bz9t5cDUrs91OGMK+s0+AJCnuSoWsz4IbI/F9g
809Mi3KZ9e18zGctw1v8YELJ4zXtu+nwW3pV3kVbx3XxD/RTv4ZnN4/xnJn+6kr4
YJJwWipzR8NJRvW4MgkdNKUQNXQRVjbN96Su1RrqoSq9FVm4D6opdBN8S2eIhGgf
xO4DcKm6V4J9orwwP/34NWFSYrbZeJve3y7Wg6pTLsFm0r99g5F/sYEepQDVHunq
rJqVPb09kP8r9ZMJaXaFBQe6TIo70EQLcJXjF3RkoZu0ImBmF8g3sZx83TsIl1jc
YaBONpUddXJmxdiot1JhwFgoVujMIuu4+KLQ8kL/dWsg2hpA+U8lFOTjm9oHr4Fz
nSL23S3fstp1O+eATsp77bZ9BSX1vU5WgPtJphUd/RSXCaNx6sgZvMMyeWRzcvKM
tiiNc8R/anA712hPiVJGIoC4uAalEuJ1Pdru95Wcng1bl/T4rzu4O6crymKln1iK
TaV69CGgdhhesNoWMB6zi+CszsY08+UsECukQ4PRYisGtLa28gw=
=8yGT
-----END PGP SIGNATURE-----

--8FwJpsqGWnfD0hha--
