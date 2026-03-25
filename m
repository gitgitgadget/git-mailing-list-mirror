Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E93E2740
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453006; cv=none; b=RFncB/W++mMkfnDKKB5Mgp7gwo6KNDxIgW7iVfYDwTibc7JBw2R2d9de33C49vwlgdKVOcUzb3YSuYPpj4S876Z0k6rFAw4lSFPOiFSs8968qwX/BId7IQ4gh4UB9CkLdeBV33hfOOAImnZ/jnkJru98UXAROMuizFtV0R/DF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453006; c=relaxed/simple;
	bh=C0Y1sKdHOXLEqM+55dyfic/acZPvD50I2IadZitpvH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdsFnp5XtXIPZZd36F8IwAzI2MauFb0q3UXe52oGoGen+PCTpzskc8e7+0T483b1sDxRPpjHgglZrBJ141hqcHPJpq5zk31CkHY8TYfu4SI2ylWq7a8LyLAfYh5EFfhxqTc6H9vAtKosTRtyQFltduPB17DP17y7Pmv5+jQEIz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRgsTzy1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRgsTzy1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b06d33e84cso16006535ad.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 08:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453004; x=1775057804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8h2cFUkqHpIYIUl97wngnv+Vs8uXpUBcUmZ22ks737o=;
        b=BRgsTzy1smqam9LM88HVdIok8SUdlcRdzMNPCxSsXoWH3KkxPX1DVeT0PvvAOnc2tS
         OPenhyxws3obHK2mS3aRHdQ5IE31Bp6T/Llr30elxk6e1hk8769tCxcuRjeZbwDV3lWj
         yoIb74oTh6NsiOgUP1bWTx7TlBpPpMULDESxqk3kkNH0kBjEcVgclWktaEmf5NqHE9G8
         HZBrn/6RDygYUnD15cd6tpHCosXaiuPokFko5Df32sGSlA5V3tDHVaCej6+PNaZQTd27
         6rKgrXpZtalcKiKuSieV0ovHk10u4l4fs1gjvn/9vJqmzBG0wqIYMT1Rn8ttMIZPje/t
         YRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453004; x=1775057804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8h2cFUkqHpIYIUl97wngnv+Vs8uXpUBcUmZ22ks737o=;
        b=BwqWdLX95laHGVEyd1uNVjCOxlNpxiL66vQ0NFvUxKQrYihMrxDHiiiMAVaEZFn+Ig
         tAOtChgyYSK1l+ZDD6LplNK3IqwKzJVtzEQ8Jzu0fh1bUddbW2dcuXvDUpYqbQIb8456
         /DBovPst31FIow2/3/3A40Dvnz5xe/itVzc9yM3ihyedRa4BhghH33kkhhwC2Jtwqu16
         ZL6WTM8MaBb4GaT9PHAo1i7OTCQW/E3Y8QlgPiRo6bz2m1af925PUZa3GdlZ2GzXumov
         ZjL7QzmW4ALw+VyU75gIDwh95sNNGtXiBtVEcXwjkSKj82Vouvc1W1Gj1Z+zgFsW9FNA
         81kg==
X-Gm-Message-State: AOJu0YyN8vmZsCv+9HerciufZN9WhH9AOQo1/T2rG0o+kyxOamlNKr2I
	NUBshSkLUGM6kvNZ3Rrj9R/HqbWEIZ42ytu3XE+q0lD/CZPPc/hrx9Zq
X-Gm-Gg: ATEYQzwlHlCpgXc1ivKaOHVYR/5PjXaGtXWYj8+NgD2V2XXXzhuwwUAWC1pYXM76+Yi
	yx9alcp8QlRqvn1+OX50geUN8sX94QVjjNJOZyUS0XdB8hvGg82SS4UAWGXA/RmEjpN4FZlkH1b
	v4xpVo1DmF4Tj0oQSIDJ7h9v/etnCs9G7xWkRORVXZwCnUxqwnBArdHqoQmRR7oDZVfCA1yLOQl
	l+RX7/Z27HxlsZ0F8fuP1Fzxf+lVwTUk45i3kHjhmxMFf8/hFDeRrlpEmi7DA73nm6DjRLfYj6T
	3cE7Du+x/82ebMtbdMBUhWr3loFZpof1yODHS9072pJqpavS+lOrVcnjwzF/nMnWO5MYjhBPeDQ
	DyodKLIIw92EEwHezLo7Q2Mhr/EweWqwROn+2wtWtblEc4oXa0D8P1TnLx34dr2GXxncOB0GJmH
	ZD3IqrqFQD4QY21ZFBhlXQhqfxirnlJN9PLRPVLn646ha38rSQnZlmR3A4oGGIoRB5j2vBBqVoj
	we7l2PW0Ts0EQUOOp98Ei4OSpXXdWLqiqg=
X-Received: by 2002:a17:902:ecc3:b0:2b0:7b57:830f with SMTP id d9443c01a7336-2b0b0ab4738mr38242675ad.33.1774453004132;
        Wed, 25 Mar 2026 08:36:44 -0700 (PDT)
Received: from ?IPV6:2409:40e3:30ab:6862:7ceb:99d5:377f:7f66? ([2409:40e3:30ab:6862:7ceb:99d5:377f:7f66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8ebfb5sm2003275ad.68.2026.03.25.08.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 08:36:43 -0700 (PDT)
Message-ID: <34248fd9-3939-472c-ba27-7ea5346e3d84@gmail.com>
Date: Wed, 25 Mar 2026 21:06:38 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] replay: add --revert mode to reverse commit
 changes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de, toon@iotcl.com
References: <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-3-siddharthasthana31@gmail.com>
 <xmqqh5q4xvyw.fsf@gitster.g>
Content-Language: en-GB
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqqh5q4xvyw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/26 11:59, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index 2cdde830a8..d3c1d920f0 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -83,7 +83,7 @@ int cmd_replay(int argc,
>> ...
>>   	/* Parse ref action mode from command line or config */
>>   	ref_mode = get_ref_action_mode(repo, ref_action);
>>   
>> +	/*
>> +	 * Cherry-pick/rebase need oldest-first ordering so that each
>> +	 * replayed commit can build on its already-replayed parent.
>> +	 * Revert needs newest-first ordering (like git revert) to
>> +	 * reduce conflicts by peeling off changes from the top.
>> +	 */
>> +	int desired_reverse = !opts.revert;
>> +
> 
> Compiler notices -Werror=declaration-after-statement error here.


Ah right, I should have caught that. I have moved the declaration to the 
top of cmd_replay() with other variables and the CI is passing now [1]. 
Will send a v6.

[1] https://gitlab.com/gitlab-org/git/-/pipelines/2406607541

Thanks,
Siddharth

> 
>>   	repo_init_revisions(repo, &revs, prefix);

