Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0586FC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF64E60E0C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhJGJRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbhJGJRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 05:17:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDD2C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 02:15:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so20495085edb.5
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=G9MBbeiHr3mBs7rgdLmxnSlHBrTsjRqTj91+yTEjp3g=;
        b=mtNLwnNa8BBb4y84t7nksDytbEhYvRllP03c2H255CzAomHhySvLWm8UTzsOP8yih9
         k3aTGEeSyDRQU3o2KyBYy3PAobz0UPqgbBTcQiuU6+9Y3jnt/nU1w8LdkF9hRNHoOTYp
         5+2Fc3d8a6/6cTED1k3+45uySJjCyl41EE6emwMOolk5t4QspyygWCj3qEtACBveZWu4
         ShXybdOFM22dnLDMOJTAeCVbJdZ3z32ebvDAv4Q7fczwI08a6zvYHugG/2vJSmTkGfKL
         3X0iGKQhZ9mdtu1IzbA9soiQ8Cj/qPQ3iJCTHl9RdlQnMVDo6Iobz6ImhqEr7d8LLeuk
         Av7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=G9MBbeiHr3mBs7rgdLmxnSlHBrTsjRqTj91+yTEjp3g=;
        b=LWAo6UJatVuuFtJDcHZx/MXnmTuvX8Id2qlT/TOT8OTmVyfwZ8mncXu7ULAy2JEjGj
         Kh/HPW8CpYHA+eJ/4mu8bKwv/EjUcMOIYyp9MDrmdKaT3j5apbwR25be8jFgcepa2WzO
         99/YzHIQ+bPK0prOrWcKrEjFrX5SDApfrrzN8kyReyKyH5sR+lH5Yl7IznGoc4csjGKT
         hmOBd3+/bFytBNphbAXv0hEQpwzyGcyBuYaMNzGPgc6mwn8izy1rxMwJw4p/xJY8R4fU
         HA/4a5cV8dcQzprHFxhRM+5nfzj+NK9LsRR//NohE1EsGSboK7Y2ozv/1tOgAmZccyV3
         V9SA==
X-Gm-Message-State: AOAM530PeghRZR4ltZWSI4t9KRW85BkpYBfoneFtj/ShbVPtpIgqhxp6
        7UKiISLMYzpYuG0ViUeb/qA=
X-Google-Smtp-Source: ABdhPJw/bLTsitBdV1DnLMXmD/s4ZgVoKsh09XMep6AJqIoqHjb7SVe0ucw+xo01zfv9KDNTSV3Jmw==
X-Received: by 2002:a17:906:2bc7:: with SMTP id n7mr4154463ejg.238.1633598145800;
        Thu, 07 Oct 2021 02:15:45 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r22sm9818748ejj.91.2021.10.07.02.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 02:15:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/3] Fun with cpp word regex
Date:   Thu, 07 Oct 2021 11:14:00 +0200
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
Message-ID: <87o881gpq7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 07 2021, Johannes Sixt via GitGitGadget wrote:

> The cpp word regex driver is a bit too loose and can match too much text
> where the intent is to match only a number. The first patch fixes that.
>
> The other two patches add support for digit separators and the spaceship
> operator <=> (generalized comparison operator).
>
> I left out support for hexadecimal floating point constants because that
> would require to tighten the regex even more to avoid that entire
> expressions are treated as single tokens.
>
> Johannes Sixt (3):
>   userdiff: tighten cpp word regex
>   userdiff: permit the digit-separating single-quote in numbers
>   userdiff: learn the C++ spaceship operator
>
>  userdiff.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

I haven't dug into the C++ syntax here, I trust you know what you're
doing there.

But some tests in t/t4034/cpp/* would be great, and seem from the files
easy to add. E.g. wouldn't changing:

    a<b a<=b a>b a>=b


to:

    a<b a<=b a>b a>=b a<=>b

Give you an updated regression test for your 3/3? Similar changes can be
done for 1-2/3.
