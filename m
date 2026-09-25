Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D44DA9C7
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351914; cv=none; b=JI6l+yhrZdL9LkDI5/RtwJIhVyp/u8ALrv+8XDuPFCtrpQBwr9g94ioOgWq3mo/nJE9oNJ4maGd/RCvdjXsRHkIEPUgu0sMNp9fhw2LXtu4mn6ymoL/8TOtsoATGcAyYlxjXz+KXGL82xHO4bVNW6c5Vc9FmSUv0RjOjNufWzBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351914; c=relaxed/simple;
	bh=ibt31RMusMAj/e9U8rSrY4dGz7Tj5ux4h3N32LqPrzM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PVMVeY3tpuF5pWP8k4fcpfpemVZ3CbKx2OZO0F78PPuIKlPr6FJx6tkypB96/JLwrFGnJTLtHNjlSwBtZLqGBcp7SWit/n+KfVhOVMfxxX1Uco/RC3DhX+p6nZLN+s4TwGiFjpDhfhpT3RQ1LVC9KALBsQbASfCFVhQT5vAEIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=suMkX/25; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suMkX/25"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4888129c46eso431623f8f.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790351902; x=1790956702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CDq9kvenMrzh8LROpFU7yrImls2DPXrO2SqSlAk/+s4=;
        b=suMkX/25FGla2I3C7UL5Q3DhIeJ16GDl1p2kQl+9dV96NPDi/Cz/usOAxuNTXVJiVQ
         zza3X7utrgvNTkk4Ln62t+HiwxnSkBSXYWiFzSRTNtPznoFYGaqPqbkoKEes6cbp2f5e
         gb90NXl9J6H4dUUoVumB9fjenp2KIoHSbnqJUPYnjSr3RVGOxABHq/EqSl8fhtICpxPW
         0WPXwbshIsF35n40HdMidYGN049M459ZqbfKn2NYKHJ7Cw4xb6O7fwKgvuNC6xvh5zsV
         mMhOjRe+zMOQbvfpYMqzQVw8nWBjZflK/4fvuhlrtsgYVv389IBeSNCnrUXOnI7FtFED
         mHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351902; x=1790956702;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CDq9kvenMrzh8LROpFU7yrImls2DPXrO2SqSlAk/+s4=;
        b=0tZX6nYN7c67vg0mg+n3LRbFDB8KWrD/fNNa8yqXjxuvvQ0K61ubd0LjaO9mVIknGt
         HHQDIPi5VW3sw/ewFz6Y2rkxF/peY5b8qUxfXZTjaYhZPQcXQ4iqO3mbpM00xv1cQNIQ
         t80i+HBHgSL3ssxDjtjlaohdoetXTvOEdC4+LUxfbZe0OJLDXvAkzSoQnq7VsnY/tAup
         4ChUbTbVIk+sCi5sTfEusTHEejTP0qDAjHbdeHmSRMWVDDRiWkHzPf6kB7eq5yCUElvo
         QWRKESV2GDYb4g0C7ZwmNcUNNf5Hpz8JVzDPl83ZSZrUf8K4nNw+ht4osGwp0u7v4vp4
         mC3A==
X-Gm-Message-State: AFuF++nwVwg686bXw4A0gKrZI7Hkh4v9RVsGGKjLdZwXGGIBP+oOyLaM
	CpW9NuSdIZDt06Pe22IHoVlg65WmNSWZYaUFke3wExdS5SKhXtUKtuvv
X-Gm-Gg: AYBFou3lru3tqWgMvQMJ/9AJ0Wa7QuvMLusQBJ7RFQkGhmcGohZTJP7jbMRyEGATORr
	4GMS1HvdIp/wR8ceScoDaerjUUAas7i5bqIcHzzlcvukoZN1eP5M1OLeAzpR2ifSv+fruzK9O3B
	gJjHblZ92yRk3v/imHtfU5hA9Qx0tNbyp6yFhJ5FQMjbzmQaHMN+9EeuolfY0yfxIeRYi+MsLYY
	P2wVlC9gWzhfJlvvtbhbQ/7jH7wSGilBO1ejPm7bLeVjWYILpSKxaRLK56qGuhKhNRL1QaaP0PC
	JwS5jlHmE+xw6dFNuILaUBzlx8NpJug5h8KaLWy6Ex1tMY7eJC2nbE3DpnUize8J9mTWEuBYVPV
	mfQVvHfASMrZL1qOydmJBsDhqZq6MkYYggINKJEFc1y30pEv0F2+t/k38IUcJmcHwCZL/I7lEF1
	RBqCovb0b429Dxa6NtFX/sgt8N/IcnxyGqgj+XRZKUbCKKS+/ZPsWAKiipt3I7U9RsTantxnRSd
	cJxsbLVLf2+WW+v+yYEmvZueuw7KG5aOXxgicIS0dxKejo6V1fv3z8=
X-Received: by 2002:a05:6000:186a:b0:488:84e2:cb0b with SMTP id ffacd0b85a97d-48884e2ccfbmr45645f8f.51.1790351901964;
        Fri, 25 Sep 2026 08:58:21 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a4e9sm6884876f8f.11.2026.09.25.08.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 08:58:21 -0700 (PDT)
Message-ID: <36e1073e-fa55-4d7d-8b8b-ba9ac34976fa@gmail.com>
Date: Fri, 25 Sep 2026 16:58:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>, Adam Johnson <me@adamj.eu>,
 Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
 Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
 <68e83baa-6ccb-4ca8-a1df-f09d51749c67@gmail.com>
 <CALnO6CDpS9GQfONKJs=LAUvwYzYyMby+rGAUtvFQruj-ERXt-g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CDpS9GQfONKJs=LAUvwYzYyMby+rGAUtvFQruj-ERXt-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 25/09/2026 13:55, D. Ben Knoble wrote:
> On Thu, Sep 24, 2026 at 5:42 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Sorry, I missed this last time, but we should finalize the merge before
>> returning to ensure the allocations in result are freed.
> 
> Yeah, I think CI caught this:
> https://github.com/benknoble/git/actions/runs/36033463504/job/107747745741#step:5:31
> 
> But I'm not sure I could have understood what it was telling me
> without your hint, thanks!

Yes, that output is terrible - to see the leaks you have to scroll to 
line 28282 of "print test failures" which is ridiculous. See 
https://github.com/benknoble/git/actions/runs/36033463504/job/107747745741#step:10:28282

Thanks

Phillip>

