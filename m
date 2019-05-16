Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC6B1F461
	for <e@80x24.org>; Thu, 16 May 2019 12:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfEPMGJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 08:06:09 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55132 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfEPMGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 08:06:09 -0400
Received: by mail-wm1-f45.google.com with SMTP id i3so3346450wml.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 05:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87soJgehf5Zser9pigM11FGKn6OLxdNNA5q/5anP4BE=;
        b=MG3Xzykas0JYb53tKCc8gkCnzLGzzTElClM2gxGGrl97XiJ9DcQoeUyJvFGh0CxHib
         OY8tRSYQSmTHSe2nRC3sVUE3qT557mk3t4iTk8jgkVb91gb0mSQO5IJhY6+8EnJKWu1r
         rk0QoWF+GZgjvQQH11r8ScBpSUeF4SpvEIluCzzDy7rq3uI205cJ9PNr3/9bY+vy8TRA
         ZSMPVwRXKT26OBDVJF+u5Ys+bsMA8Ou86TQy8NpCSlOnLYO+rcTMEwxziV44j1kcgXH0
         Hhoa1Gvu7GdU2P/XVNNatgKTPONIQR6YjKWQ4RSzTmGpI38eKX0NQgwT7FjCkc60dElM
         jeoA==
X-Gm-Message-State: APjAAAUH7M3edxvhimbLPYgkUb/89AhalsbQGGQEi1FkBWAklLm1DhK3
        dEVga/Cr819dQWZ86yrnvHwW14cgcXlAuBA0HbvSODCy
X-Google-Smtp-Source: APXvYqznzU5qhCXebFAOXJqOEpBL7WAo7xTCUmoz6P2fqP2yjyYAb3qACh9ad6vwiPzj83JdatXMh5Gt9487OOy28dc=
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr28598183wmb.76.1558008367555;
 Thu, 16 May 2019 05:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
 <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com>
 <CAPig+cS1iypB9oZ+O=KsJ7CHyWUEOKzr8djRthrXMdC+uNHVKA@mail.gmail.com> <CACsJy8AgzSZ_Gj9JW2yTdgkGQNCMMLy8i+pH_+A93+V95anQWQ@mail.gmail.com>
In-Reply-To: <CACsJy8AgzSZ_Gj9JW2yTdgkGQNCMMLy8i+pH_+A93+V95anQWQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 May 2019 08:05:56 -0400
Message-ID: <CAPig+cTkiBhZ70SC=xXQP_RfkDagCRLFxpcZYLidQrz9_v-_Bg@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 7:45 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, May 16, 2019 at 6:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Thinking more clearly on it, a better fix might be for git-worktree to
> > deal with this itself, converting such a path to absolute before
> > cd'ing to the new worktree directory (or something -- I don't have the
> > code in front of me to provide a more concrete suggestion).
>
> Our mails crossed. But yeah it's basically the same thing.
>
> Although I still doubt a good $GIT_INDEX_FILE would fix the problem.
> Even if you manage to create a new worktree, when you cd there and
> start using it, this $GIT_INDEX_FILE will still mess things up (unless
> you do mean to ignore the worktree's index file and update one
> provided by pre-commit hook).

I was forgetting that each worktree has its own index. Your advice
that his hook should sanitize GIT_INDEX_FILE (and possibly other GIT_*
variables) is probably the only sane approach. I don't think it's
something we can handle in some automated fashion since we don't know
whence GIT_INDEX_FILE arose.
