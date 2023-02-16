Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B67C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 12:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBPMbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 07:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBPMbc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 07:31:32 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579612B0AC
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 04:31:30 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lf10so4771828ejc.5
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 04:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=58iEBkYvoNzuX5jiS/QyPUueej/1z8HeUOwsJ101g2M=;
        b=AtbOzhhLmBE8SHfBBwpwZY1r+e7q96nlDMt1BLO5W7ZPfB+Wgb43QEBy4qnOO1Vvwe
         4wtu27BH9JdVccfJpX1IcF39coiXTi9Ro5kGAtPF/OI0LsvOsQYucrOrwBuNUnJAtEiB
         rJcPN1R1UYtdC6YqU+3cuYon5UnOnTJ2UgR90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58iEBkYvoNzuX5jiS/QyPUueej/1z8HeUOwsJ101g2M=;
        b=POn8Fakvf8or7BTP5CbJhYGkuz3LIoDLijguYnSIiupPGb+0w+/bT1yR2Qn5RR0CgT
         WMEgFyjSnkauP4JMCJOvoztxpuzPSri08JD5W5Q4fhnSWqHrAOUd2rxCuMaTZzEut/PL
         DlztU3vOZSyGDgjBPIZ8I0UFEmxka4pZAlwiOgl2l7gnGU2tfgQXHenVsXTIsxMnChLZ
         uHQBIb/AYND7YwYg+k4ZOf9dC9rRx4gtX5C+Tw1Gbj8jIBk+tE6yitXvbJfceu2bI/zF
         o8US0qFmdGNlFBNy4b/igZDX3OUKRG4avdqiSQgYbsC9auBaSl7KZnVTP1Mgiyh0aj3X
         nPSw==
X-Gm-Message-State: AO0yUKUgQXEigBcz+T4byqGIDDJy6lhLjcvk37I+PSzYqa+eCZm6zWCt
        kZwkETUf1FUp3/0x8JL/S3lFFaf7ROLeDDc/Vhc98bwVn6MQuPalco8=
X-Google-Smtp-Source: AK7set+amlk6NlHHLS/+WiHaR4cyyHXvuWtr+IBeHr9Ax8P5DvHkAJDQg0Mit4xlvjXWwQOg++cH0BBiV9TF9oYmvWU=
X-Received: by 2002:a17:906:16c9:b0:8b1:2916:9804 with SMTP id
 t9-20020a17090616c900b008b129169804mr2726181ejd.9.1676550688701; Thu, 16 Feb
 2023 04:31:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com> <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
In-Reply-To: <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 16 Feb 2023 13:31:17 +0100
Message-ID: <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 4:22 AM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> - The proposed wording is likely to further confuse novices. It's
> asking the user to choose between the reconciliation strategies of
> merging and rebasing, but then says to use the unintuitive combination
> "rebase=merges"

My thesis, which you clearly disagree with, is that for this type of
situation, "rebase=merges" is not an "unintuitive combination", but
rather is "a plain and simple rebase". It is truly unfortunate that
git's history has led us to a place where this command is so awkwardly
named, I agree with that at least.

If there's an appetite for it, I would love to contribute to a
multi-year adventure to change git's behavior, little by little, until
the behavior of "rebase=merges" is the default, and the old behavior
becomes a different option like
"rebase=copy-merged-commits-to-flatten"

> which sounds like it's going to make a merge commit at
> the end of the branch anyway.

I can't quite tell whether you're referring to the naming of the
option (which I agree, sucks), or saying that it sounds *to you* like
it will make a merge commit. It will not make a merge commit unless
*you* previously made a merge commit. It will rebase your merge
commits, only if there are any that should be rebased.

If your concern is that we shouldn't be showing anyone the
"consistently reasonable rebase option" because it's confusingly named
wrt the "rebase option that experts understand and has a shorter
name", then let's figure out how to rename it. In the meantime, let's
help avoid people shooting themselves in the foot. A hint pointing at
the cool loaded gun lying on the mantelpiece is *not* helping users
avoid shooting themselves in the foot.

>
> - The proposed wording makes it sound like there's something wrong
> with doing a regular rebase, but that's not usually the case because
> in practice a regular rebase is almost always equivalent to
> rebase=merges.

The new proposed option will do the right thing in (almost?) all
cases. The previous option will make a horrible mess of things in some
(or, depending on the workflow, many!) cases.

In all the cases where the behavior is equivalent, that's great. In
almost all the cases where the behavior is different, the proposed new
behavior is superior (to anyone who needs that hint).

There is only one case that I know of in which the proposed new
behavior could be considered marginally worse:

