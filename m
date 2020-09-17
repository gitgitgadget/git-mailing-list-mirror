Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE49FC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762ED2076D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 09:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY0ymolM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIQJoK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQJoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 05:44:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4095EC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 02:44:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l17so1768163edq.12
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AfVaDuppuvyzpvfIZqz11Rbv6bLsaQHem4nrnWPSszY=;
        b=bY0ymolMrY1tKRDdq0XhP8vZXJtu14IzjpifVtVlxvw3qU+CpEqBYflH7U5bGlFcEZ
         VrY2MTDEXrDok4lvtGuHyrSZevEUAnPdF+OxVT2guMPOMRblGU0oyVCJoMh1yvz4GJVi
         aiDVcopXxCv/qNCT/XBMqkCHlkYLivrPlzIytMSRvOErR8bDzQjZoAmGRLX0n3XY3ZLW
         i1GMXHt2J+sskPg1IZHdkEJQQXh/hzepOqD3+AJ4gQub1xlQme9XknvM48clMmNqauP+
         PMv5OrjtwEqnAzxmUvKZ6uZP7DFJ2+oOQD9SwEagC2DH8IFSqa3bdT9KI4zPuONDGp6p
         MiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AfVaDuppuvyzpvfIZqz11Rbv6bLsaQHem4nrnWPSszY=;
        b=hYXcJgzBqNOZoey43FiqDAB8tfIcChbWOKkjsbwGyYPwgm0+luC0tq+ABeW1Lbqwkr
         9cYIZxnPEJGJHb4+nVIajHNu1ro5Hh1rE0Xm8XpfGGWviaDU5nyGHRly6/BrsM9akuSV
         o6uOcqsZGtIsqsFG8mnUOo1XPuooHUeH3Z3C/O/w+vXCkthEFCIiUo2T5xnc5Zt1+Ngt
         7tKBLgHYITTm7/bQnQPVN63GC2qwuardR6KqBqOXCEKBK4YvsFRebYHd3MmQJ0ztg78G
         GZnxI0J+l1BNWWJ7uSrs+KdZ7lbUB3/x36z3QehIiaphUKMmBauBkLppPu9wCcrGyRXr
         qZmA==
X-Gm-Message-State: AOAM5332381rRZB0LcqMar7PMnW8CbSnnZ8/t0s0k9Xsv+lkfq7VGWfB
        4nEQBNuAVkr9yoVOsqX+eVBbXro8ikI6c1bz5yHirwWKFjR0eQ==
X-Google-Smtp-Source: ABdhPJxNPfoxalgoO0KttjgNAdvnNg4xjxGjJ6YCN3oibb3dXcYkdgghEswIMVUSQ1SkHeupADMv5t9mkJWUal8AOt0=
X-Received: by 2002:aa7:d750:: with SMTP id a16mr32875613eds.362.1600335844084;
 Thu, 17 Sep 2020 02:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet> <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
In-Reply-To: <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 17 Sep 2020 11:43:52 +0200
Message-ID: <CAP8UFD1n_PYzygFCgNDt3T=EQhbcuaTYFCfNN5n45OHRh45KOg@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 11:01 AM Christian Couder
<christian.couder@gmail.com> wrote:

> On Wed, Sep 2, 2020 at 10:50 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > As to projects, I would like to believe that
> > https://github.com/gitgitgadget/git/issues has grown into a useful
> > resource.
>
> Thanks for the useful resource!
>
> I would be interested in mentoring, or better co-mentoring, the
> following projects:
>
> - Accelerate rename detection and range-diff
> (https://github.com/gitgitgadget/git/issues/519): ideally I would
> co-mentor with someone a bit familiar with the suggested algorithms.

Proposed on Outreachy's website:

https://www.outreachy.org/outreachy-december-2020-internship-round/communities/git/accelerate-rename-detection-and-the-range-diff-com/cfp/

> - Add support for drop!/reword! commits to `git rebase -i`
> (https://github.com/gitgitgadget/git/issues/259,
> https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/)
> - Invent a way to retain reflogs for a while after the ref was deleted
> (https://github.com/gitgitgadget/git/issues/236): I guess this might
> be implemented as part of the new `git maintenance` builtin.

I will also likely submit a proposal for one of the above projects.
