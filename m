Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8687A12FF87
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 18:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724221; cv=none; b=OojuwOSd34iD0s3p+AcYnLWPm3/JaF7T/Y1znsacro/b+Lowz6a+0CIhUQV5avrnoM2H12Ur/FQ1nVhdq0e5TcYW4HB+XcXxfqMZMkNX9BgOp0LnyqoZTLDu1bQaGBRv7Gr6rpxsvgmnroZB1uO9BOiZlMX54Ka+mdKRFBK4lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724221; c=relaxed/simple;
	bh=xDdVIJxrCZDj73qYyZlmZvxPpZYo1FAXI5mRjsdWzDk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KKvjYdn4L9UIso/gRcsTDrGdTGqqmvMBNrVR+5qLFHyFlh41lebLap+7lh0OMqj1gYfFT0rfEY8maMtdKBlkyOvEu7rayt6o6EY1EPWReSS2EaB31is7oCi9TgTSBLTJtEo0b4aVyrORYVEygeVpeOm2YLWu2rvxkTs1jYq+/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnL1qLNu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnL1qLNu"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8df34835aso9103a12.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706724220; x=1707329020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AITbC+hL6bPcJg0BamD8jSCof5JkCpU756mgmI0ESP0=;
        b=ZnL1qLNuVxrpEEtTz31wmPSecwf4m0hsFf7alenWzDdJhbzwcRFWjPNfUVXZoC8OCb
         gjPuSiuFOgzVlmwxLzydV7EXlxL6ZffpZUbws9dxSlgj8YRJkadKxnUJia2LdPHbDJCY
         uyLk2Ma1KNjVcv9IdDub47IGnJiNt7/LE0dVX68hgUxvNm5SE9g57RwvqvyBMO9bc0xH
         9RGZNllrBEp5SWntcxUXyI1/m0WWQRIquKoKgPYjJSDOpSN1NUPjTjtJu+JaVlzc/opF
         9u4nyA5tYQhVNsyvT2nXvTymE2A+KH4NnySBExZJkLG16lUuGzeX5Z8C+990e3283ixN
         aDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724220; x=1707329020;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AITbC+hL6bPcJg0BamD8jSCof5JkCpU756mgmI0ESP0=;
        b=vOp4NHiOzu6Vdg2vVMqVzduShRRvTx+L8jnjuAj4qsKx/KauPln5RSwFdNp90kywOT
         MvzTfkYS1I5xzrTaUCNCAtwE+ctCOU9ct7PjLuDhMMITxcY7mASIlhcOlvOICQgg8F1i
         XOvK6cDKHwg4RpfqhzuSeOjjvyUFoDORjMY7ANvYB9bZpBag2UzYG2fF2W1wbnJ7Xn/1
         xsJ+6u3fvfwcYJot6r4194yciyc75oWa9/gPfgqryfwZwgi3w+LIsgBLPlYb+LWebsKt
         AshwSO5RZEX0XSQTx2SJ9D/bdHdZverCufvET85aUiRnr2mqk9p3WgTilfurXji34b1K
         KsRg==
X-Gm-Message-State: AOJu0YzhU2JbjsBKHsft8wpE5+iscF+LbBJlLuGylNb5Kiy9DDgXYXgx
	ZU3KqNqVGFYva3FCp0Ljaikh7EbD8yIVYHqi+uOjkmhSyxL0gp0wI5fvi+Qo
X-Google-Smtp-Source: AGHT+IFjuy26vNckPItPJoTHGrCbncrJX7zNox/OkKfmYbDkuvW7pTBFb4bdG8yD4vr6j8d2vT+Thw==
X-Received: by 2002:a05:6a20:3194:b0:19b:42ea:314f with SMTP id x20-20020a056a20319400b0019b42ea314fmr2449545pza.16.1706724219696;
        Wed, 31 Jan 2024 10:03:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUygbwE6Hwb3y9vBc1h2BLw0wdE/jJ6VIR2NXYGJjl/lSHLXoQLv0TLHkOHAE4BpyQfdHUluZbBHTvTfxU/SKLYll9dG8BKMzyABtCkJs1BT90Y3LtMVYOI9Dg4r0yfCU/re2Eb6wRhJVZYEtoEOos4fQzL2+G1UB1T1wBtXTFx
Received: from [192.168.208.87] ([106.51.151.68])
        by smtp.gmail.com with ESMTPSA id d10-20020a63fd0a000000b005cf450e91d2sm10988214pgh.52.2024.01.31.10.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 10:03:39 -0800 (PST)
Message-ID: <62165479-8539-407e-9a33-6f2733414cf6@gmail.com>
Date: Wed, 31 Jan 2024 23:33:35 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2024
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Patrick Steinhardt <ps@pks.im>,
 Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki> <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
In-Reply-To: <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 31/01/24 23:27, Kaartic Sivaraam wrote:
> 
> Great. Thanks for your interest in willing to mentor!
> 
> I created a fairly rough SoC ideas page for now including a barebones 
> information about the unit test migration idea:
> 
> https://git.github.io/SoC-2024-Ideas/
> 

For the note, I also put up the 2024 microprojects page by basically 
renaming the 2022 page. I'm supposing the projects are still relevant. 
Kindly correct me if that's not the case.

https://git.github.io/SoC-2024-Microprojects/

Also, feel free to suggest other microproject ideas that you may have.

-- 
Sivaraam
