Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955BAC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 05:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D59206DB
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 05:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kORva9do";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="suenyPBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFPFo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:44:29 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46873 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgFPFo2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Jun 2020 01:44:28 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 79721699;
        Tue, 16 Jun 2020 01:44:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 16 Jun 2020 01:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=qDbpkkEocLbqAWxHGB66FYtst2+
        s5VmGo1txVOkmKbg=; b=kORva9dofHtPvTLPj/iAM6+H2lq8k5Zpv3ZAsC4WYCz
        IVaN69fOpMBW+6RXsTtfGK6FvZ6IFJeWCxWkV1/zQzMTl/l2aHq/c3im1r/vFkGF
        BTAwarG/XwPDKpvhxObHq2ngHX9+oKI/fSc5QURWSHQOuxQUHruUFSOsgtgETMYb
        5u3xUvfS8oyQMm2/IHV1aqWJGBUUWU8tBCiFJjD4jo+Vi8FXlEN/csW+xZ0VJTVz
        vWJSzxe76UEd91rosMah8enaOJrRwrgi8DoRQQwbd980yqiCZJzWNK5+aqLG1W+H
        OD20jjysr8CTybSh6g68k2XKDlLH4OXlN9ZLAUkJPKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=qDbpkk
        EocLbqAWxHGB66FYtst2+s5VmGo1txVOkmKbg=; b=suenyPBC2/0ufZrQW3SX9J
        lElogEfM9lFmbTnNU1GDM6NF0+fFxdI6xfSGPSa+/jxAVGAzD6ZzdkMpCoOyVvtc
        UUDY240tUkasekTsxXqAMV09q4ah/tu3QrYGQlBBON20XtuWE+YsCDihFgkwvvdS
        PjpHkIkjKWnwFmFHL0luLzfMC3MCEmIBKb6MHVS0X87XJqYQ9QuI9PmJrv4l3BtK
        EWU1ego9LhQR7CSsvGB4WL+xdRvxxWarxcIP1YLonfEjJGxKz2byOS5Xm7WO8PuO
        QjW0SXwkQqlzEdJEjEnpZQKDJZ7yJohs5Q1EIK1R+dAbg8uPLXAum8pm6uUq4cIA
        ==
X-ME-Sender: <xms:OlzoXpgd-nbel1PMXcxnEPLT9AT-XFZGJ9Mr6dA5yFnoFZAshI23wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeiledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejkedrheegrddurddvvdelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:OlzoXuBFK7-0NlgpDkyt2NO5KvPCTRyJFwTR5cltu4-tEJdE-ivyLg>
    <xmx:OlzoXpFYFOiO2qIUhkL9fe6MMUj-nmqpwtTa3Hh_2aA5lLD6gtVLqw>
    <xmx:OlzoXuRny8BqE4i7g3WWvFyYbfnLohQN7CVhuPJuk5zcWJLMVFpWrw>
    <xmx:O1zoXsaW45G97azSzOaJdHrnHCf8qcfgCZfqZ-bjQMSif1fKA5uEeg>
Received: from vm-mail.pks.im (x4e3601e5.dyn.telefonica.de [78.54.1.229])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B75E3060F09;
        Tue, 16 Jun 2020 01:44:25 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 608e066b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 16 Jun 2020 05:44:21 +0000 (UTC)
Date:   Tue, 16 Jun 2020 07:45:21 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] refs: implement reference transaction hook
Message-ID: <20200616054521.GA846@tanuki>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
 <20200603165142.GA24049@syl.local>
 <20200604073632.GA498923@tanuki.pks.im>
 <20200615164639.GD71506@syl.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20200615164639.GD71506@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 10:46:39AM -0600, Taylor Blau wrote:
> Hi Patrick,
>=20
> Sorry for the slow response. I was out of the office last week and am
> only just now getting a chance to catch up on the backlog of emails that
> I missed.

No worries!

