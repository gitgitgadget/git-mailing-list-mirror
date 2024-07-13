Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C9E1311A1
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720876789; cv=none; b=puZyWly4SNeEUAF2tE8zK+NzLPQ2BI3VJYNUNCW88DRSBTE9ysudArF0iMs+6baOFIr08RThn1vsiC2zq3aP5uGxJqGWRcG0vY8Tsel72Qr5XSJ0MlvqXpb+UE7VP1mJdLyyHMi5MnqKSnBskOfOJFyBCQok20+pcq6L8biC9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720876789; c=relaxed/simple;
	bh=McymfI9AIShWOwmLm7N3LHAWcEhFgWac1OTcQdjmcVo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KT977kFABYQ0zgJuExZXOk/MX9Rw//YXAnqLh6qbHbvplUG+dmMQk+7nFySZJAHBCOUPoIDbktTyIH8s4IKVAApVsgOn1E6rB+PEXIMVdeMoPm9IAnoo3hUsA2kylHQfUhsqqg945ha4AHhRo/3x45g5dw7D3WjA/HZWivSzku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMfDQN87; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMfDQN87"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42660b8dd27so18938575e9.3
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720876786; x=1721481586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMg9TQzkNlJFCtNJE1/evvlQKRlk/C/KWP+8N/whKNk=;
        b=RMfDQN87uJEC61PY1eA2PkkA8alCz2SsE7LHuqQsiFoF+de9LraYQeGI5eqFMfl4eQ
         rWNTE7F9h6pBUQuWrdnlQ9bPBk5sYUSh6Lki81zoXWhLWRM5nm7Ef35SWp7b7wL1NuC0
         MGsQS+SPDL81/MKEInpD5DdbiLyzwwURuyqvKVQ65XZwCUfvQKrF7s3D70VBCQZOBLJB
         rbQVikOPOjOZvIvcDkx3CTYSbAHRwtDk6KXRjTLzIDOnkuR4vVffjI5d5OQFntxRw7rB
         NEOvoKuFI9Ue2ojDTmIsY8xQb4Lv1hSat+7dneT1a5UV8Xva5KAycckH/Aek0hTfGuIq
         fnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720876786; x=1721481586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMg9TQzkNlJFCtNJE1/evvlQKRlk/C/KWP+8N/whKNk=;
        b=LOLFeUCd4OAnmMUyODJC/+W7LDK8FBhprM9jPVIr7iXfwtyunAsYmQP95KtvfIlV3r
         dAxfFsmvwmnIQW+EnW0rXyS8AkgkaocAiQ1romaTAYU3tyuaATpE6zWe+FJsS2VasTie
         UvRGYbwJveSqySCxkpOVPgQO6AugjonFaWldTJjXztajukCVuPrcdZ678/lrg9O1DQDX
         qdG5aWdj5GQZyAaPBrwrsUVcyFPotzuFqEsH6zhcygwhRt27Kz079IUiBFasdOb7ugaj
         hVmmWbAbhU70aPEvq5D4l5tqu2zreXDDGsqjSsDT198J63PUGo7K+ZdTru8fuPHue4Eq
         TNLA==
X-Forwarded-Encrypted: i=1; AJvYcCWIyoAYdVB0yBe7/XVd6EWtfYqz7JjnUh+mIkJc3iKy2OQbWcfxLTDhHZkmHMWuzwzAZpfHhh3wm+bQELyaWLwwJ+8b
X-Gm-Message-State: AOJu0Yw1cB1xG1mut8m0SNDh4psjKS1eeE8lf1sWWeenm0gRAZoLr6l6
	6WYvc260jpRnNwqEjD0sEuHruc5g6Lk5oXtByw+mE37oiAYVsVNN
X-Google-Smtp-Source: AGHT+IEkK7JlJFeG6M92ih9zP44W4cEAgnnEX6ew06AMoK6k/XNEbCipz7H+rEWfnnWVXIBIxbpu1Q==
X-Received: by 2002:a05:600c:6dc5:b0:426:5b84:86d2 with SMTP id 5b1f17b1804b1-426707e32a0mr94054905e9.20.1720876785975;
        Sat, 13 Jul 2024 06:19:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25a962sm54537245e9.12.2024.07.13.06.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 06:19:45 -0700 (PDT)
Message-ID: <622849f1-de52-4b92-9465-931014c8d3eb@gmail.com>
Date: Sat, 13 Jul 2024 14:19:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC/PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, Ilya Tumaykin <itumaykin@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
 <ab974e62-098c-4200-bee3-7de8d9115516@gmail.com> <xmqq4j937pyf.fsf@gitster.g>
 <20240710093610.GA2076910@coredump.intra.peff.net>
 <d5d27cad-bacb-4a79-bb50-e65d2bb6808b@gmail.com>
 <20240711212628.GA3648684@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20240711212628.GA3648684@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 11/07/2024 22:26, Jeff King wrote:
> On Wed, Jul 10, 2024 at 02:46:30PM +0100, Phillip Wood wrote:
 >
>> I think your patch looks good. I did wonder if we wanted to fix this
>> by normalizing context lines instead as shown in the diff below. That
>> might make it less likely to miss adding "|| '\n'" in future code that
>> is looking for a context line but I don't have a strong preference
>> either way.
> 
> Yeah, I had a similar thought, but it got messy because we have to deal
> with the source buffer. But the extra "char ch" you added in the patch
> below fixes that. I think the result is better.
> 
> Looking at the blank-line handling in recount_edited_hunk(), we also
> handle a CRLF empty line there. Should we do so here, too? If so, then
> it would just be a matter of touching normalize_marker() in your patch.
> 
> Do you want to just re-send your patch with a commit message to replace
> mine? (Feel free to steal the non-wrong parts of my message ;) ).

Thanks, I'll do that

Best Wishes

Phillip

>> ---- >8 ----
>> diff --git a/add-patch.c b/add-patch.c
>> index d8ea05ff108..795aa772b7a 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -400,6 +400,12 @@ static void complete_file(char marker, struct hunk *hunk)
>>   		hunk->splittable_into++;
>>   }
>> +/* Empty context lines may omit the leading ' ' */
>> +static int normalize_marker(char marker)
>> +{
>> +	return marker == '\n' ? ' ' : marker;
>> +}
>> +
>>   static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
> 
> Minor nit: missing blank line between functions.
> 
> -Peff
