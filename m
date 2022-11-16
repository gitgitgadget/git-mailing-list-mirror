Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0529C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 10:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiKPKEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 05:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiKPKEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 05:04:35 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98C0116A
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 02:04:34 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id r3so20361500yba.5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 02:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCKyDQlBo43PS6sUd3Jj+zh6PDBo3+blIBluOQDYJSo=;
        b=oUrieLdtjclk5/EuUhOgf0sAGp4UI4POlrFHRZYR+QdWW/XzpuHbZ0iTjEUwzrYo8v
         l/Hp440OncTa9IBqFaT9Bhyz7dqF8a2+P6Auuqx00F/6wHmZK+AbZTBMDx2JXPP8rPSZ
         VC88LnVRa9I2vOD8DRaIhOnN2q5uaipmn7P2yyfVQk/pN3Nbh4z5XWAsFif5feCCCowG
         13RGWrESwP2M2glPbP0Cpjx1Bqmp7rZ58Y9nzNeJGR7rd1lnYJHkGmtleKT64lMuAaAw
         Lq/PSsogTCLhUoqQNNKvRw8RjUHJc7Axz0B6tOKsLE4mxVzvgwo6zXJQZMNyIbo1kA6y
         fqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCKyDQlBo43PS6sUd3Jj+zh6PDBo3+blIBluOQDYJSo=;
        b=IcttwEsFr650uLkXM2oeVPWv++YIen+vFnwtfSNh+WaCcKPEgThJEdpiuOQz7ac4aV
         oNS6Qv/jxtkwMZZws7wOV8HvXa24seP9RCkWFO10JcX2nqRdUnd/tjJ2IvjeeDktNWL+
         DRFsz/NpkwyqqVYmUv4IWn5g6m3VMHk/S3BuQeezLQ3AeTpgk01Nqgs1sdrUynfP0lcY
         Ck9Nw9u6ddMxWKJKN6hOWHDJWp2Sn7zLlLtpUnlWrwCvz9xd3voiUllnAQMzOGt+4hzd
         cX0ZGCvEivtWpBTmIgb2CZP7SsxKFoyeUxXeyPIe+esjbdKJIIEBlOJ9sNBTj89RFB9b
         gzcg==
X-Gm-Message-State: ANoB5pn9qKdoqAWVL/L0TrbwXLh0wdRIJ+jbgDzOnCoVWJUi9nzchsOW
        ahimAdC7kdLDlNgTsQM+AQ5fSHWW158ytt5lcjLXVn1QxsTDzJ0i
X-Google-Smtp-Source: AA0mqf4X596Buuf3KeoQIMeumZaFYoP/2x/KZVO+ZIjuccQ9SqtY0xJWwpAkfliApfeSSmxTmUqbOBpFg105fMPU0WU=
X-Received: by 2002:a25:8f91:0:b0:6dd:5646:21b3 with SMTP id
 u17-20020a258f91000000b006dd564621b3mr20555519ybl.300.1668593073805; Wed, 16
 Nov 2022 02:04:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
In-Reply-To: <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 16 Nov 2022 18:04:21 +0800
Message-ID: <CAOLTT8QOr-zTHBPLx5jibzQ6Co8a3VApgLEGRu0b+ht-VJh0nw@mail.gmail.com>
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

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 13:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 14, 2022 at 8:03 PM ZheNing Hu <adlternative@gmail.com> wrote=
:
> > Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=
=E5=B9=B411=E6=9C=886=E6=97=A5=E5=91=A8=E6=97=A5 14:04=E5=86=99=E9=81=93=EF=
=BC=9A
> [...]
> > > +sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used =
to
> > > +       define the set of files of interest.  A warning: It is easy t=
o
> > > +       over-use this term (or the shortened "patterns" term), for tw=
o
> > > +       reasons: (1) users in cone mode specify directories rather th=
an
> > > +       patterns (their directories are transformed into patterns, bu=
t
> > > +       users may think you are talking about non-cone mode if you us=
e the
> > > +       word "patterns"), and (b) the sparse specification might
> >
> > nit: s/(b)/(2)/g
>
> Thanks.
>
> > > +sparse specification: The set of paths in the user's area of focus. =
 This
> > > +       is typically just the tracked files that match the sparsity
> > > +       patterns, but the sparse specification can temporarily differ=
 and
