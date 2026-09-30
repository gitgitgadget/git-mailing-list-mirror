Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1D3BE630
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780212; cv=none; b=kDfvtKRtWOqu93Ev5SA96AidZDQLaXbOALgSfqZ1H8sx84O6k1IePO/XH5rKZZH2kEI1n7EP6oDqoixztpsgDxCGsq9GyNds+S/bu7xPFCQWGJBtYS532p3WLi9AvuM9dlS6vN9JpaTiNBLKne/JTjyyCRo4N7RYtM4awWs1szg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780212; c=relaxed/simple;
	bh=Axs6a2AYFQXob3/qpO+1mpZ2P4f/P29YgnhGkqVX3vI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWo2AOS6q6hl1+VjmqM9bcxGwftY75tSXlhRNChwbjFOn6/6GoSvSlU2e5nj31aZcMAGH0YTmMRVmxODIx6NZC17ZmgQrNSrLl6JK8xAZaQN05FAShseCrahFc1TXiVhi1bKisQ+sjHBOU698vYfI0A/NUppti1nBUTzzeS1g+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZL77pbI; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZL77pbI"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae19319854so1019281a12.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780195; x=1791384995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Th1xF7tqd8FgLXHIOx0+cr2NJklMpqW7iri+TpQuNE=;
        b=lZL77pbIaS+IVUR2ICbt11T6xUSxJjvcCWOYSXl/SPxmae39V9Uo6xmZMxSRG476P6
         S2NGwjkJ7kuec1LKsQX/XktYvQy6UgMQjsw1C3U1KhEg+Rz3LF2QPpNctFZIU2Yt3Hl9
         4b4mTUrMVriNKuy41+XUtb8J1KFc43mVA+n8yUGxUF/0JXMKcABRnJzZf4RdNZTDRAYA
         v50cUkhm3uteyN+pyWB1gcsX+g1+6IMinVKgl5kOFqsMT4uiGxBgNzoTYPxizX86fsgb
         oos4uSYGU9OhSI6AWH2kK0VAU0kdfwERTzVskreAd7tRcs3byaQXTOfS3F8jr1CQ5Elr
         O0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780195; x=1791384995;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5Th1xF7tqd8FgLXHIOx0+cr2NJklMpqW7iri+TpQuNE=;
        b=a/wsBzwPlnY4xzNC0qmAs7htKXbP0Bk5NY0vF35nBPrOgowB6TF7NUIglsE4MHjSWb
         JF+Bbbp1SCRgH+Hjhun5GCoP33oYq8kaaRPM5He8ofpFG2MJQAGuDPx0j8KnWq3ww6Fd
         vqaOJhoBdaq33yok97vlROX+2KxMp/YZepUpi1Ejl7AL7AI39aw9FTNru9P3BYYnrf4p
         Mb7Gb4D6M44JEgJueUrWjGDs97+LAIevVbjLYp9fkF3/eLvQoytasZN0h6wBlK2yiU32
         Hov/Sl8JNL3Tmer3QW6m8KYzI++um6UXX3LZvXdXh2t4h/ZfdNmElfKAPFBoqztpruqH
         fNqQ==
X-Forwarded-Encrypted: i=1; AKwUvBz5c9sBmi5HH0SrcH2uVqxinnOwM15KdiEkyA1jTcG65+L8h0qnMZFEpltLxGWxmuFC9lQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlcVwLBeqfV3XMUoXYplzAIZDnsl3auFolev01rhVAxyICc8Sz
	qliT/BnhW/P0N/4INMaicp+sjhr6n7rWoJ7qkUdiQQGrs8HouaK+BDs21+Yu/XFH
X-Gm-Gg: AYBFou2/D07RR1tThrANZTSl39hNM+vFFmOr3hFSO2StHwYcCTja53TPBg/BSXKdl2B
	SZypShJEftlHNL+DbO2E1iCUh4lf++N+jYPgRRtgCjXGvuW0yWP8OeZ5rAKwlc5+r5nSzf/vKVT
	1HsUIffuNpNzvwK6anlcJ5jeVlXaYitSQEVRQhmB4rnqkLPtknIfU2ZUBLZld+DQEcd3tJYL7+/
	3CEktBsby64qmPihCT7ikwkywMf8WQW9C+HKlZlZtwRsh9OXMIvC86gtz0BU2MobCuspo7XXDdf
	Qqm/1eDQI5C4f98PKaE9yk3+8CB+++ak1HzXbfPuw+3pYo83qekk314s6odyogZ0nBi4ULw1QgC
	jfwneX//rApQQxDiuCxofYgAbMIzkIjalvAGL/oU2MGbmyX/1mYCDHMzmxV5XSsejkT9V5psv0O
	vI/4rriWJu/RpSGodsAbGQFrIKRHuzQZoIjGi/1+6kSntG5/nexvza+vMMfSdq9arr8bPyxr0ff
	DHUhVNRqdl+s63VSY7eCz508AZx3fQ6m5mOz2N+hnG67cT7QUiej4g=
X-Received: by 2002:a05:6402:3221:b0:6ac:c82f:3caa with SMTP id 4fb4d7f45d1cf-6ae198649c8mr1389018a12.1.1790780195236;
        Wed, 30 Sep 2026 07:56:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1568e8b2sm884260a12.19.2026.09.30.07.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 07:56:34 -0700 (PDT)
