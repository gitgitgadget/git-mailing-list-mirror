Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98C3B5E01
	for <git@vger.kernel.org>; Tue, 12 May 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596434; cv=none; b=Z4Ya9JyL3xXEzBT3cEgsMSZNZRCB4jKCoE3biWS990ZMY/wJgEMrHWziUtu63k1A66JlWJx31EYjX5dhl4Xxa0Hl9nvgU8xeHS45e2wRGV4DsXCvLZXe5+k/idOmErsUeuYGg7cIIKjW93GNh86/aoRp/sqZiXXY9F2rZCBWkx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596434; c=relaxed/simple;
	bh=H0Hh8xalozQUNbJSKCf+v4NwM6TqEQJ4WoPYlGOH1T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLjl0rGAdOm7oRCfFw6LZTuhCLjG8o/yLybuzpCo+GMc+f51u21y+0xYFik6x+jMmopgHvG8dBzL2csHAa8ffYw3M01LdxU3HdFfd1f2J+Gx/eMAiIEz+m4Bz0/3PIz8knw2UOEPHaZoZu2S5GtNGxFhVDfwNRKI1Km6Phgxvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs+Ss17E; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs+Ss17E"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90eb7a63a30so18491885a.2
        for <git@vger.kernel.org>; Tue, 12 May 2026 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596432; x=1779201232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E88Xm1P9XkruOq12f3r4/jpxURciZMNVbkwwz6fnNzA=;
        b=bs+Ss17EdexXMNfQKvCnhzOF2mt/NVMKjaHBOdbWUBM0ar3NIjSiNxNaTjjilb802T
         ytzGgB37FAuT1YCE6iWROG68CKuge0/mReMTnJ8p6c7J1VtHyvCDXQMgIL67kxU8QzXH
         IIUyvHz7HpWp3djptNJD4hTgVvRT2l2EZ8qC1s2BNKxhZwjvx9km+z5PBevUTzJBkMdW
         MLUCDyt62eHmezepN2B3vN77VsWfIsuvhEP5Dj340hZ3aQTXgzZY4mVHQxPCkz6B8ZBL
         oPhNKIhOn8654c/0UkqfKRU+VGjfaQuw6nH0LZzMwQylyWW5fWYD47iaA0DXNhvF3CnG
         g1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596432; x=1779201232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E88Xm1P9XkruOq12f3r4/jpxURciZMNVbkwwz6fnNzA=;
        b=Y7w+bVPi8bS3RS/LYmsepJE+smRx2qFDDMvvX3CYZpKg/qDqL/OxazoMmu48EC5hK+
         zuHYCrrCeWwoo6AW/wc8k5nkyXgHPh2bHvADJqpePRd20+in0UUba9UqK73CuZ2asIXC
         5CmM9Zw8+2rY3wAPtJl8gNFYLEjPn46k/GoAJo5Ma8jL6Z7i4/jSLDV5Zt6nj18NTL3A
         H2poQGtg9iQUFOlE2Am0GkXXK7sHHEpc3vBhgNW4fS9DPwQ7I90kX4MTqnxxnigwzyF3
         oJhMnuMAVFq64emwOsWego/wk7SV7iPNiQX3Snz7G065Z9l9Q8B3Q81HQ66XCjlpW51M
         h0kA==
X-Forwarded-Encrypted: i=1; AFNElJ8pnS3hGG2BZNziNm+1oZnxcgedMEIIeQ7Hj27FTduCIVFOBhMr9OMYULrgVfo+eiyYd7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTvBuWNznxwuLSradqRcybdtnoG9ydKuFT8A0Dvg7d0mbKb2K
	GT4XBRmAP3KHfeDfV4ZuGohaHE9vBoHkkXxVKp1xauUBsQWtgnQcdW8n
