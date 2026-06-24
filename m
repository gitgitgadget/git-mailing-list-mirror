Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36623BFAE7
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313676; cv=none; b=fBouxY0Thc8eqcjJTyELIUJPy2yodaR+wau+DFDsaBHpXzv41BtsVAjej325+70GemQSQHIrPhLfp2eiCx5IZCDFdmQCyho41FnjSoDCmvCIKY0tXas4diddW8cCw3wdI91ODgnQKl7PkSjwg+UBY9FiOV4s13Fux2BUkZjknCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313676; c=relaxed/simple;
	bh=FaY/KBlH5DiehABlJeqPemHfEEc6vKaUhvTnKxYndzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrW8xPkwwMf9p3s5xfxYUkYOBjOEdb4+sYyjJsNAJfjeKYf31dtGaxQcXOar8WZgF9VXXCLdq9XGy1Q5tWsit7Tmt6Y367KQH6ZZkBQNdLuQECaYfSsHHp16i3AX6XU/ZjvJFwOlm+7Z27ad3vuF42BsJtxeOHV2iMlSto1+dWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ1aHwPF; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ1aHwPF"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-966801d093aso412037241.2
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782313674; x=1782918474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05n/Es3bhd9BBlcPuDKCCGHmYU6qV7yEiwAmLO7FWjQ=;
        b=EJ1aHwPFqj+defM+KVLkfXsTqxJNJlc9VxOj2X78z1bBi4zHDv4iyF79w8xTU6Q4mi
         9GQWmdFaSTCLa5giwGAhmEEMW1C/wb61SvZ7KJieUQ9/ziZK0kuM2yg5ttzSKvQ0BG62
         sPwFwAsBuSRV2ol9Yg8zrQMXJjN+Z7R4NR3AyVuCO+iuPDBUiDUECSkgqGQ/1gQzLJbX
         qNlMdfBSc6afYADN0Nx7p3IvQhA6FjbO8dtNldukUwWePJHLFf2uVMcalCKbmyvPO6Jh
         P/112FCjUo6SyeSSJYtg/gTvi1S6DLD7oQEFQGnNmAjyPfyz2aWAqIYg47D8reRNgcbj
         xTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313674; x=1782918474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05n/Es3bhd9BBlcPuDKCCGHmYU6qV7yEiwAmLO7FWjQ=;
        b=EOmBg8dy8g2QmmVEMOcQyoGbKGh7A5R77OySzpcRTjc9DDwb3StxCzWOJnHY2x29YF
         AY7rbXBQjUbBCBL1oFLckVF5y4X03FxGJFNafRnnrzwczUMwR5jvJFrqJWM6OFk5IS4t
         I4tkIUOOx8Nf5t79dH2Tr9mNM4jbv8HfQ62W4TG+W+h0FmOlLolGxu2LTAVYu+nmZfmX
         aAmOUv84umBMfX/iJKkvv744tw8pDAdbWhxj95Z4O+7Vp2MjXC5HfIFpR0fzymlGqswC
         tqFMSyQlb/NuoRApEGLDvHfe3oYJWiNJJHQJQ4ejgnxNL+L/iWVlZG8rP645M0vw4sLm
         2nvA==
X-Forwarded-Encrypted: i=1; AHgh+RqjXbfbDkyTHobjr7Tou2ODpbJTnktBDJp5CRQeK5kB9qKjpBGgEpAzLIzFBAeNcqMmltA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Qmk4wJ8vQ4kVpVbUQtyg9Ls5eAg17+GQ3fTI2FCCEzlq0vYB
	7Iza8aOdbcfsOYLA92JXtBhMD0F2/brUSeqBn4zNtnrqgi5npzJjoHrvLKWuygpi
X-Gm-Gg: AfdE7cmoM6uYjOSQolqC6jiaRMqoe3IV/e9RUrxTPB4AMc7wY85b6tVbxiR1xxyt4gn
	hmglw4rM/0GElZigvP61Q7ZggqIrX3W9fkOKlpe1SsniIAKRhg+rinf+RY4PUXUP1//d1l6+dhA
	4ISvt/O5Po3N1EwI0gTKVAfSxxUUMT/mAJZ8KPs7LBnq23eEVABCqLI2CWTXhoopnpEf+r7UdvH
	7WezGFSv28IofdYTnkUlx0u1MF/UNNKVVPD5usRfyvnV3GdwVYQtrJfDcVk79Cwry4wr8lu+SBo
	our8HR6xs/T8SwUhe8jhdyBmYbLnARBtS+VywMc48uybj2KWfGvXvBJK9cmQxfThezyqjRfD1Q0
	m1Ozo7xyL/T23/CvVsX5zonCP0EDx7gSNdbJvRdDHmDi3mOdAXAa+mJPD97eqZh7NOoKntBDZVI
	JtqR998D6zFgVQqPIxhCWcvOWwtSlcyYET1FCVdm3y6L8sSQgkRxWxbXV9oQ==
X-Received: by 2002:a05:6102:3f8f:b0:726:f965:722b with SMTP id ada2fe7eead31-72fd7c4f568mr4312275137.21.1782313673751;
        Wed, 24 Jun 2026 08:07:53 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ac1b8sm561776185a.36.2026.06.24.08.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 08:07:53 -0700 (PDT)
Message-ID: <943b9360-68dd-404a-a129-6f857b3c16f5@gmail.com>
Date: Wed, 24 Jun 2026 11:07:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <d84b932e5b078edc8255b6944ecb67fc1aa086b0.1782303254.git.gitgitgadget@gmail.com>
 <6b0d81e7-7617-4fb4-9e39-cdf8bc778837@gmail.com>
 <CAL71e4N1zMz=v9umGdGPTvLP1nF-tNLVQc+vAEBnekt2L0b6zQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAL71e4N1zMz=v9umGdGPTvLP1nF-tNLVQc+vAEBnekt2L0b6zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/2026 10:47 AM, Kristofer Karlsson wrote:
> On Wed, 24 Jun 2026 at 16:02, Derrick Stolee <stolee@gmail.com> wrote:

>>> -     test_trace2_data paint_down_to_common steps 81 <trace-half.txt
>>> +     test_trace2_data paint_down_to_common steps 57 <trace-half.txt
>>>  '
>> I love to see these steps change. If you take my suggestion to
>> update more tests with these checks, then this diff will get bigger
>> (but in a deserved way).
> 
> I will try to add them to some (but not all) tests since it's more
> closely related to performance than correctness and I want to
> avoid making too many tests overly fragile.
In this case, I think it's more about protecting all of our special-
cased termination conditions. The rigidity means that it is hard to
accidentally change the behavior. It does have the downside that
more tests need to change if there is an intentional change, but it
also gives the same _evidence_ that the change has the intended
impact.

We are definitely leaning into personal preferences, though. There
is no hard rule one way or another.

Thanks,
-Stolee

