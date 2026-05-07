Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115B1E9B35
	for <git@vger.kernel.org>; Thu,  7 May 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170104; cv=none; b=R6I7vvUgBF9GsWFWcJTrsUP41nIwqs8/VNhuufe6UtQnc4gDY1DMl0FQu+haA2c7Yybe4VzdFN/+PCbmJAzTWqAyd+ypt08myQIPzmyuotdRHdSijYweFDvAVU8rdFi56Qn8EHQepkwwmLOH3NdLytJTh6/NhEY5VbQMQsskXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170104; c=relaxed/simple;
	bh=2aEVWL8G+xD+y3ujvCQ+ma7LRJkc71UIKAUwYcWWYsQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HpLpNTOcqDLDezWFf/OnExEBMvWO0DMBC/TXdiks4Wbr7TM7JZrTveN3m27AXgvHkvo5njlvTscWkA5k9b7vxgsp74DSa3JAwYCc+f9b9Zrz/6NFCJTnAEUmd7yYQmHm+Y0mr94v+y/ju+pVuEK18ArQ4/SX84xlRwjnowyIPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsRHJAyG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsRHJAyG"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so169244866b.2
        for <git@vger.kernel.org>; Thu, 07 May 2026 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778170102; x=1778774902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnPJwiMXrDYsQP/+W+5xKj1uQGrpr07z/Obm4pyL2lA=;
        b=WsRHJAyGan5oMHP5M5NWXypiXygQjvW50rBjnvohAt7DFimE92mOEGT7mNUYLSqDHF
         PPEslxu7PrIbJ2RFov7XpxIHMbyq21UAIR6KiKsHPw9Pfeo/fdPDuNjDYXtgh99XcFTn
         pqSdVBoGqU1KU9QDiF6wETqvZHoU4VqLGHwxMllrac6OHyB8+YjIcSdIA+PYteeSGl2o
         NE/7wWcKus2lV9xExyBmo43lCC035GGbAeGZmimeHmH0QMEuVe/QpOSZCxAY+VTOa2R0
         zR7z807T0v4Q+d+mN2sqgDAplxFRnxtvWmhz+zFvxlFfe34O/yvBpqLiLa5ouysKuPxG
         oLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170102; x=1778774902;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnPJwiMXrDYsQP/+W+5xKj1uQGrpr07z/Obm4pyL2lA=;
        b=aQ/cpWqYUUvWyyokfWye6IQHMXT6L3tVV3Mw9lJYCb/AqvayEDqCmBdVmYd4A/Hepz
         ycuPLevDwON/UapUIcigDkMkE1J613sTf8fdc2zH7900MSn7aNs4w1NzibK/UA2VaCsM
         4UoNt/r2NDixuss9+c/AJhHde/k950qaBPZ7pqrkBf+KwbbArXncxoMKmpTCj5d2gRGu
         +9tD7PhsstBPMAP8Sx0rcTU4ONp1MjhqPWDqHM34KHgZiIjEWx2QiVODASVByrdDFGNy
         sfxmP4taiNbmcbL3MklOnpANH3QltFtlCGP82F/mGFdITgo6OasWxIBtXTsNjnE7oPFn
         KT2g==
X-Forwarded-Encrypted: i=1; AFNElJ8/3ebTj8mUu+FFr3WqDt5+vtkHKVvXQcYcg2SztHqHEaycJvsG2qUsrxV65J0a0/u5PS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxd94VjtnGbjdeltfnxVbgzw7+450DRTABAaNjWJzylDQTFIp
	tt0ZZK+pegNEY4tYsr+vN+O4RE0UBu14NFzfKXTDzbJJ8CY3GGY7NE5U
X-Gm-Gg: AeBDieua09exj7qrWgwTSUtvOusWu2vYPnDttFnWXyLkv1pD9KV1dbMmSMBNohDX3vB
	nM7WBXTQWXTXC5ojd3mwTy8YAnO+O5lQCthiS8zKWir3+ulWUwM31IA/NCfshzDrtBe/HVsy6/P
	WKRHt0ak+yeX5qJx5iw9cAXNZQF/cvzGClfjr/0pq86YH+vB1WFAG2N4Vjg7l7G2Jgy4drG4Pu3
	hccS7O5/NJH9jsCsEAWmaM4DRlKfJm2V9bytUWZ60OwSly5f2G7KcfasyYZZDzSk2w4cq4H7xmp
	hos8zHJrXRDFYH1cb4bwFB05q3FjHqP947UnE8xY4hQ8cpw5Ans/sjbaXQA8pURZYlpfBQfjGzl
	oi1i5/T3zlWxJEGzlxdIbTncv5wgMT9pdmvG4SR4vPvo2OiOTI+2a09vxEbe4Zt67f2buZW5oYo
	N+LizcXL7N9u5wUorwdA+B3vyH9/JK7evckAIkxaLqQMtyGkiaq365E0AQ15VYqoBagVwZHIt3p
	ofrdETEdwQ3+6RXxtwzhg==
