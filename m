Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EFEC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 17:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiFDRbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiFDRbX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 13:31:23 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B055F33350
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 10:31:21 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-30c2f288f13so109458577b3.7
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeuJ/WKKyCubDReFZp4XragLYo7jlV95qrF1iOitKJY=;
        b=MHGj9bz+I4reiIKrKiRQ1hYynW4ZX5oDELKs48rwoIi8h5N5yT12Wlss8zNx3WXjB7
         vOVHDqPZ1jXyRq8WXK5Iyf3Ikz6hVlFcS/yCpvM9Ib8c303Zjz/elgxP1f9pQ7MO32bo
         7jyCELWVOpMsj4f+yjXVE9kwDJPpan2UDC21f/jtJeH7XIFC/TQHdbi1XuQfnQPkF1WK
         PD1/wymlasMlZI68m6u2gcYJ+8HJdJWqRem7m+HI5Oy4Gi1ng8Zn4WraNQ7Xpc0DriBP
         uhJhdxtzkJi0Pgy8y2XfgJtYhutenuOidtv+brcvv9Mc8szQf3wNFEd/MnwM6wK1qa55
         dAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeuJ/WKKyCubDReFZp4XragLYo7jlV95qrF1iOitKJY=;
        b=a72kP3pdHj4yTqH60+EnycYS89CyFikmJaBzuNP2DEcaquzx7ya/IIRiN5Dt9S2ENl
         l4+4BNkpdW4tMeHGG/6mNuHHByRiH/pSSDgLjkZsjmSF5tLqAX0g7/PozVFcbOGinF26
         j/Ju/ZsTi6stfAjJRtujfu3T51Fjc4wPlHxzTry9C4WLDS1PxImVBrH5tKYmS3Y4ZfUt
         J7CltR0GovoMMUXia2IrCE4mw5Hx2lHXE1Zjdz+341GDvGrJQdPKjJ9uf2liucKONFWc
         nOElRtewHDsZhFhyDfirGdvTIrDKvMil2EG94/zyTS6EexBu6Gcb6AFWlorEMBLDObGj
         NyTg==
X-Gm-Message-State: AOAM531bXBcAFs/lyfL6XoremNLaf9NFgzGxbVHHRCAozgW3Khc6yqcz
        OyPudBUEmd8s+RB/P19mRfRGVC1XhTvHfp07YQw=
X-Google-Smtp-Source: ABdhPJz4sEvy4c5UrkIWfkewHAcD4gXvak7hLDhskAfkkz4kICAc+PQRm1bOfLtRRKq22EKy9DC81thCd0UHW+HqLDg=
X-Received: by 2002:a81:1989:0:b0:30c:214e:f0ea with SMTP id
 131-20020a811989000000b0030c214ef0eamr17484336ywz.517.1654363880873; Sat, 04
 Jun 2022 10:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220603142521.42863-1-joak-pet@online.no> <20220604161333.54627-1-joak-pet@online.no>
