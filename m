Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889A3CD68F5
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 07:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442459AbjJJHVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 03:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442431AbjJJHVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 03:21:30 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7553BFB
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 00:21:28 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D987E5C007F;
        Tue, 10 Oct 2023 03:21:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Oct 2023 03:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696922487; x=1697008887; bh=Em
        gppE18R2eyiu4nZt3FCcj78knxL5emURYESGIdkoI=; b=KW311SDNGDauYdK+dG
        hRydBRGGv8zUrtkGzU1Jw6psX3E/mZ8J02Ra0c4Tn43m6OJjEpwkFqQ8eyYZf8jN
        4Ehr0HHcKWKE5LLTSC9vnGnlAjNjPU+v4tLawXRXrZe3jaD26YtobBWclJ0rwW9m
        7ywqN/sTWcK57lcicT3w6tekckgXapEJr/C/MAtnROWARp/PWaJcoJ1BJfC2Xcz+
        zDELqw4ECbq0yw8sVQrGW3AehbTmvS5KFrivzTZ+rXVSaYa8iKVLw/jrkjJjQ7Cs
        1DC+BADGjKwHVbzh4TgaTGV8bnN4sZ0s6pgGetP69wfkR4rdRkP2mwV91eDMYxjg
        Qxdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696922487; x=1697008887; bh=EmgppE18R2eyi
        u4nZt3FCcj78knxL5emURYESGIdkoI=; b=UzmDN0J5+EgNnPRWj6yfv2i4E9dnI
        BcsZL516kSasNGByMGRfJrYDjiKk/G0TOmrG/nPQgHm/Ae+WUKjjD9EYkjMG0EEm
        eN4w5Xsm5RT1H3FIQ73Q7j4Qxo/OrvnhzuHcr07O80uWbzdIvKwTFOqg/XRty/4C
        38s/N13I9WO1Hgovjhe6+6VPPoeTpAzvk9hTsb6Je8vz562GMaWvwG3U23BDaAga
        RtK6BnKSPPj0szBQh0McVb3K2qYK6p4oT6/T/q1DA9n9VxEwC264JNMNMkMiehnM
        cwAD3q2YbF1BJf4aR2Ioo+xHzW2lzHeZ8SPisyeTK3gsERnydS8QjEnuw==
X-ME-Sender: <xms:d_skZZEZcsFF4xyjRXGpmvRiKfOgI7ly13cvaIdMQu5Pqmrl6y9dSg>
    <xme:d_skZeVEL3gHFJZXMZBY2D-O3KUHsNa85hPyZAT2BFlPMwSA9JkIZFZZAHLamA1HB
    Q5ledwhpFtBEHHcew>
X-ME-Received: <xmr:d_skZbJrgrRxGTRgwLjm3nEaZ6YJJYo9gZfVYFjmG2ks1jBPgI8J71ru3422d0Ai1ZEJx05mnuYg0IfDvx4PxlNS_RZzWpC8DRCNh8Fbp9RR6VnD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheeggdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:d_skZfEyRfEn1IuVtFxtSs1sBxsJ8ZaefeqC4DkDEhnFI76_73mklw>
    <xmx:d_skZfX6qhbfsXnGcNUqjAVobbNpz-43weOoboeVjUcBtzND_nX4oA>
    <xmx:d_skZaOUB5VAFtNpT4kfFI6oRdfgFZuHxXa1w7FJqWRcd6VP77P9EQ>
    <xmx:d_skZWdLuzvH7YZDnkAL-oJmHkmuXYGPdoyZW4Rr0PpnyFnhRMBEBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 03:21:26 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id c37cee2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 10 Oct 2023 07:21:26 +0000 (UTC)
Date:   Tue, 10 Oct 2023 09:21:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] Performance improvement & cleanup in loose ref
 iteration
Message-ID: <ZST7dIYaCEFx4P0E@tanuki>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
 <ZSPQI2gkLOSdNWLu@tanuki>
 <28ae03f5-7091-d3f3-8a70-56aba6639640@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ejX2P05oPros+0cI"
Content-Disposition: inline
In-Reply-To: <28ae03f5-7091-d3f3-8a70-56aba6639640@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ejX2P05oPros+0cI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 02:49:14PM -0700, Victoria Dye wrote:
> Patrick Steinhardt wrote:
> > On Fri, Oct 06, 2023 at 06:09:25PM +0000, Victoria Dye via GitGitGadget=
 wrote:
