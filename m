Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23FFC54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiIVOIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIVOII (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 10:08:08 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B18ED5DD
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 07:08:07 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id c4so7797243iof.3
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nNgifJkDY2Vv5kL/eFHEXlNTnrOZo6WxT2pgX79fwGk=;
        b=aIxRqQB3dEULoour/7qCXihyjeltk+CsW84RywfyS5RE8FSFrnSl+SXxMOsMcfuaIh
         u/OdzV+ztWdScQvIaU5BK6xlnCSIHeWUhcHrIR3BJ9NNc1XZP4UQesnGySEXeWdLkMO1
         9z+ac2aWlGWwa/TlRWBXP++TGwqJPWMNgqbPupZ6tMKjvFqVQRh2hTTeL+xuG9Qyd2qH
         TfkWoM6GL8Cu68DLLhwjSZSOyWGKgOf0qNhyu0nLzrNKARIRYLArXQHxeJjhzSvRlWss
         AzgOJwACFr2VwtTioXhFYHb5U1LQT6mB6XT+KVMe8tFFtWkG2WUAPMK/BRQ5wrkFQFBL
         ks7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nNgifJkDY2Vv5kL/eFHEXlNTnrOZo6WxT2pgX79fwGk=;
        b=6VYsxQVEM4RtGVQGvwIzlpb42gfDuCfbqTFqhXwwA9ugkpLYEIgiO33G2IRCyV3H+F
         Ig1WgVjnwzzrTehG6U4PNfwU/MUor4KfLFTTyEPadENdpFvcIEiRwQKf+70S6SfTqwZG
         XaS9wCIfSRuAPBqJVO1T4ISPd+ViQ1f2Yr+FQaiuBUQjytGhkrGO9L7Px441qcW5usl7
         0Pfb6PMeo7x3NiRJEl0FyVlDiJxbEffzrIXKLAVxGTkbfefxnF1BmRBH5Y8MHx8YdarC
         BIX63aD3z9mQ8OZjJ97Cy/Mwkwy0Inz4yxpShaokVS43AzlSpJCkYcimABiWQ1NPbZLj
         g0RQ==
X-Gm-Message-State: ACrzQf2mZS4itAXuOXS2VHHKeFJRO2mB/fQgD29sX+a6nW1jTsLQjjxD
        t9ZstLv1LZlarQWiw3fdCyw1
X-Google-Smtp-Source: AMsMyM7tYRCRTPPqTyiEYpjlyIK1hiPwXtDpJnk+Ms+PRVZSo/DxxbO17WqOFgVRa2MVlHvTb3c1QA==
X-Received: by 2002:a05:6638:19cf:b0:358:3dd3:2162 with SMTP id bi15-20020a05663819cf00b003583dd32162mr2027933jab.185.1663855687216;
        Thu, 22 Sep 2022 07:08:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e4c7:912a:7017:ed79? ([2600:1700:e72:80a0:e4c7:912a:7017:ed79])
        by smtp.gmail.com with ESMTPSA id t8-20020a026408000000b0035a0d844e43sm2191295jac.159.2022.09.22.07.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:08:06 -0700 (PDT)
Message-ID: <37ffe1a6-bed9-70ce-2c66-b7a2d8c45ba9@github.com>
Date:   Thu, 22 Sep 2022 10:08:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 3/7] midx.c: prevent `expire` from removing the cruft pack
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, gregory.szorc@gmail.com
References: <cover.1663638929.git.me@ttaylorr.com>
 <3ae9903d2df491e291ab975c56ec78aa13d95655.1663638929.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3ae9903d2df491e291ab975c56ec78aa13d95655.1663638929.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2022 9:55 PM, Taylor Blau wrote:
> The `expire` sub-command unlinks any packs that are (a) contained in the
> MIDX, but (b) have no objects referenced by the MIDX.

It is important to note that this can only happen if all objects in
the pack have duplicates in other pack-files.
 
> This sub-command ignores `.keep` packs, which remain on-disk even if
> they have no objects referenced by the MIDX. Cruft packs, however,
> aren't given the same treatment: if none of the objects contained in the
> cruft pack are selected from the cruft pack by the MIDX, then the cruft
> pack is eligible to be expired.
> 
> This is less than desireable, since the cruft pack has important

s/desireable/desirable/
(according to my spell-checker)

> metadata about the individual object mtimes, which is useful to
> determine how quickly an object should age out of the repository when
> pruning.
>
> Ordinarily, we wouldn't expect the contents of a cruft pack to
> duplicated across non-cruft packs (and we'd expect to see the MIDX
> select all cruft objects from other sources even less often). But
> nonetheless, it is still possible to trick the `expire` sub-command into
> removing the `.mtimes` file in this circumstance.

I was initially unconvinced that this scenario was super-critical
to keeping the .mtimes file, but I was able to think of cases where
objects are duplicated out of the cruft pack due to de-thinning or
otherwise inefficiently packing unreachable objects into these
other pack-files.

Thanks,
-Stolee

