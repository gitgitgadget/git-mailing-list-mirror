Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A2C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A375364F36
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 20:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbhBYUPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 15:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhBYUPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 15:15:06 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F880C061786
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 12:14:26 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id l133so7380063oib.4
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 12:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZN5lh4/Q8VzMYRPX7PNEmaCtjOFKjNDL9XXRe3h1cw0=;
        b=e+LgvkOc/O6b9c89383gqNpRVcx80OUIs6wkVPWWnxw2jUo+RX/T1nshRblc+W/DaG
         YojtRKZMmwqu1g6IGo1Veov42pPeRkEKSECCqzEe8X9jn0fteHHVYIV3iRWeg6oLhCuj
         ZI5MQUlLFOzesRfQpfAYlk/VAdWLSQV6ZEEN/ARupir/86MACfO3YP083OoR6GvnSMhH
         nQJeSEv9xUmMuxGZysR63hXOmlT8byZvTwF8ZQyBD4/cXckpzf6tVMi9uOuXtzooZIOL
         V/Q6GjulsHBYq6HtxTe3pm5wtUm/ogI2afufHpI10z+sbMEngJs97yDLvTGkmFV+ruiv
         JvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZN5lh4/Q8VzMYRPX7PNEmaCtjOFKjNDL9XXRe3h1cw0=;
        b=uF/WXgn+CkL4ROUVyK1+W1yl3DuOW85V+3DT/cNSgn78iwfWVG5+FZbqFeLzlxOrvO
         vjoygQ+7sCe92bZnUMnp9dyDivcDTD1bhLV9KOjGuWhE/u82u0ODi5hMhK/PyxizZwlU
         qQ+hxGktC380A2RtZ9X/9FhP6UIGEA8iVak2cNmdY1IrUwkdNAAcyUlnzcBv7drsGa8t
         KwgO3nd58/1fF3BOHlCqwpRAk7cJya0iDyyyAXuqJL4c89YDkjE7XWe96AZo8/wsEirV
         ISXQcRIiP3bzRepRbQDJ6SK1DxV0T8eLUnRuBxuFQIK/tCFlOibhPKOKIrqiO56RZLpm
         Yx1w==
X-Gm-Message-State: AOAM532lRtgbJ2Dn8EUStiJHnX0Pea81lGkbWwS9DfbkIQ+vgTE063lw
        P+H9aDS5fcrpZAUgU623v2NzMp5QUtSeeCVeajU=
X-Google-Smtp-Source: ABdhPJzQDpKzIYLC8TLVVhBwt/QoXHvIFA0IXLB6i6T6+ldfSX8Lx3UOd7VniQjXNrpe83LZJCgF8qyeWrPwYZc+U3Q=
X-Received: by 2002:aca:c48c:: with SMTP id u134mr64588oif.31.1614284065204;
 Thu, 25 Feb 2021 12:14:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <daa9a6bcefbce977606484d502f5cfd7fca63ecc.1614111270.git.gitgitgadget@gmail.com>
 <CABPp-BHwRHhYE3BPxCG+fRFWf2dCZ60rnO=ykztquKoOp_x_QQ@mail.gmail.com> <36682d84-826a-a5f0-2309-c4a5fa4b9d73@gmail.com>
In-Reply-To: <36682d84-826a-a5f0-2309-c4a5fa4b9d73@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Feb 2021 12:14:14 -0800
Message-ID: <CABPp-BHGxmfx+OPpF-qzvChhf-DmAgzE_B_5Pvv+NJ7exJE=TA@mail.gmail.com>
Subject: Re: [PATCH 01/20] sparse-index: design doc and format update
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 7:29 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/23/2021 8:13 PM, Elijah Newren wrote:
> > On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:>> +This addition of sparse-directory entries violates expectations about the
> >
> > Violates current expectations, yes.  Documentation tends to live a
> > long time, and I suspect that 2-3 years from now reading this sentence
> > might be jarring since we'll have modified the code to have an updated
> > set of expectations.  Maybe a simple "As of time of writing, ..." at
> > the beginning of the sentence here?  Or maybe I'm just being overly
> > worried...
>
> I was hoping that the phrase "this addition of" places this statement in
> a moment of time where sparse-directory entries didn't exist, but now they
> will. I'm open to alternatives and will give this some thought.

