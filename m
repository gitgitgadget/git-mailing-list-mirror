Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12824C2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AC26140B
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhEXXZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 19:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhEXXZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 19:25:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E0C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:23:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so33826239edt.13
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=uGCk91Or3rQTMt76kw6faSucGtz0agCvU46rUIC39Cc=;
        b=iK+CKEDaQg0Y0yqxc27N25O8QH8Ve9Fzx8IrNBwidwwaRSIdDe3IcfcP+VT5jbdfZs
         qKYyUanXuLdmNKv8a6+Q26nSyMhJ51Q2qjz6yGAYXHBkZgl7pQtaWbwErMt22LO5oE1e
         MiSpN1w47Yj1h3dyqlZf98BsKvdxLJKzaMKSipFyyMc3EJr0FYx7xQEuuO+bj2c2beLr
         1MZZSRUw9npN3oetPxykPB4k/hrJOClo+bbIEJMX1sHxzOUik+zVA3XqBu7i62oTZj1Y
         vmUGIB5oQWOJY4wTuUeDwMn7pSusmundRXhp0nhVpUHwEZSfUQNKZi5D0fA6t4GnGhub
         ublw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=uGCk91Or3rQTMt76kw6faSucGtz0agCvU46rUIC39Cc=;
        b=Kv6iXZ0XToSJ9pdxU39MCn+Kq6HPEPzMoUDE5HgwdkljOJOCZbkRatjIuHnd+C2psu
         qwlIwBq69538h9RDhfwpiGLx/Xmk8AN4dG7X2DSLvxZA66C1LVOpEoQ88eHrr2i05KW0
         X56Rtefq9HQAUrlQiqj8jAz1jnyYIjRriis1oyx3Dw1npB782TWBR2NphDXeJIayB0uK
         wyjq7yh7UWILvK1Yyb3kHUSqO/dQYx5Snp510xheSjnxP8w9w8B6uxLrTtJqb+ACYYGe
         moRjeS04ojNgoy3QngCIWocAvqrjXQfjqNi9BxlxQWcmQr0VjSG0LVDK916MGcpTh7H6
         d2RQ==
X-Gm-Message-State: AOAM532LFr1U9KivuFoQNlgiy5HvPphPDDwP4wtXwQUBeWWXt0WPOfXv
        wlpaThl7HhKi/A+bFO9MQL/AF4OUlcu+AQ==
X-Google-Smtp-Source: ABdhPJzNpwsPfmnWP0D0THU3UyQLPhzKfBUYjR2TzKtmKwRr//XelYQYlmVBHkC33tQRH5aCOMUIbg==
X-Received: by 2002:a05:6402:1548:: with SMTP id p8mr28306016edx.261.1621898635031;
        Mon, 24 May 2021 16:23:55 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m16sm9999620edq.56.2021.05.24.16.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:23:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Subject: Re: Renaming "non-contrib" things out of contrib/* (was "Re: [Bug]
 git-credential-netrc.perl[...]")
Date:   Tue, 25 May 2021 01:18:28 +0200
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
 <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
 <60ab17018efee_1691c20832@natae.notmuch>
 <87o8d0o2or.fsf@evledraar.gmail.com>
 <60abe0b32dfa1_1b2092081d@natae.notmuch>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <60abe0b32dfa1_1b2092081d@natae.notmuch>
Message-ID: <87a6ojogvp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 24 2021, Felipe Contreras wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Sun, May 23 2021, Felipe Contreras wrote:
>>=20
>> > Jeff King wrote:
>> >
>> >> I suspect that just opening a bug report against distro packages might
>> >> get some traction (especially if it comes with a patch to create the
>> >> extra package).
>> >
>> > I have tried that; do doesn't work. If git developers have $x in
>> > "contrib" it's for a reason.
>> >
>> >> I do wonder if packagers are hesitant to reach into
>> >> contrib/,
>> >
>> > Of course they are! The word "contrib" has an obvious meaning.
>>=20
>> [Minor edit to the quoted text to inline the link]:
>>=20
>> > This is precisely the reason why I tried to graduate
>> > "contrib/completion" out of "contrib" to no avail:
>> > https://lore.kernel.org/git/1399607587-14127-1-git-send-email-felipe.c=
ontreras@gmail.com/
>>=20
>> Seems like that patch just got no replies at the time. FWIW I'd very
>> much be for it and would encourage you to re-submit it.
>>=20
>> I'm not sure s/shared/contrib/g is the best naming though, but maybe I'm
>> contributing to needless bikeshedding by mentioning that.
>
> It is the best location because that's where completions go.
>
> You can check the location bash-completion suggests to install
> completions to:
>
>   % pkg-config --variable=3Dcompletionsdir bash-completion
>   /usr/share/bash-completion/completions
>
> In the case of zsh it's /usr/share/zsh/site-functions.
>
> Additionally, if you install them in your home directory, it should be
> $XDG_DATA_HOME/bash-completion/completions.
>
> $XDG_DATA_HOME is $HOME/.local/share (analogous to /usr/share).

*Nod* I mean just because it ends up there in the FHS doesn't mean it's
 best for us to mirror that structure in git.git.

>> You apparently named it like that to match where distros usually install
>> it (/usr/share), but we also have docs there, locale, and the perl/
>> directory usually (well, at least on my distro) ends up there.
>
> Distributions install them there, because that's where they are expected
> (by bash-completion and zsh).
>
>> I wonder if just a top-level completion/* wouldn't be best, or if we
>> want to group them all together something like
>> optional/{completion,credential}/ or other name suggesting that these
>> are meant to interact with not-always-present 3rd party software. Maybe
>> integrations/* ?
>
> extra/ is a better name.
>
> However, there's already many things that are optional, like gitk and
> git-gui, do they belong there too? For that matter locales are optional
> too.
>
> I think if such a decison to have an extra/ directory is made, it should
> be orthogonal to the completion graduation.

The line I was attempting to draw was components that optionally
interact with optional 3rd party software.

The i18n framework isn't like that because we build it and interact with
ourselves, ditto for say PCRE. Optional, but /usr/bin/git is using it.

As opposed to bash/zsh completions, git will run just fine without
either of those shells installed.

The git-gui and gitk programs are also first-party software, just like
git-send-email or whatever. We just have knobs not to build them because
of the dependencies. It looks like we might be spinning them away from
git.git entirely in slow-motion, but so far they're first-class
commands.

>> For some of these names a general re-arrangement of contrib/* would be a
>> logical thing to follow, e.g. I think it would make sense to carve out
>> various ci/, contrib/coccinelle, Documentation/doc-diff,
>> check-builtins.sh etc. and other "only for supporting git.git
>> development" or "only called by our own Makefile(s)" into some
>> consistently named pattern.
>
> Me too.
>
>> I'm also very much in favor of building and testing all of this software
>> by default, to the best of our ability. We've had some avoidable bitrot
>> e.g. in subtree and mw-to-git in the past, some of that is a pain to
>> test (e.g. requiring an installed MediaWiki), but we can usually
>> build/test some part of it (e.g. in that case, does it even compile as
>> Perl code?). In other cases we could compile/test things by default on
>> certain platforms if they're platform-specific.
>
> Yeah, some spring cleaning would be good.
>
> I'll put sending the patch in my unending to-do list.

Thanks.
