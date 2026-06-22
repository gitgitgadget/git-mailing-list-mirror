Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B095228CB0
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 18:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152107; cv=none; b=VGiW1uRAJMlhODoj6yQd0UjApXXqeT8g014jPPJ9AccYyAy13/pLH4fEvnVO85LPUQD2kBxDrftKDTHo73o0ZGJ5u/ZIrLduLwQCxrdzTRuw2/ghWyp5Q51bBl43cc0LC09gEa4JeloCzaDLsf+rklCPX3zeoyoJ7B4uGKrDLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152107; c=relaxed/simple;
	bh=Im9evNCxbDrXnOArFFqRtbfA5F3tj8Iad5mVdB3r/qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDEC7S3fgc+ueyehKFd8B3aQ2rjSvCGStpCN/2/kroSm8FRdw//dXbp+01JOJ6eL/RFHHGenVEqEMVKrqmtFAbMS0wlDmXiBgB4i3+qbnCASpiAOlEG9cp/xfKApatDEDUV1vwFPktaj3OzSkYDszEcgZNZIaoWyDqXVvRzs8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks2/U18D; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks2/U18D"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8de412e58edso42370306d6.3
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 11:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782152105; x=1782756905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0mjRwUm+DIr3gJLs4msPE8u3OdAIf88pjdDRtdpedU=;
        b=Ks2/U18DSaPLXPGvrkzT8lALw4d/OaMxPDqxj9pTFd0D8+XFZf8fVxCRvg+iTmLbP/
         y9W5FQLa4T5FycTMC650M7O5x24pzdimJcEw33jEzHm3D9e31iOXP0u0gHFM4Oi78BYy
         gUIVHpQslzykWFbfSPiGWsMGpdH/k20DGAaymU2jRGX2J+qs3XiskzIKqOpXnQfi2KyT
         JrzdYF3Pmpnx90JXZyBh8MGZQW/5OlJPmUl3h7bQDY6K3gQKRTcRfkbIp/pUdaY2rIiV
         b+wVxhg7Fg8ocB2Mf2n8L+l+uxCP889hecKBIfeJ1JdY/pBxI0c0OXUAaaf1LPwMzRKs
         f9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152105; x=1782756905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0mjRwUm+DIr3gJLs4msPE8u3OdAIf88pjdDRtdpedU=;
        b=QTTjDWpKT7lwfH3+r6jfPsC1qkljAF9Onxyh8ODHRlWyDUWXT3xpnLkwwno2nisnNo
         0s0/WhM2+S0Zct7BSmtYvDeLLJFmJRH1jHMg5aGvAdL3Mwclh8x1fpZSRPHWBaKpi4/5
         mAmWIta5ZxnV75eLjYWhm7BJZTKlp2wRRTDMD41sL2A7yGZxEcLG0qqkotUUPQMtV8vR
         uS7isnEHu3ANcCXqW1vX9ruglAFSwXTMl48bETJPxZ6qpYp1sWkiMQfe+0XkKxKAzpxk
         ARX1t3wnJOcdMPlbt7xyLqcMihkL11VOSy8m87wctJwPLQiKacyvK6oBaqxG+MvqBhBv
         JtkA==
X-Forwarded-Encrypted: i=1; AHgh+RrnDQW916+MLryr7ziaAUqmrAwfSDcYpESQm5dj+kQXNQCVIrzYsvfxM5GRioXBsi/k2Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYoGE1S/vqCa5QTv9W4cNKp/DaN5s6rOpSCHdkoJCszuXkzWQo
	MMpCmP6ofAPD830oqhY/zP/Mp4iMxWMviIzGf7PRQ1S/FfW7HeGTK45c
X-Gm-Gg: AfdE7ckZQuod7zksjZWI7tDOHdA8Zj40tU5UVwPWt1teNZpLbtqypRn+4WefGDAwF5c
	buqJYFCwpj5g2dkpb070TbO1w3du7owyb2rd+Bbe7/wOtpon+kNHpha53IfPG/Sw6ESIMrYzQuR
	TFR9ujq0Ggg+sZAI6IjmDoNeHlBnxefCTYxSIML952DhVy4uYoG/oc8uDNtU1TSlm0VnvCsZOHX
	EXTKJtAB5Bd2/nXSXBTE1M1OEhn4TNfEqAG9w6hHq6npjdclPA7n5D0zLsfgzxUdb4efRviryWz
	S8HM6bW7XHnWTbFT/Ff8tlU5C6yunQPXX99O7F8FGTif5b8ZZkku8m/1Xo2FEY8GCQzDTwO50mq
	4PnzdXOTF4pPwty/rF2B+CutR1EwYIRr4hh6lU0G/ULTtMXueU7TWaNTbVeBpe9w/M+hag+981W
	MZ6+E2E5WZhYcAEhHDg9pCyy5YNiZ/w0Q1mkcIrRRZLcgApm8gcOSN5rJXmQ==
X-Received: by 2002:a05:6214:202d:b0:8dd:f14c:1dc with SMTP id 6a1803df08f44-8df8ef4840dmr219652276d6.1.1782152105082;
        Mon, 22 Jun 2026 11:15:05 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde4b3sm100785096d6.28.2026.06.22.11.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 11:15:04 -0700 (PDT)
Message-ID: <1588b53d-9576-4752-9459-da48276e4b2a@gmail.com>
Date: Mon, 22 Jun 2026 14:15:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC 4/6] t6600: add test cases for side-exhaustion edge
 cases
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <91372b975fbe102538c05c7d2cdae356539d1bbd.1781951820.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <91372b975fbe102538c05c7d2cdae356539d1bbd.1781951820.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/2026 6:36 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Add test cases to t6600-test-reach.sh that exercise edge cases in the
> side-exhaustion optimization for paint_down_to_common():
> 
>  - in_merge_bases_many:self: commit is both A and one of the X inputs
>  - get_merge_bases_many:duplicate-twos: duplicate entries in X list
>  - get_merge_bases_many:pending-stale: STALE transition on an
>    already-painted commit (ps-* diamond topology)
>  - get_merge_bases_many:infinity-both-sides: both tips outside the
>    commit-graph with non-monotonic dates (pi-* topology)

It's usually my preference to see these tests show up before the
new code arrives, that way we can see that they already work with
the old logic and continue to work with the new logic.

It's minor, but putting them after your code change may be adding
enforcement of a change of behavior.

One thing that could be helpful here is to consider tracing a
count of "commits walked" in the merge-base code, then you could
have these tests demonstrate the performance benefit by checking
for that number changing.

In t6600, that tracing number would not be the same across the
three different data shapes (full graph, half graph, no graph) and
that could be valuable to demonstrate in tests.

Thanks,
-Stolee

