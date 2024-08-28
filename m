Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581018786F
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851087; cv=none; b=gsUbDN/JsoA/i7tabs8xdfFhz/72SAyccwAQoqMx6bVfUaf64Bq9BOQ4C4DcNycLpVBEn+BL/4iaonSA9iH8SJwuUiiwtS8DInROJxqxSUkqBY4JmG3Ed8Q6MxEOFJpBtMQ2BM/0QbkpSVLZJgRtmE1IHQ0vnxnEFHnURiRWouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851087; c=relaxed/simple;
	bh=NZjC8EVLFhillKwHeV6xzr4WoT57irArC44OL+dJF1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xc2ni8vVDidN448EBa7xx8W8KRZDtgahzMbPEhObiuqvRdxY7oOY8j/V0T5paypK3xldszWy08xKQeefgAqd+FDP3bm+03HTGzkzE5HXrtBqFI7klc6QEbpgcYVXP3SuuoUrg+l50rx8kZRB2OJ2eVH6zl+yX+bPZybPcSwBXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWAuzkT3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWAuzkT3"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso86558601fa.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724851083; x=1725455883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HijdDqTcCB91CvCT1WfzN7amqfnXAAFFYB2JAkQk8xI=;
        b=TWAuzkT3t8DQpVttC3z9c5AG4ElZfemrkVq8vbyqMzvMn1MUNf9b7WZ3oCS2V2jcEV
         kshqV3JJwGsG5ydJZJCb9P51f8s4SZL7be107hDo5W7wY6d6lUXIDz5kIkR7zRw2NEAf
         fUz5xedIi+1aL4VI6+iUaufJTgmI3HU4gLI2cwAk9DVS6rb9EQbj+/rh7VYP/oZi8r2O
         e6gqs4QVLegW90J4kU5FCeqCpnO5bkio31hCUoEHFQZpP535b9l+RgKtWmGwyYrOCVEO
         +0Poqimg2ChKGBXmrZd6MgS/Q9rU2Ga/2wBerb9EAfZc4g9vYezUZXTWgEUZolixxslu
         HG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851083; x=1725455883;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HijdDqTcCB91CvCT1WfzN7amqfnXAAFFYB2JAkQk8xI=;
        b=YDrzPOMPwGw3uRp/wxSM10RD0El77Z3E9EGFawEvWHncSFU5Gr/XYMdUASsGnPENG+
         ycU/9qV2NKTVPgtgR9NCZEZCYAFdlyi8TNj8VNVFGi1wT/bJyZfyg9D8Z/Zwd/g7kP3h
         mo6SQZIi7dqJx2qcwZ7nwl27tRZVfcpI8DKgqNMyZ721SfgOo0e7fvrwzGtMg8alrxzX
         E3EfYpU78xnw1TXlHyfg7oJ4JRhWFO8kOAhltIUesvrnsdWPyHlBWIOCf0Mq4+T81wWB
         LJfbkj1AU/AqRh8xnhmAcnlLvkblKEGNEkn6KE3+I6g0Q8jflr6+7km/EKqxeYS6md8O
         XXWA==
X-Forwarded-Encrypted: i=1; AJvYcCXaMafL3HIN0g0iRYSOhVSvq4aw7S1Q3rEYIZtLBQEjbJPPPHOHQY5FpDJYOgBIyn6Q+xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXPg1RX6dzOc5LpLofkFEKXPVSUx2Ypib9OlboZPxCjNaVEYD
	LnSUKnNkCHQfczZkAKPvJAJVYdUL24TAX8Qvysh1bTwTCEyRxobW
X-Google-Smtp-Source: AGHT+IE/aeYzJY5yyhh6BmvYNF+3PSPx2o9rGU2uAdRJJwKoiUfBwIBSYVS2l1b/zVpCoKHE4hbqeQ==
X-Received: by 2002:a2e:a991:0:b0:2f5:d4e:cdb9 with SMTP id 38308e7fff4ca-2f50d4eddbcmr68535661fa.17.1724851082674;
        Wed, 28 Aug 2024 06:18:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb20eda6sm2269485a12.48.2024.08.28.06.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 06:18:01 -0700 (PDT)
Message-ID: <2dbdb173-9e31-4dbc-a65a-dd952ec1c213@gmail.com>
Date: Wed, 28 Aug 2024 14:18:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 12/13] t/unit-tests: convert ctype tests to use clar
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1724159966.git.ps@pks.im>
 <1ac2e48a7f2d41d60ff56890d8d87125f30c2f76.1724159966.git.ps@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <1ac2e48a7f2d41d60ff56890d8d87125f30c2f76.1724159966.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 20/08/2024 15:02, Patrick Steinhardt wrote:
> Convert the ctype tests to use the new clar unit testing framework.
> Introduce a new function `cl_failf()` 

This is a nice addition which somewhat mitigates the lack of an 
equivalent to test_msg() that adds addition context messages to test 
failures.

> that allows us to print a
> formatted error message, which we can use to point out which of the
> characters was classified incorrectly. This results in output like this
> on failure:
> 
>      # start of suite 1: ctype
>      ok 1 - ctype::isspace
>      not ok 2 - ctype::isdigit
>          ---
>          reason: |
>            Test failed.

"Test failed." is not the reason for the test failure

>            0x61 is classified incorrectly
>          at:
>            file: 't/unit-tests/ctype.c'
>            line: 38
>            function: 'test_ctype__isdigit'
>          ---

This is rather verbose compared to the current framework

# check "isdigit(i) == !!memchr("123456789", i, len)" failed at 
t/unit-tests/t-ctype.c:36
#    left: 1
#   right: 0
#       i: 0x30
not ok 2 - isdigit works

The current tests also shows which characters are expected to return 
true and distinguishes between the two possible failure modes which are 
(a) misclassification and (b) returning a non-zero integer other than 
'1' as "true". The new test output does not allow the person running the 
test to distinguish between these two failure modes.

> diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
> index 66ec2387cc6..4c461defe16 100644
> --- a/t/unit-tests/unit-test.h
> +++ b/t/unit-tests/unit-test.h
> @@ -1,3 +1,10 @@
>   #include "git-compat-util.h"
>   #include "clar/clar.h"
>   #include "clar-decls.h"
> +#include "strbuf.h"
> +
> +#define cl_failf(fmt, ...) do { \
> +	char *desc = xstrfmt(fmt, __VA_ARGS__); \

In our current framework we avoid relying on the strbuf api and 
functions like xstrfmt() that use it as we want to be able to test 
strbuf.c with the framework. We'd be better with a macro wrapping a new 
function that uses a stack allocated buffer and p_snprintf() like 
clar__assert_equal(). That would allow us to upstream this change as well.

> +	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
> +	free(desc); \

This is leaked on failure due to the use of longjmp.

Best Wishes

Phillip

> +} while (0)
