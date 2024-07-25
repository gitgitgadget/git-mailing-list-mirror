Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF91103
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914310; cv=none; b=f54SJcq5M+H0fnVsAGtw8kDYC4O+wOVxibXDACq5XrR+GMu2GLmoP2at60YNugFaFR/BbVwNaLSBBxAce+dYvjthllz0YFpKGWAw7KCMBxiCrCalkEmVRloXByu1YUdafWfQc+7Q5w0eXqSxFMeOOVJUqUYWf3n/Z1n4mvVBXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914310; c=relaxed/simple;
	bh=enlZLLJYCtcIA0uQOu1pGUAR3KXWTCSnFmg4sNoQXwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APZ7qjddE8et/qC/mEN9xvl9NA2VD5Kzf/JZ77Rdz4hob2eH9ppSzJ3Mk3wOM193EJ9ljDkrmRiXKmag6vy/qFqYxGYOb/doXYMo7+p2MY/KYxp1GSzvw4rPFk9/9YuKOKiXgXumcmjwUZ9MSfgLf+P3qiPwKa5S7u3iQ8AuFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4ali5Gc; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4ali5Gc"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e026a2238d8so866193276.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721914308; x=1722519108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsbgTRUFZWRcD2zAmlrolNa3N+tZKg5ZbF1wm+EMyMA=;
        b=f4ali5Gci2Pci2uVG15p6BOko7spft7zhNlQyj7F3LhB/mSDaHbuaz6AkXD6uZZuGm
         SQ/WxS5qH4IRY0CrdMXSBpsMXsYZBSp36x8UntdXNAIyoX5pxqT2ZPwLzfGNYyhIv9ee
         Q9dWJfNvouIdZnUaTciMTji5EI7dd7Cq6XpR/gP6nkGguzTNhHCC6MXWVgg1edVtUi4i
         BzSWMa1cOVfpC01Y3p+VRYmTlX36Odi2pAPRyvzmh44UGYVd4MM+MZUQpxDK6vFspLYG
         jCh/a29NnWFRGh4Y0JeMNRTA4+Iaffc+EHAqI5k7I26dVMMazbIALCid38QEyaDLH1id
         IFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721914308; x=1722519108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsbgTRUFZWRcD2zAmlrolNa3N+tZKg5ZbF1wm+EMyMA=;
        b=r8yBQdaIUP50P3sHKgmhoKv5NoZx86qGUoUCJorq0jt54p49NbsmTiXh4ztdyxWiBF
         bP9+acG0bxpwcTP5jR6vKDM14WG/HcUCZCDDsbXwpVMO3BuZ1eu2XWCVuVsmN4RmhcUQ
         wyGGpWqcucEVGxAl7THdXYAjjevDodM6jjy9ckGxNiA2NF1f0aqmiuN1tp4qprET/F4J
         RrzkBQ91XGC4GpwzYw7ptW7LtSXagJMz/uaKlaQy1BtUJUX7CFlWPCM+0iILfukABOoC
         xBMSgp1py7HI6jpMDSnl1QRHCvtzB0maVJ5taAJhiqzhJHFZX8F9q51OlWfN4tMnqlrt
         tfqg==
X-Gm-Message-State: AOJu0YytXA0nabUSlb0dXHrw/dLn58j0A1NDcjds/g4MT4+Dj2Bv0yGz
	038/pWdzKSc/l8h4z3a0i7n98WqPQJB1OTa7FX1bBlkRthLXDXrr
X-Google-Smtp-Source: AGHT+IFog3CS0GxILlPidcpTjAwd7+a/zT+tc2LtDPU6ClfGJ8KaC+zJt0QfP3FC1yOMvRZjZ7haNg==
X-Received: by 2002:a05:6902:250f:b0:e0b:3492:69fa with SMTP id 3f1490d57ef6-e0b34926cacmr1222851276.54.1721914308100;
        Thu, 25 Jul 2024 06:31:48 -0700 (PDT)
Received: from [10.219.44.67] (syn-076-182-087-058.res.spectrum.com. [76.182.87.58])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0b29f4f74fsm318806276.17.2024.07.25.06.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 06:31:47 -0700 (PDT)
Message-ID: <3fc33179-cd65-454b-a68e-f1113926eefe@gmail.com>
Date: Thu, 25 Jul 2024 09:31:46 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ReviewingGuidelines: encourage positive reviews more
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqsevysdaa.fsf@gitster.g> <ZqH2DK83PoU2786-@tanuki>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZqH2DK83PoU2786-@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 2:51 AM, Patrick Steinhardt wrote:
> On Wed, Jul 24, 2024 at 02:14:37PM -0700, Junio C Hamano wrote:
>> I saw some contributors hesitate to give a positive review on
>> patches by their coworkers.  When written well, a positive review
>> does not have to be a hollow "looks good" that rubber stamps an
>> otherwise useless approval on a topic that is not interesting to
>> anybody.
> 
> Oh, yes, this addition is very welcome indeed! It's a painpoint of ours
> at GitLab, and folks were indeed quite unsure about how to handle
> positive reviews. I was trying to guide them into the direction of
> "reverbalizing" and "thinking out aloud" parts of a patch series that
> are tricky in order to demonstrate that they have indeed read through
> the patches and understand them. Having all of this written down
> explicitly should hopefully help them.

I'll add the perspective of my experience here that this is a good
pattern to follow. One thing that also helps is to avoid doing an
"internal review" for experienced contributors.

When Microsoft was first building up new contributors in this space,
we were overcautious and performed an internal review before going
to the mailing list. While this is good for a contributor's first
series, it loses the benefits of doing review in the open.

A positive review is great. A constructive review that improves the
series is even better.

> Except for the typo mentioned by Eric I don't have anything else to add.
> Thanks!

Same. Thanks for adding this to the official guidelines.

Thanks,
-Stolee
