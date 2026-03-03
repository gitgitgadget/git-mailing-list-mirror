Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAF3537EE
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772566273; cv=none; b=pgyzf/MgDg+COVydaUWu24ESoiPNrJMKSe6oVxk0HVQArYMTbL12yIXQAlJqxQgCyFeWhQxAH+LoUNMgHShKjSLqz4mtqI4DXI83qlF2nFCTA8QHb3Lg1K1kCPe627ptj+80b8IwimEb4hn9lJx3lXHnJ5tZZIM8QIH4RtEz+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772566273; c=relaxed/simple;
	bh=nXZFRsrvBWFiiO5MvW66ObMwSPJplC4qAD55W9SiDIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZS9cUrmnGtXT4Blm/pNFZYQEUh0FRjLFRqBHGbdnoDpQ6FDcmnp29TngTLfyVhsJrqDL+EQLXZI4BB3O+wkKF9Ss20aMmV1PRNB/tYREexWrrV9Wm1vX9RZDrWDgv5ZcA8iRwLelCHF+EMlYTN1xCrhQYcc3avXnKp6U/c3LlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TW0iPaO2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW0iPaO2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48069a48629so65169105e9.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772566270; x=1773171070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F0MAopz/FYp3YPTyKvZZv+dfI/6OHQyCCTpvGquos9c=;
        b=TW0iPaO24RKMnxsK/x+1iZdiziziw1tSXieCtHBhvmXSSMLAxLbxJ/uXoeIuDHBZfG
         VIbZhfQSij6mXN/CtE0V80iIWfTjLH8Je0ecaCd8qDl2z9V8Xc2oa2nKIM+R3p3b+FAS
         RVQkCFI/nq7C1kX0BVt3Artvhq5jF4Zp6jV7id/BYHoNa4gdwz7VD5UnfMCnWfsvq+Wr
         0aBdYqJrXdxKT0rEg0YcjCm+SuNAb+r3dr9D4JquFU3UglxvgUtchCA04I7pJFgGe7fN
         hAsmscrsmb2lGWnF4pzzjaZE0feIhv84W9QXZvIVbyHh2YGV9tgZ2BYLYUNxOPQeocpl
         6gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772566270; x=1773171070;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0MAopz/FYp3YPTyKvZZv+dfI/6OHQyCCTpvGquos9c=;
        b=SnQYmgsOeyd+oz8qUIqhqBrdBUZgEyamrE+xl4x7XOIJiSK/1oq6cqMZWPbko6YApM
         EGEkovYI2dMfZ8xDpzg+tawCpb1lqiAXAOO2IZkotJJterQlWvb/dQyRz8B4MGBWSaCa
         OMt28MPAoko9+EutzSPqCJjDjT5atUTkQl0BU9ox38Ssj3JxWtYT4oO7BWJ/In0PTvbN
         usHeKkUmDpi4VOw5lbFFHHR2MKyvaON1wJz0TJppKZj1TEHVNkBeq2bYz4RrQj0SqgWw
         IpO9hJPGbqxRKm+ihBo9oQ4ZNrw4Q3RG7QJ+LSXS1T9AMiNVbGce6fF9iOjTeEC8Qp+z
         oDqw==
X-Forwarded-Encrypted: i=1; AJvYcCUSZ70dzLSUb3orEpooLWUER4ERVXQovDJVkT/M6dhF2rYmzHfrJ+2TUitXrVeGZcf+t+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAtRyLvR7zCUr2kCdz10B5n5udK/ZZ3AaDv21tMPNPvxMqQFt
	15V8YW20EBtM8hhuOoGVIOtXdCQbwXgsDs5GOUCr0o0ZbvC7/PFTGUS+
X-Gm-Gg: ATEYQzwWbqX5ySZeQ7LfFlzAGKSQ0TFzuPno3cn1ZATZJ9oem1HO7ep6ANJ3R87YOhb
	T6/Q+P/HkUL8da4oX2VRxkYn8wl17QFeFsq8hkWWGnFDx7XvNqAfoL+QSbUfag4x+JYK9tyFpL1
	6qNIlPOLjm/SRkIPUpAtMyFl4An5F+kAKQ47Q6kSnF9M9nz2kOC4Yoh2dyOsijRNbIxI2wbIiiu
	iCYcvunxIQXlmwpw4UcxgwAAejtnZAFt1plXUB9odqDEg/MKBEO8+flq+pCyN61n8/oCIu3xpo5
	sPMI22EXq4JJMYfg2Kv78c86dgZhcUhsZxChneA6187pJpof3hoKaKgJUWMv2Z1iUEnj7ORvptl
	zjEMehpgdtO1zSOulZ0T8WMSYqbdZRnY1RbUZTPAvCMMFggMdIjetg/BzA7JYu9VJEp8Thxyojq
	RYT8QrthVAemRM+KaeJsA3V0BG1yC869tsp5ZNQGZe+SqnvEeTo+hWGZWFKnGnzoSBSD6OioMjk
	JsJ9Q==
