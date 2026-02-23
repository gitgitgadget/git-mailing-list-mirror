Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43707331214
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867077; cv=none; b=tDQ5LkM36nf+6vZM3tKLQoCxIyfuEDwqdd5QfN6ToxMyIb5aRUawNuogrAEM9xi9q0pF4nPj0a4s6uoTnoFXaxAKvyC6yazaD0oWSM+7dEbqpgVDkoEdI8LEvQpXykD5MwT+p7qbTf842YG0EO09ypUD3JgQvvCS5W8QtGJOlqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867077; c=relaxed/simple;
	bh=Fh6/TeMCbMJg7FTMpM00pFxTQSlNYjvs/KU0LLwFLIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+OIT8ZSasogyZr4ypDZOZzlmPkM6ZavBeC8QPjinoaw6wOhI+FLCpgEPznARW1mhTZ91MNrBxVwnGoHSYk2GhPwtXpbqyjfZeOmERT4MeVRib3uumqT3CQ5C0hHk9ACByEdUVm8SDhhYIksXmI0Mtv9aaMBzkbNlRGDyVZO/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXtA+XPp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXtA+XPp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a8720818aeso2256335ad.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771867076; x=1772471876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3KrbD9EitUk7sJCx6xrAdYuQAkRH4YMoXQblAo3Iwpo=;
        b=cXtA+XPpTv0U9hph3RT5WQQo9PEnWku/oX/vDYSczfQUrOaNqIGGZPUfJrbgLtOoZk
         g3UfTd6N0TCY+LZ1kGGWSdCyUZoWJECs5Y2fXb96CGSWz5ZmPmM+HGAlEt9++VKwP9yF
         gvwVZRsURYTls0tC8TjBlJQ8snXYFKg+R8Afnbddpba6vQgD6mRqGAtBSPe5Q3SpQNHF
         dVqJQvwY5TrhtC1VwgpojZDtYxPQy/114r7KC3DtlVFxfbODynpmzXfKycbbszujmwkC
         k8H0exJu6r/QngH2FanahAw/Mb7OH+5TOSGy8doFRA0ikjEGPAxSNwWIFqh3mVMLl1bx
         2ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867076; x=1772471876;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KrbD9EitUk7sJCx6xrAdYuQAkRH4YMoXQblAo3Iwpo=;
        b=D3QxHD1C0YNId9g6E2tfDXHiysIwbEupP0FSzj10mQdJp+sCl2mlTc63KK7lA/sAv0
         PZcgMXpw4xr1ib/rZd6QYbTaSUke3rqG7FQq4FyWP2jzVIXywRaD3N9k5XX3/YTPcedJ
         HnpY6ojDECU5lnQBt+5Si7WH4R5tQoVqs2PMHW2tm809ywLpGR+RVgKFgKQbgYEfsOsR
         p9xSXubibCzV3k4BOlV3G1rosYvngAielkabgludMjvf6LddTLyQABhDvxnCfuLwGNPV
         ObxZDA7NZ9xVHi0A3kQ5i5P0qQA08s06VQkRmw3tNB3NCdr0B9MUJdkngvDgyqcU44Fu
         dFiQ==
X-Gm-Message-State: AOJu0YwzsQv+xY09atEpWQqwBOmL8fL45AvLBht2gn4Ad+IrNnfsrKfn
	T7lJn2GbE+kOwo/lteGO5y5qttl1km7+dmqAaUnowOxtQq3pR/Qw8E0fg2QDQw==
X-Gm-Gg: ATEYQzy4hl32O4Rm2Tl3qYIuqx2Mxkz17ccmhRx/urmm421sKLXOPKx48J+Kb9x5Dfu
	6S44uWZmKbpj+3AzuLGXE10b63ry3U+E2TX4OPv8Gkjyg2S6UYPkT9ATN9hMLu0buWCFT4a0ho9
	Glmc0z6EoSn6JHGrJX5z0bQY2bjWKOtB/OyGDJZR0GaHxKyNAS2fODXGP995FLJSoufyVPjx3h3
	HS+15mMCXNfIDWMhHNqjLK5YuwLKfQ7w3PLTYrnST/lsCxZAwW3p/JKET/MzchMno0TX14xb7ZI
	6Kp5K/tdUfkQHo/xbB80b40FPJRpppol3uaGK+kB5PR8BK234El/jFHD4M+Ysnym67gv3z7KXdW
	Ulh1nqI9L3GcgV+h8rVWIuJA8EAVYa2uZ1dI9lR4qNbKzxSN1hVa2H3q7Xpm6/j7ELrLDxWG8vt
	btgi/7uCNb37PYKIzhmAMZUlauPX8tdefK99TVeg==
X-Received: by 2002:a17:902:ce8b:b0:2aa:d1e1:29d8 with SMTP id d9443c01a7336-2ad745690d1mr65420975ad.6.1771867075601;
        Mon, 23 Feb 2026 09:17:55 -0800 (PST)
Received: from [192.168.0.106] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3507csm83705515ad.8.2026.02.23.09.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 09:17:55 -0800 (PST)
Message-ID: <a2b2e581-18ba-42ad-9bf1-a3e16b85f4e9@gmail.com>
Date: Tue, 24 Feb 2026 01:17:52 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
References: <20260221083001.220061-1-a3205153416@gmail.com>
 <20260222102928.377519-1-a3205153416@gmail.com> <xmqq4in8quxn.fsf@gitster.g>
 <xmqqqzqcpatz.fsf@gitster.g> <5263825f-163c-43af-bac7-152d670919d9@gmail.com>
 <xmqqfr6soxjq.fsf@gitster.g> <xmqq7bs3piz7.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqq7bs3piz7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

 > But at some point, we may want to drop _ERR in those two new "these 
are not
 > errors" return values.

For the v11 I sent earlier, I kept `READ_GITFILE_ERR_MISSING` to 
maintain namespace consistency with the existing `READ_GITFILE_ERR_*` 
macros. However, I can't deny that decoupling these into neutral status 
codes (e.g., `READ_GITFILE_MISSING` vs actual fatal errors) also makes 
sense.

I'd be more than happy to drop the `_ERR` prefix in a v12 if you think 
it's better to address this cleanup right now, or we can definitely 
leave it for a future cleanup patch as you suggested.

Thanks,

Tian Yuchen
