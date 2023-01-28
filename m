Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D4C38142
	for <git@archiver.kernel.org>; Sat, 28 Jan 2023 16:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjA1Qpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Jan 2023 11:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjA1Qpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2023 11:45:47 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF532BEF3
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 08:45:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id br9so12944700lfb.4
        for <git@vger.kernel.org>; Sat, 28 Jan 2023 08:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npqTb6/uaml8YxWMFymne78Zt9BwKxhioLUZPVMimzk=;
        b=MM4O0TJPlrH1UiQYxsWUh3tOGwl9KZwRKIO7u01sq9WZRXCHl7sMPRKLtcYzW7ywmN
         o701DaJLkAsAEfJ9TLc+29wpOgX+tuDRYVBhwoBXP44C/d+MHx74qIhmuYiW6n55MNxA
         cdJWW7aDHYQadiSdwo5BCmobQd/Vm6vskP+Qik+qHMFiWW0ImA0VhjWZKUDA7fTzMDO7
         X4xZkUvF/h6Mw0vKy2UaF9Z97XoArH+ws6C6iyoqlNqlvYt8PpsfprUJYKDyAfPTffaB
         M5cis0wNqocQ+6LIultU48U3ANpBI7nnX2ssx4v5YmW1Lc0EfW8dtdr0uWppxwJEa39L
         +Mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npqTb6/uaml8YxWMFymne78Zt9BwKxhioLUZPVMimzk=;
        b=zqLqb356gwDBKPOSkJhsoOgcRrm/TUQk9p9GWPskdRmjAHUpQY5iY4n6ZEzBQQYYpY
         gSJWdv7VwmBoZr84Tj4ikvo9XtwEYGqPXv4IhW3WdoIxzaVnuDdXs2zwgQSZMB7IQmtK
         Yu4Php0H3WyaVa40La9z1cJTYAU5PZKHa34OSkqPtMXBJNcb2HAfDBwS/L9OB1O8SM8y
         CgQeXZ+MCnBgFAWbW016glViYnOMmM+/M8F5/UIOcYOfd6Y8jPoxSg4VM84rnBhhn04Q
         p+LSAIbBu0iaiKRCzmEwFCorSsRtmwZxIC7xMVYtp4e6pDuSfiKh8RLs23HCo/8ImaQ5
         c4XA==
X-Gm-Message-State: AFqh2kpqM74g0pc+G5iS+a7T7dMSKcAOMap83r5dxBR164wBFZPvOfSj
        fu9n5PuBVFitGvlkWifyP7eZpnPskCz9e3UGZ3U=
X-Google-Smtp-Source: AMrXdXsXH6zJarME2lau2Wae867gEMajPt/tlti+dh318dqQqHSwjc71Hrzas6SxlKSZVVTCyS0LBTrPqTGPNiwIRB4=
X-Received: by 2002:a05:6512:a82:b0:4d4:73e9:89a3 with SMTP id
 m2-20020a0565120a8200b004d473e989a3mr3684799lfu.183.1674924344138; Sat, 28
 Jan 2023 08:45:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com> <CABPp-BExS8UGfGzT+w9R_p0sY+_=A0-nRzU5QTOKwfBSmX6c3A@mail.gmail.com>
 <18c94f70-4adf-1b4a-8777-206804c419e6@unity3d.com> <CABPp-BFtLdRV2zWXn0On0b6mOJgMAatwvUumUxfXfNXo9gc=HA@mail.gmail.com>
 <9dda8cde-7c96-a5f1-f271-951f8b348b80@unity3d.com>
In-Reply-To: <9dda8cde-7c96-a5f1-f271-951f8b348b80@unity3d.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Jan 2023 08:45:31 -0800
Message-ID: <CABPp-BGs2wG6a3oR8dmT9dkeakoiZ+w-Tf=4A-GXeDVkJ9QNMA@mail.gmail.com>
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
To:     William Sprent <williams@unity3d.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2023 at 3:59 AM William Sprent <williams@unity3d.com> wrote=
:
>
> On 26/01/2023 04.25, Elijah Newren wrote:
> > On Wed, Jan 25, 2023 at 8:16 AM William Sprent <williams@unity3d.com> w=
rote:
> >>
> >> On 25/01/2023 06.11, Elijah Newren wrote:
> >>> It looks like =C3=86var and Victoria have both given really good revi=
ews
> >>> already, but I think I spotted some additional things to comment on.
> >>>
> >>> On Mon, Jan 23, 2023 at 3:46 AM William Sprent via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
> >>>>
> >>>> From: William Sprent <williams@unity3d.com>
> >>>>
> >>>> There is currently no way to ask git the question "which files would=
 be
