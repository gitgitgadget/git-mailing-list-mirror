Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19514C77B73
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 20:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjFEUSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 16:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjFEUSj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 16:18:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB0173F
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 13:17:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6ffc2b314so46264885e9.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685996228; x=1688588228;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKLwS1FJkAj/MaJG0sme4wlHyZYmtBgtJfnBjuGkOts=;
        b=ZC/3xbNnGlw5jEs5lGnTFhUpDr/vHJpNGA4PWlI2eNm9pEROA8P11qCvBfGYg2y2UZ
         4xX4WdqsrkeIMj4aIpNVK+J57BeKNo/5nlAmQ1QKW6v1pS3Khf29rfIpCnOxQOs+JwAQ
         7d4w86xs+Z3aOhySD5WqVRq9spFi35U7geeoptebpVylEnvnXtbIY9ecLhUUajyY90MT
         vks3uHvxCUGkmnNVRmW66FWJ8G28N10lwBg0qMeoODiMf2CNV0XlOqcVvLOeM4hyirXT
         EJ/1dx5yX4f4gGNPQHvGczptqNw+B8tBMY0LqiMXglOkS43O78fXzqlfHMFi76YWUhJa
         PQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996228; x=1688588228;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKLwS1FJkAj/MaJG0sme4wlHyZYmtBgtJfnBjuGkOts=;
        b=h5o5T6YxUtVyWPtDKglu/AKC4/2xoXQJ1xwgmvpIzkT2hS+/iDYrETV4vjRaGzRO15
         JRgRGWEqyIpG9/uit8JOcAzBjAVSXa7u5IC3HN2m4BAGGwVQSIB/KBN0fYSFp3GTupab
         37j8dDHb2G0Nd4RksV5QmZ6Tx98O8nXgHrOBwWdS36PecG27uXt0UmNZuRdKg1kJz2Nq
         rnkk4ghNVUqDIoeqJeGe6fqot1Z8R2mT6fRL9d3/Z4WzRKeV2txI+MqX7NLizNM851aK
         axbAAE9o5K5iZtbB15XJnX5NAPuy9aPyaj0lXrqxFw3iz4Yss6ylcCZQl6YFkPXH1wKM
         OVFw==
X-Gm-Message-State: AC+VfDw5jFPW1FVLXoHty/rgh6XxvfaQcIDuQ01SEpHSMtuWwufp1Dwy
        VMb7V1VEn77aPf+B6QG820Y6qdwAK2hVnhWPpqp6sPjIzpj5HQ==
X-Google-Smtp-Source: ACHHUZ45jO1KJn6EkFSXIgRUavYjixtd1ivXKipJc4Q0DAaAA8+gPhR7ly78kgLkIwU5BEm5oaAWzxnDseeTKs950uE=
X-Received: by 2002:a5d:65cd:0:b0:2ef:d0de:e8a4 with SMTP id
 e13-20020a5d65cd000000b002efd0dee8a4mr73064wrw.25.1685996227695; Mon, 05 Jun
 2023 13:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230605161644.491424-1-cheskaqiqi@gmail.com> <773c2f7a-8637-ab0b-e0a8-ab553c90e88b@github.com>
In-Reply-To: <773c2f7a-8637-ab0b-e0a8-ab553c90e88b@github.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Mon, 5 Jun 2023 16:16:55 -0400
Message-ID: <CAMO4yUEQZz8DqPb7RyN8Owb=23p==6XS6G7Bza77p4-iydo6Qg@mail.gmail.com>
Subject: Re: [PATCH v1] worktree: integrate with sparse-index
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2023 at 3:16=E2=80=AFPM Victoria Dye <vdye@github.com> wrote=
:

> >
> > The `p2000` tests demonstrate a ~20% execution time reduction for
> > 'git worktree' using a sparse index:
> >
> > (Note:the p2000 test results did't reflect the huge speedup because of
>
> s/did't/didn't
>
> (not worth fixing if you don't end up re-rolling, though!)
>
> > the index reading time is minuscule comparing to the filesystem
> > operations.)

Will fix it!

> >
> > +test_expect_success 'worktree' '
> > +     init_repos &&
> > +
> > +     write_script edit-contents <<-\EOF &&
> > +     echo text >>"$1"
> > +     EOF
> > +
> > +     test_all_match git worktree add .worktrees/hotfix &&
> > +     test_sparse_match ls .worktrees/hotfix &&
>
> I see why you're comparing 'sparse-checkout' to 'sparse-index' here (thei=
r
> worktrees should both contain only the files matched by the sparse-checko=
ut
> patterns, unlike 'full-checkout' which will contain all files), but this
> won't catch bugs that apply to both sparse-checkout and sparse-index (e.g=
.,
> if the sparse checkout patterns weren't applied and the full worktrees we=
re
> checked out).
>
> To make sure that doesn't happen, you could add a section that compares e=
ach
> test repo's default worktree to a new worktree, e.g.:
>
>         for repo in full-checkout sparse-checkout sparse-index
>         do
>                 worktree=3D${repo}-wt &&
>                 git -C $repo worktree add $worktree &&
>
>                 # Compare worktree content with 'ls'
>
>                 # Compare index content with 'ls-files --sparse'
>
>                 # Any other comparisons that are useful
>
>                 git worktree remove $worktree || return 1
>         done
>

Will do !

> > +test_expect_success 'worktree is not expanded' '
> > +     init_repos &&
> > +
> > +     test_all_match git worktree add .worktrees/hotfix &&
>
> Shouldn't 'git worktree add' not expand the index? Why use 'test_all_matc=
h'
> instead of 'ensure_not_expanded'?

Here's my perspective on why my use of "test_all_match" instead of
"ensure_not_expanded" in "git worktree add":

The functions "validate_no_submodules" and "check_clean_worktree" are
specifically related to the "git worktree remove" command, and "git
worktree add" doesn't require index reading, so with or without the
"ensure_full_index" wouldn't affect the "git worktree add" command.
I look forward to hearing your thoughts regarding whether my
understanding is correct or not.

Thanks for your valuable feedback=EF=BC=81
