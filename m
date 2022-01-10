Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFAFC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbiAJRLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiAJRLl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:11:41 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740B1C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:11:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u25so56345116edf.1
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JsuQ+/rzjkD20lT0e1A+ghayMmaPVpaeS8hC9rErEYs=;
        b=YWHIdZr5txkCgMM6P86llEThfLEq6xjn4TKq/ii9wbvs+r9B6TWkrrTySiKK8tMGPL
         j0+jNwM7GDe4Y356to4NUiEr6BHnlFnhgEdQE0ZnpfZ2wcfzMztH3fyojCxq+w/zsSDU
         FhwxvuEbWfrmQXigI36Kn2JtAvIyl1Rtmqw62uIGgOsIr9zMZ37BEdSPJMkeV+acD6q2
         JQ/xKa5nxguCWk50FZuzpwyAWDbIIuCETavSlM7VXT4j0GLkbowL8HzVgSKOC0rx6Ios
         aFAa6iKzMsTTTqXHB+LT04e/62kHxjSLp6feLdZwG7UAGRfh7uW30b1afAW17KjoCbAi
         vTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JsuQ+/rzjkD20lT0e1A+ghayMmaPVpaeS8hC9rErEYs=;
        b=1KHv+BU+fDvMSk/3Mbwg3UKfJvdaSXX4G67QU5ZhOPN939cxXKKRp19FjRbiimLqqn
         /u5TpJ0FHn6argtugVHq1vDhzIb0HqHQKJn7auI9u3OFJi7+X2P/kMA/uWfG/33NHIGt
         rrdjwttOjewpV0hPW8Pkpt0CaJo8+y8GqFnGAp/FPbYNJCmQW+JYhOpD2opfG79P5Jtd
         lIgi6wvxbMdVGF+WhhPvwdy8Qm09p9xeIpJbokiIomLG4LGeFjiT7wXVRr4YydJbI3ol
         mOeEc7siUhVdQpWxQY+h2456dqwvzxKWBRxmP3oWN/81mMqdeWVulS+pR4g+9DYd6G2X
         8btg==
X-Gm-Message-State: AOAM530Wd53aePB7N4YsmmCv6TZ1TaqCVDbn6VOJJ0aXeToniqxUY9oj
        N597uPOWWPETaSghRY5N7tCjFYoE/cZyp+ENjy0=
X-Google-Smtp-Source: ABdhPJxmkSA+ktbAy2rjK6KvdfC/Yv/HpppJyWco3v5QNlEAW6hGPPufDqr8FwldjrCwXuw2JuK/JBvESGJ559VPauc=
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr269878edc.228.1641834698730;
 Mon, 10 Jan 2022 09:11:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <3b734f89c0f2f473d71a5d3c85faec6d48a0e350.1641317820.git.gitgitgadget@gmail.com>
 <CABPp-BHadoOToWb6Kp7rUj03ZzKhzK_aFJymT_zApEw8st2ttA@mail.gmail.com> <159a35ba-7ed0-c601-15bd-54dfda460323@github.com>
