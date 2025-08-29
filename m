Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2370F261B9A
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472771; cv=none; b=EtFPaO/uz1zkRZR+12W1y8F5yunCn3LfvGOpurNeR/PGZebw2suQf7e/KkI2YJZqwzsni5JjoBsDZkzW8Gysj5c7AmTdtjcGPoRG6rO+KOtVOlqaA+/W+FxQoU2/Rnt9JiPSMnBVsrjXEKbk5twN1CqUvIi4sv1kEyPXRiU6dvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472771; c=relaxed/simple;
	bh=ei+tmHqcTFNfJ0lqXm71CW9u4PNL7NX7LmRvER0t+Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiR5jOgmDxyuk+z9SJ4yelo78peI60PwvYyeF7Dnl72jI72cGtdyq2qDIhjmhLlkb809ilfwg9nuNruapLS8gbEvhq3qbSk5ju9/PyceHiEb6Yu3YQZhzC0a1wWdgL9eM27oYfe+MESfrOcQuqc1FPeYDMiFLNHbYD5W82zRIxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUZ4h0vn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUZ4h0vn"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so12113915e9.2
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756472768; x=1757077568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuCEIY9daf64o9U0bw7s0KMMl6eroJU0GI7Jdog3bO8=;
        b=OUZ4h0vnGoP4cCqZgC4alSAxROjmzcLJzSGzyPXuG6epS4ZhDNTmVpbkfgqWwXqKY+
         Y2vtg4+lgE4tz4yCsnWXmTCWccoi1ApAWFCjWVIN+ivfiGHfn6QNW8oDJSgLxfM0tDKm
         kk9XSk9DyG2DygtBCKFSotjlaLw43JrV8KhWkaBRLtzOSuQPLTuXXWytqWRhCXGu7Krr
         y2xVgY/Hro/fwS+ejnaWmCOXtAj9eiqSgxkWbaHSOnWIav1rC8fIoFLMU0oKT8IHBlpj
         r0muu04kyY0YyGN5G6J3QdeMK+hSp2K9Yh+22NvHrOvqTuUBEIl06ROOP8+bVjH61L1a
         +SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756472768; x=1757077568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuCEIY9daf64o9U0bw7s0KMMl6eroJU0GI7Jdog3bO8=;
        b=OF7sI/onEUfnarxsRba0ZGqzIHVG0bbRf4s1+kT7+Noy8WQtZWPjxdoIdfhUcnJ5u/
         +wmtE0Bp9166jr4Go3DORTq1fe4NHQEy+kZZCoTy0Nq9zQNBBBxAGR1Bio4FQkOE3MuS
         FjUzBuhVdEJ1GK7NI8o/q+5kxS2o3DKT+0+2DMZqXMgsoo9YdlprYfJQFF3QdA4BDAT3
         SvVhzeFytm7gLsFAKD4zrDKkBcsDcSvygGSjH3M8uceefoWVvSKyYmE/IeTaEJ2QCU/2
         A7cG4cZAuPq/Op9tVtDOt+LhMJv0TOfB2GdhqX/9Gz1KKztV/Ku4RBQqiJSc+nXqLpUn
         VA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvIhLGsnJrhXqtCdeLaYg9+NEIRAkPcKud9NQ3rx3v2fyPFm7XQadSZfN3yJ5JN/8s02c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUoCLSMcArNwgxNywr5nJxvOk8C84ep3dpbfCrBfRllemsytc/
	XHlVa++lvJO9UTFnRdShh4P4jFhuPo338E5m9ErqTQ6cVPD22+2Ws4ZL
