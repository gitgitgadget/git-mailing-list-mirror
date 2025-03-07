Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A30212D9E
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343550; cv=none; b=s6CpUulR1zGZzZ9v7Xv+p24e7v5l0KVfCLWD74mLUszfenlLUFTttT8TULVY6AtY56FFD6RlanKx6ppo/+jMPB3iarQuBJZcwMLw82n8YkC4hSzVf6ORILX7ls+eSo2XEpRlnmDzewsza9iFkTVdbJHGNVzUebj0otS3lAgvQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343550; c=relaxed/simple;
	bh=lIxujJA49dqGYuXpQO/LsXPrIgjtZ6Ytz63rwGZAe1w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=thHy0XDI2QZBxzSlJg3odwuvu36p5X3m/bqW97gl3ayRHV8m7+nUMdlFlmw7xc/LQNZvLt1OoAKaxB3DVz+Vu/KCKDB4l8koqzLLhSCmcFuoaa7leourRxUZIyRcfj6qFC6u4PQo2ru7awYAJ+p9wpN5vCpB/NbDyTb7ndB3alU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF4OdqaE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF4OdqaE"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so3053702a12.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 02:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741343547; x=1741948347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr2sCF5d/qskYUAxJRVq6pjh2l4HwmBklKEvw5xvBgE=;
        b=cF4OdqaEDZdjxVXJFFOjeWPQ39x+Bn07Qer81v6CuWYLET0L/1O4t4ouHrmi6bROMM
         9tRh3YO64rtHWzpPq8EHTtnYYMl6NKixk4Rwe0Nx4cEzdvxhY5qxPt6nWdOUNnIZ54Te
         82ceGncLMPuvrOGtdp4Wgk559VN6HUxsrTkmSHCvxLSA2ukZKZOfxmeU9SWQReLeuhJS
         3hPU/g93FWQvrvyAACDd/OMc6MYEuSfUQsjbpYFRdUURXvaHL67XRGGjljRVSOCAdg5c
         Frfo5j3VQHhrZ5CPow9vIn0Cs5/Gm1mG6yEpmjNqu+eZE0Yxu6m9+sK8LCJqPz9FamTL
         6NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741343547; x=1741948347;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr2sCF5d/qskYUAxJRVq6pjh2l4HwmBklKEvw5xvBgE=;
        b=mEdjsvs2emwhoyXw7NLq93M+sru2fYV/aDv2XctqcCmvbaXE58QX1JpqmKWqtx/e31
         pYsLum4k/slX2h3hTD3+zunBf9dENutV60NoKoX/yh23pNYQrZ2MsgSBqKfaToKXYgAh
         rmLW2R/rMy4oV6hWOtZf6aON4emTo7e+Fg0yPLb3SiiaEvWokV71Bs6ms1CyzNihg9Xc
         BT5rn8Kqj89at++wqb91p4TOOU6x1JvlcQQ5eZHPi/RoB8CE3bFXQpV0r7u5YqnMh/GZ
         QDfTBAWtgfqhjy5RCNNzj2ZHeK5OpPTrMukCsnNiiWQnGZqHxrxFcydVnbJcjWwgzJ4+
         ZrIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBr5RO59F1gWGDuyaAIFqwa2fknDgcAqy7w62sa7a4+J9r2iRmvPwzMZcuYJddErBKL4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouKgr953PNSV22o87hLiQ/GdQQax9wnLMzJydUmmWjUeAxFO/
	dA1Cwzi4lG3Z/sweC+6CPgqT4An8RiULASlS2Q6vSfHOxelG0lLR
X-Gm-Gg: ASbGncvuC/L4yqtO250Lt0cYHHSfXtgpBZzZqSFHEK5OdSI2UMUCWMUDaKZUHCSzVoP
	5Oa3wrD3/6Cb8kPigD7fQFWId6O46+u4eKYe1hf3jzvMPsnVx5rzJ9SvrCD/oST1DwyAiIuYSSF
	k2fSKnjvhZbZfcxglziIrcea8hHl2vM0D25ZkGlcuxtJyucZ6hMuWjpNqi+erwBf9VAhFqtqjOO
	UOCMkzFbaHvDhyCxgF4f7Swn+Q4t5CqWAX+rYuqpGCyhbAUF6KXvySzQTc7/sVJECqLaenwIhN0
	eRir3vVFU/ugCDX4Pqhj6KlBWPAX5mmbvt0SSaAboZlZNElzr9OsaO9Om573QyvkrJEFo/W+LuY
	pqp/M3bQUWMukvm1hXIqRFfc=
X-Google-Smtp-Source: AGHT+IF5UoO85DGjG9wNYJb2UYkIW3wSiU2JTf8P+90EWnABy3tql/jGpGctPs7jnYIzidSXjpmQRw==
X-Received: by 2002:a05:6402:90c:b0:5df:5188:11cc with SMTP id 4fb4d7f45d1cf-5e5e24e8c23mr2933214a12.20.1741343546566;
        Fri, 07 Mar 2025 02:32:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7476515sm2354427a12.32.2025.03.07.02.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:32:26 -0800 (PST)
Message-ID: <082af6a3-a7ba-440d-af84-6c59827a2929@gmail.com>
Date: Fri, 7 Mar 2025 10:32:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] docs: fix check-docs with WITH_BREAKING_CHANGES
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <pull.1871.v2.git.1741171357627.gitgitgadget@gmail.com>
 <xmqqzfhzlbie.fsf_-_@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqzfhzlbie.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/03/2025 15:53, Junio C Hamano wrote:
> We correctly omit builtin/pack-objects.o from BUILTIN_OBJS, but
> forgot to add "git pack-redundant" on the EXCLUDED_PROGRAMS list,
> which made "make check-docs" target notice that the command has been
> removed but still is documented.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   * The command is still listed in the resulting "git help git"
>     output, as cmd-list.perl does not yet know which commands on the
>     list are to be ignored under WITH_BREAKING_CHANGES.

Good catch. It seems the meson build was also forgotten in 68f51871df8 
(builtin/pack-redundant: remove subcommand with breaking changes, 
2025-01-22) as we still compile builtin/pack-redundant.c and build the 
documentation. We should probably wrap the function declaration for 
cmd_pack_redundant() in builtin.h with "#ifndef WITH_BREAKING_CHANGES" 
as well though I don't think that is urgent.

Best Wishes

Phillip


>   Makefile | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git c/Makefile w/Makefile
> index a9b2de0692..95ac0820e9 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -1283,7 +1283,9 @@ BUILTIN_OBJS += builtin/mv.o
>   BUILTIN_OBJS += builtin/name-rev.o
>   BUILTIN_OBJS += builtin/notes.o
>   BUILTIN_OBJS += builtin/pack-objects.o
> -ifndef WITH_BREAKING_CHANGES
> +ifdef WITH_BREAKING_CHANGES
> +EXCLUDED_PROGRAMS += git-pack-redundant
> +else
>   BUILTIN_OBJS += builtin/pack-redundant.o
>   endif
>   BUILTIN_OBJS += builtin/pack-refs.o