> On Thu, Jun 04, 2020 at 09:36:32AM +0200, Patrick Steinhardt wrote:
> > On Wed, Jun 03, 2020 at 10:51:42AM -0600, Taylor Blau wrote:
> > > Hi Patrick,
> > >
> > > On Wed, Jun 03, 2020 at 02:27:50PM +0200, Patrick Steinhardt wrote:
> > > > In order to test the impact on the case where we don't have any
> > > > "reference-transaction" hook installed in the repository, this comm=
it
> > > > introduces a new performance test for git-update-refs(1). Run again=
st an
> > > > empty repository, it produces the following results:
> > > >
> > > >   Test                                   HEAD~             HEAD
> > > >   -----------------------------------------------------------------=
-------------
> > > >   1400.2: update existing reference      2.05(1.58+0.54)   2.08(1.5=
8+0.57) +1.5%
> > > >   1400.3: create and destroy reference   1.79(1.38+0.49)   1.82(1.3=
9+0.51) +1.7%
> > > >
> > > > So the overhead is around ~1.5%. Given that git-update-refs(1) is a
> > > > near-direct wrapper around reference transactions, there likely is =
no
> > > > other command that is impacted much worse than this.
> > >
> > > This is a serious performance regression that is worth considering. F=
or
> > > example, a 1.5% slow-down on average in reference transactions would
> > > cause be enough for me to bisect the regression down to see what
> > > changed.
> > >
> > > What are ways that this could be avoided? I bet that this would work
> > > quite well with Emily's work on hooks, where we could check in the
> > > configuration first whether a hook is even configured.
> > >
> > > Could this be integrated with that? If not, could you cache the result
> > > of whether or not the hook exists, and/or implement some mechanism to
> > > say something like, for eg., "only run reference transaction hooks
> > > core.blah =3D 1" is true?
> >
> > I wasn't aware of her work until now, so I'll take a look.
> >
> > Meanwhile, I toyed around with performance and tried out two different
> > caching mechanisms:
> >
> >     - map-cache: `find_hook()` uses a map of hook names mapped to their
> >       resolved hook path (or `NULL` if none was found). This is a
> >       generic mechanism working across all hooks, but has some overhead
> >       in maintaining the map.
> >
> >     - reftx-cache: `run_transaction_hook()` caches the path returned by
> >       `find_hook()`. It's got less overhead as it only caches the path,
> >       but obviously only applies to the reference-transaction hook.
> >
> > In theory, we could go even further and cache the hook's file
> > descriptor, executing it via fexecve(3P) whenever it's required, but I
> > didn't go down that route yet. This would also solve the atomicity
> > issue, though, if the administrator replaces the reference-transactions
> > hook halfway through the transaction.
> >
> > Benchmarking results are mixed, mostly in the sense that I can choose
> > which run of the benchmarks I take in order to have my own work look
> > better or worse, as timings vary quite a lot between runs. Which
> > probably hints at the fact that the benchmarks themselves aren't really
> > reliable. The issue is that a single git-update-ref(1) run finishes so
> > quick that it's hard to measure with our benchmarks, but spawning
> > thousands of them to get something different than 0.0s very much depends
> > on the operating system and thus fluctuates. On the other hand, if we
> > only spawn a single git-update-refs and have it perform a few thousand
> > ref updates, overhead of the hook will not show at all as it is only
> > executed once per prepare/commit of the transaction.
> >
> > The following timings are for the case where we execute
> >
> >     git update-ref refs/heads/update-branch PRE POST &&
> >     git update-ref refs/heads/update-branch POST PRE
> >
> > respectively
> >
> >     git update-ref refs/heads/new POST &&
> >     git update-ref -d refs/heads/new
> >
> > a thousand times:
> >
> > Test                                   master            ref-hook-no-ca=
che       ref-hook-map-cache      ref-hook-reftx-cache
> > -----------------------------------------------------------------------=
-------------------------------------------------------
> > 1400.2: update existing reference      1.96(1.50+0.53)   2.00(1.54+0.53=
) +2.0%   2.02(1.54+0.55) +3.1%   1.98(1.52+0.52) +1.0%
> > 1400.3: create and destroy reference   1.74(1.33+0.49)   1.77(1.38+0.47=
) +1.7%   1.77(1.36+0.48) +1.7%   1.76(1.35+0.49) +1.1%
>=20
> Huh. It is super interesting (to me, at least) that caching the set of
> hooks that are on disk and should be run makes this *slower* than
> without the cache. What's going on there? In p1400.2, I'd expect to see
> 'ref-hook-map-cache' attain at most a 2.0% slow-down, plus a little bit
> to process the hook when it is there, but not much more than that.

