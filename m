Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE6C6FA83
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 14:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiIZOtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiIZOr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 10:47:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB045041
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:13:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x18so10150060wrm.7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=5QU4lzq4QANV8wholwTsG7ZStwuESs5qEuwwTHeAAUM=;
        b=H6M76RD+2OhCntem33V8EFyd5nzCBqfZq2N68i8t8q0WuNcTvpo5IidkifrHtUAyBL
         114m6Xsc/uAx4MkvkBQ5R+5DEIywq7+SG7WMNBkOoV/Ax1cI9oSLNUwxlkMZ0nJo0+QT
         fU0ZAwyOZILs9p9iZA1pBi2sAqIoRj9rnpaKmNLSR0tUuNsnUeOO6fwZyRC/b/89N++y
         RIFoGLq9lwDeNMa2OBtuv/pjSqj60azqL3yfBcFjlPad5UzOgm1asNqyjokXTVUbBaY6
         +2ve6AgZrU7b6W4eH0HGa4z72FXYh0da/j3kCmy+GElUpo26mIUF5m0uHyHdmZfjz7I2
         XKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=5QU4lzq4QANV8wholwTsG7ZStwuESs5qEuwwTHeAAUM=;
        b=zh/PZMYjmCCCJ9aEwCHhXUKUzK8eiYgHdlP5q3pAQCrGk7yEwSVzGYgkS3pIuAwJ0i
         uR4XV/xRVhwbbXwayXfiVV3aNxHh0danMjR+UhTQZbmwkyk/nBBUBCwoEc18oeZJY5T2
         0W3r/bWiFfJ6s0/98L1BqQWLJk7EsWzLCi7wsWEpctIeOiRs33GiqIt5cUyJcPaPKZd1
         mhfxZ02g1qb6vGucjhJtqc6/GffD4+pabUmGS68xELl67l559flRanapA2zZsM3ZV0ox
         dibMH87k0qy3d6mEC7A922y9lFRVnHmk1NtAoRgMqYQIFqnU0pqpGd0VAVjaHs1i6ods
         6LAg==
X-Gm-Message-State: ACrzQf2ki/ONYXiwpoyUz5r0HfptmAiHcZxgy4lVW9Cabsp+4VgFOG+s
        2r5k5JR8x10J2Z4goHocN2Q=
X-Google-Smtp-Source: AMsMyM4uVagGmHYKiYdS7VcA98nYgDzPVHdDhdnCDwwDtw4OG2wS9K9ih33qObAeYJV2HAjIi0TuaA==
X-Received: by 2002:a5d:4c4c:0:b0:22a:35bd:84a9 with SMTP id n12-20020a5d4c4c000000b0022a35bd84a9mr12690073wrt.103.1664198031084;
        Mon, 26 Sep 2022 06:13:51 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id j16-20020adfea50000000b00228dbf15072sm14410876wrn.62.2022.09.26.06.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 06:13:50 -0700 (PDT)
Message-ID: <fc291c07-55e9-64f8-1251-20bd2422024d@gmail.com>
Date:   Mon, 26 Sep 2022 14:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/10] ref-filter: add the metas namespace to ref-filter
Content-Language: en-US
To:     Chris Poucet via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Chris Poucet <poucet@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <54e559967df55ca314e629b65927a88c7f804a98.1663959324.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <54e559967df55ca314e629b65927a88c7f804a98.1663959324.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 23/09/2022 19:55, Chris Poucet via GitGitGadget wrote:
> From: Chris Poucet <poucet@google.com>
> 
> The metas namespace will contain refs for changes in progress. Add
> support for searching this namespace.

I assume this is to save having to write "refs/metas/" when we want to 
search for meta commits?

> Signed-off-by: Chris Poucet <poucet@google.com>
> --- > diff --git a/ref-filter.h b/ref-filter.h
> index aa0eea4ecf5..064fbef8e50 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -17,8 +17,10 @@
>   #define FILTER_REFS_BRANCHES       0x0004
>   #define FILTER_REFS_REMOTES        0x0008
>   #define FILTER_REFS_OTHERS         0x0010
> +#define FILTER_REFS_CHANGES        0x0040

It would be nice to keep FILTER_REFS_OTHERS at the end I think (we don't 
need to worry about abi compatibility), also what happened to 0x0020?

Best Wishes

Phillip

>   #define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
> -				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
> +				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS | \
> +				    FILTER_REFS_CHANGES)
>   #define FILTER_REFS_DETACHED_HEAD  0x0020
>   #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
>   


