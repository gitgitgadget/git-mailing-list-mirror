Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5693806C6
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773518900; cv=none; b=gRqv8aAQsx46PNHabFB70lM1T0OAhPshSItY1KUNMu19n3WEkxo7hmr13/01zL8Nk0joLpcHbta7ibhGpFtDrS0jBIVhhMFsnrBFE6EXykSxt6Ir9+m4BgpmEPPm2T2hfWFOFwufjSrFc9SBs8wHwjaCHz+3kBFoPbJEeuT9TFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773518900; c=relaxed/simple;
	bh=7QEhOjAdvKCLOzw0x5i4EU6E/3OCTxupN4oJX76VFoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caUdlwVEb39CqT6hh1ovDzccbXxWlKQCnaMd3BzEn4LkG5PuyF2hJ60w3icaR7WN4GAZiWh3PBQKLNd6TzxtWQT6BponHX0r4sLSWVWZGP582kv00lg9HC1Vab3OeDj4KfsveDc5+CeMAdTn7jmaDqmGoSzKVOiSii7hwHCgBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntJpqhs+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntJpqhs+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-485445e80bdso28631475e9.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2026 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773518897; x=1774123697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HlwXiFhzd7zaNMzuZWuPji+CAYbZ5nig2wr3cb2FE/k=;
        b=ntJpqhs+oHlcgVcbScdl9qBj8weuovXt7Q2YXHEUrInVXRG4ceoTPNKQPIBa7zaGpP
         81+sWu0XePO/VotbVaRQ/FW/dvJoq2k0jPF87vuOo+sRd6zqtulz9eJtlLmZqg6/nzem
         k/WTNf2Ysm5UcmLdWYqbnrB3bCOizbvR7fPEERmKtrov5e/sC8k7xmZAMHE9xDwpjkkq
         aiBkIZ87xreGjPtpOQ7NujdYXzJ5b2xqZbt27duUDbCIX3oeRxs/O7x5Bt9FNfRH+tcf
         q8m47Q362dZOEO2DtTG9BdY45q2PMSF/ICIm/41iqdn803wUbOFI85zzrNfVNSxhDWYZ
         AG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773518897; x=1774123697;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlwXiFhzd7zaNMzuZWuPji+CAYbZ5nig2wr3cb2FE/k=;
        b=sKohtIR1rtsoJsucNdsY00is2dZ7pGvGCOhf2LZh0WUuA837QmX+Zq2YBYdwGbR3C8
         cIDw3R87w6AINUVQvGo/Cf9CB0RZjYvvLYPgF9VUiI+4f+C9CLjzPAjKNcHUlviiZEsM
         EckFl3cfKZBTbe5nKRRnsZ8r0Zpq8UiZaGYuYWwWuK2oUriOMghiyhsql9LauT83YARL
         6rBhGM3VoB1q6tgYfvH/VvRkkclCltBG6lRlFutgYmd+aWyRb83X4d96IFxsb4OQWzj/
         GEQ95aUxPGDEOiFwjG/3I6akFJeWFHiJfIL24GxWXa9ZxOoaZ/iT3tcBlwTt7zvf2xA6
         OJuQ==
X-Gm-Message-State: AOJu0Yxs5X1wFVaxHfYa+3qpAF5VQXVS5IAwUHjjDKIlPCuYsaK4XDvf
	18LpfyMWrN9KzQZRn5px0ovbFGoR8Hm0FoSl71IBwgrNj1tfEn5IYI14
X-Gm-Gg: ATEYQzyJRM0Y2h7Ssi8fvDJJ/VNoA+WsJKXFKyoK4Ipaa7QQkrIuyUaLC9qOIo0zetE
	owEThJhzQwTayAFU5ThqvezARkphcvp5cKg3RPLCx1wjk1tcUdU9irFfVbVXAJWKXnTRznrAYhy
	7GEZFVjc9uVPMbF5BYOcaO5w9gWLTpfyEeGAd9peXUSauKmwWlssstpvuWrZpUKkYlvqSXGuT5j
	Et9gaiMYuKPJzeOVt8rlV+fzFWcPmXwKiq+ObGmq9rP2hKt1gj3mZ1dMnQ056+UQeZos5qr0qM0
	oN4ml8uOysRqz2IbKg1iXAUjYR384oxNDPLRfsSB/foLLRClXyxDhEJt8JUCd238ERPnG885fJR
	9xOLLWZ4ZBFRl2BFrLpSHsxpK34X6drJouiZOzQeOhhunV12drYBgYeKKhDlrKl8ehPeGOeWmol
	Iv0MppFscVSykh+1WzmQLzvfgIozLToNpi9FIpMi71cHZc2ht9P5HuoN1wvdMWqyLPcZxam7ntE
	/1JaQ==
X-Received: by 2002:a05:600c:a39a:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-48556728b5emr94283165e9.31.1773518897328;
        Sat, 14 Mar 2026 13:08:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855638cebcsm106738555e9.0.2026.03.14.13.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 13:08:16 -0700 (PDT)
Message-ID: <ca6e021e-0301-496d-8bd1-b646487ccbf6@gmail.com>
Date: Sat, 14 Mar 2026 20:08:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] remote: use plural-only message for diverged branch
 status
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2239.git.git.1773479526823.gitgitgadget@gmail.com>
 <xmqqqzpmwdyi.fsf@gitster.g> <xmqqtsuiuugy.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqtsuiuugy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/03/2026 18:38, Junio C Hamano wrote:
> 
>      remote: don't use Q_() when it is not needed
> 
>      In this code path, both ours and theirs are already known to be
>      positive integers, so ours + theirs will always be plural, never
>      using the first variant given to Q_().
> 
>      Just use _() with the plural string only.

There can be more than one form of the plural string though. The gettext 
manual has the following example of the Polish translation of "file" for 
different numbers of files [1]

	1 plik
	2,3,4 pliki
	5-21 plików
	22-24 pliki
	25-31 plików

ngettext() handles that correctly, translating a single string without 
an associated count will not.

Thanks

Phillip

[1] 
https://www.gnu.org/software/gettext/manual/gettext.html#Additional-functions-for-plural-forms
