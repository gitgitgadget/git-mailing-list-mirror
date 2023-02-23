Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55192C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 19:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBWTcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBWTcH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 14:32:07 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F003B23E
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:32:06 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y14so4794851ljq.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lQyQAFEVGTu2lIksW1V2dCc/gMR6R42ZWTJFCXBZxkQ=;
        b=AFAkp/GzGiCom3Q51hFVQffF+JaN0pUAien+dKbb3aryW6G8HZuvthEDzqVv08i+4z
         4xvtkpMpzlQMp9Ta2JewBWIdGdHeZgfdB/ZRtvBUOKoVT1aEgTnc7JIALTOt1WsZwWsS
         92jekpRVVfE03l54KPGyI08ylMdxpzbzNaJlkt36/NBeqg0tgeyTWY8IXa0/Auat86vT
         4fcTkQFHL34qX1yoKvrffFY5EJTYGedLTXkxWuBB9zr0m29AyiXXneVa1rxumRHhtxXI
         LEWmz5rAGiyE9jd2NePpSMs/Erj3ERUhy/XX3tOzALRbKoq2jODRTRWNyOin9/oD9iQ6
         64mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQyQAFEVGTu2lIksW1V2dCc/gMR6R42ZWTJFCXBZxkQ=;
        b=rqepNRmU9JoFJ3Zi/nNT7Ip05PheY5kbgjtelA5bIzDjEqHbrYLXpA07uHy7YFqp3b
         KUGXa/CzT95PXZkBlPBcvSHWeoUKJPtgnizv4tEXV1fIVsJ+7eBq7qsUcNlnbhxTz1w4
         RzcJ9qnT/7v3YBwwPCHBRmvvpuzbh7En6l4s4SF5sgvY7aPOF+kMPAVn0vQ/1utKZBYs
         PccWukKuZxBAV5l58Be7lftfemHWGOs9RX15Ot6vTqb9SdHI1w3Dy81PsYNWwZDAxM/w
         lRIUYhH6+VIFZ6V5urRBgh4oEvS6VYJ1xBMT2JGi7Z7ByI2gSAy0Uv2aZrRu9jSs9LHL
         HTtA==
X-Gm-Message-State: AO0yUKX/Js4bZmK2Iiegd6WYZA25SsqEdWhJLZ9AijUNwFrZz7h9hmRw
        XSxeTJbkYIe4EKG3xEW/6SXIXDABUr62gT35/xxoZVSCDdc=
X-Google-Smtp-Source: AK7set+iTwbDdb1sBFn6rAzpf3nAYrwXz30ijVsNNyP/LOsjbgxbK34RTe6GHaNmqlgONjn8m1pGjS3KsxWwsuzKAcI=
X-Received: by 2002:a2e:b5dc:0:b0:293:34ef:355b with SMTP id
 g28-20020a2eb5dc000000b0029334ef355bmr4072670ljn.6.1677180724457; Thu, 23 Feb
 2023 11:32:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
 <c9b1b27809298eb1b7a8c5e48866637268dc12a1.1677139522.git.gitgitgadget@gmail.com>
 <22ca24ee-39fe-013a-494a-ed7f140210fa@github.com>
In-Reply-To: <22ca24ee-39fe-013a-494a-ed7f140210fa@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 11:31:52 -0800
Message-ID: <CABPp-BEDwrAdT4wzA0JMt2jSQNK+wTfBeaEnhau3AE0+spwsFQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] hex.h: move some hex-related declarations from cache.h
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 6:11 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/23/2023 3:05 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > hex.c contains code for hex-related functions, but for some reason these
> > functions were declared in the catch-all cache.h.  Move the function
> > declarations into a hex.h header instead.
> >
> > This also allows us to remove includes of cache.h from a few C files.
>
> > diff --git a/cache.h b/cache.h
> > index daf6150bb3c..d0619ce2e63 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -13,6 +13,7 @@
> >  #include "string-list.h"
> >  #include "pack-revindex.h"
> >  #include "hash.h"
> > +#include "hex.h"
>
> Adding this to cache.h is definitely safe, but it makes it so .c
> files that consume the moved code do not _need_ to include hex.h
> like I think you want to imply at the end of this patch.
>
> What changes if you drop this from your change?

I need to add a #include "hex.h" in 171 C files.  I was worried
previously that the sheer number of locations that I need to add such
a header would cause my series to heavily conflict with next and seen,
but it appears that these changes do not introduce any new conflicts.
So, I guess I should have done it all along.

I think I'll do that in a separate follow-on commit instead of
combining it with this one (so that this commit doesn't become
excessively hard to review).
