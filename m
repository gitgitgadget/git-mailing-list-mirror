Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F46C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DD764DFF
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 16:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhBIQ5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 11:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhBIQ5f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 11:57:35 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C97C06174A
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 08:56:54 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id r21so9581056otk.13
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIplPIKHkogXZ1pKFQ8s4Uj2PbyryE8ueI46lCTvWz0=;
        b=YeEv135PKgnsbCRbBOgBIA3slFBViucaadVLU7xWzSv+KF3Oe6ZSGELkhkq07rrF8W
         pNh4NjDc0kumqRMeGLMH9D1/4+qSMdt5rO+JSxCaOg6yk9Q+iwNTsKbjJ0fiv6mqxorb
         453x1nKfhEz+ZefCbIv+eBJ2qAWqaMzGk2OszJ+4o3qXeFxqhBeDCx1sSpGd3xxNA04T
         0tcfiw/MQD+6df7cgRUyWAHTnHyh8KFxHV6szykcpYerhpGiJ02P/W847GzXQl8onVIv
         1jAcrYIM2GFQpX3PnvBeQXkez2rV1lBgJJJWbL+CsihmCrSrBLCg0/I/ZPIR0mUm3v1U
         JcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIplPIKHkogXZ1pKFQ8s4Uj2PbyryE8ueI46lCTvWz0=;
        b=Qi1+7FAkijoQbKUk7xTAhYydrt8z028EGYyx9oG5a1CmBu6Z4LwDPj1t9etWqdgjcw
         Ou1POjzyDrvHngRcUWAM5Goc+PDzWyNFrY1IxcQ/wYPD5c9z9Eie4jZK8CdOE5wc4UlC
         SilUckOf8DR6K1maboq3JrG7Xvo8XTX6LmI3hdghM8UOI8EoAECVlSgBacUSFLRy+Cfc
         jh+iLSdXkypT+OJiMTfxN1ROQvb2thfaC0+xLnrTXiejGuar3OIK0f+1sRtkkoXD9frK
         bproE5+7OL1JcePFIMEYDuqhpI9zHZrgDojAePvLPbuDyUqNk/UkkbBuxLZyBtJvjKpe
         6Vvg==
X-Gm-Message-State: AOAM533mLbqM3tWfwmYcAMBUtgEnm/6YKSQZozzTBj9DMVoJGjx1XSUW
        ig1Hwru38ycMveYEJp2WhzsO881SEG6LTwagftQ=
X-Google-Smtp-Source: ABdhPJykfgN/XH5Ghh8xXuiWCloG2nXvWvd5+EzSe/ggythY44wO1HTeE+mnbSyE2Tzy/XIE2aSsy4WlieA/ECZo8dc=
X-Received: by 2002:a05:6830:1e3b:: with SMTP id t27mr14285846otr.316.1612889813421;
 Tue, 09 Feb 2021 08:56:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com> <381a45d239bb52a70373c385d8978005c9cb4800.1612870326.git.gitgitgadget@gmail.com>
 <dfbffe97-51de-9e8b-37a4-417909358323@gmail.com>
In-Reply-To: <dfbffe97-51de-9e8b-37a4-417909358323@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Feb 2021 08:56:42 -0800
Message-ID: <CABPp-BEsuOiUyvbkwPC384eho8pgSWuRdcvw9t5gkXhf+_j-3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] diffcore-rename: compute basenames of all source
 and dest candidates
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Feb 9, 2021 at 5:17 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/9/2021 6:32 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > We want to make use of unique basenames to help inform rename detection,
> > so that more likely pairings can be checked first.  (src/moduleA/foo.txt
> > and source/module/A/foo.txt are likely related if there are no other
> > 'foo.txt' files among the deleted and added files.)  Add a new function,
> > not yet used, which creates a map of the unique basenames within
> > rename_src and another within rename_dst, together with the indices
> > within rename_src/rename_dst where those basenames show up.  Non-unique
> > basenames still show up in the map, but have an invalid index (-1).
> >
> > This function was inspired by the fact that in real world repositories,
> > most renames often do not involve a basename change.  Here are some
> > sample repositories and the percentage of their historical renames (as of
> > early 2020) that did not involve a basename change:
>
> I found this difficult to parse. Perhaps instead
>
>   "the percentage of their renames that preserved basenames".

Ooh, I like it; happy to make that change.

> We might also need something stronger, though: which percentage of renames
> preserved the basename but also had no other copy of that basename in the
> scope of all add/deletes?

I don't think it's useful to try to prove that this idea can save time
or how much time we can save before we try it; I think the only
purpose of these numbers should be to motivate the idea behind why it
was worth trying.  If we attempt to prove how much we'll save apriori,
then what you have is also too weak.  We would need "percentage of
total adds/deletes that are renames that preserved the basename but
also had no other copy of that basename in the scope of all
add/deletes".  But that is also wrong, actually; we need "for any
given two commits that we are likely to diff, what is the average
percentage of total adds/deletes between them that are renames that
preserved the basename but also had no other copy of that basename in
the scope of all add/deletes".  In particular, my script did not look
at the "any two given likely-to-be-diffed commits" viewpoint, I simply
added the number of renames within individual commits that preserved
renames, and divided by the total number of renames in individual
commits.  But even if we could calculate the "any two given
likely-to-be-diffed commits" viewpoint in some sane manner, it'd still
be misleading.  The next series is going to change the "no other copy
of that basename in the scope of all adds/deletes" caveat, by adding a
way to match up _some_ of those files (when it can find a way to
compare any given file to exactly one of the other files with the same
basename).  And even if you consider all the above and calculated it
in order to try to show how much could be saved, you might need to
start worrying about details like the fact that the first comparison
between files in diffcore-rename.c is _much_ more expensive than
subsequent comparisons (due to the fact that the spanhash is cached).

