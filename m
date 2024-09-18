Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEAF9E4
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653899; cv=none; b=EkvA/nQAF/US1I4/Ssz4MBfmlfEM2Hyzs5jkLk5w8T87Ej4HJJcFrlomMli4zDk+E53EK8FfaxtGPoCa477e/Pw1+zeCbfDVww50lxciGwNNu5I763n4tgCBlihL1+nvFUil2rztiDR0HKO0RKU7MO80DCcW6PXDaaEdQEVXrd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653899; c=relaxed/simple;
	bh=+bkTV5AHGZZm0i0Pu/o/bjn9g2E60XPfh4J1vZPjvnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jf2C8vK9T7AX1C1lF49nI91Phdz+1T/9ek7DENODPvRhiA51puG6fewIH9X6lKCHNxzxFMJXhhTrnbhlNtPB6tS6gIj3xbxe6/nUGQUkjAytIxPGe6hEDWPamPRCkBeN0dSyBJXzkfoY4pmixlWJFm6TgPcVECOH0PbBdzAon0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SELjNxy+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SELjNxy+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c1120a32so4485300f8f.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 03:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726653896; x=1727258696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=36Yj0bLnbTCFBAEevTFmg/r/4100ytAfsAye/TzxdBw=;
        b=SELjNxy+a9ZcnLwBkK5A/TU80ifwFL5NzSe0oeB5H4zN9BkEgoGvJ2mdfiqNor+52y
         UELItsAOUN9+v7hiB0bUEE1duMApyNurANPYYWD+XD/4u+esr+xj4oqy7ttm4aZWyRKP
         p6tcSVZhTEzOCA27F6CHIIZrKQh/7sn3jB64vi/EAMSxIfOIzrO2b8cEWA7qcgJuxaC8
         IU26LOUlrL8MRe0UUS0j9egX6hcF5ObVjYVw14d2Q1BGvaO5SkuACuWV1kIt16MGi6OP
         DNlQihJaFnIU7Mm77CUUQMu3mXTZTHiAfZHNh+q12XXtM7xyda9JDE72epyhD6bbEL8j
         qmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653896; x=1727258696;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36Yj0bLnbTCFBAEevTFmg/r/4100ytAfsAye/TzxdBw=;
        b=RoCIjrUevmrzEELnNoiPso2H8by937FP35c/vi8PDqCUKkic1Z20w/390LkMwBz1HW
         Ao6N74BjC52vnO3d4F3qY6tRlFuxkxhKLIjyJxV6n04jOpTei4j+xVmZRuQhKTcESUgD
         FWyPKOAokvMIjmpOwqwHD9xzqR1VK+xiGeQ8WsYorviQJINtznc8B3OsdJy8rLvEUk1u
         MLkAGoKxrqVSzZmbhJmNpqYU1QLE9q21fPOsialFre8Dr9eegm03ZO9+WtSTtywYnE8j
         pg4iyHprBO+waJcx5VcQALAKzVUiOV8mHn8WiAQUXbJ7DN/u0zGF/lQtF4rDjOJFuKwZ
         3DUw==
X-Forwarded-Encrypted: i=1; AJvYcCW05YSWIC/2/SGwG1L2xlzvBWrGJZzQ0e57EimQLEwnUOXCeQsC81cVRmknbHAZZlgRi0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/BQHu5cJEIk9dILQKHIvWy5mYfVXnA1BUkXKxVWmLgrmM+9h8
	cr5DjOaz7TGMnhzNr3Wmdfdayv+/luufPD4kwyI5jZFZdobmI+MA
X-Google-Smtp-Source: AGHT+IEImbYNDFwGnPtRVh9fcxiVfZGxlez5n1eroFf8LXvZiixhmnQgjSgB7cmBJcz0wpJw8tdsAg==
X-Received: by 2002:a5d:6946:0:b0:371:8750:419e with SMTP id ffacd0b85a97d-378c2d4c8ddmr11912720f8f.47.1726653895673;
        Wed, 18 Sep 2024 03:04:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e78054absm11922907f8f.106.2024.09.18.03.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 03:04:55 -0700 (PDT)
Message-ID: <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
Date: Wed, 18 Sep 2024 11:04:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Henrik Holst <henrik.holst@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZufjWR6AJM-DIWPR@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 16/09/2024 08:50, Patrick Steinhardt wrote:
> 
> I sometimes wonder whether we should move on and discard one of the
> three build systems we have: plain GNU Make, autoconf and CMake. And
> from these three I'd rather want to throw the autoconf-based thing away:
> 
>    - The Makefile is probably what most people use, so throwing it out is
>      a no-go right now.
> 
>    - CMake is really useful because it has support for IDEs and
>      alternatives to GNU Make like Ninja, which builds Git way faster
>      than Makefiles. It also has support for out-of-tree builds, which I
>      find rather useful.
> 
> So is there a path forward to move CMake support out of contrib/, make
> it an officially supported way to build Git and then throw away the
> autoconf-based infra? I'm not the biggest fan of CMake myself and very
> much prefer Meson, but we already have it wired up and thus I'm trying
> to be at least a bit pragmatic.

We seem to get fairly regular bug reports about the configure script, 
presumably because most contributors are using the Makefile. It would 
certainly be nice if we could get the CMake support into a state where 
we could consider dropping the configure script.

Best Wishes

Phillip