In-Reply-To: <159a35ba-7ed0-c601-15bd-54dfda460323@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Jan 2022 09:11:26 -0800
Message-ID: <CABPp-BEXYZxThegY9WvudY0B7KJ1HQm--Kwe5zxQOxvzHMHN1A@mail.gmail.com>
Subject: Re: [PATCH 7/9] update-index: add tests for sparse-checkout compatibility
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 7:47 AM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Victoria Dye <vdye@github.com>
> >>
> >> Introduce tests for a variety of `git update-index` use cases, includi=
ng
> >> performance scenarios.
> >
> > Makes sense.
> >
> >> Tests for `update-index add/remove` are specifically
> >> focused on how `git stash` uses `git update-index` as a subcommand to
> >> prepare for sparse index integration with `stash` in a future series.
> >
> > This is possibly a tangent, but I'd rather that if we were trying to
> > fix `git stash`, that we instead would do so by making it stop forking
> > subprocesses and having it call internal API instead.  See for
> > example, a4031f6dc0 ("Merge branch 'en/stash-apply-sparse-checkout'
> > into maint", 2021-02-05) which did this.  The fact that it forks so
> > many subprocesses is a bug, and comes from the fact that stash is a
> > partial conversion from shell to C.  I think the subprocess forking is
> > part of the problem that causes issues for sparse-checkouts, as I
> > spelled out in patches 2 & 3 of the series I mentioned above.
> >
> > However, that doesn't affect this series.
> >
> >> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> >> Signed-off-by: Victoria Dye <vdye@github.com>
> >> ---
> >>  t/perf/p2000-sparse-operations.sh        |   1 +
> >>  t/t1092-sparse-checkout-compatibility.sh | 125 ++++++++++++++++++++++=
+
> >>  2 files changed, 126 insertions(+)
> >>
> >> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-o=
perations.sh
> >> index 54f8602f3c1..7dbed330160 100755
> >> --- a/t/perf/p2000-sparse-operations.sh
> >> +++ b/t/perf/p2000-sparse-operations.sh
> >> @@ -118,5 +118,6 @@ test_perf_on_all git diff --cached
> >>  test_perf_on_all git blame $SPARSE_CONE/a
> >>  test_perf_on_all git blame $SPARSE_CONE/f3/a
> >>  test_perf_on_all git checkout-index -f --all
> >> +test_perf_on_all git update-index --add --remove
> >>
> >>  test_done
> >> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse=
-checkout-compatibility.sh
> >> index 6ecf1f2bf8e..6804ab23a27 100755
> >> --- a/t/t1092-sparse-checkout-compatibility.sh
> >> +++ b/t/t1092-sparse-checkout-compatibility.sh
> >> @@ -630,6 +630,131 @@ test_expect_success 'reset with wildcard pathspe=
c' '
> >>         test_all_match git ls-files -s -- folder1
> >>  '
> >>
> >> +test_expect_success 'update-index modify outside sparse definition' '
> >> +       init_repos &&
> >> +
> >> +       write_script edit-contents <<-\EOF &&
> >> +       echo text >>$1
> >> +       EOF
> >> +
> >> +       # Create & modify folder1/a
> >> +       run_on_sparse mkdir -p folder1 &&
> >> +       run_on_sparse cp ../initial-repo/folder1/a folder1/a &&
> >> +       run_on_all ../edit-contents folder1/a &&
> >
> > As I've mentioned to Stolee, I'd rather these were explicitly marked
> > as intentionally setting up an erroneous condition.
> >
> > However, that might not matter if my other series gets accepted (the
> > one I promised to send out yesterday, but then spent all day
> > responding to emails instead).  Hopefully I'll send it soon.
> >
> >> +
> >> +       # If file has skip-worktree enabled, update-index does not mod=
ify the
> >> +       # index entry
> >> +       test_sparse_match git update-index folder1/a &&
> >> +       test_sparse_match git status --porcelain=3Dv2 &&
> >> +       test_must_be_empty sparse-checkout-out &&
> >> +
> >> +       # When skip-worktree is disabled (even on files outside sparse=
 cone), file
> >> +       # is updated in the index
> >> +       test_sparse_match git update-index --no-skip-worktree folder1/=
a &&
> >> +       test_all_match git status --porcelain=3Dv2 &&
> >> +       test_all_match git update-index folder1/a &&
> >> +       test_all_match git status --porcelain=3Dv2
> >
> > These make sense.
> >
> >> +'
> >> +
> >> +test_expect_success 'update-index --add outside sparse definition' '
> >> +       init_repos &&
> >> +
> >> +       write_script edit-contents <<-\EOF &&
> >> +       echo text >>$1
> >> +       EOF
> >> +
> >> +       # Create folder1, add new file
> >> +       run_on_sparse mkdir -p folder1 &&
> >> +       run_on_all ../edit-contents folder1/b &&
> >> +
> >> +       # Similar to `git add`, the untracked out-of-cone file is adde=
d to the index
> >> +       # identically across sparse and non-sparse checkouts
> >> +       test_all_match git update-index --add folder1/b &&
> >> +       test_all_match git status --porcelain=3Dv2
> >
> > The comment is not correct:
> >
>
> It is correct, but for *untracked* out-of-cone files only. Those files do=
n't
> have a `skip-worktree` bit because they're not in the index in the first
> place.

