Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FA24A047
	for <git@vger.kernel.org>; Tue, 27 May 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748334391; cv=none; b=MBPRd3gjd+dgz7XfSkgFVwSKtdMJ0fO3pdK7NYARm4sHGgTvvLhI8TsEGDqNIUYXxGG7vcm6EXWXVQ7B2rv9FBvDO4clCXC8mzYEY+Ke9rPEtvZNWffHoBtrOSRA9AmSeHKN/sJ+p5asUeznIhDMFd/ln5JAWJjvRRFy9bEsX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748334391; c=relaxed/simple;
	bh=au7UiI4GlALCbcYpbh63eoG0encv5wU+w2M91xIKNfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PudWgNOdbYiJNjr6kgFhABc1DffidbMleG1jJaZrBZIXbzdTPXbnV+6E8iz4AzKATASKcYMlzBTeBtkQmYTYwQWk62s8SBsHFaSmiEPe9x6jS0hh28cSKgV79qWkL+ZYvNOVBxtj2YLH0EW4J58BQOtTqZpgzrYcTNpSm8ERMEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW1VyTZb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW1VyTZb"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad883afdf0cso214301466b.0
        for <git@vger.kernel.org>; Tue, 27 May 2025 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748334388; x=1748939188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GjwHzFdRSBaFUxp+kvIM3BH8nxRAIDQhPAxr5oQhvew=;
        b=ZW1VyTZbn8S1bySzHtfdzhNgwtxKO7yt6AhE0FTTWhsQP0SeBl5SCh/wkyH2yGaiMd
         SCWpbCKBqSEDc4owqB1JvLDVeX6IBLUY69Jot7MumwUXmvk6v2sCQ4brcMZ1FqI00yGv
         i1MPJK2vhOrL9KlADFCcXOtz1avBiv1Lqg/GpfbVe0ODEZ+6Ux3BytfQ1l2ZYDYzyO6w
         DN52lrVB3YJ5ddYfgJzI5AzwtAdIkNRU63Qe2KiO3RiMpDzX+kCIThJySZQmMYhPp9lk
         7RNnWfVSxKDdjcQA/yGPIDAYEwKlKfFME8dE8QigszjpwQhD6fJJZoiAX0amvhAg9kaz
         cM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748334388; x=1748939188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjwHzFdRSBaFUxp+kvIM3BH8nxRAIDQhPAxr5oQhvew=;
        b=aBrOUraJ/7l8veVgd17mZZTEFCm3ICLmUSzPG7+kzChSEUb4eTZTYNHboHjyB+JpHE
         u4cDx6HPUVx1ns7JRNFJhL5H5umKhjeiAqp4IOOPWYUmT8RJ5nWeZMPwVrUfU+mCGZli
         8dmEJFicStpRMj/sH11qPbG6twWQvoY/Rxo5VshLmETFinnQQNEgsLzXyhKAVMEM+IGf
         ou1R2qnimpPInKNCnNohJlHd7N9Tn94/SIePArIaWzHJOytDBj6HimJDZ1C99eb/fIOA
         Hnqg+AurzL6flX687ayinK2es7O8kO3PTC7ltnPkrsA9W6visfwhdb1uUfaNAmOneqxn
         QhsQ==
X-Gm-Message-State: AOJu0YzattdPxAmIUENdLQrSajMiGTgXVJONhXOR/uXsiTpLvv0KnM9f
	+ktb+TzKKKCUPk+J4g105FBKWnRCrzrfPIQM1AwgWWJcGp9JYzOh/NTt
X-Gm-Gg: ASbGnctwpuOCzLDP82byzbCb6xJZZ6N7L1MQE63RiIkK2R1nAgdhSHLUyDfjCizuKKf
	4yypLuVBCuv9sc6Q87auE8UJFEg7weZCY59QNbN9Y5XR6kIJMqOoPumhIeJ0DcwYdCrAISERZSX
	03sFJtIsYQfzvZCYDmNoxLDBrpXsHqBrX/qoCPHf4qOgPVYAyu6i7+knuT6o7XqH+mgapfba7Hy
	9dqXTebOlFVnGWW5nBQAJZeoGxgmtxZ2ub6FeHfZcnbBE6m+R0wGmhleVMKqLlIE+G4DX+NkYtk
	ZXsUDk4NbQZBrqDC6oFIXdwR9zbZJYT7DzA16HwRabOzoT0G39YsidVyP41Q5yaxkc6U4ZKpq9Z
	FSEDQERrAgDLTov7Ueae1vTHhOoA=
X-Google-Smtp-Source: AGHT+IHxZoAZlREC5fW8GwwyFgV392fnduVz6QlyF7YZpD2djcJ2T0toA6HVNPPiq7UgFtmfGY7UfA==
X-Received: by 2002:a17:907:9688:b0:ad5:2a24:7c09 with SMTP id a640c23a62f3a-ad85b2b55e8mr937302166b.60.1748334388159;
        Tue, 27 May 2025 01:26:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d04e816sm1789592466b.23.2025.05.27.01.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 01:26:27 -0700 (PDT)
Message-ID: <7b6ebd22-78d9-486a-8be8-3da475015a8e@gmail.com>
Date: Tue, 27 May 2025 09:26:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] midx repack: fix overflow on 32 bit systems
To: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
 "D . Ben Knoble" <ben.knoble@gmail.com>
References: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
 <cover.1747929225.git.phillip.wood@dunelm.org.uk>
 <aC/C9oQrcx/RiyP1@nand.local>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aC/C9oQrcx/RiyP1@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/05/2025 01:36, Taylor Blau wrote:
> On Thu, May 22, 2025 at 04:55:19PM +0100, Phillip Wood wrote:
>> Phillip Wood (4):
>>    midx repack: avoid integer overflow on 32 bit systems
>>    midx repack: avoid potential integer overflow on 64 bit systems
>>    midx: avoid negative array index
>>    midx docs: clarify tie breaking
>>
>>   Documentation/git-multi-pack-index.adoc | 11 +++++++----
>>   git-compat-util.h                       | 16 ++++++++++++++++
>>   midx-write.c                            | 22 ++++++++++++++++------
>>   3 files changed, 39 insertions(+), 10 deletions(-)
>>
>> Range-diff against v1:
> 
> Thanks, the range-diff and patches look great to me.

That's great, thank you for you comments and suggestions especially with 
regard to large repositories.

Thanks

Phillip
