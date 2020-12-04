Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05315C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E03822A85
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 20:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgLDUJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLDUJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 15:09:00 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F71C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 12:08:20 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id o11so3736371ote.4
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kVxzj3WC4RerrYVDdOumgh6ZXARwetA00fgfcYxmREs=;
        b=K4XwSeipQh5QQDqwomaWm3rC0jJasHV+7/yE/XD4G7nmsLodf2tQMzXOXbZXmlaJZf
         VHUUJVntHRCQNzui3rQXvX6maqQk6bhw1G/RQe5HwaIVcXA0K4Ct581nEhsvUYBApDQz
         DI7BkTsJ4V6QGSI89Wptd5oTtQdJShYzzyNwq8tOZxARS4jr40LiXQ6IJUq7ZbZqaaI9
         EmovzwAnZSuR6VeoJYFO0uI2SB8JbcnpC2tEeHgjkY1ie7q1VCZmA/JXu5r/I+kCgnPK
         UJwAywzUogIy8xRwS3KPZVStvXeysgM6ydtKpDet5cW/U64zhU6wAFPlZGNQSltpV2ue
         PVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kVxzj3WC4RerrYVDdOumgh6ZXARwetA00fgfcYxmREs=;
        b=LV12tmlWkMXL+UNV0oZVK6qW2PZmzTn/XqUPopejWOlJvLwZkYarxc2trvgz3DNtQY
         gMRrCq8jlBxl+7PxgI7Y8PilTG5Dw6aZkVNdeJXVsT4DYz3T1POlTI6J/s0BOAadTIPY
         LSBaQhyWUVJivyUgztgBIgEy/VRgu6WDE5vVnNjNysMwAhQym/6VDXqi1DnbvJzcPn+Z
         Ad4fi4+FvUHKUhc2FDDzUdGX5nHR3G7UfEPhnJQd+A1TaGHlzgWJUNNEFOD8av1suz2w
         xPjFCqRiKNFzrtVo4OShnbdP/giiZnnJTNYfuUbP0wuyhMmdttZ3dL5RXsZY1IeW0/+s
         EDUQ==
X-Gm-Message-State: AOAM531633aDC6b0mk400pMmzgJjUU2uNJMXCDuW8ejipyrWVzDJopTo
        EDXEWH17Ldx0pim40CLBbSg=
X-Google-Smtp-Source: ABdhPJzhF8oy7VPp8Ujgcf6CKdPsXHSqKjmeOR1u4Wd7Qm2OiIguk/vpb09nTonE2pz6FPdLqP+kTg==
X-Received: by 2002:a9d:745a:: with SMTP id p26mr5108819otk.206.1607112499726;
        Fri, 04 Dec 2020 12:08:19 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id l12sm887760ooe.27.2020.12.04.12.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:08:19 -0800 (PST)
Subject: Re: [PATCH 0/9] misc commit-graph and oid-array cleanups
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net>
 <X8qK67IBtB3lqSaV@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <51e9f2c4-36e8-7d65-3b24-373a813a1eaf@gmail.com>
Date:   Fri, 4 Dec 2020 15:08:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X8qK67IBtB3lqSaV@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/4/2020 2:15 PM, Taylor Blau wrote:
> On Fri, Dec 04, 2020 at 01:48:35PM -0500, Jeff King wrote:
>> This series came out of an off-list discussion about using oid-array in
>> commit-graph.c to replace a similar data structure. But I found a couple
>> of things to clean up along the way.
> 
> Thanks, I appreciate you taking this up. Everything that you wrote looks
> very reasonable to me; I noted a couple of spots that might be worth
> changing, but I won't be sad if you ignore them.
> 
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

I have similar thoughts. Only one spot was worthy of a comment, and
it has a very low chance of being important.

Thanks,
-Stolee