Trying to account for all these details and describe them fully is
completely beside the point, though; I didn't bother to check any of
this before implementing the algorithm -- I just looked up these very
rough numbers and felt they provided sufficient motivation that there
was an optimization worth trying.

> Is this reproducible from a shell command that could be documented here?

No, trying to parse log output with full handling of proper quoting in
the case of filenames with funny characters is too complex to attempt
in shell.  I was surprised by how long it turned out to be in python.
(And I dread attempting to calculate "something stronger" in any
accurate way given how involved just this rough calculation was.  That
idea seems harder to me than actually implementing this series.)

If you're curious, though, and don't care about
quickly-hacked-together-script-not-designed-for-reuse:
https://github.com/newren/git/blob/ort/rebase-testcase/count-renames.py

> > +MAYBE_UNUSED
> > +static int find_basename_matches(struct diff_options *options,
> > +                              int minimum_score,
> > +                              int num_src)
> > +{
> > +     int i;
> > +     struct strintmap sources;
> > +     struct strintmap dests;
> > +
> > +     /* Create maps of basename -> fullname(s) for sources and dests */
> > +     strintmap_init_with_options(&sources, -1, NULL, 0);
> > +     strintmap_init_with_options(&dests, -1, NULL, 0);
>
> Initially, I was wondering why we need the map for each side, but we will need
> to enforce uniqueness in each set, so OK.
>
>> > +     for (i = 0; i < num_src; ++i) {
> > +             char *filename = rename_src[i].p->one->path;
> > +             char *base;
> > +
> > +             /* exact renames removed in remove_unneeded_paths_from_src() */
> > +             assert(!rename_src[i].p->one->rename_used);
> > +
> > +             base = strrchr(filename, '/');
> > +             base = (base ? base+1 : filename);
>
> nit: "base + 1"

Will fix.

> Also, this is used here and below. Perhaps it's worth pulling out as a
> helper? I see similar code being duplicated in these existing spots:
>
> * diff-no-index.c:append_basename()
> * help.c:append_similar_ref()
> * packfile.c:pack_basename()
> * replace-object.c:register_replace_ref()
> * setup.c:read_gitfile_gently()
> * builtin/rebase.c:cmd_rebase()
> * builtin/stash.c:do_create_stash()
> * builtin/worktree.c:add_worktree()
> * contrib/credential/gnome-keyring/git-credential-gnome-keyring.c:usage()
> * contrib/credential/libsecret/git-credential-libsecret.c:usage()
> * trace2/tr2_dst.c:tr2_dst_try_auto_path()

Honestly asking: would anyone ever search for such a two-line helper
function?  I wouldn't have even thought to look, since it seems so
simple.

However, my real concern here is that this type of change would risk
introducing conflicts with unrelated series.  This series is the
second in what will be a 9-series deep dependency chain of
optimizations[1], and the later series are going to be longer than
these first two were (the latter ones are 6-11 patches each).  We've
already discussed previously whether we possibly want to hold the
first couple optimization series out of the upcoming git-2.31 release
in order to keep the optimizations all together, but that might
increase the risk of conflicts with unrelated patches if we try a
bigger tree refactor like this.  (Junio never commented on that,
though.)  It might be better to keep the series touching only
merge-ort.c & diffcore-rename.c, and then do cleanups like the one you
suggest here after the whole series.

That said, it's not a difficult initial change, so I'm mostly
expressing this concern out of making things harder for Junio.  It'd
be best to get his opinion -- Junio, your thoughts?

[1] https://github.com/gitgitgadget/git/pulls?q=is%3Apr+author%3Anewren+Optimization+batch

> There are other places that use strchr(_, '/') but they seem to be related
> to peeling basenames off of paths and using the leading portion of the path.
>
> > +             /* Record index within rename_src (i) if basename is unique */
> > +             if (strintmap_contains(&sources, base))
> > +                     strintmap_set(&sources, base, -1);
> > +             else
> > +                     strintmap_set(&sources, base, i);
> > +     }
> > +     for (i = 0; i < rename_dst_nr; ++i) {
> > +             char *filename = rename_dst[i].p->two->path;
> > +             char *base;
> > +
> > +             if (rename_dst[i].is_rename)
> > +                     continue; /* involved in exact match already. */
> > +
> > +             base = strrchr(filename, '/');
> > +             base = (base ? base+1 : filename);
> > +
> > +             /* Record index within rename_dst (i) if basename is unique */
> > +             if (strintmap_contains(&dests, base))
> > +                     strintmap_set(&dests, base, -1);
> > +             else
> > +                     strintmap_set(&dests, base, i);
> > +     }
> > +
> > +     /* TODO: Make use of basenames source and destination basenames */
> > +
> > +     strintmap_clear(&sources);
> > +     strintmap_clear(&dests);
> > +
> > +     return 0;
> > +}
>
> Thanks,
> -Stolee

Thanks for the review!
