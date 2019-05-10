Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5D41F45F
	for <e@80x24.org>; Fri, 10 May 2019 13:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfEJNp0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 09:45:26 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40351 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfEJNp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 09:45:26 -0400
Received: by mail-yw1-f65.google.com with SMTP id 18so4773270ywe.7
        for <git@vger.kernel.org>; Fri, 10 May 2019 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xch1WsGv8jGE5clBuOwiiu0IQLck8acbM7uHVFE1Y8Q=;
        b=bsrX46POdxK70vcQOsqYHoqLsdXBPuJZRPSuL4eK1k9ods7czRNLD5sTQ3tHIq6exB
         t7ek7BMLoIehMaRGucFKoEtKGph4PkFtnQPTyTfUVBt2o4/C4cxpVeUpoUOpQFSgjID6
         2nrJBLLpIT8TaZE2tgBz6Os9MT7GYv42u50ZE6ff0g7ZJzOd9XOmRC5FR0KXylOrkUw/
         JwrNdThoHtGXP2Kpwi+t3QPQOxVOi5NNltpYN4X6CEFaogIOA/CrehLnYEtU1FfkfyO7
         l+vLhfcuR2iA3TJ/myj9++/6cwsxPUHSra1IGMsl0ilruB9elB2dVLoZnthmObJq26NQ
         4Bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xch1WsGv8jGE5clBuOwiiu0IQLck8acbM7uHVFE1Y8Q=;
        b=Ill9GF97GF3MA94Do8PNI1B5iTngGVFNmrRBPk5XkuRSaofAyOmO/8lPIjR2IHo4Qq
         XOuMvfTWYQ8bTYr/iBoepfZcG8AkkneSL1scxHhPEMYxJOnU0pKDeC3h/xhYM/LTGN56
         90F/qVW/JiuUIHM2vzoP9CBQvbXbThyPvjXR12kzoC4RZW/WbBkI/XycW76sXKQq08Fi
         L47dVHQMbPA13CNkp9ygq0SQ4cR4HtsBVzeDhKhGKSRuxm+q6bEIPTgnZhBR6f7k+TY/
         PlwqkP6OjR8WXBwBm3dODtyRiI+NTgheI3YIGcHbRePdKG44jSZiRgwshPSo76tOhHT4
         MCpQ==
X-Gm-Message-State: APjAAAXDSMBP+P1gpo61+ykbARTTBilhyXUIwbU7Eq3UU45szu1y6l4N
        V3fr/w0uYyKuw8CP9cKNi84DR2lD0XY=
X-Google-Smtp-Source: APXvYqycp027Pi8DQXgwM+sfJWGHEYmEc+afoLcaMrtsLPN+nAdxG7K91CPhoJlrMs/PGvK0YI2Qow==
X-Received: by 2002:a25:26c7:: with SMTP id m190mr5508292ybm.486.1557495925624;
        Fri, 10 May 2019 06:45:25 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l65sm657205ywd.13.2019.05.10.06.45.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 06:45:25 -0700 (PDT)
Subject: Re: [PATCH] trace2: fix up a missing "leave" entry point
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
References: <08be5aadbef7f6b404d2e1c47cf3657ced585ba1.1550874298.git.gitgitgadget@gmail.com>
 <20190510133738.4511-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1242af07-aa42-140b-0866-6227df52a886@gmail.com>
Date:   Fri, 10 May 2019 09:45:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190510133738.4511-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2019 9:37 AM, Ævar Arnfjörð Bjarmason wrote:
> Fix a trivial bug that's been here since the shared/do_write_index
> tracing was added in 42fee7a388 ("trace2:data: add trace2
> instrumentation to index read/write", 2019-02-22). We should have
> enter/leave points, not two enter/enter points. This resulted in an
> "enter" event without a corresponding "leave" event.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 61b043bac3..4fad4e3f9a 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3131,7 +3131,7 @@ static int write_shared_index(struct index_state *istate,
>  	trace2_region_enter_printf("index", "shared/do_write_index",
>  				   the_repository, "%s", (*temp)->filename.buf);
>  	ret = do_write_index(si->base, *temp, 1);
> -	trace2_region_enter_printf("index", "shared/do_write_index",
> +	trace2_region_leave_printf("index", "shared/do_write_index",
>  				   the_repository, "%s", (*temp)->filename.buf);
>  
>  	if (ret)
> 

Thanks! Obviously correct.

-Stolee
