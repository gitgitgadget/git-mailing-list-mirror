Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9D4C4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 16:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20CC613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 16:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhEUQzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbhEUQzh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 12:55:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF62C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 09:54:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i22so30487086lfl.10
        for <git@vger.kernel.org>; Fri, 21 May 2021 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JH0qKo63jv7v2qinkh3WDL1K8oyqEPrmb4eyALKdQFA=;
        b=SQehDMj/PqXYv7G7LSCH4St77DZoJ/xWOvrnfW8Fag7uFl+/37qT1Kqc1tT6I2i69A
         Cr/cKxiIZEKfwG07EFZUxcd4llSsA9wmfRO0v7pBq8R1zMpZton4iby64sI8q1dIFe9g
         2/gi1nkDtUE6uCN7pUEHuN+pRp5tJoCjfSRI+MElFcem0cncvn+0+wApy3O/8p7K9dV8
         D4WXtmNHBQfwITbZGhxsMNeRY0uyRmBeoHmFwBEVGWftcfxrwzwn3WkZpwLZR3dYsx4o
         gB8ijICVDfHoFbwWxLO09+jWK+NDWvIRQvGbFknF1OiTpfEwt15QwdyU+gmWh3TKzrRC
         AF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JH0qKo63jv7v2qinkh3WDL1K8oyqEPrmb4eyALKdQFA=;
        b=MMVXJkh/mO9QgKt54f/HWUxOxt1cOzbepQFHHX4pDbM/2l7lGrlRGha/b9IIXjN42e
         QOM9MddJ0LyVYtwZv7c5i9EiaDbE+TeNehs8V9molk5al9Xu4djGHlz2HtX+XHt4tV0T
         C5V1zGnZdG2y4RhCDgStzsxFlEjAgkO139Tm8kIKMwFxv6Qk58k2Ep+3rUtXA431LnBz
         HYrNPB1ON2mr2ei5zMyLjzzfJOdm/fbDcZuml3yRbeEWy4TpHDO1U4PNEoy8VR0nlRvr
         BMt1F8UwEWbpH8eRv6q2AKAUo0yN58CX64O/xGWqJpooLZo4i0Fd/A4KrwhQ48rP8cj2
         hDhg==
X-Gm-Message-State: AOAM530XzkMOoANxnUmn3Z5McZ1CeCSlAS+0wbbTe8Z/BhDgIoXUvteQ
        Qhrx9TIVZiudK5wjfGTWgskhVNlH88A9pEshi54=
X-Google-Smtp-Source: ABdhPJzd/W0MS9hrc/hAU4VHAY9Lar9uAwNY+DBRweLbJszzhnIaWoujoYryVXGuFQbruUnTi+YjYTSUpzzwZTE4nj8=
X-Received: by 2002:a05:6512:2283:: with SMTP id f3mr2835790lfu.148.1621616050310;
 Fri, 21 May 2021 09:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <YKWggLGDhTOY+lcy@google.com> <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
In-Reply-To: <60a5afeeb13b4_1d8f2208a5@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Fri, 21 May 2021 10:53:58 -0600
Message-ID: <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com>
Subject: Re: RFC: error codes on exit
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 6:40 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> It's good to not include many initial codes, but I would start with at
> least three:
>
>   OK = 0,
>   UNKNOWN = 1,
>   NORMAL = 2,

If you go that route, could you please pick a word other than "normal"
to describe errors that are not entirely unexpected? I'm worried that
someone will see "normal" and use it instead of "OK" to indicate
success.

-Alex
