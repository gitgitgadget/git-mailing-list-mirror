Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A6BC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 09:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiKNJyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 04:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiKNJx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 04:53:59 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D06376
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 01:53:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso7464416wms.4
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UDiXWV46+LkWqRoUMj8QYtoaRcrq6ojQUUj/Z+HaRE=;
        b=fiqtLJqHxTb1QgyyLBpYEVDxPzZXspg8+T/zwMIRDB2A0TJvlBWeXqQXr+fxLI26+n
         5Crw0wPRUE/J5jFLoPfoOSVEMgWUfyNLoRrR84mIaoyndH0tvDjOPkQT8/bVT35tGUor
         RdeBZyWpmTTXJFtAx5EO9AkqLxhR4jebu0EIfqb5glpS6wDUpA8FdLbQ/6fbozvjHRCS
         IeQ8oqzYE1R5KwFArCt4UU7P04VGxAb8nyRDzuIsfbfAd7h7gbwHqSh+UQmdvEPj9fzJ
         yt2io9qxAGy5nec7nUUQHOvmP7eSQ9LeTs3trXOQulf3pozycHLUeDXST9ANrJdxNcIY
         4UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UDiXWV46+LkWqRoUMj8QYtoaRcrq6ojQUUj/Z+HaRE=;
        b=8ID7e2KDIBZfuYtG2nvPbbNcgMc51ygPCx5V3CPy7DZSwdzOdLakLvc/weAqKk+mJU
         g3l0bf70dPOfs60HomQG7FoKzyDXzlrKSe7Rlg4o3IU/rdH2QJ1EOqLnKHINvNdtLSsj
         4GrbmrEjjzIH07sLGe2XNRbvidZYcncSiTrbfrTqMkCLjjnZWtslBdPk43MibYVaoyE+
         votw+gjiUxmOYj63j/vwxjRRjxSBNAP2zHaohAUBPA7Mmh1umGpsbfM1yXztcLuWZdjf
         v2fX8uAi0cLaNMjPUWz5EimSbeLVlCx8B6Ur3E9sXK/y/C28mWMvvqdoJlfoaUHy2YiU
         xZxA==
X-Gm-Message-State: ANoB5pmIC+Kix7ABvMRhCSWlSuIfdPQqZx6DIBTBwv10/6p1y5f/VSLV
        iQq77NUNSROxVDqyc6e5Uoo=
X-Google-Smtp-Source: AA0mqf4EVt3/Teyi7UFcE/T2GkMsYlLhXQy/Q7zbObT8TtjBTRMGS4udeCJloAYQaKLH2yDKLrM2eQ==
X-Received: by 2002:a1c:2581:0:b0:3cf:d18d:3bfe with SMTP id l123-20020a1c2581000000b003cfd18d3bfemr7136263wml.203.1668419632333;
        Mon, 14 Nov 2022 01:53:52 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id r7-20020adfce87000000b00236488f62d6sm9207671wrn.79.2022.11.14.01.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:53:51 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8ec8f3f5-0827-25a3-464d-638378b65ddb@dunelm.org.uk>
Date:   Mon, 14 Nov 2022 09:53:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
 <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
