Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D612BC77B75
	for <git@archiver.kernel.org>; Sun,  7 May 2023 02:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEGCsY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 22:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGCsW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 22:48:22 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B7D46BF
        for <git@vger.kernel.org>; Sat,  6 May 2023 19:48:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f14e499ffcso1889654e87.0
        for <git@vger.kernel.org>; Sat, 06 May 2023 19:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683427698; x=1686019698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7dMUZX1ziUwOOJ/pmufzb1E543vP+nQyqXr24lwKiA=;
        b=XDBWuYxR+qa9SRqO7ksCD6S1gA446rY4GKPiwWXSgveBH3FUqMNmvG6qQXgCdXf0QX
         cQl3NyuI6ukykpKmCV+DvSAesz7z+XZsLF/2qkv1DsJkAaGxCLF0VuBWSkqpG9G6rXTS
         U2m1fUNTh68udAzxO+Sa8Kbn08dRdia5NBJvdSo8qd6gsv0S0gDwxwO+cdKY7ybwtuHg
         Jdyg4LpyqFHHO5Of6nrFy0JrvWTRnc00EXQOXKMxHd3eCtSjX4VUOE+hM96YXY936iUm
         aIVMMF3iH1WdTCEw3SBvM05oDQqBVUMWYYWLNeWvqN7jwRufJjoCK4+DqeXHNtBntKPw
         djLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683427698; x=1686019698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7dMUZX1ziUwOOJ/pmufzb1E543vP+nQyqXr24lwKiA=;
        b=CuvfYKrf50RDyqZ7qA/vd/gOh02peQz8yds46WLJja3Sj00Fn6IXEs9rzl/vGsBh4t
         En6ZtlHqi8R9YirZvynSKo2LODoV3EFtChG+1EEGxTisgxWGhDP6vCqSg6zQCAxIW16B
         Ryrs8bjss5St+68Y8S9IRlpUzs3Lz10WfzHUBrOmI+YtUWkWjlxk5K16PbAc5yool6/6
         kxYB8rtUzjIFabUTMrrx2PC+a/EbXRozvOKajFKPyW1TbmZ3v38eYy1DBrfDK8rtL2Vs
         RMg5oFsZfpGez8kVqSXOsgmC7/AvmW4tfnCLuJWEFIZwSw0BBMQC9z9BZX5t14jk2VgN
         wZRg==
X-Gm-Message-State: AC+VfDyMF5YsSwPPj1v3UrEYnDe6WAqKOwh5d6HWwTt4CXs2ibul8gZQ
        bbZ/rI89FgQr3KqXLZ9MGUXoStMG4KUyI5pg9x0=
X-Google-Smtp-Source: ACHHUZ4eLBZ1wBuE+WgcU/VK5KyjpeH0eu3lu5pM8KDU+/t+BH10H609whhqUNE7mTZaS2YmNIFsnInVxjDBIF3D+7g=
X-Received: by 2002:a05:6512:38af:b0:4ea:fa26:2378 with SMTP id
 o15-20020a05651238af00b004eafa262378mr1436441lft.23.1683427697898; Sat, 06
 May 2023 19:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com> <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
In-Reply-To: <CAPMMpogiTVksUKgZ==n4d3xm4ZJqxm7ki2dOF8j8S5BaJvu1Ew@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 May 2023 19:48:05 -0700
Message-ID: <CABPp-BGmPKyNcDa-wUh-oisTvvux+X=6BvGxSNQC2O7uodpFrA@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tao,

On Wed, May 3, 2023 at 10:01=E2=80=AFPM Tao Klerks <tao@klerks.biz> wrote:
>
[...]
> > By the way, it was a problem that git-checkout wasn't updated to have
> > the same safety that git-switch has.  We should fix that.  (It's on my
> > todo list, along with adding other
> > prevent-erroneous-command-while-in-middle-of-other-operation cases.)
> >
>
> This surprises me because the difference in "safety" is very
> explicitly expressed and implemented in an option
> "can_switch_when_in_progress", which is driven purely by "checkout vs
> switch", and determines whether the validations in
> die_if_some_operation_in_progress() apply - dying on merge, am, rebase
> cherry-pick, or revert.

