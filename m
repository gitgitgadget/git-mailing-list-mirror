Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B617C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674162078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKFiFsbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgFWVqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387653AbgFWVqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:46:34 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0123C061573
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 14:46:34 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so18246553otp.8
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pi7Ye4mLlpfJn9WCnByyBJjEal2BpQM5i1kH0snCjFo=;
        b=BKFiFsbkWap+lIeTQiWCLYDDuBAzXm8Xm3P2RmOhHUT1HOapODwUu7gSj6/29XyvBC
         rdb64616GgWTRdfSZdt6ohF/DZuTwa2tdEwaVSr2xolaLGW64xHAUjY4guIpPtyXRBK9
         jKHpOBjLUVXQ8wdIuim3oko4JaKAt9hev2gGr21lkTcIB5nj1Xu9KxyH3wQrmJsI3+0u
         sHheEF1wbh3eWJ/8xw5frbc44h0uSLW0D42EVJPM254LWLGklATfsxb1IiUCJ3Z3Z5fc
         Rcm8dqbhm557NcKKy9yIM7yrejzQ1dIzf+CJ5dIQ1DlHXXSZc0YC5fdqsn2bC19pNYA1
         CKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi7Ye4mLlpfJn9WCnByyBJjEal2BpQM5i1kH0snCjFo=;
        b=KKwqcD0U8dX5ve8Z8NtZVZqC/CAgZHqDXtEuvS3uHOvihT+CyFI/dlN9zxRuMYH/TM
         JqnQk7efUZZB7261OeFg/ihthtOZntE0M3V36USrv2wEySaWyKCZ3sf0Zz3XQ01pHT6Q
         Aw0ph8dW2CP52V9/Vt+IhY9RR1osUopEaAy4ybe4WecyKMz7/P4m5vSrTsH3fzCniDt0
         L/l/B8uHo7R4gOSaO6p+sRAVaHbl6HrIS2Vvm3dEm/3Fhj1mEYYvwfg8VxrtWkX6S/J2
         rgUEvWYC/pQoWO5NGqOl3b3eOu/u8ATA4XyTuMzJv3lkMHnRPgxaps4MLhBNQrPKQf5u
         irBQ==
X-Gm-Message-State: AOAM533023JSvi86XASsX8CBylXRmoSd6lZtxEKF1gtJCGyG8x0zwwJT
        7HNtTdcN0UQbbEO274avpmI1vcU58FVMCqUI0Us=
X-Google-Smtp-Source: ABdhPJycqRWv56KwPgq50PdGuCd1X4tMj+cDI9CRNxsMBr0i+YK5qeXlW31vIajUmOxDvkPU190WdxPfFqmc6vrWoEk=
X-Received: by 2002:a4a:8908:: with SMTP id f8mr20727747ooi.7.1592948793894;
 Tue, 23 Jun 2020 14:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR11MB27958B80E3994CEEF13971ECE5990@DM6PR11MB2795.namprd11.prod.outlook.com>
 <20200622194122.GN6531@camp.crustytoothpaste.net> <871rm6x86y.fsf@osv.gnss.ru>
 <CABPp-BHa=jppGtoDiTz_NCXrd2zhTfALb_UrQjcF-VDcv+vuNA@mail.gmail.com> <87sgelpmb2.fsf@osv.gnss.ru>
In-Reply-To: <87sgelpmb2.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Jun 2020 14:46:22 -0700
Message-ID: <CABPp-BFwNnD-zZvHjCAvvmzy1wTT3yy-smK5nCtQ937apaNmkQ@mail.gmail.com>
Subject: Re: Request for adding a simple mechanism to exclude files from Git
 merge operation
