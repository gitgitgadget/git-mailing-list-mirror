Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820EFC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 11:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiBVLIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiBVLIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 06:08:09 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B755B6D02
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:07:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h6so32388145wrb.9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CHIXYUQno8HZSZ5r9iPScF64EPpBpw+6Rj+OsiofJXs=;
        b=PAkYd8MRkwkawMt+cvAFTqapwhKHvF3eS0xTNDIX8zmJQ/WoSR3wRIGRaxoyZ59SzO
         h3FTqfAkUB+fpkR+VXDIS0xqImkhrpmnRaql/P2maDrSr6cWZL59hL/tqKYjtR8GnbaY
         ycAfpIGPj4UyUkQ22CaG9sNK07YAkIOrEM1KMhjCMr8QmjMPqzHINnv9udq79Xp8Y78A
         dIq+LjyxGVBV+XJ1gFY+hWs2517/v0/WtLzFuPuYgpU2S0hSk9+kjpI0ETU/AwYbcJdw
         4nMiHO210p683YYyquNzvtQJrkY3YhcfTTljrNe3hpn+P4qb5JifththtoEBHR4ZhMOb
         wcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CHIXYUQno8HZSZ5r9iPScF64EPpBpw+6Rj+OsiofJXs=;
        b=ZFAIcy9/f3B5qc+kYYR5YoxTssDkth0lttpc4SKcop0IiRjoI607kgafoI0vzSHVNs
         0xK+WMESxVplNaWFvqE6aWFEuSgERnmkcsAYiNAUgQtrIkVfvEVzRZiKawZD+/YLqM2M
         HuVIM1B7HOh2UBouYXC+NB0mp+T7TzmOPBqQIzAgwW0tA19hpsKyVDtNSwlMI5CDjwxl
         eaEhw0koHJg2pQNjANb87pTxFGRb8Humff643E3iDOvzj6QaBU9qvtNg0KM+oKsV/7bu
         tEzXzR2tni/dsx7715jyFF0YJIRuM0bExRDzDuhXYs8iCmOEXLvTSZbw5NMNvZKTf5S4
         8ieA==
X-Gm-Message-State: AOAM532McHe+SKFQKbcg7rAvZvdgmUFVWNKY6GuIC8IQVPP5KZOg+tl7
        SBn5kkldPw4CTibd1/I7h4A=
X-Google-Smtp-Source: ABdhPJz4AgfTzGmB9xMMPp/ULkEPvz7YlXUmuq9kKZfq/UVyCQbTsaSldxHxuRgy9DQErZlKbp2/Yw==
X-Received: by 2002:adf:e28f:0:b0:1e7:cf02:2d28 with SMTP id v15-20020adfe28f000000b001e7cf022d28mr19871091wri.232.1645528062790;
        Tue, 22 Feb 2022 03:07:42 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id v5sm32975204wrr.7.2022.02.22.03.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 03:07:42 -0800 (PST)
Message-ID: <9b9f1ac5-d5d9-0116-477f-0477c27bc55e@gmail.com>
Date:   Tue, 22 Feb 2022 11:07:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 0/4] Add cat-file --batch-command flag
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, avarab@gmail.com, e@80x24.org,
        bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
 <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1212.v10.git.git.1645208594.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/02/2022 18:23, John Cai via GitGitGadget wrote:
> The feature proposal of adding a command interface to cat-file was first
> discussed in [A]. In [B], Taylor expressed the need for a fuller proposal
> before moving forward with a new flag. An RFC was created [C] and the idea
> was discussed more thoroughly, and overall it seemed like it was headed in
> the right direction.
> 
> This patch series consolidates the feedback from these different threads.
> 
> This patch series has four parts:
> 
>   1. preparation patch to rename a variable
>   2. adding an enum to keep track of batch modes
>   3. add a remove_timestamp() helper that takes stdin and removes timestamps
>   4. logic to handle --batch-command flag, adding contents, info, flush
>      commands
> 
> Changes since v9
> 
>   * add test to exercise format for batch-command
>   * minor semantic improvements
>   * removed README entry for environment variable used in test

The range-diff looks good to me.

Best Wishes

Phillip
