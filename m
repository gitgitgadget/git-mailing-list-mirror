Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B0AC433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF41E60FE3
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhEQGEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 02:04:49 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46047 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbhEQGEr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 May 2021 02:04:47 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 703B35C003B;
        Mon, 17 May 2021 02:03:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 May 2021 02:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ieXsDcaObQnyuMFSL1wKLLtCQ+y
        SKOTUUXRF6BLNb8A=; b=tn4xV403bYLgEmqjDhwDZYNIjFlP2mlZq0Y2W0CIta+
        HuTNt1Aux2sxMq9dO80YG2DjEbVIkQvTIQ4XqROYa+1mzgoXNzxCSRqo6kMdz3v4
        e8KpDXL1u/obLC36/c6Emdx1Sf7I8BT31EDHmaiGCe0WrT7Cz4SaKx9FWLrdFusa
        5XIrjUksRdwYmZX3WllcRC8FVoDnYyHYctHgBrZNJnifanFcmM9ThCabWYn+C25D
        QLFMZKwW1oCOEs5LD/dhPDZcMZYYzfPfhSczpbMi67ICaImEB2YoqVxV7V+CGVrt
        BZJpSfXEOIhLz33yxMR0vERLf4mJmcMv0+GTZ7v1JOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ieXsDc
        aObQnyuMFSL1wKLLtCQ+ySKOTUUXRF6BLNb8A=; b=OaB5HdV7DfpBUNGWxxo0I4
        c2chmEcDchJgysVhc+NF1KEJVDlOI+Idc64XGFh3GHp0cbPn8MuLrMexlxybZuY5
        rGYfdJqR2lRZiPDrzFjjVBr/eU+DDYsrD4ucDe1zCDmIT9hgLE4PLSXAeqKximEk
        mJD/LHvAC648fuztmBOdT+NKtkr0HxXuAxrZfewYoIm2jrRzzlGuXW7jd0UvnON/
        AV0R8DHfZjMNSbUkHG8jOLy9pN3NkH9Grr4fX0CKzxRLD9cP8cAK01pHHIrEsrZF
        WL1vgV4vob1/YzoljNCtfU31GiN6D0EqAk8nsOaaMj/Ti8/Je4P2Dht+BRLXec6w
        ==
X-ME-Sender: <xms:MgeiYNQGlQJosrpZIxfJadbDYg8Ff0XQwA-aYORdTCmVS7YTTiyZlA>
    <xme:MgeiYGx8_GjVvVqxwztpQw3cfxHbJu4DZYeT_lG539gUOFoY_DjtUUUKPJQScg9D9
    pBnQTxmofZsRelQuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeigedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrdduledurdduhedvrddvgeef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:MgeiYC1aOt6tfxpyFaZUUVmttvfx-doko6kaamowBRUzzGhXduLg6A>
    <xmx:MgeiYFA_PHgHCgYuGfiiW-hF4EiSuoB8bRxytAEg1BcfMURCL_XcAQ>
    <xmx:MgeiYGiZjExj0cFk5gl4Zi17NnZT_bL19yxHWY83od9QLhPEodZ4aA>
    <xmx:MweiYOdBSlwdBL_PFAEWdAXdsV8Jn7M-q1mwj-iO3wK2J2BSHa6e6A>
Received: from vm-mail.pks.im (x4dbf98f3.dyn.telefonica.de [77.191.152.243])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 17 May 2021 02:03:29 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 56e21748 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 May 2021 06:03:23 +0000 (UTC)
Date:   Mon, 17 May 2021 08:03:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
Message-ID: <YKIHKjs7n3v4vwNt@ncase>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
 <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
 <YJ0FL3zr/SnWN7t6@coredump.intra.peff.net>
 <YJ4mUJ+EEAnudI3G@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHNzPJKxR3nJaOvU"
Content-Disposition: inline
In-Reply-To: <YJ4mUJ+EEAnudI3G@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hHNzPJKxR3nJaOvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2021 at 03:27:12AM -0400, Jeff King wrote:
> [+cc Jonathan Tan for partial clone wisdom]
>=20
> On Thu, May 13, 2021 at 06:53:36AM -0400, Jeff King wrote:
>=20
> > > So I think it will require some digging. My _guess_ is that it has to=
 do
