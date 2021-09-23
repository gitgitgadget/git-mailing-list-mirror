Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B65FC433F5
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E656124C
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 21:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbhIWVC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbhIWVCY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 17:02:24 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88533C061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 14:00:52 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id u11so5157372uaw.3
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdhEslLawSUPlYfYeD1k6u3YNbs1YIeCWJ+DzxdlFh8=;
        b=nyGdOXLAYLOQhy7wENeGtY2aQ0UOmKSs4ZEfeYnYOGlK+UK/VKAfsOHuFVh7POfqaq
         WDybjeiAcbhIFWpf4vQRGXJ89258Ru/gbThj5zrD/LUvwOUY4EQwSYV40f8UgwjOqvLe
         +FZgOb9t8z29HpuzzTNWQ6m07IY/F097evzEFkdaW4fLtH9hCVtYh40hIXRFUkm36kQo
         GMKHKx0i5Blr8J+JB9b9Cl/Gix6lkyqJ+Lmx1dlod/O1xzQlWC/Bsmsc97aYEadmBtB/
         b53+PC/ou5IMHVIvx1XndGqBmXcjoLlmSzM+p+gkgSlGa4960VSbT+bXjYCRtVWOflH/
         yWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdhEslLawSUPlYfYeD1k6u3YNbs1YIeCWJ+DzxdlFh8=;
        b=o+hIkYAH9pH8BVd/RImBJKqEgS1VZEheUx1RdXaageCHibzNlKAF95u1MjGDvrFmuh
         qX/GhTvKorV60OdozurqHSmrNpmU65GH7VGZlHD+hd7gEnjlcu6Fmoj2lRsfnomHxVAu
         D6fgk3zwURTeVpU+KdZOho6trvL4GyuCNYPfydHl+bXC9YvaHsTely7dUtePyF2JwQYp
         IJkKCE1pv3iQLOVrAZpQqcbzLimgSZ8dz1bt1xvNEEhwpMwW3y+sLVruU9cjr4qCo+Hs
         XaoodvvqMJYmcwMXz7/P903oZAFYz1byINY4zgaFtuGOsuNqDh7A/KjvtPr6BbBQYqLc
         3owg==
X-Gm-Message-State: AOAM531VF9KLaT39w9rDNPs0wO3EFFS+PYsZZbyGpNjsooeUp7WswQEB
        lg1lgXnhBLIb8Qipcy2lk9lGbq69gVzhi8BD07S61Y3b
X-Google-Smtp-Source: ABdhPJwRC22rMyynlLlBGR2+MukSgWQl6f4Wawn57aI4Un/qBhqOqpaMpZ4hNX5M9+4aXZDKIUU5l8ihT9gZnF1OyiI=
X-Received: by 2002:ab0:3d13:: with SMTP id f19mr6665499uax.140.1632430851519;
 Thu, 23 Sep 2021 14:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
In-Reply-To: <4381472f-a9db-b8a7-a395-81c3935309ae@kdbg.org>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 23 Sep 2021 14:00:40 -0700
Message-ID: <CAPUEspivB=07OponiMrfXFBrC+L7qjSUuZEV9q-Ug5Z_ShnFNA@mail.gmail.com>
Subject: Re: [PATCH cb/pedantic-build-for-developers] lazyload.h: fix warnings
 about mismatching function pointer types
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 22, 2021 at 12:56 PM Johannes Sixt <j6t@kdbg.org> wrote:
> diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
> index d2056cdadf..dc35cf080b 100644
> --- a/compat/win32/lazyload.h
> +++ b/compat/win32/lazyload.h
> @@ -26,7 +26,8 @@ struct proc_addr {
>  #define DECLARE_PROC_ADDR(dll, rettype, function, ...) \
>         static struct proc_addr proc_addr_##function = \
>         { #dll, #function, NULL, 0 }; \
> -       static rettype (WINAPI *function)(__VA_ARGS__)
> +       typedef rettype (WINAPI *proc_type_##function)(__VA_ARGS__); \
> +       static proc_type_##function function;

dropping the trailing ";" here will also make this macro easier to use IMHO;
feel free to drop all the hunks moving declarations around from my
patch when you do if included in a reroll or let me know if I can help
otherwise.

Carlo
