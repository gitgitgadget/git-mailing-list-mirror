Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1721B963
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880238; cv=none; b=sMUr4B1Q09yDSw85BXtCdarK8WSvKhtHteJlLwDdWvt6ABONcAod12eDlpPw2GYBqfGUn1ILXmmJe+o9ewyJwtXnp9SpGGbngUUD5eDlwY15OnHq/c4R9lTK76yE0Y2BzyvCmUmJDKm6TdYNC70dMq4890CljQ8/L0M26NzRYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880238; c=relaxed/simple;
	bh=/apecLknMc6itSRc2bdxZM6X0ORtvVsAaD6s67NFOlU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uDJYGfHEhaDLogUtXz91nfZUAlBNJvR22BC+/GhXdmZYFBVBbxnuMT0KVAUGI/JnnjderVQO7QwsoBsK7FcRXAs//Jee20SjVRnTQh5pjBwVyH0JJrWe9NuALT/DPzMXxEzjs/UGF2wFQOd6jTtram1Vw+0xCtNHMCZmnBtf1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GitwB22/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GitwB22/"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a34c5ca2537so315013866b.0
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708880234; x=1709485034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C9/19eTeZfRr+P+kEPDZ4vlojquThTJFzMOfoL0HJUk=;
        b=GitwB22/4sM4OxV80x55IUho22u6T/JoBhgUOI046VkHxO0+lfTro4f7s/Cz9247mH
         JMp71C24qmtEn1b7Hh9ihwoSYhV9FTn6M+gDLoJ2x0XalVmPBNhX4B52nNyuSPbSOqkQ
         hfnJxwWFvVf/0o/ZpsNGMfaUgPnwfuUVtINGZ39cOCCuwc1ORRIAvHH2jU5Zm69t5aeY
         PZRq7v9Dun+rbcONRKdtqZgC56ZbA7mScCg2IxmFWxR4/dhqKPPVbOAwsfj0ApQ418rN
         qLAQPf8lbCexmxBUqJ07KrSEQajRuipnrU4x5xtkxJyLHTb4aXaO/UXpD/IBPcK2SKZP
         iwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880234; x=1709485034;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9/19eTeZfRr+P+kEPDZ4vlojquThTJFzMOfoL0HJUk=;
        b=sM/HybDjCbGIvxzp4tebLA/RP7m2YebBFa27i46gQJ0a6KFbE/ku5xi+Y1SsXJYIQM
         Rn8mT1aj/ca03IvzjzwCZG7QN7d2fxMU7uBTwke8sPu7brU7p0i8hpSvj4YeQZhgNfnf
         5eicRCdh0TR+dKvlXI+9kvESmh2otmVqbG7ZDFOXAR259Sg+pmmjDIU6/szNE2QgnT1u
         DMkyMTQ//+ij4kuPEQ+ZXFiNKebztLAkBdctTwy3/Bo+hPXxDdUF08VOwd02Zq0t3DUD
         7zFXmKOK7NqHJmonsZG/VeaS+A/21zx/62rbUEnoAcMoIOylVcxJBZK3yKerBIFNbVmT
         EEZA==
X-Gm-Message-State: AOJu0Yz4M7cNyHDtzcXcAWoliZVYrcF/jHky8NYX23f/9WEhiY3OYg7H
	vQIV8gdLn+RFAHlcYPU+OLwxCS+nqSJpkEVscxMOh4AQcZDYJYbS
X-Google-Smtp-Source: AGHT+IFnu/DY1eOgcGwThbiwut6jyWltduPIBQnFjUhaiKe7LGpKyLG05nqVpSlGi4RjodJrz0h1ZA==
X-Received: by 2002:a17:906:5910:b0:a3f:583c:b00c with SMTP id h16-20020a170906591000b00a3f583cb00cmr3193922ejq.43.1708880234295;
        Sun, 25 Feb 2024 08:57:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id jw4-20020a17090776a400b00a434cae86ebsm179788ejc.219.2024.02.25.08.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 08:57:13 -0800 (PST)
Message-ID: <62247a1c-0249-4ce1-8626-fe97b89c23dc@gmail.com>
Date: Sun, 25 Feb 2024 16:57:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/8] sequencer: treat error reading HEAD as unborn
 branch
Content-Language: en-US
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <17b666ca6c4b7561.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
In-Reply-To: <17b666ca6c4b7561.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 23/02/2024 05:28, Brian Lyles wrote:
> On Thu, Feb 22, 2024 at 10:34 AM <phillip.wood123@gmail.com> wrote:
>>> +test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
>>> +	git checkout main &&
>>
>> I'm a bit confused by this - are we already on the branch "unborn" and
>> so need to move away from it to delete it?
> 
> Yes, the previous test leaves us on that branch. In v3, I will update
> this to instead just use `git checkout --detach`, as that does seem a
> little less confusing than switching to some other branch that is only
> relevant because it's not `unborn`. If there is a cleaner way to do
> this, I'd be happy to switch to it.

I think "git checkout --detach" is probably the best we can do. It would 
be nice to be able to do "git switch -C --orphan unborn" but "-C" does 
not work with "--orphan"

>>> +	git branch -D unborn &&
>>> +	git checkout --orphan unborn &&
>>> +	git rm --cached -r . &&
>>> +	rm -rf * &&
>>
>> "git switch --orphan" leaves us with an empty index and working copy
>> without having to remove the files ourselves.
> 
> Thanks for pointing this out. Using git-switch(1) here instead of
> git-checkout(1) allows us to drop the `rm -rf *` call form both the
> existing 'cherry-pick on unborn branch' test as well as my new test. It
> appears that the `git rm --cached -r .` call is still necessary in the
> existing test.

It looks like the previous test 'revert forbidden on dirty working tree' 
fails to clean up properly and so "git switch" is carrying the 
uncommitted changes across to the new orphan branch. I think that "git 
switch --discard-changes --orphan unborn" ought to clean the worktree 
and index but it doesn't seem to work.

>>> +	git cherry-pick initial --allow-empty &&
>>> +	git diff --quiet initial &&
>>
>> I'd drop "--quiet" here as it makes debugging easier if we can see the
>> diff if the test fails.
> 
> This makes sense. In v3, I will update this new test as well as the
> existing test to not use `--quiet`.
> 
> Combining the above suggestions, here's the version of the existing and
> new tests that I intend to use in v3. Let me know if this isn't what you
> had in mind!
> 
>      test_expect_success 'cherry-pick on unborn branch' '
>      	git switch --orphan unborn &&
>      	git rm --cached -r . &&
>      	git cherry-pick initial &&
>      	git diff initial &&
>      	test_cmp_rev ! initial HEAD
>      '
>      
>      test_expect_success 'cherry-pick on unborn branch with --allow-empty' '
>      	git checkout --detach &&
>      	git branch -D unborn &&
>      	git switch --orphan unborn &&
>      	git cherry-pick initial --allow-empty &&
>      	git diff initial &&
>      	test_cmp_rev ! initial HEAD
>      '

These look good

Thanks

Phillip
