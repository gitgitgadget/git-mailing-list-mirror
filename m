Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748318DF73
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 20:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207824; cv=none; b=DZ/KJiZv9+IGQdRX9Rdt3OEvc6qgbCKCNfT2q1V02Mz7VlMzNtii2durGWLd0qDjB2qpEDEY8p+C8jQd47g6mkt6avoXRlIxiCNI2kFNAW7EC8CUs1HTXGg1sj4yTvfS9Q/zEmh0w5gcWRt/ppAzQB+k0aSqwT6pyyyKARJw2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207824; c=relaxed/simple;
	bh=y9KkIgxAJFYz6ENLgOFWLOEDdV563DSccOtItqnaYhw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=LLdgGqDqr3Pn41LBAtC4wmf+pyXZF0ufKoKiSN4HoywT0yVcm4KtEC0aJxwO9yjQ1sc4rqttlA3ojOKb3QymGf8e8GvnF8oj6xmZJt6rR/T8xsur57qJSBefOLQYKFeF25YWgsN2Nuh9/F7t8APo9HkIkD+ABqMDhoAgToOHPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=UbGONR8D; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=SeTGxF5c; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="UbGONR8D";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="SeTGxF5c"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6e8e6dee861so12567186d6.1
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 12:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741207821; x=1741812621;
        h=content-transfer-encoding:message-id:references:in-reply-to:subject
         :cc:to:from:date:mime-version:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d25+PWfeKD/lXHKTLB5cHuLfWJBy5CS9gGRGhfKAhnU=;
        b=ahIftyuWzQo61Qn4waiEOKC5sLjf40G/7XeGZYyTs24nm0v7k5XWCuSqh87N+qu8Pa
         FIIxAXywAj02q/QGXYIFPu9CCdS/O0yYH7g6+T9q7f/HSfD22+GHcL/NC/Qb16DI92iS
         DPxq1efant6tHUm17uOZ8bO10rREebQ58NqDf4etcxQcJEyIRQPYlNaeSZal0cULG+Sg
         3JRiaZ1Oj6DC87mTvByiB3h8HdZzPIAUDcjVobFinMvFQ3xUF1jgmqvKt4HqLQLkHFYl
         E2dvCkKYCbkTZE7Y1KIt33c6J60kB+rxJwY3Vfj6cvjI57573gYNUx9fhKiUk9+f+vPt
         N8jQ==
X-Gm-Message-State: AOJu0YyEKOOZ3r03QWLZu/NWxs/nDyS265ZUdJ6bVq46x/AVsLDWPqCr
	N0ABkm6d1k1zrihxLq6kR+puac7bADodIYelVFEJF1XE/kptHNWeuBoE8SuFtiqdYfTb3ze0Idx
	UItnEwznZlD0gl2LYKG42SaomgiY75maO
X-Gm-Gg: ASbGncsSmUYh61Pt7ztIAipRxn1LvVG7dh99FvJcabYPND/6ON6NxyL48XVTdO4/aM5
	FYjuLY0cifTzxdEcPYd8NaR5VVo/AiqvWV6u9FjMMd2RJszX4FlUQHYaq65HPBLR3kOTuG4ZNI+
	B3JvyIbWhYtIw8+g4DEZy15VZtUwU+FY4XCU3wKnivw8z47vKlXG9sR6n+UYcuIa6Tciv6p3R4P
	dln154XCozxptWmYDFJi1REHDYQnpYIpfKBMtivmhWu1I24R6NcZx02NSV54JYMtES/ZBKQjpZI
	Xvs1UiNULQ0omltzMlXLOV3Lk9mbSYlRIeaCbXR6JfagTy7q7G07olcQcWky/TOKMdAb00C/Riw
	H23/pW2KZ1XthKIwUSnnTPgfEOfdUSQ==
