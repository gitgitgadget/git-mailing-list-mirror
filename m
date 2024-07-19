Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FC4C85
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402277; cv=none; b=lG+QO1q+eIJMT86cUT8MTXL10hwEC99c20RXKDlKmOswiw1rt1+KEYxxv3jN80Zj15POkD7CrbXJC5h7NoK23/ylc8uBbMmsEXedMivh4bLTtshXYGN+78m3Uv0ImoKIjsUL8VSXq2c6LFA3rBBF5Ndpp2sZa0sBnP+77Gr5r7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402277; c=relaxed/simple;
	bh=V4AZ6QxhWlqfj7ODkmKa2pUzUVZBNqCMccTDmaqXyJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXcULtROoZQ2SduusQTBHxQdkTDnm75YMelkZJs2lk5izgxZSyj3LMn7m1ASGcJA+5tfoNMaTCs3UMmIK2+I8NirFuc4f73YuVK9H2rdDNWYkyMoaaNPO4FgFKdgsd8UG1hfFn8ElYbxEgXsH3JkBS+aL2iAa0MesPFw+UsVjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTikvCtl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTikvCtl"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34677so953144a12.2
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721402274; x=1722007074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Oq6auB6FnPab8LpTVoFUriqaVEknTLna5I92BaHxlHc=;
        b=ZTikvCtlA5pCx4YnU9DPLkwCjtwfyBdjWVSj1g9f1E9bHmeg7Q+j1rzzYkd+Dk1/X5
         SiyiknoixkqBzxb8blOoK/NHplGg7BaNl4PFAudXwkew2NPh7vNtZaUZiQi0xDJJVWuz
         VxB2Do6HsJsbcZpuYRph0BsLGbjJJTtJxsVTDRmo0sRrWBd2eMJEnIszXK5i14gFaytZ
         Nmpf/COD77YZxM5YMWWxwhKp7S3fopallGr7FIUiJWgpCy1SDsy0brVg9Zmqj1bdXS3S
         hvVnjyF2iVJNasnUDFqyjwY2D5eaxu7B12cs1T90XF+FKwt78MPAQkcGlO4YtRz7S/fZ
         cycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721402274; x=1722007074;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oq6auB6FnPab8LpTVoFUriqaVEknTLna5I92BaHxlHc=;
        b=VIhNOLbN7iurDLC/oWgoS3oRro6zNLilP+i0/qKKoTdyNwNoG0aY91+gdFITZLp5Cq
         EDAhJFRUwe8yueieqGy3FygGhdNxKstsP9+ruxl4u2qOUEnQ5nPI3HQxtO524f1sc60N
         fvxA6SHyrqb50G7cCgLG6N7dXnliq8c0E7crB/3uaE4zRHtTnCOn2IocOBBYGVM/G4YV
         OwZhYFCf1Msn9b/AyXVzy4dgSupfu6fAQ43GiPSQE3TbmJSkzxlHMeHaMsN+xzoDrzqV
         zkRcF1zv10PTk/ljn1UtF0h8Q8bYpYEdF5ydvlnNyDeMio4CVk5w7g9Qc40jJcQQ3PWi
         gygA==
X-Gm-Message-State: AOJu0YxJpluaWL4qYn771g4XZBLxC+ae36GmvQM4ReUp4qSnN0H7MLDH
	KrRujRd4kDTrrcUJ7kN6ycNzqYfXmhRuBtTk3z+rIrbfTICTjk7gwlYvo2hk
X-Google-Smtp-Source: AGHT+IG4crZ+4G/YhBrPfjegQIuqtWOeMhvgCP2DXyrXoJoimUYhiBDXm8RtZ5yd381JRiQlAOKE4g==
X-Received: by 2002:a17:906:fd86:b0:a77:d6c7:df46 with SMTP id a640c23a62f3a-a7a01115e4cmr748671266b.10.1721402273915;
        Fri, 19 Jul 2024 08:17:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c78611asm44857566b.45.2024.07.19.08.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 08:17:53 -0700 (PDT)
Message-ID: <6c7dfa30-6d4e-4b87-a25a-c1f85c83a6b1@gmail.com>
Date: Fri, 19 Jul 2024 16:17:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1763.git.1721312619822.gitgitgadget@gmail.com>
 <xmqqikx2wtn4.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqikx2wtn4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 18/07/2024 17:29, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When "add -p" parses diffs, it looks for context lines starting with a
>> single space. But when diff.suppressBlankEmpty is in effect, an empty
>> context line will omit the space, giving us a true empty line. This
>> confuses the parser, which is unable to split based on such a line.
>>
>> It's tempting to say that we should just make sure that we generate a
>> diff without that option.  However, although we do not parse hunks that
>> the user has manually edited with parse_diff() we do allow the user
>> to split such hunks. As POSIX calls the decision of whether to print the
>> space here "implementation-defined" we need to handle edited hunks where
>> empty context lines omit the space.
>>
>> So let's handle both cases: a context line either starts with a space or
>> consists of a totally empty line by normalizing the first character to a
>> space when we parse them. Normalizing the first character rather than
>> changing the code to check for a space or newline will hopefully future
>> proof against introducing similar bugs if the code is changed.
>>
>> Reported-by: Ilya Tumaykin <itumaykin@gmail.com>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> Well written.  Thanks for a pleasant read.

Thanks to Peff for letting me steal his commit message

>> @@ -953,7 +960,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>>   	context_line_count = 0;
>>   
>>   	while (splittable_into > 1) {
>> -		ch = s->plain.buf[current];
>> +		ch = normalize_marker(s->plain.buf + current);
> 
> I wondered if &s->plain.buf[current] is easier to grok, but what's
> written already is good enough ;-)

Yes I think that would be better

> There is another explicit mention of ' ' in merge_hunks().  Unless
> we are normalizing the buffer here (which I do not think we do),
> wouldn't we have to make sure that the code over there also knows
> that an empty line in a patch is an unmodified empty line?
> 
>                  if (plain[overlap_end] != ' ')
>                          return error(_("expected context line "
>                                         "#%d in\n%.*s"),

Oh dear, I'm not sure how I missed that. I'll fix that and update the 
test to make sure it exercises that code path as well.

Thanks for your comments

Phillip


