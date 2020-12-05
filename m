Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E14C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FEA22D6E
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgLEAth (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbgLEAtg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 19:49:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0381FC061A51
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 16:49:05 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id g14so6944403wrm.13
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 16:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5+syZXjMEtKd7Fa4Sf7+wnwZfYtA0RZFKkrWUpGrs8=;
        b=ZBb45IGuknDc8UBH/aX8D61arodpsW2MC3WhGA/6I/Nv56L15sDiDsChdQZ0ZJR/Wm
         d/OnoGM00mnwak39CUBVG9iyEXNJjUSxZyEMQ0HPh6k9isQnu11+B9gdQk3hei/qmtp4
         TzgSz33HvtbFOqKsHMMlLzVfAT11iegHeA1wod0NrvKTqLoUcN5p7rUNtubQ8pIUtcZq
         6/FJFVTsjbEJE4xiOrGFKGK7YnrS6qH198eCfJl4jU4UFASQfZ2FXaao+ecJaGIexjUY
         P2MsbLxLYHqJyZdsGThVxmKkLLKvG/RCr8NXWXcSqdN2FEIiM7yD4egfz7coLzZPx+Lo
         bMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5+syZXjMEtKd7Fa4Sf7+wnwZfYtA0RZFKkrWUpGrs8=;
        b=QoiL3ONkaTfaIrgqhnmRSpr1YgiJaAKUOYl2t2L3np6iSUOS0FnASeYfrw1+H/po9B
         5HYGZcCS4SrZz30CFPYZAWsVOvGWAhKtw4nOl7gEGccjm/hgPzPgBOJnqqLB1aZjzaf9
         PsTPIPJFzDVqhMrYPxUYgO/tR05JMkCeYv1J+xkyDuR3Lu/tyKYcWKcRzaoCy6xiKNPS
         dfs4XXWPj59cbvRjHMCnZCtJhRVWzvxcKgsIDAao6yeeGXOBnSfWsOxvKOaZAjfE/8Ld
         A/+PvT2J+0MxsChOyvdnV53beS8jKXiznBTcdPth0tbYov/iW2WoGUrxG8CegP73CXrp
         0cvQ==
X-Gm-Message-State: AOAM530StfT/sxu9HkSYT1V0SElHaZ+NzKvT3RWS0tsVJwQInm89pZBZ
        cKz7J9YQMzw3cOTtvS5aFJjBdCmiusgQNfp2WaQ=
X-Google-Smtp-Source: ABdhPJy3UkUw7Ft/2m2Z0ibr/jxCHOMl5ETeTx0LyRejP6BGVzP7V8BIpYfgLkY8SusLFY93dd+iYb98OmC62qgWRrk=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr393069wrw.139.1607129343731;
 Fri, 04 Dec 2020 16:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-6-felipe.contreras@gmail.com> <CABPp-BHs-eaJcTMcOPEsDx7PbBfoM0Uf7-vWi33OVOcTEgAgmg@mail.gmail.com>
In-Reply-To: <CABPp-BHs-eaJcTMcOPEsDx7PbBfoM0Uf7-vWi33OVOcTEgAgmg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 18:48:53 -0600
Message-ID: <CAMP44s3rtFWqaZz3Mg1yGuk+PwQeLJg0=TeLWbi6LDpSB9Rp4Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] pull: trivial cleanup
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:09 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > There's no need to store ran_ff. Now it's obvious from the conditionals.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/pull.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index c38548dab8..8daba7539c 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -1024,19 +1024,18 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >
> >         if (opt_rebase) {
> >                 int ret = 0;
> > -               int ran_ff = 0;
> >                 if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
> >                      recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
> >                     submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
> >                         die(_("cannot rebase with locally recorded submodule modifications"));
> > +
> spurious change?
>
> (It does make it look nicer, though.)

Nope. Was intentional.

> >                 if (get_can_ff(&orig_head, &merge_heads.oid[0])) {
> >                         /* we can fast-forward this without invoking rebase */
> >                         opt_ff = "--ff-only";
> > -                       ran_ff = 1;
> >                         ret = run_merge();
> > -               }
> > -               if (!ran_ff)
> > +               } else {
> >                         ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> > +               }
> >
> >                 if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
> >                              recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
> > --
> > 2.29.2
>
> Yeah, reads better to me after this cleanup.

-- 
Felipe Contreras
