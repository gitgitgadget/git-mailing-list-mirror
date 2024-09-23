Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5810E9
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 01:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727055121; cv=none; b=us/2VmGEYk6xH7MPKiLjKXKrV3Porp5RABkul0pS2k+terQowLT91nf3QqyDxk3ukoI/DQHeSBIvGkV3VAQcfiWJvo7W3zmdp9VR0YRQwuZ1kaGrPuLaVcohsh4laXp0VognuaVKKDW/3OTqcaK29ip7BOtJ0aZsDdbDnVPsj/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727055121; c=relaxed/simple;
	bh=OljICYDsP1evXEZBQ0AKkQ5GmF6lsydlgkFlpGX79Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fE8JjXO/Yin65/7BOzIphHheVjWGGGjsEeWk2QBQsPjjqJqZ7D3Y6lS8CrpHzXaMoJLZulA0CQgiDnRSx2K5g4uy8Kx8NK8QcnGa26GhBB7QTstz5WZ5IsYUX/XjOhdeAfl6WHw7cD72874TajqGp/jQoPR1QOLJhGtN9ixILME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGDUvZvZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGDUvZvZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2055136b612so46048755ad.0
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727055120; x=1727659920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qAtEZnsHWgbm8X1ZUfZXu+eaWvFxfrty44Oj8gNS2p0=;
        b=nGDUvZvZi2msPpumF/4EVHpCKWLs5fSYDfqiyWzcadcUATYPeAQPBOopH6faX0cVDg
         S+iv7f6hFjXGofhRWnpAqdoVKRzdUe1LuLTSM/HNcR10yw/zj19ZTFPcfdh96+DU1eOQ
         yGhXG8jSwee3KikbnByIXRSgr3lW4E+GvRkyg8LsIiw+TKDWw4D++yDUjoosqHsb2lB3
         OKgcXLHrJ0Jv6rBELdkysQ5mQbD7MscIBW3lXIuz4I5rGQU41JjukZACwr7G1xofC1xO
         cwVMXRhyV1/jZvAVqbllbnNNZk6+dPLMFx+pADk8zvATsMt437M2X39xBxUPuAoUZgtU
         y7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727055120; x=1727659920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAtEZnsHWgbm8X1ZUfZXu+eaWvFxfrty44Oj8gNS2p0=;
        b=IVym9VhbD6Z5r8JiRgUr7ZyEdTqgkZhnnNTX14BHYcfOjd78ubzUYyG8Rko88WCvU1
         gO+K4ij/4Qey3Wi0/A9RuZMOdunQG62JGraLYpEWFk2ip0I+Eoh7NkTbOuITiG7F4TNI
         W4TiqW+np1daW405RGTkJDPJuRS6ZJ59pub2J1+AuQ6uNSlbYkfrLcbvybcUMlAFYB5a
         bgJoRdwDbAOk3PT+CN31joH29Ack5uUMxtXnUg/3eoZKgJsBmNy0I7V6pnxx0fpsXfka
         JRET8TPeHa7HlRKKw4qppVObEffeAnev5wA14ivYLsyiYdX8WRoEVIyYG+Ujt+l8RnLi
         LyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbiKYNkzp6w/W+knNV1uMoSk+W4+2exqcuAdAWvK9d/tfnbQQZ85vXw5N1uBjmwZuqqmw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6mx9Fz2l8wXfFTknkKPTHGEwoMmPSoObs5lmgUCJURX37TNjw
	pTCLP4IfDiAagffslwP4PbcRWACrApR8qrgr4SSODOs7yU6P3hyZ
X-Google-Smtp-Source: AGHT+IFbl6drTpyxPhaaMTdf6fTj71GimS4MI/Wj4/DbArAxW4z+Nvh7ZfPc9hbGGrvtaPWGfDIw1g==
X-Received: by 2002:a17:902:da8f:b0:206:d6ac:85e1 with SMTP id d9443c01a7336-208d97e4004mr137913105ad.2.1727055119746;
        Sun, 22 Sep 2024 18:31:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:1803:188e:65b0:6321? ([2600:1700:60ba:9810:1803:188e:65b0:6321])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945db101sm124392355ad.1.2024.09.22.18.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 18:31:59 -0700 (PDT)
Message-ID: <34346998-deac-4e1f-9d5f-218f664e9e08@gmail.com>
Date: Sun, 22 Sep 2024 21:31:58 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Sep 2024, #08; Fri, 20)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqed5ddexk.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqed5ddexk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/24 8:32 PM, Junio C Hamano wrote:

 > * ds/pack-name-hash-tweak (2024-09-19) 6 commits
 >   - test-tool: add helper for name-hash values
 >   - p5313: add size comparison test
 >   - git-repack: update usage to match docs
 >   - pack-objects: add GIT_TEST_FULL_NAME_HASH
 >   - repack: test --full-name-hash option
 >   - pack-objects: add --full-name-hash option
 >
 >   In a repository with too many (more than --window size) similarly
 >   named files, "git repack" would not find good delta-base candidate
 >   and worse, it may not use a blob from exactly the same path as a
 >   good delta-base candidate.  Optionally replace the name hash so
 >   that only blobs at the same path and nothing else are used as
 >   delta-base candidate.
 >
 >   Will merge to 'next'?
 >   source: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>

There was some speculation [1] that maybe this --full-name-hash option
would be considered redundant or irrelevant when the --path-walk feature
is submitted/reviewed/merged. I'm not sure that that is the case, but
maybe we should leave this open a bit longer for folks to weigh in on
it?

[1] 
https://lore.kernel.org/git/81bc5d69-cf50-409d-ac64-5b9b3f722ace@app.fastmail.com/T/#me45c4fd489bae987785cddb9580339095095fa9e

Thanks,
-Stolee

