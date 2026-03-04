Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4634D4D2
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639803; cv=none; b=M7dG5FPAeFZtPmZK30/c+zhN5u71hskovulN/eVGMYDxW0Q3yrQkyvTPC+xLjOyF0QmRRP5J28K6l/Ny03hhfdjDHKbcSeD7cpoYq/MDV6H4LN8JTZ/ykUp6ZXrfESAgCe+KjEuheOXz5ceulpQ+Ukl1EjOnDJCQCnTdQ8W52nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639803; c=relaxed/simple;
	bh=b/B6Gd9tJtERMHyIrNaygBhSivo5RZjooOfIcFKOBF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXaAtp7+UJEMDh05ss0EfjWAk5joxFUQHQb1xXWDxUB12EqxvcNcXdwJY4lpKkeHXhxZEja0+uUjPe05rkRXrGYDNAgnxhPH1vo7J/dEXSxu1eR6Z1sbFqG3XXku1QjMcwTl5VVFOgJrjal4zYTUF5zIgtY7R2rP4WYBNPfQ3Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp3J8Dlt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp3J8Dlt"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso4069495f8f.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 07:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772639801; x=1773244601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5GaNng+0WJkgOMHJKXQsAB99yfOa4JQgNXKAgl1dJjI=;
        b=Mp3J8DltUYVF3QvlwwoRKT+7oulvToNu0iNB4QuWml480ISK0vJc07Y2/dPSpSwMdC
         uVq/6IojHZKPI1d01LGFnXO78Repsxpi3Aajd7fb1tdtjBIT/ggCsTJVe0qtnEriDPpa
         +iPGX4GTTkSuITL7lZFEJTXINBZrB0UzIovx781d5HbSVETWNZiRgJoE42Vs9jYBD3Af
         P9b76cfPWfHWtjAp3Zj3KUgLvhiMxDSgfaNMjK1jgutgSjzk/okBl2m9icNHv340yg6K
         V3uijszf8tpnSNP/FV2znCkAX6HxlJunge1OQ5Khn5T4BedmwmfKGkPYe6pLrjX1ZIgy
         RwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639801; x=1773244601;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GaNng+0WJkgOMHJKXQsAB99yfOa4JQgNXKAgl1dJjI=;
        b=No1jRJAJn0GYRSd6pj3M4U5K1IBzWace7px1kcmp0DWij5RdE0JEImVaV1vH8I8ed9
         geqFrIboSJlK6/eAAw+dsZFGJz9JU4KKsdXt8yQMZimTcp//5ZhTJU6a6qINDuCA3SMg
         pi1uRWZnxHgBRUfCh5q8lI+yEw3KqbcfBaAix4Cc2adWcqYnQrUKX8dMAMbB0x8xmn/P
         uNUizamGyzEn5fHpv2pse4Lkb3hCECsw8bsnqNI6+JKYDDEtL69M+t43gtPWhF8OEhQq
         PE8Ux81jFGlVOk5pWGZkOpR42MqnMrklLv9Fh0qpa0XbpLNTpss/P2PSBsBQS0oTn3dY
         +/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXbhpEVdMmwpBW3SKiLF0M5fBuAiPjiAFYnLTs39wkNeU65p0AqU/K+7EyNatRqKTPt+Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbhYhs2vdD///QPkCy0/IhHBhflLf2fAqzWaeDNRkGcP8V+hxe
	XeFJgSTul+tHqbmBc0WCV1XOJwCdakxtAiTpJMuuI198Ao1UusvBiM8z+ieTnQ==
