Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF77C433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 20:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiKTUmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 15:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiKTUmi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 15:42:38 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E12D2AC4
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 12:42:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l24so1136455edj.8
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Tfb/eSzGf9WkaQT4cTWYoJ8Micpk4lK2IoYhER8thQ=;
        b=LXXG25lnaiGPqUbJ7bKwMYxo7VH5PxayTEzzf+orHmvATXVNsLgDuZXUrD3QB18TxH
         YjTdeu9ozfmql9zzNmk3i7nRZyfiAva+C+WWQr/rqqyYmaAMsPWOxLMNjjEvPBvK1zQE
         pgemC2C+vGzmnv2WaKRDmS8bJjWxPlVunCR3CzmRnExh83hJ49+T8SV3SnUWpQ6p16wK
         RzrfJcOxtSu/E5oGNGDa4lyMQXg/byyLzEbV/wPFgrnUut2ehpvHjoOHX7iRweWnlzao
         8gHSM7NpB2buQKIe4D5Fq0MlN9IycnDt9nVigG1rUE8jL/WUoH1RWzt+/HGxoEpBaYsJ
         7/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Tfb/eSzGf9WkaQT4cTWYoJ8Micpk4lK2IoYhER8thQ=;
        b=JTTgGsgFq/eqL8W76HHKVx2ICkR6a+EjfHpT3IoTxauMEG+DxipzjHrt7rL0BpKwfp
         BcS+qHgrSTTlNcQioXj/QUo6fOxqPuqPxgtcwi1AYUTjSC4JmkQsRgoX5NZHrdJmIKIA
         NLlFuCx0lqEsTO/BcGFfnCK1NOAFsggZCFQXGf1le+9FoWwipkN9b4CPM4qYENqpc/9s
         tZQ/YMLwI4bsYb9UhirXPcGdDmI3F+N4iHZ09YAetmg0YSeSwhpvMxfGsGbBiLFdeaV6
         +q4FDhPGa53tAxanpZseu9GYVrwiqNiaYko0RtKROCddvvlLn9QSoYuAmevY63KRAjGK
         dkuw==
X-Gm-Message-State: ANoB5pnL3UXxzAn3KAVTgsAhDs5L8oi+eg3XjqPF5O/aBCvlzZ2e+jIl
        El+74uqHiLoC3PGMSuLqFk4=
X-Google-Smtp-Source: AA0mqf60ayypsSvhxDfrPn+kSb2dKZezvrFlzhogAHyzqR9qUNE7H+6jArejRCC7bn9h/AQAv/WAhw==
X-Received: by 2002:a05:6402:68c:b0:461:b506:6b8a with SMTP id f12-20020a056402068c00b00461b5066b8amr13619470edy.208.1668976954108;
        Sun, 20 Nov 2022 12:42:34 -0800 (PST)
Received: from localhost (94-21-23-70.pool.digikabel.hu. [94.21.23.70])
        by smtp.gmail.com with ESMTPSA id dy16-20020a05640231f000b004678b543163sm4422147edb.0.2022.11.20.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 12:42:33 -0800 (PST)
Date:   Sun, 20 Nov 2022 21:42:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Alison Winters via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Alison Winters <alisonatwork@outlook.com>
Subject: Re: [PATCH 2/2] completion: add case-insensitive match of pseudorefs
Message-ID: <20221120204232.GC4039@szeder.dev>
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
 <c455e855395dcc9215ea4ce3181eb3cbaff4000b.1667669315.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c455e855395dcc9215ea4ce3181eb3cbaff4000b.1667669315.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2022 at 05:28:35PM +0000, Alison Winters via GitGitGadget wrote:
