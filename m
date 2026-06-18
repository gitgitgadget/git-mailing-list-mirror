Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2DD3DBD41
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790151; cv=none; b=VIkOmYIIKOV2Bl4ZJPYqlq+j1/ft4MQI6NODgfWCKGpP07SU8EQjBbJCegYrGxEN/2Nt7NWv9+Jpxl7CUqkT/pGNMKKGIkzjEntCWOe9qjKkPB9Kv1jnYFtYEQIEjdxGNdxNl+WtInA6upT1GN5+9KSMsQdSxQMqpp9Sbod9vMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790151; c=relaxed/simple;
	bh=6/j9Zb8pdpmt5tdHPbhYclV+k9jhMsluH03Gef3t66E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtveLP+xm+jx28UQh0IY4EdvAccfiQJZo1fFIY6tMC7VzNBdY/h5c4KQs4QCnHU6KtKbiB3Cd7yYOJHtAD9gVR8v0IP5maqm/MuEo+LCV0ydrhviSvca+DeFgMl83oDWBIfD2jQIc99CabzDaC1+qQWwoV5gQ4O8tIRh2rRT7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIshsrRL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIshsrRL"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bebac79fff8so111974666b.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781790148; x=1782394948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=POnoYdAofVEG9PWY/LIDM2FbRjlYhAvkCzHw3Ee+bd0=;
        b=VIshsrRLBjaG/m95Exichuov7UiVStOfalMqbpZfnElsvkaGto8vTX2VCCQfnMxmeH
         2mPMag3nNp27yh8wPVh5vRyAVZ7m2/5aHrlw0htV5RiEp2g+YQxZqczE+Hmj/eQMBBw5
         kh/s98i9xBhOosF4AOMFuiJoXtYOTCA0JUNupykU7I1Hyh8hk3Riuxxlyoy1DRWdlSG3
         nBLI/ky0ZelTcE4+bbc+9YWvqu9Z+7M7labVSSpbIVwkep49FPbBilhRigqORfx/iArP
         HjVUt3qSUF/dJm3rqkpm2mxBnY9elA20SCUM3K7o7wu974xH0dATYcFx5va/IMmTRfe7
         +NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781790148; x=1782394948;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POnoYdAofVEG9PWY/LIDM2FbRjlYhAvkCzHw3Ee+bd0=;
        b=ThyiiRTrI5+mg6zf6Uw8Auw3NeUwxs6Tn1I+uAEC36eyj8hZF9qyo8fxOqTdlGjiTQ
         i69r2yrAJuNC7fnK84KPI49Cuaouo2SxZmx8mNpV17r6ZOIuK90m37Sxej2jMCjixKz+
         kY/aVn24Zug+zBjxIQ8IPe5pjPsUhk16ScsxVA+Vt4NbEjljs9txOdG9Xvth7XmSCrR1
         KVhlnlu8RXBhIdRP4vxfV2irhfeBQtivlcm4cmlZzkIMuWzawLcfj4BKNdWiDq1PLOQd
         ivwXDj5WqBSrzz4AfkBQZRMfjuxD+ZqqQDMajAKKha79FYWwegO3WdCZsxXEBBZWKHUW
         CqTg==
X-Forwarded-Encrypted: i=1; AFNElJ+5OdjEprf6p9Zdbgig3OKITNSq16w1cz0muoRzhCL6wr9HrlLRIVPRAxQV1isdm8GnqJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4U9Io6bx+MnFMhouvZlBH2tUP/lP+VYJdxJXjpBMbfLI/Owc
	IbQ6Q2xwtEzChWFQpAnz4nPpZHme6+vc1XMtMHoL1XLSxbk2pgz8KP2ruKU+5w==
X-Gm-Gg: AfdE7clDjyTIdsgIsByR6sYDQbRHfRKMhh4IiZPKbPbyXuGg2T96BUoQwVVZ71IZM/t
	D6CpPIl/E4pXTJ4ntwzrFcvEIOI3v5LvbnBSYv0WalIvPW4z8K03qbmoMN/mtoHPOg7bal1AIFo
	v4EHY0VNkZOzix2Guhn3GUPn8lJqWKXpvxBYnc34dKdDrDNiF+e50zwDBSs0b1ptVS/3pgsI2aC
	1O27eJjfH+q1fRl/3KElzfWq89t47lBaUBTfYbhgMjSS2BNlYjrz1Z7qXhBrWiopO2lRv8lAmm4
	Vd5yVwXo/oO1WGhi4vTaptjDQdchva+0n/oErl/FrBsWbH1+2uHzmLQ5TY1yHPoqYfK1wXF6gps
	iOtFI/1Sn1/vD5R9/Q/gOTXFHh0WuuQWonYGiG4No2/efut7Tydh78BY6NRMkAnmdlRz02UvJNh
	7KVCHKw3GyZ1tOeXa1hbYykdWY3nvrbU42CEjseWkXkjttpGVLyrPtP0fa5PX5nVQZXYU=
