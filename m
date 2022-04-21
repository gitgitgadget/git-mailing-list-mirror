Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7941DC4332F
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392234AbiDUULn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392227AbiDUULY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:11:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5434C7A3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:08:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so6171792plh.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:cc:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UOBcb24bxUsWoecRK7/gy8Gt6Pp7h4tkqnGBuZm/4OY=;
        b=U78v7PP0dlYr92j3aOxDTfDd3MB246geNDYzTwoVqzSP4MVvh7XzksxnutCFTHx2Ye
         L2wOOKPwzexVMP28rwwM9fw4JgdLYf7WyJaAUscYKv2hLw5zWhjI1VpiRqN73flCTRwV
         dEFcDS4SyVlIXj/cNRKqWqGMV9dpaT/wiUvNuk8YI4ZqLtNYzhBjlE1t588TvqCXHsje
         jF/NDL9/mRdxmHkU/9cMG99UnP4VR2ediBlrU2/1PraeGtbsQ+JcxVqn/m0e2RFX0Lz9
         gKZ2Y2xaZnDAYOzq7rBfpMcDx67YWoGEY5uLYePNFDcr/wenOztiZgJMGUAr2bRJp4ch
         osvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :cc:subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UOBcb24bxUsWoecRK7/gy8Gt6Pp7h4tkqnGBuZm/4OY=;
        b=GRgKajJ4MVxgRvuWGeTabPLggO93tFa1ashhAzUI+iJhzORlCrMlOYIOJChyRerOXq
         VrkA+D92zFgjO7kLm5PuVfyd5YzF/eErKvLfeYa2YP7Qckjus0/4fz84YEj+ootnLe2J
         qgnZSxT/LOx6nH9J3boK+a76bLNm2ifrF4tUNofZjY1bGqNQPDszAzd5wJNL9xA/3nou
         62FKuHIQzpBaVq1O4lLUAMVP1J4RnT7NIUEVdLf0vCxBYoybnsT7EYwwGa1caQ+7f/zX
         rHMbLl+y2C7Xg4Pm0Cm1K27UY8Xmm1eOoVD+ySN9jHU/VIizxZyNad5I9byvcUqLLkMO
         QdzA==
X-Gm-Message-State: AOAM532mmBMvyv7+HwSPBLPYr52+Wxnal4b1TdFFiQmu0vgj1XpAVeLi
        RWAfMAS+nQBJ3Yy9lnSjJE4=
X-Google-Smtp-Source: ABdhPJxCH2nrcgpegDPkrvlOr/bBT2zhpN36Pg/7uhggp18cE5Yr72vRG//BoNBVHsbKjeyUERRAwg==
X-Received: by 2002:a17:903:204:b0:15a:35be:58b3 with SMTP id r4-20020a170903020400b0015a35be58b3mr879181plh.123.1650571713187;
        Thu, 21 Apr 2022 13:08:33 -0700 (PDT)
Received: from ?IPV6:2001:4898:d8:33:9044:3a76:d2d:7ec4? ([2001:4898:80e8:2:1065:3a76:d2d:7ec4])
        by smtp.gmail.com with ESMTPSA id b24-20020a17090a991800b001cd4989ff44sm3449590pjp.11.2022.04.21.13.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 13:08:32 -0700 (PDT)
Message-ID: <51a685bf-3cd1-b573-535c-e18b2f987d66@gmail.com>
Date:   Thu, 21 Apr 2022 13:08:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: neerajsi@microsoft.com
Cc:     nksingh85@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Git bug report - disk errors on Windows after push
Content-Language: en-US
To:     Attila Csosz <csosza@designsoftware.com>, neerajsi@microsoft.com
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
 <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
 <fa40a6e6-dd83-9e88-e2f7-ab8aff2ca5a4@designsoftware.com>
 <04a50f96-363f-210f-b894-11945d0eb3e8@gmail.com>
 <CAMYm8FoA55JwXezckJxMPXGLh2+osCwsHHrg_MSjLMqG2emygQ@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
In-Reply-To: <CAMYm8FoA55JwXezckJxMPXGLh2+osCwsHHrg_MSjLMqG2emygQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2022 7:29 PM, Attila Csosz wrote:
> Please check this link also
> https://github.community/t/what-could-be-the-reason-my-git-repositories-keep-getting-corrupted-broken/184711
> 
> You can found many link on web on 'git corrupted repository'. In my
> opinion when a git repository is corrupted on Windows there is a good
> chance to HDD errors.
> 
> I suggest also run intensive test on Windows (run a bat file commiting
> and pushing to a bare directory type repository). Check your HDD
> healthy status after 10-20 run of 'git push'.
> 
> My git software is come form 'git-scm.com' and I'm using TortoiseGit.
> My git software is up to date.
> Last time my laptop HDD is crashed loosing sensitive datas. I will
> never push to a local repo I'm using online repo-s like github.
> 

Do you currently have a drive in the bad state? Is write-caching enabled 
for the drive 
(https://docs.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/turn-disk-write-caching-on-off)?

Git hammers the filesystem in a way that's not typically done for a USB 
drive (especially issuing some "FlushFileBuffers" calls).  So it 
possibly exposes some inherent flakiness in your setup. For instance, 
your drives might be good, but something could be wrong with your USB 
cable or the power supply.

If you have a drive in the bad state, a "chkdsk /scan /X <drive letter>" 
might give some hints about what specifically is wrong with that filesystem.

I'd recommend preferring a cloud-based backup system for your Git repos 
(e.g. GitHub or GitLab).  Also, for local backups, something solid-state 
like an SSD might be more reliable in the long run.

Thanks,
Neeraj
