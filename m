Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C35C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4080464E31
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhCAMWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:22:01 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59719 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232943AbhCAMVs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 07:21:48 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 597329E0;
        Mon,  1 Mar 2021 07:20:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 01 Mar 2021 07:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=pzxtxwlwXao9DM4Zcf4IJQyC+2x
        psUjWreAYAaxyaNs=; b=V36NfkR26U0BWvxziQU+x9qxPrtF/DYxVbvhErb0rMI
        xeh556/ApoTHfA9JhfQBW6LWFm3aef0rRVespwlDx8/3PBv37XeVpu0RlgwVnqIv
        J+gjoad0CwcLtKPfjYBJpZEfzGu+gW00kCMAtC4vPcKEw7XRY54jukuZ5tbLEp64
        cCg1rob2/N8QIzd7pd3ai96yZRmy1BTPtA6v56C2v6UVs71rhNEaxJ3sR3AgaY4f
        XsonvlvPkppsGK24+C2oi4vUyRPrbpwxSnhQFZ/dWS70O0CSLDRe1fkmDMZXwDN8
        /NaHRoFCmqkh12NzugF03h17d7WVfIc6z+fHsHpUYgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=pzxtxw
        lwXao9DM4Zcf4IJQyC+2xpsUjWreAYAaxyaNs=; b=Qll49AcEZuLPIJrkXv8mKu
        SN2Ov7jEvKfdNaxv2R5Hq54CEwXZJsXkivBukM6btX34LGqdYsytdTIdxoT8xCq1
        w67WBwOzHyQJZNoVHGPS2FzwTJj3YKCQ7AsS6zDjTJu7tCWO6f65+NdOoxQ9N985
        vSJgr1Jn3TYkm40cId0x5LPzfgtJGOhCkmR8aNcXAnpd/SoCBtbCWo+2jDmpKnFa
        9hap6GH5pDPfdBRDlTCmdAfOCKiYi3oKDxdn8RUOUvyc5tySE7t6yYuOyJspn9Fk
        TpfClGi669BjapODvAM/B6DLKEAhE0nqRrFCziPorjSAkY1J6/dPZNzpn3NLx9MQ
        ==
X-ME-Sender: <xms:Gdw8YDEan4K7cHhX3UGBuLd6jM1EKBX-cCMKWxoLDKFMg9dA9yEJzQ>
    <xme:Gdw8YAVJaHqTbIPmvSxBzTtDLf0LYtsbS70lqIJeWC_W4xjqSLl5tSwFfPnEvRSNG
    _XdkEipQ-JV1MRgrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Gdw8YFLt_W1E1vyy6k7a1SNrBqEACz2OsXfsCbBLAsax8Qg8yu0SvA>
    <xmx:Gdw8YBEk0SApxtsZhZ22ckjbwQ10d3U8vlMlBmGuyQT6De56dDQItQ>
    <xmx:Gdw8YJVlYxkZlZQ9C2fkVAZRqVx-bfV_4t6NnZS8IZqNSyuNTfheDA>
    <xmx:Gdw8YIC3SKVdk9faXMCvDYuSu2NMzKET6HXT7FIOqDfHgxq2wXiTog>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id 71E8724005C;
        Mon,  1 Mar 2021 07:20:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 50936689 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 12:20:40 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:20:37 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 2/7] list-objects: move tag processing into its own function
Message-ID: <9feadba12420842437047fe6ea1351a8a330714a.1614600555.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wMdeF7hoxz2/bCVf"
Content-Disposition: inline
In-Reply-To: <cover.1614600555.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wMdeF7hoxz2/bCVf
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
2.30.1


--wMdeF7hoxz2/bCVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA83BQACgkQVbJhu7ck
PpR3oA//TjlfJFYSecKMTR4ENaJTYUjHIHXsYbykUU3Sr9LQCCBC0KZKU5ded4iw
YRc8qki0erOvVtCEC5xSJYctWvDZedaOcnJEPCqT/kngmsBo78+XZZ/sX1v1JtTe
elDbDbt7bRnnUPqPbPmkPOqRX1Q3EZIS4QmATrDGTsBWLznJor7WtXUhzTAF0bd3
7X5Cfev6fky/2wxuLjy55RQC8RQ9UH4U6VY48qhrU5MpX99WLp5XM385Gc7nZ9V/
DzrQOUngdrKUHvcBh6YdWrGnVytDrxhFO2T1QiKoNRMgTIXtqhpHuzlcyzGhI1yn
xnSPyG00Adx0Hh56oWBWAqNDErle1ztsV/pj4+ztOEBxwisB8OQNqkvqnqLfS8el
usGMIW1rfRDdm0Jb80T+ei1m3KAS20AT+B33AS16uT6D+YvhvxTlGiw/smOEEoj1
NXQ2GWY/ymVn6R8qzci0r4n8H5Us4uA/FafNB5a4XbJaDqFyPgiUapj4uLrmQRz9
ccgBPOPls+49xgVq/Z4l0wbWjXOdaFDFrGDs5CR9JbgsIEImhWPqsruV7MbhP21G
ugPMyB4jWJbn3GzGZCbgjHuzCEUPoHgS7WyGvG40YGnVP074gMrqByWeT2quf5Ar
DbyJH7x5UyeFTFapn0Nyw8gIBNmTdB9woEYUnyTAvPW77h5yrXQ=
=Odlg
-----END PGP SIGNATURE-----

--wMdeF7hoxz2/bCVf--
