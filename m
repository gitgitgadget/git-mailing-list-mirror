Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365F2C433EF
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 15:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiFKPYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jun 2022 11:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbiFKPYS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jun 2022 11:24:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090DE222B9
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 08:24:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so4848935pjl.4
        for <git@vger.kernel.org>; Sat, 11 Jun 2022 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=1wxLQT/4ce688HpXHwyg0V+XIKWtgnGeb37LkfOf4t8=;
        b=UQWWtpuECFJU6B2LPuIl0vxRVpeiCRfTN4ZS6os7tapP1qzoNviFI1hKV+IbgyGyVT
         d5ZqFlEITmu+AEYyLKvUn+27+V7MIOz6a1pHUwAmVlQx5BsS4kION0+auufY1BCOYD2s
         y3tV+jmIgXqD65A2Mh/3fqhq3Soxtg3l5ocz9uL9GUcmAVxtVk23lsGMiM2x4+WKwNZG
         513k9C5nRWrc1qQ+E3wOlHupkqa7CnZLv8QyKK9FtVArw+Z1ElxeVM+meeS6xQt7aisO
         g15lbWHt0gsZMKtU/ZyNc8uZXLVgwJaS2Sf9PRenRCIQpwMoTKsLbJQKX2FTfWWSN6de
         m1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=1wxLQT/4ce688HpXHwyg0V+XIKWtgnGeb37LkfOf4t8=;
        b=fulgWcovnt7CNkEgODhxeja7G0WNBSfyf3RaZnvsdD9CLZtcWXufk7QcpJ4TUmsPiI
         J6gv4R95jX0LZ3lHXjnpPttRkCB1qjpmY15s1lDe43indx7fCL94UuBKmCxBHvM6bsPp
         tTx7wS7BvokxFszHFMkJdrnRyoXU7c1zklcOE92nEtDW4Z0K56I9w9NKxtxSCYwzpAAP
         vBgmAijXymaPmtPSI6B6ic7OpTeFVQN6/TYq3t8WokJCQxmHqNFdsdSvXImcdposOQS1
         GwfbUFWHeH5dbov5xlDBxIn/1ME7AnU3U3V7aJgaUWdKGyMyStCxaavlHMoJCSMthpat
         8cPQ==
X-Gm-Message-State: AOAM533JkY4apEISoXliVCwVmh2lTdcpPWCyFHCvrROVjW19LTxQ+mKJ
        0JP0ytpSBJt8RJUsbxhIDCtkygc3yd6zWg==
X-Google-Smtp-Source: ABdhPJzzEXDiMG+QGXX6dS9f5GxfGEYFUzkLozXvYIAPFwKYk3E4NaNsbWV3nw0pEGhi4IOSHrorMw==
X-Received: by 2002:a17:902:eb85:b0:167:987e:2686 with SMTP id q5-20020a170902eb8500b00167987e2686mr23249964plg.33.1654961056098;
        Sat, 11 Jun 2022 08:24:16 -0700 (PDT)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id v17-20020a170902d09100b0016168e90f2csm1658797plv.208.2022.06.11.08.24.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 08:24:15 -0700 (PDT)
Message-ID: <17d6ae9a-b376-c833-9106-26616e1d193b@gmail.com>
Date:   Sat, 11 Jun 2022 20:54:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: [GSoC] Update about Blog
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git community,

I am Jaydeep Das and my proposal[1] got accepted in GSoC(almost been 3 weeks now).
I am already in contact with my mentors Christian and Hariom. So, I will be posting weekly blogs
regarding my progress and difficulties here[2]. I have already posted 2 blogs and I am actually a bit
behind the schedule on blog posting the 3rd blog.

In the last blog, I tried to understand(and explain) the basic working of git-for-each-ref. Although, it was
difficult to grasp at first, Hariom's blog[3] was of great help.

Currently, I am going through pretty.c trying to understand it little bit. Mostly be trying to eliminate duplicate/
redundant code.

[1]: https://docs.google.com/document/d/1qq-Xze6dMGMSx3rPHD0VEc4f0a87KnHgbka1Dzpf8sc/edit
[2]: https://jdeepd.github.io/posts/
[3]: https://harry-hov.github.io/blogs/posts/week2-whats-the-difference

Thanks,
Jaydeep
