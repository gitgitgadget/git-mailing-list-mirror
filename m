Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DE4C433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 09:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiKNJJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiKNJI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 04:08:59 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B533F63D2
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 01:08:33 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-370547b8ca0so100461417b3.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ixk+k5JaOmRwZii34D0SY6K4LtgW2YW1Ehvlhtdvaw=;
        b=ekvMgGWvvWsfloWA6Xi0YhEiXrAsRjR/v+YTH7u66mNkmAtSAgp/P57D8RrJj6hoJW
         OkGo+1w1cLyvhN38sON6WYrgYPN4PqiSbxleEah6fCruDCiGitMnLbOu/hdafnu/b+AH
         20PPf4qbXjmW6gEKmTO/iyBZCJbXdzV1zy14+esnriXqF+cmMHaDOvO+lldSueaJzJ4Z
         9It8jpyl+G4kzNTn6sIdV+YhOBLnUIa1iAeHXEBfQD8GibFeFmQxX6iRNtecN0LdowXb
         GLgQxsfGNKuB5CNCBbEx2yuvggKnYzEqYWMiDaGnoF5v3cyGrzW47rpL+Fr2Rs0T6yr3
         aD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Ixk+k5JaOmRwZii34D0SY6K4LtgW2YW1Ehvlhtdvaw=;
        b=hZKS9+9ZcyVfo/Wf+HGzgs9ir3MnU3fpFfFWv/9PwulHfAb/sy8I4pCLyf/O18hPWH
         4x3+OIyqhlcUdbBPl205DVWxPW5h6/PpevidRiWfPv3Tw0w5D23ZbOr9HP47zG8nIi4d
         CxYA4bgdb1Ifi++qnmXS/PiMvzltGujidezNoZE1+5K5h68OVwW03yRLjfYXSRikOzVM
         uQ2uqx9xgrrjYqiHbdTu59ljCGi722rih0UxSwUDanGQaAiGg7kRL8DfTsZgq69gf6Ov
         qgaL32QUnLaIv+i8zRbqjaSzIkqKgIEwZahSEoW7IDAk+fACqhPQ466eR2GReSGsTbh8
         cjwg==
X-Gm-Message-State: ANoB5pmeA8MSNhtw5xr35W7pikVPgMuTcJC9r3jiIGau6pUnV3QR+l/P
        5a43FyD/0ICZyNlVVQ/jBaX5fzV7oez31MSO11s=
X-Google-Smtp-Source: AA0mqf6uNBXarrCm1POXdC4Ipkuqus0Nr7KbPHDlpBo6xGVpAsMzVMiHGznMUvOII7vdBJHfPosHK3WzPjgmfsFyh6E=
X-Received: by 2002:a81:4a09:0:b0:35f:dedf:fe5 with SMTP id
 x9-20020a814a09000000b0035fdedf0fe5mr12183967ywa.408.1668416912825; Mon, 14
 Nov 2022 01:08:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
 <CABPp-BGUXKk-LSJtHP2jSDSVYNpQgzOeferx6xJ36ntDgrBNCw@mail.gmail.com>
 <CAOLTT8TceM-NpV2_hUCZj2Dx=W30f_9SHW8CcRH-pw32BRd-oA@mail.gmail.com> <CABPp-BErUhzm5=c6Tn4nPFKx-Kx0tYwf-J=G+nOFJ2bu-r+Dhg@mail.gmail.com>
In-Reply-To: <CABPp-BErUhzm5=c6Tn4nPFKx-Kx0tYwf-J=G+nOFJ2bu-r+Dhg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 14 Nov 2022 17:08:21 +0800
Message-ID: <CAOLTT8R1K7L5p3+FkUAKMOA5+KcQU3YM8Pq2Oe4u24zi+t9Nrg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] diff: introduce scope option
To:     Elijah Newren <newren@gmail.com>
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

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E6=97=A5 14:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Sat, Nov 5, 2022 at 7:11 PM ZheNing Hu <adlternative@gmail.com> wrote:
> > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=BA=8C 13:18=E5=86=99=E9=81=93=EF=BC=9A
> > > On Sun, Oct 30, 2022 at 9:11 PM ZheNing Hu via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > >
> > > > From: ZheNing Hu <adlternative@gmail.com>
> > > >
> > > > When we use sparse-checkout, we often want the set of files
> > > > that some commands operate on to be restricted to the
> > > > sparse-checkout specification.
> > >
> > > It seems a bit premature to send this, when the guideline document[*]
> > > detailing how these options should work is still in the "Needs Review=
"
> > > state.  I know, it's been waiting for a while, but it's a _long_
> > > document.
> > >
> > > [*] https://lore.kernel.org/git/pull.1367.v3.git.1665269538608.gitgit=
gadget@gmail.com/
> > >
> >
> > Fine, I just want to start trying to experiment with this feature in
> > git-diff earlier,
> > and I can wait for the sparse-checkout.txt documentation to finish
> > first if needed :)
>
> Note that you may be able to help reduce the wait by reviewing the
> document.  (You commented on v1 -- thanks! -- but no one has commented
> on any of the newer versions, despite being out for over a month and
> still being marked as "Needs Review" in the "What's cooking" reports.)
>