X-Received: by 2002:a17:907:ea7:b0:ba6:8f34:b419 with SMTP id a640c23a62f3a-bc56ae27aa7mr506946166b.13.1778170101096;
        Thu, 07 May 2026 09:08:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:bd41:1f83:652f:1d59? ([2a0a:ef40:76d:4c01:bd41:1f83:652f:1d59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca548d1bfasm4300766b.27.2026.05.07.09.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 09:08:20 -0700 (PDT)
Message-ID: <dc7c32f7-d56e-4dd6-977e-cced6155e758@gmail.com>
Date: Thu, 7 May 2026 17:08:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] rebase: ignore non-branch update-refs
Reply-To: phillip.wood@dunelm.org.uk
To: mail@abhinavg.net, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260506023944.90691-1-mail@abhinavg.net>
Content-Language: en-US
In-Reply-To: <20260506023944.90691-1-mail@abhinavg.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Abhinav

On 06/05/2026 03:39, mail@abhinavg.net wrote:
> From: Abhinav Gupta <mail@abhinavg.net>
> 
> The following Git configuration breaks git rebase --update-refs:
> 
>      [rebase]
>          instructionFormat = %s%d
> 
> The '%d' format requests all available decorations for a commit,
> filling the global decoration table with all of them,
> which --update-refs then uses to populate 'update-ref' instructions
> in the rebase todo list.
> 
> Specifically, this results in the following instruction:
> 
>      update-ref HEAD
> 
> The todo parser then rejects the instruction:
> 
>      error: update-ref requires a fully qualified refname e.g. refs/heads/HEAD
>      error: invalid line 3: update-ref HEAD
> 
> To fix, ignore decorations that are not local branches
> when scanning through the table.

Thanks for the clear explanation, the solution makes sense

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 3e44562afa..d58236f0eb 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1960,6 +1960,28 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
>   	)
>   '
>   
> +test_expect_success '--update-refs ignores non-branch decorations' '
> +	test_when_finished "git branch -D update-refs" &&
> +	test_when_finished "git branch -D third" &&

I'm not sure that we really need to create this branch in the first
place. We already create update-refs from no-conflict-branch so we can
check that no-conflict-branch appears and update-refs does not. In
addition to checking that HEAD does not appear we should also check that
we don't try to update any tags (HEAD matches tag M). I think the
simplest way is to check the output of "grep ^update-ref todo" so we'd
have

test_expect_success '--update-refs ignores non-branch decorations' '
	test_when_finished "git branch -D update-refs" &&
	test_when_finished "git checkout primary" &&
	git checkout -B update-refs no-conflict-branch &&
	(
		set_cat_todo_editor &&

		# rebase.instructionFormat=%d loads normal log decorations before
		# --update-refs adds its branch placeholders so we must ignore
		# all non-local decorations.
		test_must_fail git -c rebase.instructionFormat="%s%d" \
			rebase -i --update-refs HEAD^ >todo
	) &&
	grep ^update-ref todo >actual &&
	test_write_lines "update-ref refs/heads/no-conflict-branch" >expect &&
	test_cmp expect actual
'

Thanks for working on this

Phillip

> +	test_when_finished "git checkout primary" &&
> +	git checkout -B update-refs no-conflict-branch &&
> +	git branch -f third HEAD~1 &&
> +	(
> +		set_cat_todo_editor &&
> +
> +		# rebase.instructionFormat=%d loads normal log decorations before
> +		# --update-refs adds its branch placeholders.
> +		# The placeholder scan must still ignore symbolic decorations,
> +		# because "update-ref HEAD" is not a valid branch update.
> +		test_must_fail git -c rebase.instructionFormat="%s%d" \
> +			rebase -i --update-refs primary >todo &&
> +
> +		test_grep "^update-ref refs/heads/third$" todo &&
> +		test_grep ! "^update-ref refs/heads/update-refs$" todo &&
> +		test_grep ! "^update-ref HEAD$" todo
> +	)
> +'
> +
>   test_expect_success '--update-refs updates refs correctly' '
>   	git checkout -B update-refs no-conflict-branch &&
>   	git branch -f base HEAD~4 &&
> 
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0

