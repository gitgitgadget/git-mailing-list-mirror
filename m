Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510430D3E5
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789831334; cv=none; b=suCLkQ5xvVVco++BjexpHlwQcKpByWh+YjhMIfoALze/L8q4fdRaTYcB6UGvH+ylm99D7Zq+OtZXQNjnaKjEam/Gu7dbPN+jIQhrkr+DUO7KjURjfjgKqfbfFvzsN6OJyONWga1dLDbrHCfeMUxEs5TT1SPI6tHXlaSpqzgNpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789831334; c=relaxed/simple;
	bh=m1fyMASlaRcyoiBmDbO/8p4qPDmnrLxXo78OD/2E8uI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uTVwBuPEzsfj922VdMU3O+7AxwKmPFFAoOtkNNSDMNuILlNPWqXlM5XJEaI/1IT9r/3UxT8xUwJMHaLUOU6kLD8RyMANst7ER7hDYeYhZZ68uEFfo8UnrojbtYfBUJGDzvvK0sQgJjG9iBjrXUrSQpNNyOc5xGtmc1TPYMIfamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otfvZ2sp; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otfvZ2sp"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-482f6351832so839170f8f.3
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789831331; x=1790436131; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3suVsFsQsLHHEiy4nuM+zhTk+FOzdIrNF7njmXkJUQA=;
        b=otfvZ2sptKk5TNPPQgI86LYd7tUgUdE6vx25igC+ZxllJQCt58/3Pmlc7/dK5WcEX4
         3sysUAPn3qCIXhoZngWPc5pWq6Ow24IYbmYQdURvTXH7ng4aHFY3TQ3/60u8Dyzzfx9y
         Q/BKTfAlU2obOQac2KLaqKmfWJRRxJDetMH58ilRdUYIfSLgeW2Awf3QDtpu3HkZGCRl
         D1TmA6FYVPlHLlaJPgNGwYlLap9g2yiYzqYdcOF3ZVW9Y0eBPWwuG2s/OYmsESDcGPX5
         DAT6k4z4ESTplp2EHg9DCP9E6msz0AJBVLi+xZ/jzaHTv0qUAb3a8wamuy17bdFxE3Ok
         A3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789831331; x=1790436131;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3suVsFsQsLHHEiy4nuM+zhTk+FOzdIrNF7njmXkJUQA=;
        b=eFQwmjiNy2Td+s2NC5jQikOPzGKh1liJW+GLS5unUu+8yRG4zCES3bISnIpPM7Yuq1
         hnCvYO5gjuxhi8FTT1yaeaqvKpGGjt07pubmJTNLgIAmgXKTbohLC3EpWiNeVZSPlFNE
         j3IJa47Ry1AtEbWHB7cliGBT2pD1O9Wln1LkLOcmvz2mw3ncppGFOd/UzbHJdBBl4bPl
         hY/z/i5O0PhhpG7hr2u5jNjBgwknITMWKFXvDVvlpmknYm5kbJFnkQUGUreFDMlpiZlL
         pMcd8gNNgtdBzYZ+BOAuY2eY1lZU3T98uT5UWD4Zmz/cGyUzpxsWAHx5u4IWidzR+BGH
         sMsw==
X-Forwarded-Encrypted: i=1; AKwUvBw+oy/1qMSbCu0zsiYz2wsoQ8NDRUb4o0Oli5in3uWIfpzZovGasUYy9bc3PqJQQCGOpOc=@vger.kernel.org
X-Gm-Message-State: AFuF++mRRK7Nq0/a9IX7RErQ9wpaSwZZcxY7DLzcKLMbNMoOPY0FJWNB
	x0pQpQQszGb77fkJrxwqk5bQk+Lz5JCOdvsgm1ln48OpH/XfR+2V1mTO17sQpeXh
X-Gm-Gg: AYBFou0o6LcV3SXZCo/jnAcfRSxiykDEYoE9HoxNmhiOos0TGA7mRRke3dBUubW7eyE
	rLsY654K8l+of8/cAOOsyrQLZJe/asu9cYFsUBhYqxffZeyh5To9w32YS4gL+VCMNL3ltZ4QDbR
	PRe64xGFPvOwAeS1wJ9xhWDHfxguesf1WQobeiopHOF7BAS9sXxrHFaL9RiSKErOdabi2CX+brU
	5Z2tNynuJKgBDnuBxPykcDv0Pi0NHLrItaI17MdaPdvRDoTQ9NxWew+uF6lKyc1OntlQWyGkfx/
	dXsTTuF0S5/PLdEADMEseE1MPx80Cl4CT2ria8PzvSeo5wDmnPeuNci+A2jvcW8U9zPcp3bYDHF
	knP3tS+oRfcBr6XnDX5RqoEvR4Ki4mhfYNsWLn7Gr7bVpbm/HaYMRLVETOnYT4wYILH2dhrX0hf
	kkIHbHSWlYMRrSKzwVAFwTqN/tUy6asmmvqGg6AVoSXuPKj9Jq0CqOX0KjYsSQw4j2jGJuLlwjT
	pbhsD6r9vz4/dHRn+teUE4/MJLMwWCvGOZ9LSBJWztj3pnGBFnEo5B9OHQCKmUf