I've skimmed v3 in general, but haven't looked at v4 yet, I'll take a close=
r
look at it.

> > > > `--no-scope` is the default
> > > > option for now.
> > >
> > > What does --no-scope even mean?  You didn't explain it, and I don't
> > > see how it could make sense.  We explicitly avoided a `--no-` prefix
> > > by allowing the --scope option to take a value.  I don't think there
> > > should be a --no-scope option.
> >
> > I think the =E2=80=9C--no-scope=E2=80=9D here does nothing, as if it we=
re unaffected by scope
> > (just like correctly "--scope=3Dall", right?)
>
> Reading your patch, I was unable to determine where you made
> --no-scope behave differently than how you implemented --scope=3Dall.
> Maybe there was a difference and I missed it.
>
> Anyway, I don't think there should be a --no-scope option.
>

Fine, I'll get rid of it.

> > > > diff --git a/Documentation/diff-options.txt b/Documentation/diff-op=
tions.txt
> > > > index 3674ac48e92..04bf83e8be1 100644
> > > > --- a/Documentation/diff-options.txt
> > > > +++ b/Documentation/diff-options.txt
> > > > @@ -195,6 +195,24 @@ For instance, if you configured the `diff.algo=
rithm` variable to a
> > > >  non-default value and want to use the default one, then you
> > > >  have to use `--diff-algorithm=3Ddefault` option.
> > > >
> > > > +ifndef::git-format-patch[]
> > > > +ifndef::git-log[]
> > > > +
> > > > +--scope=3D{sparse|all}::
> > > > +       Choose diff scope. The variants are as follows:
> > > > ++
> > > > +--
> > > > +`--sparse`;;
> > > > +       Restrict diff paths to those matching sparse-checkout speci=
fication.
> > > > +`--all`;;
> > > > +       Without restriction, diff is performed regardless of whethe=
r the path
> > > > +       meets the sparse-checkout specification.
> > > > +--
> > > > ++
> > > > +
> > > > +endif::git-log[]
> > > > +endif::git-format-patch[]
> > >
> > > What about diff-files, diff-index, diff-tree, and show?
> > >
> >
> > diff-options.txt included in their documents, and git-format-patch.txt,
> > git-log.txt, but should not in git-format-patch.txt. I don't know if it
> > should be included in git-diff-files.txt, because git diff-files compar=
e
> > the files in the working tree and the index (so it's the same as
> > "simple" git-diff, which should not be affected by scope?)
>
> Oh, good point.  Yeah, git-diff-files.txt should not get this option
> as it won't have any affect.  git-diff-index and git-diff-tree and
> git-show and git-log should get it, though.
>
> > > > +int diff_path_in_sparse_checkout(const char *path) {
> > > > +       if (core_sparse_checkout_cone)
> > > > +               return path_in_cone_mode_sparse_checkout(path, the_=
repository->index);
> > > > +       else
> > > > +               return path_in_sparse_checkout(path, the_repository=
->index);
> > > > +}
> > >
> > > This says we are including the path if it matches the sparsity
> > > patterns.  Thus, we have to be careful when we use this function,
> > > because the relevant paths are ones that match the sparsity
> > > specification.  The sparsity specification will always match the
> > > sparsity patterns when diffing two commits, but when either the index
> > > or the working tree is part of the diff, the sparsity specification
> > > *might* be temporarily expanded.
> >
> > Yes, I may have to look at more code to better understand how and when =
the
> > "sparsity specification" is extended. Any recommendations for places to=
 read?
>
> Yes, please review the newer version of my sparse-checkout.txt
> directions file; it covers this in more detail.
>

Ok, thanks.

> > > > @@ -439,6 +459,20 @@ static void do_oneway_diff(struct unpack_trees=
_options *o,
> > >
> > > do_oneway_diff is for cases where we are diffing against the index...
> > >
> > > >                         return; /* nothing to diff.. */
> > > >         }
> > > >
> > > > +       if (revs->diffopt.scope =3D=3D DIFF_SCOPE_SPARSE) {
> > > > +               if (idx && tree) {
> > > > +                       if (!diff_paths_in_sparse_checkout(idx->nam=
e, tree->name))
> > > > +                               return;
> > > > +               } else if (idx) {
> > > > +                       if (!diff_path_in_sparse_checkout(idx->name=
))
> > > > +                               return;
> > > > +               } else if (tree) {
> > > > +                       if (!diff_path_in_sparse_checkout(tree->nam=
e))
> > > > +                               return;
> > > > +               } else
> > > > +                       return;
> > > > +       }
> > >
> > > ...and you again mistakenly only compare to the sparsity patterns
> > > instead of the sparse specification.
> > >
> >
> > So here we should use ce_skip_worktree(idx) to check if this index entr=
y matches
> > sparse specification.
>
> ce_skip_worktree(idx) only checks for expansions to the sparse
> specification in the working tree.  If dealing with index files, the
> sparse specification is also expanded to handle all files in the index
> that differ from HEAD.
>

