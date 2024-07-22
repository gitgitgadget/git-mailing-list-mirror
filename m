Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7614AEE7
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690461; cv=none; b=XfYHGBz5vc+JmCA0uCdFCnnUv5uVkGpUHe3J75su1SDeXPYN5SCcwcx+U4ZeZpGf4ND+Z0Axor3ynyoEBTPRe/xClFECmZQEwV5dWj8ojxS0AxVRWdu4wciNYXwmRyQSo6F30n8wcDAHIA0uEIzUfEEOdb+3/LvJUPYusqHDAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690461; c=relaxed/simple;
	bh=4roDbuD397vA3Hhm3pBkAb4xNZUdLi6HqnhqHXfX2Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXqjvI2LrOBJMLj4BKWgmF9tfs0Kscf3PTZb8HvJ8ha2SSTSgrAUCvzI4++eMUOMya2XkLOnzPbRSmIsJX3nVPIQFINW5naSJC4Xkhx62UKM9ywVeDivg2ywPSkxDIZhrBSvEhtEh0pNr2CSn0CrQlkrIun3z98sHWVpb/ZGkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJjw2jiL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJjw2jiL"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3684e8220f9so1866034f8f.1
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721690458; x=1722295258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2Lioz4hdoaAn2/SqCI8hSK2ZY9y/jtZ0pn7DDRQo2Q=;
        b=ZJjw2jiLeHQzT89V3PIsKXrTym1HVjbhiEUojcrR/SZxAkHcKoQEeBvb5PrG5WUVgZ
         yKd+1eMHMeKfi9zLjb6jpxxksXN+wSwZP/10+mFn4Ps6ovdUL2M72+uFcf5QusSKAxdc
         iiV31qqhUE/m0escwtRczpupuhPyvt5q12uX+n1LgJy7Z2wbTd3TKRWuP1PWitVkcBYQ
         ddrYxZRluDuJyNFs3ACZX/zFoJMN5oxUxthkeF3QfiGzIJNY6MtCd7FHWsNhLEJJa4tV
         gceiMPsiDQIM/dMQLIWICQ/s2D6RzAh3QncQFPgo2r6bPGy8SKHuKRXpTuuVsLSdhmN+
         H2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721690458; x=1722295258;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2Lioz4hdoaAn2/SqCI8hSK2ZY9y/jtZ0pn7DDRQo2Q=;
        b=a/mGA1gkoZyGj3bIRe2efRor5YdygnDBRypCiQqAxEh312MhX43LSt7Vw1Pp7YXy3Z
         7qX7+vCgxXS4lU9Z+VKFtA/vSV5wJlu+gODMftGBjiavT/AECf4+0aZriDgQ+bAq4hvU
         3WNl/8ZG4bA0jnCGSWe1LF3rnjC6+9Y1dprBgKvD7KVhgUHfFSzgNgB+n8wLaJLOz14R
         LaR4yK6CYNQWlEhDD78FhEAPIhqSXAGA4FqLkWq2DGmfMYDjS4BuUfZwQh0FoTNas+yF
         1+e5KHWT/yorP2hMyCIh2yoxjx8qE/dJsNmPgSdOuSR7QAmWeYcTiQ3dWXY4FrQaKTIT
         gBsA==
X-Forwarded-Encrypted: i=1; AJvYcCUgYFSw8K4LfqMT+YW38QAPqerwt588gxyFxjYRXK0Vug4335+pmA+53E9Tx9+PnwUVjXjT3oObYne7QbPfgVJ/AAcI
X-Gm-Message-State: AOJu0YweYalefOZWZg5heGqGrfCboSAw4/hUmTE0hILd7HlzRAQQtqDf
	0MFJDfgbHlwCldEDdwD9aZOv9CHGASep/evvwBe3egSn6YjPGHt0
X-Google-Smtp-Source: AGHT+IFkqKQJXYMw8ms2RCBiiloVPFhtEeuJtlTYZ+GWKhg2vdLZDUbFKXwqRg5Bp26V3TsRCc1yMA==
X-Received: by 2002:adf:fcd0:0:b0:361:e909:60c3 with SMTP id ffacd0b85a97d-369e3e7505amr193800f8f.9.1721690457789;
        Mon, 22 Jul 2024 16:20:57 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d692976fsm145782665e9.33.2024.07.22.16.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 16:20:57 -0700 (PDT)
Message-ID: <43e045e5-4c92-4c5f-b183-d63c5b510023@gmail.com>
Date: Tue, 23 Jul 2024 01:20:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeff King <peff@peff.net>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com>
 <a2ea00e2-08e4-4e6b-b81c-ef3ba02b4b1f@gmail.com> <xmqqv80xcpe5.fsf@gitster.g>
 <079901fe-7889-4e1f-bb91-610e1eae25d3@gmail.com> <xmqq7cdd9l0m.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq7cdd9l0m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Jul 22, 2024 at 02:25:45PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > To fix the test, as already said, we need this:
> >
> > 	test_write_lines P q |
> > 	(
> > 		GIT_PAGER="head -n 1" &&
> > 		export GIT_PAGER &&
> > 		test_terminal git add -p >actual
> > 	)
> 
> This took sufficiently large amount of collective braincycles, and
> it would be worth documenting as a separate patch, I would suspect.
> 
> Something along the following lines, but please take the authorship
> *and* give it a better explanation.

Here's an attempt. 

I'm also adding the change for `wait_for_pager`, which could be squashed
in b29c59e3d2 (pager: introduce wait_for_pager, 2024-07-16).  Although,
highlighted I think it's interesting as well.  But I don't have a strong
preference.

This builds on rj/add-p-pager.

Thanks. 

Rubén Justo (2):
  t3701: avoid one-shot export for shell functions
  pager: make wait_for_pager a no-op for "cat"

 pager.c                    | 3 +++
 t/t3701-add-interactive.sh | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)


base-commit: 6bc52a5543008bff2c6ec7a0a935c7fc1f79e646
-- 
2.45.1
