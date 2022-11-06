Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4E7C433FE
	for <git@archiver.kernel.org>; Sun,  6 Nov 2022 06:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKFG6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 01:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKFG6m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 01:58:42 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7144C959C
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 23:58:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j16so12741339lfe.12
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBHV2YrDBvp2yVncu+vGT745LZD/PilpZk/S2j1VBp4=;
        b=lHb59uGpt0o5xkmotWZKv7LZz5rvSYdPZSaFBXqIBFDvJ8Fe8aEj99dQ9yzpdINeRh
         t+N5ZjiYCQP3VvWqEa59HwKRwowj+OZvhiWrSyNS9iB+F4jOxn7uW+XzGuHp6qS4cht8
         /Mkn17VHMI41L5z65sXs5rxo2sX7m0Thmn8TtAZuY8xlwXNSKAGt4o5/AcgXHuyxMnG9
         9UPBkGdF8ezRiJcHGAN+yLqDQqVNQK8EXYAVRnxjuX60JjERe1Gg/NZ64oc8FADVeeFf
         4B8rEd3hadgwD0HlTCXQCkcD9GA8Nzv0kFy19GqIK92zTazkzIgxktFbgd7imq28gGbM
         dTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBHV2YrDBvp2yVncu+vGT745LZD/PilpZk/S2j1VBp4=;
        b=fRPEr/DPy9htEaN+iIHgAicv8aXJogxnzDnlA0w6Iwa960usbWSXt41Qc28Tf6kPaq
         PWYrkx8xoaRXi3546imD5h1aK1/kGoW8aaunP4vJ7cOjaOBMA/WAamtyScpy1MQx8Xt/
         PlrxIJr7Y6xx6mzuFplFAkJztXScQ0fJEIRFDCt4EuzyByd0K0vZctCFNh3CfIXx6dSI
         tN8Qz9AHv8xZJLzpuW7/ShN1BP3wEVu1Td4IYKzjUi3nBao7UClANlV3cW8yGn8Pt7jk
         6fjXNd1tliwSXFi1qTVCqlUAeR/Ar2SiNqu9QUrYnlj6FOWGPAAGROuemand7+W5uXT/
         qXrg==
X-Gm-Message-State: ACrzQf08W+Cwxa4YxMsEu5ZKV2Far7Qqhvs7UjaaCqKgtcyn9R/zsrlx
        V4qVmmLiO1+NezsZAZzBhvXrJP0BZ+HpkbNhVic=
X-Google-Smtp-Source: AMsMyM6AwE+90K2MRqTcUGHF3QgGo6/dvG161MBOaQDxOwryvsSGQBMLO6RjyHYprnKkqPDhLYduqmZ8UkQrpZQLwJc=
X-Received: by 2002:ac2:5e70:0:b0:4a9:cd8b:980b with SMTP id
 a16-20020ac25e70000000b004a9cd8b980bmr17352151lfr.516.1667717918484; Sat, 05
 Nov 2022 23:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
 <CABPp-BGUXKk-LSJtHP2jSDSVYNpQgzOeferx6xJ36ntDgrBNCw@mail.gmail.com> <CAOLTT8TceM-NpV2_hUCZj2Dx=W30f_9SHW8CcRH-pw32BRd-oA@mail.gmail.com>
In-Reply-To: <CAOLTT8TceM-NpV2_hUCZj2Dx=W30f_9SHW8CcRH-pw32BRd-oA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Nov 2022 23:58:26 -0700
Message-ID: <CABPp-BErUhzm5=c6Tn4nPFKx-Kx0tYwf-J=G+nOFJ2bu-r+Dhg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] diff: introduce scope option
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Nov 5, 2022 at 7:11 PM ZheNing Hu <adlternative@gmail.com> wrote:
> Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C 13:18=E5=86=99=E9=81=93=EF=BC=9A
> > On Sun, Oct 30, 2022 at 9:11 PM ZheNing Hu via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: ZheNing Hu <adlternative@gmail.com>
> > >
> > > When we use sparse-checkout, we often want the set of files
> > > that some commands operate on to be restricted to the
> > > sparse-checkout specification.
> >
> > It seems a bit premature to send this, when the guideline document[*]
> > detailing how these options should work is still in the "Needs Review"
> > state.  I know, it's been waiting for a while, but it's a _long_
> > document.
> >
> > [*] https://lore.kernel.org/git/pull.1367.v3.git.1665269538608.gitgitga=
dget@gmail.com/
> >
>
> Fine, I just want to start trying to experiment with this feature in
> git-diff earlier,
> and I can wait for the sparse-checkout.txt documentation to finish
> first if needed :)

