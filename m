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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B4C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B14B965070
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240235AbhCPTAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbhCPS7l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 14:59:41 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B2CC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 11:59:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id n79so36397821qke.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t/lv4/ZHCX0CpNJ6oUKe+zEH+eGrQbMxoDjnRlkMNsc=;
        b=jhBk9JfkC2JEuFZ/R/0AUCdFUp9Rtx8GrveI2GAibNiibHvKQsbBZecZAc45OfvlbF
         C1gn8TU/8GlMI+7PnXQAbXG2C11qA2KN5RxOcNeyee9sQegGuwD9mK1d6xMAl6Es1Q0c
         WQOGxQVC1ZVGMcU/FAxEoZIYGiG+eS49Ljt7TGYkPydtWYclfCtofQdfaDkcvLWhBMDa
         Z+Y5NnA0iS3CYCGG5LhFQCM3OWS89G8yYpWdi4nCLZcMoaAjbsl4nfKTVr+RUz/y8nlw
         5KKjFEpObp1wemsJbh3dUz7/KMZHkkfr6nKUJX14jpqX2+qHfHwaWk/IfSmMOgvCqXbg
         oa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/lv4/ZHCX0CpNJ6oUKe+zEH+eGrQbMxoDjnRlkMNsc=;
        b=Ai/4glqeoZ8lJJYJ5IjMztqIWifDlLuVueUuNjcuvAe6BBYmDBw8qPC5O/FLNfy1Cg
         E+XjNnfZlxty0Y74xnJOuxyAG88sZWEmqFiqvCRSsA1hPY+TRCV/FZQ1h2qYqLGkYtBP
         9uRZjMPz8XvYKHCSWe6m3BVeWOptL5ifC11bdsYIN8ZtOgWUzwcXBWTBzIkdfFXK4uNw
         z4FBSSkbOX7oRsM4iTlLEOBMEipWZX5UAlgwc//y7xdeIjvi8irHQVE0R4RDt9/METWu
         j3purFovxY9T0d4+tP7uA7Ec4q5+n8gvNPQ0O/wao7XNvzIKfDrgzKIh14i9Xzls9Q0J
         Fi8A==
X-Gm-Message-State: AOAM531hrCEOttH9fcBn6bL9uzCtybAuDXLUPx48mGKgVQ8xDqkdTvbB
        XdW0/3ZDyT+Q9FbHYpT4QzU=
X-Google-Smtp-Source: ABdhPJyHbHCOTZO/PsC4wVrw1DJZpADnTc9xRhONrvoDRDRQhuXWXyjMBhhDZawH/1IXab/HoR3zOw==
X-Received: by 2002:a37:6c01:: with SMTP id h1mr585115qkc.182.1615921179834;
        Tue, 16 Mar 2021 11:59:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:fcd1:da21:8108:69bc? ([2600:1700:e72:80a0:fcd1:da21:8108:69bc])
        by smtp.gmail.com with ESMTPSA id n2sm13175810qta.61.2021.03.16.11.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 11:59:38 -0700 (PDT)
Subject: Re: [PATCH v4 02/22] fsck.h: use designed initializers for
 FSCK_OPTIONS_{DEFAULT,STRICT}
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20210306110439.27694-1-avarab@gmail.com>
 <20210316161738.30254-3-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eba92c82-1a19-f1ea-1bad-a639b9eb98bd@gmail.com>
Date:   Tue, 16 Mar 2021 14:59:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316161738.30254-3-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2021 12:17 PM, Ævar Arnfjörð Bjarmason wrote:
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  fsck.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fsck.h b/fsck.h
> index 2274843ba0..40f3cb3f64 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -43,8 +43,22 @@ struct fsck_options {
>  	kh_oid_map_t *object_names;
>  };
>  
> -#define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL, OIDSET_INIT, NULL }
> -#define FSCK_OPTIONS_STRICT { NULL, fsck_error_function, 1, NULL, OIDSET_INIT, NULL }

You just edited these lines in the previous patch. Seems unnecesary
to split them. You can point out that the object_names portion was
previously excluded in the message here.

> +#define FSCK_OPTIONS_DEFAULT { \
> +	.walk = NULL, \
> +	.error_func = fsck_error_function, \
> +	.strict = 0, \
> +	.msg_type = NULL, \
> +	.skiplist = OIDSET_INIT, \
> +	.object_names = NULL, \
> +}
> +#define FSCK_OPTIONS_STRICT { \
> +	.walk = NULL, \
> +	.error_func = fsck_error_function, \
> +	.strict = 1, \
> +	.msg_type = NULL, \
> +	.skiplist = OIDSET_INIT, \
> +	.object_names = NULL, \
> +}

This explicit definition is better.

Thanks,
-Stolee
