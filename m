Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12724BFE8A
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212962; cv=none; b=OQhuFKGMMtSotZ0+V6AT3v+3+M31yCidBtfTfzOYsdNlNYmjDZAfQvCog+ggBXYOoHb2VgA7Am/4/FtZz9dA2F6tzeFAiro3qzbpmzMmaWE34f5+d5Au4CA9cRAW82DIHi2k1e7gDLkRr+QywmESJTgypXjRW23sCwE3pO6fJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212962; c=relaxed/simple;
	bh=B6ya8ON8N9oxNQw0oYxzHqZTNXVihVCCxORtUS+KhdQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xi/pPYxVv7iv0ds9c8XU4Di7lZqVq0I7xBnWt3YFpPLS08VGktvud6G3BonkzOAirgRaFtJmTRWP02Ms2CKvATB6liQWh/yZCXJM3xC1+eAHBoPW1wdhMnd5l39Ef8kRA73HC4PTOB6OXmfBkVbmHmIsHyIyIi+llYg0Oh7Ds3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r819lP3f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r819lP3f"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so17517145e9.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 08:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791212959; x=1791817759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a1UpmOuzlj1qFRFy3wM9rbD+Ig1uguqBjnfSPUA1cdk=;
        b=r819lP3fJPUCA/XdNacUTJMfbZY9Kqs4c9G6LoEmVa1TOpt6r46ZgY2huSDj+3At+K
         pYJi8E1eAn6x4/0RXYFIxCjXm6atcYexBulfTfJJq1ckKlxEcAcx3BNmvfni9xQQs5g3
         xUPMyq4nlY3FXczpOS8OjXfLqAv9gw8P5W7xTX6f86mS5YtANWl6mA9n5o+DZWYeEUeo
         DpCKcFm9KC/hSJVxihHrHU/CqICGpOjCNBReS7SmuH4Qp5Re+h8Z/mDbCdnfFgEAAe9M
         MzD27uTT8frzbnDEDWMg7DzQXtiwRd0oNFRpnhvT1rykJre/fn3RSvbbgi/I0+lmbSBH
         FrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212959; x=1791817759;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a1UpmOuzlj1qFRFy3wM9rbD+Ig1uguqBjnfSPUA1cdk=;
        b=ayUpRD1HJVzq24FVJQIfqnl6WaNmTY9YKB/LvdKx30uW17LU7Dv0siitC5X52qYk6u
         vOkO7nKQbyZGSffRHFCYXd5+Wjl8Vb0Vfysze6Af0mrw3UCsxKHluwDFWRSaGjByzYjp
         pAP4mbMkAU26YZttswoCfJfz7yf6wW5YlqHlGlxDCQhn4iMsuAadysrPD9K5ykB0avtL
         q1Ty1omZGwsKvHMQxHCZaMMiLe5xFsEaVKidz5XaRmeMhM2CqWpdy8J/x2iYoT0/OyMg
         3+HR8NGpgzn6QmvxgIRiKY6EqKS/dqO5JuZBEWhuS9GNTUPMVL4CY5fIio55gkoVC1v/
         X8gA==
X-Forwarded-Encrypted: i=1; AKwUvBzSwoxO2p9VhEwiEpebwYuCKCpYokG4+MiJSQwpYfUjUTaRRcNG+JwQlUVKFK0cfKh1nWE=@vger.kernel.org
X-Gm-Message-State: AFuF++k2RJI8hytqt51VYkhxPQe7YH+Xlg7e5OexBVp7AecVh3HQSmmz
	3VSgfZJn6r3EwcUJryWXa53kaL8tnhvoP0gHL2GUzKaUcC6umdrOcN6q
X-Gm-Gg: AYBFou3zRXiOWH45ZogxCUwNkx/eNRJuZPcNRPTMD+9wfY8oXfYaFXLgJ5NNtJtuKhu
	xajD0oKJ1DsAxVgRg6VZufGU9PJ6VDZ3QKktZr/Ad5FxwvxQtMwHE4DW8xMsg5gjl8f1d8D/p8w
	hiOYFeZo67nDYU79uHfmmK0a1RFNAwS2kyiIb9eAaTlVDTl8uTNn3LhJpveXQB5ilYOBfBKKYLk
	YBWVGzOoOk5A/t4VyujPQcaFb2bOfolRuGyobUKnvjJmHxtdQ5yzTdCqHvA/9GZsPnqYsM/RDsY
	7L+YcghoMYAgs1vKD2hMeBJU8f5oqktWp0oTZI8Icd5gdEu4whrBR+d9HOshsx7hCyCy+C3AOia
	hP6967iArN+H/zBq8J0Rgesvw63haNtclFZZxXoFbfkRwd7fJnQM6GGNEiLPEnnvq5WcxjBpfdw
	128uEQZEvWDJZj9uF3+VRzr7iJqGiG6VKxjdCJL+Gudcj2pWmN09ZoRicPcYmRpng5xrKlNQ2Hw
	keniLUHCrKq26Yb2ZvahQHCgrbdgnt/AkygvW1N8q+SjUv9REXn
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1680b5402mr138708295e9.2.1791212958664;
        Mon, 05 Oct 2026 08:09:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6228d948sm3879005f8f.23.2026.10.05.08.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 08:09:18 -0700 (PDT)
Message-ID: <1221dced-b3d1-4e44-af60-eac342b891b6@gmail.com>
Date: Mon, 5 Oct 2026 16:09:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] checkout -m: recreate conflict labels
To: Johannes Sixt <j6t@kdbg.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <cover.1791206658.git.phillip.wood@dunelm.org.uk>
 <b2f86941-6ae2-4105-9284-e5e4d530b965@kdbg.org>
Content-Language: en-US
In-Reply-To: <b2f86941-6ae2-4105-9284-e5e4d530b965@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/10/2026 15:48, Johannes Sixt wrote:
> Am 05.10.26 um 15:24 schrieb Phillip Wood:
>> As "git checkout -m" is recreating the original conflict I wonder
>> if we should remember the conflict style as well so that
>>
>>      git -c merge.conflictStyle=diff3 git merge topic
>>      git checkout -m <unmerged-path>
>>
>> would recreate diff3 style conflicts, instead of using the default
>> config. I cannot decide if that would be convenient or confusing and
>> am interested to hear what others think.
> 
> I think it hurts more than it helps. For example, I usually get away
> with the regular conflict markers, but at times I might decide to see
> the diff3 version. Then I could change the conflict marker style with
> 
>     git checkout --conflict=diff3 -m <unmerged-path>
> 
> It would be disappointing if this were not possible.

I do the same thing. What I'm talking about above is "git checkout -m" 
using the same conflict style as the command that created the conflicts 
when the user does not specify a conflict style for the checkout.

     git checkout --conflict=<style> ...

and

     git -c merge.conflictStyle=<style> checkout -m ...

would continue to work as they do now.

Thanks

Phillip
