Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7183C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 22:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiK2Wdu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 17:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiK2Wds (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 17:33:48 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D7391EE
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 14:33:47 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v3so14381718pgh.4
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 14:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IdEdxr5z11aFc0ccKJf1/A/+M/5h3cbL+SEMots7I2I=;
        b=SfAvPDHIdpfGJUkrUk9vAP8MF2I3XlY50pc6o20T7mgUqP/L5YnTLpzjKdWyo9eLbL
         D65Pq49Lth5jYx22JWoZ9a93paK/OBa2eCfh7S6VDoZpeFQvpJPcCgJc1iJFkS4J02Xa
         jleYZ8g6gpfO4e+JCv6ZhLt4mIhNsHnPm8nlwKOUtGEREV7OE2SOi/BOPsgn6T6lhKmR
         Dy5nVkataEUD2LffbGPqJXM3st8EL7obQdSDiXl932M5jMDV6v44JbkZ5OmgwHVciYbt
         mMX50ifR6U7w78HaJuZBZUtizyuKcsOQrJhyjikU3sa4AndEMaaGpIofFi7j2ELbDED0
         +gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdEdxr5z11aFc0ccKJf1/A/+M/5h3cbL+SEMots7I2I=;
        b=m1WdGRXtMG8yg35LiqcnE9llbbTHBBEl5hqhfIvajQ8k5QU5pjhZUsMJF/LLbNLgrl
         /PGaTh+n8IQGu4ae/+vU5clnzDvYRKwPnC3tepl5KONNSamKWAFD925Ewc6W/lqShjUg
         dFEYR3q3jCqrntklwpfT6hZnIi6gvL1S/XPhbCR96S7P46vPbZRF4EVTKhINIk9A2O1B
         UVqk9LBjR8p3WjxvL0BmTZYdGR+HJ0noUKxrxHzWzhOEDMqGt81hToxHRtafumzlS9CM
         HI3TaD2EZ8KwGH/rxG98Sm7RBSs0Pl1pNVKJDdae9dWFIuPlsAZsDPJPB4qOxVcVC6no
         eYwA==
X-Gm-Message-State: ANoB5pkjsLxvpmpty5OAmbpd5PWo0Csluc/Z3I2SDMSRlrPUdDlVTFs6
        85EqLte58KV64vv6JIhORM51MJ5uGuqOBZL8dw0/vmoEeRw=
X-Google-Smtp-Source: AA0mqf6nscyYyeZElhO4B0G+EHK2WY0y7tFiInHI0D6uvSelF1F0WJtS0NURSKp+Z4o0AoQvjQU3CYH/WQ6uuXNNQQE=
X-Received: by 2002:aa7:9416:0:b0:575:518e:dc11 with SMTP id
 x22-20020aa79416000000b00575518edc11mr9227984pfo.86.1669761226971; Tue, 29
 Nov 2022 14:33:46 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8niurChnXPrZSeBa7g1z5AF3PqYdf1X0Rm03rDanec6Gw@mail.gmail.com>
 <Y4ZXRx4mf0UMk4H6@coredump.intra.peff.net> <CAH8yC8=zv30qNKVGZcT02hfTWgn4x1RCEUioB=jG9yq9X_Qp=g@mail.gmail.com>
 <Y4aEPpQsS8QxBYly@coredump.intra.peff.net>
In-Reply-To: <Y4aEPpQsS8QxBYly@coredump.intra.peff.net>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 29 Nov 2022 17:33:34 -0500
Message-ID: <CAH8yC8kpkcr3mk_XU-vz8QPX45O6K+bbfB8t_mRU37_R7=gDFQ@mail.gmail.com>
Subject: Re: Git port to Debian SH4 may have trouble
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2022 at 5:14 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 29, 2022 at 04:49:30PM -0500, Jeffrey Walton wrote:
>
> > > Just a hunch, but does:
> > >
> > >   git config --global pack.threads 1
> > >
> > > help? The delta resolution is multi-threaded, but nothing else in the
> > > clone should be.
> >
> > Yes, `git config --global pack.threads 1` allowed things to continue.
> > The check-out was successful.
>
> OK, that narrows it down. The question then is why threads don't work.
> Is there something broken with threading or luck primitives on that
> platform? Or are we doing something sketchy with concurrency that
> happens to work on Intel but not elsewhere, and we end up in some kind
> of deadlock?

Probably something broken with the port. Or that's what I would put my money on.

> I suspect if we want to know more, you'd need to use gdb to grab a
> backtrace for each of the threads during the hang to see what they're
> trying to do.

Yeah, so GDB won't install at the moment. I tried earlier today. It
has some unsatisfied dependencies. Failure to build from source
(FTBFS), iirc.

Jeff
