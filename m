Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF88C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 07:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbjDEHIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 03:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbjDEHI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 03:08:29 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED526B8
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 00:08:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0FFC03200933;
        Wed,  5 Apr 2023 03:08:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 03:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680678504; x=1680764904; bh=xy
        QljjIqyR0ZQ8y1nDPGLtIKYpgQQCB6i6KBLI8XVnA=; b=ni5lOyUCjE0rnVcj4n
        IFvjs4vwfC9KNGyVPBfXs0xlzRnozijo1sw9OFuiFmRnndzTsMccBAgaN1ps8gTh
        IkmnkbJJcu4My7zb/PdS1+EZFcXDZwC+zKaCnn5liwTS6djvWKWSlYZOG9XO5xCr
        StDI5XKXOSRehmdnnnEDvLsB5bI5+8qIpyLQTLnYsML4w/ta5hTQWe4nWjKwQLjM
        EkJX0C1DoSIfjXs4YlCzPwiW05+MPhFsoQt++tb9/yLAJlj6gMi1YzqlauYj67dh
        JGvjYKbAGMKsRRQby6st3nt36c9iwoUCQg78neoWs+tTmW7QtPvLd3qM2lRNM24M
        z/aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680678504; x=1680764904; bh=xyQljjIqyR0ZQ
        8y1nDPGLtIKYpgQQCB6i6KBLI8XVnA=; b=dZyLYArk4iAumVj2UukOKeaee8xZQ
        6fmEaBE99GWatNAFcb+sxhf5XXXX/BZnZlbKprYI7I0SuHzbqb6JPZRRm1cmK9Ue
        4aJB/UPb/fsiSTATrE1yK8qesoYBPteVFBdWYmCQYczao4ZcC3sjtu/ER0z1v3q8
        xtY51Q6K1M3//OdHPmAwrnutV2vpNKhfgzJMUXcnFkoAJJGfoAvUUlT1s8qj0iQv
        wJCWuXfRJoWPSd8wGwJEkk/L4lF2JDXqB1OxT6yhGVYtc0dYQBSyhUb+25eqfjVd
        vWa66OhURm3TAwjj/QuUg9oxMra/XSvvfthGknE/g7fcqAuoxggH/3Cyw==
X-ME-Sender: <xms:aB4tZNBJknyaDRLbQG6dkssOnVkZcgj2ZFlsbLOa_Ul52rRkAvdYJA>
    <xme:aB4tZLhpUCyBhKS7Z5ih_zCNfrUTgN586nITcPpo8vdpYWBVhi41WJIFjJH-sL_HU
    oUhyuUHmdGca6SHnw>
X-ME-Received: <xmr:aB4tZImrOBo8LUCX_NEwLW0s6OAhX1le_aPAhZlB2fc2GB3b3yPCbhWVMjTPMtQGRu_N-OmKl5kOsbo9Fj8K15wMoJ--kiGrOTWHR1tmM9z7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejtddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:aB4tZHyLbUmqGJ-4QWqhY00gxvfSv5cmS56bGGlSUwGmrrPEZXhcdA>
    <xmx:aB4tZCSQiQkAA0Yqf7_Qlq_oB7ZH907pmc6OVJhOurDeKVjU1NMTMA>
    <xmx:aB4tZKZTKUHdSURzEi5JDMAVjH3_FVf_6rxUWoND2lmynNuUhO5mLg>
    <xmx:aB4tZNf9QJmeYIIIZFxi-98fYdzvc7tCmaGDZl3dC0TuibM_GhUgpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 03:08:23 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 163085b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Apr 2023 07:08:14 +0000 (UTC)
Date:   Wed, 5 Apr 2023 09:08:19 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZC0eY8q6ushpfkrQ@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s3dsQziF6hCM3Sih"
Content-Disposition: inline
In-Reply-To: <ZCxytq1esQWvjIz/@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s3dsQziF6hCM3Sih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2023 at 02:55:50PM -0400, Taylor Blau wrote:
> On Tue, Apr 04, 2023 at 01:08:33PM +0200, Patrick Steinhardt wrote:
> > Both issues have the same underlying root cause, which is that geometric
> > repacks don't honor whether packfiles are local or not. As a result,
> > they will try to include packs part of the alternate object directory
> > and then at a later point fail to locate them as they do not exist in
> > the object directory of the repository we're about to repack.
>=20
> Interesting. This fix does make sense, but I wonder if it is doing the
> right thing.
>=20
> When we have an alternated repository and do 'git repack -ad' in the
> "member" repository, we'll end up creating a new pack containing all
> objects in that repository, including ones from the alternate.
>=20
> For example, if you do something like:
>=20
>     rm -fr shared member
>=20
>     git init shared
>     git -C shared commit --allow-empty -m "base" && git -C shared repack =
-d
>=20
>     git clone --shared shared member
>     git -C member repack -ad
>=20
>     for dir in shared member
>     do
>       echo "=3D=3D> $dir"
>       find $dir/.git/objects -type f
>     done
>=20
> Then you'll end up with the output:
>=20
>     =3D=3D> shared
>     shared/.git/objects/pack/pack-a2f0c663b287c3eeb0207397f8cafb9ae49f827=
7.idx
>     shared/.git/objects/pack/pack-a2f0c663b287c3eeb0207397f8cafb9ae49f827=
7.pack
>     shared/.git/objects/info/packs
>     =3D=3D> member
>     member/.git/objects/pack/pack-a2f0c663b287c3eeb0207397f8cafb9ae49f827=
7.idx
>     member/.git/objects/pack/pack-a2f0c663b287c3eeb0207397f8cafb9ae49f827=
7.pack
>     member/.git/objects/info/alternates
>     member/.git/objects/info/packs
>=20
> In other words, we end up creating the pack necessary in the member
> repository necessary to complete the repack. Since we're using `-a`
> here, that means creating an identical pack as we have in the shared
> repository.
>=20
> If we instead did something like:
>=20
>     git -C member repack -adl # <- `-l` is new here
>=20
> , our output changes to instead contain the following (empty) pack
> directory in the member repository:
>=20
>     =3D=3D> member
>     member/.git/objects/info/alternates
>     member/.git/objects/info/packs

