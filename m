Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD59C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 17:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F8C2613C1
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 17:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhFPR4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 13:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPR4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 13:56:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F9C061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 10:54:37 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so3381262oti.2
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VGQh3XUpHyukqKRYhCzOxYVozDnujGAtNOFHkARlJp8=;
        b=WPvs9UW/wacLt2NkVycKW+0GLdpAx21xy+roW31sqaMGTAFtiYk/DNNAbL75fhTyWf
         2QKAjK5ZscEPaQQ6LQnn/CsjHnp1R7kejVpanD9uhEdcUkccKoF0qpVb+LCTE45SZpTy
         h9ejmP/cXrJMpKP/rQnCtGTtMSIidc9uBopVlB6ns0t+ERllhw8Gh/SloIRnl0qNHqdj
         DNcFO+WdStaq02AG3HJm07taE/sSI6WH739OC1fgzUd6a+iDeVDJrcLBv+F+VoH7tHb9
         3+rvydQl+xPZsopGXlGeF5DzU9wm91iBeZepTs5tMvpeerMqP8/hRJKymcOd39pFuuR/
         aE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VGQh3XUpHyukqKRYhCzOxYVozDnujGAtNOFHkARlJp8=;
        b=OB8qPwd3RRZioUS9U7N3dAzdlPIK2y1gcqvCEmH/PUDvoDTrObRMKSMF94OG01yN64
         34luR1JJ8irqDBkjIwC3FhxzmpPL19ldUMP2QJkc6MC1l6ff/RYj4sAIgI8rqTAEFt2f
         ohycRWl5SRj/rUhvNBPHAHKyMe8EAbxhRiueo15lw2pxnZNT2N01EvFNoLXh0YDNL2ql
         ppUUBsY+5iLGNkb9cZAifgAKCm1poW+V6DFhot6LZwmr3A5S9rnreLtYFZFD1pIzcArF
         8SOykcrGq4EKUe9X6Dmn9h1fchLjin9S5HLedMH4Sf665iJipiZYJ7Mouz7QF7ftZZO1
         lW8A==
X-Gm-Message-State: AOAM530savNPaf6MEJQkH8mfDRGdqao0P/BQB3zkBMjcSYNUXOfLKOkr
        WDU7lRbeTNMZlls9c9JPPoU=
X-Google-Smtp-Source: ABdhPJxLneBl+Z1l48YaApMc+aKM1TuQJy4o28K7y2L03BFwc+HOc0uUdMd09pbL2JMuZ8h9dNp8vw==
X-Received: by 2002:a9d:a74:: with SMTP id 107mr962530otg.4.1623866076437;
        Wed, 16 Jun 2021 10:54:36 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4142:2009:c909:559c? ([2600:1700:e72:80a0:4142:2009:c909:559c])
        by smtp.gmail.com with ESMTPSA id d20sm667466otq.62.2021.06.16.10.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 10:54:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Optimization batch 13: partial clone optimizations
 for merge-ort
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
 <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ad73c3f7-46a9-1000-e490-e5f55e283ff1@gmail.com>
Date:   Wed, 16 Jun 2021 13:54:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/2021 6:41 PM, Elijah Newren via GitGitGadget wrote:
> This series optimizes blob downloading in merges for partial clones. It can
> apply on master. It's independent of ort-perf-batch-12.
> 
> Changes since v1:
> 
>  * Incorporated the suggestions from Stolee on patch 2.

Thank you for these.

>      -+		 ..........fetch_count:12
>      -+		 ..........fetch_count:5
>      -+		 ..........fetch_count:3
>      -+		 ......fetch_count:2
>      ++		fetch_count:12
>      ++		fetch_count:5
>      ++		fetch_count:3
>      ++		fetch_count:2

In particular, I think this simplification will pay dividends in the
future.

Also, I am in full support of the goals of this series. With such
changes, we could potentially re-enable merge.renames in Scalar and
VFS for Git. Currently, we avoid this so we don't download a huge
list of missing blobs whenever pulling the latest changes in these
enormous repos.

I am still late in doing more meaningful testing which would allow me
to give this a full stamp of approval. Specifically, I want to merge
this code and the rest of merge-ort into the vfs-2.32.0 branch of
microsoft/git and run some sample merges on some private monorepos
and see how it behaves. I'm very eager to include merge-ort as a
recommended config in Scalar, but I haven't had the time to devote
to testing like this.

I just created a calendar event for Tuesday, June 22nd to hopefully
devote the entire day to such an effort. Thank you for your
patience.

Thanks,
-Stolee
