Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17C4C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A3D619D3
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZPNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhCZPMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:12:50 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB86C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:12:49 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id p2-20020a4aa8420000b02901bc7a7148c4so1362966oom.11
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4cFvhj7y+L1ZWXcuH7zo2VcnA3KCYt9R311XmiPHU4=;
        b=CK0LFuCbH0GrLELArKJJjSyrXJjOmYzenl6HvU1hrQRhj3RrG+idPez/0dmxb9y+yM
         pbn6Zv6ie4VpBPolxwzUv3PDqao7NB18H9xDa9rn+8r/OiEetSEOePM9TjHbZjxuxfdf
         Gdia/iYHY1qAabYhPFM776WO9EbVqhTdS0P2/4tGSe0JfmbIauqtWBZKtFyrJ9xMAXJ/
         qw9bzRcTOORyLCbANiqaKJ2CXGRmlbpGjMGG5KGkZ7xFRKRZAGDZd30YuAm5vjHRpPtc
         QddidSuk7SOlgI812kKMfhUlIt2MpXI1stk7DABrL6w1ELmb3YMdjlKjSKD9NLRqZmTt
         9QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4cFvhj7y+L1ZWXcuH7zo2VcnA3KCYt9R311XmiPHU4=;
        b=FroIhjdsVXuUEbVtKuUcqcgPkSxAcvAph3iadJprfofAk9Z3WhUHIsGBeXr0S7GL9v
         bhUVuq2u42aARZ8bnDo6DhyVy0JP+JAFI5lrAKqq0l+ZcGeCK7TAoNKsHt0tPK9nb692
         caEVlGDlTUuw4+0adImXMv5B2vUO4KUNEDf6KohXon9uzG4qWEV1q8Pq4iOxCmRSBd+s
         L2v04TjmK0/3Mrg/dxK6cH4eh4SyWu5GZE3fzp2/vV6/T6lFDIa0MdnOH53LfhBH9PAs
         Nk3AKT787lr3PzBx4995yyUFJRuZsAVPM0WnbaqrZoGYvfwG68XDkt9qT9JX49CWbmT1
         gBkw==
X-Gm-Message-State: AOAM533QVbgYEK66grxrN9gBFSTexSmJDTtLC0Gkt1YIYtaZVyghbZ/q
        67LhkCXmgSvxGhqoTBmitlTb6eZCp0Oh38nNxrE=
X-Google-Smtp-Source: ABdhPJy2mD8JNu95HgO3GzUIf/MDxPlVmQ3cHrtzCLUkdv9oTQXfMb6NDEvKHV3yt5XW8+q0f5SyXN1KWrUEBXJa6KA=
X-Received: by 2002:a4a:bd1a:: with SMTP id n26mr11541882oop.45.1616771569120;
 Fri, 26 Mar 2021 08:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com> <eda509dd-d2d5-0856-0c75-094d67257d54@iee.email>
In-Reply-To: <eda509dd-d2d5-0856-0c75-094d67257d54@iee.email>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Mar 2021 08:12:37 -0700
Message-ID: <CABPp-BHgQGYLobmYvyj4u=KLePosoCq2Y_JY6aUJOQcP_PB1iw@mail.gmail.com>
Subject: Re: [PATCH] sequencer: fix edit handling for cherry-pick and revert messages
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Mar 26, 2021 at 5:27 AM Philip Oakley <philipoakley@iee.email> wrote:
>
> minor nit on a code comment
>
> On 26/03/2021 07:16, Elijah Newren via GitGitGadget wrote:
...
> > diff --git a/sequencer.c b/sequencer.c
> > index 848204d3dc3f..2fe0e0eff7e6 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -1860,14 +1860,26 @@ static void record_in_rewritten(struct object_id *oid,
> >               flush_rewritten_pending();
> >  }
> >
> > +static int should_edit(struct replay_opts *opts) {
> > +     assert(opts->edit >= -1 && opts->edit <= 1);
> > +     if (opts->edit == -1)
> > +             /*
> > +              * Note the we only handle the case of non-conflicted
>
> This 'Note the we' doesn't parse for me.

Oops; should have been "Note that we".  Thanks for pointing it out;
I'll fix it up with any other feedback that comes in.

> > +              * commits; continue_single_pick() handles the conflicted
> > +              * commits itself instead of calling this function.
> > +              */
> > +             return (opts->action == REPLAY_REVERT && isatty(0)) ? 1 : 0;
> > +     return opts->edit;
> > +}
> > +
