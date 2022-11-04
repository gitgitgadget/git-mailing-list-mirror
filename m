Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F262DC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 03:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKDDGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 23:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKDDGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 23:06:03 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B96259
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 20:05:59 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id r2so2030277ilg.8
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 20:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQSJvSHP6V0miAsTH5atqChv0rwrVM8jfnaq63MbNQ0=;
        b=OZcnnhdfyhwj2IcxingbcTe1tVY9MulhOkalo9TQXIZ6by+xetpiPIt2oeKaui2y/o
         PAQnjKN4+tTH/THIZZAH0ewviY8e6K9HuFDLoLMcwtIt9ObiAYZRkH78MK3AENlajMP0
         D8GPutJ6HMquvMM4sXmQjLm3zTXxUoF52O7KGQT0qoBjzYSkYg+hqQDUjk/TzfXJNJvX
         qyHjZCeSRp5R9nML4hHZelegiAcwNowfXcGcL/dDOB272q3dyZWvTGIM00BMaMUJANUF
         raFRNZQdnzvqIjObJNeAplfCgbgUTKiQCmrGI1/3Ewe5PLLwTqceZc1LMwZTa35pebFo
         Fp+g==
X-Gm-Message-State: ACrzQf3TwC06D6ae0tve9u6rMvzI3+zGp008fc7B+Ts7beHo1Tq+EFvQ
        2JxcsATJknEBK0wgo/bE6hgzA2+p8A1h8VrZo/nb62BfMVk=
X-Google-Smtp-Source: AMsMyM7jsUBxyWOyasxO0sPzOH2PBehSlOYWofUedpnngmmITUFiXw+dtDGLFaZxrTodwcFoaHpaTPpZzOU4iTRC1MA=
X-Received: by 2002:a92:290b:0:b0:300:c7c3:665d with SMTP id
 l11-20020a92290b000000b00300c7c3665dmr9223258ilg.249.1667531159026; Thu, 03
 Nov 2022 20:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104010242.11555-2-jacobabel@nullpo.dev>
In-Reply-To: <20221104010242.11555-2-jacobabel@nullpo.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Nov 2022 23:05:47 -0400
Message-ID: <CAPig+cQA2b6-WVvSjb5iopFO3hmB1RveEBNCuwAXBVa8sV-6Og@mail.gmail.com>
Subject: Re: [PATCH 1/4] worktree add: Include -B in usage docs
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 3, 2022 at 9:05 PM Jacob Abel <jacobabel@nullpo.dev> wrote:
> While -B behavior is already documented, it was not included in the
> usage docs for either the man page or the help text. This change fixes
> that and brings the usage docs in line with how the flags are documented
> in other commands such as git checkout.

Thanks. Some historical context...

Omission of -B from the synopsis was intentional[1] for the sake of brevity.

There was a previous "complaint"[2] about the omission of -B in the
synopsis. A response[3] to that message suggested that a patch
addressing the shortcoming would probably be welcome, though it
appears that the author of [2] never submitted such a patch.
Summarizing [3]:

    Whether or not the omission was actually a good decision is
    questionable. [...] Of course, that decision does not assist
    newcomers, so adding "-B" to the synopsis would help the page
    better stand on its own.

Which suggests that this patch is probably a good idea.

The patch itself looks fine (though the noise-change in the position
of the "\" line-splice seems unwarranted).

[1]: https://lore.kernel.org/git/1435969052-540-17-git-send-email-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/alpine.LFD.2.21.1711140324580.12112@localhost.localdomain/
[3]: https://lore.kernel.org/git/CAPig+cRc7Yqeys=oPEgPnyR4qT7qKYLbH1ifnp+6F6N+mSzNVA@mail.gmail.com/

> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
> -                  [-b <new-branch>] <path> [<commit-ish>]
> +                  [[-b | -B] <new-branch>] <path> [<commit-ish>]
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -15,9 +15,9 @@
> -#define BUILTIN_WORKTREE_ADD_USAGE \
> +#define BUILTIN_WORKTREE_ADD_USAGE                                                        \

This is just a noise-change which (IMHO) makes it harder to spot the
line-splice. (Presumably this whitespace change was made by an
automated formatting tool or by a "too smart" editor?)

>         N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
> -          "                 [-b <new-branch>] <path> [<commit-ish>]")
> +          "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")
