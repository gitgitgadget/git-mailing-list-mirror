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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AABC2BBD4
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4666230F9
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 06:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732730AbgLRGUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgLRGUc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 01:20:32 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71313C0617A7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:19:52 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s75so1780691oih.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 22:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLUE57xO6JX7c+3d2aKXwY4JjavLuwVqIQXGvetE9W4=;
        b=UTMeDr6eo0hms9pG9DZ0aBKl1tb6idilelULl5eBDxHvNv7JMIpz2kE8blIxOKqsmr
         qr+dLhTgNQO1L0D7oGwghj+vdKolKtfH75DkmOz002c4W4glnCc98Y+HDkmTO5yebRE2
         BSSMIYdpopYbzHR+IU4IVca1nabYnzKLttZB7FfRm5h5o+afHrF1PYzrBCZAlkq4S6EM
         KrFtJzIkWGlBHuZ4in3M9mT7NAwG11LLpz29cmPczA8+C+DAxfiwM85hvKGjlqwKidb0
         qMVe7JdDnt8EPFvcgSk2l/h9Xt3EW846tTo5ZlS5jot4jbtuNKUSECQ7znQLV0jvUiSX
         nK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLUE57xO6JX7c+3d2aKXwY4JjavLuwVqIQXGvetE9W4=;
        b=j1fQ4Pv4gT2fWgWGOJ2iKcaxahuxJ0btE2oIVTXThGkBLy0G5bGsIyBoE+Ffd4IOtE
         dSlSfuOVt5qkmJYLOqkCg4f5tP6g/KEOhukAVvx/B/kZtIaY/6qc3iUSqHQYtCI8POzR
         2j0TD6Po3M9fSACPBfXR+rQFhDdbGobI7H4j7hQD9xATMwIXhmLtkDqaaVSDqCFcLwy0
         X7364hvHvlhFK5edomdklRyodu1ivoyO2t4sMB340HJnN95UgvZVqE2Mt5n5dF3KzL94
         XwL8nzKHFvZeC4GWxZ4GJKTVzqexbO/ddCLbburnyuX+sD5Uu5oG/3dIObj6MKSWiUre
         scsA==
X-Gm-Message-State: AOAM5332fFUxV1/w34og/xQNsj0KPRnE84YXBpvDv98tvgM0HYmTjUNJ
        rPLtpUJzZfqtVdD4OC0l5V0+pEBbYKfjCAgpkU4=
X-Google-Smtp-Source: ABdhPJxb7gB9CI1brTh9M35bUAkCyniXOt3f+D/If1gyatXKnfcgjUXQ6s9kLihvR+7e6GJBms2NGJkg47TWfJkXBHE=
X-Received: by 2002:aca:3151:: with SMTP id x78mr1796080oix.39.1608272391905;
 Thu, 17 Dec 2020 22:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-29-sorganov@gmail.com>
In-Reply-To: <20201216184929.3924-29-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Dec 2020 22:19:40 -0800
Message-ID: <CABPp-BExc7rBCVEvLLs1u_hXurDTtWxTKg0ZN0+PA-21u_ShkA@mail.gmail.com>
Subject: Re: [PATCH v2 28/33] diff-merges: add '--diff-merges=1' as synonym
 for 'first-parent'
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> As we now have --diff-merges={m|c|cc}, add --diff-merges=1 as synonym
> for --diff-merges=first-parent, to have shorter mnemonics for it as
> well.

In all the other cases, --diff-merges=<short> is equivalent to
-<short>.  Here, --diff-merges=1 and -1 do _very_ different things.
Is there any concern that might cause confusion?  (My gut reaction is
this is probably fine and people won't try to make such a connection,
but it made me worry just enough that I thought I'd flag it for you
and other reviewers to at least mull over and maybe comment on.)

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/diff-merges.c b/diff-merges.c
> index 9492cd2b871d..63a0d78b7730 100644
> --- a/diff-merges.c
> +++ b/diff-merges.c
> @@ -57,7 +57,8 @@ static void set_diff_merges(struct rev_info *revs, const char *optarg)
>                 return;
>         }
>         if (0) ;
> -       else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent"))
> +       else if (!strcmp(optarg, "first") || !strcmp(optarg, "first-parent") ||
> +                !strcmp(optarg, "1"))
>                 set_first_parent(revs);
>         else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate") ||
>                  !strcmp(optarg, "m"))
> --
> 2.25.1
>
