Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA27C2D0CE
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 00:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178FD21734
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 00:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9Frrucq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAVAM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:12:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42527 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAVAM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 19:12:57 -0500
Received: by mail-ua1-f67.google.com with SMTP id u17so1754470uap.9
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 16:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zf0jDTwzbG4LOqz+IsQBC+qBhjaM93UUX8xqsa014ig=;
        b=B9FrrucqICB7G8UQvjc19faAsuD1GvAeKty5gNhN1x51V9EDQBkoypS9fxVJbVDIb4
         5JvzzeyYFYvpq3r2iB3VWhnH/gZ9a7pgUNTK7lyJ42THNvqX4zIwUfVRor9+f+eVGka/
         16i/oCfr7qZ+ILjIa0NsSEIVLhpYkSFYYarF9+eokHLSOLtLYPJHr/N8u7jH2vB6PNdI
         39rcUJGr5sSkzCtcZwzq1s6FBEh1T0Un7PQJktnfd6g79Eo8xxEPVvQI7DWdRO1w1ymM
         y6wB4VD3rD5mjmrr3czHEsZlCqlNkTqZHwN81JlARPNMa5BiiP81xJg2mJC6G8UbHOyI
         Q/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zf0jDTwzbG4LOqz+IsQBC+qBhjaM93UUX8xqsa014ig=;
        b=LdqEQhwUtpQobxTaLMM6X+DCXabBU+VrqbasWe7Svb80L5NTEBIt4xCqxKVKYs1wc4
         IAdfu/gjXUMzgkzaqT4hwy3c6viN0oI5JZtMMUcWfRV3kj8fNoNP0qjz/tu3PFeHTH5w
         gdZiUzfP1k4gFYr5M7XT9WkVah+VmKiSgvUPOmiB9HY9B4f75CEwdn6o4wnti3AeBUmz
         SumO8s+OVFA9zBO/qQxX0fLB8uwcdGDAaJL/wnxsSxlwI/3lxmGQ0wHHo/E9BxP9oXtL
         ANJ3FDLnapY7uZmeDVrPX8Z096J3VAtF08xsJK1gNLVd1wScuA8Ina44XiBxlIqnF0zD
         UoiQ==
X-Gm-Message-State: APjAAAUHwAkzT+ElCajnH61gywHKkzOMKgJClmZ7wtVet1x5vbL8LKjj
        D4gOENRN5vaSictw3tcIxtO622KYhBI1vnw+2MQ=
X-Google-Smtp-Source: APXvYqy7PwP2YDAwu735uaJVbFixn/cwLG/kZIul931AXWLNMt/aAsQFuix12Bbg2eqZH+9hiiPwu4KhGv81bQpBxlc=
X-Received: by 2002:ab0:4931:: with SMTP id z46mr4784965uac.119.1579651976114;
 Tue, 21 Jan 2020 16:12:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579598053.git.bert.wesarg@googlemail.com> <04eb98389880c96e1dc18131031e9d6ad5830a40.1579598053.git.bert.wesarg@googlemail.com>
In-Reply-To: <04eb98389880c96e1dc18131031e9d6ad5830a40.1579598053.git.bert.wesarg@googlemail.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Tue, 21 Jan 2020 19:12:43 -0500
Message-ID: <CAOjrSZsuPUc7kDPh6wTDMq10b2QM0R2Uq7-0TQ=W76yjk-eoJA@mail.gmail.com>
Subject: Re: [PATCH 5/7] [RFC] config: make `scope_name` global as `config_scope_name`
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Logos good to me...

As I'm a bit new, what would be the best way for me to work this into
my workflow?

On Tue, Jan 21, 2020 at 4:25 AM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> Will be replaced by Matthew Rogers.
>
> Cc: Matthew Rogers <mattr94@gmail.com>
> ---
>  config.c               | 16 ++++++++++++++++
>  config.h               |  1 +
>  t/helper/test-config.c | 17 +----------------
>  3 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/config.c b/config.c
> index d75f88ca0c..4c461bb7a3 100644
> --- a/config.c
> +++ b/config.c
> @@ -3317,6 +3317,22 @@ enum config_scope current_config_scope(void)
>                 return current_parsing_scope;
>  }
>
> +const char *config_scope_name(enum config_scope scope)
> +{
> +       switch (scope) {
> +       case CONFIG_SCOPE_SYSTEM:
> +               return "system";
> +       case CONFIG_SCOPE_GLOBAL:
> +               return "global";
> +       case CONFIG_SCOPE_REPO:
> +               return "repo";
> +       case CONFIG_SCOPE_CMDLINE:
> +               return "cmdline";
> +       default:
> +               return "unknown";
> +       }
> +}
> +
>  int lookup_config(const char **mapping, int nr_mapping, const char *var)
>  {
>         int i;
> diff --git a/config.h b/config.h
> index 91fd4c5e96..c063f33ff6 100644
> --- a/config.h
> +++ b/config.h
> @@ -301,6 +301,7 @@ enum config_scope {
>         CONFIG_SCOPE_REPO,
>         CONFIG_SCOPE_CMDLINE,
>  };
> +const char *config_scope_name(enum config_scope scope);
>
>  enum config_scope current_config_scope(void);
>  const char *current_config_origin_type(void);
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 214003d5b2..1e3bc7c8f4 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -37,21 +37,6 @@
>   *
>   */
>
> -static const char *scope_name(enum config_scope scope)
> -{
> -       switch (scope) {
> -       case CONFIG_SCOPE_SYSTEM:
> -               return "system";
> -       case CONFIG_SCOPE_GLOBAL:
> -               return "global";
> -       case CONFIG_SCOPE_REPO:
> -               return "repo";
> -       case CONFIG_SCOPE_CMDLINE:
> -               return "cmdline";
> -       default:
> -               return "unknown";
> -       }
> -}
>  static int iterate_cb(const char *var, const char *value, void *data)
>  {
>         static int nr;
> @@ -63,7 +48,7 @@ static int iterate_cb(const char *var, const char *value, void *data)
>         printf("value=%s\n", value ? value : "(null)");
>         printf("origin=%s\n", current_config_origin_type());
>         printf("name=%s\n", current_config_name());
> -       printf("scope=%s\n", scope_name(current_config_scope()));
> +       printf("scope=%s\n", config_scope_name(current_config_scope()));
>
>         return 0;
>  }
> --
> 2.24.1.497.g9abd7b20b4.dirty
>


-- 
Matthew Rogers
