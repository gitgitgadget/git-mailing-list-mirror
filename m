Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF57C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EF0611C3
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 09:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbhIQJMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 05:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245552AbhIQJKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 05:10:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFCC061766
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 02:09:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e7so9035917pgk.2
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 02:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CcK1jKc83g2lPh1KW+suk+Y9UBoLOTdJMFF3R0FrXfM=;
        b=nXCoObkRDvtX7952XF2QO7mWWThRSyYta5Ee5oLJhJKIXOSqzpPYtsL9GDIEpSEpyE
         67EuIUpdpWwLt+H+0Hl4J4gd3ZJRaZHGUV9LKk+2i0MIiHLrHkWYQtRVezC9OGCUpIfu
         23orVt+1c6QakDi3pG9zaqIsJsjM9lMvq8XVm+d9scL68TDpddH20RP+617wd3H8SxP3
         tpW+8vd3/aW6+OkOTZT/rrX0zisk2+K8TBOMRJHt9mAXnmT3H5ktuzcgTxTn1X1pGUcX
         V/bdletfocNyaqnVcS3VirQsZvpcfn0zB1zzsJ1mLRI67aqo27HUKOid6dcw2wZotyJ7
         Xr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CcK1jKc83g2lPh1KW+suk+Y9UBoLOTdJMFF3R0FrXfM=;
        b=bFeqhoh/oyiKDKjBoZxoNQwMQzVl2M5qMQi+1ygk0O87m6N/rQnzKG8rjoXmCUyMOA
         76mBDT4CXx8+l2HIL/P01Egu8qv7KthgKWGin37rZSCEL5mZQZLpas0hQnHWwZG0KynT
         hLDAn3OOjEM4p7A1BKdhvdUiYqUJpeJ2cKphHVr+oiAEwNZh9Gbl9nY5LL107W0ZEmJD
         MLHBQ8lCAAZE1j7Y9BB4z7xoI+M0Dfnt9g5jlxGt4K2aPe/7fkqFl7oifnLi8afueRhA
         20QhdoK9DjP9AZH6cPhM4lTk4XQMZ1lNJOs/oG5gjidpOUYwjh6WJ1L7trbGUF06p+cw
         Cg1g==
X-Gm-Message-State: AOAM5335x50d9LLWTmZv8CvkAkkDQsFOH1wXFacR7GCvNFjIgHOJc7sJ
        jxgdo9Qdk0O78txmbvnczNkDzP5K3P7gX+i03w/i9UqH9x4=
X-Google-Smtp-Source: ABdhPJwR+XgzHC7FPli3KSM4nLr5TftUeUuusb1HpIV8+k8wjyTsNJLJUxOgMaOarYcRz7cemFjXe5EmAoE0XJbe/E0=
X-Received: by 2002:a63:b70b:: with SMTP id t11mr8969224pgf.476.1631869749596;
 Fri, 17 Sep 2021 02:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210917085623.rjpmqqhb5xap26jd@pengutronix.de>
In-Reply-To: <20210917085623.rjpmqqhb5xap26jd@pengutronix.de>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 17 Sep 2021 02:08:58 -0700
Message-ID: <CAGyf7-E7PcRGiEd_U5bcw1na7H0LGDMw81s4SUDE=DH+4G3QYA@mail.gmail.com>
Subject: Re: git repack -A -d doesn't remove objects found in alternates?
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Git Users <git@vger.kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        =?UTF-8?B?QmrDtnJuIEzDpHNzaWc=?= <b.laessig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 1:56 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> I wonder if I do something wrong, or if I just don't understand
> something:
>
>         ukl@dude04:~/work$ git version
>         git version 2.30.2
>
>         ukl@dude04:~/work$ git clone https://git.kernel.org/pub/scm/linux=
/kernel/git/torvalds/linux.git
>         ...
>         ukl@dude04:~/work$ cd linux/
>         ukl@dude04:~/work/linux$ du -sh .git/objects
>         2.6G    .git/objects
>         ukl@dude04:~/work/linux$ echo "/ptx/work/user/git/linux.git/objec=
ts" > .git/objects/info/alternates
>
>         ukl@dude04:~/work/linux$ git repack -A -d
>         ...
>         ukl@dude04:~/work/linux$ du -sh .git/objects/
>         2.6G    .git/objects/
>
> I would have expected a drastic size decrease from git repack after the
> alternate is added.

You're missing -l on your repack command. See git help pack-objects
and look for --local. Without -l, repack includes copies of the
objects you're borrowing, so your pack size doesn't change.

Hope this helps!
Bryan