> > > with the "never filter out an object that was explicitly requested" r=
ule
> > > not being consistently followed. But we'll see.
> >=20
> > OK, I think I've unraveled the mysteries.
>=20
> Nope. This part is wrong:
>=20
> > It is indeed a problem with the "never filter out an object that was
> > explicitly requested" rule. But really, that rule is stronger: it is
> > "always include an explicitly requested object". I.e., it must override
> > even the usual "you said commit X was uninteresting, so we did not
> > include objects reachable from X" logic.
>=20
> The rule really is the softer "don't filter out explicitly-requested
> objects". It's just that the non-bitmap traversal code is way less
> careful about finding uninteresting objects.
>=20
> Here's the same scenario failing without using bitmaps at all:
>=20
>   # same as before; repo with one commit
>   git init repo
>   cd repo
>  =20
>   echo content >file
>   git add file
>   git commit -m base
>=20
>   # and now we make a partial clone omitting the blob
>   git config uploadpack.allowfilter true
>   git clone --no-local --bare --filter=3Dblob:none . clone
>=20
>   # but here's the twist. Now we make a second commit...
>   echo more >file
>   git commit -am more
>=20
>   # ...and then we fetch both the object we need _and_ that second
>   # commit. That causes pack-objects to traverse from base..more.
>   # The boundary is at "base", so we mark its tree and blob as
>   # UNINTERESTING, and thus we _don't_ send them.
>   cd clone
>   git fetch origin $(git rev-parse HEAD:file) HEAD
>=20
> So I guess the first question is: is this supposed to work? Without
> bitmaps, it often will. Because we walk commits first, and then only
> mark trees uninteresting at the boundary; so if there were more commits
> here, and we were asking to get a blob from one of the middle ones, it
> would probably work. But fundamentally the client is lying to the server
> here (as all partial clones must); it is saying "I have that first
> commit", but of course we don't have all of the reachable objects.

I'm not really in a position to jugde about partial clones given that I
got next to no experience with them, so I'm going to skip commenting on
this part.

> If this is supposed to work, I think we need to teach the traversal code
> to "add back" all of the objects that were explicitly given when a
> filter is in use (either explicitly, or perhaps just clearing or
> avoiding the UNINTERESTING flag on user-given objects in the first
> place). And my earlier patch does that for the bitmap side, but not the
> regular traversal.

I think adding these objects back in after computations is the easiest
thing we can do here. For bitmaps, it should be relatively easy to do.
The only thing I wonder about in your patch is whether we should really
do this in a specific filter, or if we can't just do it at the end after
all filters have been computed.

For the traversal-based code, it feels like the current design with the
`NOT_USER_GIVEN` flag is making this harder than necessary. I really
wonder whether we should again refactor the code to use a positive
`USER_GIVEN` flag again: it's much more explicit, there's only one site
where we need to add it and ultimately it's a lot easier to reason
about. Furthermore, we can easily avoid marking such an object as
`UNINTERESTING` if we see that it was explicitly added to the set while
still marking its referenced objects as `UNINTERESTING` if need be.

Patrick

> Alternatively, part of that fundamental "partial clones are lying about
> their reachability" property is that we assume they can fetch the
> objects they need on-demand. And indeed, the on-demand fetch we'd do
> will use the noop negotiation algorithm, and will succeed. So should we,
> after receiving an empty pack from the other side (because we claimed to
> have objects reachable from the commit), then do a follow-up on-demand
> fetch? If so, then why isn't that kicking in (I can guess there might be
> some limits to on-demand fetching during a fetch itself, in order to
> avoid infinite recursion)?
>=20
> -Peff

--hHNzPJKxR3nJaOvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmCiBykACgkQVbJhu7ck
PpTDfw/9FDRO8APNofITTaU82eDZdYb/Ih0z3yc+2f49xDXcgDULMoZG+eM+rrGt
OLglikI3bCwsb10k1oE6VAEDU6GM7aYMVn32yk3ozOv1/dk3znrB58S40NQypwKJ
2V09P7RX5kodPCeTg/ZDcZTvTq8bMXl9G08egqPpwi1Jg9SYuR9E4ajSPMGInXaz
jnn7UsB6KalhBnQFN9rXTXKpJKDAZF8xvC+2zF/EoDEVgZ7iCwU84/gTGNCsTAh9
ewQI5cjxos6FhJBj6oBKNJ77DPBSai5+70MtMCyv7MG74JNq3lVtBPHIZbf1uaXU
I1/XYYpT6UxnVPV/WXqP43g1rv5lmXyYUmmL5bwA2bCz6lVth441BYxMp7z6TwrC
mDYONOJkcOF4qRsYJu63mlnBSeQOhZX3BHYGnq9ETeuF2PXrL6RLGyykcwEnj4Q9
Wkwvmvn0y/BxJmrZfZ13A/3gPNsncRDPAad0+F+uurrMjJkqykUpGJC3MMhWRpSQ
gTTr+U50fwFG0PzOJLqN9eson4gsNRHBK4Rvil2ggbtYhdEGwnXc1zVvFvxIKGbP
BE2A0GH1e7nISgax2qxSWd1tLUnkyOZocU5GpS940d4dWcedf6X/rqdwFCSCIKDC
REfgWW/dkTuIQdfHvfj8IAAqL2OLWDtNYgiefhs94ElfhiLe30A=
=i8MU
-----END PGP SIGNATURE-----

--hHNzPJKxR3nJaOvU--
