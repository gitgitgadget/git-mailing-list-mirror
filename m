Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5041BC2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 16:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E177F20BED
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 16:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrbRriPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762449AbgJXQxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 12:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760122AbgJXQxa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 12:53:30 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB8C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 09:53:30 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b2so3822209ots.5
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PJGIUQRHOyi1GRZw5m6pMj5OBocaEJogvdAZZqh+wPg=;
        b=TrbRriPmJr5yO9JbvrK/AgwahGTAnKvDOjfPe3VDWIwDK4rxlAKD0Pmb28QrECQFap
         2wE7jY1NnXrf6pqHrTbQPoh2FT6ljHVJw5yDDj/MxKD9bxenKnrNVbNb46mMbqNIWHOT
         RCnb+otwLRKsx3a1fqoqsEn5EO9H3T+1UDha+9dDOf/iUSSg2sR2GB/S9rtMcQUgAfCS
         zKmSNzcYbovp6lNt4q2IBMVFEZyvPJBohtNml8KNRf0S4ansq2e9yQ/p98eGowjP//zg
         BKdX1Rz8BDH9jcCtDJS1IrJQ6qqHiaW1kbZZKPvckcjFIAmAV7kxcd3NLNmg1YEct1Kb
         IDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PJGIUQRHOyi1GRZw5m6pMj5OBocaEJogvdAZZqh+wPg=;
        b=uCiwEiY/8rsDVWNrgUOq2ft8XE7CU6c/sK8DlNssLSF9X7XBINryYwZnCC/UCW6tqV
         th1GbqCq+dbF6JWTsLgC9L7x0zPAVUBp5jGlEDD3jLXvddgsS7Tvu9vkNAKMPAK/ldEi
         lxLm+t6PBUG1EgBSxtQAHyOZ67bj4oZbSqunOQ6ywsuzsjdghu38vNBXqYOjKL4nlIPT
         fc6gZ5oIGt0QYykFTcMcnngwObGVBHSKFFhIgqFWJe6dApAbEmCXzT8qVuF2tO4Av/0O
         rNXgAJCFqAJy6hOXsN1t8nB6xws0mbO2PNNjMLRdO6TNLGkcrBezp1XfEZFZw7ajNwDs
         jESA==
X-Gm-Message-State: AOAM533uxXBzGIiNC5ZZNosc0sbmLWaep6h6eoQujkL7FJQufP5x98yT
        f/nMT4hWl3UWKo22s02FfGkuk7FZIlQQ1iRlwhY=
X-Google-Smtp-Source: ABdhPJxiZL/hu6y0v2T7jcd9jFd4DK8SUeBM/QCezUACMsitbp2p41M2kYSU46aXC5lOClhcE/h8E841w+HMfMnsE6c=
X-Received: by 2002:a9d:6003:: with SMTP id h3mr7059837otj.345.1603558409423;
 Sat, 24 Oct 2020 09:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
 <a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com>
 <20201024104910.GA15823@danh.dev>