> The comment is intended to highlight the fact that `update-index`
> (like `git add`, `git status`, etc.) "decides" whether to operate on a fi=
le
> in a sparse-checkout based on `skip-worktree`, *not* the sparse patterns.

git-update-index may not pay attention to the sparsity patterns for
untracked files, but `git add` does.  Let me demonstrate.  First, I
set up a simple repo where the following is true:

$ git ls-files -t
H in-cone/foo.c
S out-of-cone/tracked
$ git status --porcelain
?? out-of-cone/initially-untracked

Now, let's compare `git add` and `git add --sparse`.  First, without --spar=
se:

$ git add out-of-cone/initially-untracked
The following paths and/or pathspecs matched paths that exist
outside of your sparse-checkout definition, so will not be
updated in the index:
out-of-cone/initially-untracked
hint: If you intend to update such entries, try one of the following:
hint: * Use the --sparse option.
hint: * Disable or modify the sparsity rules.
hint: Disable this message with "git config advice.updateSparsePath false"
$ git ls-files -t
H in-cone/foo.c
S out-of-cone/tracked

So, `git add $UNTRACKED` did not add the file.  In contrast:

$ git add --sparse out-of-cone/initially-untracked
$ git ls-files -t
H in-cone/foo.c
H out-of-cone/initially-untracked
S out-of-cone/tracked

So, `git add --sparse $UNTRACKED` did add it.

> Seeing as the comparison to `git add` makes things more confusing, I'll
> rephrase the test comment.
>
> > $ git add out-of-cone/file
> > The following paths and/or pathspecs matched paths that exist
> > outside of your sparse-checkout definition, so will not be
> > updated in the index:
> > out-of-cone/file
> > hint: If you intend to update such entries, try one of the following:
> > hint: * Use the --sparse option.
> > hint: * Disable or modify the sparsity rules.
> > hint: Disable this message with "git config advice.updateSparsePath fal=
se"
> >
> > I might buy that `git update-index` is lower level and should be
> > considered the same as `git add --sparse`, but the comment should
> > mention that and try to sell why update-index should be equivalent to
> > that instead of to `git add`.
> >
>
> Tracked, out-of-cone files aren't affected by `--add` (the flag allows
> `update-index` to add untracked files), and `update-index out-of-cone/tra=
cked`
> would ignore the file.

Yes, I believe you're explaining update-index behavior correctly.

> so I believe the behavior of `update-index` is
> currently more consistent with `git add` than `git add --sparse`.

But not quite `git add`'s.  Just to be clear, let's add update-index
to the above comparison I did between add and add --sparse.  First,
let's go back to the initial setup point:

$ git ls-files -t
H in-cone/foo.c
S out-of-cone/tracked
$ git status --porcelain
?? out-of-cone/initially-untracked

Now, let's try update-index:

$ git update-index --add out-of-cone/initially-untracked
$ git ls-files -t
H in-cone/foo.c
H out-of-cone/initially-untracked
S out-of-cone/tracked

So, in other words, `git update-index --add $UNTRACKED` matches the
behavior of `git add --sparse $UNTRACKED`, not the behavior of `git
add $UNTRACKED`.

> >> +'
> >> +
> >> +test_expect_success 'update-index --remove outside sparse definition'=
 '
> >> +       init_repos &&
> >
> >> +
> >> +       # When `--ignore-skip-worktree-entries` is specified, out-of-c=
one files are
> >> +       # not removed from the index if they do not exist on disk
> >> +       test_sparse_match git update-index --remove --ignore-skip-work=
tree-entries folder1/a &&
> >> +       test_all_match git status --porcelain=3Dv2 &&
> >
> > The file is present despite being marked to be missing, we're ignoring
> > the intention of the marking, and we ask for it to be removed, so we
> > don't remove it?
> >
> > The levels of negation are _very_ confusing.  It took me a while to
> > unravel this.  I think the logic is something like this
> >   * folder1/a is marked as SKIP_WORKTREE, meaning it's not supposed to
> > be in the worktree.
> >   * and it's not.
> >   * We are stating that we're ignoring SKIP_WORKTREE, though, so this
> > looks like a regular file that has been deleted.
> > So, what would `git update-index --remove $FILE` do for a normal $FILE
> > deleted from the working copy?  According to the docs:
> >
> >     --remove
> >            If a specified file is in the index but is missing then it=
=E2=80=99s
> >            removed. Default behavior is to ignore removed file.
> >
> > So, the docs say it would remove it.  But you don't.
> >
> >
> > After digging around and looking at the testcase below, if I had to
> > guess what happened, I would say that you figured out what the
> > SKIP_WORKTREE behavior was, and assumed that was correct, and added a
> > flag that allowed you to request the opposite behavior.
> > Unfortunately, I think the pre-existing behavior is buggy.
> >
>
> I understand why you find it buggy, but I am not making baseless assumpti=
ons
> about the correctness (or lack thereof) of the current behavior.

