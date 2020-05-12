Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C7C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 22:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D296A20747
	for <git@archiver.kernel.org>; Tue, 12 May 2020 22:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="1DVk+3nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgELWzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELWzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 18:55:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE290C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 15:55:35 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x73so11974489lfa.2
        for <git@vger.kernel.org>; Tue, 12 May 2020 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+x3bHUuoeEktoK6Hj7u2yshagnyUqskgm8dg4c/neZM=;
        b=1DVk+3nwK33IsZnndMw+qViFL8HRen+7Aq8UB11K2AJ2dIRw+Vm0ihTnjDJL4vNlJY
         Y+smtMfSjO3Z5h1v6Fs1rXzCjI1Ia4nr4RI3ILmAY1+L1VvxtbbSb0Q9ZP7cidWI/Y4/
         Zfu6+t3LWoYfI664kO+ijDYQAty16T+RFw+Xv+98M3wbf2YNJ/S+hqEkZC4rVkzQ2Qze
         tdloQm8KpjVtFV3OpTOs6wqEqyxUvzdDjEiI/wA+VcsCs5mLfGGW5CJ3ULjqbGoZF6a+
         HX2e1rznBJ0mLz4byLYbUnwOSkMF0SnBIG99LDVpLdbQWM0/Il3goIK31vnVHQIdThap
         nurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+x3bHUuoeEktoK6Hj7u2yshagnyUqskgm8dg4c/neZM=;
        b=f8yWK+VIPsPcbX5p7HGU1xyqPVjlDKkUOtXAP8DbVB1aMo0sLis12ypEV2rV0fMjzK
         PwqyBuTZ0+xdtFQVBOSXI1nIyZ4Yz3b+bo9UlLWXas1JKbwE6YooVh5deHbSlYEyEa7W
         uXAXFXInDuaWIV+IH/l5bawobZQhJh7MUeBdwpTm3VZW7KgVENxkeQaop00tFjulH2nw
         joqRcgU8yN0IHhp0P/ASCT3kes05eIWLx8CLGVXmG3nPAr7Hv9ymJkP0TpYDMTq5ALRJ
         zqJonF4C1Xko/NsuUoXxGqd1hXVMJbYeP5THjEXw7WVyLk+THSlfDd45znZYsBl7M2ys
         slIg==
X-Gm-Message-State: AOAM531uyWI1S4IEkAuUk6AkNjUaqFtrfxb6+JFcZJQMN3/SPnEtOn+X
        izUeGbdWef4HCF0biLVK+pCVw9WDciUR26ndADWkoA==
X-Google-Smtp-Source: ABdhPJxD+xmtYjlnsrnQCu8P9gGm4fYnZ6bJ28c+dyrbgaqz/FORy4Vg3e/0P+wBjdT4fvvbpYFrG6gdRgcm65nuxdc=
X-Received: by 2002:ac2:4213:: with SMTP id y19mr15022455lfh.99.1589324134269;
 Tue, 12 May 2020 15:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br>
 <882310b69fd3df0acc6823a2c73bbe1801d9f6c4.1589058209.git.matheus.bernardino@usp.br>
 <xmqqlflyqocl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlflyqocl.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 12 May 2020 19:55:17 -0300
Message-ID: <CAHd-oW4J4LVo3HPj-8WnRAOXOhxaLS8v3_SW2kOTO+SFuPas=A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] config: load the correct config.worktree file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 4:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > One of the steps in do_git_config_sequence() is to load the
> > worktree-specific config file. Although the function receives a git_dir
> > string, it relies on git_pathdup(), which uses the_repository->git_dir,
> > to make the path to the file. Thus, when a submodule has a worktree
> > setting, a command executed in the superproject that recurses into the
> > submodule won't find the said setting.
>
> This has far wider ramifications than just "git grep" and it may be
> an important fix.  Anything that wants to read from a per-worktree
> configuration is not working as expected when run from a secondary
> worktree, right?

Hmm, I think the code should be able to retrieve the per-worktree
configuration, in this case, as the_repository->gitdir will be
pointing to the secondary worktree's gitdir. But when we want to read
a per-worktree configuration from a repo other than the_repository,
then the code doesn't find the setting (even if it is in the main
worktree of the subrepo).

> Can we add a test or two to protect this fix from future breakages?

Sure! There are already a couple tests, in the following patch, that
check this behavior *indirectly*. As we recurse into submodules, in
grep, we try to retrieve the core.sparseCheckout setting for each
submodule (which is stored in the subrepo's config.worktree file). The
said tests make sure we can get this setting, and they indeed fail
without this patch. But would it be better to also add a more direct
test, in this patch? I think we could do so by adding a new test
helper that prints submodules' configs, from the superproject, and
then testing the presence of per-worktree configs in the output.