X-Received: by 2002:a05:6000:2c0b:b0:486:e9ab:2b86 with SMTP id ffacd0b85a97d-4871e26bca6mr8319050f8f.39.1789831330624;
        Sat, 19 Sep 2026 08:22:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872446067asm7949721f8f.12.2026.09.19.08.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 08:22:09 -0700 (PDT)
Message-ID: <9ae2cb8a-7f2d-4c79-937b-170b8937bd8c@gmail.com>
Date: Sat, 19 Sep 2026 16:22:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
From: Phillip Wood <phillip.wood123@gmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
 <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com>
 <fd4c2cc3-d457-49b0-bf3c-96063e40700d@gmail.com>
 <CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com>
 <44881557-f15e-4ec5-b1c5-4112752f757c@gmail.com>
Content-Language: en-US
In-Reply-To: <44881557-f15e-4ec5-b1c5-4112752f757c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2026 16:55, Phillip Wood wrote:
> On 17/09/2026 14:15, D. Ben Knoble wrote:
>>> It looks like stash has its own unpack_trees() wrapper, so I think the
>>> simplest fix is to replace reset_head() with
>>>
>>>          reset_tree(&c_tree, 0, 1);
>>
>> I'm not sure if that is a pre-merge reset, post-merge reset, or
>> something in between.
>> Unfortunately, a whole bunch of tests fail (6 files) with this 
>> suggestion :/
>>
>> Summary of Failures:
>>
>>   339/1062 git:t3904-stash-patch                              ERROR
>>        0.45s   exit status 1
>>   503/1062 git:t3903-stash                                    ERROR
>>        4.40s   exit status 1
>>   763/1062 git:t6424-merge-unrelated-index-changes            ERROR
>>        0.90s   exit status 1
>>   778/1062 git:t6402-merge-rename                             ERROR
>>        2.06s   exit status 1
>>   864/1062 git:t1092-sparse-checkout-compatibility            ERROR
>>       26.19s   exit status 1
>>   868/1062 git:t7611-merge-abort                              ERROR
>>        0.45s   exit status 1
>>
>> It _also_ doesn't make the bug go away, hm.
> 
> Oh, I wonder what's happening there.

So the tests fail because when git tries to merge the stashed worktree 
changes it thinks there are unstaged changes in the worktree. That's 
because when we merge the stashed index changes the stat data and 
CE_UPTODATE flag are cleared for paths that are updated by the merge. 
When we remove those merged changes from the index we need to refresh 
the index to restore the stat data. Adding a call to refresh_index() 
after reset_tree() makes the tests pass.

Anyway that's all a bit irrelevant if we're going to start using 
merge_incore_nonrecursive() but the test failures were bugging me so I 
thought I'd have a look at what was causing them.

Thanks

Phillip


>>>>> We could avoid touching the index at all if we
>>>>> used merge_incore_nonrecursive() to cherry pick the index changes
>>>>> instead. That way we'd get a proper three-way merge and avoid
>>>>> spawning subprocesses for "git diff-tree", "git apply --cached",
>>>>> and "git reset". We're already using merge_ort_nonrecursive() to
>>>>> merge the working tree changes in that function so we have nearly
>>>>> everything we need already set up to merge the index changes as
>>>>> well. Essentially, when merging the index, we just need to call
>>>>> merge_incore_nonrecursive() instead of merge_ort_nonrecursive()
>>>>> and use info->i_tree instead of info->w_tree.
>>
>> If I'm following this, the suggestion is to replace (parts of) the
>> early "if (index)" block with a merge_incore_nonrecursive() to merge
>> index changes, reporting conflicts as we do today, and saving the tree
>> for later… and this would not touch the real index, so we wouldn't
>> have to reset at all? Interesting!
>>
>> The attached patch [Gmail headaches, sorry], which needs some
>> polishing [*], passes tests and fixes the bug! Yahoo. I'll send a
>> series later, tomorrow probably.
>> (It won't apply directly, because it's on top of the experimental
>> reset_tree() version, but resolving conflicts should be easy.)
> 
> I had a quick look at the patch, it looks good, but I think we can 
> simplify it a bit. As we abort if there are conflicts I don't think we 
> need to spend any effort setting the conflict labels (I'm not sure if we 
> can pass NULL, but "" would certainly suffice). Does the current code 
> print any errors from apply when the patch does not apply? If not we 
> should silence the merge by setting verbosity=0. Also I think we should 
> use oidcpy to copy the merged tree (it probably does not matter in this 
> case, but it I think it does some extra checks on the hash function 
> which a simple assignment does not)
> 
> Thanks for working on this, it will be a nice improvement
> 
> Phillip
> 
>> [*] namely, the log message, some tiny first cleanups, and removing
>> now-unused functions
>>
> 

