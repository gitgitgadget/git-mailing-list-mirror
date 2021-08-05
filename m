Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B018C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB7A61108
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbhHELZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:25:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43967 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241003AbhHELZy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:25:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 572375C0045;
        Thu,  5 Aug 2021 07:25:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Aug 2021 07:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UOwEP93xR/+5B2SAHmS3fbywrQL
        MKr5fGDoOOCMCTyM=; b=Ru6uGgcCgBPuXjLgulmiLDJEYH3SPdP2juWx3z76tBq
        jNudoKu8vwAylL9qImgEFgY9bFDCTAoRkpdICuV9BPgQ4lFn1aQzLhplKISBbSO4
        LF5HoYErdOzynKzcKs56gytYCEt+mSR8xOFZjI5rwGVS4uKddROIka3EqxEY992b
        y7yU4sYx5MlrWGAlbPwy5fIsNpqagR4AcI/LK5rf8x+fh8oGHPUnQbB2BNSPOOW3
        BVey20EY423dT/m6tC8pIqiIAoBkYLDRnEfC5d9H+jV1DgNeDTrLZUwnweTpH38o
        YW7nWvjvWVtaewY/sLbxYQuK1GCvKkEB1uR5tQNGUuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UOwEP9
        3xR/+5B2SAHmS3fbywrQLMKr5fGDoOOCMCTyM=; b=KMdTMPWKCvSnEbfIM4sEUr
        NPpIFFChe7lhFRvSsLZ7LfkpzEr9BL1V16xU+H6WNRbg24vPnH1TldE7KwjFbbO2
        YJe17fKdxwUvw/7O46bO4tyg5qTHE6JOT7yE963WAj7SCS6XDGcG+VAaAsqSZf2Y
        7E02fgEgiCojhbzV63igSsCup/2JEpCSfeHi2R3QqegpW+Sd3t0QClE0O6AJbX4d
        NzGTdKt7osDVB3oq1lmKDdoUdpB4324U5MKMxpRs2X0iFnYSxoDOEmPYoaqcF4Ln
        uqVE2H/iMTQySWaudqcL9pxhONfJX58GXDfkW2v30pYE/e+gY5C+4XFPSOllCZCw
        ==
X-ME-Sender: <xms:tMoLYZpDD4ffI282uy4NBNLnznLryxtRdDnMbw5szUSOrULv2Rk-Tw>
    <xme:tMoLYbpAKl4s_yMvWOJHCaaEwcaULcLc_go1tD9su36CORWhFgYsxOksfLcXzE_O9
    LRYcXxwARbD2k2m4w>
X-ME-Received: <xmr:tMoLYWMD_fx9Z_CwzGtQMwl_Mdrm1p8yY1n5OYvcFuwG2YOaeOXMY3zXAZbXb8ZJFzhQwzg5dgnE1LxukaKbdxXopIAjeLsbuhv825OO6zrHjiLKymQ-9h4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:tMoLYU7P7Eby9KQzxnKAWkLUVprxFrMQJmm4Tt7iY1m21FDuO_8l4g>
    <xmx:tMoLYY4cQPGnlsoe3ylzd6PXXNirA6W3XU-ywnvJBl4fCI5wH03Kgg>
    <xmx:tMoLYchYwkkTDun0XeEuqlwibovB5fy_8_-lQmtoqXO32nnZpY1iZg>
    <xmx:tMoLYVvDnHbXSr40lKJzXzQatFJpxsexpFxyk0To50lpBxgURkbYQA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:25:39 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 620dfca0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:25:38 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:25:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 4/6] revision: avoid loading object headers multiple times
Message-ID: <ba8df5cad00c5dace1d3abfbd563197dbb6b4b32.1628162156.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628162156.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AXf/ZMVOUWd2Pl6c"
Content-Disposition: inline
In-Reply-To: <cover.1628162156.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AXf/ZMVOUWd2Pl6c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When loading references, we try to optimize loading of commits by using
the commit graph. To do so, we first need to determine whether the
object actually is a commit or not, which is why we always execute
`oid_object_info()` first. Like this, we'll unpack the object header of
each object first.

This pattern can be quite inefficient in case many references point to
the same commit: if the object didn't end up in the cached objects, then
we'll repeatedly unpack the same object header, even if we've already
seen the object before.

Optimize this pattern by using `lookup_unknown_object()` first in order
to determine whether we've seen the object before. If so, then we don't
need to re-parse the header but can directly use its object information
and thus gain a modest performance improvement. Executed in a real-world
repository with around 2.2 million references:

    Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --not =
