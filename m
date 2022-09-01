Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D5DECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 13:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiIANWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiIANVo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 09:21:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC1F1C12F
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 06:20:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v16so19611103wrm.8
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=mjyxBXO/Q67LRq7q+ZBorUGhYnfrQtLaOy8OBVlG140=;
        b=D8bBsBsqekNJo+vm6ba2A0e8lqC6YcEWSz8a5wosDrJbHXX78KdJWbj17+RnTL3lQm
         zPeCXRKmI7n3uLnhR5MuYOTVZjJUA/ZqXKZ+aIRfYbJ5gUZUxEf43jZg+4KepjOtEQhh
         55H3lK+KgcZ1d7Q3SSmk0N17aAdnOI4Qa1p/FuqHmrPQIh1lbJz/occCirYTYDrgKxD8
         jJGntFI/4+pnhHnIBpKoh5g6KgFdhqti0p7h2XoTVibDq0hPavGpk0EEehecwlrffICm
         KHGeEsYL+AswwpNcEKW5bU+xn1pquWIljukEC+Uxuam/so6LweLfXmhZnZU1Saeoh4v1
         N/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=mjyxBXO/Q67LRq7q+ZBorUGhYnfrQtLaOy8OBVlG140=;
        b=JNGdRxxWO70LrUMge8nkdY8FXW/Q+tzoyOfO1eGyEmCncIu8334KFYlpNNEtlOqzs+
         1HyNgnVgPmLxgOjUdBBwo6u8yxTXkClfoFxbx8WmQHe8gxKz6ljhM1/RQ9WM96r+p0Yo
         gi4ZjQXK63vA5CVOWUpnbAsdGYaJ4Dqcd3PZs8d0l9Q6rUb16LUILDAX/Ws+YVaFT80J
         DffYjlDKYHaa+Pfcb28VBV0SzOmdzWqwvujIlVlX0smouy/0KYJjuc6pw6/w/U336arK
         LczJt6Qu+xzpd2kICY8ZM8Bgs8lVqDT47KBG3vLtfjoKEDLepRmdN5nkCphsvTkYciX3
         EPBA==
X-Gm-Message-State: ACgBeo0XkvPgFfWSDZHXQnRL78BnQdvYGqsAcGXhjDcQwdIYMSPmEeiY
        FS4rAnxnstzg47CZjTo3HY8=
X-Google-Smtp-Source: AA6agR6qq4YcMkEbcA5+7zBxHq8O9aW0qY3pSFt9zfDM97Py8ROxWb4KpCLD6KfVfOJ2vCmikicNsw==
X-Received: by 2002:a5d:6c63:0:b0:226:dc02:2a75 with SMTP id r3-20020a5d6c63000000b00226dc022a75mr10358609wrz.185.1662038399439;
        Thu, 01 Sep 2022 06:19:59 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g12-20020adff40c000000b00226e5e07fe9sm6171721wro.10.2022.09.01.06.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:19:59 -0700 (PDT)
Message-ID: <a6f68650-678a-ab5f-a432-87fab8821dc2@gmail.com>
Date:   Thu, 1 Sep 2022 14:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/3] add -p: detect more mismatches between plain vs
 colored diffs
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
 <25187c3a3c2bb440ab0af34011db41361d4e2496.1661977877.git.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <25187c3a3c2bb440ab0af34011db41361d4e2496.1661977877.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 31/08/2022 21:31, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When parsing the colored version of a diff, the interactive `add`
> command really relies on the colored version having the same number of
> lines as the plain (uncolored) version. That is an invariant.
> 
> We already have code to verify correctly when the colored diff has less
> lines than the plain diff. Modulo an off-by-one bug: If the last diff
> line has no matching colored one, the code pretends to succeed, still.
> 
> To make matters worse, when we adjusted the test in 1e4ffc765db (t3701:
> adjust difffilter test, 2020-01-14), we did not catch this because `add
> -p` fails for a _different_ reason: it does not find any colored hunk
> header that contains a parseable line range.
> 
> If we change the test case so that the line range _can_ be parsed, the
> bug is exposed.
> 
> Let's address all of the above by
> 
> - fixing the off-by-one,
> 
> - adjusting the test case to allow `add -p` to parse the line range
> 
> - making the test case more stringent by verifying that the expected
>    error message is shown
> 
> Also adjust a misleading code comment about the now-fixed code.

Thanks for re-rolling, this looks good. The commit message explains the 
problem well and the fix is good, I especially like the fact that you've 
added a grep for the correct error message.

Related to this we also have code that detects over-long output from the 
filter, I'm not sure if we have a test for that but I think the 
implementation looks ok.

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   add-patch.c                | 5 ++++-
>   t/t3701-add-interactive.sh | 5 +++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 509ca04456b..34f3807ff32 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -592,7 +592,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   			if (colored_eol)
>   				colored_p = colored_eol + 1;
>   			else if (p != pend)
> -				/* colored shorter than non-colored? */
> +				/* non-colored has more lines? */
> +				goto mismatched_output;
> +			else if (colored_p == colored_pend)
> +				/* last line has no matching colored one? */
>   				goto mismatched_output;
>   			else
>   				colored_p = colored_pend;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 3b7df9bed5a..8a594700f7b 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -761,9 +761,10 @@ test_expect_success 'detect bogus diffFilter output' '
>   	git reset --hard &&
>   
>   	echo content >test &&
> -	test_config interactive.diffFilter "sed 1d" &&
> +	test_config interactive.diffFilter "sed 6d" &&
>   	printf y >y &&
> -	force_color test_must_fail git add -p <y
> +	force_color test_must_fail git add -p <y >output 2>&1 &&
> +	grep "mismatched output" output
>   '
>   
>   test_expect_success 'handle very large filtered diff' '
