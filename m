Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF86C433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 21:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiGPVXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 17:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPVXT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 17:23:19 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B95D18B30
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 14:23:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c3so397609qko.1
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nCVna1hhu2iOqLEPd2RQW+Xy4QCMsHcLSksRt9Bx5U=;
        b=QdRW7QBjw1rjj56pGdEarIryXlOX7IwppaspGLBXvgBV60zxG4GhISXW4kvC0d2eFk
         ntMnATY0PYW7jwea7qc+ohIeTBL/1DCf+04+SAdVolYNCqMhablfM7X9FXTaZ+gFLCzD
         OKe5In+Dei0oM3MQE1KAhnWHXUU1n9WNm1Vvhj6m4J/WB7gaWUHlRG4ufEo9okyHFQZ/
         74djvlCzFESk1szzUqirbLVJi8iXyKkN+V86M4aesx0DnMiOQEp9gyxkaS2cLAEkcl80
         dElHHI5KeHUCFF9RHB4e7fEmfLi8K++95t5EH7m3Hm8CY4m0/dYrez+Fg7zH2dP7WHYs
         KKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nCVna1hhu2iOqLEPd2RQW+Xy4QCMsHcLSksRt9Bx5U=;
        b=wVs0j9BUs10NF2Yd00RW8MEzi3vkPK6JrwVf04ejTxMYOjQUQU6CrH//KR19fYGzue
         T/tjQcmA9dhmFp101t3yNaBeRXdrtJSWF/pZhmnAJ0pyTwQetdE3wPpy+LWmatEAHgJE
         Pjzoals2Wl/T/pbotT0PeG7rK2iWXFLjD+pvQGIBNWLSrLNu8EJ70U9DyvgHX0uaAREH
         xRXdVOb2rG+T1nKy65U9asTITYNnFwHnwgsX4oXv9iO/QfJ0uGtMaSEzdf6n8fXr6DuI
         k5gU5owXqvHfvoAaZHBigofFs0PfbFcNQXSNoveJtMpon2IAqvenbD9eTCi1CJ2D858f
         SkbA==
X-Gm-Message-State: AJIora/rOtorApYNPBwXqGT5wBoIOFPULqW4x0lG8ODAemwWQDKu5ZO+
        B7ev+FzFb8RYfCn11iJwswH/gpgj+BHmhZCtIwM=
X-Google-Smtp-Source: AGRyM1uj2D72suLwZPupVz/9chyYWND33pTXUURgOsU2QvcmoOWShXTsWQYLc6Mog8goMO5BqON4+LKZ4E4aiTudggw=
X-Received: by 2002:a05:620a:4547:b0:6b5:879c:5891 with SMTP id
 u7-20020a05620a454700b006b5879c5891mr13415010qkp.187.1658006597370; Sat, 16
 Jul 2022 14:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com> <xmqq8royibor.fsf@gitster.g>
 <73311eba-244b-3c88-d0b9-f97f426f1de6@github.com> <xmqqv8rz5ztg.fsf@gitster.g>
