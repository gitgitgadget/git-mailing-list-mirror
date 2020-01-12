Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048DDC33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16F421556
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 17:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ws88dU81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbgALR7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:59:40 -0500
Received: from mout.gmx.net ([212.227.15.15]:58531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732917AbgALR7k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 12:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578851969;
        bh=iV8tE4gLIcEkV2VmaYudMG2YNE5Y3CkSqe/DFGMuX2E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ws88dU81IevLg1wF7J2slDTRcYLUe778z6OJgqJG+6pm6Jh2tet2nqCIP5ejVrsjq
         J4FhhuFqiRadp0VlBY+IdzXn4q4RriliCmClN0vgrYXbtWqy8dZTOTHkOHictovU86
         gXODkmjo4f6iUBwKldrAF2j/dDfVYpuHGb1xXJUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9gE-1iu0OD1wUO-00GYtk; Sun, 12
 Jan 2020 18:59:29 +0100
Date:   Sun, 12 Jan 2020 18:59:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am"
 to "merge"
In-Reply-To: <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com> <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com> <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com> <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com> <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KkItqwKD7XcP1XYJTqfWNYvNT92naBoAjjD6b/uggiBK2L4jU+N
 N8s4hRGPu6YDV6JDoHjW/dfFFe9uur3SH7yBWQz2v8OnET886B5MMxI9r3S0SS+sGNkoHZp
 v8HTw6ggQmFCf+suKk97S9TnK2bks22fsb6/8B/ksfEIp8O41X39caZQZVJzPhVPW0rb0L5
 cNHMxs/sVRXjFbOrQtp+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:miwZa0oeOuY=:nP2G3W3v8gwnjFHrY+qxnS
 EhuvbIbbxytjMQIcK2ufRg/9+9g7ZkQwbabdLx/TmMgIFvOn2OQIqGYxxJBbRJsNbuiNvofuV
 +KJ1F4LKOdXV4LHPKdNKMbi4b8mh7MhZaxaQZ7lNCCjLCcSHBPP7v79MG1n6Dn6GWJNAaVlVM
 jaWB5zsBYdgBezDYOv/+FIFqYWMAYrbhZJDt1GbmXjUjs3V2px1PnGlEQjDYvnJlf+94XyMOG
 7KrgUaEuF2VI/LHbnXC8D1ekrVAs6w36w7Wxl8SrdXaZL5XueX86/dyfnMx2d0cP1SceMAohW
 /krzwakCvYtsiengGOobnaFp0SqzlYjGHDbPkbMc33b9DE8i32PQbeEEqdeBh+nvOL6/tmToT
 pRFlWL4vEAIVMOs8X7WExsHVtf+ToRZBJJ4HXBFmj/uhNjueuFZ3AENJ8jCOcJY6gCTbyB71M
 dHqX6/wToF/Fb+3/QwsILwDZsDUBD1Dla8Ichf0fzLT1bHIgo23RJP4SSNaiJxD5mgIFhN3fP
 N5L4txcGENIOVn/Vo0GgkkpwHl+v+GVC9Zb68d2YbultSa6xf0utQ5dWGfNVnfGPH2zr6mQEu
 Nl6ZdERmXUgS68dRgVF6b7+iWcqASCpVXaFDn8Mu7wtjoNqReuygp30DR/OXM9RarEoLmKUtL
 UORxJZ2RI0CsGFDrnplWDa3Q3AaGTl0Q9OZuxYbfZRknPoupVO8THuEJJstTFRTIyb402K6Q0
 cUmSknbhb137/hg/+cBouWGPiZcoTvcpNQwk1TcudMAXRQ5mlvfgPgNVFvYlaP61cTBV4nD+B
 cW5I/wvYxOZcsgRXFADZcDSHgF4vkMinDXo0LZhxvKrqXP3f2MMrThM4pe+xDDNw98kmaZ+3N
 DBLeJOfbOM3cSnWyVRrXcgF/vCtCTrAwMdCFVxez8qGfpBs4MOtd14AivE0SDEam6EMQMjRjS
 Pkcp9Am7/APWAvTgn0p4Q+79J9i79Bxlk6znKj/b8298CopBrd4n6vtRs42TDJWoxWmdZF/4Z
 G2m8U+KoDf54fOI2NLW7tOufg70cfFm8KhEznWmdZgfxxonm/8P9LmNG8k8XTcmqZKlsjOVAB
 GzIj6HQhzEwvIEbyVUtfuM4YP9ZtLJmljx0v25F42fqV4nMKRGgaAcK5S9iDXBrrj0lbpk9xy
 pogETxJMsKtIsYUulM2OfAmXOLYxcfrZ6iBv17RbRhIYtpbvsUuZs5J5XGgRB7nKbopZpu05j
 n+82NJRCDFO+5lxVsLCC0NfOsI99TirKaIKOaO15mT0qxLYLMwInHlwEimNo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 11 Jan 2020, Phillip Wood wrote:

> On 11/01/2020 01:16, Elijah Newren wrote:
> >
> > On Fri, Jan 10, 2020 at 3:14 PM Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> > >
> > > Elijah Newren via GitGitGadget wrote:
> > >
> > >   1. "git rebase --am" does not invoke the post-commit hook, but "gi=
t
> > >      rebase --merge" does.  Is this behavior change intended?
> > >
> > >      Noticed because jiri[1] installs a post-commit hook that warns
> > >      about commits on detached HEAD, so this change makes rebases mo=
re
> > >      noisy in repositories that were set up using jiri.
>
> Perhaps that hook could learn not to warn if a branch is being rebased?
> git could be more helpful there by having a porcelain option to status
> that prints the branch name if we're rebasing (`git worktree --list`
> shows the branch correctly when it's being rebased but does not (yet - I
> have a patch to do it) mark the current worktree so isn't very helpful.)
>
> > I've never used a post-commit hook or seen one in the wild.  Certainly
> > wasn't intentional, but it's not clear to me if it's wrong or right
> > either.  I don't see why it would make sense to distinguish between
> > any of git rebase --am/--merge/--interactive, but it isn't too
> > surprising that by historical accident the two rebase backends which
> > happened to call git-commit behind the scenes would call a post-commit
> > hook and the other rebase backend that didn't call git-commit
> > wouldn't.
>
> Looking through the history the am based rebase has never run the post-c=
ommit
> hook as am has its own set of hooks and the scripted version used commit=
-tree.
> The merge based rebase ran `git commit` which ran the post commit hook. =
The
> interactive rebase ran the hook until and I broke it in a356ee4659b
> ("sequencer: try to commit without forking 'git commit'", 2017-11-24) an=
d
> after I fixed it in 4627bc777e ("sequencer: run post-commit hook",
> 2019-10-15). As it was broken for two years with no one noticing it can'=
t be
> that popular.

