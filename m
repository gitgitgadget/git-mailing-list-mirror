Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61B8C433E6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 22:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF0464DAD
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 22:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhBCWBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 17:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhBCWBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 17:01:18 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D0EC061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 14:00:37 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id q9so738011ilo.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 14:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pJLbcEnzbYzj4vqSTsCnlrw6enzl40d7jkLr5irMgaw=;
        b=PLeAUFFX7Qj7qaUvIZa/n2sHJUve7iAOi9vtVKzG6oYLwwdKyY/rFZrWqoL2qpYW65
         SqZxaW2omGYhHIW0p8yd2FTk7mSoXNGbnLtAO3IcYKGmlZNgwvkemqzH9RowT/8Kbz23
         v/dQbprd/K4Av4b0sBzY7MQXsihEMkDqN3jlkb+0DnBk5Gjq3HlRKwEATGipIbVCUCJs
         xvq4JJswLew9tE3Y1mRB/nqTEiKkCGYslm5u/7YBwxvQZ94hfXZypEdQPiW4J2VzffzK
         Ktts3iGCj+GHtsv9K9m5KMKsUOllOk58cJ2/F76lDe+uSSEWlSS+GiKzGtRGqMgO2C0y
         +9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pJLbcEnzbYzj4vqSTsCnlrw6enzl40d7jkLr5irMgaw=;
        b=YJxJ01rfKg6bBOMj4KqkJGhtNuIFCC25+ZSWHqmrAszUgAOAakGMzpqIsn8Zpfu/z7
         AcDE33ynQhBXXxZ3y8q3ty0f0I1nAu+f1lZiwNJeEBGC1/AN0EPispEwAGM0ihZMgxLq
         uYNlxqmcFSIiB1efHmy8ylKFj6o0Y3Gf+qmjYkOcBNesW+0dfz1O7h0fmB7GKLoNrlSv
         UqTPK9+JzWYhwZhBFokLQyH/ppWGgOUut0WqlRAO10nnESORr+6uSueC30AwteL59W4g
         r85+BsQd1MAIxz9ShNG2J8S17Mw9jnyaeC71GOjmNw2DVW42lVkA7A8QbWfxHd13jYw2
         54nw==
X-Gm-Message-State: AOAM532eMkFofMQAozHUUbeMCUIFMWL8gs6fzg0L3yObJMEhXF9LtmhX
        4xXdD1YRLwGw9EMh4V+7kA+J/3WS4P+NFgNze/k=
X-Google-Smtp-Source: ABdhPJx/RAnseyuxs9M7CE3TbTdWvEk2Cm2iT7R8knZrgumxSMNFS1sL/4NE+AWAjSlXU02JMECdbI8y9tKBRkrrC+M=
X-Received: by 2002:a05:6e02:934:: with SMTP id o20mr4235230ilt.211.1612389636636;
 Wed, 03 Feb 2021 14:00:36 -0800 (PST)
MIME-Version: 1.0
References: <xmqqsg6infev.fsf@gitster.c.googlers.com> <YBn3ndkwo9qvXHFr@danh.dev>
 <xmqqbld2djx0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbld2djx0.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Wed, 3 Feb 2021 23:00:25 +0100
Message-ID: <CAN7CjDC8dy4Kp=rD4rSu5pnxUAWQ=GyXmU98BsiL84H2XKbbXA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git <git@vger.kernel.org>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El mi=C3=A9, 3 feb 2021 a las 2:22, Junio C Hamano (<gitster@pobox.com>) es=
cribi=C3=B3:
>
> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:
>
> > On 2021-01-30 16:00:56-0800, Junio C Hamano <gitster@pobox.com> wrote:
> >> * mr/bisect-in-c-4 (2021-01-26) 7 commits
> >>  - bisect--helper: retire `--check-and-set-terms` subcommand
> >>  - bisect--helper: reimplement `bisect_skip` shell function in C
> >>  - bisect--helper: retire `--bisect-auto-next` subcommand
> >>  - bisect--helper: use `res` instead of return in BISECT_RESET case op=
tion
> >>  - bisect--helper: retire `--bisect-write` subcommand
> >>  - bisect--helper: reimplement `bisect_replay` shell function in C
> >>  - bisect--helper: reimplement `bisect_log` shell function in C
> >>
> >>  Piecemeal of rewrite of "git bisect" in C continues.
> >>
> >>  Will merge to 'next'.
> >
> > I think the bisect_log still haven't added back the:
> >
> >       We are not bisecting
> >
> > as addressing in gohp6kv9bml9qc.fsf@gmail.com
>
> OK, I'll put it on hold and wait for a proper fix-up patch.
>
I have just sent the new patch series version with this and other minor fix=
es.
Best,
Miriam.

> Thanks.