> > > +       include additional files.  (See also "Sparse specification
> > > +       vs. sparsity patterns")
> > > +
> > > +       * When working with history, the sparse specification is exac=
tly
> > > +         the set of files matching the sparsity patterns.
> > > +       * When interacting with the working tree, the sparse specific=
ation
> > > +         is the set of tracked files with a clear SKIP_WORKTREE bit =
or
> > > +         tracked files present in the working copy.
> >
> > I'm guessing what you mean here is:
> > Some files are stored with a flag bit of !SKIP_WORKTREE in its index en=
try.
> > But files are "vivifying" (restore to worktree) or new files added to
> > index (tracked files),
> > they also belong to the sparse specification.
>
> For this case, when interacting with the working tree, I mean the
> union of the following two sets of files:
>   * files with !SKIP_WORKTREE in the index entry
>   * files present in the working copy whose index entry has the
> SKIP_WORKTREE bit set.
>

Precise description. This is consistent with the behavior in
clear_skip_worktree_from_present_files().

> The fact that files might be new index entries (i.e. newly tracked
> files) is irrelevant; it only matters whether such files fit into one
> of the two categories above or not.
>

Okay.

> The fact that files have been "vivified" is slightly ambiguous and
> thus a bad way to define this set.  When git vivifies files, it'll
> clear the SKIP_WORKTREE bit.  If an editor, or script external to git,
> or something else restores the file, it will likely overlook that
> detail.  We want vivified files to be part of the sparse specification
> when interacting with the working tree regardless of whether the
> SKIP_WORKTREE bit was correctly updated, so I defined it the way I did
> to remove such ambiguity.  (I guess I should note that as per
> af6a51875a ("repo_read_index: clear SKIP_WORKTREE bit from files
> present in worktree", 2022-01-14), git will clear the SKIP_WORKTREE
> bit for files present in the working copy as one of the first things
> it does, but that could leave people wondering whether I meant the
> SKIP_WORKTREE bit was set as of the time of git invocation.  So, I
> explicitly call out files present in the working copy for which the
> index entry has the SKIP_WORKTREE bit set, so folks know these files
> are definitely included in the sparse specification.)
>

You are right: the definition of vivifying explicitly clears the
SKIP_WORKTREE bit from the index, So the behavior described
here is not vivifying, but very much like vivifying: clear the
SKIP_WORKTREE bit from index_entry in memory instead of actually
clearing it from the index on disk.

Anyway, for the file on "worktree", we can use ce_skip_worktree(ce)
to check if it belongs to the sparse specification.

> > I think we can add some examples to describe these terms.
> >
> > #!/bin/sh
> >
> > set -x
> >
> > rm -rf mono-repo
> > git init mono-repo -b main
> > (
> >   cd mono-repo &&
> >   mkdir p1 p2 &&
> >   echo a >p1/a &&
> >   echo b >p1/b &&
> >   echo a >p2/a &&
> >   echo b >p2/b &&
> >   git add . &&
> >   git commit -m ok &&
> >   git sparse-checkout set p1 &&
> >   git ls-files -t &&
> >   echo a >>p1/a &&
> >   echo b >>p1/b &&
> >   mkdir p2 p3 &&
> >   echo next >>p2/a &&
> >   echo next >>p3/c &&
> >   git add p3/c &&

Here I forget a "--sparse"

> >   # p2/a and p3/c vivify
> >   git ls-files -t &&
> >   # compare wortree/commit
> >   git --no-pager diff HEAD --name-only
> > )
>
> You've added a bunch of code with this example, but you have not said
> what the output should be, so how exactly does this help describe the
> terms?
>

We create a repo with two sub projects p1/ p2/, then set
sparsity directory p1.

First git ls-files -t outputs:

H p1/a
H p1/b
S p2/a
S p2/b

It shows that index entries in p2 are skip-worktree.
Then we restore p2/a in the working tree and create a
new file p3/c and add it to the index.

The second git ls-files -t output:

H p1/a
H p1/b
H p2/a
S p2/b
H p3/c

p2/a and p3/c are not in sparse patterns, but they are in
sparse specification. It's like a special "vivifying".

> > > +       * When modifying or showing results from the index, the spars=
e
> > > +         specification is the set of files with a clear SKIP_WORKTRE=
E bit
> > > +         or that differ in the index from HEAD.
> >
> > #!/bin/sh
> >
> > set -x
> >
> > rm -rf mono-repo
> > git init mono-repo -b main
> > (
> >   cd mono-repo &&
> >   mkdir p1 p2 &&
> >   echo a >p1/a &&
> >   echo b >p1/b &&
> >   echo a >p2/a &&
> >   echo b >p2/b &&
> >   git add . &&
> >   git commit -m ok &&
> >   git sparse-checkout set p1 &&
> >   git update-index --chmod=3D+x p2/a &&
> >   # compare commit/index
> >   git --no-pager diff --cached --name-only
> > )
>
> Same issue here; you haven't stated the expected output of these
> commands, so I don't see how they help with the description at all.
>

Here only output p2/a:

p2/a is out of sparse patterns, but this index entry mode has been
changed compared to HEAD. So we should consider it as a part of
sparse specification.

> Perhaps it's worth noting why I think the sparse specification should
> be extended when dealing with the index:
>
>   * "mergy" commands (merge, rebase, cherry-pick, am, revert) can
> modify the index outside the sparsity patterns, without creating a
> commit.
>   * `git commit` (or `rebase --continue`, or whatever) will create a
> commit from whatever staged versions of files there are
>   =3D> `git status` should show what is about to be committed
>   =3D> `git diff --cached --name-only` ought to be usable to show what
> is to be committed
>   =3D> `git grep --cached ...` ought to be usable to search through what
> is about to be committed
>
> See also https://lore.kernel.org/git/CABPp-BESkb=3D04vVnqTvZyeCa+7cymX7ro=
sUW3rhtA02khMJKHA@mail.gmail.com/
> (starting with the paragraph with "leery" in it), and the thread
> starting there.  If the sparse specification is not expanded, users
> will get some nasty surprises, and the only other alternative I can
> think of to avoid such surprises would be making several commands
> always run full tree.  Running full-tree with a non-default option to
> run sparse forces behavior A folks into a "pick your poison"
> situation, which is not nice.  Extending the sparse specification to
> include files whose index entries do not match HEAD for index-related
> operations provides the nice middle ground that avoids such usability
> problems while also allowing users to avoid operating on a full tree.
>

I can understand the reason why we need to extend sparse specification:
index often needs to handle files that are not in the sparse pattern.

> [...]
> >  I think A's users might need a little more refinement.
> >
> > A: Some users are _only_ interested in the sparse portion of the repo,
> > but they don't want to download all the blobs, they can accept to downl=
oad
> > other data later using partial-clone, which can reduce the local storag=
e size.
> > (Current default behavior)
>
> Behavior A is definitely not the current default behavior.  Also,
> behavior A is not tied to partial clones; some users may well want it
> even with a dense clone, so we need to avoid suggesting it is only for
> users with partial clones.  (Though, if users are using partial clones
> with behavior A, then I agree with the part you wrote other than your
> parenthetical comment.)
>

Makes sense. This should be considered scalar-style behavior.

> > A** : Some users are _only_ interested in the sparse portion of the rep=
o,
> > but they want to download all the blobs in it to avoid some unnecessary
> > network connections afterwards.
>
> Here you just repeated `A*` but relabelled it as `A**`.  Yes, this one
> is explicitly tied to partial clone behavior.

Ah,  `A*` part say =E2=80=9Cso things like `git log -S${SEARCH_TERM} -p`
or `git grep ${SEARCH_TERM} OLDREV ` would need to be prepared to provide
partial results that depend on what happens to have been downloaded."

So I think it's probably a lot like the behavior after a shallow
clone: git log -p or other
git commands returning partial results.

The expectation of A** is to have all blobs under the entire sparse-pattern=
s.

>
> [...]
> > > +    The fact that files can move between the 'tracked' and 'untracke=
d'
> > > +    categories means some commands will have to treat untracked file=
s
> > > +    differently.  But if we have to treat untracked files differentl=
y,
> > > +    then additional commands may also need changes:
> > > +
> > > +      * status
> > > +      * clean
> > > +
> >
> > I'm a bit worried about git status, because it's used in many shells
> > (e.g. zsh) i
> > in the git prompt function. Its default behavior is restricted, otherwi=
se users
> > may get blocked when they use zsh to cd to that directory. I don't know=
 how
> > to reproduce this problem (since the scenario is built on checkout to a=
 local
> > unborn branch).
>
> Could you elaborate?  I'm not sure if you are talking about an
> existing problem that you are worried about being exacerbated, or a
> hypothetical problem that could occur with changes.  Further, your
> wording is so vague about the problem, that I have no idea what its
> nature is or whether any changes to status would even possibly have
> any bearing on it.  But the suggested changes to git status are
> simply:
>

I just might have caused this in one particular case. So it's not very
important at the moment. But it's worth noting that many shells, IDEs=E2=80=
=99
git plugins
may also need to understand sparse-checkout properly, otherwise it can
 cause some usability problems.

> > > +    In particular, `status` may need to report any untracked files o=
utside
> > > +    the sparsity specification as an erroneous condition (especially=
 to
> > > +    avoid the user trying to `git add` them, forcing `git add` to di=
splay
> > > +    an error).
>
> [...]
> > > +    ls-files may be slightly special in that e.g. `git ls-files -t` =
is
> > > +    often used to see what is sparse and what is not.  Perhaps -t sh=
ould
> > > +    always work on the full tree?
> > > +
> >
> > Recently git ls-files added a --format option, perhaps this can be modi=
fied to
> > show if a file is SKIP_WORKTREE in the future.
>
> If so, then you've made my question also applicable for `--format`;
> much like -t, should --format always work on the full tree?  (Or maybe
> just when the format specifies the skip worktree bit?)
>

My personal opinion is to default to "restrict" , but we can use "git
ls-files -t -scope=3Dall"
to check all index entries
.
> [...]
> > > +  * If a config option is added (sparse.scope?) what should the valu=
es and
> > > +    description be?  "sparse" (behavior A), "worktree-sparse-history=
-dense"
> > > +    (behavior B), "dense" (behavior C)?  There's a risk of confusion=
,
> > > +    because even for Behaviors A and B we want some commands to be
> > > +    full-tree and others to operate sparsely, so the wording may nee=
d to be
> > > +    more tied to the usecases and somehow explain that.  Also, right=
 now,
> > > +    the primary difference we are focusing is just the history-query=
ing
> > > +    commands (log/diff/grep).  Previous config suggestion here: [13]
> > > +
> >
> > Maybe sparse.scope=3D{sparse, all}?
>
> I guess that's people's common first guess.  However, when you dig in,
> I think this would be badly broken -- see my response to Stolee I just
> sent out.

Ok...
