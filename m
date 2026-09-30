Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD55E4E01E3
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780218; cv=none; b=Pgx+b4akMVH140rsj9GgySZlOajkXC0LSXdyt+diDPw35R1x7Z77cVfr5h/JdSzjm0hmxnw2lcR2IH9rSjLHSWyT/rtAU3iQEwKKDFxF6k/fCAWxO0xtjbKIi9LeByJk6APCikLS/bTqOHKnirERJ71knmNt0pbvzGfZzCkXpbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780218; c=relaxed/simple;
	bh=N8VZjVu5/2yIRHgWiOxiH1DQ8D9bAcSu7LJC1YjNfz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqhTwdV8I6E4woXNew8FcISG5kW4PiNmnzVbVHLDD5WmYOsZIEYFmTWfnrySA12l4aDdunDPt3GH2tzOVUHApgIyrJMp7eqF9iKs/186YULUueBJ/sQhMkJPXPMw+pcsiPmYTPEO6ZAeZVbwAq468Rwu9Xnlc9O+n5VOt834viI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO8/IA0O; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO8/IA0O"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2e201b7189so126351166b.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780205; x=1791385005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aahfjgFOSfVAsh8S027gq/nLpLEwRHsc32bHfWdbABQ=;
        b=PO8/IA0OhJQGK4f5MhKOyDrArPE/0eIdEWgPy2Uov1QyFrEd5599G/EEanh6L4XiNn
         b8UeUTyB//RScl42s6yEf+98LFXoh3gfsNVPK2tg5l91lF/ifz6DnvOe4VDikOKD/z+H
         NrROgrRxCbU2wdjQOIj9CyGRGMy6f5SO17C62MxtzTw29Wi1Pl8NSWTTxJ6dWeZjM+9U
         bK1JgWFikzeDp++Zecxmhz9EZxr7wwL6x8adyuGf0LAqbNtb9h2PSAJRK+ub3hftrthw
         uwCLm2llSgnPK4ytW/D1sjIORTkkIidgTKAXwEF+PHzn8z0us+Fd6g0lY+Gg12NToWiR
         0URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780205; x=1791385005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aahfjgFOSfVAsh8S027gq/nLpLEwRHsc32bHfWdbABQ=;
        b=0Jx0VqYpP7RquP9UGFy+/Yk6pN9umnG5gh3G/UbRQkkHEmmSRfTsKcyGCbVpEDU6ig
         qLzMis8fUEXf5L2vLzrucU0OTmTuEM7WUdFlPNMJJ4ATpsG2jriCilB7UUFu86hgnim8
         3nJapegyKhHCJvcHretpHR+UIEuvxeu+tQSLIkSjkAM876mzVRaptE417g0MxyTgZTVI
         EALqsAuzR/Fu7AWuZb+HyD75NqXLEmnmLoawQ6EOEqmLSEJ/tCt5hMHNekEiHLyUrwRl
         ucj57C1+SGoqLJyW6ln5zRoEb5LcgZP1p9s7MyQs8rYBdG/m95JBHE01M8wB4PI6qcic
         vTqw==
X-Forwarded-Encrypted: i=1; AKwUvBw8+YsCDIrK/FgOe0iEWfi5msC0Go4NT2q04g8m4RWolligUnnoGnmIZkEoTX+ry2wkRCM=@vger.kernel.org
X-Gm-Message-State: AFuF++nCY4TZ2DuzpA7mdsgNGMhM042N9KmZXPXBvFXbKTQjsgtshto3
	bFgvZTVwLTe6OliSuU73HidbipfwTDm1RGYu5mPxGFcmdMq3uCGeUAs5obcv5xLQ
X-Gm-Gg: AYBFou2ygmMiGGZJNmE0n07wA4VjGNo0kJX7rJLbKurmnFHpNs3mHmGeRvALzKiDTGQ
	6XGkTkxIxK+Silze9LGbo4fv/gijD2v9JzZ5YAb1GobSGQwX/OkyJoD4ID0lMVZd0S19A0LDTkC
	qraZ05dKczWp6ZDa9Qg1ILwqnS6nWEa+ZTMZBi+3Zwy+yZBzgluZGUaPBmW3JKs6t6vAdmypalu
	KsWqFUHoipjPl0PZ81V2/M4qD4zyRAilQYQWwWxzZOk2/+Qkfbs1Gje+DJvAPXMfbJZ2nAWktan
	3JwwPIRwq8ddt1vog6n9NrTgO9db/ydpWDf73qwTnVTzGM/cUbJtkFeuxYiO7Sat7ixBbFAfQ/g
	K0lhKuR7DXBx1Pu0t8pvBZwCRgHEbWPjT6qRy+0orHw6EH7h58IizZFoJqF6lK/Uaywfd4MFA7R
	Ni5xw7Zd12D/1UuwGf4VhrdUD6pl4oqMeoF31svdfg+1+oTML9w4UAp50Kxn2LApnIuJqAQuA7a
	Yk415Kv1f7TXmCGzaVbHvDIubElBPNC39A1+IeT7ioTf/TlQi1gcPrcRmX7Iagr
