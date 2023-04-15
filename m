Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD60C7619A
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 07:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDOHDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 03:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOHDv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 03:03:51 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4B5261
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 00:03:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l7so6993213ljq.11
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681542228; x=1684134228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKP0VTtA4YgUTkWinqXxg4aJAZghG8p9zDuIzgVpq+Y=;
        b=lyEwIH4M6C9VKlSWsmHuBalrU02DrbI/Ea1tLrjCTmkSuCXmn4Pf9xvY9Fr58QEqiP
         k1Vf3nzOAwP2gapgqWOMjUNlFFF3bXB5pt/m3lO4Y9AO+L0L0VvZMz/avbgvbWmlywD2
         2BwjbaaLU6XCWTvnDg8T1Rrf9hF0h+hKSNIJe5psCBGE/8TnG5xX2OEMtSoreHe3c3os
         XDj9840Of4CMtK1X6k09NOqkWwW2rG/BeQ94mQYR6PkeKaQn2wNpWpSg1DztdDJXv618
         5MmwNAiJkRrUJXbQqtYMHGiMwH4a156hISoVpsug/lEGOWgBfaTYON+O2Y95FUqNqv1j
         Hqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681542228; x=1684134228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKP0VTtA4YgUTkWinqXxg4aJAZghG8p9zDuIzgVpq+Y=;
        b=hUZ4ddun3LGhyaQOa1bCXO3ZwIxoe02dn1Jrti371fkV9Yn6A2keooJSaD50XgOThU
         K+pLbUYwXtXeJnjzXNoaI36XY0U1IbxqVkU/wlDzgj9rDtpFfKTNQJHVcFhseI/7VgkK
         sQDEAimCrKsyXA0E7w/ocosKHzOsaKA0LLeC6PU9rtdwaUskJCDyKKV7dKcmOZ7tmzXG
         9hblabn4NfrHxz/xlaDM14pUfIoekAeC/rIXRrwKfR+d+TJPzcMgqCIXtoNhQ5iEF0Zp
         l9rdKVTZ80w/bd1FrrLFHlnmdaWgIIin5EPJFizy1Lr8sfLNkYNq+LpOqmochBJhnXh2
         lIlw==
X-Gm-Message-State: AAQBX9eS8ImE5SV0KCqIsw0hZ+l/FRjYJmBTpQVnuRG28VJD4vaH0dKI
        OP7a3v/k/I+gOgIcO8sMDGGo49xj1mDc80Us+qk=
X-Google-Smtp-Source: AKy350bz6rkr5ExtNQCPw0Vis2Cfm/Qc2voHVUxQz/Czqmd0/72CM8KxJnMLnlqhs2kQ/NidAVcf4l2n63aYyV2BIfY=
X-Received: by 2002:a2e:9916:0:b0:2a7:a52b:123e with SMTP id
 v22-20020a2e9916000000b002a7a52b123emr2670478lji.1.1681542227518; Sat, 15 Apr
 2023 00:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com> <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
In-Reply-To: <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 00:03:35 -0700
Message-ID: <CABPp-BHyvVhVKa+M-GYTG3OEmgmoaEij15BFXQ6oyDDsboxS9g@mail.gmail.com>
Subject: Re: [PATCH 4/5] Documentation: document AUTO_MERGE
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 10:58=E2=80=AFAM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Since 5291828df8 (merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a
> conflict, 2021-03-20), when using the 'ort' merge strategy, the special
> ref AUTO_MERGE is written when a merge operation results in conflicts.
> This ref points to a tree recording the conflicted state of the working
> tree and is very useful during conflict resolution. However, this ref is
> not documented.
>
> Add some documentation for AUTO_MERGE in git-diff(1), git-merge(1),
> gitrevisions(7) and in the user manual.
>
> In git-diff(1), mention it at the end of the description section, when
> we mention that the command also accepts trees instead of commits, and
> also add an invocation to the "Various ways to check your working tree"
> example.
>
> In git-merge(1), add a step to the list of things that happen "when it
> is not obvious how to reconcile the changes", under the "True merge"
> secion. Also mention AUTO_MERGE in the "How to resolve conflicts"

s/secion/section/

