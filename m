Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDE4EDCD0
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474381; cv=none; b=oNoTXvgZOrBNr7lHlpdxoC9dk+xuAt487anLzdyYMP7YkfALB3F1KRjRkN/j2pijml0Ww5l7RnqUTNeNdQYQYMMBWS5heetmTKVHot+ZHZ8yS2dH8fHXhF+t4ouCqNbm96Bg+SHBUqo1iKo7KVhXNtEYR+mrOxCMypQ/IlpaaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474381; c=relaxed/simple;
	bh=HbckHCyzWqWpxAH0xG8t1duLLqFQ++hai5n/wJubN80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gs6znUtkPPtl+Ar48m3F6AJr9pTz/lpHyQ0UtaW8REFQucgerh6UiR5iXxBy3KByprYud4ofU8KgMoIv+IiNT9DTBkCZhWMeQQOqATFj90QVxAwMnlUg3+Zsxg0oKKWlur6DU1k3YqXGvmifPzahYg5VEvQgmoybINpkUNRznac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaM1zJc5; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaM1zJc5"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-98c67e94e53so2935927241.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791474379; x=1792079179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CBMppByzmoXkgKRdNEzWkzJosBxSwnUWcN3Ou4NTlKk=;
        b=GaM1zJc5y7mbLThdBsTZx7yejnS7uuGRX+MXWmcnGLaPcYi6fFBlcqlnTeKNTmTKAq
         CI/NBnBi8QxGCZcijZZzh08k08czEidR3YzViDg1zDlVssd7jsJ+PO5POc8lAfMmNlKQ
         3SEqGHSJga0oCmhHwV0P1GEGxeRzmFr/YmwLdGvAFg20Lk9vbC5OZJ9706HLaQSJPD9D
         z4LXLXQqrdGR2fHsOMsfxfP9KzRe0dUSHj8OK2W7sXh+WS2aTL7rZiqyTeAc64yjqXKX
         aWrZbxAP4t+/WNN32rbNjcIOZKWPJF5X6LW+/xSchybR13U2aOXxtfD4TNPqGLXtpnWG
         BbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474379; x=1792079179;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBMppByzmoXkgKRdNEzWkzJosBxSwnUWcN3Ou4NTlKk=;
        b=s5lrthFunPnY9U9C44/gb4d6ZH9Kz98fQl3GR2w6TahKDVpJ9luxZAaVGibhU/O6Oy
         UH+Lq0PL5qNrun/d9cVS6wh+yDkDJaLryGwZmXhQ721LO8/Y+YeQtqpsEriv4yRYbDlM
         w8HsIFzQZFSN5TUjbWzB1O09ZtTTkrwjUstUP/+d7uzCvGQ1EJQZACXPV7GToH2c3CPY
         nJcj8gpfk5KfGMNL7wOsx3KNaa8qlpWgWWNWrZO1NWVhoZXUBhHDhl0Osn6Q2IROrlnt
         bruWH9R4lZLXR05hathT57EvLF2QHvtP7TxclM2EN8F0jrRul+Ewu17rzHooAG2zC//+
         LIXQ==
X-Gm-Message-State: AFq9FYKf5Q65Crl7+Ea1z5wZpUys6kHVjUx+ewQA3NGjJagY4fShm/+o
	4FfVSlwxKPgyGzOsA2TDPN7kixlNs3KgK3kQc5eDyl2GMyGfTfuSSTCW
X-Gm-Gg: AYBFou2uKDO6RpvyMr5aLulSlUxmf1ih4GdK5DBQHg/nF8GcnrTf5jLpj7YUsCw+JDS
	ShpHjdJt73Wq+GXXfd/03dLCLmvsxQgFA45nuugGHccRR6DOhHQ2otMmSvzJ9HuDlAQTTyKrk+Z
	Y3HZosRrfxmrIDhLl1lDbOyh6fIAaE/fhHWZgjq9QNoOUXZE84B+nBplpno6fI/LAZiu8Iaz+7P
	aaV3aFEOaaAQH7xf/OqY511BwK3U8+Uai/5cqJpsbmKdnQ83nattdSSYwjwnM9K5mzGi+A+RTpp
	YkmE4umxE/O+yG+ZBx/92CjIShkuMGOpN/xWkPoeSXE8aMPbW3MxVEPCZaT2KaiKr5Ou0JbqWj1
	QT3Zet37ZSwN6dqyMTxomEYSXHM5mvoXORQ/2M1q4bgZGxg2EU6z6oKDx3vlBRF73v8mqSFKqFC
	aA4eiU6twquusTlHy1ByZf7Lew2eAx+S7O6FShBltTMKkxRZO55fpYqFHGvSc9rOHcoUODZsMWl
	cnMGzkSxfQCnQ==
X-Received: by 2002:a05:6102:ac4:b0:7c2:37c5:dd21 with SMTP id ada2fe7eead31-7cab892f1b3mr601504137.17.1791474378803;
        Thu, 08 Oct 2026 08:46:18 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98e39cf2220sm4303404241.13.2026.10.08.08.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 08:46:16 -0700 (PDT)
Message-ID: <07eeee7c-4086-4b7f-b59c-74ba7227d6e0@gmail.com>
Date: Thu, 8 Oct 2026 21:16:09 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] repo: add filtering options to "repo structure"
To: Patrick Steinhardt <ps@pks.im>,
 "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261005174045.1900391-1-markchucarroll@fastmail.com>
 <20261005174045.1900391-2-markchucarroll@fastmail.com>
 <asSMX-K2qLsaXc3v@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <asSMX-K2qLsaXc3v@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 11:21, Patrick Steinhardt wrote:
> On Mon, Oct 05, 2026 at 01:40:44PM -0400, Mark C. Chu-Carroll wrote:
>> Implement filtering for repo structure, imitating the mechanism
>> used in "git log".
> 
> The message should give an explanation of what this change does, and
> what the motivation behind it is.
> 

Indeed. The cover letter provides more context about the change. I think 
it makes sense to include a significant portion of the cover letter in 
the commit message. We could even likely drop the cover letter 
altogether if it feels to add no value.

That said,

 > repo: add filtering options to "repo structure"

I think the following may be a better commit title:

   repo: add revision filtering support to "repo structure"

-- 
Sivaraam

