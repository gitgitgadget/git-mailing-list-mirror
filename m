Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6C3876A4
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129715; cv=none; b=L1FUZrAWhu+adVg+o1Z66XwfN3si4k9mG3zwkn1NwAsn85cqOHIky97I3GzYKsaq9N6E3+ifXUbalMk9/OcOJ9X/E5NAF4kDeZOc66SJkFRwrLBcf2E36Ske7A9yd8YvLv4QgpE2+CbsFFLdMha44SXTL0d0fZ4UMuxDZzsgokY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129715; c=relaxed/simple;
	bh=44MUPeEc6SNd+t859GW2D5V0VI0EtI6A8rDssakvvdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3ALLy4Aonc9chmxhsevZz1tJ3ilTBFirSUEKc7Mza+HdI1oBY+IfD46xw3pyMNd75vBQo/tf1Q3Kj9cXAnZoTbGqq6W3VzdYoF5hyZuhwUvv32i9eRAEMVkaJi6o1y/T0oZvINIPZDw1s8b5TXH0af64x7MoWxPb5XMRPUxS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFU3GTdn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFU3GTdn"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b936331787bso119683866b.3
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772129712; x=1772734512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wdbrZdsPI/tQCgNelQEekfyLiwnJ1qm0g4fAEmpvNO8=;
        b=AFU3GTdnMfBoFYTFny9/9IF+w7jLj2S2fPCbN38sH6v4B/feleMXWQGU+TOym78mJb
         3LVRfpl+SXZvXQ86WcYXHWjAXuo42t6lWtgheAY41KvWr4Zz+CN1HJHKdITGNrPsT/vi
         iupoPWZ2mrkrKCDNJ3Ikvy1MJ3TY5qo+7S6/eJlHPv+ls8ij36zhLXA263+J9tOIzRWt
         6CwfwJ6PvHeTzsgRXIBcGsvKpVlSjThGBUIj+ApeE3CBkO3PmHSbzI/V1wHEs3wN2zDN
         TpGEaORW/WppoDVxkvEUvzHHQLhr71SV1jHYj1kWdbBDAhfc0PYHH8+yLAZhZNo8QsM2
         /Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772129712; x=1772734512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdbrZdsPI/tQCgNelQEekfyLiwnJ1qm0g4fAEmpvNO8=;
        b=DYaCdMown3kyjJ38p7ygthXehBZGmPCQrpQbcI2K7MM4+Aw2Jd8VJshePNq9uEV3NX
         ywJtBD83RhtjBAAoboBU5gQ0WmXrPhrbeJ1UtbvAZYSWcrYnkkrvptMTRldt2bxp0gx0
         GLTJrlNErnW10RvD01Am969fLqMX2gBvXX/gocT2SZ47B6JanqryQE4jFVoHr01pcQkV
         /OWOOPFNzLxesCzjozl0pL5vqhbFb+iPRXOZpD78XnGneMp+Ef/7c1EVA1N5wkcRbtQG
         d37bXj8V3uBKeZpJ9OMEunGEnrSC5aW+ngubyH1FnkvvP1FUDfo0np5tZFvrm1x5EquY
         peNw==
X-Gm-Message-State: AOJu0YyQAnTXGW2fSwRLehximQ7dD1f8zJAAOKe98/SiwtUiNB2s+1tP
	u8cC/P0JC0EFELNptKEg4ZvldpDChjKZ21crtVkDgozBRpytmUBFSepy
X-Gm-Gg: ATEYQzxhSZChxPSVko1xB9OujEhQOUaD22JeECrzYbF/eV3qioyylG8SnpUwYr5tHPb
	y/EgfhrTw9KMDe44Z1fXjcSP1QU7yVvXN/nCp5CMnq36FAEIokmynioOMmvviuyHwtcouWfJ9dv
	6Q5wegF5YOzDUglOyWaZAEn8ofvQB03APt6+c/Bq+1TPgjhuLycIZVRLZYFCGXaDuttXHk82OFD
	CsVixOSKWUTLYX7yKhMtF5gRt9F9nSVJuLkUHLVnu+3E6HdJlyuRTyGPMuSQC+uVuzYsu2WUF1/
	j9fndxFDMkd6FtmlLyIfswY4KRO5/UJZhjcVab+uN1NIsA+XAuVg8ZxkUnvzNgtflmlPQgxRJlf
	VdqrnWbMHI+HSKsmPv6swTlZqR/Ha3Ia06+TbrUnTa2JqBTZ4PFfwrwOGWP3EOo1mKvBd4sowzR
	nnVpiQ8elvOsTkwY3IEJdARLCBwQ5BKUcY4K9wvyL1q4ut4pPPd2diFI72G1phZKEdayhSpxb5x
	75Na1aCAww=
X-Received: by 2002:a17:906:455:b0:b8f:d960:c592 with SMTP id a640c23a62f3a-b9081b41cabmr962421766b.33.1772129711725;
        Thu, 26 Feb 2026 10:15:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:888:3d40:be1d:6b29? ([2a0a:ef40:1785:c801:888:3d40:be1d:6b29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ab13558sm86050366b.5.2026.02.26.10.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:15:11 -0800 (PST)
Message-ID: <83cac4b2-c59d-4ab2-9dfc-2f615ed3959d@gmail.com>
Date: Thu, 26 Feb 2026 18:15:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] rebase: support --trailer
To: Junio C Hamano <gitster@pobox.com>, Li Chen <me@linux.beauty>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20260224070552.148591-1-me@linux.beauty>
 <xmqqecm74fcd.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqecm74fcd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2026 16:52, Junio C Hamano wrote:
> Li Chen <me@linux.beauty> writes:
> 
>     > Apologies for the long delay in sending v7.
>>
>> v7 is based on origin/master at v2.53.0-154-g7c02d39fc2.
>>
>> This series routes trailer insertion through an in-process path, removing the
>> fork/exec to builtin/interpret-trailers.
>>
>> The first four commits refactor trailer rewriting in builtin/interpret-trailers
>> and trailer.c so callers can reuse a single in-process helper (used by git
>> interpret-trailers, git commit and git tag). The final commit adds git rebase
>> --trailer, currently supported with the merge backend only (rejecting apply-only
>> scenarios and validating input early).
>>
>> v7:
>> Rebased onto origin/master at v2.53.0-154-g7c02d39fc2.
>> Split out a new patch to parse --trailer with OPT_STRVEC in git commit and git
>> tag.
>> Use strbuf_write() in interpret-trailers when emitting buffered output.
>> Restore --in-place rewriting semantics via tempfile+rename.
>> Drop wrapper.c/h and validate trailer args via validate_trailer_args().
>> Drop redundant rebase basic-state save/restore for --trailer arguments.
>> ...
>> Comments very very welcome!
> 
> Yes indeed.  The discussion thread for v6 saw quite a bit of
> activity, but this one is quiet.  Is everybody happy with this
> iteration?

I've not had chance to read this version yet, I'm planning to do so next 
week.

Thanks

Phillip
