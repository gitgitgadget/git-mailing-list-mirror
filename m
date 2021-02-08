Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80236C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A80964E8C
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhBHWB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhBHWBY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 17:01:24 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4FC061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 14:00:42 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id q4so6016670otm.9
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GD4ChhaF6sfvUBlTGBwgkZYYz1NOkJTAnDXZrCkuYhk=;
        b=ONxJxLT3NqZwT5SYXHUtqPjfPGzBxgcUxjL/MqKYF90o9GdLutY98uAOTVupUzED3b
         tMpIFRep0CZ4XXZI/bZCfaWNY7stoX8EZ3hNXFOdciXMurVIKCRv9fogcmPMNq6vvCrU
         aDKP1um9Ea0HyrLW4rFlzU12hmPitAOt3mR+AKXGJ/xvMyIV7Dc8I4qkUZjtjzMIqIcn
         EAR81pfp6jLaJqXrmrV6JtuMZb5XUNJOMmEmuomTAV5dVMD7LtOxEI1UN+nWFq19oJWy
         JpVTz1GwMJQ9DWn7wefTWL8aGte+d533CQE9DnHlEWAy/Zbc7e7EkRcrGWMP6eKy745H
         QdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GD4ChhaF6sfvUBlTGBwgkZYYz1NOkJTAnDXZrCkuYhk=;
        b=kbujgMZSIK7lXzxEviDkwPjHMzotntc5jzXbg2hJCvK2NrJfg4S4NEkLMhkt2nCQd9
         dyM0tMjZqr4AXqTwzuN1fy+MSoIeDpdvvlHf8b6yvWk5G7Vjy+aUcEWmwyYSdMMu5SpS
         0JJLz3+2YSQbCEpUB7e8iKrfMFmQy53Vdm5BnliamwnWdA+nNKFGF++sptj8jPEkcqUk
         bLOxB6zVbcAB5wrF8Zsa0Hdb350z+g+VqYxfOHdxZ7lhix+1d+ft3KgDkcAzYFVC4cmG
         JkOlBbnVFetnZgH9+oQk/stVPnzUuuN2vMnRP7FV8IF4izCxTx7V2R/PF/vkJ+cHN/Yw
         LJ3A==
X-Gm-Message-State: AOAM532lOLUqMqG70bOrM/JsydLB//bfuv+cztkmbQjvPzkq+76MSz+e
        mDdtr6sMWK2PvAAAAzSMpp1ibi4waX4HrVsfb00=
X-Google-Smtp-Source: ABdhPJzAGexvLegd/4GxRRbccEUUcIDTk1cSnK4/vVAmhm6djn/4BtbSR4zm+p5zyL3dc6lOsEB/8kZoioMhHw2Xk9A=
X-Received: by 2002:a9d:7dd3:: with SMTP id k19mr3532640otn.162.1612821641557;
 Mon, 08 Feb 2021 14:00:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
 <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com> <xmqqsg677j2u.fsf@gitster.c.googlers.com>
 <CABPp-BGAgi+ooq==ZY2tWif0--W4Cruz02GDvxueHe6GjQEAXQ@mail.gmail.com> <xmqq4kim7964.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kim7964.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Feb 2021 14:00:30 -0800
Message-ID: <CABPp-BH_DWEE-3M96e=PPNwDqeYPaax9s1kBDhS8a6GtxsW=Mg@mail.gmail.com>
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection based
 on basenames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Feb 8, 2021 at 9:37 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > idea is still possible.  For example, A.txt could have been compared
> > to source/some-module/A.txt.  And I don't do anything in the final
> > "full matrix" stage to avoid re-comparing those two files again.
> > However, it is worth noting that A.txt will have been compared to at
> > most one other file, not N files.
>
> Sorry, but where does this "at most one other file" come from?  "It
> is rare to remove source/some-other-module/A.txt at the same time
> while the above is happening"?  If so, yes, that sounds like a
> sensible thing.

It comes from the current implementation.  If both src/module1/A.txt
and src/module2/A.txt were removed, then I don't have a unique 'A.txt'
that was deleted.  In such a case, all 'A.txt' files are excluded from
this optimization step -- both sources and destinations.  This
optimization only kicks in for basenames where there was exactly one
of them deleted somewhere, and exactly one of them added somewhere.

One could consider trying to compare all deleted 'A.txt' files with
all added 'A.txt' files.  I tried that, but it interacts badly with
optimization batch 9 and tossed it aside; I will not be submitting
such a method.

Naturally, this "unique basename" limitation presents problems for
file basenames like .gitignore, Makefile, build.gradle, or even
ObjectFactory.java, setup.c, etc. that tend to appear in several
locations throughout the tree.  As of this series, we have to fall
back to the full N x M matrix comparison to detect the renames for
such non-unique basenames.  The next series I am planning on
submitting will do something smarter for those files while still
ensuring that the preliminary step only compares any given file to at
most one other file.

> > 1) The most expensive comparison is the first one,...
>
> Yes. we keep the spanhash table across comparison.
>
> > 2) This would only save us from at most N comparisons in the N x M
> > matrix (since no file in this optimization is compared to more than
> > one other)
>
> True, but doesn't rename_src[] and rename_dst[] entries have the
> original pathname, where you can see A.txt and some-module/A.txt
> share the same filename part cheaply?  Is that more expensive than
> comparing spanhash tables?

