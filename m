Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2E8C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 23:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiAHX6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 18:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiAHX6B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 18:58:01 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF637C06173F
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 15:58:00 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b7so8570481edj.9
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 15:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JDdgUzFcgFYrKaU+/b1+Tttl5gDl4RNYuTPMA1F+CDw=;
        b=n5rYitqJfEgL0T/CwY5moxeUnzzNYJPUl4TfuuiTGpRg0Owpn8buaBa6JW/Fr3uPjt
         eOFFLPRZz3X54CKSW7H5eTlHWB4LVennJnOz/DyY1IY6lHG5r7ppNbXDu45PRj3gNEEy
         aHhlAkKR8r1HXZA4/vwuOq6r1v7+U/l5MBITTDp9u51KS2Al+DnLDFi8Fa+eBBMcMf3S
         nD8vDNTbO1mSffsHNRdVs9doS39G+H4t9svnPC5oyha1Ms8mqwWWR8XsFDeEqeww0M01
         H82dpMwPNk4rm7CB1ATH4mgC0Xq4Yji1R8fOsy0nxNonwzqpYLOJpPw4Uw/rcAHUyJyO
         Oigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JDdgUzFcgFYrKaU+/b1+Tttl5gDl4RNYuTPMA1F+CDw=;
        b=dBsx4v4cMGirfZioDjWFswPIWMedyjQ94k85TEV4CwfSANLEPFYi1bcf+Kbgf07y+q
         xGTVysBGUcfPNJbMRPpsyF+J2Bur41XhrP/tafbTvTbHxyeig2fWe1SqOoJZrIwRssoj
         iyw0Kjc1HLbhQfiRFl88VwTZLc95B/lOf4nZc/NhmkMTbC3ib2nSZazmdScRIakIJOUx
         W9XgM4QRzJJer7CniCHqMKp1rlLqC8cNiHC/rAfOlhuHXeoxxrMfEechQ+ln1yFXJK9V
         vhgPUKm7AVEg5sT0QCRU/hyTtlB7+n7D4D4xIx+47tsoy+nOQIOpTL87NKsqQqcik7gW
         lffg==
X-Gm-Message-State: AOAM5313jBGPq08oeb2ewYlBJP8W1S38+jZ+UECJlzkQE2fTsY+JT0X0
        aYEHlzLP4nqPter88+sK8kReXg+gwvPrUGWGyRY=
X-Google-Smtp-Source: ABdhPJwaE4EkUNWiZhBJxTZE/l92ZQ3TRJXdnJABYGy1j4tB4LkaXDQ683II/g7NHimsNv0Fs/5sBqvJVV+ubKCr4ME=
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr2941105ejc.192.1641686279400;
 Sat, 08 Jan 2022 15:57:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com> <3b734f89c0f2f473d71a5d3c85faec6d48a0e350.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <3b734f89c0f2f473d71a5d3c85faec6d48a0e350.1641317820.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 8 Jan 2022 15:57:48 -0800
Message-ID: <CABPp-BHadoOToWb6Kp7rUj03ZzKhzK_aFJymT_zApEw8st2ttA@mail.gmail.com>
Subject: Re: [PATCH 7/9] update-index: add tests for sparse-checkout compatibility
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Introduce tests for a variety of `git update-index` use cases, including
> performance scenarios.

Makes sense.

> Tests for `update-index add/remove` are specifically
> focused on how `git stash` uses `git update-index` as a subcommand to
> prepare for sparse index integration with `stash` in a future series.

This is possibly a tangent, but I'd rather that if we were trying to
fix `git stash`, that we instead would do so by making it stop forking
subprocesses and having it call internal API instead.  See for
example, a4031f6dc0 ("Merge branch 'en/stash-apply-sparse-checkout'
into maint", 2021-02-05) which did this.  The fact that it forks so
many subprocesses is a bug, and comes from the fact that stash is a
partial conversion from shell to C.  I think the subprocess forking is
part of the problem that causes issues for sparse-checkouts, as I
spelled out in patches 2 & 3 of the series I mentioned above.

However, that doesn't affect this series.

> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/perf/p2000-sparse-operations.sh        |   1 +
>  t/t1092-sparse-checkout-compatibility.sh | 125 +++++++++++++++++++++++
>  2 files changed, 126 insertions(+)
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-oper=
ations.sh
> index 54f8602f3c1..7dbed330160 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -118,5 +118,6 @@ test_perf_on_all git diff --cached
>  test_perf_on_all git blame $SPARSE_CONE/a
>  test_perf_on_all git blame $SPARSE_CONE/f3/a
>  test_perf_on_all git checkout-index -f --all
> +test_perf_on_all git update-index --add --remove
>
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-ch=
eckout-compatibility.sh
> index 6ecf1f2bf8e..6804ab23a27 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -630,6 +630,131 @@ test_expect_success 'reset with wildcard pathspec' =
'
>         test_all_match git ls-files -s -- folder1
>  '
>
> +test_expect_success 'update-index modify outside sparse definition' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +
> +       # Create & modify folder1/a
> +       run_on_sparse mkdir -p folder1 &&
> +       run_on_sparse cp ../initial-repo/folder1/a folder1/a &&
> +       run_on_all ../edit-contents folder1/a &&

As I've mentioned to Stolee, I'd rather these were explicitly marked
as intentionally setting up an erroneous condition.

However, that might not matter if my other series gets accepted (the
one I promised to send out yesterday, but then spent all day
responding to emails instead).  Hopefully I'll send it soon.

> +
> +       # If file has skip-worktree enabled, update-index does not modify=
 the
> +       # index entry
> +       test_sparse_match git update-index folder1/a &&
> +       test_sparse_match git status --porcelain=3Dv2 &&
> +       test_must_be_empty sparse-checkout-out &&
> +
> +       # When skip-worktree is disabled (even on files outside sparse co=
ne), file
> +       # is updated in the index
> +       test_sparse_match git update-index --no-skip-worktree folder1/a &=
&
> +       test_all_match git status --porcelain=3Dv2 &&
> +       test_all_match git update-index folder1/a &&
> +       test_all_match git status --porcelain=3Dv2

