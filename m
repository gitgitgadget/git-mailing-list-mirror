Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B15C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 06:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90BC6128B
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 06:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhGDGOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 02:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDGOv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 02:14:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E1C061762
        for <git@vger.kernel.org>; Sat,  3 Jul 2021 23:12:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso9339987pjp.5
        for <git@vger.kernel.org>; Sat, 03 Jul 2021 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AHGm6qPStwceeLZ21d/vo6gSWnvSQWYLxtWfYm16UME=;
        b=BaKqyqMxtL24qZZVa9YrNSE2DPv6iuvt+6eOGu7pCp2y9kKHsXNZkEOQPNtD+KSBLZ
         yr6pMOo/ACQzNFqvsbVpzM9TCfHB7g87ZMEGEio/PXNH8S1XFHCpi7rH0+19ae82yDTT
         cLBZsKbJMkBwEFS0WnBNSI1Jsg7V1Qy2YkZ+CNIFiwNTiVXhK2TghZudb/9M1Rr51X0x
         DOpyhxA7BcWQchCPvH2t5iDxQQbB6kGhmRUt265PhOw7Mhrg00dy5r4qVK+OVwmGoiix
         TWYS/IRGshpjj+wdJ8SXJDYHhpODbb62KsIPxRba0uPm/54PlKJzqh+CrNP+OR2bq19D
         3XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AHGm6qPStwceeLZ21d/vo6gSWnvSQWYLxtWfYm16UME=;
        b=KNR46w10ejRiz8q9wQuFYfkSy6UcFCx77225lGGBNC1r2gc0aXROaFIi1ZzfR6DN8H
         yVHtAFDfSFD/Dp+Z+t5EoPwiLJc+Ysaw7quCjc0tjXSxfzBYe7qUMggsZd7niJxawim6
         x+WkoVBsJOIHoZvP/j0JvTZ7DEPmSS0TJn8vkHEO1bmXZJVUDu8sbmKndMiqd/BOD/z+
         As3Ur+1+DtqEsaYICmAHSTlHxXnMG7z89WF5dYnIncI+Gw8C0CU6VBYFuMEfCHG/ZY27
         1bHqWojuY9SnzSCC9plzxW4Vscg0QJuwwiUKtvaLxI5++T8C3Rje5DSmv3JhjZHUwFkf
         1KJQ==
X-Gm-Message-State: AOAM533H7mKtu+jdO9lxgjJVMjNrPr4GzFRcLSGqcTz9vij2CL+0+MNb
        t+llleBOQyihiT+FNx1cgpK2XLEwoy01tw==
X-Google-Smtp-Source: ABdhPJyyD0++ZBsw1V8ngJyVZoOqTLTA3yhLlKLf8r+AxrOyDmphYvP8EDGbPi0itgOAzUtibghlbw==
X-Received: by 2002:a17:902:bd03:b029:11c:d504:c1ce with SMTP id p3-20020a170902bd03b029011cd504c1cemr6852807pls.7.1625379134991;
        Sat, 03 Jul 2021 23:12:14 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-81.three.co.id. [180.214.233.81])
        by smtp.gmail.com with ESMTPSA id v11sm6771172pjs.13.2021.07.03.23.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 23:12:14 -0700 (PDT)
Subject: Re: Logical bug during MERGE or REBASE
To:     Atharva Raykar <raykar.ath@gmail.com>, skottkuk@wp.pl
Cc:     git@vger.kernel.org
References: <1932019063.20210702192555@wp.pl>
 <3CD890FA-7A99-4DDC-9691-80D1ED6BD51B@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <3f09d890-e9b7-0e54-0d03-2ed7609cb448@gmail.com>
Date:   Sun, 4 Jul 2021 13:12:08 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3CD890FA-7A99-4DDC-9691-80D1ED6BD51B@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07/21 14.57, Atharva Raykar wrote:
> Let's look at the diffs (I have annotated this with arrows):
> 
> $ # common ancestor, ie, the first commit
> $ initial=$(git merge-base master dev)
> 
> $ git diff $initial master
> 
> diff --git a/program.cs b/program.cs
> index 8bc1a4d..93f872f 100644
> --- a/program.cs
> +++ b/program.cs
> @@ -1,4 +1,6 @@
>   {
>    Console.Writeline("1");
> + Console.Writeline("2");
> + Console.Readline();
>    Console.Readline();     <--- X
>   }
> 
> $ git diff $initial dev
> 
> diff --git a/program.cs b/program.cs
> index 8bc1a4d..eb91c97 100644
> --- a/program.cs
> +++ b/program.cs
> @@ -1,4 +1,6 @@
>   {
>    Console.Writeline("1");
>    Console.Readline();     <--- X
> + Console.Readline();
> + Console.Readline();
>   }
> 
> As you can tell, on the master branch, Git sees the changes as
> "lines were added above the line labeled X",
> and on the dev branch, Git sees the changes as
> "lines were added below the line labeled X".

What's the purpose of "X-labeled line" above?

-- 
An old man doll... just what I always wanted! - Clara
