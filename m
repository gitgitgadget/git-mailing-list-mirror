Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE67282F18
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791297429; cv=none; b=CmUmCTyKDYV0TwZ8n/8zo2bJZBgpa7yKH+b6sLH2evB90DeFrx/GFgy0G3K16cQOX6c/t3O3XD5kEnf2yJ0isyMHfnAl/DNtmFkknr0UuWcitc+eWD5sn+SkVPBBzNfI941PjvpeVROKU7gkr7A2E0kGWyUlMv956bfqRBVycr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791297429; c=relaxed/simple;
	bh=56qpm6Anj/JITmSqvUt3pToBKEBlRQGpAAkH5QSWoKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXt7KIFsG6Zo0g2x/BS0M7VRdhCgWmpKZehU+GjhimBDG8aQYtakcrg7JTPRhlSPQyAofHagixd3SS6a/XQ3D61QezNXtJj9rcYUhBg/iGhltOQi9RhQHrEH8lPm/j2Des2+yBf2CzSs6fbpOle4Euf7oT9I8IS3iYCXxf7c9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SngGEktA; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SngGEktA"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-677af43eed4so735301d50.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297427; x=1791902227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdrKyQAt2yIAmG/o50ti+XtFbBS2fnSNy+D5cfxhRLU=;
        b=SngGEktAwQZPTJOswIpXxH652yPOy6DKJKPzdhGAh7dAb9905EfgHCZ6gUgIwTjVGP
         QeaYnGKfnu3pFuDhMX2e3OqiLalksx4RotLCE/2oWNbEpKguvBEPuQLzR4TEZhV0hixV
         tY0JZuBFTOnux5J7BOfa1Bj7nhS9ghBgHipPxMPYLU43iaRkatdA5l1EZGQ8xh+lsOmN
         n3mOMXxwG3UOGSo5R4ELMx63CEkuZNNlqx/lgLYcHQFKw8L5dq8LBfw307bqUarIHf2a
         YzVTZVk9mrPuqbo5ADcmwMLoAcszaWsA7uPE/FIzSbsLpaqDUm9sXHJ608BiqlWgq3X6
         9bxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297427; x=1791902227;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KdrKyQAt2yIAmG/o50ti+XtFbBS2fnSNy+D5cfxhRLU=;
        b=rfRM/l+jEhXWCew/zGC+OmRXywVllh2IhTAV+mk7XinXa7let/Gbf3nH5bb93FUsKG
         Axc18J7nMq7iQGP7MRNNF/hZ+IfIu7pY8kEKfpLv7Z8qmwChzumTvY20hk9CMja6T3Gl
         2sCrdUCxQsaD3r7muE41vvqLrygIwr/lR9ShK09U1tCtxu3nB5AnK8r+6QOOCTmM6fyE
         Q7ssZsEs4GvOTDW+L4JKOeFQTq8b2O/gnuNY9KHNLMeG4Midg1sRxDZlm+lrMvXy2YS3
         Gw9iUO97JsKzlw5fwd5S1c/YnnDI80G+10qEl35TdimmoLuMclgQmv73kCPk84W7hB64
         EkMw==
X-Forwarded-Encrypted: i=1; AKwUvBx2RQtx3W4lZ2xr8Y51HVZmmHtcYUY+EZdjiPQfWpBmFuu62nmE1Xi+PxuNKR61hXib37w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLST08BFOWejVpW9a14rIiTUib3HrCQfaho99fLD81wBMZL9DpY
	RiT/B3MyaqwvmmVDy8lzHw7BgJUYdha3jwvdi3hR0kLBc32BYCHP7Vg4+YAKTA==
X-Gm-Gg: AYBFou2qdmokbyofXnXpcblrTV0iR7YJmwNWJDjcwvZjcSckwus9EZRk3dRXlIh5/sJ
	ivEGtGx1oEshNe4wfqh6lwjRNx04sr+BiaZK3rzVrqkrL0OIcSO4ld2K2e4A1Qs27KtIeNfmnsO
	ulUFPSK61+O9YEgTwZZJoi4q4aqKFHt80v5BBfgZWhYjxGZfUsHO/XEDFhE+IZSXqtyNj0UZKzG
	Y0CVK0lcn+eg7WR2BYP5w4ZOcT4QdP/JDa18On2gV4cOVK+Fjj6lgMg/GOIS+Jcu49rad9qulO4
	ia7YVethi9KX1/P1JdCF7UTuYzHTZSStnkwLuRLsFhKON/nJM9EKXrAb9rhqZymwSNQluFIxrEz
	vpb8SHpfFA9bXOUvJUErib9MfVl8AgPlrmw8POq9qtbGwugbev4wqO8s39SRxA6CA5PDC0+Jo6R
	1BxJJMZ525qHM0VA6RLirWS0tKc64bhhPRtcI+TvnSx8+tHjCUj+OcPkwbEeqiROEiCnkLk8f9V
	RlBF0KSxTCZiPyDvz7aHVhctk48tQ5u+3Y/jYJTmKf92tmtY+dMzCgD6KLcX03KaEm+kI1j300u
	JNfpZRYtL8lt3Xq4Oc9pAH78wmrg7liBkFzNnDBmY3XgAoRReYIARvnqEhbNhfHadq9q9VF6ZlZ
	jROA1Gj6B+pAeG66v5mHVqMoo
X-Received: by 2002:a05:690e:1697:b0:677:c78b:f5c1 with SMTP id 956f58d0204a3-678fcc4ff8emr1056297d50.4.1791297426926;
        Tue, 06 Oct 2026 07:37:06 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67906b33358sm53083d50.13.2026.10.06.07.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 07:37:06 -0700 (PDT)
Message-ID: <77c35daa-1b28-4248-a203-3fd9c23de76a@gmail.com>
Date: Tue, 6 Oct 2026 10:37:05 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] trace2: stop allowing die()
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Taylor Blau <ttaylorr@openai.com>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
 <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/2026 1:25 PM, Derrick Stolee via GitGitGadget wrote: 
> This starts with a new banned-die.h header file at the root of the repo and
> including it from all trace2 API *.c files. It starts empty, but the later
> patches will add one method at a time:
> 
>  * xsnprintf() : This is the original patch, but made more complete by
>    adding the method to banned-die.h.
>  * xstrdup()
>  * ALLOC_ARRAY()
>  * xstrfmt()
>  * ALLOC_GROW()
>  * xcalloc()
> 
> During each patch, the goal was to have the trace2 logic be "as correct as
> possible" when an allocation failure occurs. This may mean that we have
> incomplete messages or dropped trace messages.
This topic has sat idle for a while, in part because the protections
attempted by this approach are incomplete and thus less exciting than
I had hoped. My RFC for making strbuf and friends more robust was
similarly unsatisfying [1] but there are some interesting ideas as to
how this can be done differently.

[1] https://lore.kernel.org/git/0f466dc6-f9c5-48ee-bb94-f3e8a951ee5d@gmail.com/

Thanks,
-Stolee

