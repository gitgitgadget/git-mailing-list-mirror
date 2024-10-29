Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E28192D8F
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730213569; cv=none; b=HM0CBYDQvGOQhLyq3DGcC+nhUM5LF4LKJTYB4Hi3eccFSR8Vwm4NlZd3BTWN6G06GyXzGqvIDttSTrNfxHogKSK6df0FjrISTiVCqRJhdmx4OVqjYBOY7aSiUfzvGyq8V4u+L5cCKJCpVSgOnVAxfo4O3LdadWyb7Lk842agiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730213569; c=relaxed/simple;
	bh=NFg4yDW0xZ9yiHm5Re14ISubpem5c/Do5euO07/qTgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAUNmE82xV87z4pHpJ9r0l/5Eyak31FQ27TX1IOosfdnlCzoeXzuh2bO0su6l0duJ1t7C7VIW4QpgAagN+AOUz1ou1MP3P+LIoY3d/13ew9bxW/9XCH/iUD7QZCAMikE1QD58yfeGxZbzElhVP4rF1J7l7gbDA76laTZrJzuN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+pPFZC8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+pPFZC8"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e13375d3so6262509e87.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730213564; x=1730818364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2s8f+NLNVYGp4jipVae7hvptSwHnj8s/r98nYRVrMJA=;
        b=l+pPFZC8V3eNXcOiyaEuAbYPq+DCbPZoL+M7l4O3ePKd7XL3SYRSzeKEWlvRcBwXJ6
         HAXPvY/1L3TEMfCyINUk5px/jepHu5rswGvegjyhbmdkLcb0zf+vYJucucHZ2SRLHtp3
         bd3faX77+mNZCPwEFpZ1FrXef4DG3pv8FqrgMLmBFDs7Kdgwlekw6/tqMEz7Txl8ElQc
         nf5OE+aCY0lSa+qmG+xLoMG5O0XjT4TBse4shNAQXEzrMIXfhd8SX6Z854vy0PiD8UVh
         ArFQGftWWxAdlI7/tx+HiU0iE96F/kQMpoGuU2UygdLnFasahvnwrmTOP/HxJHNEA4qn
         CV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730213564; x=1730818364;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2s8f+NLNVYGp4jipVae7hvptSwHnj8s/r98nYRVrMJA=;
        b=gegRk3UvtdmrV3MkoADHJLASFjpGHaT0R0/t2yXn/6k564hwYNZ4tEW8vTsUbxQm0m
         PSaghm2aMxKqRZcabhatgyauS+KznkxT6x3rDXO6fwO903OxzdhJcNFUt/QFPQ1B7fLe
         Dbs+Ijdn1QCKc7/d0j6CfNdkib/b8+j8G6PL63f6s6cQ341XL/mpsmjfYtHlaHRztlzL
         GSpWQPiup181k/AOvQA6Rvr3RuJSFp7pU3agDCCeuSmg5YWDD/Gc0lY92igdgF0fTZY6
         PdJGEk/pl1UGypXERUFlP5skEkVTcIK1lcoOMa62TTCXGnnsOgL2LX26cDkKih7LChf5
         0FTA==
X-Forwarded-Encrypted: i=1; AJvYcCW/DNtmpoEBiginHA3WRP9UivuuviHPKbHD9KEyp4xU+2WM7M+hUBWutNNfe2JJmkDb2EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfT8rEKMTfU86WPQz+SP4y70+6Byj79xtEUEE2fvqF9HZUO7hA
	U7ayZMEzOwWiMWCs/jSmquVm2fZ+U0GdhZG+CV/KkGdI4pbt7u5/
X-Google-Smtp-Source: AGHT+IGCzE8v096P308tdko1OejEZsZ/aXsikOkdn8oTdqtomLNiE0KlXqjbgetjEwbmAbxXaAV/Ow==
X-Received: by 2002:a05:6512:4006:b0:53a:aea:81cc with SMTP id 2adb3069b0e04-53b34c463e4mr5216646e87.57.1730213564250;
        Tue, 29 Oct 2024 07:52:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b542d3csm176691195e9.9.2024.10.29.07.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 07:52:43 -0700 (PDT)
Message-ID: <985646c7-8a16-4014-a379-644408157934@gmail.com>
Date: Tue, 29 Oct 2024 14:52:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/5] worktree: add tests for worktrees with relative
 paths
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 28/10/2024 19:09, Caleb White wrote:
> This patch expands the test coverage by adding cases that specifically
> handle relative paths. These tests verify correct behavior in a variety
> of operations, including: adding, listing, pruning, moving, and
> repairing worktrees with relative paths configured.
> 
> This also adds a test case for reinitializing a repository that has
> relative worktrees.

