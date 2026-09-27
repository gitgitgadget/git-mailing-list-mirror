Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34023B14AA
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522369; cv=none; b=dUYVzU4PD+okZLSZxakZTKPX651AB0y9hwI67zQmNP0eMLsPSKSmSgSdg6mnkDiPK+EfspkO6YZbb13psto+Jc7m3ixNpJ5X8T4yM++psJ2665zMITR3VW4SSYSmpX/B9yS95kkelC1QNkpM6trJbcUYKQg723CcjWL139KOigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522369; c=relaxed/simple;
	bh=y8xPUme151g4sjD00apxzpU/kwJPmqJV4JGUcE/VADk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7g6HQ/pvYq646uRMX8k9Z9fE7kwC/PKEZ8VR/2Zj1upnodRZcHUQvaFPJHs0x2ivVbsa53ZutP7qK2pOFcMzVIBJZTFhMNRsvfUFgPhUAO9pNAR6s1fhPPtby5B8SWLYZB+z8Qp1cAsyoEanr7cWP0slH+/V++3JuVgK6OXnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZNUUVGS; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZNUUVGS"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffe817151so4390475e9.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2026 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790522366; x=1791127166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ilSdAbbhXdaO36RgrxMp68V/vg0lg4qcaWCfgn2bvW4=;
        b=GZNUUVGStW8UoJKe19+6kPdeqAplaww04emMRgkDIjbI92zGFJHXi4pkDHTUms5djK
         sC/mBiuHM0nU8E/SVojohME4aIbJsIN/t7DfqbLl5IDbVwV1wupHHs6vHxT5k7BN+7OZ
         tVi0lntvTlkZE5CDw78NHWodpGNZTJfb0sS2gcz6CqT4dmhsF1rkBmbUEdxY9DqzJoZB
         t7m+lBJceiuUQupnON3ibyMvlhBrPGR2Mk+ihNCFBM/7l5ftvX9nGLUnK5CB9pjMFub5
         MItQN7sWy24S8lExQnb+KEAqedOrhGe1IjdXBUqeWm2+wy1zzVsuxN57lVwp8KVJvjSX
         dvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790522366; x=1791127166;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ilSdAbbhXdaO36RgrxMp68V/vg0lg4qcaWCfgn2bvW4=;
        b=j3RZdpm9BTTPehzcshwUNq3s+M2D0MGpgjpN3vIs4KE4ce9WLbapXgUR/To3Pow+Eq
         9zYmkvl/7vL27UxlY2nNU2GpmzExbTdl0nrtkSCJh7+6YM+3x5ZZtnD5nOSqMoMs6GIA
         fWPIRz+GfSLSCcged5zkWcQ7ZtOxFlvjGlLWTxBdC815xYoLnnI3WemK5kyHORzTQbrz
         PKqDPe8FrcRW7FzIAtOSYb4Ad4EnqarEZ2Z281pdRpn42vJCuc793MgF6vtbop785B9y
         X6EISPv5UWP4uZkuO3X6bMN8m71EV0Ut/+7H3FGA+gbGSU2tR+WITcbOke0gyj1uHCTG
         4BuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEk7qIj5TBG0L5ozLB5CmB8TA8g+zwFZZGKl9R3tix4SSWyGdSaleKyQ8CWP9KzyrEWGw=@vger.kernel.org
X-Gm-Message-State: AFuF++mWDXjkq337GGer/jWKceWajcUU8j43phknrjWQU0t9ALhROwmQ
	BidWWtmeAkONuzMGrsrUJw5oxac2ZXnKH0xLxbzeWudn/+fazzzX+ouOAoMrr3R5
X-Gm-Gg: AYBFou0pPE1p/mtUpYO0xxVTVF9xHDm1gH630Ct6AUiY1NmgGGiiPpj07eNy3UpWK2w
	AvcQ+tYErbok4zjX2vy/jbxr4cy+yCOSjVTX3Aw8VqFjtaEWY9OXf2VQBVhZfB+z3gCEt75Fq6C
	SI8iEsxgsxT+ldy+E3FR9NW1c049WjGQWBE+rCmYLZ3lda8JU4Zlh5t7k3BY+KUxLVHVKIUMiDJ
	/zpFSHdvN2BfKFtoNRxbLX6/U+uqgL9YCo6/M1Bz5XpJ2oH3aha70PTiqMkRneP7b3182/GkAET
	uJrHBG/dWQHWJx/GzAl2IWcCfuPUYvoU0w3yoqG7abxMQynaigfU92VhvUKu8CYT61ERtKATeZG
	OGZXDfpmTa9s7jqSKeNOV5cOg3earJypA+aEO+a6/7do3gAo7bVdXYm2cPHYac5gMd2i8TTYps/
	bY+iYg3I1EP6dRuqKzSXymBGvGBd2W1SDAvTxinBpFg9SFzfaEIUFqTTF6RqCApdAcqmB9ucI6D
	gfgSW052nuPtIp52DHCs8q6dSyFTlSDxqF6cdNM4SFedeXgW9fZWw==
X-Received: by 2002:a05:600c:4e53:b0:49e:6861:50f7 with SMTP id 5b1f17b1804b1-49fe66c8921mr180205985e9.5.1790522365666;
        Sun, 27 Sep 2026 08:19:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee6cc7d3sm154855035e9.0.2026.09.27.08.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 08:19:24 -0700 (PDT)
