Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2DEC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 01:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678D260F58
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 01:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhHCBFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 21:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhHCBFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 21:05:17 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ECCC06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 18:05:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w6so26366885oiv.11
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 18:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KV1RMhKi2zPXblaT4npH2/zE4JhL+tQ9DZ2yUeY9XSY=;
        b=fcpwO5GnECwfAuBLtgdd3A2QmVq42/b2AvuN7otSRPuj7hRaTFDIkgr3FqHO/E6z83
         /CQoShSU4KsYlCRWdtcd6mC0AXk+nSpitoFCAqFMbqZVL+P4CpigwpcTlhkAG9L2u/gL
         jIdDi7D/X6UAMXq796l8FQIoCCf2HAh0UYXIi1VXF3RntR5/aFheD0kPXUmHn5LxnNgi
         OsPVCrWX+JWjDTKpKJbQO1zqyMKMZ6j05D0x7U45RIQbmJwDdYXRy2k2Rs5RzV5WfLfV
         KzkJjmSHQnLSA07qsc/y/pdGODrBs1kzX2FqxRnjV+vy1R4OoNAfiyyDFsNpK3jqcb00
         lrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KV1RMhKi2zPXblaT4npH2/zE4JhL+tQ9DZ2yUeY9XSY=;
        b=hqlzDdGgajRc4cn4JO/9wPVKAOHu1KaQGxD3kzr/eg52FdCFNa/K5OlBkOOXjc8Z4c
         e76rRhqfjzHbwZGMHp/WK2W/MXByUY2tT+ysReLex4XO+921EGk3ANiA99hhj4KePlD3
         s5HQE5mto6r/PCZdTGmJocTzMS/J5RW9pk9ElcibWAuHpw6f6suaECXB76y9FCKJoeL4
         NjFc3yfZfsgbfsseZ/jCOm6Lclq3NnIU/AF/1qzJd9Znsyibyr1c8cfQ4VxFfayYIRPK
         5cPAFW6XNWSVMTElIUPJkg376g2yQ7AoIFOtplJfbn6m/93/a6cBFYVZDDb2ipx1e4Uy
         gLdg==
X-Gm-Message-State: AOAM533ERDVtzEClncBlVKQtAA2eZncJWS4Xwj+k7YkegmeFbEvViuQk
        VWHGJBnvKUbjrZ+Lqfv0AaBBgR8I+u8p9J5rSTc=
X-Google-Smtp-Source: ABdhPJwmSS0n8ZKH2I7ytL5jLejgoK/5uC1cAM0nH0HOVNcYywqnY9Vd8HqvyO6qUM9WXxfm5CwXG3bbFqyeNw5QzqU=
X-Received: by 2002:aca:d644:: with SMTP id n65mr12541781oig.31.1627952705608;
 Mon, 02 Aug 2021 18:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108030030000.55@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2108030030000.55@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 2 Aug 2021 19:04:54 -0600
Message-ID: <CABPp-BHCy-CpiJQ7LVmrRXgZNj3sYAxu0WwJ2JLzvY-qrwDiaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Change default merge backend from recursive to ort
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 2, 2021 at 4:46 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Sun, 1 Aug 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > There are a few reasons to switch the default:
> > [...]
>
> I think it would be really fantastic to change to the new default right
> after v2.33.0.
>
> As to the patch, I only struggled slightly with the changes to
> `sequencer.c`:
>
> > diff --git a/sequencer.c b/sequencer.c
> > index 0bec01cf38e..a98de9a8d15 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -636,7 +636,7 @@ static int do_recursive_merge(struct repository *r,
> >       for (i = 0; i < opts->xopts_nr; i++)
> >               parse_merge_opt(&o, opts->xopts[i]);
> >
> > -     if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> > +     if (!opts->strategy || strcmp(opts->strategy, "recursive")) {
>
> At this stage, we're in `do_recursive_merge()`, and there is only one
> caller, `do_pick_commit()`, and the caller is guarded by the following
> condition:
>
>         else if (!opts->strategy ||
>                  !strcmp(opts->strategy, "recursive") ||
>                  !strcmp(opts->strategy, "ort") ||
>                  command == TODO_REVERT) {
>
> The issue I see is with `git revert` allowing custom merge strategies. I
> _think_ we need a slightly different patch here, something like this:
>
> -       if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> +       if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
>
> >               memset(&result, 0, sizeof(result));
> >               merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
> >                                           &result);
> > @@ -3968,7 +3968,7 @@ static int do_merge(struct repository *r,
> >       o.branch2 = ref_name.buf;
> >       o.buffer_output = 2;
> >
> > -     if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> > +     if (!opts->strategy || strcmp(opts->strategy, "recursive")) {
>
> It took me a while to convince myself that this is correct. At least now I
> _think_ it is correct: `do_merge()` defines:
>
>         const char *strategy = !opts->xopts_nr &&
>                 (!opts->strategy ||
>                  !strcmp(opts->strategy, "recursive") ||
>                  !strcmp(opts->strategy, "ort")) ?
>                 NULL : opts->strategy;
>
> and then hands off to `git merge -s <strategy>` if `strategy` is set,
> _before_ this hunk. Therefore we can be pretty certain that
> `opts->strategy` is either not set, or "ort", or "recursive" at that
> stage.
>
> However, I think we could use the same idea I outlined in the previous
> hunk, to make things more obvious:
>
> -       if (opts->strategy && !strcmp(opts->strategy, "ort")) {
> +       if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
>
> Thank you,
> Dscho
>
> >               /*
> >                * TODO: Should use merge_incore_recursive() and
> >                * merge_switch_to_result(), skipping the call to
> > --
> > gitgitgadget

I'll include both suggestions in my next re-roll.  Thanks for the feedback!
