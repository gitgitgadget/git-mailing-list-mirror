Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D5BC6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 13:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjDGN6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 09:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjDGN6H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 09:58:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC3B49C3
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 06:57:49 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l12so42356134wrm.10
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 06:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680875868;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mhXgjElTgqXX10MwNra+G6qqkqLp6avRqudRVDyohc=;
        b=MRTzdQ7x2jc1Q8KSyWsE6CBnid8Qjr1FCYAjL75UKK3LYqFEkfmCuS2UMBT774NnUa
         YT2OpqdC8w3pr27m+EJfa6LJPCW7+6qCP1drB2xHpUd0grQyVIJatHA6cjJtbnEDeHEm
         xCGGY5ZG3w4wW7JiOImCG7gQwtQwIAS6/6oN/VbBlFKQtttgYhjxDuRv8wvJLC9ZaxBk
         R6wWVfwomzfsIjeJ/yYqRBtOqfAvxUulFgNsjV579hGKg5S8cjw7lmPLoGNToiTHf9Id
         fB76DigqeTbcF4wYIVI3oWDg6Um5UxpzfylKS4K+Tm0r1WVpxz6ou4wWiaRYMa6B7pT9
         UbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680875868;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mhXgjElTgqXX10MwNra+G6qqkqLp6avRqudRVDyohc=;
        b=T0U05PyAVSHEd1E29M1mP+qpGyOy0YizbF8hwRwg6H+r1CWd+d6oMm+KZ/YKdmf6d2
         Y7tLS3vBzmDxBkqZeNSGAxpSpY5sU1Gtiy9P9Sxhnkm0/Snc14CkiF/SmwWuemL3gm10
         k3hw4V6KcJ1CTBWm4JD70xAF0gsXc33OzGXqH4ZmzAu/KiAGnTp/7u2WralUUS0sgNgV
         vJYf0kVZRViM01I4m6l7Xy3cC2axO6FJLf0tgS2YjfIO95sLS7I+r7Si8QZV6/KugkU0
         DWJRyBCfNRpiBTrAngDMA5svkutqVCmzt8fxpjnzzM6Jz9QDbRFHSVKkykI9BEjI/ymu
         Y5YQ==
X-Gm-Message-State: AAQBX9driAWKm84dgJgtEmMK1PzhSFk7BbK7aAgvppAKZavdMYrayrgG
        RpS5Hvd3OlTMY0YinwtOjBg=
X-Google-Smtp-Source: AKy350Z7qtLhMQAyr/+Kaf3Jz7HHtg2swxHgK+EowcYnJXL7/PmbUr6pu30NJmWz7vIwOWaRPlWWjQ==
X-Received: by 2002:adf:f3cf:0:b0:2cf:e688:51bd with SMTP id g15-20020adff3cf000000b002cfe68851bdmr1255481wrp.31.1680875867939;
        Fri, 07 Apr 2023 06:57:47 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d5490000000b002c8476dde7asm4564920wrv.114.2023.04.07.06.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 06:57:47 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <fe8fe698-28a0-3db7-f5b7-57456175fc74@dunelm.org.uk>
Date:   Fri, 7 Apr 2023 14:57:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/5] rebase: cleanup merge strategy option handling
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
 <cover.1680708043.git.phillip.wood@dunelm.org.uk>
 <CABPp-BFMiU8cYzUr1-m6P8w-YAtqPRyMfah8UAqdO_N4cdxUKg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BFMiU8cYzUr1-m6P8w-YAtqPRyMfah8UAqdO_N4cdxUKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 07/04/2023 06:49, Elijah Newren wrote:
> On Wed, Apr 5, 2023 at 8:22 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> I noticed a small typo/grammo in the commit message of Patch 4 that I
> missed in V1, but otherwise this series looks good.  I'm not sure
> fixing the tiny grammo is even all that important; I'll leave it up to
> you for whether you want to bother re-rolling to fix it.  Either way:
> 
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks for reviewing this series. I've sent v3 with the typo fix and 
your Reviewed-by: trailer.

Best Wishes

Phillip
