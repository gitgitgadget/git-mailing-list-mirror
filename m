Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C5EC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9E561B5F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245689AbhKRLBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 06:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhKRLBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 06:01:37 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9DEC061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:58:37 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y12so25065813eda.12
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ii2BdwxMtW0LdSa4gP4wzSUksXci82XRGatTCfJKD3A=;
        b=dsHhn8on7TaRYZLOSwMRGwLwCFDWrCzrmlKUpw27ZDiAyTyvPefJbgI+QRMFVMAodk
         X6BZIshevdy7kfBXFLD2G/EqvPIZejM0GHgLFJvE5OvM3hmuY37vMH9zL8ICnXKTtEeO
         KoZC/cA+WVVaq4YBfcGuRENXYjomgi7DNVGSgsFJ12OOIW3Ep5YHAKL6wKspNBrxnB5K
         sdrJ/9T1flHH/i4EmdBQ1zNMiCPLPpd3x10383W87HaXrdLkFi+3xpw29UsQsNpJZlS5
         gkuQcR7itmUZImcXZ4sdJSQ4k65oMqzfEteKgUXBgm8E27L1o3VHqjAdvvI0OpYSujHe
         c1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ii2BdwxMtW0LdSa4gP4wzSUksXci82XRGatTCfJKD3A=;
        b=6kwBg/CuUNrtwPr0rG7MImTr7Gv2z/1glKlJ2h3t2z2DUkRm8wU42eQpHH++soYzl9
         jYbjtNbfR3qNTtAomyUtYyYiVsKCksC9Y7/zUhgMmpxI6XJTVpJzKtSGw7J583SUxb/S
         grKYc11r2sOpQEI2HD2N96mQhF6s4Eh97uUC0NcasHIOPs54SIvVOT39bz7RUOiNZboZ
         Xwn3M2RqRpjMoiesMjsSNRtVf226NL5Zf2Yd8Zw7N8/KwsyRsNndc8yz4NtM7MwRfXy2
         JqXp6vQYUHhcm6d7t2Y6oeuf9tSybRSbxMJ2bNsf1gqoXpJ5pIReUBv2kbLBqAF+3M+5
         ys3Q==
X-Gm-Message-State: AOAM5339uYuyrMCSewQ9FK8TBZmkiFjLeL8TMtJnYnrLRmkT6A2x1YKF
        n6wRip1Ebk/Qj86jrjjSUwSP1I2t4Fk/8A==
X-Google-Smtp-Source: ABdhPJwGFn8EajqIDqzf2LU1veAKNpGIRQZRpbbyI2NIoXkIywV487YiKy/Es+6sLQmwXB5yWSjAuQ==
X-Received: by 2002:a05:6402:5208:: with SMTP id s8mr10025299edd.394.1637233115907;
        Thu, 18 Nov 2021 02:58:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id mp5sm1177629ejc.68.2021.11.18.02.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:58:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnf7i-000Q47-NQ;
        Thu, 18 Nov 2021 11:58:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/2] ci: add a job for PCRE2
Date:   Thu, 18 Nov 2021 11:32:50 +0100
References: <20211118084143.279174-1-someguy@effective-light.com>
 <20211118084143.279174-2-someguy@effective-light.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211118084143.279174-2-someguy@effective-light.com>
Message-ID: <211118.86h7c96885.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Hamza Mahfooz wrote:

> Since, git aspires to support many PCRE2 versions, it is only sensible to
> test changes to git against versions of PCRE2 that are deemed to be
> notable, to ensure those changes to git don't cause regressions when using
> the aforementioned PCRE2 versions. This is underscored by the fact that,
> commit ae39ba431a (grep/pcre2: fix an edge case concerning ascii patterns
> and UTF-8 data, 2021-10-15) was able to make it's way to master while
> causing an otherwise easy to catch regression when an older version of
> PCRE2 is used. So, to address this issue, add a job for PCRE2 to build all
> of the notable versions, compile all of them against git and only run the
> tests that can possibly be impacted by PCRE2.
>
> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>  .github/workflows/main.yml | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 6ed6a9e807..ae96fc0251 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -319,3 +319,29 @@ jobs:
>      - uses: actions/checkout@v2
>      - run: ci/install-dependencies.sh
>      - run: ci/test-documentation.sh
> +  pcre2:
> +    needs: ci-config
> +    if: needs.ci-config.outputs.enabled =3D=3D 'yes'
> +    strategy:
> +      fail-fast: false
> +      matrix:
> +        jit: ['--enable-jit', '--disable-jit']
> +        utf: ['--enable-utf', '--disable-utf']
> +        version: [31, 34, 36, 39]
> +    runs-on: ubuntu-latest
> +    steps:
> +    - uses: actions/checkout@v2
> +    - uses: actions/checkout@v2
> +      with:
> +        repository: 'PhilipHazel/pcre2'
> +        path: 'compat/pcre2-repo'
> +    - run: ci/install-dependencies.sh
> +    - run: cd compat/pcre2-repo
> +    - run: git checkout pcre2-10.${{matrix.version}}
> +    - run: ./autogen.sh
> +    - run: ./configure ${{matrix.jit}} ${{matrix.utf}} --prefix=3D"$PWD/=
inst"

Thanks a lot for following-up on this. Do you have a link to a sample
run of this to see how it looks?

I think that the --enable-utf here is a bug, my fault, I suggested using
that option.

But on closer inspection I should have said
--{enable,disable}-unicode. Eyeballing the configure.ac in pcre2.git now
and checking if/how it passes our tests I think it might be a noop
unless --enable-ebcdic is also in play, which we don't need to test.

Any reason for picking those specific versions? I think we do need to
test on older than 10.31 (released in early 2018).

On the other hand PCREv2 wasn't released at all until 2015, and got up
to 10.20 all in that one year, and I think git may have been one of the
first popular packages to use it.

I (optionally at first) us from PCRE v1 to v2, and IIRC something like
only 1-2 obscure packages in Debian depended on it at the time, with
hundreds depending on PCREv1.

We should also add a "latest" in there, and then just map that ourselves to:

     git tag -l --sort=3D-version:refname | head -n 1

I.e. it's probably overkill to test the pcre2.git bleeding edge, and it
might produce undue noise, but testing the latest release in addition to
select older versions seems like a good thing to do.

> +    - run: make
> +    - run: sudo make install

I don't think "sudo" here is needed (and I'm surprised it works in CI,
presumably a noop or it's always root). Just a:

    make install

Should do, it'll also take care of doing "make"

> +    - run: cd ../..
> +    - run: make USE_LIBPCRE=3DY CFLAGS=3D-O3 LIBPCREDIR=3D"$PWD/compat/p=
cre2-repo/inst"


I was going to say: "We should probably leave CFLAGS undefined and use
whatever the default is, or is there a good reason for -O3?".

But I see this is another thing copied from my throw-away one-liner in
[1], sorry. We can just skip that, I just happened to be testing with
CFLAGS=3D-O3 locally at the time & copied that into my E-Mail.

> +    - run: cd t && make *{grep,log,pickaxe}*

1. https://lore.kernel.org/git/211117.867dd67spq.gmgdl@evledraar.gmail.com/
