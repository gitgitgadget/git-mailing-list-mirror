Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58B63AC
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687451; cv=none; b=cKwgIn1Ly8hhQs62bouGZfQsHdISlisqNDzujXnbfbZ1fO5LlEY90fjcKMQo7vqUNESiR/FqDpJ7tptI+NQfFniC/3JdiWo5JplhrHk9n7ivyRlXIwFt9GrPEnG0fsTZFx1Etsc1QBq+OXWNKtNcJmdFmwewSdk+CSqEoVPTk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687451; c=relaxed/simple;
	bh=8HWzg0X5YV9pclWJ5FslO+Vl++TZdkONV3b08TCvCLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AS/aonKgtbnK3AUr+8Az9q5y+lrpJc/NjRyodZGqte03MzyZoOaVI3KJ7m6MqBTSHiZDPd7FViNuIUnjWaJ6IPM/ZTKX4PipaXN9+tQ/c1yh6m0q3tLboEIz9fZRIC/hq90HPMk2jzhIKUZE5PbDfQQMxrvNnaSjfwQ4PkMG6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeqbGXfA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeqbGXfA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412e84f501dso3644055e9.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 17:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709687448; x=1710292248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gAHFUHMznJNBkNG88pyfGoKAdGdAFHSVCwiafcBBXM=;
        b=BeqbGXfAQikQvZUbgUtJTTqryi7u0qSUrnx9dk5+cFXkvPR+ebP2PMzCtuc3G+Rwvq
         e4wcSvmdyi5QckLO1bxXGJs/F0ia8lzKA5B2M+tEH8O48CLF0FsHtRWGoXm5TatkjS64
         VcP9ygEPA76Epn8V8fVHGnt75X+HBdJf0MBi6Lq8eptQ9i1ukY1DAQBUPYkswY8vyytr
         2LgvmgihD30GsW6U7xLxxwibXGQ/aJBCKVV85w9Vd6vaMWlBqFhaL61XyAPnk1wchb8G
         NuxRGXTH4Zgng9a/EQM6KKURaaD6ZmeQ9GHmyan1zRGonYx8qRARGKM+vAuy1rCVRoOL
         EX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709687448; x=1710292248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gAHFUHMznJNBkNG88pyfGoKAdGdAFHSVCwiafcBBXM=;
        b=H4HIYofYZOgf2ZHMRrqpZlIvDF01MzJLpNHzK4RE8zNq2LUzpdHb24MojuE7czetVQ
         3p90v+OI0tYaH2ZMW3it00Ea31EBOi3JLTMi35l/yubPxry4q+xA7M0eKS478Av09WrZ
         h8cOuGi+hSJUxLPrC79Is/bjsIGY8nbQwAEMSDZ+am1dc9aApvd49HPPsvyb1Yesb/ql
         tdn5kzhp7uU18ygtM7s/BBVp2Skb/0pzw8V76LrpBJrWcmxMAHZqz7O+BXVP5/0fr9Te
         mnvYr3RvkCkDLmT7bcbR/ZUNN2Sm+3I+Nvz/qq+7xODkvue+kfiBGu4Ui9lPmYO1HHmB
         YKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk79QPu4db/+XqM4lixAyARYKMr1lO3+ZMOD2+dd2mwdjcz5z86LVehw18FZ/Y7jryy0QygGC3VWCG1JEXdBgqyVqq
X-Gm-Message-State: AOJu0YzwDBQbViX5Heq8C9HSC/p5ISQ4LZ0DhuMzkdQrBHWh1FPgqGWo
	oW/nS+gEev6ydNl5SEcMxx0xxYKvjPLrCwCGX14ATjmsfX5PvKfI
X-Google-Smtp-Source: AGHT+IEqeOK8jVyOvIAj9cuTZy5lRKyPfbTLoLT18to3Ae9+u4MHcpXm0gKYYjiWPFxn77xSvhGJ1Q==
X-Received: by 2002:a05:600c:4e0d:b0:412:e2a9:a44e with SMTP id b13-20020a05600c4e0d00b00412e2a9a44emr6068976wmq.21.1709687448228;
        Tue, 05 Mar 2024 17:10:48 -0800 (PST)
Received: from gmail.com (26.red-88-13-46.dynamicip.rima-tde.net. [88.13.46.26])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b0041294d015fbsm19317567wms.40.2024.03.05.17.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 17:10:47 -0800 (PST)
Message-ID: <c69350a7-027f-4834-8a6d-ff0e0632ce6c@gmail.com>
Date: Wed, 6 Mar 2024 02:10:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] t/t9*: avoid redundant uses of cat
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: Beat Bolli <bb@drbeat.li>, git@vger.kernel.org,
 Beat Bolli <dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240305212533.12947-15-dev+git@drbeat.li>
 <8b9667e5-0d2f-4624-8f7c-f8400250a21e@gmail.com> <xmqqwmqgw5oq.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqqwmqgw5oq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Mar 05, 2024 at 04:43:33PM -0800, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> >>  	git ls-tree L2 g/b/ >tmp &&
> >> -	cat tmp | cut -f 2 >actual &&
> >> +	cut -f 2 <tmp >actual &&
> >>  	test_cmp expect actual &&
> >
> > Nit: Maybe we can avoid tmp.
> 
> Piping "git ls-tree" output to "cut" would hide the exit status of
> "git ls-tree" if it fails, which is not a good idea, so I do not
> think of a way to avoid tmp so easily.

Right.  Thanks for pointing that out.
