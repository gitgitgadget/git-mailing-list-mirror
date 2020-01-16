Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4468FC33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 15:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00BE12072B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 15:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbmzIrOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAPPfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:35:51 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40854 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 10:35:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so19694368otj.7
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 07:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=As1vVpe7ACqA4LpcohHsRhxnjQlTxGoGEzhLSNrIM6M=;
        b=CbmzIrOj9zVXmpThR4xDN473BnJeVdOAL59Oukg/zRpw2EcXtla4tJb+h62LzJL9pr
         3T3awEmaIS8VrVRkfm2BehQaTyHUJV+/S+hurqN09vdfVfPJlxgEH/XmGV8CWBR1tMij
         1UHj3uvwsYkb4krUa738/Ag1YFiFQ3BX0ssbrFZ/6LAG0FAdO4b0NaBwqyPHObCbAp6V
         8vMPpeoFCTjXpfvLPNUIawMHWZh5dh82LKU2feuuMTTPp5Suz1ufWKS4wQXNbg9w50K0
         7bXCgtlzo4xithin3gfH3gTYsFm8wWfB4qmGCQVlnWu3CLhRLbg5VRjNHChCjPDqrz9w
         r8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=As1vVpe7ACqA4LpcohHsRhxnjQlTxGoGEzhLSNrIM6M=;
        b=Mq7/GKTt3eEj+C29UXH/EREgkRZIiEgePfeZAfPSAMc0CxMh+yv5MyvAcz3u2aG1Hf
         sTIg9xZwXqzSRmDnTfxDTYUTiS8BvCAR8at1M24SDHa299naueoIeoRKrT1hQHRNzkv0
         D1MRn8IljSZWhc6crMroIrW+HqqD7VsroFz6q/pKK7Bxy5Ev/3mb41dOWCbaYovsXWBb
         c+A6GDY6rBDhhg8ip3FkKAG/j1iqOz2ZEhlVZbqIhXT8QsKD3c/ZfvZMYl3GTGlkUMai
         6JpA33q1Unp1nr9p4mcux6QxUFvKGOOvShrOfV8TkQxw8hBWkEqF8xQUge1EAPrrfjx9
         w00w==
X-Gm-Message-State: APjAAAUJ393BuI+b2LoK2zuFCNjQKTrBYAM8vWDqCBYwRBsPFKn7+0ar
        KbwIytNhbISAgXzMHA69sQUuQqX+hXshRND0kJw=
X-Google-Smtp-Source: APXvYqzb/ogJWbnpRmoqVWGuSOOm2YL+cKf0lySBtKnX47usQ9RM7BYMHIanbcJRfXDl7DwayXb8tFf37afQl49ksF8=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr2417539otq.112.1579188948925;
 Thu, 16 Jan 2020 07:35:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com> <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com> <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com> <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com> <20200116075810.GB242359@google.com>
In-Reply-To: <20200116075810.GB242359@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 16 Jan 2020 07:35:37 -0800
Message-ID: <CABPp-BEPiG8OmST9z0obRGuS0Ern5RQsPcRzFEf9=KsE-Hzvbw@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 11:58 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Elijah Newren wrote:
>
> >                                          Then omit calling the
> > post-commit hook and it behaves the same as the am backend and no one
> > in the world notices because no one in the world uses or cares about
> > that hook except a few people at Google who happen to be used to the
> > am-backend
>
> Just responding to this part: I know this was a bit of thinking out
> loud, but the "just a few people at Google" bit is counter-productive.

Yes, you're right, I should do better.  Let me try again to express my
thoughts in a more constructive way...

> The search Emily ran
> <https://github.com/search?l=&q=filename%3A%2Apost-commit%2A&type=Code>
> shows that it's fairly common to use a post-commit hook for
> deployment,

