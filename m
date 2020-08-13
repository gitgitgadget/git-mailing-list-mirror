Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5800AC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 02:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A5A20771
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 02:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8+RaiQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMCLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 22:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMCLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 22:11:00 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E7C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 19:11:00 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z22so3734235oid.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 19:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ElgWvKM3fOD/v7JN85mzhOtwOhzcdf6Wj02lBX/dLbU=;
        b=o8+RaiQUFkrtyMPS5/nRcEqZ5eLbzGiMENvB1CK+my23CO75mzBIUsMR+d87uh3wJ5
         8ovBgtUkCkfQJfL02Vqe49LisJBLTCPZnXt1JkhG2tEKeI0X13Jsdq39Boc1a0OuXvBr
         ug887WYw5a2WnKBD8LtPV1TSuCiIy44mNhoY9k5BmvWcj9wAHSmyEKhvDPLIQzUP8CQO
         NluTqf2Dtzk+l4tC91lyZK2bUGNUfe1N2f3AFBVOUAu0EEtpXls9uTIt+944pwb3AkKa
         1O31isW2MJkAb/cun7AZjI+t49zgrewtKbaBQQMHrZLDUf2yZVXxUENRfRJJku3DVfx+
         UUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ElgWvKM3fOD/v7JN85mzhOtwOhzcdf6Wj02lBX/dLbU=;
        b=eM0mXRXErT0PpJcC7nyOaAHch9lFE3UiuB8WXtg8v5h6XB0Okn3gg56nKdMP+fSGiq
         4YWVcjsWP4VYhlsVrpL+qwyb57Ej6HKc3879XyfSw5yVzzWBI2Vu4HWeQ2MoEMqKUG4t
         uc0+KcI8dhGDSsfRqTbrVotruhTUzGczEBIQwxKkAWOZp1vzMtQpgH3YLCXQdUS9TJ/7
         W2p6aqK74u1zMYP96RUAZjFr5VGQ7VFlYN7Ys+SFIMWddHyzhJ9SeZraaL6x+eDGAHMh
         AsijXeTqeFB85xd0opg0d6DAOOYclhJvEAMK6AifjlyFoDLaELAN+w+RFGwbde3mNggl
         lQJg==
X-Gm-Message-State: AOAM532z8NBlAzaQ1NsYaqXbstF14Fi8jAhtKgPJYjS2B4QTdjANbnjq
        xLehggmLugJM3ImIO3BZ34EJzFls2vNh+LY2oQUWMG7/
X-Google-Smtp-Source: ABdhPJzgvfYFZLqgPzQKJ/A2DZHZIqAEiYs1k5iDJ5M3xSyDXfRXw7pHOf4fzR+5BatafjkwH0D78hAUmtC7PgBSmcE=
X-Received: by 2002:aca:d4d3:: with SMTP id l202mr1733068oig.167.1597284656963;
 Wed, 12 Aug 2020 19:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.700.git.1597271429.gitgitgadget@gmail.com> <69fe977b66f9744c914cfdfa2da4b9be5e720e4f.1597271429.git.gitgitgadget@gmail.com>
In-Reply-To: <69fe977b66f9744c914cfdfa2da4b9be5e720e4f.1597271429.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 Aug 2020 19:10:45 -0700
Message-ID: <CABPp-BENKdxqXjH07yCNojRWQ3XO+_mm8x+LSVLTBx36m6nSSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] userdiff: improve Fortran xfuncname regex
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 3:34 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The third part of the Fortran xfuncname regex wants to match the
> beginning of a subroutine or function, so it allows for all characters
> except `'`, `"` or whitespace before the keyword 'function' or
> 'subroutine'. This is meant to match the 'recursive', 'elemental' or
> 'pure' keywords, as well as function return types, and to prevent
> matches inside strings.
>
> However, the negated set does not contain the `!` comment character,
> so a line with an end-of-line comment containing the keyword 'function' or
> 'subroutine' followed by another word is mistakenly chosen as a hunk header.
>
> Improve the regex by adding `!` to the negated set.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  t/t4018/fortran-comment-keyword | 1 -
>  userdiff.c                      | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/t/t4018/fortran-comment-keyword b/t/t4018/fortran-comment-keyword
> index c5dbdb4c61..e9206a5379 100644
> --- a/t/t4018/fortran-comment-keyword
> +++ b/t/t4018/fortran-comment-keyword
> @@ -8,7 +8,6 @@
>        real funcB  ! grid function b
>
>        real ChangeMe
> -      integer broken
>
>        end subroutine RIGHT
>

This change seems orthogonal to the explanation in the commit message.
What is its purpose, and does it belong in this commit or a different
one?

> diff --git a/userdiff.c b/userdiff.c
> index 707d82435a..fde02f225b 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -53,7 +53,7 @@ IPATTERN("fortran",
>          /* Program, module, block data */
>          "^[ \t]*((END[ \t]+)?(PROGRAM|MODULE|BLOCK[ \t]+DATA"
>                 /* Subroutines and functions */
> -               "|([^'\" \t]+[ \t]+)*(SUBROUTINE|FUNCTION))[ \t]+[A-Z].*)$",
> +               "|([^!'\" \t]+[ \t]+)*(SUBROUTINE|FUNCTION))[ \t]+[A-Z].*)$",
>          /* -- */
>          "[a-zA-Z][a-zA-Z0-9_]*"
>          "|\\.([Ee][Qq]|[Nn][Ee]|[Gg][TtEe]|[Ll][TtEe]|[Tt][Rr][Uu][Ee]|[Ff][Aa][Ll][Ss][Ee]|[Aa][Nn][Dd]|[Oo][Rr]|[Nn]?[Ee][Qq][Vv]|[Nn][Oo][Tt])\\."
> --
> gitgitgadget
