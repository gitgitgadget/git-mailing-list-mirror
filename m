Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F61EB5C
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711596208; cv=none; b=BNI3zCXWy0nIuQfSTFvkDxUSPHIYzm6O61ISUmu/8mlPpwlrXJcd7na2ube6PjeG97BK7itG4BmeNKHxyJJzMZAV9sX3lG4CMa+/M5cBM7oJ/0sWS38Zy+nOGb9KzbzeWR9ghxzq7qKtEhLI4j3jJtuRVzX1SUAn4PxfD7bCIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711596208; c=relaxed/simple;
	bh=dsV5IWVUkRsuw43mgh0QwxIVzAypIJtYvs7IfYmr2yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XRlzRCcY4qwsiHhcPTcQm/hOIS8wfEkKUlCss2BlOx6ovlYxvLho9caDzOkW8f3ESEsDz06atv5eVsJSieAGjXkQb0lQ13+J0vOY2gq8IKVKIo9y6XZmTplUFhLVzLF5wZTzCRyeRavWPhi6GnjaVzcjdPmOVjHhnB8YN087xDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neF37mPA; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neF37mPA"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3d2d0e86dso286045b6e.2
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 20:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711596206; x=1712201006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qV4JG+uRADkt1TmF38Dh8TOuLtY/ZgrF+tjnucGJLnM=;
        b=neF37mPAg9nE5AgW4vb/E0W4ur09mXWTgS3CgbzawTyoH+XxMoZtnogtGxBnHAaYGe
         a6EzWqxBKS3tKaTlwJSu7I9VJW83pJ+T9pj9EvCe31RO8/ehBCW6jtDl50v5JswBLAeX
         dIf8H7nKQwb2ByDEIc3vbbZeUSEF5Tl2sudliP4MDAL//vWN1HgmVdBn3vdDn5kCUpw9
         d+f1ggiDhp5WzWRjo/tIRCJF3D0IzSq6Q2cJr6S01Lmeqq10q4lly/mDEhrdt1xNmjHK
         qUCcKZ5Ecbnkcxj0oqbfj1IIdvy0k7ygaH1cZMpr9Ih03oO0xjRLDCFUUGIw/X8Z++nZ
         z7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711596206; x=1712201006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qV4JG+uRADkt1TmF38Dh8TOuLtY/ZgrF+tjnucGJLnM=;
        b=FTkhWJcI8ilTzWgyIH5Kfqr33FZorXzeVdop3pZB8E0yd/6i5FFpfOl99tMkTm7n8l
         FvTaqn5MmeoN9AIlRYNuj1ufWtQP6et8+rRshM5PF9886bVuJsdhewLZg3QTd/gcJItP
         kJZ/LaRZnVpk87R2wmjZinnyCDgD99DL3PKEOg/DI8VBLR3QJPtVCp6hsZ+oYYZPHPG8
         ye2alihJi4jQ7KSwNkXeXE6sP7NBfDi0dxcrI+y3F+Xdw+n9L9PiNiCtSMEXOzfdn7et
         6ecCgbUvDLRvK+AgLf5HMfqrX7qavuTdiQKGMNLrKpGt64FyNdufVuRGKCajNbWCzO3T
         0i0A==
X-Forwarded-Encrypted: i=1; AJvYcCVW0xLfOEa8YIAPi+vsajQU7mEFmNJF/f1Ic0tvKbORnK9G7eyh8tXsBD8i1LwvIllm7+DJauEERLpfj9NfS7EqoSLx
X-Gm-Message-State: AOJu0YzGE4Yt6V8syL/JrCJHGwMLaRZsnSKSAMmRUolGSjaQWDLurvSy
	KATzKFwukJsQ76xuslqw+ZKmcxGxhXpMyDgT6BOnqAbRIths+HJe
X-Google-Smtp-Source: AGHT+IFuutSEC90RKWP5BzjD+f7wrjD5BoGA7NSGbiCr8u9xQirxAlGSolLrcJTdtSrceHJXEcYgXg==
X-Received: by 2002:a05:6808:1985:b0:3c3:b607:4f35 with SMTP id bj5-20020a056808198500b003c3b6074f35mr2077531oib.3.1711596206531;
        Wed, 27 Mar 2024 20:23:26 -0700 (PDT)
Received: from [192.168.208.48] ([106.51.151.98])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b006eaada3860dsm289794pfo.200.2024.03.27.20.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 20:23:25 -0700 (PDT)
Message-ID: <12a3b951-39b2-4e9b-9e27-cc29a65cc167@gmail.com>
Date: Thu, 28 Mar 2024 08:53:22 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][GSoC] Proposal: Refactor git-bisect(1)
Content-Language: en-US
To: eugenio gigante <giganteeugenio2@gmail.com>, git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, ps@pks.im,
 Christian Couder <christian.couder@gmail.com>
References: <CAFJh0PS_VB8yv7B1uM5+Ts9PtMFtU5mL4y8UUDORKQcYHSoxPA@mail.gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAFJh0PS_VB8yv7B1uM5+Ts9PtMFtU5mL4y8UUDORKQcYHSoxPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eugenio,

On 22/03/24 15:56, eugenio gigante wrote:>
> Timeline
> ------------
> 
> May 1 - 26:
> Community bounding Period.
> Read Documentation.
> Write Backlog.
> 
> 
> May 27 - July 8:
> Implement a new layout for state files.
> Write tests.
> 
> July 12 - August 19:
> Assess and implement backward compatibility.
> 
> August 19 - Deadline :
> Write documentation for the project.
> 
> I can dedicate 3 hours a day during weekdays, and 5 hours during the weekends.
> > [ ... snip ... ]
> 
> 
> Biographical information
> ----------------------------------
> 
> I’m a former student of Logic and Philosophy who turned to coding
> after graduating.
> I have been working as a Developer for NTT Data Italia for a year.
> I hold a full-time job, but I've seen that it doesn't conflict with
> the rules of GSoC
> since I'm an open source beginner. I am fully capable of managing my
> workload independently,
> including my working hours. I know it is not ideal, but I can
> definitely work around
> my schedule and dedicate time to the project.
> 

Thank you for explicitly mentioning this. Apart from this, if there's 
any specific things you need to clarify regarding your availability, 
please do so. For instance, if you have any planned vacation periods 
during which you will be unavailable or some such.

--
Sivaraam
