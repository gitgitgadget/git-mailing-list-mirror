Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA251DA609
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457143; cv=none; b=WYx5cVTYutFPC7zHbfqPKkFEn3Tz+prtSp+rEPiBtm/N4g90uthIjBypwDYzZzxrjqHrLOHWe6M7SMZvtbpUqtSKul+dyu4s2F2KdjGXH1WVkx+hncact9nHoCGzEzlS2iYXxMPKJ3H4w5gFlFwr3oImg3RWKRqlJYnmK60wVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457143; c=relaxed/simple;
	bh=ozTaZ0akT3PY4/yY0lGSVKiGtNmWZkH1gn7notb7IK4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R63Gg96eLzZf+l6CcP7SzIitSRsD/D8on4jaTABgJPHPzrSoB4u4r+oURXIB35CFkKjCou0WycTu9CgrnMZiqYHEeuaNBWQODcZcRjzTGRurzQB/RrT7UsVqdcEB9fM7+2RikIdG1CQfEar+oMCkWPQnvRPYcQnIKFlY1xDeyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3GZQ6ZG; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3GZQ6ZG"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a868b739cd9so800411966b.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725457140; x=1726061940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aylTD0P+RPR0a7clQpO9vsgv/7np4Rxv4klzCqUh4vs=;
        b=i3GZQ6ZGkCrS0/jbAHhkFXpVC/vJfyYHQQ1pA8AhU3FiMbiWTA68ciQf5og2T1LwzU
         r8glIHl6qKsoVZJjK/T6qoaiyvNoOWTqz20bM3AO3pTKbsOsDycJYH6Nj10vZG1myFGG
         ydZ5xZi0tGMnqGc+adhjS5c7q3PuaxywcYCinZe9gmBwtNrO3RX4SUb748IE5bVQ1Efj
         Si2VS2+9dUuuvN0XA7k+twazVZUErYMHQH0y+55mIXynK4DBvzQw2J/ahzeSF2hskcUm
         rp7r3ojKTiIjHe2z6Dg4DuKy+W+cmpcEMm6swhsVzNO88DbGPvYOKHqQT4QUh5jIyAZz
         eNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457140; x=1726061940;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aylTD0P+RPR0a7clQpO9vsgv/7np4Rxv4klzCqUh4vs=;
        b=fROZWRe88AfoyHIkPy8Oh68ZdpmmKfcGLeMZ+87WVyTaLCDu3RmMMfE9aRipzC2nmS
         K3krajW47R9DoCev3s8sH9jD+7rIg5XyqlxB8zKqHFNuw30ZazIZy65YZM5IXyjKYRRq
         Thp5Od1qHhsJux3gmpcUqJONcOpdMiQYe1d5b02AfMioqwgFRAf65mWW9Z8W7afBvWgf
         xH3LMXSJgEuwi/qCUfIfFaBFfAxo3vec60hJVf57RCjNLXqf8YhydSG+by/bl86nb6qn
         7jK5OR1qktGFObrCWk7wNIkiavdBK26hqGPeB2pVCDrjgXMjoI0m0VsQvE2Fg8y19Tro
         HYZA==
X-Gm-Message-State: AOJu0YzPaxp7QaGqEOr46xbsspa+Tsu/fbywZf8vfVVqutCBYAQ4CbAI
	hOfY+OWrAEu7RC1aQCcH3fMrhqkVqD8r+2yxj9Dvn8LHecTB31SC
X-Google-Smtp-Source: AGHT+IF3ADgrqX4cjjtF4dhchgoQ+gPV6KwxbOK+OMMBAA6qqSasB12luOZvgotnUbYp7ILGNprn+Q==
X-Received: by 2002:a17:907:6088:b0:a7a:bb54:c858 with SMTP id a640c23a62f3a-a897f84d6e0mr1600579666b.26.1725457139790;
        Wed, 04 Sep 2024 06:38:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989221c24sm804691966b.196.2024.09.04.06.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:38:59 -0700 (PDT)
Message-ID: <23586012-f3d7-43ba-bec3-9e67808fcbd9@gmail.com>
Date: Wed, 4 Sep 2024 14:38:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Sep 2024, #01; Tue, 3)
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqr0a0fik4.fsf@gitster.g> <ZtgBKbEnL8xJBGpE@pks.im>
Content-Language: en-US
In-Reply-To: <ZtgBKbEnL8xJBGpE@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2024 07:41, Patrick Steinhardt wrote:
> On Tue, Sep 03, 2024 at 04:01:31PM -0700, Junio C Hamano wrote:
>> * ps/clar-unit-test (2024-09-03) 14 commits
>>   - clar: add CMake support
>>   - t/unit-tests: convert ctype tests to use clar
>>   - t/unit-tests: convert strvec tests to use clar
>>   - t/unit-tests: implement test driver
>>   - Makefile: wire up the clar unit testing framework
>>   - Makefile: do not use sparse on third-party sources
>>   - Makefile: make hdr-check depend on generated headers
>>   - Makefile: fix sparse dependency on GENERATED_H
>>   - clar: stop including `shellapi.h` unnecessarily
>>   - clar(win32): avoid compile error due to unused `fs_copy()`
>>   - clar: avoid compile error with mingw-w64
>>   - t/clar: fix compatibility with NonStop
>>   - t: import the clar unit testing framework
>>   - t: do not pass GIT_TEST_OPTS to unit tests with prove
>>
>>   Import clar unit tests framework libgit2 folks invented for our
>>   use.
>>
>>   Ready?
>>   source: <cover.1725349234.git.ps@pks.im>
> 
> I'd like to wait for a (hopefully) final review from Phillip before this
> is merged down.

I've just posted a review - it all looks fine apart from the 
implementation of "--immediate" flag which we could drop until we have a 
better solution (c.f. <e435e05a-376c-4928-9852-6925df855399@gmail.com>).

Best Wishes

Phillip

> Patrick
