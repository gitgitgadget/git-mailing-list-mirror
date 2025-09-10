Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71A3128A4
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497146; cv=none; b=B4FTwwmWnH3JWWVFzNpzldswmQF2J9g9NFowYLH0fP7MkaCCOOt3yQA/7R3XbsSZ1XIvV4Hys4a+1RIVCMhp7T0pmWd907NCt0R/in+gcbD7jXS39kLJ2stUfKik6R5//GpcU5RnmyG6Q7mUUFFHyY0J75oJssJf1sWNs6UfkcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497146; c=relaxed/simple;
	bh=sOo+/UP4vPtv2/P5qjXWEnSsdN/pOkBXfwrlqZ1Hdfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7oMlwhjATTVtRJX25I7Z0j4JgSURvuGjsoLzA8WDA5IBbN/BrdPZTXtF15RBQOesq3y+MM0mbwgXoDyRiiGAhfEapLixmFpuMWF5O4/MTQdZXY0PyC65ix7ImnifBXY9r9lXhlX+9sVko0v3+m5UD5FrDLSuvaPnwcIP9tK/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHcxPqAU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHcxPqAU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dde353b47so19387135e9.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757497142; x=1758101942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s35goMQ5nPKKR/7TTr9+yYTFPCQSkzMcEQiYalIf1aQ=;
        b=kHcxPqAUmgISmcslaOC65Jf/hve5sTYglwWV8StqmVlTZg4gGMRXVG+TiPscUZ+m1o
         u9N7dZ4lut+159dsrOlNbHgH41zROI0sRYFiJYAjRw4itaDqQ5eSJX0eHA8iEdCPriCR
         oCPWeEO8cVwUYMOPtEGv7ROCzuSx9rLVgYs+NcuiN4qEbx1PjPUsI7PNUvDnkL5m95Lo
         TTNeBB9yjVsmRsjyfDZk2/mYZsrnXa+XtyuRhKEm7+4HCMx1PM8rkBhfG9Mcg7Q4+rv8
         DZNlSrmfIW7i2TG/wqkJNu75NsQ8sAjsId9SLKipc+gXyv8opFI5LHbxSxBT5KQY4uS8
         crMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497142; x=1758101942;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s35goMQ5nPKKR/7TTr9+yYTFPCQSkzMcEQiYalIf1aQ=;
        b=vFd3asE/Mune71W6dc7bkHbBHXsSQAj18irWDILuaKlGwN33By0zvGxXL/2SY5T3RT
         b8wfJ7lotEEnk5zGpzMyI+kORyJFPqChP81OWIVfa7MNVCCG9Itow8yzhQbvvBe0S24V
         vjhsHXnsi3VQtvSbyGy1wjtiepYgCfOH+rmzf01uZU3lDheSmjuOBEZwv1AoNhVzKNsZ
         8RIWQ0IMDGoWYroZNVHRp8+wa3jdeNQy2qslC33NkaFLwBTRem/CLthz/1BpDth8z5fP
         UBsWiG/IAy25CzIF77d/cqvVeQuRaXmIQAHExK+qZs5gvfsu/wY/FZaEO2OT+nBwx3R1
         cQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCV9TjDow1OZyfxy8hta5g9qaqMEpdqCl+5Ud9f2CMuHUh54u5TTx+h6xbEyGfBCA3hso5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh02jUD1rJH38T1o793sLwfzcktLyy7u3joeIBv6D+jPbfctLv
	5dBYrPoHppf0pN2FTdWZ88MZ5rmUa6AFpk98KCeg2kiukdxmtg4hxcrs
X-Gm-Gg: ASbGncvRe0WWE5E/fdiHUU4DgCIeg/x5iQdzAOwbqBGDaUrYFy/219a8Nq1yVXdUqxi
	0wo4oka5S3HD1f7ZGh4o5ymi5BHS1S431w5MDxTKC0vShn5SgtLBG4OrE1/ypDhxUf36ZNshwCv
	7mDIZlBQ4OSw9JtAsI2uskEsUlp9LkTEppPC3ErgAF9Mi84nI6hhJtaf+nzIkvZSQ/YsRAr/qBR
	ADgv8qZP8TDcf0WzokS02oF6B9/HcGbZYgzvd9w/hG9IX/3NI1hhjQkRtpVLYEaM3FaiLT2YNwj
	NsVX4ZL7sK9HWOrJrP6BzP64tESuHmQuktYeqY2Ke+kdIIE0FwN4g5gp2YG2MpT87Giu5jQDL1c
	2LlNMvVCvbaJ/v92nts/L5QNYop3QsuEhvqbdANuWUlsv1kMdowKW6FwlZGxTuLsfipeK3zGo7J
	WY7NvPJB7CNQ==