These make sense.

> +'
> +
> +test_expect_success 'update-index --add outside sparse definition' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF
> +
> +       # Create folder1, add new file
> +       run_on_sparse mkdir -p folder1 &&
> +       run_on_all ../edit-contents folder1/b &&
> +
> +       # Similar to `git add`, the untracked out-of-cone file is added t=
o the index
> +       # identically across sparse and non-sparse checkouts
> +       test_all_match git update-index --add folder1/b &&
> +       test_all_match git status --porcelain=3Dv2

The comment is not correct:

$ git add out-of-cone/file
The following paths and/or pathspecs matched paths that exist
outside of your sparse-checkout definition, so will not be
updated in the index:
out-of-cone/file
hint: If you intend to update such entries, try one of the following:
hint: * Use the --sparse option.
hint: * Disable or modify the sparsity rules.
hint: Disable this message with "git config advice.updateSparsePath false"

I might buy that `git update-index` is lower level and should be
considered the same as `git add --sparse`, but the comment should
mention that and try to sell why update-index should be equivalent to
that instead of to `git add`.

> +'
> +
> +test_expect_success 'update-index --remove outside sparse definition' '
> +       init_repos &&

> +
> +       # When `--ignore-skip-worktree-entries` is specified, out-of-cone=
 files are
> +       # not removed from the index if they do not exist on disk
> +       test_sparse_match git update-index --remove --ignore-skip-worktre=
e-entries folder1/a &&
> +       test_all_match git status --porcelain=3Dv2 &&

The file is present despite being marked to be missing, we're ignoring
the intention of the marking, and we ask for it to be removed, so we
don't remove it?

The levels of negation are _very_ confusing.  It took me a while to
unravel this.  I think the logic is something like this
  * folder1/a is marked as SKIP_WORKTREE, meaning it's not supposed to
be in the worktree.
  * and it's not.
  * We are stating that we're ignoring SKIP_WORKTREE, though, so this
looks like a regular file that has been deleted.
So, what would `git update-index --remove $FILE` do for a normal $FILE
deleted from the working copy?  According to the docs:

    --remove
           If a specified file is in the index but is missing then it=E2=80=
=99s
           removed. Default behavior is to ignore removed file.

So, the docs say it would remove it.  But you don't.


After digging around and looking at the testcase below, if I had to
guess what happened, I would say that you figured out what the
SKIP_WORKTREE behavior was, and assumed that was correct, and added a
flag that allowed you to request the opposite behavior.
Unfortunately, I think the pre-existing behavior is buggy.

Of course, there's lots of negation here.  Did I get something
backwards by chance?

> +
> +       # When the flag is _not_ specified ...

In my head I'm translating this as:

SKIP_WORKTREE =3D !worktree
--ignore-skip-worktree-entries =3D !!worktree
"flag is _not_ specified" =3D !!!worktree ?

I'm not sure I would do anything to change it, but just pointing out
it can be a little hard for others to come up to speed.

>             ...     , out-of-cone, not-on-disk files are
> +       # removed from the index
> +       rm full-checkout/folder1/a &&
> +       test_all_match git update-index --remove folder1/a &&
> +       test_all_match git status --porcelain=3Dv2 &&

Documentation/git-update-index.txt defines SKIP_WORKTREE as follows:

"Skip-worktree bit can be defined in one (long) sentence: When reading
an entry, if it is marked as skip-worktree, then Git pretends its
working directory version is up to date and read the index version
instead."

If Git is pretending the file is up-to-date, and `git update-index
--remove $UP_TO_DATE_FILE` is typically a no-op because the --remove
flag doesn't do anything when a file is present in the working copy,
then why is this the expected behavior?

