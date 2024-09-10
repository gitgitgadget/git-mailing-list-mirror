Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CC29A5
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935500; cv=none; b=mASz+j4iC3cetXQcJ15MDObV9hST/mm2q1b47innbU8Wp5sLqGoQLSlNcSH15wCZOBDQV95+6xGGuokDgM9XxolgVko6/e4GXvPcgPIRSmzVd1Hrfts2BwKkvAhQea3oiRp4NLTu2SmFyWUexs2J4l3DLdH+8lgzII6geJflC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935500; c=relaxed/simple;
	bh=LTv4h0b5N/cZ9imdkWGrke2pfA9AIcOFjPXC+svSSCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijehvFG2pZyolshyDQwuttOf2f6pYl/LDx97OAs4cEVqKNPD4sq7abiSvj6pHsgWv8GdoeBlCkG47uU5Ury6q6TbZHshF5yCIo5CzsbIx1etJY70wNv7qoOt2f9qA+zZwkjZSruTL6Nl1uA6HJQycVSYNTbY3Gvbj0MXWzYb6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNGbtxIR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNGbtxIR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201d5af11a4so52461355ad.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935498; x=1726540298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLxQjmrOh7F+4lHois2P4WFzt1WAiOvRGgl9AuTWG7A=;
        b=CNGbtxIR7pILUsNvpx74EZFnCZ700TM+1nNfT3E4pdWqnghLZJOApTjtuXWEZ5yIL9
         2FQ2rSho3N9aR4hPvMdEZqBDYriUTwRtYm0okKl+//pAHOMRGjAmmTCnU23RrMpRVvJH
         SVRDDs9LwVrUg7+F3smDxFpPFFxI9kjpwbSMXFvm8ZGJxKTveyWCaPntcMvUpZZlkDkK
         fRozWpSI/fzxfTMyEeZJ9VXbuRRX//fDowZaxTafdsE9KchBeVOQbgJX6NPLgb+wr0lc
         ycPdVC/9ZJSU3h15fDoee6DuPq0XtmI0D9LFtfjt5Vab49QzxD0uoAkyX97LpKNDoCGa
         U2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935498; x=1726540298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLxQjmrOh7F+4lHois2P4WFzt1WAiOvRGgl9AuTWG7A=;
        b=NiKSktjfE6ntYDcpd2GjLWL+cwLmqpQkzVRs9kr7ozksZa8rd5jXrkFQfnSUnoT3O/
         hVaUiW0j8Bc8vUzr8lv49an1vrTv7iiMC9mT/LnDY/nZNBRPMsov60jev/zgKBuBJ/l8
         L6Hw3S46M937J5lBfeC0nsDMkpdFIu+w86BxCxgI0yGTg41+7eyjCqf3l8vFAfaPvThc
         EGGNxP3zks1gBGAwpqKwW0AxUTyq8ELvvnkK23fI+VrQwnvgfkx2DX1y0ZXqCDdLjqmn
         aXqxcSMLT9FLWAjBfU0wp1c0uZrbzfiASo1GT10SeW8Gbm5i28vMEILR5kMdF4vNRB8E
         gDYg==
X-Gm-Message-State: AOJu0YxPfJWZH/zPJOypNFuUWGbdqsjNrORNH1WEoOpCsOH+M7Lin573
	SInjRCF1yfTbX/9QAENFjjdRKGZj/tMZWn2nLltHYL7caAhsM0wqR58moA==
X-Google-Smtp-Source: AGHT+IHNQUZqsESIyx4MUVRS67IcVNSpG4vWiWDVr1lJZ0jmfQhZAbyB+7jczCQjRcKZ1XS/SFBonQ==
X-Received: by 2002:a17:902:d488:b0:206:d6ac:85e1 with SMTP id d9443c01a7336-206f04c9a1fmr208782135ad.2.1725935498348;
        Mon, 09 Sep 2024 19:31:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d? ([2600:1700:60ba:9810:a1f3:c77b:6e39:8f9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1f38bsm39384945ad.200.2024.09.09.19.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 19:31:38 -0700 (PDT)
Message-ID: <7d7b9c30-c95a-4dcd-a5d7-1fca5ddb99e7@gmail.com>
Date: Mon, 9 Sep 2024 22:31:36 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] pack-objects: add --full-name-hash option
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
 ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <ff30f774ca82662bb25291804559bf3f2de061c2.1725890211.git.gitgitgadget@gmail.com>
 <xmqqed5ssots.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqed5ssots.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/24 1:45 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This is not meant to be cryptographic at all, but uniformly distributed
>> across the possible hash values. This creates a hash that appears
>> pseudorandom. There is no ability to consider similar file types as
>> being close to each other.
> 
> Another consideration we had when designing the current mechanism,
> which is more important than "compare .c files with each other", is
> to handle the case where a file is moved across directory boundary
> without changing its name.  These "hash collissions" are meant to be
> a part of obtaining _good_ paring of blobs that ought to be similar
> to each other.  In other words, we wanted them to collide so that we
> do not have to be negatively affected by moves.
> 
> I am not saying that we should not update the pack name hash; I am
> just saying that "consider similar file types" as if that is the
> most important aspect of the current hash, is misleading.

Thank you for this extra aspect, which has clarified some of my
thinking and I will use in future versions.

Thanks,
-Stolee