> From: Alison Winters <alisonatwork@outlook.com>
> 
> When GIT_COMPLETION_IGNORE_CASE=1, also allow lowercase completion text
> like "head" to match HEAD and other pseudorefs.
> 
> Signed-off-by: Alison Winters <alisonatwork@outlook.com>
> ---
>  contrib/completion/git-completion.bash | 10 +++++++---
>  t/t9902-completion.sh                  | 16 ++++++++++++++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8ed96a5b8b6..161327057da 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -745,6 +745,7 @@ __git_refs ()
>  	local format refs
>  	local pfx="${3-}" cur_="${4-$cur}" sfx="${5-}"
>  	local match="${4-}"
> +	local umatch="${4-}"

Why 'umatch' and not 'imatch'?

>  	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
>  	local ignore_case=""
>  
> @@ -772,6 +773,8 @@ __git_refs ()
>  	if test "${GIT_COMPLETION_IGNORE_CASE-}" = "1"
>  	then
>  		ignore_case="--ignore-case"
> +		# use tr instead of ${match,^^} to preserve bash 3.2 compatibility

Thank you for keeping compatibility with old versions in mind!

> +		umatch=$(echo "$match" | tr a-z A-Z 2> /dev/null || echo "$match")

Style nit: we usually don't add a space between the redirection
operator and the filename.

>  	fi
>  
>  	if [ "$list_refs_from" = path ]; then
> @@ -780,6 +783,7 @@ __git_refs ()
>  			fer_pfx="$fer_pfx^"
>  			cur_=${cur_#^}
>  			match=${match#^}
> +			umatch=${umatch#^}
>  		fi
>  		case "$cur_" in
>  		refs|refs/*)
> @@ -790,7 +794,7 @@ __git_refs ()
>  		*)
>  			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD REBASE_HEAD CHERRY_PICK_HEAD; do
>  				case "$i" in
> -				$match*)
> +				$match*|$umatch*)

I find the two patterns here weird.  I suppose it works as intended,
because with GIT_COMPLETION_IGNORE_CASE being unset both $match and
$umatch have the same value, so there is only one pattern after all,
but when GIT_COMPLETION_IGNORE_CASE is set then $umatch contains the
case insensitive pattern...  but I still find it a bit weird :) but I
don't know how to make it less weird without introducing code
duplication, so it's still better than the alternatives.

>  					if [ -e "$dir/$i" ]; then
>  						echo "$pfx$i$sfx"
>  					fi
> @@ -824,7 +828,7 @@ __git_refs ()
>  	*)
>  		if [ "$list_refs_from" = remote ]; then
>  			case "HEAD" in
> -			$match*)	echo "${pfx}HEAD$sfx" ;;
> +			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
>  			esac
>  			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
>  				$ignore_case \
> @@ -833,7 +837,7 @@ __git_refs ()
>  		else
>  			local query_symref
>  			case "HEAD" in
> -			$match*)	query_symref="HEAD" ;;
> +			$match*|$umatch*)	query_symref="HEAD" ;;
>  			esac
>  			__git ls-remote "$remote" $query_symref \
>  				"refs/tags/$match*" "refs/heads/$match*" \
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index f62a395d827..b4c46567fa4 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2271,6 +2271,22 @@ test_expect_success 'checkout matches case insensitively with GIT_COMPLETION_IGN
>  	)
>  '
>  
> +test_expect_success 'checkout completes pseudo refs' '
> +	test_completion "git checkout H" <<-\EOF
> +	HEAD Z
> +	EOF
> +'
> +
> +test_expect_success 'checkout completes pseudo refs case insensitively with GIT_COMPLETION_IGNORE_CASE' '
> +	(
> +		. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> +		GIT_COMPLETION_IGNORE_CASE=1 && export GIT_COMPLETION_IGNORE_CASE &&

The same comment about the unnecessary sourcing and exporting on the
previous patch applies here as well.

> +		test_completion "git checkout h" <<-\EOF
> +		HEAD Z
> +		EOF
> +	)
> +'
> +
>  test_expect_success 'git -C <path> checkout uses the right repo' '
>  	test_completion "git -C subdir -C subsubdir -C .. -C ../otherrepo checkout b" <<-\EOF
>  	branch-in-other Z
> -- 
> gitgitgadget
