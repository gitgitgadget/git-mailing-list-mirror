Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADAAC77B7A
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 15:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbjFGPbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbjFGPb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 11:31:29 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0D58E
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 08:31:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so63065655e9.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686151882; x=1688743882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4p/qsvJiHnLK0L35yWd6qn8eFAC78G4rBjF50z1dsEE=;
        b=MK6uYLW0rIyxSKX+3uYuMPrL9v5eKlQIwV6zSKCRqMKqmr39+Kf3ytlNEmkBJY4XkF
         lBukaZsNtFIbvzMErkqtc5Gh1aiqSawHYSE6uhqN+u9k1cW0Lon7C99UxZlr4RmZy/Fz
         k/hpm8Ubr2F+CJrTNv9JGZVZY1cJ24a+9m7gvBGiQJUL7nSqrcAG0or9vRWJyIHJ+sdR
         sD3tQXXiT3pR91TV4Z0laHKIZVHKxgcZVznHEwqWBpA9+YqOZCft6YVAcgzsqzKd5bq+
         mBsmA/mdvQHaFrksRMsFg7GIIvvExQUqjYWHQQDBjEHqdQGNYDzWfk5BctVjWzZrP7oa
         GSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151882; x=1688743882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4p/qsvJiHnLK0L35yWd6qn8eFAC78G4rBjF50z1dsEE=;
        b=dXEMJw4lenzIyIsSG1ZBJlqJJebR/CGLQzvl7hJjI96hSxR5ufElh356XblT2MxTrx
         BX992+rRVAn6li6kalh23Pms7gIj/tQIPDHx1U0PWy1epXjq4LjME/Y9gyPjrwXcBFmT
         yzfRaZCFOIqnxHFd31JVGh/A06VKlY2IJz7AzYyNznicie9AlWPzRLWWHobh9IthF2py
         a8DeFldqle86jN6/vsnWQK1qw1R7ZIUMUGqhEumUw1uamTWcGGcY09ancWOfIcLR0QAR
         hTbjiayjTyhisRdeldTFxWMtYWSMV8cje0p8u2iPUyvaKDtwB92m7+GTad0WIGTL9q+u
         QdzQ==
X-Gm-Message-State: AC+VfDwlYTumltwA3LIdLiRcYOKt6jC4ls7vnPyyPxbN3AVJOTeqoFm3
        0wqJhcaDMiwIFmL5PQDjN7nEniC/6L0=
X-Google-Smtp-Source: ACHHUZ7HiffMzY9o9xX+71XUDXQU5Yml4D/vFP/4dw8YoMAeoThBVmqBNLMDA9oll5PkO/9BbDI9Qw==
X-Received: by 2002:a7b:ce0d:0:b0:3f7:e48b:9752 with SMTP id m13-20020a7bce0d000000b003f7e48b9752mr4705682wmc.32.1686151881937;
        Wed, 07 Jun 2023 08:31:21 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f60101074dsm2497639wmc.33.2023.06.07.08.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 08:31:21 -0700 (PDT)
Message-ID: <2143c98e-238b-8edc-a16c-be448a8b56e8@gmail.com>
Date:   Wed, 7 Jun 2023 16:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Patch v2 2/2] add: test use of brackets when color is disabled
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
 <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
 <281431b8-af40-9de9-f4b4-c596c5dbb3af@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <281431b8-af40-9de9-f4b4-c596c5dbb3af@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 07/06/2023 14:44, Derrick Stolee wrote:
>  From 02156b81bbb2cafb19d702c55d45714fcf224048 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <derrickstolee@github.com>
> Date: Wed, 7 Jun 2023 09:39:01 -0400
> Subject: [PATCH v2 2/2] add: test use of brackets when color is disabled
> 
> The interactive add command, 'git add -i', displays a menu of options
> using full words. When color is enabled, the first letter of each word
> is changed to a highlight color to signal that the first letter could be
> used as a command. Without color, brackets ("[]") are used around these
> first letters.
> 
> This behavior was not previously tested directly in t3701, so add a test
> for it now. Since we use 'git add -i >actual <input' without
> 'force_color', the color system recognizes that colors are not available
> on stdout and will be disabled by default.
> 
> This test would reproduce correctly with or without the fix in the
> previous commit to make sure that color.ui is respected in 'git add'.
> 
> Reported-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---

Thanks for adding this, the patch looks good. Strictly speaking you 
don't need the "g" at the end of the sed expression as it only ever 
matches a single instance within each line but that's not worth worrying 
about.

Best Wishes

Phillip

> Here is the patch to add this test on top of the previous change.
> 
> I've only validated this on my local computer, not through the
> GitGitGadget PR. If needed, I could send a v3 via GitGitGadget,
> but thought this would be a simple-enough addition here.
> 
> Thanks,
> -Stolee
> 
>   t/t3701-add-interactive.sh | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index a93fe54e2ad..df3e85fc8d6 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -734,6 +734,29 @@ test_expect_success 'colors can be overridden' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'brackets appear without color' '
> +	git reset --hard &&
> +	test_when_finished "git rm -f bracket-test" &&
> +	test_write_lines context old more-context >bracket-test &&
> +	git add bracket-test &&
> +	test_write_lines context new more-context another-one >bracket-test &&
> +
> +	test_write_lines quit >input &&
> +	git add -i >actual <input &&
> +
> +	sed "s/^|//g" >expect <<-\EOF &&
> +	|           staged     unstaged path
> +	|  1:        +3/-0        +2/-1 bracket-test
> +	|
> +	|*** Commands ***
> +	|  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
> +	|  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
> +	|What now> Bye.
> +	EOF
> +
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'colors can be skipped with color.ui=false' '
>   	git reset --hard &&
>   	test_when_finished "git rm -f color-test" &&
