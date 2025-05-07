Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D742A83
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581151; cv=none; b=XGZ66k1Bb/QfhaPr4R1J7Avu+jPeszo922RJLXBBXiAcKZAjwSGeTHbbShhuEaDlywjGuNF9ZIOztMR/yFc37Yu5McLoIh9eD59TRtUeFF2pHR63k11lEu4hAysoyCgvUsPi7++4jOHgjCJAHXvPCFSCurj2mgsQpGxhITXUiv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581151; c=relaxed/simple;
	bh=0Zw9fI3gSCATNg7pkmuQ2Nipaoeq6gnHRoLL4ztxPPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EID6E41sv4BP2quRmoJucVFRpuR5/stGxTiqEdK9qTYDZQajL/HEPfyCTOLgZDleyL03wdbHxZAf575/ImKNH/YUXzyorZaJzxoSbJ7OI7vFv2e2g89JIQv10YwH4gWB3XuLUANqkJ42Tk4RkJms7UrpJ53YLf1a08Sjn4kzfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmB2HCdt; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmB2HCdt"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7585d4f921so2554987276.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746581148; x=1747185948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q6WZ2eIJN/O5JXke3tC5Z148JoKZddyYxQA3ro9kUUs=;
        b=DmB2HCdtwZ6opE2EQ0hZQRDoS8SmBcz3vdCbhPAaIXrqrclJkPgeHDd5fd/3WJwG/v
         div6cZH5orZqvVSQMMdyVtQjWjOyEifHGrLYN99BHo70KZmQsM1dj8G/bcU+6mRz5Btl
         FMAggNj9aXZ5EATnhi5SwDmvDJ245Bo76dTlyn+d8Ia5CsUIK3ntWVjR4J75xzdxgduA
         I8yuu5YcbdR8XtLUWuzXcw82g9j4GnAiebUD0/y0O2W7cDU1jY3eUJ2CEmnVRYrsfk1D
         73AAiRvLPShPp41vyFaoV/MSIteWImx3pwslkY2mVqxo6f7J2eJi8qcOP750SMML8mGE
         wezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581148; x=1747185948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6WZ2eIJN/O5JXke3tC5Z148JoKZddyYxQA3ro9kUUs=;
        b=Z9vYklN9AP/cOyToXwOQupc5KBXa/YmMqo95SNtjl73ktu8NNLoq8zd9/VGXofRDlL
         N1CTTuwF4kXPwfcG0xCHewmQFmH7UOeR/ziXYgKTTaLN/G4yzu8X/P2RKr8xwqcbo00D
         DajLC+rx4GLvBcyJrVI3xAysKcORfBzL/NhpYKuG1uREh9VyayYZrDCtHwDL6HPM3Fgp
         VuInQioY4YPcNDcfE+rXKwsewubli8+PELBJ+hx/pPGxOohPKMq3u/VxJq2f8QzV+YuN
         0Nt1R+6LdCJS4w00vYQ2tJTvFBtwlXZKDUltgV/tYnofk3upR0BPBUNgCfV6GQPHS9c9
         O01A==
X-Forwarded-Encrypted: i=1; AJvYcCVysJ5/kNluTyUFmXVUy3hm5m5wEFsllwvHWNANI+HsUNhUzRIiKSJojuCEVWgWYS7dwyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbG3zswtz9ZiAHQc6LeweXdgT5+JPux9+1dktPM/cJ+4198Q2r
	qds8WQH8DbBtIu9WQc90X2FJq8ctXeh+BgdRtRP+wmQJUNZ8EgXt8QnixA==
X-Gm-Gg: ASbGncuYRijGODjE9ovJbSxPUffOvbv5iUz5rjn7gIvD29o0C9Fi5qiCi8+gbIilvSK
	P1TqxWP2hd+lMlFaaUno/eBCWkqKNFhBA/eOw/3HjBuy0bvjtts/zvfr3bNqQfGS+jUnhWypONS
	YqqIcC/xJAbXLgWeHg+uEoWO6FGzUqeckR6380km3wjDfsuNxAuGqfgYFCb9PGJzMIBvwtgL8F5
	Qbifn4umqhwo1vSvOeeRYAhbPGWhYVhjlXVN1PraB4zlOS/154C+Hlf9Oxx6XboBADO0OB/IORN
	xrLZUYInYWmUdGWMUYMW323MWZna3rCBzrDZFR+KQBTHSQUhrOPXsm++0qVcr3yKmVnO3dZJHoL
	92vIcSOHrFKf8IuxG+SRDoQCfmj43
X-Google-Smtp-Source: AGHT+IHLP41WWcXTr480OtkXYr87Nx8tXfZ5ktyhEpmjUtSU7iaEWOd0r5eeKv7UwiwTOEbcPsD9AQ==
X-Received: by 2002:a05:6902:701:b0:e78:7b0c:db8e with SMTP id 3f1490d57ef6-e788143f6a1mr1815392276.30.1746581148433;
        Tue, 06 May 2025 18:25:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78c8f0f3c9sm84504276.46.2025.05.06.18.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:25:48 -0700 (PDT)
Message-ID: <728e13e3-b563-4d66-bc00-b3320b76ec9f@gmail.com>
Date: Tue, 6 May 2025 21:25:47 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] odb: trivial refactorings to get rid of
 `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-12-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-12-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> All of the external functions provided by the object database subsystem
> don't depend on `the_repository` anymore, but some internal functions
> still do. Refactor those cases by plumbing through the repository that
> owns the object database.
> 
> This change allows us to get rid of the `USE_THE_REPOSITORY_VARIABLE`
> preprocessor define.

> --- a/odb.c
> +++ b/odb.c
> @@ -1,5 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -

Very satisfying! Thanks,
-Stolee

