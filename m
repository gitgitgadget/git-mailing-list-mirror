Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990FFC433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 09:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiFIJDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiFIJDI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 05:03:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081422BAE6
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 02:03:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id y19so46150152ejq.6
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kYobcZbvHvXHoF+eZkVhTIJt/oK9IHpo4DR3YNIbPq0=;
        b=Z/D1kpxEupv29zOUUAtGRc3oZ+EfhKZfs8jLVNPuCmm+Xo4Wy9NVgMOY+WmZKFvrPq
         S0f1314naAgCoGfqDnpE3sJcWEgTmwJ4rWSgJHkafq04JLfqdI/7BDgWQoCj9aksQrnK
         ABFGPr4gyTiDU0xsfImisHsHdyNlEANQUngTTFniUgJpmf26NjgPyTaQBaazPPsMP1eu
         T1NBigOZ1bJPlWlsKTLgc+cv7utfgPtelS0rRPCzvAuJWXJUyPwJhefC+zncFGMkjT/L
         RZHCM0WGn4vzSGJzRv8j9176seH2/WZkdY/AaQVh1gxksI9vmGGjtEyG0Gw+xRgAaZ7A
         lg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kYobcZbvHvXHoF+eZkVhTIJt/oK9IHpo4DR3YNIbPq0=;
        b=Xn0XgtehhUlqGLnVh6/hoA/M2Pvwc1iDOIMt3rnAJ2ZIcHLfm/LV904xCVXD/3P5oU
         dc+I581bQZuCnFBmzIPIFTWXZflXYp43aj6DHU6YtK+dTVTS+/E/PlvRJ48U7/N0XxXy
         kwMaFKtLzak9fmwD1sPt4pI2/i4VuXDc04AKpRZykMhpMn4wIUIR3n5R3E8phFbTfRNJ
         xnQnxaz209E0h1Z7CMwQJzLHjRYoIMgYrKsChxZZip9wXdPpBduNSLI9WlV7FurM6h04
         Gk5R4patixp7Z9xp9AXqkNhWxB5ArGRAr+vtxgvQWcsrFkX1ti+m4woPjLyyUTN8atyK
         xenA==
X-Gm-Message-State: AOAM533KZXSLiLNgnKoiMEmrtF2qxIYsiyujrmi5n6SRtyDSqqlkah5N
        4vpGYchyWcbLdv1l+Sd/sf0YrGDYtLs=
X-Google-Smtp-Source: ABdhPJyKej2ScojuTGrmL4dhAPL6ce3nEYwb0OaD0HDrfw6QAf0JPnBvvzl7DAq2jDxVcTk61VeCkA==
X-Received: by 2002:a17:907:2cc3:b0:6fa:55f:8805 with SMTP id hg3-20020a1709072cc300b006fa055f8805mr34920249ejc.46.1654765384531;
        Thu, 09 Jun 2022 02:03:04 -0700 (PDT)
Received: from localhost (78-131-17-130.pool.digikabel.hu. [78.131.17.130])
        by smtp.gmail.com with ESMTPSA id be5-20020a0564021a2500b0042e09f44f81sm12753851edb.38.2022.06.09.02.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:03:03 -0700 (PDT)
Date:   Thu, 9 Jun 2022 11:03:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v7] git-prompt: make colourization consistent
Message-ID: <20220609090302.GA1738@szeder.dev>
References: <20220606175022.8410-1-joak-pet@online.no>
 <20220607115024.64724-1-joak-pet@online.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607115024.64724-1-joak-pet@online.no>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 07, 2022 at 01:50:24PM +0200, Joakim Petersen wrote:
