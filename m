Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D818C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhLGVJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237232AbhLGVJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:09:23 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27153C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 13:05:51 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so536736otl.3
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 13:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ybCmEtluxUch1d3p0bpSZbMHaCRQb9M6Q4F4ofula5k=;
        b=CTav/QURfP6/njzi7M5fzlBPR+DcnQSDuYBFBrGEPjN6O/YVG8mWWo/KtPnADOc5R2
         9Sfxktq6HMPCrNVxOEM4Vciz2kPaizCjRrjsQYln43J7LZn4oKyqzwhrHIZPClsXg+6M
         P3tSJMbf8fQKM3euGt00DtR8Denl+mK6lBTdldkhLEbR6LllVAmijSjB+focuB1hEIGb
         cYZ/WmYYaaavDXpBTiESxn6Xa9+6d1tWWRCIHcXyIW+Z7ybuEckuRqAlEPVfpGYqmm2Y
         8SJmvHQLFNn5dBoQIAzYerPvBpK0nJyWa0l7g+qeYftX+WaGv1cA+/MGVebCuURfoBBX
         jPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ybCmEtluxUch1d3p0bpSZbMHaCRQb9M6Q4F4ofula5k=;
        b=RSAXUpTT6iA/yqfSibB6E7lcXbp6HWg8UaMQuV8t4ZyQzH5q80Ca8H0ZqByUBddzLW
         f6G//jv3v5ju9PKfw7rK0Evau2hUt3h4HbPVkbNkImxAJAZ/DXIOF44ofAg/t4OtO91x
         BBa2j9vhvwSCn7Mu6GcKeNmJqWHiQN7lBE/mBI5F1XznXmq6tYJx28Qy/bhdV8/P6jHq
         onTT4MLfWInNkPj5kNjRKqdWWlJjL1ObppJMvWNgShYHTCXDl9xqBa4yQtCKAOhkME4l
         AH8yIfCg+V0QjO4fXWIy7gejT5GITf8N9jHD5C1jfS02XfuP/qMbd3dXOOu1/qjLA/qf
         n4EQ==
X-Gm-Message-State: AOAM5309dpUmKenV0ivGj6PDjcCoFSvZwbc2zmB0XXwb1zsBT1eABh+E
        5iZHyM1O7kwZ8HZvZ5EVEQBzdek0eKk=
X-Google-Smtp-Source: ABdhPJwba4GnfLHX7O4LQcwebO1p8TEYDeC4sXhf4AZbA7lLKRS7JYwzEmkWqRN+uHiCjW6PotfXYA==
X-Received: by 2002:a05:6830:1605:: with SMTP id g5mr38689183otr.46.1638911150433;
        Tue, 07 Dec 2021 13:05:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id bk41sm195919oib.31.2021.12.07.13.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:05:50 -0800 (PST)
Message-ID: <dca78efd-1767-e07f-d33b-c8ecbd8bccac@gmail.com>
Date:   Tue, 7 Dec 2021 16:05:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 00/10] sparse-checkout: make set subsume init
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1151.git.git.1638648020.gitgitgadget@gmail.com>
 <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2021 3:20 PM, Elijah Newren via GitGitGadget wrote:
> As described at [1], the split of init and set subcommands in
> sparse-checkout causes multiple issues:
> 
>  * Poor performance (deleting all tracked files, then later restoring many
>    and maybe even most of them)
>  * Poor UI (multiple progress bars in wrappers that hide both commands under
>    1 user-facing command)
>  * Loss of ignored files under directories the user wanted to keep
> 
> This series fixes this bug by providing a single command to switch to a
> sparse-checkout: set. It does so by making set able to do the combined work
> of init and set. It keeps init as-is to give folks time to adapt, but marks
> it as deprecated. It also makes reapply able to toggle cone/non-cone mode
> and sparse-index/non-sparse-index mode.
> 
> Changes since v1:
> 
>  * Inserted new patches 3 & 4 as additional preparatory cleanups
>  * Took the new mode-toggling work code in sparse_checkout_set from the
>    previous series and moved it into a new function, as a preparatory patch,
>    and made it usable by init/set/reapply
>  * Also updated reapply to allow mode-toggling
>  * Updated the documentation as per above
>  * Various other small items from review comments

I reread this series and the new patch organization is an
improvement! I found this to be an easy read and have no
suggestions for changes.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee
