Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AFEC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 14:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042C961165
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 14:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbhHFORd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 10:17:33 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60203 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237023AbhHFORc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Aug 2021 10:17:32 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 77E075C00B5;
        Fri,  6 Aug 2021 10:17:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 06 Aug 2021 10:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ZdEYW1MZ4egXy+cEL2/4PvquSz2
        LR7A/MAYBE46JyCM=; b=UFjsNTAvVi0kMHbBMMRkpO7wJHnjp0SleOLrFzYoa4e
        BZw9beDGNRB0QyXul8RW9tgrnHQH3ZNcwawvcCTzygOGIOULAfnkV6K8fDU97ZZU
        mLzGAs7P9+ZnmP+j4UV+XTeQhGYnvs2H1ZLmjtFxKT/S3fsdne8d+nWfNrAzyENA
        OZmvzmvPKeuCD+x35FKzazdpqjVTmFqww69niEQXFWvK0ESxWjlgxC4eB2nHj9Ql
        0x3lFNvIWJ+phmwQppRJ/Rdyj5G1Xi/PLabdTalcICGIxrQr1fKvE21sXGa2W5nP
        nDOtaMYQlB5ICKOkq1qF/MMkyNPpkpcsESaD1V/V3dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZdEYW1
        MZ4egXy+cEL2/4PvquSz2LR7A/MAYBE46JyCM=; b=f32ID6KlAImzdLV8BWN1o+
        WrHHYG8GZHOGMnfqzbToF4xFNzoF4FsBS2wF5TW77fZibbZUdxmyYvrqS5kulKQo
        fTIBYjChm0Nzz3SPvtuC42VZXjph2Qnj+b7LHYLU/9NjnzSVk6Jlr2nTpxTM5qUL
        C0yuG5svSUeEyCrA1h6JtoQV5Xv9/PMb0nRz6dRdN2fPVch0Bkvfl9VRqeRPBpwn
        UM2A9I/F9gVzS4ucAVcYRknnqfswL/Hs6AufSKJLZPOFzVUfN5e0wlLXgPQFdcPj
        MqE+m4WCffbYgSd0vt0sNztzUc821m3HPxsXzH2GWSQI7WtIrK24b6Yp8fU+vxxg
        ==
X-ME-Sender: <xms:aUQNYYnZ_26vXlHpr23nhxNul_rOLmXjUDqn-Ht3gqbEE-xYXFtAzA>
    <xme:aUQNYX3RosDIXdkBdiTvX1v2pUgBmPEuuVj6M0cOnq3gmUkZbjnZS-0bzXfgGXRTM
    uEbQDi-lebdAG8jNg>
X-ME-Received: <xmr:aUQNYWrYJcrsW1WGXkB53bWL0AxK36zj2sndhJhKChfiA3FpjhpWdGBoPQ8a-_CaE4Pg9LMQT1NzRlZBNF7WX56WeWq4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:aUQNYUnNJ8WCGYL9kiq9McsHUE9UT9EsCPZ3UTfoBhoT17RqisHi0w>
    <xmx:aUQNYW3C8X13QHWV5ijBLm3fOZda5p6jJICwAMhvIaUg-mXT_h0vgA>
    <xmx:aUQNYbtSABiIDewOdqya9C6VFtQhYj-vSP4Hhj4KMjlAugK-Z8c8uA>
    <xmx:akQNYQqzKsz_R7snVgZfuufnbmQB8X9oSM3ZoYc_Z48cUGOT1ALYkQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 10:17:12 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id cdde45b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 6 Aug 2021 14:17:09 +0000 (UTC)
Date:   Fri, 6 Aug 2021 16:17:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/4] revision: avoid loading object headers multiple
 times
Message-ID: <YQ1EZAylyI4pAC0E@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <b9897e102afbcab3bfee58ed8bda24257d8b54fb.1627896460.git.ps@pks.im>
 <xmqq5ywnws6v.fsf@gitster.g>
 <YQkHUZKZ6gkFkaD0@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vjlsUgbgWYpbwR/Q"
Content-Disposition: inline
In-Reply-To: <YQkHUZKZ6gkFkaD0@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vjlsUgbgWYpbwR/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 03, 2021 at 11:07:29AM +0200, Patrick Steinhardt wrote:
> On Mon, Aug 02, 2021 at 12:40:56PM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > When loading references, we try to optimize loading of commits by usi=
ng
> > > the commit graph. To do so, we first need to determine whether the
> > > object actually is a commit or not, which is why we always execute
> > > `oid_object_info()` first. Like this, we'll unpack the object header =
of
> > > each object first.
> > >
> > > This pattern can be quite inefficient in case many references point to
> > > the same commit: if the object didn't end up in the cached objects, t=
hen
> > > we'll repeatedly unpack the same object header, even if we've already
> > > seen the object before.
> > > ...
> > > Assuming that in almost all repositories, most references will point =
to
> > > either a tag or a commit, we'd have a modest increase in memory
> > > consumption of about 12.5% here.
> >=20
> > I wonder if we can also say almost all repositories, the majority of
> > refs point at the same object.  If that holds, this would certainly
> > be a win, but otherwise, it is not so clear.
>=20
> I doubt that's the case in general. I rather assume that it's typically
> going to be a smallish subset that points to the same commit, but for
> these cases we at least avoid doing the lookup multiple times. As I
> said, it's definitely a tradeoff between memory and performance: in the
> worst case (all references point to different blobs) we allocate 33%
> more memory without having any speedups. A more realistic scenario would
> probably be something like a trunk-based development repo, where there's
> a single branch only and the rest is tags. There we'd allocate 11% more
> memory without any speedups. In general, it's going to be various shades
> of gray, where we allocate something from 0% to 11% more memory while
> getting some modest speedups in some cases.
>=20
> So if we only inspect this commit as a standalone it's definitely
> debatable whether we'd want to take it or not. But one important thing
> is that it's a prerequisite for patch 4/4: in order to not parse commits
> in case they're part of the commit-graph, we need to first obtain an
> object such that we can fill it in via the graph. So we have to call
> `lookup_unknown_object()` anyway. Might be sensible to document this as
> part of the commit message.

Scratch that: we can just rewrite this to use `lookup_object()` to check
whether we already know the object, and then we can rewrite the
`parse_commit_in_graph_gently()` to be `lookup_commit_in_graph()`, which
does a `lookup_commit()` to create the object in case the OID was found
in the graph. That's also got nicer calling semantics..

It's negligibly slower (3.021s instead of 2.983s), but it doesn't need
me arguing about the performance/memory tradeoff. Which is a good thing
I guess: there will always be that one repo that's completely different
and where such assumptions don't hold.

Patrick

--vjlsUgbgWYpbwR/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmENRGMACgkQVbJhu7ck
PpTBZw/+Oe2P4Ta8tSNpmHjEf0v8kb1zS9gLxmORZBOfZF+hMU75NKpkr+AkQJ3/
kEqtW47+6I1SCCZv3DyZf3lukn9EXHrzDhTILUQ+lUhiZy2BDkk2/rSIrJQGx0+L
tYJyOauG2Whgy1Y/zapjG2gryR4baPKwTsPRBxHOpfYhZe35KECtTF0E4Gcrt3v6
S2PVxpsEpwVIXm1rEgeM9zSZV4mJwSGFz+sKWKDrQR4lEqwe7VdowSG3bWWTuLNh
ZgbXqUe9hoFqGAnQcx07eF2n3uDI7Ys2xSt/PoAGWASKmXQ7AJDTRs6SPiodbPPT
2gXf6fXdUxcMd2JWxWfuUBkyPNTuKNPZyMGjEXDYLx7EP551yO+n3zcIZzls07Ie
u1aqR2it1Wg2ChEF8UyxRskEn3FYjVUh8sMemi7mAkDTKgLhCN0f3WKT34j2Rkgg
2BjXf95gMNetSmxn3WvfMMy5o//FUFZcvdC1ZvP4W8Rvdghy5I4d6K9Qx5FGFfhm
x1hbScySBW4acW4AFyQsfmpDLjaH4QjGfNM4jqPIHSdJn3cpeaUm7f8/RHzqgNNX
FE0btQJY2QCFmvX2XTuEIN9L5YiVoQoKA2kLOPffPSb/Z4vgvrnn87pHsDNOlZMA
9NBDy+mujalO7QZpXIvLk7XE6404bS5mpcnlt8sSmRBJqkQoCJ0=
=9u4k
-----END PGP SIGNATURE-----

--vjlsUgbgWYpbwR/Q--
