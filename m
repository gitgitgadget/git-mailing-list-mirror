Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12413C433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 17:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350657AbiD1R7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350658AbiD1R7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 13:59:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F6A4DF5B
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 10:56:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so5126669wmj.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 10:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uqz2f2ZyYX1PDkGpxfljI9McWevfLQZIUqyji5gEkY8=;
        b=cqor6Ls8g784DICfWjGQ9gn3HPHTIv2hETM/ikA3J6EBv0YGpHuLkGhYNcioUSihgw
         L70RbDgoboCET/0zwv4b3T5GRGAet5sLf8FoIqcEvnFxW0e+EGpWPuT1YBSrtkxYxIQ7
         u1+h0ROWPjmtPMwj5+HIRu+fAkEI/o2LBzmmvXvay3xrYfCKXMTvuClER7fXTRmh59GP
         7i42DeOviimsS19c4DiL7I3/XqBn/QiQnmwE+PZRxBGZRCa+8TkLeTGN2SWXjB5BiFd6
         s+8aoDVEbS0z60cn77HCuNAU4UM47JQt259GVlDrbYXkTvJgIyKffPHz/cppfGErQYa7
         4FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uqz2f2ZyYX1PDkGpxfljI9McWevfLQZIUqyji5gEkY8=;
        b=x+//7qKxMvTUNVr4rMoiWx2fWw/VaS4vMqIkeAONpMkOivH3Wt/AMuZjEvukh+uH9Z
         hCFRKK1kVDZmNgqI/EKXKLLGL1sgRlENj9JyRiDEEE3+DEy/ACIMCPjUmlG/6Wv+sD/c
         3Za3ieOoTJvg3y/C/mjCqov+wRSptrJa4U0Ofi5IjiwEKOIZhoxIdGKkH+k+t4yKipIl
         Hj2XxcQmgw4NQzI0fgWl+lWyf/qNs4Bj03K0LuevQFwa6PvX55A42U4VYBpGyVCJjfhd
         C8A8zqRxfxXO6+V3WABvwDA0FYBVwpsV5VONoTmqe8TD0P4Ca1Icz+p/n2jCtEzwnVkG
         BuCQ==
X-Gm-Message-State: AOAM531QSWdc3q+BY7g+o9L3dqNU7U7TaXq15png1TCI0QPD++KUW5gS
        81n9om0Psu7OyJNZoZrtpa4=
X-Google-Smtp-Source: ABdhPJymbkuHC0lJY8/iwD4bmvB5OUcz1gcHshITHeZ2f4SSWccHT14wHb8TH7NsxQbZatbD2bReCw==
X-Received: by 2002:a7b:cb57:0:b0:393:db11:52ad with SMTP id v23-20020a7bcb57000000b00393db1152admr29729243wmj.143.1651168597367;
        Thu, 28 Apr 2022 10:56:37 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id bs14-20020a056000070e00b0020af0a49c3bsm342759wrb.75.2022.04.28.10.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 10:56:37 -0700 (PDT)
Message-ID: <fabb3940-7d6d-efb4-dba0-07531caf9d5e@gmail.com>
Date:   Thu, 28 Apr 2022 18:56:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com, Randall Becker <rsbecker@nexbridge.com>
References: <20220426183105.99779-1-carenas@gmail.com>
 <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
 <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com>
 <CAPUEspiHWTTAvNyqqLzcC854UccH=bkPLPBzPaPfzFKn_yt4aA@mail.gmail.com>
 <b0a80f47-f441-fc6e-3695-58ea83dea2b8@gmail.com> <xmqqzgk6l5ly.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqzgk6l5ly.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/2022 19:54, Junio C Hamano wrote:

[ I've trimmed your discussion for brevity but thanks for taking the 
time to write it out, it was helpful in clarifying what we're trying to 
protect ourselves against]

> So, in short, I think it is reasonable if we did:
> 
>   - do the extra "if SUDO_UID exists, then..." only when we are root.
> 
>   - use strtol to ensure SUDO_UID is in good shape (all digits) and
>     read into long; use errno=0 trick to notice overflows.  err on
>     the safe side and do not allow if the value cannot be read
>     correctly.
> 
>   - do the comparison between st.st_uid and strtol() result by
>     casting both to (long).  Without this, st.st_uid has a value that
>     needs wider than long, we cannot allow the owner of such a
>     repository in (and I somehow feel that is unlikely to happen).
> 
>   - or omit the third one --- tough luck for those whose UID is
>     beyond what a long can represent (and I somehow feel that this is
>     probably OK).

I think that unsigned long should be wide enough. On x86 linux uid_t is 
uint32_t for both 32 & 64 bit processors. That means that we could 
truncate the value we read from SUDO_UID when long is 64 bits if it is 
cast to uid_t but we're supposed to be able to trust that SUDO_UID is a 
valid id so that shouldn't be a problem. If an attacker can change 
what's in SUDO_UID we're doomed anyway.

Best Wishes

Phillip
