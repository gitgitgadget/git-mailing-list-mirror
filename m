Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354601172A
	for <git@vger.kernel.org>; Sun,  2 Mar 2025 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740925068; cv=none; b=MNy+hcZDicy3V84Ce5zsl6EtK8uMI7Ihxy6gaCXYaOFqbihX+NPK0aojZ824qGRQY6mSZSOab9xgbtQNflH3ZZMxnFny1DXSuzE4+iOV60kIwy0yQLDL49bzNV8OYXY9pJf/vfhWuUVeOoek6AI4f6u9hzTC5jvGtBTugfbtxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740925068; c=relaxed/simple;
	bh=0yANjNS2Zxz9C/BDGJ86gB5d9p8Zx/6EDfRp8rdWm1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwEQjXDG4rwYGB/8xoCk1sIUPgNkn+RhkvCD4NCuTAbDpyNmfChZtwIIL+I1jMZ6Ja1uZMOptprQ048271unbJBF6X3NUEV5vbp6zhHET713emOwGz3i8HE7st4kOCwCba94vXB+mYJKxLUjnNbtT8g8p6JgSk5kY8RGp1Lk6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3xzEs1K; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3xzEs1K"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso22491195e9.0
        for <git@vger.kernel.org>; Sun, 02 Mar 2025 06:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740925064; x=1741529864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RgFP0KXP4AF0XkGiTlb+mU5MisjpHCl0UdM1Pm6EvNA=;
        b=B3xzEs1K2OGlxVdPf3O13lvkc1Fl17n0tHT8k6DBUSmEWMTyrBiB4AB5dEEfj6Shhn
         HUfzjHzpWpdD02WkHNZabznd6KWOrfhMoVD4GHh4nr/ea7tmyq64DAIvAO0edrsH4FFA
         pveirMIpy6cw0svaJjUlfNseuOkyjOw+2m4Hl2vTMk631fjI9c+0J/lyQS0CdcM1AMlh
         B+vgVwO0bBnLQdQ0jj+rdU3el4oAPDVi2zoMm08uRrpeoiG+BBm0t14UxpSNz1y+WsWc
         Ud80DuUA+9gDI7jIg9v9PagLE0+VOxIO1yRLrfcda44G3t5mKSVmzPpG+hxttNg7nbTm
         U7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740925064; x=1741529864;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgFP0KXP4AF0XkGiTlb+mU5MisjpHCl0UdM1Pm6EvNA=;
        b=fO6sgKA80Lb1OPLbucZfRlYgL+534CDlFUq1xWrteL+dUE1Py6dal3ZFjc8ScexaUl
         aXb9U6PuBPQiMOB7DLNzAXm75C+tge0qfcsFeaI47glYJ1X/NZGsa6S6F5E4QS7BbFGE
         o0U8/tXV0LxdjjiiV0Xm7ZKxicsbqts7RbTQqSVV2q4jAlXpwEQrNqF6aCt68wmvM8xG
         r15/QcVnesJGAQCO29r2hLRbpGz7Jy43rojXiWL8KWA5zA8qcV10HYq6LMMriitzcx78
         crx+mKAalWb/QgpsR/KNUNbP985QWBw7mu+Dov/7zfxL2rsJlzVpxqlvl63zhiIsZIQS
         kMhA==
X-Forwarded-Encrypted: i=1; AJvYcCUmkz09oc4jqeEUjpEx8gjTIIDS/dXnc8QtdZai3MOS2FlUX4mbak50pwuM8CAiwFEuMgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAcvOgX9YF7eEFB1zGi93hS4nWqKDPVIQq9iU3KBN0m4LbCdG
	6CObF1TlF8qBfrlF3CsBkjO0/ryZNAhU2GOsCv4FgTQThFxdixDAosCObU67204=
X-Gm-Gg: ASbGnctFiLgaklWXVb70GuM4IxNw0pI1F4kz2qX04nxt0ZjHeXwgbMXPXcbBAnXUUXf
	dpzcHvUFL9xuWzcfBzFf4VOko/N2QRQewPG+t/dDH/XRUD+JsmX0Uoe8s8wCwL761IVOnEFM8ku
	u71CEpTZuCf7WC+iA//oWHiQxXnA9o5h5nPp4aJgdQZh3g4Vly53BzjgRL146U2Fla0QuefgSXl
	nN8X8+/kYWiT5nKqNuONcguT3O18a34DDaZ/qbzybNsDQZwZ0u8QwVtaPqFlkGcjBdHUmrTmiFU
	6zMV1oVZ8xS0m1b2ga8QTcifTYLL/NzEEqJhsusHOywtNH8ON9eyfAJ8MiH8pEPdo4b2MrC+YmD
	VU6Rmf0hmDeeVXIOPDezPn1A=
