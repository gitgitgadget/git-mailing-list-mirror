Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD0FC33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7262081E
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNn4oXjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAPGdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:33:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35629 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgAPGdF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:33:05 -0500
Received: by mail-oi1-f196.google.com with SMTP id k4so17982402oik.2
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrNQSEw8iyKRIfQzHi1hDdarpoxf3zvqGstzn3rC3Ss=;
        b=NNn4oXjzhRhwaKBxjQvVmk9ImAFpe5crjPQH2qw7NzCw/a9PfhiQmSCdMKlEabYpQZ
         kSgr9ndEpPA7347FSnhd3NZbrVs2q3Xa03o2OAK6frfqvE+QUtaGcVI0kWbgN2qAFn/W
         oSYrp2SLSEpNJjIE/dy832RIWYFGcP31mxEk9EWP/bjmkm4s03xcZbzD2mBosK5H6Pst
         XhGc53R+hAaO/dlVBeMvMgYMK8tDcRjA7mup6HHc0rElLfWlt7lRiiYKpPd80ZMOO+pd
         CHZmDdWd6x/qNCV2vI/Z3vMzTYSZxHRUK/+QBI7a2xy0lj3BdkxQOxZ+R5qDSVHpYgb2
         aPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrNQSEw8iyKRIfQzHi1hDdarpoxf3zvqGstzn3rC3Ss=;
        b=GKob56HLMtbqwrBipuEWePNmEVogr+VcksFKUpImXtOfBCTWM0xLpYqdK/Rl417lKZ
         Lp3ngyEwXkzkezI7Vj/ZLkenwXkmAd6PXE+MwwiztrEf69e2y0WsGCE1w5Rpr23nBEIP
         I6DdV2CnPNpmHlNodt4kvMkVGO4732kAlVnShinKl++wXeFG3NxPl+xazTa+0KRkRk98
         Xwdx7nKJzlruZGGXwVzJy/IMAB6jTtefFPKV1oa81Di9/XyjbtOj6csYbr6+sUNj4fdu
         S0K+J8IjpazohjQyi5jssRoumyQ4OhCO0EJ9ky5w6y+XYu+QS4eWX1kHEDWZdMDcdMMp
         paTg==
X-Gm-Message-State: APjAAAVRzCkoQR5/enu/H88rgrN4ORzG9pHYMPA8YO5RHHQ4sfPIQIdB
        g1niS2nVv1u4DCktLc63dSo5GFWV05/zB2bCCyc=
X-Google-Smtp-Source: APXvYqwJ89sAgjMlFTdkaf6BDmgiWxWX0bSchPPi2VsbetUCQ0J20Hc+XraPMk2895EbwcZl1NvnBJm2JhHW0HzFckU=
X-Received: by 2002:a05:6808:b18:: with SMTP id s24mr2890301oij.31.1579156383957;
 Wed, 15 Jan 2020 22:33:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com> <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com> <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com> <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Jan 2020 22:32:53 -0800
Message-ID: <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jonathan Nieder <jrnieder@gmail.com>,
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

Hi,