In-Reply-To: <20220604161333.54627-1-joak-pet@online.no>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Sat, 4 Jun 2022 13:30:45 -0400
Message-ID: <CAGTqyRxS9aBitVivSTqojX_C_VBdgrD7JkUKgKSE6apjabzvQg@mail.gmail.com>
Subject: Re: [PATCH v4] git-prompt: make colourization consistent
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 4, 2022 at 12:13 PM Joakim Petersen <joak-pet@online.no> wrote:
>
> The short upstream state indicator inherits the colour of the last short
> state indicator before it (if there is one), and the sparsity state
> indicator inherits this colour as well. Make the colourization of these
> state indicators consistent by making all colourized indicators clear
> their own colour.
>
> As of 0ec7c23cdc6 (git-prompt: make upstream state indicator location
> consistent, 2022-02-27), colourization in the output of __git_ps1 has
> changed such that the short upstream state indicator inherits the colour
> of the last short state indicator before it (if there is one), while
> before this change it was white/the default text colour. Some examples
> to illustrate this behaviour (assuming all indicators are enabled and
> colourization is on):
>  * If there is something in the stash, both the '$' and the short
>    upstream state indicator following it will be blue.
>  * If the local tree has new, untracked files and there is nothing in
>    the stash, both the '%' and the    short upstream state indicator
>    will be red.
>  * If all local changes are added to the index and the stash is empty,
>    both the '+' and the short upstream state indicator following it will
>    be green.
>  * If the local tree is clean and there is nothing in the stash, the
>    short upstream state indicator will be white/${default text colour}.
>
> This appears to be an unintended side-effect of the change, and makes
> little sense semantically (e.g. why is it bad to be in sync with
> upstream when you have uncommitted local changes?). The cause of the
> change is that previously, the short upstream state indicator appeared
> immediately after the rebase/revert/bisect/merge state indicator (note
> the position of $p in $gitstring):
>
>         local f="$h$w$i$s$u"
>         local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
>
> Said indicator is prepended with the clear colour code, and the short
> upstream state indicator is thus also uncoloured. Now, the short
> upstream state indicator follows the sequence of colourized indicators,
> without any clearing of colour (again note the position of $p, now in
> $f):
>
>         local f="$h$w$i$s$u$p"
>         local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
>
> If the user is in a sparse checkout, the sparsity state indicator
> follows a similar pattern to the short upstream state indicator.
> However, clearing colour of the colourized indicators changes how the
> sparsity state indicator is colourized , as it currently inherits (and
> before the change referenced also inherited) the colour of the last
> short state indicator before it. Reading the commit message of the
> change that introduced the sparsity state indicator, afda36dbf3b
> (git-prompt: include sparsity state as well, 2020-06-21), it appears
> this colourization also was unintended, so clearing the colour for said
> indicator further increases consistency.
>
> Colouring of $c was made dependent on it not being empty, as it is no
> longer being used to colour the branch name. Removal of $b's prefix was
> moved to before the colourization so it gets cleared properly now that
> colour codes are inserted into it.
>
> Due to colour clearing being moved into the variables for each coloured
> indicator, the tests for the coloured Bash prompt had to be changed:
>  * All colour tests now have the colour codes around the expected
>    content of the expanded $__git_ps1_branch_name variable instead of
>    the unexpanded variable in the string.
>  * The test with two indicators had a clear-colour code inserted after
>    the symbol for the first indicator, since all indicators clear their
>    own colours now.
>
> Signed-off-by: Joakim Petersen <joak-pet@online.no>
> ---
> Changes since v3:
>  * All colourized variables now also clear their own colour.
>  * Variables are only coloured if they are not empty, except $b (branch
>    name), which is not an optional indicator.
>  * Updated tests to reflect the new colourization behaviour.
>  * Fixed a mistake in two of the examples; the stash indicator is the
>    last of the short state indicators preceding the short upstream state
>    indicator.
>
> Range-diff against v3:
> 1:  0e107d0496 < -:  ---------- git-prompt: make colourization consistent
> -:  ---------- > 1:  98ce78ddc5 git-prompt: make colourization consistent
>
>  contrib/completion/git-prompt.sh | 20 +++++++++++---------
>  t/t9903-bash-prompt.sh           | 18 +++++++++---------
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 87b2b916c0..32bb98bb8d 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -245,7 +245,8 @@ __git_ps1_show_upstream ()
>
>  # Helper function that is meant to be called from __git_ps1.  It
>  # injects color codes into the appropriate gitstring variables used
> -# to build a gitstring.
> +# to build a gitstring. Colored variables are responsible for clearing
> +# their own color.
>  __git_ps1_colorize_gitstring ()
>  {
>         if [[ -n ${ZSH_VERSION-} ]]; then
> @@ -271,22 +272,23 @@ __git_ps1_colorize_gitstring ()
>         else
>                 branch_color="$bad_color"
>         fi
> -       c="$branch_color$c"
> +       if [ -n "$c" ]; then
> +               c="$branch_color$c$c_clear"
> +       fi
> +       b="$branch_color$b$c_clear"
>
> -       z="$c_clear$z"
>         if [ "$w" = "*" ]; then
> -               w="$bad_color$w"
> +               w="$bad_color$w$c_clear"
>         fi
>         if [ -n "$i" ]; then
> -               i="$ok_color$i"
> +               i="$ok_color$i$c_clear"
>         fi
>         if [ -n "$s" ]; then
> -               s="$flags_color$s"
> +               s="$flags_color$s$c_clear"
>         fi
>         if [ -n "$u" ]; then
> -               u="$bad_color$u"
> +               u="$bad_color$u$c_clear"
>         fi
> -       r="$c_clear$r"
>  }
>
>  # Helper function to read the first line of a file into a variable.
> @@ -554,6 +556,7 @@ __git_ps1 ()
>                 fi
>         fi
>
> +       b=${b##refs/heads/}
>         local z="${GIT_PS1_STATESEPARATOR-" "}"
>
>         # NO color option unless in PROMPT_COMMAND mode or it's Zsh
> @@ -563,7 +566,6 @@ __git_ps1 ()
>                 fi
>         fi
>
> -       b=${b##refs/heads/}
>         if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
>                 __git_ps1_branch_name=$b
>                 b="\${__git_ps1_branch_name}"
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index bbd513bab0..abd82eec35 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -541,7 +541,7 @@ test_expect_success 'prompt - pc mode' '
>  '
>
>  test_expect_success 'prompt - bash color pc mode - branch name' '
> -       printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmain" >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_green}main${c_clear}" >expected &&
>         (
>                 GIT_PS1_SHOWCOLORHINTS=y &&
>                 __git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
> @@ -551,7 +551,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
>  '
>
>  test_expect_success 'prompt - bash color pc mode - detached head' '
> -       printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_red}(%s...)"${c_clear} $(git log -1 --format="%h" b1^) >expected &&
>         git checkout b1^ &&
>         test_when_finished "git checkout main" &&
>         (
> @@ -563,7 +563,7 @@ test_expect_success 'prompt - bash color pc mode - detached head' '
>  '
>
>  test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
> -       printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmain" >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}*${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>         echo "dirty" >file &&
>         test_when_finished "git reset --hard" &&
>         (
> @@ -576,7 +576,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
>  '
>
>  test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
> -       printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmain" >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name} ${c_green}+${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>         echo "dirty" >file &&
>         test_when_finished "git reset --hard" &&
>         git add -u &&
> @@ -590,7 +590,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
>  '
>
>  test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
> -       printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmain" >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}*${c_clear}${c_green}+${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>         echo "dirty index" >file &&
>         test_when_finished "git reset --hard" &&
>         git add -u &&
> @@ -605,7 +605,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
>  '
>
>  test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
> -       printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmain" >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name} ${c_green}#${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>         (
>                 GIT_PS1_SHOWDIRTYSTATE=y &&
>                 GIT_PS1_SHOWCOLORHINTS=y &&
> @@ -617,7 +617,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - befo
>  '
>
>  test_expect_success 'prompt - bash color pc mode - inside .git directory' '
> -       printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nGIT_DIR!" >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_green}GIT_DIR!${c_clear}" >expected &&
>         echo "dirty" >file &&
>         test_when_finished "git reset --hard" &&
>         (
> @@ -631,7 +631,7 @@ test_expect_success 'prompt - bash color pc mode - inside .git directory' '
>  '
>
>  test_expect_success 'prompt - bash color pc mode - stash status indicator' '
> -       printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmain" >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name} ${c_lblue}\$${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>         echo 2 >file &&
>         git stash &&
>         test_when_finished "git stash drop" &&
> @@ -645,7 +645,7 @@ test_expect_success 'prompt - bash color pc mode - stash status indicator' '
>  '
>
>  test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
> -       printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmain" >expected &&
> +       printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}%%${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>         (
>                 GIT_PS1_SHOWUNTRACKEDFILES=y &&
>                 GIT_PS1_SHOWCOLORHINTS=y &&
> --
> 2.36.1
>

I like this solution. This isn't new, but does anybody know if there
is a reason why `$w` is compared for equality to "*" as opposed to
just checking whether it's a nonempty value (`-n`)? I think I'd
generally prefer it to be consistent with the others, which has the
added benefit of continuing to work if the asterisk is ever changed to
something else.