X-Google-Smtp-Source: AGHT+IESx3tdqh6vvf0XgDAIuaO6kCXZLmqsOUNLfqjKUieFBfbt4wjA/DLl/LaEb5QhlqHG9vQGCA==
X-Received: by 2002:a05:600c:4f10:b0:439:9a40:aa16 with SMTP id 5b1f17b1804b1-43ba6708379mr94212945e9.16.1740925063992;
        Sun, 02 Mar 2025 06:17:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm161364165e9.26.2025.03.02.06.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 06:17:43 -0800 (PST)
Message-ID: <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
Date: Sun, 2 Mar 2025 14:17:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, David Mandelberg <david@mandelberg.org>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David

On 02/03/2025 07:45, David Mandelberg via GitGitGadget wrote:
> From: David Mandelberg <david@mandelberg.org>
> 
> Previously, some calls to for-each-ref passed fixed numbers of path
> components to strip from refs, assuming that remote names had no slashes
> in them. This made completions like:
> 
> git push github/dseomn :com<Tab>
> 
> Result in:
> 
> git push github/dseomn :dseomn/completion-remote-slash
> 
> With this patch, it instead results in:
> 
> git push github/dseomn :completion-remote-slash

This sounds like a useful improvement and I like the idea, but I think 
running "git for-each-ref" once for each remote is not going to scale 
very well for people who have a lot of remotes. I think it would be 
better to try and strip "refs/remote/$remote/" outside of "git 
for-each-ref". I've not tested it but I think something like

local sed_cmd=
local remote
# ref names and therefore remote names cannot contain '*?[]^' so we
# only need to escape '.$/'. Using 'sort -r' means that if there is a
# remote called "github" and another called "github/alice" we will try
# and strip "github/alice" first.
for remote in $(__git_remotes | sort -r)
do
	remote="${remote//./\\./}"
	remote="${remote//\$/\\\$/}"
	remote="${remote//\//\\\//}"
	sed_cmd="${sed_cmd} -e s/^refs\/remotes\/$remote\/// -e t"
