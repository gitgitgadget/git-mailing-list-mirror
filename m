Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38DC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B7623E23
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 02:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389283AbgLKCBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 21:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389439AbgLKCBF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 21:01:05 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64913C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 18:00:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id x22so6268751wmc.5
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 18:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSyCZUy5mOvlTOSl2Yg3SOBdKCj0dCG3d4NSh4jvCkE=;
        b=HZzFww/qh2XzgKPlig5O5CwCn6gjxrO5BFGQOpWd64DZmbnp3D514GMaCbkcBNRZb1
         Hi9y6k7HcDma1NE8a8yqYsQSO3SMToYX1UXwmUKkvkCR/qBJV2Lvj5EroyIukhf/qUn6
         Ij0IbqGV9UxWLSWask66YjPRuLvHKFHBdKjuOHMjhU44jwP37c+OzSnZ5Vs7MRkLVT+A
         /ODEeDQA5N2duE1f+ldrfARs4JqhDmt90YC+mcvaMGrjMHq7XJEug3oR97YstYDCsQQK
         q80PMnNf+vxiSKm5Q+OG6Sb7o2pwMx4nwHKF0n/PDDYQK2kN8zG8k7xTR7DEmqWDDdoS
         /v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSyCZUy5mOvlTOSl2Yg3SOBdKCj0dCG3d4NSh4jvCkE=;
        b=bQ3wSz2GB5gSyvqej0wPXp/MYklK4KY8Xsu1zN65N1n1mOHhvMoZaUxB+v3elN8K1h
         3Jq4MCldd07DUYZm7l/piUdeacHWvdSS3Pxq41OTevTdaodPXvu9d8qbVZSfi6Pnd/Yu
         ZUBWoMA2S9WAmY0Ty2gzYkarGozJ92ZklOvcnwYmRfKjohWZ4jaol7PrUjo/mOgvQ7nl
         DemTkHvMaYUjqCrP6MQUQa7aAkBrec+DHXNY4gvsRQ2UV3fzerd1yBUSQCzDO/6e7vKj
         slWbIkvYn8neBNRY6EYuCDmz7VjF6xWnlUoB9hR3whcq8A1g86xipXgq6SMWn+ZUgljn
         jqfg==
X-Gm-Message-State: AOAM530tL6n72U+dqNPn+snJapfC5LpVtV6VqerX6buu0swaZjC3Ezv+
        OKlv4FYdesnFqjr+tkaBh7uk5k4cEOLZy+frevM=
X-Google-Smtp-Source: ABdhPJxoOshH/B2Qb3Qs6zn9IaV1tLIrAeq5BM1m4qKAkHXy5pD76TM7Z5Lq0X8II/AAfkHjU87IBY3v4GRhy/0R1+k=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr10983079wmg.37.1607652023169;
 Thu, 10 Dec 2020 18:00:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
 <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com> <2f21c505d560132b4563849f955554fc7d79a9cb.1607637517.git.gitgitgadget@gmail.com>
 <CAMP44s0mEsfmc7gT6Yv10_nt8d=HrbETmnwNNqxVmRGdHSOHYw@mail.gmail.com> <xmqq360dqgpa.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq360dqgpa.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 20:00:12 -0600
Message-ID: <CAMP44s3bhPP4BcNCfa4KeaoaDLm+XZqV1cX8wyaMmZyHzJujuw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] init: provide useful advice about init.defaultBranch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > On Thu, Dec 10, 2020 at 3:58 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> >> +static const char default_branch_name_advice[] = N_(
> >> +"Using '%s' as the name for the initial branch. This default branch name\n"
> >> +"is subject to change. To configure the initial branch name to use in all\n"
> >> +"of your new repositories, which will suppress this warning, call:\n"
> >> +"\n"
> >> +"\tgit config --global init.defaultBranch <name>\n"
> >> +"\n"
> >> +"Common names are 'main', 'trunk' and 'development'. The initial branch\n"
> >
> > This is disingenuous; the most common name is "master"... by far. In a
> > couple years this might change, but not right now.
> >
> > If you don't want to mention "master", then don't mention "common
> > names" that are not really the most common names.
>
> Names commonly chosen by those who want to move away from 'master'
> are...

But we don't want to spill drama into the user interface.

I think the vast majority of users haven't heard of this drama. Just
like the vast majority of users had not heard of the git-foo
obsoletion even after several years. Our vantage point is skewed for
being too close to Git development.

Those users will ask: "who wants to move away from 'master'?"

If we don't presume our users have the same knowledge as us, we have to explain:

  Names commonly chosen by those who want to move away from 'master'
  are; 'main', 'trunk', and 'development'. For more information read
  this post:
  https://dev.to/rhymu8354/git-renaming-the-master-branch-137b.

I say don't. If the user wants to know why anyone would want to change
"the default branch name", she can google it and find out.

Cheer.

-- 
Felipe Contreras
