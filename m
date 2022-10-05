Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9470CC433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 20:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJEUAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJEUAP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 16:00:15 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292C15823
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 13:00:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso1612164wms.5
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 13:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yRZpwVztAB8o4JNx/0XrspnbC5SLgnL6aLZUvlZMPEg=;
        b=l4cxbdJKhuaryOsIKPlSj3uwXZNP2IwRMrWoLePjoOqXnR6g0BkfdJC31Iy0Ao4G6p
         S0ClI234G+djooLm7uJgQv5Ua9EIrBnwj8d1l+1oHloR2WzkLgyoJEs+Zioicp7wYNBJ
         jEPwtia0ULX/u360g7Z3N7nDlq2slvwivszbe2fzb7HwvDgLQNLdBa4hQrY4mbMRdQST
         EGqgkSMUy8LjMuL4WwLsBt3mTEs0prSAkksqbB2hIAuMYYUMgL1hpapNIVCr6xkbJBRF
         zoxNez1p4uFQjR44YwUPcM3gz5jc7mWYunCpErDNTgMNN8DHW+WhqI9ymZL179PUaFO7
         oHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yRZpwVztAB8o4JNx/0XrspnbC5SLgnL6aLZUvlZMPEg=;
        b=Evi7kVBRkSWWqCBeuEzEEiA1ShtrKVlHe0ignoKb/e+eGQ9EqDGjfMUHsXTQbnQbWx
         E+G8pz0MPqugRhxj0Fx2P0k6zY5VywnMDiWHYOmS2ODWC9pVE0RL1YkpeJUQYAvYNjNw
         X9sAfLSuiWyyappXW44HXlOqQTPCxYPzbt8zFMN1dYSIaglCq479ptkHN6OmcmxaHAOQ
         nQrye58f88HHvW9fFbU2GsANlTHkfr30Hyqc4GEnbZ1PDmo7j6aRGfwu6sQVF9kMAxMB
         6tZQXLpOZxzX+fJF01/i1uiq6yDc5CLntBibcZT7xadCBi9lfypsyOIhBAH78Cv7dnC9
         qW+Q==
X-Gm-Message-State: ACrzQf1u2kw6hpRZuvVJRWqGPimpYt20vfu4LW5sIT/9O6OuZGrvOIKQ
        KfmspTnqBK8WueZmueU+mirBvPw4MAbUUNfsgK2qMg==
X-Google-Smtp-Source: AMsMyM6Znmpuik6wYea0p6D7WvvPKiANoqkkE2JNmoWLt7DhtD0b+6l9vdFpMopP0vKq2WTwJ20MNhNscNLxwKBcrQU=
X-Received: by 2002:a05:600c:4ece:b0:3b4:a79c:1333 with SMTP id
 g14-20020a05600c4ece00b003b4a79c1333mr761938wmq.49.1665000012518; Wed, 05 Oct
 2022 13:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com> <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
 <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com> <CAESOdVByucFm=yJn2yL1mwKGqey7tHXH4A-JM-yP125Ok+_Q+g@mail.gmail.com>
 <CABPp-BH5_=Tq9DM6iAfG3+DuzEE7dR-H8rhP34x-A5FQhLO+bg@mail.gmail.com>
