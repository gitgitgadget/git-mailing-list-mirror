Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C487E2D9EFF
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572221; cv=none; b=Yb8NLUvqe93D0cYBXNTShWCpkiNV89x+d4CkiDnCH1Ql+YbCWAquP9ZwEEg2UtEYj0M8OAXpFXH8TC9tQTsPXliqRcyzt8BvSnrMIkemqlafVCbnMfAh7xLFgWaWLWfViZ0PMLn4vALDdsCGA7Y4O1gIGeV2yfjexGS5WrmDukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572221; c=relaxed/simple;
	bh=wHFTkHjO/Gl8yVsxz1bVKM0xbSeiyDXbvVxuT1O953Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=c3hXDqx3wffvPeAVmY4jQTaA5tK9/NyEGWm53H66X74QSIXnT3OHgw/vVPasgv0J2BveO4mNRS1/lkrBH0iQWnoL+rWnPYrb+SCEb2uyE/O+GXhR/VRaxak1Il3RWUjceSKPrm50bnDZPHzbMZ7L7sGW0/rN2BD0T8ocNsIOgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc52R5Op; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc52R5Op"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so16711705e9.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752572218; x=1753177018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YWp/9LZeZnew59JlQ1putb/24+sHhv3wBbwchVbFRJY=;
        b=nc52R5OpDx9HytM2DqA/ObgY3uoTZEGcNfIWZLt+2N1XIn32WGu75RaOiLL38jdff/
         roQ82+eNk6KQtw76nLZ+1pNpvK0HdzLFqMLLZKddf1b/vfGTKPNBuag+xpeofd4C90OP
         RDvBbfeprI2JgbIYshxAQqHuyQ1CbouCWmRXeUxTRe+aC2X5hRXlNKV4je64Td14cL2i
         jfTMLyi9q4nHey4hYF23+bDuLvBVYzBN6+8qnZSw76JrwipD8LwH3j2qvHfusgLNm/+w
         ovIlcw1IH3n1bjsQ45XPOhkSz82uWsUndPVtDVjLecx4/VSwQcEEdHqAa2mz9zo4aEVx
         e+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572218; x=1753177018;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWp/9LZeZnew59JlQ1putb/24+sHhv3wBbwchVbFRJY=;
        b=r3nDoYHIIYQ8pONNAxeEEnicDZ26O6a6ufJjuUZl85jvDnRPNDJj8nw6sM3imHHeZ8
         jPB02YZ95FgHLQly5jt+L3zLXYBn43rZLKi+2DmU9R+gZ5LFAQe+ksyzgMxSkaKK+94X
         lznM+2VSrVAcqL38TaMXfZpa7Xm5MFkv7Nhrk+GNwv+Wk6JHIqlOFUAWSY9WtYHbfjBS
         6U6hg133ZJ9a/hw+iKI/ExlEAjLH7nauyQ/xOGrmJ2MfSzy9hn5jkqtVdV6ANfiXfrNU
         u+UkN4AWo3tLz2/BYb2DikLurxqFWpJSTZrGfpT8Fw/yROMEQj25clG6GNBbuTv3JIJP
         yL8A==
X-Forwarded-Encrypted: i=1; AJvYcCUwjSMhqAR2N8tlbbWBeKZ8boHSTTQNpj6JeyWvDwyRL9xQ4vGCB2+Q0GnUVfVEcj19sTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1ki1cTdCadGiVk98wkgaqCbgdG0G6/vLhOv+HjDURZUgFx4k
	DPVDNVMdjI3jLIbwUDsaF/i0TfD0VmIgW+LijLy+VU/pfVueLYlh0qzg2JZ+Gg==
X-Gm-Gg: ASbGncss8ncCuCBBZWmUc9uL/XeY0Wp9XXf6kKkqqBPhkHxfS84CREW5N/v1bqSehCR
	fbOuY46JNTvbWqLKgGluNonpeMfEjIBRJtRdq9E5CpAsJzkOO//4HONB/vYrHl8YzdNlYc4fWQf
	is4yWB8K+UmQO4QoHUpYnYSHlgnhe/er2OILiuanKcWUbX67SwJDNUsuuUh+G7qZqoc0xXw94py
	bQdxAEa0LX4a7VlW0LuSh0dmmjiRwxjeCRSdsva3p+9YYXNlk2u0D3eLr4+kdN1QbAhXgXkaU64
	sjZuppyapCk5ok8u4aeY6ps9MO/ktPbpOSXikuQJzbXe9jwhtAYlG1GijGHeybI+fynkQbWZA8v
	9MjIVx5VuABfNHdAbUAvY5LTGigBTeP8Jo5lyEAt97DJz2jfB8e1usvphya7k4yaRHQsgu2gw5/
	Wx
X-Google-Smtp-Source: AGHT+IGAeNY9DizR4mI3+BaET7OA8+ImmHqUnFFCsYdsz0Y8kzJBnruwhIc1RSWYsRgsnf6wqTWUdQ==
X-Received: by 2002:a05:600c:8b2e:b0:456:285b:db3c with SMTP id 5b1f17b1804b1-456285bdd90mr18179685e9.3.1752572217704;
        Tue, 15 Jul 2025 02:36:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455f8fc5a01sm109941255e9.32.2025.07.15.02.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:36:57 -0700 (PDT)
Message-ID: <1a00924e-6e2c-4758-8fe9-2c04f5935fbf@gmail.com>
Date: Tue, 15 Jul 2025 10:36:53 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] git-compat-util: convert string predicates to return
 bool
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
 <a0f9182aa20d0f956072a3d185a2d1288f1bd842.1752499610.git.phillip.wood@dunelm.org.uk>
 <CABPp-BEH9rtdPcS9hEXSdCqwydcWbakT59OuQOFUU7DGjPzdVw@mail.gmail.com>
 <aHVzJE9_xJAn5dOt@fruit.crustytoothpaste.net>
Content-Language: en-US
Cc: Eric Sunshine <sunshine@sunshineco.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aHVzJE9_xJAn5dOt@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/07/2025 22:14, brian m. carlson wrote:
> On 2025-07-14 at 17:20:08, Elijah Newren wrote:
>> On Mon, Jul 14, 2025 at 6:32 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>> I wonder if case-independent and case-dependent should be hyphenated,
>> or as separate words as you had them.  Anyone know?
> 
> I would hyphenate them.  The Chicago Manual of Style, 18th Edition, says
> in § 7.91, “When compound modifiers (also called phrasal adjectives)
> such as _high-profile_ or _book-length_ precede a noun, hyphenation
> usually lends clarity.  With the exception of proper nouns (such as
> _United States_) and compounds formed by an adverb ending in _-ly_ plus
> an adjective…, it is never incorrect to hyphenate adjectival compounds
> before a noun.”
> 
> They go on to state that hyphenation is usually omitted _after_ a noun.
> 
> I usually follow this rule in my writing and commit messages and I
> haven't gotten any complaints or comments about it, for what it's worth.

Thanks for that - I'll hyphenate them then.

Thank you also to Elijah and Eric for the typo fixes - I seem to have 
had my brain turned off when I proofread this message.

Phillip
