Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3B0C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 07:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJEHwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 03:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJEHv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 03:51:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B02F6527E
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 00:51:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g1so24395395lfu.12
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=73Uvp32l8XDGD0isizkVGVa7Kq4fD66CjshHZBsZTaw=;
        b=UACv8DttgVhBllBeM3qArU43ZIWKPT9V6LsLqPeZeCWRJ1tzsgto8gggKCe08t5DLx
         Pedl6rgD1Xmp2NAKnOQLtgVnQVefPQO7W7utlv+66/QQ/oyb+9tutbuPaGrLLCRJCpmG
         5IK54SoEmCxkrY7nrbcgXUopOH31o5UC2Hs7XH5MKvi3ACSkmmErBhcHa/ZsrjChv3JV
         h0E4augnpVIjmgHWqJuYZojX8Bw7aNiSDZ6XBAn0CNMcHYXVI2OZrlplUKp+tJFLgc/k
         ny8vRbSz4S3KXWyd1hpGunfpbY53UDjK4BVfSz9pcNXiM7W2x+Zj4mWRPk7hd4ETtVeS
         CCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=73Uvp32l8XDGD0isizkVGVa7Kq4fD66CjshHZBsZTaw=;
        b=bCJlDhxXX3VDDmyoVRlmQv0q5U7COccGmDPPyB2jnghn+6mEeMnuY0LAQn9QetsnbU
         vD/Ng00UWbSnYuynj5LdsdGZj3IMrv7/Far7EPy0/A4FwgMlUaXNM8MxvXGBjrGxCIxr
         flN75O016o65g5x5KpWCoMH5GxQ2N0w97wRiQIYZSCb193HtqwILP3Kkf0sdaIuPzMRS
         l3I3lK9erSpgnHd3cVQY1AJlthvn3bdSsitnYZzkAlMZtB+HMO9mOs+6MHSd19Wf7FfN
         3rIM2co7//1IdplSFtFRqS/KXmeqaNtFFuJ8AcFPPSbav514W0vNffxc2H/mzXQpaeCV
         Q5Mg==
X-Gm-Message-State: ACrzQf1VVF/K4dd3OgoKKwXCysEVsixzYqCK4g315bveSGk9FJIr9fYu
        DzNE1kNscLmr2SwiFB2S22JrWn+bPyZKASlt0Usj0pw6gac=
X-Google-Smtp-Source: AMsMyM5wByak7Wvviv1k4LawPFPioeX1vnx37eB7DnnHAaFReaBJCpB/elh9B6WX7Hkm0kcRgHqltwjS9aGeaQ6BH8w=
X-Received: by 2002:a05:6512:b82:b0:4a0:5970:115c with SMTP id
 b2-20020a0565120b8200b004a05970115cmr11573298lfv.531.1664956315512; Wed, 05
 Oct 2022 00:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com> <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
 <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com> <CAESOdVByucFm=yJn2yL1mwKGqey7tHXH4A-JM-yP125Ok+_Q+g@mail.gmail.com>
In-Reply-To: <CAESOdVByucFm=yJn2yL1mwKGqey7tHXH4A-JM-yP125Ok+_Q+g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Oct 2022 00:51:43 -0700
Message-ID: <CABPp-BH5_=Tq9DM6iAfG3+DuzEE7dR-H8rhP34x-A5FQhLO+bg@mail.gmail.com>
Subject: Re: Bug report: `git restore --source --staged` deals poorly with sparse-checkout
To:     Martin von Zweigbergk <martinvonz@google.com>
Cc:     Victoria Dye <vdye@github.com>, Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2022 at 9:53 PM Martin von Zweigbergk
<martinvonz@google.com> wrote:
>
> On Tue, Oct 4, 2022 at 1:35 PM Victoria Dye <vdye@github.com> wrote:
> >
> > Martin von Zweigbergk wrote:
> > >> On Tue, Oct 4, 2022 at 9:34 AM Victoria Dye <vdye@github.com <mailto:vdye@github.com>> wrote:
> > >>
[...]
> > >> Thanks for reporting this! There are a few confusing things going on with
> > >> 'restore' here.
> > >>
> > >> First is that the out-of-cone was even restored in the first place.
> > >>
> > >
> > > I was actually happy that the out-of-cone paths were restored. I ran that
> > > command as an experiment while reading Elijah's doc because I was curious
> > > what would happen. The reason I think it should restore out-of-cone paths is
> > > so you can do `git restore --staged --source <some commit> && git commit -m
> > > "restore to old commit"` without caring about the sparse spec.
> >
> > Conversely, that's behavior a user *wouldn't* want if they want to keep
> > their sparse cone intact (not to mention the performance impact of checking
> > out the entire worktree). I think it does more harm to those users than it
> > would benefit the ones that want to checkout out-of-cone files.
> >
> > The use-case you're describing should be served by the
> > '--ignore-skip-worktree-bits' option (not the most intuitive name,
> > unfortunately). Luckily, there's an increasing desire to improve the naming
> > of sparse-related options, so the UX situation should improve in the future.
>
> I realized after sending my previous email that I might have a
> different view of what
> sparse checkout is about. To me, it seems like it should be just a performance
> optimization. That's why I feel like commands should behave the same way with
> or without a sparse spec (unless that proposed `--restrict` flag is passed). I
> understand if that's just not feasible. Sorry about the noise in that case :)

