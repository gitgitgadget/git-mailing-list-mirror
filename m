Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CAC1DED6A
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180791; cv=none; b=G2CwF3kyjQZDIH74/1LRf30gQ04mNWOz9/rPE/HYeIQM/1H/FFtdbs9uG+VJsYn1MwXv4eLWAnowvy+dD8WRX2H5xbC9KyHy5IBeMUELb2rkARnXoLlqPkC67DayMK/CXjye7MAZmAxDC6PCTHRbmg6z9oBP3SQRSCPAAbnqT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180791; c=relaxed/simple;
	bh=F+I9awyca56SLOBaoMcDUlB3SX5BAn+sLlrCLaZhDt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSyPXnoZElp/5tl0z7Av6W8zPmOmce39za4IJerJqbMJv+/AQMG0W5OiaxMcdOS0DMo1qjWoqYAipFiD3QFyHy4EnQMeya74xglGVxcKmaZy/L0zkjSWotivgqKh/25uvmFtyQuTjSGE0BuUqwDGgK3XJRjZhZoUlEms2ASfUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfdnlwhj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfdnlwhj"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99cc265e0aso146411266b.3
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729180788; x=1729785588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTpmDcma6McfMOxxx3rf9x+JPGktGVD5YMN3GSSuZAs=;
        b=hfdnlwhjZeEDlqtXGgjRX4gucAwhiZeCo9EpQBb7ewV7pntGTSpDPLGaOyunJnxDR8
         cIq8fyY1PDb/0lhdCpWwNEPRncFsYXYrB3v/TrFj+64coU6wMvocROp2CUNzc3bs/6yH
         JSBP5PiSCIgzPS6h7odMVoG6ENnaX0dZiGIw6+giYsKXOUA7SaMkWpoP7FiLBrlzbOX/
         HhRjuSWZ1UqB7deNhTINOwlp+ya5axiHX94PthGtx3vNWgTNPZF5oYmW47iklrCNKbRq
         /+dYJGm2WNERsUIL+X6dGkGqjDgHO6NFqObXIiIaG9U2JZf2tYFpmQE2qWEx0ZzV9FIL
         UfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729180788; x=1729785588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTpmDcma6McfMOxxx3rf9x+JPGktGVD5YMN3GSSuZAs=;
        b=UwPGwxOlN6nrauBjHPZq2WaRTLnZvWLldC0Ef3bZqd7DGlTAxj6Ov0FqrHP0K+nON/
         Kb0YAwbc/6ZEZsGU7yBAowVlIY5sJ4bHmkkATnoChkGb6ZG/1ZjsfIdelPUJaIXCjV/o
         bMV5fkG+xfGIEQmpc+bXQOCvOmY8ZESm7MQXyvc9jo2F1E1m13mqjA7uReGjQlhmsL2d
         DMX0O87hewibnERSuNFKF5tseBC3glgf5Up9t6UiwIspbCBCNtzRCMv6JrT4fPir7ZFd
         yUcqoCwROAPcWL47DlhTAJGiolc+QsE8R/oH8g9WRphya6l3A4CoHSw+hiZkcQGmQkRL
         K7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHwh1RZJpnoUw8Y4wtYt9aAHRn00T+ERca0wqALPtcm6ReYjiNNcNvejlZWy7eGWWkBzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/7y3PVKXJVXFxcjQI3yxd4SSStujlzpQPJI3FM5kMY1pRp/F
	JVFq27brebz41dFQyqK3WnO9gAIrHGExs313Mnm37GDFdZ8K5PdMqFsQLKqb
X-Google-Smtp-Source: AGHT+IFDeFghKkf2VtITfVHqbO33x5u9ChslSfl/sra2Im/ilajEOYqRf3DU9QfLJCTC2a18YQtYzw==
X-Received: by 2002:a17:907:c8a8:b0:a99:4b56:cf76 with SMTP id a640c23a62f3a-a9a34dfea2dmr637268266b.47.1729180788065;
        Thu, 17 Oct 2024 08:59:48 -0700 (PDT)
Received: from [172.30.9.7] ([131.228.32.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29716d5dsm314616666b.15.2024.10.17.08.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 08:59:47 -0700 (PDT)
Message-ID: <a328b6d5-e604-4517-b041-59db19e1f66c@gmail.com>
Date: Thu, 17 Oct 2024 17:59:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
To: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
 David Turner <dturner@twosigma.com>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <ZxAttC1dQUllR76m@nand.local>
 <20241017023735.GB1858436@coredump.intra.peff.net>
 <ZxEr4+sb4DfmtrKv@nand.local>
Content-Language: en-US
From: Piotr Szlazak <piotr.szlazak@gmail.com>
In-Reply-To: <ZxEr4+sb4DfmtrKv@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.10.2024 17:23, Taylor Blau wrote:
> On Wed, Oct 16, 2024 at 10:37:35PM -0400, Jeff King wrote:
>>> I think it would probably make more sense to write this as:
>>>
>>>      data->allow_uor &= ~(ALLOW_ANY_SHA1 ^ (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));

Much better! :-)

>> I think we have to treat them as a complete unit, as we don't know which
>> bits were set by independent config lines and which were OR-ed in by
>> ALLOW_ANY.
>>
>> So this case:
>>
>>> Stepping back a moment, I suppose this is handling the case where a user
>>> writes:
>>>
>>>      [uploadpack]
>>>          allowTipSHA1InWant = true
>>>          allowReachableSHA1InWant = true
>>>          allowAnySHA1InWant = false
>>>
>>> and is surprised when the final "uploadPack.allowAnySHA1InWant" unsets
>>> the previous two options.
> Yeah, I think that you and I are in agreement here.
>
>> is the one that Piotr is thinking about. But what about:
>>
>>    [uploadpack]
>>    allowAnySHA1InWant = true
>>    allowAnySHA1InWant = false
>>
>> Right now that pair is a noop, which is what I'd expect. But after the
>> proposed patch, it quietly enables ALLOW_TIP_SHA1 and
>> ALLOW_REACHABLE_SHA1.

Rather not as config file is parsed only once:

https://github.com/git/git/blob/15030f9556f545b167b1879b877a5d780252dc16/upload-pack.c#L1368

>> So I think the code has to stay the same, but we perhaps should document
>> that "allow any" has the user-visible side effect of enabling/disabling
>> the other two.
> That would be a useful direction, I think. Double checking
> git-config(1), there is in deed no mention of allowAnySHA1InWant
> implying the other two options, which seems like a gap that would be
> good to address.
>
> Piotr: what do you think?

I agree. I completely missed to test it like that (which works OK):

[uploadpack]
         allowTipSHA1InWant = true
         allowReachableSHA1InWant = true

EOF

I was always testing with allowAnySHAInWant either set to 'true' or 
'false'. But always in place.

And having it set to 'false' was disabling my previously set other 
allowXyzInWant options. Which was a surprise, as I was 
considering allowAnySHAInWant as a final level of openness for 
client-side requests[1]. In contradiction to what Taylor expressed here:

> I'm not sure that the current behavior is actually wrong. The final line 
in the example above seems to indicate "do not allow any SHA-1 in the 
'wants'", which would indeed imply that the other two options should be 
set to false as well.

So as suggested I will prepare a patch for documentation, so it will be 
also clear for others. Should it be done using same thread or new one 
should be created?

[1] For example client can request not reachable objects, trees, blobs.

Regards,

Piotr

