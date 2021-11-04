Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B270DC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9648B611F2
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKDN6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhKDN6F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 09:58:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D9C061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 06:55:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ee33so21799470edb.8
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zw6dXAQRfaqKZmaMEUZNklagpLXCMIcdLsPEQDypzGQ=;
        b=nn6pR3MOZmg6fkYEdA6YGbB9/9m+DQXNOsMCJASOlFAGiyy4jLXwHQm4Xxi4gAXoeB
         7/w9Zih0oUNTG8FmG9ZQvHnkSw9FD9IJ6F8o0yx9gcuPoL+DR9WHpUz8rg+tf6s54h2j
         XGakU3Mj+Rm0hRJdJEObF57tvUDk77X+ocK0NHslvNREJoSlUhUkBJaTbYes02KH7vu2
         dSAwYeRZhUbbGMR0tPJrBVpgejU02MfjlUnCxtn246WYD7WQFORh1N+CJG92Bx/yvIFR
         114LvsS6IrOtHmHI0icqAWQRCP4iMz+alPqzkvgXMke6FeLykdv3c0OnjJXdbQYJ8c2T
         y4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zw6dXAQRfaqKZmaMEUZNklagpLXCMIcdLsPEQDypzGQ=;
        b=Wgqo9euTpN3PGvtQRp3hLZEagh5TiL4ZHLucKEQU/pmKHWZFANIEy5AkqyPcrG7ShB
         e4/97n77RXVYvjDzwRb/iT5Iji6WykieV7wqks1oLi3t9RwlnzvlVbwQQChtIDfI9bRo
         QSuaRulOeXKJ/36ZR0optuScuzr6TrAYbBbdbjf8JLm4rSs6dvb/zGKf3t6ckrwMpuy+
         fp5CfVPVr6bMTXSpuFhG32MC8gwOqC16n0kQD4r4FPvMEmRqVopKHxNwNo9dAoG0BSoe
         O9umh/ED4Bi6qVNJbUzmy7Qr8udB44u6FvlKbrYTVAEn0NVWhSBBPvKBRTzJdukk1wJK
         YkjQ==
X-Gm-Message-State: AOAM530jHHGWl37IFgR39D0D7b4iKJU9jcieherVYM2xl8RRWsEzhvLf
        4uxUT/LkJ4lAZy57ILUmUAw=
X-Google-Smtp-Source: ABdhPJx4wY4CF4A+JQIUj7ox2DxLcotmhCGzR8XlM0RmwzERihHpMK6m0pA+grH81Fjwa/0jxQJBNw==
X-Received: by 2002:a05:6402:2712:: with SMTP id y18mr13925558edd.212.1636034125529;
        Thu, 04 Nov 2021 06:55:25 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f7sm2923574edl.33.2021.11.04.06.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:55:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1midDA-000Bc9-KQ;
        Thu, 04 Nov 2021 14:55:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] ci: disallow directional formatting
Date:   Thu, 04 Nov 2021 14:48:29 +0100
References: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
 <pull.1071.v3.git.1636031609982.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <pull.1071.v3.git.1636031609982.gitgitgadget@gmail.com>
Message-ID: <211104.86ee7whvoz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 04 2021, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> [...]
>      * Corrected a code comment: my custom git grep was not PCRE-enabled,
>        but Ubuntu's isn't. But git grep -P still does not understand \uNNNN.
>      * Even if the *.po files currently pass the check, the script is now
>        future-proof by excluding them.
> [...]

> +# This is intended to run on an Ubuntu agent in a GitHub workflow.
> +#
> +# To allow translated messages to introduce such directional formatting in the
> +# future, we exclude the `.po` files from this validation.
> +#
> +# Neither GNU grep nor `git grep` (not even with `-P`) handle `\u` as a way to
> +# specify UTF-8.
> +#
> +# To work around that, we use `printf` to produce the pattern as a byte
> +# sequence, and then feed that to `git grep` as a byte sequence (setting
> +# `LC_CTYPE` to make sure that the arguments are interpreted as intended).
> +#
> +# Note: we need to use Bash here because its `printf` interprets `\uNNNN` as
> +# UTF-8 code points, as desired. Running this script through Ubuntu's `dash`,
> +# for example, would use a `printf` that does not understand that syntax.
> +
> +# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
> +# U+2066..U+2069: LRI, RLI, FSI and PDI
> +regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
> +
> +! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
> +	-- ':(exclude,attr:binary)' ':(exclude)*.po'
>
> base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49

So this is still using not-PCRE instead of the much simpler PCRE-enabled
one I suggested in[1] because your locally-built git doesn't link to
libpcre?

At the very least that comment is still quite confusing. I.e. it starts
out by saying that it's meant to run in CI where we've got PCRE, but
then goes on to describe an elaborate workaround that's only needed with
a not-PCRE grep.

Would be less confusing to understand why it's so complex as:

   # This is intended to run on an Ubuntu agent in a GitHub
   # workflow. We've got PCRE there, so all of the below could also be:
   #
   #    ! git -P grep -nP '[\N{U+202a}-\N{U+202e}\N{U+2066}-\N{U+2069}]' ':!(attr:binary)' ':!**po/**'
   #
   #
   # But the author wanted to run this locally on a system that didn't
   # have PCRE, So [go on to describe elaborate bash / "git grep -E" /
   # LC_* tweaking workaround....]
   [...]

B.t.w. I think that **po/** exclusion is closer to what you want,
i.e. "a 'po' dir anywhere in our tree". It'll also exclude this if we
e.g. end up using these in language-specific README files there or
whatever.

1. https://lore.kernel.org/git/211103.86zgqlhzvz.gmgdl@evledraar.gmail.com/ or:

   ! git -P grep -nP '[\N{U+202a}-\N{U+202e}\N{U+2066}-\N{U+2069}]' ':!(attr:binary)'
