Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001EEC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 19:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjCWTi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjCWTiW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 15:38:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F4212B8
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:38:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso1937040wmb.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679600292;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4fUntdDfdu43BwrX55PNxy89TipgdW+N9xiJtJvMeY=;
        b=gpu/mre8RHgB4/xt/U8awwwY1utrj7pBmAFBpOTJcf5Slrxc163Q105tNu+PeGMHCQ
         hcOm0KppZ/dEQckEDQyUuOtT2lyDbs9bSKPmj6UgM+K2gHYBH92xaj+n/mGzzY/u809R
         Rs/tl78HYGOGyW7TlF0AAT/oOBrSHJN2CYixCAX5JkPGKSq9dwxRQzyYgEDDI9OISW+i
         tgS1K9L14xRGPRYgsUERbj5GMqvaY8JDa37/SZSXsjNu9L963/MNhEe83ajx92hAW+lI
         Dy2DOf7OBN2TIbfQt4V2hCv6T1oIiQxTZVs0tXTV5XKTJRReQ3O3I1dgi/n9IvY7Pdqz
         iu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600292;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4fUntdDfdu43BwrX55PNxy89TipgdW+N9xiJtJvMeY=;
        b=zmPV2iMUY0KzrhAzwcx3UK+bViikAdDfH1fdtev5xvXTqwFZnXiwusCV8l3PV2K4Sf
         pt4OadHi/y9w1WXiVs+vIgmn9xLyjdtK/zomFpG+P6B5oilEhiu6Vzw/2+LqHBvyWDvt
         nYIlwBnQf1s17gWBdSPqd2d7n8lt/be3rwmybLF2YCZXtkLEXUKWVxYMw5kEt67qoeEm
         l6lu4zzQjx2MYbuj4qjA6ZM7d+Ini8/zo41KmReMTOHRF8G6Rm4TIyoSBHnRTd1WWFFN
         +gVaqZmJ50GE8mCuN3YVHaRce6KXU52JcNS6dqHD2jpuFnUn6sHRlZgolrV4mwFfPvM1
         AJpA==
X-Gm-Message-State: AO0yUKV+ULvLuX7yCFSfcm4/J3JiAvE6q2O5xfJzDJA3kmeBcCk6VKfj
        3fgdaXOj9ChR77OQzMdbq1Eu6G50JLQ=
X-Google-Smtp-Source: AK7set+SLXPADXvG2191XOnpbX06KrR2gHi2vcMDL0+Aoi5ub+0W7zbOVC2S+5ieSVo3XtLEIIDeQQ==
X-Received: by 2002:a1c:6a13:0:b0:3ed:ec34:f1 with SMTP id f19-20020a1c6a13000000b003edec3400f1mr509106wmc.35.1679600292518;
        Thu, 23 Mar 2023 12:38:12 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id m5-20020a7bce05000000b003edff838723sm2796311wmc.3.2023.03.23.12.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:38:12 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b54f00c1-e8e3-67d7-0288-805ae18d7335@dunelm.org.uk>
Date:   Thu, 23 Mar 2023 19:38:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/8] sequencer refactoring
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
In-Reply-To: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

Thanks for working on this. I've only had time for a quick read of the 
first 7 patches but there are some worthwhile clean ups here and the 
series is well structured. I'll try and have a thorough look at the last 
patch but I'm going to be off line next week so it may take a while.

Best Wishes

Phillip

On 23/03/2023 16:22, Oswald Buddenhagen wrote:
> This is a preparatory series for the separately posted 'rebase --rewind' patch,
> but I think it has value in itself.
> 
> 
> Oswald Buddenhagen (8):
>    rebase: simplify code related to imply_merge()
>    rebase: move parse_opt_keep_empty() down
>    sequencer: pass around rebase action explicitly
>    sequencer: create enum for edit_todo_list() return value
>    rebase: preserve interactive todo file on checkout failure
>    sequencer: simplify allocation of result array in
>      todo_list_rearrange_squash()
>    sequencer: pass `onto` to complete_action() as object-id
>    rebase: improve resumption from incorrect initial todo list
> 
>   builtin/rebase.c              |  63 +++++++--------
>   builtin/revert.c              |   3 +-
>   rebase-interactive.c          |  36 ++++-----
>   rebase-interactive.h          |  27 ++++++-
>   sequencer.c                   | 139 +++++++++++++++++++---------------
>   sequencer.h                   |  15 ++--
>   t/t3404-rebase-interactive.sh |  34 ++++++++-
>   7 files changed, 196 insertions(+), 121 deletions(-)
> 
