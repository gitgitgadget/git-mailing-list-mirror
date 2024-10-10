Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35431B66C
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550763; cv=none; b=BO3RdoMCC4P1GykmOlRMfsgfUoDHb0FgTNNxCWFLY8kAsZJx6AFBRoHSiKxlv7MZGmJvZr8b+ey83KkIKqRZlNCf/MTdOyXkhE7gGfAE7cWLCXXtzab5nJ495jEyUdMpMzQvl3ZoGbfa5Cnxw326ZcUmmi6+WJGUte1WvJSss3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550763; c=relaxed/simple;
	bh=QDdvS20t4J0E6O7FN8QtFOjXtHEzuv+U/vn5T11q1X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EM9EnALVdReVNkuzvBqIr4YSb0rdE8kzjG9LvyzMVeyqZusHpxoDVMLKX0sLrn+2IdlChdmeiiZz62UCYS8i2vJy+MbA9B+nQH2R60bHxfLxZDF4MLCRWz0AP4Bc/updkS7Usnf2pg/boLRi0PpAtzBKeWtwnZpezUnPUxiAz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqgd5quW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqgd5quW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so5593705e9.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 01:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728550760; x=1729155560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fY9Ekrq5p0rcrVV7BG6pot2moazDU7HrzZJ2Vnq1ldQ=;
        b=Uqgd5quWv5X1R+cZQ7YRoUVDxtjguU+DMFPWQqQcqRy6mebbBLFgsBPYEGFAxb6DeB
         24pFU+gCPoSvv6BfCmpW8e74onDU0M3ZRK6xtHHZMjD5LL+hkKDTpTLD9BWYWeLQtnS0
         yoK3nA12R8H0IGDldBq4fKsLQ9kBZxZWV/Qd0EGy91+gLjXhFvwaUsfR4PaIH/xSmWgo
         ppShpJ8E9PNdNBSYobaQoH6Nq1Ebecv+oDvls7lTLYJnL7VzeFu3MHEKAXqib9g9cT9s
         7aR18LdlIuff+Gy/RA/h/na2x8+knZRn3yegFYIY7z1aZdKAfXN4b0fdq9nf1MoW0CQa
         T0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550760; x=1729155560;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fY9Ekrq5p0rcrVV7BG6pot2moazDU7HrzZJ2Vnq1ldQ=;
        b=RrERwEMyzn2PlBPxfr0NR+GnunRB6JDYZw+q2BRrDxA6otxaIJ+d55LZ4vD87RAjTc
         RMeZM9GEdNg88yXXSPnqRDrt1xXK8klKBtoiWwL5t5NaoFja0SKA8kuvFUyIxspBui8w
         TKjN6pNKeWNpncpazRAp2HRDehXZhHOcIqQ0Z7e85d34RvGfft8X9oW5oQsF8pHyht7v
         EztKJPjp4v9X4xR1UUZRXvMEVUu0ygXfwYzehjmO42/dD7VrUNuMVaj0J/jpC5FEQvwe
         doOjgXQi295J+a9NgQowOe6M0dTHTFqqriTi8BpYAqPmXjS4Auz/G6ls5TaH6xowc7L+
         MISA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQItvIw+xPqSZ+OBjguBjPDRbJ7b7GwPRrgjx2UI3tFTPFOnYxKqQai/U+hz+5YaPX2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nAxpNlz2m4gxHwt4VQD7W+Zhmd7WVnN7NLOeSaKwzxtj6b2i
	wRs0yS6QOHedyC3gAX77tPxSzeWAvXX3pDONbJ+Lxxg9UlDHAHdo
X-Google-Smtp-Source: AGHT+IH0j/kUH09wuE4Y15nkWPt7ceics3YahFV1JGH32wFXUvjDK7GT8mVi0Ca034iVQNKPvB9K4A==
X-Received: by 2002:a05:600c:3b9f:b0:42f:8515:e4a8 with SMTP id 5b1f17b1804b1-430ccf028a0mr44971105e9.6.1728550760166;
        Thu, 10 Oct 2024 01:59:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6ce6a7sm908211f8f.46.2024.10.10.01.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:59:19 -0700 (PDT)
Message-ID: <e7646092-84e0-4210-88e9-98352e1f60e0@gmail.com>
Date: Thu, 10 Oct 2024 09:59:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] [PATCH] mimgw: remove Compiler Warnings
To: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>, git@vger.kernel.org
Cc: tboegi@web.de, phillip.wood@dunelm.org.uk,
 Junio C Hamano <gitster@pobox.com>
References: <4530b7cc-3f91-4009-977e-97519a5a9f85@gmail.com>
 <20241009171342.2354-1-soekkle@freenet.de>
 <20241009171342.2354-2-soekkle@freenet.de>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241009171342.2354-2-soekkle@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sören

On 09/10/2024 18:13, Sören Krecker wrote:
> Remove some compiler warnings from msvc in compat/mingw.c for value truncation from 64 bit to 32 bit intigers.

Thanks for re-rolling, I think "Fix some compiler warnings" would be 
clearer than "Remove", also "integers" is misspelt. As Junio said we 
fold our commit messages at 72 characters. When I said it would be 
helpful to explain the choice of signed/unsigned I meant an explanation 
in the commit message, not code comments. I agree with Junio that the 
remaining ssize_t should be a size_t so the commit message could say 
something like

     Use size_t instead of int as all of the changed variables hold the
     result of strlen() or wcslen() which cannot be negative.

It would also be helpful to explain in the commit message the changes to 
_ssize_t

> +#ifdef _WIN64
> +typedef __int64 _ssize_t;
> +#else
>   typedef long _ssize_t;
> +#endif // _AMD64

Please note that we do not use "//" comments so this should be "/* 
_WIN64 */" so that the comment matches the opening #ifdef

Thanks for working on this

Phillip

