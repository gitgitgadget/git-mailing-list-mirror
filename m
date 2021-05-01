Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9E9C433B4
	for <git@archiver.kernel.org>; Sat,  1 May 2021 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E6561449
	for <git@archiver.kernel.org>; Sat,  1 May 2021 19:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhEATE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 15:04:59 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44751 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhEATE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 15:04:59 -0400
Received: by mail-ed1-f49.google.com with SMTP id bf4so1793602edb.11
        for <git@vger.kernel.org>; Sat, 01 May 2021 12:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hKa/LqwloOr4BoZQ6uUikd12tQEZE5OvBt+wMH8o8w=;
        b=eeLCjjzCJG0L8/YMgflnQ3fSIQI0S1X4SGaFaPM+e41Yp+gqT8lW3p2exYNu6sOAt1
         /T/WRqug/lU79e3XkOqVy6Y8OYyPdlMaTdgQ4hm9FCmRt/iFjR+YIXcMHuxk3goUAT/9
         tZlSBHaLWLPc0BW8sJNzcsmmd+0i1KNV/uok9rdudyBhLRf71kq38rfr31O4/+HYCoPm
         Jsp8ytfJ4ufuKRF+BaufObso/pfGptWUtyFahISowoZoLAv5FXoWaD4mZMaG9X6d2x6h
         M3cYNWpYDhR0hWwjYz4fHvq0CXj9h5PzuKbe44M4i0qfBXbFPMN9/AOkBf1mHtrLmxcx
         3Olg==
X-Gm-Message-State: AOAM530KP9858SnqUdu2YBrqVazPZGekSyE6mXHRAlrJmV9AY3gcH8cl
        WyoIkSD2mp+GjIlKKydc1B5ofgh9BgZq0/4fHL0LIaz3IGY=
X-Google-Smtp-Source: ABdhPJx5PDygx7JPv4+tfq6uT+UEDqW/ygai1J+uoVd2w1Izeedqzg/Ms/9DwFlw0vgHzSfW8f8dzgQ0fX1LmZjYYOk=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr12536177eds.291.1619895848073;
 Sat, 01 May 2021 12:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net> <YI124aZ1dbY5O67J@coredump.intra.peff.net>
 <CAPig+cSxB89mJcjaoLMLEgqdqi9SSP5+R9qjbVydvA-kVq-2+g@mail.gmail.com>
In-Reply-To: <CAPig+cSxB89mJcjaoLMLEgqdqi9SSP5+R9qjbVydvA-kVq-2+g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 May 2021 15:03:56 -0400
Message-ID: <CAPig+cQFUUncb17MFAvJAh2KFxK_OCq_6AoOwPViYyQJUDVJNg@mail.gmail.com>
Subject: Re: [PATCH 5/9] t7450: test verify_path() handling of gitmodules
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 1, 2021 at 2:55 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, May 1, 2021 at 11:42 AM Jeff King <peff@peff.net> wrote:
> > +       tree=$(git -C symlink mktree <symlink/bad-tree)
>
> `tree` is an unusually generic name for this now-global variable. One
> can easily imagine it being re-used by some unrelated test arbitrarily
> inserted into this script, thus potentially breaking the following
> tests which depend upon it. I wonder if a name such as `BAD_TREE`
> would be more appropriate.

I see that all `$tree` references get encapsulated into a shell
function by the next patch, so perhaps the generic name `tree` isn't a
big deal after all.
