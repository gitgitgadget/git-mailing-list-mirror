Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C8C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 19:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350847AbiC3UB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346894AbiC3UBW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 16:01:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485762251A
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:59:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j15so43663360eje.9
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6j1gJvyTJbqftoCcOP48zqzDxKedZIRK/4+RsBV5F0=;
        b=bx5jnHyZMvlK0FSEVdsRhXI7ORGYNF2yB2x1c4ZQ2USGFCxv8bctzLuiqHNycwuyxa
         uZTYn6XjxT/yfJLur3e5f/o5xlCj/b5ackG+T9TJVIKrj9zCTfbxKFRnxB4zJnHMLYPB
         CROVWBltInGnlunKQ3sQbUkIxKTdIvfmh5Y0WLYaZCM2/3i2Fevbnh4wB+LD4YT9ABZ3
         eYVH6zzTh8xLJ3sKLBwY5lJqrTjtd0zAtydbZYVv6jYvifX1wj8Q9VfMpwkCpfAyqWCu
         sEcfD4h5XdlXLVrTY5dpUvwEOVBGy5HihMfBCXU1FLnJ2Rgshk9HuBjbmytN1h36nJRb
         +OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6j1gJvyTJbqftoCcOP48zqzDxKedZIRK/4+RsBV5F0=;
        b=PThta7L5vZDCQHBk2JEdHg1AoLu3WMmOB9x/Ic28FuNKxkWBvyPzum+mJP9QgY40fE
         lTWkhYvrKLppPhDzWiUAP5sdHSEcbv/btFovrcdMs3tmqLPvziNp4XD0gKsGBjr2EdsF
         pRC2r+4izTTkCkvZGJFzDAEV+6K1VQ2M1d4IiVmUIsX5vpSa0o57wYzqohoIu2W654Bn
         gV1qfU8OmBff1Evd2TjNYxC4QrDuwTuh52x8NfGYUsMJmrWOY2J9VJqeP5QfxtM1WgqK
         Axrqx1C5biaxKzv8xWcvimzbM4e3leqe/ZZ74MO5ska7Aj4NkgYcO7LTYOpKe+YJGZPj
         1STA==
X-Gm-Message-State: AOAM531KeRvhWHn3HRp19w+pOkeIWPwc3K4FFDkAHM0QcFFPPBw9gbtN
        ig1BxRKErbOcUO8PBg41TbM4jxcIhu5zYR+Y5TEhjA==
X-Google-Smtp-Source: ABdhPJzZoemJFBd0zKywsK1vwy6ig0wGu354UW5ef8QB18CXaEdni/TpNbFHRdek2quFSWiR5HYCHDcWh20zTH4PNX8=
X-Received: by 2002:a17:907:62a9:b0:6da:7953:4df0 with SMTP id
 nd41-20020a17090762a900b006da79534df0mr1379867ejc.316.1648670374682; Wed, 30
 Mar 2022 12:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.985.v4.git.1645974782256.gitgitgadget@gmail.com>
 <pull.985.v5.git.1648553134.gitgitgadget@gmail.com> <f60d2c6e36c3218f9b19d7ce62a090d7d6e0e7f6.1648553134.git.gitgitgadget@gmail.com>
 <xmqqsfr0u01k.fsf@gitster.g>
In-Reply-To: <xmqqsfr0u01k.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 30 Mar 2022 21:59:23 +0200
Message-ID: <CAPMMpog4AcDT_TpPxBaOUfT__gSLufF-EBr=c6__2W4NhhsyVw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] untracked-cache: support '--untracked-files=all'
 if configured
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 the

On Tue, Mar 29, 2022 at 7:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Tao Klerks <tao@klerks.biz>
> >
> > Untracked cache was originally designed to only work with
> > '--untracked-files=normal', but this causes performance issues for UI
> > tooling that wants to see "all" on a frequent basis. On the other hand,
> > the conditions that prevented applicability to the "all" mode no
> > longer seem to apply.
>
> There is a slight leap in logic flow before ", but this causes" that
> forces readers read the above twice and guess what is missing.  I am
> guessing that
>
>     ... was designed to only work with "--untracked-files=normal",
>     and is bypassed when "--untracked-files=all" request, but this
>     causes ...
>
> is what you meant to say.

Yep, will fix.

>
> The claim in the last sentence "... no longer seem to apply" is
> thrown at the readers without much rationale.  Either justify it
> more solidly or discard the claim?
>

I can add references to previous conversation threads around the
topic, and add the word "experimentally".

