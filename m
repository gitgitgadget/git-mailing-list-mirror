Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929222F3C28
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344907; cv=none; b=I4U2qHQK2nPioyMu7GUvrIJ0hLFItvP1FC9Mick7jsfDDdr1fl5++zBdF5Fz/7gCVr/ui8h9bTiXzC7VnQM0xBuPnCKKVL8uXqAPIHmG+TLen1Ne2RMprdKnUJ8hCIIFsQ+GPTzUlXoyTtzInDbHI8EZ33hAogKEeSZ8Y0RwkOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344907; c=relaxed/simple;
	bh=ML/LPQl07iQ35sW/xjdcLITXHgK68Q7AR1RMJQK3lMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSXYxRG38+JslG3uiXuv/FEp+4gyldl2yN45j742yDt43jb8EP8sHmhRpfXTqsQax6deCb7A2Si3xXI2TNPicIICm8qCiI+LokvAVFSvU0p7B77sSKGq4BzGjpUY4jO4vqJNjMi/8lGmFZjIUIoHFb/RJzR1CvM9qUwPg3z6SdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYjNNBTT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYjNNBTT"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so4876201e87.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757344904; x=1757949704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/C7dyRTh649q7oYGv9LCWxlWa91/qflpRg2tVy6636U=;
        b=LYjNNBTTZwtJVlxwYrNrOv0FeJ3Kz/WiKAuV4QPWVpJ+TVr3+HmhYsjsszZakCPiZf
         ac6Vxy7ecCd6hUKLFCntomK7EKR3IM1iMwtj6QVm//bimdx8LVYq2FlWUy3ZimFWTFdp
         8zcsBZ6OV5VuKZi18BHQX9NAd61hQUTpNJRIjlIU3/A/NBsFSsuDwV7sHg4ZcdCD0WAc
         EdsyeYW5/WyibP3k6NbP6If77yz9MyC04Nm7E101kNs8p3Jpml4kKJAttSRbY+4f01P9
         L4bod6kRfGaTgM0G25mwBJXFwyX6EKMQi4FaUBGi8erS7s+D5XzCyBsar/LBkyNvno5N
         baKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344904; x=1757949704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/C7dyRTh649q7oYGv9LCWxlWa91/qflpRg2tVy6636U=;
        b=u1eDk+HcXjfd4bFvvfh47pQQMMXaRJfBRn2Sz5oNmKjSIZvWFA11njIuH1PFv/Rf5n
         IRiVacTQ9YHoR0+udnaEJTgyqjcO9LvoNccohpuIF2838c97zEji0QJgqPYb7rRFs+hQ
         PyRPFELU2EPmvk4PBwy5FHYRqa7kavgDx//Iz5gUVssVpFlHG0WWyrmDSFzGjxEt3FNm
         l9tzJ5jXl4As1xRoGhNekpNneC2XqXq5T3IQ6IseQAk0tQS7AHWTmgqDV35L3fVZXwXp
         DixBNeRCrLnvr53aeF4K8JjO4YJcsqNETF34da0VCe6ba4YvQD60ynnowFhMnuX4TgmH
         AUpA==
X-Forwarded-Encrypted: i=1; AJvYcCVwM7yUf9uRa4+n4DNnqOw+D/A+9eZ84RK/6JdpJKE66uz8p01DcVT7rqSqVIa08iPz7oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp8ycSLEe5MArkJOwI7chd+prPbcVpl9tp3YDaDa2HKTl7Zied
	h+JRiVwjHJCjm/YktwKwB+kujI2GHT7wiP+LgJIoI0c/wxQIUq1hIITEVl/c+Rim
X-Gm-Gg: ASbGncu2v8IQAGXK8g40Z8BYoYaCRFJhyLd2j39qqJ4D3H8YlrbipXGxwLi++0G2w9T
	fD72Y6/e9Eluww6lLslGJGuD346jtpia78BxbEjrvB5U4bVuaefwNFqsli1MleolIkZ6gnHNihh
	3Q6hB6QXOvrf97vL/fxN76enthU+ajMsjYidXWNRrn/dv+DbnjVHgAEbuztGcuS4voqGPK/Iv0D
	XnIBlCs7iAlh/aoD8M9ptJr4dpI1q4gdXZ4rEotL9BUo/6DTOiPNXfqzCT4uMnY7SMCg2Hr50tV
	7bTYZLq/6UJIuEPztxP8N8b5g+VvFaJnLS1pv2ia/HbjPz49h61RVOqM79jJrHIwyhq3nrTLWkM
	9sEleXCGbrGVKkz2BMHAw9a4XnylBxv8S//TXJeG4VfUBat7BsQYnvhElBQqe6I2d4kR532QU02
	HUMgaB
