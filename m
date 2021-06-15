Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6233C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F18613DA
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 14:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhFOO0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhFOOX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 10:23:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C812C06114E
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:17:10 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 5so4070882qkc.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hXQggi0Nkab6G4VbQhZ0S9uhQ9BJqLB7lPe4k39B1qs=;
        b=DI4UU6KWyoXKuG2zhd2xPuf+B+ShkIUkPVvPlvI9iNY4RiX7UaXazwBytGtlBlZTxQ
         2Y1VcI7wRwqkczxEdGYfTXvGbd9Lh7xumwKyX50VCxWRunOCKRrWpimciLuUjpM9xOmY
         Gzh6Ex7Ta+yckuUnG7PbtR95MrOGleZ2VSIKZnim//VIU8CFnSuE0SxL4M1WK2b5aPTX
         7KyTKQSArFXUzo9Dm5s19bF5Y3yREGn2F79LXTRRWEPrWHGl2a56h+HjvC71Mpga4L8S
         41CNOA6AaHHsGUx7zC0WH+4NDn7jmKRyepI+X91ZYPVPb1PV0g4BIbih8XmF/T5wnvXx
         xyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hXQggi0Nkab6G4VbQhZ0S9uhQ9BJqLB7lPe4k39B1qs=;
        b=VQRKGwDX37HQv8iuImzz6wC4EezsFx+0KVVByNWb4ALzA5aS/YtaJ30Uq5wT7VSrRo
         aEOf7KtLH9+aMUenLxIFhPHULCu+2cYHu6m+hLhdJ2N5gtaa7KTDBM8Z/0ITcTrplxq6
         0BMxBhbCpl42XF8heToHvWznVD1IjJJF9iKrIkYTiD+CC3BcLaDq4nq3k5mtM2Zgcb3O
         HYIH1j0VrlJh4aU0tNizBIoDOzciDeQHPHmq0ODgbdGKdQrvFqyE8KNCi6m38N8Ud80D
         3KER46uY9xOcnO4cNRsNncUYOsxbDYaK6KylPCkYMoed59fQRYZXf3iHuovZVK3XLUv/
         hSMQ==
X-Gm-Message-State: AOAM531G/J7gXngZgOjkZwqqjh5QWV7fJLcgme40UAjONaSbzzSw1FQM
        8l6w22ms9IsKFnLgrFj/5Zs=
X-Google-Smtp-Source: ABdhPJz1RyQNT9mRk0cyuYwFlW9sAeQeBfaL43uXVeyL51xIqHq13VJUjn9uLfolPCHc34ob6DdEAA==
X-Received: by 2002:ae9:ef03:: with SMTP id d3mr15186346qkg.391.1623766629339;
        Tue, 15 Jun 2021 07:17:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:113f:4437:94ed:3bef? ([2600:1700:e72:80a0:113f:4437:94ed:3bef])
        by smtp.gmail.com with ESMTPSA id r4sm11763593qtx.4.2021.06.15.07.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 07:17:08 -0700 (PDT)
Subject: Re: [PATCH] bitmaps: don't recurse into trees already in the bitmap
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
References: <YMcExxF7DI6k+sZ+@coredump.intra.peff.net>
 <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <471cb9be-bb72-6a37-ede8-f9421d9d3ebe@gmail.com>
Date:   Tue, 15 Jun 2021 10:17:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMdGGL6v8LrbcAJP@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2021 8:05 AM, Jeff King wrote:
> On Mon, Jun 14, 2021 at 03:27:04AM -0400, Jeff King wrote:
...
> We can use the same optimization we do for commits here: when we are
> about to open a tree, see if it's in the bitmap (either the one we are
> building, or the "seen" bitmap which covers the UNINTERESTING side of
> the bitmap when doing a set-difference).

I was surprised that we were not already doing this. As Git can handle
larger repos now than it could a few years ago, I expect this
optimization to be immediately valuable, and critical in years to come.

> But here are numbers from some other real-world repositories (that are
> not public). This one's tree is comparable in size to linux.git, but has
> ~16k refs (and so less complete bitmap coverage):
> 
>   Test                         HEAD^               HEAD
>   -------------------------------------------------------------------------
>   5310.4: simulated clone      38.34(39.86+0.74)   33.95(35.53+0.76) -11.5%
>   5310.5: simulated fetch      2.29(6.31+0.35)     2.20(5.97+0.41) -3.9%
>   5310.7: rev-list (commits)   0.99(0.86+0.13)     0.96(0.85+0.11) -3.0%
>   5310.8: rev-list (objects)   11.32(11.04+0.27)   6.59(6.37+0.21) -41.8%
> 
> And here's another with a very large tree (~340k entries), and a fairly
> large number of refs (~10k):
> 
>   Test                         HEAD^               HEAD
>   -------------------------------------------------------------------------
>   5310.3: simulated clone      53.83(54.71+1.54)   39.77(40.76+1.50) -26.1%
>   5310.4: simulated fetch      19.91(20.11+0.56)   19.79(19.98+0.67) -0.6%
>   5310.6: rev-list (commits)   0.54(0.44+0.11)     0.51(0.43+0.07) -5.6%
>   5310.7: rev-list (objects)   24.32(23.59+0.73)   9.85(9.49+0.36) -59.5%
> 
> This patch provides substantial improvements in these larger cases, and
> have any drawbacks for smaller ones (the cost of the bitmap check is
> quite small compared to an actual tree traversal).

These many-refs scenarios make sense as something that is difficult to
verify using a single fork of an open-source project, but is common in
many closed-source projects that do not use forking to reduce the ref
count per repo.

I was impressed by how little code was required for this change. LGTM.

Thanks,
-Stolee