The problem I see with that definition is that I'm not even sure what
that means.  Behaving the same way with or without a sparse
specification at the extreme means that switching branches should
populate all the files in that branch...meaning a dense checkout.
That kind of defeats the point.  So, I'm sure you don't mean that they
behave the same in all cases...but where do you draw the line?

Is it just switch/checkout & `reset --hard` that avoid reading and
writing outside the sparse specification?

Should diff & status ignore files outside the sparse specification
even if users wrote to such files?  A "performance optimization" might
suggest we should, but would users get confused?

What about merge/rebase/cherry-pick/revert?  Should those write
additional files to the working tree or avoid it?  What about if there
are conflicts outside the sparse specification?

And if extra files get written outside the sparse specification, are
there ways for this to get "cleaned up" where after resolving
conflicts or changes we can again remove the file from the working
tree?

What about `git grep PATTERN`?  That's documented to search the
tracked files in the working tree.  But should that include the files
that would have been there were it not for the "performance
optimization" of not checking them out?  (Similarly, what about `git
grep --cached PATTERN` or `git grep PATTERN REVISION`?)  I mean, if
these commands should behave the same regardless of sparse
specification, then you should search those other files, right?  But
isn't that a nasty performance penalty if the user has a
sparse/partial clone since Git will have to do many network operations
to get additional blobs in order to search them?  Is that really
wanted?

What about `git rm '*.png'` to remove all the tracked png files from
my working tree.  Should that also remove all the files that would
have been there were it not for the "performance optimization"?  Will
that result in very negative surprises for those with a "I want to
concentrate on just this subset of files" mental model?

What about `git worktree add`?  Should the sparse specification be the
same for all worktrees?  Be per-worktree?  Should it default to dense?
 To just top-level sparse?  To the same sparsity as the worktree you
were in when you created a new one?

There are more questions along these lines, but perhaps this gives a
flavor of the kinds of questions that can come up which need
underlying user mental models and usecases to help us answer how these
commands should behave.

> > But suppose you're doing something like 'git restore --staged --no-worktree
> > --ignore-skip-worktree-bits --source HEAD^'. In that case:
> >
> > - you are restoring to the index
> > - you are *not* restoring to the worktree
> > - you're restoring files with SKIP_WORKTREE applied
> >
> > Right now, SKIP_WORKTREE is removed from the matched entries, but suppose
> > (per your comment) it wasn't. That wouldn't mean that we've "modified the
> > working copy"; the working tree is defined with respect to the index, and if
> > the index entry says "I don't care about the worktree", then there are no
> > differences to reflect.
>
> Yes, not technically changed. I was (and still am) thinking of the working copy
> as logically containing all the files even if some of them are not written out
> to disk.

Git started with a nearly identical definition and still sadly
includes it (though buried deep in a plumbing manual that thankfully
virtually no one will ever read):

       Skip-worktree bit can be defined in one (long) sentence: When reading
       an entry, if it is marked as skip-worktree, then Git pretends its
       working directory version is up to date and read the index version
       instead.

Such a mental model is useless to me in answering how commands should
behave in any interesting cases, and actually led to several
inconsistencies and bugs[1].  However, you didn't leave it there; you
took it a step further...

[1] https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/

> I understand if that seems like an odd way of thinking about
> it. It might
> help to think about how it might appear in a virtual file system where clean
> files outside the sparse spec are presented from the index. Or it may be better
> to not try to think about it in this weird way at all :)

Now you've provided a real usecase (virtual file system really
pretending that all files are present), which gives us some context
with which we can try to answer those questions I asked above.  I
think some of the answers might be different for this usecase than the
"behavior A" and "behavior B" in my current sparse-checkout.txt
document, so maybe we want to add this usecase to the mix.

Anyway, thanks for the interesting bug report, and the context of
another usecase to consider.
