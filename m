Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5661B218B
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001166; cv=none; b=CJ+yW1f7eACKau4VUMthORnp5jFTqV1mogWuNBOhha5wD2+dZkojQfR5mzUgLNj20vOwp1zh7EEJ/yCSsw/jHRrPlqChjJrWkA2kcNOPzLb/883WQZxe6NCt+jm+rTx3pgoTzBbd5MJjZqvQUb5gbaSd2ok9AO0DjfuR9jy8GMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001166; c=relaxed/simple;
	bh=PmMEG+kc0qKogNTh0GIs55lUfMzV4wOhZMmAjnF59q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbwTeoeN2qN0UJ3txUxK3H9fC9eVhulICSnZ57pD6EK13FHXgmBf4ksyBwT3xmTQ1Gd9INzlW1cEDt07ALBJq2eBs98VgsJzJ9k7Hpfgig5yy7sTHYqtACbYLGoThujhDvOimf0NridVVY2/CqvejpjI/ULBSQS/rriS+FAs1DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7IjWDxg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7IjWDxg"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so2940385e87.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001162; x=1729605962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IyJ0IQThsImZg4py7t/N3H1cX0yYwrvqKOTBP2kQhTM=;
        b=C7IjWDxgTzLueN0qK5hSxOImL9zFGmOL5EUC941/QkbgqG9QZOCvLBAhV7P3LSpjeI
         pA3Kld1E6e2KyKXrKZ08j+GTWjVyXroSw2zCKr3ASBh/edUIsPL17EAyVaQfKR4FKMj9
         RR4vPJmbaMgGit17lizgURIrK6PCobXh4PhOCI5bQT31zHzvh75pKPnGgJ4e6Nfr6ZLY
         l3hWefOaH0P8WDeJG9RarO2m+xZquNBMmUZCt85KPMReFGrhcpiEq318xgUJVdMHrMUw
         hewgqi+TH4EpXUvwD5yepsUbcNE3plj6Td0uoC9udVSdfsGZpG+klvHhdbKJzvH9SIxW
         hTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001162; x=1729605962;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyJ0IQThsImZg4py7t/N3H1cX0yYwrvqKOTBP2kQhTM=;
        b=bebTKATJ5OQjfRG2ttJv3Mm88URZMgCUgbITCJptOzCN/by2YUxSIZklloEv3d28Vh
         r+djxcdc1YCI0yiBNWHcmYiXRHebrerwSsVbXkPNxmIbnTctIwmxiFjfLhCUMQ21IXv3
         FCY3IbIKvV/QgVS8dDU4XpRtQv+ihfUpGIQ9Rp3AblhIlL19Tn7WXkxpiPOa6Womw5vo
         RmkSZPudDTll62yBTIhUoMBxmfGMRHBcjXbzppN0aB8k+SbcIebGC44xbVuBU4ZMdsah
         h8XGti8g9zdYjqigYRi3Dr7JO9GXRojRdwFx4cugLNxgvtPyWeq2AUj1NoNhsZevUjHC
         F8TA==
X-Forwarded-Encrypted: i=1; AJvYcCUexUBq2DmWGpj2DBS2/rdl2CbOaSpRX5w3W8g0uj6N6wbzI83vE4kXuYYKR133p4GsYwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/2iofMhChQah5hXieL5Pvsie+s0zbUctofM5qmGGtrIaSBxo
	rReCWfouBAbBQSBkEz16sMvfJGGV4kvADDsfxS8KzVo8PdI+htrdRnkUcA==
X-Google-Smtp-Source: AGHT+IGXIvpFs2UzrU6KClixBhk2ngG/c9wFDQ79KGda714+eRVOFzCGrXLRpPfnr6AdVOUoHPz1hw==
X-Received: by 2002:a05:6512:39cd:b0:539:ffb5:8d2c with SMTP id 2adb3069b0e04-53a03f2da23mr361235e87.30.1729001162157;
        Tue, 15 Oct 2024 07:06:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa90547sm1663201f8f.49.2024.10.15.07.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:06:01 -0700 (PDT)
Message-ID: <a7cb48e5-d8ba-44c1-9dbe-d1e8f8a63e3c@gmail.com>
Date: Tue, 15 Oct 2024 15:05:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 1/6] refs: atomically record overwritten ref in
 update_symref
To: Bence Ferdinandy <bence@ferdinandy.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241012230428.3259229-1-bence@ferdinandy.com>
 <3c848f10-ac14-4cd7-8fbe-868da9599244@gmail.com>
 <D4UZTVHXXL1X.2KBQI9FYTAU72@ferdinandy.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <D4UZTVHXXL1X.2KBQI9FYTAU72@ferdinandy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bence

On 13/10/2024 22:24, Bence Ferdinandy wrote:
> 
> On Sun Oct 13, 2024 at 15:52, Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 13/10/2024 00:03, Bence Ferdinandy wrote:
>>> Record the value after the
>>> ref has been locked if the caller of refs_update_symref requests it via
>>> a new variable in the function call.
>>
>> To me this patch and patch 5 feel quite disruptive to all the existing
>> callers which don't need this specialized functionality. I think it
>> would be less disruptive over all if you used a ref transaction rather
>> than calling refs_update_symref() in the final patch. That would enable
>> us to keep the simpler interface for refs_update_symref().
> 
> The extra parameter introduced here is actually used in two places by the end
> of the series, in remote set-head and fetch (of course you could make a similar
> argument for the functionality added in 5/6 which is only used in fetch by the
> final patch). To avoid code duplication I think even if we did not touch
> refs_update_symref() it would make sense to create
> a "refs_update_symref_extended()" and make refs_update_symref() a wrapper
> around that with a few less parameters. That would be similar to how
> refs_update_symref() and refs_update_ref() predetermine a couple of parameters
> to say transaction_update().
> 
> Currently there are 15 calls to refs_update_symref() in total, of these
> 5 do not use the complete functionality of the function (they pass NULL as
> logmsg), so the current implementation would not be completely unprecedented.

As those figures show it's pretty unusual not to pass a reflog message 
when updating a ref, on the other hand it is very unusual to want the 
old value so I don't think the two are comparable. At a high level the 
two callers that want to be able to check the old value are both doing 
essentially the same thing so can we create a specialized function that 
encapsulates the functionality needed by --set-head and uses a ref 
transaction?

> (This tally did make me catch an error on my side: the logmsg in fetch's
> set_head should be "fetch" not "remote set-head", I'll fix that in a v8).
> 
> Imho, even if I manage to come up with a better name than
> "refs_update_symref_extended()" wouldn't it be more confusing to have two ways
> to update symrefs via a function call, rather than have one, where _usually_
> you pass two NULL-s at the end?
> 
>>
>> I'm also not sure about the proposed interface I would have thought it
>> would be simpler to take a "char**" rather than an "struct strbuf*" if
>> we do decide that it is useful for callers of refs_update_symref() to
>> query the old value.
> 
> refs_read_symbolic_ref requires a strbuf, so one would need to be created
> anyway and I also sort of got the feeling that the project likes to handle refs
> in strbufs (which may be wrong). Are there any downsides I'm not seeing?

It's true that refs_read_symbolic_ref takes and strbuf. I'd argue that's 
a mistake for a function that is just returning a string in an "out" 
parameter as I think it is more continent for the caller not to have to 
initialize an strbuf just to retrieve the target of a symbolic ref. I 
alse think that it is inconsistent with functions like 
refs_resolve_refdup() that return a string.

Best Wishes

Phillip
