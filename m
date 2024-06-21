Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94C824B3
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965175; cv=none; b=Gkn/geAxhCjry7ciksuBBhZVV9ocRv5cQ8Zx1QdkQnM9eFpTOZ7tYotqrh8VLIvEJnANfQ0VaX1BC108s6R8vhJBihZYju2wEBbwNIbeouPbHDFuHHBGlg0UG0DAkwU9Qtdso0Itk3tsgzBv7qF6uo497hxRoSvtpDHnUYWjlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965175; c=relaxed/simple;
	bh=rjVJ8srFUeu4u39R/0MEu2m6xGYQUQDGTSATsGUvSDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQHzO+miZ+HcbcXh+W6rwMpSubrdc3ZAr1tMMKBx7Ig14FN/avnrWEud9nQfeR26Ai/OHYNhHlcH5LdPxP5p+9Ut2YD3Wk75/07U93sxHAoPeb79LATbWK+OuzWJ2OfnT7iXOwAnrywDm2z/0L7LwlQdjWBif+h2J/Aqk4i+sZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZTO9DQN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZTO9DQN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3632a6437d7so1101998f8f.0
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 03:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718965172; x=1719569972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk1A/bfOXTBLFyG9dV/Uqfm6nLtwPBLsDvx8o2VbwD8=;
        b=YZTO9DQNDCSgWB4/E4uNY2DKgOpbjLI1+nZvm9t4ddNU5ck9Lyrp17TKbO/mhcwJdP
         VIQm5C8HNeWD2037u6mnGMf1nuZnVwEtcJ7815qh/9zyCW1dEUcu+RSwhO/QwLNlD77t
         /cS0sXsfJMY/fcZr0hv1tvgLMKlxtmMdfBJYoXD4F+TISPEThTafggyZLEZMT71rbgLT
         vUX/qKqS94z+lQSSa7aMfyD6OA0OxhRQn3lIimFYeGKnJI62w9KPqdQQqDWtI4HX2oe5
         lHo+mJqdFQN6fxovU8nWPAK4x0s8xOIYlNvWZqeJIb77BkZRiHNC4UBlvmcRL/LtsBYi
         0QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718965172; x=1719569972;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xk1A/bfOXTBLFyG9dV/Uqfm6nLtwPBLsDvx8o2VbwD8=;
        b=jQ85+hc+VIxazSKdRlZvbcBSQx8D4KP+vhpEdrtSjRNQyQx9tR/YULTXVNVh7ZRQd6
         OJWpR863wzPS0mk7qc3qrFyTpSj35Epu658ix4DHONqOHQhnTRgltjZyFIc+dtXHUjbQ
         gudL/TByx+rREft8jvygBhBX/0fh642A4Taj1NQTs6iPAiUuqJcGTbytCtGVsOKOLpbo
         r4VZC+hFdADSjetDGD7W4XpGaWWY8D8Gnov8ivYJ5Qu0noE9t0I8rNC4OI9MBSVc8Doc
         KdPC9oJJ5t1Q7axJmE3mEPVQHp8hBEhttchn1MgQV0KgZB07Yh9NVxuksCB6cYHapwtM
         vN6Q==
X-Gm-Message-State: AOJu0YyH1L1IDDbVcvZzcik4VuNipC0PyyfBYo8CCTg9JkNhnYrqTToz
	AOleIkxeyou4JszARR2VYRFItG2X1Cqv1yuuCRbAF/0BSvj9MHwWsGbLiA==
X-Google-Smtp-Source: AGHT+IFJENpJvu/3kvCqkBMyr1/0fg/5IC1coR4Ai7wYjhmgD088/lBq6q4b3SysBV1LBvTEf34z2w==
X-Received: by 2002:a05:6000:45a7:b0:366:595c:ca0c with SMTP id ffacd0b85a97d-366595ccc2fmr1088627f8f.24.1718965172043;
        Fri, 21 Jun 2024 03:19:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:64f:8901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3663cd5fa47sm1294929f8f.0.2024.06.21.03.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 03:19:31 -0700 (PDT)
Message-ID: <6e71b1f3-599f-49c3-be37-e499f28983cf@gmail.com>
Date: Fri, 21 Jun 2024 11:19:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Thoughts about the -m option of cherry-pick and revert
To: Stefan Haller <lists@haller-berlin.de>, Junio C Hamano <gitster@pobox.com>
Cc: Git <git@vger.kernel.org>
References: <e60a8b1a-98c8-4ac7-b966-ff9635bb781d@haller-berlin.de>
 <xmqqa5jfoxvh.fsf@gitster.g>
 <dd58a60d-a551-4726-85a7-f47b851914be@haller-berlin.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <dd58a60d-a551-4726-85a7-f47b851914be@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/06/2024 07:33, Stefan Haller wrote:
> On 21.06.24 04:03, Junio C Hamano wrote:
>> Stefan Haller <lists@haller-berlin.de> writes:
 >
> Hm, in all example scenarios I experimented with, picking the wrong
> parent would result in an empty diff, and consequently an error message
> like this:
> 
>     nothing to commit, working tree clean
>     The previous cherry-pick is now empty, possibly due to conflict
>     resolution.
>     If you wish to commit it anyway, use:
> 
>         git commit --allow-empty
> 
>     Otherwise, please use 'git cherry-pick --skip'
> 
> I'm not sure if this error is easier or harder to understand than the
> one you get today when omitting -m, but we could probably improve it by
> mentioning the -m option if the cherry-picked commit was a merge.

That might be helpful - if we do that we'd want to make sure that the 
user can retry this pick with "-m" without restarting the whole cherry-pick.

> I'd be interested in example scenarios where both sides of the merge
> have non-empty diffs. Won't this only happen for evil merges?

I think you'd need a conflicting merge that is resolved in a way that 
the resolution of the conflicting lines doesn't match either parent. (I 
assume that's what you mean by evil but I thought it best to check)

>> If I were simplifying this, I would probably
>>
>>   (1) disallow cherry-picking a merge (and suggest redoing the same
>>       merge, possibly after rebasing the copy of the merged history
>>       to an appropriate base as needed), and
> 
> This seems unnecessarily restrictive to me. Cherry-picking merge commits
> using -m1 is useful, it's an important part of our release workflow at
> my day job.

I can see why people want to revert merges but cherry-picking them 
always feels strange to me - what is the advantage over actually merging 
the branch and seeing the full history of that commit?

>>   (2) allowing reverting a merge only wrt the first parent,
> 
> Interesting, that's what I'm considering doing in lazygit (except for
> both revert and cherry-pick), but I kind of didn't expect much support
> for that idea. :-)

For lazygit I would think it would be fine to be a bit more restrictive 
that git as anyone with an unusual requirement can always fall back to 
using git for that.

Best Wishes

Phillip


> -Stefan
> 