To be clear, the fact that the behavior was there for a decade would
typically be basis enough for an assumption (in my opinion), and I
wouldn't have faulted folks for making it.  I might well have done so
myself.  My reasoning was just that I was getting confused by the
negations and trying to understand the testcase, and when I started to
unravel it, I found what looked like a possible inconsistency.

Anyway, it's clear here you've actually dug a lot deeper and know the
history here.  In contrast, I was making assumptions about the history
(and ones that weren't correct, though I'd argue my assumptions
weren't baseless)...

> This
> specific "gap" in `update-index --remove` has been discussed in the past =
[1]
> and was acknowledged as non-ideal and a candidate for change in the futur=
e.
> At the time, the introduction of `--ignore-skip-worktree-entries` [2] was=
 a
> "safe" way to ignore `skip-worktree` without changing the default behavio=
r.
>
> Personally, I think updating the default behavior of `--remove` (and
> corresponding deprecation of `--[no-]ignore-skip-worktree-entries`) is
> probably the right way to go. However, I'd like to avoid including it in
> this series because it deviates pretty substantially from the goal
> "integrate with sparse index", and as a result has the potential to
> overshadow/derail the rest of the series. If you're alright with (slightl=
y)
> deferring changes to the behavior of `--remove`, I can submit a separate
> series for it once this one has stabilized.
>
> [1] https://lore.kernel.org/git/xmqq36fda3i8.fsf@gitster-ct.c.googlers.co=
m/
> [2] https://lore.kernel.org/git/163b42dfa21c306dc1dc573c5edfc8bda5c99fd0.=
1572432578.git.gitgitgadget@gmail.com/

Oh, wow.

Yeah, fixing it in a later series seems fine.  However, could you add
a comment to these testcases that --remove has behavior that violates
the definition of `SKIP_WORKTREE`, and that we might want to fix that
in the future but for now you are just testing the pre-existing
behavior for coverage?

(There is a possibility we can't fix it for some reason when we dig
in.  In that case, we should update the documentation for `--remove`
to call out this special case.  But again, that can be for a later
series.)

> > Of course, there's lots of negation here.  Did I get something
> > backwards by chance?
> >
> >> +
> >> +       # When the flag is _not_ specified ...
> >
> > In my head I'm translating this as:
> >
> > SKIP_WORKTREE =3D !worktree
> > --ignore-skip-worktree-entries =3D !!worktree
> > "flag is _not_ specified" =3D !!!worktree ?
> >
> > I'm not sure I would do anything to change it, but just pointing out
> > it can be a little hard for others to come up to speed.
> >
>
> Most of the confusion likely comes from the non-standard behavior of
> `--remove`, but I think I can distill it into (somewhat) straightforward
> statements about `update-index`:
>
> 1. When using the command *without* either `--ignore-skip-worktree-entrie=
s`
>    OR `--remove`, `skip-worktree` entries provided to the command are
>    ignored.
> 2. When using the command *with* `--remove` and *without*
>    `--ignore-skip-worktree-entries`, `skip-worktree` entries are *not*
>    ignored, and are removed from the index.
> 3. When both `--remove` and `--ignore-skip-worktree-entries` are specifie=
d,
>    `skip-worktree` entries are again ignored.
> 4. `--ignore-skip-worktree-entries` has no effect without `--remove` also
>    specified
>
> The goal of this test, then, is to exercise conditions 2 & 3 and directly
> show their effect on `skip-worktree` entries.

