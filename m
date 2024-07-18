Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6D3A1B0
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296115; cv=none; b=AlYbmnpVC2nsWwmXbjTX52mPJ4rZvowSj26KadA4CSbjedJWu7Pd35eUdtXmF18OsmcfdhRe5rPSxdZ4Do3ITpYG7D7alkZitqX4F6mqN1UcGhuIvxn8iuh0q75VVkzZnAXb27f1GJJBc9YJvbyjh8VRoj0A1nhWW0MJx0Gwx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296115; c=relaxed/simple;
	bh=7QcApWarojXP1TfI34+VB0bnI9eFs8eqj3tterqmXyE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aFmdn0F3qn2VNGaFpWw1Da6z7454t2j1Dljeg00XC4odZpAzrDQnz+9VTpZYy7PDb0VFZqChYA/PAaZTRjkCqVgLOZygojaFAUW6hIFcn6WlvRfv2gXQt2sOktN7IRTVatjk2Jy6v2ULKKYZ3JC9UQM4jRtCZpgFPXH6kec7cEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS+LGN49; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS+LGN49"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee9b098bd5so8796821fa.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721296112; x=1721900912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9eQSEu9/72Gcu6H9ZKPi2ojHt6C6sPz7XZBP05LVAo=;
        b=NS+LGN49l2J5122A0C8mP59Bt5urQUvFupsgZmAYzbPLl5ejhw01u48/QHlAITBnu3
         FBRbY0JJoUxQhPqgcVIUQjJhABYK0VXWyuZIntFxuxp1bU6c1rjKAYx3jxaeNVXpzbWa
         wzZOHzXhAMttjIu920cZkyJctbG3/O8exIPiuOk9tyAAGwrFH78waLwwPVwwbROcn5p3
         PfLYMLDUoU1tEjhWKe7j+bxyHwAcbz9s6BjnVo7irN/tRGv3pqVlBpIclQlKLz1+xL/C
         7+nVdAGYdLdn6F1gmpiLJ1g51B2M6n6FakdmyDG/hQIowCnXrEmzfJOKTUsaFgRxl4D0
         5Wpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296112; x=1721900912;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9eQSEu9/72Gcu6H9ZKPi2ojHt6C6sPz7XZBP05LVAo=;
        b=D9x9Y9hpDrgTiSGCs3naWf0a1buQckZ6RIZeMDv0E+W+OUUEIbXyQs7RSoqe4p3DHy
         3sbcLeL87KPulGKPzE1dgzHlpuWW+d1uD6mVEzqjBj6J3Vw60wbDeDJPZGy99sLwpmXM
         6bVmaCHtf4I1nJaUJOsJ63VoTrYJmCLprZeCrm+RqytfAE+UYMSW3wO6w09JxC5sFASt
         q6pKdg4JAFRdjwOS2bq1WNt254ZkVFzGzhdDkVgg7We/YsRGS0nbfpAKA0JzpYcCOAZc
         0bgcCseM03gNbvBK77//K2FKGy7XXA9NdOe3WHRmlAGxPuf2KwVMocgp/jPVDjqNmHAE
         jWzg==
X-Forwarded-Encrypted: i=1; AJvYcCVR89l7dBS3shPzzB7Q1ojMshXmbW3/zsDLHk6DFy/8Foxx7pzsQQU1wvC50OZ6c0iVS28YMTYXc5BWDq8DG0vM6JMu
X-Gm-Message-State: AOJu0YwafcMYX5NBlx1KYJR//OipbnSSAOXw6bOIN5/EyE0t6kdpwYwG
	5MvWA4h8OAH9sFjv1kmAeMSFutv3delyfyJbet+49Pdx1es3/GQ6
X-Google-Smtp-Source: AGHT+IHFZ/nm2zzftI0iMaPc9HDVUjB6mjdC5UOs2NjvGBHtWhA5p3HNXLYmdOGrwa+uQpoknlbFJg==
X-Received: by 2002:a05:651c:2111:b0:2ec:4f01:2c0f with SMTP id 38308e7fff4ca-2ef05c9d73bmr17097291fa.26.1721296109758;
        Thu, 18 Jul 2024 02:48:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b1e288sm4298485e9.24.2024.07.18.02.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:48:29 -0700 (PDT)
Message-ID: <e2532dee-5d16-484e-ba13-840af7b47c27@gmail.com>
Date: Thu, 18 Jul 2024 10:48:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
 <88f9256e-04ba-4799-8048-406863054106@gmail.com> <xmqqfrs723bp.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqfrs723bp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 21:03, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>>> -	test_write_lines P q | GIT_PAGER="head -n 1" test_terminal git add -p
>>> +	test_write_lines P q |
>>> +	(
>>> +		GIT_PAGER="head -n 1" &&
>>> +		export GIT_PAGER &&
>>> +		test_terminal git add -p >actual
>>> +	)
>>
>> That's surprising, why does running git in a sub-shell stop it from
>> segfaulting?
> 
> Yeah, it indeed is curious.
> 
> The rewrite resolves another iffy point in the original---you are
> not supposed to attempt a one-shot assignment to the environment
> variable when you are running a shell function, as that is not
> portable.  And the above rewrite is a common way to fix that.

Good point, I'd not thought of that.

Best Wishes

Phillip
