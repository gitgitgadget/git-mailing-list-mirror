Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EA0C54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 20:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjAJUHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 15:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjAJUGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 15:06:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4712AE5
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 12:06:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id az7so12966696wrb.5
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 12:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqPkg7LQeUDBmiIrG6LXwX3sAmtHTsuUQkyNPP6aEmA=;
        b=WWSdSgwD+Et4dNXtfgTMfXRtJrQzbF3M2MrZ24yFBzIf+wjqi2f4ypPyFajJeYHDx3
         3bmZ24hc06PwMeXnT69tUkpmBUBgrNWIo/Kis5A9/f2+Tqsas05dmpiWOahwsHGnzwJk
         i5LXO9CyFFDB0zw9SWnyBukN6kuGzHV6bsGZ++o0tMFNaJQSWkEyohBeN2/5hjd2G9D/
         eWOgFdu8SoUbPXFoDrkDI3XFkwfvYrmfP9z7NKMEZtL+nTSswZwo4uK3qhmG1ZzSRZrd
         2OdmIPD9h6N7nt9Xug+qHtK2eJjVDXDbWicd3uK1lIAjMbIKe7guTZA8M4P0lmB3ax+w
         OrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqPkg7LQeUDBmiIrG6LXwX3sAmtHTsuUQkyNPP6aEmA=;
        b=7oWCqaY2tGkRdk4ayHK2O3kN/gEOZ3xIJQswQ/mXcrsqWzrXN4kvmK8nac83tyWqOX
         6oPeEY2ZX63Q0WKUMVIeVCxiQLB+pWdf4KfcxbpoRn4YhukFZyd3C6Wi5vCZOBFMMoB8
         FXWolEaPIosPHfVjLnoL4XbzmrY94gbMBIpP7EjExK5rLHCMuZbwf1m13d6/3cutF2jB
         14XbE7a0Es+T+tc19PBznkcy8L3cE3qMCVY7o5ey/+eJzjC+w3a24LD/dlUxvHyfIZhj
         MDMJzKcmVDX6p0r2QWiEk/z0421vhgplO3jdrzxeTlfR+oO3+wDKb4qgdyhEy1GytA8H
         K8SQ==
X-Gm-Message-State: AFqh2kpgqMek0hzY9Eh9Zd3i79RJUKZJeBQzbO5+C5HyiJvCDE0O+zg2
        2Sju6/LXdvCQwaBZGSM5ZHb8J6a7hEs=
X-Google-Smtp-Source: AMrXdXtag6MEPtLoq5kYMuC+T0+DmCvHlcSWFa32osy2uYtGJbQl9UODXBexlzvrJojNk7zcFtLKzA==
X-Received: by 2002:a5d:6b85:0:b0:283:20fe:aba6 with SMTP id n5-20020a5d6b85000000b0028320feaba6mr32086101wrx.46.1673381203366;
        Tue, 10 Jan 2023 12:06:43 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm2753015wrr.26.2023.01.10.12.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 12:06:42 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <ba20039c-19a3-96da-c938-89af67bca791@dunelm.org.uk>
Date:   Tue, 10 Jan 2023 20:06:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/5] Documentation: updates and a correction around
 'ORIG_HEAD'
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
 <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe

On 10/01/2023 13:15, Philippe Blain via GitGitGadget wrote:
>   * added a link to the mailing list thread in the commit message of 5/5.
> 
> v1: Documentation: updates and a correction around 'ORIG_HEAD'
> 
> This series' initial motivation was to clear up a confusion that arose in
> [1] where it was noticed that 'ORIG_HEAD' is not guaranteed to point to the
> original branch tip at the end of the rebase if 'git reset' is used during
> the rebase.
> 
> Patch 5/5 adds a note to 'git rebase's documentation to make that explicit.
> When taking a look at the existing documentation mentioning 'ORIG_HEAD', I
> also found an error in an example (patch 1/5), other small inconsistencies
> (patch 2-3/5), and a potential improvement (patch 4/5).

Thanks for doing this, I think the adding a note to the rebase 
documentation is a good idea given the confusion that's been reported. 
The patches all look great to me apart from patch 4 where I share 
Junio's concerns about the readability and maintenance burden of the 
list of commands. I was surprised to learn that merge also sets 
ORIG_HEAD, thanks for being so thorough.

Best Wishes

Phillip

> Cheers,
> 
> Philippe.
> 
> [1]
> https://lore.kernel.org/git/1b2b8e98-5506-a1e6-6059-a967757b3bb8@gmail.com/T/#m827179c5adcfb504d67f76d03c8e6942b55e5ed0
> 
> Philippe Blain (5):
>    git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
>    git-reset.txt: mention 'ORIG_HEAD' in the Description
>    git-merge.txt: mention 'ORIG_HEAD' in the Description
>    revisions.txt: be explicit about commands writing 'ORIG_HEAD'
>    git-rebase.txt: add a note about 'ORIG_HEAD' being overwritten
> 
>   Documentation/git-cherry-pick.txt | 2 +-
>   Documentation/git-merge.txt       | 3 ++-
>   Documentation/git-rebase.txt      | 7 +++++++
>   Documentation/git-reset.txt       | 3 ++-
>   Documentation/revisions.txt       | 3 ++-
>   5 files changed, 14 insertions(+), 4 deletions(-)
> 
> 
> base-commit: 4dbebc36b0893f5094668ddea077d0e235560b16
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1456%2Fphil-blain%2Fdoc-orig-head-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1456/phil-blain/doc-orig-head-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1456
> 
> Range-diff vs v1:
> 
>   1:  74b2d5a9144 = 1:  74b2d5a9144 git-cherry-pick.txt: do not use 'ORIG_HEAD' in example
>   2:  f25c71fd4c3 = 2:  f25c71fd4c3 git-reset.txt: mention 'ORIG_HEAD' in the Description
>   3:  e488ad3ce1d = 3:  e488ad3ce1d git-merge.txt: mention 'ORIG_HEAD' in the Description
>   4:  302b789a486 = 4:  302b789a486 revisions.txt: be explicit about commands writing 'ORIG_HEAD'
>   5:  9ef427a9a2a ! 5:  7eed8f35376 git-rebase.txt: add a note about 'ORIG_HEAD' being overwritten
>       @@ Commit message
>        
>            Indeed, using other commands that write 'ORIG_HEAD' during the rebase,
>            like splitting a commit using 'git reset HEAD^', will lead to 'ORIG_HEAD'
>       -    being overwritten.
>       +    being overwritten. This causes confusion for some users [1].
>        
>            Add a note about that in the 'Description' section, and mention the more
>            robust alternative of using the branch's reflog.
>        
>       +    [1] https://lore.kernel.org/git/28ebf03b-e8bb-3769-556b-c9db17e43dbb@gmail.com/T/#m827179c5adcfb504d67f76d03c8e6942b55e5ed0
>       +
>            Reported-by: Erik Cervin Edin <erik@cervined.in>
>            Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>        
> 
