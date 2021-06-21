Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15C4C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D176B61164
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhFUVma (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhFUVmY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 17:42:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45391C061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:40:09 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s23so21488843oiw.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ebiMeds/h0zQiFO8IUfCCC4nniF/lSUzhVmta3L1yE=;
        b=vanyAj4oN7Zn3WcSXfJQRwKJnv4ZnJuTdsfbvmialrn5zg9dGEDsaD3RMhKbkNOq+3
         tcR9zc9Zf/t5AqYFGcto4JrXq1TNmbGrpZTWUiVdptJQ1gMjJ6K0E7hHFdI8gDm2eEJo
         w8fEx1On6nzqMMCpfg7ryE9fMboRCVCrq6h1+VWsW7akPNWzFZu1pqDZ19BiRLxh4Uuv
         7kuFvku6ONfLDpBe8bMf3tdGMYhXTCBtnMGjvgtA9iutyVtLICpoC7Li2hBKCkFUlMaI
         6u1QmEO30XMWOezVqur72mJM2UN4Wecbxutt57y7xycLAe4BB+aIKH4eVCeguM0UIRrW
         Gx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ebiMeds/h0zQiFO8IUfCCC4nniF/lSUzhVmta3L1yE=;
        b=Lt2OsmNYC4IohQYiMzFeRxpw4vdb/CfeGdnZWrKAgDGvCURFWZUiLJ0/eWVK35w55K
         ne0DmI5mOb3sDBo4hPFRzN5B4uDEGc27JNPHZU0OVGeia/gtSpp+AHLi+0gwamxMfKZx
         MdFmucgOURXK7dvkEQPMVdsDyqewN1pNMXPkZMb0iFeQTduK7j4N2tKxOYA8KUxn+RYN
         xd3DMIbyk+EkQi6tP8BACLIsSEaydKH294Lg/qd0a2WBxQd1WSKxC9pHJlM00RoPnaJH
         OWMsTn4ZS5kbU/LIyYI2nA39fGvA+MWYjN7EBsEhqV4V5Zvk/vi0tWc3PglF1SLkPFNv
         Yd7Q==
X-Gm-Message-State: AOAM5317tWYdqRSB/XZH9ECKceD2KUPjzgC4IYLTCU4sveFbkgpvsZDr
        Y2EXGdlM1cbhhHaovKKhIo6kH7eKJfMhCsC64ug=
X-Google-Smtp-Source: ABdhPJzanozezYaPfuUpm0Lyb0hnaKgZ0gys/6wOXq2UGIGGTK74mIKkVjLIRAvK0jl43CPveReWfg71vUrvsBm3GV4=
X-Received: by 2002:aca:f482:: with SMTP id s124mr387377oih.167.1624311608726;
 Mon, 21 Jun 2021 14:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210620151204.19260-1-andrzej@ahunt.org> <20210620151204.19260-12-andrzej@ahunt.org>
 <6e02fc85-42a4-8b19-1fe7-3527c2308a24@gmail.com>
In-Reply-To: <6e02fc85-42a4-8b19-1fe7-3527c2308a24@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 14:39:56 -0700
Message-ID: <CABPp-BEQkUQLt-ZbwdO+ecd2rumttBUKUmh3=7LaKRxwXCkB+g@mail.gmail.com>
Subject: Re: [PATCH 11/12] builtin/rebase: fix options.strategy memory lifecycle
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Andrzej Hunt <andrzej@ahunt.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 20, 2021 at 11:29 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Andrzej
>
> Thanks for working on removing memory leaks from git.
>
> On 20/06/2021 16:12, andrzej@ahunt.org wrote:
> > From: Andrzej Hunt <ajrhunt@google.com>
> >
> > This change:
> > - xstrdup()'s all string being used for replace_opts.strategy, to
>
> I think you mean replay_opts rather than replace_opts.
>
> >    guarantee that replace_opts owns these strings. This is needed because
> >    sequencer_remove_state() will free replace_opts.strategy, and it's
> >    usually called as part of the usage of replace_opts.
> > - Removes xstrdup()'s being used to populate options.strategy in
> >    cmd_rebase(), which avoids leaking options.strategy, even in the
> >    case where strategy is never moved/copied into replace_opts.
>
>
> > These changes are needed because:
> > - We would always create a new string for options.strategy if we either
> >    get a strategy via options (OPT_STRING(...strategy...), or via
> >    GIT_TEST_MERGE_ALGORITHM.
> > - But only sometimes is this string copied into replace_opts - in which
> >    case it did get free()'d in sequencer_remove_state().
> > - The rest of the time, the newly allocated string would remain unused,
> >    causing a leak. But we can't just add a free because that can result
> >    in a double-free in those cases where replace_opts was populated.
> >
> > An alternative approach would be to set options.strategy to NULL when
> > moving the pointer to replace_opts.strategy, combined with always
> > free()'ing options.strategy, but that seems like a more
> > complicated and wasteful approach.
>
> read_basic_state() contains
>         if (file_exists(state_dir_path("strategy", opts))) {
>                 strbuf_reset(&buf);
>                 if (!read_oneliner(&buf, state_dir_path("strategy", opts),
>                                    READ_ONELINER_WARN_MISSING))
>                         return -1;
>                 free(opts->strategy);
>                 opts->strategy = xstrdup(buf.buf);
>         }
>
> So we do try to free opts->strategy when reading the state from disc and
> we allocate a new string. I suspect that opts->strategy is actually NULL
> in when this function is called but I haven't checked. Given that we are
> allocating a copy above I think maybe your alternative approach of
> always freeing opts->strategy would be better.

Good catches.  sequencer_remove_state() in sequencer.c also has a
free(opts->strategy) call.

To make things even more muddy, we have code like
    replay.strategy = replay.default_strategy;
or
    opts->strategy = opts->default_strategy;
which both will probably work really poorly with the calls to
    free(opts->default_strategy);
    free(opts->strategy);
from sequencer_remove_state().  I suspect we've got a few bugs here...