The implementation was done that way, not because _anyone_ thought
that was the right design, but because Duy wanted to introduce a new
command without touching the existing command, so that he only had to
deal with review comments about the new command.  Two people commented
on it at the time, one of them me, saying that we should just change
checkout and fix it.  But it was decided to leave it for later...

> If we are comfortable changing the behavior of branch checkout to be
> safe-and-limiting like switch, then that should be almost as simple as
> removing that condition.

I've never heard a dissenting vote against this, and I've brought it
up a few times.  Junio elsewhere in this thread agrees we should just
change it.

Besides, this is typically the way backward incompatibilities are
handled in Git: First make something a warning, then make it an error,
then wait a while, then change the thing (e.g. git push defaults).
For simpler cases, you can jump straight to an error, especially when
not giving an error can hurt users and is unlikely to be what users
meant anyway.  This is a case where it can really hurt.

> The wrinkle is that I believe "--force"
> should still be allowed at least in the cases where it is safe
> (whereas currently switch does *not* allow even --force if a merge is
> in progress, and this proposed patch accidentally "fixed" that for the
> same-commit case only).

I'd be okay with an override.

[...]
> >
> > More importantly, though...
> >
> > > Change the behavior of "git switch" and "git checkout" to no longer d=
elete
> > > merge metadata, nor prohibit the switch, if a merge is in progress an=
d the
> > > commit being switched to is the same commit the HEAD was previously s=
et to.
> >
> > Even if there are conflicts?  For rebases, cherry-picks, ams, and
> > reverts too?  (Does allowing this during rebases and whatnot mean that
> > --abort becomes really funny?  Does it mean that some commits are
> > applied to one branch, and all commits are applied to another?  What
> > about autostashes?  Does it interact weirdly with --update-refs?
> > etc.)
>
> I believe this question was resolved later in the thread. The proposal
> is to allow the simplest case of merge only, for resolved
> (unconflicted) indexes only. If the change were to make sense I could
> update this message to be clearer that none of those other operations
> or situations are impacted by this change.

As I mentioned to Junio, I understood fully that your implementation
limited the changes to this one case.  That did not resolve my
concerns, it merely obviated some other bigger ones that I didn't
raise.

However, making it only available via a --force override (and then
perhaps also limiting it to just some operations), would resolve my
concerns.

> > My first gut guess is that switching with conflicts would be just as
> > safe as this is, and any users who likes your change is going to
> > complain if we don't allow it during conflicts.
>
> In principle I believe so too, I just haven't checked whether the
> tree-merge process attempts to do anything for a same-commit switch,
> and if it does, whether the presence of conflict data "bothers" it in
> any way / causes it to do the wrong thing, eg remove it.
>
> If verifying this and opening up the "pending conflicts" case meets
> the consistency itch, I'm happy to explore this area and (try to)
> expand the scope of the fix/exemption.

If this behavior is behind a `--force` flag rather than the default
behavior, then I think there's much more leniency for a partial
solution.

