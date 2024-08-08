Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0552A8CD
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133931; cv=none; b=t86ZEBzelitVg5WS3pque0sfxe0SW0P4lPYY72OCsUXWTYqRTQwkhT3rmnBpaP+7tUOv9PYoaxJx+0vx/l3F7GUrQijYSGcoOuZq59jV0/As1ez/7D1OQiPf5Pd/w6FFLKbrEjoK8lBHhefQMMotLi+2xWRb8SeUPmI1jmYEhJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133931; c=relaxed/simple;
	bh=xbSEL84mAsE4EET+Q7zDKfKiZD4mzqo4bW3+ZOj9kBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=av8x/MOnnSHa0AWCTk+hR14y9JfVRt2DLUs7AaDZ/j43i146LtBx7jlfOgLFaX05UWcTij7BLanSxBYaylT18sG+0NR54V8ai2pkG/QfIwyLCMXrVTLcBRbA8mcu4GEyFGLtHvaqrM0QQW86tK+MuHkAuZXz+c5O9BY+4xJ+ej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If1eIG7I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If1eIG7I"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42809d6e719so8649695e9.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723133928; x=1723738728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gu3SluJm77l8rusi//N2VJj6WrPyVMgTXnoA9+DaRDg=;
        b=If1eIG7IDXGm9xXNtQz6ko2V8l6+3elaka/yHQWUw7NfzXV/HqpfeCW4QCpIvoGtez
         cLpPkVOW3FON71HMJISQUV/ZfZRjEor5WKO3HvTFz2obHFjfwCRa6SgNRBcXwio5dAnJ
         77av921MXgr9OeOYBgUs446PQeQhvw45BwmQ21HLg41ORvrwBNdNxcf10HjQ4UbQpd04
         431DpZ8sZBNpLlHP0qGqnUY1K4WG2gwRBDEcV+K4MPz3zewmuxSZQPJqOkUlDcomVGoo
         6AsjzqV6G28kfuapLJQCBAEB0J4ikxk4b+m3irC9VSY0XmtWhML5BW8ICtMmg4LJMLWc
         I1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133928; x=1723738728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gu3SluJm77l8rusi//N2VJj6WrPyVMgTXnoA9+DaRDg=;
        b=arFx+YuxJyeE8YETCh+KL38EW+xg+RrJ9h56EKFORGdbZGQnKNItjG2kkDx7c8bQ1t
         Uc25htLdmc552dUHMwSWBnIXjxjQu3eI20WH/nEJmxT9lojdNoqQ8N/fTHz8S3A1yu8H
         kTjoXU9YIH6aJT74kNyH3Z0VngE0+3TgRKhRrGPz2eew2o+k6ZL915ekeRPHd4k0Surk
         m+oEUJFGXUS/BcPIoCipHp1LFHyqHgpl6dUm6TkEhtQNVJ7jHawBmZrl+sE4kCyiAFaB
         Xa3FgKjqY/D+a6BiPHjFjZ3r1+0jRJZv3LXIB/v9ClHy/3A6iuhchd2MpNAo0Ix4Hv3t
         89JA==
X-Gm-Message-State: AOJu0Yzm/8D5vvn2zryljmAF1Wge5WjN/87gh2RAHgBham6rLFzN180g
	XV/7AdODqJ5qLzHH7yxVB4pMZOukulKVp0oG0Ya8JwGy222QqMirBnwznckNP9I=
X-Google-Smtp-Source: AGHT+IFB7x7LN9KaJrO+5lu0/D0zX9+OlfhyB6RKpcEzlILlcfCGSzbZnbAErDVNaJHVinR84LveYA==
X-Received: by 2002:a05:600c:3111:b0:426:6696:9e50 with SMTP id 5b1f17b1804b1-4290aeae226mr17353625e9.14.1723133927589;
        Thu, 08 Aug 2024 09:18:47 -0700 (PDT)
Received: from [192.168.1.6] ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm31932295e9.37.2024.08.08.09.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 09:18:47 -0700 (PDT)
Message-ID: <485c3474-992f-41f3-aaaf-0ad1d43464c4@gmail.com>
Date: Thu, 8 Aug 2024 19:18:43 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] [Newcomer] t7004: modernize the style
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20240807130259.28381-1-abdobngad@gmail.com>
 <xmqq5xsbkolo.fsf@gitster.g>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <xmqq5xsbkolo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/24 18:42, Junio C Hamano wrote:
> AbdAlRahman Gad <abdobngad@gmail.com> writes:
> 
>> - Remove whitespace after the redirect operators.
>>
>> - Move number of expect files prepared outside of
>>    test_expect_success to be inside the tests that use it.
>>
>> - Split some lines that have two commands into two lines
>>    one command each.
>>
>> - Turn some "<<\EOF" into "<<-\EOF" and indent their body.
>>
>> - Avoid using pipes in the output from "test-tool ref-store"
>>    and write the output to a file.
>>
>> - Change test_expect_success that are seperated from its name
>>    to be on the same line.
>>
>> - Avoid separating test Description and test body with backslash
>>
>> - Use single quotes instead of double quotes for test description and
>>    body.
>>
>> - Use write_script which takes care of emitting the `#!/bin/sh` line
>>    and the `chmod +x`.
> 
> I gave another look and they all looked fine.  Except the title of
> one step that said
> 
>      t7004: test Description and test body seperated with backslash
> 
> was a "Huh?  what does it even mean?".
> 
>      t7004: begin the test body on the same line as test_expect_success
> 
> or something?  I dunno.
> 

Thanks! I'll send a v6 right away.

>> There are still tests that could lose exit status to pipe. This needs
>> to be modernized too, I will fix them in another patch series.
> 
> ;-)
> 
> Another one that I noticed is that we have quite a lot of
> 
> 	cat >expect <<-EOF &&
> 	v1.1.3
> 	v2.0
> 	v3.0
> 	EOF
> 
> that can be shortend to
> 
> 	test_write_lines >expect v1.1.3 v2.0 v3.0 &&
> 
> To use without extra quoting, test_write_lines is more limited, but
> the majority of here-doc used for expect files in this test are
> enumeration of tag names that we can write without any extra frills,
> and test_write_lines may be a very good fit for these use cases.
> 
> Thanks.

I'll work on them the next patch series.


