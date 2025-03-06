Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5CF233715
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278934; cv=none; b=b6IWUrcgLnMKByj5IHtS+pwpg31BIGxYZS41Pz2bsxT2HPGDfsM0oxoQUxxm11UFfslBg13rKd2aLK5LjKmHHu+MP7IOAmRf2wRLZMKL7jYfxccR6Se3+Ulmlu3cUDrs7bHSiu6hEVe/3i6kn+vSdSY4j1P9O78/Q+JXj5AQc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278934; c=relaxed/simple;
	bh=O5+qCjLU/wnCYR2QgS5+rxHy4FvE6lH7r7BitRZgvOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMLI0nLPx2UfI7P6C3TX0WIx4iiQInH5D6j+QAKEMHHYgJ8QaNTQ8KAEOMOsHTFzFdc9aDgturvLUiThT4UxG36uwxM2exeNtYQClJJIBN3Uera+8Bj4he+nNVdJdQpK0LvHlPkiDPJQOZ/piuKLwCjwoSXMjboguNlLf+eD80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TliSBcP7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TliSBcP7"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso135775666b.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741278930; x=1741883730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AXSSlabxeEDboK77ltHrJmFTRROlDIjI9K9GlGsP1q0=;
        b=TliSBcP7tGrsxge9LdTNMZq6gu6hVKbz0VSp7qIJRLtwu2gOy5/NWiCBkrXtsv5E63
         Rs7u/ve3gcEnUegTHJf+8YkyDoOsqNsAsmd0c0/1Pbe5cjoA1Sao9OX8dcBVEX1+1MNJ
         3kUQ5SO0ty6kGJVs8Oaf/Ks2NNGzjinuA23xoDWjm1UjO8QnzZ/Az6nY6o2QaLACvk4/
         88Ge5SXQ1JlaKsnK/4Zw9rey4V/K3advFDrDInlSq4SmZUbLygb4uH942TMwzXyzOgPB
         cQnU3yHO0p8sZezorF8vV81neUliNJGq/DoKEVwMQrILhGbNfUOKKCZMLZHQJkoqN2Ll
         vvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741278930; x=1741883730;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXSSlabxeEDboK77ltHrJmFTRROlDIjI9K9GlGsP1q0=;
        b=gy3/tsJ3+Bs+MM2/1cwwi0iM5r16vDAyWQjQANt2V1gHc+vUTX7bviZmWafNocsZzA
         ZUomEKUk5povxdv8p/VJjKzhpq4bt+ucyr5IR8vuQZUu2gfO5w92XVu2ujuiXtYM4Ueu
         s/MVd7so0UsnB7K+iaox3mfhzHsEEOJZ/h5rz+EQWld/0HQNo8D+q3zyqQuDJrktQFNU
         AOFrElGN2iYU19poX/Rf8xzuw9462/nKemdK8go5G1EBOhlmxEwQfgn+RfZyMF0suz/Y
         7jP70c3r6BK1/YJUCerbFNhsbULBVq3LVvpgRLZp5lS/5mvknLuczzW+b6tDdbwGAt5d
         J8NA==
X-Gm-Message-State: AOJu0Yz42SAiMBjyJnoNO2pndhvTm5h35bjB8m6ePjj5hyCPR7GCmCiZ
	iAiUSeweNHLF2hfQORO53oEA3s2w9GzdHNKdPrWuti2RdQwIH6tB
X-Gm-Gg: ASbGnctfif+PRLwZojNSFx7DxCN86Rfxi44Sh93pjTqxSqh9hMGlK0Az+6eqf3RPBp0
	KDgaewBlSDaUMP4xo4KqaQdoKhT2RU1+ucj64quqi+3/Ze5Sj09UtiycE+tLHXL/2K5qRV/mIUk
	Fr2VZz2yH7sMFLoTUShxbTxSklgeMJ6xkQ5U/HV9gxEm4yE9eh5XBCUCrgb8RvOXZqi+KJpof7l
	a+Dfj6qBl+LljHqQu3vS7nH8eGfaldj6zZUw7fWS/Bj5+FJhJTRg9VvUI0ITCeU/NSn91ukeV3a
	5RFWgIhYts3E/zGAeaiinzdlGkA2jrK+4OA5+LoQNvgM9NH7c1QdjzYM5VO9xCF53MmqcS+IMRQ
	o4sPIUfY6luYDxQgk8hzeHpw=
