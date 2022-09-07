Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10967C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiIGOsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIGOsI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:48:08 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063049751A
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:48:05 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l5so10560844qtv.4
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4qMiAWoFzEMZ9MNFGvgWDmmOK7FGCgJUdXbO51PJ5e0=;
        b=KWBXSGdmNVfdMtZU3y7eRI7Gfumqt7DbxTn4NbmzyTZYfJQ2wgSBw0Uu1pJIda1ys2
         K3BxwBg3KHRghw5drKMRjuShSt7zro/C4+MPhrxwnoikrFrtg3t+lrPGujzDRI2S7Dma
         /QHY6C7L1g0z0wFPFO/g3DYu47QuuvITcGDKLZPwGpEJnXX9WZX4moD4kPOu+Hw4f5JT
         WDUQfdu+trSxKOgmITfFnyX9OD8iXHYfltZKe62jGMSpXUw/VxHkHDwyJuEcz1uRTmps
         q1BIIj9aywglHUqYs4SZgOTofOWQa3r6Sm0PbxMHfZN4W4Hukr0Pm/9+Xxddrc5uh16a
         Iqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4qMiAWoFzEMZ9MNFGvgWDmmOK7FGCgJUdXbO51PJ5e0=;
        b=2NyfXlpnZeCR6q/vgiz27cAJCGwSsMEMgEMwEV8hOldbsx8gl0+o/LLZ4hsQ4HdNge
         9HfNTeFwtne3vz9OpKHXJB2k99pdkUI5jdJOM8wgK343cLtHD83LGFTzhfiQKvmQn25y
         /iHhj13s62VCp5cWwf5Ula9V+jwIBA355EzmnUYQUqzkjqn1KiIA3oOyYfv6jB8UQaQ7
         zngMmCHTkdhq/GmB5v8359yieQIQYEDxmXTApTLxI1dIwjHShe6GSnbijKkxnvBZt/Tq
         sAal3lF9xpLgssGLKqtuLdTaAkcBQQMdhaH/s6O+F+BfNBuIvKkiTJ2B2rwt21gqmkXj
         prNA==
X-Gm-Message-State: ACgBeo0b+d42O0Gy5WqRA4l9ojkm+0T0haxxdL99tqaSMPfppUjMIjpt
        UYOc9Dod8vwbltIDFcT6j9yf
X-Google-Smtp-Source: AA6agR5bsgQ58xR8/1dAwU5iRREydyxz0ejwQenBodxfbLcbX7gnI6QtWZ1JLL/tS+7a/H0yDXU4uA==
X-Received: by 2002:a05:622a:4c:b0:343:5d26:562f with SMTP id y12-20020a05622a004c00b003435d26562fmr3499770qtw.613.1662562085121;
        Wed, 07 Sep 2022 07:48:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t12-20020ac8760c000000b003434d1a7a14sm11907372qtq.62.2022.09.07.07.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:48:04 -0700 (PDT)
Message-ID: <fc4ce953-1a3b-8d94-d602-ad3e195f08c9@github.com>
Date:   Wed, 7 Sep 2022 10:48:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/3] speeding up on-demand fetch for blobs in partial
 clone
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
 <b0101e7e0e61496a92c2299454c2696a@xiaomi.com>
 <YxDbfXyWzgokb1Bq@coredump.intra.peff.net>
 <d5305274b7c24adbaf6ad9ab92ac3b6a@xiaomi.com>
 <YxeTsWrjpKo+JGfq@coredump.intra.peff.net>
 <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/2022 6:58 PM, Jeff King wrote:
> On Tue, Sep 06, 2022 at 02:38:41PM -0400, Jeff King wrote:
> 
>> On Mon, Sep 05, 2022 at 11:17:21AM +0000, 程洋 wrote:
>>
>>> Sorry, I told you the wrong branch. It should be "android-t-preview-1"
>>> git clone --filter=blob:none --no-local -b android-t-preview-1 grade-plugin
>>>
>>> Can you try this one?
>>
>> Yes, I see more slow-down there. There are many more blobs there, but I
>> don't think it's really the number of them, but their sizes.
>>
>> The problem is that both upload-pack and pack-objects are keen to call
>> parse_object() on their inputs. For commits, etc, that is usually
>> sensible; we have to parse the object to see what it points to. But for
>> blobs, the only thing we do is inflate a ton of bytes in order to check
>> the sha1. That's not really productive here; if there is a bit
>> corruption, the client will notice it on the receiving side.

Thanks for finding this very subtle issue!
 
> So here's a cleaned-up series which makes this a lot faster.
> 
> The special sauce is in patch 2, along with timings. The first one is
> just preparing, and the final one is a small cleanup it enables.

I carefully read these patches as well as applied them on my machine
and did some extra digging and performance tests to understand the
change.

LGTM.

Thanks,
-Stolee
