Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834FAC4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 09:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiKWJJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 04:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbiKWJIw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 04:08:52 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46D10559E
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 01:08:50 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j196so4217449ybj.2
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 01:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2ThWJgkGU9zQQGCuONsIcLXtdTAwBatYU+JGKn3nAI=;
        b=JUlaZch4ZaYI1pU+uOQ6s05fMZtWFmcfiqpjRRwIeg2DhuGt6GQi4qCgRX1wf4ze7j
         Ous9m/DmWYdDFrS/twDI6M33yywrTyo/NxLKt4DtMAZUNX4Ipp467OlQYU9WtT1MHiqj
         1qVQ7jykHFSWJAX2aNdycbCiACtGpCDhXZtQ168psWqu0z/+a/mrpASx1YN44gNgvU8j
         qmwLa1wFLOb5NwzyW+D7uZzz1RkqJLd1F07wreLn1/SLUWI88mRq9sdaFNcYFc3t4DUK
         PVzM/TC85qWos94h/iUdREQpvC8mehEyHZVCR4wjWZdJ19r3zm43UuRbrI6JKBhj9N0r
         yh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2ThWJgkGU9zQQGCuONsIcLXtdTAwBatYU+JGKn3nAI=;
        b=j4YYV6eYVvuJm+4Ywc4mMAvgbiJ2Y1Hb+biezgOLJ73DXDMxGlND9kXta6HcvsI7Ga
         +jZKY6tYfa+EBDxMmKLPBZ7uFqSedzgsvzbmQ0KFh1+pZfrObcvUQo1D5nNzxobNUAAS
         E8ap2tmrUI3kWCPaUeQJmkNFXCKGTLTtF+ywzMebt/mAqyjcm9mYlaFfRhnaQSHU56/w
         0+6IZxGOwAv0LObMgUI3X6QIdU37IJaTJlCuFjuaiwRnSWCZB8CMUa/LgLjhXMp/Tjlw
         IPR/7Zt8x3QaPGXv+mg9ngYjP3sErpHoq8etXBil50b17uPecMloJ48Y00Tsv3O39Yxb
         infw==
X-Gm-Message-State: ANoB5pn/wPpPs8H7vaHnv2Cs3U5FD71qo6tUGsq8iWTs1+wvXNVNVY7u
        LC0cQCZeVZP5y2eWvQdlmTHh5TQ1o/Wl6K8Yef8=
X-Google-Smtp-Source: AA0mqf47NTXHPWYIMuMl7k3+nSHItSsmhjKGxrkTkOw6dS+XsfIiYEf1UvAf3QvV86bKEzCMOOuU9JzYuayxH70otOM=
X-Received: by 2002:a25:2d4e:0:b0:6dc:dc81:aaf4 with SMTP id
 s14-20020a252d4e000000b006dcdc81aaf4mr8791565ybe.365.1669194529191; Wed, 23
 Nov 2022 01:08:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
 <CAOLTT8QOr-zTHBPLx5jibzQ6Co8a3VApgLEGRu0b+ht-VJh0nw@mail.gmail.com> <CABPp-BG4KVEqDBaAo0A=bjw+xeP2FxvfAtO4YRqrqHsBGSoK6g@mail.gmail.com>
