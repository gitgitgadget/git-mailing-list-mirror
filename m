Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2CB342510
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186625; cv=none; b=Gag0ECVugL5nhycMNr56+GDye806oJ3Ro7wgW8YZ1hRYDlwsKjNHoHl+AvpAmd/9Bo7R5H0Z+A8qGovNIrc3WZT9FHUpL/PVmZD+cFuo7U+1K22Ph9Pf7dtyILs4qG/+8xorYQqIDLgmQszjsDrbgFUd5gnSyHvK+CakOJR7L4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186625; c=relaxed/simple;
	bh=JTjvVfBbruvGkrCtvNwGqKDbqkT227BpoC/e10YUll0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ei8csKbJDv/kbtxyJZ335r093NkIQnHnb057qAFraAwCQNzFC7fnpJaiSPcoFzBO8onTWwgI/LlpUHIXOTs1/ZWLbdsHen/J7qSFu8r0xULYl/45yYkVlurWq1pEQD+V12WpMOUUoeKE76XN0lSM72nYSP5b2tuIV99h9jRz9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUsYrVYM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUsYrVYM"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso87643b3a.3
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186622; x=1764791422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGXEHI2mYo7bKDy7mnvLLkaLx/sozzU0rPXhpVgqQbc=;
        b=FUsYrVYMJLWkjRn4FOYe9xOq4cOA8+3FjR7J5IFyppcdF+bQ0BCbz4wbyyJCgDzR4o
         SQV/N2McFja6Q9zpnYLLsnUjhOvNAn7zoDPnNs/mrVarUbKfjcH1Khm4i96hN1uGHSVe
         9Iib/8dIN53u/w3f6pjndogsODRfKahjO7ftDD05VmcNP2FQu7jVOzly7ChsrvrVBacO
         0BHxtMQJeiMVt/7Epm1n7K2MLlSBbe5JAFjHqQuBzwhWcUXGj42IV58xRjrH7xP5Qa6H
         cBtkFDeneydXg/oXdcGXYUBO449aUnW2AAae6E/k3m+hQnuBxf+pQgiLsZqu+jawVRrX
         OsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186622; x=1764791422;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGXEHI2mYo7bKDy7mnvLLkaLx/sozzU0rPXhpVgqQbc=;
        b=lUN+p5CaDSp+DiVXhHfLEzzQ+1G8Ug+FcY6ccLIoMPLhjcXNVXLDOzjUQBX2DEiTMO
         55EJnlkk2q7ZrDO3FnrdIt5w43EPI9Lln3hM+vS+kV7mfEnmDbSUlhjTGdiOKrIu1hMl
         UeUBhnvTixvpE73zTTXPpI3r/sn8/ZYY8cF2Bd+j9pQQZLGQ36/+QoVcPT8Qe51Oiyen
         yMcuPGg8pzBw3Ziqa7hWgX50QarZVX31FX2EUidaFGqhk3rQ0FqsYAh/zSV2Qk7iNZuY
         CMentBG63kVj/X+anpXP07P3cR9/cvzCHyk1Ewp6BKkmp/oBFNmP8C0rSxSg1y3pNpDR
         cGyQ==
X-Gm-Message-State: AOJu0YyBj02zT1iK8tziEtuE3NxhF+bFtnRxRA/2YEhmZUC7/MTaYJAj
	OFJGQwYnebZtUxLLVDq1cF5uDIIQsHYfhusfH2N+oinw4HRarN5C7S/S
X-Gm-Gg: ASbGncvW4lGsa/iXL1QhUYX3s3FHaUkyg71TNx/hROE73wNFF2SCM4a4iEAtKG7UD1i
	qORZKuuyboaj+MklTTLP57rPE+CZwvYTk1zo/3SibOX1C5+XbHVa8rmYak7nYBztX+DXBwh7+Eo
	19oj1+q5wY1uPQRjn5UkSC3bIuDIbouhIZwv7kSY/Eri/3wTNhObru1Pm/iLMuhpcxPE2NgO6Pt
	8wglr632YrvO58ESkOwLB1FQMPAxYiBmssbSpjznX9NxXlphIM0Mhb5ObRlP//r82tCiNxSIu5j
	JCdaTxXrlE9c5KmtmEoYPk/cbVy5aMr6jDiu5IeeqZohKmbee4eQbStDZnqH86RqOi5Sx//jDoo
	pB8qC2yG1dIqVcfa1prgozA6cySuE5ieBzpLd1qCeRJQUpD0i6/w1YC6mm/pyGAbhDbQG4o39BO
	zl6ZxAWK4Vje5wHCCmJl1VU+kuZTZ0qzMgGWcfZbjvqX1RimeIpk43aaPpGGXOI1NwSbZhQjIbv
	Ui7EWS1o/vauz9ZgeVlFZs=
