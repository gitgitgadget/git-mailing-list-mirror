Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548623814D
	for <git@vger.kernel.org>; Fri, 16 May 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390324; cv=none; b=EEq75sulsPxBzezIil2yw0FD4tkGAYollLUbZRXQz7UG2VdIqNogUyt8bnBANtyHRmcG+QkczjkPOVPvBmhpVIpTC2OjhyPGTZs0MpW4i2zwBF2Ou421RC6UfwilbFx5YGngg8bUiRpXv74y3RaHUnUYZxobYHqSmxU6aoUwfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390324; c=relaxed/simple;
	bh=Gs4fwkKwCYCbmPOiXys2lLO6Vhw9FJdmY4lo+uFfn1E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gNsv2GMs2id2DRLqfEOaCLZ10Q8D8dyyWhqAkFwnma+Slov792Vzj0q2xVUGassyzTlba3KCMvtxKUyXqRAlCL0Z9Ei4PFLWjWvHdp1i+028+hJW5QtI3CSXNsG8XWBpYuZIESfA6QgoaPmf0v2NwknIYlG3jOLGCQ9ZXi2Nb84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO0hENrS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO0hENrS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so15173055e9.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747390321; x=1747995121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NwLtOkyPiunHoC0NM4lmz5Cv2m30Hjin2k1ixqDuSWg=;
        b=jO0hENrST7TF2I1fbK+f7RymWkQxinYRcLECb3bIdeN8MIRGP8P9csQZZCMmeOfrCn
         FlYOski4FflJIb+D0fxl4KyTT/z7rMcGowGQo0waarjJNPICClDlxT4tVkAQd9bqRFZG
         dB8LxIT+EDk1PLFXEUnG+YJ6LvLkIpMgWQ4nLRtvnIPEHhIJMb4osJ1pdjw54o4NWGnp
         aLz4EPezIaqDjnZOpFT1Dg5A35inwY/+zRy/qX1XhLI774ReCknQzpwJTAxBV+2/udbM
         cQD1lHRMBnf+ykLCR4kQ7caRVTLxPKrAqjvTATxUqCSc8SriG4HUqzJGowon5mIXirIp
         oAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747390321; x=1747995121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwLtOkyPiunHoC0NM4lmz5Cv2m30Hjin2k1ixqDuSWg=;
        b=OmgYPWZxBDJG14VW5TQbO5Y3ZM1k7TR9/sE2xoU6wKF6edRkma5k8Dk5h9MMZzNgoa
         GskOpSk1FtZsd9+KnO4QXDi78JZLYXXph5QZ1iRvSYjusZ2FpGXiCWJNgZX5mJcCE9OW
         cvQcjaZJPOMhY5fXa0o9VmvOj3EakcwaEgw6WI73LZJruL1x7z8cFmX6YKFZPZza3fy9
         EU+mmq/Ez44426oXC/fQkP6mAxqdYWc+DJiiCdw9E1gxhtabj1VPE+b1Zm0QPy8WeP9K
         fSwGPrF2XPNtVstOfFukVKVPhNan6hPrnNWa3k0S8E7HmElOvYzWB9H6MA283jKF85Gx
         GgJA==
X-Gm-Message-State: AOJu0YzmIdmRm2lu0gpJ/tOU70tFHIb6PjnonLLjl60N70cv7me4YVtw
	+qNpoqAdwtDFNv5d7+kSB5Krxr8AhJTduet1ERuiIHJTChdTBO98BwwR71KOJA==
X-Gm-Gg: ASbGncsRMEX6FX0zFRElTvN8fw98qL0eJKNXuKWb2ssDWr7TXljkcnpeGhCUfDRT073
	O4oZwZs1Ya3hfFzWk6oMLRhtujwplqRo1/ggPD7ssVMillmE0LDxk1/JyA+LDI1BfYsc3R+40KP
	07j/IwdMNZQQdz9FIlsQ9qlM2moPfsHeD2k8U8SoSU9LESBC2TcGc0IMzbaf+tzCwWgl9R2hjlm
	KwSnpWkNKTHSYf82rp4BniAuaLORRIHUgMu8O0uAfRG3NueICvL0z0mjSC5GvO5mSTCpx5OkuYI
	PzzMOsioIHuN4D1nRgxIUanLRyifL1SUTeodRPEAxUmmojXl0LeiR192MxIcG3FOT+hlA/RcnN0
	W8rGlQjd6OwDE7IAGG2I6TM52
X-Google-Smtp-Source: AGHT+IErhkN9jOajV7Wo0Cmnq/w5Xaf/lO5mCBOgPAs5WyOxtu8rPmbn1ZzETcutikt63cbuceMLqg==
X-Received: by 2002:a05:600c:4e0f:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-442feff05c2mr19456285e9.13.1747390320454;
        Fri, 16 May 2025 03:12:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:8d23:ce23:3b:22a8? ([2a0a:ef40:700:a501:8d23:ce23:3b:22a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f6f9b309sm79226665e9.30.2025.05.16.03.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 03:12:00 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phil@crinan.ddns.net>
Message-ID: <694d8e62-486b-43d4-966c-4fa1e5a95061@crinan.ddns.net>
Date: Fri, 16 May 2025 11:11:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] bundle-uri: avoid using undefined output of
 `sscanf()`
To: Jeff King <peff@peff.net>,
 Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <4dc3e2335afb42e5006ead7b9b18d33bdae7238f.1747314709.git.gitgitgadget@gmail.com>
 <20250515202502.GK3320240@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20250515202502.GK3320240@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2025 21:25, Jeff King wrote:
> On Thu, May 15, 2025 at 01:11:48PM +0000, Johannes Schindelin via GitGitGadget wrote:
> 
>> In c429bed102 (bundle-uri: store fetch.bundleCreationToken, 2023-01-31)
>> code was introduced that assumes that an `sscanf()` call leaves its
>> output variables unchanged unless the return value indicates success.
>>
>> However, the POSIX documentation makes no such guarantee:
>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/sscanf.html
>>
>> So let's make sure that the output variable `maxCreationToken` is
>> always well-defined.
> 
> Definitely an issue, but...why are we using sscanf() at all?
> 
> Wouldn't strtoul() be the usual thing in our code base? Or even just
> repo_config_get_ulong()? The behavior of the latter would differ in that
> we'd complain about a garbage value in fetch.bundlecreationtoken, but
> wouldn't that be a good thing?

I had a similar thought, though to make sure that we parsed 64 bit 
values correctly on windows so we'd need something based on strtoumax() 
I think. There is another call to sscanf() in this file which the 
analyzer does not complain about because it stores the result in a local 
variable that is not used if the call to sscanf() fails. We should stop 
using sscanf() there as well. I wonder if we should add something about 
not using sscanf() to our coding guidelines. Apart from this file the 
only other use of sscanf() is in a test helper which doesn't seem so bad 
though if we removed that we could add sscanf() to banned.h.

Best Wishes

Phillip

