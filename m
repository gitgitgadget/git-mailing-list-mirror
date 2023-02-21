Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9969AC61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 11:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjBULBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 06:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjBULBk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 06:01:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6F23303
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 03:01:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j3so988539wms.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 03:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8aPLVXt9VAdmg24Wd7l/gstxT8IzZpEzIgEOC7LNaxU=;
        b=fa/FQFYOwJeKtYaEojvMTWJ80kfUpTnl62n+nnY7sI6Jz3CxliEEZLx9+zMA4jB4bM
         2oU3aD6YoJ5qwDxqI3xzu4VGdxh17IJvRgY6eYgg7oe7CDh56pRRpR3d7zfqmRb18Ljh
         qPxmRrx1tSMMZmT6e48IW9OLubGlimF02LiLsXeddTxwNbgOrxVnHTbPJJKIAg+6KqWz
         uk1nCkJXWkZhYjqezsL1xA9c5353dbELZX7FLOXmsmXTPZE5G/AMyULQ7ngSwc7m8YQ6
         Shpfp/KLIsTUFLM5W48nlGVc3adjdvRN70YMykiTM1gsdNoTE9EcEcS3mV1GhliHJmEd
         cVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aPLVXt9VAdmg24Wd7l/gstxT8IzZpEzIgEOC7LNaxU=;
        b=U95OL6vGtUrd4mGO0bNx4h9c+WrUlXsbMYSmOXgeay+AsxQMu/Mu3BVCyUXlfFrlAr
         IB35yvs9M/CRF/R26Fn8F4TJoc7C6mWgYNADYzvl4M5TG6lWeuKRigacrEMqXcMMzh8b
         rEZ8vgzDrmA/rISIoIkgn2BvCatTveEqU/HR/llSfxJ/2rUolgK+0Kze69m/dT4p13lH
         +amRePSLRYuiUW2dF9nss+PThlPrSPQU3u5sOjX7H/IjCez3KU4ffGj0YL01OCZnVKPT
         hzsvrDEoZk+8bYDgotygg1Y4Imn4d0NPEmP9Dwe1Xcf/jDdESs2Wa3RZQTtsrR11bO6J
         +gHQ==
X-Gm-Message-State: AO0yUKXsgC18b0uYA+++XiEZf+nS9X1IYrYIM7xKSmsvJLZhf9hkCpDM
        T6zCj759Jc/5Sp4oodV5Y4o=
X-Google-Smtp-Source: AK7set9YAS4O/cJeaeXcu/GwUk9GnGFmJXmNJd0fw0I3CrT0fBxptIBRr/yfWnG9+8RTl0FpU/3UFA==
X-Received: by 2002:a05:600c:2eca:b0:3df:f7e7:5f01 with SMTP id q10-20020a05600c2eca00b003dff7e75f01mr9370845wmn.15.1676977297521;
        Tue, 21 Feb 2023 03:01:37 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id 15-20020a05600c020f00b003dfe5190376sm3302159wmi.35.2023.02.21.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:01:37 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f67126c0-82d3-bbec-89e8-fbe3ec84e04b@dunelm.org.uk>
Date:   Tue, 21 Feb 2023 11:01:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] rebase: document the --no-rebase-merges option
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
In-Reply-To: <20230221055805.210951-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

Thanks for working on this series, I think it is going in a sensible 
direction. I think the final patch needs a little bit of work but 
they're all looking good.

Best Wishes

Phillip

On 21/02/2023 05:58, Alex Henrie wrote:
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/git-rebase.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 9a295bcee4..c98784a0d2 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -529,13 +529,15 @@ See also INCOMPATIBLE OPTIONS below.
>   
>   -r::
>   --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
> +--no-rebase-merges::
>   	By default, a rebase will simply drop merge commits from the todo
>   	list, and put the rebased commits into a single, linear branch.
>   	With `--rebase-merges`, the rebase will instead try to preserve
>   	the branching structure within the commits that are to be rebased,
>   	by recreating the merge commits. Any resolved merge conflicts or
>   	manual amendments in these merge commits will have to be
> -	resolved/re-applied manually.
> +	resolved/re-applied manually. `--no-rebase-merges` can be used to
> +	countermand a previous `--rebase-merges`.
>   +
>   By default, or when `no-rebase-cousins` was specified, commits which do not
>   have `<upstream>` as direct ancestor will keep their original branch point,
