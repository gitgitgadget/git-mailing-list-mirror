Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9DF1DA4C
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313653; cv=none; b=IhMzwluBNYH8mLHUpCwU84CBmB61obqn57rZfaPKWmgmrbBsWr6Kda+PKTNr+QZ/CxbVmWwIHTPj89k77RZcnvE0wTMxKC4801TzJtHja9T7nQxLWm8FXHZ8wLNkMysHWSFlc5fKW5/BQDvyhkwS0JM0n7xlvQKMuKxPWjH1Tyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313653; c=relaxed/simple;
	bh=2gIpSc1MeZghd1NREVGhKGOowc9vYFWYqeJpShURELc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8DxsrngvFDjuhQIfljUbUjbkRPy2SCxgQkIw1vR4lEE01nU0L7xohnd6RghnU/a1QeO8v3BLEhsg+JXuk/K2Un7gmevjCoRCZZlWxwF6/qV66l6eyUZB2tB7WX4CDec9NodrvydrRupWAaXSHId3CUc+cQJzsiDYpc6QLH1Jiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFe91+UO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFe91+UO"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fad0f66d49so68135161fa.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728313649; x=1728918449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uUkxkrKPjWy7lOW3xi6VbTbZWxG9F/OvUCBLhpqb/OE=;
        b=aFe91+UO4c50xKyiwSmMsodpp1Gr8VfiWMTCl8D+fvsNDAXiqaJdMuHDF2bO25qgtf
         4VCQq7eM/ZQMZLJrUUJ38k2A7Id5VScPGjfXyZMGRfz8orSsOGCx44wIJKg+nV8tpRMq
         Zo08yff+kgffurQYtqpL3xXaYDKZ9PcfmtEYq+pzQuighD3u0SyzT+1imiZfdVlDhaea
         bw//7UhTT+p3wwZWs/DKQ8LcTyyguw3KRpN+PmLmRZUPZNqij0bdd7THhix4vgGKIO6Z
         UOH2exd3BCZCNkiZ+gReILd/S71PlC3IcfhBITUBQhun5lbwXxOo2u4rQNEid8hvAxcz
         hElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728313649; x=1728918449;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUkxkrKPjWy7lOW3xi6VbTbZWxG9F/OvUCBLhpqb/OE=;
        b=tsRydq5PjSNvDXtMOzn23plN2ug30jLWsEPQ/3c+POnq+e698SyymRLoTIoA21yLQV
         vvwaI5QetRh8OMmdb3e06DOgEj21NCM04gP6V186ZOAiyrAuu/OKuWoOQsuQU5kiR/r9
         /6GnxFCUIIwjW6mqammtJ9nhV5dKZ2QeNFO95uzyOryibL6U2+pT+lLSKSpJSJlIIZMI
         ERPmsv8ImQ2HxRHp0ir7IrykmZHKGhcQAL75lm7Tz2zBqSRzn351QIDWxl4SXG9b1LEW
         Cz3CUn8SPv7NBpa1V4q43FB0PQszQ7SEYOwl+4rsRBZREPruStvCn3r5y+WjnzMJb+/W
         zN8w==
X-Forwarded-Encrypted: i=1; AJvYcCU3kzQ+0v7tcclSnPMtYn7W+N8u2yn/LYv4431Gh286Hnv1g8t5PD+y3GAC/HvC7PUdXhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWEMiuQ01/gxvqxNOLFe9wrpUTF9WoCvZHJM6i56w43ZnFpxV
	ZAeqA1MKRPyCq/VxoNld8MPGgL4GKdqJItxYx657NdBXryJiv1mM
X-Google-Smtp-Source: AGHT+IG+6lel+l8maMtShmvvWL6AQn8FwzvC4b2W0DvCqFVsSz9sYfQ5cyboZeTr90xRjpxaBJ26Wg==
X-Received: by 2002:a05:6512:3e0a:b0:536:56d8:24b4 with SMTP id 2adb3069b0e04-539ab859f0cmr5913299e87.5.1728313649194;
        Mon, 07 Oct 2024 08:07:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f7bf7b8sm192762266b.66.2024.10.07.08.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 08:07:28 -0700 (PDT)
