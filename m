Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81470C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 07:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8B460FF2
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 07:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbhJ3Hfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhJ3Hft (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 03:35:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD43C061570
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 00:33:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t21so8301119plr.6
        for <git@vger.kernel.org>; Sat, 30 Oct 2021 00:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ALE5UcHtr4Yi5jM3SGjZdpco7Wzg9YLqhsJZIwRaSvo=;
        b=KI48qzp8pWDt3qH1dutYNa8vEFv6nKLibLJc/ejBE/Z3xtVhaWAjqxc4UPydImdCGG
         i2IunVExA/fiSkTDXYik5vfoMSNvA+y6n/PDtBVHg16bHDOgr6JInf0cvEfAePejM/l0
         9F/j5u0GAhd38Pnk/DA6SjkGvLRIY92rfbUpQPkibOebNcQ567GGRcpDYFNGp4SAcC1T
         HeH/FGMv00k8CG0d3jl0iISuBZFkIy2iZxH8wCiteEhVd5ZOBo2pHkp1tz84XaODeWOC
         BJud3jYKmeEuqoAIOAAEqWKebuI/nABCuFYyL70f4QgNFj3ulIvgy6MFQITUQq0lIIF9
         EXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ALE5UcHtr4Yi5jM3SGjZdpco7Wzg9YLqhsJZIwRaSvo=;
        b=e37tBwZSuf297MZzoa7sg/c5WubSuCupZspADdxFSVOiH4IdlK2x3hJHEdnhl1fZ4o
         /XnCWGTE1b897zmjIHog40xPxYZyY2Z9eMAmUwRQ6PpwQIb9MLjDWcqYufregnmyKsm2
         LkV+vjocf6XLmmJMpzIIbVUfnMtgNPjyvy4lMampwrs5tdOwn4yTSdmhF6JXEzgablXS
         sUW/qG8hyQV7CY2TutVGWISBXNjVKq+R72Yr/h6z/q96sjRdLODvEVd7hoSYblIj+4bT
         ArhYTHU38NsYtfnp7imC9UIDpdhCZCJBVHYYCsQ2pH8U77g3dezHnrKXikaEhTOBOIRN
         eQMg==
X-Gm-Message-State: AOAM530xqwuFofA4+kUYPyOr9+9ZXxeiZBcugMwOzrcasmc5MzgBoY49
        vHvoayQOWiuU3hKybVPfnekCoM8qTns=
X-Google-Smtp-Source: ABdhPJwiV8YHqdimCPkt/PAAExllcoP6Wdlo1kqfdkZJvMWfxli/qwbmdDCJWGph/DuXrM/OiapQKQ==
X-Received: by 2002:a17:902:8b8b:b0:13d:e91c:a1b9 with SMTP id ay11-20020a1709028b8b00b0013de91ca1b9mr14185544plb.60.1635579199508;
        Sat, 30 Oct 2021 00:33:19 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-32.three.co.id. [116.206.28.32])
        by smtp.gmail.com with ESMTPSA id u3sm3056467pfk.145.2021.10.30.00.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 00:33:19 -0700 (PDT)
Message-ID: <224a256e-8700-047d-bc12-834524a3c8f3@gmail.com>
Date:   Sat, 30 Oct 2021 14:33:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 2/2] docs: add headers in MyFirstObjectWalk
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
References: <pull.1063.git.1635343531.gitgitgadget@gmail.com>
 <33cd9b2e8a675bf79132d312da8b7d8f4a2b84a3.1635343531.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <33cd9b2e8a675bf79132d312da8b7d8f4a2b84a3.1635343531.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/21 21.05, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> In several places, headers need to be included or else the code won't
> compile. Since this is the first object walk, it would be nice to
> include them in the tutorial to make it easier to follow.
> 

Patch title should be "#include missing headers" (dunno?)

-- 
An old man doll... just what I always wanted! - Clara