X-Google-Smtp-Source: AGHT+IFKXGvo3uN73MLOUw4uMinwnW5Lk21y/5GLUw3HAWqnSFDg9mZxWKdmGGW/3gsXMdAq+oWi0y9AyL0s
X-Received: by 2002:a05:6214:300e:b0:6e4:5317:64a0 with SMTP id 6a1803df08f44-6e8f46fa6dfmr9336776d6.13.1741207821011;
        Wed, 05 Mar 2025 12:50:21 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e8ee955ba1sm540486d6.53.2025.03.05.12.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:50:21 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741207820; h=mime-version : date
 : from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding : from;
 bh=y9KkIgxAJFYz6ENLgOFWLOEDdV563DSccOtItqnaYhw=;
 b=UbGONR8D+o8FWu1XB5zpu85WKvSUemLXAFhnoLx4AplmLEbfaHcFzWK8jXxGLspN1Rfj+
 9Heu98vxmzcdcTTDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741207820; h=mime-version : date : from : to : cc : subject :
 in-reply-to : references : message-id : content-type :
 content-transfer-encoding : from;
 bh=y9KkIgxAJFYz6ENLgOFWLOEDdV563DSccOtItqnaYhw=;
 b=SeTGxF5cMO6OEggnBF+Rz0TPl6Lva9fg7sO+LSp+5Y9Evy2/uNt2nNtvhz4zrwrLdPK+K
 IHmWz0CAnc5+b6bj5V7M4fFuB9LDuntSaGvI3eJkC3N/Bmd84wTGf8uPFN/MMIxi951i9YJ
 CYfT2GoVnaJA9TgTRa8yLfza9odRNP4CR27iGbWbJa8Y0o5XGH4HHo9yrDJQnX73qobeKZl
 s7kFEQe2TMtKOgl/nE4v/aoovQMcws25pFleN5NnJwkPK0VxSspha+h6fiVnRzXG4ZDgetx
 BGYuyaYfGyoBDHDaKGqf7ENS1Q8/gMLxIj+2UE0QzbDZjXo4W3rP6CbcXrmQ==
