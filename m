Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A0D539C
	for <git@vger.kernel.org>; Mon, 13 May 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715613123; cv=none; b=aARVnWxfcvyUBmUOI9FEve6x2l1oU75FmXtzA1+6cCkwYEQuDnBwi9gGZN1sZ18URZzaidgarNZXyVSu1M2QAQTkVDxyrheAVxRpNHgDqFKjTVx+I02XCJf3SmcP8jOAWs/NABIwzUY7aarVCTIzQBFnp9nxQmqrAWedGgW9QLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715613123; c=relaxed/simple;
	bh=A6dCfCUQkK7e0CWhli7XIV0S0kFPuicsg0kkYfAKTv0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tz1Wu19kR1kEHCaF3LnFQbSLHYp1wy/gopZtHN4PRha6RbWuMlPubY2sHxXS2P+XtYh10KBn2Wmugv5nZ/d5/rlYCzyISqgfd3X3Ad+gryzp468BjHwaawc5gmfkqAVJ/qZMl1ycoKdD9WC5Fd0pa9y+pG9iGabPE65J5B1Uo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKqKuPkT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKqKuPkT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4200ee78f35so15720045e9.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715613120; x=1716217920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vz68FN8rih3DGiVjqco6Gvh0EtLp9flmVnIRHnm2twQ=;
        b=aKqKuPkTEt45otpUP32nU/sMadgXfW7dpnYkPeSYitw1mdkvb52jTXRaQXgxIoq9/+
         m8La9cyQ3g+2MA2KqYNGDh/jWJfGORLJ/KbexjRwAXmAEFKxx4Nds80YFoAk/4dfkuTe
         Rnz6BF+FLOgKGenbRn2BJLdyIfsyIYdDE0MzFCfIJA05JY/audkWDepDc71PiythEATP
         w5WDYd81I3mCq7zH/QtWYrNunBqGe6uXboqHylyQ7db6AAw+mpVhLXU93tJBbYyncljD
         hDHfQwTlEFPXkP8ePOOFlKlfr5SdHuIXeVXoZpA+ngL1a/qCX/Xy/y19OdMSbhqNijID
         BXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715613120; x=1716217920;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vz68FN8rih3DGiVjqco6Gvh0EtLp9flmVnIRHnm2twQ=;
        b=jqyEmUapDmd1PWxAos0JrGA//P/V4zQe9K5muqi7znc0nt74glLr/vkzw1GjNihwUf
         k69A/CKi1XVE+LJVxr66XJgsaX4NygHawATuGL8y8O8XVFJwczKUPUQ3xQVXSNfvbm03
         6FulP+OOKGlzFoHx3/fnZPG28Pv9KOm5+6LVX4HqXiEIszzPZQ1qVLjT6xen1h82z0lO
         kiF2PM1C9CCOtkSO3rc+gwCuJgSd0LCp9U7sFELqpGqeakI+KQeatS4vOc6eDSgWr9fY
         BwgvAG+A2QTzRUzuLH4OmhlmFOK9c1vyxdDq1lZFBZUKeiJUboJa5disJNS4rh/uig1b
         Y+LA==
X-Forwarded-Encrypted: i=1; AJvYcCVYJzZHrXUjkSHFsAsLH2sjzA6bLx27ry09ZXdJLOdfOKFKy5byFxnunpjMp+vwW7cvuZCkEcO0Yb3i7p1FKHRhWtvg
X-Gm-Message-State: AOJu0YxVtuBah7C9XeigF0Ve8RV1APWsXBR2CJobWdON1tdxY85m5QlF
	weaVL0+3gIlHp3StHxHgmgsHijXxumnKKHmMTwmf8QKz6dTdzSp/
