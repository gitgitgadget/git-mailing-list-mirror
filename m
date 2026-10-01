Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686873DA7DD
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884160; cv=none; b=XYMTlfoi9lFzdG2NjHOuhu49PuAPYci/h7Es2zWh9tPi+sjZKhG9THi8WfFTQrPyJuVeZJ0sfzOherLIlqr0F5OlzMyPf7y2IE0LvRqybXW0sR642i5xRrNrxPZmXxTwLDrXP/SFoj4gpdGwanE1+nYY2LXTVpMk/Frb1K6+VMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884160; c=relaxed/simple;
	bh=MFUe/WpMREZmVpMEJqr7ypa8zzJqu14yb13yk1rApLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGSO19Yhhr6krtLvwrLMfaif3wN3/LoH+VMit94CVGJdSCJuw6fEDMJBE+7Nlcd6SfsY1Z8HTZEa8aKHtA5WOPNXE0ll+ahquIT2vjLgN4mjDFSfdnWNs6EbXXO6nwjCiaf7psrLGfe2+TpimFps411sHNb+ayWUfWBCa0tOU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r6Lk+nKe; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6Lk+nKe"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so52255595e9.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790884157; x=1791488957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=op06To9AY5h6SxZHdQc8iA8iBRgM7VsgsQk7u9NO3/A=;
        b=r6Lk+nKe8t2QVN8kI7I8VXMZdulN+N0DO0L1/x4U/RNuNfmSD6rnAFpIZ8dvhKYJlV
         JVlRt0MRYZXbEwLln71+bmG3Bu3KKB020eAKoOBun3nr8jHn1cdRPrZVdtdjKlE1jBQY
         onDi542elMPL/mDzegwYOUeVVICmQqAXvw+ekV7M2cM9CTjggZJDuSYQjLU8k7qg92KZ
         x8vJFSCpwP8bsvhuNSjFHl+ikxXAbHncLHgN5imguWx91CNv0cZ4GXft+4gUzUPXIP/Z
         3j6O+Pb7lLSgqbmhWLau5UDlGtW3/auHRul2ErxqRKfNErO5jJ002OaDdbDAQ/9d24TI
         kRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790884157; x=1791488957;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=op06To9AY5h6SxZHdQc8iA8iBRgM7VsgsQk7u9NO3/A=;
        b=zlZ3NO5XTqoujVb7oGxmLgEhcCKTZ5uvmNZmb69qSfeoOMjQmItynWrtUK2tOeQ+db
         rqrkkWqZsrLnj8gGlRGiFxQg5/6z51Yl456i20P6h4hksXCbMCi0gDjNGJ/2KKlPiaQZ
         8TA9/XcpRBmuxlFVTbLKYA+0h4ot6TBc5iEFce3YxMnDouEkkLB8oXtgJdOie8rETpaF
         2YXgUBTpnaRa37oW3lgBseVB2X7IFJcYdGpZP1JC+FRSrj+uzZZ+0jHSnH30+yyV53PL
         HW67v8WSitAvHIpf4BJSjO/191a4ObEVdAOmvc6eLh7AXixLwyCihZjQLxWZk31bPTjI
         Du4A==
X-Forwarded-Encrypted: i=1; AKwUvBwOeahOyaH5gcT9NKGDnxp3IUgUg4TDz1pA53iaydYKL81t1OGEOLWMlovvtrjpWMolLjg=@vger.kernel.org
X-Gm-Message-State: AFuF++lIM1hKo/X+jJ+2/bOwghIWkba9w/KRH/HnZzB4F5OcdQkx14q6
	pMu7NusAprd2DLWqrf90JFtXDQnwebK9b7ImI06c0N+bmfodeDLHdl2iYfhvXTkf
