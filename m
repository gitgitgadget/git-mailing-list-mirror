Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA51C07E9D
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 19:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiIWTFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 15:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiIWTFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 15:05:16 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56419D2D65
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 12:05:12 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id v128so650068ioe.12
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Q4w8ap5CcmjvRvBeHai5V3R8dYKwBV40U7M2MRLYakU=;
        b=e+WrhlgY8qJPdgWeDYl7XSid0bbKSmC6aiRRWwHEDyNs6hoygCikevn+ni52D2DTk0
         z+ihRpQ08Fu80HDZsfvfyMi3HUspgcIiuUOT56PiGB1O7egpvIKdKvJ/WYXJPLAYE8LA
         nvJg2s3sw4LEOIl3sOqShENB+SewC3l/9qDXNpN0ZkTKC7syXrKQqneavpXc+yY3Sfc8
         TypaSnHDjKNIUni/txaDc1xorrgL/ZE/OCfvzv3Xnuaz11D/8BHyFHlAPuDHRRd1/ppI
         Q88LZeJQ6doAxFnXLz67coSddWlPPodBJ/f/h2LIgilI8O5v5XXy7Q97TcXMfqaW6+cu
         shNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Q4w8ap5CcmjvRvBeHai5V3R8dYKwBV40U7M2MRLYakU=;
        b=s8nnZu7P8zxx5ilAYSgsSFEgMgazihaWaVbrGA6HoTjX4FXw0l5gCE6/9cdG3bTP4N
         t2aNr2wYW+R7J81LvP09spqbnEjHvpZZ16J05GWDeewlLdULopVxzY0BEV9mz0Vts3kU
         XyK7SbyCljLrBAeZlUDWpPzNfRFp2DAEquXwRZYMqh7QwmcvVyL5pAg/tLtnYWMcCZZi
         Jrl1Dfb0hbjWu6hw8+6jaJqIShifKVRevzDcIx1khD7D/nWj+B4kfzdvJ56bVjqJfuAK
         YqlRnZrLevYnO/fa+dWJut2d3AJt2EMDsdwaBPYTeQqIzmIay5kn58tLfDjIE/aH1fy1
         EhLg==
X-Gm-Message-State: ACrzQf3mcILGl+HBwb4z1fv40pNvtxAn4EtziJvkgexSv+qS1iansP56
        SFBGSeUfkk1yXQW+1tHOOQAm
X-Google-Smtp-Source: AMsMyM70aoz/5ZHUzLaDOWosyVlJRqGdQUtFYxVELzcyeLn96V18YgpP+OYaCfJbwTnnPeDvM8iSrw==
X-Received: by 2002:a05:6638:1355:b0:35a:c5ff:5a32 with SMTP id u21-20020a056638135500b0035ac5ff5a32mr5561420jad.202.1663959911551;
        Fri, 23 Sep 2022 12:05:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f43f:f355:a5bb:115a? ([2600:1700:e72:80a0:f43f:f355:a5bb:115a])
        by smtp.gmail.com with ESMTPSA id o70-20020a022249000000b003572ae30370sm3740504jao.145.2022.09.23.12.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 12:05:11 -0700 (PDT)
Message-ID: <c8c42bd6-4aef-d310-b988-108bf74ebb96@github.com>
Date:   Fri, 23 Sep 2022 15:05:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/3] midx.c: use `pack-objects --stdin-packs` when
 repacking
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
References: <YyokIf%2FSd7SYztKQ@nand.local>
 <cover.1663706401.git.me@ttaylorr.com>
 <4218d9e08aba629d8f64b5a999f60d12e5d8785b.1663706401.git.me@ttaylorr.com>
 <5172dbb7-61d1-7249-f9bb-d760e6f4450a@github.com>
 <Yy364WAutGIdXCub@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yy364WAutGIdXCub@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2022 2:28 PM, Taylor Blau wrote:
> On Fri, Sep 23, 2022 at 02:23:30PM -0400, Derrick Stolee wrote:
>> Do you know if there is any reason to do this explicitly? Does this
>> change the set of objects in any way (perhaps by not including
>> duplicates that are tracked in those other packs)?
> 
> Yes. The "^" lines become excluded packs from the perspective of the
> follow-on reachability traversal to discover the namehashes. So as soon
> as we hit an object contained in one of the packs marked as excluded,
> we'll halt the traversal along that direction, since we know that we're
> not going to pick up any objects in those packs.
> 
> So you could omit them, and you'd get the same resulting pack, but it
> would take longer to generate since we wouldn't be stopping the
> follow-on traversal as early as possible.

Excellent. Thanks for explaining that!

-Stolee