> >> While investigating ref iteration performance in builtins like
> >> 'for-each-ref' and 'show-ref', I found two small improvement opportuni=
ties.
> >>
> >> The first patch tweaks the logic around prefix matching in
> >> 'cache_ref_iterator_advance' so that we correctly skip refs that do not
> >> actually match a given prefix. The unnecessary iteration doesn't seem =
to be
> >> causing any bugs in the ref iteration commands that I've tested, but it
> >> doesn't hurt to be more precise (and it helps with some other patches =
I'm
> >> working on ;) ).
> >>
> >> The next three patches update how 'loose_fill_ref_dir' determines the =
type
> >> of ref cache entry to create (directory or regular). On platforms that
> >> include d_type information in 'struct dirent' (as far as I can tell, a=
ll
> >> except NonStop & certain versions of Cygwin), this allows us to skip c=
alling
> >> 'stat'. In ad-hoc testing, this improved performance of 'git for-each-=
ref'
> >> by about 20%.
> >=20
> > I've done a small set of benchmarks with my usual test repositories,
> > which is linux.git with a bunch of references added. The repository
> > comes in four sizes:
> >=20
> > - small: 50k references
> > - medium: 500k references
> > - high:  1.1m references
> > - huge: 12m references
> >=20
> > Unfortunately, I couldn't really reproduce the performance improvements.
> > In fact, the new version runs consistently a tiny bit slower than the
> > old version:
> >=20
> >     # Old version, which is 3a06386e31 (The fifteenth batch, 2023-10-04=
).
> >=20
> >     Benchmark 1: git for-each-ref (revision=3Dold,refcount=3Dsmall)
> >       Time (mean =C2=B1 =CF=83):     135.5 ms =C2=B1   1.2 ms    [User:=
 76.4 ms, System: 59.0 ms]
> >       Range (min =E2=80=A6 max):   134.8 ms =E2=80=A6 136.9 ms    3 runs
> >=20
> >     Benchmark 2: git for-each-ref (revision=3Dold,refcount=3Dmedium)
> >       Time (mean =C2=B1 =CF=83):     822.7 ms =C2=B1   2.2 ms    [User:=
 697.4 ms, System: 125.1 ms]
> >       Range (min =E2=80=A6 max):   821.1 ms =E2=80=A6 825.2 ms    3 runs
> >=20
> >     Benchmark 3: git for-each-ref (revision=3Dold,refcount=3Dhigh)
> >       Time (mean =C2=B1 =CF=83):      1.960 s =C2=B1  0.015 s    [User:=
 1.702 s, System: 0.257 s]
> >       Range (min =E2=80=A6 max):    1.944 s =E2=80=A6  1.973 s    3 runs
> >=20
> >     # New version, which is your tip.
> >=20
> >     Benchmark 4: git for-each-ref (revision=3Dold,refcount=3Dhuge)
> >       Time (mean =C2=B1 =CF=83):     16.815 s =C2=B1  0.054 s    [User:=
 15.091 s, System: 1.722 s]
> >       Range (min =E2=80=A6 max):   16.760 s =E2=80=A6 16.869 s    3 runs
> >=20
> >     Benchmark 5: git for-each-ref (revision=3Dnew,refcount=3Dsmall)
> >       Time (mean =C2=B1 =CF=83):     136.0 ms =C2=B1   0.2 ms    [User:=
 78.8 ms, System: 57.1 ms]
> >       Range (min =E2=80=A6 max):   135.8 ms =E2=80=A6 136.2 ms    3 runs
> >=20
> >     Benchmark 6: git for-each-ref (revision=3Dnew,refcount=3Dmedium)
> >       Time (mean =C2=B1 =CF=83):     830.4 ms =C2=B1  21.2 ms    [User:=
 691.3 ms, System: 138.7 ms]
> >       Range (min =E2=80=A6 max):   814.2 ms =E2=80=A6 854.5 ms    3 runs
> >=20
> >     Benchmark 7: git for-each-ref (revision=3Dnew,refcount=3Dhigh)
> >       Time (mean =C2=B1 =CF=83):      1.966 s =C2=B1  0.013 s    [User:=
 1.717 s, System: 0.249 s]
