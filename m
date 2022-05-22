Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3B2C433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 03:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiEVDHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 23:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiEVDH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 23:07:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0774E45AC5
        for <git@vger.kernel.org>; Sat, 21 May 2022 20:07:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h186so10880047pgc.3
        for <git@vger.kernel.org>; Sat, 21 May 2022 20:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DhJePNYz7uRjnuSjBoQSXNwsGCroZQQBgYynUpuMQ/U=;
        b=BuAbZHDTZye4GKlX2hfdL3rxnTs+BiAH7xJOOo2XPq9g29ax+ZIAL1OBb/S4TF1FFN
         IyIrg2hgBXrNtmHSWN9Sx8lr5q5yZDNZxej1JqqzvS4egwiC5D/tRqMWZ61UXhoI6rdm
         NODV3241yqjHVspo+RX6c09Yz8yUHindnFTuQC0CXqi6/oqcXUvoz8MLbayAttTdLCsf
         5VqmMCCXLT+bYAx9HeBgD+UUZ1OqVw1bwMIvJFs3k8WKIpgBYc9DaU77spQYJj95cScq
         i3mnbuQqi8jFUl2w1GLC3E1OKpTcgDnK7ym3/2sOa6JVOjifcw9nol5CyE5zUg5GOyp4
         rZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DhJePNYz7uRjnuSjBoQSXNwsGCroZQQBgYynUpuMQ/U=;
        b=MKDy+vMJDvduI0HyvMvacfSPQsJKBWF+vjwUwOS7BT+5Zk+Kob0PlZZaxYnBtpkuaS
         GYsofXg3WkDJ/WuiNMk3YnnMGYe4Btyd4lxrGdTfGuFYrfPAie6vXaDuQqrt4YhOuUcR
         RpL7h9zTcvhacN0IrCn2gN+YJnjSUrBgLIcR5w4lcr/7OIbY89mglOTGpNrio5aHVZ0h
         HfoSIMo3orBi5pMVunJJw8wqRCJWMgesRWQKAVApL13wrGiiBmILosLwW2o7115JrcPp
         +1+eHL+hNmZ+1NWil8nxFfTpBujfzI0fWrJViTq48r00bPa313cWb3dMGHPHK/C4U9Zd
         Nd6g==
X-Gm-Message-State: AOAM530OzpRqvCwRBSmfb5q2zjGPLg1btZiFkPDPL3dHUyNUOyyQMf4y
        TVzg/TALy04WbYSKMELJzfE=
X-Google-Smtp-Source: ABdhPJw/1AxTIfw8iIbxsSS56adXe+kb2MA6YfMFG2W32MJnfnTVRyRaoVaEv9rEkMG89OkNHkscNw==
X-Received: by 2002:a05:6a00:1950:b0:510:739f:a32c with SMTP id s16-20020a056a00195000b00510739fa32cmr17295055pfk.77.1653188846122;
        Sat, 21 May 2022 20:07:26 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-6.three.co.id. [180.214.233.6])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b0015e8da1f9e8sm2316098plh.77.2022.05.21.20.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 20:07:25 -0700 (PDT)
Message-ID: <a6e77222-6a95-992a-892c-7361d5568784@gmail.com>
Date:   Sun, 22 May 2022 10:07:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 00/15] Finish converting git bisect into a built-in
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
 <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/21/22 21:48, Johannes Schindelin via GitGitGadget wrote:
>  * When a bogus command is provided, we now error out instead of trying to
>    start a git bisect run.

Ah! git bisect now behave like other shell commands where bogus
command is given, instead of "accidentally" start the bisection.

BTW, do the current version of git bisect exhibit that accidental
behavior?

-- 
An old man doll... just what I always wanted! - Clara
