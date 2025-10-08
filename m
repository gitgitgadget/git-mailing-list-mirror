Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA051C27
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958194; cv=none; b=qYEpfOoJEEpo3gyF68SuWtFj7KOLOOptormiYjx3czTcnAlqHLcJF51k/YVZQ0jBukUefmxY4scZWje37jHnCsDDuctMJRyJck0HE53dpQwXIsCPUqWGWSQL7TkXzcJExKrx7W85jOIZOVHzyqQVX6BMHnsiYMyBk94+9N3sZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958194; c=relaxed/simple;
	bh=voeYgUl/zSb0JIsNx5PkrHalo+8vGQ2TYuEOkqEavQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/3ZxZ/EDTrlYijXqP8y7ZdpgZOs9b2j1huoI9HoT7Qsauh6Yfke1Plq4LXvtTgdlRCM7A/kjObd6ApHh1w+u5ERHPA96RmAdw4bsgMQQTmtOWDpIyVnPtar9YEt1oKsJdkCNxrbHygVPy3Q8GACf4qGim8JfDdYDHGh1wfmlfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4UCsDIn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4UCsDIn"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781251eec51so217326b3a.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759958192; x=1760562992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mkaW2gZS7Qqrc0+Py+t+K+s8lj5svfhbMlg1zHLe+8=;
        b=D4UCsDInMhyophdzn9fAaM7nJVvR/VQyZD502cLzj+3kJvvhnKl1XQPne9UErpvjbl
         v2k7lvuP0XPLwpI4zTkfKvL1DQJM4qWnQ4RKGJDJTik2ECim9M4FV1mHwXWEtp6J0tMx
         6F++1oVISav1vOZhvn4CVhbTWE4Z85wKaD2vDg1h07yrZqx5fbez2nhWJj9EJ0NKaPqo
         AVMIXCVF+/f6X+o6+7182IvvkRoBzJGwCGcyjwMG4L+Zt7+gv93BxYl7FnPhbLq+Nkg9
         CoEUkN4Ozqdt3O9QkrqUIAh92h3SbJ6blWqNIVo0SKT5tybH503wFb7cgsa/liYbtb6h
         rdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958192; x=1760562992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mkaW2gZS7Qqrc0+Py+t+K+s8lj5svfhbMlg1zHLe+8=;
        b=VtoCsqfChBEFiovYXMjIkGOnSn5dD2hokJi13hTTNv/HmHovEdRaqLB4RzytK2eD39
         q15xVR9nALIMjHAccJT7iZ8x3wzpd4EpNuBXLN3jfGCKryXQGsQvyYsz15DOH8FdWCAQ
         3HcslCnk97pKzkwds3k2rOLhrldwM2glfxoeloBO4BL4lc/kwaEyoqA9DUWh/uweTgqd
         IkO4q8A56iXyl04JPLThk3Kcz7rtejjB8FgKywwCKeGZqwY+zwIBhs9TTTfyDnhdjpYZ
         jq+3jxA/Xa2zXj7TKIuZmOHIZN949AGTS8A4Cvmg9DYq7iWxtVIz0Yx7kqNRfW2fnUER
         1Elg==
X-Forwarded-Encrypted: i=1; AJvYcCVynAzL7oxJTo2ArGoFAhaU53XSRnhL7akzKaA4jkSYo87MZXt20HoPLnADThj6BRvN0Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeWXTL1FENK1mOl+W/wFnfSDonwrsLbhR3KYivyGVt+L5yhyY
	qAIt3QNohxfbPFqZzxOQtZfA7JnpbnIyNAR8SckIMZEjRWzXZehay7Vw
X-Gm-Gg: ASbGncvBHnfZYuEjVDqxTS9I02xJjxVAwvv2CEXveeJi4yHScT7DfdIOsiqKDdJj9IL
	KWf9vi3pZnuAiWj5i8+yz/5OxOQZMcFIiePmVtaqJyjyxI5aMmeJeURgjTiQEL36udV11TM3emT
	YrcHss98SxfHbN/3bpXNC65fUqw6Z6MD4gAgKICczDa7EaVFT4Rskea2LGQU+fI/unFdLIkuDu5
	245nmZP8cSpW0jDEJvovVcqQuoNsRgcXC6TYbBgzksEVKR6nbJhR+szlOyOXSAiwPQUfhl7Q2VB
	a6g45Wyzq4vzF53QxK5CqpodMps84aYydIzJ+hGVjYUfSLNl0IDtdfaOwBJytFS1k9R+XexBKBE
	QRzMS7OMDCAtYV4EB9Wb/M5IxZQAF22cZK9NtlE/pyT5BqS9dSLSq4zXR0VunnHgJzePRyQpfu4
	V61CbG2kleqga33S99Jm817GcXuNrKXSC+nxK1y8rQkTI0zsCVoWILKMvMC905q6f1SGpBy2L9z
	f5un2EV9MTjDrI+dW4F2rjtCTjbq5rWXw==
