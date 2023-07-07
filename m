Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2930CEB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 08:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjGGIsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjGGIsi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 04:48:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396131FDD
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 01:48:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9939fbb7191so304796266b.0
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688719715; x=1691311715;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AQpi2GFJEbDkVjdBS3gFRlDo0hZa7Ilak15pp7nmy6k=;
        b=hUwAW1u6b/BIxFNiy5nuM9FrYis7Ww3QsZwmiO0ivbQ8uQo6QEjID6/NMOYEY7rYFa
         Ynql/7SbtaQDLsaentPMme3hS3KBrVmqjVjFxzhMVusyzQvMb4J+3BaV+v+YveWXHCjW
         tIbPlSDEQ0hAmC04K5ofpJDhuhQOtbahL9Qz3S7aKYujN7pu6XwoCha1q2Uw2FEBqSED
         Yi+EoR8AcHJnKypIFMXtcg8Z0j2do3hPUwLbSsI0k2zgQBSoreJcIHNsebvlM17mwUWS
         MFGehDd8kBBW0Mkqwcc3ZC7uOuLBvIMUTmpw6W1g7PRrLLVi+KJbuL3i40i8IFe5VPax
         fp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688719715; x=1691311715;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQpi2GFJEbDkVjdBS3gFRlDo0hZa7Ilak15pp7nmy6k=;
        b=UScwghzZy1K7jsGmzXlYx9ojgbZWX9oTR6MdBHkJAFWp1yssomowkcT2dFGwWQfc0F
         /KvhQZBF4eMc22l7E7vQ3u5pkW7dc6zyi3JgUyK7VzyivWrfZHM+8Zk94IYyjxrjE6W1
         0WvkdOcaYDBPAPdHVzmap1u2/AFRftKSZu87xm9fKQRVdYaKorrnpv4mk/ciaoedlA5X
         Z/4fZ6qmTXFK7tMOnuGH2sml0piTWd/muTRmMyO/CteNlJR4Gb5DguJ5lRXH7oSeEtz2
         9WjtO5jlBRyPe+b9jXN6TdMGT2kNMequQlEvQE+Q3TjuMquRFgjgx6u9NXTAISimdG7B
         aifw==
X-Gm-Message-State: ABy/qLaJ4rLj8yhbtlNNXNK5HZIdldg3ucZ45BUeKnhCnDQPE7rz//s6
        2Fe5urBSVS8wSsv3vUSFyuo=
X-Google-Smtp-Source: APBJJlHaaGiRXoLH8FXNm2oZ/Fubqs5SiNWH0rFunCuHaAbV3gZnyk/xvndKe6kFffvG2zbEdrkHCw==
X-Received: by 2002:a17:906:7490:b0:993:d8c0:f0f6 with SMTP id e16-20020a170906749000b00993d8c0f0f6mr78701ejl.1.1688719715435;
        Fri, 07 Jul 2023 01:48:35 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id y20-20020a170906471400b00991dfb5dfbbsm1885237ejq.67.2023.07.07.01.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 01:48:34 -0700 (PDT)
Message-ID: <0a001080-4d1a-75b6-1b76-ed132f126bf4@gmail.com>
Date:   Fri, 7 Jul 2023 09:48:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email, gitster@pobox.com,
        phillip.wood@dunelm.org.uk
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com>
 <20230706040111.81110-2-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230706040111.81110-2-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 06/07/2023 05:01, Alex Henrie wrote:
> Also, don't imply that `git pull` is only for merging.

While the cover letter gives some background for the reason behind this 
change the commit message does not explain why the proposed changes are 
desirable.

> @@ -2323,7 +2323,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
>   			base, ours, theirs);
>   		if (advice_enabled(ADVICE_STATUS_HINTS))
>   			strbuf_addstr(sb,
> -				_("  (use \"git pull\" to merge the remote branch into yours)\n"));
> +				_("  (To reconcile your local changes with the work at the remote, you can\n"

This is a welcome improvement but I think it would be better to say 
"integrate" rather than "reconcile" to keep the wording aligned with the 
advice is builtin/push.c.

> +				  "  use 'git pull' and then 'git push'. To discard the work at the remote\n"
> +				  "  and replace it with what you did (alone), you can use\n"
> +				  "  'git push --force'.)\n"));

I share Junio's concerns about giving this advice after "git status" or 
"git checkout" especially as we don't know if our remote tracking ref 
accurately reflects the current state of the remote branch.

Best Wishes

Phillip

>   	}
>   	free(base);
>   	return 1;
