Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE78AC4332D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B5064E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378498AbhCDAW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347607AbhCCIQT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:16:19 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A907C0611C2
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:41:47 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f33so22657217otf.11
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKwZAiaWGSKSLEbxzhfxPeZ4TaMncQC5dkU8oE/ESVA=;
        b=sJNE33BlZhGfv+syxc8gUOuqSdcd3HuAca7dlwYhcRzWOlLe3TfLoxhvDMY/DefkcT
         DUGPbzzSZGos/bR9hPfbpeSc/YkcRJhGTyY/3ctCg1AWacvL9R+hskhIPEzwmW1WYS+/
         ibBVpK0Jf/hJmco9pwMygj1cX/6A2LXpAQFYa9OJSUstE3ol7SgwRmFBqwsg4j0WyJt1
         /YXHnbJu/gSIEwvEkHhhXaWltpTQZltwPMU2NfJEgPePkOzmpDAeOq99nnSyAbF3glxB
         e0aV2sg0Yj2Sd6NM6ebARTeEUPLqJb4duoBUWidoIlIMgJiB6GQFS8uqbbalGecVOazS
         pl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKwZAiaWGSKSLEbxzhfxPeZ4TaMncQC5dkU8oE/ESVA=;
        b=SmcGgYsN7q2r9X+lBlVJcgP0DueEFDYbzbKYPVrxIG1xK72LCJLSwB7CEQv/TG6TpP
         Fp1Vp9FRHAt8Gymtvn5/4X0mkYM97crKgT4BF/FBd7puLOgMFMdXFlxVxBBLfP5OBTGR
         k+vh6SxNJqkaj86mbz4NeqByRxu/hZEdP0MVNH7R40IAPqSv8Or2vObSGUKc6eEmMMZJ
         l7qCK6dXbO2UhMOJYLDXjghTzYllJx/9qtrQKspGhjVC4+3Ypp1XVNYJbw/9WeaNLEmC
         inBd+rAKsw5OdaeEnTTgzP9o1Ei2WffJkIeaB0ne+potxywpdJepnfIFRhQo1rlMSfqf
         SVrQ==
X-Gm-Message-State: AOAM5326oW1ikd84FK7SgHEoYeIhMxS+Ls29IGZJP+STg+2FjXzeZtuU
        XE13wJV2tHG7SUrntdyc6XPSjA+T8FpJwwqGgmk=
X-Google-Smtp-Source: ABdhPJz9E0TfK5XGv4k0pI+v/rwyZyLw0GfRqOq9PFB6zOu9+IhrbpX1sXKl8iCJihHqMkO+tVqlfdZgaxADlpB6IGA=
X-Received: by 2002:a9d:66:: with SMTP id 93mr465102ota.147.1614757306837;
 Tue, 02 Mar 2021 23:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-4-charvi077@gmail.com>
 <CAPig+cQR2ibdc1CQdwWKdk=mZM4FyaMsfw2Mpgk7Rdc-1R4PRQ@mail.gmail.com>
In-Reply-To: <CAPig+cQR2ibdc1CQdwWKdk=mZM4FyaMsfw2Mpgk7Rdc-1R4PRQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:11:36 +0530
Message-ID: <CAPSFM5dAdD2GYdrTx3fN2eoca63YZxFq76Qi7ftX4892v4BiUA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] commit: add a reword suboption to --fixup
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     20210217072904.16257-1-charvi077@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 04:06, Eric Sunshine <sunshine@sunshineco.com> wrote:
>

> > +       if (argc)
> > +               die(_("cannot combine reword option of --fixup with path %s"), *argv);
> > +       if (patch_interactive)
> > +               die(_("cannot combine reword option of --fixup with --patch"));
> > +       if (interactive)
> > +               die(_("cannot combine reword option of --fixup with --interactive"));
> > +       if (all)
> > +               die(_("cannot combine reword option of --fixup with --all"));
> > +       if (also)
> > +               die(_("cannot combine reword option of --fixup with --include"));
> > +       if (only)
> > +               die(_("cannot combine reword option of --fixup with --only"));
> > +}
>
> Or, more concisely:
>
>     if (argc)
>         die(_("--fixup mutually exclusive with path '%s'), ...);
>     if (patch_interactive || interactive || all || also || only)
>         die(_("--fixup mutually exclusive with
> --patch/--interactive/--all/--include/--only);
>

Got it ! Its seems more clear, I will fix it.

> The mix of two different error message styles (capitalized with
> full-stop vs. lowercase no-full-stop) is a bit jarring, but minor.
>

Okay, I will fix it.
