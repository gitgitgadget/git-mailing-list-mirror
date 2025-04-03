Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260E24CEE5
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694011; cv=none; b=IuXqSu1ePCXD41pYJpo3F8MShC4t4rby8gBTk9ki5qRIVEQtRD70+IxF4fa+582KiYCXocfVGYOlqdyDFjaPa8///RfmStqCvQFl+FLfINWxeHZTIYLE2j2ZPTxQEQLm8TwmWqDRwj8crEHA0WVagvG892OqUhcNwo1uNF4tjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694011; c=relaxed/simple;
	bh=cgh0bGX3SZmU8g7JKFlDEgW/1SXNaXWJQcsLVqTOOsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S06MaXh8PCQL6aZtS0htMA/aHz4GKdJ5dXlUMo7Mt4lR1dz/wlEy+T5Tr26xcLXmg70vYfPMfqrIr1Y6ZWxVLu6yrbvuD3JyI7eq5EaEc4dwZM6fSPbAqfZjij/JM/HkkByxV46XeeaO8U/wgxNMIF32oGNjV22wcANIMjKvp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9pFHWhD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9pFHWhD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227aaa82fafso11368965ad.2
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743694009; x=1744298809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/IKpE+Is6r4WFqqxEjIAXBzsXSD1PWNwDmNhKWUe2c=;
        b=I9pFHWhDOlbfTRP7K7ZSNoUkVyzTuoV6rqQn4CDPWqaiDQyZrpzZ7BITac/qbywFQX
         P04E8ZLf4NQts5O888NLP2GlVcyflQwiIUp6H69cBuN4gBRKjLGpEzoKoUpYcbayEHaK
         9QDoplGDCHDwa2hVzFlzUWODQ8CN/9axKXvYYNCQtBYhSGGr3nizB5m0JicEQN25OQUc
         MCE6a64TWQfaMvkSX1QaoU4EzhX1FVW0lKeMw28jCVw4ARo2UhTHlytWPkCuia5QKZ15
         TNgME+jm0Bk2oS/UoFRU9+UrpUOdZhQtJ4R95RtFqaWwMrJGPN+9Eg2oFnyEIzHjTt8q
         KQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743694009; x=1744298809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/IKpE+Is6r4WFqqxEjIAXBzsXSD1PWNwDmNhKWUe2c=;
        b=mPD0Mulfi62x3HT9k9xZ2kS6ImT9COCfasNQQa4+dvkZvbiL8rpmrS5fBsZt/baMIz
         5NCbADKv7N6hJpZq6Z8+Wz7CZ+hE72GYyQFykMlbyoa2e32yHv+qK6w5/p8Dh8OeaZG/
         idR99wtY6emJLEAIugqt71YWLFClpqjYOoKmOt3OyZ9W3NnO11ezKZzfWW46fPbvZzXx
         g5GSV9lZeCive5UAzQTx+ZguzvWE1ni4Yk863TTRafHRIDvgkVkF8K2U3QPzeDPQXkvZ
         ZuQL7N3YDmbj4dQeZn7CVD0UdqXL7CtLwGhOL/TcDfZJCqdSgOICaErFShaImFR7FQyp
         5AqA==
X-Gm-Message-State: AOJu0Yz0Zxzpkra5JUWDQdfJ+9XYvzN+tcc+L4zSe8WSCDlIb6D16uHM
	z+SWsJlLM0EZSqtJKzqjr2bwGmzUNqo8V6bHva6Vx/WjlDkbNMj0HU2eXQ==
X-Gm-Gg: ASbGncthhUXv0t3pZu1bb+bxIh+Rpih3ZDxISC6CEX5coEfiovTAdS3UzjsBTDT9YTT
	ul05GH/S1lBNuPFWM4spDH6k50/1pWD4Y6y/dCylmrcg2chGoPmGa2qurZPVf5oNdwFSmsn6y39
	egWIyhA2RQCPK1P8zMGHa8JKYv/p2GJfRHug9wkvkeTJaG+GFRYtdpmQUD6TBvjDQMJtsB718a9
	c7UWx52yRdVcqj8uP+KwZ/MQb4zazkc1E06jqpTbZWDWvnnDKrxX8KVCpHE/xZR6xeYLOyB/Sw5
	xnzGO+xQUhkzUSg0BNTnchgLy0olf5bIvlx1RtYDYY0wihdv
