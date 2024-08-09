Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22B624
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163854; cv=none; b=UkX5o0GHfZYYljJNCOPh0rWbxB54YEhvL+TPx+SW173MGXT9XVa85zI7KLe2mjtsTsoy1n4axTLrPcqUji6ib8pRaVe9BVs3kqQnkOrMw5aEDCPl2bLkgrVjYjSEgB1dAerOW2HOF71GyRNoMtGbmTEaZg/Tc3gGmnmDwh/0sUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163854; c=relaxed/simple;
	bh=GAYkLbGidfKszW22aSFzxiGcOA6qXlD5fUFsCbQKl3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fzVc673u391R5o5SN/oCbqz5xVqyUsgPYqi+rb7tHqZFeGMKlTeTrgJXKLODd0FwCznLVqNSNVjNIe0TaRBt5lzP5QtixB7ytvf9Zt+n2wzr5mnposEYNTa79HP78mn1T34A4B+cv15Ah2wZOefObek7A1D3QpOpnBGSjPd3uSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBgqYAHk; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBgqYAHk"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4281c164408so10910575e9.1
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723163851; x=1723768651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXyRh1bQX7Nwo86gDUTIcQhzuKCJhjHAX5zGbXYJ22A=;
        b=kBgqYAHkxHhngSmgIIBxPh61sXSP0HxXNBfS6tJEoh4cAqja4KXfVQuuhdSE6PFxXw
         YTmyEJ7GRQWshFmLZ9M2fUYgJF3v+Uc5rxPwH6nf0jsVM/5MotNcSOjUBjgTERGV//Y4
         +OtgLh1wEsGJIkOLt8pbwC5AY+2pWRqM41faHYxY7iAdUZxM7YI3B0Y7+PXLfjKXC+79
         2Ai8fXG31BcSG+9mPZzFgjTqksRVaKXwR0s3XvLonOuchS5J9LS5pvwGENifA5AHgtqG
         UsvZQzYedX3dGL/2hDkMWBhSbQKpNfWIf8oziK2m9RFyg9wyBmmgOQp63sphnD/iO0oN
         7mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723163851; x=1723768651;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXyRh1bQX7Nwo86gDUTIcQhzuKCJhjHAX5zGbXYJ22A=;
        b=UI+j35cunzIfl9flmf5MDet0TcHmvl/phBgixWFUR62jLmzRCUxRtKjKjkJQIf0DGE
         uiopcEXHW4bnYUQ97hxhKsqfJ7H4JEGzg/I+tMfhoqiJiacRaQcK00/T6AJjn3lnyEHG
         YPSb2gycBriHOQ3YHBSYxHvWGefAzlTDCGdZacVoFlUsM+3dV8ZNHeBo1pqdNsru9QqE
         gnyUWo4dSUzT5w/LnIfmZJZqoICHi7XAS4pTicfmjjwD6v4p8wvjBvhXaa0S+PWvBUc8
         EFY8WfM21amf/6MDV9/lq8MudUV9+/bTrpKv+oouzxrWmC0k0xZjegHTrs4gPmMteXu2
         aFrg==
X-Forwarded-Encrypted: i=1; AJvYcCXhCuQWxVz3pEaWaKXMhpmvCg40hUzuFLqvyEHYvsSXTOfg6CGf5IbE30JEbueZe47J9UgUQLYnf3PZmueatLIEPGeG
X-Gm-Message-State: AOJu0Ywf+6GYiHqapNxEd4valeceaSpGNfL2Fq4BviWRWWaSnfNiBlwH
	iBq46udy5m8KNU2NzvHsTfXzLOyT7is8Wg1GkJXQN94GQkjmMFZ3
X-Google-Smtp-Source: AGHT+IHJtff9Pa+hQReyIF25pL+OicjG+7wG+cSO3A6FhOb0EFXtq/rweRrxBjhqndpMkAtLf9qGwg==
X-Received: by 2002:a05:600c:1f93:b0:426:6618:146a with SMTP id 5b1f17b1804b1-4290ae998a8mr23829565e9.2.1723163850909;
        Thu, 08 Aug 2024 17:37:30 -0700 (PDT)
Received: from gmail.com (243.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2724d1besm3643059f8f.117.2024.08.08.17.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 17:37:30 -0700 (PDT)
Message-ID: <93e6fdd3-4a15-4cc5-929a-aa5e79f44e1c@gmail.com>
Date: Fri, 9 Aug 2024 02:37:29 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: drop use of 'tee' that hides exit status
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4j7uhfvm.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq4j7uhfvm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Aug 08, 2024 at 02:19:25PM -0700, Junio C Hamano wrote:
> A few tests have "| tee output" downstream of a git command, and
> then inspect the contents of the file.  The net effect is that we
> use an extra process, and hide the exit status from the upstream git
> command.
> 
> In none of these tests, I do not see a reason why we want to hide a

This double negative caught my attention.  The message is
understandable; perhaps "In none of these tests I see ..." would have
been clearer.

> possible failure from these git commands.  Replace the use of tee
> with a plain simple redirection.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t1001-read-tree-m-2way.sh | 2 +-
>  t/t5523-push-upstream.sh    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

A simple search only points to these two files:

   $ git grep '\s*git.*|\s*tee' "t/t[0-9]*.sh"
   t/t1001-read-tree-m-2way.sh:400:        git ls-files --stage | tee >treeMcheck.out &&
   t/t5523-push-upstream.sh:127:   test_terminal git push --quiet --no-progress upstream main 2>&1 | tee output &&
   t/t5523-push-upstream.sh:134:   test_terminal git push --quiet -u --no-progress upstream main 2>&1 | tee output &&

And the following three changes are in line with the result:

> 
> diff --git c/t/t1001-read-tree-m-2way.sh w/t/t1001-read-tree-m-2way.sh
> index 88c524f655..48a1550371 100755
> --- c/t/t1001-read-tree-m-2way.sh
> +++ w/t/t1001-read-tree-m-2way.sh
> @@ -397,7 +397,7 @@ test_expect_success 'a/b vs a, plus c/d case setup.' '
>  
>  test_expect_success 'a/b vs a, plus c/d case test.' '
>  	read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
> -	git ls-files --stage | tee >treeMcheck.out &&
> +	git ls-files --stage >treeMcheck.out &&
>  	test_cmp treeM.out treeMcheck.out
>  '
>  
> diff --git c/t/t5523-push-upstream.sh w/t/t5523-push-upstream.sh
> index 1f859ade16..4ad36a31e1 100755
> --- c/t/t5523-push-upstream.sh
> +++ w/t/t5523-push-upstream.sh
> @@ -124,14 +124,14 @@ test_expect_success TTY 'push --no-progress suppresses progress' '
>  test_expect_success TTY 'quiet push' '
>  	ensure_fresh_upstream &&
>  
> -	test_terminal git push --quiet --no-progress upstream main 2>&1 | tee output &&
> +	test_terminal git push --quiet --no-progress upstream main >output 2>&1 &&
>  	test_must_be_empty output
>  '
>  
>  test_expect_success TTY 'quiet push -u' '
>  	ensure_fresh_upstream &&
>  
> -	test_terminal git push --quiet -u --no-progress upstream main 2>&1 | tee output &&
> +	test_terminal git push --quiet -u --no-progress upstream main >output 2>&1 &&
>  	test_must_be_empty output
>  '
>  

Looks good.

Thanks.