On Sun, Jan 12, 2020 at 9:59 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi,
>
> On Sat, 11 Jan 2020, Phillip Wood wrote:
>
> > On 11/01/2020 01:16, Elijah Newren wrote:
> > >
> > > On Fri, Jan 10, 2020 at 3:14 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > > >
> > > > Elijah Newren via GitGitGadget wrote:
> > > >
> > > >   1. "git rebase --am" does not invoke the post-commit hook, but "git
> > > >      rebase --merge" does.  Is this behavior change intended?
> > > >
> > > >      Noticed because jiri[1] installs a post-commit hook that warns
> > > >      about commits on detached HEAD, so this change makes rebases more
> > > >      noisy in repositories that were set up using jiri.
> >
> > Perhaps that hook could learn not to warn if a branch is being rebased?
> > git could be more helpful there by having a porcelain option to status
> > that prints the branch name if we're rebasing (`git worktree --list`
> > shows the branch correctly when it's being rebased but does not (yet - I
> > have a patch to do it) mark the current worktree so isn't very helpful.)
> >
> > > I've never used a post-commit hook or seen one in the wild.  Certainly
> > > wasn't intentional, but it's not clear to me if it's wrong or right
> > > either.  I don't see why it would make sense to distinguish between
> > > any of git rebase --am/--merge/--interactive, but it isn't too
> > > surprising that by historical accident the two rebase backends which
> > > happened to call git-commit behind the scenes would call a post-commit
> > > hook and the other rebase backend that didn't call git-commit
> > > wouldn't.
> >
> > Looking through the history the am based rebase has never run the post-commit
> > hook as am has its own set of hooks and the scripted version used commit-tree.
> > The merge based rebase ran `git commit` which ran the post commit hook. The
> > interactive rebase ran the hook until and I broke it in a356ee4659b
> > ("sequencer: try to commit without forking 'git commit'", 2017-11-24) and
> > after I fixed it in 4627bc777e ("sequencer: run post-commit hook",
> > 2019-10-15). As it was broken for two years with no one noticing it can't be
> > that popular.
>
> Maybe a crazy idea, but maybe not: how about running the `post-commit`
> hook _only_ if `--merge` was specified explicitly, and in that case (and
> guarded behind a check verifying that the `post-commit` hook _actually_
> exists _and_ is executable) warn the user that this hook won't be run in
> future versions?
>
> To make things better for users who actually want to run that hook during
> rebases, we could introduce a config option, say,
> `rebase.runPostCommitHook` that is a tri-state (`true`, `false`,
> `onlyForDashDashMerge`, at first defaulting to the last, eventually to
> `false`).
>
> Crazy? Or helpful?

Seems crazy.  Why would you want it just for --merge?  If anything, I
would think --merge should be most like --am; if some mode of rebase
were to be considered special, I'd think it'd only be the _explicitly_
interactive case.  But I don't see the justification for treating any
of the rebase modes differently.  I think the hook should be on for
all of them, or off for all of them, and I could go either way.

(Honestly, it's tempting to just fix the fact that the interactive
backend needlessly forks a "git commit" process by having it commit on
its own much like builtin/merge.c does.  Then omit calling the
post-commit hook and it behaves the same as the am backend and no one
in the world notices because no one in the world uses or cares about
that hook except a few people at Google who happen to be used to the
am-backend and even then aren't convinced whether invoking the hook or
not is right.  And if that's wrong and someone has a solid argument
about why and the harm that not calling it does, then big deal, we add
calling the hook sometime in the future...)

> > > But the big question here, is what is correct behavior?  Should rebase
> > > call the post-commit hook, or should it skip it?  I haven't any clue
> > > what the answer to that is.
> >
> > It's creating a new commit so I lean towards thinking it should run the
> > post-commit hook. As an example I have a post-commit hook that prints a
> > warning if a commit is created on a branch that is being rewritten by
> > one of my scripts in another worktree. There are pre-commit and
> > pre-rebase hooks to try and prevent that, but the warning is there as a
> > last resort if those hooks are by-passed.
>
> I guess you're right, it is quite surprising that the `post-commit` hook
> is _not_ run for `--am` rebases even though commits are created.

I guess part of the problem is whether people think of it as "new
commits" or just any commits.  "New commits" are created by "git
commit" and "git merge".  rebase and cherry-pick just create
derivatives of existing commits.  Given the existence of the
post-rewrite hook, one could argue that the distinction has merit.
I'm not sure either way, so I'm glad Emily started investigating.  I'd
rather not deal with that can of worms...  :-)