> section, when mentioning 'git diff'.
>
> In gitrevisions(7), add a mention of AUTO_MERGE along with the other
> special refs.
>
> In the user manual, add a paragraph describing AUTO_MERGE to the
> "Getting conflict-resolution help during a merge" section, and include
> an example of a 'git diff AUTO_MERGE' invocation for the example
> conflict used in that section. Note that for uniformity we do not use
> backticks around AUTO_MERGE here since the rest of the document does not
> typeset special refs differently.
>
> Closes: https://github.com/gitgitgadget/git/issues/1471
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  Documentation/git-diff.txt    |  8 +++++++-
>  Documentation/git-merge.txt   |  9 +++++++--
>  Documentation/revisions.txt   |  6 +++++-
>  Documentation/user-manual.txt | 27 +++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 52b679256c4..a85cc756ebc 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -102,7 +102,11 @@ If --merge-base is given, use the merge base of the =
two commits for the
>  Just in case you are doing something exotic, it should be
>  noted that all of the <commit> in the above description, except
>  in the `--merge-base` case and in the last two forms that use `..`
> -notations, can be any <tree>.
> +notations, can be any <tree>. A tree of interest is the one pointed to
> +by the special ref `AUTO_MERGE`, which is written by the 'ort' merge
> +strategy upon hitting merge conflicts (see linkgit:git-merge[1]).
> +Comparing the working tree with `AUTO_MERGE` shows changes you've made
> +so far to resolve conflicts (see the examples below).
>
>  For a more complete list of ways to spell <commit>, see
>  "SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
> @@ -152,6 +156,7 @@ Various ways to check your working tree::
>  $ git diff            <1>
>  $ git diff --cached   <2>
>  $ git diff HEAD       <3>
> +$ git diff AUTO_MERGE <4>
>  ------------
>  +
>  <1> Changes in the working tree not yet staged for the next commit.
> @@ -159,6 +164,7 @@ $ git diff HEAD       <3>
>      would be committing if you run `git commit` without `-a` option.
>  <3> Changes in the working tree since your last commit; what you
>      would be committing if you run `git commit -a`
> +<4> Changes in the working tree you've made to resolve conflicts so far.
>
>  Comparing with arbitrary commits::
>  +
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 23aefe28851..3f61389c1c2 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -196,7 +196,11 @@ happens:
>     can inspect the stages with `git ls-files -u`).  The working
>     tree files contain the result of the merge operation; i.e. 3-way
>     merge results with familiar conflict markers `<<<` `=3D=3D=3D` `>>>`.
> -5. No other changes are made.  In particular, the local
> +5. A special ref `AUTO_MERGE` is written, pointing to a tree correspondi=
ng
> +   to the current content of the working tree (including conflict marker=
s).
> +   Note that this ref is only written when the 'ort' merge strategy
> +   is used (the default).
> +6. No other changes are made.  In particular, the local
>     modifications you had before you started merge will stay the
>     same and the index entries for them stay as they were,
>     i.e. matching `HEAD`.
> @@ -336,7 +340,8 @@ You can work through the conflict with a number of to=
ols:
>
>   * Look at the diffs.  `git diff` will show a three-way diff,
>     highlighting changes from both the `HEAD` and `MERGE_HEAD`
> -   versions.
> +   versions. `git diff AUTO_MERGE` will show what changes you've
> +   made so far to resolve conlicts.

s/conlicts/conflicts/

>
>   * Look at the diffs from each branch. `git log --merge -p <path>`
>     will show diffs first for the `HEAD` version and then the
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 98b8f89bc8d..b42a2bb30a5 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -33,7 +33,8 @@ characters and to avoid word splitting.
>
>    . If '$GIT_DIR/<refname>' exists, that is what you mean (this is usual=
ly
>      useful only for `HEAD`, `FETCH_HEAD`, `ORIG_HEAD`, `MERGE_HEAD`,
> -    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD` and `BISECT_HEAD`);
> +    `REBASE_HEAD`, `REVERT_HEAD`, `CHERRY_PICK_HEAD`, `BISECT_HEAD`
> +    and `AUTO_MERGE`);
>
>    . otherwise, 'refs/<refname>' if it exists;
>
> @@ -64,6 +65,9 @@ run `git revert`.
>  when you run `git cherry-pick`.
>  `BISECT_HEAD` records the current commit to be tested when you
>  run `git bisect --no-checkout`.
> +`AUTO_MERGE` records a tree object corresponding to the state the
> +'ort' merge strategy wrote to the working tree when a merge operation
> +resulted in conflicts.
>  +
>  Note that any of the 'refs/*' cases above may come either from
>  the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.tx=
t
> index dc9c6a663a9..99e5f652e92 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1343,6 +1343,33 @@ $ git diff -3 file.txt           # diff against st=
age 3
>  $ git diff --theirs file.txt   # same as the above.
>  -------------------------------------------------
>
> +When using the 'ort' merge strategy (the default), before updating the w=
orking
> +tree with the result of the merge, Git writes a special ref named AUTO_M=
ERGE
> +reflecting the state of the tree it is about to write. Conflicted paths =
that
> +could not be automatically merged are written to this tree with conflict
> +markers, just as in the working tree. AUTO_MERGE can thus be used with
> +linkgit:git-diff[1] to show the changes you've made so far to resolve
> +conflicts. Using the same example as above, after resolving the conflict=
 we
> +get:

Mostly...  To clarify, conflicted paths *with a textual conflict* are
written with conflict markers.  Conflicted paths with non-textual
conflicts are not.  There are several conflict types that fall into
the non-textual conflict umbrella: binary files, file/directory,
symlink/directory, symlink/file, modify/delete, rename/add,
rename/delete, rename/rename (1to2), and various submodule and
directory rename conflict types as well.

The AUTO_MERGE stuff will only help with seeing how textual conflicts
were resolved, it's not much help with the non-textual conflicts.

(By contrast, the closely related --remerge-diff option to `git log`
or `git show` does help see the resolution of *both* the textual and
non-textual conflicts, but of course one can't use that option on the
current merge until after first commiting the existing changes.)



> +
> +-------------------------------------------------
> +$ git diff AUTO_MERGE
> +diff --git a/file.txt b/file.txt
> +index cd10406..8bf5ae7 100644
> +--- a/file.txt
> ++++ b/file.txt
> +@@ -1,5 +1 @@
> +-<<<<<<< HEAD:file.txt
> +-Hello world
> +-=3D=3D=3D=3D=3D=3D=3D
> +-Goodbye
> +->>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
> ++Goodbye world
> +-------------------------------------------------
> +
> +Notice that the diff shows we deleted the conflict markers and both vers=
ions,
> +and wrote "Goodbye world" instead.
> +
>  The linkgit:git-log[1] and linkgit:gitk[1] commands also provide special=
 help
>  for merges:
>
> --
> gitgitgadget
>
