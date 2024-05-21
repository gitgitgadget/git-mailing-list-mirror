Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E88E1482E7
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716321406; cv=none; b=D1Bys6Ox0Y2jevpIzNITUxMvCFuIRrceDuctPo84qvw2Omm2LKN/uVTsinFhlSCM/Ry9kZZxBmMgO0P4kR4wQnwUEeJSQyP0EeJ7wzp4ERoXVQDCSd5c9GqrgPju+2YDPuk4uqxwkMSW/luXb2pNT3I8xlggqxGuiF/VHQs2O84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716321406; c=relaxed/simple;
	bh=hcYTSG5/YAUif30BigQ8vhPxjiYpX//dNpe9H74LoKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIoMSKXiJL9FK7A9Rrt4bw+4N/1Zx3aEKLW08hrsz2Zo6pdodUvkDUC6CL0B4w0ZE7aTe4eRdLwfHeUCkaQ+ymq0BXZtfNzQyokEmm5QSMpoTsFd5keNgxZs987cmMdAkyovJ9fSwg6CUjHAKWhzA4J+GfOHKdERj0FYJBJ73E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqxUlhTp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqxUlhTp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34db6a29998so52577f8f.0
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716321403; x=1716926203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Fjv5/TFkPqF2nvK0iz9yszIEMwuuaEOwZGEq7YdsA8=;
        b=bqxUlhTp2y7s1CcsELgNO0dW1Yj1H5u6ZAWGd8TdKX9g+4SNeTMYnh656FBggz/owu
         8qca0XNdnJu5xgLjAprIBds6EpfWUxoEpXru2nECzIdCdAam57V9GlPf+OqWWCDUgVUv
         Hc+iVBZPwvOqkkjvr6JTZtyLjNTEPFbLkUojVh5XZJ89ScZnB8AiI4+bvpwAF1mCownA
         dkjy5r6HU8JkMjODt81cvwYzhjSqkvhJXdhaqvVHAqA8iSG9EPLBnj92uPVC3DR2uOJj
         MVfqWjvkH8TGvut6rAFdCzXTSaPMROmekn6fzzkIn1x2Js6+B+1d0gCmG4Ik9/qAe5d1
         pWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716321403; x=1716926203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fjv5/TFkPqF2nvK0iz9yszIEMwuuaEOwZGEq7YdsA8=;
        b=tB9xkaJFQQyAabt7+WYK7ZcAZf6vZ9PbpTTzK+S4pCEUfK+8bAYC8RvwBy3yecJVm3
         FPdiqSvWAA7G1P+5V6gWWKtUkkAKvPnI9owLNaxSgdR+bhk75DkLEeYsf5ucY34tjYNt
         hO8w56xJzzRWrhmtCYRU7ToqwDN3TQYFQlynStW3kNup8hfERFKXD6qmfW3WGThDfbsT
         OFLMELSSyT0hJAcvM5Ke5m+W0wdotPd9u6FDAaERtqaQ0KnZfVXjPZ3SXIGQ5Zy5Kx+v
         Ds/fjNiXaPcZacu20LSM8uawN7sATjn/WnxyiKBQvYepuEVmp3WDwnRgvZY1+rXxfbbL
         RMyA==
X-Forwarded-Encrypted: i=1; AJvYcCUkXBbIiDQpyszidyIZN0fFRElqVhBO+VNbxhE9glz6+Gz0SnAvM2j6/0K0wf0tcv6CIH5A3iudMaKke51vVpTcY4/I
X-Gm-Message-State: AOJu0Yz7Qsk9QHcFDiUgKAI5e55j1CTQgWXDTWCppgVVs6HXn8xFgMb+
	nGdz/Yb2R0jZGVOJn7r/V5imzsDZh+Tz07WOIKnOsWVTvqGzw5bE
X-Google-Smtp-Source: AGHT+IFbqWaiEPfQrAVXjFu3oIFiZXNBISeLdl8TWjHUjaX/BSugHbA/SoD9W8HrF1BVKYrbfY8iag==
X-Received: by 2002:a5d:43c2:0:b0:354:d437:1e67 with SMTP id ffacd0b85a97d-354d4371f48mr606228f8f.27.1716321403217;
        Tue, 21 May 2024 12:56:43 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354c575da9esm6695456f8f.85.2024.05.21.12.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 12:56:42 -0700 (PDT)
Message-ID: <87fa38a1-d40b-42d1-be31-aba7ce21881a@gmail.com>
Date: Tue, 21 May 2024 21:56:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com> <xmqqh6esffh1.fsf@gitster.g>
 <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <83071f70-e8a1-41d6-9fb1-108a31602baa@gmail.com>
 <516ffe6bafb71f5645e93e6c01f721a7@manjaro.org>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <516ffe6bafb71f5645e93e6c01f721a7@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, May 21, 2024 at 01:54:22AM +0200, Dragan Simic wrote:

> Though, I think that we don't want to add "pager.add" as a new
> configuration option

I have no plans to add a new git-add(1) option or a new configuration
option.  Only a new interactive option 'P'.

I do not see the need for them, but maybe I'm missing some use case.

I'm going send a new iteration, v2;  please, take a look at it.

Thanks.
