Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C640B116
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835930; cv=none; b=ihDliHp42/7W0azo9MmFIibTXvOqjS61Dv/4JG3lrAAkvC88o6G6NiK6WyDDE6M6WNTY6xnfDwlKAfk3iBLqfZNEGSa4/dCx/GOpakhXAIxwY5nxbuPLk0Umv60anLpXgObrXUmcKSG1/lNMWH+EV4EL4UGFGPS4/wTUOxJkMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835930; c=relaxed/simple;
	bh=NDHgwgtTLQQ3Y9fDHUkaYKTTSv9H+mx5xfSmmKzepgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWRwZOMB36gKVc2TxrBX15bTaV7A6Gpr+96pdcTfd4FbSXP+ExJxNaoqzLbCuldToNRGPeuNnJzpDfYIW/M2cn/s5v6vE/9RNVxzW6HHtmn/9NiXYDMlNdrHPjHYTeIn7fh4LsNAIPoz8LJNdwsTzdaq7DhJHPqXzG/8uP/ywOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL7O4Dco; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL7O4Dco"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso3211888a12.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787835914; x=1788440714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWtpe39jY37KwtNrVkAa6PBvcrBWe13JYA66GANCNxg=;
        b=NL7O4DcohK6nNxdKq+1C7V8d6wdnwpnJz630emYqEgE358OCrYzOqYV2LgIxYQqTx1
         /+DjUH8U0iNLaJBwnSfQTg85MVlGgNGgKI2ZFlFVf6NkpY6Fbv2yqyUBiglEsEd0dSH2
         rPPbKuMEX1Lh1iolO9N+HL6ReKmOFjqsw1jF4kHNHHH/fQ4Wfo4duZV1YhEY1HYlubpL
         MyC0Gsqy5BWASaCU4Cums1KaZJL7jpsuJtdc74e5U+roYgS8HbCU7DlLloqLOuGexHqc
         urTztfyBnBqdCYkYnu2+syo4DQEEIs5maXfOifKnFvb97sb59vTFUw17+u9ZLPlKGu/j
         pifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787835914; x=1788440714;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWtpe39jY37KwtNrVkAa6PBvcrBWe13JYA66GANCNxg=;
        b=mzOANjfX/6dJ+9FIp6+mQJwsuqg3uediipU1VjwtZLzuqCHMgB9uVHxuGitUyh7D48
         KXTyWe2JfTE/eZL/fR+g5uOsgVtqdEO9ex1a2pgEhAB0dM+bgQhSLOoyqhHxltgR4iBO
         sdQtIqczTkjmMnJnjRp/Yc0Q7tU/OdH+brCOw4NjKTQbYmghJUAUwG2+IOnc9Ae06N3A
         ae4jAO4bdMAxYT1p1NxSXoVDWMUVEsUbweaffrAWaiTsklLJIcyMgri7178nVlzHFnA9
         DNsLfR+XuFfcw8iouJq1u+OybXGXE3Nw7tXhd39u6QI5PcJDlRcA7crYC8HcdkgHi93D
         Vv9w==
X-Forwarded-Encrypted: i=1; AHgh+Rpr8nDYEU/np0mi0ShknAtQ7zw47GOhE0qjSIJdgG1uvOyllSbkbRB6SYIHEy35uiVTOns=@vger.kernel.org
X-Gm-Message-State: AFuF++luXAk42jINMFO+OpPauoEiCmWYJjDAkv04E7gQ/8L/q95puujh
	9vf1GGz6PEZO7xSphxnSdoXcByEoLCIPvG1lEaNZBri81h3s5qKrtEZt
X-Gm-Gg: AR+sD12qtLeZUDEiDMMfheQhwKI740vlJshQpjrdJqFdWquAFKpw8uLC1cPLy4vdfmt
	oZeTsoZ7fimpHJEu3ujAiBhbCMyAlqNDG4WWM8fWmaO8kmcZiGJlFFo9FF/UXod0XDSgbOTdGuk
	Mn4Gsq/C9VPjnFbc9vmn52c959KRphB6fQOEWITgtlzAvMQUBXkibA2jpz9UzdOhqrZTv4r/Ce8
	nAQemf0btYJWg32JSyJlf+GLwcpvnlzbgaFPvbosbqlsEf9HSJiLO8MTSne+1xggB1lkasLRGTO
	CdrEDBdVUpInxMFiSU2dBk0d22Ee1QzA+yTMxwl55WJ6odjfJULC75rp4XYEzTPe5A+QVto6z4q
	dt+FTdRToCdaUuCGb9HWFtmN7CTCYJBrKF5gjEoJ6bXnjS173fFb3qrAVWIfcQ4+RUZtdsWHf4N
	5p6uwyFSRX2dQdyAvoSRpGZLlHdwToMK+V3T9M0oEXxjobibOCYNsr4AvDj6SKiETS3uiG8r3eI
	kgw3WFFfTKYTtH1NgMKZY176/gLQ1PlBWbL88uGkxnffNz33Eg=
