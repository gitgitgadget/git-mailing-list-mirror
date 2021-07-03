Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD871C07E95
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 00:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2D361427
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 00:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhGCAXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 20:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhGCAXl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 20:23:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF58C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 17:21:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s14so10730289pfg.0
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 17:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6fQsy7tIESb55GF1C+OxZz4flTXDUfbuCO2FfGD2+iI=;
        b=OuprZGWveK62zbTdNy9lrpsGyPdLN30nG7sqJ69EMKqfzRypTetylqTwwGwnbXdooI
         /xVSH3/eZS/hqenx5uSVJGlYz7BtaUdtDeh+SLkJ3Ft+vvsuO8+2d7nFE4ieNsPWCUUF
         DR71E3/uvv+xwsKTI5N/c6vH7Oka7KtlBYti6oOuw/MAzLB+rrDHyf9JimSPEucjwK4U
         Nf15BSe3NwEcPBKw418BNmNqt+Lk51W+yxnJricTaNUYe/HaXRtuqtAliIgQlS65HNuK
         9cqrGvwYykrwuyUUOdVILHDMoVlsZDMVd382S6PnWgTxBniKQtfVOtnV2wu/h1h/EQmr
         dGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6fQsy7tIESb55GF1C+OxZz4flTXDUfbuCO2FfGD2+iI=;
        b=C6gJJp0h6GA6vZLkecPI2f1mGXdW7TDAmkR9AThNTNlPrvA9uWwlDA68HjV2RYE1Pz
         nigudLD3F4T+snJRopI07h/Cw3ULpJjswA6P9Dgou65xGcLrS/WiQs1PhcKLMkzy+s3t
         +GksBFV7CdlSd547m/jwxgosbxrOQ70qsWcwzXLqL+YhqbkkK3Ph4aoIeJLvovnfUJz1
         ExJHgNnAhIEe1JGVs9VYfcHK35icHqlrcm4TFPMKFAygyUjkrTzQYnRO3w3cZkzAgPCH
         DRUZAV1dXiJltey6SW4mi1oJzLUTKjMIwphRUBHm347ZpugtXoTR06TMlyx01YyXUlKN
         EJpw==
X-Gm-Message-State: AOAM533DGPXFEPbT3BGxLrUTO89jJrTwbH5HiZZfb+yD41pGf5Qb6NCf
        tXRCCOgoE7tTxih/BPEIUECbKp8wbcKaug==
X-Google-Smtp-Source: ABdhPJzo5Al9f0x1z9cqtcHmtajzsG7EtE3PFM7/2cCE+93ZgHe0U6QiE1cIk8N5Y9oH5YnNr+ELHA==
X-Received: by 2002:aa7:80d9:0:b029:2ed:49fa:6dc5 with SMTP id a25-20020aa780d90000b02902ed49fa6dc5mr2073754pfn.3.1625271666946;
        Fri, 02 Jul 2021 17:21:06 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-62.three.co.id. [116.206.12.62])
        by smtp.gmail.com with ESMTPSA id k25sm4617074pfa.213.2021.07.02.17.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 17:21:06 -0700 (PDT)
Subject: Re: [PATCH] docs: .gitignore in parents is current repo only
To:     Andrew Berry <andrew@furrypaws.ca>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20210702222044.72767-1-andrew@furrypaws.ca>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <b9da43a8-897b-7cce-ecbc-ea56078f0f09@gmail.com>
Date:   Sat, 3 Jul 2021 07:21:02 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702222044.72767-1-andrew@furrypaws.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07/21 05.20, Andrew Berry wrote:
>    * Patterns read from a `.gitignore` file in the same directory
> -   as the path, or in any parent directory, with patterns in the
> -   higher level files (up to the toplevel of the work tree) being overridden
> -   by those in lower level files down to the directory containing the file.
> -   These patterns match relative to the location of the
> +   as the path, or in any parent directory in the same repository, with
> +   patterns in the higher level files (up to the toplevel of the work tree)
> +   being overridden by those in lower level files down to the directory
> +   containing the file. These patterns match relative to the location of the

So for example I have `something/foo` in ../.gitignore, but .gitignore 
(in current directory `something`) has `foo`. Is .gitignore from current 
directory or ../.gitignore takes effect?

Also s/toplevel/top level/

-- 
An old man doll... just what I always wanted! - Clara
