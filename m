Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD928CF5E
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367198; cv=none; b=ZUhlk7GGVrYA0A27s4ZSMvH0icx2SJvJNyyTO6ZwdQo8sJCYRHGFBRzoEc5cwFaAEhKWoxgnaUi8Pldj+kgAG4eIXXweWH8mc1x5xexx/Sy4VvGIOYc37Sa/5xV5GUtNSHV6MUJPF09an/hW7rghLvjvySfrt4dhP0WfVXs+OEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367198; c=relaxed/simple;
	bh=D+VXgGXJTdRGosiC4dpjdAjkatz/Z3rsuMgF/owMkmk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F0yeZ/OQHIyeOTsex/XI5jsOxZ2ZLrlJcwfRNMY6QCGZu6AdX9TBqVjOG9CiLdiVceI1p8Z2nu5XYyix+9txpakaUi+PRT6dJtIeyyQunD+hcsYmO82NDF5l7iry8vdVnrn1ONt/j1eGIlmFowYpAyRYQKunDTbizqW80HFpR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0OzYzAr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0OzYzAr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d7b50815so7115995e9.2
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753367195; x=1753971995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeNJ9U5Hg5HaUfqDPBmUKZk9NoSwqzllIVES+wcPjaE=;
        b=S0OzYzAr9R5sKIfgOHdXApmuGmnH/nEyH3HoqxZx7obDvopcC4qt4B6UelnvekD4ei
         emQdCxH3ShmPx51A8EC6+n4t9qv5Kn7LA0l1LZ9SzTzRYLFM8HzSveBpxGMIc3mK4viI
         VDqxYhrwkf4D00AJwnIR+wouuQyLQohf7lDSI0CAK+lQRoJHevcoE00IpSNNyMGHyMTy
         7a8tbrONGIQ1dPquvISOKCAqNU3PII50pvh8HNvfXgY5ItdouPRTU7BwQd1TVKe6lvdQ
         DjSxbzGEiDdaEOYhXYSvArF2sAxSGY3rF7gAUi+SeRXTNagdpZhHiy8b4fcme/bVxL7T
         yz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367195; x=1753971995;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeNJ9U5Hg5HaUfqDPBmUKZk9NoSwqzllIVES+wcPjaE=;
        b=F5lDbTqDSedyZUHiFuZm2d5LRK87JASW4qhdzXwSrdbXbnKEvJfBJv5qMNGQjV7aGv
         XQ/fK1ictK5vpGwCmXCJlYeghL3jtRBu0nea4gVuPdzI6kC/nRSiVg9SkUASIZRV7pTL
         uy/uA3aBENR+Am2tOMcCK01gFihafrKng+mFCGM0zmxaBCpkB+HyUwKWL3mftwvGI2WJ
         I/fEJvcTev8DCnSvFaXODMuNRiyGPbcQsDSHDCDfOXfagVY6Bv/NYNKXd3oB/UuK/y7h
         X31RoXQ3IJDFyYyUVjPOt7iWBwWQbWFYXxyjWm4XRgszEegHvxcfMxtLDXByCSKRfu+u
         FyWA==
X-Forwarded-Encrypted: i=1; AJvYcCVqYCE68eV4f74vL0mZR4cFZsH2YvC/9mqrDgHGfasvqnU/KX3gqcQ1RbkYPmURNCjRCsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8f/jmk0KW+0JNi/97IJQTJI6bofUI9RcfPY0AKW34cGE32un
	hF5Yam8cJWqdkAfxl1QsR01ZMlAAzi4YX/Y9RLOqWEYFSZxvt+gim866
X-Gm-Gg: ASbGncvFOfq/ig2/CLnkiJNJik+dkuijykijya+v+MqQxf5nCkNEQHvsAm3eKDlChdp
	E6HLes8NuwZN2iNDsBuAwvW5dakMq9DCETmAiI+xjyI1n5SibV7ufse7CK9oOXyjsQ4qmsk8DVr
	TpDTBgY9s2pM+qJp9teZT7SfFE2OUqVUboaQj7CzgLOhAs5LE+BMGNTzfVEAkNLH3++SFvYyeA7
	KX3TYpiiR/XWzqzG+tqUcVClbNGWLuJJvIzrUzYJY5gwA7Lc/6PJ3wozLIqR5NgAPMPzA2RpVgD
	dTBndTnS4p/aZuVCfdfHz9fQxut76QdBKnOYMzfC9agrR+noJR1FPM1gPVbmVASoPBWlL4iTl4c
	ezEqP9zx86mA1G0VOnW7MydXeEse8GalR5oZt0zEurtRX6DHQ5eQAE1YGKiOmOj0xkSVx9lw9OD
	Ryr7mf9j8m8Jg=
X-Google-Smtp-Source: AGHT+IFhZOWjIE90IhxYz2qcoN0M9JOsP5U7hM/bfGnxK8fcNIDJN3Zij6UGYOCU6cpP/c8U1nIW/w==
X-Received: by 2002:a05:6000:26ca:b0:3b6:1ed:9ad2 with SMTP id ffacd0b85a97d-3b768f03086mr5301043f8f.42.1753367194784;
        Thu, 24 Jul 2025 07:26:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcc2b8asm2383501f8f.74.2025.07.24.07.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 07:26:34 -0700 (PDT)
Message-ID: <f954683b-b0be-4608-814d-23993316fcc2@gmail.com>
Date: Thu, 24 Jul 2025 15:26:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] CodingGuidelines: document test balloons in flight
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
References: <xmqqldoen5v3.fsf@gitster.g> <xmqqecu6n1pt.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqecu6n1pt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 23/07/2025 20:31, Junio C Hamano wrote:
> Due to portability concerns, we do not blindly say "It is in [[this
> standard]], so we will make liberal use of it" for many features,
> and use of C99 language features follow this same principle.  When
> we contemplate adopting a language feature that we haven't used in
> our codebase, we typically first raise a test balloon, which
> 
>   - is a piece of code that exercises the language feature we are
>     trying to see if it is OK to adopt
> 
>   - is in a small section of code that we know everybody who cares
>     about having a working Git must be compiling
> 
>   - is in a fairly stable part of the code, to allow reverting it
>     easily if some platforms do not understand it yet.
> 
> After a few years, with no breakage report from the community, we'd
> declare that the feature is now safe to use in our codebase.  Before
> that, we forbid the use of the language construct except for the
> designated test balloon code site.
> 
> The CodingGuidelines document lists these selected features that we
> already have determined that they are safe, and also those features
> that we know some platforms had trouble with.
> 
> Let's also start listing ongoing test balloons and expected timeline
> for adoption.
> 
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>

I'm not sure what I've done to deserve that - it was Patrick that 
pointed out the test balloon already existed. The patch and the commit 
message look good to me.

Thanks

Phillip

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   Documentation/CodingGuidelines | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c1046abfb7..0776d15a95 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -298,6 +298,14 @@ For C programs:
>      . since late 2021 with 44ba10d6, we have had variables declared in
>        the for loop "for (int i = 0; i < 10; i++)".
>   
> +   C99 features we have test balloons for:
> +
> +   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
> +     compound literal syntax, e.g., (struct foo){ .member = value };
> +     our hope is that no platforms we care about have trouble using
> +     them, and officially adopt its wider use in mid 2026.  Do not add
> +     more use of the syntax until that happens.
> +
>      New C99 features that we cannot use yet:
>   
>      . %z and %zu as a printf() argument for a size_t (the %z being for

