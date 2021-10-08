Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D6DC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1EF610CC
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 02:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhJHCwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 22:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhJHCwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 22:52:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F6AC061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 19:50:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n11so4799834plf.4
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 19:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nPr5IJA+cPGzhsMxdRm6+X7J+7Vq6AOfGlef7PrzQhc=;
        b=T1335ZgGcAOgCSs5SQg98z1PcrcvdToKe0vgi1VKjN/20W4dYyu6YQ+cz7pc3RUd/e
         RV4BpQe68UWGkLCVtmr/tnR0TCPnjziEOatxRoVMPoL6AK5oBssPXMUKJcyslfKI6Ssn
         erhCtEgppzYwuOccru7MTUosK68l1PwXtIVwyTJXAg0eDLrmYZFNeXVNiE/GHmHKzaH/
         1VkQbuOT1XusEPnU8KG5hT3Y7NGvAqW81L1zwVkR6KDtLzMNrUmanArtUngr9lifUonY
         gJo2urlFkrCzMxNsfUIELfjJZlUvH7r1wMkhOznPyKNnOUjYZtjtuJ9W0zroEvvr5QjE
         dGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPr5IJA+cPGzhsMxdRm6+X7J+7Vq6AOfGlef7PrzQhc=;
        b=SgHgjAXnOKkoIrD4h3v3MzxoWd5GpNgNSbeJEzk7I9k0Eq0+Puj7sFnl3o3RBXkdOI
         OOXT4YKqJx6kDbFWm9zYA42+IsuFjpNB1PLRneCQ3Y6e4iyMeevsvg0Q5rJCZd4tc84j
         LRBy36fM/ZgONroF5XXJTjcVtsTLPU+ta+bSScy0+Xi/Gfgdlh1GgYRrDFZd7AXZEP+K
         WwjxdXgYfyIfc3Ok3DXI5pfYFqpqqEuXEcfTYy7PZs+p9sknlfXb+qtwOcVHCbBKf1md
         zlGd5Sizzx42MfPEQ6+DeuSAgYbuHugFePIlhqVnD7LCvaOEo4+b303pnflQ5e8kpdQK
         YW6g==
X-Gm-Message-State: AOAM5307A4o2guPxlv/NICxPbJ80tY8TF3xwXgownSvH6GoBLfWQJ7kZ
        yzLIHcDe4havxRt6d60l17U=
X-Google-Smtp-Source: ABdhPJyhuaGj4/A1MsF9yf/Y+FVzBWyGPTa1y/ux4/SRiBtOZh6hvHvfZFJwgwXsuCjlaN0zEW6/AQ==
X-Received: by 2002:a17:90a:9d81:: with SMTP id k1mr608767pjp.153.1633661409342;
        Thu, 07 Oct 2021 19:50:09 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id o2sm649542pgc.47.2021.10.07.19.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 19:50:08 -0700 (PDT)
Subject: Re: [PATCH v3 3/8] update-index: add --force-full-index option for
 expand/collapse test
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <45a1e0aa-4857-6647-cc60-bc47f32ae0c0@gmail.com>
Date:   Fri, 8 Oct 2021 09:50:03 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/10/21 04.15, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Add a new `--force-full-index` option to `git update-index`, which skips
> explicitly setting `command_requires_full_index`. This option, intended for
> use in internal testing purposes only, lets `git update-index` run as a
> command without sparse index compatibility implemented, even after it
> receives updates to otherwise use the sparse index.
> 
> The specific test `--force-full-index` is intended for - `t1092 -
> sparse-index is expanded and converted back` - verifies index compatibility
> in commands that do not change the default (enabled)
> `command_requires_full_index` repo setting. In the past, the test used `git
> reset`. However, as `reset` and other commands are integrated with the
> sparse index, the command used in the test would need to keep changing.
> Conversely, the `--force-full-index` option makes `git update-index` behave
> like a not-yet-sparse-aware command, and can be used in the test
> indefinitely without interfering with future sparse index integrations.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Victoria Dye <vdye@github.com>

Grammar looks OK.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
