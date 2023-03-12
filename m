Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87C4C6FD19
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 21:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjCLVCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjCLVCh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 17:02:37 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F573B66A
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:02:35 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id c11so8141047oiw.2
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678654954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1twzzL1krS/wFzsN0bfX5tWEwDHIsjeRHd5FkC0yK8U=;
        b=XAYgYA4Uf01znuMA3FgJiTf3a1HnhHp112/ubSSV2D14AKlhpvcgTVTiRQ/1BRgOy0
         OA4HB+dIwDtyLavo5tJw/dTeiClDHjVHFgmVsU//7U/n99Q5jCfLAgr368v1kEAGzI/I
         Qn3/hzZ+MkTDsC6zmXqR5qR8FfnUlN0MzS77MLLrze1ttm4ntH53RoOEaTPcYFv28/kJ
         xiZzyNZ5v7bP6NtRjogL8HW+SCClpZLSHA5Hg/OtD0WmsFbXs0Oxz7U6DPUYuNqlpkYc
         LemKnNk8Jte7mYUG6sjpY7RYo/iJ3suq+US+nB77e6fxYkGeq36eBtSq+DedIfvIQKjj
         CsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678654954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1twzzL1krS/wFzsN0bfX5tWEwDHIsjeRHd5FkC0yK8U=;
        b=5rFdwDWyELSnC+EzYWL5CKO9s/hjf/thG8tiPzZtigAxux6ezYXqDjg9CVZWgSFnwK
         kHStNIcMQKxRICVtsqq4rcO2jhTHoQRCOIWvXqBue6nqY19Pi7vgErBeSMaNZCbAnTyo
         fxTwUHMixOxE2BfnnpM98U5GYFN4yfJ0o1nhZzNIDTSNFABFcweojuYpzAbysDym0WJ+
         NM/4Uc/fksvGqnbI9+qI+v84qqtlhrv4uJnnkJD17ZKm4nexPpSpzlky6I/nmMIHYKda
         YD3KOfEKJUDf6P89gKQRuI8Q7tXL6yIbloT1PzW/ebzzZ8dHr7Ro1dH7jPQ1bn1iVeF1
         jdAA==
X-Gm-Message-State: AO0yUKWfoJGf5ik93qt8dHIqqQ7QY9af02HOtLQoK69QR1Y7nctVWD8n
        EfwNwsvohzQg5Ima7QPkaBB1QmWRvWJzFOPJ4Tw=
X-Google-Smtp-Source: AK7set+PpjHQeoqaVi6BWapzRoRPcwS76LRzFRBe5zt2lV3Rq55HuH6Lb7Acpr392Yy+wJQad8qI0tEH+GyIi+XzwhM=
X-Received: by 2002:a05:6808:195:b0:384:6d14:c707 with SMTP id
 w21-20020a056808019500b003846d14c707mr9466970oic.5.1678654952867; Sun, 12 Mar
 2023 14:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com> <20230305050709.68736-4-alexhenrie24@gmail.com>
 <7cf19017-518b-245e-aea2-5dee55f88276@dunelm.org.uk> <xmqqcz5kza3b.fsf@gitster.g>
In-Reply-To: <xmqqcz5kza3b.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 12 Mar 2023 15:01:56 -0600
Message-ID: <CAMMLpeR_ZN1cGJdeRQVVay+Vp1fQ80mgGKm2fOhPmhBE4CyqUg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rebase: add a config option for --rebase-merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com, chooglen@google.com, calvinwan@google.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2023 at 11:32=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> +rebase.rebaseMerges::
> >> +    Whether and how to set the `--rebase-merges` option by default. C=
an
> >> +    be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting t=
o
> >> +    true is equivalent to `--rebase-merges` without an argument,
> >
> > This is a bit picky but how can rebase.rebaseMerges=3Dtrue be equivalen=
t
> > to --rebase-merges without an argument when the behavior of
> > --rebase-merges without an argument depends on the value of
> > rebase.rebaseMerges?
>
> True.  I think the configuration is meant to give (when set to
> something other than Boolean) the default value to the option
> "--rebase-merges" that is given without value, so setting to false
> should be a no-op (a command line option would override it if given,
> and if there is no command line option, --rebase-merges is not used
> by default), setting it to a specific value between cousin choices
> would give --rebase-merges=3D<value> unless --no-rebase-merges is
> given, but setting it to true here makes the result undefined,
> unless the built-in default between cousin choices is described
> here.
>
> "Setting to true is equivalent to setting to no-rebase-cousins" and
> "Setting to false is a no-op but accepted only for completeness",
> perhaps?

A false in the local configuration overrides a true in the global
configuration, so I wouldn't call "false" a no-op. But it would be
fine to say that "true" is equivalent to no-rebase-cousins (and then
change the documentation for "true" if and when the default changes in
the future).

> >> +`no-rebase-cousins`. If the mode is not specified on the command line=
 or in
> >> +the `rebase.rebaseMerges` config option, it defaults to `no-rebase-co=
usins`.
>
> This side could describe what setting it to "true" means, but it is
> a separate page so it would be more friendly to readers to cover it
> on both pages.

The longer the documentation is, the less likely people are to read
any of it. I don't really want to repeat the detailed explanation that
is in git-config.txt, but I see that other places in git-rebase.txt
link to git-config.txt, and having a link seems like a good idea. Fair
enough?

-Alex
