Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143F324113D
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299683; cv=none; b=bI2leq/2oHSdFl25yyEAd2McZziO8FEzKnPdt9Qz45h/YaNgF5x+Wja8bWf/GIOP74uikV2Fo46xrVZfFpEptyCfm2kIxLs5s2caTjwqzXzJxDoYx5bpJ9fHaNEuB9jtyaPDUCobJAwiN574Od4llg3xuGVX9DR07vtJOy1PM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299683; c=relaxed/simple;
	bh=Ia6fExVIe2Coe6ANm7onA4NN2edZVTT8ZYJOKWLYnXo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gADB8onb9gLfuf+bFnWxrHm3Vj43PsxNLp1U2uD35sho/CXIap+0t8JzFISBOe9O7ruYGT4vmL8IRxOgstparasKAjy1Z0sgB5k4KxSC0A+jHxDU/CvxE0jhlnSKrsMv7dU5cwv5twEgrqPMwlA/xDhByQ6YCY88HUCINIvv4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM2pb1l+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM2pb1l+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45994a72356so9494635e9.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754299680; x=1754904480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ul71Y/XBd5rkvk1YNV/qLC1cJn43MHBRMZU0DHTsx30=;
        b=XM2pb1l+lO1MbKxLcNEoxB5run/PADTeJT1CceZZ+BIkomIPBkyPZPwDP6RuQQoorF
         fAxVW5J3aqFZIv3MzaSTx6gJ1DjecnWZbvWKRiwSj03oNfKQbeH8CRnSXyqJexkM7dgL
         7ifpSw0NpP7JKhwB8sOPToBgT9TtKUBJkGFAYwzU/gCBefHtuuzZL92QAjSWSgbH3T8a
         pkWAj4g/DtpcA2OuG5wf6N1yq6erPlgy2EykmOiG9n1vVpRNxxq9OfIl/OwAAEKswvCH
         YrdNZRIJnEY+RwShYibiDieZfzB6NNOF3UxA877Ow5uzZn+IuqxxqoEnj6ZaoCaWLWIE
         UdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299680; x=1754904480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ul71Y/XBd5rkvk1YNV/qLC1cJn43MHBRMZU0DHTsx30=;
        b=MmJQeipqSthGBMiBnBdhb1XMfXfbbnrW61yDWOS8OCR/NV+wsq0S85pLsIhGZhOprL
         l4NJqf9Uww1rEur/TQiP/HNd0hE1hKvii2mj19edoivf5HUau6rgNOFMP4RIsv7p8XED
         irCHkWjpEFMIAdVdXja8caPLAaPMnkR5jHLwgSPoAT0gGeF3y+gpTs3bs6F1fvMAxcFQ
         fZu2+MKm31sY36JXhXfQ7092OEtw6ARqRgv7VjA4R7vg2Jz0s1ezHaSvq4ySqZc258J6
         84Yxx7j5/sVLgyTlRF3/IisP03vmc1JSoZ9RsYpli3XGwt+bl6S1hUyEl6NbsCWLOQXW
         cKAw==
X-Forwarded-Encrypted: i=1; AJvYcCXoLLQV8/LnUAmTXp5tcJG9M2EEFEeV6DChpgUgG/1pYqdxY/2m/CIHmTnJcjTFPcJ4194=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wpf/hvmJpJhMS3xiuJY2jc5NFgc/g7xSiJVsTCXh6uvK9MJG
	htoKZmcwPyTM9hEzRJIgb9NpHV3o7kLJeP8Mpns/41nHYEhidYPSHaZb
X-Gm-Gg: ASbGnctt6UhCwBtvsz526eZ+RX79Vh4BtNR+WaLJ0T9zyxPBgf6AfJzmoKONrQIodJO
	XkFMVaM1b/Hr3afjOTr8CVy8BNbs07GTRD5So4x1ecnK7Haec6FafaMPqTfKfHDubFKULyZLhCL
	aynqYrDZt2eG59xfTg6QE6KpXt6S2BBAOBDvL7zGvLmX9LzGH2cdpBVMvioCMsHiTemZWsZ6W75
	NkScCiKS3Ko00ICi84e37q3J3rvdjBpojjvCQ80LUJ3w7eTwEU9yhAthy8Xn8UBTTkihOzvJPiS
	kg3NC/NX8g9kZ34bdTYHKPzMm6U5bzPYdORII4kh01zRbIJiXBzsmeu1Lw4YR0WyI/tJpoqHGKc
	vVXOOkYfiT1zh7wlzE6wBcKXmaYAUEwzTIeyU/ROSj93fikE1/3PMBWpoM6Kh/lbEF3Zgp6Trbu
	eQg1zzao0q5xA=
X-Google-Smtp-Source: AGHT+IEFb8PueVHepEhQOyRwmymVHb/dZtf9NPVZHi4R+5Mz3FsBhtsI62X++TBa/7Jvgfp+CkqHYQ==
X-Received: by 2002:a05:600c:1c0a:b0:453:6c45:ce14 with SMTP id 5b1f17b1804b1-458b59e37e9mr60460125e9.4.1754299680247;
        Mon, 04 Aug 2025 02:28:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bf8eae84sm68919005e9.31.2025.08.04.02.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 02:27:59 -0700 (PDT)
Message-ID: <61933769-1992-473e-8d0b-8cd6946e80ce@gmail.com>
Date: Mon, 4 Aug 2025 10:27:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][RFC PATCH v4 3/5] builtin/refs: add list subcommand
From: Phillip Wood <phillip.wood123@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org, ps@pks.im,
 shejialuo@gmail.com, karthik.188@gmail.com, sunshine@sunshineco.com,
 John Cai <johncai86@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-1-meetsoni3017@gmail.com>
 <20250731090040.1625303-4-meetsoni3017@gmail.com>
 <2d2f823d-6e85-44a0-85d2-d45d4dc287fc@gmail.com> <xmqqseibm7ap.fsf@gitster.g>
 <c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com>
Content-Language: en-US
In-Reply-To: <c4d9b25a-2a62-41bf-90e6-455c62b03aa3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/08/2025 16:49, Phillip Wood wrote:
> On 01/08/2025 15:43, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>> What does a double-asterisk currently do in these patterns?
> 
> refs/heads/m** seems to behave like refs/heads/m*. I'm a bit surprised 
> by that as for-each-ref seems to set WM_PATHNAME and I thought that our 
> wildmatch code used '**' to match any character in that case.

I'd forgotten the rules for '**' - it must come after a slash and be 
followed by a slash if it is not at the end of a pattern otherwise it is 
silently converted to '*'. I wish our wildmatch code at least warned 
when it did that. So one can query all the branches beginning with "m" 
by passing

     'refs/heads/m*' 'refs/heads/m*/**'

which isn't as convenient as it could be but it is possible.

>> If it
>> is not doing anything useful, perhaps we should make it match any
>> letter, without getting constrained by hierarchy boundaries?  IOW,
>> a "fix" might be to make sure the following happens?
>>
>>   - "refs/heads/m*" matches all local branches whose name starts with
>>     'm' like 'morning', but not the ones inside subhierarchies that
>>     start with 'm' like 'mid/night'.
>>
>>   - "refs/heads/m**" matches all local branches whose name starts
>>     with 'm' and in the ones inside subhierarchies that start with
>>     'm'.
> 
> That sounds like a good idea

Now I'm not so sure. We could add a flag to wildmatch() that allows ** 
to match any character anywhere in a pattern (I think that is how the 
code behaved when it was first imported from rsync and it also rejected 
invalid patterns) but it if we use that flag in for-each-ref we'd be 
changing the behavior.

Thanks

Phillip