Yeah, it makes sense to have good test coverage.  +1.

>
> >>             ...     , out-of-cone, not-on-disk files are
> >> +       # removed from the index
> >> +       rm full-checkout/folder1/a &&
> >> +       test_all_match git update-index --remove folder1/a &&
> >> +       test_all_match git status --porcelain=3Dv2 &&
> >
> > Documentation/git-update-index.txt defines SKIP_WORKTREE as follows:
> >
> > "Skip-worktree bit can be defined in one (long) sentence: When reading
> > an entry, if it is marked as skip-worktree, then Git pretends its
> > working directory version is up to date and read the index version
> > instead."
> >
> > If Git is pretending the file is up-to-date, and `git update-index
> > --remove $UP_TO_DATE_FILE` is typically a no-op because the --remove
> > flag doesn't do anything when a file is present in the working copy,
> > then why is this the expected behavior?
> >
> > I know it's the traditional behavior of update-index, but
> > SKIP_WORKTREE support in Git has traditionally been filled with holes.
> > So, was this behavior by design (despite contradicting the
> > documentation), or by accident?
> >
>
> As far as I can tell, it appears to have been intentional in the original
> `skip-worktree` implementation [3], but given Junio & Johannes' discussio=
n
> on the `--ignore-skip-worktree-entries` patch [1], the sentiment now woul=
d
> probably lean towards having `--remove` ignore `skip-worktree`.
>
> [1] https://lore.kernel.org/git/xmqq36fda3i8.fsf@gitster-ct.c.googlers.co=
m/
>     (copied from earlier in this message)
> [3] https://lore.kernel.org/git/1250776033-12395-5-git-send-email-pclouds=
@gmail.com/

Allow me to comment on this history...