X-Google-Smtp-Source: AGHT+IHPvt9VfGbfDg6uBvexUpX8Nlfs5psSrqOAO5E71FSot8D0yggVutdm8pADoy5aUarDDAm/2g==
X-Received: by 2002:a05:6a20:9187:b0:309:8e28:4e6 with SMTP id adf61e73a8af0-32da8462dcbmr6133528637.54.1759958191888;
        Wed, 08 Oct 2025 14:16:31 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:dc83:454e:4cd8:e34b:b52a? ([2406:7400:56:dc83:454e:4cd8:e34b:b52a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794dbc5a1d8sm682769b3a.39.2025.10.08.14.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 14:16:31 -0700 (PDT)
Message-ID: <5307ed25-b041-4a68-ad75-466f63851b01@gmail.com>
Date: Thu, 9 Oct 2025 02:46:25 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
Content-Language: en-GB
To: Elijah Newren <newren@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, gitster@pobox.com,
 christian.couder@gmail.com, ps@pks.im, code@khaugsbakk.name,
 rybak.a.v@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 toon@iotcl.com, johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
 <9d310bd5-453f-43a4-b477-ba02baa7a664@gmail.com>
 <d9764c7b-8de2-4b54-8c44-a4bd7f5860e8@gmail.com>
 <1bfffc20-7e25-4633-a0b8-6660913a74dd@gmail.com>
 <CABPp-BHyKM9hVvTiPx=n9HzO7Mf9oHrJvWcvVi+HxxMXWqMekA@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CABPp-BHyKM9hVvTiPx=n9HzO7Mf9oHrJvWcvVi+HxxMXWqMekA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/10/25 02:29, Elijah Newren wrote:
> On Wed, Oct 8, 2025 at 1:09 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>> On 08/10/25 19:31, Phillip Wood wrote:
>>> Hi Siddharth
>>>
>>> On 02/10/2025 23:20, Siddharth Asthana wrote:
>>>> On 30/09/25 15:35, Phillip Wood wrote:
>>>>> On 27/09/2025 00:08, Siddharth Asthana wrote:
>>>>>> The git replay command currently outputs update commands that must be
>>>>>> piped to git update-ref --stdin to actually update references:
>>>> The actual advantages of the new default aren't about atomicity (that
>>>> already exists), but rather:
>>>> - Eliminating the pipeline for the common case
>>>> - Better ergonomics for users who just want refs updated
>>>> - Simpler server-side automation
>>>>
>>>> I will rewrite the commit message to accurately reflect this. Elijah
>>>> provided a good suggested structure that captures the real trade-offs
>>>> without false claims.
>>> That's great. I agree that having replay update the refs itself is a
>>> useful improvement.
>>>
>>>>>> +--allow-partial::
>>>>>> +    Allow some ref updates to succeed even if others fail. By
>>>>>> default,
>>>>>> +    ref updates are atomic (all succeed or all fail). With this
>>>>>> option,
>>>>>> +    failed updates are reported as warnings rather than causing
>>>>>> the entire
>>>>>> +    command to fail. The command exits with code 0 only if all
>>>>>> updates
>>>>>> +    succeed; any failures result in exit code 1. Cannot be used with
>>>>>> +    `--output-commands`.
>>>>> Rather than having two incompatible options perhaps we could have a
>>>>> single "--update-refs=(yes|print|allow-partial-updates)" argument. I
>>>>> think the name "--allow-partial" is rather ambiguous as it does not
>>>>> say what it is allowing to be partial.
>>>> After thinking about this and Elijah's feedback, I am leaning toward
>>>> dropping --allow-partial entirely since I don't have a concrete use case
>>>> for it. That simplifies things to just: default atomic updates vs
>>>> --output-commands for the traditional pipeline.
>>>>
>>>> Would you still prefer a --update-refs=<mode> style, or is the simpler
>>>> --output-commands flag sufficient given that --allow-partial is going
>>>> away?
>>> The advantage of --update-refs=<mode> is that it allows for future
>>> extensions such as adding support for partial in a way that does not
>>> add conflicting options.
>>
>> That's a good point about extensibility. Elijah suggested
>> --[no-]update-refs
>> which is simpler but less extensible.
>>
>> Between:
>> - --[no-]update-refs (simple, covers current needs)
>> - --update-refs=<mode> (extensible for future modes)
>>
>> I am inclined toward the simpler --[no-]update-refs for now since we don't
>> have concrete plans for other modes. But if you think the extensibility is
>> important, I can go with the =<mode> style. What do you think?
> I like Phillip's suggestion more than my own.


Got it. I will go with --update-refs=<mode> then:
- --update-refs=yes (or just --update-refs as shorthand): atomic updates
- --update-refs=print: output commands
- (future) --update-refs=allow-partial or other modes

This keeps the design extensible without adding conflicting options later.

For the config, I will use replay.updateRefs with string values matching 
the
command line modes. That keeps them consistent.