I think the issue is that a single git-update-ref(1) invocation does so
little work that allocating the hashmap and inserting the hook already
has noticeable impact on the program's runtime. E.g. in above
benchmark, a single call to git-update-ref in p1400.2 takes roughly
0.002s on my machine. You also see this by the fact that doing a single
stat(3P) call as introduced by my patch adds a 1% performance penalty
already, and with the map cache we still have to do this single stat(3P)
call in addition to the dynamic memory allocations for the map and
insertion of the hook.

> I think that this just seems a little contrived to me. I can understand
> why server administrators may want this feature, but the general
> user-base of Git doesn't seem to stand to benefit much from this change
> (in my own mind, at least).

That's true for several hooks we have, though.

> So... I'm not sure where this leaves us. Maybe a 2.0% slow-down on an
> already fast 'git update-ref' invocation for the average user won't be
> noticeable. It certainly *will* be noticeable to administrators who
> processes a much higher volume of such transactions.

I think we should keep in mind that it's git-update-ref(1) we're talking
about, which is a nearly direct wrapper around reference transactions.
The 1% perfomance hit is thus the worst case that can happen, as there
is no other tool that does as little work around the reftx as this one.
For any other tool, I imagine the performance hit to be at worst the
same (e.g. git-branch(1)) or not noticeable at all because a single
stat(3P) call will be drowned out by other things (e.g. git-clone(1)).

That's not to say that nobody will be impacted by this change, I bet
there are setups that make heavy use of git-update-ref(1).

> > For such a short-lived program like git-update-refs(1), one can see that
> > the overhead of using a map negatively impacts performance compared to
> > the no-cache case. But using the reftx-cache roughly cuts the overhead
> > in half as expected, as we only need to look up the hook once instead of
> > twice.
> >
> > And here's the results if we use a single `git update-ref --stdin` with=
 a
> > thousand reference updates at once:
> >
> > Test                             master            ref-hook-no-cache   =
    ref-hook-map-cache      ref-hook-reftx-cache
> > -----------------------------------------------------------------------=
-------------------------------------------------
> > 1400.2: git update-ref --stdin   0.21(0.09+0.12)   0.21(0.07+0.14) +0.0=
%   0.21(0.07+0.13) +0.0%   0.21(0.07+0.13) +0.0%
> >
> > As expected, there's nothing much to be seen here because there's only a
> > single transaction for all ref updates and, as a result, at most two
> > calls to `access(refhook_path, X_OK)`.
>=20
> Better, but I have to imagine that real-world usage will look much more
> like a thousand tiny transactions than one large one.

Most likely, yes. Doesn't happen too often that one updates multiple
references at once.

Patrick

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7oXHAACgkQVbJhu7ck
PpTOVBAAixFhZHjzW951UeNNpYjigkg8d+iZI2j0PmvelaySDPSAjovT904DVFc8
pX4RXrjInicyj+6WOV5gEyq682ABT6jXFybfJU1RsfhjuK8D94qvo0wBHc1QoI6u
LD9+SliCTZ5opNBOtdHhhSUR1YarhtkqldHoZWp91XPtoSPe+puhcb+8tkWFGcX0
AS5xVUTFeEfhIwpOxybvMtr3JkRWJ93u1Fym+NBnEJILwC+5m6cKPUUZy3TGKarV
MWDBN1xYagAUS2N4q48WtIyRnm9LjweIsZaP044vYSn+quLBKpsF/9m9I8fe6Ma/
c7uf3ozt89VVW71bjeRPynMDmxti9skPZumei+HCHerlXbYlxxR2mYWnsMvI8imA
OE90t0GBoOG9rvpOR8AHZ7TQrxAdlK4mfHuHo3YxX8f5uQFScTjF9Ism1VhXaJ+y
mcnL0b3QJPr6hHYxIDISWrIsj+03zMAEpKKFyk7mtozVPViOrPCOFBLlDQwyYfVZ
irDZ2qTi41hXtb8Lr2M2C6UUm/I+2pgvZHXFu5p8+x7n8yYlsScg6VmHhF5Yf/aW
RSeMUFH/t/ismy55r5E4ZpN76KZfdCfgoMCMLl2vjpzAbytXRoPE8f2cduVLfMQT
8wcATdPnV/cS1qEYT5/4O5y21JiLf6niDvcRIKYDfWmOPpOm6co=
=J0LM
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
