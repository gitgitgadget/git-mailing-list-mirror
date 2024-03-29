Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A717E13A3FF
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742377; cv=none; b=K7vyoy/qbKmK/HV5dIRwXh1GfviFhGTdrIF5vw+A4i6y9cnc6yQc1ypRiGPbczwPmNTx1WeifLUUDm+sVfYLcRjRNn81TXFIcNONV7G5JWt+CuEWFyfaXngWV6y7cOLpEFoyOpV6LB1yxkum1R3SMdowFWFBDYpCGUH7LZ4ABWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742377; c=relaxed/simple;
	bh=rMQnIEzzmjIqCP3IYw1nr50Tkol872aY/MehLOXJSE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUhn5sw/S3i/NLmKYnN04q9zJYjwYwk3Eva/vmfXtdFAEnq60KfZF/PYTSGw/NIUWhKsG5CYZ6+ysODElUls/pxC06YvguyKT6vLBYB8JkRuG8gmO92sSPpCLDDpFpRVfPhzxmjhoa1thcs1hWcWFVqUYET9ecHqRDb7qXomtRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVdGkTAo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVdGkTAo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-415523d9824so5778295e9.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711742374; x=1712347174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rjkj3FzOtLjRzxErBi3W0Qp7RFMIQaSOeVYndcxc36w=;
        b=VVdGkTAoxEskZXfJSn1pNguVj5IGblR6NBejm2cf7cR4nMiJegiTbJwZgPxhsevMRL
         ewVOTZGcmL1/9ZYlLa3VTf3g4fTYwR2a7YHsoS4Hx8SQEk9EQdy3pRcEvAZn66Vs0Z1J
         wMdpNjhVJI7WpKWlkhloXJbQ9e8XLc6RHZ3nhvUPtuoGtyJSzeq0lyZkiK95P3WpiqXL
         ArF9HxBJFrPQg+WAu1vkwVkbW4xyaYeJ+SsLEH5I235J8BIQaJ2Twic21DoUMiu+p+mc
         g39AYpXCM7tS241t9blkJ8Fp1rFuZb3gDuZa4afLo16zF7taQQ87SauozdYEZmXK/Dcm
         uuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742374; x=1712347174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjkj3FzOtLjRzxErBi3W0Qp7RFMIQaSOeVYndcxc36w=;
        b=beqrrz0kQO/vU7QswWqxrRw4wHUbwAuRfz/beqArpStGhaZdbNVyucID0Tlti6ZKlB
         n83643JA7btJlK7XxiQ+1ugjt0uyGFbkAj7QbW4KXneddrF/0vmPILsqe2P1kL4O+IbM
         CTogt2KUJaaP4U7ZvrDjdiIX68cVWm2+NoKEKibzyN012ahz7Il3XleA5sH83LGbGcSu
         dKTOy4bP1EGSIB9GHBUrBIK5JOmqjuxsy5EgGc5V+WDDrj6gl11mhWBPhAtmuUJjY3V9
         lxA5PJZeA+SGPC/ZmRgP8hLAQSTrxPxRfijFsRk5ekcFlVG3fdzezdk6bwTi6MD8SODL
         BPIw==
X-Gm-Message-State: AOJu0YwXTUJLONuR2VCBYwHRMGKaPzugAakN3YAtGVaOjQ6LjlBzXocP
	HFuOBmkiQ4nO4eB3WxuoXrRUY5VG2iIWJ0bWZHkLG7SuzauwUYUlpdCxlCAX
X-Google-Smtp-Source: AGHT+IF9g3pnext/IZ7xVgzaaogK3xQk0x6hfWwYiUD5bMVXOXeczIQtFxrYCytAKc175+l4C+RQEA==
X-Received: by 2002:a05:600c:a42:b0:413:3110:2d06 with SMTP id c2-20020a05600c0a4200b0041331102d06mr2879383wmq.16.1711742373782;
        Fri, 29 Mar 2024 12:59:33 -0700 (PDT)
Received: from gmail.com (118.red-88-14-46.dynamicip.rima-tde.net. [88.14.46.118])
        by smtp.gmail.com with ESMTPSA id bi25-20020a05600c3d9900b00415481edde3sm5397711wmb.9.2024.03.29.12.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:59:33 -0700 (PDT)
Message-ID: <a76a0935-78e6-4ad3-9bf9-989f5ed53b84@gmail.com>
Date: Fri, 29 Mar 2024 20:59:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] add: use advise_if_enabled for
 ADVICE_ADD_EMBEDDED_REPO
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
 <0e38da05-efd6-451e-bd8a-b2b3457c0c75@gmail.com> <xmqqcyrczzv7.fsf@gitster.g>
 <de916779-3c0c-4cf0-b78e-d0536c65af0e@gmail.com> <xmqqjzlkygvh.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqjzlkygvh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Mar 29, 2024 at 12:31:30PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >> This one also needs a similar justification, but with a twist.
> >
> > May I ask what you would find a good justification?
> >
> > Perhaps "newer" -> "now preferred"?
> 
> That is merely shifting justification around.  You'd now need to
> answer: Why do you consider it preferred?

Because it's newer ;-D

Maybe I'll point to the commit where advise_if_enabled() was introduced,
b3b18d1621 (advice: revamp advise API, 2020-03-02). We have some
arguments there.  I'll sleep on it.