X-Gm-Gg: ASbGncuwnRCpl9r3JxqZcbdYJ9c+blJG1J6+2NtMvwm1xBptZalZLV/WBjAfYbUBatH
	8SCRlFttJH4Q/zdCXaYiApwHdV1kmKFtmkWe14mSv1noMnWFMA9c72kPDXHoKScM8oFewHJQYjR
	K6IRxPhCNpQ+XJU7Wlw8r+mFFlgsyQiTl2+U61aZOFwP/Pm0ICEDq/FprTbXUA9Hcsd6InnyoXl
	oymIAZ4P4V7yaTqOerAr3P9K9BXQiYAIkqlIpKvJmHWuXbyrs6RDG55j7OWjVmlsNhYie2KQxql
	4hOs4aq5gt4oEvWgl1EnuxpK3zu94rjuno6BgurjquV/7q56uSXd+dmpY88aBZsNr3U/B/Q9WkA
	Ix0LS7KdsZGGo2yP+CEQ4caWfeulz6jwaULpuzgO6IggHVp5CSkzCQ7otQJljDbpe7W9nE27+pb
	ok/K1QI6k=
X-Google-Smtp-Source: AGHT+IGjfW5w3sCn/09wFj+qS1Lr3KM3/YQrEs3wMZIn6He0LfrWQFk7QuDxg4jTGxSg1PL+GcvI1Q==
X-Received: by 2002:a05:600c:524f:b0:45b:7cad:7ac7 with SMTP id 5b1f17b1804b1-45b7cad7bd3mr41650095e9.2.1756472768135;
        Fri, 29 Aug 2025 06:06:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:1c1d:4ebf:5a41:64b9? ([2a0a:ef40:7a5:4701:1c1d:4ebf:5a41:64b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab093sm41058575e9.22.2025.08.29.06.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 06:06:07 -0700 (PDT)
Message-ID: <9f9e49c5-5612-4e6d-89af-839b353506f1@gmail.com>
Date: Fri, 29 Aug 2025 14:06:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [FEATURE] Proposal: git stash --only-unstaged
To: Ben Knoble <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
 "J. Dettweiler" <git.vger.kernel.org@dettweb.de>, git@vger.kernel.org
References: <89394e50-9077-4a7b-b30e-afd1be1a40e8@gmail.com>
 <18A45EC6-2D2C-45A2-8802-0E5060539398@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <18A45EC6-2D2C-45A2-8802-0E5060539398@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 19/08/2025 00:41, Ben Knoble wrote:
> 
>> Le 18 août 2025 à 11:14, Phillip Wood <phillip.wood123@gmail.com> a écrit :
>>
>> ﻿On 17/08/2025 17:08, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>> To use it create your stash with "git stash push --keep-index" and then
>>>> use the script to pop the unstaged changes rather than using "git stash
>>>> pop". If the script proves to be useful then perhaps we could add an
>>>> "--unstaged" option to "git stash pop"
>>> Hmph, would the behaviour useful enough that it should be always
>>> enabled, without any new option?  I strongly suspect that those who
>>> worked on adding "--keep-index" option did not expect the user to be
>>> mucking with the working tree files while "testing the staged stuff
>>> by updating the working tree files to match it and nothing else",
>>> and as long as the end-user stays within that originally designed
>>> use case, nothing changes for them, no?
> 
> I can’t particularly comment on the script, but I do think the example
 > in the docs should either just work or be adjusted to work.

I think the example works but may generate conflicts when the stash is 
popped. One can argue that the conflicts are unnecessary because they 
could be avoided by popping the unstaged changes but I don't think the 
example is broken as such.

>> Yes it probably would make sense if we knew that the stash had been
>> created with "--keep-index". At the moment I don't think there is
 >> anywhere to tell from looking at the stash if that's the case but we
 >> could add a trailer to the commit message when we create the stash to
 >> record that it was created with "--keep-index" and apply only the
 >> unstaged changes when we see that trailer.>
> This seems reasonable; I wonder if there would be any interaction 
 > with the stash import/export features? But perhaps those omitted the
 > index anyway, I cannot recall.

It exports the stash commits as-is so it should be fine I think

Thanks

Phillip