X-Received: by 2002:a17:907:3d91:b0:c28:599b:7782 with SMTP id a640c23a62f3a-c2e23cd9d61mr147939466b.21.1790780204754;
        Wed, 30 Sep 2026 07:56:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d36795sm16563966b.38.2026.09.30.07.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 07:56:44 -0700 (PDT)
Message-ID: <5529bccf-eeb1-40f9-ae03-8fa19dc26f5a@gmail.com>
Date: Wed, 30 Sep 2026 15:56:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] ci: point test failures and fixed known breakages
 at their file and line
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
 <750c3605128c268f331b1b9477ca0489ced75543.1790748583.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <750c3605128c268f331b1b9477ca0489ced75543.1790748583.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 30/09/2026 07:09, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> A test failure or a fixed known breakage gets an annotation that names
> the test but carries no file or line, so there is nothing to click
> through to from the GitHub UI.

Have you got an example of this? As I said in my last mail, I can't see 
any links in the output from the linux-leaks job.

> Find the line a test is defined on by searching the script for its
> description as a fixed string, using the first match. A description
> can contain characters like `[` or `*` that a regex search would
> misread, so match it literally. 

This second sentence doesn't really add anything - you've already said 
we're searching for a fixed string.

> Fall back to line 1 when the
> description is not found verbatim, which happens when a test builds
> its description at runtime instead of writing it out literally.

Ironically, it is the dynamically generated tests where a line number 
would be most useful, but there is no easy way to determine what line we 
should be using.

> A GitHub annotation is a single line, and a test description is always
> one line too, so only a `%` or a stray carriage return in it needs
> percent-encoding to keep the annotation intact. Escape `%` first, or a
> carriage return's own encoding would be mangled by a `%` substitution
> that ran after it.

Why do we need to escape the test descriptions when we haven't been 
doing so up to now? Also if the test description is a single line why 
are we worring about '\r'? If it is so important to escape the output 
why does this patch not convert the existing annotations like the 
"group::" on in the trailing context lines?

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   t/test-lib-github-workflow-markup.sh | 38 +++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
> index 0d54496358..66d2ccca18 100644
> --- a/t/test-lib-github-workflow-markup.sh
> +++ b/t/test-lib-github-workflow-markup.sh
> @@ -31,6 +31,22 @@ start_test_output () {
>   	github_markup_script_name=${0##*/}
>   }
>   
> +github_escape_message_ () {
> +	# A test description is always one line, so only % and CR need
> +	# escaping here. Escape % first, or CR's own %-encoding gets mangled.
> +	# \r is not a portable sed escape, so splice in the actual byte.
> +	sed -e 's/%/%25/g' -e "s/$(printf '\r')/%0D/g"
> +}
> +
> +find_test_case_line_ () {
> +	# A description can contain characters like [ or * that would
> +	# corrupt a regex search, so match it literally and take the first
> +	# hit; -- keeps a description starting with "-" from being read as
> +	# an option.
> +	grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
> +	head -n 1 | cut -d: -f1
> +}
> +
>   github_annotation_ () {
>   	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
>   }
> @@ -40,18 +56,28 @@ github_annotation_ () {
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
> +	test_case_description=$(printf '%s' "$1" | github_escape_message_)
> +
>   	case "$test_case_result" in
>   	failure)
> -		echo >>$github_markup_output "::error::failed: $this_test.$test_count $1"
> +		github_annotation_ error "t/$github_markup_script_name" "${test_case_line:-1}" \
> +			"failed: $this_test.$test_count $test_case_description"
>   		;;
>   	fixed)
> -		echo >>$github_markup_output "::notice::fixed: $this_test.$test_count $1"
> -		;;
> -	ok|broken)
> -		# Exit without printing the "ok" or ""broken" tests
> -		return
> +		github_annotation_ notice "t/$github_markup_script_name" "${test_case_line:-1}" \
> +			"fixed: $this_test.$test_count $test_case_description"
>   		;;
>   	esac
> +
>   	echo >>$github_markup_output "::group::$test_case_result: $this_test.$test_count $*"
>   	test-tool >>$github_markup_output path-utils skip-n-bytes \
>   		"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET

