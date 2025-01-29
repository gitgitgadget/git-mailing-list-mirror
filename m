Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10515B102
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164258; cv=none; b=AHByW/9eIM+qJf7q7cPhQExmWi9PjNkRKj28Q3K5iqDe4nPWr54ZXntPfZuoXZWa+SlI5xAMQ/hi6pGzNPzzcy/TAJGGXKmFxUAgHFV93PwqaPIP7ccQop13xcUwfdbyMJLu7YXDO16DRyFFggJL/UPi6/nkXatQay7LzPx6CLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164258; c=relaxed/simple;
	bh=qXbkPjO1Fhw3DcXdWxIXGmDs+uWzbpQtmuZeWXoqzUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/AwVIuOwrHBHw76O6NEGR2QvOBFyUyRvevooR8O+tia2krAwcWLXepNkS8/fRpmeOQ6jEoLIw4MR6s2Rjz+RzyGSFGCxhpRUu+W/kUAZGXYUfLw6GJQ79L0+7rzIg9p6sblr0wt7k63IsUqG3DKeFc9i+sscsKdwuEhRlPb+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTJ3XHmy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTJ3XHmy"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3831831f8f.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738164255; x=1738769055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=flj48Q80pNA5zRWulYKvqDsFZj8Qfw47JpPSI9drbwc=;
        b=jTJ3XHmyb0SWy9dh/xdZjEjKkZu7bO1tejd7Jut4Bqw/euz3NTVznd6PE3icP1XI+9
         ScLD1YdI1FU1mNfmovYVhyP8o73CxUs/gCqmylkY12wtSUi+sMNQ9RhtdHB7hKv7+wck
         oGaWy/dUT34QxnHGt4CleviG0XPU76HZHVPk5Tgx/JZaxc3+3yqaPtC2jVJxOzU5I5gq
         8VNIZmIv0uv+tblz5G+AjOKg4RT1uCPRK9MP2Pi74HzyhaorNsoia2bOFUaY4rjAfcEH
         WmNDwFN/ZcyN44Efril3PFUgW9hLlYCis9uyTHIX8VTPZectrrJddxt+RkIXc5ELC6Rr
         9E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738164255; x=1738769055;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flj48Q80pNA5zRWulYKvqDsFZj8Qfw47JpPSI9drbwc=;
        b=bpFGFCyguZWlwRolI8W8QK9lOKc5aSQCs9fQ1C1CYH3JvnZlsEtR1kNOLqTAjo/LrF
         CVEjkeH1lTWn6VsIK+zF1G/urMDiufZUGP6iQ29RGcxivSw4S1kyRILuGbAW9om+FKyh
         v78q+oVGq2jTARkBmfI3OjGZia85G8LJXiDDluTvTcIcke4RcEn638VQ1k4PY97+jslt
         qvCufll00iKyRDe7mzjFtX00AA/8SHve5Fq5RiK3UQAXGBp0fYveiBQMjjQnQfpxfzkB
         T7O3RnMfGO6vihMHQhyCz/piMgwmcV0MqxND5Upl+BpfgDXjBNp11qJtkqhGX9bLLGoR
         aDAg==
X-Forwarded-Encrypted: i=1; AJvYcCUPL30Qc/sFIkHvFQggccp9MtlL2M8y+PlbgPxSlClrwqFOCqMXZfCDdCFmrur+9RsYZwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWl+oljzD+dvFWbZARHX9nYRgfY4Faku0OBPuCMqhXX1ckiiY7
	v3/JVr3cdSTdv03k9HI7qFV6GEATLBnAZ0jV0hfxtYg3HLHVA03H
X-Gm-Gg: ASbGncsobC/A1IXuz3zRWqVdKqwzK5ZcpQ/nf0ejqTv50gxJ0bWXcEvGsMV9Eoa3Olp
	KqEvuS3NbHlHCHqWyh6V6P/64SnUjyXgy35MLyAhIbo8mvs+dHTFyDS0LEgRyFrblCiocVS2omv
	zXQrAPyVh+oRNYbygyrgY9blbtZR2ahWEkF82VEamDAa626fagxzAZKlq8Bi/DntegBngm/flMu
	QeQEPz1eId8QiMFce8AujR0+k9dJlDXWa4PEtvGu9vWGEatKpzoEWNf24P0aIhnEg1r0SerD4od
	xDVnQugHJNRxuoPKxKNB0f0WpqKidQptmAE+QlUqTUnM4P9N1HAFxw9lBA2HTRmIBalKmA==
X-Google-Smtp-Source: AGHT+IG/TbiHxzyZg7jjRSkJTDn0TlgKyNSAy5JXy1eobKU7sxTbw3X+sNICr99/fwpMjUeKNUmSGw==
X-Received: by 2002:a5d:588c:0:b0:385:ebea:969d with SMTP id ffacd0b85a97d-38c5196a1d4mr3285987f8f.22.1738164255011;
        Wed, 29 Jan 2025 07:24:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc51208sm26382665e9.35.2025.01.29.07.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 07:24:14 -0800 (PST)
Message-ID: <6ed6cf83-070c-4be2-b58d-398006cbb072@gmail.com>
Date: Wed, 29 Jan 2025 15:24:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 0/4] Introduce libgit-rs, a Rust wrapper around
 libgit.a
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc: calvinwan@google.com, nasamuffin@google.com, emrass@google.com,
 gitster@pobox.com, sandals@crustytoothpaste.net, ps@pks.im
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738101256.git.steadmon@google.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1738101256.git.steadmon@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Josh

On 28/01/2025 22:01, Josh Steadmon wrote:

Thanks for re-rolling, the range-diff looks good to me apart from

>       +void libgit_configset_free(struct libgit_config_set *cs)
>       +{
>      -+	git_configset_clear((struct config_set *) cs);
>      -+	free((struct config_set *) cs);
>      ++	git_configset_clear(&cs->cs);
>      ++	free(&cs->cs);

Which I think should be "free(cs)". In practice it does not matter 
because we pass the same value to free() but it seems a bit odd to pass 
the address of the first member of the struct rather than the address of 
the struct itself.

I'm looking forward to seeing this merged soon

Best Wishes

Phillip

