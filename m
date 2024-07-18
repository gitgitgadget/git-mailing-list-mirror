Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17612C473
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721296721; cv=none; b=YtKmcD/Ts/zdhtU4hSnS6CTEKo2J2csIhENa1pSm9VcagimDyGWtwVTCk5WeidGF+oqgK4xiOIsUVf8zLx4F8Im6zJUaDvMPKj6iVfZXWC9K6FfkbOuW/fSprNmVBYXSV8ZH6KvxgWFnWKO6pandFme4ohc/C9zornpznPM2oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721296721; c=relaxed/simple;
	bh=fZfwdcBIUrC5T8kal6log+pby0xb8lRoLcpFgjKZhy8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gB5u4C08WUqjwF9DNYRaF4viGCB0bQeLOeG1VBxsuruAFh3Ho6dM14sye1+OooMeUDowe+NWXJoDznOqrIoQsmpJz6ODIW+jWpZEq6oAVRwSD0fINeIyfrXmG3q4/sI04EnOWC8OBaI2YKM69B3XXEIhMmvqqQIx1TofzHPMw+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/8bphAZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/8bphAZ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367e50f71bbso369989f8f.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721296718; x=1721901518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+YsHFquQKKTdKj4MKb6Pzqgz8yATNPBoieNb5S1QYM=;
        b=g/8bphAZiHYtCjQwZWzS3iqwDqIRwb4470eg641nVIVO2guhvypQXh/wSmaxij1B2f
         hQMw6ROI9SKLy/8Ml+ZbyDhKuI7wkz3xR/fxmmvJkj+IRu3GSS2GD++siDIzbBq65o8F
         4RuR09eqh9dcsJj1csJ9b5GavHZWrDCasM4wxy61dZXBk/n/Md59sxD7h6ZKN/jbekmA
         1KMdiONMxV9W+Jv7pfFj2oYT8gFbI/DgknKHa1Z0aXCrQt8SM3iCEwYflLOcEsDZWiwe
         LFmH8vxIeffpCY3CUS3Hh8Am7IL0yipcvwfqbL4UBReuiaqtGjOic4q4fvrolj8x1I9V
         BOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721296718; x=1721901518;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+YsHFquQKKTdKj4MKb6Pzqgz8yATNPBoieNb5S1QYM=;
        b=JNNsuylIe8H6yOMGjXRxaI5+y5lDJva+NyYdUoqjPYDFmDiQijLhuElTJ4xVpNShZ2
         2A2LatUUINqKzmd013gnQ+fwCpLiyhUaEDs/XYLsFYTkQ8QP9UBmXqLonXN8BIj0VWl/
         fD0C6r6A3N6lvl3MI+W/RJHLCMmW8kmGV1CwQI4u7hYAoAaDL690n49z+dEpnveOmaN3
         4Xn5T3PiKsFGJ2KwCfbeVAfUwvWlAJ+pjtjCHO7fHKwL+V1C3UargdxImoAlbZB/z5tJ
         YsGlTf8jqeWvrqyFnQoCUzSvw8VP8sK6xsTC725CoowZhcw97HGjpfnxaAC1EE1Jqvpc
         ShCA==
X-Gm-Message-State: AOJu0Yx93wOpAgr7ELtwjgnNdWK5btB5HkobRLOo41VZBz3UE1CPjGu5
	HnlugmGGMAV87VgN4DiQ/JBNvzOJf7xeQj9ogwAyG/qVNBWKeSE/
X-Google-Smtp-Source: AGHT+IHdR9rEIRlAVUu6/ELRmd7BgDUq56dYdwSP6XxBVg2/94GpQ75aQ3SPTfMQo8SOfKssWRGjqw==
X-Received: by 2002:adf:f042:0:b0:368:3f61:b955 with SMTP id ffacd0b85a97d-3683f61bb56mr1979387f8f.38.1721296717769;
        Thu, 18 Jul 2024 02:58:37 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3683f5e0119sm2893548f8f.100.2024.07.18.02.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:58:37 -0700 (PDT)
Message-ID: <f52d5c9c-e96c-430f-a49a-eb2ee6e19d9f@gmail.com>
Date: Thu, 18 Jul 2024 10:58:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/4] add-patch: render hunks through the pager
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
 <efa98aec-f117-4cfe-a7c2-e8c0adbdb399@gmail.com>
 <1dc9ebad-768b-4c1a-8a58-8a7a5d24d49e@gmail.com> <xmqqttgqyzwa.fsf@gitster.g>
 <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
Content-Language: en-US
In-Reply-To: <2b57479c-29c8-4a6e-b7b0-1309395cfbd9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rubén

On 17/07/2024 18:20, Rubén Justo wrote:
> However, this error has exposed a problem: calling `wait_for_pager` if
> `setup_pager` hasn't worked is an issue that needs to be addressed in this
> series: `setup_pager` should return a result.

It already dies if we cannot execute the pager so maybe we should just 
die on other errors as well?

Best Wishes

Phillip