In-Reply-To: <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 12/11/2022 22:07, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> It is more performant to run `git diff --no-index` than running the
> `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
> Windows uses. And a lot more readable.

This makes me wonder about the implications for our diff tests. We have 
~200 calls to `test_cmp` in t*-diff-*.sh. I had a look at 
t4053-diff-no-index.sh and non of the tests that use `test_cmp` look 
critical for functionality that is used by `test_cmp` and there are 
tests for the exit code. I suspect that if `diff --no-index` breaks 
we'll end up with confusing test failures rather than misleading passes.

A side effect of this change is that on windows `test_cmp` will now 
except directories as well as files but I don't think that matters.

> Note: Earlier attempts at fixing this involved a test helper that avoids
> the overhead of the diff machinery, in favor of implementing a behavior
> that is more in line with what `mingw_test_cmp` does now, but that
> attempt saw a lot of backlash and distractions during review and was
> therefore abandoned.

Hopefully most of the files we feed into `test_cmp` are small enough 
that the absolute difference in run-time is not too big. There is an 
optimization for -U0 that trims the common tail from the files before 
calling xdl_diff() but that does not help here because we need to use 
--ignore-cr-at-eol (otherwise `git diff --no-index -U0 || git diff 
--no-index` might speed up the common case of matching files).

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   t/test-lib-functions.sh | 66 -----------------------------------------
>   t/test-lib.sh           |  2 +-
>   2 files changed, 1 insertion(+), 67 deletions(-)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 8c44856eaec..452fe9bc8aa 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1541,72 +1541,6 @@ test_skip_or_die () {
>   	error "$2"
>   }
>   
> -# The following mingw_* functions obey POSIX shell syntax, but are actually
> -# bash scripts, and are meant to be used only with bash on Windows.
> -
> -# A test_cmp function that treats LF and CRLF equal and avoids to fork
> -# diff when possible.
> -mingw_test_cmp () {
> -	# Read text into shell variables and compare them. If the results
> -	# are different, use regular diff to report the difference.
> -	local test_cmp_a= test_cmp_b=
> -
> -	# When text came from stdin (one argument is '-') we must feed it
> -	# to diff.
> -	local stdin_for_diff=
> -
> -	# Since it is difficult to detect the difference between an
> -	# empty input file and a failure to read the files, we go straight
> -	# to diff if one of the inputs is empty.
> -	if test -s "$1" && test -s "$2"
> -	then
> -		# regular case: both files non-empty
> -		mingw_read_file_strip_cr_ test_cmp_a <"$1"
> -		mingw_read_file_strip_cr_ test_cmp_b <"$2"
> -	elif test -s "$1" && test "$2" = -
> -	then
> -		# read 2nd file from stdin
> -		mingw_read_file_strip_cr_ test_cmp_a <"$1"
> -		mingw_read_file_strip_cr_ test_cmp_b
> -		stdin_for_diff='<<<"$test_cmp_b"'
> -	elif test "$1" = - && test -s "$2"
> -	then
> -		# read 1st file from stdin
> -		mingw_read_file_strip_cr_ test_cmp_a
> -		mingw_read_file_strip_cr_ test_cmp_b <"$2"
> -		stdin_for_diff='<<<"$test_cmp_a"'
> -	fi
> -	test -n "$test_cmp_a" &&
> -	test -n "$test_cmp_b" &&
> -	test "$test_cmp_a" = "$test_cmp_b" ||
> -	eval "diff -u \"\$@\" $stdin_for_diff"
> -}
> -
> -# $1 is the name of the shell variable to fill in
> -mingw_read_file_strip_cr_ () {
> -	# Read line-wise using LF as the line separator
> -	# and use IFS to strip CR.
> -	local line
> -	while :
> -	do
> -		if IFS=$'\r' read -r -d $'\n' line
> -		then
> -			# good
> -			line=$line$'\n'
> -		else
> -			# we get here at EOF, but also if the last line
> -			# was not terminated by LF; in the latter case,
> -			# some text was read
> -			if test -z "$line"
> -			then
> -				# EOF, really
> -				break
> -			fi
> -		fi
> -		eval "$1=\$$1\$line"
> -	done
> -}
> -
>   # Like "env FOO=BAR some-program", but run inside a subshell, which means
>   # it also works for shell functions (though those functions cannot impact
>   # the environment outside of the test_env invocation).
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 7726d1da88a..f8c6205e08f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1546,7 +1546,7 @@ case $uname_s in
>   	test_set_prereq SED_STRIPS_CR
>   	test_set_prereq GREP_STRIPS_CR
>   	test_set_prereq WINDOWS
> -	GIT_TEST_CMP=mingw_test_cmp
> +	GIT_TEST_CMP="GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol --"
>   	;;
>   *CYGWIN*)
>   	test_set_prereq POSIXPERM
