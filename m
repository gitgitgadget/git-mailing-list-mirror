Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4A20E023
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548164; cv=none; b=KZt6BuurZ126GF39xJcnfuoKDGsXajz1YzRUezLpendBcA6x9YpKpyKu/G7c8YtA8NjK60ZpF0DklWaWgc4l5TR9ikvBpykrrIH6kNrK7dyWJ+UDFAan7ie94a7FI9JNvi6qECTL8qhkClD5C73EQCmzTne+SR4SruHAvN+LLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548164; c=relaxed/simple;
	bh=hsl0Sw7VAAFP4EYBnBSNmW3nU0/i6TWRP7tVsbGfHgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNdsgd2hCSy7klJ8QwABIpV+M6mrSaO5cFCkbycnlz0m1nGmQ1hFOtaeRCWKVYy68If1iatvRNPX8BT2k4WSc+fgToFJ9W0kckoqpKFpEnWSWGzsh1zZzsV4tDO9eHSmXgMXYBvFcL2GkL0Uy4kGcSGk5rOptoUMwl/FKX4Iz/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVxJk3My; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVxJk3My"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8072bb631daso362802685a.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758548161; x=1759152961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jka+5BuNYmVd+S6mr4k13NNX1oj4sDggzsm9F/WJZM=;
        b=mVxJk3MyssH00KL0nPvZ6qhhW0LQRK36mXLBJIQ6q5KZnuvSzIqwwZ1Qq9qA7+hsbw
         YVl14zOXwEwvhbvXCrjISSbVm1o7S0vpsOAr+UDdIixNdvIes9qbFcpU3A80XDxIvwPx
         dvaogF/Vo/fV/iuwmv3tk4XkFFLmKas5wys8HBDbAXlo1WlI5Py63vkOVmpz+ObU1xmT
         qp3dUQo8cRU7f/FOBoFtDbv4ElXN2TwCfOrrXjUrS81/DFznk7PU9HQhlt9bl35QTNTR
         hY3F8muFrzC7mzB6ufjmXsZZy3zX/OQtf+uX4dRBYQASfsUlBqhIChjivPbN/vQ992rW
         4bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548161; x=1759152961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jka+5BuNYmVd+S6mr4k13NNX1oj4sDggzsm9F/WJZM=;
        b=EWsR8yIS0bJ3eB5rkwz6KB1z9DO8WbgtnOKkI9n7L3lYzurdxAcilh2BbemWg3lrpf
         FIv+JoBm7sWnBM2+hhC2T2Tis/NUm0oHsI47exkm9qS9FA9pZAwzFcEs2pc5r1jZzNh+
         170CaEDAOufnJueFI664F4hHd9uaEVIdHzybNebh1CVUt4vDB32kXE4PhL3DBTEn+dQ2
         Wkki1CVwxeMcPkNwSMqjkZJ126oNbWE7msYdiKW0yD8peZTKWAOY/gp8xHN+5f++Jd74
         zKhVzDm3zNCnoM9T8aJJSKttIePGhWxtww8aXqR9B2Aizt1t329tlrN6qPo2rZVp4p6s
         +7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl2V63mVQrhDXGGL+1T3WR4AqNwKQwgBT9ADrWXEH4mT9M/Z1JkBDGi7rceVPhaq0wMaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1w5RCpiAhi4cpLjrTVRSK4RR5xdOOrIw6xT5sZEGKwY4oDCnJ
	2un7S+lT/xLPOQi1kcQh7alc4bnHY1qd/prPA+uq5aLS0Jmi8W7s5wyc
X-Gm-Gg: ASbGncuLXmkb9bOkcKVgEoDNDZaNCcCvAAx7sWbOXjE7+rzV+LkDiuJj6ukdFEO7CX9
	4rki4xsEurHWQe7jqrY2nlVy9cvcs8ZbTz/1/22/8j/5uqGZpOsrqAemrPUmxl0vfHZT1zwjKlH
	fPFzLLMI3qwrIBAQfZURWUS3wgjYNbfPSeHJh5H7UiBvA7kKFgePfvTQAkUxF1sNzpQra2lxIYR
	5IM6wwt8TxbG/YiilnnzYLysHuElc3bJTbqRbQ/F3FnUGE2TC2ovRbdvGb6Kt2AdQcyv3wUBgIo
	OQ2+kCQUYS5EEZVbJ91VnUZJ6+Y1SeXZsXSn6dguJDKLPNoktjNneVedvjNjIYC/pJ4jd8+2rN/
	dweYPKuxVHwP3y8RpHIo9EfwL4mnB+z/MSm2YPVnCNbQLfy9ACM0Pw+DweFCBAIOc+tcc+uk=
X-Google-Smtp-Source: AGHT+IEZKl2PUSgOs2sFQCq/8wntwlnOCwvGK9iJmbAGzcoyJ2YoqC8wSjd+SgWpWS+Un388ZJ19rA==
X-Received: by 2002:a05:620a:4607:b0:804:4a23:38c1 with SMTP id af79cd13be357-83ba589b884mr1516948685a.36.1758548161385;
        Mon, 22 Sep 2025 06:36:01 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:c3d:251c:41c5:905f? ([2605:a601:a6de:d300:c3d:251c:41c5:905f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-848b1f5b5f6sm219270885a.31.2025.09.22.06.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:36:00 -0700 (PDT)
Message-ID: <ffa61066-7004-48dd-9096-85b305373bc7@gmail.com>
Date: Mon, 22 Sep 2025 09:36:00 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] how to find options set by scalar?
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Matthew Hughes <matthewhughes934@gmail.com>, git@vger.kernel.org
References: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>
 <aMkVqNbdgxqBJ9K4@pks.im>
 <evxbvwwyo4p4iboc4k6r2cd2cvlnm2upgxumqopdijwmvhxhxs@7xvg42heibp3>
 <xmqqikhf7bdf.fsf@gitster.g> <08deb8a8-6c34-4f11-a36b-93d151a56f9b@gmail.com>
 <aNDqnMTJIoHi7Ifc@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aNDqnMTJIoHi7Ifc@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2025 2:20 AM, Patrick Steinhardt wrote:
> On Fri, Sep 19, 2025 at 11:38:50AM -0400, Derrick Stolee wrote:
>> On 9/18/2025 4:29 PM, Junio C Hamano wrote:
>>> Matthew Hughes <matthewhughes934@gmail.com> writes:
>>>
>>>> I was also looking through the list of config options (within
>>>> `set_recommended_config`) and thought it might also be useful to comment why
>>>> each those settings are recommended in the context of working within a large
>>>> repository.
>>>
>>> That would be ultra useful.
>>
>> I think all of these ideas are good ones. Adding the comment as Patrick
>> described is good, for sure.
>>
>> Instead of commenting the _reason_ in code or in the config, it would be
>> good to list the reasons for each recommended config in the Scalar docs
>> so they would be visible in web docs [1] for easy discovery.
>>
>> [1] https://git-scm.com/docs/scalar
>>
>> It seems like Patrick is already 80% of the way to a patch for the
>> comment in the config. I'll see if I can carve out some time next week
>> for the commentary on the config options in the Documentation.
> 
> Agreed, that seems like a good compromise: we note in the config the
> values that were set by scalar(1), but the more verbose justification
> would be part of the docs.
> 
> I'm a bit stretched right now, so if you want to work on this please
> feel free to just pick my patch and iterate on it.

Makes sense. I'll pick up your patch into my series as I prepare it.

Thanks,
-Stolee

