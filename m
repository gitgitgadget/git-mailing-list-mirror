Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8667BC77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 13:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjDMNm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjDMNmF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 09:42:05 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B3BBB81
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:40:10 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-54f6a796bd0so167743467b3.12
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681393202; x=1683985202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57I95kycdnw3ixZYvArsvM4Bkkylg6tumQNeGHPLjaE=;
        b=Wm5mmnp3m76tIjxV51kpBxbu3YmXnNADQO58waPPu07H9RMAf/9zvxVDtK9vG+JIcT
         g3oLDwxv6F0IctlGtffcVUGSoyEZwxwFyluK3Zims/qn43u1BmTbvRN4OaL3tRCtZEgF
         khMZMo6nE46JvGbsI200qTXkDD9ESpDuJ27g+4inXPvE/xwXoD33qdlHDJQNM1Js3YRh
         j3j7mMyac7gS2WirpmRBLksRCubKnX1pe7/Hs7Lgc4MXzokjzdOm2T/N1ttdNHRWEMKU
         /f9e+07JjeHBuB6MtqfQJEAhSpB8JmwsEYpXH4qmnhROtV0Q/s6sIaaIXHq/t2dWKyQ+
         YiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393202; x=1683985202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57I95kycdnw3ixZYvArsvM4Bkkylg6tumQNeGHPLjaE=;
        b=U8Iz5QXoNmmW3tgdXYwMGDzbEYRX6JnZzS135CNKBQLBqEXkUJXWFTYA59P9MRvq2s
         DZojpUbiwxlG1dqCG6FsfEDoIr06/JgkMdG9XrV/5kwJIdKQKWAZQ//llnJbiH1Z8wlf
         QoVwZzIRYBfIWdcdh88h9CUtiOlAropM3tLE6U6GT3NqjLBsXOG8+cgJuwY1E9XW5SGZ
         YA0MAPYk3w0Kk7JdWphDtBlxX+NE/vspBvG6C1lkymHXZg2D8/ArDa6wgzChr7Ghhn89
         rJW3wyCOtl7HLA/lbtBh66HjL1tzptkaA8j0y+2TyuUvJVI6aoQLvioQsJvjSKPM/mR5
         KxsA==
X-Gm-Message-State: AAQBX9cG6nvK/ASQrUl3OqU1oJL3K9+jVBZpJMgqj9oPJAQuAUZscS/O
        bmiYtRuByEaQcYGaOQY4UL1V
X-Google-Smtp-Source: AKy350bgtKSP4sgvhnvI/DdPOzOd8/SQal36TtqoxkjvLYsgvIM3SSJ/kvLPvL8TO0SerVvHUl9JLw==
X-Received: by 2002:a0d:c985:0:b0:54f:caeb:15d0 with SMTP id l127-20020a0dc985000000b0054fcaeb15d0mr1344360ywd.4.1681393202611;
        Thu, 13 Apr 2023 06:40:02 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b14-20020a811b0e000000b00549143fb1a5sm457243ywb.92.2023.04.13.06.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 06:40:02 -0700 (PDT)
Message-ID: <2b651052-5eba-6ec6-1d15-17ff60be9b4b@github.com>
Date:   Thu, 13 Apr 2023 09:40:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/7] pack-revindex: enable on-disk reverse indexes by
 default
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <cover.1681338013.git.me@ttaylorr.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1681338013.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/12/2023 6:20 PM, Taylor Blau wrote:
> Here is a (tiny) reroll of my series to enable pack reverse-indexes to
> be written to disk by default instead of computed on-the-fly in memory.
> 
> The original cover letter[1] and commits herein have all of the gore-y
> details. Not much has changed since last time, except:
> 
>   - squashing in a patch from Stolee to propagate a `struct repository
>     *` a little further out from `load_pack_revindex()`
> 
>   - a tweak to the linux-TEST-vars CI job to continue running it with
>     GIT_TEST_NO_WRITE_REV_INDEX
> 
>   - and an additional benchmark to demonstrate the performance of `git
>     cat-file --batch-check='%(objectsize:disk)' --batch--all-objects
>     --unordered` with and without on-disk reverse indexes

Thanks for addressing my concerns from v1. This version LGTM.

-Stolee

