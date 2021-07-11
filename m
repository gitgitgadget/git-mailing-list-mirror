Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CABC07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 20:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E076101C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 20:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhGKUDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 16:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKUDU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 16:03:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84600C0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 13:00:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q16so1596365lfa.5
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IRz9MbUidegjo92e9u78qtsWsjst0W+EjDoXaoOehP8=;
        b=KuaitNfunCyzD0+UlcQeAiw7trMTaFJZ0Un7LxnyLTZyoelDhOawTw1Kot7iOkymcu
         yr9Xl2gDbaw9Ub0Lct7ImdI91OwijTOaHpVeaF2ZXAqsLD9PwZe422N9OWewsEda24od
         b41yz4zT46QPle/vgNRxLsyO35BhOYXAZ/UwGIkm+DNTLnWN2QAPsFzUjuXVLQsw9JV6
         zHEK4ZyDGbJe+62YZEn4lR9pgNioo4EedkJ3i/NMNap1e4/jvprTEmh+FqzaVBpue2pH
         McUjYVabREleqoWPzOYTpQ//dMrZhcvJgRXc46fbu4oExvHXSEsrHZhyT0C5iwfZLJIl
         Xp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IRz9MbUidegjo92e9u78qtsWsjst0W+EjDoXaoOehP8=;
        b=O2VSKrX9lX681XKRyOK/uYlYH+djKDYTtXlgHVeWiTfxSS2k30UhS8AdbP0OoJw6b7
         6gYDDwRNnXogr8W8bBHmNHz1qKn8PvlqRKJixDEqogZVI71FrL1LObBaV6D9aCCZOfKP
         jL16QpIfdkfJhccc3k7qtqwmXGNvXwgRLYr/UucG9LocZUtVzA5+BrB4WvRzZtHnAhbX
         crK34MYXLwu729JCb6RwlDq34Ku75zvNT12LkjFT29s+BssAdDwoAvu/9wXfd1df1ZAw
         XK7bOpwSg634nMP6Zo5aEbhpmblhKiVD5Uo89SiB8XZimkQWPLKsYXJtNdjRjO1qoFrB
         li0w==
X-Gm-Message-State: AOAM531OEP5EFKhPE9UIeLPy53uk0Bnteu0SK89cGzfGQNBWf2Hy57hL
        0+nW5th0AmzsQ25L/u+xjVdKsE76V7XOGdONYQ4=
X-Google-Smtp-Source: ABdhPJz4JhwVb6pHGZ7TFAqT2u8FUyMlD3/JwJuB4GBBWbIk0oujVZWYSq8YfQyzQADY2Jgzy2qP2ZUpgEreD9PO1aM=
X-Received: by 2002:a05:6512:3f9d:: with SMTP id x29mr35914369lfa.221.1626033630930;
 Sun, 11 Jul 2021 13:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com> <60eb259e1a75d_974bf20895@natae.notmuch>
In-Reply-To: <60eb259e1a75d_974bf20895@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 11 Jul 2021 14:00:19 -0600
Message-ID: <CAMMLpeRwpxEe5qJumwXa5hyjeUBrTRDU3-1OSHDNc=UiNqN48w@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 11, 2021 at 11:08 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Alex Henrie wrote:
> > The warning about pulling without specifying how to reconcile divergent
> > branches says that after setting pull.rebase to true, --ff-only can
> > still be passed on the command line to require a fast-forward. Make that
> > actually work.
>
> I don't know where that is being said, but it's wrong: --ff-only is
> meant for merge only.
>
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -1046,9 +1046,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >
> >       can_ff = get_can_ff(&orig_head, &merge_heads.oid[0]);
> >
> > -     if (rebase_unspecified && !opt_ff && !can_ff) {
> > -             if (opt_verbosity >= 0)
> > -                     show_advice_pull_non_ff();
> > +     if (!can_ff) {
> > +             if (opt_ff) {
> > +                     if (!strcmp(opt_ff, "--ff-only"))
> > +                             die_ff_impossible();
>
> As I've mentioned multiple times already, this is wrong.
>
> The advice clearly says:
>
>   You can also pass --rebase, --no-rebase, or --ff-only on the command
>   line to override the configured default per invocation.
>
> With your patch now this is even less true:
>
>   git -c pull.ff=only pull --rebase

I think it's an improvement over the current situation. --no-rebase
does not override pull.ff=only, so it makes sense that --rebase does
not override pull.ff=only either. Besides, it's generally better to
abort instead of rewriting history if it's not perfectly clear that
the user meant to rewrite the history.

-Alex
