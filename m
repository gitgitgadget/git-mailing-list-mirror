Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6A0C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F83360C40
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhHJQ6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJQ6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 12:58:43 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E128C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 09:58:21 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so5513750ooc.2
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt9PGzg1Hug7JFvCp6cn6s2Bz7oXtehfamloeMs8/34=;
        b=pNb9JhrKZKifniJDLluWrjTUGyAZT8YCZl830EBcr0j06ZNmoSI2+rf6shTYmuZBuj
         ECgm5SbEj2ZKJnWabQ5drQtEvs1E4UehiJG+vLMJa9OWRsXTWuB9WJs/89v8+oXyZFpa
         BtrrFcg9pbasMnQzSx+qEhtxOUmZUMumfW8cYhRjrwTKxtO7JsEBgkVhOOjd/XpKGzi6
         LCAt1/GZGaWQ6t+TAT2SK1mmOkWSuhyhfrCmd9GRooPTt+Hw9e4s8clds7RXVzEr8Aif
         FlDBTKi9BnHoNr1Ix1KNnH//8Jj/h7qvKKfxyWfsEh2Yac0b4xQoVmzHQqydOsOaPuTA
         flFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt9PGzg1Hug7JFvCp6cn6s2Bz7oXtehfamloeMs8/34=;
        b=kA/7lBbQDwASa6vB4WNHFNkme0OrhSBQFkiYKaB1YvuKv0Qbw57FovTIPTcf+TiGRW
         lyIWBvrBLNi1KbFGAHu+RQHky3pRrVprktO34/X3roCyaiX0QuflkbxJADksCh7/ovzs
         Swa63uFCFcznMVZdZbkHnvhpKzmwPOrG77vQWsrmM0esIaU/YIOha9E6UK+jB9Wlt7u8
         1TrEN21BInZpXTPJEeBRHhsV9d7C3Ww0E8qSl+jqFP4BYL5InKSui+jebZaIq//o5Nec
         BUqqOvEsPc57VuxIqFXsIH/sCFxKQ9qMuVfxW7HLomZBP0HJsOrosipLozUCElRWInt7
         fvYA==
X-Gm-Message-State: AOAM531z2V9FTobuqNJ7CV+mSWu/YjTxw3RJkTeGdfij4UWRQ0HL7c2l
        fstQPrMj+astncHjmdBsrEtTTBeJpUufbx8e1Vs=
X-Google-Smtp-Source: ABdhPJzS21FmAzlRP2b7dV8PNpcao/hmGi0cTDzj3xwIMD6EpdAF3scdVeJUgtp7FRnRkeMmRhgLUHUdmp19yHwhz1Q=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr19138545ooe.45.1628614700425;
 Tue, 10 Aug 2021 09:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com> <f7722dab21dafb73e64754b1286913eaa826f865.1628587917.git.gitgitgadget@gmail.com>
In-Reply-To: <f7722dab21dafb73e64754b1286913eaa826f865.1628587917.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Aug 2021 09:58:09 -0700
Message-ID: <CABPp-BFJD77wkroL5NFsH++a-yn0h6s6KM=Xfr2Ad_PfPQrUuw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rebase --apply: restore some tests
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 2:32 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> 980b482d28 ("rebase tests: mark tests specific to the am-backend with
> --am", 2020-02-15) sought to prepare tests testing the "apply" backend
> in preparation for 2ac0d6273f ("rebase: change the default backend
> from "am" to "merge"", 2020-02-15). However some tests seem to have
> been missed leading to us testing the "merge" backend twice. This
> patch fixes some cases that I noticed while adding tests to these
> files, I have not audited all the other rebase test files.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3403-rebase-skip.sh     | 2 +-
>  t/t3418-rebase-continue.sh | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
> index 6365c5af2f7..a44e68d0ffb 100755
> --- a/t/t3403-rebase-skip.sh
> +++ b/t/t3403-rebase-skip.sh
> @@ -52,7 +52,7 @@ test_expect_success setup '
>         '
>
>  test_expect_success 'rebase with git am -3 (default)' '
> -       test_must_fail git rebase main
> +       test_must_fail git rebase --apply main

Looks good.

>  '
>
>  test_expect_success 'rebase --skip can not be used with other options' '
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index f4c2ee02bc9..e4cb8be0418 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -36,7 +36,7 @@ test_expect_success 'non-interactive rebase --continue works with touched file'
>         git reset --hard &&
>         git checkout main &&
>
> -       test_must_fail git rebase --onto main main topic &&
> +       test_must_fail git rebase --apply --onto main main topic &&

I think the point here is that you're noticing that "git rebase -i"
and "git rebase" are both built on the same rebase backend (the merge
one) and thus that testing interactive vs. non-interactive isn't much
of a test.  The real test we are interested in is merge-backend vs.
apply-backend.  Your code change here is the necessary one to do that,
but it least the test descriptions still talking about interactive vs.
non-interactive even though that's not what we're concentrating on
anymore.

I'd say we'd at least want to change the description for this test,
"non-interactive rebase ---continue works with..." => "rebase
--continue with the apply backend works with...", but that we'd
probably want to change the description of the test before it and
maybe even just use rebase --merge rather than rebase -i.

>         echo "Resolved" >F2 &&
>         git add F2 &&
>         test-tool chmtime =-60 F1 &&
> @@ -254,7 +254,7 @@ test_rerere_autoupdate () {
>         '
>  }
>
> -test_rerere_autoupdate
> +test_rerere_autoupdate --apply

Looks good.

>  test_rerere_autoupdate -m
>  GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
>  test_rerere_autoupdate -i
> --
> gitgitgadget
