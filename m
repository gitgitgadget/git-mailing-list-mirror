Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4DBC00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 13:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbiHXNVY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 09:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbiHXNVW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 09:21:22 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F7C6112B
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 06:21:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b2so12593589qkh.12
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=ORz8jTJRQqDJ7/e7bMrIDGgvffJpiz3IkyXf88ZHSpI=;
        b=YAbesPRPkocuc9JARQYDBZrwOhxodVBX7JrevmVaDYfRSiuR/EKLR8HkX/fgeDF+pt
         RyzpYxwRFy6napH7HAyGpVg+m+0eDPmI0ACHx/leCRUxZFp4FA+nvgQLh7ojLk46qgTf
         11EtXj4ECgeZov6/+I8O3PW6aPMxyREsdAHtYETybdfasFuKu2O+XROoCQP5TRLGI1QK
         DXvDKstY9GdgvspW94bBzVTWhNcDU2syBEzFR1Lo9UHI5ASc2dkgwDwcDXLVE9Q5nHpq
         NtPqNY/FbYlqCfCbMcwvz0NsI284t6g3XzOBBkadq8YQh70kAAGbqhDYsGe0brsmexI8
         EPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=ORz8jTJRQqDJ7/e7bMrIDGgvffJpiz3IkyXf88ZHSpI=;
        b=0CuezJWhY4PFPDjYN6Jq625lWvC4pk0EpB39FLUvldHUin4Wwgs9CPdo+K9luuUBO+
         zgIIqGtphmseRytGSODnZMgJ7Id1HAKr49zabYQcCvPFxk97aPv+aTc1CbUKHzvuMkKt
         hoRF4VPAP63nP0aVbPfHNCEPmUWdKT8/sZKmWzLNwTE1UcUihhpb71l3zNsgkeolytRw
         XnUfh9G0VAQVAurXgaD9UwcfRISyeuy77grQtIeAh11tidl+kZy84xA/sYxzOkBotICI
         MYjdsRDeKlIJi4e9H+JmNDgHnxHsAoaYmWVEc3+eJIp1LGDcmTPgGeVF3tRmp0nsWLox
         rHOQ==
X-Gm-Message-State: ACgBeo2kLgT89QRnIPhphQpFc3Hxd7Dy5u5FR6XfTijK7B1O6qdlAhSc
        2b4x2vfPjnvq+6qliLOrX7H1/pwnSak=
X-Google-Smtp-Source: AA6agR4+mp2o5bzhzG8ITv9oLlWnJI5WsIrlVoXL+VXD2TqRWOGhbVxJYrdsTkdPNWbeawf0jGQKcQ==
X-Received: by 2002:ae9:e914:0:b0:6bb:a11f:ea31 with SMTP id x20-20020ae9e914000000b006bba11fea31mr19004980qkf.647.1661347279573;
        Wed, 24 Aug 2022 06:21:19 -0700 (PDT)
Received: from [192.168.1.128] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id h4-20020ac87764000000b0034355a352d1sm12489090qtu.92.2022.08.24.06.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:21:19 -0700 (PDT)
Subject: Re: [PATCH 0/3] built-in add -p: support diff-so-fancy better
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
 <ab012782-1d02-b90b-9a4a-179ecc3f8e9e@gmail.com>
 <1r3pq48q-s728-8r2r-r4q3-72413r5483o1@tzk.qr>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <41781ceb-bfad-2534-2970-c74618c93f2a@gmail.com>
Date:   Wed, 24 Aug 2022 09:21:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1r3pq48q-s728-8r2r-r4q3-72413r5483o1@tzk.qr>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Le 2022-08-24 à 02:27, Johannes Schindelin a écrit :
> Hi Philippe,
> 
> On Tue, 23 Aug 2022, Philippe Blain wrote:
> 
>> However, I've tried it on a more "real-life" example, and then I get:
>>
>>     error: mismatched output from interactive.diffFilter
>>     hint: Your filter must maintain a one-to-one correspondence
>>     hint: between its input and output lines.
>>
>> This is despite using "diff-so-fancy --patch" as interactive.diffFilter, which should
>> keep the number of lines the same.
> 
> Would you mind sharing the example with me?
> 
> Thanks,
> Dscho

In trying to write a reproducer, I realize that this is in fact a separate "bug".
I happened to have a submodule in the repository I was testing, and it had modified 
content. This is what was causing the "mismatched output" error, although I'm not
sure why. If I use a pathspec that does not include the submodule when invoking 
'git add -p', it works correctly. 

I'm a bit out of time now but I'll try to write a separate reproducer for this later today.

As for my real-life example, I noticed a little change in the output. 
Here is what it looks like with the Perl version:

$ git -c interactive.diffFilter="diff-so-fancy --patch" -c add.interactive.useBuiltin=false -add p ice_dyn_vp.F90

───────────────────────────────────────────────────────────────────────
modified: ice_dyn_vp.F90
───────────────────────────────────────────────────────────────────────
@ ice_dyn_vp.F90:274 @ subroutine implicit_solver (dt)
         do i = 1, nx_block
            rdg_conv (i,j,iblk) = c0
            rdg_shear(i,j,iblk) = c0
            divu (i,j,iblk) = c0
            divv (i,j,iblk) = c0
            shear(i,j,iblk) = c0
         enddo
         enddo
(1/1) Stage this hunk [y,n,q,a,d,e,?]? 

The first part of the hunk header "ice_dyn_vp.F90:274" is in pink and the subroutine
name is in light mauve (default diff-so-fancy colors). Here is what it looks like
with your patches with the builtin version:

$ git -c interactive.diffFilter="diff-so-fancy --patch" add -p ice_dyn_vp.F90

───────────────────────────────────────────────────────────────────────
modified: ice_dyn_vp.F90
───────────────────────────────────────────────────────────────────────
@@ -271,7 +271,7 @@ @ ice_dyn_vp.F90:274 @ subroutine implicit_solver (dt)
         do i = 1, nx_block
            rdg_conv (i,j,iblk) = c0
            rdg_shear(i,j,iblk) = c0
            divu (i,j,iblk) = c0
            divv (i,j,iblk) = c0
            shear(i,j,iblk) = c0
         enddo
         enddo
(1/1) Stage this hunk [y,n,q,a,d,e,?]? 

Notice we have the line numbers (-271,7 +271,7) in cyan, then the first part
of the hunk header modified by diff-so-fancy (ice_dyn_vp.F90:274) in pink, and
then the subroutine name (in light mauve). 

We can see the same thing with my earlier reproducer, only there is no function
matched. I really don't mind having this first part with the line numbers, I
just wanted to share my observation.

Thanks,

Philippe.
