Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4ECC433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59AE65140
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhCPTHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbhCPTGj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 15:06:39 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A23C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:06:32 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t16so9139571ott.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r61WWzHrBw5EfmoSrWNWU4847XBOPz13Utvv93uqWrQ=;
        b=I4f8hTEil8/3TaOYWT+oEg6ZRpvTEjwlPojE44sJajNVzA1j0nYvm1mD7nQtIN4EOZ
         aqxuybTjs9NgxlooQsCjgKVX6Lx2I7NPkO1ClbccQlNW8FzwIFW/dDLacTC5TtAKUJck
         ILjVmezMCc9Qx7Ddy7OKZYIqW4wdHqsSXbYHU5RzlQYPtI7lYwnX0uM3JIGVkpZp5M7E
         IBuhDPj3LvgYbKQ1RYafhxA3EApGfm6z78VnmikgAPXbA+D8GZ9PBKz+oO3Me0xEx8Ui
         EEoj/6dJwnh8Gb3GDT0TbCPgd+btiLG7OWW96vR3hPs1NPDbq1OGBhs6VUrZldOyiksw
         7/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r61WWzHrBw5EfmoSrWNWU4847XBOPz13Utvv93uqWrQ=;
        b=rG9GB4ZmLSQDyBmdQeJ2a93cvzzwRnZcRXOeNpCyS+7X7SDitFpNAlv19V1FZpugr4
         FzN2GE/Ft8TFhr2oGRfHPLMsYYp7nNbXsgNgk2BVuQ+TcBfATNG87WMnBOrd8vcNAYPK
         wS9Pbg21A5IKoTMTARwFVz+K1KouwfB4X9DBB2AeZcbcwJyM7Y0pLcyvSLJ/JwNQo5Xs
         3aWu+nWJ9tQA6l305oe/0ICIlyf8kE6ZCnJj5VV1Z9FY3fLn2k87VklHGnh76htbz/AR
         a2lM/pDVpATRt5km7b4i2qDVfAqp3kk3rh3/0WpyqWRvTrRds3jxRb7wksDlQD5EvYqj
         v8yw==
X-Gm-Message-State: AOAM533CnpYfKsePaGHFmPzgb/B693cyZ9w5AgU1YwMc7a7mN+/DhBhW
        E4v3mTt6y4qoVPXUoaHVsOg=
X-Google-Smtp-Source: ABdhPJxVjeZ/RSeDruOgQR23gYkA75iD1ShLAgjYAV0hkxtAD84cYDjOk80MiOxERHOoSNNyHTqvZA==
X-Received: by 2002:a9d:4b8d:: with SMTP id k13mr225860otf.354.1615921592307;
        Tue, 16 Mar 2021 12:06:32 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:fcd1:da21:8108:69bc? ([2600:1700:e72:80a0:fcd1:da21:8108:69bc])
        by smtp.gmail.com with ESMTPSA id h9sm4453940ooi.22.2021.03.16.12.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:06:31 -0700 (PDT)
Subject: Re: [PATCH v4 04/22] fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC
 macro
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20210306110439.27694-1-avarab@gmail.com>
 <20210316161738.30254-5-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b0d72d72-6e3f-0022-417a-2dc253b7dac5@gmail.com>
Date:   Tue, 16 Mar 2021 15:06:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316161738.30254-5-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2021 12:17 PM, Ævar Arnfjörð Bjarmason wrote:
> Add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro for those that would like
> to use FSCK_OPTIONS_COMMON in their own initialization, but supply
> their own error functions.
> 
> Nothing is being changed to use this yet, but in some subsequent
> commits we'll make use of this macro.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  fsck.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck.h b/fsck.h
> index ea3a907ec3..dc35924cbf 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -45,12 +45,15 @@ struct fsck_options {
>  
>  #define FSCK_OPTIONS_COMMON \
>  	.walk = NULL, \
> -	.error_func = fsck_error_function, \
>  	.msg_type = NULL, \
>  	.skiplist = OIDSET_INIT, \
>  	.object_names = NULL,
> -#define FSCK_OPTIONS_DEFAULT	{ .strict = 0, FSCK_OPTIONS_COMMON }
> -#define FSCK_OPTIONS_STRICT	{ .strict = 1, FSCK_OPTIONS_COMMON }
> +#define FSCK_OPTIONS_COMMON_ERROR_FUNC \
> +	FSCK_OPTIONS_COMMON \
> +	.error_func = fsck_error_function
> +
> +#define FSCK_OPTIONS_DEFAULT	{ .strict = 0, FSCK_OPTIONS_COMMON_ERROR_FUNC }
> +#define FSCK_OPTIONS_STRICT	{ .strict = 1, FSCK_OPTIONS_COMMON_ERROR_FUNC }

OK. It seems like you are converging on your final definitions
for these macros. At first glance, this seems like unnecessary
split to demonstrate the tiny changes between, but it could
just be done with one change and a description of why you want
the four different entry points as macros.

Thanks,
-Stolee
