Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0351F453
	for <e@80x24.org>; Thu, 25 Apr 2019 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfDYSqn (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 14:46:43 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:46155 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYSqn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 14:46:43 -0400
Received: by mail-qk1-f180.google.com with SMTP id w73so356566qkb.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 11:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=paeeAf9SG+ZPbkKRP0S0nu1T6P5MZhmSFlJdtxHsIWM=;
        b=iBzp2Apc1nqLjpDCEiSaVd3J2Ecng2RkduWeOeooIhDSolnQfJwq0xdYMC1WUMs3iC
         mHb4H8i2GXEBQmyk2xk7Sr2TzqV6SrKAeUKVcJCY1ACgSD+mP1YfM0Or8FNvTK7Q5c0a
         SReui7F1EpOlyioeMhf4/aNjfwmFVlPxwj5u8+2kYa+QiA97T4gnJ30P5n2mXq7fxb93
         lQwopwIBGrHhxDg9TMj/5JfAHi/ZHOPOUZRUDEA4FWk0CpiNE2ClBIltrt/uhu4ofInW
         0GxThTteZJmyT0OPkwmncQZF9Wo24SxdzfTv0PypsrQ6CVF2UOXpR2MzxadLROcNhxnN
         B+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=paeeAf9SG+ZPbkKRP0S0nu1T6P5MZhmSFlJdtxHsIWM=;
        b=bqIg4JZNMfEGjAyXfX8+sSpLmyjLm1yYsdLNaST3EFpRasAK+cSP8Hyp+JawoNBH0t
         TeQxQDiOaiJfcDp1B0iuECXiRCYxI9PQu5zkSJ/QQ5kmHJ/OwEyVveIxx5e4eBhH3MzI
         KElfbcSqUc59dk0b6Q8jo35I51qnqWpNoRGWMtFC98FMSggR0KTHVa+ivCAAHEyc3bBw
         u8D72zLw9JsKA7LCUs24EX/mqrl+AxcJAhKHqxyzg/tklRlTjIWqiz/+hGj0bYuQDamy
         Jep11ira8nrWvgQabxFCdDHCsYOZx/OfUkHloSRWWuGy9chVyPsGRCfs6HeOxTLT/dgh
         GNSA==
X-Gm-Message-State: APjAAAVygdY/rzBT+NeoBvmgMNAt3wbgl34KbbV/yvF3yzTBcVdAftTV
        uu9kCV9J4EGOKSx9NYhyrnw=
X-Google-Smtp-Source: APXvYqy0PERkTGIXNELOa3nxt4iuhStP2568+mNGQ07thRcEFS/Zkb/4COnhLOwVzI3hpvUbfjjIKg==
X-Received: by 2002:a37:c81:: with SMTP id 123mr2208375qkm.174.1556218002167;
        Thu, 25 Apr 2019 11:46:42 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:189a:8d9a:2c4d:7028? ([2001:4898:8010:0:1d0:8d9a:2c4d:7028])
        by smtp.gmail.com with ESMTPSA id t124sm10092015qkh.29.2019.04.25.11.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:46:41 -0700 (PDT)
Subject: Re: [PATCH] trace2: fix incorrect function pointer check
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     git@jeffhostetler.com
References: <548a9b833f4569c526cf94c048ae115a76d54be9.1556211995.git.steadmon@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <20ceb5c3-f64f-be77-2d11-cb41a7045642@gmail.com>
Date:   Thu, 25 Apr 2019 14:46:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <548a9b833f4569c526cf94c048ae115a76d54be9.1556211995.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2019 1:08 PM, Josh Steadmon wrote:
> Fix trace2_data_json_fl() to check for the presence of pfn_data_json_fl
> in its targets, rather than pfn_data_fl, which is not actually called.

[snip]

>  	for_each_wanted_builtin (j, tgt_j)
> -		if (tgt_j->pfn_data_fl)
> +		if (tgt_j->pfn_data_json_fl)
>  			tgt_j->pfn_data_json_fl(file, line, us_elapsed_absolute,

Seems obviously correct. Thanks!

-Stolee

