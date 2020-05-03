Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD13C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 10:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDAE2075B
	for <git@archiver.kernel.org>; Sun,  3 May 2020 10:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogY+lKTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgECKQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 06:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728018AbgECKQ4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 May 2020 06:16:56 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891CC061A0C
        for <git@vger.kernel.org>; Sun,  3 May 2020 03:16:56 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id m9so5419181uaq.12
        for <git@vger.kernel.org>; Sun, 03 May 2020 03:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSMcPvqoozr0q60z3+Mxu8KvWBbkCLURADCj4saVy7U=;
        b=ogY+lKTWVm9l5MVxswaQDvl6Z8PGY1gzSSX5KfihKoG3krx3e8yzX38adxYvTSEIf/
         zIiq24Mx18zVgO1M4Ws7QfcbSF3hGgdtghyPmHIBtFGc5x56jFYt2JfS4TEDt1geR/Fv
         1LgfsYXvxYVQe6Qp/EgQF3wz9C0XXMebiq7+EfEz+85DGvKVxDrKOzLTH01Yriclja1v
         JR4qxUZthHneuNnDA9GPZqqoEpQ7gwbMsdKBL5D9XtBpfsG4MNNyQDrq9zfvNJahpYzx
         IEImmpjnthQX+f+dbvELih8AUfWyiAJM2qmB/RoXflHNfmXfOcaxnsdOxcRpvQvPBZRW
         er4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSMcPvqoozr0q60z3+Mxu8KvWBbkCLURADCj4saVy7U=;
        b=iqyqCCopiMn1YyibD5CWyt9bcChUZol67tn/m1zlTfOTobNmW3x2hfdTryoELEM0+r
         xgbNAptN+Ox7JfQ9TMfGSX+oO+HfTgio8f963aWbY3jde7fEhyW7eFHdNdhtvfA+7JNA
         96RYTmsyrhuaHYJN5LJq7bm8eNyxnUXxmYbGD5vHQFU3FNFnIOdRfl5R8/iiasbCAmvb
         flbyVBbTRkgqAQWRMOJvVE0Cispn9BOdkoqEeeJSbHP7WWYFgZ2dkfJ93Wku4ofZQIup
         m2ATpFwn4GRcUESUkbC+kGAeq/rvXK1qpf3UEedZS/5Vj/TxvswVo4abl1U0awoke8TB
         bCyg==
X-Gm-Message-State: AGi0Pua8mILTnR1QA/2P8dwHFbJwY7w930MpgX0Ibx4nMQup9X9cX75E
        tghfx9Ca9HL/h57wnBnWHV1/avNxggoVpzMqTN+CCQ==
X-Google-Smtp-Source: APiQypLDUgSMH1OpjYnk10WYkOneZZGP0FnUSn90Hb6jR13KXPNNT61Vg/0SpUATTcZx+Cw8gPec/hlI742x1dx0HbY=
X-Received: by 2002:ab0:328:: with SMTP id 37mr8136915uat.112.1588501015602;
 Sun, 03 May 2020 03:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqZTUvuJgZH-YUxDTYunng3QD4-wwPgquZX1P=1P1R=Ku0s2g@mail.gmail.com>
 <20200503090952.GA170768@coredump.intra.peff.net>
In-Reply-To: <20200503090952.GA170768@coredump.intra.peff.net>
From:   clime <clime7@gmail.com>
Date:   Sun, 3 May 2020 12:16:44 +0200
Message-ID: <CAGqZTUvaiDQbiQ1dOoqLcy+GHZg+BuXY=Z+S=Dpsq=wm44dGaQ@mail.gmail.com>
Subject: Re: git for-each-ref - sorting by multiple keys
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Awesome, thanks!

On Sun, 3 May 2020 at 11:09, Jeff King <peff@peff.net> wrote:
>
> On Sat, May 02, 2020 at 10:31:50PM +0200, clime wrote:
>
> > I have the following command:
> >
> > /usr/bin/git for-each-ref --merged="${GIT_HEAD-HEAD}"
> > --sort='-taggerdate' --sort='-*committerdate'
> > --format="%(*committerdate)|%(taggerdate)|%(tag)" refs/tags
> >
> > I thought this will use: -*commiterdate as a primary key and
> > -taggerdate as a secondary. According to man page for --sort: "You may
> > use the --sort=<key> option multiple times, in which case the last key
> > becomes the primary key."
> >
> > But that doesn't seem to be the case. I created a repo with a single
> > commit and created annotated tags on the commit in the following
> > order:
>
> It looks like this has been quite broken since 2015 and nobody noticed. :(
>
> Thanks for your reproduction recipe; using times is a critical part of
> the bug. Here's a fix, plus a fix for a related bug I noticed while
> working on it (the second one fixes your bug).
>
>   [1/2]: ref-filter: apply --ignore-case to all sorting keys
>   [2/2]: ref-filter: apply fallback refname sort only after all user sorts
>
>  builtin/branch.c        |  2 +-
>  builtin/for-each-ref.c  |  2 +-
>  builtin/tag.c           |  2 +-
>  ref-filter.c            | 13 +++++-
>  ref-filter.h            |  2 +
>  t/t6300-for-each-ref.sh | 94 ++++++++++++++++++++++++++++++++++++++---
>  6 files changed, 104 insertions(+), 11 deletions(-)
>
> -Peff