Note that you may be able to help reduce the wait by reviewing the
document.  (You commented on v1 -- thanks! -- but no one has commented
on any of the newer versions, despite being out for over a month and
still being marked as "Needs Review" in the "What's cooking" reports.)

> > > `--no-scope` is the default
> > > option for now.
> >
> > What does --no-scope even mean?  You didn't explain it, and I don't
> > see how it could make sense.  We explicitly avoided a `--no-` prefix
> > by allowing the --scope option to take a value.  I don't think there
> > should be a --no-scope option.
>
> I think the =E2=80=9C--no-scope=E2=80=9D here does nothing, as if it were=
 unaffected by scope
> (just like correctly "--scope=3Dall", right?)

Reading your patch, I was unable to determine where you made
--no-scope behave differently than how you implemented --scope=3Dall.
Maybe there was a difference and I missed it.

Anyway, I don't think there should be a --no-scope option.

> > > diff --git a/Documentation/diff-options.txt b/Documentation/diff-opti=
ons.txt
> > > index 3674ac48e92..04bf83e8be1 100644
> > > --- a/Documentation/diff-options.txt
> > > +++ b/Documentation/diff-options.txt
> > > @@ -195,6 +195,24 @@ For instance, if you configured the `diff.algori=
thm` variable to a
> > >  non-default value and want to use the default one, then you
> > >  have to use `--diff-algorithm=3Ddefault` option.
> > >
> > > +ifndef::git-format-patch[]
> > > +ifndef::git-log[]
> > > +
> > > +--scope=3D{sparse|all}::
> > > +       Choose diff scope. The variants are as follows:
> > > ++
> > > +--
> > > +`--sparse`;;
> > > +       Restrict diff paths to those matching sparse-checkout specifi=
cation.
> > > +`--all`;;
> > > +       Without restriction, diff is performed regardless of whether =
the path
> > > +       meets the sparse-checkout specification.
> > > +--
> > > ++
> > > +
> > > +endif::git-log[]
> > > +endif::git-format-patch[]
> >
> > What about diff-files, diff-index, diff-tree, and show?
> >
>
> diff-options.txt included in their documents, and git-format-patch.txt,
> git-log.txt, but should not in git-format-patch.txt. I don't know if it
> should be included in git-diff-files.txt, because git diff-files compare
> the files in the working tree and the index (so it's the same as
> "simple" git-diff, which should not be affected by scope?)

Oh, good point.  Yeah, git-diff-files.txt should not get this option
as it won't have any affect.  git-diff-index and git-diff-tree and
git-show and git-log should get it, though.

> > > +int diff_path_in_sparse_checkout(const char *path) {
> > > +       if (core_sparse_checkout_cone)
> > > +               return path_in_cone_mode_sparse_checkout(path, the_re=
pository->index);
> > > +       else
> > > +               return path_in_sparse_checkout(path, the_repository->=
index);
> > > +}
> >
> > This says we are including the path if it matches the sparsity
> > patterns.  Thus, we have to be careful when we use this function,
> > because the relevant paths are ones that match the sparsity
> > specification.  The sparsity specification will always match the
> > sparsity patterns when diffing two commits, but when either the index
> > or the working tree is part of the diff, the sparsity specification
> > *might* be temporarily expanded.
>
> Yes, I may have to look at more code to better understand how and when th=
e
> "sparsity specification" is extended. Any recommendations for places to r=
ead?

Yes, please review the newer version of my sparse-checkout.txt
directions file; it covers this in more detail.

> > > @@ -439,6 +459,20 @@ static void do_oneway_diff(struct unpack_trees_o=
ptions *o,
> >
> > do_oneway_diff is for cases where we are diffing against the index...
> >
> > >                         return; /* nothing to diff.. */
> > >         }
> > >
> > > +       if (revs->diffopt.scope =3D=3D DIFF_SCOPE_SPARSE) {
> > > +               if (idx && tree) {
> > > +                       if (!diff_paths_in_sparse_checkout(idx->name,=
 tree->name))
> > > +                               return;
> > > +               } else if (idx) {
> > > +                       if (!diff_path_in_sparse_checkout(idx->name))
> > > +                               return;
> > > +               } else if (tree) {
> > > +                       if (!diff_path_in_sparse_checkout(tree->name)=
)
> > > +                               return;
> > > +               } else
> > > +                       return;
> > > +       }
> >
> > ...and you again mistakenly only compare to the sparsity patterns
> > instead of the sparse specification.
> >
>
> So here we should use ce_skip_worktree(idx) to check if this index entry =
matches
> sparse specification.

