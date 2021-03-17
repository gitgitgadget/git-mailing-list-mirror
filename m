Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0291C433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843AA64F50
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCQNoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhCQNnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:43:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2D2C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:43:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so2301715edu.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KsEuci+B3IoSSevu9Gtcxxk9igFqA0vdozdXPz9Tkao=;
        b=QKAj1M9z5YCzeNlvJBo1qhkKCN88ln0mnV/V3VDaYAascJZVYbeU1r1KWS6aXgYv1C
         OfV0JcjjPPpS90+KipcNdTkFsHeee7W9jjb/uW+/3tDq/yw02dXJWjqS9yXDVKoXCt8r
         3sLWFf9MuFg3bwNLaMolwDFZAEhXD8KZwG65YyQQDmjdj0fyBkxO7r/QQ6+rEGPPuEdg
         JrymG0+QqDGtlCzknA/x88ltoVIQj4nlvNXYIH4jS1C9q3bdEPPKD3/okgRX2sUngt24
         roQSz7gazgOtYQDFMsXjdvQCt/EicSjP8++lDwI2ZjB0rdWabHQVt1uUoCJxfE+wi4M3
         5/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KsEuci+B3IoSSevu9Gtcxxk9igFqA0vdozdXPz9Tkao=;
        b=Jtfgt3r/vxSDmXM9dATnp9jyBMlp4NC4aYPC2ppYW5mODRgEX64XBDJwXkysK3RvEZ
         /u6ngI+ACSRgaEB3yfq+Yp898vMiZwd9ggYPaWKyRDfHB1V/a6OhPcymoIwdoZbqFYTt
         s/1mc3unTptKhzkIvox+fAlYheckF6qKAHLpFXPeit/5g7hszqM1W6e/A1yncRkpKGJe
         O+R5ddqHh6z1kvofY1kt0U6EeLy7RDHUmTjImKU4RP5decKIdqqPBQiozekMeQqQqlZL
         lteyd1t4WxmStp8WO3AyaoCK4hN6bhwRiUhI7JHbaRPZpE9hDPxQGXzAtjmZdbEVsX1X
         WCGA==
X-Gm-Message-State: AOAM5331UoFdR8WQMpaiG3AzvVxdfVOiy9Bp2K76EQ30zZ96UPvWiNMv
        5P8XpX8jAT3lVJNtAY21EHa5vAlQ+c3/+A==
X-Google-Smtp-Source: ABdhPJzY+h8ferHXWSPyuFKonukCtkNnOWZeKfdpb7xNGkYM4xP/2CJ7itqXBWsIJl/Oxen5oULGSg==
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr42922299edw.354.1615988618427;
        Wed, 17 Mar 2021 06:43:38 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id eo22sm11651754ejc.0.2021.03.17.06.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:43:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 11/20] sparse-index: convert from full to sparse
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <e41b14e03ebb143c874cc276adcbc36059f0c64e.1615912983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <e41b14e03ebb143c874cc276adcbc36059f0c64e.1615912983.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 14:43:36 +0100
Message-ID: <87wnu5zyif.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:

> diff --git a/cache-tree.c b/cache-tree.c
> index 2fb483d3c083..5f07a39e501e 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -6,6 +6,7 @@
>  #include "object-store.h"
>  #include "replace-object.h"
>  #include "promisor-remote.h"
> +#include "sparse-index.h"
>  
>  #ifndef DEBUG_CACHE_TREE
>  #define DEBUG_CACHE_TREE 0
> @@ -442,6 +443,8 @@ int cache_tree_update(struct index_state *istate, int flags)
>  	if (i)
>  		return i;
>  
> +	ensure_full_index(istate);
> +
>  	if (!istate->cache_tree)
>  		istate->cache_tree = cache_tree();
>  
> diff --git a/cache.h b/cache.h
> index 759ca92e2ecc..69a32146cd77 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -251,6 +251,8 @@ static inline unsigned int create_ce_mode(unsigned int mode)
>  {
>  	if (S_ISLNK(mode))
>  		return S_IFLNK;
> +	if (mode == S_IFDIR)
> +		return S_IFDIR;

Does this actually need to be mode == S_IFDIR v.s. S_ISDIR(mode)? Those
aren't the same thing...

>  	if (S_ISDIR(mode) || S_ISGITLINK(mode))
>  		return S_IFGITLINK;

...and if it can be S_ISDIR(mode) then this becomes just
S_ISGITLINK(mode), but losing the "if" there makes me suspect that some
dir == submodule heuristic is being broken somewhere..