Message-ID: <fc4efe9f-69f4-4f58-9f7c-8f2e75a8e590@gmail.com>
Date: Sun, 27 Sep 2026 16:19:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ci: point leak-sanitizer failures at the actual test and
 error
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 25/09/2026 19:54, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
>      ci: point leak-sanitizer failures at the actual test and error
>      
>      I discovered while running CI on another GitHub pull request that it's
>      very hard to see where the error is for the leak tests.
>      
>      This will stop each leak-sanitizer script at its first failure and
>      points annotations at the real file and error.

Putting the leak output in the test results is very welcome, but does 
this mean that if there are two leaks we only report one?

>      Proof that it works:
>      https://github.com/git/git/actions/runs/35871180948/job/107215430244

Opening that link shows that the individual test failures are no-longer 
folded and I see some very strange scrolling behavior in firefox - when 
the page opens it scrolls to the bottom of the output of 
"ci/build-and-run-tests.sh" and if I try to scroll up it immediately 
scrolls back down as soon as my fingers leave the touchpad.

The patch below seems to do more than just changing the output to 
display the leak backtrace - it adds some escaping and changes the 
annotations. There is no explanation of what these changes do or why 
they are required.

Thanks

Phillip

> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2419%2FHaraldNordgren%2Fci-annotation-file-line-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2419/HaraldNordgren/ci-annotation-file-line-v1
> Pull-Request: https://github.com/git/git/pull/2419
> 
>   ci/lib.sh                            |  1 +
>   t/test-lib-github-workflow-markup.sh | 49 +++++++++++++++++++++++-----
>   t/test-lib.sh                        |  2 ++
>   3 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index c6ccbf8c17..a89f480a78 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -382,6 +382,7 @@ linux-leaks|linux-reftable-leaks)
>   	export NO_CVS_TESTS=LetsSaveSomeTime
>   	export NO_SVN_TESTS=LetsSaveSomeTime
>   	export NO_P4_TESTS=LetsSaveSomeTime
> +	GIT_TEST_OPTS="$GIT_TEST_OPTS --immediate"
>   	;;
>   linux-asan-ubsan)
>   	export SANITIZE=address,undefined
> diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
> index fa29a62aa3..4f6460a0ad 100644
> --- a/t/test-lib-github-workflow-markup.sh
> +++ b/t/test-lib-github-workflow-markup.sh
> @@ -28,6 +28,7 @@ start_test_output () {
>   	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
>   	>$github_markup_output
>   	GIT_TEST_TEE_OFFSET=0
> +	github_markup_script_name=${0##*/}
>   }
>   
>   # No need to override start_test_case_output
> @@ -35,22 +36,54 @@ start_test_output () {
>   finalize_test_case_output () {
>   	test_case_result=$1
>   	shift
> +
> +	case "$test_case_result" in
> +	ok|broken)
> +		# Exit without printing the "ok" or "broken" tests
> +		return
> +		;;
> +	esac
> +
> +	test_case_line=$(find_test_case_line_ "$1")
> +	test_case_output=$(test-tool path-utils skip-n-bytes \
> +		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET)
> +
>   	case "$test_case_result" in
>   	failure)
> -		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
> +		test_case_summary=$(printf '%s\n' "$test_case_output" |
> +			tail -n 20 | github_escape_message_)
> +		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
> +			"failed: $this_test.$test_count $1%0A%0A$test_case_summary"
>   		;;
>   	fixed)
> -		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
> -		;;
> -	ok|broken)
> -		# Exit without printing the "ok" or ""broken" tests
> -		return
> +		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
> +			"fixed: $this_test.$test_count $1"
>   		;;
>   	esac
> +
>   	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
> -	test-tool >>$github_markup_output path-utils skip-n-bytes \
> -		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
> +	printf '%s\n' "$test_case_output" >>$github_markup_output
>   	echo >>$github_markup_output "::endgroup::"
>   }
>   
> +finalize_test_leak_output () {
> +	test_leak_summary=$(head -n 40 "$TEST_RESULTS_SAN_FILE".* |
> +		github_escape_message_)
> +	github_annotation_ error "t/$github_markup_script_name" 1 \
> +		"memory leak logged around $this_test.$test_count%0A%0A$test_leak_summary"
> +}
> +
>   # No need to override finalize_test_output
> +
> +github_escape_message_ () {
> +	sed -e ':a' -e 'N' -e '$!ba' -e 's/%/%25/g' -e 's/\r/%0D/g' -e 's/\n/%0A/g'
> +}
> +
> +find_test_case_line_ () {
> +	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
> +	head -n 1 | cut -d: -f1
> +}
> +
> +github_annotation_ () {
> +	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
> +}
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1f0505e412..a52589c6a2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -199,6 +199,7 @@ mark_option_requires_arg () {
>   start_test_output () { :; }
>   start_test_case_output () { :; }
>   finalize_test_case_output () { :; }
> +finalize_test_leak_output () { :; }
>   finalize_test_output () { :; }
>   
>   parse_option () {
> @@ -1218,6 +1219,7 @@ check_test_results_san_file_ () {
>   		return
>   	fi &&
>   	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
> +	finalize_test_leak_output &&
>   
>   	if test "$test_failure" = 0
>   	then
> 
> base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7