X-Google-Smtp-Source: AGHT+IFwWfhk142MaSEFXkbSgc7rHjoNxfAeD7GFEetd88O3b7CVEuUw1SluoJ9dB+2diRpSPxJ5Qw==
X-Received: by 2002:a05:600c:1907:b0:45d:f7e4:8969 with SMTP id 5b1f17b1804b1-45df7e489eamr17214915e9.4.1757497141808;
        Wed, 10 Sep 2025 02:39:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8259524sm20773805e9.21.2025.09.10.02.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:39:01 -0700 (PDT)
Message-ID: <dd71ebee-8629-43c3-aa2a-40124400f262@gmail.com>
Date: Wed, 10 Sep 2025 10:39:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] contrib/subtree: fix split with squashed subtrees
To: Colin Stagner <ask+git@howdoi.land>, git@vger.kernel.org,
 phillip.wood@dunelm.org.uk
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
 <20250910031124.1807856-1-ask+git@howdoi.land>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250910031124.1807856-1-ask+git@howdoi.land>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Colin

Thanks for working on this. I'm not particularly familiar with 
git-subtree but as far as I can see this version looks good.

Thanks

Phillip

On 10/09/2025 04:11, Colin Stagner wrote:
> 98ba49ccc2 (subtree: fix split processing with multiple subtrees
> present, 2023-12-01) increases the performance of
> 
>      git subtree split --prefix=subA
> 
> by ignoring subtree merges which are outside of `subA/`. It also
> introduces a regression. Subtree merges that should be retained
> are incorrectly ignored if they:
> 
> 1. are nested under `subA/`; and
> 2. are merged with `--squash`.
> 
> For example, a subtree merged like:
> 
>      git subtree merge --squash --prefix=subA/subB "$rev"
>      #                 ^^^^^^^^          ^^^^
> 
> is erroneously ignored during a split of `subA`. This causes
> missing tree files and different commit hashes starting in
> git v2.44.0-rc0.
> 
> The method:
> 
>      should_ignore_subtree_split_commit REV
> 
> should test only a single commit REV, but the combination of
> 
>      git log -1 --grep=...
> 
> actually searches all *parent* commits until a `--grep` match is
> discovered.
> 
> Rewrite this method to test only one REV at a time. Extract commit
> information with a single `git` call as opposed to three. The
> `test` conditions for rejecting a commit remain unchanged.
> 
> Unit tests now cover nested subtrees.
> 
> Signed-off-by: Colin Stagner <ask+git@howdoi.land>
> ---
> 
> Notes:
>      This bugfix patch is intended for maint-2.44 and up.
> 
>   contrib/subtree/git-subtree.sh     | 36 +++++++++++----
>   contrib/subtree/t/t7900-subtree.sh | 71 ++++++++++++++++++++++++++++++
>   2 files changed, 99 insertions(+), 8 deletions(-)
> 
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 5dab3f506c..ad9b9b0191 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -783,24 +783,44 @@ ensure_clean () {
>   # Usage: ensure_valid_ref_format REF
>   ensure_valid_ref_format () {
>   	assert test $# = 1
>   	git check-ref-format "refs/heads/$1" ||
>   		die "fatal: '$1' does not look like a ref"
>   }
>   
> -# Usage: check if a commit from another subtree should be
> +# Usage: should_ignore_subtree_split_commit REV
> +#
> +# Check if REV is a commit from another subtree and should be
>   # ignored from processing for splits
>   should_ignore_subtree_split_commit () {
>   	assert test $# = 1
> -	local rev="$1"
> +
> +	git show \
> +		--no-patch \
> +		--no-show-signature \
> +		--format='%(trailers:key=git-subtree-dir,key=git-subtree-mainline)' \
> +		"$1" |
> +	(
> +	have_mainline=
> +	subtree_dir=
> +
> +	while read -r trailer val
> +	do
> +		case "$trailer" in
> +		git-subtree-dir:)
> +			subtree_dir="${val%/}" ;;
> +		git-subtree-mainline:)
> +			have_mainline=y ;;
> +		esac
> +	done
> +
> -	if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
> +	if test -n "${subtree_dir}" &&
> +		test -z "${have_mainline}" &&
> +		test "${subtree_dir}" != "$arg_prefix"
>   	then
> -		if test -z "$(git log -1 --grep="git-subtree-mainline:" $rev)" &&
> -			test -z "$(git log -1 --grep="git-subtree-dir: $arg_prefix$" $rev)"
> -		then
> -			return 0
> -		fi
> +		return 0
>   	fi
>   	return 1
> +	)
>   }
>   
>   # Usage: process_split_commit REV PARENTS
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index ca4df5be83..25be40e12b 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -9,6 +9,9 @@ This test verifies the basic operation of the add, merge, split, pull,
>   and push subcommands of git subtree.
>   '
>   
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
>   TEST_DIRECTORY=$(pwd)/../../../t
>   . "$TEST_DIRECTORY"/test-lib.sh
>   
> @@ -67,6 +70,33 @@ test_create_pre2_32_repo () {
>   	git -C "$1-clone" replace HEAD^2 $new_commit
>   }
>   
> +# test_create_subtree_add REPO ORPHAN PREFIX FILENAME ...
> +#
> +# Create a simple subtree on a new branch named ORPHAN in REPO.
> +# The subtree is then merged into the current branch of REPO,
> +# under PREFIX. The generated subtree has has one commit
> +# with subject and tag FILENAME with a single file "FILENAME.t"
> +#
> +# When this method returns:
> +# - the current branch of REPO will have file PREFIX/FILENAME.t
> +# - REPO will have a branch named ORPHAN with subtree history
> +#
> +# additional arguments are forwarded to "subtree add"
> +test_create_subtree_add () {
> +	(
> +		cd "$1" &&
> +		orphan="$2" &&
> +		prefix="$3" &&
> +		filename="$4" &&
> +		shift 4 &&
> +		last="$(git branch --show-current)" &&
> +		git switch --orphan "$orphan" &&
> +		test_commit "$filename" &&
> +		git checkout "$last" &&
> +		git subtree add --prefix="$prefix" "$@" "$orphan"
> +	)
> +}
> +
>   test_expect_success 'shows short help text for -h' '
>   	test_expect_code 129 git subtree -h >out 2>err &&
>   	test_must_be_empty err &&
> @@ -425,6 +455,47 @@ test_expect_success 'split with multiple subtrees' '
>   		--squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
>   '
>   
> +# When subtree split-ing a directory that has other subtree
> +# *merges* underneath it, the split must include those subtrees.
> +# This test creates a nested subtree, `subA/subB`, and tests
> +# that the tree is correct after a subtree split of `subA/`.
> +# The test covers:
> +# - An initial `subtree add`; and
> +# - A follow-up `subtree merge`
> +# both with and without `--squashed`.
> +for is_squashed in '' 'y'
> +do
> +	test_expect_success "split keeps nested ${is_squashed:+--squash }subtrees that are part of the split" '
> +		subtree_test_create_repo "$test_count" &&
> +		(
> +			cd "$test_count" &&
> +			mkdir subA &&
> +			test_commit subA/file1 &&
> +			test_create_subtree_add \
> +				. mksubtree subA/subB file2 ${is_squashed:+--squash} &&
> +			test_path_is_file subA/file1.t &&
> +			test_path_is_file subA/subB/file2.t &&
> +			git subtree split --prefix=subA --branch=bsplit &&
> +			git checkout bsplit &&
> +			test_path_is_file file1.t &&
> +			test_path_is_file subB/file2.t &&
> +			git checkout mksubtree &&
> +			git branch -D bsplit &&
> +			test_commit file3 &&
> +			git checkout main &&
> +			git subtree merge \
> +				${is_squashed:+--squash} \
> +				--prefix=subA/subB mksubtree &&
> +			test_path_is_file subA/subB/file3.t &&
> +			git subtree split --prefix=subA --branch=bsplit &&
> +			git checkout bsplit &&
> +			test_path_is_file file1.t &&
> +			test_path_is_file subB/file2.t &&
> +			test_path_is_file subB/file3.t
> +		)
> +	'
> +done
> +
>   test_expect_success 'split sub dir/ with --rejoin from scratch' '
>   	subtree_test_create_repo "$test_count" &&
>   	test_create_commit "$test_count" main1 &&
> 
> base-commit: 09669c729af92144fde84e97d358759b5b42b555

