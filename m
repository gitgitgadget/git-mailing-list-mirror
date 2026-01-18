Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3BB23D7F0
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768760835; cv=none; b=eRZxZOCX9Zl53jHRq6ez20MFdubJ0iraXOb/sv2YK5HsS6/wn+IPAu/j/4uWGPkFoXlsHUmUU4iHPVV63PTByJFBeruvqz24pgNO3j2VF1OyC5HrOrNsKx30ygIcHUGlcqp96Qqu/IO+TYsyWqFmgKB4Khq+wTA2Hhto8U4SuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768760835; c=relaxed/simple;
	bh=McA0JMGTfjKYke6PyAGappDTWbp1uRGnNV2BIY8JkRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niNzVr6quza+4eU+e0NJ1dTcVMGRjUbyCUTok8eZvqwUSz6DCkN8Mne70gJtN6oJRoRxgC6FBRN+tvvpbi4W+zfarvr0pywf9pDs3hPCCP4ck5U2RZnB5aa8cWrYJOphQdOl9W20/mIbcDBKoNoRDyFhGYWkhhxuK8Sw2VaD/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcgVzmYr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcgVzmYr"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-502a26e8711so12491901cf.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 10:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768760833; x=1769365633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56/0tYGuYk7w6Mc9CJbO4TVfCeS0Dk82NC6JrRx/dSg=;
        b=kcgVzmYrRE5sGmFzXJ7/JH/9Qql4FJZCV5vqc5gqgMJmdZ+FQarP87XxOe5xaA9sjT
         LdqSjVDEQMe863QEe7E+OkieK302iZUherQQWwPRXe5LaK68A36owg27i2Dv+HvrEInR
         /g93Jbg+SxGbvO4I1SgZ/y0pQocJdT2CK72ippLuTR5GYMYolk3mkvcFAHeIELbqgTxn
         3F24fmyuAQ32I0ZsHFb/71D8LwF2oa8roiPFaUUp158s3+2xTFIkm3fnjQSQzFa0ucf2
         KOrMmLrW6CWayAw1lX5OuM3iG3Vcdqu2LpCiXhvYB8mqlzRFIY09G/UMmkN9qOkIWime
         T+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768760833; x=1769365633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56/0tYGuYk7w6Mc9CJbO4TVfCeS0Dk82NC6JrRx/dSg=;
        b=nbT1izt2RLYF2XO8Ks1mNwYOg4yrR6HeAztJLFIg+2tiVlXBAYyV2zNamLGNkAlL/H
         SXTS93xf+eq6HIZ0KaHYG5u/SC2vzdADjYqcIxn5KPSaKwpSsFGv/2mv9vP7VNoSk8GT
         dcOz3tF7MSdHdps+qEpnPfyFHRNwApUtwIkkDWXnI69R4iueLjSNPoDdrjWZ7TaRWuIk
         wbZRI8iF4Ll04VV0QoE8R/Ph4/OXm0qJyBQMOXUTYB4IeqqC/zqAUYYBRfgZ4/fyXLdO
         4BuLI49ToBiO3SQlYp3GN38+qKlqCD+S0WYnRzQvH/QdvHd63LZJkNut+ZI3uXnzXLIs
         6NkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Bx8X/os1Rbfu8NWAsd0BOFweWPWr4H/zLWZj37zRNTANWcuLq6b0TeBFFc8moZ4WAjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWIMfvvX2Lo+nU6iqcX7R41qDtRkVmHoxuJ8fRcK9SxNLT/E8B
	MDUseIuGSxLY7xtzRdE9te+Rp0Yj4TjsnT7r9VyyhUaQBlb7Akg/DZBI
