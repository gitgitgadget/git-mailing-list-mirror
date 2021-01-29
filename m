Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EC3C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D6564DE1
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhA2W3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhA2W3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:29:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAEBC061573
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 14:28:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d22so12376046edy.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 14:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tBgNMmTR4bz8PkKRlAzImrlIpWD4vA2Kp0+fZeTaweQ=;
        b=UsxUVJT+oBI+VeS57XR4d4vyT6BsUFXx9vJJ/7N5NWW0uXbDzfnQ1AgUXjQKNqGl7c
         WdyXX6BXrx2+xQDOgPqs8JlP3fgjKTeX5Gk+coy152klZzukyx4QGMA0zumIexRR7onh
         gwq8IUR+fm/ZGy4ewR/uUfhPfYWaeERySivkwKzYnUOiqxGAlydzOYcfmnxdIiIwT+lD
         vvTVEq2x6fm2ixhx87h69KlCIq/bw3LK7rGTtJbaw67/iNdWpAJ+UGmsJhi4iL52TzfM
         f7AM70wZfIGkONpjJ/B3tBSczqwJqBCTpCzEr+OrT1A8+q1klk5Ulx80VXR4/f4BUWHf
         GBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tBgNMmTR4bz8PkKRlAzImrlIpWD4vA2Kp0+fZeTaweQ=;
        b=tyXI5d3OSAm6p8smG8ZEEJth0dzthEC8vgBbkx4qJWgdA9oSw5iQYpkq6+r5Svm+Sm
         Ef7s30duYaAYRv5w4zofv6ZfHLX9ymyzpsIDpwxIMwhuop+eAcs3f8SGAZvpPErUis8q
         m7fK02RbIM42ETxEedmA3f8ihzQaoMko1p/APipF/Q+bvAhJdse7dJD9bwoCuoLYCQ0e
         BxGZkAXuBvlnohGtuHfqrCVA4YItjehbE5zGTftvoMXFxt1NmnSwGfGtdKOXo5CISul7
         emmxviDldx7nzgxzMs7XD8TDI5SRibE6uaEn6pZxPdA7KlSJwghddEfwkYp41Ik7mMrJ
         mh5w==
X-Gm-Message-State: AOAM533kY6i0NDS0Xajf+FrvAuu/bfe9wNk33uhnG21o2gkOXAgrKd8K
        X8oLLLkEIOXaPOe83V06FZGujh0NUf0FRAAtmsgLL3gbiaMouw==
X-Google-Smtp-Source: ABdhPJz5rVyzSsBVcv91eq7sKjJ1Z6in0ezLpypcows04icVMyugywql4yfkZB9TcslBVFmNz59+NEQdvgEFSEEYG9c=
X-Received: by 2002:a05:6402:1549:: with SMTP id p9mr7733115edx.387.1611959314462;
 Fri, 29 Jan 2021 14:28:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <pull.726.v2.git.1611954543.gitgitgadget@gmail.com> <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
In-Reply-To: <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 29 Jan 2021 23:28:23 +0100
Message-ID: <CAP8UFD00sdiaFYUvgzQmXKCQSyrNKG82_xXvRGRaqdkbqKu7UQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pretty.c: capture invalid trailer argument
To:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 29, 2021 at 10:15 PM Hariom Verma via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Hariom Verma <hariom18599@gmail.com>
>
> As we would like to use this same logic in ref-filter, it's nice to
> get invalid trailer argument. This will allow us to print precise
> error message, while using `format_set_trailers_options()` in
> ref-filter.

Thanks for continuing to work on this!

>  {
>         for (;;) {
>                 const char *argval;
>                 size_t arglen;
>
> +               if(**arg == ')') {
> +                       break;
> +               }

A space char is missing between "if" and "(". Also no need for "{" and
"}". It could just be:

> +               if (**arg == ')')
> +                       break;
