Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9230CC433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6484E207DA
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciVM1pp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHUVt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHUVt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:49:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6E5C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:49:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 93so2755602otx.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gf9qLeHaNKr5s8WfcRc+935K4g2yGhGNonsEd2nFisk=;
        b=ciVM1pp4U1A8yoW8BWcshW3H8cxEL7NOYLsIoODtliv3+bfsroIOESQZw/TnMq49y3
         2KB5zFtPecahkomqYQbACGYHjw2v7TBZ5/GCg+tU04mRoi4A73GD6RPixfOzHmsO3lTp
         9lfdo2oKYnJmS6tuzflTnwGQVWlM0CUUIlww9ImvamWddkMyGL+bPXMHnknaEnpHEnkS
         cy62iyQba7K1/DdLjsv6pEnYoOm5jPRtXPd/oFBMGVXJIDgjC247AfAwvv//e+u+cCuv
         uUZRQeeEqeDrzByiCqu/oBNgcVZuCUnKY7P0MSC3TXrDzdgTUkMbppVjzdK5s2Ol4Up5
         8pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gf9qLeHaNKr5s8WfcRc+935K4g2yGhGNonsEd2nFisk=;
        b=Ozp+EenZeF1Dz5n9SmRfM/nMDJJd9Pg7TnxE0tbt9o04tM+iiC1GEgtfwv3oUrVKsM
         pTG+R9glqOgBh97MPh2vtSYWlURM4d16AVX25wkVDYIn4ZeJqihzgyavW5gl3FFTnvZl
         WiKpIbYhl/hRflJUL/jDlPA+OOf57SLFNfx/2Q3OH/vkYjE5000yaGrNeTlsNh+nwQm1
         VAUP8KaNLH85iH3DArdYC3PwMqYNgNuYmGRuv5Ir2yaL+JtuiwbATKgPbgGQFYV5jmly
         nFqy+gCR1jDMnEiiwBF4hxiB4zRgYyv8Svw2C+tOKF4NFXyD4Pcvn6ZcpWVhar2qCroY
         /UgQ==
X-Gm-Message-State: AOAM531t8Xq+T6PANK/yDFoma1lwfJuKmHFLmsAWmLf2BTCyMWK2+By6
        6nfaF+7jzaUR4zm3fwGA/Xnc579+Nbn6vZuyqek=
X-Google-Smtp-Source: ABdhPJwOIYKEymtd/DjFFYyCWszrKyRj42KVhP3rPJ4XovrJubcr1Sk2P5bqVqdtu7ElqEv4NcilS3EPFMRnoAwk9UA=
X-Received: by 2002:a9d:7ccf:: with SMTP id r15mr3159560otn.177.1598046566321;
 Fri, 21 Aug 2020 14:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
 <pull.707.v3.git.1598043976.gitgitgadget@gmail.com> <659b9835dcd0b38ac3972eb19c08c3bf26dccc80.1598043976.git.gitgitgadget@gmail.com>
 <CAPig+cSxjRoBE9FNqBW_xSkct6F23HmVSPhta_b4YD+MJERcTA@mail.gmail.com>
In-Reply-To: <CAPig+cSxjRoBE9FNqBW_xSkct6F23HmVSPhta_b4YD+MJERcTA@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 21 Aug 2020 21:49:14 +0530
Message-ID: <CA+CkUQ-2sCguVx2SVJhEZj0WJefxFDt28HD=R5WD_wk25sZV0A@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ref-filter: 'contents:trailers' show error if `:`
 is missing
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, Aug 22, 2020 at 2:43 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Aug 21, 2020 at 5:06 PM Hariom Verma via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The 'contents' atom does not show any error if used with 'trailers'
> > atom and colon is missing before trailers arguments.
> >
> > e.g %(contents:trailersonly) works, while it shouldn't.
> >
> > It is definitely not an expected behavior.
> >
> > Let's fix this bug.
> >
> > Acked-by: Eric Sunshine <sunshine@sunshineco.com>
>
> I didn't "ack" this patch. If you think some sort of attribution with
> my name is warranted, then a "Helped-by:" would be more appropriate.

Sorry about that. Fixing in the next version.

> > Signed-off-by: Hariom Verma <hariom18599@gmail.com>
> > ---
> > diff --git a/ref-filter.c b/ref-filter.c
> > @@ -345,9 +345,11 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
> > -       else if (skip_prefix(arg, "trailers", &arg)) {
> > -               skip_prefix(arg, ":", &arg);
> > -               if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
> > +       else if (!strcmp(arg, "trailers")) {
> > +               if (trailers_atom_parser(format, atom, NULL, err))
> > +                       return -1;
> > +       } else if (skip_prefix(arg, "trailers:", &arg)) {
> > +               if (trailers_atom_parser(format, atom, arg, err))
> >                         return -1;
>
> This looks better and easier to reason about (but I may be biased in
> thinking so).

Thanks for the review.

> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > @@ -823,6 +823,14 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
> > +test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '
>
> This still needs a s/semicolon/colon/ (mentioned in my previous review).

Sorry, I missed that too.

Thanks,
Hariom
