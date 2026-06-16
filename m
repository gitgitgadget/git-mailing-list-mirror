Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E872C0261
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634409; cv=none; b=pU0ejwUP+MsyUGVYRuCsfcc0Zf9tvwJJo1SJb/AnLgsAuNh1l7al+eQ6tLa4lifP8tfoFo6XwbnbLmns4uZxxAQ+u+Dfxo+xIbX8Wp7TRPoixedMeFTcLXuT1+woZHa3lj3ZK7wI9PeTB3dXEtvrXQdEsQzvULKW/FHrXNGJp9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634409; c=relaxed/simple;
	bh=SnSGkVJL5g/Lb2QjAfx+Yl5SFZ1dMittEZnE7lZStmA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hZyCAG8SxqlEbqbN8htKHbctgi5agHmpjxzPa18ELePX9yX9j8SC6sG7lOuYi76Ky9Ybs/inIg/Ky2oyklNi4VHLf9rfrB+wx7an7fh7RMEtWi+1pdrae8zjZd6IhWrPi9avyf91VbjZiK9O6fzsx/04p27PJVutn9EQzUa+Saw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ql0Ttl3M; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ql0Ttl3M"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490ac357c55so46455635e9.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634406; x=1782239206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCADqLnwvhNoHk0mM6YGVmgwXHOhric86g+h+axLLpI=;
        b=ql0Ttl3M4Xc5KUaK/uB3TNRKwa+5wjfJYBPFCjsbBfAEsnCWyUq9TDkggFS/d8cBUW
         GFseCVzPeTB6dtf2hCgPEvMwvv9qZatRKnKvtEWwxt3wpc1wlaJ2o+LGXUPymbjVev+W
         baidYdkBgvuQ4uG4nfl2/g59VO2NoKafZYLkxpgtBSbSTQgAqJXrSJHd1ZrnxyALSqwm
         Tp7e5BkYHHZR1hJH3B+6ae96Ng5OP7apnWkn/SO4AITcorVilyqUOvXAl/SrxQp/2HYd
         vlazHbzNsgxzWUYR9r00H5dY8ylRRqIGxBrV1/HhMU6hhGP1xiqKtXmFy6Woy0V+BVd/
         zSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634406; x=1782239206;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCADqLnwvhNoHk0mM6YGVmgwXHOhric86g+h+axLLpI=;
        b=aTbTXtgMFKA7UATDHvtQ0bsPrEcbpgDDyprJRvv3HsGRoNk3++ARZ/E5HED2LGJEEU
         REy78tnx5zVl6f2oCclcqaF9E/vCCURe13PVksTTxij4Kv7Lwre0n3s5kHvh+mLf4WvQ
         h4aFQO5Q5sleiXjhp9j1/mNQTZPlM82HnYn30iiHscGFi4BvVHfOdJ8EWfWnF4hxlH87
         bWqqN/7zQxKTuVu6U1V18sRhOi0vF/9Dg4Jo35hdCPF33oDp3TWMSc4E8c0KYCBzsCEM
         n8pzY0pHSDNXrVg28QpBiNohgJXgGYKIj02IamymKdYHEzbXsXoCaKU0Awo0AgAl6pS0
         Rx0A==
X-Gm-Message-State: AOJu0Yz51/OaGEsmVBFVujVoTZ87NNqbyk07osiNcQrF6j6j+PAOph36
	Fc9/qDbUHf32xAEUS41U4Js1ZnW8JufCkQWl+Dy2gPFr33tpDcjjVt38
X-Gm-Gg: Acq92OG/0yRJutJgzayS/MZJ9Jcu9F7VyfOtXjUDKEjnlditjbiEZMmgk9g/k1wXxRE
	yT692cuu5Iya/2cwAtjM6gcqVD4i8FL7IGIr6eh73ZuvJWGWNFAUnI85MtWcFyjpK51UZUK5h7v
	5X+r7GhZb49r6KQDFCWmfq4/3CZ/U1c2ZPL8Kxk+4lkZ4457+zgheMRf3MszVmhiS7F6SwnANyB
	mS6I9KQJOCcyMB1ydmUueIht3pvrZnyvFeYknAE3fx3lMkRzGK4w4/LY2lfyVjkfCvZQuYXafUv
	MGEiRKJyj7XhtLclulhMtQoiT1s73pnbQMIX/SXStdH7U6JdSWBJiQJhWybmyOmS1dci7nzYRLB
	HK8UC5eB238hx4hu8EzkSn2uwD96F97jDRwySk4Zw8oiEHSCgv2u7L5173j48snHaiK+yGp407m
	0MdDz92hFGGw7OpR5UXEy4PNUtWisCFeKg0s8MybdLLpJoOk8bjDuE9glQW1ekAVBADibI8xSzL
	JVaBw==
