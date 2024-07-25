Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5313BC02
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900733; cv=none; b=uwzzP6grfGUM9QdydmDq9VS4vVa1BIHi5lcpBd312jD9y92ZmA4ds35pP/zuKE8ASj3fEfz/Khfh8vPhtplHHIHql5BytL50DB8m8ktVrzlXlxSQGIsjFjUMZSOoysMHgX60pHBZE0bZ0MSWo859XlNayZfVkzxfb8WcTraVIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900733; c=relaxed/simple;
	bh=O6Rb2UNzJW+qpyENU1xhID3m3Rde7YztJk0D06I/5EE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q7ognhaX0Qk95JmL0tqlcf6d/P8dA8P3okeWamN25yzd2tia4JFkIwFw/HwA1FF9IjCVpeIAcfwf+N9hqTjskc9LbV5+Ajox+lHfJ2V+ipt3X4U9lX/EQYtdRmNC2QtSxpZmi9S2RiWyVcwPZh7ZXf/ooNKV4NEQABuiY/0SpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUU8rvyu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUU8rvyu"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36844375001so376167f8f.0
        for <git@vger.kernel.org>; Thu, 25 Jul 2024 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721900730; x=1722505530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fzZRUPQdjHZ7mAkQwkvcQMF4ZNxoa2OQPcDO1ld2i2o=;
        b=eUU8rvyumdtgEe2/5oOELQkvItLF6SzoM7ywd0J9ETWhOZXzVrKKY2wP+csC2Uy2A/
         DoyUDPUFZN3y5oG9gLAcw2T9WLajXazi6LtbT6SrPMP5q8QnC7wBwD4DTHMvbCSofS9z
         2CJ1yo24DlsU2EB9VHvclNaaQDU6DQbGIpX6RGTv7tp6pVIkxCYoQzKrW6b6V1eaGZSJ
         WLXzwB82rWgVetQf+HajTJdawEt7zTQsWh5OdlOESvXpa3UrS5eglPTh4HIiKNnke6Zv
         RChhek7sjCB3fsGrGOvOSlqrm6q9PKKzfutWh13NjIaz0F1XpN5PvSOZj75FI/qxPDTd
         zcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900730; x=1722505530;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzZRUPQdjHZ7mAkQwkvcQMF4ZNxoa2OQPcDO1ld2i2o=;
        b=aqdO30vtau0IfLi/LgYAwzEemHOnpuQD3NUJvxaD9dIwNIMtPF2IV2iNN0+tUaWWYX
         60B8nGocZpMUNdZuI1Psnan6daP1ropV3S4icz8w8PJZhoA/AFQUmZ3iAnJ8XqHPrDJs
         MRLjYlB7Qh6zU39LdxuVvbykYp3FTy2twXFPEvVZ8a4/ctwegB3/qpiJxOk1IpBCXRlf
         ZO2tsGgte/pWunwynDrAJRzVbOGtK9PIO1LVBqPavXTJCekTsaVNIxPHyPRJ8O+JTXe/
         epPPK5VDCUnFMif2qIadCqe0c8uwSi/dq1eOjvKnIdvlu+18AZrdTjpJMez2xdhBC8V6
         ZXzg==
X-Gm-Message-State: AOJu0Yx9DK3svEDsPiHqaSCSkYWWmTcK2+dkTIWNTWrunREEN61R9jdb
	0w83doP1rHFtjtnhQFQfLH41NkSWWpFM+PIh+t3EFPd2vnG+4Fsza1TFX4Rg
X-Google-Smtp-Source: AGHT+IE9OfM0rUAJpBEKUQ5+3a43P4s12pQGUpfAsTmpur6W/GAbCCjNq9hKS/wMpg741CfqABWHrA==
X-Received: by 2002:adf:f701:0:b0:367:95e8:3aef with SMTP id ffacd0b85a97d-36b31a4187emr1807228f8f.42.1721900730258;
        Thu, 25 Jul 2024 02:45:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d? ([2a0a:ef40:683:1601:9ca9:646d:b3da:7e1d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9372a3fsm68824595e9.13.2024.07.25.02.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 02:45:30 -0700 (PDT)
Message-ID: <0a9fac5d-a8e7-4b4f-a681-878c1efdf488@gmail.com>
Date: Thu, 25 Jul 2024 10:45:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
Reply-To: phillip.wood@dunelm.org.uk
To: Kyle Lippincott <spectral@google.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>,
 Junio C Hamano <gitster@pobox.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
 <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
 <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/07/2024 20:24, Kyle Lippincott wrote:
> On Wed, Jul 24, 2024 at 7:53 AM René Scharfe <l.s.r@web.de> wrote:
>>
> Macros like this require additional cognitive overhead to understand;
> I can't read `for_test ("for_test passing test") check_int(1, ==, 1);`
> and understand what's going on without going and reading the comment
> above `for_test`. Unlike `TEST(<func>, "<description>")`, I can't even
> _guess_ what it's doing. This macro is project-specific, and this
> knowledge has to be attained by everyone wishing to even read this
> code.

As well as the obscure name and oddness of using "continue" to exit a 
test early I think having two ways of defining tests also adds to the 
cognitive overhead of writing tests as one now has to decide which to use.

As you say below it is not clear to me that the changes in the last 
three patches that start using for_test() in our existing tests are an 
improvement.

This will be the last comment from me for a while as I'm about to go off 
the list for a couple of weeks

Best Wishes

Phillip

> I personally consider the patches that use this to be regressions in
> my ability to read and understand the tests. As an example, one of the
> diff hunks in the strbuf patch (patch #6 in the series) does this:
> -       TEST(setup_populated(t_addch, "initial value", "a"),
> -            "strbuf_addch appends to initial value");
> +       for_test ("strbuf_addch appends to initial value") {
> +               struct strbuf sb = STRBUF_INIT;
> +               t_addstr(&sb, "initial value");
> +               t_addch(&sb, 'a');
> +               t_release(&sb);
> +       }
> 
> But the main simplification in that patch (not using
> `setup_populated`) can be achieved without `for_test`:
> 
> + static void t_addch_appends(void)
> + {
> +     struct strbuf sb = STRBUF_INIT;
> +     t_addstr(&sb, "initial value");
> +     t_addch(&sb, 'a');
> +     t_release(&sb);
> + }
> 
> -       TEST(setup_populated(t_addch, "initial value", "a"),
> -            "strbuf_addch appends to initial value");
> +       TEST(t_addch_appends(), "strbuf_addch appends to initial value");
> 
> It seems to me that all `for_test` is getting us there is an inlining
> of the test logic, which seems like it's optimizing for vertical space
> in the file. Maybe it's because I'm coming from a C++ environment at
> $JOB that's using Google's gunit and gmock frameworks, where every
> test is in its own function and we usually don't even write the main
> function ourselves, but I have a preference for the separate
> functions.
> 
> Maybe I'm in the minority, so only consider this at somewhere like a
> -0.5 on this series (fine with deferring to a reviewer who is
> significantly in favor of it, but if there aren't any, I'd lean
> towards not landing this).
> 