I know it's the traditional behavior of update-index, but
SKIP_WORKTREE support in Git has traditionally been filled with holes.
So, was this behavior by design (despite contradicting the
documentation), or by accident?

(To be fair, I think the definition given in the manual for
SKIP_WORKTREE is horrible for other reasons, so I don't like leaning
on it.  But I used different logic above in the
--ignore-skip-worktree-entries case to arrive at the same conclusion
that the --remove behavior of update-index seems to be backwards.
Unless I missed a negation in both cases somewhere?  There are so many
floating around...)

> +       # NOTE: --force-remove supercedes --ignore-skip-worktree-entries,=
 removing
> +       # a skip-worktree file from the index (and disk) when both are sp=
ecified
> +       test_all_match git update-index --force-remove --ignore-skip-work=
tree-entries folder1/a &&
> +       test_all_match git status --porcelain=3Dv2

Makes sense.

> +'
> +
> +test_expect_success 'update-index with directories' '
> +       init_repos &&
> +
> +       # update-index will exit silently when provided with a directory =
name
> +       # containing a trailing slash
> +       test_all_match git update-index deep/ folder1/ &&
> +       grep "Ignoring path deep/" sparse-checkout-err &&
> +       grep "Ignoring path folder1/" sparse-checkout-err &&

Is this desired behavior or just current behavior?

> +
> +       # When update-index is given a directory name WITHOUT a trailing =
slash, it will
> +       # behave in different ways depending on the status of the directo=
ry on disk:
> +       # * if it exists, the command exits with an error ("add individua=
l files instead")
> +       # * if it does NOT exist (e.g., in a sparse-checkout), it is assu=
med to be a
> +       #   file and either triggers an error ("does not exist  and --rem=
ove not passed")
> +       #   or is ignored completely (when using --remove)
> +       test_all_match test_must_fail git update-index deep &&
> +       run_on_all test_must_fail git update-indexe folder1 &&

This one will fail for the wrong reason, though -- `update-indexe` is
not a valid subcommand.  (extra 'e' at the end)

> +       test_must_fail git -C full-checkout update-index --remove folder1=
 &&
> +       test_sparse_match git update-index --remove folder1 &&
> +       test_all_match git status --porcelain=3Dv2

Otherwise these seem reasonable.

> +'
> +
> +test_expect_success 'update-index --again file outside sparse definition=
' '
> +       init_repos &&
> +
> +       write_script edit-contents <<-\EOF &&
> +       echo text >>$1
> +       EOF

Copy and paste and forget to remove?  edit-contents doesn't seem to be
used in this test.

> +
> +       test_all_match git checkout -b test-reupdate &&
> +
> +       # Update HEAD without modifying the index to introduce a differen=
ce in
> +       # folder1/a
> +       test_sparse_match git reset --soft update-folder1 &&
> +
> +       # Because folder1/a differs in the index vs HEAD,
> +       # `git update-index --remove --again` will effectively perform
> +       # `git update-index --remove folder1/a` and remove the folder1/a
> +       test_sparse_match git update-index --remove --again &&
> +       test_sparse_match git status --porcelain=3Dv2

This might need a --ignore-skip-worktree-entries, as per the
discussion above.  Otherwise, this test makes sense.

> +'
> +
> +test_expect_success 'update-index --cacheinfo' '
> +       init_repos &&
> +
> +       deep_a_oid=3D$(git -C full-checkout rev-parse update-deep:deep/a)=
 &&
> +       folder2_oid=3D$(git -C full-checkout rev-parse update-folder2:fol=
der2) &&
> +       folder1_a_oid=3D$(git -C full-checkout rev-parse update-folder1:f=
older1/a) &&
> +
> +       test_all_match git update-index --cacheinfo 100644 $deep_a_oid de=
ep/a &&
> +       test_all_match git status --porcelain=3Dv2 &&
> +
> +       # Cannot add sparse directory, even in sparse index case
> +       test_all_match test_must_fail git update-index --add --cacheinfo =
040000 $folder2_oid folder2/ &&
> +
> +       # Sparse match only - because folder1/a is outside the sparse che=
ckout
> +       # definition (and thus not on-disk), it will appear "deleted" in
> +       # unstaged changes.
> +       test_all_match git update-index --add --cacheinfo 100644 $folder1=
_a_oid folder1/a &&
> +       test_sparse_match git status --porcelain=3Dv2

Makes sense, because the update-index command removes the existing
cache entry and adds a new one without the SKIP_WORKTREE bit.  But it
might be worth mentioning that in the commit message.  Also, you could
follow this up with `git update-index --skip-worktree folder1/a`, and
then do a test_all_match git status --porcelain=3Dv2, to show that when
the SKIP_WORKTREE bit is restored back to the file, then it again does
as expected despite not being on-disk.

> +'
> +
>  test_expect_success 'merge, cherry-pick, and rebase' '
>         init_repos &&
>
> --
> gitgitgadget