> > > >   2. GIT_REFLOG_ACTION contains "rebase -i" even though the rebase is
> > > >      not interactive.
> >
> > If this is important to people I think it should be easy enough to set
> > GIT_REFLOG_ACTION to the appropriate string in builtin/rebase.c (so long
> > as it hasn't already been set by the user) rather than relying on
> > sequencer.c to do it.
>
> I agree (but won't have time to implement it, so maybe I should shut up
> already...)
>
> > > Yep, as does --keep, --exec, --rebase-merges, etc.  There are lots of
> > > rebases which use the interactive machinery even if they aren't
> > > explicitly interactive.  I've never seen the "-i" in the reflog
> > > message defined, but clearly it has always been used whenever the
> > > interactive machinery was in play regardless of whether the rebase was
> > > interactive.  In that regard, I figured that --merge fit in rather
> > > nicely.  (And I noted the fact that reflog messages were different
> > > between the backends among the "BEHAVIORAL DIFFERENCES" section of
> > > git-rebase.txt).  But if others think we should just drop the -i (much
> > > as we did for the bash prompt), I'd be happy with that too.  If we go
> > > that route, I think I'd rather drop the -i in the reflog for all
> > > rebases, not just the
> > > using-the-interactive-machinery-but-not-explicitly-interactive ones.
> > >
> > > >   3. In circumstances I haven't pinned down yet, we get the error
> > > >      message "invalid date format: @@2592000 +0000":
> > > >
> > > >          $ git rebase --committer-date-is-author-date --onto branch_K
> > > >          branch_L~1 branch_L
> > > >          $ git checkout --theirs file
> > > >          $ git add file
> > > >          $ git rebase --continue
> > > >          fatal: invalid date format: @@2592000 +0000
> > > >          error: could not commit staged changes.
> > > >
> > > >      This isn't reproducible without --committer-date-is-author-date.
> > > >      More context (the test where it happens) is in [2].
> > >
> > > Interesting.  Do you happen to know if this started happening with
> > > ra/rebase-i-more-options, or did it just become an issue with
> > > en/rebase-backend?  I looked around at the link you provided and feel
> > > a bit confused; I'm not sure which test does this or how I'd
> > > reproduce.
> >
> > I'm confused by the test as well. As ra/rebase-i-more-options only touched the
> > sequencer then any bugs would only show up in this test (which runs a
> > non-interactive rebase) once en/rbease-backend switched to that backend. It
> > seems likely that ra/rebase-i-more-options is to blame.
> >
> > Jonathan - do you happen to know if your users create empty commits at all?
> > and if so what do they expect rebase to do with them (and any that become
> > empty when they are rebased) - cf
> > https://lore.kernel.org/git/<CABPp-BEH=9qejeqysHYE+AJ+JPaBympZizq-bx_OjArYFa4xUQ@mail.gmail.com>
>
> The double `@` looks very funny. I would be interested in seeing an MCVE.
>
> > > >   4. I suspect the exit status in the "you need to resolve conflicts"
> > > >      case has changed.  With rebase --am, [3] would automatically
> > > >      invoke rebase --abort when conflicts are present, but with rebase
> > > >      --merge it does not.
> > > >
> > > > Known?
> > >
> > > Nope, but I would certainly hope that "you need to resolve conflicts"
> > > would result in a non-zero exit status.  If it doesn't, that sounds
> > > like a bug in the interactive backend that we need to fix.  I'll dig
> > > in.
>
> Yes, exiting with status 0 would be a major bug, and I think it might even
> be a bug that was introduced by me when I re-implemented the core loop of
> the interactive rebase in C.

Ooh, that sounds interesting.  Do you have any more details?  My
simple testing here shows that we exit with status 1, so we shouldn't
have that problem unless perhaps there was something else in next
(ra/rebase-i-more-options??) or some other special conditions that was
causing it.

> But to me it sounds as if 4. is not so about the exit code but about
> aborting immediately. I do not recall seeing --am rebases to abort,
> though, but to exit with error (and I saw the same behavior in interactive
> rebases).

The aborting "immediately" wasn't done by git but by the code calling
git; following Jonathan's link you'll see the code they are
complaining about is:

func tryRebase(jirix *jiri.X, project Project, branch string) (bool, error) {
    scm := gitutil.New(jirix, gitutil.RootDirOpt(project.Path))
    if err := scm.Rebase(branch); err != nil {
        err := scm.RebaseAbort()
        return false, err
    }
    return true, nil
}

but of course, the scm.Rebase() and scm.RebaseAbort() definitions
aren't within that file so I have no idea what is really being run.

> We will need to see a reduced concrete example (preferably as a new test
> case) of the described behavior.

Yes, please.
