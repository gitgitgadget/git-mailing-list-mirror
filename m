Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91985C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 04:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69FE661B39
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 04:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbhKREy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 23:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbhKREyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 23:54:21 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5FDC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 20:51:22 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id y5so10923855ual.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 20:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpqz6T3hZXPS7tbF4RLxIusRscWdGkLe6UdLAszOra8=;
        b=pLFV7udMu8rBhMzk6HAUa6EPwDjQYTqMpZCjlSLJrzvIluR1oh/euylLjZ5i+6IKpt
         AHTU4re1N4Q8VCGxQJx5z23mIcjasaLcDEwIOTVfpd/lmt5DeQcL3O6JRqw2272uvUvo
         c+3J25kKUS/0pkH2G247hbMu8ajWdbHe0P9A3+45WUieljh1NsB+tN6xIRqdLgfhgB8C
         h+7rf6gkQkrVu6seQVgA6SB3URLa37zrcOht50BYabFNGLYQKWqvEM9lrhlyWxp4FsBp
         2b4hSWO2Vl8runqClp7YR1xONQSF6ECJLFjaibcMlDjQkdT4n0aN8RDeMRv0txDHWgSM
         8E4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpqz6T3hZXPS7tbF4RLxIusRscWdGkLe6UdLAszOra8=;
        b=BrwIaZF35AfVj4gInJYdEudziIQyHkYjgi1cOtYW2dut+2e+cHoU0WaJ2C0CTNNM7g
         4yOMuB2UZbvCbR2sIWnn+SC8wDeEPotlhBb9jt9fRoVbpNy2e6iy4PICGBHSwDggP5D2
         +fmWdvcmXvAhxc7sUrVV+9gwYFA+b74e6N0J8co1jLC1FNoQq932H18GFUvDdQb7OD8E
         fdotDuLAh4T9Wok3oKXn6F1H454gm4Uz3neFQUCqpdrpHSLHLZEXl0GDtPRhy5iyEGod
         BdbgbhQ2s44q4pMht7ZX9vcplXtChZa9ExNChi/NsXs3KObEFZ06kKXhJFoNy1wft1pd
         j3Rw==
X-Gm-Message-State: AOAM531HbVjUA1FZYEqeCcUJF7TkMLLQ4onbHZVrKKW/jLXEQfVZvNjY
        YZCCXVpCtGx0hL0N5hl6E5GnFcUNN7/p11kI27HKjUPjhN8=
X-Google-Smtp-Source: ABdhPJz+f0cefuA+n/uAXxeK0+BgW6UvlIYKQrSuUDAc1x5vCr8s6CDZZciuCrNdRAHxuDy4Xul3Lsv4iEnEgPqfZwI=
X-Received: by 2002:a05:6102:512b:: with SMTP id bm43mr77656964vsb.14.1637211080671;
 Wed, 17 Nov 2021 20:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20211005063936.588874-1-mh@glandium.org> <CAPUEspgLwLxavP3bC9OEJQTphoemQ+jxv+9Nkcvbf51uaBEpww@mail.gmail.com>
 <20211118030255.jscp2zda4p2ewact@glandium.org>
In-Reply-To: <20211118030255.jscp2zda4p2ewact@glandium.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 17 Nov 2021 20:51:06 -0800
Message-ID: <CAPUEspg-5+YdfTJ6zi9hdDqF=KV2LJFCtqmECSss9Kfpn6sGrQ@mail.gmail.com>
Subject: Re: [PATCH] Use mingw.h declarations for gmtime_r/localtime_r on msys2
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 7:03 PM Mike Hommey <mh@glandium.org> wrote:
>
> On Tue, Oct 05, 2021 at 12:12:12AM -0700, Carlo Arenas wrote:
> > On Mon, Oct 4, 2021 at 11:57 PM Mike Hommey <mh@glandium.org> wrote:
> > > A possible alternative fix would be to e.g. add `#define _POSIX_C_SOURCE
> > > 200112L` to git-compat-util.h and add `ifndef __MINGW64_VERSION_MAJOR`
> > > around the definitions of `gmtime_r` and `localtime_r` in
> > > compat/mingw.c, since, after all, they are available there.
> >
> > something like that was merged to "main"[1] a few months ago, would
> > that work for you?
> >
> > Carlo
> >
> > [1] https://github.com/git-for-windows/git/commit/9e52042d4a4ee2d91808dda71e7f2fdf74c83862
>
> Since this reached 2.34

It is not in 2.34; only in the git for windows fork, but agree is
needed if you are building master with a newish mingw

guess I got the perfect excuse to get myself approved for gitgitgadget
with this PR[1] then

Carlo

[1] https://github.com/git/git/pull/1142
