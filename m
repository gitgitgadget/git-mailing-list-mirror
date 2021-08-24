Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAF7C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D8B61008
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 10:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhHXKhx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:37:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55497 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236261AbhHXKhu (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Aug 2021 06:37:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F39065C0121;
        Tue, 24 Aug 2021 06:37:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 24 Aug 2021 06:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=VfWBHeI3sZurx+ImAqL6erq3gkM
        r4MWLfUx7+IjLUPY=; b=PMJeRYFx5Z78vn3LwVF39sgrynHmuLSDe+GeEr+3KT2
        CUYNAcQVs3I9cybQFYjmM4+657JDgjAWjZVHUU9r+kegbB1A1uWTVxMHGBnq1S4s
        Dy55DX8Br1WrPqJqFg87EZhLX8F2kNW/hZ1TlzbY9C5Vx8d+8XCM1RC0BnWMRalL
        pGnMawCelqsncZO3JIx761O+Vuz/8b/kskXD2y75UVsYXPnLdCW/EH42V7cJCBNn
        uJNcwYjgC9iaaFnDlTz3S+gmsy2PKCIKN9M01wZej/xUHSS/uHzqQrbTMkCUyvJ8
        8yhxtJnh8+ndY3KAI2lkmH4s0B/KyYg66qsJnM2yfOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VfWBHe
        I3sZurx+ImAqL6erq3gkMr4MWLfUx7+IjLUPY=; b=S6KVIun9c0pp1BxvBcb2Od
        2LHfOnMustrO+RZwxovV4K6evEA06fVC4u8+0/J3XisID5jcJaMxfigz3dlJ4zIn
        s0VEzKWjGM/hTAZ3uZlj6gm4PJZRS9ennEoeGLc3TthrYqbQXQxpWmY8CfIwTdIe
        RUXGOeJeGJVsZJI7uvLKfYu2pLqyq6Wl6UvXVbkc9lD0CpQBVevX4oS6Q/LTj+/T
        ap9vsFCVS6QVTrMuseRkyfNdx3hUCWXGE1RKsHKfEdIONUg3RbAyRv9baYZ4XpGI
        VLfddlw6a/mNB0YA3zF1sEi2PCoqniB2ftiYIS86hBri55xZ1Klzc7EDM+c1dHAw
        ==
X-ME-Sender: <xms:0cskYSlsYLEUNc62aXsKyuwGQEh76v0V0mTWOawX3swmqwRoIN6KjA>
    <xme:0cskYZ3__LLN16yGIvK3MYsnXGupD0kitAGX3vsLos1A5TUvJzWHG6-4j7k7rjGLN
    GovAQev2GIq0G0wyA>
X-ME-Received: <xmr:0cskYQo8fEVoPInkjrysjEhEua_Yes2SgK1ul-Xjt5ZWJ_Fs56PbegMw-ofrrzev2CYpuU3gc5_2HWWzaVqqJyCIpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:0cskYWn48X0IqxTa-c4wko38YkH-aE9APzvRRIVyfWcm7BfBC-frJQ>
    <xmx:0cskYQ3fRFDref56bW-dWv4On8jv1HPr-SNVU2B4akVFAev2BD4-EQ>
    <xmx:0cskYdtCm3TV4UC55kksjuA-r7RrhWtRjcy2c2ZjjzRWuv9HUvIFfA>
    <xmx:0cskYTQNwmdueqmYmnD_tbQnjJUbI-Csgn2TkQbsIu6CZoAeaEHXUg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Aug 2021 06:37:04 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id af769317 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Aug 2021 10:37:01 +0000 (UTC)
Date:   Tue, 24 Aug 2021 12:37:00 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 2/7] fetch: avoid unpacking headers in object existence
 check
Message-ID: <81ebadabe8e861269336f6446f87acac88371042.1629800774.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UUk1l9UmfmCy6szs"
Content-Disposition: inline
In-Reply-To: <cover.1629800774.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UUk1l9UmfmCy6szs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When updating local refs after the fetch has transferred all objects, we
do an object existence test as a safety guard to avoid updating a ref to
an object which we don't have. We do so via `oid_object_info()`: if it
returns an error, then we know the object does not exist.

One side effect of `oid_object_info()` is that it parses the object's
type, and to do so it must unpack the object header. This is completely
pointless: we don't care for the type, but only want to assert that the
object exists.

Refactor the code to use `repo_has_object_file()`, which both makes the
code's intent clearer and is also faster because it does not unpack
object headers. In a real-world repo with 2.3M refs, this results in a
small speedup when doing a mirror-fetch:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     33.686 s =C2=B1  0.176 s    [User: 30.=
119 s, System: 5.262 s]
      Range (min =E2=80=A6 max):   33.512 s =E2=80=A6 33.944 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     31.247 s =C2=B1  0.195 s    [User: 28.=
135 s, System: 5.066 s]
      Range (min =E2=80=A6 max):   30.948 s =E2=80=A6 31.472 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.08 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 91d1301613..01513e6aea 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -846,13 +846,11 @@ static int update_local_ref(struct ref *ref,
 			    int summary_width)
 {
 	struct commit *current =3D NULL, *updated;
-	enum object_type type;
 	struct branch *current_branch =3D branch_get(NULL);
 	const char *pretty_ref =3D prettify_refname(ref->name);
 	int fast_forward =3D 0;
=20
-	type =3D oid_object_info(the_repository, &ref->new_oid, NULL);
-	if (type < 0)
+	if (!repo_has_object_file(the_repository, &ref->new_oid))
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
--=20
2.33.0


--UUk1l9UmfmCy6szs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEky8sACgkQVbJhu7ck
PpRirw/6Aun1cLdhsmRRX78doKMO8Iou/r9O+PBaS+9R5BT4PFDENBEBuxW6Ae0g
7A12cNdWiin2FZVay5QUJs/l4lJqe7/sPMO3zEUMzBkweV8B7oyEA1LZijJ21ZNP
fy2NwizwDUJDFhLfm+gOmJKecF/PgZ90Faga9Yk+Ynrrd81ZYuL9tRvyrJK101rP
pU2RrCW6vNQqBAIBqTt7kVsWsu4HfmJnkvqXcslIr5U6Ejk5yfr4wvj5blchotph
GMjfVc1QlV7z4LQwJrBmZsVhjHFnCP9E3/Q/UPAN6rcybTw+oUUs5CPkMsrb5D8q
tEGKvujSNraxboJSVCm2o113+IAccKW9bACdPEMeKVjuQc9jVgeTxdRNevwjNZzi
raCWkEvSWpdcFOCQFvPzm0ytKq3RVbKu7VpWu9QfUO3PdHMgQiHzuR84Cm/yvui7
tZvhOP0CczK5pLhmNZyztHiRF9CYiVSnCjjY4rsa+h936OurcV8w8/HUJze7mweP
QevqJv7j0M9gwFMed1U3mwXR7WevFEkULd4knJ7eT3iH3Ad/z66GlxjCUCa4tIE9
Efw/9JCKBLW8p8bSbKn4Z6oAV6xRr3fQwZLdzaxIJBVQEHaX75VsAlXtEJS/8WNI
UamDEDzHqYTWOwwYIbZizod+dSwGJNSEMNLuhqYACIWj7BqVBIc=
=dzZO
-----END PGP SIGNATURE-----

--UUk1l9UmfmCy6szs--
