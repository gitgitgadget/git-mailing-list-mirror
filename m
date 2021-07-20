Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924F2C636C8
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C66561164
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 14:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbhGTNru (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 09:47:50 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40643 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239873AbhGTNqV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Jul 2021 09:46:21 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 285F35C0191;
        Tue, 20 Jul 2021 10:26:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 20 Jul 2021 10:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=fdfFeMhFK+fi9XLK08xv4dCTFwv
        EeOZ8Rz9NpRpcQD4=; b=FwIxES8hS029e/fl61pd1wZ5ro9jv7sVc0ZfLx9b6pH
        X/yn2xMzCC3rMqpZ0o1rTmRyLRRytGjZXs27CMy7jzltK6Iwxpb6dF44ld3Tb9Cl
        VmepOZySCip8iR2YaU2Ft+ZRDBA6pYT51pL94ZavCQeUks47RqJeVgPXLPIt2FQI
        Stxfxwj5dmbMVfVlFmRuX653yAr7UoZmmKwg5dDzTX4eDIyp+MWOm5x4wMuCP+zd
        Ce+SS+7fbH/B9+SqK/ljHP9c8oKcCC8Lr7hwPLH1Nf56HXu3kzzhqreuZzTK3byz
        I/b2QNqcJoI75/23yUYd/P6C2kIlucE8a5GDOHHRUng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fdfFeM
        hFK+fi9XLK08xv4dCTFwvEeOZ8Rz9NpRpcQD4=; b=bjK6HLs0XPtB0o1kjNr+RW
        /BWkugmRTLDd2Bj8CL5DZH+oalfF72W5WTBp1sF2lPJKY10JcbWK82vhAMP1sTLv
        lAwPDsCfPndSW/E6KC9z4O6BrmhoeinreITgSlZ90ogj7W9v0JfVeS4h6BVf/dy3
        izYaiB3x+ElTmVs/j1RejGWDeecxV20vweZypOB/cZu3XJnL5TyvOF0EopPrbngB
        ZgudD2Dbu4pawya2rKefpu9fVGwG6iP79LKODQbiiC1Wl/FzGSazHh1wdLB2h1kF
        /YTHlgGwds/8af9TMwOZye9d0E7AJ9JIc+IiL1DagWD/ULsQAyYIko/OBikzDeuQ
        ==
X-ME-Sender: <xms:LN32YKTepQT4NV0CtzD6TCyazvOBQ5bOUCv8rZWZsd1vwFkOyhI2Ew>
    <xme:LN32YPw_zb8V21WDKVqelrgeUssz_llwVXPhwMPSY3zJews-V54KmrgCdFzpe3U9d
    9QBQ5kdg5AntvhKTQ>
X-ME-Received: <xmr:LN32YH3-kI3r6GFppQNbLSR97QdJJ7BEesazQxt6lVnv5jBOsdhIgSbQWQTBr7XfBuc5GfxvkaYnpfxL4yTmChqDqfn->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:LN32YGAVgNHUFXQJuiqApGjDc-a2tAkyFCDKj8vJSJkHbvvuRxiBWg>
    <xmx:LN32YDgegXexiHjv_gGwWT9bDFrVnF17e0R5vBkb_52xc2g5cujGbw>
    <xmx:LN32YCrKps-2w_tdXXfL_NTWvjjE4gbWf-B8dugao72KTRWogcDHxw>
    <xmx:Ld32YOU0mIfrbAUpNpZ2x_z_wh-2Igr6IAm8gRrdNgRTtUL2GPsrmA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jul 2021 10:26:51 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e61429d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 20 Jul 2021 14:26:46 +0000 (UTC)
Date:   Tue, 20 Jul 2021 16:26:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/3] connected: implement connectivity check using
 bitmaps
Message-ID: <YPbdJFfykDo1diJK@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
 <YNvOJQDYRWpFa+4S@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VMsOl/TbRFipuzF3"
