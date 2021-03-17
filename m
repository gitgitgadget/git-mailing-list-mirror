Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC5C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C51B64F30
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhCQUbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhCQUav (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:30:51 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5FCC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:30:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id v192so317158oia.5
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y9bIxyo+t6cHBVeE/vejtlHwMeHNjCEXR7m5YFyNmg4=;
        b=pHuM6ygIxJvZMNHCRHCEzAA5gCetv8w3Q7L5Rr8LWXkcIzum5X64/dm7oDUaLKlPeK
         WCaYZ1xDT6Vjzss0j6FZAlUnaBRxhdRy1zqWDNUnZ4z5Santp0wleglgZxDc1IdjvEAX
         9zDZK2SHNsbrZvI+L611nN6+vkPhBJgiUqwmZ58nX5BOBEbDvniCVN23DYSDRoVUFj8b
         yvGNA/xi062Sb9B7NBBkpjFU9tOEEF2mVV2cBD5xf+VQYJ4EnbkHbObqDtPtqcgrukFm
         qrz+P4wylek10YZzCbL0ybJWRSqNoJO7YmWrG1/nLZQt2qFNbXgdGgaEXlljd1GZnN9O
         fO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y9bIxyo+t6cHBVeE/vejtlHwMeHNjCEXR7m5YFyNmg4=;
        b=VPaZ3hKd1IVyT9bvwYS3gFKMsmDlEkKIIkvWCzZvZo/nof+BdOHX44lmXSBhl7xykg
         d//XGUMZEGBmL1tjIEUM1eOoiFsuEm1ai0R2+VTzQ5DkwIx2clzyqKd4x4KVNDOLSpIN
         MZX9w66A2HdC9y+jbrRDGIJgN0gLJ+vM6LuirCwfhWzqM8JoCG5vo8zniAUhAM2rmQ9f
         ck7lOUvL5jXwXDiWSRaJjs33WLJt3XJHFqJtAcEw/s4aTOktR7JuH0XHZgHFUYdyoml6
         wivkszjNuewAiqy+Z524p4t+/5UZUyRdsn6DYoYVA3IJLDhmXyGfbGWkHQZVGEaqB0Nk
         1Mkw==
X-Gm-Message-State: AOAM5320wbI+LqEizQMh4w3X1lShyltJeaitGZYHXJtQk7L8aeyknbEw
        FD7mLQXP83hG1M2Bbjd7ArLu2UqrlP/VCw==
X-Google-Smtp-Source: ABdhPJzQw7oC4EaROZb02pj+waSjMPK7Oj5tl2h34di8AL8QFiNdu+MQ3dqfn4acHmmSlbWVHm9GQA==
X-Received: by 2002:aca:ab53:: with SMTP id u80mr460322oie.77.1616013051006;
        Wed, 17 Mar 2021 13:30:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id e12sm31202oou.33.2021.03.17.13.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:30:50 -0700 (PDT)
Subject: Re: [PATCH v5 00/19] fsck: API improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20210316161738.30254-1-avarab@gmail.com>
 <20210317182054.5986-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4150ab33-3fde-6f4d-80e6-ec697a264a6e@gmail.com>
Date:   Wed, 17 Mar 2021 16:30:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317182054.5986-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 2:20 PM, Ævar Arnfjörð Bjarmason wrote:
> A v5 with changes suggested by Derrick Stolee. Link to v4:
> https://lore.kernel.org/git/20210316161738.30254-1-avarab@gmail.com/
> 
> Changes:
> 
>  * 1/19 is new, it's a simple refactoring of some git_config() code in
>    fsck.c code I changed recently.

This new patch is simple, as advertised.
 
>  * Squashed the first 4x patches of incrementally redefining two
>    macros into one.

Thanks.

>  * Squashed a whitespace-only change into another patch that changed
>    the same code.
> 
>  * Got rid of fsck-cb.c, that one function just lives at the bottom of
>    fsck.c now.

I was late in giving you confirmation that fsck.c is a good place,
but you got there, anyway. Thanks!

This version LGTM.

-Stolee
