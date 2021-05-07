Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2FC433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 16:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD39B61458
	for <git@archiver.kernel.org>; Fri,  7 May 2021 16:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbhEGQ2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbhEGQ2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 12:28:11 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41488C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 09:27:10 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id i67so9018619qkc.4
        for <git@vger.kernel.org>; Fri, 07 May 2021 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4e3sjA9zg1iorNd5Mn8kmpEovSeLvuJsK/h2sEjfrqM=;
        b=OJAfvx6OQnkluIZ7adCSCB5ln8Yb5f1MSKHpBf3okf5KBADYXsyWpS6pQpMMa06jbs
         5o3eh02n24IdrMD0GREzSQR8mQVF/Ofjk82lHNlgd6K+qNepILHCUdpG49/hDUPZi9n5
         URkrWY/SkX80a5jchYnrY6cwRSQSSB0elCqOMa5BDrKNljO6l/BXg/KhPfmQpe/heH0Z
         oDz09PibZPTDWZI9wabf9z2VwJ4h5O4yvrIQuQ0q7ABhNpo6OiSKGkF92lUTGUmfACAj
         k6i4AxmGYpir8wdIunZLiDL2QicZoHSbeSUZnAyR491ydKoMn62cygzHcBCPXBrz8NaY
         cvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4e3sjA9zg1iorNd5Mn8kmpEovSeLvuJsK/h2sEjfrqM=;
        b=LLKGL5z0gbRzK3/XwzplkOpyirt0joB8bkIoeapfC5vl5s/E3VlUIuyJgyQQd4Iojd
         66C9TIZ5IqGLcao21aIGwU6a86lNjhEa5RfA49qtC4Xz0AG2kZQQHjtAjylX0wET6Lnw
         CaNJqa3SI40DXlcge7BRlBHmK1LmC9+5F3f1Ffw+0Nlz476W57YM4DChhW44fCXsPEPn
         HA+fYeiIbQvMJFTiSIx3A0cAljXem8Bkl9pk9NQ6nrE707sVTBqn6N8R9CsdDqjavXHd
         ueheZHSLYeW+CAMa8rqTolQ0JE5iJc7MR4SzXRYGje9muIL8Oco1Hp9cB5BIIExlBf/v
         5ccw==
X-Gm-Message-State: AOAM530tQkC8ZDvPpx2z/due0lmXllRTtONW1OuLwC0eS1BrYWh03qaM
        mw48HMXCnf05e6gHiTPm1rlHSEnotE9wdg==
X-Google-Smtp-Source: ABdhPJzJEa4HGq/wmMQ2N+LpSjP9pJLQMjSQ55qBdbvJNu2vRpSrvDwCwMJc5/pNHWjKy7YlyyxhXw==
X-Received: by 2002:a37:ba83:: with SMTP id k125mr10245574qkf.336.1620404829411;
        Fri, 07 May 2021 09:27:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:10d2:8815:444d:57fb? ([2600:1700:e72:80a0:10d2:8815:444d:57fb])
        by smtp.gmail.com with ESMTPSA id m4sm5668419qtg.21.2021.05.07.09.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 09:27:09 -0700 (PDT)
Subject: Re: [PATCH 0/5] Directory traversal fixes
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f99d7cd9-5e27-b5de-12fc-0a42be2d14ec@gmail.com>
Date:   Fri, 7 May 2021 12:27:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/7/2021 12:04 AM, Elijah Newren via GitGitGadget wrote:
> This patchset fixes a few directory traversal issues, where fill_directory()
> would traverse into directories that it shouldn't and not traverse into
> directories that it should. One of these issues was reported recently on
> this list[1], another was found at $DAYJOB.
> 
> The fifth patch might have backward compatibility implications, but is easy
> to review. Even if the logic in dir.c makes your eyes glaze over, at least
> take a look at the fifth patch.
> 
> Also, if anyone has any ideas about a better place to put the "Some
> sidenotes" from the third commit message rather than keeping them in a
> random commit message, that might be helpful too.

As for your patches themselves, I can't claim to understand all the
complicated details about how treat_directory() is working, but your
patches are well organized and the new tests are the real proof that
this is working as intended.

Thanks for the attention to detail here.

-Stolee
