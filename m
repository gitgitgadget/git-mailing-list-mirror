Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A403C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 17:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiI3Rak (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiI3RaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 13:30:16 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA04198D0E
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:30:13 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id g8so3818552iob.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UVkhiBv2dK2twUEMS6WogxykuSm4bTuyXHuYNtxOzrI=;
        b=UMB6I37rcs0avwXYdF8si0wVnqX1hTdfXoQnCo4Tts+zcRKMCbyfYl3fq4VfQ1pmR+
         T4eAyIayd5VVhEg7eKkzSPn699EzCYTnM0gXqfkXCl55BJOZ15nWgbwrUuSPaj8UrG7c
         BqTQgzR9sHu02VTFhxdcJ61jOb127alfx+Do8RQRrm38n9ySiGkaBaw/UDiTvKqWOrWy
         FWulOdgBnfgDVNHFkbLkFn2jo3IS4Fen/4Zz0nH9ckOjO1tCyEJjLqu8fM5jTx9Jt9Hx
         fK6+o3dSAmQEi4GIM/t5jGqEdXSFsKIXHLNsaalq4FgGA5twGECXlOR/IN0/NnkJ/bro
         wsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UVkhiBv2dK2twUEMS6WogxykuSm4bTuyXHuYNtxOzrI=;
        b=lzIRsH0Og6a2Q+BjVTJjXSFjwD9VDadGO9pfNPJWH2dZOG3XCrJT7Y3msr17yBDxCA
         b+cTbaB/v6g6HWPYRZCOriSqPKqaxe1uoT+t8YJMpdokwE4E7kFp0VfwJwTeARKs9qmZ
         3CI4ttu9Gp8GHOIDp8BAGDFTtiHAmR4/7yoYXNtFHluETg/ziBizjLZa6ECsGCOs/pXs
         BAUqEvO4qIeKQVIyB4DB7/YDX3Vaz568a2dZtT5/XnY3Pj2Q4WSzZJ3tdo8OP+qPvyeg
         QMTQKv1AdTGxlrZ4AQwgZ6mj8YpO4ECbASXYzHzQJ9fqqX/cPZd8UAzoF40O/rch84Ja
         +0MQ==
X-Gm-Message-State: ACrzQf3qRdhYV0ZrXKs5KAQEXDL2xr9tCJEYyaU4rdk3Zdwzvg+LDxaW
        n00sFq54T3sAeh7gJ5f9T9xm
X-Google-Smtp-Source: AMsMyM56sbB6WjdSTlZE0bREnkOAvzhmxauLMIbo8/yKZxUSdZ88xm840CGkxhzvew9Nn9EzCTYkcQ==
X-Received: by 2002:a05:6602:2d14:b0:6a5:5d0:ed02 with SMTP id c20-20020a0566022d1400b006a505d0ed02mr4373462iow.173.1664559000463;
        Fri, 30 Sep 2022 10:30:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8c53:a5aa:3322:e297? ([2600:1700:e72:80a0:8c53:a5aa:3322:e297])
        by smtp.gmail.com with ESMTPSA id j8-20020a0566022cc800b006a153f7e34asm1307527iow.6.2022.09.30.10.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 10:29:59 -0700 (PDT)
Message-ID: <05c5076b-eb78-5381-4eba-863a84190755@github.com>
Date:   Fri, 30 Sep 2022 13:29:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/6] rebase --update-refs: smooth out some rough edges
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220930140948.80367-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/30/2022 10:09 AM, SZEDER Gábor wrote:
> A couple of cleanups and fixes to a new 'git rebase --update-refs' feature
> introduced in the current release cycle.

Thank you for examining the feature closely. I think most of these
are clearly improvements.

I'm less sold on patch 4 which removes whitespace a bit too
aggressively. I agree that the situation with multiple refs pointing
to the same commit is somewhat wasteful, but I also think it is
important to use whitespace to highlight the different groups of
commits. It provides a nice break for the reader to quickly find the
commit they are looking for within each group. I'm not sure how to
add a whitespace break only at the transition point between the
update-refs commands and other commands, but it would be nice to have.

Otherwise, everything looks good.

Junio: I don't think any of this needs to rush into v2.38.0, since
they are mostly cosmetic changes and helping users get out of bad
situations.

Thanks,
-Stolee