In-Reply-To: <CABPp-BG4KVEqDBaAo0A=bjw+xeP2FxvfAtO4YRqrqHsBGSoK6g@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 23 Nov 2022 17:08:37 +0800
Message-ID: <CAOLTT8RAwtfFU+FHOWHvrZ7VMBuVRhYVsvDL5rjWFVveGmC7gQ@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Glen Choo <chooglen@google.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8819=E6=97=
=A5=E5=91=A8=E5=85=AD 10:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 16, 2022 at 2:04 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 13:49=E5=86=99=E9=81=93=EF=BC=9A
> > > On Mon, Nov 14, 2022 at 8:03 PM ZheNing Hu <adlternative@gmail.com> w=
rote:
> > > > Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E20=
22=E5=B9=B411=E6=9C=886=E6=97=A5=E5=91=A8=E6=97=A5 14:04=E5=86=99=E9=81=93=
=EF=BC=9A
> [...]
> > > The fact that files have been "vivified" is slightly ambiguous and
> > > thus a bad way to define this set.  When git vivifies files, it'll
> > > clear the SKIP_WORKTREE bit.  If an editor, or script external to git=
,
> > > or something else restores the file, it will likely overlook that
> > > detail.  We want vivified files to be part of the sparse specificatio=
n
> > > when interacting with the working tree regardless of whether the
> > > SKIP_WORKTREE bit was correctly updated, so I defined it the way I di=
d
> > > to remove such ambiguity.  (I guess I should note that as per
> > > af6a51875a ("repo_read_index: clear SKIP_WORKTREE bit from files
> > > present in worktree", 2022-01-14), git will clear the SKIP_WORKTREE
> > > bit for files present in the working copy as one of the first things
> > > it does, but that could leave people wondering whether I meant the
> > > SKIP_WORKTREE bit was set as of the time of git invocation.  So, I
> > > explicitly call out files present in the working copy for which the
> > > index entry has the SKIP_WORKTREE bit set, so folks know these files
> > > are definitely included in the sparse specification.)
> > >
> >
> > You are right: the definition of vivifying explicitly clears the
> > SKIP_WORKTREE bit from the index, So the behavior described
> > here is not vivifying, but very much like vivifying: clear the
> > SKIP_WORKTREE bit from index_entry in memory instead of actually
> > clearing it from the index on disk.
>
> No, the definition of vivifying in my PR does not explicitly state
> that; in fact, it doesn't even imply that it always happens.  The
> wording was:
>
> +vivifying: When a command restores a tracked file to the working tree (a=
nd
> + hopefully also clears the SKIP_WORKTREE bit in the index for that
> + file), this is referred to as "vivifying" the file.
>
> In particular, it's important to note that:
>
>   * some git commands won't even clear the SKIP_WORKTREE bit when they
> vivify files (e.g. I think git-checkout-index falls in this category,
> for example); we could never audit all codepaths and fix them all.
> But when they restore files we still consider that to be "vivifying"
> those paths whether or not they clear the SKIP_WORKTREE bit.
>
>   * I considered the restoration of files by non-git commands (e.g.
> "echo contents >filename") to also be considered "vivifying" of those
> files, and I certainly don't expect non-git commands to clear the
> SKIP_WORKTREE bit.
>

Ok, I probably understand, what you mean by vivify is the "activation" of t=
he
file, and I thought it was the "restoration" of the file state in the index
(clear SKIP_WORKTREE).

> > Anyway, for the file on "worktree", we can use ce_skip_worktree(ce)
> > to check if it belongs to the sparse specification.
>
> Yes, due to the commit af6a51875a referenced above, our implementation
> can just check this.  Except, it's !ce_skep_worktree(ce), of course.
> :-)
>

Yes, but I think I should need one or more explicit interfaces to determine
whether a file belongs to "sparse specification", instead of using
!ce_skip_worktree(ce) every time. I'll expose this interface in my next
=E2=80=9Cdiff --scope=E2=80=9D patch.

> > > > I think we can add some examples to describe these terms.
> > > >
> > > > #!/bin/sh
> > > >
> > > > set -x
> > > >
> > > > rm -rf mono-repo
> > > > git init mono-repo -b main
> > > > (
> > > >   cd mono-repo &&
> > > >   mkdir p1 p2 &&
> > > >   echo a >p1/a &&
> > > >   echo b >p1/b &&
> > > >   echo a >p2/a &&
> > > >   echo b >p2/b &&
> > > >   git add . &&
> > > >   git commit -m ok &&
> > > >   git sparse-checkout set p1 &&
> > > >   git ls-files -t &&
> > > >   echo a >>p1/a &&
> > > >   echo b >>p1/b &&
> > > >   mkdir p2 p3 &&
> > > >   echo next >>p2/a &&
> > > >   echo next >>p3/c &&
> > > >   git add p3/c &&
> >
> > Here I forget a "--sparse"
> >
> > > >   # p2/a and p3/c vivify
> > > >   git ls-files -t &&
> > > >   # compare wortree/commit
> > > >   git --no-pager diff HEAD --name-only
> > > > )
> > >
> > > You've added a bunch of code with this example, but you have not said
> > > what the output should be, so how exactly does this help describe the
> > > terms?
> > >
> >
> > We create a repo with two sub projects p1/ p2/, then set
> > sparsity directory p1.
> >
> > First git ls-files -t outputs:
> >
> > H p1/a
> > H p1/b
> > S p2/a
> > S p2/b
> >
> > It shows that index entries in p2 are skip-worktree.
> > Then we restore p2/a in the working tree and create a
> > new file p3/c and add it to the index.
> >
> > The second git ls-files -t output:
> >
> > H p1/a
> > H p1/b
> > H p2/a
> > S p2/b
> > H p3/c
> >
> > p2/a and p3/c are not in sparse patterns, but they are in
> > sparse specification. It's like a special "vivifying".
>
> What do you mean by a "special" vivifying?
>