X-Gm-Gg: AY/fxX61wNaVCs4ODxa22f/72C+Hr/OYQirqm/dRakNDeDNbSCWsUdwg0FLkG5MXmr4
	YCxZBWqgqBMWd+oacVgNwi7SCgumiOHBUFkLN96TI97aliIq+9fZruUZVQQMSTe48VXRLYqyDq1
	a6V5H3mbxgfNWlzbFFAx++U4IIw2fTvnhwkNNmC+7Imlv4HkG04Y9VH6VgiHiFIb71pxdOB94vB
	d88eLZ0P3ClLHUkxUeRv2xKtfPOxmKkvZ3EBEhyiZafyZpHupLGRPxcQqysXO/RbJl/jQcpaDvm
	9llp0uQeq7xxs9ymUqvp+basEakCmcaU1KQMceTln1w2jX/L3rRf9kfzUG4O0Y4yLYkDmPOroF9
	b2pp0uZ7jmbkZqDZZV6A1TSkGhMGTdsbSeIINFR78ZpmhnRvl8p3Sq6O9rsr6bDKxgv2daWV8Lx
	qpYDW1cKK+yk0uxQbdW7gTkKnA0d+EwgFW1Yfe9ATjBnNeKwaaGMsGrCfQMf2rHKL4fIF2ZCgjQ
	A5QAe/Vj+cjMkA27BHqImsB52yU+vCNwQ==
X-Received: by 2002:a05:622a:58b:b0:4f4:d92a:7be9 with SMTP id d75a77b69052e-502a1652581mr169141241cf.16.1768760832912;
        Sun, 18 Jan 2026 10:27:12 -0800 (PST)
Received: from ?IPV6:2605:a601:8119:700:1eb:9803:eb2f:8b98? ([2605:a601:8119:700:1eb:9803:eb2f:8b98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a724a445sm650780885a.26.2026.01.18.10.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 10:27:12 -0800 (PST)
Message-ID: <b46885b1-5781-43d8-8751-d85048c45e5e@gmail.com>
Date: Sun, 18 Jan 2026 13:27:11 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] revision: add --maximal option
To: Johannes Sixt <j6t@kdbg.org>
Cc: gitster@pobox.com, git@vger.kernel.org,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
 <1da38e88-3f61-43df-9c75-5716d715bf80@kdbg.org>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <1da38e88-3f61-43df-9c75-5716d715bf80@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/26 4:05 AM, Johannes Sixt wrote:
> Am 18.01.26 um 03:34 schrieb Derrick Stolee via GitGitGadget:
>> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
>> index 453ec59057..f0d2ab32a9 100644
>> --- a/Documentation/rev-list-options.adoc
>> +++ b/Documentation/rev-list-options.adoc
>> @@ -444,6 +444,10 @@ The following options affect the way the simplification is performed:
>>   	times; if so, a commit is included if it is any of the commits
>>   	given or if it is an ancestor or descendant of one of them.
>>   
>> +`--maximal`::
>> +	Restrict the output commits to be those that are not reachable
>> +	from any other commits in the revision range.
> 
> I had to read this sentence three times to understand what it wants to
> say, and that even though I had a rough idea what it was supposed to
> mean. I tried to come up with a better wording, but found it to be
> really hard.
> 
> 	Restrict output to the commits at the tips of the
> 	revision range.
> 
> is all I could do, but this isn't a lot better, I am afraid.
 > > The option name is too generic IMHO. How about "--starting-point",
> "--topmost-only"?  It's function is somewhat parallel to --boundary, but
> at the positive end of the revision range. Perhaps we can use that as
> inspiration.

My perspective is skewed, because "maximal" is a concrete term in the
world of partially-ordered sets (such as commit history ordered by
reachability across child-to-parent relationships). It's important to
distinguish from "starting points" because the inputs to the command
are a list of starting points, not all of which are maximal within the
set. In fact, if some positive starting points are reachable from the
negative starting points, then they are already excluded.

My familiarity with this term is skewed by my experience working with
such terms, so I'm very open to new names for this option.

Your comparison to --boundary is interesting, because --boundary _adds_
commits to the range by selecting the commits from the negative range
that are reachable from the output commits. --maximal as defined here
_restricts_ to the output of commits in the range. It's interaction with
--boundary is trivial because no boundary commits would be included as
they are necessarily reachable from a maximal commit.

> The option is listed among options that affect the way the
> simplification is performed. But is this true? Isn't it just an option
> that changes what output is produced?

You're right that this is poorly placed. I'll put it in a better location
in v2.

Thanks,
-Stolee

