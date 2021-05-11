Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E09AC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1803161221
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhEKRZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhEKRZH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:25:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADC3C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:24:00 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x15so5948378oic.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XQ9pKsCSo2dst1m0vkuSVFT6Gghshsydm00um5GN3c=;
        b=duF4aG+9l4RkwSM/td7PfgWkip6nqiX7zIAkUvu4pGuVH8Qn1ll2QHMSMoqhsNy8J1
         Nc/erZZDkdvM8PWYodc2OJ6e9lkeYfVf4D0MrcViP84kQnfVyp6BUeCViXrgzmw327v8
         2Ip5pSu2SGE/GSvZk4htCDE2BFifaXIAJiIpb4ih723V4SGLMpOHnMex/iQR1/h0vQAu
         SrN7H4dMkjGxFwk8TdI/m2wNDncjT0Gl5aLzOk3BVrc57upBPydIMDX5XelUr6WmlRdh
         e0RxBZaUemz8dk6DTzrdpOv34tmisepx4Q06UUhI7tslPac9Pd3EretlqHj6TATsFmqV
         IgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XQ9pKsCSo2dst1m0vkuSVFT6Gghshsydm00um5GN3c=;
        b=OUpfNuuSAXdBcCmusjgCthx8XCnBKGAOtDcSd5QwbtkyeBTWugyLCD7J+/l7zL87Gl
         S6IRffOJes176UPoMHTTJHd3kmBdW1YbWVD2+e7fjwu/bZ4pzKDgx0spbCpKH1E1YL+I
         W0lDVAYoQk5bR69RmgV4AKtchJ3BWi7oauJqrXAcurjVz3T8kh1gcKRPCPVyfjf6v0H0
         khU8oGhq3tkImnpGKtstJM2SMF5iIn/oashYQaXs9a3AAHrYXmsFok1G6EysblXc8vGv
         OSnbl9lFaUJetlzz9vfb/ymiNO4xlPSUPMfXduJhRqn5qsjV67cmsAE44KyOR+IpvbHR
         4LAQ==
X-Gm-Message-State: AOAM530H/vhRxXGeeKFdXIRGyhB2s4Zc0KVU6Y9bU1g3U1Hkx7KUYjSJ
        B3ao8PDSNxYYlPRzAypQdc55XymmcqiEoPHiLbK01ZzWx88=
X-Google-Smtp-Source: ABdhPJz4KbudDGGKoSLOH881//dCITbLElGiv7fsO2ll6BjcGDuvIeY7bAvRU53Bxo/nsN+Bt0O+l9rfjDiGxa/RyKI=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr4280549oiw.167.1620753839902;
 Tue, 11 May 2021 10:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
 <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com> <9f1c0d78d739cc1da8517eea92e81a7bd162578f.1620503945.git.gitgitgadget@gmail.com>
 <xmqqk0o7ry5c.fsf@gitster.g>
