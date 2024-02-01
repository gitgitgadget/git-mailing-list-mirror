Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268F5D47D
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796159; cv=none; b=PzuYFp62oJZ0DKqmfKTjjfoh7ZdAg/fmF2VBhUIJ2Auc9BuUFeqwdXiEW0Ra8aghVosqNxqEimBAU4V/n7SmWED4kHHV4UWSC5CjDTRYqiCcXFQ39fEpH+8ZbtLSW0ew5qTmDxMmRBT5vFpMayfoWBiUibzn/EIgywKwiVcwPaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796159; c=relaxed/simple;
	bh=v+VQThbLcZwCXqFNg2io5NW1rHX2/EjQxKJFaXxh0hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZYbUql31J+RLeZ1Qq4QONgo4OuAYRWeno4jD8dnkC5QmjqUi7a8HBWSDRoBx+3Nol8lnrlr9R0CeYLov1HB23qRljJMW27z0QLad+MtvGjtt4BnLbiAdu2ckP8yUPz0WIQQigN+dv0PzLjlglGIJmCdl/wZWCIVKovZ7EveaZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMtOMCqV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMtOMCqV"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso8086705e9.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796155; x=1707400955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qtEb3uPG3Hk6+9WlQSE5UxdHjHDsx8KuYQjL3t+wURo=;
        b=MMtOMCqV5BcDLTk3PB0oOC7Hi+s6Wnbyaf6P0tbbvMdtsUCj+vBdggMoi4FLepeL0r
         J4QdtDOBZPoV5/2b4XR7bpHeVru96iGZrreUX+lrwFJeYVPQIQOB23qvjdHyfuh1k/aT
         cCP4w9bP3lQ9+Zq0S2NIZd67Ko9UuE5uNzW06QozJ76dp3v0neNflCsl1Y3o0VWAnf3+
         5FENwDANKAeJ8LT/dg8/dkhCiuub6+x1sqXuJRAD0vZP31YAsNEVNeVzW5XNA8WnZz0C
         hhMoxC9WZT2/gCBi8tKwRI5QWF7bYwCXVOM1l5cltI6CW5/n2Jix5fqmiqADfpLhl5ML
         FmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796155; x=1707400955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtEb3uPG3Hk6+9WlQSE5UxdHjHDsx8KuYQjL3t+wURo=;
        b=dr6o1hxj7uC9KpEJQPne6Ca2FMo+c+ScwqQfxqPgZMLr/xpO56HVTKe8H6WntLpnAf
         +Q5M2MVWFIXFn/xiuHgn/cELkbSd8CklH8B4uoh+i3YaarHtGE079xQ2/cqaGuomTlEO
         eb3toTmrf0Z+Pvm9dAp4jYVG9IMaihU51BGz5SypIWpTnZ0b21iibqfVGUODoBFTV29A
         eEqzsFlgfU+ZNN3WDh9oTEUjiasAbeSfQwmSz66IwMInK7MElNkKaDerNigMcp9MbXSl
         KOlyfWmo3zB33WzXJphzO1NhBiQe+p2tzZXUJ9C9FandW0UOofsHao/vjN47QK5PyvX2
         5XaQ==
X-Gm-Message-State: AOJu0YzjPg10Y3nuIhHTVGxk+DgYBgAG2umVNlOTvxPTYIbOSRyNcPFk
	DnW6JTHN+/vLPwxI3sLXWO3l7O2jZPsST9HG+qffZyGuPbYXkA6j
X-Google-Smtp-Source: AGHT+IHo12rCGJ5N4FZ3I7ttKznD/iAoCiG4p/A++WMgq7mLdmkSh83OJLASaGH6YEwAVki2lmjI0g==
X-Received: by 2002:a05:600c:a3a5:b0:40f:afd6:b266 with SMTP id hn37-20020a05600ca3a500b0040fafd6b266mr1821759wmb.18.1706796155436;
        Thu, 01 Feb 2024 06:02:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVAj3mmrR0btl3qQPqkxPxhbTj0+cvdNU5CqACZsgmnVv5Y1E0Sbv7qIrEXfEEWJCcK8c/3qoHCOodog0xTbmZ4xAeZwC4pH7y21p5UMndHZYeeguNuPhbq2Y/BKeNhlAFpR3fa1sYb4HuCU81V
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id o7-20020a05600c510700b0040e880ac6ecsm4595341wms.35.2024.02.01.06.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:02:35 -0800 (PST)
Message-ID: <20b6c81a-b1cf-4d10-980b-94698d7e62aa@gmail.com>
Date: Thu, 1 Feb 2024 14:02:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] rebase: Update `--empty=ask` to `--empty=drop`
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-4-brianmlyles@gmail.com>
 <7032ae96-602f-499d-8430-a5dc3864d1bb@gmail.com>
 <CAHPHrSefHb7KddWNS4NS2bAFG9DFfKZ=Ue499+EqDT3myS_tEA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHPHrSefHb7KddWNS4NS2bAFG9DFfKZ=Ue499+EqDT3myS_tEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 27/01/2024 21:49, Brian Lyles wrote:
> On Tue, Jan 23, 2024 at 8:24 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
>>> From: Brian Lyles <brianmlyles@gmail.com>
>>>
>>> When `git-am` got its own `--empty` option in 7c096b8d61 (am: support
>>> --empty=<option> to handle empty patches, 2021-12-09), `stop` was used
>>> instead of `ask`. `stop` is a more accurate term for describing what
>>> really happens,
>>
>> I can see your reasoning but I think of stopping as git's way of asking
>> what to do so I'm not sure if "stop" is better than "ask". I don't know
>> how we ended up with two different terms - the prior art is "ask" so
>> maybe we should change "am --empty" instead. Lets see what others think.
> 
> The suggestion to use 'stop' instead of 'ask' for rebase was initially
> Elijah's[1], which I agreed with. I am certainly open to others'
> opinions here though, and am content with whatever is decided. I am
> mostly aiming for consistency between git-rebase(1), git-am(1), and
> ultimately git-cherry-pick(1).
> 
> [1]: https://lore.kernel.org/git/CABPp-BGJfvBhO_zEX8nLoa8WNsjmwvtZ2qOjmYm9iPoZg4SwPw@mail.gmail.com/

Thanks for the link, that is useful context

>> It would be helpful to mention the tests in the commit message - we end
>> up with a mixture of "--empty=ask" and "--empty=stop" I assume that is
>> by design
> 
> You are correct -- the intent being to ensure that `--ask` continues
> working for as long as it is supported. I'll add this to the message in
> v2.

That makes sense,

Thanks

Phillip