As mentioned above, I misunderstood your "vivify". What I just
want to say here is that skip_worktree bit of these files has
been cleared, their status is "activated".

> Also, there's multiple problems with using your example so far to
> describe the sparse specification:
>
>   * You are specifying `git ls-files -t` output here, which may or may
> not ignore the sparse specification (as mentioned elsewhere in the new
> document); if it doesn't, then specifying how commands behave when
> they ignore the sparse specification as a way of describing the sparse
> specification seems less than helpful.  We could overlook that, but:
>   * You didn't specify the output for `git diff HEAD` and `git diff
> REV` was one of the cases where the sparse specification matters.

Makes sense. My example misses the point.

> Explaining how `git diff REV` works relative to the sparse
> specification seems like the point of you having an example, BUT even
> if you tried to do that with this particular example:
>   1) Users are probably left wondering whether p3/c is present in the
> working copy at the time these commands run, and thus whether it is in
> the sparse specification for that reason rather than for the reason of
> there being a difference in the index relative to HEAD.
>   2) You didn't specify the differences in the output between behavior
> A and behavior B for your example, if any, which might be needed for
> an appropriate contrast.  Further...
>   3) You picked an example where the output might be the same for both
> behavior A and behavior B, and since behavior B ignores the sparse
> specification, it's really hard to see how this example helps
> elucidate the meaning of the sparse specification.
>
> So, I'm still not seeing how this example helps describe the sparse
> specification.
>
> > > > > +       * When modifying or showing results from the index, the s=
parse
> > > > > +         specification is the set of files with a clear SKIP_WOR=
KTREE bit
> > > > > +         or that differ in the index from HEAD.
> > > >
> > > > #!/bin/sh
> > > >
> > > > set -x
> > > >
> > > > rm -rf mono-repo
> > > > git init mono-repo -b main
> > > > (
> > > >   cd mono-repo &&
> > > >   mkdir p1 p2 &&
> > > >   echo a >p1/a &&
> > > >   echo b >p1/b &&
> > > >   echo a >p2/a &&
> > > >   echo b >p2/b &&
> > > >   git add . &&
> > > >   git commit -m ok &&
> > > >   git sparse-checkout set p1 &&
> > > >   git update-index --chmod=3D+x p2/a &&
> > > >   # compare commit/index
> > > >   git --no-pager diff --cached --name-only
> > > > )
> > >
> > > Same issue here; you haven't stated the expected output of these
> > > commands, so I don't see how they help with the description at all.
> > >
> >
> > Here only output p2/a:
> >
> > p2/a is out of sparse patterns, but this index entry mode has been
> > changed compared to HEAD. So we should consider it as a part of
> > sparse specification.
>
> Same thing here about the fact that you've given an example with the
> same output under behavior A and behavior B, and since behavior B
> ignores the sparse specification, I'm not sure your example elucidates
> the sparse specification that much other than to make clear it
> includes more than the sparse patterns.  But didn't my wording already
> do that?
>
> (Note that `git diff --cached` without a revision is just inherently
> susceptible to this problem; it should always produce the same output
> under both modes.)
>

You're right. here need a commit other than HEAD for comparison.

> > > Perhaps it's worth noting why I think the sparse specification should
> > > be extended when dealing with the index:
> > >
> > >   * "mergy" commands (merge, rebase, cherry-pick, am, revert) can
> > > modify the index outside the sparsity patterns, without creating a
> > > commit.
> > >   * `git commit` (or `rebase --continue`, or whatever) will create a
> > > commit from whatever staged versions of files there are
> > >   =3D> `git status` should show what is about to be committed
> > >   =3D> `git diff --cached --name-only` ought to be usable to show wha=
t
> > > is to be committed
> > >   =3D> `git grep --cached ...` ought to be usable to search through w=
hat
> > > is about to be committed
> > >
> > > See also https://lore.kernel.org/git/CABPp-BESkb=3D04vVnqTvZyeCa+7cym=
X7rosUW3rhtA02khMJKHA@mail.gmail.com/
> > > (starting with the paragraph with "leery" in it), and the thread
> > > starting there.  If the sparse specification is not expanded, users
> > > will get some nasty surprises, and the only other alternative I can
> > > think of to avoid such surprises would be making several commands
> > > always run full tree.  Running full-tree with a non-default option to
> > > run sparse forces behavior A folks into a "pick your poison"
> > > situation, which is not nice.  Extending the sparse specification to
> > > include files whose index entries do not match HEAD for index-related
> > > operations provides the nice middle ground that avoids such usability
> > > problems while also allowing users to avoid operating on a full tree.
> > >
> >
> > I can understand the reason why we need to extend sparse specification:
> > index often needs to handle files that are not in the sparse pattern.
>
> Yep!
>
> [...]
> > > > A** : Some users are _only_ interested in the sparse portion of the=
 repo,
> > > > but they want to download all the blobs in it to avoid some unneces=
sary
> > > > network connections afterwards.
> > >
> > > Here you just repeated `A*` but relabelled it as `A**`.  Yes, this on=
e
> > > is explicitly tied to partial clone behavior.
> >
> > Ah,  `A*` part say =E2=80=9Cso things like `git log -S${SEARCH_TERM} -p=
`
> > or `git grep ${SEARCH_TERM} OLDREV ` would need to be prepared to provi=
de
> > partial results that depend on what happens to have been downloaded."
> >
> > So I think it's probably a lot like the behavior after a shallow
> > clone: git log -p or other
> > git commands returning partial results.
>
> Yes, though not being a fan of shallow clones, the comparison makes me
> recoil slightly.  ;-)
>
> > The expectation of A** is to have all blobs under the entire sparse-pat=
terns.
>
> Ah, I misread your `A**`.  I agree there are users that want to do
> this; I'm one of them.
>
> But how does that affect the results that users see from running
> operations?  Does it change any definitions or categorize any commands
> differently, or affect anything in the document?  Why is it worth
> calling out that people want full history of the paths matching the
> sparsity patterns?
>

Hmmm,It does not change the current definition of "restrict" or "scope",
because =E2=80=9Crestirct=E2=80=9D/"scope" care about the range of the "hor=
izontal" file path,
and this "A**" cares about the "vertical" historical depth. While this seem=
s
like a digression, I think it's still relevant to mention it.

I have another issue related to sparse checkout: monorepo size:

1. The user started working under project1, but he accidentally wanted
to see the content of project2, so he modified the speciation patterns, but
then he went back to working on project1. Yes, the size of the worktree is
reduced, but the size of git objects is not, and the size of the git reposi=
tory
will gradually expand accordingly.

2. Since many git commands now accidentally touch objects outside
the sparse checkout specification (e.g. accidentally downloading objects
after the last git pull), until we actually implement --scope, this reposit=
ory
size will gradually increase.

Therefore, can we create a new gc option for removing objects out of
sparse specification?

> > >
> > > [...]
> > > > > +    The fact that files can move between the 'tracked' and 'untr=
acked'
> > > > > +    categories means some commands will have to treat untracked =
files
> > > > > +    differently.  But if we have to treat untracked files differ=
ently,
> > > > > +    then additional commands may also need changes:
> > > > > +
> > > > > +      * status
> > > > > +      * clean
> > > > > +
> > > >
> > > > I'm a bit worried about git status, because it's used in many shell=
s
> > > > (e.g. zsh) i
> > > > in the git prompt function. Its default behavior is restricted, oth=
erwise users
> > > > may get blocked when they use zsh to cd to that directory. I don't =
know how
> > > > to reproduce this problem (since the scenario is built on checkout =
to a local
> > > > unborn branch).
> > >
> > > Could you elaborate?  I'm not sure if you are talking about an
> > > existing problem that you are worried about being exacerbated, or a
> > > hypothetical problem that could occur with changes.  Further, your
> > > wording is so vague about the problem, that I have no idea what its
> > > nature is or whether any changes to status would even possibly have
> > > any bearing on it.  But the suggested changes to git status are
> > > simply:
> > >
> >
> > I just might have caused this in one particular case. So it's not very
> > important at the moment. But it's worth noting that many shells, IDEs=
=E2=80=99
> > git plugins
> > may also need to understand sparse-checkout properly, otherwise it can
> >  cause some usability problems.
>
> Why do these tools need to understand sparse-checkout?  What kind of
> usability problems could occur?  Can you describe what range of issues
> can occur, or even give any specific examples?
>
> The whole point of the document is trying to address remaining
> sparse-checkout issues, and we even have a section highlighting known
> current problems.  If you know of additional issues, it would be great
> to make them known, but I cannot figure out what you might be referring
> to from these vague descriptions.


Sorry, I haven't been able to reproduce this specific example yet, and
when I find it,
I'll re-propose it.
