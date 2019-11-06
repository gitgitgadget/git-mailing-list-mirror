Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2496A1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfKFJPI (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:15:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:40535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfKFJPI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573031694;
        bh=gCilKyGA2c4xnW1oylxV+EteRGwvJwKd93KO/p3Sjjg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UTzcEtz8kwhNr6JQ9e+osu8xZ5LKrRQk1P2Gg/LPCLWKCV2JeVdmdPYjbtLdfXylp
         FLMQVKz0vluQdzc2c8/SBj/sep/bVgxr09LvvomAZU1FSry0Ykr8kUDGPl8B2oeQW5
         1eNPH5XEj9v1eZm7MDKcJzQJ5DnIkwBYqrloshRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw3X-1i1V6c3ovb-00iy8T; Wed, 06
 Nov 2019 10:14:54 +0100
Date:   Wed, 6 Nov 2019 10:14:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] remote-curl: unbreak http.extraHeader with custom
 allocators
In-Reply-To: <20191106041644.GE4307@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1911061009230.46@tvgsbejvaqbjf.bet>
References: <pull.453.git.1572991158.gitgitgadget@gmail.com> <d47a2aa5949a5dd3a10b89d9a77ebb89af6ba57e.1572991158.git.gitgitgadget@gmail.com> <20191106041644.GE4307@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M+iX3w8JRaY9SI4JZ71Vk+b2JNGnbIGPlZtn89S2EXqJNUaL8XO
 9IUUFyzkFyDGzHjzxvgiV63/BMyr23vlRMqhHXAKKSWwuN0F28ggGkiG21Ei+S88vqt+2JR
 tJ1aVGNM6rt9u0AhrqfYzvGN8tWOYYpC07l5zvW6cjfW9SFcuozao94752oQaQcZ78vxFhz
 /g51vZvMmRwo3qAr8mknA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o4iEmOJpFGc=:uYt/kD/N4r2tz7L2EOuHfS
 RGsOq8I8h+1316qtkupI0xdgy9s57asy/Yy6WmsnluK7eNnDOve4NR2wEMwSN6ahSOl64uJiz
 9XIG50oB4pvVNZMuXeOGBmULKpVxB0THJGOYPVbxxmIreodjVwjYP3MhJCPLVkRgsjfum+iYn
 mLHSe5yojXzvSgZwYM/pFDweVd07mXdnktpaPdgZvidPYbTsF7BtQ/Nmb56kD8iJ8Ja7YCBeV
 f8ZP0dLMnREuZwrQuxrwkoeJqP594UlFy1yrZmWJKEUvOwALgbbeKmoiGjBHZt/hKoTVtkPDk
 HNgeuRqNTGIBiMVIjBGS9J4Tph3QQq1G5+zqBbeZjLv3pxRdjgNzx8aX2w1Zax7FnXM2BwPOi
 0de/cV/K4Wb5HGyc35V28e5co792wffHUXL5Wi70Lt30sMINqDUjT91M40eSVwzJno15lL4rj
 a5I4wdjQXnB6ckNbtF2SatX7JzsRhTMndCNGgwGoqiLdUikqJx4jx9/zur0OZUM4LqEA60EY+
 SY6QBOu2CWhOd+OFfbjS2InHwqtvo90+nXVPzQIpRf7569VhFT3XELQI3typZLzWpaNsoOGun
 KEQw8bDeaKFchScBVEj9Gs/h8G8lJxao3o7Ui5Vr8hTqRAyxiyiO7P+kMAH48n3CUjhZufTjC
 VzwOidu4BVsi8zquP8jPVuspJgmLS35nUvTOq4RKr4JX41QTNo//ncYDiZOfOStCPeRqUawjV
 gXUYkDWbBVywCQqmwemevn1Guz0zmtAC9QEN7jDThgDNUSVP4ATHBo/TXzu7stBBl1RtKyt2C
 SkwCI+ZpznvrYq9scqT+v/rDm12niivfVu/56d7mtqmM1xHcWFG6ZrwHX8IKGDfHz4NG7Qu71
 4k22NqjvWXXyA2X684T6MKtmbXGvLtgFpWz31VzAxmhCCuDtxwfPFJHze6BqhA+q6gIWOB5GT
 XDVwITI7oP4FHLQYABQznQ4DJihSyPrYGOpI2J+MTrFGOyyqcANcye4Krqzw3goyBWp3qMQGS
 xSOU3YQxXZfhLxJJip6VaGrfgnTEBEBJJdigejk+QAscWiPAZx1qUS84/XgvN+iBEKpW7Uiae
 GFCeSj4q/fywYsmAtQEof9JGb7ravyn1ptjd2AoPDMd2apXWrlp0Hla06Sj6KYIEV3AOn0R+H
 blnOGTZx+GgDPoZXN7oujbI9SZ7lX8+eCNjuzga1UX4Dfv3QwSDQOaFzWfSC/Cq3tx7FmRm3G
 LStA2X35XqWpXC7pGFbQwuC5lUe6qlNvCxLnoeaLoQlR+bWRFc52egQXxvn8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 5 Nov 2019, Jeff King wrote:

> On Tue, Nov 05, 2019 at 09:59:18PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 93b980e58f5 (http: use xmalloc with cURL, 2019-08-15), we started t=
o
> > ask cURL to use `xmalloc()`, and if compiled with nedmalloc, that mean=
s
> > implicitly a different allocator than the system one.
> >
> > Which means that all of cURL's allocations and releases now _need_ to
> > use that allocator.
> >
> > However, the `http_options()` function used `slist_append()` to add an=
y
> > configured extra HTTP header(s) _before_ asking cURL to use `xmalloc()=
`,
> > and `http_cleanup()` would release them _afterwards_, i.e. in the
> > presence of custom allocators, cURL would attempt to use the wrong
> > allocator to release the memory.
> >
> > Let's fix this by moving the initialization _before_ the
> > `http_options()` function is called.
>
> Nicely explained.
>
> Another option would be to separate our config mechanism from curl
> entirely by putting the list of headers into a string_list, and then
> transforming it later into a curl_slist. I don't think that really buys
> us much, though.

Alas, it _does_ buy us a lot, as I *just* found out (can you imagine how
glad I am not to have rushed out another Git for Windows release?). It
buys us one less bug: my patch introduces the bug where
`http.sslbackend` can no longer be used, because `curl_global_sslset()`
needs to be called _before_ `curl_global_init()`, but my patch breaks
that because we _need_ to parse the config before we can ask cURL for a
specific backend.

> This is all inside http.c, so it's fairly contained.  It's not like
> other random parts of Git are using curl's slist before calling
> http_init().

Indeed. We cannot use cURL's slist anywhere outside of the
cURL-dependent code because we want to keep `NO_CURL=3DYep` working.

> I did briefly grep around for other slist users, but they're all what
> you'd expect: code in http-push.c and remote-curl.c creating header
> lists while working with an active http request (so well after
> http_init() has been called).

Indeed, I came to the same conclusion that Carlo's patch only broke
support for `http.extraheaders` (and only with custom allocators),
nothing else.

I will change the patch to avoid using `slist` early and send another
iteration.

Thanks,
Dscho

> > ---
> >  http.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> The patch itself looks good.
>
> -Peff
>
