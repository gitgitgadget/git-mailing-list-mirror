Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328581D6188
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301210; cv=none; b=DMSSFZ8YuQFRkVhgeb7S43UqBfI83GCJdLYjUDJiiJBG3ALcSNT7AweQSNHvdkA0Iup4WK7nv0EMtFE+/ke91ApStbe+h8rm+0Efw50UgWzLS46IqYBV5uQ6TzwMo89wEw6vtkE8f6ZptJ83ZvCP+woqByi0JkmdHM2BZziF4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301210; c=relaxed/simple;
	bh=Mw+3jdAm5HxPSmkjpVHhj0RPeolJZ/bI1VfWd+ecr2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdRvxDiPFMhuDDE8vIqVWxU/LIn5qOWPiIK7K5TrLJQoSxEK0/MshCMe8j3uURle7dqZbAg2l8kiy4jgPW3nqASddvzBFcZK5ocvJ9RCFER/S3bvKYtGmDyYDcrSV5qzAAOaCoYmIKdyklDSUrMBBZRmSQg84g6Ulq7mufVq4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKby1utL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKby1utL"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3cbe70a7923so1154374f8f.2
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756301207; x=1756906007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gsqDnKZ2E1Nra9UJ1pYzTlp6Uj2/Vrj0UEdyN0Ds2L0=;
        b=WKby1utLFxh3Qjy18tw83GHRbEK5zuO64iemXE5+zZQxYriAPQbOHlha1O9adMKMdU
         t+d8ifAcls0c3o/djIf2etU+SzLZd9dwA3fM4g/UP/ztksWOUGGxxsHuTlYZF03cMNhR
         wx7n0vDAS6JRzZeVANM9znQjxuvn23IHIhEsP/MBXDCDH7Qm5sCPjHPaCVGuJ8J9/VLt
         lAL9H8+u9lAdh3C0nE7obMBUOqisqlnoy9a0SQyg0fUUvN8BfMP2YWP6GSSotRa1uW8m
         Bx+lVjCn9bvwmWZAUaQazTV5Mk10Qyjp6lq0/S4kQx/JS7WL5wvZYNISey29chLPo3zm
         Jfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301207; x=1756906007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gsqDnKZ2E1Nra9UJ1pYzTlp6Uj2/Vrj0UEdyN0Ds2L0=;
        b=BluuuA4FyrzxNMZoVhn9gGO0NYo/dxswigcRnchoWpCmSdSAd8k/G2gIG2zLGAef/3
         Hhz+2S806xghjwxrmHTBFYZVBWgLpom2oKA9lSTzejGbmJ3vbO23Tl6atRUrFd9E1WRy
         FcM55gSBknxWDN9ie7hr+/SA93/uov5+tSk/GwWv6rgql+0/+bWYY7BgG2BS5Egnxo3s
         PPbm3g6SV/8yVlIa507K9Qe3INlkZfRgSW7aCMO4yzl4b1OeMH6C0j/MQKwb7k7GaL2U
         htg6w94yecBsSYxmC98+AyRMfEC4086Pl2AkPxhvk1hg0yjKp+drbzWoaN1+1hVmEEqD
         ueOw==
X-Forwarded-Encrypted: i=1; AJvYcCX5wo9uW5re8grG7Yg7G8K4oAxUmXRbv0T3F8C1e+/dHA9rAmBkmK1T/8dEvhc+N7bF0Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPT/YvFg3/aJqwdJHCvUXwFA9+EcrBARwF5jEatA0sBtrUoLQr
	HDIRpdpOMZWshpV96SID35ZGNSorzLJU7Fr34uqbK+zfIuEuwDRmhFv9
X-Gm-Gg: ASbGncuofz/5BUzH46ZCZLq0B0AsRUb0ic9qchwOt2GMSrbW+XX0YApPL3AO3aPXH04
	sACs1rABRpPvKfMqm1lHVUs5k1ud7SSn3Ez+L8cn9xXfzyfn8JY06QfTKqNoFxY15BQ7WQS4s8v
	xT3/gaz4yW91caeE3CS7bLW1O035j+UuloJNSebMCjgBpTNENyoflK2Jrv3CDSgDQfmc2ijXdvu
	osbjgg0UtiPIiR9hYE0bygP72VACprDMiDwvSNt3j2cC6ENAlnUsyv5JCVB2X4qjS2MBm31MGsG
	TyRi+qTYCqmcf+VrCUpmRmmXj0WbtJnx0Ai5DkDjHhA5m6pdGi9vQ69ECN1roOLXq+F04zGcNnP
	7RBiNNiCbubSl2taPYW6m/r4FizKbMgYtGF+p30Aoi0Z+IIJPh8SunyQNlQ9a//dLn+KcL1FXMe
	ms7w==
X-Google-Smtp-Source: AGHT+IHQ3t9/5uz3GghoaH8PH3th61Ln9FsgTxVfk6xBtbh9XwTJYsEg69v0Z7WYBBNuqvYF9Dd0Hg==
X-Received: by 2002:a05:6000:2404:b0:3b7:9dc1:74a9 with SMTP id ffacd0b85a97d-3c5dd2d7ea7mr17143146f8f.42.1756301206756;
        Wed, 27 Aug 2025 06:26:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cce17246c8sm2345902f8f.30.2025.08.27.06.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 06:26:46 -0700 (PDT)
Message-ID: <cf89ccda-442f-4b98-b30d-93f708e64133@gmail.com>
Date: Wed, 27 Aug 2025 14:26:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rename default branch from 'master' to 'main' in refs and
 test scripts
To: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc: Wing Huang via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Wing Huang <huangsen365@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>
References: <pull.1961.git.1756183921623.gitgitgadget@gmail.com>
 <0a574b62-273e-4519-855f-66c554cd93c7@gmail.com>
 <20250826111234.GA1925107@coredump.intra.peff.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250826111234.GA1925107@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 26/08/2025 12:12, Jeff King wrote:
> On Tue, Aug 26, 2025 at 10:58:55AM +0100, Phillip Wood wrote:
> 
>>>        * remote.c: Update fallback branch name for remote operations
>>
>> I think we want to keep the fallback to "master" but check for "main" first.
>> Otherwise we'll stop finding the default branch where the remote is still
>> using master.
> 
> I'm not sure we need to change anything there. Modern Git will generally
> report the name of the branch pointed to by HEAD back to the client
> (using either a symref capability in protocol v0 or the symref extension
> to the ls-refs list in v2). So the fallback would be needed only for
> very old servers, in which case "master" is probably a better guess.
> 
> IIRC, there are cases where v0 does not report the HEAD value when it
> points to an unborn branch (and while I'd expect most Git servers to
> always support v2 these days, sometimes the protocol upgrade fails due
> to things like ssh blocking the GIT_PROTOCOL variable). But I don't
> think that would affect the fallback code:

Thanks for clarifying that

Phillip

>>> @@ -2379,7 +2379,7 @@ struct ref *guess_remote_head(const struct ref *head,
>>>    			return copy_ref(r);
>>>    		/* Fall back to the hard-coded historical default */
>>> -		r = find_ref_by_name(refs, "refs/heads/master");
>>> +		r = find_ref_by_name(refs, "refs/heads/main");
>>>    		if (r && oideq(&r->old_oid, &head->old_oid))
>>>    			return copy_ref(r);
> 
> since it is only about looking for the matching branch name, and not the
> unborn case.
> 
> If we truly have an unborn HEAD on a very old server (with no protocol
> support), I think we just end up without checking anything out, which
> means HEAD would default to whatever the local client default is.

I just tried cloning a repository with an unborn head and the clone >
> -Peff
> 