done
__git for-each-ref --format="$fer_pfx$sfx" \
	${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
	"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" |
sed $sed_cmd | sort -u

should work and means we're only forking three extra processes no matter 
how many remotes the user has. I'm not sure if it changes the output 
order when GIT_COMPLETION_IGNORE_CASE is set though.

Best Wishes

Phillip

> In addition, the change to __git_dwim_remote_heads() restricts it to
> only list remote branches, not HEAD. I think that actually improves the
> completion where it's used though, since HEAD doesn't seem to be valid
> anyway:
> 
> $ git switch HEAD
> fatal: a branch is expected, got 'HEAD'
> 
> Signed-off-by: David Mandelberg <david@mandelberg.org>
> ---
>   contrib/completion/git-completion.bash |  17 ++-
>   t/t9902-completion.sh                  | 180 ++++++++++++++++++++++---
>   2 files changed, 169 insertions(+), 28 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 17c044f7d60..5f4407be37f 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -807,11 +807,15 @@ __git_dwim_remote_heads ()
>   	# employ the heuristic used by git checkout and git switch
>   	# Try to find a remote branch that cur_es the completion word
>   	# but only output if the branch name is unique
> -	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
> -		--sort="refname:strip=3" \
> -		${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
> -		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
> -	uniq -u
> +	local remote
> +	for remote in $(__git_remotes); do
> +		local base="$(__git_escape_fnmatch "refs/remotes/$remote")"
> +		local strip="$(__git_count_path_components "$base")"
> +		__git for-each-ref \
> +			--format="$fer_pfx%(refname:strip=$strip)$sfx" \
> +			${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
> +			"$base/$cur_*" "$base/$cur_*/**"
> +	done | sort | uniq -u
>   }
>   
>   # Lists refs from the local (by default) or from a remote repository.
> @@ -917,7 +921,8 @@ __git_refs ()
>   			case "HEAD" in
>   			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
>   			esac
> -			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
> +			local strip="$(__git_count_path_components "refs/remotes/$remote")"
> +			__git for-each-ref --format="$fer_pfx%(refname:strip=$strip)$sfx" \
>   				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>   				"refs/remotes/$remote/$match*" \
>   				"refs/remotes/$remote/$match*/**"
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 0219408358c..0c41ef9d5b1 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -149,7 +149,8 @@ fi
>   test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
>   	mkdir -p subdir/subsubdir &&
>   	mkdir -p non-repo &&
> -	git init -b main otherrepo
> +	git init -b main otherrepo &&
> +	git init -b main slashrepo
>   '
>   
>   test_expect_success '__git_find_repo_path - from command line (through $__git_dir)' '
> @@ -681,6 +682,13 @@ test_expect_success 'setup for ref completion' '
>   	) &&
>   	git remote add other "$ROOT/otherrepo/.git" &&
>   	git fetch --no-tags other &&
> +	(
> +		cd slashrepo &&
> +		git commit --allow-empty -m initial &&
> +		git branch -m main branch/with/slash
> +	) &&
> +	git remote add remote/with/slash "$ROOT/slashrepo/.git" &&
> +	git fetch --no-tags remote/with/slash &&
>   	rm -f .git/FETCH_HEAD &&
>   	git init thirdrepo
>   '
> @@ -693,6 +701,8 @@ test_expect_success '__git_refs - simple' '
>   	other/HEAD
>   	other/branch-in-other
>   	other/main-in-other
> +	remote/with/slash/HEAD
> +	remote/with/slash/branch/with/slash
>   	matching-tag
>   	EOF
>   	(
> @@ -709,6 +719,8 @@ test_expect_success '__git_refs - full refs' '
>   	refs/remotes/other/HEAD
>   	refs/remotes/other/branch-in-other
>   	refs/remotes/other/main-in-other
> +	refs/remotes/remote/with/slash/HEAD
> +	refs/remotes/remote/with/slash/branch/with/slash
>   	refs/tags/matching-tag
>   	EOF
>   	(
> @@ -774,6 +786,19 @@ test_expect_success '__git_refs - configured remote' '
>   	test_cmp expected "$actual"
>   '
>   
> +test_expect_success '__git_refs - configured remote - with slash' '
> +	cat >expected <<-EOF &&
> +	HEAD
> +	HEAD
> +	branch/with/slash
> +	EOF
> +	(
> +		cur= &&
> +		__git_refs remote/with/slash >"$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'
> +
>   test_expect_success '__git_refs - configured remote - full refs' '
>   	cat >expected <<-EOF &&
>   	HEAD
> @@ -916,17 +941,19 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
>   	other/ambiguous
>   	other/branch-in-other
>   	other/main-in-other
> -	remote/ambiguous
> -	remote/branch-in-remote
> +	remote/with/slash/HEAD
> +	remote/with/slash/ambiguous
> +	remote/with/slash/branch-in-remote
> +	remote/with/slash/branch/with/slash
>   	matching-tag
> -	HEAD
>   	branch-in-other
>   	branch-in-remote
> +	branch/with/slash
>   	main-in-other
>   	EOF
>   	for remote_ref in refs/remotes/other/ambiguous \
> -		refs/remotes/remote/ambiguous \
> -		refs/remotes/remote/branch-in-remote
> +		refs/remotes/remote/with/slash/ambiguous \
> +		refs/remotes/remote/with/slash/branch-in-remote
>   	do
>   		git update-ref $remote_ref main &&
>   		test_when_finished "git update-ref -d $remote_ref" || return 1
> @@ -946,6 +973,8 @@ test_expect_success '__git_refs - after --opt=' '
>   	other/HEAD
>   	other/branch-in-other
>   	other/main-in-other
> +	remote/with/slash/HEAD
> +	remote/with/slash/branch/with/slash
>   	matching-tag
>   	EOF
>   	(
> @@ -962,6 +991,8 @@ test_expect_success '__git_refs - after --opt= - full refs' '
>   	refs/remotes/other/HEAD
>   	refs/remotes/other/branch-in-other
>   	refs/remotes/other/main-in-other
> +	refs/remotes/remote/with/slash/HEAD
> +	refs/remotes/remote/with/slash/branch/with/slash
>   	refs/tags/matching-tag
>   	EOF
>   	(
> @@ -979,6 +1010,8 @@ test_expect_success '__git refs - excluding refs' '
>   	^other/HEAD
>   	^other/branch-in-other
>   	^other/main-in-other
> +	^remote/with/slash/HEAD
> +	^remote/with/slash/branch/with/slash
>   	^matching-tag
>   	EOF
>   	(
> @@ -995,6 +1028,8 @@ test_expect_success '__git refs - excluding full refs' '
>   	^refs/remotes/other/HEAD
>   	^refs/remotes/other/branch-in-other
>   	^refs/remotes/other/main-in-other
> +	^refs/remotes/remote/with/slash/HEAD
> +	^refs/remotes/remote/with/slash/branch/with/slash
>   	^refs/tags/matching-tag
>   	EOF
>   	(
> @@ -1022,6 +1057,8 @@ test_expect_success '__git_refs - do not filter refs unless told so' '
>   	other/branch-in-other
>   	other/main-in-other
>   	other/matching/branch-in-other
> +	remote/with/slash/HEAD
> +	remote/with/slash/branch/with/slash
>   	matching-tag
>   	matching/tag
>   	EOF
> @@ -1142,6 +1179,8 @@ test_expect_success '__git_complete_refs - simple' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	matching-tag Z
>   	EOF
>   	(
> @@ -1180,6 +1219,20 @@ test_expect_success '__git_complete_refs - remote' '
>   	test_cmp expected out
>   '
>   
> +test_expect_success '__git_complete_refs - remote - with slash' '
> +	sed -e "s/Z$//" >expected <<-EOF &&
> +	HEAD Z
> +	HEAD Z
> +	branch/with/slash Z
> +	EOF
> +	(
> +		cur= &&
> +		__git_complete_refs --remote=remote/with/slash &&
> +		print_comp
> +	) &&
> +	test_cmp expected out
> +'
> +
>   test_expect_success '__git_complete_refs - track' '
>   	sed -e "s/Z$//" >expected <<-EOF &&
>   	HEAD Z
> @@ -1188,9 +1241,11 @@ test_expect_success '__git_complete_refs - track' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	matching-tag Z
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main-in-other Z
>   	EOF
>   	(
> @@ -1235,6 +1290,8 @@ test_expect_success '__git_complete_refs - suffix' '
>   	other/HEAD.
>   	other/branch-in-other.
>   	other/main-in-other.
> +	remote/with/slash/HEAD.
> +	remote/with/slash/branch/with/slash.
>   	matching-tag.
>   	EOF
>   	(
> @@ -1260,6 +1317,20 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
>   	test_cmp expected out
>   '
>   
> +test_expect_success '__git_complete_fetch_refspecs - with slash' '
> +	sed -e "s/Z$//" >expected <<-EOF &&
> +	HEAD:HEAD Z
> +	HEAD:HEAD Z
> +	branch/with/slash:branch/with/slash Z
> +	EOF
> +	(
> +		cur= &&
> +		__git_complete_fetch_refspecs remote/with/slash &&
> +		print_comp
> +	) &&
> +	test_cmp expected out
> +'
> +
>   test_expect_success '__git_complete_fetch_refspecs - matching' '
>   	sed -e "s/Z$//" >expected <<-EOF &&
>   	branch-in-other:branch-in-other Z
> @@ -1340,8 +1411,8 @@ test_expect_success '__git_complete_worktree_paths with -C' '
>   
>   test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
>   	test_completion "git switch " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -1487,8 +1558,8 @@ test_expect_success 'git-bisect - existing view subcommand is recognized and ena
>   test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
>   	test_completion "git checkout " <<-\EOF
>   	HEAD Z
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -1496,6 +1567,8 @@ test_expect_success 'git checkout - completes refs and unique remote branches fo
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1515,8 +1588,8 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
>   
>   test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
>   	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -1525,8 +1598,8 @@ test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
>   
>   test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
>   	test_completion "git switch --no-guess --guess " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -1549,14 +1622,16 @@ test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only complete
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
>   test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
>   	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
>   	HEAD Z
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -1564,6 +1639,8 @@ test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1,
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1576,14 +1653,16 @@ test_expect_success 'git checkout - with --no-guess, only completes refs' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
>   test_expect_success 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
>   	test_completion "git checkout --no-guess --guess " <<-\EOF
>   	HEAD Z
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -1591,6 +1670,8 @@ test_expect_success 'git checkout - a later --guess overrides previous --no-gues
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1603,6 +1684,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1616,6 +1699,8 @@ test_expect_success 'git checkout - with checkout.guess = false, only completes
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1623,8 +1708,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
>   	test_config checkout.guess true &&
>   	test_completion "git checkout " <<-\EOF
>   	HEAD Z
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -1632,6 +1717,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1639,8 +1726,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
>   	test_config checkout.guess false &&
>   	test_completion "git checkout --guess " <<-\EOF
>   	HEAD Z
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -1648,6 +1735,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1661,6 +1750,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous checko
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1673,6 +1764,8 @@ test_expect_success 'git switch - with --detach, complete all references' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1685,6 +1778,8 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1857,6 +1952,8 @@ test_expect_success 'git switch - with -d, complete all references' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1869,6 +1966,8 @@ test_expect_success 'git checkout - with -d, complete only references' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1877,11 +1976,15 @@ test_expect_success 'git switch - with --track, complete only remote branches' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   	test_completion "git switch -t " <<-\EOF
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1890,11 +1993,15 @@ test_expect_success 'git checkout - with --track, complete only remote branches'
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   	test_completion "git checkout -t " <<-\EOF
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1914,6 +2021,8 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1926,6 +2035,8 @@ test_expect_success 'git switch - with -c, complete all references' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1938,6 +2049,8 @@ test_expect_success 'git switch - with -C, complete all references' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1950,6 +2063,8 @@ test_expect_success 'git switch - with -c and --track, complete all references'
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1962,6 +2077,8 @@ test_expect_success 'git switch - with -C and --track, complete all references'
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1974,6 +2091,8 @@ test_expect_success 'git switch - with -c and --no-track, complete all reference
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1986,6 +2105,8 @@ test_expect_success 'git switch - with -C and --no-track, complete all reference
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -1998,6 +2119,8 @@ test_expect_success 'git checkout - with -b, complete all references' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -2010,6 +2133,8 @@ test_expect_success 'git checkout - with -B, complete all references' '
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -2022,6 +2147,8 @@ test_expect_success 'git checkout - with -b and --track, complete all references
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -2034,6 +2161,8 @@ test_expect_success 'git checkout - with -B and --track, complete all references
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -2046,6 +2175,8 @@ test_expect_success 'git checkout - with -b and --no-track, complete all referen
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -2058,13 +2189,15 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
>   test_expect_success 'git switch - for -c, complete local branches and unique remote branches' '
>   	test_completion "git switch -c " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -2073,8 +2206,8 @@ test_expect_success 'git switch - for -c, complete local branches and unique rem
>   
>   test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
>   	test_completion "git switch -C " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -2111,8 +2244,8 @@ test_expect_success 'git switch - for -C with --no-track, complete local branche
>   
>   test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
>   	test_completion "git checkout -b " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -2121,8 +2254,8 @@ test_expect_success 'git checkout - for -b, complete local branches and unique r
>   
>   test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
>   	test_completion "git checkout -B " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -2159,8 +2292,8 @@ test_expect_success 'git checkout - for -B with --no-track, complete local branc
>   
>   test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
>   	test_completion "git switch --orphan " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -2175,8 +2308,8 @@ test_expect_success 'git switch - --orphan with branch already provided complete
>   
>   test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
>   	test_completion "git checkout --orphan " <<-\EOF
> -	HEAD Z
>   	branch-in-other Z
> +	branch/with/slash Z
>   	main Z
>   	main-in-other Z
>   	matching-branch Z
> @@ -2192,6 +2325,8 @@ test_expect_success 'git checkout - --orphan with branch already provided comple
>   	other/HEAD Z
>   	other/branch-in-other Z
>   	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>   	EOF
>   '
>   
> @@ -2206,7 +2341,8 @@ test_expect_success 'git restore completes modified files' '
>   test_expect_success 'teardown after ref completion' '
>   	git branch -d matching-branch &&
>   	git tag -d matching-tag &&
> -	git remote remove other
> +	git remote remove other &&
> +	git remote remove remote/with/slash
>   '
>   
>   

