Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5F5FB83
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019897; cv=none; b=HQwCNyQHhNxztBUn7w0ULbooocZojcQy6bt0/5JgdIVKXkeMJilmOHnwsXwyzqqj95d8IXGIyvAasq+wE12cP23jpFFHuMF9iskpWlZRnwE0qQ1gK0udJqIzeG7rHgfDrL9Bq1bNWfM3VcPQSIrC+TOg/BZIqZGXK7qotuzlSKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019897; c=relaxed/simple;
	bh=kZtG+6UKwzP2cjyext8tGzgpta9sl4Mz/ui0Db6v3uk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bDzvQVJNLNeMQZ3pAl9GnlnJBSscWbHzfq5n94dRXwXbkUhzx8DUblZQTyOaa/DF2GdCxWF64flYZ4mGdO0aa53B0xaLV82BIPlaDzftvL1a4DIu6ky5j02/HYCmJZ3T8TKyABhwf/Oph1rWPqjgH8/q3+YB/p/S9e8RzdLQGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkozEqNR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkozEqNR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337cf4ac600so4088366f8f.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 06:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706019894; x=1706624694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrUx5lOvtysWlB6tR4sX0NysNMrz0hr5XSamfz1mXAw=;
        b=IkozEqNRxtwAfqAmBqlEHF2Ct4YkknHqqZq6clscoi1//wrB5gnjwiy/2utEcXogVT
         lpYUOmpGQDQeAothAjy9mTVsqZeS2Mw0z38mix7WrHEsiWUzMsHN8LRv+PgG28cmMgt5
         sn8Ht1SsZoRcxr4MTNZOOOgOjZ6ZL0FW7YEzA2JaG4vu8CdKmr87JVxkb977dM0efMAz
         9VYELjKg8FMth15l1Ulc59vWlVOv/OROvjGp5cT9yvoOjHA5kTDzAi4ts3/TovjAVRwf
         eg0b1CGVLCEjH7jkc4xz/l6GgZP8itNyXCFC+d5lwoGKC8EGs0cu5IKet0N4qSGL+vv2
         YvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019894; x=1706624694;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrUx5lOvtysWlB6tR4sX0NysNMrz0hr5XSamfz1mXAw=;
        b=NurGCmXPG8xJhF8UpGnIIxhL1H6cRW+JS1/hMQE3ss3zh6GR+ZSvAKsrGyNavLm+2S
         a/3FIXzk+giuQvDSnnSl+KcEeN0NGZz718kxHHImHxrcrv9LSts482OqvDUxhr80HvOc
         nm5ovcmM0JDn6+Kcd8iFDAj8fIQKf2MhUJEYrYagnm6PSIdwNzw11CxZbnD4hIAbqbH+
         5b1A5RVTOaQZJCToBg1fY+DnyNAHB+Z1R01rf/IUtOEZ8UbkdkOgLkNzU/9TdSeUcZ0e
         g2Wb1Kmf9D9TAnvMI8hkTJg3QON/S/SRVVzjm/S4YgTb2DhRgLXbhTO4LZ+7SYW261dr
         oEhw==
X-Gm-Message-State: AOJu0YxjvclJRUclEEXxDhuW+3Jqu25Er7538u1dMqArNb2mz7szOg3n
	UMAlYZ72QFX5XJ2nZ+yJMhKfm/P2D5MdyTagWtkCK8e5pvRgYzt8hMY6VD94
X-Google-Smtp-Source: AGHT+IG/cjAtAtRWO2mhde2AS8iN09lLB8qmCvjr1Gh62zHpq1xRDRSpvQl8wOtZk0FwE/Up/zr1Iw==
X-Received: by 2002:adf:ef8b:0:b0:337:c4d4:e32b with SMTP id d11-20020adfef8b000000b00337c4d4e32bmr3119679wro.83.1706019893778;
        Tue, 23 Jan 2024 06:24:53 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id q12-20020adfab0c000000b00337d8c40ff7sm12505590wrc.3.2024.01.23.06.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 06:24:53 -0800 (PST)
Message-ID: <7032ae96-602f-499d-8430-a5dc3864d1bb@gmail.com>
Date: Tue, 23 Jan 2024 14:24:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 3/4] rebase: Update `--empty=ask` to `--empty=drop`
Reply-To: phillip.wood@dunelm.org.uk
To: brianmlyles@gmail.com, git@vger.kernel.org
Cc: me@ttaylorr.com, newren@gmail.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240119060721.3734775-4-brianmlyles@gmail.com>
Content-Language: en-US
In-Reply-To: <20240119060721.3734775-4-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> From: Brian Lyles <brianmlyles@gmail.com>
> 
> When `git-am` got its own `--empty` option in 7c096b8d61 (am: support
> --empty=<option> to handle empty patches, 2021-12-09), `stop` was used
> instead of `ask`. `stop` is a more accurate term for describing what
> really happens,

I can see your reasoning but I think of stopping as git's way of asking 
what to do so I'm not sure if "stop" is better than "ask". I don't know 
how we ended up with two different terms - the prior art is "ask" so 
maybe we should change "am --empty" instead. Lets see what others think.

It would be helpful to mention the tests in the commit message - we end 
up with a mixture of "--empty=ask" and "--empty=stop" I assume that is 
by design

> and consistency is good. This commit updates
> `git-rebase` to also use `stop`, while keeping `ask` as a deprecated
> synonym.

If we're deprecating "ask" do we want to print a warning recommending 
"stop" instead?

Best Wishes

Phillip
