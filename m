Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B906C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 14:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiGUORs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGUORr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 10:17:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F665D72
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:17:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so2477003wrc.8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5kjjkpoek4P8MgLTS9gLgGFKHzKUW9wcqj5zOWpWLQk=;
        b=EQatKxMaLH4yh3D/YSTROVPyBi/aSJIKNb859b4mHKZYin4nkuRGMcTNNl2jK3iWCR
         vPdz0c3pFGGzPYpEQq3EZ2oi57l6PcQH/Jj+bwexqnNOrX0dpz7opj8lmgBbhv2bYvA9
         3ATyXmYYkmDDCwhfYzKT5DatUMQ5dTx+OANTHvXlnMshIwI2UPW85WUINQEpMiTo+ipZ
         mZG0esMhNrSDc6tdC8Ubqz65fbbqVgbiCLAHp9sT7Tn0KIVWgu0e8gueN6y487KCb6Mm
         9uiQQendn2yHwBOTpcoExGDYSUHEiRcOLqjFxGO+C3tWuCVcnOKlnBhm5ueQFfRzaRn3
         9oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5kjjkpoek4P8MgLTS9gLgGFKHzKUW9wcqj5zOWpWLQk=;
        b=3h3A7wfslzQS13vA43nJaFzUciRl14N1WZURQQuU4YtstNh+7MM0Ac3m4mbkPBLmc8
         rv/Y0Nviq022vgIJp7VX3h3O3zgGjIFCn1DfV1uTPRCwqliAvxix3DHpXIf/yyS4YCET
         hzR3ATjzadwxkvo5RPPGCUzZo9VKwLFqGRaLRBj912UD6H2V1pqMD0wEewY5gH52uiQp
         /M41o7OEux4rtAR+rWr5SmdNObPLIuRoO9tm6FhxoZaG5UrDjpFz5TGOQn/joNv9NnZ5
         136Yl7jlz1FAxKnnu9GzhsLk5J7DjsK/kDwGS458BPks5YD50dNsJV8rsw2yruotRAln
         Dv2g==
X-Gm-Message-State: AJIora9thoIR4I4imzC5yqO5DxVGQVW7C27B1SZSHTMn4d//Mmjlnlpx
        Yci/7TtnFbBDO76hdr9NSLQ=
X-Google-Smtp-Source: AGRyM1tfYQGgNF3Kch5PBgfhLzacqQ1/6S221vTcw01Gr67oOrbj8KBUYWh76If+UNcJb3gNr0hvyA==
X-Received: by 2002:adf:e9cf:0:b0:21d:7b89:da5 with SMTP id l15-20020adfe9cf000000b0021d7b890da5mr34214025wrn.346.1658413064620;
        Thu, 21 Jul 2022 07:17:44 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d4a4d000000b0021dff3cf67asm2067950wrs.10.2022.07.21.07.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:17:44 -0700 (PDT)
Message-ID: <653c6a24-df30-2b06-4cf7-f01bd6012d55@gmail.com>
Date:   Thu, 21 Jul 2022 15:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] compat/win32: correct for incorrect compiler warning
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1294.git.1658256354725.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1294.git.1658256354725.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index 1f8d8934cc9..0af18d88825 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -44,6 +44,7 @@ void syslog(int priority, const char *fmt, ...)
>   
>   	while ((pos = strstr(str, "%1")) != NULL) {
>   		size_t offset = pos - str;
> +		char *new_pos;
>   		char *oldstr = str;
>   		str = realloc(str, st_add(++str_len, 1));

Not related to your patch but this context line looks suspicious as 
str_len is incremented without checking for overflow. I did wonder if it 
should be using a post increment instead and was using the st_add() to 
check if that overflowed but str_len is an int so we'd still have 
undefined behavior.

Best Wishes

Phillip