> > The disqualification of untracked cache has a particularly significant
> > impact on Windows with the defaulted fscache, where the introduction
> > of fsmonitor can make the first and costly directory-iteration happen
> > in untracked file detection, single-threaded, rather than in
> > preload-index on multiple threads. Improving the performance of a
> > "normal" 'git status' run with fsmonitor can make
> > 'git status --untracked-files=all' perform much worse.
>
> The last sentence is a bit hard to parse and very hard to reason
> about.  Do you mean to say "--untracked-files=all is slower when the
> untracked cache is in use, so the performance of 'git status' may be
> improved for '--untracked-files=normal' when the untracked cache is
> used, it hurts when 'git status --untracked-files=all' is run"?

Something like that. The case where untracked cache bypassing (or
disabling) has a huge impact is on windows, and involves fscache and
fsmonitor:
* Untracked cache saves some work under qualifying conditions
* If qualifying conditions are not met (eg when -uall), we do the work
anyway as though untracked cache were disabled.
* fscache optimises directory-iteration on windows, with an N-thread
preload strategy. This is enabled by default, and improves windows
"git status" performance transparently from "abominably slow" to just
"slow".
* fsmonitor, when combined with untracked cache, eliminates recursive
directory-iteration in favor of using a persistent in-memory model of
what's changed on disk (to compare to the index and untracked cache)
* When fsmonitor is enabled and used, the fscache preload strategy is
(obviously) disabled
* When fsmonitor is enabled and untracked cache is disabled or
bypassed, the otherwise-ubiquitous "fscache preload" does not happen,
and the untracked file search (directory iteration) takes... forever.

In other words: In windows, where fscache behavior is critical for
large repos and defaulted-on, when fsmonitor is also enabled which
generally further improves things but disqualifies fscache preload,
the bypassing of untracked cache causes a huge performance impact. A
"-uall" run can take a minute, where a "-unormal" run takes only a
second, because the enumeration of untracked files without using the
untracked cache data means a full directory iteration, not optimized
by fscache. On the other hand, removing fsmonitor and untracked cache
altogether, and leaving just the fscache optimization to do its job
consistently, results in consistent middle-of-the-road performance in
the order of 10 seconds in this example.

Enabling fsmonitor in this situation causes -uall to perform
pathologically badly, because of untracked cache bypassing
(interacting with the fscache-preload-bypassing of fsmonitor).
However, the benefits of dropping status time from 10 seconds to 1
second make fsmonitor very attractive. On the other hand, the
pathological performance with -uall is a problem if you use GUIs that
*require* -uall. Therefore, fixing untracked cache to be compatible
with -uall is critical to large repos on windows where the ideal
experience would be fscache working, fsmonitor working, untracked
cache working, and GUIs able to use -uall without the user waiting a
minute or more and sometimes timing out.

This problem sounds like an edge-case when I describe the chain of
interactions, but is actually very common among large-repo windows
users. Windows users are typically GUI users. GUIs typically use
-uall, as git's default "hide contents of untracked folders" behavior
is obviously limiting.

This patch doesn't actually change anything I've described by default
- but it makes it *possible* to get good/consistent performance with
-uall (with fscache, with fsmonitor, with untracked cache), *if* you
configure status.showuntrackedfiles=all.

Now, coming back to the paragraph in question; maybe, instead of
trying to summarize this windows-fscache-fsmonitor-untrackedcache
interaction, I should be a little more vague. Would this work?

--
When 'git status' runs without using the untracked cache, on a large
repo, on windows, with fsmonitor, it can run very slowly. This can
make GUIs that need to use "-uall" (and therefore currently bypass
untracked cache) unusable when fsmonitor is enabled, on such large
repos.
--


> Let me follow what actually happens in the patch aloud.
>
[...]
> This _guesses_ the user preference from the configuration.
>

Yes - the proposal, in this patch, is that the untracked cache
usability/compatibility be aligned with the configuration. We are
adding an extra meaning to the "status.showuntrackedfiles"
configuration, such that it not only indicates what you want to have
happen when you don't specify "-u" to git status, but it *also*
indicates what kind of status output the untracked cache should be
targeting/supporting.

