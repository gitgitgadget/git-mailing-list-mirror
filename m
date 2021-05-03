Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D2BC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 12:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A7D61185
	for <git@archiver.kernel.org>; Mon,  3 May 2021 12:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhECMLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 08:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhECMLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 08:11:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8CBC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 05:10:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k127so4687492qkc.6
        for <git@vger.kernel.org>; Mon, 03 May 2021 05:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hAoCoVJ1GHSS+N0fedZL6/0F11/ZNyJUlGKnIiia4o=;
        b=dN2AzrPHhxJQATLdUzxbcX20/hqoXoqJrVXjcJ1THdC9HZh/JUhRsL5CQ19CbSGADR
         1eTxcbNEEdfqmLIbQ6EC/b69cDvHIs7qdbFaPJYJJr5AX0YLtHmd2ABseKS7H94RZlIc
         BN/uQQiS561TFjdsXJsKgI1xhk496UwDO1XVmEGYWpQW6vzHWQ91gkpdL37Bfga5s33D
         qlqXSLNQNdfwsmusM6KGSkNbxozEGN3HX6449D0BEmFCp93SmuQdLkdRO+9BRPHyZRcG
         DRLcQabXaLFcrd00vkQ346rK5VFLfFNFlDw9WEIsYUf5bVasWdaNCFjSWNABMijL7jdA
         uw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hAoCoVJ1GHSS+N0fedZL6/0F11/ZNyJUlGKnIiia4o=;
        b=Gbd6Mm7qKG0WqBulVWv+OHpaYmz6pWI51UbgTxb2tM7gVbeuL3SbrpF6fHjTnreNbG
         umSXr8tXqKKZyf7fuvjgdlRQ0WSZvVbtPZ9qNGXJF5YEPwHIuNrSOCWFI7dC7R8BNPVK
         /z/bQCByZngaRALYqFaJ+V34UVbMc3UQScWkq5cYQfHluWJWwAsyibO8Jvv+/doLduj4
         hXHjYH+2R1iXJM4Mu6ixdHVOSJB3A7aExejXCnE/I98vec71g1a/QcNSyHnfMZjOP6pG
         FsEihiBqq+ck1xvBswt3wfoCPIgBCwO++LvbE1/sIhaXBcWhQqA5IXHUFZvemDfFNeeb
         ThKA==
X-Gm-Message-State: AOAM531l5lMgsJ1L0EMQau5BbK5TpiZ0oun6T3PHoctAEc3fEBbrbquK
        ayw3T5qzT3DcbzxgfCloCcIZgc+N7KXZkg==
X-Google-Smtp-Source: ABdhPJyvtzvh9fXrcbBjucGOSW3wDG9chTuE2EDRtMInsIR4DJ44t54z8bt8AbB6Iw7gTP4e/09k2w==
X-Received: by 2002:a37:a9c8:: with SMTP id s191mr3010911qke.430.1620043828849;
        Mon, 03 May 2021 05:10:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e8cc:2a25:fb4:a65b? ([2600:1700:e72:80a0:e8cc:2a25:fb4:a65b])
        by smtp.gmail.com with ESMTPSA id c17sm7946077qtd.71.2021.05.03.05.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 05:10:28 -0700 (PDT)
Subject: Re: [PATCH 3/5] pack-objects: clamp negative window size to 0
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Yiyuan guo <yguoaz@gmail.com>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
 <YI1fubjvQQlrPz9D@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3d77d70b-2cc5-4ca9-8753-fa9af5111842@gmail.com>
Date:   Mon, 3 May 2021 08:10:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YI1fubjvQQlrPz9D@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2021 10:03 AM, Jeff King wrote:
> A negative window size makes no sense, and the code in find_deltas() is
> not prepared to handle it. If you pass "-1", for example, we end up
> generate a 0-length array of "struct unpacked", but our loop assumes it
> has at least one entry in it (and we end up reading garbage memory).
> 
> We could complain to the user about this, but it's more forgiving to
> just clamp it to 0, which means "do not find any deltas at all". The
> 0-case is already tested earlier in the script, so we'll make sure this
> does the same thing.

This seems like a reasonable approach. It takes existing "undefined"
behavior and turns it into well-understood, "defined" behavior.

Thanks,
-Stolee
