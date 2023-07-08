Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD017EB64DC
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 18:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGHS5X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGHS5V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 14:57:21 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF526CD
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 11:57:20 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-560b7ac3cbfso2430011eaf.2
        for <git@vger.kernel.org>; Sat, 08 Jul 2023 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688842640; x=1691434640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPUybzd8MssWJXzvMz9qiTr3upUafMetbqP8piAAsRw=;
        b=ko9CwBtYKI6wZKY3tyZMIi0LPTpmPx9HXRPjTinSIuUzxThyRy8xvOXvTHVzb2uXbs
         rP4Hf+nEa90xKmU3WtOX5AhM1sM6vzhsdadf7nd9vveXCROJjM3MV/dCmFvMBHG+v2+c
         t8Kj6tL7KcfkfRGs6iry8tx3+vFEZJsrrd2XCmYoCbosNyQFPebD/vc42m352ZOM/6cY
         cfrC8bkWgbih4zqaG7AsDy91W74E0ykijrxlB8rzSlhtps51VGaBRIKo+TehoL/4eepd
         LZQ9voEyGnKnDMuAx6oagvk6R+Vd9E2N3AwneFuAyubaW3TGSphXCS1ZWnRZZAWYjbKm
         uLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688842640; x=1691434640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPUybzd8MssWJXzvMz9qiTr3upUafMetbqP8piAAsRw=;
        b=hQrk7bzO0E4Se1xg8mlUIF9kapyfazyc8B6parvnqc/avxO4fn3qb/8CgySbR6GZ2s
         eQplUTeXFnreGEpz5hLyQVz78XNfEQ6SJoweZ9PDiFuPLbMuNXajwlMqbb9xBs6xld4E
         j1P2YreexqDeOIll1pHskryffa0qUcYC5THeS20LRJcF2ABYTQScyyfCwL54Zrm0MD1Z
         QN+I4OcdlDG5tDfK761+efY37AFhlPAREXPmZ8kkAXnOGcXzZFezUGMArhb96n1qxVx5
         hgegoc0K6sp2FsQeTWd40sAZpWXdF21F4DbkugoZ3GxuoR8HxJlMhlUm1UtvSzcEPt9T
         wyFw==
X-Gm-Message-State: ABy/qLYH1zYGXonQ/Iud4iZTq20H9wfZOFtBbTVb+P7G3pcVlDnhMdzp
        yAfOLE55pgJEK6XWvzYGP5OiO7RBPM5rTzk0TjL/8GZLC4g=
X-Google-Smtp-Source: APBJJlFl+UkLTdw1eY0LAUajNDu2di08EU/csqAPh5zTRF7q6hBhSGa6gESXDCWPZre90nxurXBAjXBqFE53u13lpvs=
X-Received: by 2002:a4a:2c89:0:b0:563:2489:dfe6 with SMTP id
 o131-20020a4a2c89000000b005632489dfe6mr7177596ooo.5.1688842640248; Sat, 08
 Jul 2023 11:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com> <20230706040111.81110-3-alexhenrie24@gmail.com>
 <82255166-49ac-3c10-1744-27d6d436822e@gmail.com>
In-Reply-To: <82255166-49ac-3c10-1744-27d6d436822e@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sat, 8 Jul 2023 12:56:43 -0600
Message-ID: <CAMMLpeSk7_2xn_atUoVeyFSHwE3TNDijSwDMo6PVbvf4XFUvtw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] push: advise about force-pushing as an alternative
 to reconciliation
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 7, 2023 at 2:49=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:

> This message would also benefit from adding explanation as to why this
> change is desirable.

OK, in v5 I'll add more explanation to the commit messages, including
points brought up in this discussion.

> >   static const char message_advice_pull_before_push[] =3D
> >       N_("Updates were rejected because the tip of your current branch =
is behind\n"
> > -        "its remote counterpart. Integrate the remote changes (e.g.\n"
> > -        "'git pull ...') before pushing again.\n"
> > +        "its remote counterpart. Use 'git pull' to integrate the remot=
e changes\n"
>
> This is much clearer than "(e.g. 'git pull ...')"
>
> > +        "before pushing again, or use 'git push --force' to delete the=
 remote\n"
> > +        "changes and replace them with your own.\n"
>
> I think it would be good to give a bit more context here as to when
> force pushing is a good idea. For example something like
>
>      If you have rebased the branch since you last integrated remote
>      changes then you can use
>      'git push --force-with-lease=3D<branch-ref> --force-if-includes' to
>      safely replace the remote branch.
>
>      If you have deleted and then recreated the branch since you last
>      integrated remote changes then you can use 'git push +<branch>' to
>      replace the remote. Note that if anyone else has pushed work to
>      this branch it will be deleted.
>
> It makes the advice longer  but the user get a specific suggestion for
> their current situation rather than a generic suggestion to delete the
> remote changes without discussing the implications. In this case we know
> that it was the current branch that was rejected and so should fill in
> the branch name in the advice as well.

Even if we could fill in <branch-ref> automatically, it's too much to
ask the user to type out --force-with-lease=3D<branch-ref>
--force-if-includes. Mentioning `git push --force` with a fat warning
about how it only makes sense in a narrow (but common) case would be
enough to make users aware of it while deterring them from abusing it.
The advice already refers the user to the man page for more
information, which includes a discussion of --force-with-lease and
--force-if-includes as alternatives to plain --force.

> My main issue with the changes in this series is that they seem to
> assume the user is (a) pushing a single branch and (b) they are the only
> person who works on that branch. That is a common but narrow case where
> force pushing is perfectly sensible but there are many other scenarios
> where suggesting "push --force" would not be a good idea.

The goal of the series is not to assume that the user's situation is
that narrow but common case, but rather to not assume that the user's
situation is not that case. The most important thing is to make the
user aware that integration/reconciliation is not the only possible
way forward.

Thanks for the feedback,

-Alex
