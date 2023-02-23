Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D94C64ED6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 13:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjBWN5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 08:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjBWN5c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 08:57:32 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144D45457D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 05:57:28 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id t7-20020a9d5907000000b00690ecb95d46so2400555oth.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 05:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xK9yfGLW2NQV20ScivjwnfsUJtXzXoA2SsaeAZMHbAA=;
        b=c1V7wDHXuJE97FTzZuuipJVIdZcPsHS07p1PUCcvJFdzHANXmH6jhJ9aXhw53iOl25
         VKIV2z6lPj7ELbeWjCukM1+Qa9+PErdt340N9mVfyJqS+8XPjC++7efbPAY1xADY79mo
         T3zgUUE3Zr5DVR6PhcswNBr7k3Nrq6YEeI5i2BTLVOHIZekviJ+jKDKZFhecjzXPrqua
         LkxqXf3eEuPMJo4sIE4A6GnVavn2TmVv8R1D+ihZL4rrQAF7R2tqE95p7cESDvanYQWl
         XC0dLjRtQbAyC3QhmHkx6UWapAfeSk/IjzD2g3NmaFEH3GIQeAn7iAmdl721OCembKjp
         Ja6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK9yfGLW2NQV20ScivjwnfsUJtXzXoA2SsaeAZMHbAA=;
        b=syxsKyfBiYuMcrq76Z/dazrV3gMqXoKeBmBfTs87P4nTCBj7pOReqq8hSc5wbL32xM
         TKhSXwGuCMcS7nPguQeXwkatoo5OKHWnzKrChgNOtrzF+swNY2s3qgl23j3/9+IT+/F4
         Qg3q3OMnzSofHlCA05ZIyw/8yNKBazNGb6iJgIC//O7dUUxhB+LDJyWuCjfjQxySh+/l
         21v/HSCP03PN/OLKMlQH6GnbBvnPSuwTxmoyqnH5zbLS5NZxSqd7889C8SVE2N80AzPv
         Ccv3rZOdEXbc8k/ddPqdxgX050+lem5d/slU1ArZDG1jszYDzlggzoiqb8RZBKgIUCVo
         8pvA==
X-Gm-Message-State: AO0yUKV7kEdBYovhTPdjI/6DIhk8aUQ7SqMxZpAh5vChVS9HXRMwoAHW
        tlg3zHDpyCZf6nRjQFncE4BB
X-Google-Smtp-Source: AK7set+OGCLfvCu5X2od2hjDgbe2NiDba7yejvwqKA9LETgiCclvW0rjYfSJauWERcsXZfqf9zxHFA==
X-Received: by 2002:a05:6830:d14:b0:68d:3fc8:7c12 with SMTP id bu20-20020a0568300d1400b0068d3fc87c12mr5024469otb.13.1677160647408;
        Thu, 23 Feb 2023 05:57:27 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id r15-20020a056830418f00b00690f6d9a737sm1118335otu.8.2023.02.23.05.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:57:27 -0800 (PST)
Message-ID: <577c07be-b62e-f2b7-9d59-ae4229ee1208@github.com>
Date:   Thu, 23 Feb 2023 08:57:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 04/16] treewide: remove unnecessary cache.h includes in
 source files
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <bec6f89d82c98c594f88a1fd5e3cd44973c9a1c2.1677139521.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <bec6f89d82c98c594f88a1fd5e3cd44973c9a1c2.1677139521.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> We had several C files include cache.h unnecessarily.  Replace those
> with an include of "git-compat-util.h" instead.  Much like the previous
> commit, these have all been verified via both ensuring that
>     gcc -E $SOURCE_FILE | grep '"cache.h"'
> found no hits and that
>     make DEVELOPER=1 ${OBJECT_FILE_FOR_SOURCE_FILE}
> successfully compiles without warnings.


> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 3ecb830f4a8..67b42ef50eb 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -9,8 +9,6 @@
>   */
>  
>  #include "test-tool.h"
> -#include "git-compat-util.h"
> -#include "cache.h"

This double-deletion initially caught me off guard, but then I
double-checked your first patch where "test-tool.h" was an
acceptable first include.

Thanks,
-Stolee