In-Reply-To: <20201024104910.GA15823@danh.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 24 Oct 2020 09:53:18 -0700
Message-ID: <CABPp-BHgJrQMNEm7-y7nStVjcAedsNKH+bHNM9V34netTN+NTQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] t/: new helper for tests that pass with ort but fail
 with recursive
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 24, 2020 at 3:49 AM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2020-10-23 16:01:16+0000, Elijah Newren via GitGitGadget <gitgitgadget=
@gmail.com> wrote:
> > +test_expect_merge_algorithm () {
> > +     status_for_recursive=3D$1
> > +     shift
> > +     status_for_ort=3D$1
> > +     shift
> > +
> > +     if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
> > +     then
> > +             test_expect_${status_for_ort} "$@"
> > +     else
> > +             test_expect_${status_for_recursive} "$@"
> > -test_expect_failure 'check symlink modify/modify' '
> > +test_expect_merge_algorithm failure success 'check symlink modify/modi=
fy' '
>
> I find this series of "failure success" hard to decode without
> understanding what it would be, then I need to keep rememberring which
> status is corresponding with with algorithm.
>
> Perhaps this patch is a bit easier to read. This is largely based on
> your patch. (I haven't read other patches, yet).
>
> What do you think?

It is easier to read and I think something along these lines would
make a lot of sense if this weren't a transient change (the idea is to
eventually drop the recursive backend in favor of ort, and then these
can all switch to just using test_expect_success).  Maybe it still
makes sense to make further changes here anyway, but if we do go this
route, there are 1-2 things we can/should change:

First, while a lot of my contributions aren't that important, and the
new test_expect_* function certainly falls in that category, one of
the driving goals behind a new merge algorithm was fixing up edge and
corner cases that were just too problematic in the recursive backend.
Thus, the patch where I get to flip the test expectation is one that I
care about more than most out of the (I'm guessing on this number)
100+ patches that will be part of this new merge algorithm.  Having
you take over ownership of that patch thus isn't right; we should
instead keep my original patch and apply your suggested changes on top
(or have a patch from you introducing a new function first, and then
have a patch from me using it to flip test expectations on top).

Second, I think that lines like
    test_expect_merge_success recursive=3Dfailure ...
read like a contradiction and are also confusing.  I think it'd be
better if it read something like
    test_expect_merge recursive=3Dfailure ort=3Dsuccess ...
or something along those lines.


> -------------8<------------
> From: =3D?UTF-8?q?=3DC4=3D90o=3DC3=3DA0n=3D20Tr=3DE1=3DBA=3DA7n=3D20C=3DC=
3=3DB4ng=3D20Danh?=3D
>  <congdanhqx@gmail.com>
> Date: Sat, 24 Oct 2020 17:41:02 +0700
> Subject: [PATCH] t/: new helper for testing merge that allow failure for =
some
>  algorithm
>
> There are a number of tests that the "recursive" backend does not handle
> correctly but which the redesign in "ort" will.
>
> Add a new helper in lib-merge.sh for selecting a different test expectati=
on
> based on the setting of GIT_TEST_MERGE_ALGORITHM, and use it in various
> testcases to document that we expect them to be success by default
> but failure with certain algorithm.
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gma=
il.com>
> ---
>  t/lib-merge.sh                         | 19 +++++++++++++++++++
>  t/t6416-recursive-corner-cases.sh      | 11 ++++++-----
>  t/t6422-merge-rename-corner-cases.sh   |  7 ++++---
>  t/t6423-merge-rename-directories.sh    | 13 +++++++------
>  t/t6426-merge-skip-unneeded-updates.sh |  3 ++-
>  t/t6430-merge-recursive.sh             |  3 ++-
>  6 files changed, 40 insertions(+), 16 deletions(-)
>  create mode 100644 t/lib-merge.sh
>
> diff --git a/t/lib-merge.sh b/t/lib-merge.sh
> new file mode 100644
> index 0000000000..efd8b9615c
> --- /dev/null
> +++ b/t/lib-merge.sh
> @@ -0,0 +1,19 @@
> +# Helper functions used by merge tests.
> +
> +test_expect_merge_success() {
> +       exception=3D"$1"
> +       : "${GIT_TEST_MERGE_ALGORITHM:=3Drecursive}"
> +       case ",$exception," in
> +       *,$GIT_TEST_MERGE_ALGORITHM=3Dfailure,*)
> +               shift
> +               test_expect_failure "$@" ;;
> +       *,$GIT_TEST_MERGE_ALGORITHM=3D*)
> +               BUG "exception must be failure only" ;;
> +       *=3Dfailure,)
> +               shift
> +               test_expect_success "$@" ;;
> +       *)
> +               # No exception
> +               test_expect_success "$@" ;;
> +       esac
> +}
> diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner=
-cases.sh
> index fd98989b14..d13c1afb4a 100755
> --- a/t/t6416-recursive-corner-cases.sh
> +++ b/t/t6416-recursive-corner-cases.sh
> @@ -3,6 +3,7 @@
>  test_description=3D'recursive merge corner cases involving criss-cross m=
erges'
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-merge.sh
>
>  #
>  #  L1  L2
> @@ -1069,7 +1070,7 @@ test_expect_success 'setup symlink modify/modify' '
>         )
>  '
>
> -test_expect_failure 'check symlink modify/modify' '
> +test_expect_merge_success recursive=3Dfailure 'check symlink modify/modi=
fy' '
>         (
>                 cd symlink-modify-modify &&
>
> @@ -1135,7 +1136,7 @@ test_expect_success 'setup symlink add/add' '
>         )
>  '
>
> -test_expect_failure 'check symlink add/add' '
> +test_expect_merge_success recursive=3Dfailure 'check symlink add/add' '
>         (
>                 cd symlink-add-add &&
>
> @@ -1223,7 +1224,7 @@ test_expect_success 'setup submodule modify/modify'=
 '
>         )
>  '
>
> -test_expect_failure 'check submodule modify/modify' '
> +test_expect_merge_success recursive=3Dfailure 'check submodule modify/mo=
dify' '
>         (
>                 cd submodule-modify-modify &&
>
> @@ -1311,7 +1312,7 @@ test_expect_success 'setup submodule add/add' '
>         )
>  '
>
> -test_expect_failure 'check submodule add/add' '
> +test_expect_merge_success recursive=3Dfailure 'check submodule add/add' =
'
>         (
>                 cd submodule-add-add &&
>
> @@ -1386,7 +1387,7 @@ test_expect_success 'setup conflicting entry types =
(submodule vs symlink)' '
>         )
>  '
>
> -test_expect_failure 'check conflicting entry types (submodule vs symlink=
)' '
> +test_expect_merge_success recursive=3Dfailure 'check conflicting entry t=
ypes (submodule vs symlink)' '
>         (
>                 cd submodule-symlink-add-add &&
>
> diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-=
corner-cases.sh
> index 3375eaf4e7..0c8eb4df8a 100755
> --- a/t/t6422-merge-rename-corner-cases.sh
> +++ b/t/t6422-merge-rename-corner-cases.sh
> @@ -4,6 +4,7 @@ test_description=3D"recursive merge corner cases w/ renam=
es but not criss-crosses"
>  # t6036 has corner cases that involve both criss-cross merges and rename=
s
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-merge.sh
>
>  test_setup_rename_delete_untracked () {
>         test_create_repo rename-delete-untracked &&
> @@ -878,7 +879,7 @@ test_setup_rad () {
>         )
>  }
>
> -test_expect_failure 'rad-check: rename/add/delete conflict' '
> +test_expect_merge_success recursive=3Dfailure 'rad-check: rename/add/del=
ete conflict' '
>         test_setup_rad &&
>         (
>                 cd rad &&
> @@ -951,7 +952,7 @@ test_setup_rrdd () {
>         )
>  }
>
> -test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete confl=
ict' '
> +test_expect_merge_success recursive=3Dfailure 'rrdd-check: rename/rename=
(2to1)/delete/delete conflict' '
>         test_setup_rrdd &&
>         (
>                 cd rrdd &&
> @@ -1040,7 +1041,7 @@ test_setup_mod6 () {
>         )
>  }
>
> -test_expect_failure 'mod6-check: chains of rename/rename(1to2) and renam=
e/rename(2to1)' '
> +test_expect_merge_success recursive=3Dfailure 'mod6-check: chains of ren=
ame/rename(1to2) and rename/rename(2to1)' '
>         test_setup_mod6 &&
>         (
>                 cd mod6 &&
> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-d=
irectories.sh
> index 06b46af765..249fbb6853 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -26,6 +26,7 @@ test_description=3D"recursive merge with directory rena=
mes"
>  #                     files that might be renamed into each other's path=
s.)
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-merge.sh
>
>
>  ########################################################################=
###
> @@ -1339,7 +1340,7 @@ test_setup_6b1 () {
>         )
>  }
>
> -test_expect_failure '6b1: Same renames done on both sides, plus another =
rename' '
> +test_expect_merge_success recursive=3Dfailure '6b1: Same renames done on=
 both sides, plus another rename' '
