Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835321A08A0
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799359; cv=none; b=lFG92uaTzKN1kK2WWPCOZ5E/UZGsRBDzXpo9zEnKSUkwWNrAsp5RUJmyKS8wq8p46n+5ufmlkhU+9sIgofYMyB4T0KM0QkfQ7qk7ccklMJRcCKQK3djaVcGGj3CNLtky3G0jP+UTvimlB0y3DUBY9uct5E54HTCTlCkj6A/4zTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799359; c=relaxed/simple;
	bh=bVsUrD9a4AJwZ89bU+j3nTRIzvP9MLDtRIRxDJ3suG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adAmxwtry/LlkYjMHr1yjzQ0E+ENixx3sG5d6XYkWGTscVUwpB4F7wkGI+tDbB9XyRwG+H3goz0yQahoilZdekD3kP00r/N7Rn7auxD9WyppOIF0zj7DblpsqL+6iVijWOKjcNLb/XoRrc/uNuPdH7IzfmrlIdOyqUJM1gEB5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJnHR1Tk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJnHR1Tk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso64892135e9.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 03:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744799356; x=1745404156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzATq4XwQbryh5Oemtt8k1Af3M/nkHkeJG7dtS3qoDE=;
        b=fJnHR1TkgPu52EnTS5VWFLBrSeQ4jQQU7UziKT5UPdAjjxylQwnWSwwiv1JzAWnGPk
         PwQAYLmVL47IBkL9uICI2nnqgCMFHnc+VcWqVLwLtlhRTbA5D8pNMGXznUALkVwbw9DA
         f43yV7UHaRUcxRTB2oiKg6fIdHhmfQ6xg7xXXT1Nbd7fuGiFjBmTFbNdFqj1SHhPMuX8
         eWTBx1xLYbuJVCmfb1TOOSkVTa1jl/j72l/k+/+JPMlpv6By2/3Pdk7qpMS3QeOcGeea
         YKX7fUADEi07lQRdSbKdgVNO8CcjbFP5NvTT7NSe1myRkPMH0fS+wQUmOw4Qf+o2Gg6F
         gCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799356; x=1745404156;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzATq4XwQbryh5Oemtt8k1Af3M/nkHkeJG7dtS3qoDE=;
        b=uAFE+mnkbzvbbEqkWePzjP+14EiSW6jTbGYrjn4fJJL/itrrtr/LM+YDMXf3qVVdbg
         pM/sbMw+nFTiefV7bk/2u+6tSFNRjImshLA2iY3P9HSCsNjEbPv6kK6X6FF48fFxKXhh
         vhPTXEG4s+jWt4gJV6egBKPphgvZx5R4vbvv7qE89fI957Aio3ddVTYDWZg1cdPd3XXf
         +Z5S6yr/VuLX7QwlmwofyiDc81m6MeQxejrtv75psD6DAa1GUsmIQjCp1rlxxQgnOxeB
         GqY84ZtMw1ylQUlScYUJWbmCIG/H641PfoQeG4TmtSeBAENhEGb1t7BXn5UKn/tVpQaz
         DhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR5inVabKMv6AsvMPhg9wZ5+vERX5T0NN7zXM5tMhcWgDcVBHT4XvCJvlcAcGNexMZtic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjYY6tNO9nBSo/R7IT14R3IMso6KaUER+XXnKJGogE7CILhEC1
	PLQx68V2cJbuir4BgtTihXNBoH7PZbu6rUadm6uHLBoEDN2L9o0T
X-Gm-Gg: ASbGnctQGCjiowNowMHPGCdUgRbgrB00U2wiEN4izyHfqmTP3wvqVjJhvg78QUkfj0U
	sDUXyisMGNVAMHW14jnreyrsfHc4kjrudvXAKtxF1/Dsu4Xt3VMnpYlw8IaED8KvphdX32ZjAtq
	Yt//fVZq7iIMvspRm6merBWHb7NRiCceEgpH/9UOqfi7aEI2xGGUiQv8h/05mVy1GNZYufvjDlo
	jx1XQiOket+F+wzxGiacsLWYwa7LVt76SJ/nVFXVetGvZ+VjbaYooq+otkEAPq2afpSkHJyOVmD
	WKBnCNuVr3KAw7PU46ZGQbQdIOkfrmOgPCiSU7DxngZhStIdg1VKFOv1DDp97shEACi0mQ0Txm2
	E0hxH75cfkfOA/bL05ybDa5U=
X-Google-Smtp-Source: AGHT+IGF4QJNx/aKRLZrUEqQNKWT/R8iELdI/oAzM6c0sM+/I2lDc4VyKSrvwDqv02M+LLNhFaO5TA==
X-Received: by 2002:a05:600c:a087:b0:43c:f64c:447f with SMTP id 5b1f17b1804b1-4405d6cfabamr13168735e9.29.1744799355435;
        Wed, 16 Apr 2025 03:29:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:9904:268c:c66:c7d3? ([2a0a:ef40:700:a501:9904:268c:c66:c7d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf44579bsm16513031f8f.87.2025.04.16.03.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 03:29:14 -0700 (PDT)
Message-ID: <a5632198-9e04-4302-a3c9-1cbf0f0cad65@gmail.com>
Date: Wed, 16 Apr 2025 11:29:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git: add --no-hooks global option
To: Derrick Stolee <stolee@gmail.com>, phillip.wood@dunelm.org.uk,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, james@jamesliu.io,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
 <cb3d080b-51a3-4096-9650-34ec4ed68f1d@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cb3d080b-51a3-4096-9650-34ec4ed68f1d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stolee

On 14/04/2025 11:59, Derrick Stolee wrote:
> On 4/4/2025 10:15 AM, Phillip Wood wrote:
>> On 03/04/2025 23:38, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <stolee@gmail.com>
>>>
>>> To that end, add a new --no-hooks global option to allow users to
>>> disable hooks quickly. This option is modeled similarly to the
>>> --no-advice option in b79deeb554 (advice: add --no-advice global option,
>>> 2024-05-03). This uses a GIT_HOOKS environment variable to communicate
>>> to subprocesses as well as making this a backwards-compatible way for
>>> tools to signal that they want to disable hooks.
>>>
>>> The critical piece is that all hooks pass through run_hooks_opt() where
>>> a static int will evaluate the environment variable and store that the
>>> variable is initialized for faster repeated runs.
>>
>> That certainly makes the implementation much more viable. However I'm
>> not really convinced this is a good idea.
> 
> I don't read a strong reason in your message that this is a _bad_
> idea either. As in, there's nothing that hints that this will cause
> significant harm to users other than providing a new footgun (and we
> have plenty of those for folks willing to look, including the
> _existence_ of hooks).

It is certainly not a terrible idea given that it is possible to disable 
hooks already but I'm not clear what the motivation is. I don't find the 
example of a skipping a pre-commit hook persuasive as we already provide 
a convenient way for users to skip that hook. Elsewhere in this thread 
you mention the "pre-command" and "post-command" hooks but they are not 
part of git - if a fork is running its own hooks and that is causing 
problems for users I'm not sure we want to change the upstream project 
to address that. If there was a clearer motivation it would be easier to 
understand the benefits of this change.

Best Wishes

Phillip