> The short upstream state indicator inherits the colour of the last short
> state indicator before it (if there is one), and the sparsity state
> indicator inherits this colour as well. This behaviour was introduced by
> 0ec7c23cdc6 (git-prompt: make upstream state indicator location
> consistent, 2022-02-27), while before this change the aforementioned
> indicators were white/the default text colour. Some examples to
> illustrate this behaviour (assuming all indicators are enabled and
> colourization is on):
>  * If there is something in the stash, both the '$' and the short
>    upstream state indicator following it will be blue.
>  * If the local tree has new, untracked files and there is nothing in
>    the stash, both the '%' and the short upstream state indicator
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
> change in colourization is that previously, the short upstream state
> indicator appeared immediately after the rebase/revert/bisect/merge
> state indicator (note the position of $p in $gitstring):
> 
> 	local f="$h$w$i$s$u"
> 	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
> 	
> Said indicator is prepended with the clear colour code, and the short
> upstream state indicator is thus also uncoloured. Now, the short
> upstream state indicator follows the sequence of colourized indicators,
> without any clearing of colour (again note the position of $p, now in
> $f):
> 
> 	local f="$h$w$i$s$u$p"
> 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
> 
> If the user is in a sparse checkout, the sparsity state indicator
> follows a similar pattern to the short upstream state indicator.
> However, clearing colour of the colourized indicators changes how the
> sparsity state indicator is colourized, as it currently inherits (and
> before the change referenced also inherited) the colour of the last
> short state indicator before it. Reading the commit message of the
> change that introduced the sparsity state indicator, afda36dbf3b
> (git-prompt: include sparsity state as well, 2020-06-21), it appears
> this colourization also was unintended, so clearing the colour for said
> indicator further increases consistency.
> 
> Make the colourization of these state indicators consistent by making
> all colourized indicators clear their own colour. Make colouring of $c
> dependent on it not being empty, as it is no longer being used to colour
> the branch name. Move clearing of $b's prefix to before colourization so
> it gets cleared properly when colour codes are inserted into it. These
> changes make changing the layout of the prompt less prone to unintended
> colour changes in the future.
> 
> Change coloured Bash prompt tests to reflect the colourization changes:
>  * Move the colour codes to wrap the expected content of the expanded
>    $__git_ps1_branch_name in all tests.
>  * Insert a clear-colour code after the symbol for the first indicator
>    in "prompt - bash color pc mode - dirty status indicator - dirty
>    index and worktree", to reflect that all indicators should clear
>    their own colour.

This patch seems to break colorization when __git_ps1() is invoked
from $PROMPT_COMMAND:

  ~/src/git (master)$ echo $PROMPT_COMMAND 
