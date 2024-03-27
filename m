Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627721C28F
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536930; cv=none; b=F7t0tMfatzEfY9kuRLheC2Ylh6SvcjtcdMGWX9MM9AwCTNE/3iCK1rYAnJMRloj1ritpwGmyPXPnxmhKyM6iPZC0rr82BCzWjepyLTl4+YhzJyZG0LCkD8a+GmBF/kmYl2iaV1tTE3awO6Vr6Qy2BxGHCzTwarzVclIu2d0B1Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536930; c=relaxed/simple;
	bh=tWj+4B7vdk80nYwNqA7z7P0NSiBn+gyNkOvUMwQDEcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CguQLslBvsj+lW5rBwNxljP7Q634RLZU+3ZYf/+DSTZFDc5/F5lr/pA+hhRs0F8PnA3uehUsYNUkUzMqiC/tMGuv4B3IBdIQsIB7f2DqMMtVBr6393bu0nWxEs2j5fx+DH6ZsIjUziLW1rvHpP0FUuNU6MFBDOn1nYt+iqL5fc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeIqYwor; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeIqYwor"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41495d16568so1715095e9.1
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711536928; x=1712141728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GM0ux2L9aC3JHolipoLwwaHJMzXRDx15tc0CKO+Itgk=;
        b=EeIqYwor2yXcIoTQW5VHgrdPVEdO4TfF+YrjGN/cd050wbxSGne2s8T3q3wiNVKbGZ
         ef0L0SDv8LyH/y2xhcC7C7PHEq4Sbt1O83upqgmDtgVYF1g2vS24qAHgMCQ1w71x1HNN
         948MpUegFbr90c9wQMdutXLyOKjktyOzh88zYHUOoiTKWEcGMkj/UmTGVdXzXdiCh5Le
         qffWhRJRTTUoX1OUfZF1ws0z0+UoEVQJRwbUtcSRfdMv29mR/qR5nq7mOXxihQJyAsA5
         NuiB9oFkOiPNbl9UbVhcX79BYMRXJ7740vWjiJemD1/lkJZ/L5r9MlgqOPuo7gFeUUir
         Kr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711536928; x=1712141728;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GM0ux2L9aC3JHolipoLwwaHJMzXRDx15tc0CKO+Itgk=;
        b=ioDa3j5V4CxKV1zUXW5v17yFbGLZhdYQblHrC1tUI8uA5jD1JJxhhtvCyMt6AfsgsI
         86OQ0uKX7sVYyooJrLkGsa/p5kT6IQsgqEPzROJiWemIz+mVInmTxznuRL98RXY4+hVC
         HtFHjxZVH2o1SVl9K6c0Rn4KrhogqF0imt9Yuf1ncTzwxKA2Cgmi6ZJFRXCgw/xS+rsp
         W3FvjPkhUzyolWDVhrESevr9oVhTCJJ8K8uIQH9HtfOz4fMAF7+tfaWlr5AJQkGzBQEA
         pvZOTzyeY2oXDFJPvXQU4QnJ3GxHUZHqIOlmi3OE4eYzXe/yLOuy2mXa4vUPLwlqhseu
         bIlg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Y9ZmDHIzZ3vbRXkJIdUMuohDf2BSAaiWjde3E9c1S1l5tgEVR7qzRHFaVsC/ZIIqDV6GsMp0VEWqbjNBZYAIQXLR
X-Gm-Message-State: AOJu0YyS8p3eAMlawbmc/zgqBhCj1y3wx3WzTgsGlbdlhOMlDARRZYbs
	1kpHSx1PQ9f0qLflV3ntneMbwO0jMugTQtrfZdPTxS+dBSTR+MYw65APqRlr
X-Google-Smtp-Source: AGHT+IGor0g5lyQd1dE30WBpOLQr6QhYVAv6MS5S39U1QvjzT87hZdoRZ8MxWPdSKJssQtMM+kj/vg==
X-Received: by 2002:a7b:cb14:0:b0:414:80c0:d352 with SMTP id u20-20020a7bcb14000000b0041480c0d352mr810270wmj.23.1711536927557;
        Wed, 27 Mar 2024 03:55:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:d2c6:37ff:fef6:7b1? ([2a0a:ef40:68c:c401:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id he3-20020a05600c540300b0041477d83499sm1765955wmb.16.2024.03.27.03.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:55:27 -0700 (PDT)
Message-ID: <65f41d5a-b645-4123-a214-0e785c64cdb4@gmail.com>
Date: Wed, 27 Mar 2024 10:55:26 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] add-patch: introduce 'p' in interactive-patch
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
 <34e027d3-c351-431b-97de-e15a2d5a9756@gmail.com>
 <13a9164b-6ff8-43d1-bbdd-032cd2581034@gmail.com>
 <e54ebc35-6946-4e63-a54f-fd73df0e89bc@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <e54ebc35-6946-4e63-a54f-fd73df0e89bc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 26/03/2024 18:40, Rubén Justo wrote:
> On Tue, Mar 26, 2024 at 02:38:02PM +0000, Phillip Wood wrote:
> 
>>> Let's introduce a new option to allow the user to explicitly request
>>> the printing.
>>
>> I wonder if we want to hide this option unless we've skipped rendering the
>> hunk in the same way that we hide other options that are not relevant to the
>> hunk being displayed.
> 
> You've got me scratching my head.  Do you see any cases where we
> shouldn't offer the new option?

If we've printed the hunk followed by the prompt then there is no point 
in offering 'p' because it does not do anything useful for the user. It 
is only useful offer to show the hunk again when we've printed an error 
message that separates the prompt from the hunk. I don't think we should 
make 'p' an error, but it seems like clutter to put it in the prompt 
when it does not offer anything useful to the user.

>> I also wonder if 'r' for "re-display" would better
>> convey the intent of this keybinding.
> 
> I'm more inclined towards the 'p' because the verb is 'print'.  Does
> this reasoning make sense to you?

I'm not sure I follow as "re-display" or for that matter "reprint" are 
also verbs. The reason I suggested "re-display" is that it I think the 
name is a more accurate description because we're printing the same hunk 
again.

>>
>>> diff --git a/add-patch.c b/add-patch.c
>>> index 68f525b35c..444fd75b2a 100644
>>> --- a/add-patch.c
>>> +++ b/add-patch.c
>>> @@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
>>>       "/ - search for a hunk matching the given regex\n"
>>>       "s - split the current hunk into smaller hunks\n"
>>>       "e - manually edit the current hunk\n"
>>> +   "p - print again the current hunk\n"
>>
>> I think "print the hunk again" is clearer
> 
> The word 'current' is in my proposal because IMHO it adds value making
> explicit what we're offering.  Maybe "print the current hunk again"?
> What do you think?

I've no objecting to "current"

Best Wishes

Phillip