X-Google-Smtp-Source: AGHT+IG0C9LaVWz37hv/Elob9PsD+qZcq1615c4r5gaipaIVeJphuBYoaW0BhR9/nyAr9FTXnBllww==
X-Received: by 2002:a17:907:7d93:b0:ac1:effd:f2ea with SMTP id a640c23a62f3a-ac20da43f47mr884503266b.24.1741278929973;
        Thu, 06 Mar 2025 08:35:29 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943c476sm119105066b.3.2025.03.06.08.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 08:35:29 -0800 (PST)
Message-ID: <2bed28ca-b106-474d-9bac-db377bc51949@gmail.com>
Date: Thu, 6 Mar 2025 16:35:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] completion: fix bugs with slashes in remote names
To: David Mandelberg <david@mandelberg.org>,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <d5860dbe1e6a149d72739af3271369b3@mandelberg.org>
 <187a63ad2f4a66b644187a8201eadfed@mandelberg.org>
 <fa70c8336f836ebb5b9c196fe291d357@mandelberg.org>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <fa70c8336f836ebb5b9c196fe291d357@mandelberg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David

On 05/03/2025 20:50, David Mandelberg wrote:
> David Mandelberg schreef op 2025-03-04 19:09:
>> Previously, some calls to for-each-ref passed fixed numbers of path
>> components to strip from refs, assuming that remote names had no slashes
>> in them. This made completions like:
>>
>> git push github/dseomn :com<Tab>
>>
>> Result in:
>>
>> git push github/dseomn :dseomn/completion-remote-slash
>>
>> With this patch, it instead results in:
>>
>> git push github/dseomn :completion-remote-slash
>>
>> Signed-off-by: David Mandelberg <david@mandelberg.org>
>> ---
>>   contrib/completion/git-completion.bash |  38 +++++-
>>   t/t9902-completion.sh                  | 180 ++++++++++++++++++++++---
>>   2 files changed, 189 insertions(+), 29 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 5fdc71208e..450fabc901 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -790,16 +790,39 @@ __git_tags ()
>>   __git_dwim_remote_heads ()
>>   {
>>   	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
>> -	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
>>   
>>   	# employ the heuristic used by git checkout and git switch
>>   	# Try to find a remote branch that cur_es the completion word
>>   	# but only output if the branch name is unique
>> -	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
>> -		--sort="refname:strip=3" \
>> -		${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>> -		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
>> -	uniq -u
>> +	local awk_script='
>> +	function casemap(s) {
>> +		if (ENVIRON["IGNORE_CASE"])
>> +			return tolower(s)
>> +		else
>> +			return s
>> +	}
>> +	BEGIN {
>> +		split(ENVIRON["REMOTES"], remotes, /\n/)
>> +		for (i in remotes)
>> +			remotes[i] = "refs/remotes/" casemap(remotes[i])
>> +		cur_ = casemap(ENVIRON["CUR_"])
>> +	}
>> +	{
>> +		ref_case = casemap($0)
>> +		for (i in remotes) {
>> +			if (index(ref_case, remotes[i] "/" cur_) == 1) {
>> +				branch = substr($0, length(remotes[i] "/") + 1)
>> +				print ENVIRON["PFX"] branch ENVIRON["SFX"]
>> +				break
>> +			}
>> +		}
>> +	}
>> +	'
>> +	__git for-each-ref --format='%(refname)' |
>> +		PFX="$pfx" SFX="$sfx" CUR_="$cur_" \
>> +			IGNORE_CASE=${GIT_COMPLETION_IGNORE_CASE+1} \
>> +			REMOTES="$(__git_remotes | sort -r)" awk "$awk_script" |
>> +		sort | uniq -u

I wonder if we can use "sort -u" here and drop uniq. It isn't quite the 
same as it will remove entries that are equal according to the current 
locale but I don't think that should matter.

> I realized that this sends refs to awk that it doesn't need to. I'll
> apply this diff to the next version of this patch:

With that tweak this looks good. If there are no glob characters then 
"git for-each-ref" does a prefix match so strictly speaking you don't 
need the '**' but I don't think it matters in practice. I had one 
thought below but if you don't feel like spending more that on this I 
think what you have here is fine.

The filtering is O(number of remote refs * number of remotes). If we 
could sort the list of remotes and remote refs in the same order then we 
can reduce this to O(number of remote refs + number of remotes) by doing 
(in pseudo code)

     for ($ref in $remote_refs) {
	while (!starts_with($ref, "refs/remotes/$remote[$i]"))
		$i++;
	if (starts_with($ref, "refs/remotes/$remote[$i]/$cur_)
		print $ref;
     }

I think we can get "git for-each-ref --sort=-refname" and "sort -r" to 
agree on a sorting order by setting LC_COLLATE=C, otherwise "sort" will 
sort according the the current locale whereas git sorts by bytes.

Best Wishes

Phillip

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 450fabc901..c9d014070c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -818,7 +818,7 @@ __git_dwim_remote_heads ()
>                  }
>          }
>          '
> -       __git for-each-ref --format='%(refname)' |
> +       __git for-each-ref --format='%(refname)' 'refs/remotes/**' |
>                  PFX="$pfx" SFX="$sfx" CUR_="$cur_" \
>                          IGNORE_CASE=${GIT_COMPLETION_IGNORE_CASE+1} \
>                          REMOTES="$(__git_remotes | sort -r)" awk "$awk_script" |
> 
>>   }
>>   
>>   # Lists refs from the local (by default) or from a remote repository.
>> @@ -905,7 +928,8 @@ __git_refs ()
>>   			case "HEAD" in
>>   			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
>>   			esac
>> -			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
>> +			local strip="$(__git_count_path_components "refs/remotes/$remote")"
>> +			__git for-each-ref --format="$fer_pfx%(refname:strip=$strip)$sfx" \
>>   				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>>   				"refs/remotes/$remote/$match*" \
>>   				"refs/remotes/$remote/$match*/**"
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 015289c776..343b8cd191 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -149,7 +149,8 @@ fi
>>   test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
>>   	mkdir -p subdir/subsubdir &&
>>   	mkdir -p non-repo &&
>> -	git init -b main otherrepo
>> +	git init -b main otherrepo &&
>> +	git init -b main slashrepo
>>   '
>>   
>>   test_expect_success '__git_find_repo_path - from command line (through $__git_dir)' '
>> @@ -674,6 +675,13 @@ test_expect_success 'setup for ref completion' '
>>   	) &&
>>   	git remote add other "$ROOT/otherrepo/.git" &&
>>   	git fetch --no-tags other &&
>> +	(
>> +		cd slashrepo &&
>> +		git commit --allow-empty -m initial &&
>> +		git branch -m main branch/with/slash
>> +	) &&
>> +	git remote add remote/with/slash "$ROOT/slashrepo/.git" &&
>> +	git fetch --no-tags remote/with/slash &&
>>   	rm -f .git/FETCH_HEAD &&
>>   	git init thirdrepo
>>   '
>> @@ -686,6 +694,8 @@ test_expect_success '__git_refs - simple' '
>>   	other/HEAD
>>   	other/branch-in-other
>>   	other/main-in-other
>> +	remote/with/slash/HEAD
>> +	remote/with/slash/branch/with/slash
>>   	matching-tag
>>   	EOF
>>   	(
>> @@ -702,6 +712,8 @@ test_expect_success '__git_refs - full refs' '
>>   	refs/remotes/other/HEAD
>>   	refs/remotes/other/branch-in-other
>>   	refs/remotes/other/main-in-other
>> +	refs/remotes/remote/with/slash/HEAD
>> +	refs/remotes/remote/with/slash/branch/with/slash
>>   	refs/tags/matching-tag
>>   	EOF
>>   	(
>> @@ -767,6 +779,19 @@ test_expect_success '__git_refs - configured remote' '
>>   	test_cmp expected "$actual"
>>   '
>>   
>> +test_expect_success '__git_refs - configured remote - with slash' '
>> +	cat >expected <<-EOF &&
>> +	HEAD
>> +	HEAD
>> +	branch/with/slash
>> +	EOF
>> +	(
>> +		cur= &&
>> +		__git_refs remote/with/slash >"$actual"
>> +	) &&
>> +	test_cmp expected "$actual"
>> +'
>> +
>>   test_expect_success '__git_refs - configured remote - full refs' '
>>   	cat >expected <<-EOF &&
>>   	HEAD
>> @@ -909,17 +934,19 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
>>   	other/ambiguous
>>   	other/branch-in-other
>>   	other/main-in-other
>> -	remote/ambiguous
>> -	remote/branch-in-remote
>> +	remote/with/slash/HEAD
>> +	remote/with/slash/ambiguous
>> +	remote/with/slash/branch-in-remote
>> +	remote/with/slash/branch/with/slash
>>   	matching-tag
>> -	HEAD
>>   	branch-in-other
>>   	branch-in-remote
>> +	branch/with/slash
>>   	main-in-other
>>   	EOF
>>   	for remote_ref in refs/remotes/other/ambiguous \
>> -		refs/remotes/remote/ambiguous \
>> -		refs/remotes/remote/branch-in-remote
>> +		refs/remotes/remote/with/slash/ambiguous \
>> +		refs/remotes/remote/with/slash/branch-in-remote
>>   	do
>>   		git update-ref $remote_ref main &&
>>   		test_when_finished "git update-ref -d $remote_ref" || return 1
>> @@ -939,6 +966,8 @@ test_expect_success '__git_refs - after --opt=' '
>>   	other/HEAD
>>   	other/branch-in-other
>>   	other/main-in-other
>> +	remote/with/slash/HEAD
>> +	remote/with/slash/branch/with/slash
>>   	matching-tag
>>   	EOF
>>   	(
>> @@ -955,6 +984,8 @@ test_expect_success '__git_refs - after --opt= - full refs' '
>>   	refs/remotes/other/HEAD
>>   	refs/remotes/other/branch-in-other
>>   	refs/remotes/other/main-in-other
>> +	refs/remotes/remote/with/slash/HEAD
>> +	refs/remotes/remote/with/slash/branch/with/slash
>>   	refs/tags/matching-tag
>>   	EOF
>>   	(
>> @@ -972,6 +1003,8 @@ test_expect_success '__git refs - excluding refs' '
>>   	^other/HEAD
>>   	^other/branch-in-other
>>   	^other/main-in-other
>> +	^remote/with/slash/HEAD
>> +	^remote/with/slash/branch/with/slash
>>   	^matching-tag
>>   	EOF
>>   	(
>> @@ -988,6 +1021,8 @@ test_expect_success '__git refs - excluding full refs' '
>>   	^refs/remotes/other/HEAD
>>   	^refs/remotes/other/branch-in-other
>>   	^refs/remotes/other/main-in-other
>> +	^refs/remotes/remote/with/slash/HEAD
>> +	^refs/remotes/remote/with/slash/branch/with/slash
>>   	^refs/tags/matching-tag
>>   	EOF
>>   	(
>> @@ -1015,6 +1050,8 @@ test_expect_success '__git_refs - do not filter refs unless told so' '
>>   	other/branch-in-other
>>   	other/main-in-other
>>   	other/matching/branch-in-other
>> +	remote/with/slash/HEAD
>> +	remote/with/slash/branch/with/slash
>>   	matching-tag
>>   	matching/tag
>>   	EOF
>> @@ -1135,6 +1172,8 @@ test_expect_success '__git_complete_refs - simple' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	matching-tag Z
>>   	EOF
>>   	(
>> @@ -1173,6 +1212,20 @@ test_expect_success '__git_complete_refs - remote' '
>>   	test_cmp expected out
>>   '
>>   
>> +test_expect_success '__git_complete_refs - remote - with slash' '
>> +	sed -e "s/Z$//" >expected <<-EOF &&
>> +	HEAD Z
>> +	HEAD Z
>> +	branch/with/slash Z
>> +	EOF
>> +	(
>> +		cur= &&
>> +		__git_complete_refs --remote=remote/with/slash &&
>> +		print_comp
>> +	) &&
>> +	test_cmp expected out
>> +'
>> +
>>   test_expect_success '__git_complete_refs - track' '
>>   	sed -e "s/Z$//" >expected <<-EOF &&
>>   	HEAD Z
>> @@ -1181,9 +1234,11 @@ test_expect_success '__git_complete_refs - track' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	matching-tag Z
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main-in-other Z
>>   	EOF
>>   	(
>> @@ -1228,6 +1283,8 @@ test_expect_success '__git_complete_refs - suffix' '
>>   	other/HEAD.
>>   	other/branch-in-other.
>>   	other/main-in-other.
>> +	remote/with/slash/HEAD.
>> +	remote/with/slash/branch/with/slash.
>>   	matching-tag.
>>   	EOF
>>   	(
>> @@ -1253,6 +1310,20 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
>>   	test_cmp expected out
>>   '
>>   
>> +test_expect_success '__git_complete_fetch_refspecs - with slash' '
>> +	sed -e "s/Z$//" >expected <<-EOF &&
>> +	HEAD:HEAD Z
>> +	HEAD:HEAD Z
>> +	branch/with/slash:branch/with/slash Z
>> +	EOF
>> +	(
>> +		cur= &&
>> +		__git_complete_fetch_refspecs remote/with/slash &&
>> +		print_comp
>> +	) &&
>> +	test_cmp expected out
>> +'
>> +
>>   test_expect_success '__git_complete_fetch_refspecs - matching' '
>>   	sed -e "s/Z$//" >expected <<-EOF &&
>>   	branch-in-other:branch-in-other Z
>> @@ -1333,8 +1404,8 @@ test_expect_success '__git_complete_worktree_paths with -C' '
>>   
>>   test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
>>   	test_completion "git switch " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -1480,8 +1551,8 @@ test_expect_success 'git-bisect - existing view subcommand is recognized and ena
>>   test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
>>   	test_completion "git checkout " <<-\EOF
>>   	HEAD Z
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -1489,6 +1560,8 @@ test_expect_success 'git checkout - completes refs and unique remote branches fo
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1508,8 +1581,8 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
>>   
>>   test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
>>   	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -1518,8 +1591,8 @@ test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
>>   
>>   test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
>>   	test_completion "git switch --no-guess --guess " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -1542,14 +1615,16 @@ test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only complete
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>>   test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
>>   	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
>>   	HEAD Z
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -1557,6 +1632,8 @@ test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1,
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1569,14 +1646,16 @@ test_expect_success 'git checkout - with --no-guess, only completes refs' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>>   test_expect_success 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
>>   	test_completion "git checkout --no-guess --guess " <<-\EOF
>>   	HEAD Z
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -1584,6 +1663,8 @@ test_expect_success 'git checkout - a later --guess overrides previous --no-gues
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1596,6 +1677,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1609,6 +1692,8 @@ test_expect_success 'git checkout - with checkout.guess = false, only completes
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1616,8 +1701,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
>>   	test_config checkout.guess true &&
>>   	test_completion "git checkout " <<-\EOF
>>   	HEAD Z
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -1625,6 +1710,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1632,8 +1719,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
>>   	test_config checkout.guess false &&
>>   	test_completion "git checkout --guess " <<-\EOF
>>   	HEAD Z
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -1641,6 +1728,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1654,6 +1743,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous checko
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1666,6 +1757,8 @@ test_expect_success 'git switch - with --detach, complete all references' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1678,6 +1771,8 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1850,6 +1945,8 @@ test_expect_success 'git switch - with -d, complete all references' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1862,6 +1959,8 @@ test_expect_success 'git checkout - with -d, complete only references' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1870,11 +1969,15 @@ test_expect_success 'git switch - with --track, complete only remote branches' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   	test_completion "git switch -t " <<-\EOF
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1883,11 +1986,15 @@ test_expect_success 'git checkout - with --track, complete only remote branches'
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   	test_completion "git checkout -t " <<-\EOF
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1907,6 +2014,8 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1919,6 +2028,8 @@ test_expect_success 'git switch - with -c, complete all references' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1931,6 +2042,8 @@ test_expect_success 'git switch - with -C, complete all references' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1943,6 +2056,8 @@ test_expect_success 'git switch - with -c and --track, complete all references'
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1955,6 +2070,8 @@ test_expect_success 'git switch - with -C and --track, complete all references'
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1967,6 +2084,8 @@ test_expect_success 'git switch - with -c and --no-track, complete all reference
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1979,6 +2098,8 @@ test_expect_success 'git switch - with -C and --no-track, complete all reference
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -1991,6 +2112,8 @@ test_expect_success 'git checkout - with -b, complete all references' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -2003,6 +2126,8 @@ test_expect_success 'git checkout - with -B, complete all references' '
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -2015,6 +2140,8 @@ test_expect_success 'git checkout - with -b and --track, complete all references
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -2027,6 +2154,8 @@ test_expect_success 'git checkout - with -B and --track, complete all references
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -2039,6 +2168,8 @@ test_expect_success 'git checkout - with -b and --no-track, complete all referen
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -2051,13 +2182,15 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>>   test_expect_success 'git switch - for -c, complete local branches and unique remote branches' '
>>   	test_completion "git switch -c " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -2066,8 +2199,8 @@ test_expect_success 'git switch - for -c, complete local branches and unique rem
>>   
>>   test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
>>   	test_completion "git switch -C " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -2104,8 +2237,8 @@ test_expect_success 'git switch - for -C with --no-track, complete local branche
>>   
>>   test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
>>   	test_completion "git checkout -b " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -2114,8 +2247,8 @@ test_expect_success 'git checkout - for -b, complete local branches and unique r
>>   
>>   test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
>>   	test_completion "git checkout -B " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -2152,8 +2285,8 @@ test_expect_success 'git checkout - for -B with --no-track, complete local branc
>>   
>>   test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
>>   	test_completion "git switch --orphan " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -2168,8 +2301,8 @@ test_expect_success 'git switch - --orphan with branch already provided complete
>>   
>>   test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
>>   	test_completion "git checkout --orphan " <<-\EOF
>> -	HEAD Z
>>   	branch-in-other Z
>> +	branch/with/slash Z
>>   	main Z
>>   	main-in-other Z
>>   	matching-branch Z
>> @@ -2185,6 +2318,8 @@ test_expect_success 'git checkout - --orphan with branch already provided comple
>>   	other/HEAD Z
>>   	other/branch-in-other Z
>>   	other/main-in-other Z
>> +	remote/with/slash/HEAD Z
>> +	remote/with/slash/branch/with/slash Z
>>   	EOF
>>   '
>>   
>> @@ -2199,7 +2334,8 @@ test_expect_success 'git restore completes modified files' '
>>   test_expect_success 'teardown after ref completion' '
>>   	git branch -d matching-branch &&
>>   	git tag -d matching-tag &&
>> -	git remote remove other
>> +	git remote remove other &&
>> +	git remote remove remote/with/slash
>>   '
> 

