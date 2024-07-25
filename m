Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593D6AD7
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900745; cv=none; b=P+XfRT+XGZISQ5cAFbmH8h/oX1uP4Djzx+ztsW6MRPG9Pmo7Jh67n4YzsIys2+rpmjyFX/ye+KdZ5rgOkXp9ltQQENm4YwXZeL2JoFkKmojTdPNkn8vsOqMLlUC6gXFkGLCsHw8B+5I3cNZvEUI5Oh3QmmgTbcKinJjbiOyfq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900745; c=relaxed/simple;
	bh=tQ66PMurgQ/pcSVmrWl7F2munEHjm0o4SHAaVCTENNk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Vpxezqd2y+o791v/ryu3DtCyxlFx+QNUKwWbelVZvU/bYAGOZJ3tYcMSqoCBt/E/of5X3Ij1xwO7EOvCvk/XLLY9DYMdN/3QFHS+B+SS+q5kG49lOxIU6XuDhtRc/vVVlzOlC5pSEz16irOWV7X5HpasKXIiYsbsK1W/aibkigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE8nedVN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE8nedVN"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42808baddf9so1093055e9.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900742; x=1722505542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmPK1YaWPfONJ48qC1zMzdGUaWJwCJ0uy9qafRdwXZA=;
        b=JE8nedVNDpYw/iMiQtqWYSYpst5eFFGT/iDEQ7Clv7fUytE21ipNqbv6G0SrZfUlEP
         ZzqpMie9sjUpYUHiGZIvSkf868kRfcT4p+B1SGxzlbnQz8x50mOXDtlmYYW70/YtpKt/
         dWHsNFT0t+C8FaQDPAD1q2qLYP7tzEgiTlVmrXs4dh1AD2qRX/QOjT0En5jj967Mh32r
         0cBD99BXwh/EYu0gmYsina5+BVv3c6iGw99022neB/Da1NOBa8xhRcyKMKi75QV88UaA
         LMFSTyHaUnGa4QIH7CBXcwJyiBcJiWexs4WJ31S0qxduu1CBJfkw69uBLJEtkLF7X29d
         gcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900742; x=1722505542;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmPK1YaWPfONJ48qC1zMzdGUaWJwCJ0uy9qafRdwXZA=;
        b=JQ7QV29ln4lEF2rFOw7KTRQ7E+eKhOfC/pLlBfJKF60r0GQute+WctrOfDsCsJdvwS
         Whd10OHa7gwzJmoyi24eiwJgHtfglLpIEWYpOeWhqgStn6pXJzt+AhRbsJkayAT1lFk5
         JzE9K+aKJ+qZx9C1PtdL9/CX1HtgYNmz0fyfH1n9Z+LFtcJ+V+OOxBsvHuqz0kM6Kqas
         4LW+PPqgwi3KHb349bBMvkYAi6dxvWPVSXHLmzm2UMJcl4k1Hyv/Wq3kUzk8nrG8N+r1
         +MpKA6tbxKFWP8K5phb7y6pMBn1qsjKf8zkJhyHFjVhwvFIB4Xr+6hTfR5D6hlCgLoc0
         G40Q==
X-Forwarded-Encrypted: i=1; AJvYcCVs3hVREicK8uuNzq4EMx+UlHYMX1vnYUiAX7rhOufMgONFG4f3r51VjuhwzSeaE7Cgf+FMWoC3KbcM6I/14XAUeA0g
X-Gm-Message-State: AOJu0YwoxaJvqWomo7xsA9exOD6nBGBgsUvkFaaMrtiCHNJSQmVZfpNh
	i+4TBzitnh+C77BfmDlWDqForA5OHSviJrMeGV7dXfn7OuOil+wW
X-Google-Smtp-Source: AGHT+IEeSd1MwIn4YC/aRQlE6OnPKh2NhKtRqbRUlwGaE6pbBVaAZ1cuv13PnaxOpRckiBqIQzbCtA==
X-Received: by 2002:a5d:494a:0:b0:368:4e35:76f9 with SMTP id ffacd0b85a97d-36b363ea1d9mr1178668f8f.37.1721900741777;
        Thu, 25 Jul 2024 02:45:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d? ([2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857dc2sm1558822f8f.77.2024.07.25.02.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:45:41 -0700 (PDT)
Message-ID: <ecfd53a7-645b-4e8b-a1e7-17ee5c782ad4@gmail.com>
Date: Thu, 25 Jul 2024 10:45:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/3] safe.directory: setting safe.directory="." allows
 the "current" directory
Reply-To: phillip.wood@dunelm.org.uk
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240720220915.2933266-1-gitster@pobox.com>
 <20240723021900.388020-1-gitster@pobox.com>
 <20240723021900.388020-4-gitster@pobox.com>
Content-Language: en-US
In-Reply-To: <20240723021900.388020-4-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 23/07/2024 03:19, Junio C Hamano wrote:
> When "git daemon" enters a repository, it chdir's to the requested
> repository and then uses "." (the curent directory) to consult the
> "is this repository considered safe?" when it is not owned by the
> same owner as the process.
> 
> Make sure this access will be allowed by setting safe.directory to
> ".".

Setting safe.directory to "." should be unnecessary after the previous 
two patches. It might be better to test that "git daemon" works without 
safe.directory containing "." instead.

Best Wishes

Phillip

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   t/t0033-safe-directory.sh | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> index ea74657255..1eeb794194 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -233,4 +233,36 @@ test_expect_success SYMLINKS 'configured leading paths are normalized' '
>   	git -C repo/s/.git/ for-each-ref
>   '
>   
> +test_expect_success 'safe.directory set to a dot' '
> +	test_when_finished "rm -rf repository" &&
> +	(
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		git config --global --unset-all safe.directory
> +	) &&
> +	mkdir -p repository/subdir &&
> +	git init repository &&
> +	(
> +		cd repository &&
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		test_commit sample
> +	) &&
> +
> +	(
> +		sane_unset GIT_TEST_ASSUME_DIFFERENT_OWNER &&
> +		git config --global safe.directory "."
> +	) &&
> +	git -C repository for-each-ref &&
> +	git -C repository/ for-each-ref &&
> +	git -C repository/.git for-each-ref &&
> +	git -C repository/.git/ for-each-ref &&
> +
> +	# what is allowed is repository/subdir but the repository
> +	# path is repository.
> +	test_must_fail git -C repository/subdir for-each-ref &&
> +
> +	# likewise, repository .git/refs is allowed with "." but
> +	# repository/.git that is accessed is not allowed.
> +	test_must_fail git -C repository/.git/refs for-each-ref
> +'
> +
>   test_done
