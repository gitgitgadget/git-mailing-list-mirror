Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2551F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 20:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeKUGuo (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:50:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34034 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeKUGuo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:50:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so2814284ljd.1
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 12:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hINHTEPYUq4zgRY5E8gvoC2oRUps+rLekzPpeYThrU4=;
        b=I+Z6qEPY9oEUDIfj0oatz00gWMeUgrC4+cnOkHr2R8Rh+qCtHrAN1KzSBjIxF6/2Pi
         cwIfI5gtk3x+ch6Z/E2aXy8AtogvgKVFu2WPn2eOapf3NpPjT9W+MrdL0uNuuwtcuJ/C
         e6/2YC9Hhvq21T/7QEoQe/TTMTLc6jFcb/Hz11fAw3e3Oew9XJRKf/EQKOdMUun8i6/y
         xJ7bFAL1YQlxwN0eoNIuAqIWdqXqtXdMUdI8BYfHawGMUl7cKh1MJT2zm4a9nvTmqi+9
         BBlwoN7NPt8XqoJZVHZEsaMjI9WvCg8A3eRbnY2GEWyq9r0+O4eqkqLroFbE/ynzeEpS
         UwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hINHTEPYUq4zgRY5E8gvoC2oRUps+rLekzPpeYThrU4=;
        b=sKIEbwj13BHoc6PJnA+bi4vOL181tys20v8a3snCnT12wSwtDKZMuxhDQ9xEFjvzMW
         pW8OT5x8+TEUe3BPhkGmhNur5akUcvJkm5vSYwasQ//5LSODj+F/Ik7kqygH0JxBLKMO
         uHDlrMGHHS1wfwJujrYDLc74Hr8ZbemX6VHzYr6rRo8p/S4ZAlyTy46hobYb1TqBAmkR
         1vfNTS/8kN8fgkjrVfXwxLDb+zzrb9c0MrXrc78+YhedHmauxtYE2WfbqrKkyMjG5cTs
         r487FLug7xIXz8KiVPyPiZ+1UXtiq9Zyq5Li5qQCQkbhnJocAIZflz4plV5pq2m/s4pe
         /glA==
X-Gm-Message-State: AA+aEWbP07jhoJglRkAtTXoXGeFvuSjKTvPAdWuHpYhO/9YkfK6s3cml
        CZNYfFdksTdWJNtMgRcfew8knGnpKEu0YOUj/EArJw==
X-Google-Smtp-Source: AFSGD/V3zZ2mQGM32rxS6i79h1Hcg3KFMbXsAjNPUYcSADBtuQWwpUyGI8zFDvK/oNZDELUbdftNYZ9ZvBHOLwsjyso=
X-Received: by 2002:a2e:6f11:: with SMTP id k17-v6mr2050878ljc.94.1542745186721;
 Tue, 20 Nov 2018 12:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <a4c5d89c-cf82-6b1d-2690-82c7f8a95cc4@talktalk.net>
In-Reply-To: <a4c5d89c-cf82-6b1d-2690-82c7f8a95cc4@talktalk.net>
From:   Stefan Xenos <sxenos@google.com>
Date:   Tue, 20 Nov 2018 12:19:34 -0800
Message-ID: <CAPL8ZivzMR30bt62SzOnmwmMnVZdMSiYSUhRSTg6uxyQUGcHLw@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This explains why we have 'origin' fields in the meta commits, it might
> be worth putting a forward reference or note earlier on to explain why
> recording the origin is useful. (I didn't find gerrit needs it very
> convincing on its own but it is actually more general than gerrit's
> specific use case)

I'll add the forward reference.

TBH, gerrit is the main reason I added it - so I'm interested in why
you didn't find the gerrit use-case convincing. Can you elaborate? (If
there's some other way around the gerrit requirement, we might not
need the origin parents)

> Should this be meta/mychange:refs/for/master or have I missed something?

It should be metas/mychange/.... It's already fixed in the v2 patch.

I really wanted to use the namespace "changes", but gerrit is
squatting on that. I tried "change", but that brakes the plural naming
scheme and may get confused with gerrit's namespace, so I settled on
"metas".

> I think it would make sense to have this next to the sections on commit
> --amend and merge I was wondering what about rebase when I was reading
> those sections.

Will do.

> I'm a bit confused why it is creating a meta ref per commit rather than
> one for the current branch.

I tried to explain that later in the doc. meta refs serve two purposes
- they act as stable names for changes (or at least the commits at the
head of each change) and they point to the metacommits that are
currently in use. For both purposes, we need a ref per commit. For the
"stable name" case, this should be obvious - something that just
points to a branch couldn't provide different names for each commit on
that branch. The metacommit case is less obvious - the set of
metacommits for one change aren't connected to the metacommits for any
other change. The "parents" of a metacommit are older versions of the
same change. They don't point to the metacommits from the parent
change. That means that there is no single ref we could create for a
branch that would reach all the necessary metacommits.

> I got the impression they had put quite a lot of effort
> into having evolve automatically run and resolve divergences when
> pulling and rebasing, is there a long term plan for git to do the same?

IMO, we should add anything to the plan if doing so improves the
workflow of our users... but it sounds like you're referring to
mercurial features I've never used. Could you point me to specific
docs on the feature you want and/or make a concrete suggestion about
how it might work?

I never use pull so it slipped my mind. It would probably make sense
to have the option of doing an automatic evolve after pull (actually,
once the feature is stable, most users would probably want it to be
the default). How do you think it should be triggered? "git pull
--evolve"? or perhaps "git pull --rebase=evolve"? We should probably
also introduce a new "evolve" enum value to branch.<name>.rebase
config value. I'll use "--evolve" for now. If may make sense to add
"--evolve" to every git command that performs an automatic evolve when
done.

> What happens if the original commit are currently checked out with local
> changes?

For a start, I'll probably just display an error message if the
current working tree is dirty ("Please stash"). Long term, I'd like it
to work like rebase --autostash. It should stash your changes, do the
evolve, return to the evolved version of the original change, and
reapply the stash. I'll add this to the doc.

> Can I suggest using refs/remote/<remotenome>/metas. I

Ooh! Great idea! I'll update the doc.

> I think this could be useful (although I guess you can get the branches
> you've been working on recently from HEAD's reflog quite easily).

The changes list is different from the reflog. It's a list of all your
unsubmitted patches - regardless of their age or what branch they're
on. They may not have corresponding branches: you may have been
working on them with a detached head, or there may be multiple changes
on the same branch. You might not have visited them recently, in which
case they wouldn't be in the reflog at all. You may have reset to an
older version of the change, in which case they'd be in the reflog but
the reflog and change point to different places. If you've used gerrit
before, the "changes" list will contain pretty much the same content
as the gerrit dashboard, except that it works locally.

>> +Much like a merge conflict, divergence is a situation that requires user
>> +intervention to resolve. The evolve command will stop when it encounters
>> +divergence and prompt the user to resolve the problem. Users can solve the
>> +problem in several ways:
>> +
>> +- Discard one of the changes (by deleting its change branch).
>> +- Merge the two changes (producing a single change branch).
>
>I assume this wont create merge commits for the actual commits though,
>just merge the meta branches and create some new commits that are each
>the result of something like 'merge-recursive original-commit
>our-new-version their-new-version'

It depends on which version of merge you use. I've proposed a new
"merge --amend" argument specifically for resolving divergence. It
avoids creating merge commits as long as there's only one parent
remaining after combining the parents of the commits being merged.
Basically, if the two things being merged are divergent commits, it
would resolve the divergence without creating a new merge commit...
but if the divergent commits had different parents or were themselves
merge commits, the result may still be a merge commit.

If you run the normal version of merge, it *would* create a merge
commit and leave the changes divergent. However, one of the
transformations on the evolve command will look for this situation and
resolve it. Specifically, if it encounters two divergent changes but
exactly one child change contains a merge that would resolve that
divergence, the transformation will merge all three changes, squash
them together, and make all three changes point to the result. I'm not
sure what to call this transformation, but it serves a useful purpose:
it allows users to use either form of merge to resolve the divergence.
If they use the "--amend" version of merge, no merge commit is created
and the divergence is resolved immediately. If they use the normal
version of merge, a merge commit is created (as it is now) and the
evolve command figures out later whether that merge was intended to
resolve divergence. This avoids putting any magic in the merge command
itself, avoids changing the existing behavior of the merge command,
and it means that most users won't need to learn about "merge --amend"
and can't accidentally paint themselves into a corner by accidentally
using the wrong kind of merge. Power users can disable this
transformation and resolve their divergence explicitly using --amend.
Novices can just use the defaults and things will probably work.

It can get more complex, though. If there are two or more child
changes containing merge commits that resolve divergence, this
transformation would happen separately for each one and the resulting
merges would themselves become divergent (since they are two
conflicting solutions to the same problem). This may happen if the
user unnecessarily resolved the same divergence multiple times with
different merge commits. At that point, one of several things would
happen. If after rebasing the merge, the result automerges to exactly
the same thing (which would happen if both merges were the result of
running the automerger on incremental versions of the same two
changes), the divergence would instantly resolve itself because the
two changes are aliases. Otherwise, this new divergence would be
treated like any other and evolve would eventually try to apply the
same algorithm recursively on the new divergent changes.

I'll elaborate more on the supported transformations in the doc for
the evolve command.
