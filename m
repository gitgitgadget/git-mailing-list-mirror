Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003E0C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 21:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbiESVy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 17:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245316AbiESVyr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 17:54:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5A9562F4
        for <git@vger.kernel.org>; Thu, 19 May 2022 14:54:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso9865562pjj.4
        for <git@vger.kernel.org>; Thu, 19 May 2022 14:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:cc:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v/YZSxICK4EJmp8zP7TO/g2mlHDZc1jVdJfv8mWTR/U=;
        b=UlNh+mWvV0nwIqizmbKekAN3EmTLKKRUwrO3FVwlui3B7fYrvDvJnTEsDWxlwyGOpW
         sxkL4Va3SN8DodHoayj7imqcgQ/l+UI1kW1H0b4ijemr2GeJo5TanO5Cb7K2/sTc0N6B
         sn6/tgtuypNwH0jtWjC+McpBeIA1NPCNK5oDtX0Mkgh1VFd/x9e43Cka+4I8J+mA2hXS
         pvV4QCbr2aCgsIuwW8jV7wMOw4KMU8bJ+1Z+UQRmSELwdl0gf6YwQZiUk7Mn2V430pSU
         XFfsif/GDn/c0Aaj8n+u6naGoEjBdOkuTc6KVomK0oa2lxMKPK+r6mkIie8SaHZr3U9M
         dwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :cc:subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v/YZSxICK4EJmp8zP7TO/g2mlHDZc1jVdJfv8mWTR/U=;
        b=bihUIMbq7OZOU4xe3Vx6OOpx3DXXwkVA9HsFXqEUUPLj8SbTl3/FK+C/jZle3R38B3
         12l8chMttdY01BVxmE+fq/vJNIhIwK3fUl8jFSZEq4QB6deyXzqHoUjX8DAJo5wLMOoR
         wNOSJWgrKQOyNqsg+jrWoLT7eq8MeViVnetfvucUCaZQkd1oWa7+wmoPIBYls2K1cthg
         AG7oYVSNfloe68K99Mvq4q/8YcM2WNmLpQAIYG5swpuoX9jz0uM++UKc8DLoLcWXZsAQ
         WVZxl1IliFxizL4bzZ6YHOTSDzajW87kaiozXRmHTNVE5HnFUZxJ3Kr2iXTljvzD+RyT
         py8g==
X-Gm-Message-State: AOAM530ZC7COhtNsMjFUiSafg1d4bX2KqrdVe333oTY76+DXlHJWNE10
        xbnFo4yTCG58xIR+Pi3EYfY=
X-Google-Smtp-Source: ABdhPJyT9IfALlXLsoAcvXPeU23ji8iMKED99syY5NaagPiYtcH+WzbCTdZiBhxV+DeuANhYN6gV2w==
X-Received: by 2002:a17:90b:4c8f:b0:1de:b3b5:ea23 with SMTP id my15-20020a17090b4c8f00b001deb3b5ea23mr7866706pjb.133.1652997285484;
        Thu, 19 May 2022 14:54:45 -0700 (PDT)
Received: from ?IPV6:2001:4898:d8:33:e91f:6a3a:65d4:8597? ([2001:4898:80e8:0:6942:6a3a:65d4:8597])
        by smtp.gmail.com with ESMTPSA id ml5-20020a17090b360500b001df82551cf2sm263212pjb.44.2022.05.19.14.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 14:54:44 -0700 (PDT)
Message-ID: <fb1f2c8c-b749-85d9-b472-587f51dea8a8@gmail.com>
Date:   Thu, 19 May 2022 14:54:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: neerajsi@microsoft.com
Cc:     nksingh85@gmail.com, gitgitgadget@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        jeffhost@microsoft.com, neerajsi@microsoft.com, ps@pks.im,
        worldhello.net@gmail.com
Subject: Re: [PATCH v6 00/12] core.fsyncmethod: add 'batch' mode for faster
 fsyncing of multiple objects
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
 <20220405052018.11247-1-neerajsi@microsoft.com> <xmqq7d82x8a9.fsf@gitster.g>
 <xmqqtu9lkxe5.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
In-Reply-To: <xmqqtu9lkxe5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/19/2022 2:47 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> nksingh85@gmail.com writes:
>>
>>> From: Neeraj Singh <neerajsi@microsoft.com>
>>>
>>> GGG closed this series erroneously, so I'm trying out
>>> git-send-email. Apologies for any mistakes.
>>>
>>> This series is also available at
>>> https://github.com/neerajsi-msft/git/git.git ns/batched-fsync-v6.
>>>
>>> V6 changes:
> 
> We haven't heard anything on this topic from anybody for this round.
> I am planning to merge it to 'next' soonish.
> 
> Please speak up if anybody has concerns.
> 
> Thanks.
> 

No updates on my end. I'll keep my eyes out for any reports of regression.

Thanks,
Neeraj
