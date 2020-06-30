Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B7C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 16:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C854C206BE
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 16:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9msuhTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733192AbgF3QXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgF3QXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 12:23:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F0EC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 09:23:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u9so5056456pls.13
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NwTDbOm4YE12Fl8OET4pp2TlOUEkn+rnnEVAEDgG/9A=;
        b=h9msuhTsqiq0s18f9TxNiZklalLLgrog5yKqJ09v5Mv8OUL764zECe9Kmm3zhGq8BZ
         P5/Nwy2bb7z3giLgX/X4/yVc1bUC2qZUcPuRv+aLr14WlZUZgAMNr+8fVgRof19tMjjw
         QtQpJ3rHKlDgTlwfKSCnJ0wUtypvymHFC0MNsTWDnIPn94CHBqLLqFjNh+aTLr5VjYWa
         XeG4xgCwBFFc/y7U5Dcu9+bYFyusxJDEWCX6/zDPjHXQ8S/n8/DtUJZfCGAcShbqvIUQ
         i3J9G9n0yTuYSqch+Et/KDIGebHm5n8tkomjdDfdeOwhqL/AUMz8/yLe/0ac/KcZrA2U
         5CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NwTDbOm4YE12Fl8OET4pp2TlOUEkn+rnnEVAEDgG/9A=;
        b=P9tc3HE2Mb0fKAzYBSb6w0QHbjg1VwraYs0Jt9aRdJsKZmiyvS9n9MWCp2js+bWnnL
         /pMBP8jHMH4zfbUIlSZVj3qf40QzH2/rgw50hwQAuuakq8nnaVe8UWnRIHUjTqiDESj7
         lQ0DyNAW0phXjbhp3oydIo4xmOKJnaqvYc3FI9RXogoCl2vRTcaaC7T51Cf9YH2wraKP
         SzBtEuGan4VMQkVQaz/aCrpMWnLDbLeS17hOCL7BJUFIfwcHO212PglMuXLceVifgvaa
         p9WW0SvG2lnRIuNPqiHwRppHNrtcxk86ZbfYrFsiZfNPHFlxcJsYqKUrGU3nQYMUKra0
         xZ2w==
X-Gm-Message-State: AOAM531XQfW2IxZhAmSyTgw8J3jzg0LZy4YXa1gLa5zbY7/e0bdjQZh3
        VQjSbe6d7/SU+YRBdN4HK3w=
X-Google-Smtp-Source: ABdhPJz0it5viyZe+Xej8e2ZyPjUb0Vok9irsJuwK3afVjaAC3Vjgp9mu9o0FtACV9jfghZlrka2ng==
X-Received: by 2002:a17:90b:3555:: with SMTP id lt21mr24504162pjb.234.1593534216119;
        Tue, 30 Jun 2020 09:23:36 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id 76sm3229982pfu.139.2020.06.30.09.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:23:35 -0700 (PDT)
Date:   Tue, 30 Jun 2020 23:23:33 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        "lin.sun" <lin.sun@zoom.us>
Subject: Re: [PATCH v4] Enable auto-merge for meld to follow the vim-diff
 beharior
Message-ID: <20200630162333.GA15821@danh.dev>
References: <pull.781.v3.git.git.1593414441313.gitgitgadget@gmail.com>
 <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.781.v4.git.git.1593516397380.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-30 11:26:37+0000, sunlin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: "lin.sun" <lin.sun@zoom.us>

This part needs to be fixed, aka, use your real name here :).