> >       Range (min =E2=80=A6 max):    1.952 s =E2=80=A6  1.978 s    3 runs
> >=20
> >     Benchmark 8: git for-each-ref (revision=3Dnew,refcount=3Dhuge)
> >       Time (mean =C2=B1 =CF=83):     16.945 s =C2=B1  0.037 s    [User:=
 15.182 s, System: 1.760 s]
> >       Range (min =E2=80=A6 max):   16.910 s =E2=80=A6 16.983 s    3 runs
> >=20
> >     Summary
> >       git for-each-ref (revision=3Dold,refcount=3Dsmall) ran
> >         1.00 =C2=B1 0.01 times faster than git for-each-ref (revision=
=3Dnew,refcount=3Dsmall)
> >         6.07 =C2=B1 0.06 times faster than git for-each-ref (revision=
=3Dold,refcount=3Dmedium)
> >         6.13 =C2=B1 0.17 times faster than git for-each-ref (revision=
=3Dnew,refcount=3Dmedium)
> >        14.46 =C2=B1 0.17 times faster than git for-each-ref (revision=
=3Dold,refcount=3Dhigh)
> >        14.51 =C2=B1 0.16 times faster than git for-each-ref (revision=
=3Dnew,refcount=3Dhigh)
> >       124.09 =C2=B1 1.15 times faster than git for-each-ref (revision=
=3Dold,refcount=3Dhuge)
> >       125.05 =C2=B1 1.12 times faster than git for-each-ref (revision=
=3Dnew,refcount=3Dhuge)
> >=20
> > The performance regression isn't all that concerning, but it makes me
> > wonder why I see things becoming slower rather than faster. My guess is
> > that this is because all my test repositories are well-packed and don't
> > have a lot of loose references. But I just wanted to confirm how you
> > benchmarked your change and what the underlying shape of your test repo
> > was.
>=20
> I ran my benchmark on my (Intel) Mac with a test repository (single commi=
t,
> one file) containing:
>=20
> - 10k refs/heads/ references
> - 10k refs/tags/ references
> - 10k refs/special/ references=20
>=20
> All refs in the repository are loose. My Mac has historically been somewh=
at
> slow and inconsistent when it comes to perf testing, though, so I re-ran =
the
> benchmark a bit more formally on an Ubuntu VM (3 warmup iterations follow=
ed
> by at least 10 iterations per test):
>=20
> ---
>=20
> Benchmark 1: git for-each-ref (revision=3Dold,refcount=3D3k)
>   Time (mean =C2=B1 =CF=83):      40.6 ms =C2=B1   3.9 ms    [User: 13.2 =
ms, System: 27.1 ms]
>   Range (min =E2=80=A6 max):    37.2 ms =E2=80=A6  59.1 ms    76 runs
> =20
>   Warning: Statistical outliers were detected. Consider re-running this b=
enchmark on a quiet system without any interferences from other programs. I=
t might help to use the '--warmup' or '--prepare' options.
> =20
> Benchmark 2: git for-each-ref (revision=3Dnew,refcount=3D3k)
>   Time (mean =C2=B1 =CF=83):      38.7 ms =C2=B1   4.4 ms    [User: 13.8 =
ms, System: 24.5 ms]
>   Range (min =E2=80=A6 max):    35.1 ms =E2=80=A6  57.2 ms    71 runs
> =20
>   Warning: Statistical outliers were detected. Consider re-running this b=
enchmark on a quiet system without any interferences from other programs. I=
t might help to use the '--warmup' or '--prepare' options.
> =20
> Benchmark 3: git for-each-ref (revision=3Dold,refcount=3D30k)
>   Time (mean =C2=B1 =CF=83):     419.4 ms =C2=B1  43.9 ms    [User: 136.4=
 ms, System: 274.1 ms]
>   Range (min =E2=80=A6 max):   385.1 ms =E2=80=A6 528.7 ms    10 runs
> =20
> Benchmark 4: git for-each-ref (revision=3Dnew,refcount=3D30k)
>   Time (mean =C2=B1 =CF=83):     390.4 ms =C2=B1  27.2 ms    [User: 133.1=
 ms, System: 251.6 ms]
