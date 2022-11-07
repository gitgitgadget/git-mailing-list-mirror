Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB70BC433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiKGTm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKGTm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:42:56 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977E51002
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:42:54 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id k2so7828612qkk.7
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGWfuUquXl6wS91dPXJxaVgMeMyRSYml+xrGP1cLYvA=;
        b=XczC2rn3q2BWIPblqo2jBP2V7yMwAn6uGJf5OBKk9wLvS+CDUHYDSH+WRBkLzgBVsZ
         /0wL51Z0taAshicKtXufGXnfbPf1rK2nodwGL1CW0LtS/JBAqxJvJFVdCEA77MgHjKRu
         9lYtRx68TO36IXV6eGYOqc7c9bj6ggN+qlR/d6v9W/uVSEGYRIG/wiWfR4HHRA0Fw/Pf
         jupWZi1qyh0qu9QSw8hmOmXoqiGkKPAFhcysz0puLtnKBuW/j0kYWUkG8CRXIHZhGrLz
         KPLRHKBUPPc+TwliVGDN3l3C9QajuxKu+qlrFdB7k0ENurkBz/IHd3AzD3ihxytKyux2
         xyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGWfuUquXl6wS91dPXJxaVgMeMyRSYml+xrGP1cLYvA=;
        b=L5mBmSzGtVhmvfYSH8wgAbyZ+hj5FMvurQaxg2FjllWQyZrC+VnrHB0VbDMEfXMl5Z
         p8Gi2rFOaAgs+Dnl2K0yIjy6Ew6JfSLA8zjvAQzzxKFWt6wqxEoWZnwJ88wJWQgcCESl
         R5J9oDOr+hOx6jH33qUxclTD6W9w3BSP/JtFcXiQdIT5wFxItGBGFWbmGlJykcvQLasx
         2PqN5x3pynXVWdavbkFbBOeqEs0+G4AzBYarfwjeVL0Q9VbI410tWBiai5R33lqeGsw4
         SRXa0e3T1UEiEQI5WumrJiI+PIy8OewaRGGY3ZVxMbgjVaqLLZUZ6l3wUbxI4AsXh2T9
         QW/w==
X-Gm-Message-State: ACrzQf07f+fBICNv62AKlVEMxpB06qhbW1OYk8gvf7DVWzE9PnD2sZKt
        ue15OX9mQlh8suSMQiIEYty9
X-Google-Smtp-Source: AMsMyM6ZnkRQpDqTx4fcDYzR1EHj/wCEzn0nwpg8gBrzffiFqx71wP16fa7TgDkTNm0OcIqPErMByA==
X-Received: by 2002:a05:620a:677:b0:6f9:f710:ea57 with SMTP id a23-20020a05620a067700b006f9f710ea57mr36499397qkh.403.1667850173695;
        Mon, 07 Nov 2022 11:42:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a248600b006ecfb2c86d3sm7602572qkn.130.2022.11.07.11.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:42:53 -0800 (PST)
Message-ID: <21e870f7-0f86-7021-d141-9e83286adea7@github.com>
Date:   Mon, 7 Nov 2022 14:42:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 4/4] builtin/repack.c: implement `--expire-to` for storing
 pruned objects
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <cover.1666636974.git.me@ttaylorr.com>
 <6376d15c9c9adce883dba86ef5e5219f803aa9bf.1666636974.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6376d15c9c9adce883dba86ef5e5219f803aa9bf.1666636974.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/22 2:43 PM, Taylor Blau wrote:
> When pruning objects with `--cruft`, `git repack` offers some
> flexibility when selecting the set of which objects are pruned via the
> `--cruft-expiration` option.

This patch looks good.

Creating these cruft packs in the expire directory does help
remove the main problem of the race condition. This currently
requires some external system to check that no races happened
and it is safe to delete the pack in the expire directory.
Also, that external tool is needed to move that expired pack
(or preferably, only the necessary objects) back into the
repository.

Some future series could find a way to handle those situations,
perhaps within 'git fsck' to pull missing reachable objects
from the expire directory. Definitely not required for this
series, though.

Thanks,
-Stolee