Message-ID: <37628f91-eb36-426b-9f6b-b2083f917919@gmail.com>
Date: Wed, 30 Sep 2026 15:56:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] ci: annotate leaks and stop a leak-sanitizer
 script at its first failure
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com>
 <b6a36820ae3c50e36d71f751b7ff25b7f3275cea.1790748583.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <b6a36820ae3c50e36d71f751b7ff25b7f3275cea.1790748583.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Harald

On 30/09/2026 07:09, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> A leak is only discovered once, at the end of a whole script, well
> after every test has already reported ok, and it gets no annotation at
> all, so a leak-sanitizer job's only visible failure is:
> 
>      Process completed with exit code 1.
> 
> Give a leak its own annotation. Point it at the test script, the exact
> line isn't known, only which script the leak turned up in, and put the
> full sanitizer report in a log group next to it, so it stays visible
> and isn't capped to a handful of lines.

It is good that it reports the full LSAN but is it really necessary to 
emphasize that - why would anyone reading this think it might be 
abbreviated?

What does adding the file and line number to the annotation buy us? I 
was hoping there'd be a link in the output to the test source but I 
can't see anything like that. The output is displayed as

     Error: failed: t7603.3 pull c2, c3, c4, c5 into c1
     ▶failure: t7603.3 pull c2, c3, c4, c5 into c1
     Error: memory leak logged in t7603
     ▶leak: t7603.3

and clicking on the '▶' lines expands the output, but there is nothing 
about the source file as far as I can see. Ideally, if the test is 
failing due to a leak, it would be nice to report that as

     Error: leak detected in: t7603.3 pull c2, c3, c4, c5 into c1
     ▶failure: t7603.3 pull c2, c3, c4, c5 into c1

and display the test output and LSAN output together when the 
"▶failure:" line is clicked, rather than having separate sections for 
the test output and leak output. Having said that what you've already 
implemented is a clear improvement so I'd be happy to take that if you 
don't feel like devoting any more time to it.

> Once a script has one leak, it keeps running: the sanitizer log
> directory is never cleared between tests, so every later test in the
> same script sees the same leftover log entries and also reports "not
> ok", burying the one real failure in copies of itself. Stop a
> leak-sanitizer script at its first failure with --immediate instead.

I think that is probably a welcome improvement though if two different 
tests have different leaks it would be nice to be able to show both.

Thanks for working on this, it makes the LSAN output much more accessible.

Phillip

> A failing test already gets its own annotation once its script
> finishes, but --immediate exits as soon as that test fails, before
> reaching the code that writes it. Write the annotation first, so
> turning on --immediate here does not silently drop it.
> 
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>   ci/lib.sh                            |  1 +
>   t/test-lib-github-workflow-markup.sh | 16 ++++++++++++++++
>   t/test-lib.sh                        |  6 +++++-
>   3 files changed, 22 insertions(+), 1 deletion(-)
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
> index fa29a62aa3..0d54496358 100644
> --- a/t/test-lib-github-workflow-markup.sh
> +++ b/t/test-lib-github-workflow-markup.sh
> @@ -28,6 +28,11 @@ start_test_output () {
>   	github_markup_output="${GIT_TEST_TEE_OUTPUT_FILE%.out}.markup"
>   	>$github_markup_output
>   	GIT_TEST_TEE_OFFSET=0
> +	github_markup_script_name=${0##*/}
> +}
> +
> +github_annotation_ () {
> +	echo >>$github_markup_output "::$1 file=$2,line=$3::$4"
>   }
>   
>   # No need to override start_test_case_output
> @@ -53,4 +58,15 @@ finalize_test_case_output () {
>   	echo >>$github_markup_output "::endgroup::"
>   }
>   
> +finalize_test_leak_output () {
> +	# The exact line the leak turned up on isn't known, only the script,
> +	# so point at line 1.
> +	github_annotation_ error "t/$github_markup_script_name" 1 \
> +		"memory leak logged in $this_test"
> +
> +	echo >>$github_markup_output "::group::leak: $this_test.$test_count"
> +	cat "$TEST_RESULTS_SAN_FILE".* >>$github_markup_output
> +	echo >>$github_markup_output "::endgroup::"
> +}
> +
>   # No need to override finalize_test_output
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1f0505e412..e74a12f1dd 100644
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
> @@ -822,6 +823,9 @@ test_failure_ () {
>   	say_color error "not ok $test_count - ${pfx:+$pfx }$1"
>   	shift
>   	printf '%s\n' "$*" | sed -e 's/^/#	/'
> +	# Write the annotation before either --immediate exit path below,
> +	# both of which call exit and would otherwise skip it.
> +	finalize_test_case_output failure "$failure_label" "$@"
>   	if test -n "$immediate"
>   	then
>   		say_color error "1..$test_count"
> @@ -835,7 +839,6 @@ test_failure_ () {
>   		check_test_results_san_file_ "$test_failure"
>   		_error_exit
>   	fi
> -	finalize_test_case_output failure "$failure_label" "$@"
>   }
>   
>   test_known_broken_ok_ () {
> @@ -1218,6 +1221,7 @@ check_test_results_san_file_ () {
>   		return
>   	fi &&
>   	say_color >&4 error "$(cat "$TEST_RESULTS_SAN_FILE".*)" &&
> +	finalize_test_leak_output &&
>   
>   	if test "$test_failure" = 0
>   	then