Received: from webmail.mandelberg.org (mail-web-d031b246.virgo.mandelberg.org [10.0.6.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X448 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z7Pnm2cdFzySw;
	Wed,  5 Mar 2025 20:50:20 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Mar 2025 15:50:20 -0500
From: David Mandelberg <david@mandelberg.org>
To: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>, Junio C
 Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] completion: fix bugs with slashes in remote names
In-Reply-To: <187a63ad2f4a66b644187a8201eadfed@mandelberg.org>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <d5860dbe1e6a149d72739af3271369b3@mandelberg.org>
 <187a63ad2f4a66b644187a8201eadfed@mandelberg.org>
Message-ID: <fa70c8336f836ebb5b9c196fe291d357@mandelberg.org>
X-Sender: david@mandelberg.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

David Mandelberg schreef op 2025-03-04 19:09:
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
> 
> Signed-off-by: David Mandelberg <david@mandelberg.org>
> ---
>  contrib/completion/git-completion.bash |  38 +++++-
>  t/t9902-completion.sh                  | 180 ++++++++++++++++++++++---
>  2 files changed, 189 insertions(+), 29 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 5fdc71208e..450fabc901 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -790,16 +790,39 @@ __git_tags ()
>  __git_dwim_remote_heads ()
>  {
>  	local pfx="${1-}" cur_="${2-}" sfx="${3-}"
> -	local fer_pfx="${pfx//\%/%%}" # "escape" for-each-ref format specifiers
>  
>  	# employ the heuristic used by git checkout and git switch
>  	# Try to find a remote branch that cur_es the completion word
>  	# but only output if the branch name is unique
> -	__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
> -		--sort="refname:strip=3" \
> -		${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
> -		"refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" | \
> -	uniq -u
> +	local awk_script='
> +	function casemap(s) {
> +		if (ENVIRON["IGNORE_CASE"])
> +			return tolower(s)
> +		else
> +			return s
> +	}
> +	BEGIN {
> +		split(ENVIRON["REMOTES"], remotes, /\n/)
> +		for (i in remotes)
> +			remotes[i] = "refs/remotes/" casemap(remotes[i])
> +		cur_ = casemap(ENVIRON["CUR_"])
> +	}
> +	{
> +		ref_case = casemap($0)
> +		for (i in remotes) {
> +			if (index(ref_case, remotes[i] "/" cur_) == 1) {
> +				branch = substr($0, length(remotes[i] "/") + 1)
> +				print ENVIRON["PFX"] branch ENVIRON["SFX"]
> +				break
> +			}
> +		}
> +	}
> +	'
> +	__git for-each-ref --format='%(refname)' |
> +		PFX="$pfx" SFX="$sfx" CUR_="$cur_" \
> +			IGNORE_CASE=${GIT_COMPLETION_IGNORE_CASE+1} \
> +			REMOTES="$(__git_remotes | sort -r)" awk "$awk_script" |
> +		sort | uniq -u

I realized that this sends refs to awk that it doesn't need to. I'll
apply this diff to the next version of this patch:

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 450fabc901..c9d014070c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -818,7 +818,7 @@ __git_dwim_remote_heads ()
                }
        }
        '
-       __git for-each-ref --format='%(refname)' |
+       __git for-each-ref --format='%(refname)' 'refs/remotes/**' |
                PFX="$pfx" SFX="$sfx" CUR_="$cur_" \
                        IGNORE_CASE=${GIT_COMPLETION_IGNORE_CASE+1} \
                        REMOTES="$(__git_remotes | sort -r)" awk "$awk_script" |

>  }
>  
>  # Lists refs from the local (by default) or from a remote repository.
> @@ -905,7 +928,8 @@ __git_refs ()
>  			case "HEAD" in
>  			$match*|$umatch*)	echo "${pfx}HEAD$sfx" ;;
>  			esac
> -			__git for-each-ref --format="$fer_pfx%(refname:strip=3)$sfx" \
> +			local strip="$(__git_count_path_components "refs/remotes/$remote")"
> +			__git for-each-ref --format="$fer_pfx%(refname:strip=$strip)$sfx" \
>  				${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>  				"refs/remotes/$remote/$match*" \
>  				"refs/remotes/$remote/$match*/**"
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 015289c776..343b8cd191 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -149,7 +149,8 @@ fi
>  test_expect_success 'setup for __git_find_repo_path/__gitdir tests' '
>  	mkdir -p subdir/subsubdir &&
>  	mkdir -p non-repo &&
> -	git init -b main otherrepo
> +	git init -b main otherrepo &&
> +	git init -b main slashrepo
>  '
>  
>  test_expect_success '__git_find_repo_path - from command line (through $__git_dir)' '
> @@ -674,6 +675,13 @@ test_expect_success 'setup for ref completion' '
>  	) &&
>  	git remote add other "$ROOT/otherrepo/.git" &&
>  	git fetch --no-tags other &&
> +	(
> +		cd slashrepo &&
> +		git commit --allow-empty -m initial &&
> +		git branch -m main branch/with/slash
> +	) &&
> +	git remote add remote/with/slash "$ROOT/slashrepo/.git" &&
> +	git fetch --no-tags remote/with/slash &&
>  	rm -f .git/FETCH_HEAD &&
>  	git init thirdrepo
>  '
> @@ -686,6 +694,8 @@ test_expect_success '__git_refs - simple' '
>  	other/HEAD
>  	other/branch-in-other
>  	other/main-in-other
> +	remote/with/slash/HEAD
> +	remote/with/slash/branch/with/slash
>  	matching-tag
>  	EOF
>  	(
> @@ -702,6 +712,8 @@ test_expect_success '__git_refs - full refs' '
>  	refs/remotes/other/HEAD
>  	refs/remotes/other/branch-in-other
>  	refs/remotes/other/main-in-other
> +	refs/remotes/remote/with/slash/HEAD
> +	refs/remotes/remote/with/slash/branch/with/slash
>  	refs/tags/matching-tag
>  	EOF
>  	(
> @@ -767,6 +779,19 @@ test_expect_success '__git_refs - configured remote' '
>  	test_cmp expected "$actual"
>  '
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
>  test_expect_success '__git_refs - configured remote - full refs' '
>  	cat >expected <<-EOF &&
>  	HEAD
> @@ -909,17 +934,19 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
>  	other/ambiguous
>  	other/branch-in-other
>  	other/main-in-other
> -	remote/ambiguous
> -	remote/branch-in-remote
> +	remote/with/slash/HEAD
> +	remote/with/slash/ambiguous
> +	remote/with/slash/branch-in-remote
> +	remote/with/slash/branch/with/slash
>  	matching-tag
> -	HEAD
>  	branch-in-other
>  	branch-in-remote
> +	branch/with/slash
>  	main-in-other
>  	EOF
>  	for remote_ref in refs/remotes/other/ambiguous \
> -		refs/remotes/remote/ambiguous \
> -		refs/remotes/remote/branch-in-remote
> +		refs/remotes/remote/with/slash/ambiguous \
> +		refs/remotes/remote/with/slash/branch-in-remote
>  	do
>  		git update-ref $remote_ref main &&
>  		test_when_finished "git update-ref -d $remote_ref" || return 1
> @@ -939,6 +966,8 @@ test_expect_success '__git_refs - after --opt=' '
>  	other/HEAD
>  	other/branch-in-other
>  	other/main-in-other
> +	remote/with/slash/HEAD
> +	remote/with/slash/branch/with/slash
>  	matching-tag
>  	EOF
>  	(
> @@ -955,6 +984,8 @@ test_expect_success '__git_refs - after --opt= - full refs' '
>  	refs/remotes/other/HEAD
>  	refs/remotes/other/branch-in-other
>  	refs/remotes/other/main-in-other
> +	refs/remotes/remote/with/slash/HEAD
> +	refs/remotes/remote/with/slash/branch/with/slash
>  	refs/tags/matching-tag
>  	EOF
>  	(
> @@ -972,6 +1003,8 @@ test_expect_success '__git refs - excluding refs' '
>  	^other/HEAD
>  	^other/branch-in-other
>  	^other/main-in-other
> +	^remote/with/slash/HEAD
> +	^remote/with/slash/branch/with/slash
>  	^matching-tag
>  	EOF
>  	(
> @@ -988,6 +1021,8 @@ test_expect_success '__git refs - excluding full refs' '
>  	^refs/remotes/other/HEAD
>  	^refs/remotes/other/branch-in-other
>  	^refs/remotes/other/main-in-other
> +	^refs/remotes/remote/with/slash/HEAD
> +	^refs/remotes/remote/with/slash/branch/with/slash
>  	^refs/tags/matching-tag
>  	EOF
>  	(
> @@ -1015,6 +1050,8 @@ test_expect_success '__git_refs - do not filter refs unless told so' '
>  	other/branch-in-other
>  	other/main-in-other
>  	other/matching/branch-in-other
> +	remote/with/slash/HEAD
> +	remote/with/slash/branch/with/slash
>  	matching-tag
>  	matching/tag
>  	EOF
> @@ -1135,6 +1172,8 @@ test_expect_success '__git_complete_refs - simple' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	matching-tag Z
>  	EOF
>  	(
> @@ -1173,6 +1212,20 @@ test_expect_success '__git_complete_refs - remote' '
>  	test_cmp expected out
>  '
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
>  test_expect_success '__git_complete_refs - track' '
>  	sed -e "s/Z$//" >expected <<-EOF &&
>  	HEAD Z
> @@ -1181,9 +1234,11 @@ test_expect_success '__git_complete_refs - track' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	matching-tag Z
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main-in-other Z
>  	EOF
>  	(
> @@ -1228,6 +1283,8 @@ test_expect_success '__git_complete_refs - suffix' '
>  	other/HEAD.
>  	other/branch-in-other.
>  	other/main-in-other.
> +	remote/with/slash/HEAD.
> +	remote/with/slash/branch/with/slash.
>  	matching-tag.
>  	EOF
>  	(
> @@ -1253,6 +1310,20 @@ test_expect_success '__git_complete_fetch_refspecs - simple' '
>  	test_cmp expected out
>  '
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
>  test_expect_success '__git_complete_fetch_refspecs - matching' '
>  	sed -e "s/Z$//" >expected <<-EOF &&
>  	branch-in-other:branch-in-other Z
> @@ -1333,8 +1404,8 @@ test_expect_success '__git_complete_worktree_paths with -C' '
>  
>  test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
>  	test_completion "git switch " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -1480,8 +1551,8 @@ test_expect_success 'git-bisect - existing view subcommand is recognized and ena
>  test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
>  	test_completion "git checkout " <<-\EOF
>  	HEAD Z
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -1489,6 +1560,8 @@ test_expect_success 'git checkout - completes refs and unique remote branches fo
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1508,8 +1581,8 @@ test_expect_success 'git switch - with GIT_COMPLETION_CHECKOUT_NO_GUESS=1, compl
>  
>  test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_GUESS=1, complete local branches and unique remote names for DWIM logic' '
>  	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git switch --guess " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -1518,8 +1591,8 @@ test_expect_success 'git switch - --guess overrides GIT_COMPLETION_CHECKOUT_NO_G
>  
>  test_expect_success 'git switch - a later --guess overrides previous --no-guess, complete local and remote unique branches for DWIM' '
>  	test_completion "git switch --no-guess --guess " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -1542,14 +1615,16 @@ test_expect_success 'git checkout - with GIT_COMPLETION_NO_GUESS=1 only complete
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
>  test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1, complete refs and unique remote branches for DWIM' '
>  	GIT_COMPLETION_CHECKOUT_NO_GUESS=1 test_completion "git checkout --guess " <<-\EOF
>  	HEAD Z
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -1557,6 +1632,8 @@ test_expect_success 'git checkout - --guess overrides GIT_COMPLETION_NO_GUESS=1,
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1569,14 +1646,16 @@ test_expect_success 'git checkout - with --no-guess, only completes refs' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
>  test_expect_success 'git checkout - a later --guess overrides previous --no-guess, complete refs and unique remote branches for DWIM' '
>  	test_completion "git checkout --no-guess --guess " <<-\EOF
>  	HEAD Z
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -1584,6 +1663,8 @@ test_expect_success 'git checkout - a later --guess overrides previous --no-gues
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1596,6 +1677,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous --gues
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1609,6 +1692,8 @@ test_expect_success 'git checkout - with checkout.guess = false, only completes
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1616,8 +1701,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
>  	test_config checkout.guess true &&
>  	test_completion "git checkout " <<-\EOF
>  	HEAD Z
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -1625,6 +1710,8 @@ test_expect_success 'git checkout - with checkout.guess = true, completes refs a
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1632,8 +1719,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
>  	test_config checkout.guess false &&
>  	test_completion "git checkout --guess " <<-\EOF
>  	HEAD Z
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -1641,6 +1728,8 @@ test_expect_success 'git checkout - a later --guess overrides previous checkout.
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1654,6 +1743,8 @@ test_expect_success 'git checkout - a later --no-guess overrides previous checko
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1666,6 +1757,8 @@ test_expect_success 'git switch - with --detach, complete all references' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1678,6 +1771,8 @@ test_expect_success 'git checkout - with --detach, complete only references' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1850,6 +1945,8 @@ test_expect_success 'git switch - with -d, complete all references' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1862,6 +1959,8 @@ test_expect_success 'git checkout - with -d, complete only references' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1870,11 +1969,15 @@ test_expect_success 'git switch - with --track, complete only remote branches' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  	test_completion "git switch -t " <<-\EOF
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1883,11 +1986,15 @@ test_expect_success 'git checkout - with --track, complete only remote branches'
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  	test_completion "git checkout -t " <<-\EOF
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1907,6 +2014,8 @@ test_expect_success 'git checkout - with --no-track, complete only local referen
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1919,6 +2028,8 @@ test_expect_success 'git switch - with -c, complete all references' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1931,6 +2042,8 @@ test_expect_success 'git switch - with -C, complete all references' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1943,6 +2056,8 @@ test_expect_success 'git switch - with -c and --track, complete all references'
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1955,6 +2070,8 @@ test_expect_success 'git switch - with -C and --track, complete all references'
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1967,6 +2084,8 @@ test_expect_success 'git switch - with -c and --no-track, complete all reference
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1979,6 +2098,8 @@ test_expect_success 'git switch - with -C and --no-track, complete all reference
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -1991,6 +2112,8 @@ test_expect_success 'git checkout - with -b, complete all references' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -2003,6 +2126,8 @@ test_expect_success 'git checkout - with -B, complete all references' '
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -2015,6 +2140,8 @@ test_expect_success 'git checkout - with -b and --track, complete all references
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -2027,6 +2154,8 @@ test_expect_success 'git checkout - with -B and --track, complete all references
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -2039,6 +2168,8 @@ test_expect_success 'git checkout - with -b and --no-track, complete all referen
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -2051,13 +2182,15 @@ test_expect_success 'git checkout - with -B and --no-track, complete all referen
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
>  test_expect_success 'git switch - for -c, complete local branches and unique remote branches' '
>  	test_completion "git switch -c " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -2066,8 +2199,8 @@ test_expect_success 'git switch - for -c, complete local branches and unique rem
>  
>  test_expect_success 'git switch - for -C, complete local branches and unique remote branches' '
>  	test_completion "git switch -C " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -2104,8 +2237,8 @@ test_expect_success 'git switch - for -C with --no-track, complete local branche
>  
>  test_expect_success 'git checkout - for -b, complete local branches and unique remote branches' '
>  	test_completion "git checkout -b " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -2114,8 +2247,8 @@ test_expect_success 'git checkout - for -b, complete local branches and unique r
>  
>  test_expect_success 'git checkout - for -B, complete local branches and unique remote branches' '
>  	test_completion "git checkout -B " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -2152,8 +2285,8 @@ test_expect_success 'git checkout - for -B with --no-track, complete local branc
>  
>  test_expect_success 'git switch - with --orphan completes local branch names and unique remote branch names' '
>  	test_completion "git switch --orphan " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -2168,8 +2301,8 @@ test_expect_success 'git switch - --orphan with branch already provided complete
>  
>  test_expect_success 'git checkout - with --orphan completes local branch names and unique remote branch names' '
>  	test_completion "git checkout --orphan " <<-\EOF
> -	HEAD Z
>  	branch-in-other Z
> +	branch/with/slash Z
>  	main Z
>  	main-in-other Z
>  	matching-branch Z
> @@ -2185,6 +2318,8 @@ test_expect_success 'git checkout - --orphan with branch already provided comple
>  	other/HEAD Z
>  	other/branch-in-other Z
>  	other/main-in-other Z
> +	remote/with/slash/HEAD Z
> +	remote/with/slash/branch/with/slash Z
>  	EOF
>  '
>  
> @@ -2199,7 +2334,8 @@ test_expect_success 'git restore completes modified files' '
>  test_expect_success 'teardown after ref completion' '
>  	git branch -d matching-branch &&
>  	git tag -d matching-tag &&
> -	git remote remove other
> +	git remote remove other &&
> +	git remote remove remote/with/slash
>  '
