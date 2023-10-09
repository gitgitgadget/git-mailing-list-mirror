Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F68E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 10:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbjJIKEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbjJIKEb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 06:04:31 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA3C6
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 03:04:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 43FC6320094F;
        Mon,  9 Oct 2023 06:04:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 09 Oct 2023 06:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696845864; x=1696932264; bh=0F
        J4uvqnAzfFXwNiNZm4MBWjQMd2cBmXQnhoSxNpbyU=; b=M3s33OTa8hk0B7UCJC
        3QgAZNqxyTJfYClJJeIqejoLE8A9ZJdDqpBer+I6rO/ENWudPxb3Bhjur85DbtU0
        1fsbN2fhcSRT7/URjNg63cANpG+8LajOCvx3wVOrIcH8PtPgG4wSa4XPOyEqquzc
        Uag6karj6RbopDvtk1CR/OMjTRY7uRMtncmogC56JyXml3zZpG7/JtxfymjcCzNR
        S/xeiBGClN/VeTu8Yv31quoMmpFokf85cQRaTR/Y5wnskjFcYv1MoYUsEMjFkZyu
        4gz6nDssqQaDhKC1aB/05ci4eS2TVtF+ISZTYaZehKqv7843KlEXig2m25SWCqyv
        7ZEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696845864; x=1696932264; bh=0FJ4uvqnAzfFX
        wNiNZm4MBWjQMd2cBmXQnhoSxNpbyU=; b=Tv/CrDO8gfAJEn9BmWI7HKjuNj236
        MKctMmYT3UZ+nJdHgk9ff4uE0C/nJbwc+zBUSG3WKwJ3NvLNVT+eA2a1MjUwAi4/
        +wpdAv+hiX4VF0SGAIHWLQ1zX8X+SsV8+7Vvp3BIEDBomECtbp+8C/nH25rZT0jZ
        O9yy97/d/ZwUK39GfSEnViYaPGOTtXibW/dbu8+ppnLNjKPA72EoM/CjbZYiZDrP
        CQmXl2PCkbQl8+6+viWb+jLBE1Ytq+irqNcqF2iWMPjaE6Jwq1qQuDgOAhS3rgYK
        m6dwd9RuGna4uailwM1J09Yn5VpflxQ0Kcw4wSznQd42VI51kbxfH9m3g==
X-ME-Sender: <xms:KNAjZZVCEwFNzH9LbrctBCbhoJ_X2xNbrccyJeLzIHO6nezSIa39nQ>
    <xme:KNAjZZlTV6IIx1b1cyOvqZhSIgkKlzIgRuJFJWYv9Y067LfS0o27elBoXspTTMrGy
    lnHE5hjR_0MrPEpDQ>
X-ME-Received: <xmr:KNAjZVZmtkp1A4Qj66kk_sojuOnx-64Z7-4JswYn-VQLqwYaleApOxYt-aMyB4qhZiL37r6qwkMvcLXZJ-Vd083lw9jpX68Uen46XwGk-tqkag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetfeetleeiffdvveffgfehhfduleelffeujeevvdehfeffiefhhefhleffieejjeen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KNAjZcVCxt_J_iqGqaOsjXum9olK_qBjPaHFHZqKbtTcrnqazx_aMQ>
    <xmx:KNAjZTkwRwdn7Qj172d2br1l2fMHUf4RcRSpcT4lCf01DIfoHZD4uA>
    <xmx:KNAjZZdaFXI4KXcqU9R0lBhdPB2JyGERQdu0nNhpEFHtFNe5OxKbMw>
    <xmx:KNAjZbsB1xjqNim5jDd68P2cfG6vxN89r8ANFWRQGtY6AF7TLBX8Wg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 06:04:23 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 6168aac9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Oct 2023 10:04:21 +0000 (UTC)
Date:   Mon, 9 Oct 2023 12:04:19 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/4] Performance improvement & cleanup in loose ref
 iteration
