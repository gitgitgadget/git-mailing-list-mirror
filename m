Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2A5CDE4
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796154; cv=none; b=Q1u5fK5DMY5bIL98K5RvYdJVGhpFxfB9i2HNn12ZRcvE5HYq1STNPol9GaHb+n7A0H3zS5mhXxR5lUcVct8p+s3762mk+cy/B2AP0noy01aI/r0SCF+1bODCNMaojyXyPKjZK2lVoSKYAdPJdUU22DkcJ/lRBBIc3/2vHYK+qhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796154; c=relaxed/simple;
	bh=0SnP6M1KMR8/dNUDS4r+1ggObP8huWzO+O6ziVc8Zi0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Elvu0GHuLeuJoNpx+1FPaak9ptvEw5qSZyfFiA514OP7tmXJ4aL/G4RJFulfDsV9u2NGSkH4t4Vxp3jHnbKK1qs2/nMejJ9FTaj8iFMHFRvzevkfbaaBZ6hvmMSVe3Nk9/bxIB53mrzudxdY80C16zAt4k+c4FyK5Due3FeHvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+r3oQ9/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+r3oQ9/"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51132f7b4a3so8967e87.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796149; x=1707400949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PznUGSvHhTLsPZzkG5MCzjHthx1AxW9w4r/Ih6cgRi4=;
        b=H+r3oQ9/DWiK6G7URTpYbrDzsAMMtxu5Q2myjrlh5EeWPRi8OuKBsBj/m+gtT3n4ZC
         SeyeuqlLIQFOdMqV2AhW04IECFQ4GrCLBNYgezUE91NZEAXR9kYfnGRMkBON0JHjiReq
         jDyppCX82RKlfEWuukkRw61popw1d28oDqy9om1ClnJuuFnMGtX8moQRNYBhgThPv/cM
         6tpvPWbyRwWkLr0CLtmaPe8gt97dT4L99mI113rzhyb6j3Uo65XZCqNXour07xNXtf6d
         RoBSaNBQ7eeiGbOlBwv4e0W7iM6Abm4f+832fTcQtZeo2iPr+yUT5VFyND7GqcCwOgl9
         amwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796149; x=1707400949;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PznUGSvHhTLsPZzkG5MCzjHthx1AxW9w4r/Ih6cgRi4=;
        b=vfWkFT8jDSmE6jFzEknwgBDE8oZa2bLT48o88+KxWIR98Sv7hDwCxbb/2ljdtVKbG7
         iZnioo2RbD7jqlLiVXZsy+nGkGpkYGZf/btNdEjpNCHqh0LD+9gJI5uTqs/vWqTS6gYV
         uziVFbJfNqjJZlAIgCx/M7iTz8qz28YPS6OvjLwCIFbIyH0gQ7J+8KNN56E7mj/l647/
         Yv+aYsQkqQXMm6ivOWfPK5Gx2X1fnByxxenyQbvxBr2/shLJmZ51V/RHyS2yXUp4j4BX
         U/XxlpB24bHqDj/VHchCineoPEzPEWRmKkw0GEhC+5uTm7HXL1YBhq056Pxh76UpeohS
         eDIw==
X-Gm-Message-State: AOJu0Yy4tR/uomiDHsO4/HTmxgJsFbEyzGqhPcUHJaFayKubjg3gBAxl
	Sk5LMNiMzQgdmqWzQQ6EeTI6xT7vYRjOgWbjkf6rj11695sDYvMC
X-Google-Smtp-Source: AGHT+IFkAdwyGnmmkPuvtD+EFFOuxwIPFX5sMCorjU1+OmfW3EPmYZvYanw/ETyu9SOSouYwl1bRSw==
X-Received: by 2002:ac2:4188:0:b0:511:b41:b334 with SMTP id z8-20020ac24188000000b005110b41b334mr1850907lfh.34.1706796148840;
        Thu, 01 Feb 2024 06:02:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUY3abnHbei/ECtyD8Dw+ynNlxQpioNxshLnk/kHlNjavghyJUYaZ7+8QRumBdn5FoJuZ4CsS7ZLZcUH/8UlWEa4eg4xBWT/+8jeBjXO2M2ZFvuWAoJIRL9ziiS78ka/jBNV6cUk2adXYp+8fV0
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id o7-20020a05600c510700b0040e880ac6ecsm4595341wms.35.2024.02.01.06.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 06:02:28 -0800 (PST)
Message-ID: <0ed4a9b2-2318-4424-8173-42c0e61c8dda@gmail.com>
Date: Thu, 1 Feb 2024 14:02:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/4] docs: Clean up `--empty` formatting in `git-rebase`
 and `git-am`