Yup, that's fair.

> > Skip over packfiles that aren't local. This will cause geometric repacks
> > to never include packfiles of its alternates.
>=20
> ...So I wonder if this is the right thing to do in all cases. IOW,
> should we be creating packs in the "member" repository which may be
> based off of packs from the shared repository when `-l` is not
> specified?
>=20
> I think this gets tricky. For one, the geometric repack code creates at
> most one new pack. So if some of the packs that were above the split
> line (IOW, the ones that don't need to be squashed together) were in the
> shared repository, I'm not sure how you'd write a MIDX that covers both
> without using the MIDX-over-alternates feature. I have no idea how that
> works with MIDX bitmaps (IIUC, the MIDX/alternates feature is very
> niche).

I agree, things would become tricky in case geometric repacks are
expected to work across alternates.

> I think we reasonably could do something like ignoring non-local packs
> in `init_pack_geometry()` only when `-l` is given. That still runs into
> problems when trying to write a MIDX or MIDX bitmaps, so we should
> likely declare the combination "-l --write-midx --write-bitmap-index" as
> unsupported. For backwards compatibility, I think it would make sense to
> have "--no-local" be the default when `--geometric` is given (which is
> already the case, since po_args is zero-initialized).

Okay, I agree that it's not all that sensible to allow writing bitmaps
in a geometric repack that spans across multiple repositories. These
bitmaps would immediately break once the shared repository performs a
repack that removes a subset of packfiles that the bitmap depends on,
which would make it non-obvious for how to even do repacks in such a
shared repository at all.

But I'm not yet sure whether I understand why `-l --write-midx` should
be prohibited like you summarized in the follow-up mail:

On Tue, Apr 04, 2023 at 02:55:50PM -0400, Taylor Blau wrote:
> TL;DR: I think that this is a (much) more complicated problem than
> originally anticipated, but the easiest thing to do is to assume that
> git repack --geometric=3D<d> means git repack --geometric=3D<d> --no-local
> unless otherwise specified, and declare --geometric=3D<d> --local
> unsupported when used in conjunction with --write-midx or
> --write-bitmap-index.

The newly written MIDX would of course only span over the local
packfiles, but is that even a problem? Ideally, Git would know to handle
multiple MIDX files, and in that case it would make sense both for the
shared and for the member repository to have one.

> I suspect in practice that nobody cares about what happens when you run
> "git repack --geometric=3D<d> --local", but in case they do, I think the
> above is probably the most reasonable behavior that I can quickly come
> up with.

Well, I do as we use alternates to implement fork networks at GitLab and
we're in the process of adopting geometric repacking. So what I want to
have is that I can perform geometric repacks both in the shared and in
the member repository that includes only the local packfiles.

And yes, I agree that the above is the most reasonable behaviour, with
the exception of disallowing MIDXs when doing a local geometric repack.
But that raises the question: what do we do about the currently-broken
behaviour when executing `git repack --geometric=3D<d> --no-local` in a
alternated repository?

I'd personally be fine to start honoring the `po_args.local` flag so
that we skip over any non-local packfiles there while ignoring the
larger problem of non-local geometric repacks breaking in certain
scenarios. It would at least improve the status quo as users now have a
way out in case they ever happen to hit that error. And it allows us to
use geometric repacks in alternated repositories. But are we okay with
punting on the larger issue for the time being?

Thanks for your feedback and this interesting discussion!

Patrick

--s3dsQziF6hCM3Sih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQtHmIACgkQVbJhu7ck
PpRjNw/8CQ/JmGeAg+e8vvJWE7YeuSai2VZGkscIDnfZEBDlZ1jJHm4UrtSSvf0j
rHh4+Wp3RnCYSiOhjD+VDbaZ/a4Lq8BthpS3zKnzjGLQWQG+O2M/Mruzjkd80YaW
A+tbxCAk49k079rQr/vIHI+boRRaCDea6uFY064hGExerU9Q7oeEIJQ1YuwlsLdm
kWaZceh5ubcM24WVfbmMw56mbXgu0bpAmzmX3sK92i9Ry78Mh9hNqL1PfB7u+a8P
VejnnEwgxxo8iVDnyrj8YhOD/uo34RRyHVyysifb3hjVuSs0b5wZqLwuY8UZaeE4
eANAkhpWQUZUfWeQly70npIghstp0msgX3oyeyYhlSpKPhLQihxDAPuWYcNj2Nsg
RRD5Sl6nGqSY3FwVoS8GE/tvNHe3B215WD2hQhpAQAxxy0bVyTISdQNchSFbintb
l/79c/G9F5+7tjVTwivc6aNEDlVWVkYq6vGKjzaVLyD//jWUNS4cnJVvOJTMsNUH
fbka6wT11NJOY6/5HgauRSGDNUgaTog/ogV2EVOeE72JCXfWXKvvpl0hVnmNiT9M
0PCqJ9E1Z/hoj1R5hBV1Jb5yLQQ2DA0ZPz2Ez1RhTJ2g8OfG+Ytyc+NIcbvTzE1h
T+NL6VI7qmXxXamYT2EFJX0ffuoSSsfqKS3NkNWgSadQ9qi/MNY=
=VaCW
-----END PGP SIGNATURE-----

--s3dsQziF6hCM3Sih--
