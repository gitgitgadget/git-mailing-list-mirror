Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0ACC43219
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 20:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiKTUZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 15:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTUZA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 15:25:00 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E028E0C
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 12:24:58 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id me22so7809984ejb.8
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 12:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGf8SM5kQloOwtdkJ/1iFsxq2zrx9tCso6j0QpFqFLk=;
        b=kuG98GYfyfuugNkwwxidqAsd4BSeYcVML5T0OpyhMIlmW9/r8Jsqldq0+UPCLIUTJn
         Q8Mu1zi16kSisXs82OymhO+dtuFYxDYDnkuqvp7wDnli386C+1GPy16cYR4IsfhZ/4ph
         KW8hjKfNguu8Un/Y/pwkLtNFXz4oHqvsmxUVgpt2c/aGubCdrs3Qj4baSn8169EkEPeQ
         4ElwDKcCltMkO3ZYOpMLWY+LWTh1QRPrXBm+kKx3uABgGGTDxHXR8cQ1Twrxu45eicvP
         drxA17QZlG9GU78wQGi5rvgM+Twl1ePvTQgDZvSi+uiHzBo9rUC+800or6703VLMlLc7
         LPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGf8SM5kQloOwtdkJ/1iFsxq2zrx9tCso6j0QpFqFLk=;
        b=uL/GvsvgsfIW74jnq75IXTcrREoiExyP1MsF008f3C2yeT8Xx3DYxlZ1DGRH6mDocH
         v1I6XiR3iwbgv0rKt8oNqUur54gt8W85vfsmJFf2eF5coRF4b6ynxTRGwaTSEHduilMq
         awfm1x7ymUzit/YqXuz0xC5YwMHYmRgNM+QsnXzbv+UQgFhQSdNhNXaN+qIZQv2MRdH3
         NhBVLt7hMHEn+MeNewSy67p+s8QHdhcN1qfPZa8HA+uVOrzVlY8wG8eUGEIKYrbzTL/g
         Jo/RGz2swzDs3puH8L45W1wWm2Rw6WpAbmTDpXDehdHQ25aDQiq4tEMAB1yU9Uo6oNiT
         p1mA==
X-Gm-Message-State: ANoB5pkbMN53P/XdMmPQHFeVqKiyo1P1FaF/jUcri3CFGMZRoNI1Qlm7
        VYoOqlfsb0FJHhk4HeJXiKo=
X-Google-Smtp-Source: AA0mqf5mccmxtqNEIHsyM1mdXrXmm6FTSGz4Up6IbkidB0FT1c8E7UgyLP6ZcZu+gM7hHnilyLPZbw==
X-Received: by 2002:a17:906:455:b0:7ad:b97e:283a with SMTP id e21-20020a170906045500b007adb97e283amr12607502eja.567.1668975896949;
        Sun, 20 Nov 2022 12:24:56 -0800 (PST)
Received: from localhost (94-21-23-70.pool.digikabel.hu. [94.21.23.70])
        by smtp.gmail.com with ESMTPSA id tz6-20020a170907c78600b0079fe11e97cesm4260692ejc.48.2022.11.20.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 12:24:56 -0800 (PST)
Date:   Sun, 20 Nov 2022 21:24:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alison Winters via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alison Winters <alisonatwork@outlook.com>
Subject: Re: [PATCH 1/2] completion: add optional ignore-case when matching
 refs
Message-ID: <20221120202454.GB4039@szeder.dev>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
 <cef9a12b5752fc62151296e1b679fbe973556998.1667669315.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cef9a12b5752fc62151296e1b679fbe973556998.1667669315.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2022 at 05:28:34PM +0000, Alison Winters via GitGitGadget wrote:
> From: Alison Winters <alisonatwork@outlook.com>
> 
> If GIT_COMPLETION_IGNORE_CASE=1 is set, --ignore-case will be added to
> git for-each-ref calls so that branches and tags can be matched case
> insensitively.
> 
> Signed-off-by: Alison Winters <alisonatwork@outlook.com>
> ---
>  contrib/completion/git-completion.bash | 41 ++++++++++++++++++++++++++
>  t/t9902-completion.sh                  | 16 ++++++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index ba5c395d2d8..8ed96a5b8b6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -58,6 +58,11 @@
>  #
>  #     When set to "1" suggest all options, including options which are
>  #     typically hidden (e.g. '--allow-empty' for 'git commit').
> +#
> +#   GIT_COMPLETION_IGNORE_CASE
> +#
> +#     When set to "1", suggest refs that match case insensitively (e.g.,
> +#     completing "FOO" on "git checkout f<TAB>").

I wish the commit message and this comment would be more explicit
about only the matching being case insensitive, but the words listed
for completion will all have the same case as the files/refs/etc. that
are being completed.

I've already started writing a reply along the lines of "does this
only work on case-insensitive filesystems?!" before finally realizing
that's not how it works...