Reply-To: phillip.wood@dunelm.org.uk
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-3-brianmlyles@gmail.com>
 <192892be-262c-487e-bb1d-6e50c01e2d66@gmail.com>
 <CAHPHrSdOVoBPR9vJou_Bxmq=4QW_z6nhnzxfmZ1Am0i-GJuz4g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHPHrSdOVoBPR9vJou_Bxmq=4QW_z6nhnzxfmZ1Am0i-GJuz4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 27/01/2024 21:22, Brian Lyles wrote:
> On Tue, Jan 23, 2024 at 8:24 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
>>> From: Brian Lyles <brianmlyles@gmail.com>
>>>
>>> Both of these pages document very similar `--empty` options, but with
>>> different styles. This commit aims to make them more consistent.
>>
>> I think that's reasonable though the options they are worded as doing
>> different things. For "am" it talks about the patch being empty - i.e. a
>> patch of an empty commit whereas for "rebase" the option applies to
>> non-empty commits that become empty. What does "am" do if you try to
>> apply a patch whose changes are already present?
> 
> Hm -- as you mention, this does appear to have a different meaning for
> git-am(1) than it does for git-rebase(1). Regardless of the `--empty`
> value passed to git-am(1), a non-empty patch that is already present
> appears to error and stop.
> 
> That is an unfortunate difference. I think that my updated version of
> the git-am(1) docs is still easier to read, and preserves the original
> meaning. So I'm inclined to say that it's still an improvement worth
> making, and perhaps my commit message should just clarify that.
> Thoughts?

Yes I agree the change is worthwhile but I think it would benefit from 
an updated commit message.

>> If you're aiming for consistency then it would be worth listing the
>> possible values in the same order for each command.
> 
> That makes sense. I had initially maintained the existing order in which
> these were documented, keeping the default option first. I think that
> the updated layout makes the order less relevant by making it easier to
> read and identify the default anyway.
> 
> I could see alphabetical being better, though with the changes later in
> this series we'd end up with the deprecated `ask` being first or
> out-or-order at the end. What are your thoughts on the ideal order for
> these?

Alphabetical sounds reasonable, we could sort on the non deprecated 
names with stop and ask grouped together

drop;;
     ...
keep;;
     ...
stop;;
ask;;
     ...
     `ask` is a deprecated synonym of `stop`

>>> +`keep`;;
>>> +     The empty commit will be kept.
>>> +`ask`;;
>>> +     The rebase will halt when the empty commit is applied, allowing you to
>>> +     choose whether to drop it, edit files more, or just commit the empty
>>> +     changes. This option is implied when `--interactive` is specified.
>>>        Other options, like `--exec`, will use the default of drop unless
>>>        `-i`/`--interactive` is explicitly specified.
>>
>> Thanks for adding a bit more detail about the default, however it looks
>> to me like we keep commits that become empty when --exec is specified
>>
>>          if (options.empty == EMPTY_UNSPECIFIED) {
>>                  if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
>>                          options.empty = EMPTY_STOP;
>>                  else if (options.exec.nr > 0)
>>                          options.empty = EMPTY_KEEP;
>>                  else
>>                          options.empty = EMPTY_DROP;
>>          }
>>
>> Off the top of my head I'm not sure why or if that is a good idea.
> 
> The two lines indicating this behavior are actually pre-existing -- I
> did not change them in this patch and thus didn't even think to fact
> check them.
> 
> Upon testing this, I've confirmed that you are correct about the actual
> behavior. I will address this in a separate commit in v2.

Thanks, I'd missed that those were context lines in the diff.

Best Wishes

Phillip
