Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73FC1E1E12
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749138817; cv=none; b=PSJ2fdzpfU9iUKU0tUfC/YlQYuGr6EaxL64zSazDan+ltREqjg2HO4eLzcyXt/y2zXGXYQUkyDhcgHy1yEWv4nQkcJHLlydQmIaLh2GU9L9OfPdLeRkE94wc4+gieUlnIUf6oXVamd/waezS5W+C8COHmnWilnM4UxHJZgEFIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749138817; c=relaxed/simple;
	bh=I41VUwG9dg1uG3zvJHv5rB1qN7TCPETdOYbK5jmptaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQM6drfxd9Yf6SUHkXiWINPdCNe18Bntj8lUAWX7IE+CWr2LSctLoC8+21334cVp2ixBDA4gV7GM7JQweB4eHdsN5EoUc5/VrDC7/LQxOg1qbiMM7ekstjtAVXJZjcNAHveyEiyi3BT5rfu4zSkvGqK1Pwn+FkgOBytjx9bum8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbIb6dgu; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbIb6dgu"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70e78e04e48so10007517b3.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749138814; x=1749743614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlZ0mwVEjUB88Pprr2cjCSn/3B0JDxZzqNONmusfOto=;
        b=DbIb6dguPMb5Ep8i7b4kmWXDLG6lqOCjbIQo2HkLcLcK4Rx34mH4wqopcDBZgoWtqk
         5NuwJ0Ar/1sjxWeENyWyHkukhrLA0zy/4UaJr820Fs8S6y0JE2OFgHYntCVZ8st6MiQq
         IZmPgboJYbjLMHi9IaszDW928QimulrCZgP4pITrXgONTy5MnimZyuTheZkmjWlzHMcl
         N9Hexw2v7OMSLVog5PAhcKft//do5lli3xzJ/ctVw3KUmZGSSwPQrstPTrYt9QeQldDC
         4XpZu9yvgTl7j+eKluQTXEWqzVWFEJLhjsKUB+3Me4ZldZaG7lphMEg0PgL/Lk8wefwf
         sKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749138814; x=1749743614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlZ0mwVEjUB88Pprr2cjCSn/3B0JDxZzqNONmusfOto=;
        b=nUEn/l7uqeNVleGeyIWQdEGHRA26B9n7X5KKzVN2YFwPjzJ1yv1cAoA1UmU86nGejm
         ESDlCUR63WdUKW1vfLkK0yTMJnvkoc0e2c1nlZe4XySpEq/hmXkZbJjFuR76UkEt248W
         sr1cesUmqMveTGXgqFy6b5Ox/n8mY91tkDtea1iEzOmKGrPm8cFZ+6jMj3PYYg/ytL7g
         MxnqHMBsWBWtMemkWueuWIJiw6/IlSQVhnuEHC8A6rgwR0NkUUfA7367ZjRc3YfYVk1p
         Y6/PdFUblIGZZLFULMMmaTQrGb2QE2BZn0r37JsPomJGlrYpefn27WFkgQQOgKULJBbe
         e1RA==
X-Forwarded-Encrypted: i=1; AJvYcCWK053izV9QvDdTmeLjynbFzqkiBOZcJXDGfC0RxIyFi2bzRiteCd2R/oGmCVNmklSS7gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dgEE1cZDVwaaVss7VyCG4bJ9g1+wvMGra9TGtjxa/rhPbKlE
	1HVuXyINE0kVnzYCWea198lC8kVmbGNbUOs5/W3oVpxnchD9HwkwN9QG
X-Gm-Gg: ASbGncvsPhbjCewcqtrvZST2YiLRYHzT172V5hQ7uaxkUqnNfZk3OXBfT/JO2yE/wSN
	+V6wcoyjmD849NxZK5Vi/g0e6KguMoyOGH3djDKfWmr6AvwHu5rrKcy+YzmesxFRZ0nFmWTL2M3
	5vLfM33zIxMdK/aPqvr3oBUtN7ZH29/76b/Xpjf/LxSR5jhgRtGWPV3CKTzjY3zEyxAtOOLUgDL
	Ibz0V5mlQEJGlaAeMpyzjF6iI0h3zleQ8v7uQVAxUdd9CEJQ7Egl9gQm8HGN/tNqtmCDGnR1cww
	DVaL3SiZAUk+pYUbgKPwIpraTEajBZf8H7vFVInyUN065XB5D4de5Lnx1gNfvikj5DqPenjENDX
	C8N3hl4HxKDlEsSQZfPXx9IOC9U5Rc65NJs9HDQ==
X-Google-Smtp-Source: AGHT+IEaqEYvhACB4vquUHdCkHgHj7+vF5UERB35XC3HgCbj8HpFczKYH/WCmtmPoxfXRtOnypquuA==
X-Received: by 2002:a05:690c:450e:b0:6fb:a696:b23b with SMTP id 00721157ae682-710d9fe0dfamr98569317b3.33.1749138813729;
        Thu, 05 Jun 2025 08:53:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:b0b8:1731:c2b2:54d2? ([2600:1700:60ba:9810:b0b8:1731:c2b2:54d2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-710ec2b78a5sm3081117b3.60.2025.06.05.08.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 08:53:33 -0700 (PDT)
Message-ID: <4a8b02fc-09b1-4e7a-9b44-49a526b1da48@gmail.com>
Date: Thu, 5 Jun 2025 11:53:32 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] builtin/maintenance: fix ref lock races when
 detaching
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, david asraf
 <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Ben Knoble
 <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
 <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/2025 10:01 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series fixes races around locking the "packed-refs" file when
> auto-maintenance decides to repack it. This issue has been reported e.g.
> via [1] and [2].
> 
> The root cause is that git-gc(1) used to know to detach _after_ having
> repacked references. As such, callers wouldn't continue with their thing
> until we have already packed refs, and thus the race does not exist
> there. git-maintenance(1) didn't have the same split though, so this
> patch series retrofits that logic.

Thanks for making these changes. I read this v4 and only found an
opportunity to improve our docs relative to the more helpful errors
around using --schedule and --task together. I sent a diff that could
be squashed in or skipped.

Thanks,
-Stolee
