Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E8CC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 21:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908DE611AD
	for <git@archiver.kernel.org>; Wed, 19 May 2021 21:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhESVts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 17:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhESVtn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 17:49:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49D5C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 14:48:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x18so6557668pfi.9
        for <git@vger.kernel.org>; Wed, 19 May 2021 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T+ooDvJFJWNVyo1Km70N8wFaBjxp+qtar7on9vxjNj0=;
        b=PvuBomFkbasMjg5ArAY21FFCc10b+VJwg0T7CH2oZQ3lMs07tw72CGHU4DJ8CGTHuK
         /VZHybxnKkSVMBsL3KUkHzqjbH3W5Ttan5Igoo8WXO6htTciFlZZ3YTp0LBzUk0xvjTx
         D+pf2R/0LbyfpK+9FJ4Q15TfCLhZlsQjbIv/gsW4ccoocNrXocIsZw405/yYIQaXGEYK
         LnLVR00BIXXu8NyI7ZvJMWeIkOqopgrq3DrOuGZqehzKxCxOqgV9hWv3XFHq0cE3XQhp
         j9aiWmpoFEAX2CHlkkhQlNLH4ojYThNg2JX26bQyQyk8MtipXfMotsVYvqtCF6vcwICH
         EWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+ooDvJFJWNVyo1Km70N8wFaBjxp+qtar7on9vxjNj0=;
        b=TqUesm9w08SFaE13VkIklQaLOT7Tq2QgAf9zzZiE2IuwV2q23eOBpAZpAwknr2IerL
         vIiOJyGjFA1ODjX5ZKrDLZiGUhXHBrspHM9JlDLLcDL5kBQOd65B9pGaJC7to4qUoAox
         SLOoN3plkZgV2flmuU/6MsSgo8qst6f9Xop/8Q7Gdx5KtwVeUOFd2AM8qiNn90MMh7V6
         LWKcR3kIQXEr7GgAGkHXCuK3C8LetUrGAOSQQJaJWnsGgCp+R0U8xmBVwY9KBFz6Hn8K
         pPw9NBUZQBjzn048sgmQwgzEhooI//D2FNCyLThNRXeIIxnrNWT0O/sqrbrxUlBatr7N
         jrIw==
X-Gm-Message-State: AOAM532xfpqXQEOPxDkArDUnyCltP8DwCyHlGYEqDH6VvG+2XTrNhCE2
        C7WmcQpARrN8O55XjrH2gBE=
X-Google-Smtp-Source: ABdhPJzhczq/qnh8xJtkDGrMm3glFhhiy5Yf+IvdycQwV4b72x9ALlUsgCTQgOTT9aCITm6U63Aibw==
X-Received: by 2002:a63:a602:: with SMTP id t2mr1193048pge.320.1621460902287;
        Wed, 19 May 2021 14:48:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id j3sm288327pfe.98.2021.05.19.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:48:21 -0700 (PDT)
Date:   Wed, 19 May 2021 14:48:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
Message-ID: <YKWHo9gZNp+i3fH9@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
 <20210510153451.15090-7-sorganov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510153451.15090-7-sorganov@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:

> Fix long standing inconsistency between -c/--cc that do imply -p, on
> one side, and -m that did not imply -p, on the other side.
>
> After this patch
>
>   git log -m
>
> will start to produce diffs without need to provide -p as well,

Personally I don't ever use -m without -p and --first-parent, so in
that sense this feels like a change in the right direction.

Does this also affect the plumbing command "git diff-tree"?  I'm
guessing "no" because diff-tree already generates a diff by default,
but it seems worth spelling out in the commit message to prevent
worries about the effect on scripts that expect stable plumbing
behavior.

Thanks,
Jonathan