X-Google-Smtp-Source: AGHT+IHNo8Y5k1NGDnFLyds1wo+a3D2vIOzRStSW/G1uzM3gBWTbR6dzdsb3Ttl2b3Zki40Ugj7Otg==
X-Received: by 2002:a05:600c:4f4e:b0:418:a985:3ca with SMTP id 5b1f17b1804b1-41feac556e3mr119660335e9.31.1715613120152;
        Mon, 13 May 2024 08:12:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce9426sm159243945e9.25.2024.05.13.08.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 08:11:59 -0700 (PDT)
Message-ID: <f182c3f0-4d9e-491e-9b0d-59560cd93b8d@gmail.com>
Date: Mon, 13 May 2024 16:11:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 03/10] trailer: teach iterator about non-trailer lines
To: Linus Arver <linus@ucla.edu>, phillip.wood@dunelm.org.uk,
 Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
 Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>,
 Josh Steadmon <steadmon@google.com>,
 "Randall S. Becker" <rsbecker@nexbridge.com>,
 Christian Couder <christian.couder@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
 <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
 <4aeb48050b14e44ec65cfa651a4d98587a6cd860.1714625668.git.gitgitgadget@gmail.com>
 <18343148-80d1-4558-b834-caaf8322467a@gmail.com>
 <CAMo6p=GJwmStLrW6cDDKrch2cXn_8fe0GsBHi3hpe5Uya72y=w@mail.gmail.com>
 <a75133dc-a0bb-4f61-a616-988f2b4d5688@gmail.com>
 <CAMo6p=FS3ShvBdutprWBiAVef6A1XjsXB1UJSQBk0s5euN=tog@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMo6p=FS3ShvBdutprWBiAVef6A1XjsXB1UJSQBk0s5euN=tog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus

On 09/05/2024 08:11, Linus Arver wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 05/05/2024 02:37, Linus Arver wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>> On 02/05/2024 05:54, Linus Arver via GitGitGadget wrote:
>>>>> From: Linus Arver <linus@ucla.edu>
>>>>>
>>>>> The new "raw" member is important because anyone currently not using the
>>>>> iterator is using trailer_info's raw string array directly to access
>>>>> lines to check what the combined key + value looks like. If we didn't
>>>>> provide a "raw" member here, iterator users would have to re-construct
>>>>> the unparsed line by concatenating the key and value back together again
>>>>> --- which places an undue burden for iterator users.
>>>>
>>>> Comparing the raw line is error prone as it ignores custom separators
>>>> and variations in the amount of space between the key and the value.
>>>> Therefore I'd argue that the sequencer should in fact be comparing the
>>>> trailer key and value separately rather than comparing the whole line.
>>>
>>> I agree, but that is likely beyond the scope of this series as the
>>> behavior of comparing the whole line was preserved (not introduced) by
>>> this series.
>>
>> Right but this series is changing the trailer iterator api to
>> accommodate the sub-optimal sequencer code. My thought was that if the
>> sequencer did the right thing we wouldn't need to expose the raw line in
>> the iterator in the first place.
> 
> Well, having familiarized myself with the trailer machinery I was more
> comfortable updating this area than reworking the details of the
> sequencer code.
> 
> To me the sequencer code is a bit hard to read so I feel more
> comfortable updating the trailer code as I did here in this series. I
> also have another 40, 50 patches in the trailer area I want to continue
> pushing up for review, so I would rather focus on that first before
> coming back to the sequencer to try to clean it up. My other trailer
> patches make the trailer API more precise and aware of the separator and
> spaces around it,

I'm a bit confused by this as it looks like the 
trailer_iterator_advance() already respects trailer.separators and 
trims the key and value.

> so using those richer interfaces later would make it
> easier to clean up the sequencer area, I think.
> 
> So in summary I would rather not get into refactoring the sequencer at
> this time.

Far enough, I hoped I might have time over the weekend to look at the 
sequencer code in more detail but that didn't work out. So long as we're 
not building bad abstractions into the trailer iterator to accommodate 
the sequencer we can come back and clean up append_signoff() later.

Best Wishes

Phillip