> >>>> part of a sparse checkout of commit X with sparse checkout patterns =
Y".
> >>>> One use-case would be that tooling may want know whether sparse chec=
kouts
> >>>> of two commits contain the same content even if the full trees diffe=
r.
> >>>
> >>> Could you say more about this usecase?  Why does tooling need or want
> >>> to know this; won't a checkout of the new commit end up being quick
> >>> and simple?  (I'm not saying your usecase is bad, just curious that i=
t
> >>> had never occurred to me, and I'm afraid I'm still not sure what your
> >>> purpose might be.)
> >>>
> >>
> >> I'm thinking mainly about a monorepo context where there are a number =
of
> >> distinct 'units' that can be described with sparse checkout patterns.
> >> And perhaps there's some tooling that only wants to perform an action =
if
> >> the content of a 'unit' changes.
> >
> > So, you're basically wanting to do something like
> >     git ls-tree --paths-matching-sparsity-file=3D<pattern-file> $COMMIT=
1
> >> sparse-files
> >     git ls-tree --paths-matching-sparsity-file=3D<pattern-file> $COMMIT=
2
> >>> sparse-files
> >     sort sparse-files | uniq >relevant-files
> >     git diff --name-only $COMMIT1 $COMMIT2 >changed-files
> > and then checking whether relevant-files and changed-files have a
> > non-empty intersection?
>
> Well, the concrete use-case I'm exploring is something along the lines
> of using the content hashes of sparse checkouts as cache keys for resourc=
e
> heavy jobs (builds/tests/etc).
>
> So, that would be something along the lines of,
>
>      git ls-tree -r --paths-matching-sparsity-file=3D<pattern-file> \
>      | sha1sum > cache-key
>
> and then performing a lookup before performing an action (which would
> then only be done in the context of the sparse checkout). My thinking
> is that this only would require git and no additional tooling, which in
> turn makes it very easy to reproduce the state where the job took place.
>
>
> > Would that potentially be better handled by
> >     git diff --name-only $COMMIT1 $COMMIT2 | git check-ignore
> > --ignore-file=3D<pattern-file> --stdin
> > and seeing whether the output is non-empty?  We'd have to add an
> > "--ignore-file" option to check-ignore to override reading of
> > .gitignore files and such, and it'd be slightly confusing because the
> > documentation talks about "ignored" files rather than "selected"
> > files, but that's a confusion point that has been with us ever since
> > the gitignore mechanism was repurposed for sparse checkouts.  Or maybe
> > we could just add a check-sparsity helper, and then allow it to take
> > directories in-lieu of patterns.
>
> I don't think it necessarily would be better handled by that. But it woul=
d
> be workable. It would be a matter of collating the output of
>
>    git ls-tree -r <commit>
>
> with
>
>    git ls-tree --name-only -r <commit> | git check-ignore ...
>
> Which is less ergonomic. But it is also a less intrusive change.
>
> Really, the main thing is to expose the sparse filtering logic somehow, a=
nd
> allow for building tooling on top of it.
> > This seems nicer than opening a can of worms about letting every git
> > command specify a different set of sparsity rules.
>
> I think you are the better judge of how much of a can of worms that would
> be. I don't think it would be too out of line with how git acts in genera=
l
> though, as we have things like the the 'GIT_INDEX_FILE' env-var.

I agree you've got a reasonable usecase here.  The integration you've
described sounds like something that could be independently composable
with several other commands, and you alluded to that in your commit
message.  But is adding it to ls-tree the best spot?  If we add it
there, then folks who want to similarly integrate such capabilities
with other commands (archive, diff, grep, rev-list --objects, etc.),
seem more likely to do so via direct integration.  We already have a
very large can of worms to work on to make commands behave in ways
that are limited to sparse paths (see
Documentation/techncial/sparse-checkout.txt, namely the "behavior A"
stuff).  As can be seen in that document, what to do for limiting
commands to sparse paths is obvious with some commands but has lots of
interesting edge cases for others (even with years of experience with
sparse checkouts, we had 3- and 4- way differing opinions on the
intended behavior for some commands when we started composing that
document a few months ago).  If we had jumped straight to
implementation for some commands, we would have likely painted
ourselves into a corner for other commands.  Adding another layer of
specifying an alternate set of sparsity rules will likely have
interesting knock-on effects that we should think through for all the
commands to ensure we aren't painting ourselves into a similar corner,
if we go down this route.

