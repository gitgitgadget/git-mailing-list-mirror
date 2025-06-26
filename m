Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0C2E427A
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750943687; cv=none; b=D60t8/gJe/O6xnCrZBWoHcH5N81bdvWS/QWav1E9AgleclImMotKtLD7mwN3BuGyWa6yl4OqZdfYYMNAodBdFFrqHPaLjfRVxiHxwcoJmDYt8KsarZkfyjsvRK5ZWRnstxj1yV5ozkYLnu8FNAtKMAdfhzM+EOCC3EQCGJ2z2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750943687; c=relaxed/simple;
	bh=Ki7GCcHPwTmAT0Hp6Yl4bF9p4Ud4EKIDZ3l0AHxP5k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASc/Fa8A6beH4JmCgw3F0Wh23Lr4Nf0ZHc05LxAOImLIrETKM2HAs9m2+/xaPS1U4g4+Ur27+VE/LwNAL/VRkMqcYeHpVLehNC8iyDiyZdvsfKZoCA3huibuVvT05ZvA473uDbf5jbclhmyUrq+fm39FOow9adDqU27wxNeLXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8GJxXDA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8GJxXDA"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a528243636so588185f8f.3
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 06:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750943684; x=1751548484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0+XJ7+2k5R5miN5SUhShDkVAZv60XoW51kEtsZk3IA=;
        b=a8GJxXDA65qIheAXAUpRpWh6JVuyC9PvJqk5WtmPUkQ51uxQF3G6EKQAG9vjriQ4XJ
         nuYwB4rC6sN3vaZcWVMsLJi9JoFjytGRMpYkxOTWfNtcye3hjjeAIVF/WFknT7ARnh6K
         24jg88B9/8r76k6sr8ni78hBrlwX8hOwUuM03HBx9ZMXKD5gBOv/McqfUehMC9pSGEI7
         DzlPkHVX3uscrrsFoGlrQ/hbQo1u1mTWbJcAu6wbrWPudPbH7hHExLZi7gGvSzrvtjmb
         ldxdo5W66zmnt4H7mjt4gcGfKWie0yDkilrQPocmkK3jHLThaPoBo5kJg2cAATB8bVr7
         tE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750943684; x=1751548484;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0+XJ7+2k5R5miN5SUhShDkVAZv60XoW51kEtsZk3IA=;
        b=AtHpyOSFXVyxthjOX2DbMxGPOlTVTWP8N4fMi0TaDyhA4oJAr9jdK/aPQQnc4YPw7Y
         Ayy71o7O1PyC4IC8MXd75P38rnnVDDhCFP7qKZpV8QdmpPpJfzKET8q74mzZwYJq734c
         nTcEsPrxYXsP9zuS2qCk08T23yYARdhg7ojOTgD0U8J2dlu7ve32UTZIKicDRFx8Xgvm
         ENvSJIf2jGccdH7RRLV1Z4IYI2IfELqJVWlwNEiuMD+Op1fkHFbcDkRyeikN0cunZLMM
         rkGkTeaZpr+ALv07xN4+lnUO5Ctd1BTutkTsDs/Aytc2GwyROI5ab5EQMWizNr+kcDKj
         IFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdiYXYS0QSfdm2jsPuFkYXYXTQnuQ57ipj2/pK7YsAyXA499E+R9QBQ8/RdLSslA3P/84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP+dzhz4NQ+aT2ZM9WvCyzMyjyerIB8zzG6p663ZBKe+oeFZue
	r4B3PzELPWrwSPEu22zJqygr9PnQC5NUMo6gJ6Axiid1NIdmTBxTF7OI
X-Gm-Gg: ASbGncuxOFZB6Ki2gUrfuYTCx2TVnyKZAnpE4BhdC0l2rXgV3ZWjZrZ/xAm1jpToecC
	b1MiL/vamofOiPO2CW4iRszrX0v5TDYrpnclhNEAuHLs5ivnsQZtawPwOZtlxewQ8W1sQqqDWox
	ob6BW7wT/gbROvzX89MPLwukCMt5I+5qM1RC6RIOJTZnLthVTHJ0G+FwWvdNlnhTWe9Zyh7iFxP
	hPF1dko8xyhlZWlYoipPNQydWviOaHnG5vZvxyldstU1mRE6LAzPE7+PPvKwlhoqK82piKfU46t
	twQpcq4/qLMlx+pkC85vF8RoLvPOg+dWDxK+pZPBin9FhvrDHDw7qXWkUOn8FHffBLUdCeiDP2g
	nwfIWVxE4FH42TwQK/20SJ+tENf2hu5s7zXtMaOjQQ7gQ
X-Google-Smtp-Source: AGHT+IEKdaAepNC59HWon+pzkbhRnvgddVtEmn/4+bEIDKOgxrAvtFTJ3Wwi5vRfhFqMgeOX/R8YoA==
X-Received: by 2002:a05:6000:25e8:b0:3a4:c909:ce16 with SMTP id ffacd0b85a97d-3a6ed67333dmr5144747f8f.49.1750943683971;
        Thu, 26 Jun 2025 06:14:43 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5? ([2a0a:ef40:700:a501:f8e3:1d9:71a8:62f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2792sm7462365f8f.54.2025.06.26.06.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 06:14:43 -0700 (PDT)
Message-ID: <dba9ae0d-1e43-4345-a7ec-b57a07d45a07@gmail.com>
Date: Thu, 26 Jun 2025 14:14:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] daemon: explicitly allow EINTR during poll()
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 Chris Torek <chris.torek@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
 <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
 <851d663be0bda9ecb0e267ab0f85cc1f14cff10e.1750927989.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <851d663be0bda9ecb0e267ab0f85cc1f14cff10e.1750927989.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/06/2025 09:53, Carlo Marcelo Arenas Belón via GitGitGadget wrote:
> From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> 
> If the setup for the SIGCHLD signal handler sets SA_RESTART, poll()
> might not return with -1 and set errno to EINTR when a signal is
> received.
> 
> Since the logic to reap zombie childs relies on those interruptions
> make sure to explicitly disable SA_RESTART around this function.

Given "git daemon" seems to have been designed with the assumption that 
long running system calls can fail with EINTR I don't know why this 
series is trying to use SA_RESTART in the first place.

Thanks

Phillip

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   daemon.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/daemon.c b/daemon.c
> index 155b2e180167..7e29c03e313f 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1116,6 +1116,25 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
>   	}
>   }
>   
> +#ifndef NO_RESTARTABLE_SIGNALS
> +
> +static void set_sa_restart(struct sigaction *psa, int enable)
> +{
> +	if (enable)
> +		psa->sa_flags |= SA_RESTART;
> +	else
> +		psa->sa_flags &= ~SA_RESTART;
> +	sigaction(SIGCHLD, psa, NULL);
> +}
> +
> +#else
> +
> +static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
> +{
> +}
> +
> +#endif
> +
>   static int service_loop(struct socketlist *socklist)
>   {
>   	struct sigaction sa;
> @@ -1136,6 +1155,7 @@ static int service_loop(struct socketlist *socklist)
>   	for (;;) {
>   		check_dead_children();
>   
> +		set_sa_restart(&sa, 0);
>   		if (poll(pfd, socklist->nr, -1) < 0) {
>   			if (errno != EINTR) {
>   				logerror("Poll failed, resuming: %s",
> @@ -1144,6 +1164,7 @@ static int service_loop(struct socketlist *socklist)
>   			}
>   			continue;
>   		}
> +		set_sa_restart(&sa, 1);
>   
>   		for (size_t i = 0; i < socklist->nr; i++) {
>   			if (pfd[i].revents & POLLIN) {

