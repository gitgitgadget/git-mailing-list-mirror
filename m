Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FDDC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbiCJNjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242571AbiCJNjF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:39:05 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2153B67
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:38:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c20so6978541edr.8
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=H6ex94dq3zhr/NPEKSk8YKOo8cyVtJdYd2iCChXwdDY=;
        b=QRFQp2jsL26a+kOrRe0ozE4MMGY2YmuxLKit/eO8J/ssXjb93OwOT47P1if4szjeLP
         xHKZzCdEUh1qEUW1WbPJ4TSbJ/ATtOmA0gXDbWT78yvdK56/Csqkptlsdi5wKWJOCz/9
         /jc5kOjpB7W7vJ4C5TwJ5pyOrokn+BEloGtE6lY9HIvOYbn0C5MfUTYkqhSZHITA5Ew/
         Fc5WnvKqPZLjbrQM7TTnJ6N3xMta4NclI7fsQ9+KOlRqb+E8pQUVfTvEh/D8JPTDBEHG
         UKoEEK0ieGuIEtBqTVA9uxWNZRGcQSZ0g3f1tc8IqCO4XT7trGe1w2f+Rr91JQQwSGny
         XH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=H6ex94dq3zhr/NPEKSk8YKOo8cyVtJdYd2iCChXwdDY=;
        b=5IsLFaRj6njEFNt+cobhvNnatLtZPAej8wOJEGsf/eh4/lnshzvN5VhqvqeAjJ46mB
         BUWuPOE3E/am3jdPbtus+nUjJOQAeJCnts/XFuxOHmjWusHigenvJsptGMlYWcShCJy4
         2znZVt5kjsh725rAPVkzthwp6Jqv8rItFPCIIy5XGOS+hXS0QZQss0bfxJEypqiqGjC6
         xaj9E9IeuEPt1dlKKoDbrXdtU/38HcScQxXIw65hhWNjdVxWNho/eYGxN0XP+cinDzhj
         5i4EQ/+11e/KCPPxoxyobyXTbnpxRH1A2p2pmYjpRvKMwePEn6wca8DiG19dCMIxhN0w
         s76Q==
X-Gm-Message-State: AOAM530kKKCiO/2mKH1SU4TNE6BovPmTxsB9YI88xYRW8h9cRNTOG7Su
        8+OKdvQZ8aDPlYzCCbmUYgM=
X-Google-Smtp-Source: ABdhPJzu4MVFooNs8NgKrz9009h8v2OnNwdI89crfF+TZOijvCtixFq2UXvuVOxHltfagRBJZN98Fg==
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id f11-20020a0564021e8b00b003da58e69a09mr4326572edf.155.1646919480942;
        Thu, 10 Mar 2022 05:38:00 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o20-20020a056402439400b00416a29c663fsm1517637edc.17.2022.03.10.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:38:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSIzP-000UlX-KM;
        Thu, 10 Mar 2022 14:37:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 3/4] terminal: work around macos poll() bug
Date:   Thu, 10 Mar 2022 14:35:00 +0100
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com>
 <20220309110325.36917-4-phillip.wood123@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220309110325.36917-4-phillip.wood123@gmail.com>
Message-ID: <220310.86v8wmj5c8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> On macos the builtin "add -p" does not handle keys that generate
> escape sequences because poll() does not work with terminals
> there. Switch to using select() on non-windows platforms to work
> around this.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  compat/terminal.c | 43 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 6 deletions(-)
>
> diff --git a/compat/terminal.c b/compat/terminal.c
> index cb653419c3..4189cbb12c 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -82,6 +82,32 @@ static int enable_non_canonical(enum save_term_flags flags)
>  	return disable_bits(flags, ICANON | ECHO);
>  }
>  
> +/*
> + * On macos it is not possible to use poll() with a terminal so use select
> + * instead.
> + */
> +#include <sys/select.h>

I don't think this breaks anything in practice due to the platforms we
define HAVE_DEV_TTY and NO_SYS_SELECT_H on, but it does look redundant &
confusing, and will break if the current users of HAVE_DEV_TTY and
NO_SYS_SELECT_H change.

I.e. isn't sys/select.h already pulled in by the relevant include in
git-compat-util.h? Why is it needed again here?
