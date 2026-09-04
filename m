Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7775844213B
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515863; cv=none; b=bW7W1po8FV+zSSt4yIgV+yzw8OZ/miw07amFWJna8vH4e+AjkowtEXeN7CBHiabwRBFJpYfJyJa7Yo+9oFrPrONIZlD1tAYcV/3DX4Z8yCTN8/zUiri0Jeu+sxb+EwqA9nUa124DDjMgn2wLrg2n4P6Nli91dOOzowfP6EUp41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515863; c=relaxed/simple;
	bh=/gFMC+fTtiltmvHFfcVQka8u8QqfGemjt8nVQPmVI/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HFDEzdhJF3HY83T1PoU31W9c/8fOaxkdA5u0vJoKNxiGv1btFBLmjVRyO3sNChFjC10GVzUsWFaRIZDF1ILe1TUIDYSy9X7d85/RYptsVJd1suj9Nxzqtg5xV2QdIVaq1AeQoLbOiaLNnY5LuiIvnm6H8uStM3JPc+GeRoaIAt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6gFfOJP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6gFfOJP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so8617055e9.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 02:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788515859; x=1789120659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t3FggJiznuKGgT8fnHPi6oQMznnLfiuF2qESgTYpNjA=;
        b=l6gFfOJPHCuSaH00TCr3vVGLMRP6WUh8VQ/iCF/DW3PlToKz1uDK4yR3H76LqsMFXg
         +1viZPVWZIPW3uWduhzO00k8rwYu0LMFuwr2lXM3Ug8NrvNNYW2InttYTrq++rZIOEso
         JSmPNPgww9J6H5HWCTGKzSNUVYeUlkVws6WdTjzmsyDWxdBp7KTmSCOIo5SfJDyugICn
         t4qvm57vmJAVHBXQm6ThKz1R0G3Aa801Qa7aZSdhOjgnIyr9Kb8mxXSdaDgFxWSi3LPL
         0Noim0WWzYmdv5sqBZaayRVaMKJs4fGAlOZ9rinn3t/wi3jXT9ttu/PQ3jwj/QWXXRUS
         tndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515859; x=1789120659;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t3FggJiznuKGgT8fnHPi6oQMznnLfiuF2qESgTYpNjA=;
        b=lj+wI++y1Uv2ySWVVhtTLmISJjSMOx98rOzXUXkXG55bcw6QqqQ545oZzTxIEloPc7
         n/5KAMS7W8nFRgiNW85p3dNzdwY0T1WgTpi+lz4PVrlvQ/010wG6jj8fRZpaqjiwNLYC
         jf9PvJMNOaZww86cDXgRi3mA9C6pBrA9fiwL6yeZE0rAhTkTTYaxEK4KCPhWZpg5Z8FV
         ZxreKQQM3A8iHr08Fmhx+h/cofsMHuhcxpB+rJ8I/8ywvrZF4o7NbnOuwxdEalUKFLu9
         P4FmUgN+52Vlom4JZ+f+GwWGUbmo6nLAV/o32rKStyfy+OS+t8HT83jLSbpu0B319GOR
         cg6g==
X-Forwarded-Encrypted: i=1; AKwUvBwgD28/C1M8uLbkeY2OEFILfizlHEm+MxVNDU71hl9aUtolkxBL0Ecra9F+S1h1Jkgzm4M=@vger.kernel.org
X-Gm-Message-State: AFuF++lqIKSTFSeZdh0scYDmWWiveF/AH6JCm3o9VXVAYOGzM8D9I9Dk
	9+omSaub0T0hDKfvI6Ha90xqsXxMMrW7hZoALYUIYb0uoDWX7q0C6yMD
X-Gm-Gg: AYBFou1qyr4ZEuWKWyqGkAzZ7u7RD3FG7mhfF10KzXCPeV+J7MpSrzaBX9ntyRxNqMK
	S5WYr0fHxn+TMZ9PGizmMsz6gxuhnnG7A//j1lkc6NmkNcyNoWFeXx2+ftLyfhuBO7FWmWXnWGS
	WJ0B/bOYA7QbN0U1NA5gbKRBUfaENQBH3SnYcS4EIZ/iwKAoACUTOt3p5+rfrhDYInyRyi85mj2
	aN6WkJtz24IB82FaDtgnWwcopeKzd2EybkizVh/FIGW0qz3sLGiD1wZjZwU/BZAEtr6rcNJRB0u
	30f7hjN7ModWsjQ9fGbmnZX9PXPCQUpj+Xu6iAII6osuGgrShv8emqj76IT+APerDwtl6grNx6k
	l63yZdRmVD8pUHubH9NCnALmRL4Y/umKuXl/iyzEzuUnkhlnSZqY9QQVQWhoiV6cwXYm/JM9sYS
	g1JnLTqdwE8RnqFI0HVFhwG0MXBwy8eK7NTJVPWyReEzHg9vz14eeYYUNrJu1Bj0d2aVqKEc1JD
	Vn/8jx/sokJlCmmVnCDQfErISgxr86IlBZ1SWl7V+8=
X-Received: by 2002:a05:600c:3551:b0:499:8b13:3a98 with SMTP id 5b1f17b1804b1-49cf8224cd8mr50884675e9.4.1788515859403;
        Fri, 04 Sep 2026 02:57:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce55259ecsm141620235e9.2.2026.09.04.02.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:57:38 -0700 (PDT)
Message-ID: <5e77651d-38a1-451e-b96b-33c91c414eb5@gmail.com>
Date: Fri, 4 Sep 2026 10:57:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting
 --no-commit
To: Aleksei Sviridkin <f@lex.la>, git@vger.kernel.org
References: <20260903125524.67889-1-f@lex.la>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260903125524.67889-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexsei

On 03/09/2026 13:55, Aleksei Sviridkin wrote:
> The tests here check the ref after a conflicting pick, after a clean
> pick and after a clean pick under --no-commit, but not after a
> conflicting one under --no-commit.  That is the combination a user
> runs into by accident: the pick stops with conflicts, and the ref
> "git commit" would take the authorship from is not there.
> 
> Pin it next to its siblings.

What does pinning a test mean?

> Letting the ref be written under
> --no-commit when the pick conflicts leaves the rest of the cherry-pick
> tests green, so nothing else guards that path.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
>   t/t3507-cherry-pick-conflict.sh | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 44596cb1e8..2ce2e88184 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -100,6 +100,12 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
>   	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
>   '
>   
> +test_expect_success 'failed cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick --no-commit picked &&

We already have a test that checks the advice that's printed when there 
are conflicts, so could just add

	test_must_fail git show-ref --verify CHERRY_PICK_HEAD

there. Because that test checks the command's output, we know that the 
cherry-pick has failed due to conflicts, and not some other reason. 
Using test_must_fail() here without checking the error message means we 
don't verify the reason that the cherry-pick failed.

Thanks

Phillip
> +	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
> +'
> +
>   test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
>   	pristine_detach initial &&
>   	echo foo >foo &&
> 
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc

