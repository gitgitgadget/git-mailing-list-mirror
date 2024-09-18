Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7271917C9B8
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653999; cv=none; b=XpV1+svhX0M8SWD3BuZKQiaKDBaWiH4NQx8haj+7PaKgJCn/+WwJwomrOis9ZhUj50SRDuTEPgFAP88nTzsaJnH4or0xizxTda4EVAmPx+J+RYjKyfqMXr3ZM7bTrEZgxklJ0MykPYyjywvrLI40zsjVJZOgNFd/f7cyJ14Sv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653999; c=relaxed/simple;
	bh=SExZS6m1CnAaZIxXZymweOPp9VDARsF/+Qn+KrvE7rs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p2NJ9j3LCHW//Pz4FHjlCvqTDkQiXW0UXwsAneFlH1VDCYozw7tga/m6bSllEcc8HMzTtJCTfAh0RXWF1wD+uy7o1JTT04/ViYP0CjMmzVfq+kUI7QrO4XK6/cV1ZXiyW25PdlA3SiPKAkG5roiIQPCf3f7oC6IQ7wO7ZQ+nLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jySNElmP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jySNElmP"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-378f90ad32dso2055803f8f.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 03:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726653996; x=1727258796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjM5QWXVvjLKSO90lbY7fLCTlTUQyujnB7z1R43HcxM=;
        b=jySNElmP95O6ATkSoSGBwlqBBxHlVI4lHkPIugAAHXWgG4j2danBvQFOxovQmSFfTi
         6K7ZKjXsiE5fQt6uDgaUp7Ji9owNl0RiHGISTPcQHGFFUwLf3GKoEdEbGmoXPLjp7bwN
         aZe9vv561dMC9kRKvCs3Ira0gI6ITTlIezVyjKdZqL2DanDqOE7DcmhTaiqxsqwHynQq
         cU+k2MUgrHiGwBJjtld7+fYnmvvzJ7jaVzzlRTexgfrAwvwfrRAvLk1hzmqkKdQmSL2Q
         no8nBEhJ3euXiWKbsvs70VrTWEzPx8lgneecNZ71BhT3sGYxKT4kLG8Jj67Gpu+McPg1
         Em+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653996; x=1727258796;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjM5QWXVvjLKSO90lbY7fLCTlTUQyujnB7z1R43HcxM=;
        b=p1Rdua3o11s9+SUhd7IMEJ98jKq7iM2R671QPku696TLK0hTkcmfTdSQCqtAhybwnO
         nYqcLKVGtWKqW+oJ97MlfdV7JTRPLOHl3SVoMKPUibiRE91SyTng+UI61X+KOODLt1kx
         O9V6DESuf+77uCvWT6eQEUmTfdpZ3eJE4vGwD53lmixXqN86tdzlOyquFm83Bx/DzKLh
         LWYk2Iw71rzv5LJMYylR6jLXiEl/edn3pZpSMeeuGnATMJ9RWxwuB94UOSiE1f6Htn2G
         yh6I+Dzi6XRTYNhSpKKwei7DaKwJzA1iG+hWV+Iwku/37w53Z5JQNwkf4FUd4mZLsIOh
         08ig==
X-Forwarded-Encrypted: i=1; AJvYcCVmp1MK3bKX0NyeQkrh88COC0mDLvybSKupfBv+NCger9QErmZuFUjcNOdo2Ea4nMRUENE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmI+09zWzBdpwfMlKyasSTksVpDGklnnCZCzAOnBPlkb6gfd/G
	55xF7d4l/UGiD/N7xzud5X9dAysCUKXerT6FKHMRsqmWUEZ7F2RI76X5OA==
X-Google-Smtp-Source: AGHT+IEZYwfOghq6J/NBADTMsaqpmnyt4hcCR7hQzytRfviE5mhM4PUx821b250EoVmF38UEFg9fWw==
X-Received: by 2002:a5d:4e50:0:b0:374:c1de:7e5e with SMTP id ffacd0b85a97d-378c2d58e8fmr11280782f8f.54.1726653995405;
        Wed, 18 Sep 2024 03:06:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e4b60sm11876834f8f.24.2024.09.18.03.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 03:06:34 -0700 (PDT)
Message-ID: <d20d030b-7d3e-49c6-a988-ab7fe480dd47@gmail.com>
Date: Wed, 18 Sep 2024 11:06:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: edit the hunk again
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <21ddf64f-10c2-4087-a778-0bd2e82aef42@gmail.com>
 <cba63486-2186-4e8e-aad4-ed7f54606ec7@gmail.com>
 <be0149e3-148b-4e25-9e44-f3f9a3303fcd@gmail.com>
Content-Language: en-US
In-Reply-To: <be0149e3-148b-4e25-9e44-f3f9a3303fcd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 16/09/2024 23:09, Rubén Justo wrote:
> On Mon, Sep 16, 2024 at 02:33:54PM +0100, Phillip Wood wrote:
> 
> I can imagine that we could give the flawed and annotated patch back to
> the user, if they want to fix it and try again.

Exactly

> At any rate, I'm thinking about small fixes and/or avoiding to use a
> backup (":w! /tmp/patch" + ":r /tmp/patch") if I have doubts about
> making a mistake after spending some time thinking about a hunk, so as
> not to lose some work.

The problem is there is no good solution at the moment. Either we throw 
away the user's work if the edited patch does not apply or we keep the 
broken patch and say "this is broken, please figure out what's wrong 
with it and fix it". As I explained previously fixing a broken patch is 
not necessarily straight forward especially for new users. A few times 
when editing patches that are going to be applied in reverse (from "git 
checkout HEAD -- <path>") I've found it impossible to figure out why a 
particular edit was being rejected. In that case starting again with the 
original patch is my only hope. If you want to be able to re-edit a 
broken hunk perhaps we should add an option for that when we ask the 
user if they want to try again.

>>> diff --git a/add-patch.c b/add-patch.c
>>> index 557903310d..125e79a5ae 100644
>>> --- a/add-patch.c
>>> +++ b/add-patch.c
>>> @@ -1146,6 +1147,10 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
>>>    				      "addp-hunk-edit.diff", NULL) < 0)
>>>    		return -1;
>>> +	/* Drop possible previous edits */
>>> +	strbuf_setlen(&s->plain, plain_len);
>>> +	strbuf_setlen(&s->colored, colored_len);
>>> +
>>
>> At this point hunk->end points past s->plain.len. If the user has deleted
>> all the lines then we return with hunk->end in this invalid state. I think
>> that turns out not to matter as we end up restoring hunk->end from the
>> backup we make at the beginning of edit_hunk_loop() but it is not straight
>> forward to reason about.
> 
> I'm not sure I understand your comment.  We are adjusting "hunk" right
> after that, no?

Sorry I should have said hunk->colored_end and s->colored.len. If we 
return early then we don't call recolor_hunk().

>>> +	echo been-here > "$1"
>>> +	EOF
>>> +	test_set_editor "$(pwd)/fake_editor.sh"
>>> +'
>>
>> I don't think we need to write the fake editor in a separate test. Also it
>> would be better to call test_set_editor in a subshell so that it does not
>> affect later tests.
> 
> Yes, t3701 deserves an update.  I tried to respect its current style.
> I didn't want to start a mix.

I see are four instances of "test_set_editor" in this file, two of which 
setup the editor within the test that uses them and are called from a 
subshell. We should do the same here rather than creating more work for 
whoever decides to clean up this file in the future.

Best Wishes

Phillip
