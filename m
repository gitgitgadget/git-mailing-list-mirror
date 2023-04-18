Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A36C77B71
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 04:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDRE6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRE6R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 00:58:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5CB2D50
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 21:58:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y24so1129933ljm.6
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 21:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681793894; x=1684385894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2nRRhW5miXijagfC5kLPRxOw8cwLCJHnxoCjSkXkVU=;
        b=sr0nfXnI5gCQetgecTwRtqGkUbLv6BuHzEKxX8/z/0jFfIj3xKoC+gZUX6WOeVZdfp
         tE98WJZB77HlvHj0KDsCiDRahnW4JhyrZnkxuNg/7dwzhVFEXf81eaBJDbyUSdMmtzPE
         a9T8P1shNZOIUTheLTJC1CzpHKnxx9Y+Ze5rdWXC7JpgQdu3EuNYt1iTN9Ijg5SvaSQP
         TH+8bLNaNz8etxQTQxbsVC5U2vJ026vf/w4eNU7X27zTc9DikHj3LbkBANqyHXa7siBT
         YvRqFGYV6kz0A6du4lLgoW3kTclRFIhjWEuJOYE9q75WS7igWi+LYiJPuGL3CGaXwlfG
         mgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681793894; x=1684385894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2nRRhW5miXijagfC5kLPRxOw8cwLCJHnxoCjSkXkVU=;
        b=j8jhZ4Cnu0ixaEM4ZcEsTbFhUYRQYDYUiJCzyykYcNQCRSxNCiH3loaNYPb7ZS9F78
         xIJWVcTmPdeAixkWA4qxBR/WA1MIoetZifj4pWinDL4K+FulwH5/DotohygIooumePu4
         57Fs8dgFItmcp445eeGE0R/Bkv+IPQEpTuZNLtglkPsjUCC09kHNXnmjxJI3sK01+vm1
         8KlepRz7e4EF/R4TichfZCr0uvx+bC8bhAlhbB5x/Teml+Rwg5gaNAzUHjylljim0u/W
         DaOvVC21OgZKDiiDg8ywwl7aD3lkADSuwdxbqIfbIanzoJqpYAGnBwNqwiuf3WnAk53/
         LJ+g==
X-Gm-Message-State: AAQBX9dg4fmvuegkej+qtrbaidkx96BFs20BptSS3ScXdI6cXfTxjus6
        wrwfG1owjFEA0F1yNlETISjAE4kLysAP/hXznnSkgMdjXfQ=
X-Google-Smtp-Source: AKy350ZU1DFqoIBiwK0FeDBiPPmIOiadEZnqn1dPaJmLmgRphSpe47A7ulvMeRVrLj7Ju9AL5XdYKCiQdKsILdsdhKQ=
X-Received: by 2002:a2e:b61b:0:b0:2a6:16b5:2fba with SMTP id
 r27-20020a2eb61b000000b002a616b52fbamr397656ljn.1.1681793894389; Mon, 17 Apr
 2023 21:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230407072415.1360068-1-christian.couder@gmail.com>
 <20230407072415.1360068-12-christian.couder@gmail.com> <8daf2603-2818-9c9d-7a06-6af2872a045a@github.com>
 <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
In-Reply-To: <89c78da5-388a-e52b-b20b-e376ac90de14@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Apr 2023 21:58:01 -0700
Message-ID: <CABPp-BHCdjOutYqdMO1NbYKNA0BgkXRgwUEKK=MX0kXM-5G_DQ@mail.gmail.com>
Subject: Re: [PATCH 11/14] replay: use standard revision ranges
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 7:23=E2=80=AFAM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> (I was able to get a segfault by rebasing this series with
> --author=3Dstolee because the commit list became empty. Something
> to watch for.)
>
> > Something like:
> >
> >       'git replay [options] <base> <tip>'
> >       This mode means to rebase <tip> onto <base>,
> >       detecting the range of commits to rewrite.
> >
> >       'git replay [options] <new-base> <old-base> <tip>'
> >       This mode means to rebase the range <old-base>..<tip>
> >       onto <new-base>.
>
> For that reason, I think we should be using explicit argument
> parsing in the builtin and only transform arguments we
> understand into the setup_revisions() (by building a strvec).

So, it turns out that this suggested solution wouldn't have helped
prevent the segfault you found.  If someone merely passed <old-base>
=3D=3D <tip>, they'd see the same segfault.  In fact, I think you found a
latent bug in merge-ort.  In particular, cmd_replay() has

    struct merge_options merge_opt;
    struct merge_result result;

    init_merge_options(&merge_opt, the_repository);
    memset(&result, 0, sizeof(result));

    <do N merges, for some value of N>

    merge_finalize(&merge_opt, &result);

This code segfaults if N is 0, because merge_finalize() doesn't return
early when result->priv is NULL.

We never triggered this before, because this is the very first code
example we've had where someone has tried to call merge_finalize()
without first performing a merge.  Anyway, nice find and thanks for
reporting!