To:     Sergey Organov <sorganov@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Tiran Meltser <Tiran.Meltser@mavenir.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Amir Yosef <Amir.Yosef@mavenir.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, Jun 23, 2020 at 1:19 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Jun 23, 2020 at 5:47 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> [...]
>
> >>
> >> I believe we basically need support to apply different merge strategies
> >> to different files.
> >>
>
> [...]
>
> >> > Normally merges are symmetric, so if you want non-symmetric behavior,
> >> > you have to define what it's supposed to be.
> >>
> >> Yes, I'm ready to define what it's supposed to be. The problem is that
> >> "git merge" won't let me, due to lack of support to apply different
> >> merge strategies to different files.
> >>
> >> As I see it, first step of improvements could be to support
> >>
> >>   git merge -- <files>
> >>
> >> where selected strategy applies only to <files>, and the rest of files
> >> are kept intact (effectively applying "ours" strategy to them), along
> >> with
> >>
> >>   git merge --exclude=<files>
> >>
> >> , to be able to exclude specific files (apply "ours" only to them)
> >> rather than include.
> >>
> >> [ As a side-note, please notice that after such changes, the "ours"
> >> strategy could be deprecated (not that I think it should), as either:
> >>
> >>    git merge <branch> --
> >>
> >> or
> >>
> >>    git merge --exclude=. <branch>
> >>
> >> would do the trick. ]
> >>
> >> The next step would then be to support
> >>
> >>   git merge --force -- <files>
> >>
> >> that would force to re-merge <files> with given strategy no matter what
> >> their current status in the index is.
> >>
> >> Even though such support would be enough for my specific use-case, it
> >> doesn't provide suitable way to configure the default behavior. As a
> >> more generic solution, a new syntax for "git merge" to specify what
> >> merge strategy to apply to what files could be designed, and then
> >> ability to put that syntax into a file for "git merge" to pick would
> >> solve the problem of quasi-static configuration problem. Alternatively,
> >> even more generic .gitignore way of doing things apparently could be
> >> re-used to some degree by adding support for .gitmerge files.
> >
> > I think you'd have an uphill battle to convince me that this isn't
> > net-negative value:
> >
> >   * You can just do "git merge --no-commit ...; git restore
> > [--source=<side>] -- <pathspec>" to do what you're talking about
> > above.  I don't see the need to add extra functionality to merge,
> > especially not functionality that duplicates restore's functionality.
>
> Yeah, thanks, nice to know! I didn't, as "restore" is rather recent
> addition:
>
> $ git --version
> git version 2.20.1
> $ git help restore
> No manual entry for gitrestore
>
> However, it probably won't help with any other merge strategy anyway,
> right? E.g., think "git merge -X ours".
>
> It's already admittedly better than nothing though!

Well, I mean if we're talking about adding new features to git, then
obviously we're only going to add them to new versions; in that
context, a version from a year and a half ago is ancient.  ;-)

Going on the tangent for a second: if you can, please consider
upgrading (and to something newer than the last release, 2.27.0) in
order to help the community with testing the latest features,
refactors, and performance improvements.

> >   * The "ours" vs. "theirs" wording means you're going to have
> > intrinsic problems with rebases.  Several users will like your choice
> > of what "ours" means, the other half will complain that you've got it
> > all wrong.  I think you need to let the users decide on a case-by-case
> > basis, and we have a handy "git restore" command for letting them do
> > that already.
>
> I don't see how rebases are affected. I only suggested enhancements to
> the merge-the-procedure, the "git merge" user command. Once merge is
> finished and result is committed, there is (fortunately) now way for git
> to know how exactly the resulting content has been achieved.

Sorry, the original email from Tiran wanted to be able to record
"branch-specific" files and have merge automatically handle them
differently.  You also alluded to that when you said

"""
As a
more generic solution, a new syntax for "git merge" to specify what
merge strategy to apply to what files could be designed, and then
ability to put that syntax into a file for "git merge" to pick would
solve the problem of quasi-static configuration problem. Alternatively,
even more generic .gitignore way of doing things apparently could be
re-used to some degree by adding support for .gitmerge files.
"""

Once you record the information for which files it applies to, then
you want it to happen whenever the merge machinery fires, right?
Rebasing, cherry-picking, and reverting are all created via the merge
machinery (even if they end up recording one parent instead of more).
Said another way, if merge automatically handles these special files,
either rebase/cherry-pick/revert also handle the special files
automatically or you've just created a very inconsistent and weird
design.

If you're disclaiming your last paragraph and saying that this would
only be a manual operation where the user specifies which files they
want to specially merge, then a lot of my complaints go away.
Although...

