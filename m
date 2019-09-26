Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91FA1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 13:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfIZNNL (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 09:13:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41250 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfIZNNK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 09:13:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id n1so2753264qtp.8
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yLFbhR2F0g1vgCk6h5eQr8Tm7De82clzvtZsfV9PKUc=;
        b=eZiIxJ7/CqSiRnusyx/HZqGNm0cXkI+nyPuLH8BcVW0dzJ8Tjb412lcIpXzOk4x8Cl
         mbskOalf4jLS9Lg6DZlacEYeGufs164lr1s1Is8Mzr9I4Mj1NGywiJ3q6QmVgR8rNhDR
         2EZOBZK1rPx83eH1VVUil7Kd0f0aQF5MyD57ZbOH4+FGNIw83RVTryWYWk+XNW/9D/3o
         f3SPWdZpLT+XFK309mkbchTbJcnTk/Pd78bn7cnEZ/ovoebjznkAIlOidLjekhY7Mzxo
         Z1/wtduEp2286Z43FaQHC+lMunLxc9vaAIyXjaAEfNb4H9Fglhw2AF00hrBZRZ3fApV7
         Gfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yLFbhR2F0g1vgCk6h5eQr8Tm7De82clzvtZsfV9PKUc=;
        b=F0JPg8Zn3HVUcCnGMAVE77QWORfT8sfar8Rd1Zb6NoNGrphIZY10WT3oBL5ejpQUdv
         KcgOolkFh+NbgiaWy5Qn/stqlYr2deodlMzrJiPxjHxqYrHOmt1MWzO5NZYejjq2NWhU
         9VUiHLcgaMLrvklxwxrpgGv8X4TjlEc6khYYJZuCNaB8wxLY77tn80p8BjR/SXX0twTS
         q77g0Yt9brfjbK8um9HwTnPgfKe6GfbdBsJkJja9FKr6mGl6W1gSNGs3QnDKTSAiEMLA
         Ip7cpcbfKttWDFF7tjysM0P6ZtTR0Hz35U174OnzE/v0fjCEq2GZ24T4WKYDSJMe/5RD
         XbFg==
X-Gm-Message-State: APjAAAWBtvO/spVeLMl6jfeTQ9a44WS24HxPmw6cEKLB3vT03fGWxizG
        Q6kzVntpPyge+EQdxnLEGDA=
X-Google-Smtp-Source: APXvYqyhO97JxX9QEnyjN1r6GUlwkZvQc9IJpaZV+NV8tPITJJ+qkqy07caOK3xd+LwvlawZSbXspQ==
X-Received: by 2002:ac8:f54:: with SMTP id l20mr3850121qtk.355.1569503589906;
        Thu, 26 Sep 2019 06:13:09 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b594:20f6:c10f:d45d? ([2001:4898:a800:1012:66c8:20f6:c10f:d45d])
        by smtp.gmail.com with ESMTPSA id a3sm1339432qta.68.2019.09.26.06.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:13:08 -0700 (PDT)
Subject: Re: [PATCH 3/3] wrapper: use a loop instead of repetitive statements
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, davvid@gmail.com
References: <20190925020158.751492-1-alexhenrie24@gmail.com>
 <20190925020158.751492-4-alexhenrie24@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <03e509db-942e-4538-4729-4e345df82a7e@gmail.com>
Date:   Thu, 26 Sep 2019 09:13:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190925020158.751492-4-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2019 10:01 PM, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  wrapper.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/wrapper.c b/wrapper.c
> index c55d7722d7..c23ac6adcd 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -469,13 +469,12 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  	filename_template = &pattern[len - 6 - suffix_len];
>  	for (count = 0; count < TMP_MAX; ++count) {
>  		uint64_t v = value;
> +		int i;
>  		/* Fill in the random bits. */
> -		filename_template[0] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[1] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[2] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[3] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[4] = letters[v % num_letters]; v /= num_letters;
> -		filename_template[5] = letters[v % num_letters]; v /= num_letters;
> +		for (i = 0; i < 6; i++) {
> +			filename_template[i] = letters[v % num_letters];
> +			v /= num_letters;
> +		}
>  
>  		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
>  		if (fd >= 0)
> 

This change is clear.

Thanks,
-Stolee