X-Gm-Gg: AYBFou0VIrUmeD3dugo++H9CUjIhnpytuL2NvEj3YGeW/JmQFCP5fpCDFjkOe5UK+Yr
	Zc4Y34x1dfyfe6Epo+dQ1S3NyGvBv/P+mSCKMUuSQqwqpnzIWqY5X58Wbw8vG0xWcD0JgwJQRvf
	a/JORhnDC9vrgpBWcdyrGpqwf63d5mcG0u5Qtv5Oct4f20PhtjOrbrYa1ZcQRQ0kNsjCZOv54w8
	Ayj77175LQhpSLyvOwvfvfqCUmb/O5E6UmbW1dsuZikAwZMn3iVr5BAbwvNlWtJrzpvrmLcgAie
	+ia/aMvmqHwtCgxsTBstnYAiFBwdUDGIvVl2XHO+bAa9CIxxAfYzzQ87F1h18QzCPHddJtGlZ4z
	92nD4aAfbacgw+JONX9hSNnx7h7cgU1BrzmE0ELSmNIEwpogQtNxQf2hgXoYj8+UIQ8pzIYbyZx
	yMUpjmbxjbavZLwTzkUSYedRldOqQDmRcaRzvurVYcaon7J5Coqz95o03DpCm3PcKJPvg6JVjaC
	EB7ROHom4FGUgE9QLvt4LqlCxj/XyJLLJf8QHjnbfkTKHZ2gkwysQ==
X-Received: by 2002:a05:600d:8645:10b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-4a02759003emr8289855e9.10.1790884156495;
        Thu, 01 Oct 2026 12:49:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0858sm530356f8f.8.2026.10.01.12.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 12:49:15 -0700 (PDT)
Message-ID: <0e0972b7-65a2-46ce-84a9-7e403620802a@gmail.com>
Date: Thu, 1 Oct 2026 20:49:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] ci: point test failures and fixed known breakages
 at their file and line
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v4.git.git.1790880255.gitgitgadget@gmail.com>
 <8ec2b53d8265e1219b5f1279cadda2ac44c96ae0.1790880255.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <8ec2b53d8265e1219b5f1279cadda2ac44c96ae0.1790880255.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 01/10/2026 19:44, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> A test failure or a fixed known breakage gets an annotation that names
> the test but says nothing about where it's defined, so a reviewer has
> to search the script by hand to find it.

I'm afraid I'm still not clear what this does in practical terms. What 
appears in the test output that the user sees that didn't before?

> Find the line a test is defined on by searching the script for its
> description as a fixed string, using the first match. Fall back to
> line 1 when the description is not found verbatim, which happens when
> a test builds its description at runtime instead of writing it out
> literally.
> 
> A GitHub annotation is a single line, so a `%` in a test description
> has to be percent-encoded as `%25`, or GitHub misreads it as its own
> escape sequence. for-each-ref's format atoms use plenty of them, e.g.
> `%(raw)`.

That's a useful example of why we want to escape the output which makes 
it all the more puzzling that we don't escape the existing annotations 
that I mentioned last time.

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   t/test-lib-github-workflow-markup.sh | 38 +++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/t/test-lib-github-workflow-markup.sh b/t/test-lib-github-workflow-markup.sh
> index 0d54496358..6fee4dfb22 100644
> --- a/t/test-lib-github-workflow-markup.sh
> +++ b/t/test-lib-github-workflow-markup.sh
> @@ -31,6 +31,22 @@ start_test_output () {
>   	github_markup_script_name=${0##*/}
>   }
>   
> +github_escape_message_ () {
> +	# % has to be escaped or GitHub misreads it as the start of its own
> +	# percent-encoding (e.g. a literal %(raw) in a for-each-ref test
> +	# description).
> +	sed -e 's/%/%25/g'
> +}
> +
> +find_test_case_line_ () {
> +	# A description can contain characters like [ or * that would
> +	# corrupt a regex search, so match it literally and take the first
> +	# hit. The -- keeps a description starting with "-" from being read
> +	# as an option.
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

