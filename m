Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB208C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D044361057
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhHBJi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:38:27 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:52779 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232871AbhHBJiX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Aug 2021 05:38:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1EE02320082A;
        Mon,  2 Aug 2021 05:38:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Aug 2021 05:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GZHlia91WZIVolUD7vLI/abMu+h
        Hfie34ywewvxJ9bA=; b=hkNtxVNWNaz5SvigUTZGluKROknAN8Ek+JErZdcxyou
        gqn5yvWmfMQanLtFLDrGKw3U8QhG3wwZb7b2gZLNp1U6fbOFIDljZz3aVeqi7MGI
        IhsBazaZ038fy0sZBSvHdVeoihWVPK5K/Eu59vUIsV5WddIRlPE5hYdhysX9iyeI
        0WEHuchAbsuALXFaYNZC56Ta/64WtHXgCoRni2QSLMpUxrSB7WMxw9w6sH+88DL6
        o6LL5/J6VJj2fJ8mvzBMxEO3CvvsZ22xEmE7zlnU/tya4oLWnU0VyFz+N5AlxuG6
        0fLVSPZg2kwAQTbP8gPeX2yxqUbwsWm18m5eTdGBSgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GZHlia
        91WZIVolUD7vLI/abMu+hHfie34ywewvxJ9bA=; b=upvdhaDQHQCbeiRqx8wM0T
        HnRmTHU7VVQykfB1dpXj/LKFejUmN3ep1Sk4W3zxtOn7QmHY+4VeBnE2k6kxe68f
        rWJYfIO/nGAx4+JdQk5B4Z1Xo3W/h1fP3Ymc9qwyREaRWgWDxc4jFRqC4l0ikb4H
        np7sX8FIeEjr7uQeDwYcE+71A0yPdqMLa++6Fqsw5ndzUbtsgCL0VRBZ223Ipgnl
        PGJM+lpreDGZxH1iXAJ7pFQL1eNYVWp9CBmqkN0VysaCpBN7VfKm5hgTGtmoWSZL
        L4vO0DLunP7azc//nQFNwpiSistU6zV5cxUYPu5zTdJuG4PI+wsfVBIpuaCPlugA
        ==
X-ME-Sender: <xms:Bb0HYX21vD-7l8crgaQzRX6bWNmAwiVQ_z7_RUG9vVc4gkKxfFLP1A>
    <xme:Bb0HYWGwmatf0_6bzNY4UhGP7EH2N_eK-u2lz0Ld-qNQ0YLuKgGu7w5A0hzHP6gau
    7AhpUhImGhQepG3Ww>
X-ME-Received: <xmr:Bb0HYX6Xs9NoOgmU-jTjFPzjOWaBMqu_fNSR5_kQcHzEVm83EwpwzIgaQZ6w7I3Wz1iWziJjfhrZhw1Z3qdXZ-YwiPCAaPFATfZHoBa1V_Hl8Qm7Wl-4eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddriedvgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:Bb0HYc0gnq6g3t3RFbiJHhgfI3EsihSAm58QLKInaTM3StdUrgw_Lg>
    <xmx:Bb0HYaHpC6piwzIqPlO36d_nrVKZumyHqmGP9KuTbFfUionaRHEFjA>
    <xmx:Bb0HYd-7S5qJNU1s5Hn2v0zByz2wLeoaDhyjIaHZA3FdR51ycPSKmA>
    <xmx:Bb0HYf5zZnAIrHywiVeCQgrVVzNzkD5Bq2nSGlewd4m40Q9sGUrIMw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 05:38:12 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d2bad18a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 2 Aug 2021 09:38:12 +0000 (UTC)
Date:   Mon, 2 Aug 2021 11:38:10 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 3/4] revision: avoid loading object headers multiple times
Message-ID: <b9897e102afbcab3bfee58ed8bda24257d8b54fb.1627896460.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="51pAdVTzwGSsFnxq"
Content-Disposition: inline
In-Reply-To: <cover.1627896460.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--51pAdVTzwGSsFnxq
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index f06a5d63a3..671b6d6513 100644
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


--51pAdVTzwGSsFnxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEHvQIACgkQVbJhu7ck
PpTS+Q//X86VKO3yUB9MrhlEXjeWfJ2VTsUDNfaMbHEatbBjYGg1NsWFJtfMucOH
GVNaB6sfWytNubCKem31nUsrGQ7zccOEUUb0QqeAaMV6+xmGtAAf+Ee7p62ayWc7
0ePHK7lAxk9d6ClxkvYH1zo+ohc7BUQVvWrAtEwunpP1cohUZJTv5xGWqdg4hdAX
DoYAWG7Aj4F6+iNCss7ipm82HHCGI/v9bu4efSjwWPxW4pgYV4ZMKyUq9FNkNw4Y
wIb4ju+cHSlzDmJv+SWJrR+S2nsRCCYAydBgk/SuT3N6+KynhfRdG8fQo6u+Spxg
AuVxxJIeBIsehAoPsNdeoh3fnv+kXfe+9TvWL7Z2OyITdrIMraXuhKM5XP5qzeqN
gEHZuKHr0xqBgW/Z+RbE+8CLw3HcVWuur6N9rFlTGfV+jEahv2V3Hcgh0QPqhURe
LJZL+/1spnw9dDqL0KQsx2LTaV5NbhlKn7xg3KVa6FYPA3ATSxqaDOZja6PeW4Uy
dp0ROMZ0PcSpjFC2a+QFVyy7PbrgSWwNkS/DY1lRiEw3bqsPVmyZCgOsGBC6B8kF
z0OD+MytAGugueVOa41aFJo0YIrWmiIB0x8XOoUYQTsJILVil3ScBErR4nFlxcwl
5A07/Tbev2eCRzcHvdSDUOr/OLZCj9NC/xUXG8tBjV0qpEHhl1w=
=eTZO
-----END PGP SIGNATURE-----

--51pAdVTzwGSsFnxq--