It's nice to see new tests being added. If they were added with the code 
changes they test that would help reader understand the changes being 
made I think.

Best Wishes

Phillip

> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>   t/t0001-init.sh            | 17 +++++++++++++----
>   t/t2400-worktree-add.sh    | 41 +++++++++++++++++++++++++++++++++++++++++
>   t/t2401-worktree-prune.sh  |  3 ++-
>   t/t2402-worktree-list.sh   | 22 ++++++++++++++++++++++
>   t/t2403-worktree-move.sh   | 22 ++++++++++++++++++++++
>   t/t2406-worktree-repair.sh | 26 ++++++++++++++++++++++++++
>   6 files changed, 126 insertions(+), 5 deletions(-)
> 
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..e21b9aa5e7f4599af8b20165b50896c9a49ba7ea 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -435,6 +435,7 @@ sep_git_dir_worktree ()  {
>   	test_when_finished "rm -rf mainwt linkwt seprepo" &&
>   	git init mainwt &&
>   	test_commit -C mainwt gumby &&
> +	git -C mainwt config worktree.useRelativePaths "$([ "$2" = "relative" ] && echo true || echo false)" &&
>   	git -C mainwt worktree add --detach ../linkwt &&
>   	git -C "$1" init --separate-git-dir ../seprepo &&
>   	git -C mainwt rev-parse --git-common-dir >expect &&
> @@ -442,12 +443,20 @@ sep_git_dir_worktree ()  {
>   	test_cmp expect actual
>   }
>   
> -test_expect_success 're-init to move gitdir with linked worktrees' '
> -	sep_git_dir_worktree mainwt
> +test_expect_success 're-init to move gitdir with linked worktrees (absolute)' '
> +	sep_git_dir_worktree mainwt absolute
>   '
>   
> -test_expect_success 're-init to move gitdir within linked worktree' '
> -	sep_git_dir_worktree linkwt
> +test_expect_success 're-init to move gitdir within linked worktree (absolute)' '
> +	sep_git_dir_worktree linkwt absolute
> +'
> +
> +test_expect_success 're-init to move gitdir with linked worktrees (relative)' '
> +	sep_git_dir_worktree mainwt relative
> +'
> +
> +test_expect_success 're-init to move gitdir within linked worktree (relative)' '
> +	sep_git_dir_worktree linkwt relative
>   '
>   
>   test_expect_success MINGW '.git hidden' '
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index cfc4aeb1798c6d023909cec771e5b74e983af5ea..630c13230b3cc762ce8d943e22be8891aa2b1871 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -1207,4 +1207,45 @@ test_expect_success '"add" with initialized submodule, with submodule.recurse se
>   	git -C project-clone -c submodule.recurse worktree add ../project-5
>   '
>   
> +test_expect_success 'can create worktrees with relative paths' '
> +	test_when_finished "git worktree remove relative" &&
> +	git config worktree.useRelativePaths false &&
> +	git worktree add --relative-paths ./relative &&
> +	cat relative/.git >actual &&
> +	echo "gitdir: ../.git/worktrees/relative" >expect &&
> +	test_cmp expect actual &&
> +	cat .git/worktrees/relative/gitdir >actual &&
> +	echo "../../../relative/.git" >expect &&
> +	test_cmp expect actual
> +
> +'
> +
> +test_expect_success 'can create worktrees with absolute paths' '
> +	git config worktree.useRelativePaths true &&
> +	git worktree add ./relative &&
> +	cat relative/.git >actual &&
> +	echo "gitdir: ../.git/worktrees/relative" >expect &&
> +	test_cmp expect actual &&
> +	git worktree add --no-relative-paths ./absolute &&
> +	cat absolute/.git >actual &&
> +	echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'move repo without breaking relative internal links' '
> +	test_when_finished rm -rf repo moved &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config worktree.useRelativePaths true &&
> +		test_commit initial &&
> +		git worktree add wt1 &&
> +		cd .. &&
> +		mv repo moved &&
> +		cd moved/wt1 &&
> +		git status >out 2>err &&
> +		test_must_be_empty err
> +	)
> +'
> +
>   test_done
> diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
> index 976d048e3efc74be9cd909ce76d552b3944d2e10..5eb52b9abbf29514dc082c260ebb7a5e8e63aae0 100755
> --- a/t/t2401-worktree-prune.sh
> +++ b/t/t2401-worktree-prune.sh
> @@ -120,11 +120,12 @@ test_expect_success 'prune duplicate (main/linked)' '
>   	! test -d .git/worktrees/wt
>   '
>   
> -test_expect_success 'not prune proper worktrees when run inside linked worktree' '
> +test_expect_success 'not prune proper worktrees inside linked worktree with relative paths' '
>   	test_when_finished rm -rf repo wt_ext &&
>   	git init repo &&
>   	(
>   	    cd repo &&
> +	    git config worktree.useRelativePaths true &&
>   	    echo content >file &&
>   	    git add file &&
>   	    git commit -m msg &&
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> index 33ea9cb21ba07c9563530b54da06753eaa993fe2..780daa6cd6351f8fa9434619cc212aade8f01420 100755
> --- a/t/t2402-worktree-list.sh
> +++ b/t/t2402-worktree-list.sh
> @@ -261,6 +261,7 @@ test_expect_success 'broken main worktree still at the top' '
>   '
>   
>   test_expect_success 'linked worktrees are sorted' '
> +	test_when_finished "rm -rf sorted" &&
>   	mkdir sorted &&
>   	git init sorted/main &&
>   	(
> @@ -280,6 +281,27 @@ test_expect_success 'linked worktrees are sorted' '
>   	test_cmp expected sorted/main/actual
>   '
>   
> +test_expect_success 'linked worktrees with relative paths are shown with absolute paths' '
> +	test_when_finished "rm -rf sorted" &&
> +	mkdir sorted &&
> +	git init sorted/main &&
> +	(
> +		cd sorted/main &&
> +		test_tick &&
> +		test_commit new &&
> +		git worktree add --relative-paths ../first &&
> +		git worktree add ../second &&
> +		git worktree list --porcelain >out &&
> +		grep ^worktree out >actual
> +	) &&
> +	cat >expected <<-EOF &&
> +	worktree $(pwd)/sorted/main
> +	worktree $(pwd)/sorted/first
> +	worktree $(pwd)/sorted/second
> +	EOF
> +	test_cmp expected sorted/main/actual
> +'
> +
>   test_expect_success 'worktree path when called in .git directory' '
>   	git worktree list >list1 &&
>   	git -C .git worktree list >list2 &&
> diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
> index 901342ea09b51a8e832f1109fbb737df84283aa2..6ce9ed3f1e6b3f73d2a290e770233eec30221fe5 100755
> --- a/t/t2403-worktree-move.sh
> +++ b/t/t2403-worktree-move.sh
> @@ -247,4 +247,26 @@ test_expect_success 'not remove a repo with initialized submodule' '
>   	)
>   '
>   
> +test_expect_success 'move worktree with absolute path to relative path' '
> +	git config worktree.useRelativePaths false &&
> +	git worktree add ./absolute &&
> +	git worktree move --relative-paths absolute relative &&
> +	cat relative/.git >actual &&
> +	echo "gitdir: ../.git/worktrees/absolute" >expect &&
> +	test_cmp expect actual &&
> +	git config worktree.useRelativePaths true &&
> +	git worktree move relative relative2 &&
> +	cat relative2/.git >actual &&
> +	echo "gitdir: ../.git/worktrees/absolute" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'move worktree with relative path to absolute path' '
> +	git config worktree.useRelativePaths true &&
> +	git worktree move --no-relative-paths relative2 absolute &&
> +	cat absolute/.git >actual &&
> +	echo "gitdir: $(pwd)/.git/worktrees/absolute" >expect &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
> index 7686e60f6ad186519b275f11a5e14064c905b207..84451e903b2ef3c645c0311faf055c846588baf6 100755
> --- a/t/t2406-worktree-repair.sh
> +++ b/t/t2406-worktree-repair.sh
> @@ -216,4 +216,30 @@ test_expect_success 'repair copied main and linked worktrees' '
>   	test_cmp dup/linked.expect dup/linked/.git
>   '
>   
> +test_expect_success 'repair absolute worktree to use relative paths' '
> +	test_when_finished "rm -rf main side sidemoved" &&
> +	test_create_repo main &&
> +	test_commit -C main init &&
> +	git -C main worktree add --detach ../side &&
> +	echo "../../../../sidemoved/.git" >expect-gitdir &&
> +	echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
> +	mv side sidemoved &&
> +	git -C main worktree repair --relative-paths ../sidemoved &&
> +	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
> +	test_cmp expect-gitfile sidemoved/.git
> +'
> +
> +test_expect_success 'repair relative worktree to use absolute paths' '
> +	test_when_finished "rm -rf main side sidemoved" &&
> +	test_create_repo main &&
> +	test_commit -C main init &&
> +	git -C main worktree add --relative-paths --detach ../side &&
> +	echo "$(pwd)/sidemoved/.git" >expect-gitdir &&
> +	echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
> +	mv side sidemoved &&
> +	git -C main worktree repair ../sidemoved &&
> +	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
> +	test_cmp expect-gitfile sidemoved/.git
> +'
> +
>   test_done
> 

