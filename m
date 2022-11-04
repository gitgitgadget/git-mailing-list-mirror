Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98485C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 14:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiKDOuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKDOuG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 10:50:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCE724F
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 07:50:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id cl5so7367108wrb.9
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UpQIsbDq3nltF5EFea80OfEDXn613ykAg/QYOZK1nto=;
        b=T/PZvYOvc/JFnJPjJeyYSY8CYhLX72tYG6RJvBNrWIk7PuOLzRojgWHS7rQG2n8N8+
         av/MxW/CWjGQIwPTji8LgzHW92m/+r6RhbupC3DkDOvWsKlB/oqopwRYlpfOTdV2+nxv
         AUslGHL+LttAVWyAV1joAN4b453IT3OLid7fSlC8ixBM5EUPXe8+eo3JOWS5/CyTDDWC
         hyeP4LRrNyFVNP/Qla+ADWgjxI+QCCg83S4utFuUgyaX5j/PZeRveKRmEQgmBuDtUqDs
         zq6g4PvhJssViMYGiamamONMYxaKPjyT3DEeFZ3KBoczOJkPWSgVMvz4/9hCYd7T6kmY
         BlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpQIsbDq3nltF5EFea80OfEDXn613ykAg/QYOZK1nto=;
        b=uvOTz5eNdRENUMHX4NMEJ/YXlYZlvxGBabLErgO0jXyxC5j/VrZGc9LWwUQfOww0V8
         rFC9/6GFxOVhw1zLyiyGh83SrGeLglape4C+U4S8xWk5ef/7JbdwQfvfOMcw6kIyg2in
         ZpXkkFjhj8PYBUss2NSPay6P3aveHi+SQPKcg9Hd8Zl7qdl0UZikpIjX5tkulvYITaqI
         kjEjAWvtgLXxuxK8yc6H+RDUt6Ujg481llP7gALlI3nH3h35puRkKm2Yjk2NWKnJuL44
         s+2n+FBKe4Ok9N6WJAjAwuHkXlw2OVfv9V4sviAkFKOkhf2Z1DzxLJjRAqReLucNGxU/
         EwMQ==
X-Gm-Message-State: ACrzQf0Jp4UMkRDpsvSZ7zPDic4pEclf6BtxseCL2qRcp0wCJx6A8Q5h
        vev2GncFpQLnsTJ9sFMY9frc1ID3s9s=
X-Google-Smtp-Source: AMsMyM6FtCunMpy1Zcv9Pcg834BnK3ESVomAeGkFiRXi6JPDz8oK2F2I2+a4Xm37nbNKAHiExdb/Yg==
X-Received: by 2002:adf:e30f:0:b0:236:d8ef:9ede with SMTP id b15-20020adfe30f000000b00236d8ef9edemr16585999wrj.170.1667573404311;
        Fri, 04 Nov 2022 07:50:04 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003cf75213bb9sm3422932wmo.8.2022.11.04.07.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:50:04 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b9f08244-36bc-b74f-ac1a-b665423bc2e7@dunelm.org.uk>
Date:   Fri, 4 Nov 2022 14:50:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 10/17] sequencer.c: fix "opts->strategy" leak in
 read_strategy_opts()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <patch-10.17-9c70bfa334e-20221103T164632Z-avarab@gmail.com>
In-Reply-To: <patch-10.17-9c70bfa334e-20221103T164632Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11/2022 17:06, Ævar Arnfjörð Bjarmason wrote:
> When "read_strategy_opts()" is called we may have populated the
> "opts->strategy" before, so we'll need to free() it to avoid leaking
> memory. 

Where is the previous value coming from? I guess it may be the config 
but otherwise I'm confused.

> Along with the preceding commit this change various
> rebase-related tests pass.

Really? at a glance the previous patch looks unrelated and there are no 
tests marked as passing in this one.

Best Wishes

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   sequencer.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e658df7e8ff..07d7062bfb8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2894,6 +2894,7 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
>   	strbuf_reset(buf);
>   	if (!read_oneliner(buf, rebase_path_strategy(), 0))
>   		return;
> +	free(opts->strategy);
>   	opts->strategy = strbuf_detach(buf, NULL);
>   	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
>   		return;