X-Gm-Gg: ATEYQzz4SE6l0lcIKYh8RTqXgbyVrMUFQLYJ1x37AotEElQRA/gssYtvLhN3jzWzlZc
	BJbk623KKLfPw4mCZinJnYXawvE42sumQ0pLGrs03l2dE1Y1yufj+iMm7KziZrFExgqYvRY6ah8
	G0VtIU4REdnxv5b5ecD8Ax3TggiadmjtIMSna5FdPgR3hnfV91Pb8MdiAEvSRfSDaQz02zb9szm
	Lq7onOcC7kQyqH68hq+S1s3Qm8WKlCQNScSWcu8/g752asRM2L/Wz5JxLu7JGWxK7qRLwcwDoPN
	8ieRebGrm5AFxx5wUW7jXaCxy1o0J3orkn+1NCfNwKDuQxHYNYmXOXJwYQcMxkk+WvuvTS6spU1
	rn2fz4i880BMg/3+lpZ9+97ZDACN5ZwyAvQStZRzy/nP+Ojbn5qki2mmYSSwscK0Yb2LlBZyQk1
	Yz2edW04iLfXhiA06r5qi7Cz8D269c0WFgGQlrQJ0suX8Tv12wSmGyUdKRLipemCON+5mrxHAI3
	LZZzA==
X-Received: by 2002:a05:6000:2484:b0:430:f40f:61ba with SMTP id ffacd0b85a97d-439c8014495mr4902577f8f.41.1772639800710;
        Wed, 04 Mar 2026 07:56:40 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503424fsm28599034f8f.22.2026.03.04.07.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:56:39 -0800 (PST)
Message-ID: <28ebbc8f-4b3c-4d2a-b9f4-046de95923ed@gmail.com>
Date: Wed, 4 Mar 2026 15:56:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Editing GSoC Project Ideas
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 Christian Couder <christian.couder@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 Git Mailing List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
References: <c67066fb-f857-4738-a3a2-53108c57456a@gmail.com>
 <CAP8UFD2Q7gctwzGOe+rbgdXZSbDbV0dmM-cx4qt_d8nKi88=HA@mail.gmail.com>
 <8bf53293-f2cb-4780-9ece-a77f32f485d7@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <8bf53293-f2cb-4780-9ece-a77f32f485d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kaartic

On 02/03/2026 18:03, Kaartic Sivaraam wrote:
> +Cc Stolee
> 
> Hi Phillip,
> 
> On 02/03/26 03:48, Christian Couder wrote:
>>
>> On Sun, Mar 1, 2026 at 3:26 PM Phillip Wood 
>> <phillip.wood123@gmail.com> wrote:
>>>
>>> I'd be very grateful if someone with write access could please update
>>> the description of "Refactoring in order to reduce Git’s global state"
>>> [1] to stop recommending moving settings from `environment.c` into
>>> `struct repository_settings`. That struct was originally added to hold
>>> config settings that were already lazily parsed. We've had a number of
>>> submissions that move eagerly parsed config settings into that struct
>>> where an invalid config setting causes git to start dying in unexpected
>>> places when the lazy parsing fails.
>>
>> Yes, we should definitely update the description. Thanks for telling
>> us about this.
>>
> 
> Indeed. Thank you for the suggestion. We've tried to tweak the 
> description accordingly. Kindly check and let us know if it still needs 
> any tweaks:
> 
>    https://git.github.io/SoC-2026-Ideas/

Thanks for updating that, it is certainly much clearer.

>>> I haven't been following Stolee's work [3] on "git conifg list --type"
>>> closely but I think it introduces some functions to parse config
>>> settings gently. Those functions might enable us to parse some config
>>> settings lazy where the functions using the lazily parsed settings are
>>> already set up to return a error. Doing that would require careful
>>> analysis and should not be a blanket recommendation.
>>
>> I haven't followed Stolee's work either, but I will take a look.
>> Thanks for the pointer.
>>
> 
> I've not yet mentioned stolee's work in the tweak as it is a work in 
> progress. I'll leave it for a future enhancement in case it is really 
> worth mentioning the same.

That sounds sensible as none of us have actually thought through if it 
is useful yet.

>> In the meantime, if you have concrete suggestions for change you can
>> submit one or more PRs to the https://github.com/git/git.github.io/
>> repo.
>>
> 
> Just to add to this, any patches via mailing-list are also welcome if 
> that's preferred :-)

Thanks I'll bear that in mind

Phillip

