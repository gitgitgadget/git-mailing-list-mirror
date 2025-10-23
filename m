Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13002F83C2
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210279; cv=none; b=AM+QywJfw462eu217R1we1aX0Mx/E5o7WttuWff/jNcyRaZsWMkR6/hKMv+POPfMpBs6JNIXmgwqt6cOtjL76mVxepJzW/uudS2HV1SZrIv8E8zREg83r1SINOrMJbnajaWCyRDIkKQg6A0trmSQcNMJd4m38DoTw47kXjzLR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210279; c=relaxed/simple;
	bh=iECe/3qiskyxWRHlqU+ztuWJ8eYDvGNzPfyAHSoNwD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtnmw4TrFz/hscsuhn2v5/ElkY7Rt42tXhaHi79CXPqTBQbZ7IgLjK6SaHZTWzoUHyldysxFpHMYd+LIWPKb4u9J9IFSgYxTdMxePR3JAGDsRK1Hqm4yP9sZiyj1f+Z8AsPdA9zEdRUWAPHZsYCTzxhYAMUL/cQ/1hgj/d+5Scc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvoyNFGa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvoyNFGa"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-471193a9d9eso5865445e9.2
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761210276; x=1761815076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvDWez1K/1Y5NPMRyLdJ8gvHg/igFqQI7xHSS8L12sg=;
        b=OvoyNFGaxEQzPQS44Q9qsUncbojsfzgijDJcwnTuvycVdyWuy/nKXlcdMrbVMV9fSW
         xMG3HKLajO+AIQ1yN0ZB/g0LSoA4WORM6Nrl4QhlmuJI4iY7XHwdu9iMXfiErYXRaCB/
         8dDIB2iqHKCqhecUa1cOwSPRy2zV15W0Im0ervlCWMz2DCChAvKkebXXPRP3pcskqfDR
         9BqmhxaLDfxdggb/r1pzOnFJw7b/U2foM157ilFvT/FVbLp8WakTJR39pRF9vmKlC886
         iEzemCnN/4S0Dw3LVnvrKaKq3U2BtfOT1+7/krW1UwAEmuZaLoN/tsWiHkB+BGytOr09
         uKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210276; x=1761815076;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvDWez1K/1Y5NPMRyLdJ8gvHg/igFqQI7xHSS8L12sg=;
        b=hSPiRpOsihdUvudsDruaL6sWHX7Rwqr9ArlClcN1CDL/e9a5EtRusB7bW7Jn0OmY4s
         pBCM2t8TypG6SfE81ayxyJ3rKLkl11VA4+KKQGeHzyeOejJPDA+zPMexpw+zLGA4MgO5
         bn9p5dqhdod3WARkHKpS1NZ2SQLz+gnvolz33/l9YMWrXkQAW9W63BKanAhR6LDoubSR
         gZ1lpYE3D5eelwERXuRjfAbDkBR5bflG/jnHOo4t9cLhulPbpyudKI7lzw2XL1+yfpYz
         wzDp/JtEDpuVbUFP0xj70Z+eMmcEh8KWQkrkxFlnzAFkL57LX/4neMhCxvlmPFe+7Hb6
         UWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOHNTQi17HOxWBpPPUKWUzyfrnVsegiVVE2a76OYpzmDuReqO+S9F1WSiuitYRf9K3YRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZDaVslEJs8xmhdFCd6inPCXSbaccCzI289LTC+0iqf9Y3RGf4
	FGFSUirNII+zymuSi5yN4y3n3T2k/IKChD6fr5GGbItJPXLOAQcuyGr29rnlyZ9qY74=
