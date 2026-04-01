Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB52BCFB
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052257; cv=none; b=cWb1GnAyyeIQ99bt7RTbrpVX/tu/f4SH6jDVEX2Slf86F2ufygm5WK8K3HheZRFLWXxUfUUCsqdnGMRwa+tSVFJkKi1iTMsp9KPcug1wKeA1ysbTE3rz010SN7Hv786fp79gCegF4EQlU7lE7qEZRHFsM9ndzVy+3g+9XzODbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052257; c=relaxed/simple;
	bh=jpF+lACMwejfyWPOl44vzjfxsxhabwONSJwjPYnKFHM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tB/Ji7rbEMOKkOd/RUk24MCntjRuMm7O2KxuIg5cpZ9uUDdVmxEoH+ARhDFuSQKb+gVSeAaNEees0PJyWpcfYG+GEK8OjTkDG1h4FpaPWhqjEZKFzyG5/K/HTax9nUeH6bmJt6IG94gt1K2pJYGa7cC36YOwTtk5UuNUKGSQpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRy1eNYg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRy1eNYg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9c1da7ac63so127164066b.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775052254; x=1775657054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MrAgdgvubSQMJ+aXE9zFO4wsdK0GGHlMlgcpe3HGFOU=;
        b=QRy1eNYg6cuvJBN86DKmaDn9oHXqzDYFDmhzlLrX4kdchZkec4p4XnAmjnLrDb5d+8
         zie+L78CjZu14etwIHU6WqbXQOvOanSkBdDQM+LKu2btIkqSUsQqp2x0jTR5vie2Dd1H
         bUgQy6vI8YDb/BvmHmOkw1lakNsG7KwmmMvvaAQ9hSGiw7bR2ro4L/czq+RrEONbvjGo
         6w3xpobcX+vM0zsoViisLIR/a7P145vvQBeVDOHepd199FVtdMD4WCAc0RMsp/04Ku2R
         SYFmN5eNjU9jF5u+EJ+jww0Mju6bgmWycaRrrT77QTfb/vmXNyEEJBfy6x7iq8iShZTN
         aQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775052254; x=1775657054;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrAgdgvubSQMJ+aXE9zFO4wsdK0GGHlMlgcpe3HGFOU=;
        b=l4RAE6Td6ZLoP5I8KDXSQpyEhQalEgpWatKeYQ5NpyKrdpiFNaBxl+VpdUWteFeceJ
         caxRSSQnW4OtCKYn5RedtFpKUbgbten+w/WH7wqmyEhVk7dr4shzPX7KavIly/YSa33r
         IrQ8gCtWJsQ2lYH/l/XKgB6Z8rMj5xYohnBqoAudrgpCvRrtbu9kkdZnGScF2L425cJi
         tH6z24dCtrwLx8g9+CtLmVHvhQKMfZjJtwr5/w89BQLTd8E7zsMlVKRfn1TUokoVi6P+
         DvuttS/8Zih2qB6V3X78yPZRvRVOZKi/XK/6q5HbyTUQfja4CMiVqKZj3jX9gwQ4Mq5G
         2XJg==
X-Forwarded-Encrypted: i=1; AJvYcCXUKNUN6k9uycb/Xvf25S47q60WNkmf00wriPTG8tuIuPcFm9cTcPfDQa2FIIYhN5rAIIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNd5EIyVn7aCDNZC4omHpMENGHBmnTp6SpguiANm43SMX5FT4o
	+a+Se4YAThJU4Fyq/Owcwd/CIw4lYK2YQ9m2Vhrn5xxor52lqlQHXuAs
X-Gm-Gg: ATEYQzwVP9sHYVZKNFZNXkjlrfXeAmvGF6Xp9EMFBjVOUlDUDBTXcV7ISFUWLq3eV1H
	iSlTMHC4Oe5JY/zowBAt5TTL26Fmvs6J2yppAEGwYTtaJXqmggR7MYlaeffR3Xp7P4ZwECcAv7R
	0fcJcWfQT3msHa5gl2yEOwshCeDC27sOxawSiAzGXkMzMNajwMOcGPAIlYi5CqTMUlVWyKVGqCO
	4FRGe0Q7pLxojSVDHTLTMuNvw2gmDdpi1Ja3HQLqTpWU7Z77sOqWTrbuVWM41kNRzit0LvG3hBB
	TrZk7QFt7E5qXQL3vivQ9clnrDfLGRyNT7qtrf8EnG+J30iO03WNWNoH6CWkGe6jOpSfzZh9Fb/
	uN4Zv4avdRm97dT3Cv3zvFyjUj7KvQNb4AQ65GknfAitY3j15LN5rbcG5Kxw5rRl+M4UXGQkv6p
	lr2pHlQkGb0LsYgzLPsWdxUEHRF4PsH+qUfbvsNqT/ffnqaUxw1TLTVx1/ZUbBS8f7PjeyGM2YC
	9E=
X-Received: by 2002:a17:906:2556:b0:b9b:207c:f7ca with SMTP id a640c23a62f3a-b9c137b7a6dmr194417266b.5.1775052253212;
        Wed, 01 Apr 2026 07:04:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c29605870sm50169566b.37.2026.04.01.07.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 07:04:12 -0700 (PDT)
Message-ID: <b77be594-83b4-4d9b-9f89-569f1f335d61@gmail.com>
Date: Wed, 1 Apr 2026 15:04:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] skip_prefix(): check const match between in and out
 params
From: Phillip Wood <phillip.wood123@gmail.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
 <20260331235017.GH2328529@coredump.intra.peff.net>
 <14a417c6-fc80-4a7e-993d-57fff10896f8@gmail.com>
Content-Language: en-US
In-Reply-To: <14a417c6-fc80-4a7e-993d-57fff10896f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/04/2026 14:17, Phillip Wood wrote:
> On 01/04/2026 00:50, Jeff King wrote:
>>
>> +/*
>> + * Check that an out-parameter that is "at least as const as" a matching
>> + * in-parameter. For example, skip_prefix() will return "out" that is 
>> a subset
>> + * of "str". So:
>> + *
>> + *  const str, const out: ok
>> + *  non-const str, const out: ok
>> + *  non-const str, non-const out: ok
>> + *  const str, non-const out: compile error
>> + *
>> + *  See the skip_prefix macro below for an example of use.
>> + */
>> +#define CONST_OUTPARAM(in, out) \
>> +    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))
>> +#define skip_prefix(str, prefix, out) \
>> +    skip_prefix((str), (prefix), CONST_OUTPARAM((str), (out)))
> 
> This is clever but it changes the behavior of skip_prefix() which is 
> documented as not touching out if it returns false.

Sorry, I've just realized we always take the other branch so this does 
not change the behavior and is in fact a nice solution to the problem.

Thanks

Phillip

> That may not matter 
> in practice but there are nearly 600 callers so auditing them all would 
> be quite an undertaking. Elsewhere there was some discussion about using 
> type generic macros to fix the warnings. That would be more complex as 
> we need to check if they were supported by the compiler but it would 
> avoid changing the behavior.
> 
> Thanks for working on fixing these warnings, your approach of trying to 
> fix the underlying problem rather than casting away the warning is very 
> welcome.
> 
> Phillip
> 
> 

