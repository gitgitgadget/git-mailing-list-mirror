Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A96ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 19:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiIATYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 15:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiIATYV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 15:24:21 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C108186FEC
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 12:24:20 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q81so15455374iod.9
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VFhVT13OUkKQqp67pBrCnP0wJVTtfdpazWsQlpRya1c=;
        b=RyHw1Gc1lk+WKMCCvdN+JeX4OWaX6AHy73Vs5xtnfWSgYMCf2TSARxBUsPxPvXLlOL
         v/jkQv9G5TAig3bFw46Zf9HClGzCl47tqjbhCcR3btIzwbXRmawXZb8RGG4X7TPo9FX3
         6xnMDVuFDYdUCvPvm22R2hp8pNjtKXZ5DnIHR4bNvWufckudDu1DUtxOJlNoEZXdLeHG
         C32Z8IeZ/QsS7kNj9KzoDtxcEobMLw1B4T0Med0i7j9R9jvsy636CDEZqa31RJKzdWEl
         u1PFlrmtL4dD2dtq5u/GyJxt6V5ny97TKt8DGkQwJwqcWeYdLY5BtYet8ORcGhlBNopX
         d2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VFhVT13OUkKQqp67pBrCnP0wJVTtfdpazWsQlpRya1c=;
        b=48DoklGOUOQjSB9KyMhGdDFcuugI3hCHd1a5C+DB9V+Hc6dH4fbVhXvWQclfO/mxZs
         EhrDi+EWI53mMUy4asXlwNlIZqUTc5Ww1kT29dIszRaMT6m0DHil41Coswkq0wE8WWnP
         Zs5u6XkLjGgR/YbZYOykKrD0g/NCEwYcZ4xEZMwDHNbQ67b9ITe+jCTnhQ0U8Uy+lbIV
         BqUH0sKES/7tAPrEZ8rYjpXl0d/rh4SM4rdZw4qmx0PYwh6r5m3y04gHVxB9knokF7ZE
         hbF0dLmL/h7Z5qlSw1jyMIRFg0pHs5ssHHpMO4T2RDgqcj5TRu1l0hf5odN5iQonHFe2
         YEcg==
X-Gm-Message-State: ACgBeo2yQCQiXFVDIVZJBgALvgJu2e/htAs5UFWNDqddmtZE6Y6wO7sz
        qI4EUIwSp97zAOZ2a9XbhiQl
X-Google-Smtp-Source: AA6agR4QiO+ebxyqI5IYFWYb6y8fYBoOMkzm+X+lhN/5/1yw4fc4/BZC0kGsE+0wsXI2wG3YOgVFDQ==
X-Received: by 2002:a05:6602:3284:b0:68b:649e:1789 with SMTP id d4-20020a056602328400b0068b649e1789mr10081013ioz.37.1662060260166;
        Thu, 01 Sep 2022 12:24:20 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t21-20020a02ab95000000b0034a5837db0dsm3900809jan.32.2022.09.01.12.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 12:24:19 -0700 (PDT)
Message-ID: <a14028be-2fd2-258d-94f5-c010669de8a6@github.com>
Date:   Thu, 1 Sep 2022 15:24:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/3] list-object-filter: introduce depth filter
Content-Language: en-US
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1343.git.1662025272.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/1/2022 5:41 AM, ZheNing Hu via GitGitGadget wrote:
> This patch let partial clone have the similar capabilities of the shallow
> clone git clone --depth=<depth>.
...
> Now we can use git clone --filter="depth=<depth>" to omit all commits whose
> depth is >= <depth>. By this way, we can have the advantages of both shallow
> clone and partial clone: Limiting the depth of commits, get other objects on
> demand.

I have several concerns about this proposal.

The first is that "depth=X" doesn't mean anything after the first
clone. What will happen when we fetch the remaining objects?

Partial clone is designed to download a subset of objects, but make
the remaining reachable objects downloadable on demand. By dropping
reachable commits, the normal partial clone mechanism would result
in a 'git rev-list' call asking for a missing commit. Would this
inherit the "depth=X" but result in a huge amount of over-downloading
the trees and blobs in that commit range? Would it result in downloading
commits one-by-one, and then their root trees (and all reachable objects
from those root trees)?

Finally, computing the set of objects to send is just as expensive as
if we had a shallow clone (we can't use bitmaps). However, we get the
additional problem where fetches do not have a shallow boundary, so
the server will send deltas based on objects that are not necessarily
present locally, triggering extra requests to resolve those deltas.

This fallout remains undocumented and unexplored in this series, but I
doubt the investigation would result in positive outcomes.

> Disadvantages of git clone --depth=<depth> --filter=blob:none: we must call
> git fetch --unshallow to lift the shallow clone restriction, it will
> download all history of current commit.

How does your proposal fix this? Instead of unshallowing, users will
stumble across these objects and trigger huge downloads by accident.
 
> Disadvantages of git clone --filter=blob:none with git sparse-checkout: The
> git client needs to send a lot of missing objects' id to the server, this
> can be very wasteful of network traffic.

Asking for a list of blobs (especially limited to a sparse-checkout) is
much more efficient than what will happen when a user tries to do almost
anything in a repository formed the way you did here.

Thinking about this idea, I don't think it is viable. I would need to
see a lot of work done to test these scenarios closely to believe that
this type of partial clone is a desirable working state.

Thanks,
-Stolee
