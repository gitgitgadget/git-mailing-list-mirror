Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A270B221578
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872362; cv=none; b=aZ4wWV6DglNMhPlMg/h9bA+lCZVM7nc0+Ui4gz3QwBVTBKcgJS0HMWllt34aQPaNzUHEe6mtfXJBLXAd8lnFcF6KdfmJYGpbmjQKwBr2DOtMnnn7Ja6NZMKArat8BTvTYT4cy9UZYNFWbSQ2005ssvHNkeo575aCA1Qe53HFGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872362; c=relaxed/simple;
	bh=i/urKSLO1zRBXGqabpNy2J6MjPcdJOw41ZPnIi/EO8k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UTxwiDacsoNFiMYlwLwtXETUI9yR+LbY7kmC3hHZMWKWT5dXaucKfqOmZfWp3lEBfQyvVogsEZiFIRWA2Q0EE5xI0S0FAH0ovTn7IOtIkazhDvR212Mu8qeu8NFM+HXVIddXvQg4jnxQ7EvfxAT38oM3jkXNC5QmDrw9kyfhEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr18datg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr18datg"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so25543345e9.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748872359; x=1749477159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLnijCf2nZtKbJhBr0xl/0eg2jneCxd90ylHYNpL1H8=;
        b=Fr18datg0NtaXA1IJiyilgukzXrdbnuYsS39u92l35XkE3PtziKmKr1RMe4i6l5goO
         EIYl8LxBSFafRMx9XIQfzHhj6j1afOYhwUSLocFBjHQy+D0g+3wkQx47a2XI1XB5pNqc
         z587J8vP38cuTQKQbSKWuU0fYVW7TnDaFujXiUsPAP06GDrPvLZu+U21yO3FGpFQ9Oqk
         typ7fC3K5vGnzW4wbiHF1t6xSLxeEYN2cwQqT6FD6c8lbfIfSrJu/eQIA5cwWmzkDTcV
         KuyRwmenLCKu5ARNLXF233R+v64ucXGd/aS3Rhzg8A2XT8bCxgjfi57NJn/v5OmJgZD0
         57wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872359; x=1749477159;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLnijCf2nZtKbJhBr0xl/0eg2jneCxd90ylHYNpL1H8=;
        b=dy0j2PLVWYwRLUuTKQFgKI6P/dU7tDp7iPJR0R8Sq70PhfkbRSQgj8fgK+1mPE2FmZ
         VeuHtMIv9IztfpyvHDooR9mlLeX9OBGv1z2RDV5hCSKKCqxd9kr95GGHOf6Nj49Ky/yP
         OwKpFw1U/+zjNPTNR8eUzEC9ptH8tFz3FiBh6g1USdPxCih8ekJqnnwN8VZv/eO/3M+1
         swz4mTQK2XEl7dnvg/MZwHtpo6UYtj90eQ43mQSKGlIgCiZmv/mZIq48e98lEBP0CR1q
         tXrA/lniisxWnQtRAPo742dg3Nm1xU464X4Uy/6fbYJvKjE//xE9NL0zGglPMgWBnUVO
         4Ehw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ErgJLhOerLakHhb16uWQr0EXD19P8UjhC90old7V/9v9EGTV7YHpObfXIv9Yp9ex2P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPYw8tbmRgCK3z1ChQzflHSfUUlxy82YRQKSssvZNC8ByBpuz
	MkG70eLvMvHP3/UH22or/MjvsuEP9ng6pO4x64yGKh6MJBZWNnQOTq2/meQv0g==
X-Gm-Gg: ASbGncvDMXDPuEAcl4EmxGMXQaGZMbPOgHgQbkmxaPiCGt0tXLiWLaAzc/OPoozaj+e
	BaBDtLjzJYEHRsK48Qp73IntlIAJXtNwPtR+0JS0DoMtOd+TFVXhlSh2UAwDysCEsGsZyAAZXJb
	WjDNqoOrU2e8A3+K5Hx5eJa86WNklZFGoY+Oxj/wQSskMRyXj/bwpREvFT/I97N4UqeOc2mS70h
	Wv3a/WnpZpTVAkcZVsF7Yo5i7l1M/aI2ru0fwmDPcVr0N69tXeDWNEPB5WaIb+Khd93GCPTYnY7
	oDZaf4VH6kpWl+GlZ/pXUg/d2Cg7EZIRkH38c2JsvuXQh024t61qeE+su5gHI5X3/5R5Udz9OaH
	bC+VIF6bBv5WiszPKmOz5HIBTNgQ=
X-Google-Smtp-Source: AGHT+IGOWAvvKWKdKGKWGHfw0a0M3sIM3XdIa/tnIn+gvMuI9uOeUCpKRh+6guasLU6KpuaPeuxbWw==
X-Received: by 2002:a05:600c:4649:b0:43c:ec72:3daf with SMTP id 5b1f17b1804b1-450ce88aa5dmr110570775e9.14.1748872358582;
        Mon, 02 Jun 2025 06:52:38 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d45sm123436075e9.25.2025.06.02.06.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 06:52:38 -0700 (PDT)
Message-ID: <21a5cbc3-3d0b-410b-80d0-94e6444f8080@gmail.com>
Date: Mon, 2 Jun 2025 14:52:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> <xmqq5xhmvuol.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq5xhmvuol.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 27/05/2025 18:18, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Should that be " \$"? What you've got seems to work with dash but I'm
>> not sure if it is POSIX compliant or not.
> 
> "2.6 Word Expansions" ends with this sentence:
> 
>      If a '$' that is neither within single-quotes nor escaped by a
>      <backslash> is immediately followed by a <space>, <tab>, or a
>      <newline>, or is not followed by any character, the '$' shall be
>      treated as a literal character.
> 
> Taken together with "2.2.3 Double-Quotes", I'd read it as blessing a
> lone '$' at the end of double-quoted string as a literal dollar sign.

Thanks for finding that - TIL. I agree with your interpretation that the 
original is in fact safe.

Thanks

Phillip

