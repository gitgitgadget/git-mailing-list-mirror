Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC71F1518
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957812; cv=none; b=j1/jbBwnCQoOwQsvOtGJV2jtKkQbcubK3CMrvjS5tbcY+ih3yMmBxDYHTZUHcz5e0l2+LIBVAfylTzEVV5UpD0qYtRnhG7APlK5Nb8k0uYNyOSGsbEhJgQ6Vt7fQKiZ3RjK5FVYbMu7uvlK60pPV5avZMY62kUeKCwNXke0csz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957812; c=relaxed/simple;
	bh=m9BwbE4vzRgqpf4VUmOdjbUtHgyEMhhpERZaWadbO4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQzQu5EcNfBJkVWeMZWVb0qFS0F7fa+oUYwZkHVHIQ7YQn58db0jc2U6s/7LwEnhEHIe4CHDWV73limiYwarKQM5eFfPiIjNNz5sct7US9Uw66l8Bzss8UYBkctufxmaJbAREEIZAenIKLTl+uxUsvxwmksMx+GgZLnCw6ugCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+HvehZ8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+HvehZ8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781206cce18so361432b3a.0
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759957810; x=1760562610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PNPTgy41meMwx4YwQpgqTHbg4XHGmUj1l+bJiVnOo8=;
        b=b+HvehZ8iYvOLO8jZKsBzmwPAfiIB9WVHohBw4cbkhZe3wLTxR/T4R05yAFxvFb3ZZ
         V6ST53xRfcEKOUg2OxewS+HxFR5oddjgkjgYj4Np0ASjgUdMxoalNSs8QEMwoaTWBtb0
         SCZUPsT+9loonaP7ZQY8i4KGyLVURkGJFJatb7Nw/x/FKu85ueAIPye0Fmcbf7P1II8G
         Aj11OYRvsPyWfElBBeLhqRTi5tzUPjy+LXgsAm7qR+kV+z0sex+HpR+NkFLRHJjDz+Qa
         R8PaN2MsN24BJAZDDlLIHsXF5JjSCbJvyMdgkJRcV9rWK7uhBSe+KVydNFJEIXsjBz7h
         5acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759957810; x=1760562610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PNPTgy41meMwx4YwQpgqTHbg4XHGmUj1l+bJiVnOo8=;
        b=lhN2NuvVNPmQCIX1jbqIpPUiD71798kAP/pneAVqKZbswcBG2aYiL+MUdaUxrnH2Er
         MBy4W3U2oc+08kyPvCqxe81pOfE0+OVbxWl57Qb/MQghcapi1nSfoeHHRT2p3/eW6h7g
         HeIyOYSU/LmCpadDIRBnKPUD2Ik1lLp9o/Z/Xyo7+4dDxDXJoGnNiIXiUxJ5Ig6l0dM0
         Ei4stYMbuR613xnYXMi37PS/qiz7BawO9FgfJlgWbacJXTJtI1xfb4FxZiyRsc/8LGpx
         8u0L3XaAkpDRLxWODncqiZ4ZWPOJyeNBMwf3qe6ByBr/9T/DVLEBCVYEb+w0+PCyMYeP
         m2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVX9K9dy1jjzTHIFR+mH28GlngGfZEnuIgWHfvRbaWBqZnrLhwE7qQeRwsXX6iJbSsxk9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GcWF2jQwytp5EmTsB4OqUmZTeUG/0TxeNYBOcMDG3AO99kvV
	kjUS8u3S4jrf8ecXm0mmtYNDrJkRNrrvkOFpHw/Pg7Byv/Iudkw0G0gR
X-Gm-Gg: ASbGncu5C5qWCF+oZV3NIzM+tJlmHuZhpxpk0gPqVs5znjs553GpHVdcX6bv08xEw++
	uEsk4iKI1UjwdKCSOmy5HR7yjvkRlYkHuJbfkvmx6ohqtmeJLUhZhBM9OTUYoiynwqfPj+ZOeWT
	NiEPCsDoSg/o9/uWxOCPD3LDry1SPht2QoAcAJvwGBKUNucsa+o6U4KxUiWu/LQs51cIPUUZ1Pd
	oMPo6tFuB+wVT1TKS1za215Ca2O5O/USknivMvDIXKT6CGqCptE1aNkYk1WLE2RsB6tKrfkjC5F
	4zzq2pElPFp+pX3Q66OqDZb7hHmTVES87LW+D/S/OqY0dnGbjD9R/oUlSf9L2uairb3DRkU5U0J
	UNHU6z6mK+uYUErXblle7mdKEwey6h3nRlDHW7LBvEyGK3IQBIgEISDy2zecf7EvD1C2P7uooU1
	yVMt/fIcVzNPe1weX7L3iHWS8TXvh5ftxTbBUJ2+kdm1+crgsgePTKP+Utklge5NgUEURsNyTT5
	lD0ORgguUkuImzi1YlCLz0UvAfRDHkulA==