X-Received: by 2002:a17:906:9fcf:b0:bee:426:87ec with SMTP id a640c23a62f3a-c05a541a74dmr561313266b.23.1781790148082;
        Thu, 18 Jun 2026 06:42:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb85402e9sm939972266b.47.2026.06.18.06.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 06:42:27 -0700 (PDT)
Message-ID: <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com>
Date: Thu, 18 Jun 2026 14:42:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
 <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 16/06/2026 20:15, Harald Nordgren wrote:
>>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>>> index 4e7deddc04..27ea1319bb 100755
>>> --- a/t/t3200-branch.sh
>>> +++ b/t/t3200-branch.sh
>>> @@ -1809,4 +1809,205 @@ test_expect_success '--forked requires a value' '
>>>        test_grep "requires a value" err
>>>    '
>>>
>>> +test_expect_success '--prune-merged: setup' '
>>> +     test_create_repo pm-upstream &&
>>
>> The rest of this test would be easier to read if we did
>>
>>          (
>>                  cd pm-upstream &&
>>                  ...
>>          )
>>
>> rather than prefixing every command with "-C pm-upstream"
> 
> I feel like the discussion to nest or not to nest has come up many
> times in other topics as well. I don't feel strongly about either way,
> but I just want to flag that if I change it now, another reviewer
> might ask me to change it back later.
> 
> Should the rules be to nest inside of setup functions (and helpers?)
> but not inside the actual tests?

I think it depends on how many commands you're running in a row in the 
same directory. In this case we're running quite a few commands so it 
seems clearer to use a subshell. In the later tests we're switching 
between repositories and running fewer commands in each one so it is 
less clear that using subshells is clearer. Also later on we're using 
test_config() which I don't think works in a subshell because it relies 
on test_when_finished().

One thing I've just thought of related to this patch is whether we want 
to protect branches that are the upstreams of branches that are not 
slated for deletion. With stacked branches it is possible that a branch 
has been merged but has other branches stacked on top of it that have 
not been merged. If we build an strset of branches that we want to 
delete, then loop over all branches and if there are any that are not in 
the to be deleted set which have their upstream in that set we'd remove 
the upstream branch from the set. Once we've done that we can convert 
the set to an strvec to pass to delete_branches()

Thanks

Phillip

> 
>>> +     test_commit -C pm-upstream base &&
>>> +     git -C pm-upstream checkout -b next &&
>>> +     test_commit -C pm-upstream one-commit &&
>>> +     test_commit -C pm-upstream two-commit &&
>>> +     git -C pm-upstream branch one HEAD~ &&
>>> +     git -C pm-upstream branch two HEAD &&
>>> +     git -C pm-upstream branch wip main &&
>>> +     git -C pm-upstream checkout main &&
>>> +     test_create_repo pm-fork
>>> +'
>>> +
>>> +test_expect_success '--prune-merged deletes branches integrated into upstream' '
>>> +     test_when_finished "rm -rf pm-merged" &&
>>> +     git clone pm-upstream pm-merged &&
>>> +     git -C pm-merged remote add fork ../pm-fork &&
>>> +     test_config -C pm-merged remote.pushDefault fork &&
>>> +     test_config -C pm-merged push.default current &&
>>
>> So we clone upstream and add fork as the default push remote. I find the
>> pm- prefixes rather distracting. It would be clearer to me if we just
>> called the repositories "upstream", "fork" and "repo"
> 
> Good point.
> 
>>> +     test_must_fail git -C pm-local rev-parse --verify refs/heads/one
>>> +'
>>> +
>>> +test_expect_success '--prune-merged warns instead of erroring on un-integrated commits' '
>>> +     test_when_finished "rm -rf pm-unmerged" &&
>>> +     git clone pm-upstream pm-unmerged &&
>>> +     git -C pm-unmerged remote add fork ../pm-fork &&
>>> +     test_config -C pm-unmerged remote.pushDefault fork &&
>>> +     test_config -C pm-unmerged push.default current &&
>>> +     git -C pm-unmerged checkout -b wip origin/wip &&
>>> +     git -C pm-unmerged branch --set-upstream-to=origin/next wip &&
>>> +     test_commit -C pm-unmerged local-only &&
>>> +     git -C pm-unmerged checkout - &&
>>> +
>>> +     git -C pm-unmerged branch --prune-merged "origin/*" 2>err &&
>>> +     test_grep "not fully merged" err &&
>>> +     test_grep ! "If you are sure you want to delete it" err &&
>>
>> I'm always suspicious of test_grep when we know what the output should
>> look like - it might be better to use test_cmp. This test does not check
>> that we also delete branches that are merged when we see one that isn't.
>>
>> I'm going to stop here - the tests I've read seem to me to be too much
>> like unit tests checking one aspect of the implementation in isolation
>> rather than checking that the whole feature works as expected.
> 
> I'll respond to the rest here: Excellent points regarding the testing
> aboce, I will take a look at doing this.
> 
> 
> Harald
> 

