Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE6B1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 01:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHEDtS (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 23:49:18 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:36690 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeHEDtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 23:49:18 -0400
Received: by mail-pg1-f180.google.com with SMTP id h12-v6so4600105pgs.3
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 18:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K+4eeKxTT4GkxS45OtvTDgsJ0+xu2BX+gakOhQwYkMU=;
        b=AYsCon+tcoZMTXffJwXl657s6dYjd8axfszICbtG6Qe00nvB+xaiOlljhQBtvxsUfj
         7a4pVtdKz4wyClcElPb1+Pxw/tHoPYTB+jIG5CYZucxV9kD6e5iUx/8wHqpdKNE2MFlo
         iiVe4eVJWdsQAggAUtVGQU8byt+G7Mbt2AlHWa934NxgVEP5Xjw3Zk+FuYcpELp3xVau
         FYbAjtDcbzoWm9+OuePd1/05/fMOTdPKFg72Wl4o8D+PnrTFfbVHiKoC2KlPKkOQqNIU
         lsn7fG9iqRQssRE8+HTdyWwBYVn7VoA3WWFuYtLnPGlzftmActQ6UKdngln3qmtN2AbQ
         dYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K+4eeKxTT4GkxS45OtvTDgsJ0+xu2BX+gakOhQwYkMU=;
        b=tKuzbl2QQgdLQ88AsKDsMJXKkeKyv/EXiVNkJZKrnpU3kliiaivcM0LY4j7ZgK4pzG
         2zlXXjC6oZT8boGrQL0BTXOj5YXUBr+qC+wY+Mx3zqiqqCbWRPDUvz45Wv/xjvYDLiLI
         bBFocjZ0hpmO9NyauKwKbNNvLBewCRMau6f4z7b5HeZjdoWbti6WFO98EQmHRwQ/rkCE
         NP0EesCYIAQh28GXH18YGgNrXWhk8CJ+FC98nVdpsL/wBjImxPN8nGv9dI7qZlX+5fz8
         q85O9AQ5WCmAnuPzA1R5hLVHb5rhMFWB5sRfX2OqZIp6bZpVK1Q4OkVkN1kV5WO9Jc/z
         ID8g==
X-Gm-Message-State: AOUpUlG2y0LTw4gLMr2SCJ5fV/3J8UAjVEt/kRm1ssE5t0v2G6hHURXG
        Za2ViznuYG4/loPgwpwTPQjjCMsv
X-Google-Smtp-Source: AAOMgpclVDzPUnNuVuHGZmQ9Ru+WaECspln9Qrt7aklXA22NwhWRthnxI3XLCR+9CECPrBoD1DS0Ug==
X-Received: by 2002:a63:5e45:: with SMTP id s66-v6mr9404432pgb.151.1533433593692;
        Sat, 04 Aug 2018 18:46:33 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h24-v6sm20875153pgj.10.2018.08.04.18.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 18:46:33 -0700 (PDT)
Date:   Sat, 4 Aug 2018 18:46:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: concurrent access to multiple local git repos is error prone
Message-ID: <20180805014631.GD258270@aiede.svl.corp.google.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alexander,

Alexander Mills wrote:
> On Sat, Aug 4, 2018 at 2:47 PM, Alexander Mills
> <alexander.d.mills@gmail.com> wrote:

>> I assume that access more than 1 git repo concurrently on a local
>> machine is not without errors. However this seems like a huge
>> limitation or design flaw.
>>
>> Is my observation correct? Are there any plans to remove this limitation?
[...]
> Note, in my first paragraph, I should have said "If I have multiple
> local git repos, and I run `git status -v` on them *concurrently*"...

There's no known limitation of this kind, no.  It sounds quite
strange, and I've never heard of anything like that before.  Do you
have more details?

Thanks and hope that helps,
Jonathan
