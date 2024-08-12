Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AA20323
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454794; cv=none; b=N7+/TRzWFDyxfB73qGnkEhNLTAKHqraW/3BUMZolRP7Av3aGaWbt3CSgPLvnuAb/GUEgwIMVSjZg1c0dc2jTQtJx0HWL3U9M2huUV7UdvX4gzgV7XO4FxQNlq6RtweYTP6a5SUoJAZL7MWCYoP3LEqZdZ9+TU9kD0MZPAjSq2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454794; c=relaxed/simple;
	bh=fM+V1aQKFmBjlBLSEPEB3hKDpPGq71GBpi5ufxRHJHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dab/Qdou81jFcUw6GJsbSIF763GcLo+0OHwcmK0XVoiLnPb2ElTPW033L8iAbXbNyA7EpXoqLwnYiNIR+kUCcWzNorsA1442y/a8WoCXDBbbttdjyM7Y52DryP9umbBo9KYlrNKexrrGXUo2ywLeQQJ4XZEB6d/C9LmuwhyufT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOlT0wUj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOlT0wUj"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42817bee9e8so30587675e9.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723454791; x=1724059591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QTzZdI/xjIVugFdZhtfMz8nvex4MQcXBm7Qo931DvvY=;
        b=YOlT0wUjyl3b/5XG7zvwMSelU7FCHKhjTDO1E+1MWt5LoFCUHTjIdHmbR/ga/Wt//s
         x3zkkq77P1tcdVMevu9n2KWXLZbXtb+wU4qhOobO10MHbl81VIJ+q9nm060i4sZ2pb3i
         B2LntAflHzQhZL5e3NqytdNslxg+U25+UsDejvWUmderR+8MTgrIOkJd0agzb8UvYh2e
         xYaIVDTEAsnl3uUWhyKKqzd6qUVKnr7DWjISP5xakhUmMqS+f/XvJ3xtyLfvqGcT8GvG
         /4Xv1S89DwlUS8ViD/9G0cHZG2icHh0FrkPdC4M6yRG0PQb0Gf8vTZGMe81wAFIuswFb
         jzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723454791; x=1724059591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTzZdI/xjIVugFdZhtfMz8nvex4MQcXBm7Qo931DvvY=;
        b=pkjH1zVs8KyuVhatRynyb+quqybzWkth6BQVoTVK+VvITz1X38Y/wgmLUv5bBiyOvI
         TfPI1DHUdsJyZghAkdtdQUsb1D2iUJlMj5P7O10tsEdO8l9Pfe2kGZ8wa2ryCXOIKF0x
         lxDcy9xhN0EQGndCox8Nx2RwvNJF1p6E+zW1BBKjHDsr1PO+jvl5hlNJnWTbSRB8JyuX
         WNLn6y7+BP3LQ5iIkp/BZ4YqywThxJ7blq53pr5P+wHWySsGJ55NKkBu2iQjjJcgZdhv
         iOC3qAhGlwccRw+nKpxGxMAiyuA84RSluhrC0+J7tRTgbA4R7zaxsLMsyko1HxKah2O3
         CidQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeAPJp4uA3BgPIfolcQL0pfpSB8n9j3/ujDPoNPYAI32pHq2qCpZ3SAcJwWXM9xILAJD9IlwZ8g/UCue3buhPjplqr
X-Gm-Message-State: AOJu0YxQD7ZvGtmErkOK09NId5hHKZpQoXDwWFRguA36AH2o6OtIDJ6L
	MCRkuRiADYRz78liB0sN9FnO75Ezws82vpYBdbA7Uoz7kGaYMtkUwX6N/w==
X-Google-Smtp-Source: AGHT+IETTqKYXL1EG13PlzEYx+CBBtAeOhnJMy1jBnZqAKg6KpksCMijZjv+KjTrL+o2zOJs1izfQw==
X-Received: by 2002:a05:600c:3547:b0:426:5dc8:6a63 with SMTP id 5b1f17b1804b1-429c3a5677fmr47251175e9.30.1723454790853;
        Mon, 12 Aug 2024 02:26:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7492cesm180371115e9.20.2024.08.12.02.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 02:26:30 -0700 (PDT)
Message-ID: <e3f7d292-ee51-4784-8c85-14b5223c380f@gmail.com>
Date: Mon, 12 Aug 2024 10:26:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/5] cgit: add higher-level cgit crate
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
 emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com,
 mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com,
 dsimic@manjaro.org
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <514c744ba41cf48c4ffd85640b7ef0c5783cc77d.1723242556.git.steadmon@google.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <514c744ba41cf48c4ffd85640b7ef0c5783cc77d.1723242556.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 09/08/2024 23:41, Josh Steadmon wrote:
> From: Calvin Wan <calvinwan@google.com>
> 
> Wrap `struct config_set` and a few of its associated functions in
> cgit-sys. Also introduce a higher-level "cgit" crate which provides a
> more Rust-friendly interface to config_set structs.

Having an ergonamic interface is a really good idea. As far as the 
naming goes I think the suggestion of "libgit-rs" is a good one.

> diff --git a/contrib/cgit-rs/cgit-sys/public_symbol_export.h b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
> index 64332f30de..882c7932e8 100644
> --- a/contrib/cgit-rs/cgit-sys/public_symbol_export.h
> +++ b/contrib/cgit-rs/cgit-sys/public_symbol_export.h
> @@ -9,6 +9,18 @@ void libgit_init_git(const char **argv);
>   
>   int libgit_parse_maybe_bool(const char *val);

I'm suprised the compiler does not complain that 'struct config_set' is 
not declared in this header - I was expecting to see

	struct config_set;

before the function declarations. As I said in my comments on the last 
patch I think we'd be better to namespace our types as well as our 
functions in this library layer so this can be resued by other language 
bindings.

 > [...]
> +    pub fn get_str(&mut self, key: &str) -> Option<CString> {

If we're adding an ergonomic api then having return CString isn't ideal. 
I think the equivalent function in libgit2-rs has variants that return a 
String which is convinent if the caller is expecting utf8 values or 
Vec<u8> for non-utf8 values.

Best Wishes

Phillip