X-Google-Smtp-Source: AGHT+IEE9WSaw8a4tWT0jBJJOkNljEAiFHxiuZSdOxapiVxZb7poADjPV6mjK7rtzb8xEJ71JL2EbA==
X-Received: by 2002:a05:6a20:3c8f:b0:248:86a1:a242 with SMTP id adf61e73a8af0-32da8df1bccmr5643183637.4.1759957810434;
        Wed, 08 Oct 2025 14:10:10 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:dc83:454e:4cd8:e34b:b52a? ([2406:7400:56:dc83:454e:4cd8:e34b:b52a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d510f54fsm686337b3a.28.2025.10.08.14.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 14:10:09 -0700 (PDT)
Message-ID: <ca63e3a7-6b39-4e34-9ebb-a817971737b1@gmail.com>
Date: Thu, 9 Oct 2025 02:40:04 +0530
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
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
 christian.couder@gmail.com, ps@pks.im, code@khaugsbakk.name,
 rybak.a.v@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 toon@iotcl.com, johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20250926230838.35870-2-siddharthasthana31@gmail.com>
 <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
 <0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
 <CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
 <xmqqh5wfu3o6.fsf@gitster.g> <ea7aa170-400c-47fa-b3f0-2623fcbfcaea@gmail.com>
 <xmqq4is9f6tv.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq4is9f6tv.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 09/10/25 02:29, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> On 04/10/25 02:02, Junio C Hamano wrote:
>>> Elijah Newren <newren@gmail.com> writes:
>>>
>>>>> For naming, I am thinking either:
>>>>>      - replay.updateRefs (boolean: true = update, false = output-commands)
>>>>>      - replay.defaultOutput (string: "update" | "commands")
>>>>>
>>>>> The boolean feels simpler, but the string might be more extensible if we
>>>>> add other output modes later. Which pattern feels more consistent with
>>>>> existing Git config conventions? Looking at rebase.* they're mostly
>>>>> boolean toggles, but am I missing a better example to follow?
>>>> replay.updateRefs sounds better to me.  defaultOutput with "update"
>>>> doesn't make sense to me.
>>> Yup.  Or "replay.defaultAction = (update-ref | show-comamnds)" if we
>>> anticipate that we might have a third option someday.  That would of
>>> course affect the choice of the command line option.
>>
>> That's interesting. Between:
>> - replay.updateRefs (boolean)
>> - replay.defaultAction (enum string)
>>
>> The enum is more extensible, but do we actually anticipate other modes?
>> Elijah's --format idea from Kristoffer might be a third mode eventually,
>> but that seems far off.
> What do you exactly mean "far off"?  If it won't happen in 2 weeks,
> but it is likely to come in 2 years, then making sure we have smooth
> upgrade paths is still valuable.  Once you start with "do we update
> refs?" boolean, how would you later accomodate the third option?


You are right - I wasn't thinking about the upgrade path properly.

Looking at Kristoffer's post-rewrite hook use case --format support seems
likely within a reasonable timeframe. And you are absolutely right that
starting with a boolean creates an awkward situation: we would end up with
replay.updateRefs (boolean) plus replay.outputFormat (string) or something
similarly messy.

The enum approach is cleaner:

   replay.defaultAction = update-refs | show-commands | format

This keeps one config variable handling all output modes. When --format
gets added, it's just another value, not a new config.


For the command line, I'm thinking --update-refs=<mode> makes the most
sense. It's specific enough to be clear but general enough to handle the
three modes. The slight inconsistency with the config name
(defaultAction vs updateRefs) seems acceptable since the command line is
about *what* to do with refs, while the config is about the broader action.

Does that reasoning make sense?


>
> No matter what you do then, the end result would be an awkward "if
> you want the command to update the refs, set this Boolean to true,
> if you want the command to show what would happen in the output,
> set this _OTHER_ configuration option to this string, or you can set
> this yet another variable to cause this different action to happen."