>  case "$COMP_WORDBREAKS" in
>  *:*) : great ;;
> @@ -644,8 +649,15 @@ __git_complete_index_file ()
>  __git_heads ()
>  {
>  	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
> +	local ignore_case=""
> +
> +	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
> +	then
> +		ignore_case="--ignore-case"
> +	fi

I find these six lines a bit too verbose for what there are doing,
especially since the same six lines are added a couple of times.  I
think it could be shortened to just a single line with the "use
alternate value" parameter expansion like this:

    local ignore_case=${GIT_COMPLETION_IGNORE_CASE+--ignore-case}

>  	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
> +			$ignore_case \

In fact, we could eliminate that new $ignore_case local variable
entirely by adding that parameter expansion right here.

>  			"refs/heads/$cur_*" "refs/heads/$cur_*/**"
>  }
>  
> @@ -657,8 +669,15 @@ __git_heads ()
>  __git_remote_heads ()
>  {
>  	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
> +	local ignore_case=""
> +
> +	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
> +	then
> +		ignore_case="--ignore-case"
> +	fi
>  
>  	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
> +			$ignore_case \
>  			"refs/remotes/$cur_*" "refs/remotes/$cur_*/**"
>  }
>  
> @@ -667,8 +686,15 @@ __git_remote_heads ()
>  __git_tags ()
>  {
>  	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
> +	local ignore_case=""
> +
> +	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
> +	then
> +		ignore_case="--ignore-case"
> +	fi
>  
>  	__git for-each-ref --format="${pfx//\%/%%}%(refname:strip=2)$sfx" \
> +			$ignore_case \
>  			"refs/tags/$cur_*" "refs/tags/$cur_*/**"
>  }
>  
> @@ -682,12 +708,19 @@ __git_dwim_remote_heads ()
>  {
>  	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
>  	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
> +	local ignore_case=""
> +
> +	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
> +	then
> +		ignore_case="--ignore-case"
> +	fi
>  
>  	# employ the heuristic used by git checkout and git switch
>  	# Try to find a remote branch that cur_es the completion word
>  	# but only output if the branch name is unique
>  	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
>  		--sort="refname:strip=3" \
> +		$ignore_case \
>  		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
>  	uniq -u
>  }
> @@ -713,6 +746,7 @@ __git_refs ()
>  	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
>  	local match="${4-}"
>  	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
> +	local ignore_case=""
>  
>  	__git_find_repo_path
>  	dir="$__git_repo_path"
> @@ -735,6 +769,11 @@ __git_refs ()
>  		fi
>  	fi
>  
> +	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
> +	then
> +		ignore_case="--ignore-case"
> +	fi
> +
>  	if [ "$list_refs_from" = path ]; then
>  		if [[ "$cur_" == ^* ]]; then
>  			pfx="$pfx^"
> @@ -765,6 +804,7 @@ __git_refs ()
>  			;;
>  		esac
>  		__git_dir="$dir" __git for-each-ref --format="$fer_pfx%($format)$sfx" \
> +			$ignore_case \
>  			"${refs[@]}"
>  		if [ -n "$track" ]; then
>  			__git_dwim_remote_heads "$pfx" "$match" "$sfx"
> @@ -787,6 +827,7 @@ __git_refs ()
>  			$match*)	echo "${pfx}HEAD$sfx" ;;
>  			esac
>  			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
> +				$ignore_case \
>  				"refs/remotes/$remote/$match*" \
>  				"refs/remotes/$remote/$match*/**"
>  		else
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 43de868b800..f62a395d827 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2255,6 +2255,22 @@ test_expect_success 'checkout completes ref names' '
>  	EOF
>  '
>  
> +test_expect_success 'checkout does not match ref names of a different case' '
> +	test_completion "git checkout M" ""
> +'
> +
> +test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGNORE_CASE' '
> +	(
> +		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&

I don't think it's necessary to source the completion script here,
because the test script's main shell process has already sourced it,
and its functions are visible in this test's subshell as well.

(Yeah, there are a few test cases near the end that do (re-)source the
completion script, but they do so because they must invalidate the
cache variables used by the completion script; this case-insensitive
match feature, however, doesn't involve any of those cache variables.)

> +		GIT_COMPLETION_IGNORE_CASE=1 && export GIT_COMPLETION_IGNORE_CASE &&

There is no need to export this variable, because only a handful of
completion helper functions look at it, which are invoked in this same
shell process (or perhaps in one of its subshells, but this variable
will be visible there are all the same).

> +		test_completion "git checkout M" <<-\EOF
> +		main Z
> +		mybranch Z
> +		mytag Z
> +		EOF
> +	)
> +'
> +
>  test_expect_success 'git -C <path> checkout uses the right repo' '
>  	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
>  	branch-in-other Z
> -- 
> gitgitgadget
> 
