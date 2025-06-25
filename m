Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FFF27C15C
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840853; cv=none; b=LKwfeZd7NpZ5hPdT+Mro/Jj/mO67F3H99CgjIruII2g8ymKaa6MnCLm4DvCLRaR4toLOXNVz6chITIzY6PBKIhktRDU28vjdnQO4Xbc2OdXmXVyK1JYzMxvfdxwCPEW04UUTcX7+cmneHaHcSFipN6ZfK2NhMpvJQvZOrTem8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840853; c=relaxed/simple;
	bh=puuYvyEcpkl6w5l9B0BPMP9p6UktddzNEMsByNlrSy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCXYVeUFT4m4LTKzylXujr/1W7FL/wUXuOJxk5N2k0nIJTCrbKUbm2r2YHkuizfiIU4myDi2wE19tZIO23QnyhZRW6xvQaQcW6n5WokjemF0W3tgIzoZVyxVMPRHPQQfIKBDM3yWuCecRHtFZ6hxfWd8uykX76GKIcK6SFEcKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQw3zou3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQw3zou3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so1085143f8f.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750840850; x=1751445650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jg7Xrvy+8baxdGR4x3boMcItYbdKAQEK7+vZN4arcQ=;
        b=AQw3zou3h6xau9xapTW/6RQ0QhiOPPITsy9widL2pJOfvgAXHzjtVeE0ZPvnfWt06/
         bCbuPPVt8QxdvPe0usrUtAtHqElq2cPJ+oK97vuj0DH/D0d89hI+wCnsrxlBtimqO17g
         sljahhKWdXKt2642kiPnCf/AQvSS4rmURpT5llPrs+0cuGcrZnKygXBMc0o+oYXHnlBk
         gnHcQZJ5ZEh8OkE+7lvzJYRylgVdv2J1zpl3gbZxW0kdPDWuXHk+UBwpZrictlLHQocT
         rMUriKhj6bkqCr0PGjfRJtQGLHu6OyZmoAQucMWDsQxJdyQPRBFYDV75h75xcmr7dJP2
         UMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750840850; x=1751445650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Jg7Xrvy+8baxdGR4x3boMcItYbdKAQEK7+vZN4arcQ=;
        b=uMvnvvOloXVgq93k1OGaeMl9LrzEOcqwRoPRBH7kK4EPBWsTisMD5bUDaAbKzazANn
         Ey3iq2kYEeiF9AcqAivEr+xnfdcRUA2k3QiqGEhCQF03S6lqYzQlWiCYxtHXC5VrHV4x
         vRianOKBH0ipIZMVerdI2ZXIUWBoXJonhCxNjfg7qFaujDAaPPMbtay42U+4CSIojMYY
         jBSzI644Bab6sVg7ACv6uUgqr44xVNew2SDVCD29aJautMbMMjEEl8R2NgQwrgW1trHN
         SkYULmi7iZ97g1fdSP5JexDAt4GK4h2EKtzl8w5oStrf9hrXQuHa5EBfZ5lLBdC9BmJz
         gAow==
X-Forwarded-Encrypted: i=1; AJvYcCW4eTmv4kC2Jpnz1vtVTdPcuYd0NMeKmTWEesTpEQCTo+Z943ux/Q7knVDNoL4zwIU7ON8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51Jy4yWtFxxkweV1IniOlIEAy2eONyprEGG0fmai/7J9xgZrI
	vKWmRg+8dkFylwHgeb1eAKjD7gg4MuWqCgp3s/i5nThvT55+EdSDNbv1
X-Gm-Gg: ASbGncuq1C8Ro4B9kH1ARImeUGwpSAARgP5L0aGQ0TQmLU9jJpkxkZ2f1ttQzXsTXov
	NTbGx7Axo/yTDj0uz2lm6dyF494GbZXuqWvY7xJsvAwJ86b9LdztNGtTDPqOcF6Kuu4aukDpSLk
	UZQc+ncdY32jQV0B8B6Jo8il/RHZPhbfB2xy7OFjv1nSC1gQOPx38qnj39WrRWTM3lyYtOkCoZ3
	CCXyF8/Bh0FuyhWthIozovINegOPDl+aLCY8KTu7V83cCl39vDH5D310r0WSJshjevPFjekcH8s
	+dvO6jD0Hoff2KxOYeDYBRuo58MmYfwNR1x8p1cs6onc4aTGLtz5GQ4UGtue4rdRrVBDG466MDc
	yiima2i8kTi/9b+g0jKoRU0v2riF0KUM54nf7uA==
X-Google-Smtp-Source: AGHT+IGsXLk42Omdz2fOZ90JLf7QacJgCgGcVgqOKNVmt9tFGXpj7NTUQ742pPRlEnRbWIpf6dVKRg==
X-Received: by 2002:a05:6000:178b:b0:3a5:2fae:1348 with SMTP id ffacd0b85a97d-3a6ed64edb2mr1493386f8f.51.1750840850068;
        Wed, 25 Jun 2025 01:40:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f26ebsm3992966f8f.51.2025.06.25.01.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 01:40:49 -0700 (PDT)
Message-ID: <88915a18-de18-437b-bd74-91fb82ab760e@gmail.com>
Date: Wed, 25 Jun 2025 09:40:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 0/4] Importing and exporting stashes to refs
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250601223225.464076-1-sandals@crustytoothpaste.net>
 <20250612011221.4158484-1-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250612011221.4158484-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

On 12/06/2025 02:12, brian m. carlson wrote:
> Stashes are currently stored using the reflog in a given repository.
> This is an interesting and novel way to handle them, but there is no way
> to easily move a set of stashes across machines.  For example, groups of
> stashes cannot be bundled, pushed, or fetched.
> 
> Let's solve this problem by allowing users to import and export stashes
> to a chain of commits.  The commits used in a stash export contain two
> parents: one which is the pointer to the next exported stash (or to an
> empty commit with no parents if there are no more) and the second is the
> stash commit that would normally be stored in the reflog.
> 
> Original thread at message-ID: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
> 
> Changes from v7:
> * Rephrase the documentation to be slightly more explicit.
> * Don't have `write_commit_with_parents` free its arguments, instead
>    letting the caller (who allocated them) handle them.
> * Handle invalid combinations of arguments to `export` and add tests for
>    this case.

The range-diff between v7 and v8 looks good to me. Sorry for the slow 
reply, I was off the list last week.

Thanks

Phillip

