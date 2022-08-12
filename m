Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE8C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 12:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiHLMV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiHLMV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 08:21:57 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D63B07E5
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 05:21:56 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h22so606471qtu.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=tIE2Y4FBEHsCncTcoskgAjrxT5LurPcjuDECh7R1Jm0=;
        b=fcBtff8Uxay9YGrei4qmzohqDBp8AGAaSwM00IQ1v996k6iZ/AbH8mkkHHlm+/sHcF
         i1N+nMMJEJIn6RgNwyiYI0+6Gs+TLlbPZHa9tb7xtNj09aqqBcZMNgJFIcNf83qb3KPP
         Z3tgqiRhaBEbMbZ2cH53mVR3yqgiWEtFlVbv6p/8UWACeYHyKLZEDatFzMPGB/bSlY/7
         KTm/0QQApZKtYh+r9gQI1melHjU34Wp0JwNQmWrw57K9wG4KA9Uhe5zgiToOWNa7tNuh
         hu+P9SEdWPnTSnKl6iMjaJdJML3RB7an92lyT/pkARkY13TIcZPxC9uw8hk8PDfq5NDT
         G79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=tIE2Y4FBEHsCncTcoskgAjrxT5LurPcjuDECh7R1Jm0=;
        b=B6lpp1HtVE3rlkFuaVSxXvx5sZMceQFLILRcdIDW11evUV9AXFoJmidYKxxV8nmgcR
         TmZiJLjrYpfuUHL6HQS5tg6zgo6NcH8/6IAolBp5/IT4V4WN9Yxla/0OIwlGBjBYtozN
         7FBNQCMghUiutTplUZp7tbA5ebOdlZfccBOEQR39LTSQQ8mE9+Pe+7VwHu42Is7x/cYL
         6+NAwwsbd8VZeW0SVQltAn8Wf3PjiwLC0AA2puv4vo5OT+1fjPbZJg0Tqn6aVxem96GX
         Gy5teOUbljNWNfyTeySSZu+LehyRfW+z+HdnDSCkcG840jx6BsiML6LFavcDM2uzYv+H
         qVhQ==
X-Gm-Message-State: ACgBeo3hmTDO//2zE9xD7ugQjHOhF+bZ+BRvrX6eeaxwyX5yI0A35OAs
        7p2XN6q4hzo+DyOtOF+jObWW
X-Google-Smtp-Source: AA6agR4rJ1GUslxxwixtTI/SYBPubT3y0MFoe4w1KcV9XaEMtoYVqlN0oQX4UdHSHoVPGQlNLIGyFA==
X-Received: by 2002:a05:622a:1a01:b0:343:310d:fedf with SMTP id f1-20020a05622a1a0100b00343310dfedfmr3346863qtb.622.1660306915172;
        Fri, 12 Aug 2022 05:21:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:bde0:34b4:88fb:47ff? ([2600:1700:e72:80a0:bde0:34b4:88fb:47ff])
        by smtp.gmail.com with ESMTPSA id bk3-20020a05620a1a0300b006b9be18b774sm1555129qkb.105.2022.08.12.05.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 05:21:54 -0700 (PDT)
Message-ID: <16633d89-6ccd-859d-8533-9861ad831c45@github.com>
Date:   Fri, 12 Aug 2022 08:21:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: Partial-clone cause big performance impact on server
Content-Language: en-US
To:     =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/22 4:09 AM, 程洋 wrote:> Hi.
>      We observed big disk space save by partial-clone and require all of our users (2000+) to clone repository with partial-clone (filter=blob:none)
>      However at busy time, we found it's extremely slow for user to fetch. Here is what we did.
> 
>     1. ask all users to fetch with filter=blob:none. And it's remarkable. Now our download size per user decrease from 460G to 180G.

I hope this includes the blob download during the initial checkout,
because otherwise you have a very strange shape to make your commits and
trees take up 180 GB.

>     2. But at busy time, everyone's fetch become slow. (at idle hours, it takes us 5 minutes to clone a big repositories, but it takes more than 1 hour to clone the same repositories at busy hours)
>     3. with GIT_TRACE_PACKET=1. We found on big repositories (200K+refs, 6m+ objects). Git will sends 40k want.

You only have six million objects in the repo and yet have that size? It
must be some very large blobs.

>     4. And we then track our server(which is gerrit with jgit). We found the server is couting objects. Then we check those 40k objects, most of them are blobs rather than commit. (which means they're not in bitmap)

Are you seeing any commits in these requests? If the Git client is asking
for blobs, then they should not be mixed with commit wants. What kind of
operation are you doing to see these mixed wants?

If the request was only blobs, then the server should not need a "Counting
objects" phase. It should jump immediately to preparing the objects (which
will likely require parsing deltas, and that can be expensive). I don't
know if JGit is doing something different, though.

>     5. We believe that's the root cause of our problem. Git sends too many "want SHA1" which are not in bitmap, cause the server to count objects  frequently, which then slow down the server.
> 
> What we want is, download the things we need to checkout to specific commit. But if one commit contain so many objects (like us , 40k+). It takes more time to counting than downloading.

One thing that the microsoft/git fork uses in its "git-gvfs-helper" tool
(which speaks the GVFS Protocol as a replacement for partial clone when
using Azure Repos as a server) is a batched download of missing objects [1].
The initial limit is 4000 objects at a time, but that helps keep each
request small enough that it is less likely to fail for scale reasons alone.

[1] https://github.com/microsoft/git/blob/vfs-2.37.1/gvfs-helper.c#L3510-L3520

It might be interesting to create such batch-downloads for these partial
clone blob-fetches.

Thanks,
-Stolee
