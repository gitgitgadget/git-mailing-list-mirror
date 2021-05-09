Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F41C433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 08:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9A261361
	for <git@archiver.kernel.org>; Sun,  9 May 2021 08:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhEIIVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 04:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhEIIVy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 04:21:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB8CC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 01:20:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q2so11478501pfh.13
        for <git@vger.kernel.org>; Sun, 09 May 2021 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KPJ/TYMeLaRc8/9kVurZ+ypRmoER/oG9lWhJFCY/beE=;
        b=GxdytXc6FiFvJja5jLi10Wjq7N8msgeBeIfQ5YtOmkfrSTbtQCjI2lgudUEmy77xKB
         tiGZ8zF7OUwD0iIEsCTnhu7F2mFEv6hKmPvQjUUMS/zMnfdssdaSjYfRdRrBSZEEHunG
         EMLqUdGwgT8gY7NETvl3NqqqexmmCODkdOb+0+ZhW010BFNmBAa/UQPDSmcoKYrIbZmu
         64EbeJuIfmuCzyHIyFxZN3D+5v0d+ojRER4eLXkY506DVQQbtauJS0J1pHXiDXneweRr
         3RDPSaeRZYEoXW1HATR5f85UIeByvcBEvE+VNtjX3wZZuKhZCoNSbADRqlFYQLT1gY2u
         Q7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPJ/TYMeLaRc8/9kVurZ+ypRmoER/oG9lWhJFCY/beE=;
        b=sTeuX20fUeRcLYqDe9aNwlCC0aMJjzINOXMvjXX/phRoVgEemf87u1tQO6XWZ3D83c
         janP5c+kbcHM9SLDjkvJjyqdQlMvy4tbdr1Er6TsivYtfdv1RyRDjq8qYNncLll6h7cU
         gH5xX5EeyNtrbJmFwHhs/ovPTFLLS4a2Ge/Ct4v78ARYsg0K8mjcj8Apzy7VUyZ9iSO9
         pbo67xI1q/MZQ7WDR6k+cZLbuzoOjbXZc2cXoSNbzst9ndJo2IdnwBHFko4Z9ydLRIYH
         nluHRQDy+lDH2iYabUef41jrA4pZ08mF74i74AJ5/8qPWsGClpFb3oQZ0r0YP78jTUmQ
         VeHw==
X-Gm-Message-State: AOAM533e//OFPscmb+TYDPVUbLO4ihK/9D8dxR/twvlhPbA8Puxolz2r
        LaX6lzB73hLN2YDxDZ06VybCEg1PAUOeASQUTVkrpxp3Hhs=
X-Google-Smtp-Source: ABdhPJz8XnTkhLIPRrmjm1fv9OTh3WdLj34GVPHIE2fZpeLf9zhpvV8b9YkNHg4JtDaKPQWKiLyDkEpyccre1eZ/yKI=
X-Received: by 2002:a62:3201:0:b029:211:3dcc:c9ca with SMTP id
 y1-20020a6232010000b02902113dccc9camr19236380pfy.46.1620548450819; Sun, 09
 May 2021 01:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net> <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
In-Reply-To: <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 9 May 2021 10:20:37 +0200
Message-ID: <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 8 May 2021 at 00:19, Jeff King <peff@peff.net> wrote:
>
> I _thought_ the original asciidoc was marked as deprecated /
> unmaintained at some point. But it does seem to have gotten a few
> releases in the last year (it looks like maybe the python 2 version was
> EOL, but somebody decided to make the effort to port it to python 3?).
>
> But I wouldn't be at all sad to just standardize on asciidoctor. I think
> we're at parity in terms of the output (thanks to lots of work from you
> and Martin over the past couple of years), and I've generally found it
> nicer to work with.

I tend to think asciidoctor even renders our manpages *better* than
asciidoc does. Not by a huge margin, but a few things here and there.
Some time around the Python 2 EOL, I was about to propose flipping the
default, but then I went to look up the asciidoc EOL schedule, and like
you, I noticed that it was a lot more alive and kicking than I thought
it was. So it's not so much "we should flip to avoid a bitrotting
dependency" as it is "asciidoctor is arguably nicer" or "it's the way
forward".

I've done some working-around in the past to try to make something look
non-broken in both of asciidoc and asciidoctor. Working with *three*
toolchains, we should probably be clear about which one it is we're
going to leave behind, and that shouldn't be the default. I'll be happy
to make a patch. I can't use the EOL argument, it seems, but I do think
it's the only thing that will allow us to reach an xmlto-less generation
of the manpages without losing our minds.

> The only downside is that it may be available in fewer places (though
> I'd think that python vs ruby is not so different). IMHO it's OK to be
> aggressive about the doc toolchain requirements, because the fallback is
> always grabbing the preformatted roff or HTML pages that were generated
> on a different system.

In general, I agree. I do think it's important that "most people
contributing to Git", whatever that means, can build the documentation
to check the part they're adding/modifying and not find it broken left
and right. They would then (quite rightly) not even bother building it.

When we looked at xmlto-less rendering around two years ago [1], we
found various asciidoctor bugs up to and around version 2.0. We would
likely need to require some >=2.0.x. The exact requirements will
probably only become clear when someone really does the work.

I think what I'm arguing for is

  1) switch the default to asciidoctor,
  2) enable optionally using it without xmlto,
  3) figure out what broke and fix it, and document which is the minimum
     asciidoctor version we're going to bother with for (2),
  4) lather, rinse, repeat (3),
  5) switch the default to not using xmlto,
  6) drop the xmlto way of generating the manpages(?).

[1] https://lore.kernel.org/git/20190317194431.GY31362@pobox.com/

Martin
