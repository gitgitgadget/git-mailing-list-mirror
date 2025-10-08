Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989082586C5
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931249; cv=none; b=SjPdvjOrMnstE7ay3IFBktCU5yQOt1EfSfZHxTMHgV55gLSkMV4bh0ef1JoQcSkjZatJ89qCkGsRzb1EfpUJURIEQc8t851Df5EGI6/yGOtQqyjkLzulP2L/HgohA5NhEmnFKFJxtteX5Mm00p50H6nWKfZjtCo8ZRvz0kEQWvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931249; c=relaxed/simple;
	bh=jjDm/vefVsyegGkKbQvK7sklKD2xttOEiTNu17DU6nQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=thcRcfK1GuDoLSdf35A4dXWqdg8ypJDY1hVDkz/qUQUQJHc3e1KKFnq04+zKTISwpM4/qBlDA/R0p1EnwY1tnus4dIrMRk/L781x0EWI9jgzBDHWOAt1/Bt/h+49/uTVwQubvKvaQ7qp7I5/3TqSkMiw0MOEo109cUF9T373JzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JazcQVTg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JazcQVTg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso48464115e9.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759931244; x=1760536044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adudNWS2rn3OV370S1mRNIq4JvYYiAS8oHr6hWa41DE=;
        b=JazcQVTgUwcVKpvqencXsjJgNSAUvlT3FTY+EXuo4FBWZk5H3dBjVAF809RuAR0LMn
         kvrgY8noRpwipgkNQB4VlwCZsGlepDdHKx3T64yUqAtczRZSAuRFqiz3EGXt051IedzX
         mp+vQpgZwDSJNHW5KMVtNoCSzWE1NvwYpffTarDakpJhecOqU5IHYte3GbQNMYGQi5pJ
         xQtEhquS69Yygiq1UBgPKsbIcCkc+1SLUGAn7rlmo7XIltAobX1cIzDq9YoaXgxmas/c
         oVloPdEbhALhuD+GlZtBESoBs2DzD9ZbA1p06iMHbQ0pZ0cxH/AE+MBdkLqnXK8ot6bJ
         aIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759931244; x=1760536044;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adudNWS2rn3OV370S1mRNIq4JvYYiAS8oHr6hWa41DE=;
        b=NFkXIx3oFW7HGjpx4LEgZdfExDuJGAI74o4xjQmHY6kV4o1wrAbu9kwpbB1CPWkq6C
         4lsazPwBwGKDbqiNhQ12Cc/4+Q2ziKPKnu/xwz1YWfL0Cxh4AeZiWl/J4Q5leNqKYxy4
         xnNuVWQEtWUQmfjJtXdiKvWV17zoCofwrKTBtmVb0nFpPSKxo+8Hft675tkbogFq6X5h
         3NWyFeZNvzCYE9qzZZVXVI6C3hkP8AK4OYaFoiMPZfb/DGKkm44xtrbyuhBokbeJQ+TP
         cx532l9jEhTruSI7oxPsxarUWnTtWpd7qudvlEyBIM7Z2jqPH36+OMcqFEmVSVoNlOex
         jB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKhH8Lhx2kThI9/KtHONXApNB13CeYO9LmMAwBPB7MI4fe8pIqLGckgZaFAwLC+ebvhwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsMpwplzfj+FioL3uSkKdxSCKOhF/F7bX5AyugopmWpeomE0G
	uHoiQpClq3yz3OKEimNO95i0TQzbCxdO78vtU/upFxVHbx/r2aQAeTHQ
X-Gm-Gg: ASbGncttmLvl/VYwuWztwOxJBnAGr0orB+mb0DRabVgTuQA8mMLTJmR6xObgP6ihtFA
	3+DMrqLTQgJezEqSNrLQldGItclaoQcykkGGUYhDrdQx0jhOA2BErqoW2rt8SniSonlx/g2Qg4m
	X7ZoA8icpm6IQkNA5wZCh/7MK+V2EpWsxKM8oHslq/OJIYVAkHtUdewQOXq5NfoWxBGc9xL1+29
	YXR2A9/Qs1WvgSvNHCrYlRc+NHeWhKAERmDYoZ+qnT8ASn3wjV0g07g+lnkueYDTB8Owsoiub+r
	W/a4A+rFTzPA9kX2pfUCk3W4LHWvGTPxLAAiGnzkLju6fyA7IpgobWNvQyKLTpCn6LRZRSdse1O
	Qn95YcwSjZdIwiOTtQNQIPvlqKj7ie73nrf/BHq+hxf3eE5eTj4WBigc4CdY2hWaw+/cbpOlj/B
	+rlv97NFucq9x97xLV0WDejMo=
