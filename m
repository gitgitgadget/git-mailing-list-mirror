Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A49C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 10:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiB1K7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 05:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbiB1K7R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 05:59:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2222677
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 02:57:31 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r10so5439297wma.2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 02:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jQfFC+KV76iXnxdXthugfttxS1JKFmY+rRgGVD8c0wQ=;
        b=UTDiaT6j9h3RpE8rg2qoF35+vEofDK9qbcMWmFNJyhWzzC6y6ss/qYnEvkwsjItda4
         YatMpChWd4wr7W2w+3hf/ZZB8h6lcACZhrUcKT5XLGASLMH75qGlUw0BLVSC9mlm0AcV
         l3odTzjwTHaLjYWuuxVpqTTn7YYyW5GP5MVNNyS0SHL3osMH3A+CL2Eko3/KABSfMi3k
         d1Hc09HQLnec6b2hy3tOzn1AXY5YoB92Js5Etq1czfEYUiIoiyQNiLLbkYtmx17Vo+sE
         3+y8GWm/PIdep8O9gQvEJFlXPE6LvNIZ4DSgna9vKRg6aZPnc1vYgIJg2C3vqEglE/0V
         pi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jQfFC+KV76iXnxdXthugfttxS1JKFmY+rRgGVD8c0wQ=;
        b=vzQzHcph93bfqJCzLX7yWnTKEb0yGCyMF9QWfTlFuEpikLNoNooFTOQb1EsaHySyIt
         uK/BVzZAky2RhXQnp7f83zHDaVIfIC/+yc2PJj1YTttk+GNwpFgg9us98uCbMwf+foB7
         JMRH0hcuvFbWq3mBOfRZctGJkIb+W1BaHaWAF2fC+APIOkEpJ5VXRFPeRJPWMGkQjzwc
         6eossUPuLvyY/9MvVue7RMmL5EiShKY2xFqJ3P/6qYEhCUgBTuzdiBbZFvhlNfPvMLty
         cffQHJ0cvCDWCCYsqG8NXEEsHtNmwn3QiFHLQNjuHnJIUPHQxd8SF1zYUzXMSfoG/ZeF
         N8fQ==
X-Gm-Message-State: AOAM531bFtDAHz7xofSqtZgLSA15RHUdGwKZm5BXio1PuWKhwjDCIxRu
        dqq3gXfhWs92nOcdjNjEFOeaDt5DG7s=
X-Google-Smtp-Source: ABdhPJwqRSaiRQKpPNqNf6taq+cHliLhJMSVX1x/nOkBfkfqAI0XSkYTq6L99V6PARV4hQjJYImrqA==
X-Received: by 2002:a1c:2946:0:b0:37b:d710:f565 with SMTP id p67-20020a1c2946000000b0037bd710f565mr12983040wmp.10.1646045849983;
        Mon, 28 Feb 2022 02:57:29 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id j12-20020a05600c190c00b00380ead5bc65sm12957245wmq.29.2022.02.28.02.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 02:57:29 -0800 (PST)
Message-ID: <074263e5-7974-6272-2b9a-a55f1b6598d3@gmail.com>
Date:   Mon, 28 Feb 2022 10:57:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree: add -z option for list subcommand
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
 <90fcd727-414f-fc1f-fab3-2cbce5790aa0@free.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <90fcd727-414f-fc1f-fab3-2cbce5790aa0@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jean-Noël

On 28/02/2022 09:47, Jean-Noël Avila wrote:
> Le 25/02/2022 à 16:08, Phillip Wood via GitGitGadget a écrit :
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>>
>> @@ -696,6 +702,8 @@ static int list(int ac, const char **av, const 
>> char *prefix)
>>           usage_with_options(worktree_usage, options);
>>       else if (verbose && porcelain)
>>           die(_("options '%s' and '%s' cannot be used together"), 
>> "--verbose", "--porcelain");
>> +    else if (!line_terminator && !porcelain)
>> +        die(_("'-z' requires '--porcelain'"));
>>       else {
>>           struct worktree **worktrees = get_worktrees();
>>           int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
> 
> 
> Please better use
> 
>   die(_("the option '%s' requires '%s'"),  "-z", "--porcelain");
> 
> 
> In order to make a no-op for translators.

Will do, thanks for the suggestion

Phillip

> 
> Best regards,
> 
> JN
> 