Message-ID: <4f79f144-9f48-4fbe-b646-2d146e57606a@gmail.com>
Date: Mon, 7 Oct 2024 16:07:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 2/2] t3404: employing test_line_count() to replace test
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
 <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
 <b3d3deced25f038defe6afe7d474350464328299.1728299466.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <b3d3deced25f038defe6afe7d474350464328299.1728299466.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Usman

I missed this when I read the earlier version of this series but our 
commit subjects use the imperative so we would say

     t3403: employ test_line_count() to replace test

or

     t3404: replace test with test_line_count()

I agree with Patrick that we should let this series settle for a couple 
of days to allow others to comment before sending any new version.

This series is looking good, congratulations

Phillip

On 07/10/2024 12:11, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> Refactor t3404 to replace instances of `test` with `test_line_count()`
> for checking line counts. This improves readability and aligns with Git's
> current test practices.
> 
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>   t/t3404-rebase-interactive.sh | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 96a65783c47..2ab660ef30f 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -281,8 +281,9 @@ test_expect_success 'stop on conflicting pick' '
>   	test_cmp expect2 file1 &&
>   	test "$(git diff --name-status |
>   		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
> -	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
> -	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
> +	grep -v "^#" <.git/rebase-merge/done >actual &&
> +	test_line_count = 4 actual &&
> +	test 0 = $(grep -c "^[^#]" <.git/rebase-merge/git-rebase-todo)
>   '
>   
>   test_expect_success 'show conflicted patch' '
> @@ -401,8 +402,8 @@ test_expect_success 'multi-squash only fires up editor once' '
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
>   	git show >output &&
> -	count=$(grep ONCE output | wc -l) &&
> -	test 1 = $count
> +	grep ONCE output >actual &&
> +	test_line_count = 1 actual
>   '
>   
>   test_expect_success 'multi-fixup does not fire up editor' '
> @@ -416,8 +417,7 @@ test_expect_success 'multi-fixup does not fire up editor' '
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
>   	git show >output &&
> -	count=$(grep NEVER output | wc -l) &&
> -	test 0 = $count &&
> +	! grep NEVER output &&
>   	git checkout @{-1} &&
>   	git branch -D multi-fixup
>   '
> @@ -436,8 +436,8 @@ test_expect_success 'commit message used after conflict' '
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
>   	git show >output &&
> -	count=$(grep ONCE output | wc -l) &&
> -	test 1 = $count &&
> +	grep ONCE output >actual &&
> +	test_line_count = 1 actual &&
>   	git checkout @{-1} &&
>   	git branch -D conflict-fixup
>   '
> @@ -456,8 +456,8 @@ test_expect_success 'commit message retained after conflict' '
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
>   	git show >output &&
> -	count=$(grep TWICE output | wc -l) &&
> -	test 2 = $count &&
> +	grep TWICE output >actual &&
> +	test_line_count = 2 actual &&
>   	git checkout @{-1} &&
>   	git branch -D conflict-squash
>   '
> @@ -501,8 +501,8 @@ test_expect_success 'squash ignores comments' '
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
>   	git show >output &&
> -	count=$(grep ONCE output | wc -l) &&
> -	test 1 = $count &&
> +	grep ONCE output >actual &&
> +	test_line_count = 1 actual &&
>   	git checkout @{-1} &&
>   	git branch -D skip-comments
>   '
> @@ -519,8 +519,8 @@ test_expect_success 'squash ignores blank lines' '
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
>   	git show >output &&
> -	count=$(grep ONCE output | wc -l) &&
> -	test 1 = $count &&
> +	grep ONCE output >actual &&
> +	test_line_count = 1 actual &&
>   	git checkout @{-1} &&
>   	git branch -D skip-blank-lines
>   '

