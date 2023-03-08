Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360BC678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 17:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCHRUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 12:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCHRTe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 12:19:34 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6EF5A6CE
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 09:18:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n6so18326778plf.5
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 09:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678295863;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fY2KhXONW2YlmmcFlnUniJk/niWNc1vR1yBtwTz1bM8=;
        b=hKVGYCkKtp/Xe9nTV5C58WP836JaEayRBuQahxeEUv+T9hX0XP+3Xpyg2D7bNnCI28
         1Zdj6MQUZRhPkq9O9GsyJJyToh4Gpar2eFsO645uPkqrlV5FItn/VQeR/aZMam6bFSaM
         U3vKzBO/uA2eGqctqKopHfPb4azbY8oTJ/Rwso3t89tQrl8s0+xiijoly2lpOxmylr3w
         t8qaCNosqPB8yncnOT+XLKvNomHZceX1W99yCkozoJAelkU4GWh0Ew2TI32hpuTERYRn
         BFJ7hDUYdt9uikGh60o4zGrI8aJYMW6IO3jcryvrXu+6ZEwVb4k7HkkP+EuZJKOkACDP
         MOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678295863;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fY2KhXONW2YlmmcFlnUniJk/niWNc1vR1yBtwTz1bM8=;
        b=GHz60XuJmfDH5sOD/TZkFTRx0WV86boqjc3kBDhbSB4xIvLuxenvAdC7Hn+GYnFi0+
         Nh4mipEUn7w+5LUfPanr3KJ3SZqYhgKrL2ZTWsqrTr/3qz1gJqXdQXYecwbqsRTsVx6N
         g357S4nKrH/GyrbHjtpuoxBTHGyvO3/beshAitf+Zg05SoEbNJ1cvuZRGoG9zS5yZgf7
         NAhk32eVxYzfzCsjJkH5pKGSPTSfK6dmxgTtR1oPJ7hrM3DBFNCtFmOfCkWwj6IiOwfW
         96ccSh1WoJiaAYWkUi3yJx/i3eLAqXYrMCojeN5UWTgVFDGBLhQcPIYTnpYzhWJ7sNvd
         lspA==
X-Gm-Message-State: AO0yUKXp64A2ZDEk6YGkrquVB2jcIfZEkNLcnosRA+ck+zkix6BDpgIo
        k6PHpdf/yorrKMpZJjivyq4=
X-Google-Smtp-Source: AK7set8rF8CIEC0V9Vl5HmI1T/wCkzsJoB9bQKYNeE3nSQKcCRFLBygJ3RBOM6AvX4UJOxDnU6FGqg==
X-Received: by 2002:a17:902:aa84:b0:19e:76c2:c62 with SMTP id d4-20020a170902aa8400b0019e76c20c62mr16263807plr.15.1678295862760;
        Wed, 08 Mar 2023 09:17:42 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b0019cb131b89csm10110033plf.254.2023.03.08.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:17:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Matheus Tavares <matheus.tavb@gmail.com>
Subject: Re: [PATCH 1/2] advice: add diverging advice for novices
References: <20230308024834.1562386-1-felipe.contreras@gmail.com>
        <20230308024834.1562386-2-felipe.contreras@gmail.com>
Date:   Wed, 08 Mar 2023 09:17:42 -0800
Message-ID: <xmqqcz5jupqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The user might not necessarily know why ff only was configured, maybe an
> admin did it, or the installer (Git for Windows), or perhaps they just
> followed some online advice.
>
> This can happen not only on pull.ff=only, but merge.ff=only too.
>
> Even worse if the user has configured pull.rebase=false and
> merge.ff=only, because in those cases a diverging merge will constantly
> keep failing. There's no trivial way to get out of this other than
> `git merge --no-ff`.

A good description.  Without this explained, the instruction to run
"git merge" with "--no-ff" in the text would have been puzzling to
readers.  At least I was initially puzzled as I read the patch text
before the proposed log message.

>  void NORETURN die_ff_impossible(void)
>  {
> +	advise(_("Diverging branches can't be fast-forwarded, you need to either:\n"
> +		"\n"
> +		"\tgit merge --no-ff\n"
> +		"\n"
> +		"or:\n"
> +		"\n"
> +		"\tgit rebase\n"));
>  	die(_("Not possible to fast-forward, aborting."));
>  }
