Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8C14D2BE
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382329; cv=none; b=KulnaOQth1Thz7bt9puWljyFcgUhziCaYT+oaAo7rmmEm40uzoyOS8P1xT/I9bVHdoSRRPQzp/kHyN0fX8RFyHgSE28ZbkrvuwA5Se2Kzll5pXOiVHDNt2FCsC3ERHd+l9mrGY2+Pmund2qPQ1Y95UZ1l8BYEuESPfqM2+S1NuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382329; c=relaxed/simple;
	bh=cvucR80F3lBg3jADdRWzWHjDWcqa/dykB9m4HANKCss=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rPo0p66DWc/TAD9vsrmmcXDFzXoq16hV24I6JyqIfE6ioptTjFsH49WWy4TKtew8q8Oea5UOagc+7OCt/mU13tVSqTmS4BpHF7ekI9KzHhU0abt8xH01S23tJRgZQ8qSYZ8K+bxCLnUFAXMOvtyP5rUZPAfTQxHQoIVk78g0WBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ1+WbUn; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ1+WbUn"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-71d125f2d96so415852a12.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719382327; x=1719987127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XueTwXeEzj/Hub4MGuPnSt+8H+HcGObi/PxbGn2nV2I=;
        b=lZ1+WbUnkYj2WKg5yqR0iSJeEXSctazcocnd4zYPaQDfDz6Hu0zvYCdWWNSvl5y3IQ
         TNT2DhhcKo/nJvuS62dgwOM3qz+msLT5hjz56Olmc/WE7JW0SkHhFdnCLmivtEmwoif7
         Xpsp6O6IIso0peHDWDu0VT3wdoP7l6mYbJXJHzLo3tfSW/p34H8ZmkUyIR6nZ5zeIr/u
         NI6SZAgp5D6SEnUDnTwepupAwbCLU4W8idqlnaw8HlMpCjmxeLV1PvI2n6YJ8DmqPe9Z
         aj7pF3JmWbuXfG9Pdu8UfwRXobJ+qWGK0eY0b2l4lKgJgmaC5LHU32CjYnZt4RUDxAVu
         jo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719382327; x=1719987127;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XueTwXeEzj/Hub4MGuPnSt+8H+HcGObi/PxbGn2nV2I=;
        b=tiRAnsWWhnNIL4onI9mCg6GoRMU/ZsYlGzCqjHILWMyPMiGmTeW2Bu1I+U5SLlz7ig
         znpTF9GAFhpYTBxcGj4zaSM8H4eFfYE/cHLXm8chl+srQqEqqh3kq2kKlZlDQyjBZqZs
         BqHZXlFHd/whhFinussAOCzTp5rstF6DUYNTqe4TRlFLgV2KgvP70osLEb9AyRajkhlU
         o7O02iwtVs+JiNrdLyydOJaMz31YmlUwLAKbCRNOe4NC6AwRaJfvL7IvVWLRHMWh0eKU
         JA6gCHUSEP60HewyX8gsRcYHkoNvzy5bP4a3Z+GDn8PntqFFvtXIoZGaDSL2YlLn9o0p
         LrHA==
X-Gm-Message-State: AOJu0Yyr1hxOJq6/AuP+Y+9MbVXqn0Tzv/JVAMPIPN/rLA+FJ69dkc4Q
	P7smuP2iJwBAdT6wFkSyUkFIDP+r6EB0FiKq3JAd5GZUVFhILtfJ
X-Google-Smtp-Source: AGHT+IFztPwVk473/M/35sZolC7ZSmwkXQDHGkrDmWe+QNGdWiWHR5ExcPewQJoLAP21ngiy2evPCQ==
X-Received: by 2002:a17:90a:f598:b0:2c8:5865:4d33 with SMTP id 98e67ed59e1d1-2c858654d78mr9137393a91.3.1719382327079;
        Tue, 25 Jun 2024 23:12:07 -0700 (PDT)
Received: from ?IPV6:2409:40c2:205a:5198:7ae3:8451:ca0f:16a4? ([2409:40c2:205a:5198:7ae3:8451:ca0f:16a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d7e590c2sm749333a91.1.2024.06.25.23.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 23:12:06 -0700 (PDT)
Message-ID: <751d79f1-3cb7-45bf-a276-fc4852039e09@gmail.com>
Date: Wed, 26 Jun 2024 11:41:59 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Subject: Re: [PATCH v3] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com,
 Paul Millar <paul.millar@desy.de>, Phillip Wood <phillip.wood123@gmail.com>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
References: <20240625133534.223579-1-abhijeet.nkt@gmail.com>
 <xmqq34p1813n.fsf@gitster.g>
Content-Language: en-US, en-GB
In-Reply-To: <xmqq34p1813n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/24 21:29, Junio C Hamano wrote:

> Why clear .args here?

I overlooked the fact that run_command already clears .args if the 
command exits with a zero exit code.  Will fix, thank you.

> I am wondering if the last part need to be more like
> 
> 	...
> 	cp.no_stdout = 1;
> 	if (run_command(&cp))
> 		child_process_clear(&cp);
> 

That makes sense to me, will do.

Thanks.
