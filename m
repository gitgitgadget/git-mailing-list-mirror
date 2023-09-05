Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD07BCCF9AA
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 16:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjIEP7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 11:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354877AbjIEPZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 11:25:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2348E128
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 08:25:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so26403115e9.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693927538; x=1694532338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vb7nj4Y0YPLgpF5IDu5+rmBX2C1pF/lTDZoTdo4uUTE=;
        b=MAKkj1eP7KMVCl2tKR6AbMsLaXqzYV9TVwMkf7VUbAGURj7+r7eN9iOS02IZgXnEsE
         UMs3qJPo5Oky6GJdk/Ur+NfOnD28voZjBDamDiKkT3khtbOOOiS2qq1pSXqoQ8IpENHs
         afoOinTAaUt2gNrYUyxSgOrTjMQ9f6B1flBSJaJzfS1PLw2YuvsuwpLN4in8mj7NqoEO
         5EGFCC7I+C8bSs8OKNmCFQWNV6bRPQ2tdAMss8KCFHlQ0GQ/QLGpd0YxOSUqVvcdC0HJ
         pvoVQbUcZ+X7wc0/qij99Ip+tzDOf81zLIT0N8XQkiiHFd5WFbP06cFKZFIP6p9Hjmdv
         MNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693927538; x=1694532338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vb7nj4Y0YPLgpF5IDu5+rmBX2C1pF/lTDZoTdo4uUTE=;
        b=Ll3WfhKZbvpLt3xqjbvKvefjX0iSEYlgWASlUHVmvSdZWHgXGsz7UcQIGh6KTbSqP8
         Dq1xp6njnpTwKUhUj9H8WeVWHgD0dhwnYUBrpM5V52GJkzzbvF5/08dGkugCKP75Jjww
         WTSacPDNZvhUsF0CemsKm8lumCyiC/fSJ0ScvAY4eEQj0y2tMEAEmZPWAm4gv41wMpQM
         p/MGRUifNpX9LNroD4JWD7ttXEeP/ejQycfLPBWE/aW68CezNDq7zJLrXKZnFzUYOIoI
         brwMWufkJ7khOMSpJsx6OCq9Mzo0fwNcu+sL843OxUNbRQb9dzjC4VpX5W33UYMcLTu5
         kxJw==
X-Gm-Message-State: AOJu0YwV2KkwBgFF6QMyNslEnPCWaECKXWU6sGFwOjfzUIqyiUjfN2NZ
        QQw2Ao+nhjKm3JOsw87gqIw=
X-Google-Smtp-Source: AGHT+IEczUnrDrn14+BKhriuxSAE5Br8tIaPVlgRB+3A4oJ9AyDIWTelg9EuXHhppYIF5RIRDrZd7Q==
X-Received: by 2002:a5d:4fc8:0:b0:31a:d8be:d6f4 with SMTP id h8-20020a5d4fc8000000b0031ad8bed6f4mr123853wrw.10.1693927538111;
        Tue, 05 Sep 2023 08:25:38 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id n4-20020adffe04000000b0031779a6b451sm17837963wrr.83.2023.09.05.08.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 08:25:37 -0700 (PDT)
Message-ID: <84227916-92d9-4085-9738-29d7e489f144@gmail.com>
Date:   Tue, 5 Sep 2023 16:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/7] rebase --continue: refuse to commit after failed
 command
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <2ed7cbe5fff2d104a1246783909c6c4b75c559f2.1690903412.git.gitgitgadget@gmail.com>
 <a5bfea5f-0d0d-f7ed-3f72-37e3db6f5b2c@gmx.de>
 <02c28b26-4658-43c8-b1d1-7f1e09bda609@gmail.com>
 <87fbc8c9-f42b-b374-fee1-57c58f5e8fc0@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <87fbc8c9-f42b-b374-fee1-57c58f5e8fc0@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 05/09/2023 12:17, Johannes Schindelin wrote:
> A further contributing factor for my misunderstading was the slightly
> convoluted logic where `is_clean` is set to true if there are _not_ any
> uncommitted changes, and then we ask if `is_clean` is _not_ true. Reminds
> me of Smullyan's Knights & Knaves [*1*].

I agree 'is_clean' is confusing (I have the same problem with 
merge_recursive() and friends where a return value of zero means that 
there were conflicts)

> With your patch, there are now four users of the `is_clean` value, and
> all but one of them ask for the negated value.
> 
> It's not really the responsibility of this patch series, but I could
> imagine that it would be nicer to future readers if a patch was added that
> would invert the meaning of that variable and rename it to
> `needs_committing`. At least to me, that would make the intention of the
> code eminently clearer.

Inverting and renaming 'is_clean' is a good idea, I might leave it to a 
follow up series though.

Best Wishes

Phillip

> Ciao,
> Johannes
> 
> Footnote *1*: https://en.wikipedia.org/wiki/Knights_and_Knaves
