Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA7EB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 20:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjFUUtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFUUtK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 16:49:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EC110D2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:49:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd5f9d084c9so7326012276.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687380549; x=1689972549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXvlgeMXYrKH4aV8hTrtqu/RQbGPT+IFbzbJ3NLA3Mw=;
        b=g4mp1VsNY1enEjO6ZH545T+9fdtb7sPmKUQmulQU8z9BG0AkB0CIjihiho0RUWO9Aw
         wxIFPfVnPDc8ep8GLptYrQAW9jTnD4pF40kJdnkKYqtE94H0Do8ida+u/GlC+IeXIxnR
         daeyqlMVDF9RHv2N5qfLIrs1NfFmyLcXohXv2SXVbJf7ukOPbwqgI+2ZUhCyK1Vs+aOT
         24rCM6V4jsTvq/rWMS522SwPV29w0ziTiEw7iMMXiKUYf4rs8VkQCMHlVaKKJwC0i5Mr
         lp5SnTTNosK0inQ3Uud0DPQMCyF8A050zkIKbY1nIm3yceBeDJxK1/p+tPkkQgmf4jHh
         JSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687380549; x=1689972549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXvlgeMXYrKH4aV8hTrtqu/RQbGPT+IFbzbJ3NLA3Mw=;
        b=eBfA7w+5D7xKQ4U9gReLiZHYn3ckX1HVwsTALDQrGHQjX0wkyuZMtuVxMhTD83QVk9
         1UZqBIYpbNNZYrMR2QXY6uu6qq3L040qahSI4xtIO10xWl+Ffy/M5q17jUF6knhX5LSD
         Y9kAif+a0fvAJRLbsGcxlQZLgB9h1yf0u99zhB7CGbMqIwfR7VWwlNJMbhtDKGhwBAR9
         9KBaPzlVc9ZoxV39ugxE0GdRsg0UEAz5gsBYYRC5YeFZY1FUcVN4BcYwvP6jVdJAxjz7
         VJtKbP6p4aJD36j0DFb3V7kYV8aUFQ1I7qnm1vAQNkYtzpVwYPoMkIsF67L7xJcFp/uS
         ObTw==
X-Gm-Message-State: AC+VfDwbXzclrWa5ZkbzEfnHA9goznuEo519rdIahRSNrL0vCNZQt4Po
        wKgBElSooQko0EAfRCYdDUusUSU3PRf/DQ==
X-Google-Smtp-Source: ACHHUZ7dWuPO/lmUGM4dJXj9uoFC0edTVB7+Wp6VPLN8AdP7u6unFWWR8y/6SuR1Tm/fRs2sd3AUPFgQcoNHmg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:7346:0:b0:bfe:9259:8f1d with SMTP id
 o67-20020a257346000000b00bfe92598f1dmr1851725ybc.6.1687380549243; Wed, 21 Jun
 2023 13:49:09 -0700 (PDT)
Date:   Wed, 21 Jun 2023 13:49:07 -0700
In-Reply-To: <f8e64c1b631116367e6e68fcfde711b507a03a94.1682089075.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <f8e64c1b631116367e6e68fcfde711b507a03a94.1682089075.git.gitgitgadget@gmail.com>
Message-ID: <kl6lmt0sr16k.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 5/6] rebase: fix rewritten list for failed pick
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When rebasing commands are moved from the todo list in "git-rebase-todo"
> to the "done" file just before they are executed. This means that if a
> command fails because it would overwrite an untracked file it has to be
> added back into the todo list before the rebase stops for the user to
> fix the problem. Unfortunately the way this is done results in the
> failed pick being recorded as rewritten.

I could not make the connection from the described problem to the
proposed solution. In particular, I couldn't tell what about "the way
this is done" that causes the incorrect behavior (e.g. are we failing to
clean up something? are we writing the wrong set of metadata?).

> Fix this by not calling error_with_patch() for failed commands.

So unfortunately , I wasn't sure how this solution would fix the
problem, and I didn't dive too deeply into this patch.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index c1fe55dc2c1..a657167befd 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1289,6 +1289,10 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
>  	test_cmp_rev HEAD F &&
>  	rm file6 &&
>  	test_path_is_missing .git/rebase-merge/author-script &&
> +	test_path_is_missing .git/rebase-merge/patch &&
> +	test_path_is_missing .git/MERGE_MSG &&
> +	test_path_is_missing .git/rebase-merge/message &&
> +	test_path_is_missing .git/rebase-merge/stopped-sha &&

This also seems to be testing implementation details, and if so, it
would be worth removing them.