ce_skip_worktree(idx) only checks for expansions to the sparse
specification in the working tree.  If dealing with index files, the
sparse specification is also expanded to handle all files in the index
that differ from HEAD.

> > > +               } else
> > > +                       return error(_("invalid --scope value: %s"), =
optarg);
> > > +       }
> >
> > As written with no follow-on else clause here, wouldn't this silently
> > accept "--scope" without an "=3D<something>" argument without an error
> > and without properly initializing opt->scope?
> >
>
> Because opt will be initializing with default_diff_options in repo_diff_s=
etup(),
> and opt->scope should respect config value first. So I don't think there'=
s a
> mistake here.

Okay, it's good that you've got the variables initialized somehow, but
that's only half the point here.  The main point is that the user can
specify something that makes no sense and if they do, we should throw
an error informing them of their mistake.  --scope should not be
passed without an argument (either "all" or "sparse", currently), but
this code allowed it.

> > > diff --git a/t/t4070-diff-sparse-checkout-scope.sh b/t/t4070-diff-spa=
rse-checkout-scope.sh
> > > new file mode 100644
> >
> > This needs to be fixed.

Since you didn't comment on this but usually do comment on thing, I'll
just re-ping it to make sure you don't miss the comment about the
incorrect file mode here.

> > > +reset_repo () {
> > > +       rm -rf repo &&
> > > +       git clone --no-checkout temp repo
> >
> > Why --no-checkout rather than say --sparse?
> >
>
> This is because I accidentally associated it with a
> partial clone. I often use "git clone -filter=3Dblob:none -no-checkout"
> to do a partial clone, then "git sparse- checkout set <pattern>"
> to set sparse-checkout patterns, and "git checkout" to download
> the missing blobs and checkout to a branch. But in this
> test file, we only need sparse-checkout, so it's true that I should
> not do such strange no-checkout thing.

Yeah, no need to involve partial clones here.  (As an aside, though, I
think even with a partial clone that --sparse makes more sense than
--no-checkout.)

> > > +change_worktree_and_index() {
> > > +       (
> > > +               cd repo &&
> > > +               mkdir sub2 sub3 &&
> > > +               echo sub1/file3 >sub1/file3 &&
> > > +               echo sub2/file3 >sub2/file3 &&
> > > +               echo sub3/file3 >sub3/file3 &&
> > > +               echo file3 >file3 &&
> > > +               git add --all --sparse &&
> > > +               echo sub1/file3 >>sub1/file3 &&
> > > +               echo sub2/file3 >>sub2/file3 &&
> > > +               echo sub3/file3 >>sub3/file3 &&
> > > +               echo file3 >>file3
> > > +       )
> > > +}
> >
> > It would be nice to modify different paths in the working tree and
> > index, to see if we can handle cases where the sparse specification
> > does not match the sparsity patterns better.  (So, modify files inside
> > and outside the sparsity patterns, stage those changes, and then do a
> > `git sparse-checkout reapply` to make the files outside the sparsity
> > patterns disappear from the working tree...then modify different files
> > in the working tree both inside and outside the sparsity patterns.
> > And also remove some file that matches the sparsity patterns and
> > manually mark it as SKIP_WORKTREE.)  That'd give us much better
> > coverage.
> >
>
> Nice addition. So I should use git update-index --skip-worktree to set
> skip_worktree bit for index entries.

Well, I'd say use normal "sparse-checkout" commands to set most of
them.  However, adding one or two extra SKIP_WORKTREE paths via
running `git update-index --skip-worktree $PATH` (and removing the
corresponding local file) would make the testcases more interesting.

> > I think I'm going to stop reviewing here.  I'm probably just going to
> > keep repeating the same issues I identified earlier if I continue.
>
> Thank you very much for your review, you have pointed out very many
> problems with this patch :)

I'm glad it was helpful.  :)
