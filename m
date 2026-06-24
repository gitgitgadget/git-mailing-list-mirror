Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EBD3BBFB9
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310198; cv=none; b=bjMaq857jXLT2EPzNy7wfikLto/jtHQ7kyV0+k3xiw9GAGjGZ/9gOYHTkquNhn4GPZGZqRkv+I7gYviN0Jx0h4pc7MFVC9VAgOx6Xv7SMyqMqFPOqLsLv86KMrKXzEiwtEJTSwIgNUgTtO1NLtpkOcWZGFA52YhOQ6JNzM6yZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310198; c=relaxed/simple;
	bh=IByj3Xnr7+Lcr6LltC02GOOR1O4fiPvL9DrFgCv8zLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/zf1bJz/SBq4lOwmQFbqz8MlHRwxQq4w3fCcn/sFGu5AwewKLDkSuF2NLpVa7r1DKSqqfrUj/NW3k5RurjmW7LMEJbPUejgd6GMRtmskF4UymMrxI8oUqFiWZXmMhIl7W2kywaGSqLBdG/0AJfGTfVDf0qkgIIRVtJvcNZ3+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiCIlsqR; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiCIlsqR"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662b76dabfcso1146911d50.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 07:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782310196; x=1782914996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxdXTufpwpcpm++SjvpyvGIp+es18Lb9VDpJ58rxd30=;
        b=YiCIlsqRqjYMLvDQmvoo2KMLifvw/hIvnMT23X9dVn4KHNOlCWYGXHmI8wagT6ddHX
         5jRoxds6bHpjwZ6P2rbcTvNbzGfvlHgDFIZxqx0GweaTa/9g4bG0s8vFqx44k9krYLpj
         mLFWMrlYHS0u3Qe4uqUqivUSONZhc/miFhwmxKUBZ8j9qQvOhh7DJle7KBl6RmM/0Xul
         FqXwaNnfZl0+IhyY0tJ9Oo67313z2MtcVcHdFCbdBE98ctxJ9OemhxP/aFySxrkdpXft
         VIisWgI1YXAZ0U5U3oSYDjSSwRs02HNNzI2otk2pKH+2UsNTzbUrYegLLKF0gIAFsDgm
         K+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310196; x=1782914996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxdXTufpwpcpm++SjvpyvGIp+es18Lb9VDpJ58rxd30=;
        b=NZxfVW+WD28PwI65Em7czf6YsZ6foMFJPXd8QiHURk0/OPx5sZgHi0QGCsgn8uT3nG
         NCKM64Uabgey4j2V68s4BHKv83orCzxNPJteXqBEVsOSbNb8ccYRJpFD4XyZvEIxTida
         vRkjZdH8UoYwC8WaGNxiDtXntf589lpr38oXMowxC11Rrvnb3mii936Tvtuq0pU+1CQL
         pkdEf5krVGrK3M/zxM/fzvdxrayfB9adDgedEIhRkXRiSu9Y4mOGazOXrNWknaQCklet
         nCwQ+AgGBa2EjKsC8opMKNgu41wzHGsa8TxMYTlBz39Yd9KI+DjY5m+cfRGaeFDPYpsQ
         kspw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1qWRxBuROSiLJljsf7YxpQBPQDRQgDY5ancuk21zJ5cP745eLvRzc1ZRnTnYEk4nShOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1X7Z6r9heIBobDAekeIJ2nmJp9y/ONvqW+rSJ0ytFJvtVpUX
	OMlyVnZ04LDMAKuWjXyS2oXEm/dSgZCsGxfAa2JnjffOX4IbHkw4I9sm
X-Gm-Gg: AfdE7clpDrwPMXNB8d55tOtTQFtRR39k08TMkJwLCE6EE1gz2mzG65s2Er6J+pzoi4H
	z2iCbHxaXX6WumX9KJyTwV2p06w1HJDnDTze6bNMgeaaW3D7FcpvamWz1+OelPeZ8QZjNBu1MLW
	aVo05FU5VEKKHDAePY3OfdPph+VWSifGkxg9nLcCEZEVhTdxBCJgy2CjC97D8nhvffqsOGkx6qr
	xqMSw62QwhHHEQtuq1+FVLDHL7+t2RltF1XK3px8wnbevg5AK/e6QZxk92WqlivadSEIYVWMfZI
	sEFHzvP41YY/w/EppeFsyzxR3IRSBmnTXxCHq6sIYzCoAfdYFCy+VDU/g717bUoJpM69r3dk+YA
	oBDoiwvmR3keeZDqygxiD9Id+JWAonEREIk2Klft3XtDhYcEpoqsQpFfCZr1inuMw+lLaay1ACh
	W/UaCVQ/lke+DMkoiovUND/XqHY7ISKjnA+vdy8ajPwgJv8YaMCEiOcXjLOQ==
X-Received: by 2002:a05:690e:4894:20b0:664:7e57:ce4d with SMTP id 956f58d0204a3-6647e57dabbmr54516d50.28.1782310195763;
        Wed, 24 Jun 2026 07:09:55 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82c62eedsm157778986d6.47.2026.06.24.07.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 07:09:55 -0700 (PDT)
Message-ID: <c1368af3-2525-4911-8a42-2188a37f2f15@gmail.com>
Date: Wed, 24 Jun 2026 10:09:54 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] commit-reach: terminate merge-base walk when one
 side is exhausted
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Kristofer Karlsson <krka@spotify.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/2026 8:14 AM, Kristofer Karlsson via GitGitGadget wrote:
> commit-reach: terminate merge-base walk when one side is exhausted
> 
> Optimize paint_down_to_common() for merge-base queries that hit large
> one-sided histories.
I completed my review of this version. All of my comments are around
either making the commit history a little cleaner or expanding the
tests that use the trace2 data.

I believe that this code is _correct_ and could be shipped as-is. My
comments are focused on making it the best that it could be, with an
eye towards a cleaner final result or a more robust test setup.

The most actionable things are:

1. You can add tracing before the new tests, allowing the new tests
   to also check the step counts in their first versions and then
   get updated in the final patch to demonstrate how they change
   with that behavior change.

2. The t6600 helper 'test_all_modes' could set GIT_TRACE2_EVENT for
   each mode into a different trace file that can be scanned later.
   This will simplify your current tracing tests but also unlock
   easier tracing like this in the future.

3. The termination condition depending on min_generation could be
   refactored into paint_queue_get() to help make things even more
   obvious as to when we terminate. This should help with your
   concerns that you mentioned in response to patch 2/6 of the
   previous version:

> I am not 100% happy with the halt-condition placement yet --
> the existing loop in master already has several exit paths
> (while condition, min_generation break, FIND_ALL break) and I
> think there is an opportunity to consolidate them. But that is
> a separate discussion and I do not want to derail this series.
> I can propose some alternatives in a follow-up after this
> lands.

I then have some super minor comments around making the diffs
even easier to read, but they could be ignored as they are very
nit-picky. It's the kind of detail that I would try to resolve
if I was the author, but I'm _not_. You are. Your time is
valuable so make your own conclusions as to whether you want to
go down that road. You've already entertained my ideas around
updating the docs as the implementation changes.

Thanks,
-Stolee