In-Reply-To: <xmqqv8rz5ztg.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 14:23:06 -0700
Message-ID: <CABPp-BHARfYcsEM7Daeb7+vYxeB9Awo8=qbrOMXG6BQ0gX1RiA@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] rebase: update branches in multi-part topic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 14, 2022 at 11:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <derrickstolee@github.com> writes:
>
> >  Before:
> >
> >   A---B----C---M---Q1---Q2---Q3 <-- refs/heads/Q
> >    \          /
> >     P1--P2--P3 <-- refs/heads/P
> >
> >  After rebasing both topics simultaneously (with 'git rebase --update-refs
> >  C' while Q is checked out):
> >
> >   A---B---C---D---P1---P2---P3---Q1---Q2---Q3
> >                           ^              ^
> >                       refs/heads/P  refs/heads/Q
> >
> > But it seems what you mean to say is to update the merge commit M, which
> > means that the 'P' branch above has been updated independently of the 'Q'
> > branch, so we need to update 'Q' after-the-fact.
>
> I am not aiming to flatten P and Q into a single strand of pearls.
> That would defeat the point of "git log --oneline --first-parent"
> that can be used to view "master..Q", whose output would be "at the
> bottom the topic P lies there, and on top there are 3 patches".
>
> P's may be your ds/branch-checked-out topic while Q's may be this
> topic.  Other people may find bugs, improvements and a room for
> unwanted churns in the former, and P may gain a few more commit,
> in which case M thru Q3 needs to be rebuilt.
>
> In a manual procedure, when I realize that P will gain a few
> more patches (or gets rewritten):
>
>  * find what other topics depend on P and make a mental note (i.e. Q
>    needs to be rebuilt)
>
>  * perform an equivalent of "git rebase -i --onto A P", but without
>    using "git rebase".
>
>    - git checkout P
>    - git checkout --detach master...    ;# reuse the same base
>    - git am -s                          ;# apply
>    - git rebase -i                      ;# minor fix-up while queuing
>    - git range-diff @{-1}...            ;# sanity check
>    - make test                          ;# further sanity check
>    - git checkout -B @{-1}              ;# update P to the new round
>    - git range-diff @{1}...             ;# final sanity check
>
>    this rebuilds P1, P2, and P3 into a new series on A
>
>  * for each topic that needs rebuilding (i.e. Q), find M and rebuild
>    it
>
>    - git checkout Q
>    - git checkout --detach master...    ;# reuse the same base
>    - git merge --into Q P               ;# recreate M with updated P
>    - git rebase --onto HEAD M Q         ;# rebuild Q
>    - git checkout -B @{-1}              ;# update Q to sit on top of new P
>    - git range-diff @{1}...             ;# sanity check (should be empty)

Thanks for sharing all these details, and the ones below.

> > I'm not sure what that rebase would look like, indepdendent of
> > updating refs.
>
> I suspect that a creative use of "git rebase --rebase-merge master
> Q" should allow me to get there.  Here is an outline of the todo
> list you'd get out of "git rebase --rebase-merge -i v2.37.0" while
> the topic ds/rebase-update-ref is checked out:
>
> ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
> label onto
>
> # Branch ds-branch-checked-out
> reset 5ed49a75f3 # Merge branch 'os/fetch-check-not-current-branch'
> pick 31ad6b61bd branch: add branch_checked_out() helper
> pick d2ba271aad branch: check for bisects and rebases
> ...
> pick 9bef0b1e6e branch: drop unused worktrees variable
> label ds-branch-checked-out
>
> reset onto
> merge -C 7fefa1b68e ds-branch-checked-out # Merge branch 'ds/branch-checked-out' into ds/rebase-update-ref
> pick a0bfa0ec53 t2407: test bisect and rebase as black-boxes
> pick 43547f7a52 t2407: test branches currently using apply backend
> ...
> pick 8b2a776cab sequencer: notify user of --update-refs activity
> ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
>
> So it would likely involve
>
>  - "git checkout Q && git rebase -i --rebase-merge master" to get
>    the todo list.
>
>  - remove all "pick"s for existing commits on branch P, and replace
>    them with a "break"
>
>  - add an update-ref insn to update ds/branch-checked-out topic
>    using the ds-branch-checked-out label at the end of the todo
>    list.
>
>  - exit the editor, and in the "break" session, run "am" to accept
>    the new round of patches for P.
>
>  - "git rebase --continue" to let the tip labeled as P and let the
>    rest of the todo list rebuild Q
>
> but I am not sure what should happen when there are more than one
> dependent topic (i.e. in addition to Q, topic R also depends on P).

Yeah, rebase's hard-coded HEAD assumption and including it in an
implicit range, makes it hard to get more general revision range
expressions.  If we had something that just let you specify your
revision range, then you could handle multiple topics, using syntax
something like:

   git replay --keep-base ^master P Q R

and then edit the resulting todo file (where --interactive and an
equivalent of --rebase-merges are both assumed).  You don't even
necessarily have to have any of P, Q, or R checked out.  In fact, if
we can use revision ranges, then perhaps it'd be even nicer to run

   git replay --keep-base --contained --ancestry-path P..seen

(where --contained says update all refs pointing to any commit
contained in the revision range, instead of just the explicitly listed
refs).  This would also remove all the picks for P for you, since it's
the left side of that range.  So, you'd just need to adjust the first
"reset" directive to an older commit, and add a "break" directive
right after it followed by an "update-ref" directive for P.  During
the "break", you can "git-am" the new patches to accept the new
version of P.  You wouldn't have to make a mental note of any other
branches (Q, R, S, etc.) that also need to be included, since they are
contained in seen and the --ancestry-path gets you just the right
range of commits, replaying them all including merges (and I've got
plans for improving the replaying of merges too).

However...

What if someone wants to edit the patches in topic P too, rather than
just eject and replace them?  There's no <revision range> I know of to
get that if the base of P is some very common commit, because
"--ancestry-path master..seen" will suddenly balloon the number of
topics involved rather dramatically.  I guess you could just take that
todo list and edit it (since most commits in the list would just be
replayed on the same base and end up fast-forwarding and thus not be
changed; only commits the user edited and their descendants would
change), but that todo list could be unworkably long  to meddle with.
I'm curious if anyone has ideas for that.

> It also is unclear in the above procedure with "rebase-merge" what
> to feed to "range-diff" in the sanity-checking step.  I could type
> "git range-diff P..." but being able to use @{-1} is a lot handier.

I think you could use "git range-diff seen@{1}...seen" after the
operation I outlined above.

Granted, that only helps sanity check the non-merge commits, since
range-diff currently ignores merges, but perhaps if we teach
range-diff to make use of --diff-merges=remerge then it could?
