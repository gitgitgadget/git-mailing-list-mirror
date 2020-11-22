Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C45C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 21:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFC92078B
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 21:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr1+aRHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgKVV4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 16:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgKVV4g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 16:56:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1043AC0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 13:56:35 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g14so1520635wrm.13
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 13:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iOL+LiEJwSYFwWIVcZXFdvQMI6p+LK2xGBE/QEa+oQ=;
        b=Wr1+aRHysxdLKosb5Yqe62k3KM3JphBBKFHH3aLWT5bKmjpWMH8vqKId8FknhfQJfz
         wDxn+Qo2/YwASUmmjqYvE5Lre+365N/fFE43rxW7ebwlBA+XBFLXdWfwYJMloQ21eGZm
         r/+kaznSzkuoW4+148RFLxWXMCGbfoqdxCE3xJ7YQnFewHdkEXEKR58mgmr+tUHwK71C
         AgrL9j5JVpXsv6oxDHcEYXEPh7u5cwwTh0/Xcj5jGiSeVdt5U+omePm7fSqvmpVq0dra
         jgkP6VkvF8jJ/npm392ZzuPPu0aqqZuiQzAUlUYN7HuTFeifREkYNgbFXbC/n65YoTSQ
         N22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iOL+LiEJwSYFwWIVcZXFdvQMI6p+LK2xGBE/QEa+oQ=;
        b=eaBlNVJt1/GjZPoXxZfIZ8ZQbE08rPceUaVPDvMhvw/I8UKxTJe0lsOXqOYfVcCHbq
         BeZhGRprO/6WG5GH0vWlrOJiZn+7AL73/VSVU9sFEZGrbalHm4EE1gv5xlLnCpUsyxlh
         T6DFMuK+OLSeAbxJceJSNkwtejeBvOk0tJZa2yxza8sqtx5em2me7DNo9ZprNkLx/rPG
         TW0Qs/rFR/QPja0M/8uPcNn1larbk0/HCh/dlj/xvoYmz8vbiOS/O/43q7gCJ48midi9
         ZocLde1KnvJHWlBIppxtz8r1n5gZ/uZZDoA0YdoFlPxJCHM0naUFf8A2gzHzuXdIOR1I
         il6w==
X-Gm-Message-State: AOAM532nosen1dZPwMf02SWvPUSNnduG97bzf4GO1/B4PJTzv5koB5vz
        RHxg0vMk/fHDOCC8nkf8YC+6hymr+Rr9EoxA24cFiGSTJFU=
X-Google-Smtp-Source: ABdhPJwjg5+6A9I3SUWY+KfZ5/vMTTMJRatlL0xiXp/QbTOwPHSPGBFgv7lmV8SzgZOKiCycPH+xXQweyfrh+rRklAc=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr27638155wrs.100.1606082193836;
 Sun, 22 Nov 2020 13:56:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
 <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email> <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
 <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email> <871rgpr497.fsf@osv.gnss.ru>
 <xmqqpn46qppl.fsf@gitster.c.googlers.com> <87y2it8zfm.fsf@osv.gnss.ru>
In-Reply-To: <87y2it8zfm.fsf@osv.gnss.ru>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sun, 22 Nov 2020 15:56:22 -0600
Message-ID: <CAMP44s2eccgXTqFgHwv-ciUJ+v2PkHzHtCpA_+vQ9XZ1Kw6VUA@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 22, 2020 at 4:24 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:

> > The latter (i.e. you are not on a branch) does not grow any branch.
>
> That's one way of looking at it, resulting in this "detached HEAD"
> thingy that is too technical for the git user proper, I think. Moreover,
> it immediately raises the question: if it doesn't grow any branch, /what/
> does it grow?
>
> Another way of describing it, that I prefer, is that you /are/ on an
> /unnamed/ branch and new commits grow this particular /unnamed/ branch.
> No need not only for "detached", but even for "HEAD" to be known to the
> user to get the idea, I think.

This is precisely what it is conceptually.

And there's absolutely no need for the user to know what HEAD is
behind the curtains, especially since they can just use @, and think
of it as "the current branch".

It is clearly a branch, for example you can do "git push origin @:my-fix".

Cheers.

-- 
Felipe Contreras
