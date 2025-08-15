Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8E1E51EB
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271075; cv=none; b=Ee2WfeeP0Rrl/yMcFFW2yWQwF6bKFFiELMX/2Y+evyfDae+IXUUMopfn4+kVkTfjGV80qneAXmasbo4CxAAlLvIwzixIW1wK8I7XywqlvaREnLCpZfDcX1Z7QEwM/hIAwLYHnBm3A1qXb7ex5AkaFx6BxM/fnmvwE7JMlNvwCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271075; c=relaxed/simple;
	bh=PYRS9+q2V2+IESlnLn422mOar7fH4zFUU45ZJsW27+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cs9Cr2itC4y6CPiy6tf50tArpm/Ge6bT+Ve99a7cPJ9qvo2HI971zJ61Rqo3JaZTWpAwQA5yJ4ZaQ2eYe0A5Eaa1ATbRwNnu48E3+fBp0ZD5L0zIz53vih7PJuq8rddjMmiJ9rKtIPL+ijpVQgYz0ogqqim1Vt6qI3YfIFw8nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gM9HY0zx; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gM9HY0zx"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e87068760bso239191185a.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755271071; x=1755875871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgGyJ+FJomhnKKOEAM1vMn5ePXSJb54QUB4Bbq3L2Xk=;
        b=gM9HY0zxQHcvYkWgbO1qrATS/VLz4nSSsvflWxE6o07zc6cWZCM5Z+MhCzhcK1ZKKr
         EZIgFlD8h8PeeMTQ/7VNqKLUF5jH3XPltEqAIOr8jAwZHyU7f1icL5XxxmRWTBDTwIpK
         XuneDlNtLuA9rCbiw3QkYnBsVEwRBvUPi5cu+A6WhV6gKjTvmmte6lc0KLXbhDCBuoIz
         gGyHYNOJnO10pPpb2eO8QUTzFNARlU7eq1lbNA23G3qIWc2CVuLFyfBJwM94QWVjqDtC
         UIiYL6K1iSoqVDY/G7viVsxIREBQt5d/i85E6O8rerasnWjP64SLHcm0zMCoJ+GShUBi
         Zgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271071; x=1755875871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgGyJ+FJomhnKKOEAM1vMn5ePXSJb54QUB4Bbq3L2Xk=;
        b=GILByWGMxL6x6FoWkZmcH0ctbnIMdvmjyirohzvbe+kL92M/O10O5f4nSzxVRxzWnK
         9z1tJKeP4tq3w0gGRzBKC6p8H8v9fIKT8YhdCzw5Ns+6CxSdZuA7kHLhBX/zo2Nl8ve3
         87Xj4tsP+oI/E4koSD/6XLpDmbJcBfvOtdiG9AaF6GROFaAoMRtIqsQwK3ZheEQ4d3m5
         xRCABNFb6opTnCkVOwamepKaQn1B++2KHkrFQvs8UucJ/B0d9mhdw6uuWt67VMlUWZi2
         HJaQ7yKnqaEp7nxBlkuHg5pQssk75Y71u17uBprXZ4RpRDKLcx7bEKBs21R4/75Y51ta
         wP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+0K1Ot/KeEZTVQwz/Sq0R5RKswQ/RUhcn3vID4R5lJRdWKXOIfqnxfqyiU9R5buYqeN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrrWlVhYpsZ53Fdd8PcLGYx2VrRT2iygUv3Sp+ph97tT7cNUm9
	yAJALOkD93Xxjv5XwOUobWRee36iBzaRzo93LGHA+/1TmYVSzCWvcpqLwAq0dA==
X-Gm-Gg: ASbGncth6AkICeLEmvY4Exfqck9O5eKSmmThlNkRyqCzvsNPHf4WJ7m8jr4isQVfquE
	1gvdTFM44IS5mybFdnGWCQXSD3+wjd6jRiSk8QCzFTI8aj+bs/nxCS44r8SjC3sqZ83yCZToFeg
	xUS0Klx4coQgmpHqacvOJrk88zR77+C5yETexlajKYI+zEGMyKjJPocYjeh7PWHUCyRstjvLiuE
	+v10JZSYiL/aOMbNU64sUOyonIUg+Zm3Wn/GvZKZunryl3pDemwkuVkMY7rhtKy+J/Y1hchgXJg
	SNzWCBRZ/FL7zxGi721dbtZ/E71F1URTJsP8Z4AOPju3wvO63VRTEGyAnpG2u3FvmgmIm2WGuEv
	yaL7Main6HnVYQeUPJRYZRUHOgdAkGEGKVFY=
X-Google-Smtp-Source: AGHT+IElOpKp8MIdndNncBsz8IP1QPKUPkhxS9Tc65ekcKNT5AViSOPL76HKWUA+pRc5kNBarS1kVQ==
X-Received: by 2002:a05:620a:a1dc:b0:7e8:852d:8cc with SMTP id af79cd13be357-7e8852d09e4mr2367385a.21.1755271070572;
        Fri, 15 Aug 2025 08:17:50 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e05477fsm123815685a.22.2025.08.15.08.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:17:49 -0700 (PDT)
Message-ID: <6704a016-781e-458e-96d9-2183b779a549@gmail.com>
Date: Fri, 15 Aug 2025 11:17:28 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] commit-graph: remove reliance on global state
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250815-b4-pks-commit-graph-wo-the-repository-v4-0-b6b651178cce@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/2025 1:49 AM, Patrick Steinhardt wrote:
> Changes in v4:
>   - Drop the patches that fix `-Wsign-compare` warnings.

I appreciate the choice to leave the controversial changes
for a later series and instead focusing on refactoring-only
changes in this version. LGTM.

Thanks,
-Stolee

