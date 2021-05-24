Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABB5C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEBA61412
	for <git@archiver.kernel.org>; Mon, 24 May 2021 17:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhEXRX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 13:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhEXRX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 13:23:26 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDD5C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 10:21:57 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso6508273oow.10
        for <git@vger.kernel.org>; Mon, 24 May 2021 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=i4tlQV6fP6j63aETdJT8Lhy0fSCO1OlbHK+lJfdgmZw=;
        b=UFbtX3Ryik3uZySOFWatN2z7BnNEdxFVVOoIr12yuzHk1JhKzn7geZfhsiZ2IG7ggH
         cddO0l96krsFSdkxbEvt2su5XCHbEp5FolFQzLCjZEEDnKp/XMU2Tfd8/4Bd8zVcWEiy
         i5KGmFVC8cvl8hvRpW6GriBo+afYEobZdSruCroSlS39Xd5pG6S3d5kfJ3OirUCcyJAJ
         MerNlBJcFgoUgH+gQigXsZa6OpW/nKwbWyBs6RmnGhM3lvanKcnAhTT4v7Ngt5+yQu31
         /ZLPybeaakdAtBB1Lqgnx2ZYmglrg2bkXUnoS/EqjWMN/uoF02wl6/m7GeycxUUQwoas
         uXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=i4tlQV6fP6j63aETdJT8Lhy0fSCO1OlbHK+lJfdgmZw=;
        b=ORwtGP/0HSCXnN07hLUR+fQbNucsn5LjYa/GYXrljwPAaFFS+66RhT20nXj1Ds49P9
         4Nlb3Uzv8b4P1cDVwYbphahvav3WObhGoYd154zWvHNrCXv8jz3mxDKqiK21QGeYtjEw
         IiAzfvxGnAmpBl2LggueLiNQa8e+Ldm6Y5amLp3seHt4x56LQMEKX8YguKVyTUfc3YnO
         Z0dAHuGUmi6actns2FTKJkKG7zOvQwNU+geORLJmXmYmr5gIWrnOJYq4UOENHKpAZFPI
         NvzMi8bxPLmmFOOUe+3YspykEClm52jUVWHNB9LtWR4EvDi/dI4feoeZqaoz8B73nlUI
         6gcw==
X-Gm-Message-State: AOAM533F7swb91yQJ+Bv9StHzv5+bIR7GY4Lz3ncdbR+Kl3tYfWbn8ub
        biNTzA5BGVefaDNB+M5SJO4=
X-Google-Smtp-Source: ABdhPJxgU4lispbnVKyOdTS68ZnKmtzeync2cBZ+zeIjxlE7HeePa1QW7GUhYKfub4UPHhHzEZQCWQ==
X-Received: by 2002:a4a:a511:: with SMTP id v17mr4868907ook.44.1621876917190;
        Mon, 24 May 2021 10:21:57 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id f6sm2692990otb.64.2021.05.24.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 10:21:56 -0700 (PDT)
Date:   Mon, 24 May 2021 12:21:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Siavash <siavash.askari.nasr@gmail.com>, git@vger.kernel.org
Message-ID: <60abe0b32dfa1_1b2092081d@natae.notmuch>
In-Reply-To: <87o8d0o2or.fsf@evledraar.gmail.com>
References: <87k0nt3f8i.fsf@gmail.com>
 <YKcTFDgW4etXFpOR@camp.crustytoothpaste.net>
 <YKeFxcTDp4tHSRu8@coredump.intra.peff.net>
 <YKgzvFHOcUgPjbj/@camp.crustytoothpaste.net>
 <YKqzj/DZU8m9AaI/@coredump.intra.peff.net>
 <60ab17018efee_1691c20832@natae.notmuch>
 <87o8d0o2or.fsf@evledraar.gmail.com>
Subject: RE: Renaming "non-contrib" things out of contrib/* (was "Re: [Bug]
 git-credential-netrc.perl[...]")
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Sun, May 23 2021, Felipe Contreras wrote:
> =

> > Jeff King wrote:
> >
> >> I suspect that just opening a bug report against distro packages mig=
ht
> >> get some traction (especially if it comes with a patch to create the=

> >> extra package).
> >
> > I have tried that; do doesn't work. If git developers have $x in
> > "contrib" it's for a reason.
> >
> >> I do wonder if packagers are hesitant to reach into
> >> contrib/,
> >
> > Of course they are! The word "contrib" has an obvious meaning.
> =

> [Minor edit to the quoted text to inline the link]:
> =

> > This is precisely the reason why I tried to graduate
> > "contrib/completion" out of "contrib" to no avail:
> > https://lore.kernel.org/git/1399607587-14127-1-git-send-email-felipe.=
contreras@gmail.com/
> =

> Seems like that patch just got no replies at the time. FWIW I'd very
> much be for it and would encourage you to re-submit it.
> =

> I'm not sure s/shared/contrib/g is the best naming though, but maybe I'=
m
> contributing to needless bikeshedding by mentioning that.

It is the best location because that's where completions go.

You can check the location bash-completion suggests to install
completions to:

  % pkg-config --variable=3Dcompletionsdir bash-completion
  /usr/share/bash-completion/completions

In the case of zsh it's /usr/share/zsh/site-functions.

Additionally, if you install them in your home directory, it should be
$XDG_DATA_HOME/bash-completion/completions.

$XDG_DATA_HOME is $HOME/.local/share (analogous to /usr/share).

> You apparently named it like that to match where distros usually instal=
l
> it (/usr/share), but we also have docs there, locale, and the perl/
> directory usually (well, at least on my distro) ends up there.

Distributions install them there, because that's where they are expected
(by bash-completion and zsh).

> I wonder if just a top-level completion/* wouldn't be best, or if we
> want to group them all together something like
> optional/{completion,credential}/ or other name suggesting that these
> are meant to interact with not-always-present 3rd party software. Maybe=

> integrations/* ?

extra/ is a better name.

However, there's already many things that are optional, like gitk and
git-gui, do they belong there too? For that matter locales are optional
too.

I think if such a decison to have an extra/ directory is made, it should
be orthogonal to the completion graduation.

> For some of these names a general re-arrangement of contrib/* would be =
a
> logical thing to follow, e.g. I think it would make sense to carve out
> various ci/, contrib/coccinelle, Documentation/doc-diff,
> check-builtins.sh etc. and other "only for supporting git.git
> development" or "only called by our own Makefile(s)" into some
> consistently named pattern.

Me too.

> I'm also very much in favor of building and testing all of this softwar=
e
> by default, to the best of our ability. We've had some avoidable bitrot=

> e.g. in subtree and mw-to-git in the past, some of that is a pain to
> test (e.g. requiring an installed MediaWiki), but we can usually
> build/test some part of it (e.g. in that case, does it even compile as
> Perl code?). In other cases we could compile/test things by default on
> certain platforms if they're platform-specific.

Yeah, some spring cleaning would be good.

I'll put sending the patch in my unending to-do list.

Cheers.

-- =

Felipe Contreras=
