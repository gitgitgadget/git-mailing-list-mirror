Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BADC433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C29561432
	for <git@archiver.kernel.org>; Sat,  8 May 2021 06:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhEHGko (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 May 2021 02:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhEHGkm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 May 2021 02:40:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E787C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 23:39:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g14so12749428edy.6
        for <git@vger.kernel.org>; Fri, 07 May 2021 23:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diP8UKnhYMLcl/3rLSz2PITEf6tTZncV6Y62z8gPaBY=;
        b=IDzPYorcjeu4xlXDqcbF3XZ2kyw7zydkuHUbrIjUD960FLLJlHVyHxsDXsQlxii2PY
         zCQbrGK7qdQ6QeLKYBQ/0/QtqX/evyUGIjmCJRNOllJwLuE3rJy/WlBYl1nXi6QCJDf4
         eSxvDfdnuukWxIFUSd5cjbSavJq0dKf8gb8stoo7RxvQJzMyMWEaeNnM9HBBSyYP3sg5
         yHW0MUpbgM/nJMGHe+XJiSn/9FjoAQVYCsZ4ybmFBMy6qUkemN7pdOWy4wPAfsec2OvR
         2w2v9HCyp6faxAEoAsJTm8xyw6MzGMAZlM2zyA89TghzN5jjkGQ9+y6NfOJhvZOeuEmh
         NEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diP8UKnhYMLcl/3rLSz2PITEf6tTZncV6Y62z8gPaBY=;
        b=p1J3FpJG+qXG4FVqmQ6j4RsVa/lBAxbq/BK3ImB/rpGeqwfPyzmgxr1fwt4CsFfCAq
         aIYjAVqab/RSeAfMvNPUxYg+zulTAMOlA8h01Csgi28Idr660fyOvIUCcXNjG4FYUaYa
         i4xq0cSbQdZdULsHQBPbQAqjOiJ0fBOB3DdnN/YhKIcCMt05vRyykiiwIDQ2M/y5X8h4
         K6O2Zv1CUN2PLBwuNEU6CBpcbZxivuOJPIoueaZ00cpa/NSyeSXnnlasbXcBMt8uPZFT
         fPDx2A1dNJnFsZen7bDpkXnK+BKX65/4LYcDYmkdq+IYmD4KbbeR0YHtu5zeTUAS/LtT
         6+tQ==
X-Gm-Message-State: AOAM532eX2Rz7xqvrL5tKvMSJpE6gHqbETCfPn68jELGo2yG6iGs/LJc
        4lxgOQd6naHEMBOyoCK8JynJshp6zvoLHIIoOaRVVbqGAdK9Ow==
X-Google-Smtp-Source: ABdhPJz4pCWrUP47/MftbXT1aANR67YmGZdmGulqL+MpE2GTxI7QQD5bodJ0h0UDt+OSCU4Pk+IFn80m8OcVJ50L7Go=
X-Received: by 2002:aa7:d90b:: with SMTP id a11mr16283818edr.273.1620455979920;
 Fri, 07 May 2021 23:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210508022225.GH3986@localhost>
In-Reply-To: <20210508022225.GH3986@localhost>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 8 May 2021 08:39:28 +0200
Message-ID: <CAP8UFD0vp-zZv=Q1+KWv8PHnxTuspTw2aSCUp8QUic0HOSyq4w@mail.gmail.com>
Subject: Re: Preserving the ability to have both SHA1 and SHA256 signatures
To:     dwh@linuxprogrammer.org
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

(Not sure why, but, when using "Reply to all" in Gmail, it doesn't
actually reply to you (or Cc you), only to the mailing list. I had to
manually add your email back.)

On Sat, May 8, 2021 at 4:25 AM <dwh@linuxprogrammer.org> wrote:
>
> Hi Everybody,
>
> I was reading through the
> Documentation/technical/hash-function-transition.txt doc and realized
> that the plan is to support allowing BOTH SHA1 and SHA256 signatures to
> exist in a single object:
>
> > Signed Commits
> > 1. using SHA-1 only, as in existing signed commit objects
> > 2. using both SHA-1 and SHA-256, by using both gpgsig-sha256 and gpgsig
> >   fields.
> > 3. using only SHA-256, by only using the gpgsig-sha256 field.
> >
> > Signed Tags
> > 1. using SHA-1 only, as in existing signed tag objects
> > 2. using both SHA-1 and SHA-256, by using gpgsig-sha256 and an in-body
> >   signature.
> > 3. using only SHA-256, by only using the gpgsig-sha256 field.
>
> The design that I'm working on only supports a single signature that
> uses a combination of fields: one 'signtype', zero or more 'signoption'
> and one 'sign' in objects.

Here I understand that your design doesn't support both a SHA1 and a
SHA256 signature.

> I am thinking that the best thing to do is
> replace the gpgsig-sha256 fields in objects and allow old gpgsig (commits)
> and in-body (tags) signatures to co-exist along side to give the same
> functionality.

Is this part of your design, or a, maybe temporary, alternative to it?

> That not only paves the way forward but preserves the full backward
> compatibility that is one of my top requirements.

There has been patches and discussions quite recently about this, that
have been reported on in our Git Rev News newsletter:

https://git.github.io/rev_news/2021/02/27/edition-72/

You can see that, with the latest patches (not sure the documentation
is up-to-date though), signing both commits and tags
 can now be round-tripped through both SHA-1 and SHA-256 conversions.
How isn't that fully backward compatible?

Best,
Christian.
