Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE879143C61
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581356; cv=none; b=k62y2WVdpN53aiRs4B01LWbI1md/JDYer2CL543RbwLxLW2jTLa6bZJlOz/Sic5uDkaDq6UgUPatP0b6iu5VJB1LEXaMVfceUMsMOoHO76GejtJghzhVP2m9T4iICADNerMac+VC2AKCgoZQfhkszLtb8PJ57MUyxhvrpi3Tavg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581356; c=relaxed/simple;
	bh=5rSIq9viJp2rkcmvm+pclhrvshtiqfPKi9jKavcsAQA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=tQauhBkjEaMO0vQwpHtfuXtsoODDNlZ3xVF2tOU96YU+TGLiqXP5zmZJj99et0C7kd8WgIYKw7JPHZU8jOruLlQbU/7oHgq6aWZuM23ajYW7tqrrixNrLVBODeQoQsU8gj0TH4GE9fXypIC+KPhg9qsOPr2ifrgdog+k8yKj4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2hGIe6h; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2hGIe6h"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e72a786b1b8so431746276.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746581354; x=1747186154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XxKDYhFOyP85eToVu1IRD6/jYH3C0tHU4pHXLp4JJc0=;
        b=j2hGIe6hj85JA+q/hjDnuLfmFPaw/0G5vPndRzx66f/Z2m4R/MPZCq7Hz1HmsKDw4I
         IYLL8E0bHUZDlROLJIQpawkDwRNAms5bVSKHsUflvRgUg+D27rneD0o07jFYEpm/aV6S
         85iXe/uSYOCrjG6Kz/3zmVjl/3TG0vF7Kv/kIP7fPHnuyMWyYvJk/aNSGTQJRIgOEg9c
         XUfKvBeixF/gKxb10dBGsq85oVIOSnisuOOtKRimmUJHj8o6YoXepjNRWYz1WIEVniN/
         t2x4yeNXtqHH/9rAhyT0A/TwHaHOGWwwKKwD0NkGr/w4Pw49hf8Ged/Sg7W9PKaV2nKR
         NFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581354; x=1747186154;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxKDYhFOyP85eToVu1IRD6/jYH3C0tHU4pHXLp4JJc0=;
        b=vWI9DySjEwbt4H/8e2/5tGqpwmG/S3gzzDIMkFvhRHmeSnQEoZo143iTc0H4ca6qzx
         v/RyN813OG9v9/wb5MUQNR08NCeXyi/Ww7iPKElqQ/iQykYalZJWMA25QC94Mk7mvnhz
         b0xMuLvWuSzp+NwuZzo3kX/xlZHUoC0nkMTt4vXq5hUmHGhMv+r9kNYljQUpJfi/etdD
         yo312ZmZJM9aCWjZdG7mx1iTGY/BUWrVYswXCP1RaxPg9RR2H0bPgLCrWZ7bre+TljhH
         ixHZgaxPMASYBzm1vAyeuoYga4jnzi4C/4I674D+glBWNDoL6wdyApovEP1peQ7OTMBp
         6e0w==
X-Forwarded-Encrypted: i=1; AJvYcCWgs/UQmlWAM9ZZ6C22TUm5go768Sd+kVTIQ2pFFlRDBY75DVD0xIPtW4n5LqOS2kDzyXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNItpgkNLK/gGIv0FkITTHtUu1tDwZeT2x+wk+5uhTke0U02b
	S+5ptZFZt0aku+50XNKgJDj8ZtjtqWJdwDUWm+6w9nksF6PhMfjW6QcO7w==
X-Gm-Gg: ASbGncuR0hR4cIb2MQB7ox2Z0MzKw61o6bhO/8aBGieglHkq2rRiKKB8L30hhrRbPxk
	BmzCmXXCQ8boeTw3aE4LJkk10J4gM6oFdsQ8bJMK6NJ5PUY8Xo8gLJqWcCX/uvKTiTeFQrTTVuo
	BvbID0s+kOQX68ngO2ux5PC99W+t1phr3rGWutM2TbhMAxhE8w8TLjaPJUwEs9FWE4eKFggGCka
	tQh9QO8szz3XaAB/u/8UufJNN4vwe7Xw6Z5jbwjfV75W7ZtrOylAllMLyAp82llMbgi3M1NajCj
	DlwMxRz/pkhUnwmZovWj8gclGlYjm0oG/83IDDnCEd6FcF/VPmOZCRM2DjZRkvJjiuFJ9c4tMON
	UnQ84uN3a5QML96H0Od2esIGqgNsb
X-Google-Smtp-Source: AGHT+IHfvwvKOpXwiWqZ2WnbiPmV/nNkCGQq4ABornRjPX3l81TozIdU+n+dRYKMK5PWgRUrp92aIQ==
X-Received: by 2002:a05:6902:218d:b0:e72:bb81:4fc with SMTP id 3f1490d57ef6-e7884cbdca6mr1720666276.5.1746581353744;
        Tue, 06 May 2025 18:29:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e75c0022197sm633803276.36.2025.05.06.18.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:29:13 -0700 (PDT)
Message-ID: <0f885626-d676-45b1-b8be-1ef5e63ffb78@gmail.com>
Date: Tue, 6 May 2025 21:29:12 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] odb: get rid of `the_repository` when handling
 submodule backends
From: Derrick Stolee <stolee@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-11-c05b82e7b126@pks.im>
 <a715e7c7-20a7-4a2f-95e3-28d4d4bc8995@gmail.com>
Content-Language: en-US
In-Reply-To: <a715e7c7-20a7-4a2f-95e3-28d4d4bc8995@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/25 9:25 PM, Derrick Stolee wrote:
> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:

>> +        if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
>> +            BUG("register_all_submodule_backends() called");
> 
> Did you plan to create a test around this test variable?
Please ignore me. This was re-used from before. It was just in
code that looks like a new hunk.

-Stolee