X-Google-Smtp-Source: AGHT+IFJPIxEZBa7jLhOYs6jQ+WAjITf78j97as2OpwaJoYQDU9hqiRpk2a04hcabtEJ/jXOF0Wa/Q==
X-Received: by 2002:a17:903:22c4:b0:224:1780:c1ec with SMTP id d9443c01a7336-22977df3ac2mr48263075ad.35.1743694008476;
        Thu, 03 Apr 2025 08:26:48 -0700 (PDT)
Received: from [10.61.99.47] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad820sm15883945ad.9.2025.04.03.08.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 08:26:47 -0700 (PDT)
Message-ID: <bcdeb3cf-33a1-4553-897d-0bc09dc6a78d@gmail.com>
Date: Thu, 3 Apr 2025 20:56:45 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BGSoC_PROPOSAL_v1=5D_Refactoring_in_order_to_redu?=
 =?UTF-8?Q?ce_Git=E2=80=99s_global_state?=
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <1077615a-1c31-416d-a754-58b36d404289@gmail.com>
 <Z-5b6INZXiXbEuU2@pks.im>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <Z-5b6INZXiXbEuU2@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patrick Steinhardt <ps@pks.im> writes:
> On Wed, Apr 02, 2025 at 11:44:12PM +0530, Arnav Bhate wrote:
> [snip]
>> ## Proposed Plan
>>
>> - Identifying all occurences of `the_repository` and updating them to
>>   use a `struct repository` passed to the function.
> 
> I think that might be overly ambituous :) After all we're talking about
> ~3500 occurrences, and it won't be feasible to replace them all in the
> couple of months. This is rather a multi-year project, and one that has
> already been going on for quite a while.
> 
>> - Identifying global variables that should be moved and identifying
>>   suitable locations, some could be moved directly into
>>   `struct repository`, some in its sub-structs that already exist and
>>   some in newly created sub-structs.
> 
> Likewise, I would recommend to properly scope _which_ variables you want
> to replace. There's a ton of global state, so you should try to limit
> the project to a reasonable workload.

I could do all the global variables in environment.c. I feel like that
is doable. Once I am finished with that, I could start replacing
the_repository.

>> - Identifying and updating occurences of these variables to reference
>>   their new locations.
>>
>> It makes sense that all the variables need not be in the same struct, as
>> separation would keep the codebase organised, and thus easier to
>> maintain. It would also make it easier to introduce these changes
>> systematically, as a group of related variables, combined together in a
>> struct, could be introduced in a single patch series.
>>
>> ### Timeline
>>
>> #### Pre-GSoC (Until May 8)
>>
>> - Explore the codebase, identifying global variables and how they are
>>   used.
>>
>> - Start to identify suitable locations for global variables.
>>
>> #### Community Bonding Period (May 8 - June 1)
>>
>> - Interact with mentor, discussing best ways to refactor various
>>   variables and make a plan based on that.
>>
>> - If time is left, start coding early, as my summer break will have
>>   started.
>>
>> #### Coding Period (June 2 - August 25)
>>
>> - Modify functions to add an `struct repository` argument where they
>>   depend on `the_repository` and replace all occurences of it.
>>
>> - Move global variables to their new locations in various structs,
>>   and refactor functions that depend on them to use their new locations.
> 
> In large-scale projects like these it typically makes sense to work in
> batches. Instead of having three separate phases to "define the
> problem", "develop the solution" and "deploy the improvement" I would
> strongly encourage you to define and tie together smaller batches of
> work.

What I meant is, before coding started, I want to finalise all the new
locations for the global variables with my mentor, then I would actually
modify the code in batches, struct-by-struct. Are you suggesting that
the new locations not be finalised beforehand, or are we misinterpreting
each other?

> Thanks!
> 
> Patrick

-- 
Regards,
Arnav Bhate
(He/Him)