Message-ID: <ZSPQI2gkLOSdNWLu@tanuki>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WBOHSaxs3QmEfjH7"
Content-Disposition: inline
In-Reply-To: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WBOHSaxs3QmEfjH7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 06:09:25PM +0000, Victoria Dye via GitGitGadget wro=
te:
> While investigating ref iteration performance in builtins like
> 'for-each-ref' and 'show-ref', I found two small improvement opportunitie=
s.
>=20
> The first patch tweaks the logic around prefix matching in
> 'cache_ref_iterator_advance' so that we correctly skip refs that do not
> actually match a given prefix. The unnecessary iteration doesn't seem to =
be
> causing any bugs in the ref iteration commands that I've tested, but it
> doesn't hurt to be more precise (and it helps with some other patches I'm
> working on ;) ).
>=20
> The next three patches update how 'loose_fill_ref_dir' determines the type
> of ref cache entry to create (directory or regular). On platforms that
> include d_type information in 'struct dirent' (as far as I can tell, all
> except NonStop & certain versions of Cygwin), this allows us to skip call=
ing
> 'stat'. In ad-hoc testing, this improved performance of 'git for-each-ref'
> by about 20%.

I've done a small set of benchmarks with my usual test repositories,
which is linux.git with a bunch of references added. The repository
comes in four sizes:

- small: 50k references
- medium: 500k references
- high:  1.1m references
- huge: 12m references

Unfortunately, I couldn't really reproduce the performance improvements.
In fact, the new version runs consistently a tiny bit slower than the
old version:

    # Old version, which is 3a06386e31 (The fifteenth batch, 2023-10-04).

    Benchmark 1: git for-each-ref (revision=3Dold,refcount=3Dsmall)
      Time (mean =C2=B1 =CF=83):     135.5 ms =C2=B1   1.2 ms    [User: 76.=
4 ms, System: 59.0 ms]
      Range (min =E2=80=A6 max):   134.8 ms =E2=80=A6 136.9 ms    3 runs

    Benchmark 2: git for-each-ref (revision=3Dold,refcount=3Dmedium)
      Time (mean =C2=B1 =CF=83):     822.7 ms =C2=B1   2.2 ms    [User: 697=
=2E4 ms, System: 125.1 ms]
      Range (min =E2=80=A6 max):   821.1 ms =E2=80=A6 825.2 ms    3 runs

    Benchmark 3: git for-each-ref (revision=3Dold,refcount=3Dhigh)
      Time (mean =C2=B1 =CF=83):      1.960 s =C2=B1  0.015 s    [User: 1.7=
02 s, System: 0.257 s]
      Range (min =E2=80=A6 max):    1.944 s =E2=80=A6  1.973 s    3 runs

    # New version, which is your tip.

    Benchmark 4: git for-each-ref (revision=3Dold,refcount=3Dhuge)
      Time (mean =C2=B1 =CF=83):     16.815 s =C2=B1  0.054 s    [User: 15.=
091 s, System: 1.722 s]
      Range (min =E2=80=A6 max):   16.760 s =E2=80=A6 16.869 s    3 runs

    Benchmark 5: git for-each-ref (revision=3Dnew,refcount=3Dsmall)
      Time (mean =C2=B1 =CF=83):     136.0 ms =C2=B1   0.2 ms    [User: 78.=
8 ms, System: 57.1 ms]
      Range (min =E2=80=A6 max):   135.8 ms =E2=80=A6 136.2 ms    3 runs

    Benchmark 6: git for-each-ref (revision=3Dnew,refcount=3Dmedium)
      Time (mean =C2=B1 =CF=83):     830.4 ms =C2=B1  21.2 ms    [User: 691=
=2E3 ms, System: 138.7 ms]
      Range (min =E2=80=A6 max):   814.2 ms =E2=80=A6 854.5 ms    3 runs

    Benchmark 7: git for-each-ref (revision=3Dnew,refcount=3Dhigh)
      Time (mean =C2=B1 =CF=83):      1.966 s =C2=B1  0.013 s    [User: 1.7=
17 s, System: 0.249 s]
      Range (min =E2=80=A6 max):    1.952 s =E2=80=A6  1.978 s    3 runs

    Benchmark 8: git for-each-ref (revision=3Dnew,refcount=3Dhuge)
      Time (mean =C2=B1 =CF=83):     16.945 s =C2=B1  0.037 s    [User: 15.=
182 s, System: 1.760 s]
      Range (min =E2=80=A6 max):   16.910 s =E2=80=A6 16.983 s    3 runs

    Summary
      git for-each-ref (revision=3Dold,refcount=3Dsmall) ran
        1.00 =C2=B1 0.01 times faster than git for-each-ref (revision=3Dnew=
,refcount=3Dsmall)
        6.07 =C2=B1 0.06 times faster than git for-each-ref (revision=3Dold=
,refcount=3Dmedium)
        6.13 =C2=B1 0.17 times faster than git for-each-ref (revision=3Dnew=
,refcount=3Dmedium)
       14.46 =C2=B1 0.17 times faster than git for-each-ref (revision=3Dold=
,refcount=3Dhigh)
       14.51 =C2=B1 0.16 times faster than git for-each-ref (revision=3Dnew=
,refcount=3Dhigh)
      124.09 =C2=B1 1.15 times faster than git for-each-ref (revision=3Dold=
,refcount=3Dhuge)
      125.05 =C2=B1 1.12 times faster than git for-each-ref (revision=3Dnew=
,refcount=3Dhuge)

