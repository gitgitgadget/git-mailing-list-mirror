Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A1C46467
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 14:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiK3Oge (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 09:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiK3OgY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 09:36:24 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2C2CB
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 06:36:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so1565289wma.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 06:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uhjeUL2NDrmG4wzDv6U1eMxrSpR/bzz9c35DnRAJhqY=;
        b=bPLrVeBlX19Ckw2jAVP/5QWWr2beETjmGZa6HYrTWIajkhaEqf3mvUDM0fj0Axaepq
         1U+zMKKHiaOr0/B7xSifsVivZ+T1cB0m5rJ8v03tRziiAhF9q8uo52q63cye0sGC5Ra0
         g+fUR+KBi5WCrUURSAmhe3ycU5y2npcF+VVJg7PMqJFbTvMsMBkGkqUyrKJExsG7zq3f
         VE1+ORoMOA9lOhyJHg0PbfSxPI5QFlio18x1TsQtl2Wok/9Ik/6/PyoDObdm9IdXm1M9
         Yis8T9Ql14fCEhxyGn4BbxI4qpsF0j6RCjN9nRYGlrsZUCkjiCt+YMEfTtNC/qhiEa+3
         /G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhjeUL2NDrmG4wzDv6U1eMxrSpR/bzz9c35DnRAJhqY=;
        b=HanxIHjk4WsFaXm2h92PHvN6Gib9R5RXE9Rs+EBTRPDTdEkTh80KtbGan08Yw7SI9T
         rsbSPuXxBoDYE6Od77rZcUm3ebW10CirpjPVMwVuLYDVWU3UWrTsWeBkVtw9Kv1bxWMi
         6OQmdPF11fx1WF41cMcTEi6mXWApVKLi72eaNEegdsEzaAJy+mO7xx2OfnBRcEaNXS/e
         kxTI3WlYwbiyGrrpyyGwqg6VsThYSlLLevtRQpIYODz1/hfiIK/xjZW6DrB+2Wenr3T/
         x/ToxuUfAwEVhskWWwfKjVZAkn5zpqEgknh0Cw9asFkcjH3+sssBWp6cW+XsD7+J69li
         K8SA==
X-Gm-Message-State: ANoB5pk0EzJLg+5vi+wPV8g8wIeADbJMY4OiO3BFzkdRCTN+tNKtkivr
        838XYlZpc4va+qRcfDhQU5U=
X-Google-Smtp-Source: AA0mqf5bFs+rTgf++0ItVKSlUVMMx0C7Ly3MlcNEbkUryRoQcWYQ5XaW+xnTmuqucjJKwIEXTcSQoA==
X-Received: by 2002:a05:600c:3d1b:b0:3cf:670e:63cc with SMTP id bh27-20020a05600c3d1b00b003cf670e63ccmr50414354wmb.150.1669818981615;
        Wed, 30 Nov 2022 06:36:21 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id q128-20020a1c4386000000b003c71358a42dsm8139242wma.18.2022.11.30.06.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 06:36:21 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <19f91fea-a2a9-7dc6-d940-cc10f384fe76@dunelm.org.uk>
Date:   Wed, 30 Nov 2022 14:36:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/5] diff-lib: refactor match_stat_with_submodule
Content-Language: en-US
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com, myriamanis@google.com
References: <https://lore.kernel.org/git/20221020232532.1128326-1-calvinwan@google.com/>
 <20221108184200.2813458-5-calvinwan@google.com>
In-Reply-To: <20221108184200.2813458-5-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calven

On 08/11/2022 18:41, Calvin Wan wrote:
> Flatten out the if statements in match_stat_with_submodule so the
> logic is more readable and easier for future patches to add to.
> orig_flags didn't need to be set if the cache entry wasn't a
> GITLINK so defer setting it.

Thanks for splitting this change out. I have to say I find the original 
quite a bit easier to read. If you're worried about the code added in 
the next commit being too indented perhaps you could move the body of 
the if statement into a separate function.

Best Wishes

Phillip

> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
>   diff-lib.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/diff-lib.c b/diff-lib.c
> index 2edea41a23..f5257c0c71 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -73,18 +73,25 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
>   				     unsigned *dirty_submodule)
>   {
>   	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
> -	if (S_ISGITLINK(ce->ce_mode)) {
> -		struct diff_flags orig_flags = diffopt->flags;
> -		if (!diffopt->flags.override_submodule_config)
> -			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> -		if (diffopt->flags.ignore_submodules)
> -			changed = 0;
> -		else if (!diffopt->flags.ignore_dirty_submodules &&
> -			 (!changed || diffopt->flags.dirty_submodules))
> -			*dirty_submodule = is_submodule_modified(ce->name,
> -								 diffopt->flags.ignore_untracked_in_submodules);
> -		diffopt->flags = orig_flags;
> +	struct diff_flags orig_flags;
> +
> +	if (!S_ISGITLINK(ce->ce_mode))
> +		goto ret;
> +
> +	orig_flags = diffopt->flags;
> +	if (!diffopt->flags.override_submodule_config)
> +		set_diffopt_flags_from_submodule_config(diffopt, ce->name);
> +	if (diffopt->flags.ignore_submodules) {
> +		changed = 0;
> +		goto cleanup;
>   	}
> +	if (!diffopt->flags.ignore_dirty_submodules &&
> +	    (!changed || diffopt->flags.dirty_submodules))
> +		*dirty_submodule = is_submodule_modified(ce->name,
> +					 diffopt->flags.ignore_untracked_in_submodules);
> +cleanup:
> +	diffopt->flags = orig_flags;
> +ret:
>   	return changed;
>   }
>   
