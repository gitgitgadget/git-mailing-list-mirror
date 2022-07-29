Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F3BC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 12:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiG2M6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiG2M6v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 08:58:51 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AA1422F9
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:58:50 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id bb16so5679318oib.11
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8QSjys++NX41qfNGfoCdESmBhtykESPB03kPmHXHe2s=;
        b=VpPaqhJLJAozn1cQW1dIvaDjdNFblD5MAMMzdlVfxg/Ok9c9/aZzrHHLIliOh/j+e/
         kaUWI9qtbW4xVyMm7rELgdkL211N9fVqVz54i9Kqb1n/fGWLhXPKebdFR9s7TZMCUUVB
         ihFqCLuIDjbMeQ/8Vq/7Y8vTbz6GF92QBiODfDV+FtCBO8yRQykygq4iFhYAHBgBEEAW
         qH7yVBXevt8Zp6+fH8VX3vVELS9pjinIky1XnI1U5A+/1h0VeYglK1eTO3T8al/mvmJg
         8nLGeknkBRhSxWDUkdNK9D6RYAIqS2Clmd1GEAqhtWJ0Ex2FZ/lSX8bcUY8mqxnIAlJM
         4PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8QSjys++NX41qfNGfoCdESmBhtykESPB03kPmHXHe2s=;
        b=QOGnrCPu+UyJ9ejyXjAKxKB4BEigCSL2WxIETcxJqS87M6y1934IjEmnmqinWv3a/z
         F7O0f8TmUxQnJsZsY2BDX473nFUSPl6y1hqaaBWe919/Qwd0aTemg/wo8xGhLlbHeot7
         QQERCZGbciuxBkv6YW/pRBGLKDGDiEGwggRCQUCG5on+PuaWN28Ry0FFYDHe7OYSYu9H
         3xBW6014h0G1e8XvTkxqQUEXjdi3n7lwJQWHRs+rMBo0IazWvYbbgpDfQgMa5A+JetSS
         tLSmdjHDseuI5RjPf9u0wyh42LGSs8gtI9gq5AHKtDeASzUrD7MqO+JGNkbBJ1QkuN2K
         PYRg==
X-Gm-Message-State: AJIora9XW/kNdYmjYU3EUD2bxRyTHTXfhWyiOoFLlpBbMe9spAt58Apz
        j6dTUb/CphJN9q5Z7ndtpsWBStrpL5QE
X-Google-Smtp-Source: AGRyM1v6Qb9Zyxij2VGRp55GmoSnTlKvwkciCEXoaDaiIQZ43AXfN2Gy4Cs2nvRG9mzt9yjM7JaPNg==
X-Received: by 2002:a05:6808:2189:b0:33a:d513:143c with SMTP id be9-20020a056808218900b0033ad513143cmr1431565oib.233.1659099530208;
        Fri, 29 Jul 2022 05:58:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:994a:ecce:40c:c0b7? ([2600:1700:e72:80a0:994a:ecce:40c:c0b7])
        by smtp.gmail.com with ESMTPSA id m29-20020a056870059d00b00101bc3380a5sm1519671oap.12.2022.07.29.05.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 05:58:49 -0700 (PDT)
Message-ID: <985e4bb8-0cb1-3980-aaf7-bd3c793f7627@github.com>
Date:   Fri, 29 Jul 2022 08:58:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] ci: fix the FreeBSD build
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1308.git.1659097724.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/29/2022 8:28 AM, Johannes Schindelin via GitGitGadget wrote:
> Since 3a251bac0d1a (trace2: only include "fsync" events if we git_fsync(),
> 2022-07-18), the FreeBSD builds are failing in t5351.6. See
> https://cirrus-ci.com/task/4577761405698048 for an example. The run at
> https://cirrus-ci.com/task/6004115347079168 shows that this patch fixes the
> bug.

Thanks for noticing and fixing this bug. The FreeBSD build is slow
and flaky enough that I sometimes ignore its output before submitting
a series. Good that it will be green again.
 
> While verifying the fix on Windows, I noticed a recent, rather terrible
> performance regression: t5351 all of a sudden takes almost half an hour
> [https://github.com/git/git/runs/7398490747?check_suite_focus=true#step:5:171]
> to run on Windows. I found a fix, and it now passes in less than half a
> minute
> [https://github.com/gitgitgadget/git/runs/7578071365?check_suite_focus=true#step:5:125]
> again.

Thanks for speeding this up!

-Stolee