X-Google-Smtp-Source: AGHT+IEP5WRBtOtax2wpW6vXPqXgO88DNlrWSR6uZdJFDpQ4o6B0gvQzn1grDgTwXGHQUzj0VXO7BA==
X-Received: by 2002:a05:6a20:a114:b0:35d:8881:e6a4 with SMTP id adf61e73a8af0-3614ecbf45fmr22718399637.25.1764186622408;
        Wed, 26 Nov 2025 11:50:22 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:bc94:4b73:d55a:67b2? ([2409:40e3:30a4:b776:bc94:4b73:d55a:67b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63aefsm22305471b3a.52.2025.11.26.11.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:21 -0800 (PST)
Message-ID: <d4362def-9be6-4191-8846-f3180a5a5d59@gmail.com>
Date: Thu, 27 Nov 2025 01:20:15 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 gitster@pobox.com, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
 <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
 <CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BEF1RVs7n4xf6ihyPUmxrhgpG6VEpZLrX=MTgcBWBRbfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 26/11/25 23:05, Elijah Newren wrote:
> On Wed, Nov 26, 2025 at 3:10 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> Hi Siddharth
>>
>> On 25/11/2025 17:00, Siddharth Asthana wrote:
>>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
>>> index dcb26e8a8e..ad7dc08622 100644
>>> --- a/Documentation/git-replay.adoc
>>> +++ b/Documentation/git-replay.adoc
>>> @@ -54,6 +54,18 @@ which uses the target only as a starting point without updating it.
>>> [...]
>>> +To revert a range of commits:
>>> +
>>> +------------
>>> +$ git replay --revert --onto main feature~3..feature
>>> +------------
>>> +
>>> +This creates new commits on top of 'main' that reverse the changes introduced
>>> +by the last three commits on 'feature'. The 'feature' branch is updated to
>>> +point at the last of these revert commits. The 'main' branch is not updated
>>> +in this case.
>> I'm struggling to understand when I'd want to do this. Why would I want
>> to update 'feature' to point to the reverted version of its last tree
>> commits rebased onto 'main'? In order to understand I ran the first
>> tests case which does
>>
>>          git replay --onto topic1 --revert topic1..topic2
>>
>> after fixing it by adding --ref-action=print the resulting commit log
>> looks like
>>
>> commit d337fab78e90008835f74e890039b464a0308cbe
>> Author: author@name <bogus@email@address>
>> Date:   Thu Apr 7 15:30:13 2005 -0700
>>
>>       Revert "E
>>       "
>>
>>       This reverts commit bceb3acd81ddd36ba0da391fffa48949a1337276.
>>
>> commit 47f0cc1c1f1911c0047a4d79d79f7c19c6c7151a
>> Author: author@name <bogus@email@address>
>> Date:   Thu Apr 7 15:30:13 2005 -0700
>>
>>       Revert "D
>>       "
>>
>>       This reverts commit d953cf2dcc1da8b51934e43fd83dac72d0e267c7.
>>
>>
>> The commits are empty because the original they are reverting each
>> create a new file which is then present in the base revision but not in
>> either of the merge heads when we revert. This suggests to me that it is
>> not a very realistic test and I'm still scratching my head to see where
>> "git replay --onto <commit> --revert" is useful.
>>
>> If '--revert' does not make sense with '--onto' then perhaps it should
>> be a new mode that takes a ref and acts like '--advance' but reverts the
>> commits rather than cherry-picking them. When reverting a range of
>> commits it would reduce the likelihood of conflicts to revert then in
>> reverse order so we should either recommend passing '--reverse' or make
>> that the default when '--revert' is given.
>>
>> As you can see in the log output above the new function to format the
>> revert subject lines is buggy. If you had used test_commit_message() to
>> check the commit message, rather than just grepping for ^Revert the
>> tests would have picked that up.
>>
>> Thanks
>>
>> Phillip
> I was going to say the same thing, but from a different angle.


Hi Elijah,

thanks for the architectural clarity!


>
> The sequencer in git is used for three different types of operations:
> rebasing, cherry-picking, and reverting a range (with a sequence of
> reverts rather than one big revert).  In replay, these correspond to
> --onto, --advance, and the new thing you are trying to add.  As such,
> it should be its own new mode.


This makes complete sense. I was treating `--revert` as a modifier when 
it should be a third mode alongside `--onto` and `--advance`.

I will restructure so that the user specifies exactly one of:
   --onto <newbase>
   --advance <branch>
   --revert <target>

Where `--revert <target>` applies the reverts on top of <target> and 
updates that ref.


>
> (I do tend to see ranges reverted by a single big revert, the way
> Johannes suggested, rather than as a range of individual reverts,


The commit-by-commit approach is useful when you need:
- Individual revert commits with proper "This reverts commit X" messages
- The ability to later cherry-pick specific reverts
- Clear history showing which commit caused which revert

But I will add documentation noting the `merge-tree` alternative for 
cases where a single combined revert is preferred.

Thanks,
Siddharth


>   so
> to me the utility of the new mode looks low, but perhaps others find
> more utility in it.  Or maybe the intent is to only use it with a
> revision range that is only one commit long?)
>
> Phillip also went into more detail about why "--onto $COMMIT --revert"
> specifically doesn't make sense.  I'd also say



> "--advance $BRANCH
> --revert" doesn't read well because to users, "revert" means going
> back while "advance" means going forward,


Exactly - combining these is semantically confusing even if it could be 
made to work technically.


>   so it's a rather confusing
> command line to make them wrap their head around.
>
> And yes, Siddharth, you were right that the new mode should be
> incompatible with --contained, but that's because --contained is a
> special modifier of --onto.  --onto, --advance, and --revert are three
> different modes that are incompatible with each other.  Once you've
> checked for that incompatibility between the three modes, then you can
> either check that whenever --contained is specified, either --onto is
> as well, or neither --advance nor --revert are.



Right. The check becomes:
1. Exactly one of --onto, --advance, --revert must be specified
2. --contained requires --onto

This is much cleaner than my current approach of pairwise 
incompatibility checks.

