Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8542DC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584686191D
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 21:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhCVVfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCVVef (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 17:34:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E409C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 14:34:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id hq27so23690465ejc.9
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LM57kOnr11HrH03RgGQ56tIitTFNvJsqsKOSA+zkW6k=;
        b=PrYHyVcHADufhHPbw58zExFQKrJRfXQ6qvb59F9Z8i2CfO+nrcIGq8srTc3fFgFXcf
         xsEPDaN+UoqaEYYXJyggW9U5cNdiw8D8pb3HXvGPJDG0Ze2G2/5SoII7m6qGKFBk2ZMv
         EVwauVQRbN1m0DejflqM8fcrjhmb3W043mCMvy6NiiTX1b8Ei3jFJHRcXJn84/TKM2ip
         BzVcXczv1D+pWyLNFgcYWBsSMw84SWpUVdEfkgFBueRjjNEKuYQOrDfiHdvvG8K6lzp3
         8yTSbp0aFlUR3z+vAXrgvwMiY1dMKMjF+SMbQaNRHq234iAAby2m3GxIoja9gXAONyNC
         JPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LM57kOnr11HrH03RgGQ56tIitTFNvJsqsKOSA+zkW6k=;
        b=lXWRBtw/2cTDysJvhOkbFRGTFsEpsPEcBZkaud13P6CVfFiOITtfZow+sfT0+CMalC
         +3oHqCA3o7DXswJRqOG9JL27lqFnllD4+hVTuy7IT25JmxouyQkYrnk7lghcz0qw6x6J
         Yg3qfJqic7CGbSWh38ZcOUf3zOQtLgMzSibIEp2bKTc4IHHeNecuLf3UzNwv+Z/tDzg7
         cl6jyVR+Kjdd04GReU+RhB6TNUH5hZqlSevs281E17Fp4FFNMTN23+HdfXe6gc5UpgG+
         fwjJkRMtUG19QNTIUbNKDiamI49DnaMZGqpScJ7qQK9PuDRirDq0OzR8747+3lsP61Z6
         qt1g==
X-Gm-Message-State: AOAM532dYXVOhu5/zz7flLT3opAeVfIYDgLUgGTGS1QL64LIed3whut2
        WpV8J5ZjAUz2KfZBO9pd0fnI9eGBWy8g55/b3wc=
X-Google-Smtp-Source: ABdhPJwjZGDg8G8/sMlCKwGZu+ZSkh0kq3QirQpce1HfRboOMpzMDV8HjnDG2DUMA0Q/E2genMAZ+mcL3XDbo4jT11o=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr1716579ejz.341.1616448873812;
 Mon, 22 Mar 2021 14:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
In-Reply-To: <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 22 Mar 2021 22:34:21 +0100
Message-ID: <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 11:23 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8822=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:43=E5=86=99=E9=81=
=93=EF=BC=9A

> > Nice that you have added such a test!
>
> Thanks.
>
> But at the same time I have two little doubt.
>
> 1.
> If we have your config:
>
> $ git config trailer.sign.key "Signed-off-by: "
> $ git config trailer.sign.ifexists replace
> $ git config trailer.sign.command "git log --author=3D'\$ARG' -1
> --format=3D'format:%aN <%aE>'"
>
> Then I touch a test.c and use:
>
> $ git interpret-trailers --in-place test.c
>
> without `--trailer`, See what is happen:
>
> It seem like your local repo last commit "name <email>" pair
> have been record in `test.c`.
>
> Could this be considered a bug?

First it seems strange to use `git interpret-trailers` on a "test.c"
file. It's supposed to be used on commit messages.

Then, as the doc says, every command specified by any
"trailer.<token>.command" config option is run at least once when `git
interpret-trailers` is run. This is because users might want to
automatically add some trailers all the time.

If you want nothing to happen when $ARG isn't set, you can change the
config option to something like:

$ git config trailer.sign.command "NAME=3D'\$ARG'; test -n \"\$NAME\" &&
git log --author=3D\"\$NAME\" -1 --format=3D'format:%aN <%aE>' || true"

(This is because it looks like $ARG is replaced only once with the
actual value, which is perhaps a bug. Otherwise something like the
following might work:

git config trailer.sign.command "test -n '\$ARG' && git log
--author=3D'\$ARG' -1 --format=3D'format:%aN <%aE>' || true")

Then you can run `git interpret-trailers` with the --trim-empty option
like this:

------
$ git interpret-trailers --trim-empty --trailer sign=3DLinus<<EOF
EOF

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
------

or like:

------
$ git interpret-trailers --trim-empty<<EOF
> EOF

------
