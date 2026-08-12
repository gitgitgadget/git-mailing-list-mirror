Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964043C7C1
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539598; cv=none; b=pLG+uZJdsNl683KbQJSiOwmAUNVqj83Xb7OC4yrDEWmVHgZ0xseGTO/oLlYo1I1VcE/B/ph6et52BKCoCDsJhm6wwAouhh2jegev/NuNZxzfQiIqIXNZ28tikc+emT7a84qH4eH62/NnT7yUGRO9+gJysTrTUP1HKQDzh3QEAX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539598; c=relaxed/simple;
	bh=EDpnHlDvUbf40QqTLl20rm0SIIfcNHsHrMyVzB5CJpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Id6sl6MK6h7n3Zs+9rJKDL74xvXZAu1BgisCt8Wi7jy18PVqLjTAm5DIYoiJkNVEgCLprV0dqQcyD9lHWII8DNuXnc4NI/UaLk7OP+TfBDgAnBU1aaHj+Orvba5XRUdvd/83GbgOb3Wzb7qX1OBiqtA4u9LoIW5vbvZbbu6B1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTcs22+d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTcs22+d"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980dc26022so9359855e9.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786539594; x=1787144394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WfRqCkXJVdSNEoQ4wn3O/vxpQFOUUUFQ821BjryZBIs=;
        b=nTcs22+dhA+/OtmOcQT2g9CAmJvofcodMao+MpCgDpi/yjho6gK5rXjZ49rY2/Ja5s
         dNcVC8AZTWPtBBeCksliSvFL3/mrijTQTgSggSBzbJSaLP650jaGnm9WRRJaXv0WLM9z
         Wgs0/PWx/kY2ZNJWZ1k921Vv2Vi4iiZRFKK9b3qV3qn5uS7q2XO+joNNdZxiernCDgJC
         x5ahS7lrOtgSlxrHVi8Cg0zLZcLE2JFtdZA0y8z+UyhQZx3DFVAF7Png91h6te4jlwCT
         c4oYrmmUsAe7Z+/sgfc+nXxxh6t7T/pNVj45SWyr3rSRirej6Db7GZdWeV3TtyFNPzS6
         kBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786539594; x=1787144394;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WfRqCkXJVdSNEoQ4wn3O/vxpQFOUUUFQ821BjryZBIs=;
        b=sIyOjpi89RQ0VKKcNhHN3J7KRXT7J2FIDPPdY88cWbRh4du3DZrf3ejojCD4HgQUZK
         HTrvPqNRsWHM+1uzby08u3iIvgm+BAuSGFVqqKLiO1XwQjYqqVuaCYc4I+0n2iuvvwDR
         sD446TZoPxXjB3oWrfn9OQOHj4QxSCpRPNLBiX4AbZRQUrugkNHTbka4Yu+UwBc1i9lJ
         rp/FFC38kdX9QbOmg2sxOTzDaA6HofJkXseSUkvBCGSKpA62crzyoe+F/CHYVkN+Q4lD
         477LH7rKvwx8D0TzzoG9OW9VOWq4KWm1JouwDs1jEhGZdPMW7x15FriiBxuvd7XinnBR
         ecDA==
X-Forwarded-Encrypted: i=1; AHgh+RoVYDd5Gbeou+jOgBseFvQZ626eXey6KAo1LDOwLGeP7wIDIKwWciMWzGNHsvLFWx33WA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz58iOP9pIaKFYW/3PzLGZc2Y1hOEfnqjyD/8Xu5MxpMxyL5+bN
	qkLMEUMQwHsLm+7ZmPYFWvQ2DAzqQ1lpi6gGMirpoeUeXMDAIFsmJf5GvlxiZw==
