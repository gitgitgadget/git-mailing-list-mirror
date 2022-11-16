Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A9BC4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 05:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiKPFta (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 00:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKPFtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 00:49:25 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E00222AF
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 21:49:23 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j4so27947805lfk.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 21:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec4Vw538VPFb61qQI3k15Uhkhbucxfb9Sbi1gddX7+A=;
        b=oBWPRFLMP9UjFOJ8wOduR8M17a9Dg6ekURLh95eAdClcfY5MnnJCXZWgWjKn8183Hl
         5tLzvc3ZFKBZvMUm9tdhEOpHnlG3lCI8mp0VCdo54tJWNUD5wMXjOSCyyzb3zKSLZZi5
         G17KIjqYgPG+VaX5aNQLls/tcgwgj7kBT9ymkFB3Po8KzoCDpVUGvKJSqc1JDijCYMAb
         zNUF3RWpJTB68YAKOiK1BggcNtG2RpbypF+H4h+j8/fnhLPDdaNglUY83NcUjyjozvUB
         yZKK6sdglXOXVdD1eiCjf5ETuh+xk77mxZASe6gJZHz1cz/Vu+K/O8X79Q6kZb3fcJru
         fG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec4Vw538VPFb61qQI3k15Uhkhbucxfb9Sbi1gddX7+A=;
        b=0iLpmZ2DVgLV9plKy1kDQVvTjzYlFXdS4BcgV7PWvpzDTtr/M96z1aAKbn5A/v8fxm
         AEkyP8RGUJp9+EohG6rbA03Ls3i01XnzG1Bw+bkT5mUCxXtxHYObKg4hndVIUH9hHk82
         fm1Yf9ClUmNpvId5o1SEZI8+CKewEU1m/cbUJgK4rqLn7KLGUBogvqS+kbYzHx/iaHHY
         SbgHj0S1ooWbPZhH44KpVg8ehSLqjnbfVidC+9gv2QK/tH1Y1VLyDfHDR89JUXvXWcjT
         Ck5mIP6ZlSEB+Z1lRE+G10/DHn9H88PFHmwpX3qhdfgWmeucy4nrKTlE2NzSNZmiE2GA
         5oNQ==
X-Gm-Message-State: ANoB5plY1dn3xJDwQi0/L6FXSL6vpbxMBIqx2mHSusdqSVLL7njK2GYi
        LIV4VkFqQV2gXz7B3J9eit4netYIGNbUEA3DYaA=
X-Google-Smtp-Source: AA0mqf4MosgctN+LFNtbNRL3LNIzqZE9xeYNMtmnZF/DC1rNKzNCZ52NavK57ymPsuZ7/sAdee+21d3G6Ha2NM1QozQ=
X-Received: by 2002:ac2:5d69:0:b0:4b4:1036:bbb with SMTP id
 h9-20020ac25d69000000b004b410360bbbmr6363162lft.65.1668577761676; Tue, 15 Nov
 2022 21:49:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
In-Reply-To: <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Nov 2022 21:49:08 -0800
Message-ID: <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     ZheNing Hu <adlternative@gmail.com>
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

On Mon, Nov 14, 2022 at 8:03 PM ZheNing Hu <adlternative@gmail.com> wrote:
> Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=E5=
=B9=B411=E6=9C=886=E6=97=A5=E5=91=A8=E6=97=A5 14:04=E5=86=99=E9=81=93=EF=BC=
=9A
[...]
> > +sparsity patterns: patterns from $GIT_DIR/info/sparse-checkout used to
> > +       define the set of files of interest.  A warning: It is easy to
> > +       over-use this term (or the shortened "patterns" term), for two
> > +       reasons: (1) users in cone mode specify directories rather than
> > +       patterns (their directories are transformed into patterns, but
> > +       users may think you are talking about non-cone mode if you use =
the
> > +       word "patterns"), and (b) the sparse specification might
>
> nit: s/(b)/(2)/g

Thanks.

> > +sparse specification: The set of paths in the user's area of focus.  T=
his
> > +       is typically just the tracked files that match the sparsity
> > +       patterns, but the sparse specification can temporarily differ a=
nd
> > +       include additional files.  (See also "Sparse specification
> > +       vs. sparsity patterns")
> > +
> > +       * When working with history, the sparse specification is exactl=
y
> > +         the set of files matching the sparsity patterns.
> > +       * When interacting with the working tree, the sparse specificat=
ion
> > +         is the set of tracked files with a clear SKIP_WORKTREE bit or
> > +         tracked files present in the working copy.
>
> I'm guessing what you mean here is:
> Some files are stored with a flag bit of !SKIP_WORKTREE in its index entr=
y.
> But files are "vivifying" (restore to worktree) or new files added to
> index (tracked files),
> they also belong to the sparse specification.

For this case, when interacting with the working tree, I mean the
union of the following two sets of files:
  * files with !SKIP_WORKTREE in the index entry
  * files present in the working copy whose index entry has the
SKIP_WORKTREE bit set.

The fact that files might be new index entries (i.e. newly tracked
files) is irrelevant; it only matters whether such files fit into one
of the two categories above or not.

The fact that files have been "vivified" is slightly ambiguous and
thus a bad way to define this set.  When git vivifies files, it'll
clear the SKIP_WORKTREE bit.  If an editor, or script external to git,
or something else restores the file, it will likely overlook that
detail.  We want vivified files to be part of the sparse specification
when interacting with the working tree regardless of whether the
SKIP_WORKTREE bit was correctly updated, so I defined it the way I did
to remove such ambiguity.  (I guess I should note that as per
af6a51875a ("repo_read_index: clear SKIP_WORKTREE bit from files
present in worktree", 2022-01-14), git will clear the SKIP_WORKTREE
bit for files present in the working copy as one of the first things
it does, but that could leave people wondering whether I meant the
SKIP_WORKTREE bit was set as of the time of git invocation.  So, I
explicitly call out files present in the working copy for which the
index entry has the SKIP_WORKTREE bit set, so folks know these files
are definitely included in the sparse specification.)

> I think we can add some examples to describe these terms.
>
> #!/bin/sh
>
> set -x
>
> rm -rf mono-repo
> git init mono-repo -b main
> (
>   cd mono-repo &&
>   mkdir p1 p2 &&
>   echo a >p1/a &&
>   echo b >p1/b &&
>   echo a >p2/a &&
>   echo b >p2/b &&
>   git add . &&
>   git commit -m ok &&
>   git sparse-checkout set p1 &&
>   git ls-files -t &&
>   echo a >>p1/a &&
>   echo b >>p1/b &&
>   mkdir p2 p3 &&
>   echo next >>p2/a &&
>   echo next >>p3/c &&
>   git add p3/c &&
>   # p2/a and p3/c vivify
>   git ls-files -t &&
>   # compare wortree/commit
>   git --no-pager diff HEAD --name-only
> )

You've added a bunch of code with this example, but you have not said
what the output should be, so how exactly does this help describe the
terms?

> > +       * When modifying or showing results from the index, the sparse
> > +         specification is the set of files with a clear SKIP_WORKTREE =
bit
> > +         or that differ in the index from HEAD.
>
> #!/bin/sh
>
> set -x
>
> rm -rf mono-repo
> git init mono-repo -b main
> (
>   cd mono-repo &&
>   mkdir p1 p2 &&
>   echo a >p1/a &&
>   echo b >p1/b &&
>   echo a >p2/a &&
>   echo b >p2/b &&
>   git add . &&
>   git commit -m ok &&
>   git sparse-checkout set p1 &&
>   git update-index --chmod=3D+x p2/a &&
>   # compare commit/index
>   git --no-pager diff --cached --name-only
> )

Same issue here; you haven't stated the expected output of these
commands, so I don't see how they help with the description at all.

Perhaps it's worth noting why I think the sparse specification should
be extended when dealing with the index:

  * "mergy" commands (merge, rebase, cherry-pick, am, revert) can
modify the index outside the sparsity patterns, without creating a
commit.
  * `git commit` (or `rebase --continue`, or whatever) will create a
commit from whatever staged versions of files there are
  =3D> `git status` should show what is about to be committed
  =3D> `git diff --cached --name-only` ought to be usable to show what
is to be committed
  =3D> `git grep --cached ...` ought to be usable to search through what
is about to be committed

See also https://lore.kernel.org/git/CABPp-BESkb=3D04vVnqTvZyeCa+7cymX7rosU=
W3rhtA02khMJKHA@mail.gmail.com/
(starting with the paragraph with "leery" in it), and the thread
starting there.  If the sparse specification is not expanded, users
will get some nasty surprises, and the only other alternative I can
think of to avoid such surprises would be making several commands
always run full tree.  Running full-tree with a non-default option to
run sparse forces behavior A folks into a "pick your poison"
situation, which is not nice.  Extending the sparse specification to
include files whose index entries do not match HEAD for index-related
operations provides the nice middle ground that avoids such usability
problems while also allowing users to avoid operating on a full tree.

[...]
>  I think A's users might need a little more refinement.
>
> A: Some users are _only_ interested in the sparse portion of the repo,
> but they don't want to download all the blobs, they can accept to downloa=
d
> other data later using partial-clone, which can reduce the local storage =
size.
> (Current default behavior)

Behavior A is definitely not the current default behavior.  Also,
behavior A is not tied to partial clones; some users may well want it
even with a dense clone, so we need to avoid suggesting it is only for
users with partial clones.  (Though, if users are using partial clones
with behavior A, then I agree with the part you wrote other than your
parenthetical comment.)

> A** : Some users are _only_ interested in the sparse portion of the repo,
> but they want to download all the blobs in it to avoid some unnecessary
> network connections afterwards.

Here you just repeated `A*` but relabelled it as `A**`.  Yes, this one
is explicitly tied to partial clone behavior.

[...]
> > +    The fact that files can move between the 'tracked' and 'untracked'
> > +    categories means some commands will have to treat untracked files
> > +    differently.  But if we have to treat untracked files differently,
> > +    then additional commands may also need changes:
> > +
> > +      * status
> > +      * clean
> > +
>
> I'm a bit worried about git status, because it's used in many shells
> (e.g. zsh) i
> in the git prompt function. Its default behavior is restricted, otherwise=
 users
> may get blocked when they use zsh to cd to that directory. I don't know h=
ow
> to reproduce this problem (since the scenario is built on checkout to a l=
ocal
> unborn branch).

Could you elaborate?  I'm not sure if you are talking about an
existing problem that you are worried about being exacerbated, or a
hypothetical problem that could occur with changes.  Further, your
wording is so vague about the problem, that I have no idea what its
nature is or whether any changes to status would even possibly have
any bearing on it.  But the suggested changes to git status are
simply:

> > +    In particular, `status` may need to report any untracked files out=
side
> > +    the sparsity specification as an erroneous condition (especially t=
o
> > +    avoid the user trying to `git add` them, forcing `git add` to disp=
lay
> > +    an error).

[...]
> > +    ls-files may be slightly special in that e.g. `git ls-files -t` is
> > +    often used to see what is sparse and what is not.  Perhaps -t shou=
ld
> > +    always work on the full tree?
> > +
>
> Recently git ls-files added a --format option, perhaps this can be modifi=
ed to
> show if a file is SKIP_WORKTREE in the future.

If so, then you've made my question also applicable for `--format`;
much like -t, should --format always work on the full tree?  (Or maybe
just when the format specifies the skip worktree bit?)

[...]
> > +  * If a config option is added (sparse.scope?) what should the values=
 and
> > +    description be?  "sparse" (behavior A), "worktree-sparse-history-d=
ense"
> > +    (behavior B), "dense" (behavior C)?  There's a risk of confusion,
> > +    because even for Behaviors A and B we want some commands to be
> > +    full-tree and others to operate sparsely, so the wording may need =
to be
> > +    more tied to the usecases and somehow explain that.  Also, right n=
ow,
> > +    the primary difference we are focusing is just the history-queryin=
g
> > +    commands (log/diff/grep).  Previous config suggestion here: [13]
> > +
>
> Maybe sparse.scope=3D{sparse, all}?

I guess that's people's common first guess.  However, when you dig in,
I think this would be badly broken -- see my response to Stolee I just
sent out.