X-Google-Smtp-Source: AGHT+IFv+CJbS6VtMjEkA5xGZ5bVTv9mYwaq87lxyX8I80K8TqhubxFvcLY6MywS1VirENb/9+glWA==
X-Received: by 2002:a05:600c:828d:b0:46e:44bf:210 with SMTP id 5b1f17b1804b1-46fa9af8107mr24729115e9.22.1759931243644;
        Wed, 08 Oct 2025 06:47:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf112fdbsm832555e9.8.2025.10.08.06.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:47:23 -0700 (PDT)
Message-ID: <bd51d7df-f0f2-44f5-8ebc-c95b944994bd@gmail.com>
Date: Wed, 8 Oct 2025 14:47:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: roll over to next undecided hunk
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 "Windl, Ulrich" <u.windl@ukr.de>, "git@vger.kernel.org" <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <c72518099a3b465c8761e41210fe3fcb@ukr.de>
 <76665b6f-cb92-4694-bc89-5eb21197df34@web.de>
 <8fdfb03a-6bbc-46a0-a8fe-9ad75aba555a@gmail.com>
 <fcc003d6-c71f-4c41-a3a1-c9364d3bca9c@web.de>
Content-Language: en-US
In-Reply-To: <fcc003d6-c71f-4c41-a3a1-c9364d3bca9c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/10/2025 15:10, René Scharfe wrote:
> On 10/3/25 3:41 PM, Phillip Wood wrote:
>>
>>> @@ -1436,8 +1436,15 @@ static int patch_update_file(struct add_p_state *s,
>>>        render_diff_header(s, file_diff, colored, &s->buf);
>>>        fputs(s->buf.buf, stdout);
>>>        for (;;) {
>>> -        if (hunk_index >= file_diff->hunk_nr)
>>> +        if (hunk_index >= file_diff->hunk_nr) {
>>>                hunk_index = 0;
>>> +            for (i = 0; i < file_diff->hunk_nr; i++) {
>>> +                if (file_diff->hunk[i].use == UNDECIDED_HUNK) {
>>> +                    hunk_index = i;
>>> +                    break;
>>> +                }
>>> +            }
>>> +        }
>>>            hunk = file_diff->hunk_nr
>>>                    ? file_diff->hunk + hunk_index
>>
>> If there were no undecided hunks then this will be out of bounds
>> because hunk_index >= file_diff->hunk_nr. Are we absolutely certain
>> that we cannot reach this point without at least one hunk being
>> undecided?
> 
> The new loop only sets hunk_index if i < file_diff->hunk_nr.  If
> it finds no undecided hunk then it does nothing.

Exactly - that's what I was worried about. However I'd missed the fact 
that we still set hunk_index to zero before the loop so I thought it was 
unchanged from file_diff->hunk_nr when in fact it is unchanged from zero 
which is safe.

>>> +test_expect_success 'roll over to next undecided (1)' '
>>> +    test_write_lines a b c d e f g h i j k l m n o p q >file &&
>>> +    git add file &&
>>> +    test_write_lines X b c d e f g h X j k l m n o p X >file &&
>>> +    test_write_lines J y y q | git add -p >actual &&
>>> +    test_write_lines 1 2 3 1 >expect &&
>>> +    sed -ne "s-/.*--" -e "s-^(--p" <actual >hunks &&
>>> +    test_cmp expect hunks
>>> +'
>>
>> I'm not sure what this first test adds, the one below checks that we
>> find the first undecided hunk which seems to be the important thing
>> to check.
> 
> It's a regression test for the case that the original code got
> right by accident.  It may seem superfluous, but I actually
> triggered it in my first attempt at a fix.

Ah, interesting, I'd assumed it was superfluous but it seems it isn't.

I've had a quick read through of what Junio has in "seen" from the last 
iteration of this series and it looked like a nice improvement to the 
usability.

Thanks

Phillip

> René
> 