Content-Disposition: inline
In-Reply-To: <YNvOJQDYRWpFa+4S@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VMsOl/TbRFipuzF3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 29, 2021 at 09:51:33PM -0400, Jeff King wrote:
> On Mon, Jun 28, 2021 at 07:33:15AM +0200, Patrick Steinhardt wrote:
>=20
> > As expected, performance doesn't change in cases where we do not have a
> > bitmap available given that the old code path still kicks in. In case we
> > do have bitmaps, this is kind of a mixed bag: while git-receive-pack(1)
> > is slower in a "normal" clone of linux.git, it is significantly faster
> > for a clone with lots of references. The slowness can potentially be
> > explained by the overhead of loading the bitmap. On the other hand, the
> > new code is faster as expected in repos which have lots of references
> > given that we do not have to mark all negative references anymore.
>=20
> Hmm. We _do_ still have to mark those negative references now, though
> (the bitmap code still considers each as a reachability tip for the
> "have" side of the traversal). It's just that we may have to do less
> traversal on them, if they're mentioned by other bitmaps.
>=20
> So in that sense I don't think your "a ref for every commit" cases are
> all that interesting. Any bitmap near the tip of history is going to
> include a bit for all those old commits, because our fake set of refs
> are all reachable. A much more interesting history is when you have a
> bunch of little unreachable spikes coming off the main history.
>=20
> This is common if you have a lot of branches in the repo, but also if
> you maintain a lot of book-keeping refs (like the refs/pull/* we do at
> GitHub; I assume GitLab does something similar).
>=20
> Here are some real-world numbers from one of the repos that gives us
> frequent problems with bitmaps. refs/pull/9937/head in this case is an
> unmerged PR with 8 commits on it.

Yeah, this kind of brings us back to the old topic of pathological
performance combined with bitmaps. As I said in the cover letter, I
haven't been particularly happy with the results of this version, but
rather intended it as an RFC. Taylor's extension does look quite
interesting, but ultimately I'm not sure whether we want to use bitmaps
for connectivity checks. Your spiky-branches example neatly highlights
that it cannot really work in the general case.

I wonder where that leaves us. I'm out of ideas on how to solve this in
the general case for any push/connectivity check, so I guess that any
alternative approach would instead make use of heuristics.

In the current context, I care mostly about the user-side context, which
is interactive pushes. Without knowing the numbers, my bet is that the
most frequent usecase here is the push of a single branch with only a
bunch of commits. If the pushed commit is a descendant of any existing
commit, then we can limit the connectivity check to `git rev-list
--objects $newoid --not $oldoid` instead of `--not --all`. There's two
issues:

    - "descendant of any existing commit" is again the same territory
      performance-wise as `--all`. So we can heuristically limit this
      either to the to-be-updated-target reference if it exists, or
      HEAD.

    - Calculating ancestry can be expensive if there's too many commits
      in between or if history is unrelated. We may limit this check to
      a small number like only checking the most recent 16 commits.

If these conditions hold, then we can do above optimized check,
otherwise we fall back to the old check.

Do we actually gain anything by this? The following was executed with
linux.git and stable tags. afeb391 is an empty commit on top of master.

    Benchmark #1: git rev-list afeb391 --not --all
      Time (mean =C2=B1 =CF=83):      64.1 ms =C2=B1   8.0 ms    [User: 52.=
8 ms, System: 11.1 ms]
      Range (min =E2=80=A6 max):    58.2 ms =E2=80=A6  79.5 ms    37 runs

    Benchmark #2: git rev-list afeb391 --not master
      Time (mean =C2=B1 =CF=83):       1.6 ms =C2=B1   0.5 ms    [User: 1.0=
 ms, System: 1.0 ms]
      Range (min =E2=80=A6 max):     0.4 ms =E2=80=A6   2.2 ms    1678 runs

Obviously not a real-world example, but it serves as a hint that it
would help in some cases and potentially pay out quite well.

Patrick

--VMsOl/TbRFipuzF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmD23SMACgkQVbJhu7ck
PpR+ExAAnvykCYI/B1bfpblGnt1Gv4ZmH8/AjNZdjjXyKsB9SJpAMXrP0H6emBfg
uIpdW0PAK7eIulz3wXiTEcwz95KZFNnAEupijee5v+Yo8dCioqMK+waRZ3OTOyC3
4za65sffJXu/7GJ+ufV0FHRfzNM7D1jTF378PRTS9uthohtX5UihAuJxTSmpO0yf
ZWOyU96KaHjO1LDnLZt7R4xc8XF6sxZvRVGPX3dwyvMP/kOCnZ3bKvMziodYmIRP
OPIQXd8ATe9MVQZ27rgNY18sBuQSPTdnbtZf/l7TU0sFSu6bau+4Gwet9cLUvsBM
ChfepIR7obxg16wQs1hoTCbGAog3Rtqle5nZF5bYCKSGcLU55FTeaRifcwZLy5vM
2sNtNkaLmSYzvVEz16u3e9yIDLUn4Xv6Vs5kKssW9HqLGe8PnshL1WKW9HuaNnG0
Ya/0Pr9z2jx34UsllY+6YBXOFw+E8S1Z6U4Urd0QTM4P06luyGEUapLHL/OGXg6F
bFYs4ni8jQeBse0Dq8aZczZd+X10Sh74GDOMwBethBJYjFk0TZITLnbQqgqDsHKA
JcDp2j0Rkw34s3qcPw6fH+saSolxMkDAWDKWcNg5hNBTsBw5WYDV0n3vdjvz6zJc
4qW6xBf3eVrszcMsBf6T/k+5YXH77jqenL3XdXoCIrxY/5+FUog=
=yMDF
-----END PGP SIGNATURE-----

--VMsOl/TbRFipuzF3--
