Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6001862A
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002832; cv=none; b=SonU/I10YD7w/O8q5axUy3JsaK/hc9CwKsV+8tv5bD8mhEHI3rlUaySO30L6KEMu9ckxbVbACEJ5Z+K5CO0Cs95t1zPtZeSXMpQvXShvgiTtg1Dejkoc1nAzDssUrhv8wl7EsE3Z4nR+5B7cu6ZtLL0lEUTA1/N8lhxm/V9zVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002832; c=relaxed/simple;
	bh=rrlIlHhPAO62wJ+ksOvKe6o2udX7XIwiSK08XpRU1QE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QdzwntClKkvVejF12gCfTdBT4CraCCKg/bzAVUlzCkNceuQJobscpRsBiQ7q1Th+cjM/2IyZuLCQTI/CSWqei6omQDooXiVqYjyz42Xvo0GqSEc4FM64kPo0Y7SGoQGTNpnIf9ily7UhGTb7jJ206gsgt1L8Fc8fxwvl+80/lVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ0Ocwjw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ0Ocwjw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso668668f8f.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760002829; x=1760607629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+oYs8H1h2XO7jbdil8kPOuhDl8rbKyokGCs67lPJfY=;
        b=SJ0OcwjwHqjULjjLp/FyM8cAB9UPOyUXvQb5qAIp8jErOOMzLZ/F9JmgBwj7ez1OyL
         zeJAfJUG89LEcaLcUkI9WAH+inlmsMz2eDJrNLUkpVjniO6yQllNhLWL5Awu45d9T26J
         0AcfnUdqOBt0eJxQQpADzZBU6ci+eoZGi3TQPBgP9vpxCp+j3SUZ8QEbyB6fmyXzuuC2
         nTKL6aetRzBTFXSAqXICa1cGbLfzAEeYYjCDsPV13kJwfp2vcgkzxdkbeC2jhrS9scgK
         8u6chxWM9SRcMuj80FET9ofWCyILHHavBnCQnFrkyXZEdMldnWSXMibBVKOc2GMxgWYK
         4+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002829; x=1760607629;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+oYs8H1h2XO7jbdil8kPOuhDl8rbKyokGCs67lPJfY=;
        b=c+r+bz5MxkD0iZVbdsydGWkRpYqQDDoYpMAtfIKtdfx6mVrmJdCJlHw8kvTErDjeL1
         zYcRv5G3wzsrJ2ZU94iqS1WECyw8Cj5eqeyxVoQ4HeYP+S837dVzxjr1u4369/UVtQgS
         WDMwHKzV3kK36VhpW72juWpHW1miUvuzj6VZ4OAY2li6QxW0TMQuz56mVjSgVdSqit6w
         NX62T++msZBIHrpZg6whug4qPhm3ss0SrfVOea/+gdt5vSySznva9DacSKPC7pIjzG7C
         m+V8Eyk5N1pgeXdk9oFAvgubaLZOkoQZtQwi8IaI0Ismnu3GRBtyMp3OQX4CYm4mWn3Q
         c2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVwQuzfVlDzb5Asf8W0Ag01bXF8I0xSRvmTwQmFbj4SfbnlN/d26IMS+4tPESW4tsAegpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3VaX/JwJeSzJv0Y2CpAeOHyjmTpz9Ge1z67MHc0PowE4ehCW
	hsmxAk8AKW5m5AwpWcKCvR720l7/yz5/u0cIog28qRXL1CzpQuZRN1CS
X-Gm-Gg: ASbGncsdX2Ud1TX75ad4Of7IA0NPOHuvax5ExmAkQFahRylQKy7EI0YdeTVPmo/GZ5D
	iZM7+dJUzlois5OnnM8Y7KUAc0/mwdsDJX1nWl+I14Ijluv2dEEhupjr58ndCm8WY/363Wq38Lc
	ehMbqtwAI4EtLgiaw/s1OLHUYElmMxOulZU5O1TmAtUPaO6ZFoeGWpJgexu5WQGFI0sGgSyPk7s
	iggnDytAqx2z4g8NYbT1uHs+6zrOkgVZXjFgPnP4PwunYpmqBKWWaEowKKiV7fkH5Z9+0LSMTIO
	12HBcTxVbN2cZtd0+Id/G0a0os3ZLDgab7GQDst5GPjLIGKxfkEZ1KadqEsCH/PLlCXqdh8ONhK
	/PQoPyeHyRyrEozYO6F23B2Uajd0XVCTk9Hne9BqrX35jmIl9aN6qQZN6CuMhRd238IDY9I1Ux3
	TSmIK1VM135G7QMBwWlUL06S4Av2Xia60PuiL3Huzc5kbd
X-Google-Smtp-Source: AGHT+IEuwnb/P2xefBIa+nOU5VXUPuvqPg8pWEqPpVBAJwjzpT6+uU0VSF9VFfme/dkuxq06bJFKkw==
X-Received: by 2002:a5d:5f48:0:b0:3f6:9c5a:e202 with SMTP id ffacd0b85a97d-4266e7bf23cmr4109759f8f.24.1760002829308;
        Thu, 09 Oct 2025 02:40:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm34016133f8f.2.2025.10.09.02.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:40:28 -0700 (PDT)
Message-ID: <f6f3ca21-8894-4477-9a00-600cfa53a2ae@gmail.com>
Date: Thu, 9 Oct 2025 10:40:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
To: Siddharth Asthana <siddharthasthana31@gmail.com>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 karthik.188@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
 <9d310bd5-453f-43a4-b477-ba02baa7a664@gmail.com>
 <d9764c7b-8de2-4b54-8c44-a4bd7f5860e8@gmail.com>
 <1bfffc20-7e25-4633-a0b8-6660913a74dd@gmail.com>
Content-Language: en-US
In-Reply-To: <1bfffc20-7e25-4633-a0b8-6660913a74dd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/10/2025 21:09, Siddharth Asthana wrote:
> On 08/10/25 19:31, Phillip Wood wrote:
>> Hi Siddharth
>> On 02/10/2025 23:20, Siddharth Asthana wrote:
>>> Would you still prefer a --update-refs=<mode> style, or is the simpler
>>> --output-commands flag sufficient given that --allow-partial is going 
>>> away?
>>
>> The advantage of --update-refs=<mode> is that it allows for future 
>> extensions such as adding support for partial in a way that does not 
>> add conflicting options.
> 
> That's a good point about extensibility. Elijah suggested --[no-]update- 
> refs
> which is simpler but less extensible.
> 
> Between:
> - --[no-]update-refs (simple, covers current needs)
> - --update-refs=<mode> (extensible for future modes)
> 
> I am inclined toward the simpler --[no-]update-refs for now since we don't
> have concrete plans for other modes. But if you think the extensibility is
> important, I can go with the =<mode> style. What do you think?

If we go with a boolean flag we can always add an optional argument in 
the future so I think that would be fine.

Thanks

Phillip

