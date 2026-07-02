Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1254B8DC8
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000734; cv=none; b=NyWs+okSNMQTDGZOnczHmA3Uj7xMnKjfyMDQiFaSpqzGGFGuFKx38/e91kTKUxjIynBzAVIryYdebCoWAp1lEkohs5Jk5Ew+dA/Lg7K2UIdWdGdIJR9Xqszs6aHKmwDQxCfHjabkC3Tn7XMCDfzx9EyiKM6jjhls9bFNrbDk7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000734; c=relaxed/simple;
	bh=+JiTWnpPxJLe/SmfGUP8kEhXsRV3M54qPXhZFOfasLw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dHALEbS8zjxX98R17GXnrP5TeDLkixH5MAHlpbV9ATCSo59sI8QZovrSwVsOzwb+dQA7rlYntFyV9CDm69NRtkVvl1U4hrULHUJ2RgOikMWU74vJAWzVAGkaEW44k3nTvSH3IWVArLMmUO/3Xm3lp4z3k4kDz4ALVJVNlpf+t18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUnFHzqO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUnFHzqO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so13013255e9.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783000731; x=1783605531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KyaJmN2n61u7xUjVdifQ+bDcxO6HfaA9K7BIo4wdsfo=;
        b=rUnFHzqO6I0E+8yXnJ9unAwrJOrLZMaKl7KEjiTBRHLocjCaekGJywgJIJlWSnpesk
         zkfle0E1hVR1hCM+m/bC7/uGcGSwVgqtiXZStHTGaqezqqR/pgiP6n9uVPqhfnMGt0Eq
         kN78DblAHK7j14byP/ZCDdm7RzqzvfbF7choG2nF3t766UtSJVklZG6GfE8BEUSO5Bch
         /VdieaS9MGvRc8m6LFxec0y/wXSRNxM3T/WQem7r9rh2/hqnWaNoZodvUvxZWqj0ET4B
         pHwLHaVOfBSTsWoHh+EDvtUMGvGfgOLg+E5o7nJSpkJlLFdxDgl8oMJ1lsXxxlCEWC6N
         u8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783000731; x=1783605531;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyaJmN2n61u7xUjVdifQ+bDcxO6HfaA9K7BIo4wdsfo=;
        b=UT/oZlfeY54vs3TL8BWGo2y8uG/xD58Qy5Q2aBAc4PKEgLrwP6EMXnciXQJuz12lIz
         eZy7x1KsAXgUe1l4/YDNgIZrr1IwSmkJgPVh14pf2Jk3muPk5XaHlFeaXJZwj5Y6tQKb
         ZyX80ZZXK2tHhFmOhLxZmJwZT6wwY5HCZiIVcmuFgtd+tSDZTh27qxOR+szUuLOfyRvQ
         HnmuGaKRwYQJUOd8OU1cl9XiHqDI1UxpYkpraM+tbUt0pIniubP1n+1PxkPE2vtmAEj8
         tAUNyo9BbNSJU7S7OI9A2cDv9KrFxQSiy5MmzwsLGPSbs8dsVWGS972CvkdC6BrIMeqU
         zLig==
X-Forwarded-Encrypted: i=1; AFNElJ8PZlXXP2hnbeLt2MB+W5eaQnW3qcVcz/xmFopien4BEVyYOhtKdYKGhlVEeycIJRakLiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1C0KlU4tWeKy3UVYh3Gge9ioUwYpfi2zyLt0aYcw6EPsYmu8d
	Pi0vLuhwDNSfapIXag6AlB8ApnLE4bj+wly5//PKyGDsO2vGLBPcwSED
X-Gm-Gg: AfdE7cmoj+BBkRlPS8KI5Oej+PWAlZWUaGzVhxUF6z5jk/whSHIl5yc0h+DtfJtvXhj
	MLR+HTDsbQ3hA8iUyroCBx7eBKYkFWaQMejDknAYqKLQhdtgYis1edGgrWQEq+EfblwfccgIA6W
	+zoiOR4VDq76JmCK7BLLd9BEZD/vbNUvVOy0JNPbIQ1LXvDlJmNdhvO5dKpyCBGw1DJE79el5ic
	bJVpXPmRQP8lDc6PnYpv6cBb2Ox5MlBSBC5WnhvGek3xfx0rC2fR76KxKhGLT7ldlYvT4e+DYDb
	Sj/OXBeEawiGND15Upnu+pXdoRYu1zDL6NzZZ6rFDZMSNG6TdcQgaL3IH1M6YGOM3CzG5OR30EV
	2LOma/blILeBkpAx/PdBW/YEaLcruMUwDNTGIwkW6i4tpn+odpnUN0E4U1ptPe27fjwuzYSIOkT
	if9jP20oNk+WtBYkYbwhvabNQqdiz8Oqp1qn6kl8K/aQeu9aGDWxvFHm8PlR2OasG9aGQ=
X-Received: by 2002:a05:600c:8189:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-493c2b9cc74mr85588555e9.30.1783000731263;
        Thu, 02 Jul 2026 06:58:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94c8ccsm9482895f8f.21.2026.07.02.06.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 06:58:50 -0700 (PDT)
Message-ID: <dd692c2d-87ca-4618-ae34-7e5e90ffa515@gmail.com>
Date: Thu, 2 Jul 2026 14:58:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk,
 Patrick Steinhardt <ps@pks.im>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
 <CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
 <4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com>
 <CAHwyqnXoqZYHodWXHtwnk0_PiZcCYSVL+WgL3h5nWiYx_cSZLw@mail.gmail.com>
 <f15456d2-d8b2-4edc-80b4-3a9d8fc77da9@gmail.com> <xmqq8q7urfe1.fsf@gitster.g>
 <c517bce2-9f39-46ec-8509-bb0893e26ae2@gmail.com> <xmqqfr22obei.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfr22obei.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 18:41, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Yes - if you apply the way "rebase -i" works to multiple commits you can
>> end up with a message template that has a screen full of commented lines
>> between uncommitted parts of the message. See the example below from
>> earlier in the thread. It is not so much of a problem in "rebase -i"
>> because it only fixes up a single commit at a time so all the commented
>> messages end up at the top of the buffer and at worst you have a few "#
>> fixup! ..." or "# squash! ..." lines mixed in with the uncommitted text.
>>
>>       # This is the combination of 4 commits
>>       # This is the first commit message
>>       Base subject
>>
>>       Base body
>>
>>       # This is the second commit message
>>       # Another subject
>>
>>       # Another body
>>
>>       # This is the third commit message
>>       # fixup! Base subject
>>
>>       # This is the fourth commit message
>>       # amend! Another subject
>>       A better subject
>>
>>       A better body
> 
> In the example, the second one becomes completely empty?

Yes because there is an amend! commit that replaces its message
> Is the proposal not to show any messages that will be discarded
> anyway and not even show them in commented form?  I think that makes
> sense, and leaving only commit titles for these commits that would
> not contribute to the text in the editor given to the user to edit
> would indeed be an improvement.  For the same reason, as "# amend!"
> will replace the message wholesale, it would also be a good idea for
> the first commit to be hidden like all the other commits that would
> not contribute to the text,

But the amend! commit does not target the first commit - it replaces the 
message of the second commit so I think we should keep the first message 
as shown below. You can see a different example with a squash! message 
at [1]
>      # This is the combination fo 4 commits
>      # 1. Base subject
>      # 2. Another subject
>      # 3. fixup! Base subject
>      # 4. amend! Another subject

        Base subject

        Base body

        # -------------------------------------
	
>      A better subject
> 
>      A better body.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com