> 
> Make the mergetool used with "meld" backend behave similarly to
> how "vimdiff" beheaves by telling it to auto-merge parts without
> conflicts and highlight the parts with conflicts.
> 
> Signed-off-by: lin.sun <lin.sun@zoom.us>
> ---
>     Enable auto-merge for meld to follow the vimdiff beharior
>     
>     Hi, the mergetool "meld" does NOT merge the no-conflict changes, while
>     the mergetool "vimdiff" will merge the no-conflict changes and highlight
>     the conflict parts. This patch will make the mergetool "meld" similar to
>     "vimdiff", auto-merge the no-conflict changes, highlight conflict parts.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-781%2Fsunlin7%2Fmaster-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-781/sunlin7/master-v4
> Pull-Request: https://github.com/git/git/pull/781
> 
> Range-diff vs v3:
> 
>  1:  3b70fd0bfc ! 1:  93ae3ec011 Enable auto-merge for meld to follow the vim-diff beharior
>      @@ Metadata
>        ## Commit message ##
>           Enable auto-merge for meld to follow the vim-diff beharior
>       
>      -    The mergetool "meld" does NOT merge the no-conflict changes, while the
>      -    mergetool "vimdiff" will merge the no-conflict parts and highlight the
>      -    conflict parts.
>      -    This patch will make the mergetool "meld" similar to "vimdiff",
>      -    auto-merge the no-conflict parts, highlight conflict parts.
>      +    Make the mergetool used with "meld" backend behave similarly to
>      +    how "vimdiff" beheaves by telling it to auto-merge parts without
>      +    conflicts and highlight the parts with conflicts.
>       
>      -    Signed-off-by: Lin Sun <lin.sun@zoom.us>
>      +    Signed-off-by: lin.sun <lin.sun@zoom.us>
>       
>        ## mergetools/meld ##
>      -@@ mergetools/meld: merge_cmd () {
>      - 	then
>      - 		check_meld_for_output_version
>      - 	fi
>      -+	if test -z "${meld_has_auto_merge_option:+set}"
>      -+	then
>      -+		check_meld_for_auto_merge_version
>      -+	fi
>      +@@ mergetools/meld: diff_cmd () {
>      + }
>      + 
>      + merge_cmd () {
>      +-	if test -z "${meld_has_output_option:+set}"
>      ++	check_meld_for_features
>       +
>       +	option_auto_merge=
>       +	if test "$meld_has_auto_merge_option" = true
>      -+	then
>      + 	then
>      +-		check_meld_for_output_version
>       +		option_auto_merge="--auto-merge"
>      -+	fi
>      + 	fi
>        
>        	if test "$meld_has_output_option" = true
>        	then
>      @@ mergetools/meld: merge_cmd () {
>        	fi
>        }
>        
>      -@@ mergetools/meld: check_meld_for_output_version () {
>      - 		meld_has_output_option=false
>      - 	fi
>      - }
>      -+
>      -+# Check whether we should use 'meld --auto-merge ...'
>      -+check_meld_for_auto_merge_version () {
>      -+	meld_path="$(git config mergetool.meld.path)"
>      -+	meld_path="${meld_path:-meld}"
>      +-# Check whether we should use 'meld --output <file>'
>      +-check_meld_for_output_version () {
>      +-	meld_path="$(git config mergetool.meld.path)"
>      +-	meld_path="${meld_path:-meld}"
>      ++# Get meld help message
>      ++get_meld_help_msg () {
>      ++	meld_path="$(git config mergetool.meld.path || echo meld)"
>      ++  $meld_path --help 2>&1
>      ++}
>      + 
>      +-	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
>      ++# Check the features and set flags
>      ++check_meld_for_features () {
>      ++	# Check whether we should use 'meld --output <file>'
>      ++	if test -z "${meld_has_output_option:+set}"
>      + 	then
>      +-		: use configured value
>      +-	elif "$meld_path" --help 2>&1 |
>      +-		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
>      ++		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
>      ++		if test "$meld_has_output_option" = true -o \
>      ++						"$meld_has_output_option" = false
>      ++		then
>      ++			: use configured value
>      ++		else												# treat meld_has_output_option as "auto"
>      ++			if test -z "$meld_help_msg"
>      ++			then
>      ++				meld_help_msg="$(get_meld_help_msg)"
>      ++			fi
>       +
>      -+	if meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
>      -+	then
>      -+		: use configured value
>      -+	elif "$meld_path" --help 2>&1 |
>      -+		grep -e '--auto-merge' -e '\[OPTION\.\.\.\]' >/dev/null
>      -+	then
>      -+		: old ones mention --auto-merge and new ones just say OPTION...
>      -+		meld_has_auto_merge_option=true
>      -+	else
>      -+		meld_has_auto_merge_option=false
>      ++			if echo "$meld_help_msg" |
>      ++							grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
>      ++			then
>      ++				: old ones mention --output and new ones just say OPTION...
>      ++				meld_has_output_option=true
>      ++			else
>      ++				meld_has_output_option=false
>      ++			fi
>      ++		fi
>       +	fi
>      -+}
>      ++	# Check whether we should use 'meld --auto-merge ...'
>      ++	if test -z "${meld_has_auto_merge_option:+set}"
>      + 	then
>      +-		: old ones mention --output and new ones just say OPTION...
>      +-		meld_has_output_option=true
>      +-	else
>      +-		meld_has_output_option=false
>      ++		meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
>      ++		if test "$meld_has_auto_merge_option" = true -o \
>      ++						"$meld_has_auto_merge_option" = false
>      ++		then
>      ++			: use configured value
>      ++		else												# treat meld_has_auto_merge_option as "auto"
>      ++			if test -z "$meld_help_msg"
>      ++			then
>      ++					meld_help_msg="$(get_meld_help_msg)"
>      ++			fi
>      ++
>      ++			if echo "$meld_help_msg" | grep -e '--auto-merge' >/dev/null
>      ++			then
>      ++					meld_has_auto_merge_option=true
>      ++			else
>      ++				meld_has_auto_merge_option=false
>      ++			fi
>      ++		fi
>      + 	fi
>      + }
> 
> 
>  mergetools/meld | 73 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 16 deletions(-)
> 
> diff --git a/mergetools/meld b/mergetools/meld
> index 7a08470f88..1b92771228 100644
> --- a/mergetools/meld
> +++ b/mergetools/meld
> @@ -3,34 +3,75 @@ diff_cmd () {
>  }
>  
>  merge_cmd () {
> -	if test -z "${meld_has_output_option:+set}"
> +	check_meld_for_features
> +
> +	option_auto_merge=
> +	if test "$meld_has_auto_merge_option" = true

We probably want "meld_want_auto_merge"?
Someone may use meld that has --auto-merge but don't want to use it.

>  	then
> -		check_meld_for_output_version
> +		option_auto_merge="--auto-merge"
>  	fi
>  
>  	if test "$meld_has_output_option" = true
>  	then
> -		"$merge_tool_path" --output="$MERGED" \
> +		"$merge_tool_path" $option_auto_merge --output="$MERGED" \
>  			"$LOCAL" "$BASE" "$REMOTE"
>  	else
> -		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
> +		"$merge_tool_path" $option_auto_merge "$LOCAL" "$MERGED" "$REMOTE"
>  	fi
>  }
>  
> -# Check whether we should use 'meld --output <file>'
> -check_meld_for_output_version () {
> -	meld_path="$(git config mergetool.meld.path)"
> -	meld_path="${meld_path:-meld}"
> +# Get meld help message
> +get_meld_help_msg () {
> +	meld_path="$(git config mergetool.meld.path || echo meld)"
> +  $meld_path --help 2>&1

We always use TAB for indentation.

> +}
>  
> -	if meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +# Check the features and set flags
> +check_meld_for_features () {
> +	# Check whether we should use 'meld --output <file>'
> +	if test -z "${meld_has_output_option:+set}"
>  	then
> -		: use configured value
> -	elif "$meld_path" --help 2>&1 |
> -		grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null
> +		meld_has_output_option=$(git config --bool mergetool.meld.hasOutput)
> +		if test "$meld_has_output_option" = true -o \
> +						"$meld_has_output_option" = false
> +		then
> +			: use configured value
> +		else												# treat meld_has_output_option as "auto"

Please don't put your comment like this,
it's too far away from code,
reader may miss that.

> +			if test -z "$meld_help_msg"
> +			then
> +				meld_help_msg="$(get_meld_help_msg)"
> +			fi
> +
> +			if echo "$meld_help_msg" |
> +							grep -e '--output=' -e '\[OPTION\.\.\.\]' >/dev/null

I probably write like this to save a pipe, a fork and an exec:

	case "$meld_help_msg" in
	*"[OPTION"???"]"*)
		meld_has_output_option=true ;;
	*)
		meld_has_output_option=false ;;
	esac

If you don't like the case ... esac,
I prefer "grep -q" in this case,
I didn't check how much portable it's.
Don't forget to hide the error with 2>/dev/null (or in you case 2>&1)

> +			then
> +				: old ones mention --output and new ones just say OPTION...
> +				meld_has_output_option=true
> +			else
> +				meld_has_output_option=false
> +			fi
> +		fi
> +	fi
> +	# Check whether we should use 'meld --auto-merge ...'
> +	if test -z "${meld_has_auto_merge_option:+set}"
>  	then
> -		: old ones mention --output and new ones just say OPTION...
> -		meld_has_output_option=true

I think something was forgotten here?

> -	else
> -		meld_has_output_option=false
> +		meld_has_auto_merge_option=$(git config --bool mergetool.meld.hasAutoMerge)
> +		if test "$meld_has_auto_merge_option" = true -o \
> +						"$meld_has_auto_merge_option" = false
> +		then
> +			: use configured value
> +		else												# treat meld_has_auto_merge_option as "auto"
> +			if test -z "$meld_help_msg"
> +			then
> +					meld_help_msg="$(get_meld_help_msg)"
> +			fi
> +
> +			if echo "$meld_help_msg" | grep -e '--auto-merge' >/dev/null

And I'll use the same "case ... esac" above for this one :)

> +			then
> +					meld_has_auto_merge_option=true
> +			else
> +				meld_has_auto_merge_option=false
> +			fi
> +		fi
>  	fi
>  }
> 
> base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
> -- 
> gitgitgadget

-- 
Danh
