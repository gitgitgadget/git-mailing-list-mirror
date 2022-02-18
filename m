Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DDDC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 06:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiBRGLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 01:11:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiBRGLo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 01:11:44 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F06189
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 22:11:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bg10so12596983ejb.4
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 22:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQr0R2JnGPp/kehkMJW+jCVVz5NuZ8qlShOJn5tCGw4=;
        b=MNYjjSqVp2WgfYf/HQmvPZYVwTTSXNgsa4ZVmXsrtBSuvR4T47a70U+uwNIqyOyzP4
         xX3CKwJunfxD3HLXkegUYgNsABHqopgD5cpihpAum425FnnasdvKwYk1kn2ulubuvhAU
         QyoNiyC7qbuL2XjN7LLSOz+z3MIV51aBM73RNNUQu7kNLcUD13GPdWaHLkcaOoFrgxdM
         xXmk19OvJoimyjF/2JpXDnAdr1DejjWvzRxw7TtZc9mt72H8bHSuzBhomCGSFwAkEx8S
         rcwnDzw6BjCew9DDbQZSe9L48JdjmCMj02Dewwhq2HgGjzez30vufIY1mQM7+JB4ob4l
         Sa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQr0R2JnGPp/kehkMJW+jCVVz5NuZ8qlShOJn5tCGw4=;
        b=cOOjyFN2Y1zY3zv1ZBVJ0tpRdeAaGOPR6jaseE2aVqk3N/AF6pnrZhhaH1kbmkKvEM
         +MOda+IF2aCNg2B07kkdtZJzmXjc94xBIYeA50Efi/5lK3oRkqyfaPw9Am9Hx/ZuL9bm
         Yh/+GTRuM3pB/jjdAnB7dfTiugTZCBy3Gacy8qGlicf5g7uHYaQRRMIbwMXW0Ic//d+Q
         kE7ltjQAyv+PJwTY7r68yQqutJnxeBEoG+q9o8nKcoNfp5Ua5JuBu1i+6KVp9LQxGW81
         lLOhAjB8ZQXLEZ1vafJF2r0XzZqW5oW8+GdloLaHzTtfOjxd3evHhXmMMg6ihsSBcDyK
         fz8w==
X-Gm-Message-State: AOAM533mvWlCRkdnwFxj2k+eU7WSP2vdLDAjXLvAF4CFNTPUO6jv3lO7
        LGLxTw3RDJV6jMx1+2kAAyj6BrBX4J2I9gJSltE=
X-Google-Smtp-Source: ABdhPJz5c6CGLvJ5SOchOyEygHpBwU/BWCHbt8AoCT2Z8Pz4mbpoyDIKfrk/H6TGmItEvX88MQJTxwhRTDrW12jzQoY=
X-Received: by 2002:a17:906:2f94:b0:6cf:e4f7:13a with SMTP id
 w20-20020a1709062f9400b006cfe4f7013amr4985532eji.269.1645164686579; Thu, 17
 Feb 2022 22:11:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
 <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com> <1fdebc1953fcc30a6a08b3efd62dcdb31f7e4704.1645080889.git.gitgitgadget@gmail.com>
 <xmqqtucx9xjf.fsf@gitster.g>
In-Reply-To: <xmqqtucx9xjf.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Feb 2022 22:11:15 -0800
Message-ID: <CABPp-BEk0ivLve0Li0-kJKf_5PKeFTGRaEs9frdzC5k47oUA7g@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] sparse-checkout: error or warn when given
 individual files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 17, 2022 at 10:07 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >               int prefix_len = strlen(prefix);
> >
> >               if (!core_sparse_checkout_cone)
> > @@ -703,20 +706,44 @@ static void sanitize_paths(int argc, const char **argv, const char *prefix)
> >               for (i = 0; i < argc; i++)
> >                       argv[i] = prefix_path(prefix, prefix_len, argv[i]);
> >       }
> > +
> > +     if (skip_checks)
> > +             return;
>
> The placement of skip-checks here makes the earier die() between the
> hunks in this block unskippable.

Fair point; I'll restructure a bit.

> > +     for (i = 0; i < argc; i++) {
> > +             struct cache_entry *ce;
> > +             struct index_state *index = the_repository->index;
> > +             int pos = index_name_pos(index, argv[i], strlen(argv[i]));
> > +
> > +             if (pos < 0)
> > +                     continue;
>
> I _think_ the intent for this is to catch possbily common mistakes
> rather than a hard rule, so while an unmerged path will evade this
> check, I think it is an acceptable trade-off between code simplicity
> and thoroughness.
>
> > +             ce = index->cache[pos];
> > +             if (S_ISSPARSEDIR(ce->ce_mode))
> > +                     continue;
> > +
> > +             if (core_sparse_checkout_cone)
> > +                     die(_("\"%s\" is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
> > +             else
> > +                     warning(_("pass a leading slash before paths such as \"%s\" if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
> > +     }
>
> Hmph. The skip_checks flag was introduced exactly so that what the
> code catches as a possible problem is a false alarm, no?  I would
> understand if both were die() to be conservative, of both were
> warning() to be lenient, but one being die() and the other being
> warning() makes this look somewhat uneven.
>
> Besides, being leninent here somewhat defeats the point of having
> skip_checks, no?  As long as we believe skip_checks option is useful,
> shouldn't these be die() to be equally conservative?

One thing that gives me pause about making the leading slash
suggestion a die() instead of a warning() is that on Windows boxes,
users also have to quote arguments with a leading slash to prevent
them from being transformed into a "C:\Random\Garbage\Path\" prefix
instead.  But I don't want to tell linux/macos/etc. users to quote
their patterns unnecessarily, and being rather unfamiliar with Windows
I don't know if it's all Windows systems affected or only some like
cygwin.

Thoughts?