I already listed my only suggestion -- adding a "As of time of
writing," at the beginning.  I'm totally open to other
proposals/suggestions, and it's admittedly a minor point so you can
feel free to just ignore it if we can't come up with wording everyone
likes.

>
> >> +To complete this phase, the commands `git status` and `git add` will be
> >> +integrated with the sparse-index so that they operate with O(Populated)
> >> +performance. They will be carefully tested for operations within and
> >> +outside the sparse-checkout definition.
> >
> > Good plan so far, but there's something else bugging me a little here.
> > One thing we noticed with our usage of `sparse-checkout` is that
> > although unimportant _tracked_ files go away, leftover build files and
> > other untracked files stick around.  So, although 'git status'
> > shouldn't have to check the tracked files anymore, it is still going
> > to have to look at each of the *untracked* files and compare to
> > .gitignore files in order to correctly classify each file as ignored
> > or just plain untracked.  Our `sparsify` tool has for a long time
> > tried to warn about such files when changing the sparsity
> > patterns/modules and had an --remove-old-ignores option for clearing
> > out ignored files that are found within directories that are sparse
> > (Meaning the directories where all files under them are marked
> > SKIP_WORKTREE.). I was never sure whether a warning was enough, or if
> > pushing that option more made sense, but about a month ago my
> > colleagues made the tool just auto-invoke that option from other
> > sparsify invocations.  To my knowledge, there have been no complaints
> > about that being automatically turned on; but there were
> > complaints/confusion before about the directories being left around.
> > (Of course, non-ignored files are still left around by that option.)
> >
> > I'm worried that since sparse-checkout doesn't do anything to help
> > with all these untracked/ignored files, we might not get all the
> > performance improvements we want from a `git status` with sparse
> > directories.  We'll be dropping from walking O(2*HEAD) files (1 source
> > + 1 object file) down to O(HEAD) files (just the object files) rather
> > than actually getting down to O(Populated).
>
> This definitely seems like a valuable _enhancement_ to sparse-checkout
> that could occur in parallel.

Yes, indeed.  Your discussion of performance just reminded me of it,
and since this idea might be important in order to drive the costs
down to O(populated) in practice, I thought I'd mention it.

> For a workaround in the moment: is "git clean -xdf" sufficient to help
> these users?

Not really; that wouldn't remove the ignored stuff (build files) under
sparsified directories which is the point.  (Builds build everything
over here; once you sparsify you have leftover build files from
projects you now don't care about.)  If you convert it to "git clean
-Xdf" then you're closer, but that wouldn't just remove builds info
from sparse projects, it'd force users to rebuild all the stuff
they're interested in.

It's close though; what's wanted is basically a special flag that runs
"git clean -Xf <long list of sparsified directories>", without the
user having to specify 300 directories.

However, for now, since I've got a 'sparsify' script anyway (needed
for determining inter-module dependencies and certain directories that
always need to be present, etc.), it just has a flag for running "git
clean -Xf <long list of sparsified directories>" since it has logic to
compute what all those directories are anyway.

> >> +Phase III: Important command speedups
> >> +-------------------------------------
> >> +
> >> +At this point, the patterns for testing and implementing sparse-directory
> >> +logic should be relatively stable. This phase focuses on updating some of
> >> +the most common builtins that use the index to operate as O(Populated).
> >> +Here is a potential list of commands that could be valuable to integrate
> >> +at this point:
> >> +
> >> +* `git commit`
> >> +* `git checkout`
> >> +* `git merge`
> >> +* `git rebase`
> >> +
> >> +Along with `git status` and `git add`, these commands cover the majority
> >> +of users' interactions with the working directory.
> >
> > Sounds like a good plan as well.
> >
> > I hope we get to make this specific to the merge-ort backend.  It
> > localizes the index-related code to (a) a call to unpack_trees()
> > called from checkout-like code (which would probably automatically be
> > handled by your updates to git checkout), and (b) a single function
> > named record_conflicted_index_entries().  I feel it should be pretty
> > easy to update.
> >
> > In contrast, the idea of attempting to update merge-recursive with
> > this kind of change sounds overwhelming.
>
> Yes, I'm hoping to eventually say "if you are in a sparse-checkout, then
> you should use ORT by default." Then, if someone opts to do merge-recursive
> instead, then they pay the index expansion cost.
>
> While this is very clear in my head, it might be worth mentioning that
> explicitly here.

