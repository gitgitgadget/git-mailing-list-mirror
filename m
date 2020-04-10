Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E213C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 06:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6523920757
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 06:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLPJ0cZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDJGrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:47:13 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41855 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgDJGrN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 02:47:13 -0400
Received: by mail-io1-f68.google.com with SMTP id b12so860363ion.8
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 23:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2BPN3bJOkuF/xSdQkr/5eL+Cd9LoX1fcoFnFEOHCgs=;
        b=NLPJ0cZql7HlNlWu5Z7zvETvHqmHLZaMsGuxO/VIYNhVo/hlcClIg+NiZmmZGSiwVX
         OrFsGUhFqM40tt3XwmeHeIELXDKbwXQK2B2QKe3JidELXIBc85Rn4bAwLANG8bpDYs96
         +K0pmfmL7I7RpSbhs5aTWmQQDS2YVOLo3nA79AFX7EyN4+H4ZTj5EmNdzz/GcccT+vXn
         VmmliLHdbQA0nYqjmOeLz7lDBEd/PvG0QGY2Jv6pr9h4sf2VXW7deIk1o2PqkHjnbsV4
         dmTTIgb4ZVhm5I6vZ7cQ1xEBZtYroBEGXnsUVF5YZ4S4SHIHCii0lhyj0EgApqn4f/sc
         cR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2BPN3bJOkuF/xSdQkr/5eL+Cd9LoX1fcoFnFEOHCgs=;
        b=WFAmuBgS807++oZ1280uOtvScy4yKp3jz2yXXIqpXROo9Zsu7s781BIQe+9at88gSF
         av5/Rw2LgK4+7RI+U9CIg02dHKighlhJEhh29c6alsWuXfLHweR/q+mL21RUK5rvw9pi
         eozoh5ZjE8OehwmQzfEqTwieDG44hATIBJbRUJRXXK9Z2wJ674fT//XU6QlJSxKkTTGi
         BoiZr8X82FtO/kfh8kxu0kkPVfPOxZoZFxu+Qzz3JDYMxXJ8Qi+VC8OKHZGVmMUw6odS
         SusdkUKQp37he+fkWJ3iSkJDMnQWrcvnEtf7oTPJ1t1VK61HpHWAdODGrYTPIAHYLiLn
         YzqA==
X-Gm-Message-State: AGi0PuZeEbzrekg5C455ST7fSv2ZTZOtjIQK3EcS2CHc14KwR1tnKPws
        ejTG2R46PZOATJ4mtqvPcAC/XNrvO/ttccxz7YIazg==
X-Google-Smtp-Source: APiQypJt8vyLLsKQoB0p/ky20jmmVHA8g04k14e7iPdyUS7RTslv+UxAZ5p3Td+1bkHMhGRvpm+91QHc42Zw7GMO3xY=
X-Received: by 2002:a05:6602:2182:: with SMTP id b2mr2941239iob.19.1586501233366;
 Thu, 09 Apr 2020 23:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAG5PFTvqnR-aeJ=+4W5A5WKqJ8Wq3JsD7J5QjwprE+Nws+=YBg@mail.gmail.com>
 <20200409235719.GA46281@coredump.intra.peff.net>
In-Reply-To: <20200409235719.GA46281@coredump.intra.peff.net>
From:   Erwin Bonsma <erwin.bonsma@gmail.com>
Date:   Fri, 10 Apr 2020 08:47:02 +0200
Message-ID: <CAG5PFTs5CbB0+JY5qgqL91fSziNwNNEPfL8tKv30NAZGtNtWeA@mail.gmail.com>
Subject: Re: Commit includes rename which was not staged, nor actually performed
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Thanks for the analysis. I am happy to hear that it is fixed already.

Btw, version 2.24.1 with the bug is part of the latest XCode release
(11.4). Hopefully a new version of XCode will be released fairly soon,
and will include an updated git version. Otherwise, other macOS
developers may experience (and report) similar issues. I will at least
report this issue with XCode.

Cheers,
Erwin


On Fri, Apr 10, 2020 at 1:57 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Apr 08, 2020 at 09:28:09PM +0200, Erwin Bonsma wrote:
>
> > The branch includes the wrong commit. To reproduce it:
> > > git reset --soft HEAD~1
> > > git restore --staged de.xliff
> > > git restore --staged Pending/it.xliff.todo
> > > git restore de.xliff
>
> There was a bug where git-restore didn't correctly invalidate the
> cache-tree extension of the index, and could cause phantom changes to
> end up in commits.
>
> It was fixed by e701bab3e9 (restore: invalidate cache-tree when removing
> entries with --staged, 2020-01-08), which is in v2.25.1 and up.
>
> -Peff
