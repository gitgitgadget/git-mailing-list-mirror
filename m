Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13992C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD2A6117A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhGMRjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhGMRjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 13:39:25 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E39C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 10:36:34 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id q16so15282180oiw.6
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wOBUTzDU34OeqzyPEKf4eSACqjnaNmkkXMg8JtzRBIY=;
        b=Ok2OjjSG6Ot+iZr+xXAS9wKWlVx1ezJQpMlEnWFzMu+BDy3eaQ2Ycz9ihsLBqCuEoF
         9y/bZyS+q3qoOMlja4vXAH9gzG+ukx8QfEo9h9LtDka9luMpzgCN2c00SgMQhzWdaeGQ
         fJFZt5oh7h2Kn4PjBn2sXccdfYnbeluE9g8aaRVPNe6Qf8cCrWLuWl50Aw9fVT9ttFY6
         82Fw8dqFt75fV/0039BlY6Scu8mCV8ptuAjvi4MTEsv3pkVZCwqp9jXdQuz+qSWA3aJe
         Ci0K/5IKj/kn8aK6ZpKvEUWaD8zGDzy43ipH03ff3U/SJuExDbTgucZfeLOeW0txr9CB
         w+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wOBUTzDU34OeqzyPEKf4eSACqjnaNmkkXMg8JtzRBIY=;
        b=ZJvCNXVjzB5jaWWPAB7b8POO28+JjYkRRyacPwotCURk/X++2fFa62stVpe0OmVfK2
         cT7TvBzq4C98hOysU7tI8xGBB8acSpPSBzcMp4/Gwowddp38eGqBmYaVaCBkxkEn6mZ+
         mIkuZjf2ZtBoy7xiKRih7eU6PrElcADBkUaX0gedyTUgifOpn1FUYbSUe/m5lyiULn9a
         u9hhZqXZqxW/5rHkU3AxAANo26lIPyRqDM4ZgPWU6/eTl57lsSLp/i91DMV36vaoSJu5
         h2GSaNzBWGIUROtMr8+73Bb378GMWsy47gL64S8tzKtyZ0ueR6RdS1/6fVsZE1S6B+g+
         cArA==
X-Gm-Message-State: AOAM533MWtk051DtwfzULG+KwghX5f8PCxFA5dDOBLPsiKZzKMOxfrKq
        U/2mZGs1Ln8CVyJxIx+0zIK3B7wNgDwsfOgP500=
X-Google-Smtp-Source: ABdhPJyD/24j/bOEvx1oB1hmD1AeuerYm3dqEM4iwSmN3SMRkIw0tUE9pzMPvnXWiyIGnMB9oR/jZpUGpcTOu+qt9fE=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr360086oie.167.1626197794122;
 Tue, 13 Jul 2021 10:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
 <87h7hdbpgb.fsf@evledraar.gmail.com> <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
In-Reply-To: <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Jul 2021 10:36:23 -0700
Message-ID: <CABPp-BF+GiAZVxeC+MAr6pSssRpSi2pNwHLrxUp9HvrOhUBieg@mail.gmail.com>
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool touch"
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 10:10 AM Jeff Hostetler <git@jeffhostetler.com> wro=
te:
>
> On 7/1/21 7:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> > Did you try to replace this with some variant of:
> >
> >      test_seq 1 10000 | xargs touch
> >
> > Which (depending on your xargs version) would invoke "touch" commands
> > with however many argv items it thinks you can handle.
>
> a quick test on my Windows machine shows that
>
>         test_seq 1 10000 | xargs touch
>
> takes 3.1 seconds.
>
> just a simple
>
>         test_seq 1 10000 >/dev/null
>
> take 0.2 seconds.
>
> using my test-tool helper cuts that time in half.

Yeah, test_seq is pretty bad; it's just a loop in shell.  Is there a
'seq' on windows, and does using it instead of test_seq make things
faster with =C3=86var's suggested command?

I'd really like to modify test_seq to use seq when it's available and
fall back to the looping-in-shell when we need to for various
platforms.

Maybe it'd even make sense to write a 'test-tool seq' and make
test_seq use that just so we can rip out that super lame shell
looping.