--all --not $newrev
      Time (mean =C2=B1 =CF=83):      4.771 s =C2=B1  0.238 s    [User: 4.4=
40 s, System: 0.330 s]
      Range (min =E2=80=A6 max):    4.539 s =E2=80=A6  5.219 s    10 runs

    Benchmark #2: HEAD: rev-list --unsorted-input --objects --quiet --not -=
-all --not $newrev
      Time (mean =C2=B1 =CF=83):      4.454 s =C2=B1  0.037 s    [User: 4.1=
22 s, System: 0.332 s]
      Range (min =E2=80=A6 max):    4.375 s =E2=80=A6  4.496 s    10 runs

    Summary
      'HEAD: rev-list --unsorted-input --objects --quiet --not --all --not =
$newrev' ran
        1.07 =C2=B1 0.05 times faster than 'HEAD~: rev-list --unsorted-inpu=
t --objects --quiet --not --all --not $newrev'

The downside is that `lookup_unknown_object()` is forced to always
allocate an object such that it's big enough to host all object types'
structs and thus we may waste memory here. This tradeoff is probably
worth it though considering the following struct sizes:

    - commit: 72 bytes
    - tree: 56 bytes
    - blob: 40 bytes
    - tag: 64 bytes

Assuming that in almost all repositories, most references will point to
either a tag or a commit, we'd have a modest increase in memory
consumption of about 12.5% here.

Note that on its own, this patch may not seem like a clear win. But it
is a prerequisite for the following patch, which will result in another
37% speedup.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 0d99413856..25f4784fdd 100644
--- a/revision.c
+++ b/revision.c
@@ -359,14 +359,22 @@ static struct object *get_reference(struct rev_info *=
revs, const char *name,
 				    const struct object_id *oid,
 				    unsigned int flags)
 {
-	struct object *object;
+	struct object *object =3D lookup_unknown_object(revs->repo, oid);
+
+	if (object->type =3D=3D OBJ_NONE) {
+		int type =3D oid_object_info(revs->repo, oid, NULL);
+		if (type < 0 || !object_as_type(object, type, 1)) {
+			object =3D NULL;
+			goto out;
+		}
+	}
=20
 	/*
 	 * If the repository has commit graphs, repo_parse_commit() avoids
 	 * reading the object buffer, so use it whenever possible.
 	 */
-	if (oid_object_info(revs->repo, oid, NULL) =3D=3D OBJ_COMMIT) {
-		struct commit *c =3D lookup_commit(revs->repo, oid);
+	if (object->type =3D=3D OBJ_COMMIT) {
+		struct commit *c =3D (struct commit *) object;
 		if (!repo_parse_commit(revs->repo, c))
 			object =3D (struct object *) c;
 		else
@@ -375,6 +383,7 @@ static struct object *get_reference(struct rev_info *re=
vs, const char *name,
 		object =3D parse_object(revs->repo, oid);
 	}
=20
+out:
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
--=20
2.32.0


--AXf/ZMVOUWd2Pl6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELyrAACgkQVbJhu7ck
PpQhow//Uq6KUtJ0TXIB63s14CDLUk4oidGxyK03vLCJnpyrDD4NR9xj1+laN4AK
CgXhmzpFd8InDk4miyf1fyfcuKwMTmLX5/306GhSI7gGxWd0ia4s5v0UWPJNZjzG
lye4j9lZ+57tWNJVlcaW2BCBoxEUGPCEjNvOKIUlDj/IWshJofFmAt9b+eoAGdDC
RAAmQNZ/f057c9q7T2kzPl9+RLPoVEGHtGCCbSy0MidA5naJ4WXIhDM1FKDdeZVr
yc1/4oXPCtNrNOhZ6zsHvL3O/V996lJpFCEHBPgGI8hZzMJIG2yU2Kzbae6NO+7F
2HZPvV3KCoDggtUWBk4Obl+1jjSe5X0WXFuGEkARWcr/yRlE8k/9jfr79efSI3pq
uKXtN/pR7ilskUvSLPJhq1xGI8qMDcVq+t0kjlpQplH1NwZn2Krj8zmbtC8+K63H
+GMDrT8NXc15zgjjQcYUkKeN2V8IrFDT99jF10voDNFnlUBVuTh7W7/GnlzfTsW6
dm9kdj0DVxfZubOLvAObtNwGdNX0fLxyB3SwLsyzcIyRbYjLGe5exCkhhk2aTPTy
aw1nv3bsOeUVacZQUUtQsbiY4nPs/u02otyQbh+o91uyiO5Xu7IU+iPlRCsVg6fG
eYdh18Zoh4sEZazvnHYAtl23jhZc1NtIXZvjmsdPcuAI/HBfdo8=
=jKKD
-----END PGP SIGNATURE-----

--AXf/ZMVOUWd2Pl6c--