__git_ps1 "\[\e]0;\w - Terminal\a\e[01;32m\]\h\[\e[01;34m\] \w" "\[\e[01;34m\]\$\[\e[00m\] " " \[\e[01;34m\](%s\[\e[01;34m\])"
  ~/src/git (master)$ git checkout 9470605a1b
  HEAD is now at 9470605a1b git-prompt: make colourization consistent
  ~/src/git ((9470605a1b...))$ source contrib/completion/git-prompt.sh 
  ~/src/git (\[\e[31m\](9470605a1b...)\[\e[0m\])$ # uh-oh
  ~/src/git (\[\e[31m\](9470605a1b...)\[\e[0m\])$ git checkout 9470605a1b^
  Previous HEAD position was 9470605a1b git-prompt: make colourization consistent
  HEAD is now at 2668e3608e Sixth batch
  ~/src/git (\[\e[31m\](2668e3608e...)\[\e[0m\])$ source contrib/completion/git-prompt.sh 
  ~/src/git ((2668e3608e...))$ # Looks good.


> Signed-off-by: Joakim Petersen <joak-pet@online.no>
> ---
> Changes since v6:
>  * Remove repeated statements and move all explanation of what the patch
>    does to the latter part of the message.
>  * Add a short statement about other benefits of the behavioural change.
> 
> Range-diff against v6:
> 1:  50765eeb95 = 1:  e25738c667 git-prompt: make colourization consistent
> 
>  contrib/completion/git-prompt.sh | 22 ++++++++++++----------
>  t/t9903-bash-prompt.sh           | 18 +++++++++---------
>  2 files changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 87b2b916c0..cb01c2fd5d 100644
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
>  	if [[ -n ${ZSH_VERSION-} ]]; then
> @@ -271,22 +272,23 @@ __git_ps1_colorize_gitstring ()
>  	else
>  		branch_color="$bad_color"
>  	fi
> -	c="$branch_color$c"
> +	if [ -n "$c" ]; then
> +		c="$branch_color$c$c_clear"
> +	fi
> +	b="$branch_color$b$c_clear"
>  
> -	z="$c_clear$z"
> -	if [ "$w" = "*" ]; then
> -		w="$bad_color$w"
> +	if [ -n "$w" ]; then
> +		w="$bad_color$w$c_clear"
>  	fi
>  	if [ -n "$i" ]; then
> -		i="$ok_color$i"
> +		i="$ok_color$i$c_clear"
>  	fi
>  	if [ -n "$s" ]; then
> -		s="$flags_color$s"
> +		s="$flags_color$s$c_clear"
>  	fi
>  	if [ -n "$u" ]; then
> -		u="$bad_color$u"
> +		u="$bad_color$u$c_clear"
>  	fi
> -	r="$c_clear$r"
>  }
>  
>  # Helper function to read the first line of a file into a variable.
> @@ -554,6 +556,7 @@ __git_ps1 ()
>  		fi
>  	fi
>  
> +	b=${b##refs/heads/}
>  	local z="${GIT_PS1_STATESEPARATOR-" "}"
>  
>  	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
> @@ -563,7 +566,6 @@ __git_ps1 ()
>  		fi
>  	fi
>  
> -	b=${b##refs/heads/}
>  	if [ $pcmode = yes ] && [ $ps1_expanded = yes ]; then
>  		__git_ps1_branch_name=$b
>  		b="\${__git_ps1_branch_name}"
> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index bbd513bab0..abd82eec35 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -541,7 +541,7 @@ test_expect_success 'prompt - pc mode' '
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - branch name' '
> -	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nmain" >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_green}main${c_clear}" >expected &&
>  	(
>  		GIT_PS1_SHOWCOLORHINTS=y &&
>  		__git_ps1 "BEFORE:" ":AFTER" >"$actual" &&
> @@ -551,7 +551,7 @@ test_expect_success 'prompt - bash color pc mode - branch name' '
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - detached head' '
> -	printf "BEFORE: (${c_red}\${__git_ps1_branch_name}${c_clear}):AFTER\\n(%s...)" $(git log -1 --format="%h" b1^) >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_red}(%s...)"${c_clear} $(git log -1 --format="%h" b1^) >expected &&
>  	git checkout b1^ &&
>  	test_when_finished "git checkout main" &&
>  	(
> @@ -563,7 +563,7 @@ test_expect_success 'prompt - bash color pc mode - detached head' '
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty worktree' '
> -	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_clear}):AFTER\\nmain" >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}*${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>  	echo "dirty" >file &&
>  	test_when_finished "git reset --hard" &&
>  	(
> @@ -576,7 +576,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index' '
> -	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}+${c_clear}):AFTER\\nmain" >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name} ${c_green}+${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>  	echo "dirty" >file &&
>  	test_when_finished "git reset --hard" &&
>  	git add -u &&
> @@ -590,7 +590,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirty index and worktree' '
> -	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}*${c_green}+${c_clear}):AFTER\\nmain" >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}*${c_clear}${c_green}+${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>  	echo "dirty index" >file &&
>  	test_when_finished "git reset --hard" &&
>  	git add -u &&
> @@ -605,7 +605,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - dirt
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - dirty status indicator - before root commit' '
> -	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_green}#${c_clear}):AFTER\\nmain" >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name} ${c_green}#${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>  	(
>  		GIT_PS1_SHOWDIRTYSTATE=y &&
>  		GIT_PS1_SHOWCOLORHINTS=y &&
> @@ -617,7 +617,7 @@ test_expect_success 'prompt - bash color pc mode - dirty status indicator - befo
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - inside .git directory' '
> -	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear}):AFTER\\nGIT_DIR!" >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name}):AFTER\\n${c_green}GIT_DIR!${c_clear}" >expected &&
>  	echo "dirty" >file &&
>  	test_when_finished "git reset --hard" &&
>  	(
> @@ -631,7 +631,7 @@ test_expect_success 'prompt - bash color pc mode - inside .git directory' '
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - stash status indicator' '
> -	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_lblue}\$${c_clear}):AFTER\\nmain" >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name} ${c_lblue}\$${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>  	echo 2 >file &&
>  	git stash &&
>  	test_when_finished "git stash drop" &&
> @@ -645,7 +645,7 @@ test_expect_success 'prompt - bash color pc mode - stash status indicator' '
>  '
>  
>  test_expect_success 'prompt - bash color pc mode - untracked files status indicator' '
> -	printf "BEFORE: (${c_green}\${__git_ps1_branch_name}${c_clear} ${c_red}%%${c_clear}):AFTER\\nmain" >expected &&
> +	printf "BEFORE: (\${__git_ps1_branch_name} ${c_red}%%${c_clear}):AFTER\\n${c_green}main${c_clear}" >expected &&
>  	(
>  		GIT_PS1_SHOWUNTRACKEDFILES=y &&
>  		GIT_PS1_SHOWCOLORHINTS=y &&
> -- 
> 2.36.1
> 
