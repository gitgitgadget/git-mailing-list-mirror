Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5855C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 05:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9332461042
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 05:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhDVFRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 01:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhDVFRK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 01:17:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F171C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 22:16:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gq23-20020a17090b1057b0290151869af68bso319730pjb.4
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lrg9uJY8CF7+ESuIbEQcsfVCSv+I/5KFI/Xx9gEzR3Q=;
        b=jZdmxqMTT1nQB3djGOIU4cBejRrBr+LwEAvGkli+GthlNPM03+rkw/mDkEuCGpxzUs
         GZHLZqHonXwehkGBTUoenWCH/wkc0RdmWtUXNVyEay5POQz0X1kqUaJX357eoREgyqY4
         Rhc3cq5+HeFH2lAGBzpw4XOkpZrCvdJGx2vKJHdpttdrLc3H9n7ZklzExQTg4VQiThFe
         Ds3ipPz8rFFvInOqSCw8MeWNUZQ5lq+WTCzC9kX9R8tCuDyiIv2LKp1yVbZi0wAmeUYZ
         aX1RcLhUIrMa9zT7ngPCPKsotUPv9OGwwEqJnP/TwIZbKtOKy86EgWyk+55W2OkdD975
         t24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lrg9uJY8CF7+ESuIbEQcsfVCSv+I/5KFI/Xx9gEzR3Q=;
        b=nUBkUOxLO85abOU9/HsZGV8jPjEKjIUSZQFjJpuuqKyhll8D7Df9EAgCDGu60C7e2P
         3PPA4RT8k3XWUTqdixxXwZ+P3FdxVjsYl8mgEflchyzbu50GxatfcgrjLKy8AZrbN7hn
         RX0OZSs56RmoQHKIAF/32LQ2aOBuOWRvKE0Qi6fFxoQLwHYX3TtdeRW8JmX08ebnm/WL
         B98pC6U1nqF2MX2q5+XgUUsorY8W5VV/Je9jAw0I+1vwgQaNrKrNyIlKiDUDfWb9N4bZ
         2LTV08GbPtv1agP5grSR7UacHK3eM/BECh77EieJe+JAL2qJcc3fRy9AjfrvQguCfI66
         nYOQ==
X-Gm-Message-State: AOAM530RC962u8SpnisRrPRen74qc5VyrKTphgo3lUj4yoT+VyXaiRoI
        OKn4pe2GgIwTBsJAyoFQptg=
X-Google-Smtp-Source: ABdhPJy2+xRCK9SVpoA3nK2DEearoLzfKgPNhZEFXA6uwT76Y5rR5GXUGXCXXTmLhXpJlW+jbIZiug==
X-Received: by 2002:a17:902:eac1:b029:ea:dfe4:7b44 with SMTP id p1-20020a170902eac1b02900eadfe47b44mr1617633pld.79.1619068594595;
        Wed, 21 Apr 2021 22:16:34 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id l132sm940227pga.39.2021.04.21.22.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 22:16:34 -0700 (PDT)
Subject: Re: [PATCH v2] test: add test for git bisect skip with --term*
 arguments
To:     Junio C Hamano <gitster@pobox.com>
Cc:     trygveaa@gmail.com, git@vger.kernel.org, larsxschneider@gmail.com,
        chriscool@tuxfamily.org, Johannes.Schindelin@gmx.de,
        pranit.bauva@gmail.com, tanushreetumane@gmail.com,
        mirucam@gmail.com
References: <20210418151459.GC10839@aaberge.net>
 <20210421040808.14185-1-bagasdotme@gmail.com> <xmqqa6przh08.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3bbc9350-60cd-9fb2-117a-add3dc5cf77e@gmail.com>
Date:   Thu, 22 Apr 2021 12:16:30 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqa6przh08.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/04/21 00.25, Junio C Hamano wrote:
> I expected, as you said in your first version, that it would be
> added as part of an existing test script for "git bisect".  And I
> suspect that you can reuse the history the existing tests in the
> script already use, so you won't have to add the first "initialize"
> piece.  If the tested sequence should work but does not yet work due
> to lack of a fix to a known bug, the test should be marked as
> test_expect_failure instead of test_expect_success.

So will this patch be queued? Or should I send the patch adding this
test to t6030 instead of separate test script here?

-- 
An old man doll... just what I always wanted! - Clara