The performance regression isn't all that concerning, but it makes me
wonder why I see things becoming slower rather than faster. My guess is
that this is because all my test repositories are well-packed and don't
have a lot of loose references. But I just wanted to confirm how you
benchmarked your change and what the underlying shape of your test repo
was.

Patrick

> Thanks!
>=20
>  * Victoria
>=20
> Victoria Dye (4):
>   ref-cache.c: fix prefix matching in ref iteration
>   dir.[ch]: expose 'get_dtype'
>   dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
>   files-backend.c: avoid stat in 'loose_fill_ref_dir'
>=20
>  diagnose.c           | 42 +++---------------------------------------
>  dir.c                | 33 +++++++++++++++++++++++++++++++++
>  dir.h                | 16 ++++++++++++++++
>  refs/files-backend.c | 14 +++++---------
>  refs/ref-cache.c     |  3 ++-
>  5 files changed, 59 insertions(+), 49 deletions(-)
>=20
>=20
> base-commit: 3a06386e314565108ad56a9bdb8f7b80ac52fb69
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1594%2F=
vdye%2Fvdye%2Fref-iteration-cleanup-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1594/vdye/=
vdye/ref-iteration-cleanup-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1594
> --=20
> gitgitgadget

--WBOHSaxs3QmEfjH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUj0CIACgkQVbJhu7ck
PpRfpQ/+LRWAyecbmihqEpX3xvSyFYur7O9sqMVosOv8dAGXTqFLDBJbEduYaaKk
/al3HXmIPpvcX5pTx/V7vpVutueic2hAE+wHlUdz5oVPrZQlJBT8kbqpwrZM1s5t
SB871FR7aPj9oliIJ5aoDioAmhzQb2Yk6l34eJgC9PuN2KFXoLRLOfdsvCpH7KuS
m64Die7RGpq0rr/7uU9Xh3FZaly/v3Vw7JtizZuKm3HaMdFjGttqf8ZImBHaYv03
oUrGnCMI38kd8HB9sghrvMmjUUOa55O8BhmUfQtoPtxdJXM7HU7zVl7SaQeBToev
3ByIqO7BeJYgkclizyEYncXXcRBeYU99ZsMbi7uCCusdf0KfzswSCFWz3ARa3GQa
NnIL+tw3dofMO65Z2NEQ3lZowZRHNS1ZFoNGwBRmJmHp0A9tlIWXY5AK9m5h/KLZ
41KlVP865UY27FB1VL+0I4LcOHAQGFNKxdjirH4B5NE51sQOpBfXHSEFq1l50Ahc
6wqZV/6lHKMQhbjFWWuKrcOyE2wsjp8AkDgeE/kcn0VmrKGsrsipIvTmne3GzOph
i++JsczQDDhhJq2f9kc2mhaZG+C0d5R7v1IhcRBQs9pLUdFWXkp4LbNPzJNlE4M0
fW/SHSVvsYNJfoQYJgcn1BhAWA89YyNw34ZBY2aMun6FuRsC+HY=
=2MSX
-----END PGP SIGNATURE-----

--WBOHSaxs3QmEfjH7--
