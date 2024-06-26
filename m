Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A81684B9
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392394; cv=none; b=kwX/ajeKxy0uNWSpOlN5BYZCJOwpGQR6dQAqUKh9RdSpP3babrDQ9ZLaRCoSYld/ZJ87cR0siUFyGeJWRyi2SMQi7Z7PauIT7tfOGBBqfTnI2Ijt3ehYqb//UfKJj0zacTepROyUJZBQlPzqMMPFF1+VTaqsBDaeozRbKbNzksU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392394; c=relaxed/simple;
	bh=iVf0XpLfhmAvTvCohjuHeA6tGxTaF3OHf3mhPKfP4UQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=clFCnqutRSbE+h+/0ts0lsTa66UjWidBeYpa3TrZNKY5Qp4OE669AXVoItptKNfeEsrjfhky9zAIV7cYfpQmnfu3ZVrrWabhMjunQ5JsqYJsOYawSPIq+HGIVYb31kyjzx1wnQim4blOW5c9AkuqyKlgVl/Lp1KhYjPjPd6I7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJUJUkWL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJUJUkWL"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42108856c33so2001525e9.1
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719392391; x=1719997191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wzVyOaseqZM17QH39cySt6x2TjBSFGdE8ey0JQC35w=;
        b=lJUJUkWLbY2+44oQHCpZcQ/i3Nsq9RqGRk12I/8ouTqirBKM7xFmNBTQDf3VRVJdxB
         uwUzgzmZaUwDWRGkBRGTtxAdxAc6M+s+xw2LzirZgOLlqeeWM0v9dxeDZFvCQ4lzEIrE
         9rEXEkm2/sxcYLqe2KBMZcFyg8Wfxwdxro7t60TyC/uWb2iFVWkEdHWt0ya+piHd4df8
         tKucUFdhMEgDldnjc6JuNH0oFSVsqkYIfBmGUOWo19v9eStSTZEWKxrIU9AC8V83r2Fo
         mqsJooHft9HWwxhfTpNeN6nFrTlZRAqeKRWEbm92pSdDMQ8grXXOgQU04ucBZ9ie1Dxd
         Cmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719392391; x=1719997191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wzVyOaseqZM17QH39cySt6x2TjBSFGdE8ey0JQC35w=;
        b=i3yB5Nm1BJVRDuj0Fs8g1E/WYRj/eqPWq48NHSK7eFriDckImqePSwfT1s42U4PiHx
         eFM4yR4I9ZOSGfZX7e2celc6wGp93MW6stGaFvcRwzXtPtRUGoFeRyAEkCEj4jRrhNcd
         eHsmZvNIaz7fhl3hO2jhP39FG4i+2JQj9/vZRsuM3PUkUJ8pFrdK53Skl61f5tMHPtMy
         fQYdtZTxguTzjvhXRLIMPkROieqWaHxVy0dYLNZnV0t7bHDMlxKmn6DNWpCLPa831B/2
         qMcWLJXrE2oGApWmhM+8BSpABEt+TPNAdAmTII1PYhyqoLVEnEdE8vsS652iZSW079CG
         UjQw==
X-Gm-Message-State: AOJu0YzzxUJuAQTAJyfoU4BwN0yHXvg+lIhS4M6lXJ0YDeK25LR44gfq
	a5TBbi3FduudppGFH5Nui/FEEYGuPFLC5Mk/nO0zUR3G2pzDdJqk
X-Google-Smtp-Source: AGHT+IEguUki/pcIvB56aA3uzNVitjPD7qvULbB6iugj++hnkBORqMfqU+z6cbLcLfgG0zCo7tLICQ==
X-Received: by 2002:a05:6000:178c:b0:366:e9f5:781b with SMTP id ffacd0b85a97d-366e9f5795emr9021898f8f.21.1719392390950;
        Wed, 26 Jun 2024 01:59:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476? ([2a0a:ef40:64f:8901:b1e3:645a:b3c0:7476])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f687dsm15187493f8f.15.2024.06.26.01.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:59:50 -0700 (PDT)
Message-ID: <360290b2-f9eb-4a12-9832-1bb53ff455ef@gmail.com>
Date: Wed, 26 Jun 2024 09:59:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 phillip.wood@dunelm.org.uk, Jonathan Nieder <jrnieder@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 Christian Couder <chriscool@tuxfamily.org>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 Josh Steadmon <steadmon@google.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <ZnP6G6SSBynlBNUj@google.com>
 <827f6cea-2367-403f-ba8b-055c9c8a7259@gmail.com>
 <D29C89BS8UEJ.14F33FD8XJATD@gmail.com>
Content-Language: en-US
In-Reply-To: <D29C89BS8UEJ.14F33FD8XJATD@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam

On 25/06/2024 20:16, Ghanshyam Thakkar wrote:
> Phillip Wood <phillip.wood123@gmail.com> wrote:
>> When writing unit tests it is important to make sure that they fail,
>> rather than just return early if there is an error. There are a number
>> of places like this that return early without calling one of the check()
>> macros to make the test fail.
> 
> They do fail. `get_oid_arbitrary_hex()` from 'unit-tests/lib-oid.h' is
> a function specifically built for the use in unit tests. And it
> contains in built `check_*` to ensure that the tests fails if something
> goes wrong and also prints diagnostic info. Maybe we can add a check here
> as well to know the line number at which the call failed, but since we
> already print queried hex value and other diagnostic info from
> `get_oid_arbitrary_hex()`, I thought it would be enough.

Oh, sorry I didn't realize that. I agree that the check in 
get_oid_arbitary_hex() should be sufficient.

Best Wishes

Phillip