* I have a local branch "feature-1", with some local work on it
* This is a shared branch, others are working on it also, so
"origin/feature-1" has a few other commits on it also (diverged)
* I create a derived branch, "feature-1-sub". I do some work on it
* I pull with rebase (--rebase or --rebase=merges, makes no
difference), so my original local feature-1 changes are rebased on top
of others' changes.
* I do some more work on (my local, rebased) "feature-1"
* I merge "feature-1-sub" into "feature-1"
** -> I now have duplicate commits in my history: the original local
"feature-1" work is in the history of "feature-1-sub", and it was/is
separately rebased in "feature-1"
* I "git pull --rebase" or  "git pull --rebase=merges":
** A "simple rebase" will automatically squash the duplicated commit(s)
** A "rebase with rebase-merges" will retain/recreate the merge
commit, and thereby retain the existence of a duplicated commit in the
commit graph.
(test script available upon request, I didn't want to spam the list with it)

While I agree "--rebase=merges" is not clearly superior, or could even
be worse in this one contrived case, I would argue that this is far
less harmful than the current "pathological case" of "--rebase", which
will happen far more easily and which I will outline again:

* There is a "main" branch with lots of commit activity from lots of
contributors
* There is a "feature-1" branch with a few contributors collaborating
on something that will be merged into "main" when ready
* These contributors are not experts - they don't coordinate on
rebasing "feature-1" every time they need to incorporate changes from
"main" - instead, they merge "main" into "feature-1" when that's
needed
* One of those contributors is tasked with doing the merge from main,
resolving conflicts, spot-checking, etc - the last merge from main was
10 days ago, 100 commits.
* They have a merge commit ready, tested
* They try to push "feature-1", but one of the other contributors has
added some work/commits, so the error tells them to "git pull" first
* They "git pull", get an error and follow the wrong advice, or they
followed the wrong advice in the preceding days/weeks - they end up
doing a "git pull --rebase" without knowing what that means for their
recent merge commit, and/or without even realizing that's how they
previously configured things
* Their "feature-1" branch now has 100 duplicated commits by arbitrary
"main" developers, but they haven't even necessarily noticed - they
may well be using a GUI that just congratulates them on a successful
pull
* They now push, successfully.
* Unless anyone looks at the commit graph of "feature-1" carefully,
no-one necessarily notices anything is wrong; the changes from "main"
are in "feature-1", as expected; it's just the lines connecting them
that are wrong
* Two weeks later, the team needs to merge in "main" again - and they
start to get all sorts of weird conflicts
** "Oh man, git sucks - I thought it was supposed to merge *better*
than that other stuff, but it's finding conflicts that have nothing to
do with us, all over the place!"
** "Hmm, this is weird - let's see what the git expert says"
** "Oh man, 'feature-1' needs to be rebuilt, and everyone working on
it needs to figure out how to rebase their work / their branch(es)
onto the new state"
** etc

> A regular rebase may even be what the user really
> wants: For example, the user might choose to merge when pulling and
> then change their mind and decide that they really wanted to rebase.
> Repeating the pull with the regular -r or --rebase flag fixes the
> mistake.

I don't understand the relevance of this example: No-one is suggesting
to forbid "merge-flattening rebases" - only avoiding the suggestion to
use them as the default for people who don't know what they are doing
(that's who the hints are *for*!)

The way you suggest this example, it feels like you think this might
be intuitive/predictable: "I chose the wrong thing, so I flip the
choice and I get the other outcome" - that's not true at all, because
if you flip the choice the other way (--rebase first, and then merge),
you get a completely different outcome! (especially if what you
accidentally rebased contained a merge of course - but even without
merges in the rebased history, doing a merge later does not yield
nearly the same outcome).

>
> - `git pull -ri` (or its longer form `git pull --rebase=interactive`)
> is generally more useful than `git pull --rebase=merges`, but once
> rebase=merges has been specified, there's no way to specify
> rebase=interactive also. Recommending rebase=merges steers people away
> from rebase=interactive, hiding useful functionality from the user.

I don't understand your argument here... Are you saying that users
reading "You can also pass --rebase" would have been more likely to
end up running "--rebase=interactive" than users reading "You can also
pass --rebase=merges"? I believe this to be a grave misreading of user
behavior, but I have no credentials to back up this belief.

People consistently, and unhesitantly, copy-paste the suggestions
offered to them. If you believe users should be running
"--rebase=interactive", then the new wording is no worse than the old.

Now, as to whether users should in fact typically be running
"--rebase=interactive" when doing a "git pull" - is there an option to
"preserve merges" in this interaction? For users who *do not ever
merge* your suggestion sounds... possibly-overbearing, but not wrong.
For users who *do* merge, it is plain wrong as far as I know.

>
> Now, this is not to say that there's no room for improvement. I like
> the rebase=merges option and I wish everyone knew about it because
> there are situations where it really is the best option. I suggest
> leaving the existing text alone, but adding an additional paragraph,
> something like:
>
> Note that --rebase or pull.rebase=true will drop existing merge
> commits and rebase all of the commits from all of the merged branches.
> If you want to rebase but preserve existing merge commits, use
> --rebase=merges or pull.rebase=merges instead.

My primary motivation with this pull request is to reduce the
incidences, out there in the world, of people copy-pasting "git config
pull.rebase true" into their command-line, and causing themselves
major headaches days or weeks later. The "--rebase=interactive" part
is secondary (to my concerns), because it's much less copy-pastable.

Your proposal does nothing for my concern, unfortunately - it leaves a
message that, overall, offers three copy-pastable options, two of
which are safe-enough, and one of which has substantial chances of
plunging you into a world of pain that you cannot comprehend. It is
plain wrong. We need to change it.

I am very happy to add the paragraph you proposed instead of changing
"--rebase" to "--rebase=interactive", but I would like to see a much
better suggestion as to how to address the harm of "git config
pull.rebase true".


Thanks for your feedback, and my apologies for the insistent response
- I'm having a hard time figuring out how to express just how *bad*
the existing copy-pastable suggestion in this hint is (in this day and
age), for users who merge - users who, I believe, make up the
significant majority of "corporate" developers at the very least, and
I suspect even the significant majority of git users out in the world.

I'm adding Johannes Schindelin to the thread in case he has the cycles
to weigh in - as the original author of what I would call "the better
way" (5 years ago now!), I'm sure he's more aware than most of its
limitations, and of any reasons why we *wouldn't* want to make the
change(s) I've suggested here.

Thanks,
Tao
