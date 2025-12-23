Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEE2877FC
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457588; cv=none; b=WziJTgtrhsZQ5oCF9syfECCeZcrYQaFrSwqfoJgPyZs7XqV4y3jnCbotEDsAF8/eN5dVkDyPj8YF1bb9u6KV560pk/BY4v2Mdna6rpDKfLAwHzSHQmDkzG2hZ8Pkc/pj3l1WqLO/apeyDccntmXK05UuQeF1DeEcsucbn04fMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457588; c=relaxed/simple;
	bh=F/kQNT1BF+OMvkJTZ3pkySHU5AB3PTg9P3al2JaIYhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfdJogSAbAZYPCSlkR2ZU/CKr8b9JxN32h9gVZmbmHOge/CMj57gCAvRQcJ0IwgYyRzPMYliu1HFH3Q6WgBf4JAwChEBowznNfPbtST1DDUgweUcNH08Ew2MgO9kDGL5vkQjbW9ijpLDISP3+/K9zRb4L7LpUc73G/1s+UE1cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNZcIag0; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNZcIag0"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72b495aa81so753487566b.2
        for <git@vger.kernel.org>; Mon, 22 Dec 2025 18:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766457585; x=1767062385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmN+lMh8PgAQ2LhVdxpbmWIe9+DaXf3oOxTHRZ9dHew=;
        b=aNZcIag00sJC2KFAbKtgBTrVNCO228Myu285uPWGqyLOprjjhgdpiS6es4o7QnbTzh
         Lu4Yg3SZ6HLc53Vs3DoLYPN/HMqPt+Q4ix3VAxn4k3E4PZ+w25XhikFNL56qGXpLqMrT
         2LZxKTyonxQXnWlv9xNmcV7391GePK5i8d3tU8wHhvd+griX7qYi1682vv6lTrcCb7p8
         QeK5Kb8Aiv5/feLZZPEZAJOWtN6uoNSZPc3BR0cCCsrsEYOQPpPTcpcUbDs2fSg9bO3z
         9JVsPZedJthMb+7f8OtXLnTfZt6MqiYiCVnqJDwyzXx6H7T9welmZccRR9HlCyA3uyIw
         R8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766457585; x=1767062385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmN+lMh8PgAQ2LhVdxpbmWIe9+DaXf3oOxTHRZ9dHew=;
        b=cckbQeTeyBGjVXthqaaFFS+hCuJb5/c71QiCQkGSDFYyjAanJxFA3DPEc8VUuYCrsj
         PyhiFJAFEUzq4TiRDSPAMOCUhh+w53okpJOBZFca79xhRV+z6PDZFZmGFe9wOa7IDB60
         8sLaXtijaGtN58vEkb9rgb/nSkNNoS/p6HLwJY+AXbebrTpZRneMF96qV2UlljCtbQOB
         Snaq8lpEE9AAEGnQj01tbwOEGHGto2gmI2W97IH/snpeFX8I3s8YgWYHq4dMeXw5fxJs
         1b/Eai8Vm/bkZeg+/MOeZNV5DewAaoOUZcp1sLm5/XKBYGHfVpViVq7Gm9r5MMTa95+2
         ZaLw==
X-Forwarded-Encrypted: i=1; AJvYcCXS6KxBD7wmEbdxYJGN8mlM6zHxTorzQVmJ7oWSiJXtKlM0ER/dKNWmbOvltwldlADJlx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXc+bAvRDo4CQ0ctSfGsye3AiFXJr5aSo4lMsiZOWFNqT5Z32f
	a69fazhwHFXVEFE2Gcru1WZaGROjLxjSGIt03ep8C9XyYNc6NJZQ6qgW
X-Gm-Gg: AY/fxX7eKwxDVJF29jkycvS1g6Q8rsIY6UwN6BpSTbQT7qeXx7T+ZgGmV6kaA5Rls7e
	1uHIC2ue2/0fsaxDSPa8ufjMAY5US8TVGS9WgGvjmK3sCzL66p2GivX4O+MTYay7lEcCjEtHaPG
	uFCR99HHgvW/TmV1pAhnyf4pfH1+eJ/C44tK670/y2o330aml7U1T9EqtDjDklCU+junCSzPaaj
	NXzp8q9o9ohcJJGsW9BrS6jLzYeOaDppiU4FaYDq+RmEg/WVke4F4Dzoh4YejHt82AUSfzOiNvR
	NIHTCB8A+Nxy6DyQcjDFbbwgn4riUN9IRIwwr6HPhZ86AAyobQtm6dGKV6uZ8iC0EXugqRADmdX
	XYH1a5i+oW+ShMs1rouxuvjxAdHmIK/BZ3Tw2TgQ2h/tfARX+BnBDxyx2xamft/ZNf9p6hipcVW
	EZyuy1ml62LG9uH2DQYy1+MwMbBpjHCpw6MA==
X-Google-Smtp-Source: AGHT+IG9jsLuDOfHFRbNK9aGFC3GfZ7CgTGAP4oJ6oUytu/M9zO55z8OpPOY9dAcamqpnEhHwFOxmA==
X-Received: by 2002:a17:907:94cf:b0:b7d:1a23:81a0 with SMTP id a640c23a62f3a-b8037297276mr1186201566b.63.1766457584715;
        Mon, 22 Dec 2025 18:39:44 -0800 (PST)
Received: from [192.168.1.134] ([178.224.218.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab86cesm1256161366b.19.2025.12.22.18.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 18:39:44 -0800 (PST)
Message-ID: <1959d147-1a2d-40b4-9ca6-b85a461d2568@gmail.com>
Date: Tue, 23 Dec 2025 03:39:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkout: add remoteBranchTemplate config for DWIM branch
 names
To: Junio C Hamano <gitster@pobox.com>
Cc: Pasteley Absurda via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2136.git.git.1766332796836.gitgitgadget@gmail.com>
 <xmqqtsxjruwi.fsf@gitster.g> <7246f693-2047-4218-8103-8143e01032f0@gmail.com>
 <xmqqy0muqaut.fsf@gitster.g>
Content-Language: en-US
From: pasteley <ceasebeing@gmail.com>
In-Reply-To: <xmqqy0muqaut.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/12/2025 1:51 AM, Junio C Hamano wrote:
> pasteley <ceasebeing@gmail.com> writes:
> 
>> 1. Server-side policies/hooks that require a namespace on the remote
>>      (e.g. `team/*`, `users/<id>/*`, `release/*`).
>> 2. Hosting / mirroring setups where remote branches live under a fixed
>>      prefix for organizational or access-control reasons.
>> 3. Migrations where the remote branch layout is constrained by the
>>      target system, while local developer workflows assume short names.
>>
>> In these scenarios developers do not create the problem, they inherit it.
> 
> Nobody stops you from interacting with projects like the above, and
> locally name branches you store your work in users/pasteley/topic-1
> instead of topic-1, no?
> 

I would say: forced to handle it this way. And guessing I’m not the only
one struggling. Meanwhile, there’s a simple quality-of-life improvement
that would help avoid all the hacky custom aliases and shell workarounds
for what should be a relatively straightforward remote refspec format
adjustment.
I’d really like to see this discussion move toward practical,
constructive steps, though I’m not sure what it would take to get there.