However, in the cases that sparse-checkout.txt document was
addressing, the behavior fundamentally needs to be integrated into all
the relevant commands to get user experience right.  In your case, you
merely need a separate tool to be able to compose the output of
different commands together.  So, exposing whether sparsity rules
would select various paths in a single separate command (maybe git
check-ignore, or a new sparse-checkout subcommand, or maybe just a new
subcommand similar to check-ignore) would avoid a lot of these issues,
and give us a single place to extend/improve as we learn about further
usecases.

[...]
> >> I agree that it is a bit awkward to have to "translate" the directorie=
s
> >> into patterns when wanting to use cone mode. I can try adding
> >> '--[no]-cone' flags and see how that feels. Together with Victoria's
> >> suggestions that would result in having the following flags:
> >>
> >> * --scope=3D(sparse|all)
> >> * --sparse-patterns-file=3D<path>
> >> * --[no]-cone: used together with --sparse-patterns-file to tell git
> >>     whether to interpret the patterns given as directories (cone) or
> >>     patterns (no-cone).
> >>
> >> Which seems like a lot at first glance. But it allows for passing
> >> directories instead of patterns for cone mode, and is similar to the
> >> behaviour of 'sparse-checkout set'.
> >>
> >> Does that seem like something that would make sense?
> >
> > --sparse-patterns-file still implies patterns; I think that would need
> > some rewording.
>
> Yeah. After sleeping on it, I also think that it becomes a difficult
> interface to work with, and you'll get different results with the same
> patterns whether you pass --cone or --no-cone, which seems error prone
> to me.
>
> For better or for worse, both cone and non-cone uses of sparse-checkouts
> end up producing pattern files. And those pattern files do unambiguously
> describe a filtering of the worktree whether it is in cone-mode or not.

Back when cone mode was introduced, I objected to reusing the existing
pattern format and/or files...but was assuaged that it was just an
implementation detail that wouldn't be exposed to users (since people
would interact with the 'sparse-checkout' command instead of direct
editing of $GIT_DIR/info/sparse-checkout).  It's still a performance
penalty, because we waste time both turning directory names into
patterns when we write them out, and when we read them in by parsing
the patterns to see if they match cone mode rules and if so discard
the patterns and just build up our hashes.  The patterns are nothing
more than an intermediary format we waste time translating to and
from, though once upon a time they existed so that if someone suddenly
started using an older (now ancient) version of git on their current
checkout then it could still hobble along with degraded performance
instead of providing an error.  (We have introduced other changes to
the config and git index which would cause older git clients to just
fail to parse and throw an error, and even have defined mechanisms for
such erroring out.  We could have taken advantage of that for this
feature too.)

Anyway, long story short, if you're going to start exposing users to
this implementation detail that was meant to be hidden (and do it in a
way that may be copied into several commands to boot), then I
definitely object.

> Given that 'ls-tree' is more of a plumbing command, I think it might stil=
l
> make sense to use the patterns. That would also make the interaction
> a bit more logical to me -- e.g. if you want to override the patterns
> you have to pass them in the same format as the ones that would be read
> by default.

No, sparsity specification should be provided by users the same way
they normally specify it (i.e. the way they pass it to
`sparse-checkout {add,set}`), not the way it's stored via some hidden
implementation detail.

I'd make an exception if you ended up using `git check-ignore` because
that command was specifically written about gitignore-style rules, and
git-ignore-style rules just happen to have been reused as-is for
non-cone-mode sparse-checkout rules.  But if you go that route:
   (1) you have to frame any extensions to check-ignore as things that
are useful for gitignore checking, and only incidentally useful to
sparse-checkouts
   (2) you'd have to forgo any cone-mode optimizations
Going the check-ignore route seems like the easiest path to providing
the basic functionality you need right now.  If your usecases remain
niche, that might be good enough for all time too.  If your usecases
become popular, though, I expect someone would eventually tire of
using `check-ignore` and implement similar functionality along with
supporting cone-mode in a `git check-sparsity` or `git sparse-checkout
debug-rules` command or something like that.
