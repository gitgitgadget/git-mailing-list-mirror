Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F682E11CB
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942372; cv=none; b=Ble1XO4kUbo82CPvfT7Mn4t+9fFp0pEtIdRERkDF57E2Ae29PcyHUIIbYFWOKV/KsTQiKSIMgzK/39Db9M4U179HqTTf82hNNQ64VkbcaWdNPINRur+7sILtuFxSY7RArJ+6WkWpZNdJWjHzO6vaUAmfX65ZfuwUBmwvKsAGhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942372; c=relaxed/simple;
	bh=IDq/kX/KTS8J6Wmlh5jd8WX/uzdokFjy+18MK9K4N5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcnTdnT42xrf8Vqytt6dzj9k04ZumUsyXjFOb9PB4+4HLqX05RZ3kNRfrXK6JDmS9wDg+JgI1up7rCqaAAg4L6N02Yb4vDfFzrDFbTw5E6zGXQTdiw5BrzdHhJCkTuHKZPGEUzIItFgaOAcSpxLBz42Oz/3UfclTW1WF10xveCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ruw3mO4T; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ruw3mO4T"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a53359dea5so606740f8f.0
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 05:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750942369; x=1751547169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHhINhGrkGQ2hHjM1kcsgWIOcLc7VE5ZzbwVFPas/Wk=;
        b=Ruw3mO4T7aAM5sfs1woB5mPy4z2IZcugkUJejbwoRpvbuchyl06laglLv8ZXl9phxJ
         R+v8w3LSyJKczHr8KfJiUrXv1IpPVKq6rMrUO96RhUc0WVKTPN7rrAKmY+O2x5ILIuc/
         wRKhkZHwbV/rAahfXFTWHPDN+GESkcs97gs9UA+Pnhjj1hNGomMe3sI66rJ3cnLvi37i
         AjBigMVdRkpD8WNntBlPxgGxis9eoVdOCqsVYvpP8QWu2I3ZjZm4gbuo92ad7FWGnIj7
         ybw4s9Uh4/kC6JBgzWBZHcfvwHME59zj6dGD/OZEeHiZ1rdUPjFb59Gy49dBkEsc6C+2
         pPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750942369; x=1751547169;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHhINhGrkGQ2hHjM1kcsgWIOcLc7VE5ZzbwVFPas/Wk=;
        b=wV4MVO9woUXdjSULmR8H9LuB34Dp+z0Ce2lkN+iGlu2/dIRB2Hq0wyMTcWaQUpvIuD
         4r6FOkW94yyUTNDww/s9fghC/+f5usJ7tCHYCU97arVVD0mGldbfcrcMxWZv/6ZQLtDZ
         hhOiXF0OnjWZVxqghPrpViJMZZrP5i63KSHadmZ8HF2Y/qDC2QkkbuQC3d1wP2FltxHE
         z30PDJAPz9qETOn0UojXFgf94CjYGv5dI8uYcbKHcam/Xiaa+WGXUNcDO5pCLj9q3E2K
         hj8ozBe5dGHaKLrcMJzMmht3VcCMyfj46S3Lxx/Hi1B7T2kxWFpabAEsRMnATlNoZHfA
         eolg==
X-Forwarded-Encrypted: i=1; AJvYcCUjxruz5xZvQAAql7QX9LfZlr5KfH/C/07+rodSYLae2ABWdBTDlGK+n2Q2v2jONpTaowY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmdb/XmUeeglneMeoSLBXRuZENSuZCCtfXg80uCebDl+g9vJ/u
	/3+VBXTHa4fnUSy3DgHwwLiVqMOwChR31p5Di8U4sxsBxxLDamKWa0hu
X-Gm-Gg: ASbGnctlCCfzxca9stv2E9OCAOQZyKkOZYgds6pm2fwNxspQi6Ei0gsiia+0AWJeH+Q
	/KYrMbvx3qHoUiPXkOrhdmYOvhZufXgWgtYQRKLODTmzalXgP8OsIDZBO5uwS3y5JEkW2quZ/Z0
	LqBOU/DppOMpbVl43Ok9pvIPOosFdK07T6YqAq97XwRbMko2kyrv1tkatHu9W+OoJ8lfaVVdfjH
	NdCDEgMRhoXD5X9xFt3NL7Bd16cgAWs3Unv8lbDMyYxCJ0OUGk0ilCJtmSEs/gM9SA0WWB1/abj
	N9Q3vlt3yns/zQo6Oz927+WdFlX2j2hfcb3Ze/qIwC3zznTT1/N+SJe2YAfnujotjJDUMrKSdPa
	jFgKMmv2zEoJKx+e4HknFgWTpBdyitLeFlWhKfsAdxcEPtdWFglcPjD0=
X-Google-Smtp-Source: AGHT+IG44sdxbzDVK8GPzF1rDN8WAXm4pmAdNUmo54ynL/D388cU2EQZTUAPcBGa5pkjcUCYMi3oTQ==
X-Received: by 2002:a05:6000:23c2:b0:3a4:c8c1:aed8 with SMTP id ffacd0b85a97d-3a6ed66f7c7mr4506281f8f.39.1750942368911;
        Thu, 26 Jun 2025 05:52:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5? ([2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c4acsm48270865e9.1.2025.06.26.05.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 05:52:48 -0700 (PDT)
Message-ID: <49cf7749-fc86-4829-8e94-c1f1e87803aa@gmail.com>
Date: Thu, 26 Jun 2025 13:52:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Chris Torek <chris.torek@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> 
> A future change will start using sigaction to setup a SIGCHLD signal
> handler.
> 
> The current code uses signal() which returns SIG_ERR (but doesn't
> seem to set errno) so instruct sigaction() to do the same.

Why are we returning -1 below instead of SIG_ERR if we want the behavior 
to match?

Thanks

Phillip

> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   compat/mingw-posix.h | 1 +
>   compat/mingw.c       | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
> index a0dca756d104..847d558c9b2d 100644
> --- a/compat/mingw-posix.h
> +++ b/compat/mingw-posix.h
> @@ -95,6 +95,7 @@ struct sigaction {
>   	sig_handler_t sa_handler;
>   	unsigned sa_flags;
>   };
> +#define SA_NOCLDSTOP 1
>   
>   struct itimerval {
>   	struct timeval it_value, it_interval;
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 8a9972a1ca19..5d69ae32f4b9 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2561,7 +2561,9 @@ int setitimer(int type UNUSED, struct itimerval *in, struct itimerval *out)
>   
>   int sigaction(int sig, struct sigaction *in, struct sigaction *out)
>   {
> -	if (sig != SIGALRM)
> +	if (sig == SIGCHLD)
> +		return -1;
> +	else if (sig != SIGALRM)
>   		return errno = EINVAL,
>   			error("sigaction only implemented for SIGALRM");
>   	if (out)