X-Received: by 2002:a05:600d:84ca:20b0:492:3071:1db7 with SMTP id 5b1f17b1804b1-492333d8b49mr8339145e9.28.1781634405570;
        Tue, 16 Jun 2026 11:26:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923343c925sm4756735e9.0.2026.06.16.11.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 11:26:44 -0700 (PDT)
Message-ID: <204a4160-f913-4121-8eee-1f42103afca1@gmail.com>
Date: Tue, 16 Jun 2026 19:26:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC Patch v5 2/4] rev-parse: use append_formatted_path() for
 path formatting
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com,
 gitster@pobox.com, phillip.wood@dunelm.org.uk, sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com, a3205153416@gmail.com
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-3-jayatheerthkulkarni2005@gmail.com>
 <0077b1ae-3c85-4b34-a0ac-766395157c4f@gmail.com>
 <CA+rGoLfhhRNrSReeJ1grhy+2K3BSrikTCNgGpCaGqc4fFp3Lfg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+rGoLfhhRNrSReeJ1grhy+2K3BSrikTCNgGpCaGqc4fFp3Lfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/06/2026 18:04, K Jayatheerth wrote:
> Hi Phillip,
> Thanks for taking a look!
> 
>> On 16/06/2026 05:49, K Jayatheerth wrote:
>>> The path-formatting logic in builtin/rev-parse.c is tightly coupled
>>> to that command and writes directly to stdout, making it impossible
>>> for other builtins to reuse.
>>>
>>> Extract the core algorithm into append_formatted_path() in path.c
>>> and expose a path_format enum in path.h so that any builtin can
>>> format paths consistently without duplicating logic.
>>
>> Sorry I haven't had time to look at this series recently, it is looking
>> much nicer now that we have a single enum. It would be helpful to
>> explain why we need PATH_FORMAT_DEFAULT that acts exactly like
>> PATH_FORMAT_UNMODIFIED. Looking at the next patch it seems this is still
>> a wart in the api due to rev-parse wanting needing to distinguish the
>> unmodified case from the default case.
> t);
>>> +
>>>    # ifdef USE_THE_REPOSITORY_VARIABLE
>>>    #  include "strbuf.h"
>>>    #  include "repository.h"
>>
> 
> 
>>>    int cmd_rev_parse(int argc,
>>> @@ -717,7 +661,7 @@ int cmd_rev_parse(int argc,
>>>        const char *name = NULL;
>>>        struct strbuf buf = STRBUF_INIT;
>>>        int seen_end_of_options = 0;
>>> -     enum format_type format = FORMAT_DEFAULT;
>>> +     enum path_format arg_path_format = PATH_FORMAT_DEFAULT;
>>
>> This is the source of the api wart I referred to in the previous patch.
>> Could we keep the existing enums and convert them into the appropriate
>> PATH_FORMAT_* flag in print_path() above? I think we already have the
>> logic to do that in the existing code. That would mean that other users
>> of append_formatted_path() don't have to worry about the extra flag.
>>
> 
> That is a much more elegant solution than the current one.
> 
> For v6, I will clean this up by keeping the fallback logic
> localized within builtin/rev-parse.c and removing
> PATH_FORMAT_DEFAULT entirely from enum path_format in path.h.
> 
> Instead, I'll re-introduce a small local enum (e.g., enum
> rev_parse_format) inside rev-parse.c to handle the
> command-line parsing state (tracking whether the user
> explicitly provided a flag or if we are still in a
> neutral/default state).

I think it is probably simplest to keep the existing enums and modify 
print_path() to convert them to the appropriate PATH_FORMAT_*. That way 
we can keep the option parsing code as is.

Thanks

Phillip

> As you said, most of the logic is already present. In
> print_path(), we will check that local tracking enum. If it’s
> set to the local default, we can map it directly to the
> path-specific def_format before invoking append_formatted_path().
> This ensures other users of the function don't have to worry
> about the extra flag.
> 
> I will send out the v6 series with these fixes shortly.
> 
> Regards,
> - K Jayatheerth

