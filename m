Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122E2AE90
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 22:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443664; cv=none; b=UjlrH2ZGus1uo/0bayhrV4/NaoTD8GXlB1kARxNK0kE/MA8XHlgQeK0wsmAT0lcI4Y3qnCUrBPrDD5cNNbMsrv6samy0vgpXi5gIKddZkfkhFG6ZPCHRHw19vI+aWjT0APBW/RPKtQWGhUOayndL64BglkqaiOGYrTX+TdFF3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443664; c=relaxed/simple;
	bh=n/XV5lTBgHK8SXe2O5HOvqG4oXjbqLbtU+4WdrrCvvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oN7x4REW7Yv4ovUgTFusCxEuZT0dca64Cl60MDaJfp72b3SBVeUVJa+WxRwAygDS0mV+d8FWCnbnFF1On/uUydOokDv19uvLESQq58Oy89ItBftlxdRX3hw6L97u4h0UJ/xCXMPzsiJqMioWM9vXdO8c4nlEsWRV/e8Ci/k57F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX5fgcEh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX5fgcEh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f5d497692so2259757b3a.1
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 15:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759443661; x=1760048461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5Hv3kcEzOl3frmmJfxXhZYmxzJRSBzHEG594Ns3ND8=;
        b=nX5fgcEhHKnL6wto1tiqNJahoBi+e2vgF/gjllEhZIrh4DvPeiRJ+IvuR2JRgeL3ir
         Gq6oOHjk1bP4u//ZrVbNCqxuRZgtakhsU7+6s/fpfkFh9oNAW0sG4pTo10QWwM/1YJsx
         izUiK7UTUiwjp6hqCtrKLp/GjLBc9arE/A3I30uJIHU8kAFtZQVELerz68IHJV/Q9AJx
         Nh49TZA6Hfih2QmE7PKyQh4ZjGquCwWK0A1rIHAHMhl7F5gHyW5qbkc3rNrO0c7SIKix
         cyfQyBT6w0cRj531UKDP7EhNQXSMW7udR4sBmvMEf4jbCp44qgeux9JHjEIcLiaRvd8S
         4BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759443661; x=1760048461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5Hv3kcEzOl3frmmJfxXhZYmxzJRSBzHEG594Ns3ND8=;
        b=V10ABRS1zuBnO7jySQrmeDKUX1Dfq/u0NsgtcFy6LcbP0T4KXvYufN0lsiXXuSU//V
         sAtMCF9BX0LT89oKccoHTAPjjPYAmL8QIRi1ch9LSM/bX5cD9v+staXy4rKxFVBdJRlB
         M/9r0lhXs2SIEEs4Sp1AYDcSNEi9AuQ39o/6sEoVAraAnWc5eaFGrjIRMo0yJLTwECS0
         FnUo3zo2rHCgS+Xkb3FSNiu1B3d/PJsNT2neUBolODMU4mZ7Duqrb+L7DCuN4TJnQ9vU
         1X4Mrg7i3hSiOGTVdvFUQO9baS9PB9h0n7EOpOsw2TULI6RHoOydU0QNVisZV+BaPdqm
         1S4w==
X-Forwarded-Encrypted: i=1; AJvYcCW/m1nfvpIrg66yIIAWhXJw+ZQut2dZy4M+9lrJt7WsulMP/O1DoLJJXHxj5qSCP5OWgn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2QxpzY+KfUY1Ea0FUbHYrpEjv5jZOqUJEcuPpMnMc09pU0aU
	YItRDiGfWlvX1gE20Ws+pLoNweDK9JWxJlOIEoDvGtufPJo8IxDwFq1O
X-Gm-Gg: ASbGncttw4NwsOJxBe5Yt2lTGx0bonNyVco0V9GYSnInOEtUXyqm6svIa7iLb7C3s6S
	OpbZ1eebe3Ov0X5DGrMhUdU4lbMP2QOCArFrMPlzosUN8AZz5R4rs510khGaDK3VlzoHam/s81x
	JzDGVhG7bIi9GgAp9AQL4S2gOHuZoCPzAc+seqZN62ziiOwUtC2DeQAJkuuEyRPIfjTHO8CzPFs
	808jpmuXSwu1l/aoE8YinzOXpJKZUTm5/6328TVTT3rSTJAxWLg3SSgMAwYAE531434mtXEFSBc
	M654uLkbiHkLBWXkptCjwi38+g/ai2afFQKQsRqyQzyFtPMhwVxUOT3fBvWEN/fXEsCYGlMvhjk
	MUcNufAr/migF4xBTfrgJXpNigI0/UhzEq0XPfrwZwDKwfV5h33w71AMu6H9Ye3ExYQkviOSjn7
	1yneuTgg7NyEiQ23XJpOddXJ5nJrcRFCSDpgg+iIiAV+SXD+QCEyrlSoGVsT2zRGeS6e0CtQ==
X-Google-Smtp-Source: AGHT+IGqO9BKlQtMwMgkOtMzqOM5Axwzj0GU/WDzc3gjKHdQd2mwfar1tf1UgLTOizfRjWadQAGwEw==
X-Received: by 2002:a05:6a20:12c5:b0:249:c68f:7ac6 with SMTP id adf61e73a8af0-32b61e59404mr1314068637.20.1759443661414;
        Thu, 02 Oct 2025 15:21:01 -0700 (PDT)
Received: from [192.168.0.100] ([49.207.235.198])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099afa5fdsm2827576a12.15.2025.10.02.15.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 15:21:00 -0700 (PDT)
Message-ID: <64b63d62-482d-42b2-8090-60aac8f505d4@gmail.com>
Date: Fri, 3 Oct 2025 03:50:55 +0530
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
To: Karthik Nayak <karthik.188@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <9052eccc-1121-442f-ad51-4fe9217024a0@gmail.com>
 <CAOLa=ZQjMzCiVd8tRXtJJ8yXxLgwGQDgOZW3F86h9jC71NJm5w@mail.gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <CAOLa=ZQjMzCiVd8tRXtJJ8yXxLgwGQDgOZW3F86h9jC71NJm5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 02/10/25 15:30, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Hi Siddharth
>>
>> On 27/09/2025 00:08, Siddharth Asthana wrote:
>>> The git replay command currently outputs update commands that must be
>>> piped to git update-ref --stdin to actually update references:
>>>
>>>       git replay --onto main topic1..topic2 | git update-ref --stdin
>>>
>>> This design has significant limitations for server-side operations. The
>>> two-command pipeline creates coordination complexity, provides no atomic
>>> transaction guarantees by default
>> Are you sure that's true? Maybe I'm missing something but my reading of
>> builtin/update-ref.c is that it when "--stdin" is given it starts a ref
>> transaction, reads the commands from stdin and applies them to that
>> transaction and then commits the transaction which will make the updates
>> atomic.
>>
> You're right. Using '--stdin' is atomic by default. You can manually
> handle the transaction's by passing in the 'start', 'prepare', 'commit',
> 'abort' sub-commands in the '--stdin' mode.


Thanks for confirming this Karthik. I will correct the commit message to
accurately represent what update-ref --stdin provides.


>
> [snip]