>   Range (min =E2=80=A6 max):   360.3 ms =E2=80=A6 447.6 ms    10 runs
> =20
> Benchmark 5: git for-each-ref (revision=3Dold,refcount=3D300k)
>   Time (mean =C2=B1 =CF=83):      4.171 s =C2=B1  0.052 s    [User: 1.400=
 s, System: 2.715 s]
>   Range (min =E2=80=A6 max):    4.118 s =E2=80=A6  4.283 s    10 runs
> =20
> Benchmark 6: git for-each-ref (revision=3Dnew,refcount=3D300k)
>   Time (mean =C2=B1 =CF=83):      3.939 s =C2=B1  0.054 s    [User: 1.403=
 s, System: 2.466 s]
>   Range (min =E2=80=A6 max):    3.858 s =E2=80=A6  4.026 s    10 runs
> =20
> Summary
>   'git for-each-ref (revision=3Dnew,refcount=3D3k)' ran
>     1.05 =C2=B1 0.16 times faster than 'git for-each-ref (revision=3Dold,=
refcount=3D3k)'
>    10.08 =C2=B1 1.34 times faster than 'git for-each-ref (revision=3Dnew,=
refcount=3D30k)'
>    10.83 =C2=B1 1.67 times faster than 'git for-each-ref (revision=3Dold,=
refcount=3D30k)'
>   101.68 =C2=B1 11.63 times faster than 'git for-each-ref (revision=3Dnew=
,refcount=3D300k)'
>   107.67 =C2=B1 12.30 times faster than 'git for-each-ref (revision=3Dold=
,refcount=3D300k)'
>=20
> ---
>=20
> So it's not the 20% speedup I saw on my local test repo (it's more like
> 5-8%), but there does appear to be a consistent improvement.

Thanks a bunch for re-doing the benchmark with a documented setup.

> As for your results, the changes in this series shouldn't affect
> packed ref operations, and the difference between old & new doesn't
> seem to indicate a regression.=20

Yeah, I've also been surprised to see the performance regression for
packed-refs files. The regression is persistent and reproducable on my
machine though, so even though I tend to agree that the patches
shouldn't negatively impact packed-refs performance they somehow do. It
could just as well be something like different optimization choices by
the compler due to the added patches, or hitting different cache lines.
I dunno.

Anyway, I agree with your assessment. The regression I see is less than
1% for packed-refs, while the improvements for loose refs are a lot more
significant and conceptually make a lot of sense. So I didn't intend to
say that we shouldn't do these optimizations because of the miniscule
peformance regression with packed-refs.

Or in other words: this series looks good to me.

Thanks!
Patrick

--ejX2P05oPros+0cI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUk+3QACgkQVbJhu7ck
PpTo3Q/5AY336t+OBCSJDSfPjy0hVBU9BQFBL0E0y6m87oy0mkF+0K6SbdaNy0TM
twRBxuGGCLjH7K1bVxHl2UZIbAOsqunyYCjQe92YhiGj6iir+YIbdKfAxP8niIRD
//nnWJpmhRY8A1mlNCqll2GToJXZC/Tx7WBA+x5PgnHZVLcaYLuhf+ojpBzbbQit
01nyaUvHU5KZQ91st+GrXDn3zvJ0expei9g0yK/MH5Kb0GvTLKFxoFcALsHQ6R1h
YicBtG8Ium0GlcCRIM7sNfIqjV+/vadvwneg8J7/EfvS93B2zp18YsH2HC5p2a/R
butE7B0FuuGRrLVDgBhe9wUw5jOpztsGnGY6q0LNJKd34TbKgkRiF1tVcflYW1yD
hjc3kC57SQR/jl142mjJbVLHyC9/pjwBCnv0/VYwM1v7U1gAeQTXJ0oV/Mw2rTZj
ffc8KbdZL74+ul0131bi8y75KcGwFFcMUtHNf2IShUtPVLQO4Zk+bmNPRTt/acY3
JVLtODD9rMATlePW0FxSd8w8kU3JbQJ+JNCkwqUytmdwr0I4ezxo2TkhRRjJcEnw
p9FGOFE2e2M68AvNt50EdWxr1p0gzKo4mQ6V2pf73wJEqAi7Zd7tRLd4vD1fkXjd
aB141s96MTeYUCHDt5ttRI666l5qpQ/g7WSfR4yY7Gxg6c+GyYk=
=mpnw
-----END PGP SIGNATURE-----

--ejX2P05oPros+0cI--
