Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A1F13FD72
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401280; cv=none; b=cHhi4SAqam45N2v3uEmlWlqZenMMbq0mKCeePy7K8JxvEQn92cVMqQZDqNphcCJKwfKYYxATe/E+8BkVmdHIePYbg2Ay7+URgCgfqTZiqENDqGC/t39axMMBxHUcYJS8DIzjafGLYvQcFLZq3i6QwXks27j+6FJhTc7LwZ4gzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401280; c=relaxed/simple;
	bh=gkY9bGIUtoAGmkYS5ij7/pMRZaZ6TD5q+DWAWowZB8Q=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pZ1tsYK8+rJMh9n1N+stfsnvS2/O5TLxeJCxK9Jp2xUwHayuuG/djOoOL2wz0Exmb2XZirtMNxoZhrNISlPKEqcF10tHqrtUYQnE+lOBXKfMgIf3hT4bOZvVP214IEDZ+FOP4apDTWmVdEqaAWrUY7INKYdVGqVrRYTkpplGG18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/H2GdsU; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/H2GdsU"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-202146e93f6so16978685ad.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 01:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724401278; x=1725006078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mCQAzXJmLufCkVqbnTRwerEmUhezUvvWwvsZezfVirs=;
        b=Q/H2GdsUXn+HeYU27y9ll162r1YH540ay/V/k2h3vC5pNfjPxE7f36Oy4rCb3Tusb6
         DsU8CySNYtZk7AMvB0+ux+QfwqT/Gw6KPY5oFcCLtLiq49ZjlDJLq8KW3txNaoTaGYY6
         T0gD6oANgChyMKd/COW0ec/8RtcZVTRQvaDQTmJG+T0UMKBFCgfPYhekSvPxTcScwkGn
         TYKsGH92ga9uFnkXOw5qgMELXrMRtpHlHe1jrVR9rCpzLBgEB8iM+lFMe37ORDZpkoYQ
         SZTmPY2H4uS7JMPmO0TUF4oBC2YcIY71+jdxFjlflv8aQnaSZKqKL6hzE8s7Kq39Pp9d
         PIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724401278; x=1725006078;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCQAzXJmLufCkVqbnTRwerEmUhezUvvWwvsZezfVirs=;
        b=fSTLm3casCIAUxfbsnEfr6RC81UNwvzOXq999EXYE+EWEzLogAgzCxD/8cZPV5IieO
         uPGTFFcCg6GSKwWdjSTf+qJkCF8GfEsAyjj0Eo0rLa+qOA/WmNMDriTm8eUzwg2wgeQW
         XI3LhY2/awnvs3vk5fEATphJowxjgRXp6G3UOYTOgUQqXOBfO4SR8QoVIsmv8ljCJ44+
         G2Os9rarbIaUdcWhWFohYo4Qc89+XIfjhu/oDUnZPwb3O6Y0fks2/SsdycRy16MN3TJA
         w8vLjrwG13nx/Dpb5Ei1RpqJ26He/3jolLvZ2oDNS9DLYE3aV2NcQ6+35Bmv8gtgLPlL
         IShA==
X-Gm-Message-State: AOJu0YxSUybblden29HvRqYlKKajAOEXJkJ87eyOGSnpTDBZ4rylRzo2
	XoHM3h2cdPOAfuUBvMAPneRZz0czXjFCH0Vlhlvkand9633p0t7nXLERtwxTvOU=
X-Google-Smtp-Source: AGHT+IEiJR9n/yPww4AzwKVk5DjubqSZ7IQmRjFStZroh2q3PEG0eX4YvCO9ZSm0Yjbr8EASEKnTEg==
X-Received: by 2002:a17:903:22c5:b0:202:2ead:f948 with SMTP id d9443c01a7336-2039e44f6dcmr14475325ad.3.1724401277954;
        Fri, 23 Aug 2024 01:21:17 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609775sm23673535ad.198.2024.08.23.01.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:21:17 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <6c9f666e-12ad-4b67-a44a-3111686454f3@gmail.com>
Date: Fri, 23 Aug 2024 16:21:15 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: replace 3 dash with correct 2 dash in git-config(1)
Content-Language: en-GB-large
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20240822172042.54065-1-CoelacanthusHex@gmail.com>
 <Zsgh4LacdOt8N69o@tanuki>
In-Reply-To: <Zsgh4LacdOt8N69o@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2024-08-23 13:45, Patrick Steinhardt wrote:
> On Fri, Aug 23, 2024 at 01:20:41AM +0800, Celeste Liu wrote:
>> Commit 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
>> introduced this typo.
> 
> We typically do not word the commit message as a continuation of the
> subject. The subject often becomes invisible in many contexts, so it is
> helpful if it can be read standalone while providing all of the context
> necessary. So mentioning what is wrong would be welcome here.
> 
>> Fixes: 4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06)
> 
> We do not use Fixes tags in the Git project.
> 
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>> ---
>>  Documentation/git-config.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index 65c645d461..79360328aa 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -130,7 +130,7 @@ OPTIONS
>>  --all::
>>  	With `get`, return all values for a multi-valued key.
>>  
>> ----regexp::
>> +--regexp::
>>  	With `get`, interpret the name as a regular expression. Regular
>>  	expression matching is currently case-sensitive and done against a
>>  	canonicalized version of the key in which section and variable names
> 
> This looks obviously correct to me.
> 
> There's one more thing I noticed: the synopsis for `git config get` says
> `--regrexp=<regexp>`, which is clearly wrong. As you're already at it,
> would you mind including a second patch that corrects this?

I couldn't find this typo. Did I miss something? If something missed, please 
tell me. I will include it in v3.
v2 has been sent.

> 
> Thanks!
> 
> Patrick
