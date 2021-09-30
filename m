Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6006C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE183619E7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351671AbhI3OCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351630AbhI3OCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:02:33 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44287C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:00:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so10300441wri.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M1J3Jh0FkU7U3Tx1DXuR1DOO6B0WH8kLVznTB7mp6lg=;
        b=f8F/q28YaYmPYf2wviqRdf8sbTsZ39rF0L+Hfea+71iZV0Pu2u5QoKB9IrzGs3zD1N
         x07gecf0HGuhwEfKz+uXLaF7OC/kTawKHGlgY5zQZBQavPAxV/GQ0MmXasR4CCuZcJVr
         N8vzrf4jhfoucSov6OP3qFV+uNncq6Da/AWYsvcVxqGWelfI07R7brNVA7jKyEJp1Gkk
         d/ilvQAISjaEwER/VzEFK3bdv6A6QkN/Fy9E3pT/cjkIja7zEB/NSuBJDR3P0Ps0TCBA
         xR9gJoYK1wnxYoE42uhkfhfxRte4sd4ckPgEzix30sFhmuYUNWHK8Mzq7kLbRvwRce7w
         17RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M1J3Jh0FkU7U3Tx1DXuR1DOO6B0WH8kLVznTB7mp6lg=;
        b=ZeKIL58CnUp/zp6vWMuHejDw5+UROxty3Hoojrp8bdEZt88xnGRz/4Tnc0RonTJ911
         sJNn6tAJXNlNf2yftiZWkocMEedykbQSlFEt/GoyyNLjfurRga1KyLRDQg23VMxV3qPF
         wNvta/WLPdDgU5XsUGDAobw2Ny6kUqT5ZhcjsBN2AA8AB4J6qefbdlgwGb4ZNHo849Xv
         +m3tm8G25QElOtUYJK70C5FoQtEl5YJN3ms2wgF3CfboapCIl1N2hm6YqTIBOQuLQT27
         PtPS/ei/oMmOjjbvUqMeiwt7GLc8fXxc27L3FXuK4bakTt5rX41PhpmGIZaTuOB7+7xU
         10yA==
X-Gm-Message-State: AOAM532MpWd3RshtodztEWJjyQjlLUI6USR3uu2M/8x9XIm7uDNJCEl+
        rehJRHLzZIY9hw7KmkBfddY=
X-Google-Smtp-Source: ABdhPJxOpqti5agEwPtAmqW1ASPA2lVWNq9AIesY8RK+JVfcCDbTTtHJsjWBMuhc6QxQwaULt9lyUw==
X-Received: by 2002:a5d:6292:: with SMTP id k18mr6436339wru.110.1633010449876;
        Thu, 30 Sep 2021 07:00:49 -0700 (PDT)
Received: from [192.168.1.240] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.gmail.com with ESMTPSA id c18sm3055960wmb.27.2021.09.30.07.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 07:00:49 -0700 (PDT)
Message-ID: <b23bb983-39e6-75ad-0cb5-d9a5ba2cd4d8@gmail.com>
Date:   Thu, 30 Sep 2021 15:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/11] Fix various issues around removal of untracked
 files/directories
Content-Language: en-GB-large
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Resending as it did not seem to get through to the list last time]

Hi Elijah

On 27/09/2021 17:33, Elijah Newren via GitGitGadget wrote:
> We have multiple codepaths that delete untracked files/directories but
> shouldn't. There are also some codepaths where we delete untracked
> files/directories intentionally (based on mailing list discussion), but
> where that intent is not documented. We also have some codepaths that
> preserve ignored files, which shouldn't. Fix the documentation, add several
> new (mostly failing) testcases, fix some of the new testcases, and add
> comments about some potential remaining problems. (I found these as a
> side-effect of looking at [1], though [2] pointed out one explicitly while I
> was working on it.)
> 
> Note that I'm using Junio's declaration about checkout -f and reset --hard
> (and also presuming that since read-tree --reset is porcelain that its
> behavior should be left alone)[3] in this series.

I've had a read through and I don't have any specific comments, I like 
the way you have simplified adding the standard excludes for callers and 
making the existing value of reset invalid when converting to an enum. I 
think there is a small risk someone will complain about read-tree 
changing how it handles ignored files, but hopefully everyone was just 
passing ".gitignore" to --exclude-per-directory and they wont mind 
'read-tree -m -u' removing ignored files now.

Best Wishes

Phillip
