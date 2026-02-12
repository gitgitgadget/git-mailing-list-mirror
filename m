Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F321E492D
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770911818; cv=none; b=YJnu0OVzu60HJ6JOliMZgb1GSaqPsLN4ZtMwswyVFoZz1k6mSiB3R7pjKQ41PR0oqWCu2VYpATL+E5GM2+FYNg7uGhnPvuWcEXudofidoE1x0o6UR8MKj264bYmqpcz7IUdaIfG6iVSHb91jPQWmXVRoMHrM8/JetkvAfoHFfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770911818; c=relaxed/simple;
	bh=EtPa1uBL5XDiBVEwmMnMABbZWqaFsU+1eYEmuuapg2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QEyWh2o1fGgp4qPIj9KVwL2LjnOL1bfEFztqPwigS2TsWx5LAHhRuKqJLbwqkBCmVK9ko9xG7Y9KRel5KFITMcNVqsoJ2aPbi15r6WVZC2/DnvDbTTJRtVu+74eqkR6rYfHfK6qfI/cE/lECXSyV1pXSkcUjJGD5gT7XLYRmLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5NfRc6R; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5NfRc6R"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so40027855e9.2
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770911815; x=1771516615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A43HesFdsu5Oy0hM9iNCKGQbq84AsW+yGjn7pqaqbws=;
        b=M5NfRc6R+sq3oqQKE1SFi20H43o3LbW55SiCUR4JRb1bG/Yy6nMYfT0lfT0O+BXKsv
         s3yfBkTkGHnxFNgmAZsWJgctZBYDMx09MrlFwfT6fswcjr8+pK8QDT3UYDD4ZCKZb/lS
         E5sbD4dMBaC6nZl/xZOBAsqvVib4/NtIMSa61ev8yAenUqLdAeRvsSYn8ukYWNBXADkC
         8ydmEDPyGgcRyf38pk1/Qw4J2/oIOzXb2m1ihtJEywuboHCmqLx/fJyT5dX8ecDK7Pmj
         wyfS28XBkFLSe0WpuleGyIfkc6hdUoIdkCheABzHMkgFQzlzGduOELCGqBuUCF18vnCX
         FJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770911815; x=1771516615;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A43HesFdsu5Oy0hM9iNCKGQbq84AsW+yGjn7pqaqbws=;
        b=H9kOLFg3p5W9FiKkkucuzIiqUP/WVIMOFQvy/PlZ0GX9v0T879oXCV6z95kGz5iuXa
         D1cU8zS8l1RTsxxOQGovA2TvUOrZOmM5YufzKA5d9Gjd0CTIb7nf3fJeapVpdM0n07kj
         4LOk13IpAbySW83gn7V7u0u/MXdaE2ntqDvxGINTgRBogKgu1dq0AzMtSMQuHs3GRGpf
         HH0QUtWLP9PP4Q8++/ZYkdTGFi+t/ZeAU4+uXUKSPJtgi+AAWbRYKNZwudQlrQcXdP+8
         B2gRu+mBnDCtK3Eh2ZRDI74t1hZz+Ie/0auGa7AR6Rcc3CYzOs1lc8WGZwO22U+J6Sg6
         bAcw==
X-Forwarded-Encrypted: i=1; AJvYcCUKOsjWj5bNzK0T8/mcYG/za+/7g9l7FzdmJPr1CCMBGaqsBbNDJTWwyBasMf8qJ69ciCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmrUC59ZZDSMkjQrv2brtywUqQpSP4dDOJTcq4iswV+bkFY+Y
	5k/FL+tbUSHbVFjaGS4EULJ+VGbUicQhFs+uF78AeFbJJ14RsWV8CVpW
X-Gm-Gg: AZuq6aJ40B/pcvbYsmmJWKI48zUto5SsyNCBd1ijgFBpuN84+k+CMdv42K5iPyKCj5p
	YTEMqPB21arPsVwmud3GrZ1dlyLRfxUVwKJ/WoFDMgiQ4YU6vwiLGhwnmragRmEZVxsVOE68xmM
	j7GOSQy9LJyeWlbFmM8uc7VYcB61kWBITCD38LSIiq/GTbbC91HbWy2gAQCoktFbcUmH0SSWIPG
	EjQRL019LhXH484MCnHWCuu00qyyZ1FhS2lc1iNWBvdDnUTuncpVMs8BbfNotVwVjCMAbS1VmHR
	mXzudzlf7bwS4ayg1tlVZo29BL98JHpBH5gkhl7faK53djPehDGbDdzaMFyDjABEDdutLSOKRnd
	PhLnbV5fKy3OScjDlJNJJVOwr3R+fEn1yBHi/nL/GwcJp2P1vq7uSrqA54xcWYPBwtxCtpcigYE
	lUmAAPB1a+0ziTu2R15+fNkP6yolq6kJuRdrlbNP7X84e9ibBn0/CKARuqgFxhbTdJBEpQEWXgG
	wRhqA==
X-Received: by 2002:a05:600c:3e8c:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-4836716b6ccmr46458635e9.31.1770911815029;
        Thu, 12 Feb 2026 07:56:55 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77f9sm218491275e9.3.2026.02.12.07.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 07:56:54 -0800 (PST)
Message-ID: <53696dd3-1920-4777-a62e-bf7818bd228c@gmail.com>
Date: Thu, 12 Feb 2026 15:56:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Feb 2026, #04)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5x84xms1.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5x84xms1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/02/2026 22:21, Junio C Hamano wrote:
> 
> * pw/commit-msg-sample-hook (2026-02-07) 3 commits
>   - templates: detect messages that contain a separator line
>   - templates: detect commit messages containing diffs
>   - templates: add .gitattributes entry for sample hooks
> 
>   Update sample commit-msg hook to complain when a log message has
>   material mailinfo considers the end of log message in the middle.
> 
>   Will merge to 'next'?
>   source: <cover.1770476279.git.phillip.wood@dunelm.org.uk>

I'm planning a re-roll to handle subject lines that start with "diff -" 
after using this hook while preparing 
<2a8cc2d6c37f25a58823b501500165d597321749.1770911599.git.phillip.wood@dunelm.org.uk>. 
Such subject lines are safe because "git format-patch" prefixes them 
with [PATCH]. I think I'll probably drop the last patch as well.

Thanks

Phillip