X-Gm-Gg: ASbGncvyOBIOdi4dbzE4rqa7AYZ/6HD3TDK618PoqqnjKpHkObSRr7hq79/ClPBvJrr
	YCkgZIQvP3VMprKP/YC6OUoEh/9OYItmws5lhOKPeLYdGlooX07BJXlqI3XC58MHiGks7tr9yot
	klmvc6hkjaLR88z6hzmlOAl2Kytzyn0Q73fMRXZMX8eJdEAKDtACm1hIefz9SWg3MKUxC2lWVLW
	OQmmYCf//9iOmjgTeQmaITGJIjVyf5HKdljTyliDTgw+OGvoI9mbF9VChAAcTK1jaLqeM8n5GTi
	BtN9KMfugAf5oat5UwcxOqBL+94zEu/2P+oTo7ou5kZLd653mZp0dCUQaqGNOJIW/AjKFTI/ety
	l5YOhiK5Xu+9GFIlR5yTatnYugGeTh+0q7OdO99/GAvR9FNHUNhv4/Z9kkCEl8X3+7YMk3f5rBj
	QW4tza6AQ/0o/PBmB2AV2xX/5zAU7zDGsCtxgS8E6lKlXvQCoWobuuzu7gTojbLVfMZ31/
X-Google-Smtp-Source: AGHT+IGEnOQZzsDLCuy+zB9KwtIbKlDJ6PbNh6MKRv1FBuRDpBc8z4KgiJCFFdai1BJuYglEBj9EQw==
X-Received: by 2002:a05:600c:1d9b:b0:471:1702:f41c with SMTP id 5b1f17b1804b1-4711791fa29mr179071075e9.35.1761210275715;
        Thu, 23 Oct 2025 02:04:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:fd52:7363:399c:d2a8? ([2a0a:ef40:62a:101:fd52:7363:399c:d2a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c43900e1sm99000465e9.17.2025.10.23.02.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 02:04:35 -0700 (PDT)
Message-ID: <bdba181a-915b-48d7-8e24-84fd08436576@gmail.com>
Date: Thu, 23 Oct 2025 10:04:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/29] tests: t3440: create expect files at point of
 use
To: Li Chen <me@linux.beauty>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-18-me@linux.beauty>
 <4eb06e60-e088-462b-9f1b-ca800af39b94@app.fastmail.com>
 <199e82ac06b.22809060320824.5985600477588171363@linux.beauty>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <199e82ac06b.22809060320824.5985600477588171363@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/10/2025 14:58, Li Chen wrote:
> Hi Kristoffer,
> 
> Thanks for the review suggestions! I'll address them in the next version.
> 
>   ---- On Wed, 15 Oct 2025 04:41:33 +0800  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com> wrote ---
>   > Now you start to change the test suite/file that you created for this
>   > series.  There shouldn’t be a need to do a test file-only patch/commit
>   > for a fresh series.
>   >
>   > I saw in one of your patches that you removed `--keep-empty` from a test
>   > because “that is the default”.  I also saw Phillip’s comment somewhere
>   > that said the same thing.
>   >
>   > The goal with maturing series is not to add patches on top in each round
>   > (if that’s what you are doing).  It is to recreate them as if the series
>   > was perfectly written to begin with; if one patch introduces
>   > `--trailers` and a test file, then there should be no need with
>   > follow-up patches that improve the test file style, refactors it, and
>   > so on.
> 
> Thanks for the tip. I split the changes into separate commits to ease review,
>   as Phillip suggested in https://lore.kernel.org/git/d4c9f082-52be-48d9-b817-fcb8a72e1bd7@gmail.com/.
> 
> It seems I may have overdone it? If so, I'll try for a better balance in the next version.
I asked that you did not refactor code at the same time as you moved it. 
I was expecting a handful of patches, not twenty-nine. The point that 
Kristoffer makes about this patch is perfectly valid - you add a new 
test and then correct it in a later patch. Instead you should correct 
the test where it is introduced as Kirstoffer suggested. Looking at the 
first patch in this series there seems to have been some 
miscommunication because it has exactly the same problem as V3. The code 
that is moved from builtin/interpret-trailers.c to trailer.c is heavily 
refactored at the same time. Variable names are changed and the code is 
rearranged so that "git diff --color-moved 
--color-moved-ws=ignore-indentation-change" detects barely any moved 
lines. I'll try and leave some more detailed feedback on the first few 
patches of V5 in the next few days.

Thanks

Phillip