X-Received: by 2002:a05:600c:3108:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-483c9c1d177mr312189535e9.29.1772566269581;
        Tue, 03 Mar 2026 11:31:09 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485125bbb48sm38372145e9.0.2026.03.03.11.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:31:09 -0800 (PST)
Message-ID: <460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
Date: Tue, 3 Mar 2026 19:31:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Tian Yuchen <a3205153416@gmail.com>, karthik.188@gmail.com,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20260222102928.377519-1-a3205153416@gmail.com>
 <20260223074410.917523-1-a3205153416@gmail.com> <xmqqpl5rumy0.fsf@gitster.g>
 <xmqqjyvu42pw.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqjyvu42pw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2026 16:26, Junio C Hamano wrote:
> Let's try again.
> 
> Can folks equipped with knowledge and environment to debug breakages
> that hapepns only on Windows lend a hand to figure out what this
> patch gets wrong to help the topic move forward?

Looking at the test failures the tests are failing because

     GIT_DIR=/dev/null git diff --no-index ...

which is used by test_cmp() on Windows is dying. That happens because 
stat("nul", &st) fails and this series makes that an error (somewhere 
along the line "/dev/null" is rewritten to "nul" on Windows). I'm afraid 
I don't know enough about Windows to be sure how to fix it but maybe we 
should special case "nul" in the setup code or mingw_stat(). We should 
also check what happens when GIT_DIR=/dev/null on linux and other POSIX 
platforms.

Thanks

Phillip


> Thanks.
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Tian Yuchen <a3205153416@gmail.com> writes:
>>
>>> 'read_gitfile_gently()' treats any non-regular file as
>>> 'READ_GITFILE_ERR_NOT_A_FILE' and fails to discern between 'ENOENT'
>>> and other stat failures. This flawed error reporting is noted by two
>>> 'NEEDSWORK' comments.
>>>
>>> Address these comments by introducing two new error codes:
>>> 'READ_GITFILE_ERR_MISSING'(which groups the "file missing" scenarios
>>> together) and 'READ_GITFILE_ERR_IS_A_DIR'.
>>>
>>> To preserve the original intent of the setup process:
>>> 1. Update 'read_gitfile_error_die()' to treat both 'IS_A_DIR' and
>>>     'MISSING' as no-ops, while continuing to call 'die()' on true
>>>     'NOT_A_FILE' errors to prevent security hazards (like FIFOs).
>>> 2. Unconditionally pass '&error_code' to 'read_gitfile_gently()'.
>>> 3. Only invoke 'is_git_directory()' when we explicitly receive
>>>     'READ_GITFILE_ERR_IS_A_DIR', avoiding redundant filesystem checks.
>>> 4. Correctly return 'GIT_DIR_INVALID_GITFILE' on unrecognized errors
>>>     when 'die_on_error' is false.
>>>
>>> Additionally, audit external callers of 'read_gitfile_gently()' in
>>> 'submodule.c' and 'worktree.c' to accommodate the refined error codes.
>>>
>>> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
>>> ---
>>>   setup.c                       | 45 ++++++++++++++------
>>>   setup.h                       |  2 +
>>>   submodule.c                   |  2 +-
>>>   t/meson.build                 |  1 +
>>>   t/t0009-git-dir-validation.sh | 77 +++++++++++++++++++++++++++++++++++
>>>   worktree.c                    |  6 ++-
>>>   6 files changed, 118 insertions(+), 15 deletions(-)
>>>   create mode 100755 t/t0009-git-dir-validation.sh
>>
>> Unfortunately this seems to break almost all the tests, not just the
>> test the patch adds, on Windows (which I almost know nothing about,
>> but I can observe that CI jobs die).
>>
>> https://github.com/git/git/actions/runs/22464017037 is a CI run that
>> merged this patch on top of the commit that corresponds to the tip
>> of 'next' as of today.  We can see "win test (N)" jobs dying all
>> over.  I cancelled the workflow before seeing everything die,
>> though.
>>
>> https://github.com/git/git/actions/runs/22464479533 is a CI run that
>> tests this patch applied directly on v2.53.0 in isolation.
>>
>> As I said, I do not know Windows well, so this may be a red-herring,
>> but in this CI run, we see "GIT_DIR=/dev/null git diff --no-index ..."
>> results in "fatal: error reading 'nul'":
>>
>>    https://github.com/git/git/actions/runs/22464479533/job/65067515458#step:5:95419
>>
>> which is an expected thing to happen, but we probably used to ignore
>> it as a non-error?
>>
>> For now, I'll kick this topic out of my tree to give other topics a
>> bit more test exposure so that we can notice new bugs in them (not
>> in this topic) that causes the tests fail.  With this topic in 'seen',
>> such bugs in other topics are all masked.
>>
>>
>>
>> Thanks.
> 

