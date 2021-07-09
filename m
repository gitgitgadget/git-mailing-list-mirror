Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD689C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 06:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6B5613FC
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 06:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhGIGWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 02:22:45 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:40634 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhGIGWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 02:22:45 -0400
Received: by mail-ed1-f49.google.com with SMTP id t3so12108470edc.7
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 23:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sf4AAZJGHkYGGkh8mmRNq8T1R5wO7lgJjiECJk/AL84=;
        b=f1sisYoh0RZTqkEY7r6/HW8NCroHSjVarv31hwGo+UyonZxp6gZABR/s7VlsvXJ2xl
         15/Xkw55TmzEczMfzstdH/YLJ2WBLSnjOIP4XpmJoBc0UyrbMYW+mz/kttSTu1KPSEFK
         N5JHbh1mfzb2eLDeDwLx0RW2WqaLkm0ybUAYHKg4Tit3SXSqn+4sdJPBBZbe0hcBYnR+
         tWgZNMMSZ6v62A4QOq9fvDa9BwbpBZDeHx5RfoGrVqCFlIKKi0x3eW5iw8BvcsIg7JPE
         vp/qp1dWItmIOlKu6pnEWHiAljgsrVouuZHRFEDDZurBM/ZVAce71lcpqSENkJtc2GfP
         sz4A==
X-Gm-Message-State: AOAM533ilzQ5Fk6ZceLf5dTjBE1HOZpayFHHDIpmEft20EejlaKCtIOn
        eHbs5kxqkQvJG+JeLG8wFszPmA5v+hD+dBJaDHs=
X-Google-Smtp-Source: ABdhPJyBYdT8ZotATtGtbf48YqtL36IGMWkdNeo1aEKeHfSzffjIX5/Dg1/P79DcagU2wPmrWeBUc1Y5KhmHGsNYKJY=
X-Received: by 2002:a05:6402:151:: with SMTP id s17mr43316263edu.233.1625811600871;
 Thu, 08 Jul 2021 23:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
 <pull.992.v2.git.1625759443.gitgitgadget@gmail.com> <30196cc93697cd4a6a6881dcbb1073d19e96d8a0.1625759443.git.gitgitgadget@gmail.com>
In-Reply-To: <30196cc93697cd4a6a6881dcbb1073d19e96d8a0.1625759443.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 9 Jul 2021 02:19:50 -0400
Message-ID: <CAPig+cRiEYcz8-F0FzQRetF9UoN1Di099JVgCz0920kQ3a+BwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] worktree: default lock string should be marked
 with `_()` for translation
To:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stephen Manz <smanz@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 8, 2021 at 11:50 AM Stephen Manz via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -305,7 +305,7 @@ static int add_worktree(const char *path, const char *refname,
>         if (!opts->keep_locked)
>                 write_file(sb.buf, "initializing");
>         else
> -               write_file(sb.buf, "added with --lock");
> +               write_file(sb.buf, _("added with --lock"));

Makes perfect sense, though the "initializing" string in the `then`
arm probably deserves the same treatment:

    write_file(sb.buf, _("initializing"));
