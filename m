Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C5197A76
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864491; cv=none; b=BscIZqIyTE4Fc/OM07RLlLfv6zDRdqIwOK9l1WgOtIIi7UNog+5nR0k84f5w7BDstJ+wF9Ycs2gxGKsAoVhUd5y1xFufgJcoYSZdSOlFqhyGGj0jQ0KK6cKTQLBmdM3dmmHIVrGCnmsDg3NwZgqVK3j4v291ytWmQpd0eKmka4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864491; c=relaxed/simple;
	bh=D8JpO/fzknvUZT3tN0Q/magT0pvHQy6Mm/I/g7gMk0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6EwIZme8YrTAU0odafi6oasQqtHUntEDgXLnCXfvZww9VgHaPIPu7P9Ekt4PPDxWRvTWiWrAINz7j8cCOJzcYFPGnx1DbQIDK2g75aaBriN4+WkQGYpOM1oz5psgfkdeN4yNrOwj2tW/Z7xtwOsTspUJv7TIrEBDk9k4lbECuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+SGApV2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+SGApV2"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7740ca85eso154376266b.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738864488; x=1739469288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=beNZCgS3kFsnsT7TwE2DKLzWthMb8Vb1QcoSmH7WDf8=;
        b=m+SGApV2GU9Y68KQUfVYO/ipFhb2yaFwdPgrvX7dOa0KuRuMOk3KC9mRoFNbJKrgfm
         SrTn6g/JTYFiAaThpX5CMHCRGofjC0iYm6z4491z9FItvkDqNxboa3yqXmk/Q//KsR7t
         19kzSQACLWfv6RRI/y7PmfM/ROI1otPXGKUkh1T5/IVRxr4/Okcdoss5eXCPgMqHl3KZ
         pxhC5oJVzbItjHWF2KVQeu6rd3hazgis8Nh5KcNbMAACvxi3eVwmFErwfnZYEQ/akcwa
         3YXpsrlsHInTDlq23bWakoLDbZ7q4y0mme2iMHUN12gpVSHAfblEVeGdE5YvarQ8GcsL
         jLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738864488; x=1739469288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beNZCgS3kFsnsT7TwE2DKLzWthMb8Vb1QcoSmH7WDf8=;
        b=NA+QH4T33vt8uTTAwwk24Os6KtiwC37XrDUPHSZB4esi7vUjzT2Ri3ruh+8wSa7QnX
         3jG25sW9lhDGbfIwEnxwrkfjMXESS+9xSnTOj3UWgckd1Rv2Bl7hFZvqNKQT+44kCR8y
         YOTGAsbRUVR8eSSbEfLZm0JpmA3ERp5Ryg+KIRHJP7RiAgaQoUYpTvEBo7+U0+982j8L
         kBouBf80d87f/Ti1r8CYIOZf8hTZD4S0EZJy5qSUC3qmE9u1MIpNkC491luyNcyU40r3
         n9YADWaQRQ8YeQFkinTDdj86wghr94oAD1YJqEFydZ/gkOItnqhfQ439/Iv2C5BCxnpE
         EBnQ==
X-Gm-Message-State: AOJu0YyIbHfZrzPKSXid44SWssqfZYf388QyO9kPj1TCsqksLhVZUi+g
	jVFJoEgmNrSof2yz5XADjtWrR0FJAfLeNjzmnTyQ+h6DhBKfYVnlpshmMQ==
X-Gm-Gg: ASbGncsINhcx5UMH80sTY8uK3pyHc5fMEbzJ6tFlUUwwPv308UshJP7WwEFWH6yn9Zc
	sZZGe03uhcHI/xPKBYecZ6DIkoAXEdDsQwf8fV71lMGfefGoLWu2WKvzdgKGyoetGjBXV/QoO5a
	qcZdRXdjswO7QWUCInWcIGuOLpK5MnuGTOwrAqivhUApNsvFJ4UuZ9M6XGxVEB2Q/id6tgBMwAR
	li0Km39aYTQd2Aylt4sxAP0y2zuYBCeKDd+ecKhZk60dMEVVRXWZu8AAJmylCur4hpAL3ix3RA0
	XZzT5tPsZDefDJeZUAZq0WviJ+ZrYSJkl8Tk7fLf/2Y90godjTLVx/+ADjcBAkyCfPkIONXV
X-Google-Smtp-Source: AGHT+IFDklr3ckrWiiRUsYjunO6PXnXqnV15akD5mSux1EuRj6APe1jwNcifKM021pIZtxju3CC+nQ==
X-Received: by 2002:a17:907:72cd:b0:aae:bd36:b198 with SMTP id a640c23a62f3a-ab75e321e23mr778186766b.47.1738864487434;
        Thu, 06 Feb 2025 09:54:47 -0800 (PST)
Received: from [192.168.1.216] (89-67-228-254.dynamic.chello.pl. [89.67.228.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b734dasm1206601a12.13.2025.02.06.09.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 09:54:45 -0800 (PST)
Message-ID: <943551b1-c02c-4321-908b-8224c5cf8f1a@gmail.com>
Date: Thu, 6 Feb 2025 18:54:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: documentation for http.uploadarchive config option
To: Junio C Hamano <gitster@pobox.com>,
 Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
 Jeff King <peff@peff.net>
References: <pull.1885.git.git.1738790425046.gitgitgadget@gmail.com>
 <xmqqseorjhj4.fsf@gitster.g>
Content-Language: en-US
From: Piotr Szlazak <piotr.szlazak@gmail.com>
In-Reply-To: <xmqqseorjhj4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.02.2025 15:04, Junio C Hamano wrote:
> "Piotr Szlazak via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Piotr Szlazak <piotr.szlazak@gmail.com>
>>
>> In Git v2.44.0 support for 'git archive' over HTTP protocol
>> was added, but it was nowhere documented how it should be
>> enabled in git-http-backend.
> Good eyes
>
>> This commit adds needed information.
> It is more customary to say something like:
>
>      Add missing documentation.
>
> around here.

Commit message corrected in [PATCH v2].

>
>> diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
>> index f37ddaded82..1dea4268520 100644
>> --- a/Documentation/git-http-backend.txt
>> +++ b/Documentation/git-http-backend.txt
>> @@ -56,6 +56,10 @@ http.receivepack::
>>   	disabled by setting this item to `false`, or enabled for all
>>   	users, including anonymous users, by setting it to `true`.
>>   
>> +http.uploadarchive::
>> +	This serves 'git archive' clients for remote archive over HTTP/HTTPS
>> +	protocols. It is disabled by default. It only works in protocol v2.
> The description looks good, from the correctness point-of-view,
> and its style is in line with other entries before it.
>
> We may want to later consider moving these four http.* configuration
> variables somehow to Documentation/config/. directory so that it is
> shared across git-http-backend.1 and git-config.1 pages, but that is
> something we should leave outside the current effort.
>
> Thanks.

Regards!

