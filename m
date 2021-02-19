Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6827C433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA4364E90
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 06:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhBSGBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 01:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBSGBp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 01:01:45 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A83C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:01:05 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id h17so4780507oih.5
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 22:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4grvbthroDR+wqijgwT4q48GPuhllRmo0kazkr/5FE=;
        b=IP/J19Y1jy39mJyvnTX1Yp/JEh+0R00abcBMw2dSuc6g53GMEXcBRGtBVKLvf4HqaL
         cMRswfuuE/OKOiU5SN6Zb79z6hzAsJAwrW3FDVyYRePNRo1gMuiEmspuvpl2y9sk6Ohv
         FJdLlZ+MLb/OXQ1QQ9+hZJQvmoGgvWSohsndKZ4S/GxbQ8/uQlzHJ2QTOci402uKs8E2
         kCNup9T5uKEmYu/tn0Q3rzKaamzQ8mtZWbdCLiU/6EHkQzclTnOOWfIVDgqnnSXVAjov
         VI0I/Zt+52ZaU1mysMIIaq1y6FUYTMBvDuHGfYFLQfml3bIUNLZMkEPXyjov+t2FSu8c
         ws5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4grvbthroDR+wqijgwT4q48GPuhllRmo0kazkr/5FE=;
        b=AmqFfJTU6auN8UYelJcstxQbn6r1Bu8PsH05m/HrpSE9Q0PXgcL2lR9voCTK2ZFVkk
         sYfXBT3vJjLdeM3257nO0DnNeFlV3RLRTBBAuTg63yLUthtQ7anJqvh57VbpT/+FIuMv
         LJB574WaVPG3aU4vCjlDZdP73CUAPzL9XLUrTjYND1pOW/Xl+8NMziVLSrh05RrVFDSc
         R0tXhy+EppkZohNujwtni1K2yY80Mgj40bv34eo7UOSGN74t0C3Sf67P7oQRMD87SRe3
         aa2kEboK6lJxwoql7nSUQolROyeUBxgSqZgFd4aZkPUV4XQB5eBdIV9+COcf5y2G/KmJ
         zLrw==
X-Gm-Message-State: AOAM532/U8OGLEmQ7xELPvo4gprCw249+FoHeKi03HEE7ZkCoYuspa7D
        vFYd22SZ+FTBEtrBbtKNUwfZn7UYagIPj1wTYbs=
X-Google-Smtp-Source: ABdhPJzu45IPF9q23v8KslEzPIMDvlTGTBw3ffnwQfeESx5LIS0vOlAuSzM2sGSRD0DyN4OO/cL7KlvjHKePNXhGrWk=
X-Received: by 2002:a05:6808:489:: with SMTP id z9mr5524429oid.155.1613714463306;
 Thu, 18 Feb 2021 22:01:03 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com> <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 19 Feb 2021 11:30:51 +0530
Message-ID: <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Feb 19, 2021 at 5:32 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> I have just created an Idea page with 2 project ideas:
>
> https://git.github.io/SoC-2021-Ideas/
>

I just saw the "Use ref-filter formats in `git cat-file`" in the ideas list.
I would love to co-mentor this one, if possible.

Thank,
Hariom.
