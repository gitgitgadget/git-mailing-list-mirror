Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F846C25B50
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 15:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAUPV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUPV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 10:21:56 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9880A2A981
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 07:21:55 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so20813463ejc.4
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 07:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YUjdXI4y1CU13ughjr/jYnwYLArLQPsmRkintKdKT8=;
        b=OKKI+bMxJvkITs7CVK01YXSNnFELgnwbtnbUnL8TrJB/K8My4CC4XV0TmLKa37gUFc
         AS9Z61ftkBR/i8rss0MnVr3WMs+isTDgBB0onEJQcJVg7pWGG/6yQw30rzvFiZVsNf+j
         Cv1S5z85a8Rc6b9O8GMAsGseW/9rb/KJ7leh8WV4/B6xN1HX4iis+qTK9cDp16J283fG
         QmwrJlPTJDyJdlDGmeqKS+zQIKvc11FeVDhNifY+EJtbutVQNlBmzBhEjyvtmPKZhr+Y
         hF6wQ/hkpa33b6AYjbJq8oEuDcLqsHBOH90Zmwz5W7yOPLrKcNbfoy3eY5fchkvM/43H
         0Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YUjdXI4y1CU13ughjr/jYnwYLArLQPsmRkintKdKT8=;
        b=2mjWe2dYHpM9tocnVEeNumn6696c6hKVsMG8JcGFWCAxlFitQm+2LPzfFNfwSQIbjS
         fwclSCXlr1yGFdRKlIW/zNs4+E5Ex7bOdHTX8bMEiodqTGKWx00cFgdWwhZUCOQ8WSas
         ZDRmAyjq6dlZzRXsScsIMwd4alqs+0QKLONLa/Vd9WIzbYB5WmF3zlycXpaZwFeRRbh3
         OBOahLiJisgDrd1Tu816Wtl+TByDab5UMvreE28Q7wIP8Quhhqq11i/+aEfCokV9q+Xx
         /Cclj+v1sxZm3961AL8BxHy3YPzFXAkFD9MpIud0v3cAwck56pAHVVjXEx7Aflv2+eTy
         nJdA==
X-Gm-Message-State: AFqh2krEN7tc3BtrKkXNgdeRvD0gi7uX2DY8TMhGvkSr2dn22JR9Ncsd
        e16gS9PlsmJZNyn91pCND04vVBhE6Jg=
X-Google-Smtp-Source: AMrXdXudAO2hisKtuJmFJRSUpjOHCnIqWzwwGLQ8YdWd8TEsGVpWzJ2BhZmJQDxWqlGp6sInlrKzVQ==
X-Received: by 2002:a17:907:6d87:b0:84d:3fa7:12e5 with SMTP id sb7-20020a1709076d8700b0084d3fa712e5mr25602158ejc.32.1674314514226;
        Sat, 21 Jan 2023 07:21:54 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id k22-20020a17090632d600b00780982d77d1sm7802715ejk.154.2023.01.21.07.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 07:21:53 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <878097e3-7a74-6b7d-40d6-90f31558f8ad@dunelm.org.uk>
Date:   Sat, 21 Jan 2023 15:21:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 7/7] rebase: fix formatting of rebase
 --reapply-cherry-picks option in docs
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
 <0e8b06163f2b21748a19f32d515aecb16cd4574b.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <0e8b06163f2b21748a19f32d515aecb16cd4574b.1674266126.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 21/01/2023 01:55, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Commit ce5238a690 ("rebase --keep-base: imply --reapply-cherry-picks",
> 2022-10-17) accidentally added some blank lines that cause extra
> paragraphs about --reapply-cherry-picks to be considered not part of
> the documentation of that option.  Remove the blank lines to make it
> clear we are still discussing --reapply-cherry-picks.

Thanks for clearing up my mess!

Phillip

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-rebase.txt | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 00a9e22bc32..140c984d0ea 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -331,7 +331,6 @@ See also INCOMPATIBLE OPTIONS below.
>   	upstream changes, the behavior towards them is controlled by
>   	the `--empty` flag.)
>   +
> -
>   In the absence of `--keep-base` (or if `--no-reapply-cherry-picks` is
>   given), these commits will be automatically dropped.  Because this
>   necessitates reading all upstream commits, this can be expensive in
> @@ -340,7 +339,6 @@ read. When using the 'merge' backend, warnings will be issued for each
>   dropped commit (unless `--quiet` is given). Advice will also be issued
>   unless `advice.skippedCherryPicks` is set to false (see
>   linkgit:git-config[1]).
> -
>   +
>   `--reapply-cherry-picks` allows rebase to forgo reading all upstream
>   commits, potentially improving performance.