X-Gm-Gg: Acq92OGNFVFNA3zs4mp8k/4c6aJ6Ci5yd3wZpUdEGl6UKdgNahZmvDREC6rNwUGQYPY
	9WDErDYMp4FWgoJQMrAQHViy+m1urUj/M9aop70M6sYIUS7NpTyhsnwEpkztndXVr0omYWyF2Et
	J6Yuzx2z+OQWCvxi6OpxOSDtuHd8IQz3uWq9oGwdbk4A72gpu+9guwTLerzgsUyiAQXM66Lnqw2
	vU0NIub7uRL25OlxTVPaFkltNq/cYgjL9KRfkTdoj1x7MaQ/Un0wXAwEj/jeJkoYWHOLKC/zks4
	0bUoWCtlLThNP0qHoFGzYAETuSCYx1ZVUH5NwEKR+pI3oUQcTgB+Wu/MCS43ji9dDwqcPIWG7Te
	D/r6QS7sgZ6oZ0Hh5bQiuYPrBOzaxcZ6el2HpxOefX8mFN27HQGju0uMLG9e+7WuQSOgTc7s8+L
	XeQbubQEueDVXD8OMQ/O8Je2wzJ5rY7YtjnK6Dhy+ZskArEAryTRioXMxB2cdaeh4vsdu9+iz6E
	cX0LLSOL+Bs34E5DvBRrPtka4tWgfvn8DH+HP3rhZuTu7xxpms=
X-Received: by 2002:a05:620a:bd3:b0:8c6:d309:f9c0 with SMTP id af79cd13be357-904d3fa42e0mr4032053985a.8.1778596431814;
        Tue, 12 May 2026 07:33:51 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c? ([2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b9380925sm1386639385a.11.2026.05.12.07.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 07:33:51 -0700 (PDT)
Message-ID: <16a7342e-015a-4e68-ac1e-45e59313299f@gmail.com>
Date: Tue, 12 May 2026 10:33:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] transport: rename negotiation_tips
To: Matthew John Cheetham <mjcheetham@outlook.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <4332cbf26631516030da32fd6de6ae134f8a6645.1776871546.git.gitgitgadget@gmail.com>
 <VI0PR03MB116342F99CAA8959D2D8638E0C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <VI0PR03MB116342F99CAA8959D2D8638E0C0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/26 7:30 AM, Matthew John Cheetham wrote:
> On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote: 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The previous change added the --negotiation-restrict synonym for the
>> --negotiation-tips option for 'git fetch'. In anticipation of adding a
>> new option that behaves similarly but with distinct changes to its
>> behavior, rename the internal representation of this data from
>> 'negotiation_tips' to 'negotiation_restrict_tips'.
> 
> Nitpick: s/tips/tip/ .. no trailing s for either the option name, nor
> the (old) variable name. The function names do use the plural however.

Thanks for the close eye!

>> diff --git a/transport-helper.c b/transport-helper.c
>> index 4d95d84f9e..0e5b3b7202 100644
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -754,7 +754,7 @@ static int fetch_refs(struct transport *transport,
>>           set_helper_option(transport, "filter", spec);
>>       }
>> -    if (data->transport_options.negotiation_tips)
>> +    if (data->transport_options.negotiation_restrict_tips)
>>           warning("Ignoring --negotiation-tip because the protocol does not 
>> support it.");
>>       if (data->fetch)
> 
> Oh! Looks like a place was missed when renaming the preferred option name in 
> strings. It probably makes sense to do this rename in this patch
> (rather than in patch 1) since we're already updating the struct field
> name here anyway, but up to you.
> 
> Also do we also want to make it translatable like the others?

I will update this as part of the previous patch that handles all the strings,
including making it translatable and dropping the capital "I" at the start.
Good find.

> Aside: I just noticed another '--negotiation-tip' instance in the
> `get_commons_through_negotiation` function in send-pack.c. It still uses
> the 'tip' option name when forming the shell cmdline.

Thanks! I've done a more careful search and confirmed that you found
everything I had missed.

-Stolee