X-Google-Smtp-Source: AGHT+IEbiceG5KqDva0TvCSnRx24sWfrhnj3vs/biOg0feJdbatqonOqmv3kyHDYChITGxqGv38QKg==
X-Received: by 2002:a05:6512:3b23:b0:55f:7c3a:1176 with SMTP id 2adb3069b0e04-56263007fcdmr2266736e87.55.1757344903438;
        Mon, 08 Sep 2025 08:21:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ad4dec5sm3689898e87.140.2025.09.08.08.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:21:42 -0700 (PDT)
Message-ID: <b78639ee-021d-49fc-8b8d-0140ed8fc010@gmail.com>
Date: Mon, 8 Sep 2025 16:21:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] contrib/subtree: fix split with squashed subtrees
To: Colin Stagner <ask+git@howdoi.land>, git@vger.kernel.org,
 phillip.wood@dunelm.org.uk
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
 <20250905022728.940664-1-ask+git@howdoi.land>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250905022728.940664-1-ask+git@howdoi.land>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Colin

This is looking good. I've left a few comments below, especially on the 
new test.

On 05/09/2025 03:27, Colin Stagner wrote:
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
> +		(git-subtree-dir:)
> +			subtree_dir="${val%/}" ;;
> +		(git-subtree-mainline:)
> +			have_mainline=y ;;
> +		esac
> +	done

This looks good, we run git log once and then parse the trailers. We do 
not use the optional '(' in case statements in our code though.

> -	if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
> +	if test -n "${subtree_dir:-}" &&
> +		test -z "${have_mainline:-}" &&
> +		test "${subtree_dir}" != "$arg_prefix"

If we have a git-subtree-dir: trailer whose value does not match the 
subtree we're interested in and there is no git-subtree-mainline: 
trailer then we skip this commit - good. What's the idea behind using 
"${var:-}" rather than "{var}"?

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
> index ca4df5be83..8bd45e7be7 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -67,6 +67,34 @@ test_create_pre2_32_repo () {
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
> +		git checkout --orphan "$orphan" &&
> +		git rm -rf . &&

If you use "git switch --orphan" that clears the worktree for you

> +		test_commit "$filename" &&
> +		git checkout "$last" &&

I think this could be "git checkout @{-1}" and then we'd avoid having to 
run "git branch" above

> +		git subtree add --prefix="$prefix" "$@" "$orphan"
> +	)
> +}
> +
>   test_expect_success 'shows short help text for -h' '
>   	test_expect_code 129 git subtree -h >out 2>err &&
>   	test_must_be_empty err &&
> @@ -425,6 +453,48 @@ test_expect_success 'split with multiple subtrees' '
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
> +for is_squashed in '' 'y';

no need for ';' at the end of the line

> +do
> +	test_expect_success "split keeps nested ${is_squashed:+--squash }subtrees that are part of the split" '
> +		subtree_test_create_repo "$test_count" &&
> +		(
> +			cd "$test_count" &&
> +			mkdir subA &&
> +			test_commit subA/file1 &&
> +			git branch -m main &&

For tests that depend on the default branch name you can add

	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

to the start of the file before it sources test-lib.sh. Or we could 
change subtree_create_repo() to pass all its arguments along to 
test_create_repo() and use "subtree_create_repo --initial-branch=main 
$test_count"

> +			test_create_subtree_add \
> +				. mksubtree subA/subB file2 ${is_squashed:+--squash} &&
> +			test -e subA/file1.t &&

We have test_path_is_file() for this which prints a useful diagnostic 
message it it fails

Thanks

Phillip

> +			test -e subA/subB/file2.t &&
> +			git subtree split --prefix=subA --branch=bsplit &&
> +			git checkout bsplit &&
> +			test -e file1.t &&
> +			test -e subB/file2.t &&
> +			git checkout mksubtree &&
> +			git branch -D bsplit &&
> +			test_commit file3 &&
> +			git checkout main &&
> +			git subtree merge \
> +				${is_squashed:+--squash} \
> +				--prefix=subA/subB mksubtree &&
> +			test -e subA/subB/file3.t &&
> +			git subtree split --prefix=subA --branch=bsplit &&
> +			git checkout bsplit &&
> +			test -e file1.t &&
> +			test -e subB/file2.t &&
> +			test -e subB/file3.t
> +		)
> +	'
> +done
> +
>   test_expect_success 'split sub dir/ with --rejoin from scratch' '
>   	subtree_test_create_repo "$test_count" &&
>   	test_create_commit "$test_count" main1 &&
> 
> base-commit: 09669c729af92144fde84e97d358759b5b42b555

