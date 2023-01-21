Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A15C004D4
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 15:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAUPJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAUPJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 10:09:37 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C076233FC
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 07:09:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bk15so20683306ejb.9
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2e/oIYBQGnCmgk7Qb+LgC+pTIjzw8A/j3NNWlS1J7O0=;
        b=d3bxLgNVVXudfnGRLu4SCkj/ijwKjiL5ujzmk4hPEVtdQazRejgsl0+hNLjmWoQlYu
         kNbfwE741zziqB0XBSd6EmZINZmCWkqHeUCo32eL61hCWuG2hL7LGRRvUXt3i17NFy5H
         y/uq7g3DsiGvO9znaagSH5CSic8bnmRO/NUoGGHlm3Y7YfK0tU93OQB4OdkSi1UMMleP
         mUfcV4KC6G0Oet7IX5aBnycRWwSeeL4I9okAcb8+PlvgYdBKaOmOKN5YgfRs390IwBZb
         cU8zn3jKaENmSMceBocxAvO2g15WKWvnTROpKgRmvynCWkD0QUd2j3R3iVxheO3+r4rd
         OmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e/oIYBQGnCmgk7Qb+LgC+pTIjzw8A/j3NNWlS1J7O0=;
        b=X22+DQw7WiBAv6YFYi9qx9uqiRljEIv2HIle+538LzBIHfN44KilVLe2GxKJXUnZst
         zfspETfbPtRL7yMRz9yRCS/3/HTU23k0VtnalY9a6kpeagg0fTog4IzxNNSsmQrgRaxI
         S2VR5gARnA/VneNv6e+vai+YqV635Q5yw2Mj377iA0Q8SohTv5Kzlfo4+PiH5cy88fkU
         ZdeRXXkxpfDBmaXAKvqVZ80DLu/MklKZeTXgcLaX+djklaNq7G/USVcYR7DWDYI06LY7
         I2gOTw0HZw05O/ixyotW+MW5AG2TbFgvD66i22JlXUYVOYConDiyCjuErYjxHrDZtAp6
         A5SQ==
X-Gm-Message-State: AFqh2kpWC3AxVfu7D4ty2iEpDKX/AGi7x0Q23DPLeyTyWEF+U1xWmsJh
        wVUnb8zC32o2l4khlo1AhUU=
X-Google-Smtp-Source: AMrXdXsch/fy8b/BD/KnBA0DNFWLfJx1ZR60CL/djLPK8/0LZ1uL7Wb76leo7jVOSb1vDvMcYvnyBQ==
X-Received: by 2002:a17:906:3e13:b0:877:839c:bd6c with SMTP id k19-20020a1709063e1300b00877839cbd6cmr8438416eji.71.1674313774806;
        Sat, 21 Jan 2023 07:09:34 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709063d2100b0086d70b9c023sm10423094ejf.63.2023.01.21.07.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 07:09:34 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8d6c741c-3271-db61-4e69-3b93049f9f8f@dunelm.org.uk>
Date:   Sat, 21 Jan 2023 15:09:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/7] rebase: remove --allow-empty-message from
 incompatible opts
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
 <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <f4fbfd40d4599542b041081880e89075f4ff792b.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <f4fbfd40d4599542b041081880e89075f4ff792b.1674266126.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 21/01/2023 01:55, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> --allow-empty-message was turned into a no-op and even documented
> as such; the flag is simply ignored.  Since the flag is ignored, it
> shouldn't be documented as being incompatible with other flags.

The patch looks fine. Just to note that

#leftoverbits - I notice there is some code in builtin/rebase.c, 
builtin/revert.c and sequencer.[ch] related to this option that could be 
removed. The setting seems to be completely ignored by the sequencer and 
so could be removed from struct replay_opts.

Best Wishes

Phillip

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-rebase.txt | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 00d21d7287d..3929535c0cd 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -640,7 +640,6 @@ are incompatible with the following options:
>    * --merge
>    * --strategy
>    * --strategy-option
> - * --allow-empty-message
>    * --[no-]autosquash
>    * --rebase-merges
>    * --interactive
