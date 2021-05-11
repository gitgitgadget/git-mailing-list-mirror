Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFDDC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19576162B
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhEKRbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhEKRbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:31:06 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED1EC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:29:59 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id w6-20020a4a9d060000b02901f9175244e7so4356871ooj.9
        for <git@vger.kernel.org>; Tue, 11 May 2021 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=johnYBx7cAkltybGkGcjie3F9tHPe9Oj5RNwwMsdc44=;
        b=Sh+rjw6wYD0m3GTPUGnyfDvNVgiVuXHW2Kq4qVq7Ve7TCYTR0cBsIKbqKE1AHHF1Qu
         OPJR6K10LmEVKr3Xooi52BNm81M0J3iNzy/c6MGM1tfQghBJdHrx3nMqJOY5xIHitADh
         f2AzrIzDVBNTx0EuMFknbBuId9ruEZ4GDPca23xpP3YZj4Uz0IStxKgvafjgzlxPuy3l
         zpBhX8jBpL2LRU4j7JDNeLQKNHxFE1ltDxMiP7W0HacM1RD4rS6knlS8oEV/UYH1kQXB
         7IhJ55mpLG2aFKLDTAKInVkPAOMVwyAKR3mo9WTn02PyXJkr8CQONkW+N/p+tHAOHDER
         +RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=johnYBx7cAkltybGkGcjie3F9tHPe9Oj5RNwwMsdc44=;
        b=oJoPdghd2G8CItderiv0+FD4yfWrM6aKBjpbW8JHcy4ny6fGcXY25k8qPDB+d4JLK3
         H2XcHClCmuhWneklNiwwwjEIc16XzFTGolYYderiL6t4s6oa/utz3I4PzR6MiCxXN1zs
         B6utyHBnoJ/VJeNCW3XiIvij69QxTaSGJKguMwSA1jabUC3wkNGMOZeX7swvQ3i+4Rnw
         SepiPzACJZTbIE/C3HLhBfSmXOQelP+jlf9/ygM6MhykQAtF0fQF8hPbzlRwggIlrUpM
         wpeNCOzw5jVderH2xg32G46pwgvHL70+KSwRJuuUplRhtwmwopdP+mOh+LYWnsOF8zV1
         EY/g==
X-Gm-Message-State: AOAM531MFyHa6QrGkBh9js2DdVsq2yrKsayjarQJFuRZwgFn1mxHU9fn
        2oeEL6vrrYfeA+Do/sPSp6ssYf5A3JJS3g6Q1cM=
X-Google-Smtp-Source: ABdhPJyHTJByhRmyFtL+MPK4jObJneIf5DlwQc+EE01wqDJP4KalHsbgskwpNBOWO/FcGTHdWkQQzjxZ8u4Dhikz748=
X-Received: by 2002:a4a:a58f:: with SMTP id d15mr24173660oom.32.1620754198890;
 Tue, 11 May 2021 10:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
 <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com> <9f1c0d78d739cc1da8517eea92e81a7bd162578f.1620503945.git.gitgitgadget@gmail.com>
 <96679919-f6ea-adcc-b8fc-9eaa0134c876@jeffhostetler.com>
In-Reply-To: <96679919-f6ea-adcc-b8fc-9eaa0134c876@jeffhostetler.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 10:29:47 -0700
Message-ID: <CABPp-BEa0hgrTXWAA0hVAZ3uRhsfLY=jEe17+2X5pQpRKiejMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] [RFC] dir: convert trace calls to trace2 equivalents
To:     Jeff Hostetler <git@jeffhostetler.com>
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

On Tue, May 11, 2021 at 9:17 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 5/8/21 3:58 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >   dir.c                             |  34 ++++--
> >   t/t7063-status-untracked-cache.sh | 193 +++++++++++++++++-------------
> >   t/t7519-status-fsmonitor.sh       |   8 +-
> >   3 files changed, 135 insertions(+), 100 deletions(-)
> >
> > diff --git a/dir.c b/dir.c
> > index 3474e67e8f3c..9f7c8debeab3 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -2760,12 +2760,29 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >       return root;
> >   }
> >
> > +static void trace2_read_directory_statistics(struct dir_struct *dir,
> > +                                          struct repository *repo)
> > +{
> > +     if (!dir->untracked)
> > +             return;
>
> Is there value to also printing the path?
> The existing `trace_performance_leave()` calls were, but
> I'm familiar enough with this code to say if the output
> wasn't always something like ".".

The path will most likely just be "" (i.e. the empty string) for the
toplevel directory, but not always so it may be useful to print it.
I'll add it.

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
> The existing code was quite tangled and I think this helps
> make things more clear.
>
>
> >   int read_directory(struct dir_struct *dir, struct index_state *istate,
> >                  const char *path, int len, const struct pathspec *pathspec)
> >   {
> >       struct untracked_cache_dir *untracked;
> >
> > -     trace_performance_enter();
> > +     trace2_region_enter("dir", "read_directory", istate->repo);
> >
> >       if (has_symlink_leading_path(path, len)) {
> >               trace_performance_leave("read directory %.*s", len, path);
>
> This `trace_performance_leave()` inside the `if` needs to be
> converted too.

Ooh, good catch.  Will fix.

> > @@ -2784,23 +2801,13 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
> >       QSORT(dir->entries, dir->nr, cmp_dir_entry);
> >       QSORT(dir->ignored, dir->ignored_nr, cmp_dir_entry);
> >
> > -     trace_performance_leave("read directory %.*s", len, path);
> > +     trace2_region_leave("dir", "read_directory", istate->repo);
>
> Can we put the call to `trace2_read_directory_statistics()` before
> the above `trace2_region_leave()` call?   Then those stats will
> appear indented between the begin- and end-region events in the output.
>
> That way, the following `if (dir-untracked) {...}` is only
> concerned with the untracked cache and/or freeing that data.

Makes sense, I'll move it.

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
> > @@ -2811,6 +2818,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
> >                       FREE_AND_NULL(dir->untracked);
> >               }
> >       }
> > +
> > +     if (trace2_is_enabled())
> > +             trace2_read_directory_statistics(dir, istate->repo);
>
> Also, I think it'd be ok to move the `trace2_is_enabled()` call
> inside the function.  Since we're also testing `!dir->untracked`
> inside the function.

Actually, I can't do that.  The path passed to this function is not
going to always be (and will often not be) NUL-terminated, but
trace2_data_string() expects a NUL-terminated string.  So, I'm going
to make a temporary strbuf and copy the path into it, but of course I
only want to spend time doing that if trace2_is_enabled().

> The more that I look at the before and after versions, the
> more I think the `trace2_read_directory_statistics()` call
> should be up before the `trace2_region_leave()`.  Here at the
> bottom of the function, we may have already freed `dir->untracked`.
> I'm not familiar enough with this code to know if that is a
> good or bad thing.

Yeah, the statistics really need to be moved earlier, both for the
nesting reasons you point out and because otherwise the statistics
won't print whenever dir->untracked != istate->untracked.  I'll move
them.
