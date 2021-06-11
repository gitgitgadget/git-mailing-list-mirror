Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B889C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AB4660FEB
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFKJVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhFKJVM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 05:21:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9357C061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 02:19:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so4961730wms.3
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 02:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t2+pym2cFfo+MLFozanGaZsO/LCSuJyBlqv08veNhIo=;
        b=ldAR10xfmejESnN/VS9EwnTzFnT8Wyt3pZbsiRoHt05DA5cPshlCzKJR4sQzZhLDHo
         0/jq6MpePrhSrnlUyEKd27CdxxgJCxOEWMX1y28dihS3G5z803ex+ZnUxJg1eKttLNWR
         XGiQAyckknSF967fE97PYfcXAbMrWKlJU2RncwDiMsV/66wHAYQOTAJoc3/VlXYcx0um
         hvEOQPmVeOIbs7pg5poEwrS82AVPcgCeMqu54nxv035mQPbwbUhVgrO+pXE8io2+QIUY
         kJdgYhis0CeS3AgQFx8YH9u1ogYyZTRQearwbt1CSX3C6cg3AAR9CClbqSD+t9mJ96rS
         qxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t2+pym2cFfo+MLFozanGaZsO/LCSuJyBlqv08veNhIo=;
        b=t4lQpWnNZc8RkPp5ctYqglVcPUEWknsbeodS3XCGD7OvBKsa0t/wKWuc0T6axqHh0r
         PLpwV7VStkoJkkD2UZAyXUglUC25jfxNKe/g1PhkoxJLkpEzD6FO15yrVWRFf4UuiHTg
         B2/1zEd+B6KENIBB8zh7g7cbyyAJJh7UMD8lo6oB/zIKb4Yud5MSZOL+BmG8gXVGpQao
         YOT8iNAbhvwI8h0MjejSEOwZjl95wVXqlxTRMEalPBq4qeK86Qm97L5E7xIwnePN4SSE
         t3ZnmOPu3zHLweMMAvyYyb0KZt/9hCOM6To79s7fCTDv6m+XBN8g0U9a0F2VYopPiRkr
         jmyw==
X-Gm-Message-State: AOAM531GjC12l3AK4qKRdCoQyOUVOoXOxNlBwiZV8kLn4bvmgXtkFB8q
        Od5X/xE4qMZ/41M0DT5ekefuW4pr96M=
X-Google-Smtp-Source: ABdhPJxCesMXw+6SrZxn1kVBt0TYiuZWZLm3+6BplFYDQ5Mrj5koiOBA5MdjVV4qLGgf/7YPhi7GQg==
X-Received: by 2002:a1c:ddc3:: with SMTP id u186mr19208033wmg.44.1623403140322;
        Fri, 11 Jun 2021 02:19:00 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id k5sm6120384wmk.11.2021.06.11.02.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:18:59 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] checkout: fix merge.conflictstyle handling
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-5-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <bf1125b9-fbf1-f937-5197-e5128233952c@gmail.com>
Date:   Fri, 11 Jun 2021 10:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609192842.696646-5-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2021 20:28, Felipe Contreras wrote:
>[...]
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d146bb116f..10e6e1e4d1 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3845,7 +3845,7 @@ static void merge_recursive_config(struct merge_options *opt)
>   		} /* avoid erroring on values from future versions of git */
>   		free(value);
>   	}
> -	git_config(git_xmerge_config, NULL);
> +	git_config(git_default_config, NULL);

Now that all callers are required to call git_config(git_xmerge_config) 
before calling init_merge_options() this line can be deleted.

Best Wishes

Phillip

>   }
 >
>   void init_merge_options(struct merge_options *opt,
> diff --git a/sequencer.c b/sequencer.c
> index 0bec01cf38..9e2bdca0f6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -34,6 +34,7 @@
>   #include "commit-reach.h"
>   #include "rebase-interactive.h"
>   #include "reset.h"
> +#include "xdiff-interface.h"
>   
>   #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>   
> @@ -224,6 +225,10 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
>   	if (status)
>   		return status;
>   
> +	status = git_xmerge_config(k, v, NULL);
> +	if (status)
> +		return status;
> +
>   	return git_diff_basic_config(k, v, NULL);
>   }
>   
> diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
> index 44f79ac91b..485ad0eee0 100755
> --- a/t/t6440-config-conflict-markers.sh
> +++ b/t/t6440-config-conflict-markers.sh
> @@ -89,4 +89,35 @@ test_expect_success 'notes' '
>   	)
>   '
>   
> +test_expect_success 'checkout' '
> +	test_create_repo checkout &&
> +	(
> +		test_commit checkout &&
> +
> +		fill a b c d e >content &&
> +		git add content &&
> +		git commit -m initial &&
> +
> +		git checkout -b simple master &&
> +		fill a c e >content &&
> +		git commit -a -m simple &&
> +
> +		fill b d >content &&
> +		git checkout --merge master &&
> +		! grep -E "\|+" content &&
> +
> +		git config merge.conflictstyle merge &&
> +
> +		git checkout -f simple &&
> +		fill b d >content &&
> +		git checkout --merge --conflict=diff3 master &&
> +		grep -E "\|+" content &&
> +
> +		git checkout -f simple &&
> +		fill b d >content &&
> +		git checkout --merge --conflict=merge master &&
> +		! grep -E "\|+" content
> +	)
> +'
> +
>   test_done
> 