In-Reply-To: <CABPp-BH5_=Tq9DM6iAfG3+DuzEE7dR-H8rhP34x-A5FQhLO+bg@mail.gmail.com>
From:   Martin von Zweigbergk <martinvonz@google.com>
Date:   Wed, 5 Oct 2022 13:00:00 -0700
Message-ID: <CAESOdVDt7SU=OJhF0mgyZ=B3sncB49aML8oOzKTKAnmGO5BaVQ@mail.gmail.com>
Subject: Re: Bug report: `git restore --source --staged` deals poorly with sparse-checkout
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye <vdye@github.com>, Glen Choo <chooglen@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2022 at 12:51 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Oct 4, 2022 at 9:53 PM Martin von Zweigbergk
> <martinvonz@google.com> wrote:
> >
> > On Tue, Oct 4, 2022 at 1:35 PM Victoria Dye <vdye@github.com> wrote:
> > >
> > > Martin von Zweigbergk wrote:
> > > >> On Tue, Oct 4, 2022 at 9:34 AM Victoria Dye <vdye@github.com <mailto:vdye@github.com>> wrote:
> > > >>
> [...]
> > > >> Thanks for reporting this! There are a few confusing things going on with
> > > >> 'restore' here.
> > > >>
> > > >> First is that the out-of-cone was even restored in the first place.
> > > >>
> > > >
> > > > I was actually happy that the out-of-cone paths were restored. I ran that
> > > > command as an experiment while reading Elijah's doc because I was curious
> > > > what would happen. The reason I think it should restore out-of-cone paths is
> > > > so you can do `git restore --staged --source <some commit> && git commit -m
> > > > "restore to old commit"` without caring about the sparse spec.
> > >
> > > Conversely, that's behavior a user *wouldn't* want if they want to keep
> > > their sparse cone intact (not to mention the performance impact of checking
> > > out the entire worktree). I think it does more harm to those users than it
> > > would benefit the ones that want to checkout out-of-cone files.
> > >
> > > The use-case you're describing should be served by the
> > > '--ignore-skip-worktree-bits' option (not the most intuitive name,
> > > unfortunately). Luckily, there's an increasing desire to improve the naming
> > > of sparse-related options, so the UX situation should improve in the future.
> >
> > I realized after sending my previous email that I might have a
> > different view of what
> > sparse checkout is about. To me, it seems like it should be just a performance
> > optimization. That's why I feel like commands should behave the same way with
> > or without a sparse spec (unless that proposed `--restrict` flag is passed). I
> > understand if that's just not feasible. Sorry about the noise in that case :)
>
> The problem I see with that definition is that I'm not even sure what
> that means.  Behaving the same way with or without a sparse
> specification at the extreme means that switching branches should
> populate all the files in that branch...meaning a dense checkout.
> That kind of defeats the point.  So, I'm sure you don't mean that they
> behave the same in all cases...but where do you draw the line?

I agree with you and Stolee that there are two different cases: some
people use sparse checkouts to restrict what they see (behavior A), and
some people use it just as a performance optimization (behavior B). So I
suspect we roughly agree about what should happen if you pass
`--restrict` (or if that becomes the default so you don't actually need to
pass it). My arguments were about the `--no-restrict` case. Sorry, I
should have made that clear.

I also agree that having a way to make commands restrict to certain paths
by default is useful, and I agree that tying that set of paths to the current
worktree's sparse spec makes sense.

I'll answer the questions below for the `--no-restrict` case
(behavior B).

>
> Is it just switch/checkout & `reset --hard` that avoid reading and
> writing outside the sparse specification?
>
> Should diff & status ignore files outside the sparse specification
> even if users wrote to such files?  A "performance optimization" might
> suggest we should, but would users get confused?

I think they should be included (again, in the `--no-restrict` case).

>
> What about merge/rebase/cherry-pick/revert?  Should those write
> additional files to the working tree or avoid it?  What about if there
> are conflicts outside the sparse specification?

I think they should avoid it, but since the user will need to resolve
that conflict anyway, I can see it makes sense to write them to disk
if there are conflicts.

>
> And if extra files get written outside the sparse specification, are
> there ways for this to get "cleaned up" where after resolving
> conflicts or changes we can again remove the file from the working
> tree?

I've never really used `git sparse-checkout` (until I read your doc),
but isn't that what `git sparse-checkout reapply` is for?

>
> What about `git grep PATTERN`?  That's documented to search the
> tracked files in the working tree.  But should that include the files
> that would have been there were it not for the "performance
> optimization" of not checking them out?  (Similarly, what about `git
> grep --cached PATTERN` or `git grep PATTERN REVISION`?)  I mean, if
> these commands should behave the same regardless of sparse
> specification, then you should search those other files, right?  But
> isn't that a nasty performance penalty if the user has a
> sparse/partial clone since Git will have to do many network operations
> to get additional blobs in order to search them?  Is that really
> wanted?

I think it's consistent to search them with `--no-restrict` (but not
with `--restrict`, of course).

>
> What about `git rm '*.png'` to remove all the tracked png files from
> my working tree.  Should that also remove all the files that would
> have been there were it not for the "performance optimization"?  Will
> that result in very negative surprises for those with a "I want to
> concentrate on just this subset of files" mental model?

Same here.

>
> What about `git worktree add`?  Should the sparse specification be the
> same for all worktrees?  Be per-worktree?  Should it default to dense?
>  To just top-level sparse?  To the same sparsity as the worktree you
> were in when you created a new one?

That's an interesting case. If someone does `git worktree add` and expects
all files to be available in the working copy, they might be surprised, yes.
I think that's a much smaller risk than
`git restore --source HEAD^ --staged && git commit -m 'undo changes'` being
partial, however.