In-Reply-To: <xmqqk0o7ry5c.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 10:23:48 -0700
Message-ID: <CABPp-BFk_VNv7jzDP8Ep0Yk2e_nNg7-EAK1rbpS=9y9oNmi0kg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] [RFC] dir: convert trace calls to trace2 equivalents
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 9, 2021 at 9:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static void trace2_read_directory_statistics(struct dir_struct *dir,
> > +                                          struct repository *repo)
> > +{
> > +     if (!dir->untracked)
> > +             return;
> > +     trace2_data_intmax("read_directory", repo,
> > +                        "node-creation", dir->untracked->dir_created);
> > +     trace2_data_intmax("read_directory", repo,
> > +                        "gitignore-invalidation",
> > +                        dir->untracked->gitignore_invalidated);
> > +     trace2_data_intmax("read_directory", repo,
> > +                        "directory-invalidation",
> > +                        dir->untracked->dir_invalidated);
> > +     trace2_data_intmax("read_directory", repo,
> > +                        "opendir", dir->untracked->dir_opened);
> > +}
> > +
>
> This obviously looks like an equivalent to what happens in the
> original inside the "if (dir->untracked)" block.
>
> And we have a performance_{enter,leave} pair replaced with
> a region_[enter,leave} pair.
>
> > -     trace_performance_enter();
> > +     trace2_region_enter("dir", "read_directory", istate->repo);
> >   ...
> > -     trace_performance_leave("read directory %.*s", len, path);
> > +     trace2_region_leave("dir", "read_directory", istate->repo);
>
> >       if (dir->untracked) {
> >               static int force_untracked_cache = -1;
> > -             static struct trace_key trace_untracked_stats = TRACE_KEY_INIT(UNTRACKED_STATS);
> >
> >               if (force_untracked_cache < 0)
> >                       force_untracked_cache =
> >                               git_env_bool("GIT_FORCE_UNTRACKED_CACHE", 0);
> > -             trace_printf_key(&trace_untracked_stats,
> > -                              "node creation: %u\n"
> > -                              "gitignore invalidation: %u\n"
> > -                              "directory invalidation: %u\n"
> > -                              "opendir: %u\n",
> > -                              dir->untracked->dir_created,
> > -                              dir->untracked->gitignore_invalidated,
> > -                              dir->untracked->dir_invalidated,
> > -                              dir->untracked->dir_opened);
> >               if (force_untracked_cache &&
> >                       dir->untracked == istate->untracked &&
> >                   (dir->untracked->dir_opened ||
>
> Removal of the trace_printf() in the middle made the body of this
> if() statement much less distracting, which is good.
>
> > @@ -2811,6 +2818,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
> >                       FREE_AND_NULL(dir->untracked);
> >               }
> >       }
> > +
> > +     if (trace2_is_enabled())
> > +             trace2_read_directory_statistics(dir, istate->repo);
>
> This slightly changes the semantics in that the original did an
> equivalent emitting from inside the "if (dir->untracked)" block, but
> this call is hoisted outside, and the new helper knows how to be
> silent when untracked thing is not in effect, so the net effect at
> this step is the same.  And if we ever add tracing statics that is
> relevant when !dir->untracked is true, the new code organization is
> easier to work with.
>
> The only curious thing is the guard "if (trace2_is_enabled())";
> correctness-wise, are there bad things going to happen if it is not
> here, or is this a performance hack, or is it more for its
> documentation value (meaning, it would be a bug if we later added
> things that are irrelevant when trace is not enabled to the helper)?

No, there's nothing bad that would happen here.  It was a combination
of a performance hack and documentation in case
trace2_read_directory_statistics() started gaining other code besides
trace2_*() calls, but which code was only relevant when trace2 was
enabled.

Turns out, though, that Jeff's suggestion to also print the path in
the statistics is going to require me creating a temporary strbuf so
that I can get a NUL-terminated string.  We only want to do that when
trace2_is_enabled(), so that will make the introduction of that check
a bit more natural.

> > @@ -57,6 +57,19 @@ iuc () {
> >       return $ret
> >  }
> >
> > +get_relevant_traces() {
>
> Style.  SP on both sides of "()".

Will fix.

>
> > +     # From the GIT_TRACE2_PERF data of the form
> > +     #    $TIME $FILE:$LINE | d0 | main | data | r1 | ? | ? | read_directo | $RELEVANT_STAT
> > +     # extract the $RELEVANT_STAT fields.  We don't care about region_enter
> > +     # or region_leave, or stats for things outside read_directory.
> > +     INPUT_FILE=$1
> > +     OUTPUT_FILE=$2
> > +     grep data.*read_directo $INPUT_FILE \
> > +         | cut -d "|" -f 9 \
> > +         >$OUTPUT_FILE
>
> Style.  Wrapping the line after pipe '|' will allow you to omit the
> backslash.  Also quote the redirection target, i.e. >"$OUTPUT_FILE",
> to help certain vintage of bash.

Will fix.