I will read more code to understand this detail.

> > > > +               } else
> > > > +                       return error(_("invalid --scope value: %s")=
, optarg);
> > > > +       }
> > >
> > > As written with no follow-on else clause here, wouldn't this silently
> > > accept "--scope" without an "=3D<something>" argument without an erro=
r
> > > and without properly initializing opt->scope?
> > >
> >
> > Because opt will be initializing with default_diff_options in repo_diff=
_setup(),
> > and opt->scope should respect config value first. So I don't think ther=
e's a
> > mistake here.
>
> Okay, it's good that you've got the variables initialized somehow, but
> that's only half the point here.  The main point is that the user can
> specify something that makes no sense and if they do, we should throw
> an error informing them of their mistake.  --scope should not be
> passed without an argument (either "all" or "sparse", currently), but
> this code allowed it.
>

Ah, it makes sense, I will fix it.

> > > > diff --git a/t/t4070-diff-sparse-checkout-scope.sh b/t/t4070-diff-s=
parse-checkout-scope.sh
> > > > new file mode 100644
> > >
> > > This needs to be fixed.
>
> Since you didn't comment on this but usually do comment on thing, I'll
> just re-ping it to make sure you don't miss the comment about the
> incorrect file mode here.
>

Yes, I've noticed the file permissions issue here, but there may be some ot=
her
issues with this test file: it fails when running CI tests, presumably
because of
some shell syntax incompatibility.

> > > > +reset_repo () {
> > > > +       rm -rf repo &&
> > > > +       git clone --no-checkout temp repo
> > >
> > > Why --no-checkout rather than say --sparse?
> > >
> >
> > This is because I accidentally associated it with a
> > partial clone. I often use "git clone -filter=3Dblob:none -no-checkout"
> > to do a partial clone, then "git sparse- checkout set <pattern>"
> > to set sparse-checkout patterns, and "git checkout" to download
> > the missing blobs and checkout to a branch. But in this
> > test file, we only need sparse-checkout, so it's true that I should
> > not do such strange no-checkout thing.
>
> Yeah, no need to involve partial clones here.  (As an aside, though, I
> think even with a partial clone that --sparse makes more sense than
> --no-checkout.)
>

Using --sparse may indeed be better than -no-checkout, as there is no
need to perform an additional checkout after using clone --no-checkout
and sparse-checkout. But it uses sparse-checkout cone mode by default.

A little curious, why can't we specify --no-cone mode when doing git clone
and why can't we specify sparse-checkout patterns here? If such a feature
is available, git clone and git sparse-checkout will be combined in one ste=
p.

> > > > +change_worktree_and_index() {
> > > > +       (
> > > > +               cd repo &&
> > > > +               mkdir sub2 sub3 &&
> > > > +               echo sub1/file3 >sub1/file3 &&
> > > > +               echo sub2/file3 >sub2/file3 &&
> > > > +               echo sub3/file3 >sub3/file3 &&
> > > > +               echo file3 >file3 &&
> > > > +               git add --all --sparse &&
> > > > +               echo sub1/file3 >>sub1/file3 &&
> > > > +               echo sub2/file3 >>sub2/file3 &&
> > > > +               echo sub3/file3 >>sub3/file3 &&
> > > > +               echo file3 >>file3
> > > > +       )
> > > > +}
> > >
> > > It would be nice to modify different paths in the working tree and
> > > index, to see if we can handle cases where the sparse specification
> > > does not match the sparsity patterns better.  (So, modify files insid=
e
> > > and outside the sparsity patterns, stage those changes, and then do a
> > > `git sparse-checkout reapply` to make the files outside the sparsity
> > > patterns disappear from the working tree...then modify different file=
s
> > > in the working tree both inside and outside the sparsity patterns.
> > > And also remove some file that matches the sparsity patterns and
> > > manually mark it as SKIP_WORKTREE.)  That'd give us much better
> > > coverage.
> > >
> >
> > Nice addition. So I should use git update-index --skip-worktree to set
> > skip_worktree bit for index entries.
>
> Well, I'd say use normal "sparse-checkout" commands to set most of
> them.  However, adding one or two extra SKIP_WORKTREE paths via
> running `git update-index --skip-worktree $PATH` (and removing the
> corresponding local file) would make the testcases more interesting.
>

Get it.

> > > I think I'm going to stop reviewing here.  I'm probably just going to
> > > keep repeating the same issues I identified earlier if I continue.
> >
> > Thank you very much for your review, you have pointed out very many
> > problems with this patch :)
>
> I'm glad it was helpful.  :)

Thanks.

ZheNing Hu
