Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1A5258
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239686; cv=none; b=BGSzH6L6rbBhxMKK3wMvY3hlkruuywKy6Fts1GCdByC9Kruc4Jm0VlGvG2xRq7E3t6dVeiy+rD9VSl/QAaUhGwaRc8LoGY8eYeGUSIgWZbJfw1Q6b7AtdLsLWTReH3So8icANmyGVj8hLJEjPOWJQjYT58HA+U4R7GkdfBN30z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239686; c=relaxed/simple;
	bh=b9grrF8oCr/Y+YJ5R0ol+G8OyM+7qy3HBQvTLi8bgns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDEQaLYwe2qHose64GLVMgdnZqepoKLlI1IkQrnBk+f2/wWWwM3C4jSxtEXCjTza41j/BF93P8HVeFedLCxToLpp0crD9isg1TcJoB3tmwerDgjW0lWNRpGLy5CNKl+CBD1cvf6IZMLknIUMVOLnHceB1/U6H/q01ea6s5m7eWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqKcA3al; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqKcA3al"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-454f426b3e5so3380405e9.0
        for <git@vger.kernel.org>; Fri, 11 Jul 2025 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752239683; x=1752844483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KaQny2yv6X8p42uhWxxzhZ/hNkP/dKAl1WCSQpNm/W4=;
        b=QqKcA3aljxghxuk0KVX0j8BAZAuYXK2fHh13FVYMhTSxQ4B1b66v/CHFZ+MKf36d4S
         zCwh4ghFD5AkrwnmKq04oC3SgGq7bJcPpo9PNUro4dXpakvFVrN0eQFN8QT2u7r2z39d
         yF8t2k1LxSjmj/euuCpf3kvn2epySkIxfbyX0lr7D1QMaWX2os47Sl+XTwrKSPNHzb4x
         lsMDRxUYQWNVMdqY0tXHwq+UnNXo8z1zoXb1ZIxW+ozi+V8+2cMh6s2iHraiLGipor9P
         mk41BF5cGnxeujlTutSe8QKJ/Exz0D9aTDYtsB7kgQeojYldEnXcptl0w4I/+7iinyut
         jllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239683; x=1752844483;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaQny2yv6X8p42uhWxxzhZ/hNkP/dKAl1WCSQpNm/W4=;
        b=u9krdM0CBkIPQ9AECpddSvWgvLsASJ+maxNSmXMiTAab6H/kWUr69+QXc7aXssOi66
         NmJTcmad+crZeZxYAhyoXtPFKqcxordNo7ZjqFCrmO4vzgahXEU3tFsmkZFCQIGamgLK
         BTDouw53wtNnLIuH4ESSamKRJAWB82UUKGYVWsm/cQkBToxj/4UdmxJMQ8I8gpVPw6BA
         tuJ0gNmh11Vlx17MleRtMtZnYp5/upgRbNwmTykbZvhhbBgrgI4bbMph0pZ0NBQEu+n5
         C8z0xYEB9m88sQrcKzpOE7IY09kl1sX6bw+zckpYHBcMb71NY9PD8umaaLa5ZHV3HdzC
         JuMA==
X-Gm-Message-State: AOJu0Ywr41psrCeeHabF9eAgIpC84gks2vj+xZiR5TEXe6yxvjMIU2VU
	7nXLl38qS8hOAOTzCgePfSvSjVfPMNP5d1qVIYzRXK5DmuzDyymLTfaC
X-Gm-Gg: ASbGnctfrOIg/tTvVcb1aHooWC2Vc2WLoCSAQZbWR50nMG2iLup0zAl2f69w+UOQoMI
	oWYOCjUwDQHSaDyaAhBxAga8FLmP9nWx98NiJQTqGIzg4pUCTf/WX6v0300lUYbl0kegvwVRO+H
	7p+gqhM5owdZvAN/Rs3RaPCMNcql5JDVZrqzeL7WjhyHA0aagmL4PerNWah5z8BgkUg/zcf7tdW
	yq6XW4jtGnq/nfEeHWpy/lCFs95yWD1y7VUOYqKfsFb/l5vgbNad+XzNcLOtE5qhPMsDmKiZN44
	7APRWFPTfUEOP63s4Fgkp9IWjCrdlNUF1cJwNEgJtWoCKA4MHA55v4iPRAwqRaA0rBB3OVfBQ3P
	nHoQgkheov7ra+ZxOC2TpbaRKEXmZKURoL2AHCyZmCRB5Ba/XEc60bNhkxfgdsJlK+sXkDWSUNN
	nRlfCM2Hs=
X-Google-Smtp-Source: AGHT+IHJB4Lq6zHU1p5lU8cjORNBok7/CbzfoRA8aMLrLdHZUxJ3DAcW+0jiXupPfYMsHwixaRWjhw==
X-Received: by 2002:a05:600c:c4ab:b0:450:cf42:7565 with SMTP id 5b1f17b1804b1-454f4261520mr23709345e9.23.1752239682748;
        Fri, 11 Jul 2025 06:14:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:750:6901:548d:e1c8:10d2:b904? ([2a0a:ef40:750:6901:548d:e1c8:10d2:b904])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50df0cdsm89227945e9.25.2025.07.11.06.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:14:42 -0700 (PDT)
Message-ID: <313e3b1a-a095-41ec-adb9-fc500589b979@gmail.com>
Date: Fri, 11 Jul 2025 14:14:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] daemon: explicitly allow EINTR during poll()
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?=
 <carenas@gmail.com>, Chris Torek <chris.torek@gmail.com>
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
 <xmqqfrf368lz.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqfrf368lz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/07/2025 22:26, Junio C Hamano wrote:
> Thanks, will queue with the following typo-fixes.
> 
> I'd appreciate an explicit Ack, even if this version is acceptable
> for all those who have helped polish this topic.

Patch 2 looks good, using sigaction() rather than signal() should reduce 
the variation in behavior across our unix platforms. I'd be much happier 
if we set errno on SIGCHLD in patch 1 - the argument in [1] that a 
non-zero errno might break something because signal() did not set it 
does not make much sense to me. At the moment it does not matter because 
there are no callers that check the return value let alone errno but if 
a future caller does start checking for errors there going to be 
surprised by errno not getting set.

Thanks

Phillip

[1] <3hrbpiapamvfiuilebjcbcruppz3vukf6mndg62j6gvko2jfs4@ll24s25shcgv>

> I understand that the self-pipe to wake ourselves up is left outside
> this topic on purpose, which I agree with.
> 
> Thanks, Carlo, for putting this together from weeks' long
> discussions, and thanks Phillip for pushing for simpler and smaller
> set of changes.
> 
> Will queue.
> 
> 
> 1:  30773a76ce ! 1:  ef03aa432a compat/mingw: allow sigaction(SIGCHLD)
>      @@ Commit message
>           The current code uses signal(), which returns SIG_ERR (but doesn't
>           seem to set errno) so instruct sigaction() to do the same.
>       
>      -    A new SA flag will be needed, so copy the one from Cygwinr; note that
>      -    the sigacgtion() implementation that is provided won't use it, so
>      +    A new SA flag will be needed, so copy the one from Cygwin; note that
>      +    the sigaction() implementation that is provided won't use it, so
>           its value is otherwise irrelevant.
>       
>           Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> 2:  7a33d7a646 = 2:  d83e1eef3b daemon: use sigaction() to install child_handler()

