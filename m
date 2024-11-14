Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673F1F9EAE
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580120; cv=none; b=Xuru7QhLgjga2q3gbeJ/zf+OoMZ73aapJMmlrXp3sF9sB3M8Mt+lJ1a3cZiwO011UWlKPV4V6dw/xJzVQARBG1rSVWWGBhpZI1LJQSZQiYJGsgzQLxT07yGuC3lWzv/majRqGhUtRNNDjkrkPA9M75IB9LnjTU2eDrrnFjxM/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580120; c=relaxed/simple;
	bh=sKpgE99KHL1weNFegHWMldd5XJ9xkA31GV1XaJBWHpA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ulrAQP6J/UDxLfUOUdDLeeK3HLgybGRaKjKcAnjuMrsMFYHSZFmU5U7+yTQt19LxRnB8tP6TIr0SgTGbyn2/mWLeD8h0415JRmRgBhhW3qZuD3vA8frhm8tfHN2ByVdEYtXT9tgq42nLwn9j+bboOH3csJ82a09Tuklx/ExTvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaADFak2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaADFak2"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316cce103dso5534585e9.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 02:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731580117; x=1732184917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xQJVCxm2LbYO95q5qEhAAbDpejmGrttZ3g8XGlip5M=;
        b=KaADFak2zT04ETI+HT9h3Jd0JG10M6fjpoZfdlBzV3HXlTM2NixWALrom2kHCVnJC0
         kO8QCxovosgKNbOnZWo5ZBSlKnZd4vxDPQkQMchpq2GyDRw0nzDj0p4N8xFa2LATTJ8V
         zz//4tS8Mtzuy48a04aocOpDbOMJdTAWKhKGdIHs9Q/6QXe53CNfvwObleMOBCVDSz1O
         4D3Buri/sb7RsQgTIxYLr9h+lOQNlmal6YVMUVNsdMMMfjzvueKB6QFbl5ge4hIGQeS/
         AHnf0nXQG/htFKE1sEZ9tSdOFBQU5Fi0Rj6UI0ugU/kkJRhCusUdOVMULhpd/VMqPyH9
         Wgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580117; x=1732184917;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xQJVCxm2LbYO95q5qEhAAbDpejmGrttZ3g8XGlip5M=;
        b=CzpPMRWcn40ObNJfgBcJ9lokdlrSaeM8U/b8mKs4U/1NXs5L+4yK69PFsq5kWZSKQf
         ZsnW8k9qa/DkaYEFz4SUN1llXjQGmKyls6ZAoeNUDaaNPzBuVbs609eaXlHgzwSWY46K
         zg0e+wntIVV4tXaEPwuIdBuqATCBEK3uLPXVfGN2Om1Kem0go8r2DUY/rofRkDlwBETL
         bWM2psko//2bzBJv5ejsbMcLfWIPwjHoEPh4hnsMqPeec1JaamwnxJiEoy2DnuFz0s/k
         TkxkjxeuvFphdwuoju4HeLw2LSzn7dK0j438M/d0gZcC8D7Y9oJ9lSesT3rcZfdpapgs
         fjZA==
X-Gm-Message-State: AOJu0YwWkQcKP2Uh9/4ZZEdhnMXrKFx08fcq/d8bDk8aHvd6XRfAVSe/
	q/ELqVVDQs+p7+orO7Nheospb0zIKfbJNwxdR4zuU/n5m3Cxr7jj
X-Google-Smtp-Source: AGHT+IGYPUinPb9tk/+jVFhx3mhidVEVSRHJrc/EwG0N2cp09U7ks2qIBbk+EvPy/YIHqBFK/7/OSA==
X-Received: by 2002:a05:600c:4e8b:b0:431:24c3:dbaa with SMTP id 5b1f17b1804b1-432da76ed1emr18841675e9.2.1731580116894;
        Thu, 14 Nov 2024 02:28:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dac1d85fsm15264495e9.36.2024.11.14.02.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:28:35 -0800 (PST)
Message-ID: <53d40c4a-0f88-428a-8fae-cd8cecbe1768@gmail.com>
Date: Thu, 14 Nov 2024 10:28:34 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] cmake: use verbatim arguments when invoking clar
 commands
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
 <20241111-pks-clar-build-improvements-v2-3-d4794d8d1b30@pks.im>
 <82d3f3aa-b11c-318f-9d47-35e0ebf3ebce@gmx.de>
Content-Language: en-US
In-Reply-To: <82d3f3aa-b11c-318f-9d47-35e0ebf3ebce@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 13/11/2024 15:41, Johannes Schindelin wrote:
> 
> I would not be surprised if this `VERBATIM` was unaware of the quirky
> escaping that the MSYS2 runtime (and therefore the Bash) requires. See the
> commit message of ad1559252945 (tests: add a helper to stress test
> argument quoting, 2019-09-18) for details.
> 
> Having said that, this patch certainly does not make things _worse_, even
> if it probably does not have the intended effect on Windows. But then, it
> does not matter because most git/git source checkouts live at absolute
> paths that do not need to be quoted.

It may not be perfect but it is an improvement on Windows. When I was 
playing around with

	COMMAND ${SH_EXE} -c [[awk -f "$1" "$2" >"$3"]] ...

to build clar.suite on Windows it failed to work without VERBATIM.

Best Wishes

Phillip

> Ciao,
> Johannes
> 
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>   contrib/buildsystems/CMakeLists.txt | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
>> index 2db80b7cc3c6aba840f18ffdc78d2cda1877d8cd..8c71f5a1d0290c9204e094fb266f10c7b70af9fb 100644
>> --- a/contrib/buildsystems/CMakeLists.txt
>> +++ b/contrib/buildsystems/CMakeLists.txt
>> @@ -1009,13 +1009,15 @@ add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>>   		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>>   		${clar_test_SUITES}
>>   	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh
>> -		${clar_test_SUITES})
>> +		${clar_test_SUITES}
>> +	VERBATIM)
>>   add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>>   	COMMAND ${SH_EXE} "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
>>   		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>>   		"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>>   	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
>> -		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
>> +		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>> +	VERBATIM)
>>
>>   add_library(unit-tests-lib ${clar_test_SUITES}
>>   	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
>>
>> --
>> 2.47.0.229.g8f8d6eee53.dirty
>>
>>

