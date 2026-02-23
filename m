Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D8CCA52
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771817152; cv=none; b=bz7N/eM8v+KihJUZo5EWefcP75zafHxiKZxhmegrSGIyXoEZi4bjE8pc6KUJBCg11ObPGEkY1wH69qxNyiOEGTGAp12SFE+RNs49R06nw1sxhLErz8DS9VzPDUBEc+aPBdaEk8YTUR9YUaMMOxqipWKPKABMAQmn0X+8Hq70eBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771817152; c=relaxed/simple;
	bh=58awwJ49un3E5OPoGn54zwXFWo3/9gYuHI1+v2EjvLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMC9yYltOh6mnzU2LFQtp1g0O+zdHZM6OfoMdTUUvOi9FHCitoPEIzn6c5X4wqWHe7BBMOaqEax5ClpZE9DUCd6T9Da/sT45eh9qrHy6MdYY6DiWprURRS0pgHIQfLpqvJiB/3dwxtDzmrzJU2yE84Rd9kI+lJG/E/oXwCKr0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nzfsv8xz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzfsv8xz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb49f63238so226485285a.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 19:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771817150; x=1772421950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vZGnimRW91JYb3y+GLLGtHwb8r/Dc91Xisj4A66TVU=;
        b=Nzfsv8xzfVJUL9hSdu4N9zaO2m011zpsuJPdGnSeaFdo0V2YI4v0ZYD7dyu6u31Ju9
         oogkkN93GAGX9QauMmz7YN+gkLcJdnHnaYyXkvwxow1KybFxRMCpP1sw2FO5bLecfMBw
         lZ9JuA2QlXxOaMvEH3suBbkwe6Ogai0ToaresIIU9k0hyEC9tkss16ZSk+GthyJLaVBP
         Rb9SccvLhLi8c3JYYlXm5mDAhAmzt9YVvX6N5WFcHeMMZilOAXiaYRSiYhAjSjl4QTer
         pbjZB1m5O+K7OSdmxvfsT0gYvYgR45b4djddRQ65A3GyLqJxFBm8vtdzQPLIKb+ns2JB
         Hqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771817150; x=1772421950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vZGnimRW91JYb3y+GLLGtHwb8r/Dc91Xisj4A66TVU=;
        b=kE3k9Lv0Cd/O4SljoWEbrNMKgOzZBf85FihiBTAqP9/y7cpBeSkN+44iYsiIF9qu7Y
         D5ByMaZpIZAIvNCJ+wAw/kN31nWbackXwEQdFNTcDW6l+oqvB/V4dyPPI76R+F+tiALM
         /vxf1HerQZUNIGBI/PvAYxwb12lHDGk7U7wthCWEy9JjokvwGRu6igx45dAMJiDr5noV
         0zy8ZbiycdcNPOOzmgSAyeutbd6F8i7aATarMQSOMLJ3bIjFqnJprMpqWYwrtVvIQIw1
         Z5eLyslwhr3TcFJST7EcpHZD4341Hfxwc3fDNwqMOS6uxiRvCE3ZNyv6ovxhxsSW4M24
         IFvg==
X-Gm-Message-State: AOJu0YyExHq2eMOE837/+1MgYUkVMBT4/ZHXp6fKXtprQCodfMnPmaXv
	w3cKPe4VNE6XKO6hK4wu78AiH8MMmuZRAK0OqJfezPziCAyoYpBG5AB+/WMChQ==
X-Gm-Gg: AZuq6aJ6lekwdRfdV64/uvzOsCFn9m99XNwuCmtysuafIG6ZX8Ev5kBs9mKExBr4pUx
	oXZd2pzlCU9JVxFRgm699FqOmqE3m1RLXO5ZqyLwpMb6nnWoY1c2Ig7ZPZJySsxZmQw0AVb7q79
	OY88Ko29l3vc8gOouYjwfK91+MACvR/W+3t60DsbZVlPnDdOJgo3gFV0FolJDNVbcs4FvpW4WIa
	XKqM3IrkuM9/f5paZSSAKBIiHemz3vMrracfLdtJCxQ8hJzFxpKH//rSp3fvy560W1wlN5dty0A
	gFmgJMsTO0klRdUQfQl+UGyQUyxX1FYURbJoNvBVg5BUjQ2udiIrRVuASUH55tUrNNM2s7gOeAm
	oPqv1Su6vkM2pfUhG+FZ0oTc592CpVCvm9c9ITpDi0zii+zyFHxZcw2Vm8SeM5jKocMooMBBOKw
	pgR+Slbv+HWTe46Iy3uOSZnbeu4qXhoi0MnT/U/gGKb0/nSesUWwgPbzUGI1M1SLVv4+CjoMaW2
	QI97yC35d/dMd8rkBPWAD4qhX4SGJTM8/JkNf0tJT4brh/+
X-Received: by 2002:a05:620a:7082:b0:8c9:ebce:43f4 with SMTP id af79cd13be357-8cb8ca83255mr789948885a.65.1771817150437;
        Sun, 22 Feb 2026 19:25:50 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eb04csm692984385a.25.2026.02.22.19.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 19:25:49 -0800 (PST)
Message-ID: <a72fd162-d904-496b-90e7-34c78299c356@gmail.com>
Date: Sun, 22 Feb 2026 22:25:49 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] config: format bools or ints gently
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <0a428d2ffe092c2af6789b5e698dc769b0eb883a.1771026918.git.gitgitgadget@gmail.com>
 <aZQvRH4vPkPYHyg9@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aZQvRH4vPkPYHyg9@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/26 4:05 AM, Patrick Steinhardt wrote:
> On Fri, Feb 13, 2026 at 11:55:11PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/builtin/config.c b/builtin/config.c
>> index 2c169fc126..2c93e1725b 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -274,6 +274,34 @@ static int format_config_bool(struct strbuf *buf,
>>   	return 0;
>>   }
>>   
>> +static int format_config_bool_or_int(struct strbuf *buf,
>> +				     const char *key_,
>> +				     const char *value_,
>> +				     const struct key_value_info *kvi,
>> +				     int gently)
>> +{
>> +	int v, is_bool = 0;
>> +
>> +	if (gently) {
>> +		v = git_parse_maybe_bool_text(value_);
> 
> This function also returns `1` in case `!value`. Is this intended? I
> guess so due to our implicit bool thingy, and `git_config_bool_or_int()`
> seems to behave the same.

Do you mean in the case of a NULL value?

Based on the rules for iterating through config values, deep down in
get_value() the value parameter sent to the function is never NULL.
It may be an empty string, but never NULL.

Thanks,
-Stolee