That said, I do still think it'd be nice to handle this case for
consistency, so if you're willing to take a look, that'd be great.  If
you are interested, here's a pointer: Stolee's commit 313677627a8
("checkout: add simple check for 'git checkout -b'", 2019-08-29) might
be of interest here.  Essentially, when switching to a same-commit
branch, you can short-circuit most of the work and basically just
update HEAD.  (In his case, he was creating _and_ switching to a
branch, and he was essentially just trying to short-circuit the
reading and writing of the index since he knew there would be no
changes, but the same basic logic almost certainly applies to this
broader case -- no index changes are needed, so the existence of
conflicts shouldn't matter.)

If you don't want to handle that case, though, you should probably
think about what kind of message to give the user if they try to
`--force` the checkout and they have conflicts.  They'd probably
deserve a longer explanation due to the inconsistency.

> > But I think it'd take
> > a fair amount of work to figure out if it's safe during
> > rebase/cherry-pick/am/revert (is it only okay on the very first patch
> > of a series?  And only if non-interactive?  And only without
> > --autostash and --update-refs?  etc.), and whether the ending set of
> > rules feels horribly inconsistent or feels fine to support.
>
> I agree this gets complicated - I haven't thought or explored through
> most of these, but I have confirmed that switching branch in the
> middle of a *rebase* is very confusing: your rebase continues on the
> new HEAD, as you continue to commit, your rebased commits get
> committed to the branch you switched to, but at the end when you
> *complete* the rebase, the original ref you were rebasing still ends
> up being pointed to the new HEAD - so you end up with *both* the
> branch you were rebasing, and the branch you switched to along the
> way, pointing to the same head commit.
>
> I understand how that works in terms of git's internal logic, but as a
> user of rebase, if I tried to switch (to a new branch) in the middle,
> I would be intending to say "I got scared of the changes I'm making
> here, I want the that is ref pointed to the new commit graph at the
> end of the process to be this new ref, instead of the ref I originally
> started on".
>
> Supporting that usecase, for rebase, sounds to me like it should be
> done by something completely different to "git switch". The most
> helpful behavior I can think of here would be that a "git switch"
> attempt would say "cannot switch branch in the middle of a rebase. to
> continue your rebase and create a new branch, use 'git rebase
> --make-new-branch NEWBRANCHNAME" instead of 'git switch'"

That all sounds reasonable.

But you know someone is going to try it anyway during a
rebase/cherry-pick/revert.  If we start letting `--force` override
during a merge, we should do something to address that inconsistency
for users.  It doesn't need to be something big; we could likely
address it by just specifically checking for the `--force` case during
a rebase/cherry-pick/revert and providing an even more detailed error
message in that case that spells out why the operation cannot be
`--force`d.

> > > Also add a warning when the merge metadata is deleted (in case of a
> > > "git checkout" to another commit) to let the user know the merge stat=
e
> > > was lost, and that "git switch" would prevent this.
> >
> > If we're touching this area, we should employ the right fix rather
> > than a half measure.  As I mentioned above, this should be an error
> > with the operation prevented -- just like switch behaves.
> >
>
> My understanding, given the code organization, was that we wanted to
> preserve current (funky) behavior for backwards-compatibility
> purposes.

I totally understand how you'd reach that conclusion.  I would
probably come to the same one reading the code for the first time.
But, as it turns out, that's not how things happened.

> If we're comfortable changing behavior here, I am happy to
> change the patch (while keeping/allowing the --force exemption, which
> *should* still destroy the merge state).

Yaay!

> > > Also add a warning when the merge metadata is preserved (same commit)=
,
> > > to let the user know the commit message prepared for the merge may st=
ill
> > > refer to the previous branch.
> >
> > So, it's not entirely safe even when the commit of the target branch
> > matches HEAD?  Is that perhaps reason to just leave this for expert
> > users to use the update-refs workaround?
> >
>
> It is *safe*, it's just that one aspect of the outcome is *potentially
> confusing*. You really did do the merge on the original branch. The
> merge message is the same as it would be if you committed, created a
> new branch, and reset the original branch.
>
> (and just to note - the reasonable workaround is to commit the merge
> on the current "wrong" branch, create the other branch, and then reset
> the original branch, as Chris Torek shows on StackOverflow; not to
> teach people all about update-refs)
>
>
> Thanks so much for taking the time to go through all this!
>
> Please let me know whether you would be comfortable with a patch that:
> * Fixed checkout to be more restrictive

Absolutely.

> (except still allowing --force at least on a merging state)

That's fine too.

> * More explicitly noted that we are relaxing things for merge only,
> none of the other in-progress states that currently prevent switch

That wouldn't resolve any of my concerns; it was totally clear to me
the first time.

> * Also worked with outstanding conflicts in the index (verifying that
> this is safe)

In combination with `--force`, I think that would be very nice.
