Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7FEC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 10:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92812610A1
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 10:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhKSKgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 05:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbhKSKgm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 05:36:42 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFCC06175C
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 02:33:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p17so8299498pgj.2
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 02:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IcGB3gPSM6QXyEAa/sBfA0vwWU1uC3LfHPCaVAVh3eE=;
        b=meMywrBVyq5blye5jGh6RfLWD/FXI8gweDRjJHqHeES+Qn0/ejlvZTttmMtx7hbDSP
         qslWAaHB7NlgEhzry0vp6COwUEdMC/05R5A2FQlso56HEOGodiO5KrjE1Gx9U8F/U7J2
         2FySqi90igPGqQ5ccVvrBEVt2QOJJh15UoLedF0kS5tTGxt8E+M4oM7cfMoRgubBqS5p
         wSbEVjHqvLi0v8/CWDlI06Yr+bjrmFRKRgjo5WhXqVY4lfOuyyesIvxS1BRSszokCNTl
         qarfUVyywnPi/RaxQ3OYWplNykUrrA9XWd8NmbrGpwPzSKNIgPxFsxCe2fA/XtZzRaAe
         L9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IcGB3gPSM6QXyEAa/sBfA0vwWU1uC3LfHPCaVAVh3eE=;
        b=iuo/xywTydFAZ8zNKpP0Nc6gIwQ9AvUZydPSZNLTcGExECeTl3pp8TKXUwX3U2dOLs
         JEU2kIk2OIOHzs/AgaUcFjkvYipDp0Dgc9Ln2lEVXGMa1MOjX0EhzpnnoIxPSH62a8BG
         Xpm0p96r/Le83tNriVv/bWcQyRhAq8WclITeEvHOkEcmVeYy1Dkvk+JVK0wheT6OUb45
         tMNvLm16USoImIhFW2MuBK2cY5C5UNUGHdql8N/BHAjOHXS2TadKI5Q5r75RaOAtJhk5
         GSd1FRj/2ftZgMZcIa55NUPGXwCA/7qgTDBlXzFrJYlEK1hRGkF4qaheANt4WNxcBP6t
         CYAg==
X-Gm-Message-State: AOAM530rVJ+CAxdS/+QoPPbNbO9fb6VVt+fdVBbfamt+EOLZrpMNX5Fx
        oW5kQkQU1y6MCUUEFdCcwLg=
X-Google-Smtp-Source: ABdhPJyRBgPKUrAGa6qysqtN1ciN7KAiptueurE3HF2fTyAhgs/cZ4NIzxEuIP//t/Ff5JtIpMZZWw==
X-Received: by 2002:a63:4e09:: with SMTP id c9mr16321022pgb.83.1637318019590;
        Fri, 19 Nov 2021 02:33:39 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id j1sm2409567pfu.47.2021.11.19.02.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 02:33:39 -0800 (PST)
Message-ID: <877e2b84-347d-8687-d3dc-6c7ce508ac1d@gmail.com>
Date:   Fri, 19 Nov 2021 17:33:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v6 2/3] am: support --empty option to handle empty patches
Content-Language: en-US
To:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
 <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
 <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/11/21 17.50, Aleen via GitGitGadget wrote:
> +test_expect_success 'still output error with --empty when meeting empty files' '
> +	test_must_fail git am --empty=drop empty.patch 2>actual &&
> +	echo Patch format detection failed. >expected &&
> +	test_cmp expected actual
> +'

Why isn't the echo string quoted?

-- 
An old man doll... just what I always wanted! - Clara