For a small enough number of renames, no, it won't be more expensive.
But I don't want to optimize for low numbers of renames; the code is
fast enough for those.  And with a large enough number of renames,
yes, the basename comparisons in aggregate will be more expensive than
the number of spanhash array comparisons you avoid redoing.  The
preliminary step from this optimization at most only did O(N) spanhash
comparisons, because it would only compare any given file to at most
one other file.  (Any file that didn't have a matching basename on the
other side, or wasn't a unique basename, wouldn't have been compared
to anything.)  So, at most, we save O(N) spanhash comparisons.  In
order to avoid repeating those O(N) comparisons, you are adding O(NxM)
basename comparisons.  Once M is large enough, the O(NxM) basename
comparisons you added will be more expensive than the O(N) spanhash
comparisons you are saving.  Recall that my testcase used N and M of
approximately 26,000.  The real world repository I based it on had
over 30K renames.  And if I know of a repository with 30K renames with
only 50K files (at the time), I think we shouldn't be using that as an
upper bound either.

> Having asked these, I do think it is not worth pursuing, especially
> because I agree with Derrick that this "we see a new file whose name
> is the same as the one deleted from a different directory, so if
> they are similar enough, let's declare victory and not bother
> finding a better match" needs to be used with higher similarity bar
> than the normal one.

You say you agree with Stolee, but that's not what I understood Stolee
as saying at all.  He said he thought it wasn't worth the complication
of trying to use a different value for the basename minimum similarity
than the normal minimum similarity, at least not at first.  He
suggested we could add that in the future at some time, and then
talked a bit about how to add it if we do.

> If -M60 says "only consider pairs that are
> with at least 60% similarity index", finding one at 60% similarity
> and stopping at it only because the pair looks to move a file from
> one directory to another directory while retaining the same name,
> rejecting other paring, feels a bit too crude a heuristics.  And if
> we require higher similarity levels to short-circuit, the later full
> matrix stage won't be helped with "we must have already rejected"
> logic.  A.txt and some-module/A.txt may not have been similar enough
> to short-circuit and reject others in the earlier part, but the
> full-matrix part work at a lower bar, which may consider the pair
> good enough to keep as match candidates.

I'm sorry, but I'm not following you.  As best I can tell, you seem to
be suggesting that if we were to use a higher similarity bar for
checking same-basename files, that such a difference would end up not
accelerating the diffcore-rename algorithm at all?  Is that correct?
If not, I don't understand what you're saying.

If by chance my restatement is an accurate summary of your claim, then
allow me to disabuse you of your assumptions here; you're way off.  I
wrote find_basename_matches() to take a similarity score, so that it
could take a different one than is used elsewhere in the algorithm.  I
didn't think it was necessary, but it does make it easy to test your
hypothesis.  Here are some results:

Original, not using basename-guided rename detection:
    no-renames:       13.815 s =C2=B1  0.062 s
    mega-renames:   1799.937 s =C2=B1  0.493 s
    just-one-mega:    51.289 s =C2=B1  0.019 s

Using basename_min_score =3D minimum_score, i.e. 50%:
    no-renames:       13.428 s =C2=B1  0.119 s
    mega-renames:    172.137 s =C2=B1  0.958 s
    just-one-mega:     5.154 s =C2=B1  0.025 s

Using basename_min_score =3D 0.5 * (minimum_score + MAX_SCORE), i.e. 75%:
    no-renames:       13.543 s =C2=B1  0.094 s
    mega-renames:    189.598 s =C2=B1  0.726 s
    just-one-mega:     5.647 s =C2=B1  0.016 s

Using basename_min_score =3D 0.1 * (minimum_score + 9*MAX_SCORE), i.e. 95%:
    no-renames:       13.733 s =C2=B1  0.086 s
    mega-renames:    353.479 s =C2=B1  2.574 s
    just-one-mega:    10.351 s =C2=B1  0.030 s


So, when we bump the bar for basename similarity much past your
hypothetical 60% all the way up to 75% (i.e. just take a simple
average of minimum score and MAX_SCORE), we see almost identical
speedups (factor of 9 or so instead of 10 or so).  And even when we go
to the extreme of requiring a 95% or greater similarity in order to
pair up basenames, we still see a speed-up factor of 5-6; that's less
than the factor of 10 we could get by allowing basename_min_score to
match minimum_score at 50%, but it's still _most_ of the speedup.

Granted, this is just one testcase.  It's going to vary a lot between
testcases and repositories and how far back or forward in history you
are rebasing or merging, etc.  The fact that this particular testcase
was obtained by doing a "git mv drivers/ pilots/" in the linux kernel
and then finding a topic to rebase across that rename boundary makes
it a bit special.  But....even if we were only able to pair 50% of the
files due to basename similarity, that would save 75% of the spanhash
comparisons.  Even in git.git where only 16% of the renames change the
basename, if we could pair up 16% of the files based on basenames it'd
save roughly 30% of the spanhash comparisons.  The numbers are
probably a lot better than either of those, though.  Since 76% of
renames in the linux kernel don't change the basename, 64% of the
renames in gcc don't, over 79% of the renames in the gecko repository
don't, and over 89% of the renames in the WebKit repository don't, I
think this is a really valuable heuristic to use.
