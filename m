Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CEC25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 21:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiHNVHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNVHg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 17:07:36 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA806348
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 14:07:35 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id 5so2264208uay.5
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7MCi6U6WUuanxJswWJ3F/76SLQ8wdULv1+dRyVZ0aAQ=;
        b=n1dWc3/NaqC1P54qKvkLdJHVfQyR/9jorG69tqwQ7Foc+Qz4vh4d11yWwAxSgqsc2s
         W6yPCF4juiKpt53qI41DfX5qJk23PKi1r2wUp+m4sbFIBkpiXpD2AYxqy7PP1fbOURBb
         tRkUnyB+dOnN8H1PwpW0+DJza0ajYotASdOsQ+D0HPnPuWUTw3p/w9IDAsdgwF2hUN06
         QofjPqV+ovyGQdHY4/kk+Qimor2s5v2mkLAhUTZPxnasSNvvdTKeej/dTMu4DxsHDqc4
         oThiIlm7s++Ej59d3vZ4jIVYrkLFTGibp8WHDrL6JCBSmVmeKW9iMXc9HwDWzpa9yYFk
         AIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7MCi6U6WUuanxJswWJ3F/76SLQ8wdULv1+dRyVZ0aAQ=;
        b=iUAivUTKyMEGA3IEQaz9NeBHX1Akt2UYkp+UF3dmb6RrfynG6LEfImgdpzfKNEMEbV
         JbRBxCMqCIKuMxTqkebifI3W2Z9DYkERPKddXjcNs6Fr+7hbbIn6xFbdsCbfp5hvNU5i
         onPOczmI4ajXRL7CpzuXUcckK8UfNtltZ/VrI3G0mfCWCVfXzD5bEwtubQKDnwhMuKdr
         UdGORgWWfNwC25tsB0wv286/k9c1CxegRTVsu7pGxlf6ODIBuEMSTW29oxoX2cIRZjiW
         9qHzq1JRMqUnj/h49hMidMpobydhiKr939qGb6qOR5oOI4CFChlJiNZzMWo2D7rOmV6S
         IeiQ==
X-Gm-Message-State: ACgBeo2Do1Dp6MDEhtJJvf+5WwwsMZl/YlASTBnCl0gY8bc7tKuQ1AEM
        +4GiXlP+LMU7u4yhD7HZATsXlo9z3k2kSUCRT4U=
X-Google-Smtp-Source: AA6agR5GTY+DiPPhcAseUs0dtNrS90kXH86kqhv4Mf9sAQuGBS9aKoa9JnH2p+1LBfC/Gemx/eAoaWlmJwafRze1uMA=
X-Received: by 2002:ab0:5a9b:0:b0:38c:6969:7bae with SMTP id
 w27-20020ab05a9b000000b0038c69697baemr5242449uae.3.1660511253976; Sun, 14 Aug
 2022 14:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com> <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
In-Reply-To: <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Sun, 14 Aug 2022 17:06:57 -0400
Message-ID: <CAGTqyRw-SYDbQy9aktq5s3ZhoDhUOCf-pEopjH9m7v5+PH7Qqg@mail.gmail.com>
Subject: Re: [PATCH v2] git-prompt: show presence of unresolved conflicts at
 command prompt
To:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, newren@gmail.com,
        phillip.wood@dunelm.org.uk, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 6:08 PM Justin Donnelly via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Justin Donnelly <justinrdonnelly@gmail.com>
>
> If GIT_PS1_SHOWCONFLICTSTATE is set to "yes", show the word "CONFLICT"
> on the command prompt when there are unresolved conflicts.
>
> Example prompt: (main|CONFLICT)
>
> Signed-off-by: Justin Donnelly <justinrdonnelly@gmail.com>
> ---
>     Show 'CONFLICT' indicator at command prompt
>
>     This patch adds functionality for bash/zsh to show "CONFLICT" on the
>     prompt in cases where there are unresolved conflicts. The feature is
>     only enabled after setting an environment variable.
>
>     The conflict state is determined by running git ls-files --unmerged. =
In
>     my testing, the performance was very good. It took around 0.01 second=
s
>     to run git ls-files --unmerged regardless of the number of conflicts,=
 or