Maybe a crazy idea, but maybe not: how about running the `post-commit`
hook _only_ if `--merge` was specified explicitly, and in that case (and
guarded behind a check verifying that the `post-commit` hook _actually_
exists _and_ is executable) warn the user that this hook won't be run in
future versions?

To make things better for users who actually want to run that hook during
rebases, we could introduce a config option, say,
`rebase.runPostCommitHook` that is a tri-state (`true`, `false`,
`onlyForDashDashMerge`, at first defaulting to the last, eventually to
`false`).

Crazy? Or helpful?

> > But the big question here, is what is correct behavior?  Should rebase
> > call the post-commit hook, or should it skip it?  I haven't any clue
> > what the answer to that is.
>
> It's creating a new commit so I lean towards thinking it should run the
> post-commit hook. As an example I have a post-commit hook that prints a
> warning if a commit is created on a branch that is being rewritten by
> one of my scripts in another worktree. There are pre-commit and
> pre-rebase hooks to try and prevent that, but the warning is there as a
> last resort if those hooks are by-passed.

I guess you're right, it is quite surprising that the `post-commit` hook
is _not_ run for `--am` rebases even though commits are created.

> > >   2. GIT_REFLOG_ACTION contains "rebase -i" even though the rebase i=
s
> > >      not interactive.
>
> If this is important to people I think it should be easy enough to set
> GIT_REFLOG_ACTION to the appropriate string in builtin/rebase.c (so long
> as it hasn't already been set by the user) rather than relying on
> sequencer.c to do it.

I agree (but won't have time to implement it, so maybe I should shut up
already...)

> > Yep, as does --keep, --exec, --rebase-merges, etc.  There are lots of
> > rebases which use the interactive machinery even if they aren't
> > explicitly interactive.  I've never seen the "-i" in the reflog
> > message defined, but clearly it has always been used whenever the
> > interactive machinery was in play regardless of whether the rebase was
> > interactive.  In that regard, I figured that --merge fit in rather
> > nicely.  (And I noted the fact that reflog messages were different
> > between the backends among the "BEHAVIORAL DIFFERENCES" section of
> > git-rebase.txt).  But if others think we should just drop the -i (much
> > as we did for the bash prompt), I'd be happy with that too.  If we go
> > that route, I think I'd rather drop the -i in the reflog for all
> > rebases, not just the
> > using-the-interactive-machinery-but-not-explicitly-interactive ones.
> >
> > >   3. In circumstances I haven't pinned down yet, we get the error
> > >      message "invalid date format: @@2592000 +0000":
> > >
> > >          $ git rebase --committer-date-is-author-date --onto branch_=
K
> > >          branch_L~1 branch_L
> > >          $ git checkout --theirs file
> > >          $ git add file
> > >          $ git rebase --continue
> > >          fatal: invalid date format: @@2592000 +0000
> > >          error: could not commit staged changes.
> > >
> > >      This isn't reproducible without --committer-date-is-author-date=
.
> > >      More context (the test where it happens) is in [2].
> >
> > Interesting.  Do you happen to know if this started happening with
> > ra/rebase-i-more-options, or did it just become an issue with
> > en/rebase-backend?  I looked around at the link you provided and feel
> > a bit confused; I'm not sure which test does this or how I'd
> > reproduce.
>
> I'm confused by the test as well. As ra/rebase-i-more-options only touch=
ed the
> sequencer then any bugs would only show up in this test (which runs a
> non-interactive rebase) once en/rbease-backend switched to that backend.=
 It
> seems likely that ra/rebase-i-more-options is to blame.
>
> Jonathan - do you happen to know if your users create empty commits at a=
ll?
> and if so what do they expect rebase to do with them (and any that becom=
e
> empty when they are rebased) - cf
> https://lore.kernel.org/git/<CABPp-BEH=3D9qejeqysHYE+AJ+JPaBympZizq-bx_O=
jArYFa4xUQ@mail.gmail.com>

The double `@` looks very funny. I would be interested in seeing an MCVE.

> > >   4. I suspect the exit status in the "you need to resolve conflicts=
"
> > >      case has changed.  With rebase --am, [3] would automatically
> > >      invoke rebase --abort when conflicts are present, but with reba=
se
> > >      --merge it does not.
> > >
> > > Known?
> >
> > Nope, but I would certainly hope that "you need to resolve conflicts"
> > would result in a non-zero exit status.  If it doesn't, that sounds
> > like a bug in the interactive backend that we need to fix.  I'll dig
> > in.

Yes, exiting with status 0 would be a major bug, and I think it might even
be a bug that was introduced by me when I re-implemented the core loop of
the interactive rebase in C.

But to me it sounds as if 4. is not so about the exit code but about
aborting immediately. I do not recall seeing --am rebases to abort,
though, but to exit with error (and I saw the same behavior in interactive
rebases).

We will need to see a reduced concrete example (preferably as a new test
case) of the described behavior.

Ciao,
Dscho
