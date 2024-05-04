Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18619219F3
	for <git@vger.kernel.org>; Sat,  4 May 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714831068; cv=none; b=BoYm3K7i3nUHKKKYzESp6XEDIrL5Gv5OD/yB7y/23MbHSEaVksciiMj/4YSTn9NZaNcoiq0wkeWW56e9a3YfyRbOJDB3D2YIPfGeQZHG0ifyyS6BXT7dVxvWvxKHftB0A33byOAW0LrshKlL1rYL8mYpQZr1gtfPyeS2A4hnPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714831068; c=relaxed/simple;
	bh=3Ax5li+JsCjmXVmrrLzDzkh6R3IXJjqPRvqbLSvjtwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+cXY62GyVt6135DysWN5qZ6TAcXlFxEnZb2s51ZQrvnbgFJTHLbxwRpH9cBZZ+MuceJxXm5shMXaDW1X19CtjKzuTAtLFzSteDDuuAJI1Lg+/d4GQB+Kitq8UR5oY3VtZKExrmAIg92YNJw2eG+zM+Ekci4AxhbsAODwutyJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaFdX1yD; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaFdX1yD"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ee575da779so307752a34.2
        for <git@vger.kernel.org>; Sat, 04 May 2024 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714831066; x=1715435866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHLDI6VARbL9ZeDPK6Qx8BLclXW9V2dOeFrB8ublZTE=;
        b=aaFdX1yDbGvPYmqWzMgaV0x2D4HDjvwcaGGat5HCF6Wm09wKqrrl93MANIeatJhg/G
         QlTr8rzIUNjy0qT0iQX5LCjUEMvMEGGcG+UhOTOiO7tvw61Q/xG/7xTFUXB/kBH9Gpkq
         curNRlIOmnuUV2d3RrY9lpYoYAmzAFutBqmnzmatqqzoCdNRvywGSYI4J4az+uuOKiKI
         QbP9IPQctLtq9B3G57+abyb4qiTmlWFoqHSmNUkX8z2FGhyXcOVNdq/WCQEV7dmF3KNm
         i8P5xnbbESYBMccWJTEgQYOvcKyCubp/uht6JCRUaIu8xUL5CZ/8b0XncxJlN4+7ORKa
         OmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714831066; x=1715435866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHLDI6VARbL9ZeDPK6Qx8BLclXW9V2dOeFrB8ublZTE=;
        b=oatvPTZ5niDSXiHlzZKmp4GhacKUYw71KQKQ1P+2or3yDNR2kbj90fIWereTkdVGoj
         0iIXTzwudg58AXAM7dD5O7CmwvREL21ZW9R6yEVWv/xtms6q/UptBWzXji0RMwGXoneC
         WGfOYPRXt57IEQz8mETJ0dJAxgDKn/AvEJgUelZe3yjaQft77m5+uvOn5t2jflVhOZ4m
         mcge860GzuGRGxUz6MKlglXZFvK14FF84yDYlPs9zvoGrFMkiwDTqKLzcUGrn5qY7yMI
         VOMNyXAJPCc8Hs12B9TRvzBSqhUA6ObotvlRn0i7nnNrLeD6RIshPa1QwhVL/8h2sXRs
         ZyWA==
X-Gm-Message-State: AOJu0Ywb17AVf3nmwot5T6BkGYa5yAHT5crB4rjydzYSiD4GxNK+8pSM
	qH9UlgYD9Ai0QzHWV7U3i+RYoyaE1cksN1fDigvCU4zVibQYnC4L
X-Google-Smtp-Source: AGHT+IEAk6NwqGnfRkhWS+7u7JXkIvexqI/VaHjVudn9elEyX5lM40Ou1igoK0W+7HseiOOxATV7dQ==
X-Received: by 2002:a05:6870:a790:b0:239:8e67:6f10 with SMTP id x16-20020a056870a79000b002398e676f10mr6646238oao.30.1714831065931;
        Sat, 04 May 2024 06:57:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:80ec:25d9:aee0:4557? ([2600:1700:60ba:9810:80ec:25d9:aee0:4557])
        by smtp.gmail.com with ESMTPSA id wz7-20020a0568707ec700b00238abc3bb0bsm1027535oab.40.2024.05.04.06.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 06:57:45 -0700 (PDT)
Message-ID: <0e043864-a5ce-4e21-97eb-15a0bf614fc8@gmail.com>
Date: Sat, 4 May 2024 09:57:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scalar: avoid segfault in reconfigure --all
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>
 <ZjM23X_Tf3pcWsIq@tanuki>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZjM23X_Tf3pcWsIq@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/24 2:46 AM, Patrick Steinhardt wrote:
> On Tue, Apr 30, 2024 at 04:58:52PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> During the latest v2.45.0 update, 'scalar reconfigure --all' started to
>> segfault on my machine. Breaking it down via the debugger, it was
>> faulting on a NULL reference to the_hash_algo, which is a macro pointing
>> to the_repository->hash_algo.
>>
>> This NULL reference appears to be due to the way the loop is abusing the
>> the_repository pointer, pointing it to a local repository struct after
>> discovering that the current directory is a valid Git repository. This
>> repo-swapping bit was in the original implementation from 4582676075
>> (scalar: teach 'reconfigure' to optionally handle all registered
>> enlistments, 2021-12-03), but only recently started segfaulting while
>> trying to parse the HEAD reference. This also only happens on the
>> _second_ repository in the list, so does not reproduce if there is only
>> one registered repo.
> Interesting. This also has some overlap with my patch series that aims
> to drop the default-SHA1 fallback that we have in place for
> `the_repository` [1].

Thanks for this pointer. It indeed will help.

>> Add a test to t9210-scalar.sh to test 'scalar reconfigure --all' with
>> multiple registered repos, as a precaution. Unfortunately, I was unable
>> to reproduce the segfault using this test, so there is some coverage
>> left to be desired. What exactly causes my setup to hit this bug but not
>> this test structure? Unclear.
> One way to trigger _a_ BUG is to use an "includeIf.onbranch:foobar.path"
> config. This will cause Git to try and look up the "HEAD" reference, but
> because we have a partially-configured repository, only, that will crash
> with:
>
>      BUG: refs.c:2123: reference backend is unknown

This is a good extra find. After your explanation for the second

test, I'm confident that I was hitting the detached HEAD case on

my machine.


I will shamelessly steal your tests in my v2.

> This issue should be fixed by my patch series in [1] because we start to
> use `get_oid_hex_any()` to parse detached HEADs.
>
> Anyway, your fix is indeed effective because with `repo_init()` we now
> properly configure the repository.

I appreciate that your series will fix this in a ref-focused way. I think

this change could prevent other bad interactions with the_repository in

the future.


Thanks,

-Stolee