:+1:

> >>  In addition, we can
> >> +integrate with these commands:
> >> +
> >> +* `git grep`
> >> +* `git rm`
> >> +
> >> +These have been proposed as some whose behavior could change when in a
> >> +repo with a sparse-checkout definition. It would be good to include this
> >> +behavior automatically when using a sparse-index. Some clarity is needed
> >> +to make the behavior switch clear to the user.
> >
> > Is this leftover from before recent events?  I think this portion of
> > the document should just be stricken.
> >
> > I argued about how these were buggy as-is due SKIP_WORKTREE always
> > having been an incomplete implementation of an idea at [1], but didn't
> > hear a further response from you.  I'm curious if you disagreed with
> > my reasoning, or it just slipped through the cracks in a busy schedule
> > and this portion of the document was leftover from before.  In my
> > opinion, both commands are just buggy and should be fixed for general
> > sparse-checkout usage cases, not just for sparse-index.
>
> This is definitely a case of "I've been too busy to read those topics
> in detail." I figured that there was something going on that was relevant
> to the sparse-checkout and would affect the sparse-index, but I shelved
> it in my mind until I had space to think about it directly.
>
> > Anyway, that's a long way of saying I think this section of your
> > document is already obsolete.  (Which is a good thing -- less work to
> > do to get sparse-index working.  Thanks, Matheus!).
>
> Thank you for your summary, which helps a lot. Thanks, Matheus, too!
> If those fixes already include coverage for the behavior, then I'll see
> if they also translate to sparse-index tests easily.
>
> I feel like a lot of these later contributions will be more about adding
> tests than actually writing a lot of code.
>
> >> +This phase is the first where parallel work might be possible without too
> >> +much conflicts between topics.
> >> +
> >> +Phase IV: The long tail
> >> +-----------------------
> >> +
> >> +This last phase is less a "phase" and more "the new normal" after all of
> >> +the previous work.
> >> +
> >> +To start, the `command_requires_full_index` option could be removed in
> >> +favor of expanding only when hitting an API guard.
> >> +
> >> +There are many Git commands that could use special attention to operate as
> >> +O(Populated), while some might be so rare that it is acceptable to leave
> >> +them with additional overhead when a sparse-index is present.
> >> +
> >> +Here are some commands that might be useful to update:
> >> +
> >> +* `git sparse-checkout set`
> >> +* `git am`
> >> +* `git clean`
> >> +* `git stash`
> >
> > Oh, man, git stash is definitely in need of work.  It's still a
> > minimalistic transliteration of shell to C, complete with lots of
> > process forking and piping output between various low-level commands.
> > It might be interesting to rewrite this in terms of the merge
> > machinery, though its separate stashing of staged stuff, unstaged
> > stuff, and possibly untracked stuff means that there is a sequence of
> > two or three merges needed and interesting failure handling to do if
> > those merges fail, especially if the user uses --index.  But I
> > digress...
>
> I would prefer to leave 'git stash' alone, but it's used by enough
> people that I need to care about it eventually.

Oh, it can definitely come later.  And I agree about the desirability
of touching that code; I was avoiding it for a long time, but there
was one important sparse-checkout-related bug recently[1] so I've
already been forced to touch it once.  That might mean I'm
(eventually) on the hook to make it sparse-index friendly, especially
since it might involve using merge-ort to do so...

[1] https://lore.kernel.org/git/pull.919.git.git.1605891222.gitgitgadget@gmail.com/

> > Anyway, overall, very nicely written and planned out.  Thanks for
> > taking the time to write this all up.
>
> Thanks for your detailed comments!
> -Stolee
