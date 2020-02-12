Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE3C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 06:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0B72073C
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 06:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCcSVi11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgBLGED (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:04:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44592 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgBLGEC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 01:04:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id y5so670858pfb.11
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 22:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3keNILPrj2DN4zHfHrymqRtIIATlQWdcXpkza2SVXic=;
        b=DCcSVi11k+hDy0ZHnMubl1xWw/voQbhF3CpJN9zEuuk/lEEixmAmWycSA4dalNg4lf
         YRwAEp8gHUvingtKokOaP52hzmVvaifgV+IzuRpM8SF6FgnIq2x0LDZJasIYrkO1ozHt
         0Wz5IL+CQXrpYp/enMJJGqxBUdXFHTwNj7/8pZRQ2wKY7IQqPNC0MukjF0DO/OajgHIy
         yVeuryMbzMDZ/WzwoGYl3ZPthd38ACBdCq8bMIx6Rerw1KEnQXtx6WxqLD9gEBJ/nBeH
         W1XJbSEUOOllJAwE5nA6J3Zabx/6OvrqCUESAM+cmgf9mNBau5LrUH2A8f5IcND14x9t
         mXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3keNILPrj2DN4zHfHrymqRtIIATlQWdcXpkza2SVXic=;
        b=Z7YJy2s8kRQt5Vy+8EyFgG+WDKqCR80R59YLSqbMDXaAEApeRqdsNo2C/uKHfVnXbx
         ofbNhjUSZLmtLpZJUcnajnh2ry8CzN8DXJb6WIguVxKQou/iy7hZcnS8Imc2Bax2Klu/
         RPdfX5dmqFLXimAVdx4ZWUG71uEHR0+M1C6NfAUt5ZydMPHNTxvf/Wud013SU+jY1u2h
         ogy5TomoNcyFwo8+0ThSkpqeqrt+tWjAKZSlPZ+f/vYYmTsz7Y1u4gmweVd4Gi7jcimd
         jIUr50VbEgaZiwK8symKDJxZyoQ1ROBke2h97w5MNOVIsBqy1JiVfbEheC30VxLT92K+
         NznA==
X-Gm-Message-State: APjAAAVUMzB4jew2k8HOUnyL4kwJTfxWFeZixT6VuOBG7FQFrRST3ylf
        DwGcOLJtxgCWjVfy0MPUwPH+vneLg7EHCN0Z/kQ=
X-Google-Smtp-Source: APXvYqzHfJXJzcjwf5UqYd5YnXY1KPEC9pXtG12BzW23gJSkHJ0Jkfz/g8CBn7JwPexme9YexIv8+RUBRJ/cZWth/ZI=
X-Received: by 2002:a63:1510:: with SMTP id v16mr3901467pgl.155.1581487439892;
 Tue, 11 Feb 2020 22:03:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580430057.git.me@ttaylorr.com> <cover.1580862307.git.me@ttaylorr.com>
 <3e19d50148c8d53b30f8f0036a2d3af9f4bb3499.1580862307.git.me@ttaylorr.com>
 <CAN0heSrXZd7ktBTHaYFWjhW=NcGx5gL52-unSDaC4ZoNf96HFA@mail.gmail.com> <3acac399-9476-e4ad-556e-e0138380eeb0@gmail.com>
In-Reply-To: <3acac399-9476-e4ad-556e-e0138380eeb0@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 12 Feb 2020 07:03:46 +0100
Message-ID: <CAN0heSrNJ5XdJ=w=xgNQORAyprOD6xudivveroXV-OJwO6nBvg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] builtin/commit-graph.c: support '--split[=<strategy>]'
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 7 Feb 2020 at 16:48, Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/6/2020 2:41 PM, Martin =C3=85gren wrote:
> > On Wed, 5 Feb 2020 at 01:28, Taylor Blau <me@ttaylorr.com> wrote:
> >> -               OPT_BOOL(0, "split", &opts.split,
> >> -                       N_("allow writing an incremental commit-graph =
file")),
> >> +               OPT_CALLBACK_F(0, "split", &split_opts.flags, NULL,
> >> +                       N_("allow writing an incremental commit-graph =
file"),
> >> +                       PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> >> +                       write_option_parse_split),
> >
> >
> > I keep getting back to this -- sorry! So this actually forbids
> > "--no-split", which used to work before. Unfortunate?
>
> That certainly is unfortunate. Hopefully no one is taking a dependence on
> this, which only means something if they had a `--split` previously in
> the command-line arguments.
>
> > I have to ask, what is the long-term plan for the two formats (split an=
d
> > non-split)? As I understand it, and I might well be wrong, the non-spli=
t
> > format came first and the split format was a user-experience
> > improvement. Should we expect that `--split` becomes the default?
>
> In some ways, the split is now the default because that is how it is
> written during 'git fetch' using fetch.writeCommitGraph. However, I
> don't think that it will ever become the default for the commit-graph
> builtin.

Thanks for giving this piece of background.

> > To try to be concrete, here's a suggestion: `--format=3Dsplit` and
> > `--split-strategy=3D<strategy>`.
>
> Why --format=3Dsplit instead of leaving it as --[no-]split? Is there a re=
ason to
> introduce this string-based option when there are only two options right =
now?

My thinking was, if my concern is "--split" being overloaded, what would
it look like to "unload" it entirely? From "--split" it isn't obvious
whether it's a verb or an adjective (shall we split, or shall we do
things the split way?). Having "--format=3Dsplit" would help avoid *that*,
possibly leaving a cleaner field for the issue of "do we
allow/force/forbid the 'merging' to happen?". But I'm happy to accept
"--split=3D<strategy>" and move on. :-)

I see that Taylor juuust posted a v3. I'll try to find time to look it
over, but I won't be raising this point again.

Martin