> Nor do I see why to limit decisions to "ours" vs "theirs". I meant to
> support arbitrary merge strategies for different files. Generic feature.
>
> My thought was: if git at all supports different merge strategies, why
> not to support different strategies for different files? I don't see any
> inherent contradiction in adding of such a feature.

If you're interested in re-merging specific files, why not just call
`git merge-file` to handle each one?  It supports e.g. --ours/--theirs
(similar to merge's -Xours/-Xtheirs) and could possibly add more if
there are ones missing.  So, it seems like we already have a command
for this, even if it's less well known?

> >   * The pathspec limiting is going to be a bug factory for renaming
> > handling.  (The simplest form of which is just renaming a special path
> > to a non-special path or vice-versa and modifying both sides of
> > history.)  Rename handling can already get some pretty hairy corner
> > cases without dumping more in the mix.  I'd rather have users decide
> > what to do with paths that switched from being one of the special
> > "ours" paths to being a normal 3-way-conflict marker path.
>
> I admittedly didn't dive into such details, but I didn't suggest to
> attach any additional attributes to paths either, so there is no need to
> care about renames, as far as I'm able to see.
>
> Apparently you talk about some other feature here that I didn't suggest.

Perhaps your comments on creating a ".gitmerge" file means something
different than I understood.  If it indeed does not record pathnames,
then the rename issue goes away (though then I don't understand what
its purpose is nor the rest of your comments in that paragraph where
you suggested it).  But if your .gitmerge comments did imply something
similar to .gitattributes which specified how certain paths were to be
handled, then renaming issues would certainly arise.

> >   * I've run into "branch-specific" files in the wild and even
> > supported repositories that used them for years.  In my opinion, they
> > are almost always nasty code smells that are artifacts from
> > CVS/SVN-like thinking.  Although I wanted to stamp them out
> > immediately, there was opposition to it.  However, over time, people
> > removed those branch-specific files from the repository (and it wasn't
> > just by me or at my prodding either; many were cleaned away by others
> > without my involvement as other folks just found better ways to handle
> > things over time).  Giving special support to bad practices will just
> > enshrine them, which I'd rather avoid.
>
> I didn't suggest any specific support for "branch-specific" files, nor
> to any bad practices, as far as I'm aware.
>
> OTOH, the generic feature I suggest, as any generic feature, could
> indeed be (ab)used in multiple ways, but it's not a problem of the
> feature itself.
>
> > If someone wants to spend their time here, I can't stop them. Just be
> > aware that personally, I think it'd be a bad idea to make any
> > merge-recursive or merge-ort changes to support this kind of thing.
>
> Hopefully your attitude is caused by some misunderstanding of the aim of
> my suggestions.

Well, given that the last paragraph of your first email sounds (to me)
to be contradictory to your statements in this email, it seems quite
likely I am misunderstanding something you have said.

> > (Alternatively, if you're still convinced this is a good idea, you can
> > consider this email a heads up about potential problem areas that you
> > need to address and areas where you'll need to craft some good
> > arguments to win over those who are skeptical.)
>
> I still don't see any potential problems. Could you please give an
> explanatory example?
>
> Let me try to show my point by example. Suppose I've got a merge commit
> where part of files were merged with recursive strategy, part of files
> -- with the same recursive strategy but with -X ours, and the rest --
> with the same recursive strategy and -X theirs. What problems,
> exactly, do you expect?
>
> In fact I even fail to see how you will be able to tell it has been
> achieved with suggested feature rather than by manual resolution of all
> the conflicts, so there must be no additional problems here.
>
> What do I miss?

The problems I was raising were not with the resulting end-state tree
that users can construct or what happens with those trees once
constructed.  My problems were with expected automatic behavior from
the merge machinery coupled with incomplete specifications that
sounded to me like a pile of corner cases and bugs that I'd have to
field while trying to maintain the merge machinery logic.

Oh, and I have a problem with "branch specific" files from the email
you were responding to.  I think those are a code smell.  But my
primary concern was the expectations of some new automatic behavior
out of the merge machinery and how/if it gets configured.
