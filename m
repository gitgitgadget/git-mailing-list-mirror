Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812F20FAB4
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149539; cv=none; b=qRlay5/zbHZabTGpif70lgRBzkyTpBk51TLp9Rt6k5N+7bmBocW8KzE4g8bvVffcIscSDwpQ3/mDpTmuq8tpfk6zo3G2MBp30GUKplEfX+aqndiXrCkbqYc1KOSVmxZ72Kj3NIMrjS9KuG6AcW0FNDjamOBUz0mtxjc+5yXpDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149539; c=relaxed/simple;
	bh=tZnLYxja5ZYZvKoFWq2XD8cxG70FLIu790+QjR1kZLg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mXISXUVFrsNIr2KoUnxdUsKf2raIqEM8iPQptOyp/B+XFtPS1PwZLT4FDZ91FeQhz3jdsr+PqJPJ3yR0a2rT9oUgmfSo4q00SuIAo2IibJlZI31xNJi8e16DtugYGjpXRROSO4sl1pl85l6mJpoffZ1VwPqMX7aIDU5FQraCSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egIyxrFY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egIyxrFY"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so2833721a12.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 06:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149534; x=1740754334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8K4OrGQNXdSBP0tANXyc9o2ReLdFP/6exRX5mC4ZoHQ=;
        b=egIyxrFYQJaE2eDbyQeMeigOyNsvsPej8G3K+lHcTlYGiAgf++t4cfzuVH/nKN1h04
         x869oJPc5lS+dQ7mTqZCkNTggTvDjgSQGGUYJ6hYYb/UpvW2SVAOKuekNdicPE0gYsfO
         Rqg2B8PaI5V4AJiioLmQXWrJVPh9oLSbb3vpAoPGKbp9fuE5QsWdyo2dqH2FUwMHvmXn
         oQntsY4N7VISp4K/4BafgMQGoGfa7RjfzpO8ZdT3j/n33m+H0zt/Gnec80xyXuMoumkN
         WmggCnWjnkorObph/pPt0BdSnWzoTVO7tLiD82yjO1c6zoCqbmvuw/DwuUrknA3DsNcv
         Hy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149534; x=1740754334;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8K4OrGQNXdSBP0tANXyc9o2ReLdFP/6exRX5mC4ZoHQ=;
        b=NbHaK1Ks+XBxUv/Sw/KgrUV5o2xFpINBTC4en9XEaI6a/o98TjMn7BGXbcwW2z2W9/
         e0bcY2HSxj91w/EEb3AHQ4DeJG/Pdy0eShyymXlWta1eUZtlUtac3oiqlBNLRNK0TTD8
         Wl0P+vYdBB1u4g15vN5dXOOunaqDG0CWTr5doLZOzxRUuZOCnvsuTcbEiPhaTNNWDQy2
         6QnqJpzd9ZvRGbngGot7Bomn5RYK6gXjvLBMdMjwtO9r0/8TDHcBQAF8T1Dhzl1Dm9Yn
         fP96cNxy6K6arYN/JpLlqo+VMHHayb8o20bOhxFKn/2fRvy10u1U75QfT2J/4jQjkVsZ
         5gAA==
X-Forwarded-Encrypted: i=1; AJvYcCXz7KXk23QK9sPq76fFa4d6T0dZPyTBuZtK0GBtPzgrhQwCYAdEnQ+naxKzw5EN5lNH/Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+13ZZGdVdtZUXPoV1bwXJxAQfjXUSAeZQOVVEIciwQwNjmNX
	UiT19xLN+uE/sNi7Jn3MAse2WIZC30N7VEv41+4SAZiteW8gqWhM
X-Gm-Gg: ASbGncs2rJL79wce8CIix+MRSxgi7+HUs+e+p//LmKXOiAkT12OHV8V5xefk4Z4WwCQ
	ygvjKY7Jv6z8KxZCF/mwB5ZOpQdGCi9d/N8etHbF2OS2AQZh6olyJGiFOS3fkQ1nEYkW0zlNiaN
	fLAJPKtNHXUycPh0Q/Fp9SJZaRinxYkh6p1BGyQv6aYRyjwlLAfLOjpYEPEYwgXlCZk+ewIOUSp
	AChmekKLeOCorWrMAz/ZE+SnLlQtq4vyiScpKZ5bUcFE9okvmLk9rGub4yndCJj0FvnGYp2rX61
	PJRS33OuLKazRAyF/7ijVxqg8/3vivCItjP0BWWea+i1UyYU6Si4lCw4AJ8bqOnheIaxVRKCg/j
	xVYgj
X-Google-Smtp-Source: AGHT+IGVJWR2OpEc/5fJUbAlXCwtsJ8BFG9rz36MfzlRzuGyBrugAsQYu9MRBt/J30s3b23bC4iNqw==
X-Received: by 2002:a05:6402:51d3:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5e0b7252e43mr6271827a12.23.1740149534293;
        Fri, 21 Feb 2025 06:52:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3472sm13725979a12.34.2025.02.21.06.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 06:52:13 -0800 (PST)
Message-ID: <443ecd89-785f-4985-8666-e8caae33306b@gmail.com>
Date: Fri, 21 Feb 2025 14:52:12 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/5] t/unit-tests: convert unit-tests to use clar
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk
References: <20250220082959.10854-1-kuforiji98@gmail.com>
Content-Language: en-US
In-Reply-To: <20250220082959.10854-1-kuforiji98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Seyi

On 20/02/2025 08:29, Seyi Kuforiji wrote:
> Hello,
> 
> This small patch series transitions a couple more of our existing unit
> test files to the Clar testing framework. This change is part of our
> ongoing effort to standardize our testing framework to enhance
> maintainability.

Overall I think the conversions are correct, but we'd be better to keep 
the diagnostic messages by using cl_failf().

Best Wishes

Phillip

> Thanks
> Seyi
> 
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> 
> Seyi Kuforiji (5):
>    t/unit-tests: implement oid helper functions in unit-tests.{c,h}
>    t/unit-tests: convert oid-array test to use clar test framework
>    t/unit-tests: convert oidmap test to use clar test framework
>    t/unit-tests: convert oidtree test to use clar test framework
>    t/unit-tests: remove lib-oid.{c,h,o}
> 
>   Makefile                                      |   7 +-
>   t/meson.build                                 |   7 +-
>   t/unit-tests/lib-oid.c                        |  52 ------
>   t/unit-tests/lib-oid.h                        |  25 ---
>   t/unit-tests/{t-oid-array.c => u-oid-array.c} | 123 +++++++-------
>   t/unit-tests/{t-oidmap.c => u-oidmap.c}       | 153 ++++++------------
>   t/unit-tests/{t-oidtree.c => u-oidtree.c}     |  78 ++++-----
>   t/unit-tests/unit-test.c                      |  42 +++++
>   t/unit-tests/unit-test.h                      |  19 +++
>   9 files changed, 212 insertions(+), 294 deletions(-)
>   delete mode 100644 t/unit-tests/lib-oid.c
>   delete mode 100644 t/unit-tests/lib-oid.h
>   rename t/unit-tests/{t-oid-array.c => u-oid-array.c} (35%)
>   rename t/unit-tests/{t-oidmap.c => u-oidmap.c} (32%)
>   rename t/unit-tests/{t-oidtree.c => u-oidtree.c} (44%)
> 

