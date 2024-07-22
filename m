Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9516DC36
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659835; cv=none; b=hFmUyuQvO+9wUcUa2CF1yMK8VaOJXqnVsSyzzicALVF1kjXSa0hatMFXlAVJtwcskmNJu+WQ+1sbekuI4NwZm3JjgSWtYu7F68nim4hMCW8GDb0qJSr65uDEgAzXEZA3gmHr/7DR5zzbplJw+//Ewu3/VFq5NFmlBF264McHYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659835; c=relaxed/simple;
	bh=Lz41DehoiQKR4Dp68KNwe2jl9dY8cMVMIIrlfn4yBOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcqIjQtrSgtm1KuMXmwVjL8dxIoYoqsnYL4TRqwjMaupexNeQKa1I48SoFk0Z8ShPBi2Um5gdkV5DzbIxZQjgO7BPu4Hb0k+8pXRG2928g/WCN8FN6fvQTqqxWSHSQQrXFlBrcR0uxwTQ/7i32bVfIDB6UpRH6qEz1DJ0t+TpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx36dE+k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx36dE+k"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso33031715e9.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721659832; x=1722264632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGvHuNDUOhWGAS57cHAmV8Pkr9FREcZ/jji1VVWx54o=;
        b=Mx36dE+k3UMDLR4Il5fOx7kMBhOznNS2lLdSmynvdOMylpgAULBIJOvGxm+88chsSO
         5iWdZ3vi8V/LxEj4iwoU1gBwFgMDpZmwySerTBp/MrLxCZK8Y8QCjs8qIhMqk6Jq3LcS
         X/iXEAWT0EmTtpMtj/WAi55ce1IgHng/tHfp/S3lp4Ig0CBiw9bXGGMUltwdhdk31yht
         PvjRuBjFRCwII+VYNftGbjhWpq42LxBJTB56zo2akxwV47XaOPxc74BWZKsn7RnEfhiw
         184yM4CxUYbOo0y8oywDuwhAveMIfr+it8yklJsxriOv/lrQcwgAqt1uLvMyg8mSXa89
         oGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721659832; x=1722264632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGvHuNDUOhWGAS57cHAmV8Pkr9FREcZ/jji1VVWx54o=;
        b=crAoM0apL3BP2oVK4RXRu7rp3FeFF5NRPmzXW16G28XL9Y0tKvVyz2TfqV/KqBp6ZE
         KJW5vzBR/9BVVfxTwAe9drCn1vKo6PisXRyOhH0N46VONpWYa4RtrjsTJc5b1ghNs+Xi
         CrhdWSDbAy13cOh0Ng5t6dxz6j1v0WioLIu7Al/Hng8clbKMsMTc5VrtzH8t3Mv8uHXA
         0VPdzb9Mm492l65u8+z3hppN/3vcmMOt6qAgXYqo0Ea/gAEsuN2SlB9ApFmYKkp99mRr
         gYht0JLp4nA0nviOHIi+d5EMbRD7QGfG69TUUiMIJVnAtGdRqh+n/veVS7cD/DV4B666
         ShHg==
X-Forwarded-Encrypted: i=1; AJvYcCWSYxyaGD9JtkKqpTZhYCGxO1lU6jnlRsR+ZfyV9H6TcUNMo/clzs6N2GtB6xTc0XBAL8WvktR3eu1K/63GUPhaSNhw
X-Gm-Message-State: AOJu0YwqIaoIW/aDqcbwMpbgGV3qG091xVTsRSKVcyTZ3y7GKKlFAMSz
	5UEvhvmYTXZF8SNo0MxGvTxZ65pvGFcFZBjalcyAnvUQWbQo7D5o
X-Google-Smtp-Source: AGHT+IESQG66HtABuNikj7GGb1PXUlWi2Ow8QYVZqZx0G1f3TXcBsS3heXG54AZqOFEMziOgxHkJ7Q==
X-Received: by 2002:a5d:53d1:0:b0:368:3f6a:1de8 with SMTP id ffacd0b85a97d-369dec048dcmr84368f8f.11.1721659831628;
        Mon, 22 Jul 2024 07:50:31 -0700 (PDT)
Received: from gmail.com (89.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684818sm8696868f8f.21.2024.07.22.07.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 07:50:31 -0700 (PDT)
Message-ID: <2e1c8fc6-86f0-404f-bef6-9502aa0d31d0@gmail.com>
Date: Mon, 22 Jul 2024 16:50:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] improve one-shot variable detection with shell
 function
Content-Language: en-US
To: Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20240722065915.80760-1-ericsunshine@charter.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240722065915.80760-1-ericsunshine@charter.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Mon, Jul 22, 2024 at 02:59:10AM -0400, Eric Sunshine wrote:
> From: Eric Sunshine <sunshine@sunshineco.com>
> 
> This series addresses a blind-spot of check-non-portable-shell's
> detection of one-shot environment variable assignment with shell
> functions. In particular, although it correctly detects:
> 
>     VAR=val shell-func
> 
> it will miss invocations such as:
> 
>     echo X | VAR=val shell-func
> 
> References:
> https://lore.kernel.org/git/CAPig+cRyj8J7MZEufu34NUzwOL2n=w35nT1Ug7FGRwMC0=Qpwg@mail.gmail.com/
> https://lore.kernel.org/git/bc1b9cce-d04d-4a79-8fab-55ec3c8bae30@gmail.com/
> 
> Eric Sunshine (4):
>   t3430: modernize one-shot "VAR=val shell-func" invocation
>   t4034: fix use of one-shot variable assignment with shell function
>   check-non-portable-shell: improve `VAR=val shell-func` detection
>   check-non-portable-shell: suggest alternative for `VAR=val shell-func`

All these changes look good to me.

Thanks.

> 
>  t/check-non-portable-shell.pl | 4 ++--
>  t/t3430-rebase-merges.sh      | 4 ++--
>  t/t4034-diff-words.sh         | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> -- 
> 2.45.2
> 