X-Gm-Gg: AR+sD13HF4PR1p2C1V1a8VEmgUocupqPS92+K3DFc4MTMFikcL8DC26AxcfTf5QhiEx
	ONLcTz0yqsmS8F1EdyRFIikv5dnqjM7QVcKIZp3SGK4IIoxq7k96OlgIvKEMfZzj4KgUWmagV7Y
	8Pbx/21WwruYd4JEXUYgqPkrQ5V6RZfC1qisj8rhH93Gu5wvZAundkFbFSW0d9kTyrrR8Z4NNTU
	WSgKFkD0huWU9OHoVBNNF85sbrcKdFf5mVepOkmrSGhaZH1CIIf9VvwUQCDntHqFreszfOX7+37
	rCh96KQc0vEfGdfn8r4xXzEkHJ/P5zQZ9g2xJSXSt9+YW3oQKANbfhGzOwtuDhSIaTHRd/Yt4nl
	qjispzUSK0eU40V/3B5p8JZUN5p3Nw7EoB1BnO+Sfjc5dLYpQAa39kTL2tuYc8xnhFhpl9rVATJ
	j4FPJzkpIVjoFnYBOQSYpcKICvCFnao15EspcJQ+5mxFcQ3EouWMOdLgsoIs49me+aoueiE+S9S
	gEwdVv92WrFZhvTxXUUDK6ywQ==
X-Received: by 2002:a05:600c:c178:b0:498:1595:be7b with SMTP id 5b1f17b1804b1-4997c0cd08fmr63581675e9.4.1786539593436;
        Wed, 12 Aug 2026 05:59:53 -0700 (PDT)
Received: from [10.0.1.15] (85-71-82-202.rce.o2.cz. [85.71.82.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4e3f5sm7168123f8f.22.2026.08.12.05.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 05:59:52 -0700 (PDT)
Message-ID: <f4e39b04-b6dd-4b83-9103-8a1c98019dce@gmail.com>
Date: Wed, 12 Aug 2026 14:59:52 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bugreport
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
References: <a7899757-9c3d-4735-b7ab-469808707e61@gmail.com>
 <8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
From: =?UTF-8?Q?Marcel_Svitalsk=C3=BD?= <marcel.svitalsky@gmail.com>
Content-Language: en-US, cs, en-GB
In-Reply-To: <8fe70f89-89a8-426f-bab9-21284722c58d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I see, thank you. Is this a new feature? I've been using this command 
for years
and today is the first time I am seeing this. Also, is there another 
flag instead of
`--all` that would just include the actual commits only?

Thank you, best regards
Marcel Svitalský

On 12/08/2026 14:54, Kristoffer Haugsbakk wrote:
> I have only skimmed this.
>
> On Wed, Aug 12, 2026, at 14:31, Marcel Svitalský wrote:
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> I called `git lg` command to display git graph log in my terminal. The
>> command is defined in my
>> general gitconfig file as follows:
>>
>> # double liner with hash, time, branches and tags on first line and the
>> message on second
>> lg = "!f() { num=15; if [ \"$1\" != \"\" ] && ( echo \"$1\" | grep -q
>> \"^[0-9]\\\\+\\$\" ) ; then num=\"$1\" ; shift ; fi ; [ $num -eq 0 ] &&
>> num=999999999 ; git \"$@\" log -n \"$num\" --graph --abbrev-commit
>> --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold
>> cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold
>> yellow)%d%C(reset)%n'' %C(white)%s%C(reset)' --all; }; f"
> Note the `--all`.
>
>> What did you expect to happen? (Expected behavior)
>> I expected to see git graph log with the project commits.
>>
>> What happened instead? (Actual behavior)
>> On top of the project commits were added these four pseudo-commits made
>> by some Git component(s).
>>
>> * f7b611ce - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
>> |  Notes added by 'git notes append' - rewrite-analytics
>> * 1a7605bb - Wed, 12 Aug 2026 09:26:03 +0200 (5 hours ago)
>> |  Notes added by 'git notes append' - rewrite-analytics
>> * c2a05d79 - Wed, 12 Aug 2026 09:25:03 +0200 (5 hours ago)
>> |  Notes added by 'git notes append' - rewrite-analytics
>>    \
>>     * 01c630e0 - Wed, 12 Aug 2026 09:13:00 +0200 (5 hours ago)
>>        chatter: initialize notes ref - chatter
>>
>> They are not graphically connected with the actual commits, they just
>> sit there over them. No other graphical
>> tool (Sublime Merge, IntelliJ Idea) displays them.
> They are Git notes. They form their own connected graph. That’s why they
> are not connected with the “actual commits” like from some branch.
>
> The `--all` will include all refs, including Git notes like
> `refs/notes/commits`.
>
> This doesn’t look like a bug.
>
>> [snip]

