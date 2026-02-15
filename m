Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECB13B584
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771172527; cv=none; b=pSohWiUZyEdVZMZ+TT1UlFs5gnBNaFb1aSuwisA/y5tT+N2bunUseyVfoxtBR1Cp/LMNC7uVUnVT5/YnTcp930MYWgB8PLiNxez3NXBshUZ7hG+kWJ9fPhYxXXhiQnc7VDK/nhI84rzdQ6fC9zouHFzN8Qxfx8BRulJMKoThEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771172527; c=relaxed/simple;
	bh=4DBvR1ZcCyQhvdt/Mci3vb40vmZlCXykxTFwbsmPSes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pgw9anPhingyBjzqy9w4UeZtsD2fOrugLnotK+lGDNkF1IVOXbW8NS21ra/i+LdEf5nH056u4UGDoZj1mTw0FdM3a3HI/ISOWmKzQYRGRFRqZ/pRU5CLE3sdKokfBxgZKR0SHpvHYnoP1FGHzSP5ZRxPSyO7L2e85/vSop+swRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9UY5jXE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9UY5jXE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354a2864fa1so91776a91.2
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 08:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771172526; x=1771777326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TWPoFgj6pB7SWY2T50saQgmwRJHyro24f1+IoSufiA=;
        b=f9UY5jXE2sEhoruvTW+fC0jcm8nd2DjRr+mH228JdzS7VIIxHDbc0VDY9AKKWHCKUN
         IpdMqPoNPf/32RxkHOcAkl4B0RN//Ads7Nv+dt81pwJChguI81CgspMbCuSP+vQmCKwu
         ejNalMh8ciAPf55O+3+seGR2u2Pb9Ks9kvxMiSGjQ1psgr2TOqcI92Q1xmjXGPc3u0p7
         9J9SgOWr5zvunuMYttMzdbiKf2Nw/PT2M57Ed05nZ2JhXd6cSyd3nD2weFKfrsT3t7qM
         369TRYBpvNZR+suNJakE5oIohHQG6qpzpevWmZ7NmSvKcAkreUKH4KTssp99dclg5+Z6
         6pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771172526; x=1771777326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TWPoFgj6pB7SWY2T50saQgmwRJHyro24f1+IoSufiA=;
        b=IPoehmwHVUCC3QgCEMCr4ch4YA1eJlhvARmzXi6bwwWuLZy/96MVTP7ZdtNgBbRMkv
         owe0b5AEf8tT9D2/2t1ajvjoOCnnv7BWrKGqtgONepyBySOaZ4vo9tEGu0BqYnVwTaiE
         Uc39KrSWKhsMlZF+cSRLD1LgHu8cdEE1sxfcu2G6+SePOf1MBW+FNrbTMHYxPUsP/ej8
         aSZv6DvOgKaqCTyEraM11OuzvhdJEdeazHmBNUqSJHe1AdOA2t+FswbhS6O7ejVxpEo+
         QAVAcRVjRnjBLuwTWFjD5xV/qKss6r9OmzP+ztpbT9kGq5k82CDAhJD2jPiWGbvTDyAp
         wVeA==
X-Gm-Message-State: AOJu0YwGq7JYjVsPNNAhXzFQWQa4xBZslIADCVoK8pF9FvoBu2Wdb/kd
	ODV1IONoupWDmPdEt4EAcFhEsPKYuswo0HXTTIZmvUuodfo/apB4B++7
X-Gm-Gg: AZuq6aJy1BMqSN+fBV0vwcvZc1jDfgNniY2hECoyH0uQAvl4DNOB9lZ6M0SicmwLPBv
	X++MzvFypMQD4asSlj4Nj1nwh9jHioKHZicIfJAnLACzfpTa9DHh/+KDT/YIl44tpDjrWfaWNf3
	pJG6gHpePQ+yR2OvAeO1bZLD6n9VIErkeJxJX1b43/HZlc24TWRRN1wMLbJ9ZaHFsCjsju2CH4r
	RTy9Lbd/h1Rd43EBcTOAa+3Ag9pfl8J1xy4zWir54xnpnR5v8KUAsBaRaImTgKGMblrcrnLD+3n
	YaGAoy/4gFPGl0dbXMC6nw3PQSkqwF3gdsv37gmYNMHb+r4Cq2cI/7/rbj2sWA7EHWRYxT1LDpz
	9n+3IW+O3oli7ihZ40STX8mOTsd1mo58/oe+bjEZpVDbbJcKJxsrjbFL2FkvdXkFU5dmS29JUHQ
	01xwjF+JGhLsEYgrBJ2HyqOd4ISLU=
X-Received: by 2002:a05:6a21:6d94:b0:343:c095:c4d6 with SMTP id adf61e73a8af0-394672532d2mr6932274637.3.1771172525679;
        Sun, 15 Feb 2026 08:22:05 -0800 (PST)
Received: from [192.168.0.102] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b6a12asm8270764b3a.42.2026.02.15.08.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 08:22:05 -0800 (PST)
Message-ID: <f7426def-dce4-41d4-81de-91388fb41997@gmail.com>
Date: Mon, 16 Feb 2026 00:22:02 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] setup: fail if .git is not a file or directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
References: <20260212172405.48614-1-a3205153416@gmail.com>
 <20260214045247.118013-1-a3205153416@gmail.com> <xmqqfr72flga.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqfr72flga.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio,

I admit the code logic is indeed full of flaws - the vast majority of 
your suggestions make more sense than the current code. I do lack 
experience handling this kind of call chain, but I'll keep learning #^#

Given the extensive changes required, I won't address each point you 
raised individually. Instead, I'll rewrite the code directly based on 
your proposed solution. Please reserve your review for the next patch.

 >> I have verified this with a test script covering:
 >> 1. Normal .git file
 >> 2. .git as a symlink to a directory
 >> 3. .git as a FIFO
 >> 4. .git as a symlink to a FIFO
 >> 5. .git with garbage content
 >>
 >>  setup.c | 39 +++++++++++++++++++++++++++++----------
 >>  setup.h |  3 +++
 >>  2 files changed, 32 insertions(+), 10 deletions(-)

 >There is no test addition here, though?  What am I missing?

Sorry, I didn't express myself clearly. I meant I tested it myself but 
never add a test script. Test script will be included in the next patch.


On the other hand, if I understand correctly, state flows should be 
categorized as follows:

  1. Nothing there (ENOENT) ---> ignore and go up one level
  2. Directory (IS_A_DIR) ---> check is_git_directory
  3. NOT_A_FILE ---> die
  4. *REAL* error (READ_FAILED, INVALID_FORMAT) ---> die

And I mixed 1 and 2 and covered 4 in an obscure way (!= STAT_FAILED). I 
don't think this code is "unrunable" but indeed the logic flow is 
GARBAGE. I'll fix it.

Thank you for your advice,

Regards,

Yuchen

