Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A964EC678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 15:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCGPGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCGPFk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 10:05:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE28F50E
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 06:59:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so10595345wms.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 06:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678201158;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaUb0baoh04C5hN+7uDsbzjwq0hzhKkPGWR3SAAxxJ0=;
        b=gGduS6Zr+WCTuWC/OJHTHXC6R2BkjaPHKod/2B0tOjT6lse45Xe3Hyv6cpVFIC/sIM
         l/XiW7GLxBJSsN6Vur7jKQi1rtoHdR32f5TWFPa/K9Kva3a9skr5C/gcHAqeGb5ppHwA
         qsETq5098mqxYyUunuG8AyIKK7LHliv0KcESjvMl+lLmrQzgnYuBqRSJuk76g2nzoc7N
         tAZbwHymCShlzFl/Ygg1JRdzTsw3B/vzMr3cJeoUHDVYYRQxEj6vBcpqJ73Y8dIse7sx
         Y+L+ltFN4Nhuj496SfsGDuOOwGdyloXDgvM3LdfmjQD23RfUOhFSB7i/oRbSVjXIWFQB
         2r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678201158;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaUb0baoh04C5hN+7uDsbzjwq0hzhKkPGWR3SAAxxJ0=;
        b=nUokboIFbiGOQxJ0Vdwp1U8LJN4yDBeCUz4zz+81MqhORR6dUwkbpCUHdYBDAPG91H
         EKHCDzCfLFc183BpcO34S9GzKobOYikWmw45pasikYGbcdOS+N9GFxNG6FEFxIOPl+7l
         eI7hK0F9OWOCINwNfmG9IPVhudPf4DvBzCaaph+z6vf6VIElI+XxXNA7aBVCdIyjN5Ej
         edQNxLTWuID2mmJMESTj0LJxFWHIGYvhDRXqDu/qji3E+MorirywOD6Fi6e6E1e4HRhY
         e7IXlayKApL/Rb7KFDRd1EQ+U27qhEce8xbc15Kc/5hh/uYVdFicg7YWDY+WSOj90nIo
         VrNQ==
X-Gm-Message-State: AO0yUKXwrGCyPXoUFGFqofwCZQnQ/bXcoyCVYkmXPzV6757hDcHRZgor
        BpFTxrKy4uj+enPOs+HHitI=
X-Google-Smtp-Source: AK7set9N7+eIvDtWyJUOq3MIZ/DpuDom8pFf0Bfmo1J4PwF4BgPRUNm127N5m5vuVIjR+6PVjQd0aQ==
X-Received: by 2002:a05:600c:ad3:b0:3ea:e667:b1ee with SMTP id c19-20020a05600c0ad300b003eae667b1eemr12540186wmr.38.1678201158707;
        Tue, 07 Mar 2023 06:59:18 -0800 (PST)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id ay25-20020a05600c1e1900b003daf6e3bc2fsm2726285wmb.1.2023.03.07.06.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 06:59:18 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <af07d899-4e33-e554-2ab9-4226896c695c@dunelm.org.uk>
Date:   Tue, 7 Mar 2023 14:59:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 2/3] rebase: deprecate --rebase-merges=""
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com>
 <20230305050709.68736-3-alexhenrie24@gmail.com>
In-Reply-To: <20230305050709.68736-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 05/03/2023 05:07, Alex Henrie wrote:
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6635f10d52..c36ddc0050 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1140,7 +1140,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
>   			N_("mode"),
>   			N_("try to rebase merges instead of skipping them"),
> -			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
> +			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},

I've just realized there is a subtle behavior change here. If the user 
passes "--rebase-merges=rebase-cousins --rebase-merges" we used to 
rebase cousins but now we wont. The next patch goes back to the old 
behavior so I don't think we need to worry about it.

Best Wishes

Phillip

>   		OPT_BOOL(0, "fork-point", &options.fork_point,
>   			 N_("use 'merge-base --fork-point' to refine upstream")),
>   		OPT_STRING('s', "strategy", &options.strategy,
> @@ -1438,7 +1438,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   
>   	if (rebase_merges) {
>   		if (!*rebase_merges)
> -			; /* default mode; do nothing */
> +			warning(_("--rebase-merges with an empty string "
> +				  "argument is deprecated and will stop "
> +				  "working in a future version of Git. Use "
> +				  "--rebase-merges without an argument "
> +				  "instead, which does the same thing."));
>   		else if (!strcmp("rebase-cousins", rebase_merges))
>   			options.rebase_cousins = 1;
>   		else if (strcmp("no-rebase-cousins", rebase_merges))