>         test_setup_6b1 &&
>         (
>                 cd 6b1 &&
> @@ -1412,7 +1413,7 @@ test_setup_6b2 () {
>         )
>  }
>
> -test_expect_failure '6b2: Same rename done on both sides' '
> +test_expect_merge_success recursive=3Dfailure '6b2: Same rename done on =
both sides' '
>         test_setup_6b2 &&
>         (
>                 cd 6b2 &&
> @@ -3471,7 +3472,7 @@ test_setup_10e () {
>         )
>  }
>
> -test_expect_failure '10e: Does git complain about untracked file that is=
 not really in the way?' '
> +test_expect_merge_success recursive=3Dfailure '10e: Does git complain ab=
out untracked file that is not really in the way?' '
>         test_setup_10e &&
>         (
>                 cd 10e &&
> @@ -4104,7 +4105,7 @@ test_setup_12b1 () {
>         )
>  }
>
> -test_expect_failure '12b1: Moving two directory hierarchies into each ot=
her' '
> +test_expect_merge_success recursive=3Dfailure '12b1: Moving two director=
y hierarchies into each other' '
>         test_setup_12b1 &&
>         (
>                 cd 12b1 &&
> @@ -4272,7 +4273,7 @@ test_setup_12c1 () {
>         )
>  }
>
> -test_expect_failure '12c1: Moving one directory hierarchy into another w=
/ content merge' '
> +test_expect_merge_success recursive=3Dfailure '12c1: Moving one director=
y hierarchy into another w/ content merge' '
>         test_setup_12c1 &&
>         (
>                 cd 12c1 &&
> @@ -4632,7 +4633,7 @@ test_setup_12f () {
>         )
>  }
>
> -test_expect_failure '12f: Trivial directory resolve, caching, all kinds =
of fun' '
> +test_expect_merge_success recursive=3Dfailure '12f: Trivial directory re=
solve, caching, all kinds of fun' '
>         test_setup_12f &&
>         (
>                 cd 12f &&
> diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-=
unneeded-updates.sh
> index 699813671c..8510d4da8b 100755
> --- a/t/t6426-merge-skip-unneeded-updates.sh
> +++ b/t/t6426-merge-skip-unneeded-updates.sh
> @@ -23,6 +23,7 @@ test_description=3D"merge cases"
>  #                     files that might be renamed into each other's path=
s.)
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-merge.sh
>
>
>  ########################################################################=
###
> @@ -666,7 +667,7 @@ test_setup_4a () {
>  #   correct requires doing the merge in-memory first, then realizing tha=
t no
>  #   updates to the file are necessary, and thus that we can just leave t=
he path
>  #   alone.
> -test_expect_failure '4a: Change on A, change on B subset of A, dirty mod=
s present' '
> +test_expect_merge_success recursive=3Dfailure '4a: Change on A, change o=
n B subset of A, dirty mods present' '
>         test_setup_4a &&
>         (
>                 cd 4a &&
> diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
> index a328260d42..4795a7abd0 100755
> --- a/t/t6430-merge-recursive.sh
> +++ b/t/t6430-merge-recursive.sh
> @@ -3,6 +3,7 @@
>  test_description=3D'merge-recursive backend test'
>
>  . ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-merge.sh
>
>  test_expect_success 'setup 1' '
>
> @@ -641,7 +642,7 @@ test_expect_success 'merge-recursive copy vs. rename'=
 '
>         test_cmp expected actual
>  '
>
> -test_expect_failure 'merge-recursive rename vs. rename/symlink' '
> +test_expect_merge_success recursive=3Dfailure 'merge-recursive rename vs=
. rename/symlink' '
>
>         git checkout -f rename &&
>         git merge rename-ln &&
> --
> 2.29.0.rc1
