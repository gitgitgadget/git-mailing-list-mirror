Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE7C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 12:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D8461077
	for <git@archiver.kernel.org>; Mon,  3 May 2021 12:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhECMGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbhECMGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 08:06:07 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466AC06138D
        for <git@vger.kernel.org>; Mon,  3 May 2021 05:05:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id j19so538310qtp.7
        for <git@vger.kernel.org>; Mon, 03 May 2021 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3BzWnO/bR1wHxLNCVzogkFhrZtq5oGAQSc6zRlCRDUw=;
        b=kRMxirgH+R8AcDgvQE2xViRNCDJdiV0rJ/TRYIuqFsGts648W4kSMmIMohVk+bEHrW
         to8TBuD0boKWCX+6uZwJlwyIY8sOb++oGAs+Y/f4g3efOS8iEayxfuZ0Xj2VZ2Z6XJRx
         kTcjxlEqYseNv0JDLKnZXxMA0X6fDiA6iydibaLRnrU/cvr7TP9St5fj8xNQpO4d8qzt
         VmcWkXqgpRzjYpQjqf7/yshR28sx58LbrpGMz/h//TZxJ+yDqDirAxyzJMv4LDecqznG
         iD3w/WZ7YfiIrjI7r7RP+8/Vim0WVjNkzEhk5PiCLpVXOgNgcoECqPpXgfaZqkG1cScg
         4kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3BzWnO/bR1wHxLNCVzogkFhrZtq5oGAQSc6zRlCRDUw=;
        b=dKA3FCD959jyJqah3dAwRgpNSsic6BcOnWpsUHdPs29CwaM8WEU7VTgSAEN37cl5zr
         eFpmzRfCmDwhkZ74JRYEqdYXrS0ZrhfbvArUCyIiWtPO2o/Mhu/Cf6wXNlKir6A0sQCw
         qHcaVgjZ49TskVai4SZC8aSxibQicciIW9fdd6CB8o9uTesQ3Vj0Xxf9uE6eimNXhZMq
         MmxPrfdhZob4UxZzpuCfMkluUmpc4ySXQV6p5njLThHvU0MRQIFz7SBkeVDWMNCxGuE8
         GebyEym0WbnV0r2gGv4RBJHEKLawVApVnFQd0Dl+Y189nOnnZu/jRKwnIw9IDBXj1fPv
         E/OQ==
X-Gm-Message-State: AOAM531kWfiLFoDL+SRib9p8O1W1qJxAGTIU9Bi+aW4Yt9ZanLb9s0Hc
        rnTL3RfpuScO6OkLKaKSpAkSQbRQLpBx0w==
X-Google-Smtp-Source: ABdhPJxgqlvxbf9wiVYI4rbdj4I3eoI3BxNYvAsK3iVtRebbmK8H5eJGJdKjzQyCHKRSml+PeFfnIg==
X-Received: by 2002:ac8:5649:: with SMTP id 9mr6799848qtt.148.1620043503616;
        Mon, 03 May 2021 05:05:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e8cc:2a25:fb4:a65b? ([2600:1700:e72:80a0:e8cc:2a25:fb4:a65b])
        by smtp.gmail.com with ESMTPSA id g1sm8324260qth.69.2021.05.03.05.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 05:05:03 -0700 (PDT)
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <faed7793-a011-748f-d5c5-2dc00d0fe52c@gmail.com>
Date:   Mon, 3 May 2021 08:04:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210501145220.2082670-1-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2021 10:52 AM, Lénaïc Huard wrote:
> The existing mechanism for scheduling background maintenance is done
> through cron. On Linux systems managed by systemd, systemd provides an
> alternative to schedule recurring tasks: systemd timers.
> 
> The main motivations to implement systemd timers in addition to cron
> are:
...

Thank you for working on this. Users have questioned "why cron?"
since the release of background maintenance, so I appreciate you
taking the time to port this feature to systemd.

I won't do a deep code review here since that seems to already be
covered, and a v2 seems required. Ensuring that users can choose
which of the two backends is a good idea. We might even want to
start with 'cron' as the default and 'systemd' as an opt-in.

The other concern I wanted to discuss was the upgrade scenario.
If users have already enabled background maintenance with the
cron backend, how can we help users disable the cron backend
before they upgrade to the systemd version? I imagine that we
should disable cron when enabling systemd, using
crontab_update_schedule() with run_maintenance given as 0.
We might want to enable quiet errors in that method for the
case that cron does not exist.

It is important to make it clear that we only accept one
scheduler at a time, since they would be competing to run
'git for-each-repo' over the same list of repos. A single user
cannot schedule some repositories in 'cron' and another set in
'systemd'. This seems like an acceptable technical limitation.

Thanks, and I look forward to your v2!
-Stolee