> > +static void new_untracked_cache(struct index_state *istate, int flags)
> >  {
> >       struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
> >       strbuf_init(&uc->ident, 100);
> >       uc->exclude_per_dir = ".gitignore";
> > -     /* should be the same flags used by git-status */
> > -     uc->dir_flags = DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
> > +     uc->dir_flags = flags >= 0 ? flags : new_untracked_cache_flags(istate);
>
> We use unsigned for the flag word unless there is a reason not to,
> but this function wants to use top-bit as a signal to "guess from
> config".  The caller either dictates what bits to set, or we guess.
>
> And the created uc records the flags.
>

Yep - although the word "guess" may be slightly misleading here. The
proposed semantics are such that if the existing untracked cache flags
are inconsistent with the config, we *discard* the
no-longer-consistent-with-config untracked cache; so it's not so much
a guess as a mandate.

> > @@ -2762,11 +2782,11 @@ static void new_untracked_cache(struct index_state *istate)
> >  void add_untracked_cache(struct index_state *istate)
> >  {
> >       if (!istate->untracked) {
> > -             new_untracked_cache(istate);
> > +             new_untracked_cache(istate, -1);
>
> We are newly creating, so "-1" (guess from config) may be the most
> appropriate (unless the caller of add_untracked_cache() already
> knows what operation it is using for, that is).
>
> >       } else {
> >               if (!ident_in_untracked(istate->untracked)) {
>
> Found an existing one but need to recreate.
>
> >                       free_untracked_cache(istate->untracked);
> > -                     new_untracked_cache(istate);
> > +                     new_untracked_cache(istate, -1);
>
> In this case, is it likely to give us a better guess to read the
> configuration, or copy from the existing untracked file?  My gut
> feeling says it would be the latter, and if that is correct, then
> we might want
>
> +                       int old_flags = istate->untracked->dir_flags;
>                         free_untracked_cache(istate->untracked);
> -                       new_untracked_cache(istate);
> +                       new_untracked_cache(istate, old_flags);
>
> instead?  I dunno.
>

As I noted above, we later consider that an untracked cache with flags
that are inconsistent with the current config is an invalid untracked
cache, and discard it; so setting the flags based on config is the
right thing (the only useful thing) to do.


> > @@ -2781,9 +2801,9 @@ void remove_untracked_cache(struct index_state *istate)
> >  }
> >
> >  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
> > -                                                   int base_len,
> > -                                                   const struct pathspec *pathspec,
> > -                                                   struct index_state *istate)
> > +                                                         int base_len,
> > +                                                         const struct pathspec *pathspec,
> > +                                                         struct index_state *istate)
> >  {
> >       struct untracked_cache_dir *root;
> >       static int untracked_cache_disabled = -1;
>
> Is this just re-indenting?  Not very welcome, but OK.
>

Will fix; I think there was a previous version in which these lines
actually changed.

> > @@ -2814,17 +2834,9 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >       if (base_len || (pathspec && pathspec->nr))
> >               return NULL;
> >
> > -     /* Different set of flags may produce different results */
> > -     if (dir->flags != dir->untracked->dir_flags ||
> > -         /*
> > -          * See treat_directory(), case index_nonexistent. Without
> > -          * this flag, we may need to also cache .git file content
> > -          * for the resolve_gitlink_ref() call, which we don't.
> > -          */
> > -         !(dir->flags & DIR_SHOW_OTHER_DIRECTORIES) ||
> > -         /* We don't support collecting ignore files */
> > -         (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> > -                        DIR_COLLECT_IGNORED)))
> > +     /* We don't support collecting ignore files */
> > +     if (dir->flags & (DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_TOO |
> > +                     DIR_COLLECT_IGNORED))
> >               return NULL;
> >
> >       /*
> > @@ -2847,6 +2859,41 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
> >               return NULL;
> >       }
> >
> > +     /*
> > +      * We don't support using or preparing the untracked cache if
> > +      * the current effective flags don't match the configured
> > +      * flags.
> > +      */
>
> Is that what we want?  What happens when your user does this:
>
>     - set showuntrackedfiles to "normal"
>     - generate the untracked cache
>     - set showuntrackedfiles to "all"
>
> And now the user wants to make a request that wants to see flags
> that are suitable for "normal".
>
> The best case would be for the untracked cache to know what flags
> were in use when it was generated, so that in the above sequence,
> even though the current value of configuration variable and the
> current request from the command line contradict each other, we
> can notice that the untracked cache data is suitable for the current
> request and the right thing happens.
>
> > +     if (dir->flags != new_untracked_cache_flags(istate))
> > +             return NULL;
>
> But this only pays attention to what is in the configuration?  It
> seems to me that it is being too pessimistic, but perhaps it is
> necessary for correctness somehow?

The logic in the current patch is:
* If the configuration doesn't match the request, ignore untracked
cache completely (exit the UC logic)
* If the configuration doesn't match the current untracked cache data,
discard the existing untracked cache data (and later recreate it if
everything else works out)

I think your proposal is something like:
* If the current untracked cache data doesn't match the request
** If the current untracked cache data doesn't match the
configuration, then discard the existing untracked cache (and later
recreate it if everything else works out)
** Otherwise, ignore untracked cache completely (exit the UC logic)
* (otherwise, if current untracked cache data *does* match the
request, assume it's good enough to keep using for now - this is the
new behavior)

I find the latter slightly harder to understand and explain, but I'm
reasonably certain it addresses the case you identified above without
compromising correctness in any other cases - it can only have a
positive impact on performance. I'll have a go at making that change
today.
