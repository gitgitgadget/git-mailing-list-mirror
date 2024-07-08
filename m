Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75A9461
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451897; cv=none; b=LMrkXRiUEd151rNlblHbEP8vRxSWdW9mAClAMQKVs2h5BhDjcQEjEoPfTMjj7t196P0gdTuTKvYaMV/shTpW2NOlKLWl1ReNEvVTXpNVxKlcfo2A7an2QG4ayhlA3+Nu9ogeOqXWjFXEaSe7IpG/9O6fISaEUwcFL45SVNC0nm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451897; c=relaxed/simple;
	bh=xIjiE/feZSTf6MqMSkCFGLj5SjqHsH0IdoHKLYimGHY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qt2gR705A0URLOzcRUjKp8OokN5vnBNiCCZ5O7HkgqSxDnvn0qkKNyX1MzlRkx/lyf48nuJrJ6fJaVmqvgIunjtGdG7douRLLYldS8irMGGGitJMWXvSGjEqL+GPZO7L/6V8WVzirvYKgaTZIUt4jj+YjdQJA7cBL5hNYnV1ZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIMzcD7G; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIMzcD7G"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-426636ef8c9so10824205e9.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 08:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720451894; x=1721056694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaSKtyU650WkdYxbydWuOfGr8xkFAaVGOyJrD0kdEko=;
        b=dIMzcD7GLUNrUmcel1y24NOZDIlwcuMeDA21ao8xRZ23FS1dfwcYS7FT/lxYCAkK3g
         FVS26ODgUtirv0NRjaHclkdSZ+odxoQiTN9/8ThhRk7SxtTqtFctCBh42qR40GM8oert
         gO4aX1SuoOmJrHOP/p39mkKz5x2MB5RrxVJTXSlA/vbqw5kuy5rjjzOELY6MvHj3Pz64
         c40Nzg/kUcVQmB5141AwXd69j0B5i7iZarmgEXghFcZlYwgXK77igzyLdTiA5m4pDDOE
         UMDNDQWjlRPiiyoVcxXytKZheypKzHrixuHUywv2yMnl9HhxSfPlJQ4eOlKHxeisI0E8
         dNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451894; x=1721056694;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaSKtyU650WkdYxbydWuOfGr8xkFAaVGOyJrD0kdEko=;
        b=LQnrkK1+LJhAo0ZF52yxqPG1nwQVsx/HeKkzKA0D4tO2nflpuldHYvZiuwb4T41WH/
         RGeWo6i+lQpWqN38mFJDdxKU46wP0UGJC0PgZDSeGTAmeJwEuirqI0tyDmm6KtyAIfbv
         byRWlmq6nwop3m8HF1QUkuXryO1bN5c4XT0Dg6dnczm2Dnx6/fuiKRf2PzZAxHnGQ+E+
         2k5j3weTI9D1KyiIFJY42HvL+qMQCMc8x7o7U6UE+DYpQ3jWRUFOQg/11uF/latREbMs
         gnzO9ZzeD+WVTakJ0Kl09DuXT81+9bPqbBxwBvzO9AQRunYXLk5eltGeRNaG/jlw7CDq
         JZaA==
X-Forwarded-Encrypted: i=1; AJvYcCWDKmfsbD3eBPwVt61XhnAxj757kWKWbzaz6Mdv7c5i5P70yWP0+wfdwJcjcbgusbcZxcksb0h7RzrtrzklKp5fZJf3
X-Gm-Message-State: AOJu0YyXwmtlo+uFMr0C/lknV0qQE6qTM4g+N60KK9+YOxTm5Vgf6kOP
	cczqu1hWWnQp1ILDD/57UshrGOUHounClWy5E1lypKtYMNxfC5SNlOAgww==
X-Google-Smtp-Source: AGHT+IF+aLvWiaz0L4IYR1Nto8w0kObFIoVIEg15s4irnIWAVp0fKQP54QVw3jJnunEQtH6TrDxqtw==
X-Received: by 2002:a05:600c:35cf:b0:426:549c:294c with SMTP id 5b1f17b1804b1-426549c2f81mr68070395e9.35.1720451894208;
        Mon, 08 Jul 2024 08:18:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61c:a601:7f88:feb2:513a:4c20? ([2a0a:ef40:61c:a601:7f88:feb2:513a:4c20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca5casm171150935e9.32.2024.07.08.08.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 08:18:13 -0700 (PDT)
Message-ID: <69ec31f8-2cac-48c3-a513-0f7f21607c88@gmail.com>
Date: Mon, 8 Jul 2024 16:18:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/6] unit-tests: add TEST_RUN
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
 Git List <git@vger.kernel.org>
Cc: Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <8175f239-8d4e-49f7-ae0d-dba7df8c365d@web.de>
 <51ebc0fd-ddae-4bdb-a5d6-c92ce8b1f3e6@gmail.com>
 <97390954-49bc-48c4-bab1-95be10717aca@web.de>
 <8802b3ab-9986-47bd-be80-51ac599b2892@gmail.com>
 <6c83357a-825f-49d9-8cc2-e81415e8010d@web.de>
 <62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
Content-Language: en-US
In-Reply-To: <62d221cc-532a-4a6d-8e96-b5a246ddeb1b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi René

On 07/07/2024 08:20, René Scharfe wrote:
> Hmm, again.  I can see the appeal.  How to call it?  Given that the
> foreach macros have lower-case names, perhaps to indicate that they act
> as control flow statements, not function-like macro calls, would we want
> lower case here as well?

I'd automatically assumed we'd want an uppercase name to signal that it 
was a pre-processor macro but I've not really spent any time thinking 
about it.

> 	#define test(...) if (TEST_RUN(__VA_ARGS__))
> 
> 	        test ("passing test")
> 	                check(1);
> 
> 		test ("split single item") {
> 			struct strvec vec = STRVEC_INIT;
> 			strvec_split(&vec, "foo");
> 			check_strvec(&vec, "foo", NULL);
> 			strvec_clear(&vec);
> 		}
> 
> Can't get much cleaner than that.

Yes, I like it

> Requires learning that this macro is
> not function-like, but it's probably not too much to ask.

For someone new to the project it should hopefully be pretty clear how 
to use it from the existing tests once we have a few more test files 
that use it. Maybe an uppercase name would signal that it is special?

Best Wishes

Phillip