>     their depth, even on very large projects (Linux kernel). However, if
>     anybody has any concerns with this, I'm open to other options.
>
>     Any tests that were impacted (with the conflict prompt feature enable=
d)
>     were duplicated. The original test was left as-is (no changes, and
>     conflict prompt feature disabled). The new version of each test enabl=
es
>     the conflict prompt feature and confirms the prompt includes
>     "|CONFLICT".
>
>     ---------------------------------------------------------------------=
---
>
>     Changes since v1:
>
>      * This feature is now disabled by default.
>      * Created new tests for conflict state (instead of modifying existin=
g
>        tests).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1302%2F=
justinrdonnelly%2Fconflict-indicator-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1302/justi=
nrdonnelly/conflict-indicator-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1302
>
> Range-diff vs v1:
>
>  1:  e380826dcaf ! 1:  7154d695426 git-prompt: show 'CONFLICT' indicator =
at command prompt
>      @@ Metadata
>       Author: Justin Donnelly <justinrdonnelly@gmail.com>
>
>        ## Commit message ##
>      -    git-prompt: show 'CONFLICT' indicator at command prompt
>      +    git-prompt: show presence of unresolved conflicts at command pr=
ompt
>
>      -    When there are unresolved conflicts, show the word 'CONFLICT' o=
n the
>      -    command prompt. Similar to other state indicators, this provide=
s
>      -    information to the user about the current state of the reposito=
ry.
>      +    If GIT_PS1_SHOWCONFLICTSTATE is set to "yes", show the word "CO=
NFLICT"
>      +    on the command prompt when there are unresolved conflicts.
>
>           Example prompt: (main|CONFLICT)
>
>      @@ contrib/completion/git-prompt.sh
>        # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or =
omitted
>        # by setting GIT_PS1_OMITSPARSESTATE.
>        #
>      -+# When there is a conflict, the prompt will include "|CONFLICT". T=
his can
>      -+# be omitted by setting GIT_PS1_OMITCONFLICTSTATE.
>      ++# If you would like to see a notification on the prompt when there=
 are
