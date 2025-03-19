Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA6254860
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380433; cv=none; b=RCCixQ8ZleTwisVYyctPRcpwn1CY/k4Wqpu6ypoffssdogQ9H9SCThGMdRKNK6FnL3K0d2UORbURT0DWJDNyIl23IeNDY4BQREerBb+hMcbpxeRWB5nzpC4Jp6PvBNvr9qM4Sd9lmkB/QzOF8YntHrZjzTskH6d++gkvj0Kh+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380433; c=relaxed/simple;
	bh=pc0u2D+W2CFpWL4lu+Hooz/0pfN7RvXJuqLISXKTe78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+VCaCHozb9fSqp6KcnZSYz2Qa+ubvLpHnVrLzEQTyCwoiBR0ZTtEBA65sPgFAWTe6vEOg2DhmYGIibKOYUhHJ0BCtEojW8v2VQBuX3g9WRTXNZ9CCkq0ov+7fzT06JSngX+RmHIE0fKqPl4wyFmyz5SpOrZyzU6zafaTNb/zWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qnk3zHKU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnk3zHKU"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so3587625e9.1
        for <git@vger.kernel.org>; Wed, 19 Mar 2025 03:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742380429; x=1742985229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VxLqSbjgRNvnuK5hVEBuyI/PphmstcydaJ2trpRa7Hk=;
        b=Qnk3zHKU+crJ+A2x16CBlso2Z2L66dHtg99JgSvGWoPVdi3oD1TI8bpqkU+9qBmIXx
         63DX89uCDuqQ6zUyNuZ/mdg73S4Dyi1j0ybERgjaMk1N736emJomzXKuAoZgJ0qHo36b
         z9XDhLN84DKI3CUPxKqHp1NDVoahEkHD55dbuAfDqa8L0ZgvK59AqZdQb2jsLWI0+SU5
         pQIGHNLzlCa3W2fti9b5tzNojGzEYzkqgKtdmalaTF/9uNnZEqtKPi1uoaZeWtFYay26
         wBXGyNrN9FEPKtrIEyGUaEtY66I9EDrC69ImnkYwU9TfT9XP9aZXUDYn2TYii8mvG5A4
         5PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380429; x=1742985229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxLqSbjgRNvnuK5hVEBuyI/PphmstcydaJ2trpRa7Hk=;
        b=pTZBP2nAMOdWCzHI3NWAOZIqdNy6hWdLnfoCa/ykas1RRJQIsD8Ie0kStuCkWctznB
         rmWtm1nMEdIA6hYizC9xDMfNZejyLdtMDk1ums8Ct5RktDUiNC5BJfEgQiPXXEba4Ac2
         jKRnYwpdfAnqtb8ebKly6P9jCsXNVGgHHl/mgqnwOS6YLPJNySyipEvhQmFGE41aphxu
         lcjQ38bXeO786T4dA1LEIqO8UIOXPv7CfKUzPGQXcHcJP66ylE+PzJESPPmeEng7Cq+Q
         IJcurKYfXYx9B+pW7mA7CneIAF52L+FpB79uhZMkcjN83Kx8Xp/0LAIwz59Aza9fXWSO
         EbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn4YTjThMj4cZUVLuAX3/3+TA6pq0STH+1H6QxA9ps0RbpCiFvMWKokfp0Mpb9ywttriU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BsQU/9Wc7/gDgFgeHRbc8r353x644sL+efxCu5U+hMRWTNAu
	ffEbzvlKERv+rG9cM84Yhlw6+xpTmI8PwRydo+g8qwYVtfbzGgcQ9s032w==
X-Gm-Gg: ASbGncsHfME2y96gHU+WCi/10juqapU27blhKuaF12PR4IIUtyKqZnR0KG9VGrZeAFK
	YddrPYuSGilXhUF5+4P/iG5YGE6FlFI+WKxVcxsLzFTSFYM+L+y6yu35UqHqrC+w2M3oFpgkVgs
	Rp6qPVeexIWhyp9bNZ8dTmozHjMB/a6+tUw9ruYsBjlYbJ+pjdHDdxvV5Lr9BOeVDPgm8sk/Z8Q
	ApMbki91iRxZIhypB/qm2C3dj89K1thkER6Keg6Ab3ySiqhoNSVkLuz+4wPm5cZ4T4tJOrei0pt
	2rfuunujb6Ydf8Wg7DspBLvOC7LmaX4a15IC6E0QlaNpjLa9ZQp/JNQPr6SYSbhXV4L/i5v2U/5
	tlzFGDhjfGKaMITBEIlGc
X-Google-Smtp-Source: AGHT+IHgf+GYWsGNIrY2x3ldFn0BOx1Vq45Yv4mQ/aAPfbQ4V3GR8Bv4+nAQLdmS7axV8GGP8jV2Hw==
X-Received: by 2002:a05:600c:1e01:b0:439:8e95:796a with SMTP id 5b1f17b1804b1-43d430cb2aemr19860455e9.13.1742380429096;
        Wed, 19 Mar 2025 03:33:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f864d4sm14875835e9.37.2025.03.19.03.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:33:48 -0700 (PDT)
Message-ID: <e4244e04-d2f3-43ab-88cf-58d9804731b8@gmail.com>
Date: Wed, 19 Mar 2025 10:33:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] bundle-uri: add test for bundle-uri clones with
 tags
To: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Scott Chacon <schacon@gmail.com>
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
 <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
 <d148b14c390f74e86bfa14c05e9e186fdcecbeb8.1742312173.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <d148b14c390f74e86bfa14c05e9e186fdcecbeb8.1742312173.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Scott

On 18/03/2025 15:36, Scott Chacon via GitGitGadget wrote:
> From: Scott Chacon <schacon@gmail.com>
> 
> +test_expect_success 'clone with tags bundle' '
> +	git clone --bundle-uri="clone-from-tags/ALL.bundle" \
> +		clone-from-tags clone-tags-path &&
> +	git -C clone-tags-path for-each-ref --format="%(refname)" >refs &&
> +	grep "refs/bundles/tags/" refs >actual &&

Thanks for adding this test. Calling "git for-each-ref" followed by 
"grep" follows the pattern of the existing tests but I'm not sure why 
they don't just pass the pattern to "for-each-ref" and avoid the extra 
process.

Do we want to just test for tags or are we really interested to see all 
the bundle refs created when cloning? This applies to the previous patch 
as well - we obviously need to change the expected output but I'm not 
sure changing the ref pattern is necessarily a good idea. After all the 
point of this series is to create refs under refs/bundles for all the 
refs in the bundle.

Best Wishes

Phillip

> +	cat >expect <<-\EOF &&
> +	refs/bundles/tags/A
> +	refs/bundles/tags/B
> +	refs/bundles/tags/tag-A
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   # To get interesting tests for bundle lists, we need to construct a
>   # somewhat-interesting commit history.
>   #

