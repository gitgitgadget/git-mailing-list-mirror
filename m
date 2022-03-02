Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A061EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbiCBUXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiCBUXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:23:53 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B4048E76
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:23:08 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id k9-20020a056830242900b005ad25f8ebfdso2684569ots.7
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 12:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3v1/9TCjRC82hbRUxj4NUn1FbGHnsRgRPASubqKaff8=;
        b=d6SIJoxGSU+MrO/2svCY0d+AiushEd8aYdAmQaqIFNd9mN59sRGMw4J7sae4YB33oy
         lpsd/KTVqoSaGzryebWYv2DDOK8J8MqDfyL62D5WGUYUaBWajRpZKbRSD4M0wKDfID1q
         sYBDxTRO3bWHHrMQRknTnj9isWJaXqpDc8P9C5iFKbK9kj3X6n+0D2lT8TK8oy3JDQ3Z
         SS5yKVuLZ1vuKUy5QOaRRnDou+SpMfpHP6SNHn4Qw81YQUphmCvpDFr2x7jFcNSe2pB4
         +OO3fNe7b5Pd27TauD84cmhl0Ubi5jgJxmDkGBrDGm6q51D9wQu8ITNSA9GMibJrpkhP
         XXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3v1/9TCjRC82hbRUxj4NUn1FbGHnsRgRPASubqKaff8=;
        b=VDYX4dGDNX+Z+Y8yIxNJit1tKaqo5v+nEDYIf2vD7QHmlvBU0Olr/EHDej9d1WohMW
         4uzK5o9+at5kdk8YR75u/oa7XQIhpeNWLDaMccIuRdsQrPxnL7r8Hf7sAMzVzjnay7cV
         IB0nRi0ttK/2xWE0QPBiJqY1QNMsmqm/cYXAzpSQDgiX4ZdtvpR6uzL/FibVaP7WvxZk
         5UQdP1WMJK+qK0D5kL9M1vHqeIHLufQbdoInH33p1KwArktiHy2e+PDuN2MkTsXDozVF
         f1qIKePoIYqaBDq4KRxV9+VqbBjqWoOB7oZ82XT+GTnd70uM6JIYsDPF4AWfWz6bup7o
         FMbQ==
X-Gm-Message-State: AOAM532dA3F1OYC5Cdc6+U/g6jpQvoWAn6ZvqywWNF5l+Bf3GEiAgzEd
        XPG3YY93UFkwlgrDvWrmBla5
X-Google-Smtp-Source: ABdhPJxnlog4aZLxZ3xf5Lf3OidhmTM6VFSfJ5MC2o7uWu0hHpGIklkQyXmJq3oY9ySpTobNrwS6Tw==
X-Received: by 2002:a05:6830:3113:b0:5af:4eec:6132 with SMTP id b19-20020a056830311300b005af4eec6132mr16951026ots.6.1646252587421;
        Wed, 02 Mar 2022 12:23:07 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id hq12-20020a0568709b0c00b000d3d5d4def7sm41085oab.29.2022.03.02.12.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:23:07 -0800 (PST)
Message-ID: <138d98bd-928d-1708-128f-217bfe9a2788@github.com>
Date:   Wed, 2 Mar 2022 15:23:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 00/17] cruft packs
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     tytso@mit.edu, gitster@pobox.com, larsxschneider@gmail.com
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1646182671.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 7:57 PM, Taylor Blau wrote:
> Here is a reroll of my series to implement "cruft packs", a pack which
> stores accumulated unreachable objects, along with a new ".mtimes" file
> which tracks each object's last known modification time.
> 
> This was on the list towards the end of 2021[1], and I have been
> accumulating small changes to it locally for a couple of months now.
> Major changes since last time include:
> 
>   - Clearer documentation and commit message(s) to better illustrate how
>     the feature works and is supposed to be used.
> 
>   - Some minor documentation updates to pack-format.txt, which make some
>     ambiguous details more explicit.
> 
>   - Minor code movement / tweaks to make things easier to read, ensure
>     that functions aren't introduced in patches before they are used /
>     etc.
> 
>   - Moved the new test script to t5328 (instead of t5327, which happens
>     to be taken up by a new MIDX bitmap-related test), and purged it of
>     all "rm -fr .git/logs" (replacing them with "git reflog --expire
>     --all --expire=all" instead).
> 
>   - A new test which fixes a bug where loose objects which have copies
>     that appear in a cruft pack would not get accumulated when doing a
>     `--geometric` repack.
> 
> For convenience, a range-diff is below. Thanks in advance for taking
> another look!

It had been a while since my last read, so I read the patches
in full one more time. I found a couple nitpicks, but otherwise
everything is looking good.

Thanks,
-Stolee
