Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B1AC07E9D
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 03:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C77611C1
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 03:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhGVDBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhGVDBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 23:01:47 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F4C061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 20:42:22 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so4151180otl.0
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lk0ku7Kf3BojkzX+Ikwu/NoJFPV1cqcyEcH1tcFdQ7w=;
        b=oyYhN6SpsjmTaZB0pskbgGRc/1BxEsyweM6shURY9Celuu8JRR7aCAf58KlQoyzH08
         LqonMNu5mJmC+Wys526dhKE+yA5HA3n0VzWBuQTQ2ft5QbCIfaqrn7qa9S3e66rM3jr4
         GJVhTsZxxfJQ2FAfUVP/imEft8LSqYs1OTIxhIlDyR4I88toDmaDjfocwUk0UnczVJPH
         LfHbeH+VQl9BYWSdHvEiL+pXuLHiNcnC/Wgo+98YKMQcajA4xEQB98IaRY8FYBWaIFgY
         1Pp1mxuUOJ/I+l9bF9Iw9LCkLYm+ZvHm6rSn2/RWPdYiUEqGg/cMSY9AHO08q2sCR9HK
         7wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lk0ku7Kf3BojkzX+Ikwu/NoJFPV1cqcyEcH1tcFdQ7w=;
        b=Wnaa8mRdiMgdo9QFiNSfQqF3RxIXLBD0bEuHw6RBDKKOlAsAP1Mugc//VxK+WWsb8d
         LarSuofWwyebEGoaZ0wKrXHGpUXKoOBPIObpqlR5SLuyNl2t59kij2VJf3wUIMJf63rz
         nvqj8s/UKZt03LeNeVt5dXWf5gVb9+yIyDpeSLyKRc0Cy47PLfZ9W04o2peQIBxQYgMd
         Z5LeFVnCb7ycVrYVsEnGDqWYe4Y4Sw5mboCFpCH5RF+0E363oiC5VZLZlaJ/By4yjqHi
         QfxOfGIUxvOd0Ialm82LFHfMlNlmIZFuZUmfTyLCcWlOVamIFIMYLPOtJh74rrSRXHPz
         geRg==
X-Gm-Message-State: AOAM530qZh52wqGOIsEf4ijz9PVziSg3tdcrz0xm6l5hCqnve+iVD92G
        aNUTo198ee2KkUp7ho4e/ZC+fd2PThA4kPNap3w=
X-Google-Smtp-Source: ABdhPJzdntUt2jMbJ+wW9MIsin5G6LqEdQ6ySvHh/j67hwB87Lt6P4bUpMgYVvnwsaeMLAGzl/g/9e4lThtSFSMWVcw=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr27245407oti.316.1626925341850;
 Wed, 21 Jul 2021 20:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
 <pull.1049.v2.git.git.1626831744.gitgitgadget@gmail.com> <1a821d3b1ddf22b62b14d3b573015c3d8c90e2de.1626831744.git.gitgitgadget@gmail.com>
 <xmqqlf5zctey.fsf@gitster.g>
In-Reply-To: <xmqqlf5zctey.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Jul 2021 20:42:09 -0700
Message-ID: <CABPp-BG--c4Q8bFv20382dyQJgAWqZymT+gGD0eR2v0QB2RQxg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] pull: since --ff-only overrides, handle it first
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 1:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > -     if (!can_ff) {
> > -             if (opt_ff) {
> > -                     if (!strcmp(opt_ff, "--ff-only"))
> > -                             die_ff_impossible();
> > -             } else {
> > -                     if (rebase_unspecified && opt_verbosity >= 0)
> > -                             show_advice_pull_non_ff();
> > -             }
> > +     /* ff-only takes precedence over rebase */
> > +     if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
> > +             if (!can_ff)
> > +                     die_ff_impossible();
> > +             opt_rebase = REBASE_FALSE;
> >       }
> > +     /* If no action specified and we can't fast forward, then warn. */
> > +     if (!opt_ff && rebase_unspecified && !can_ff)
> > +             show_advice_pull_non_ff();
>
> This part makes sense, but ...
>
> > @@ -1069,13 +1069,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >                   submodule_touches_in_range(the_repository, &upstream, &curr_head))
> >                       die(_("cannot rebase with locally recorded submodule modifications"));
> >
> > -             if (can_ff) {
> > -                     /* we can fast-forward this without invoking rebase */
> > -                     opt_ff = "--ff-only";
> > -                     ret = run_merge();
> > -             } else {
> > -                     ret = run_rebase(&newbase, &upstream);
> > -             }
> > +             ret = run_rebase(&newbase, &upstream);
>
> ... as I already pointed out, this does not seem to belong to the
> change.
>
> What makes this hunk necessary?
>
> We used to use run_merge() to fast-forward, now we let run_rebase()
> to first "checkout" their tip, which ends up to be a fast-forward in
> the "can_ff" situation.  As a side effect, opt_ff gets contaminated
> with the current code, but that would not affect what happens after
> this part (i.e. call to rebase_submodules()).

Indeed, you are right.  Sorry about that, I'll re-roll with this hunk
removed, and the modifications to t5520 pulled out as well.