X-Received: by 2002:a05:6402:458a:b0:6a3:fee5:adcf with SMTP id 4fb4d7f45d1cf-6a5df5e1a14mr17670340a12.1.1787835913690;
        Thu, 27 Aug 2026 06:05:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:8486:9ada:868f:4693? ([2a0a:ef40:17bb:9901:8486:9ada:868f:4693])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5de8d1188sm6494856a12.7.2026.08.27.06.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:05:13 -0700 (PDT)
Message-ID: <28428451-8a56-43be-8ee4-af5a704977a9@gmail.com>
Date: Thu, 27 Aug 2026 14:05:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] checkout -m: refine autostash fallback
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <37becf38c2ef175a3dadcf750e2cca836942d83e.1784993669.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <37becf38c2ef175a3dadcf750e2cca836942d83e.1784993669.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 25/07/2026 16:34, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> When unpack_trees() fails under "git checkout -m", only create an
> autostash and retry if there are tracked local changes.  Without such
> changes, the fallback cannot help and merely repeats the same failure.

Unfortunately to do that we have to look for local changes before the 
first call to unpack_trees() so we're trading an occasional 
inconvenience of an unnecessary stash and unstash for the cost of 
looking for local changes on every invocation of "git checkout -m". I 
don't think that is a good trade off, especially as there is no 
guarantee that stashing the local changes will make unpack_trees() 
succeed. To do this effectively would require refactoring unpack_trees() 
to write its error messages to a buffer and return an error flag that 
indicates all the errors that were encountered. We could then check if 
the only thing that prevented upack_trees() from succeeding was local 
changes to files and stash them, or if there are other errors print the 
error message. I suspect such a change is far from straight forward.

> Use the conflict result from apply_autostash_ref() to print a blank line
> before the branch-switch message, visually separating it from the
> conflict advice.


This change is very welcome and could happily be squashed into the first 
patch as it motivates the changes in it.

> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 0ddd1ad7aa..f9696dab36 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -240,6 +240,14 @@ test_expect_success 'checkout -m creates a recoverable stash on conflict' '
>   	test_grep "git stash drop" actual &&
>   	test_grep "git stash pop" actual &&
>   	test_grep "The following paths have local changes" actual &&
> +	sed -n "/apply the local changes later/,/Switched to branch/p" \
> +		actual >separator.actual &&
> +	cat >separator.expect <<-EOF &&
> +	apply the local changes later by running "git stash pop".
> +
> +	Switched to branch ${SQ}side${SQ}
> +	EOF
> +	test_cmp separator.expect separator.actual &&

I wonder whether we should just bite the bullet and check what gets 
printed to the screen with test_cmp, rather than grepping for all these 
separate parts of the message. Is there something in the message that 
makes that difficult?

Thanks

Phillip

>   	git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual &&
>   	sed /^index/d actual >actual.trimmed &&
>   	cat >expect <<-EOF &&
> @@ -262,11 +270,18 @@ test_expect_success 'checkout -m creates a recoverable stash on conflict' '
>   	git reset --hard
>   '
>   
> -test_expect_success 'checkout -m which would overwrite untracked file' '
> +test_expect_success 'checkout -m only retries untracked-file failure with local changes' '
>   	git checkout -f --detach main &&
>   	test_commit another-file &&
>   	git checkout HEAD^ &&
>   	>another-file.t &&
> +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/trace" \
> +		git checkout -m @{-1} 2>err &&
> +	test_grep "untracked working tree files" err &&
> +	grep "\"region_enter\".*\"category\":\"index\",\"label\":\"refresh\"" \
> +		trace >refresh.events &&
> +	test_line_count = 1 refresh.events &&
> +
>   	fill 1 2 3 4 5 >one &&
>   	test_must_fail git checkout -m @{-1} 2>err &&
>   	q_to_tab >expect <<-\EOF &&

