Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F58C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01A1613B4
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 20:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFEUtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 16:49:17 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:46950 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEUtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 16:49:16 -0400
Received: by mail-ej1-f45.google.com with SMTP id he7so486192ejc.13
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NzC/gjEPtAQPP3s6hmOhfe1AQb1fi7AxnHARR7KJaYg=;
        b=sdqlwShrAtGQYO27nNpqu7YmQaf7p0GAF0gM42je8Md7EEBxi7gC7I3IG4vFTOIlUH
         pZoc1yqC5Rd0Hs5zTFdRA6x+5lhyeNh57fanxz0rLHegbJtgjllKtstD2VjrRhjVLsMd
         /8eElr5MRRSBS0DoUjkv6U31ROl2XcUeg6I0clpRGhElndcVSAvLP3lxw1tzyrad5ivC
         oyndaAYHbZ5KXMvrzEZR3rh50428ZVjRbkYmwiGNlxJM/UoKDTLQsJuIIisS+KJ1H/TY
         qC8x850d7IpdOcEPrrDQVYb80cLMB6/ZJrVXSRoLw9GgN5RfwFy+ZR/2nkdjTPCdcwk+
         /ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NzC/gjEPtAQPP3s6hmOhfe1AQb1fi7AxnHARR7KJaYg=;
        b=di4kD9bEZzjDsauo0LuMNlJH1/GVKOo/ohaCbJ5vfowaC9hsfQKob8csH9vt+mTnDQ
         dtBodU3AVpVj1WoS84ShioSn5sIKXINgCyaxQ3mdCGUhPNl1OQTJa6xOtcVZktNsv7ze
         9sLlsdW73wTw49zUfa84jDZYn6+Aw7e78RUQYpiuzbGKb8L72IbIop4zo0FOqEJOhYpo
         VryQYgP0JNi2d7xbO5Jso4qndK8yb38R321A9SSk52fU1lPuWSLIGf6QyyhlHU5vZ2DA
         nYyA2VctLr2oNt9Ih0ESkiDoEcDEPJrr1UPu0Wfkneux+lciUNsV85hYOIHGX2T1+AWm
         sRpQ==
X-Gm-Message-State: AOAM533tV1xs3tocasXsD4XcAfFi/+2986jx04IEBfOhWo4a+GCVegwn
        QFFAJv4OcFSXQkALFu36CTA=
X-Google-Smtp-Source: ABdhPJx3e1mbAaO2ifV4HCQ0dWBTAalGomHGVzr+FTzKqPNtnhuE6taTV8dlkCRK4MYxW/iqtfvz0Q==
X-Received: by 2002:a17:906:b7d7:: with SMTP id fy23mr10851586ejb.49.1622925971571;
        Sat, 05 Jun 2021 13:46:11 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h6sm1822060edj.91.2021.06.05.13.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 13:46:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     grizlyk <grizlyk1@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: Pro Git book: concerning data lost due to ".gitignore"
Date:   Sat, 05 Jun 2021 22:39:17 +0200
References: <3957861622848346@myt5-a5512e99e394.qloud-c.yandex.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <3957861622848346@myt5-a5512e99e394.qloud-c.yandex.net>
Message-ID: <87a6o459bh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 05 2021, grizlyk wrote:

> Good day.

Hi.

> 1. Summary. 
>
> It should be explicitly warned in the Pro Git book https://git-scm.com/book/en/v2 (and in git man also) that the ".gitignore" feature is very dangerous stuff and should be used with care. 

This mailing list does not maintain that book. For any issues with it
see the issues/PR's at https://github.com/progit/progit2.

> Due to ".gitignore" usage, some data files in directory placed under
> git version control, can be lost for indexing and can be not placed
> into repo _unexpectedly_ for user.

I skimmed the rest of your mail, I think you might find the previous
discussion(s) about a "precious" attribute at and adding something like
a backup log when we shred files due to gitignore[2] interesting and
relevant to much of what you point out.

I don't think the notion of moving to some general workflow of compiled
files being staged elsewhere than the source is something that's viable
as a general constraint for a VCS like git.

It's way too common of a pattern to e.g. have a *.o file made from a
corresponding *.[ch] file(s) in the same directory.

For those for whom the solution you suggested works I believe git
already does a good job of supporting it. You'd e.g. compile all your
assets outside of the repo via your build system, and just not have
anything in .gitignore.

I don't see how we could expect to smartly deal with having some
parallel tool like VS that's (supposedly, I'm just taking your summary
at face value) actively working against the wishes of its
users. Something like .git/info/exclude is useful, but only assuming
that your tooling isn't actively trying to subvert you.

1. https://lore.kernel.org/git/20190216114938.18843-1-pclouds@gmail.com/
2. https://lore.kernel.org/git/20181209104419.12639-1-pclouds@gmail.com/