>      ++# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to "yes". Th=
e
>      ++# prompt will include "|CONFLICT".
>       +#
>        # If you would like to see more information about the identity of
>        # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STY=
LE
>      @@ contrib/completion/git-prompt.sh: __git_ps1 ()
>         fi
>
>       + local conflict=3D"" # state indicator for unresolved conflicts
>      -+ if [[ -z "${GIT_PS1_OMITCONFLICTSTATE-}" ]] &&
>      ++ if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" =3D=3D "yes" ]] &&
>       +    [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
>       +         conflict=3D"|CONFLICT"
>       + fi
>      @@ contrib/completion/git-prompt.sh: __git_ps1 ()
>                 if [ "${__git_printf_supports_v-}" !=3D yes ]; then
>
>        ## t/t9903-bash-prompt.sh ##
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - interactiv=
e rebase' '
>      - '
>      -
>      - test_expect_success 'prompt - rebase merge' '
>      -- printf " (b2|REBASE 1/3)" >expected &&
>      -+ printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
>      -  git checkout b2 &&
>      +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase mer=
ge' '
>         test_when_finished "git checkout main" &&
>         test_must_fail git rebase --merge b1 b2 &&
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase mer=
ge' '
>      +  test_when_finished "git rebase --abort" &&
>      +- __git_ps1 >"$actual" &&
>      ++ (
>      ++         sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
>      ++         __git_ps1 >"$actual"
>      ++ ) &&
>      ++ test_cmp expected "$actual"
>      ++'
>      ++
>      ++test_expect_success 'prompt - rebase merge conflict' '
>      ++ printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
>      ++ git checkout b2 &&
>      ++ test_when_finished "git checkout main" &&
>      ++ test_must_fail git rebase --merge b1 b2 &&
>      ++ test_when_finished "git rebase --abort" &&
>      ++ (
>      ++         GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
>      ++         __git_ps1 >"$actual"
>      ++ ) &&
>      +  test_cmp expected "$actual"
>        '
>
>      - test_expect_success 'prompt - rebase am' '
>      -- printf " (b2|REBASE 1/3)" >expected &&
>      -+ printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
>      -  git checkout b2 &&
>      +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase am'=
 '
>         test_when_finished "git checkout main" &&
>         test_must_fail git rebase --apply b1 b2 &&
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - rebase am'=
 '
>      +  test_when_finished "git rebase --abort" &&
>      +- __git_ps1 >"$actual" &&
>      ++ (
>      ++         sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
>      ++         __git_ps1 >"$actual"
>      ++ ) &&
>      ++ test_cmp expected "$actual"
>      ++'
>      ++
>      ++test_expect_success 'prompt - rebase am conflict' '
>      ++ printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
>      ++ git checkout b2 &&
>      ++ test_when_finished "git checkout main" &&
>      ++ test_must_fail git rebase --apply b1 b2 &&
>      ++ test_when_finished "git rebase --abort" &&
>      ++ (
>      ++         GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
>      ++         __git_ps1 >"$actual"
>      ++ ) &&
>      +  test_cmp expected "$actual"
>        '
>
>      - test_expect_success 'prompt - merge' '
>      -- printf " (b1|MERGING)" >expected &&
>      -+ printf " (b1|MERGING|CONFLICT)" >expected &&
>      -  git checkout b1 &&
>      +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - merge' '
>         test_when_finished "git checkout main" &&
>         test_must_fail git merge b2 &&
>      -@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - merge' '
>      +  test_when_finished "git reset --hard" &&
>      +- __git_ps1 >"$actual" &&
>      ++ (
>      ++         sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
>      ++         __git_ps1 >"$actual"
>      ++ ) &&
>      ++ test_cmp expected "$actual"
>      ++'
>      ++
>      ++test_expect_success 'prompt - merge conflict' '
>      ++ printf " (b1|MERGING|CONFLICT)" >expected &&
>      ++ git checkout b1 &&
>      ++ test_when_finished "git checkout main" &&
>      ++ test_must_fail git merge b2 &&
>      ++ test_when_finished "git reset --hard" &&
>      ++ (
>      ++         GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
>      ++         __git_ps1 >"$actual"
>      ++ ) &&
>      +  test_cmp expected "$actual"
>        '
>
>      - test_expect_success 'prompt - cherry-pick' '
>      -- printf " (main|CHERRY-PICKING)" >expected &&
>      -+ printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
>      +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pic=
k' '
>      +  printf " (main|CHERRY-PICKING)" >expected &&
>         test_must_fail git cherry-pick b1 b1^ &&
>         test_when_finished "git cherry-pick --abort" &&
>      -  __git_ps1 >"$actual" &&
>      +- __git_ps1 >"$actual" &&
>      ++ (
>      ++         sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
>      ++         __git_ps1 >"$actual"
>      ++ ) &&
>         test_cmp expected "$actual" &&
>      -+ printf " (main|CHERRY-PICKING)" >expected &&
>         git reset --merge &&
>         test_must_fail git rev-parse CHERRY_PICK_HEAD &&
>      -  __git_ps1 >"$actual" &&
>      +@@ t/t9903-bash-prompt.sh: test_expect_success 'prompt - cherry-pic=
k' '
>      +  test_cmp expected "$actual"
>      + '
>      +
>      ++test_expect_success 'prompt - cherry-pick conflict' '
>      ++ printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
>      ++ test_must_fail git cherry-pick b1 b1^ &&
>      ++ test_when_finished "git cherry-pick --abort" &&
>      ++ (
>      ++         GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
>      ++         __git_ps1 >"$actual"
>      ++ ) &&
>      ++ test_cmp expected "$actual"
>      ++'
>      ++
>      + test_expect_success 'prompt - revert' '
>      +  printf " (main|REVERTING)" >expected &&
>      +  test_must_fail git revert b1^ b1 &&
>
>
>  contrib/completion/git-prompt.sh | 12 +++++-
>  t/t9903-bash-prompt.sh           | 70 ++++++++++++++++++++++++++++++--
>  2 files changed, 77 insertions(+), 5 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-pr=
ompt.sh
> index 1435548e004..57972c2845c 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -84,6 +84,10 @@
>  # single '?' character by setting GIT_PS1_COMPRESSSPARSESTATE, or omitte=
d
>  # by setting GIT_PS1_OMITSPARSESTATE.
>  #
> +# If you would like to see a notification on the prompt when there are
> +# unresolved conflicts, set GIT_PS1_SHOWCONFLICTSTATE to "yes". The
> +# prompt will include "|CONFLICT".
> +#
>  # If you would like to see more information about the identity of
>  # commits checked out as a detached HEAD, set GIT_PS1_DESCRIBE_STYLE
>  # to one of these values:
> @@ -508,6 +512,12 @@ __git_ps1 ()
>                 r=3D"$r $step/$total"
>         fi
>
> +       local conflict=3D"" # state indicator for unresolved conflicts
> +       if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" =3D=3D "yes" ]] &&
> +          [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
> +               conflict=3D"|CONFLICT"
> +       fi
> +
>         local w=3D""
>         local i=3D""
>         local s=3D""
> @@ -572,7 +582,7 @@ __git_ps1 ()
>         fi
>
>         local f=3D"$h$w$i$s$u$p"
> -       local gitstring=3D"$c$b${f:+$z$f}${sparse}$r${upstream}"
> +       local gitstring=3D"$c$b${f:+$z$f}${sparse}$r${upstream}${conflict=
}"
>
>         if [ $pcmode =3D yes ]; then
>                 if [ "${__git_printf_supports_v-}" !=3D yes ]; then
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 6a30f5719c3..47eb98893ef 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -188,7 +188,23 @@ test_expect_success 'prompt - rebase merge' '
>         test_when_finished "git checkout main" &&
>         test_must_fail git rebase --merge b1 b2 &&
>         test_when_finished "git rebase --abort" &&
> -       __git_ps1 >"$actual" &&
> +       (
> +               sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
> +               __git_ps1 >"$actual"
> +       ) &&
> +       test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - rebase merge conflict' '
> +       printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
> +       git checkout b2 &&
> +       test_when_finished "git checkout main" &&
> +       test_must_fail git rebase --merge b1 b2 &&
> +       test_when_finished "git rebase --abort" &&
> +       (
> +               GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
> +               __git_ps1 >"$actual"
> +       ) &&
>         test_cmp expected "$actual"
>  '
>
> @@ -198,7 +214,23 @@ test_expect_success 'prompt - rebase am' '
>         test_when_finished "git checkout main" &&
>         test_must_fail git rebase --apply b1 b2 &&
>         test_when_finished "git rebase --abort" &&
> -       __git_ps1 >"$actual" &&
> +       (
> +               sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
> +               __git_ps1 >"$actual"
> +       ) &&
> +       test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - rebase am conflict' '
> +       printf " (b2|REBASE 1/3|CONFLICT)" >expected &&
> +       git checkout b2 &&
> +       test_when_finished "git checkout main" &&
> +       test_must_fail git rebase --apply b1 b2 &&
> +       test_when_finished "git rebase --abort" &&
> +       (
> +               GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
> +               __git_ps1 >"$actual"
> +       ) &&
>         test_cmp expected "$actual"
>  '
>
> @@ -208,7 +240,23 @@ test_expect_success 'prompt - merge' '
>         test_when_finished "git checkout main" &&
>         test_must_fail git merge b2 &&
>         test_when_finished "git reset --hard" &&
> -       __git_ps1 >"$actual" &&
> +       (
> +               sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
> +               __git_ps1 >"$actual"
> +       ) &&
> +       test_cmp expected "$actual"
> +'
> +
> +test_expect_success 'prompt - merge conflict' '
> +       printf " (b1|MERGING|CONFLICT)" >expected &&
> +       git checkout b1 &&
> +       test_when_finished "git checkout main" &&
> +       test_must_fail git merge b2 &&
> +       test_when_finished "git reset --hard" &&
> +       (
> +               GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
> +               __git_ps1 >"$actual"
> +       ) &&
>         test_cmp expected "$actual"
>  '
>
> @@ -216,7 +264,10 @@ test_expect_success 'prompt - cherry-pick' '
>         printf " (main|CHERRY-PICKING)" >expected &&
>         test_must_fail git cherry-pick b1 b1^ &&
>         test_when_finished "git cherry-pick --abort" &&
> -       __git_ps1 >"$actual" &&
> +       (
> +               sane_unset GIT_PS1_SHOWCONFLICTSTATE &&
> +               __git_ps1 >"$actual"
> +       ) &&
>         test_cmp expected "$actual" &&
>         git reset --merge &&
>         test_must_fail git rev-parse CHERRY_PICK_HEAD &&
> @@ -224,6 +275,17 @@ test_expect_success 'prompt - cherry-pick' '
>         test_cmp expected "$actual"
>  '
>
> +test_expect_success 'prompt - cherry-pick conflict' '
> +       printf " (main|CHERRY-PICKING|CONFLICT)" >expected &&
> +       test_must_fail git cherry-pick b1 b1^ &&
> +       test_when_finished "git cherry-pick --abort" &&
> +       (
> +               GIT_PS1_SHOWCONFLICTSTATE=3D"yes" &&
> +               __git_ps1 >"$actual"
> +       ) &&
> +       test_cmp expected "$actual"
> +'
> +
>  test_expect_success 'prompt - revert' '
>         printf " (main|REVERTING)" >expected &&
>         test_must_fail git revert b1^ b1 &&
>
> base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
> --
> gitgitgadget

[SubmittingPatches](https://github.com/git/git/blob/master/Documentation/Su=
bmittingPatches)
recommends using `git-contacts` to determine who to "cc" on the email.
I used GitGitGadget, which doesn't cc anybody by default (I see now
that others manually add cc's to the PR description). So I've added
the following cc's to this email:
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
Junio C Hamano
Elijah Newren
Phillip Wood
Johannes Schindelin

I hope this is against protocol/etiquette, but after some initial
feedback from Junio, I haven't gotten any more. I wasn't sure if
nobody had seen the patch, or if there just wasn't any interest.

Thanks,
Justin
