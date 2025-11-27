Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F85149C6F
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271310; cv=none; b=cuY2d5BUQL6ZLuTEZklPw1tRPJx6JS+NVvxYo2xrFFaL0GxZXjNH9GwSGDP+WUWHKW4ClPDHWCzkz3D/zvYPbfnQrvuWtmfqZ9k0bYIywWZQ/CKSh3+LPrwLEZCj0OutkuE0TPhRb0XWXlhHU4S/iSKn1vpTIznFxn/RMdEgHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271310; c=relaxed/simple;
	bh=aXaUTCHTPaj+WLTORTr8ZP8FiE11Zh7+gNsCuOY/tKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jy1I19lGSGBcMcGAkDxniIAlcaJXco1n5jRKUhkVEq9xBhfwIlFgMUjXa4Nuv1Ny0jhwkFrZk5fybgqE5lKpToFcBbs2zExsEqy2MSaPAz9wXJtSC4ScOwWka1xud3w86YJyFppeelyd7lMFokGVmbtGLUhEdqRWmmsydQWAi6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR/bkNpZ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR/bkNpZ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3437af8444cso1276964a91.2
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 11:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764271309; x=1764876109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qGocpGkLSE5loEd67DY8z4Q9kQ1GQWeXeWv7jWhF0g=;
        b=QR/bkNpZdqzTDWZ3akMcz12gnZuMNWa9TPGWWTAGLvRUKjrDRn7bATUikH4WFSvCLh
         B7V4p0gs2D/2H3cGqDn46wf3UK2CBB2QrM+ttBWKwOsX0HMtJIXJy1Fy2s8whLabzzj2
         sEW7HmI9Fd7+shsjWgE6K33Hvh+oNZRPiKrmMU03igMXHwH9Yn74kw391znAI3t89Qfd
         JGcUhft45EvwsYO0NETET9IcBxxBiGAaNbBXFSm4vjd6/IrofwLFjb8CEmvS7vbBJ+Vc
         DfGoUL+NwQBG9fHBsq1OouTDRkW82cZhqcdVewL+nPl0wo9TYxej7fcELPE16HqJLd9n
         kL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764271309; x=1764876109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qGocpGkLSE5loEd67DY8z4Q9kQ1GQWeXeWv7jWhF0g=;
        b=SQePXM27W+h9Hl7Tm1XJC4bguBakYbD4iQBt3h6TVg3gUr5PWtHTzP22p/w2aUIuWp
         aVpbsbmWquIuarcmIufNPut3pKv3lHva9BkkVkY6PKO5tMFZiGi4zFsiXWVkVxtlf/L3
         REmypBt2+27vvqYAa0lZ5CK2ak3fRsh/TvRuDP55sB0v0QsF7RW0Xujbq+DCuzDXaHjX
         MxsLWMTVYYVio2cNPnPxd0ffWYfw5yHH1hdjfyp1U0GjtD6K1ojH9MlmWPymLfWkDLAb
         lRMkTu9lDg9/IEdV9qejLLkjeqocpLMzPAX44suD16SniQ8ZL0v1t6MBYpJx3QL2EE4v
         XLsw==
X-Forwarded-Encrypted: i=1; AJvYcCXn0t7mds8vTP/2G//PIOF2SH04rNp9NAGsPa5mQpfEDtnxTH/AjU7f/33igiHw8vm6MGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPq8ihK7zr5k74cYS1e5OcuJWC7APkdiRzxHexO83bpKledQ7W
	8gHUOj0mfzbBIh9vXzNK/k4y6gIxyqFdWwd4aDNmRx68jlRCAa7s9gOq
X-Gm-Gg: ASbGncu/QIp4gxhwMbQwDVI6+Ccj4jrAKRTvp4xv3ZXIdYRPfvFR28qG5u1kKTEAdg4
	X0Y6+cjWagqlMvL+RINFPMh6JDHrd02WTEqKP2i6XX+RUUQMyouO5/6fzWLQ2+Kr1PCm1vqSMb6
	iaAOmUyg1tL3mLxxBAWRewR1LlMy+6U5zgn8Wy7hWCczMxk2neiqChVGkMW9yymHfGylbN27FRJ
	/G+bv4nuMTZA5jIN/erAxUaP3AckKEfM/gAwFh0ovbArB1F+BZ01JdW+s/TiDFPtDdh6ta2yU2g
	1F0qo5KwXkQtKpdDHd5ygjpV8eikkTP0undmmeiuWgGi6GaZaJNe/VU3PyF68jPUEKoJF+M2fsf
	Q3Ta5fOVGxSQrBkkJz0AZU2u4KWwhsB0qspwPZLEn09iL93Qa7RHJ1jtAj5WuLDOm5cHgTP4YHt
	sgFwgUTkcbmGpMhXPM5vIeinUfnJkni3+xVOOvyg0yy1/gP9O5rqXi8Luie37PLothkoQomxMCM
	rV9PAaDrL8UacGO3iZoA48=
X-Google-Smtp-Source: AGHT+IFgLDQbYN3pHv531OkLF4CDpMceGBfMhMQR6qc9a7xk5JZBX/gbib0EZsCgVReKuiz9zYrhkg==
X-Received: by 2002:a17:90b:3e48:b0:341:2b78:61b8 with SMTP id 98e67ed59e1d1-34733f23e04mr22538885a91.20.1764271308661;
        Thu, 27 Nov 2025 11:21:48 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:a4fb:44b4:6c24:a31a? ([2409:40e3:30a4:b776:a4fb:44b4:6c24:a31a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3477b732b91sm2541488a91.9.2025.11.27.11.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 11:21:48 -0800 (PST)
Message-ID: <fa403239-cae3-463b-8c62-8761116ec652@gmail.com>
Date: Fri, 28 Nov 2025 00:51:41 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
 christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <4d75da90-7e85-573a-bb10-0c63a02b076c@gmx.de>
 <27fef9e1-bf26-48af-b3df-35948937c891@gmail.com> <xmqqcy54mro6.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqcy54mro6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 27/11/25 02:34, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> 1. For quick undoing an entire MR, the `merge-tree` approach you
>> suggest is indeed more efficient and avoids unnecessary intermediate
>> conflicts.
>>
>> 2. For commit-by-commit reverts, we need individual revert commits with
>> proper attribution (which commit is being reverted) for auditability and
>> history clarity. This is particularly useful when only specific commits
>> from a merged branch need to be reverted.
> These are both good workflows with appropriate uses.  To make the
> tool useful for #2, it needs to be able to allow "I have merged a
> topic with 7 commits, but the first commit and the fourth commit are
> faulty and I need to revert them", i.e., not just a range


Since replay uses the same rev-list machinery as `git log`, users can 
already specify disconnected commits:

     git replay --revert <target> <commit1> <commit4>

I will add a test to verify this works and document the capability.

Thanks,
Siddharth


> (like
> "rebase" and "cherry-pick" workflows take), but a set of commits
> that are potentially disconnected.  The current command line
> arguments "git replay" supports, or "git revert A..B" for that
> matter, are not exactly a good fit for such a use case, although the
> user can of course run two single-commit revert operations in a row.
>
