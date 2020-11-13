Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CEEC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F9922240
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/ynM6Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKMMHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgKMMHv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:07:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F9C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:07:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so9591262wrt.4
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ZUKx50NxPLS51v01gbn9G3aVafoQcyQJMt5c7Kp0KI=;
        b=B/ynM6GmLvg2OC6xfqtD9XU2/2ifJ+3lSZmaCS5nDfhplkARueMwnaRPtbbvaWrPMg
         r40h4mAU3KEY8zZds2Ccjz0Lq/3AeDhLXFa+y2pUoq127WACVmyyHCwJkPgU2sS5e7dg
         JbsLaTU3aUKZk24nzwMCI8IlqKfSAdpW3G8Rra6gEDqzybm6CdyLZ17EwduVMjpAQnlB
         NozBVsOKozQyiSjuY/2A/IEqY2P095GWEilIXn3n/5cx2Z8xOWtxuBfpEoIdSEOi0Cn6
         eqb2BmZbdiDDrYI0K0boM47HsURHAsPQwBIpE9pZ/SvVocu8UgHxUtBG9t122I+ogug9
         WWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ZUKx50NxPLS51v01gbn9G3aVafoQcyQJMt5c7Kp0KI=;
        b=F4xf1uHgPNrC4BFHXNbFKz99+uM1txBayJiw/fSATcEKbgzn/Xz2JVHuiwLbpHO9jn
         y6LDy9ciG4AaTSUm1bmc9Mquley3IJ8b9Xz+GfSanh3CqBzTs7zKHXoMP6MVAMJAeHWe
         4vQrBSS82p2TIHIpJG6CVl2CI4n/dTHGWp5kwnFzboPonwJvX6W3Xr62sf0Oyv4vsnqo
         HWwYaXAJy4lHs1978jkCeCfCWAUHOqm8RCgtU3OwyAnXySLwcZl3E6NkDwi3B4Xl/SeL
         gJRulrW1K5Pc/HUyKgjo8xJi0opogJz5k+7E7UqYeRoqBhJa7PgD2PsGED8uDONuTO2W
         q30A==
X-Gm-Message-State: AOAM533IMxPVTzQFntsL5x9MZyeNO6U0vNwR2lE6PgmFsCguYi68ObhU
        kaEYdu6SFQfz6bHp/xYBPQg=
X-Google-Smtp-Source: ABdhPJyi9C+iyMdJ0WUb5gqO2TRhC+EUMnnGRUTJvjZ6Pj7Jr4O5R/MROQLzji0d6aZkVrYfqxKy0g==
X-Received: by 2002:a05:6000:372:: with SMTP id f18mr3306531wrf.149.1605269269522;
        Fri, 13 Nov 2020 04:07:49 -0800 (PST)
Received: from [192.168.1.201] (194.55.7.51.dyn.plus.net. [51.7.55.194])
        by smtp.googlemail.com with ESMTPSA id z3sm10099070wrw.87.2020.11.13.04.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 04:07:47 -0800 (PST)
Subject: Re: [PATCH v2 07/11] add -p (built-in): do not color the progress
 indicator separately
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <73b6d60a801766605cde9403d7a9e8451ef99e11.1605097704.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <918a0a1d-6384-5615-c343-1f03046770f7@gmail.com>
Date:   Fri, 13 Nov 2020 12:07:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <73b6d60a801766605cde9403d7a9e8451ef99e11.1605097704.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The Perl version of this command colors the progress indicator and the
> prompt message in one go, let's do the same in the built-in version.

Why? the C version has access to an api that means we don't have to 
remember to print the reset string each time so why move away from that? 
I don't think it matters to the user that there are some extra escape 
codes in the prompt of the C version. The answer is probably "so we can 
use the same test as the perl version" which might be a good reason - if 
it is I think it would be helpful to say so in the commit message.

Best Wishes

Phillip

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   add-patch.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index bf89c43145..2fad92ca37 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1461,15 +1461,15 @@ static int patch_update_file(struct add_p_state *s,
>   		else
>   			prompt_mode_type = PROMPT_HUNK;
>   
> -		color_fprintf(stdout, s->s.prompt_color,
> -			      "(%"PRIuMAX"/%"PRIuMAX") ",
> +		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.prompt_color,
>   			      (uintmax_t)hunk_index + 1,
>   			      (uintmax_t)(file_diff->hunk_nr
>   						? file_diff->hunk_nr
>   						: 1));
> -		color_fprintf(stdout, s->s.prompt_color,
> -			      _(s->mode->prompt_mode[prompt_mode_type]),
> -			      s->buf.buf);
> +		printf(_(s->mode->prompt_mode[prompt_mode_type]),
> +		       s->buf.buf);
> +		if (*s->s.reset_color)
> +			fputs(s->s.reset_color, stdout);
>   		fflush(stdout);
>   		if (read_single_character(s) == EOF)
>   			break;
> 

