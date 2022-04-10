Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02FC433EF
	for <git@archiver.kernel.org>; Sun, 10 Apr 2022 18:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiDJSXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Apr 2022 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiDJSXn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Apr 2022 14:23:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8C22536
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 11:21:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ll10so4700098pjb.5
        for <git@vger.kernel.org>; Sun, 10 Apr 2022 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=HhZurzBRFvvXxLNNKyoBPPddrL0c1Xu/R0+h/EG3mBY=;
        b=I1YlgM/Yw7JYX3GolhtLul+sRHIVGSFicuXVsMWE9bLP5qBkLmDcypyHB5zC2eOS/4
         8V07nDBPquv67fVPFgNb4vDc1Jb4Ac98c65EKYJejc84SlGAAX1BSsJcrc4xfCuZ7uao
         0HWMEvNR9y4DXp1z/uRAQzO6NrhNueC9VfXFGnEIUZhAlA4/Baze/WjQsD7NR6RM7sUb
         NN6DIYhS/t6SMEGieYEe0V17ahfHWOlzN8E5KRtLTl/jP+gOUAN9urtVD5R2UaOc9fea
         uAiHWkx+51b53amPuHZqfKQ6oIuv6wgqBlWwVPP9ZT8C/zuDwkkwvQXeVVw5948hA4co
         hkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=HhZurzBRFvvXxLNNKyoBPPddrL0c1Xu/R0+h/EG3mBY=;
        b=3yAAZ/UKNVn2EgeFni0Vmlkpdg8xDnVshd+0DGYpcV3dKR6EB3Whni09fw0MOs6ISJ
         tVyNF2flwXjImdc31g7tr7MrNLswb5iCDy8rVaEyzV4eQkzP1MOOQUYSLuOLi47owNgR
         m46/Hy5hAgkm9IAlhKNsZ1iSRnUsHKxj3RpMr0WzmkGfek2A1DvRyux4skCDJazowUxz
         MhD/XbcvIYoleBmjpSYtDEKZwL9y25BCOuxxIkWNuYpA1oY1HDjBzjFyQuWl6rFfWxDQ
         BYlQ1rm0+W9Kj5Td5RhGHQU58eTUDixzyTviiVMLPBBLY4K00pUJ5chPV0OXpPn7rzwe
         cFGQ==
X-Gm-Message-State: AOAM532rFjTSkbrdKUybNSkGx+FBWcfYTVjx7dAOufXAEEW9APhuW0eH
        w0rK0QTKThBl8WPA02BlG++eErZbAG0aHw==
X-Google-Smtp-Source: ABdhPJwknO8bTRMwUR9BYlyo9eQx8jJHQZryieer0iq4hux1+P351uL12fZfSO2i+5c7VZta5/8ZYw==
X-Received: by 2002:a17:903:24c:b0:156:cc13:bfca with SMTP id j12-20020a170903024c00b00156cc13bfcamr29359905plh.114.1649614891582;
        Sun, 10 Apr 2022 11:21:31 -0700 (PDT)
Received: from [192.168.208.37] ([49.204.120.113])
        by smtp.gmail.com with ESMTPSA id o3-20020a056a0015c300b004fb24adc4b8sm32529541pfu.159.2022.04.10.11.21.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 11:21:31 -0700 (PDT)
Message-ID: <3ce82619-6305-69b6-b4e5-bbbc91c17530@gmail.com>
Date:   Sun, 10 Apr 2022 23:51:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Git Community <git@vger.kernel.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Issue when using the fsmonitor-watchman hook?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I recently installed v2.36.0-rc1 and started getting the warning about
the deprecation of core.useBuiltinFSMonitor configuration. It appeared
for each 'git' invocation which was a bit annoying. Fortunately, I had
some spare time so I went the route of actually applying the suggested
alternative rather than suppressing the warning.

According to the git-hooks documentation, I configured core.fsmonitor
to '.git/hooks/fsmonitor-watchman' and after that for some reason all
the styles in the terminal seems to have gone awry (I use Windows
Terminal with PowerShell 7). A sample demonstration.

This is how the terminal should've looked (it appears with appropriate 
colours):

   04-10 23:36:38 D:\Source\kaartic\git [(f2817c1...) +2 ~0 -0 !]
 >

After setting the config the following is how it got rendered (without 
colours):

←[95m04-10 23:36:20 ←[0mD:\Source\kaartic\the-wallet 
←[93m[←[0m←[96mmaster←[0m←[96m ≡←[0m←[31m←[49m +1←[0m←[31m←[49m 
~0←[0m←[31m←[49m -0←[0m←[31m !←[0m←[93m]←[0m
 > cd ..\git\

I should note that I use posh-git [2] plug-in for the colourized
Git metadata info in the terminal.

Also, I got the following error messages when running 'git status'

 > git status
open2: exec of watchman -j --no-pretty failed: No such file or directory 
at .git/hooks/fsmonitor-watchman line 78.
Unsupported query-fsmonitor hook version '1'.
Falling back to scanning...
On branch master
Your branch is up to date with 'origin/master'.

...


It's clear that I'm doing something wrong. I'm not sure what, though.
The fact that I have no clear idea about what the fsmonitor-watchman
hook does, does not help at all. It would be great if someone could
help me understand what I got wrong :)


[1]: https://git-scm.com/docs/githooks#_fsmonitor_watchman
[2]: https://github.com/dahlbyk/posh-git

-- 
Sivaraam