* I actually looked through a dozen or two of those yesterday.  I came
away assuming that many of those might be svn hooks
(http://svnbook.red-bean.com/en/1.7/svn.ref.reposhooks.post-commit.html)
or for other non-git version control systems.  Those that were for git
didn't seem like they'd matter whether or not they were called by
rebase.  Which led me down a thought experiment...

* sequencer.c has accumulated a bit of cruft.  Partially this was
because it's conversion to c was somewhat minimal, e.g. it'd still
fork other processes.  One of these other processes is "git commit".
I think it's been part of the plan all along to remove any forked
processes from sequencer.c and other things that were converted from
shell.

* What if, before being aware of this post-commit hook, someone had
removed the forking of "git commit" from sequencer.c?  I think it
nearly certain that whoever did that wouldn't realize that strict
back-compat would involve adding a call to a post-commit hook when
they did that, and thus all the non-am-based rebases and cherry-picks
would suddenly stop calling that hook.  Would anyone notice?

* People have been using the interactive and merge backends for years
for lots of different rebase types with more and more joining.  We've
never had a report that users were annoyed by it calling the
post-commit hook.  But, on the other hand, rebase-am has run for years
without ever calling the post-commit hook and no one has complained.
I don't believe interactivity is the deciding factor here, as we have
several non-interactive types of rebases implemented by the
interactive backend (--keep-empty, --exec, --rebase-merges,
--preserve-merges, --strategy, --merge) all of which are more similar
in usecase to the am-backend than to the explicitly interactive
usecase from a user perspective (i.e. "Just run on all the commits"
vs. "Let me edit and rearrange and drop and insert and whatnot") and
thus for which I'd assume similar user expectations for what hooks if
any to call.

* When the issue came up, Junio argued that "post-commit" can easily
be argued to mean "whenever a commit is created".  That seemed
eminently reasonable to me.  On the flip side, we do have both
"post-commit" and "post-rewrite" hooks, which could argue that you'd
want to handle brand new commits ("git commit", "git merge")
differently than tweaking existing ones ("git rebase", "git
cherry-pick"), though explicitly interactive rebases are a
monkey-wrench here since they can be used to insert brand new commits
in the middle of rewriting a big pile of commits (suggesting maybe
that only the explicitly interactive rebases should call
"post-commit"?).

* Five different people on this list have chimed in about this
"post-commit" behavior, but I haven't seen a single argument for or
against calling "post-commit" based on actual user expectation for
this kind of usecase (e.g. if done from a clean design).  All I've
seen is folks talking about whether there are backward compatibility
concerns and/or what could be construed by the meaning of words like
"post-commit".  In other words, I don't think any of us have a clue
what is correct behavior if we were designing from scratch.

* Since we don't seem to understand what "correct" behavior is...how
much does or would "incorrect" behavior hurt?  What if we made a
random judgement call about the post-commit hook and got it wrong?
Well...

   * If we changed am to also call the post-commit hook, we have some
early signal that there might be some folks who could comment, though
I haven't yet seen a case where people would be hurt other than a
possible slow-down which the user could probably fix by adjusting
their scripts.  And in such cases it's easy to say "post-commit" means
we call the hook when a new commit is created; if you're doing
something weird where you don't want to do work during the middle of a
rebase your script should check for that case -- it has always been
called by other rebase backends anyway.

   * If we changed sequencer.c to stop forking a git-commit process
and by proxy missed the post-commit hook, I strongly suspect no one
would notice or care.  But if they did, we could just point out how we
have both "post-commit" and "post-rewrite" hooks and that means we
"fixed" our bug of calling the "post-commit" hook from other
rebase/cherry-pick backends in the past by just calling the
post-rewrite hook.  We can tell users they should add a post-rewrite
hook, and, if they want, have it call their post-commit hook one or
more times.

   * If we changed sequencer.c in a way that it stopped calling the
post-commit hook, and someone did notice/care and did have a good
solid argument about correct behavior and that it should involve
calling "post-commit"...then we simply add it and the world is fixed
(though we have to do the explaining that post-commit means whenever a
commit is created mentioned above).  And we provide users with a
workaround for older git versions where we tell them to have the
post-rewrite hook invoke their own post-commit hook for them.


In short, while I don't know what "correct" behavior is other than
that the rebase backends ought to behave the same (or at least all the
am-based rebases and the non-explicitly-interactive rebases
implemented by the interactive backend should all behave the same),
I'm not yet seeing much damage from just picking an answer and
implementing it.

All that said, I'm really, really glad Emily decided to look into this
so I don't have to argue or justify it from anything more than a
"backseat driver" type of perspective.  :-)

> with scripts like
>
>         #!/bin/bash
>         unset GIT_INDEX_FILE
>         git --work-tree=/var/www/html --git-dir=/home/daniel/proj/.git checkout -f
>
> or
>
>         #!/bin/bash
>         # Sync gh-pages branch with master
>         #########################################
>         git checkout gh-pages
>         git rm -rf -q .
>         git checkout master -- .
>         git add .
>         git commit -am "Syncing gh-pages with master"
>         git checkout master
>
> And I'm not saying that selfishly --- obviously, from a selfish
> perspective, what you're proposing would change behavior the least and
> I'd end up with happy users. :)  I'm just trying to help with updating
> the list's collective model of user behavior.
>
> (Actually, I want to remove jiri's post-commit hook --- so it is only
> the example that revealed this behavior change and is not my
> motivation for continuing to chime in in this thread.)
>
> The deployment examples above seem like examples where the user would
> want the script to run on "git am" (and on "git merge --ff-only", for
> that matter) but not on the intermediate commits in "git rebase",
> since when rebasing a multi-commit series, deploying earlier rebased
> commits would cause the deployment to lose the benefit of later fixes.

With your correction later in the thread that it's protected by
current branch == "master", this example doesn't concern me as much.
The ctags case is more interesting, but it's currently running on
every commit of rebase using the interactive backend already, and
while it might slow things down to run on every commit it wouldn't
break anything.  Plus, users can easily add a detached-head or
in-the-middle-of-rebase check to their hook to avoid such a slow down
if it is enough for them to notice so I'm not seeing much harm yet.

So, these are definitely interesting cases, but I'm still not seeing
arguments about whether the hook should be called from a user
perspective, just whether users might in the short term be adversely
affected due to assuming they previously built up scripts assuming
only certain types of rebases would ever be run.  (Not that I'm trying
to discount the short term, because it obviously matters, but that I'm
worried we're letting it be the sole deciding factor rather than
thinking of correct behavior and possibly introducing transition plans
and whatnot if needed.)

> [...]
> > Ooh, that sounds interesting.  Do you have any more details?  My
> > simple testing here shows that we exit with status 1, so we shouldn't
> > have that problem unless perhaps there was something else in next
> > (ra/rebase-i-more-options??) or some other special conditions that was
> > causing it.
>
> I can set aside some more time to investigate that one early next
> week.

That'd be great, thanks.

> Thanks for the quick answers --- it's been very helpful.
>
> Sincerely,
> Jonathan