I can see sometimes wanting to make a command line option a special
case that doesn't follow the general documented rules.  Not sure I
believe it in this specific case, but I can see it as being a
possibility in general.  But when you're going to make an option not
follow the otherwise documented behavior, then that option's
documentation should have a special callout about how it diverges
and/or why it's a special case.  So, this seems like a double-layered
problem to me (not only choosing the wrong behavior, but leaving the
documentation to claim it does something else).  It looks like Dscho
partially tried to fix it, but I would have preferred that Dscho's
documentation comment he added to `--ignore-skip-worktree-entries` be
added to `--remove`; it's odd that folks wanting to learn about
`--remove` behavior need to read the documentation for
`--ignore-skip-worktree-entries` (even if they aren't using it) in
order to understand `--remove`'s behavior.

> > (To be fair, I think the definition given in the manual for
> > SKIP_WORKTREE is horrible for other reasons, so I don't like leaning
> > on it.  But I used different logic above in the
> > --ignore-skip-worktree-entries case to arrive at the same conclusion
> > that the --remove behavior of update-index seems to be backwards.
> > Unless I missed a negation in both cases somewhere?  There are so many
> > floating around...)
> >
> >> +       # NOTE: --force-remove supercedes --ignore-skip-worktree-entri=
es, removing
> >> +       # a skip-worktree file from the index (and disk) when both are=
 specified
> >> +       test_all_match git update-index --force-remove --ignore-skip-w=
orktree-entries folder1/a &&
> >> +       test_all_match git status --porcelain=3Dv2
> >
> > Makes sense.
> >
> >> +'
> >> +
> >> +test_expect_success 'update-index with directories' '
> >> +       init_repos &&
> >> +
> >> +       # update-index will exit silently when provided with a directo=
ry name
> >> +       # containing a trailing slash
> >> +       test_all_match git update-index deep/ folder1/ &&
> >> +       grep "Ignoring path deep/" sparse-checkout-err &&
> >> +       grep "Ignoring path folder1/" sparse-checkout-err &&
> >
> > Is this desired behavior or just current behavior?
> >
> >> +
> >> +       # When update-index is given a directory name WITHOUT a traili=
ng slash, it will
> >> +       # behave in different ways depending on the status of the dire=
ctory on disk:
> >> +       # * if it exists, the command exits with an error ("add indivi=
dual files instead")
> >> +       # * if it does NOT exist (e.g., in a sparse-checkout), it is a=
ssumed to be a
> >> +       #   file and either triggers an error ("does not exist  and --=
remove not passed")
> >> +       #   or is ignored completely (when using --remove)
> >> +       test_all_match test_must_fail git update-index deep &&
> >> +       run_on_all test_must_fail git update-indexe folder1 &&
> >
> > This one will fail for the wrong reason, though -- `update-indexe` is
> > not a valid subcommand.  (extra 'e' at the end)
> >
>
> Thanks for catching that! I'll update in my next re-roll.
>
> >> +       test_must_fail git -C full-checkout update-index --remove fold=
er1 &&
> >> +       test_sparse_match git update-index --remove folder1 &&
> >> +       test_all_match git status --porcelain=3Dv2
> >
> > Otherwise these seem reasonable.
> >
> >> +'
> >> +
> >> +test_expect_success 'update-index --again file outside sparse definit=
ion' '
> >> +       init_repos &&
> >> +
> >> +       write_script edit-contents <<-\EOF &&
> >> +       echo text >>$1
> >> +       EOF
> >
> > Copy and paste and forget to remove?  edit-contents doesn't seem to be
> > used in this test.
> >
>
> Will remove.
>
> >> +
> >> +       test_all_match git checkout -b test-reupdate &&
> >> +
> >> +       # Update HEAD without modifying the index to introduce a diffe=
rence in
> >> +       # folder1/a
> >> +       test_sparse_match git reset --soft update-folder1 &&
> >> +
> >> +       # Because folder1/a differs in the index vs HEAD,
> >> +       # `git update-index --remove --again` will effectively perform
> >> +       # `git update-index --remove folder1/a` and remove the folder1=
/a
> >> +       test_sparse_match git update-index --remove --again &&
> >> +       test_sparse_match git status --porcelain=3Dv2
> >
> > This might need a --ignore-skip-worktree-entries, as per the
> > discussion above.  Otherwise, this test makes sense.
> >
>
> The `--ignore-skip-worktree-entries` option is explicitly omitted because
> this test needs `update-index` to modify a `skip-worktree` entry. However=
,
> given the debate around what `--remove` should do, I'll update the scenar=
io
> to not use `--remove` or any variation of it.
>
> >> +'
> >> +
> >> +test_expect_success 'update-index --cacheinfo' '
> >> +       init_repos &&
> >> +
> >> +       deep_a_oid=3D$(git -C full-checkout rev-parse update-deep:deep=
/a) &&
> >> +       folder2_oid=3D$(git -C full-checkout rev-parse update-folder2:=
folder2) &&
> >> +       folder1_a_oid=3D$(git -C full-checkout rev-parse update-folder=
1:folder1/a) &&
> >> +
> >> +       test_all_match git update-index --cacheinfo 100644 $deep_a_oid=
 deep/a &&
> >> +       test_all_match git status --porcelain=3Dv2 &&
> >> +
> >> +       # Cannot add sparse directory, even in sparse index case
> >> +       test_all_match test_must_fail git update-index --add --cachein=
fo 040000 $folder2_oid folder2/ &&
> >> +
> >> +       # Sparse match only - because folder1/a is outside the sparse =
checkout
> >> +       # definition (and thus not on-disk), it will appear "deleted" =
in
> >> +       # unstaged changes.
> >> +       test_all_match git update-index --add --cacheinfo 100644 $fold=
er1_a_oid folder1/a &&
> >> +       test_sparse_match git status --porcelain=3Dv2
> >
> > Makes sense, because the update-index command removes the existing
> > cache entry and adds a new one without the SKIP_WORKTREE bit.  But it
> > might be worth mentioning that in the commit message.  Also, you could
> > follow this up with `git update-index --skip-worktree folder1/a`, and
> > then do a test_all_match git status --porcelain=3Dv2, to show that when
> > the SKIP_WORKTREE bit is restored back to the file, then it again does
> > as expected despite not being on-disk.
> >
>
> I really like this - it helps clarify how `update-index` can be used to
> correctly add a sparse-checkout entry to the index with plumbing commands=
.
> I'll include it in V2.
>
> >> +'
> >> +
> >>  test_expect_success 'merge, cherry-pick, and rebase' '
> >>         init_repos &&
> >>
> >> --
> >> gitgitgadget
