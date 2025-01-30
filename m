Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BEE19F120
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234049; cv=none; b=L13mKXTyHDgc7AMfxsKwy8S7pdqOTivNfW5sufRt6tIoDjN0AHRZK2PK2+l23nhrzF+kGopSlHIdTHI4mj3m9rJU3TzMF25kcGn/X8xCrCPhhNJKnxbTQfL58/h35+Zjoa5tvmCWSf5PDtohWS17w+gMq+dF9aEOLEucitYC1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234049; c=relaxed/simple;
	bh=Eac4wqGo8luCbSwag3UlojkXK4kfSx3Io1TLADgNnRE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hlfuuzj5d6gWpZqhss5bEuReBN4hXjJEbMF8vWcxbhjDIrmNcJI1ODU9n+WgvKEEtOZZ/pXeriu6WVrNLX0r5ayLvtJQj5vDBPRlFioaZCS+Chb+c6rIOoNnKF/zwptpjqO9lWSoqLfPmYC8hLbvr3g+fWnwMi91RQQt8xZIRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGs/djG+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGs/djG+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso11433635e9.0
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 02:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738234046; x=1738838846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fWhOs54Ir6mS0vKgu87vtPyzE8JXVeST11QJy38ucOk=;
        b=AGs/djG+7MTIAl6Hj32UzoOk4DG3IH3CEc05SAkLM9DL+Xykb6lVzg4HW7l6FwrhiO
         MrNuPj/ZXeKW9ugizHaWo9w1N/evM5upbjWwHI8mbt6Jw7ItvES3SgU4rEkUS5KyWELO
         I3lCBVHYNvLytvSUQkAj4zqidxyx32jsJuQR+XRM5qrKP6AucCRyDUxVlCq3ZtAUCiwI
         /+pBisX0T9VPhQ086yOn2a7FZUVtkYtYnqoYJSX/OwvkknGZUoDYJLWzADe9uF9zQN9a
         I0tW/mrHoT3c7dCxBFHDcZbPqKZ8zf/qwjvKxz76yPnYKjiLYywf8vU1GSYEwDJgWlfS
         GvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738234046; x=1738838846;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWhOs54Ir6mS0vKgu87vtPyzE8JXVeST11QJy38ucOk=;
        b=rf61BqXTXlS9ofW1FQV4SrBFjZISUr3DqpazloGMoIiiBZ4Lv/Mx/XPWHf4Tc+Ruep
         43XfnZt26nL7SjXyOWzmkRDqVsSLLYwWEcDRXSzInOC2b4qDp9XaGRSYzRYITosuoRS4
         9Punw0kT9zMrUXFfBY44YcpivBS4mdjfaH3upHZukvue7QTKp7smi0yGxNvsy2hwTy95
         l3tY0rXmRynxcKS76MfOzsaIM06XQFASERIE9zoRvBQDNXcfWx9DagCwHxbBs7CdsqnJ
         onGPqHbKuFMReCARJsqweSsNflarB3VlKhlTodbfFYLMp4YQQ+u37DKHn9z6yaftEfmV
         vABg==
X-Gm-Message-State: AOJu0YyqTS82otb+IRs8gD88Ystq3nMy2dVFfCNJq4AMIrvT9Smoi+m4
	vQfKoCDRTOFZuKxHSJmAjChv9/6mzrE+7Xj82t8aAmJrX5+MjbdC
X-Gm-Gg: ASbGncu5iWRh/57U/ILTtROc2ADcGbg7osRZ5PZ2wAwe+xVRtfrXQm+KZytMBSVUyFd
	XikAGUXLEEBc/VkApd6HXkPsVb0Bfd5XB3dlswrS7cqaK4kEI3j9wJ958CUnDYyv2sgaKK4hE79
	DED8xI2l3NoBvwwWaGwZuLhwiP7B5sanVZ2PzW8F6dwCH5YIDA2+5AORdK/UGQyY6gHNSBc5ZB2
	qVERQm/h9WVDNGbHnEuUzq9YBILDN0+8UsB2O+Tt7x7zjf4tcwcwXpDzISonbxmTxt6yCLFyTQl
	tUUXqoAAThGhyqkraVsLIj3QTJvrt6yePQxS+4Yzp9wTz9QMYrdYAWgjAQvETm1funN7Bw==
X-Google-Smtp-Source: AGHT+IEc/3UPwDBU2drHxIz5JWcuQ9AXce3rrQXiAGtR0LGL2R+AKMWYZQPriqs87o/tAlIylqsStg==
X-Received: by 2002:a05:600c:3485:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-438e2990d98mr13523105e9.11.1738234046118;
        Thu, 30 Jan 2025 02:47:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e245f14esm18420865e9.34.2025.01.30.02.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 02:47:25 -0800 (PST)
Message-ID: <57031bce-6dc4-48a7-b4b5-1b837ea3ab8f@gmail.com>
Date: Thu, 30 Jan 2025 10:47:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/4] add-patch: Fix type conversion warnings from msvc
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, sunshine@sunshineco.com,
 =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
References: <20250126125638.3089-1-soekkle@freenet.de>
 <20250126125638.3089-2-soekkle@freenet.de>
 <6a251603-25bc-415d-ab8c-ae698bd7977a@gmail.com> <xmqqsep1iei6.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqsep1iei6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 29/01/2025 19:52, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> By the way, who is
> <CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com>
> and why is such an apparently bogus e-mail address Cc'ed?

That's the Reply-To address from the mail I was replying to. 
Unfortunately it does not seem to exist.

Best Wishes

Phillip


