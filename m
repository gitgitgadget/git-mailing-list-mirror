Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09DE020259
	for <e@80x24.org>; Wed,  7 Dec 2016 13:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbcLGNMf (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 08:12:35 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:32916 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbcLGNMe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 08:12:34 -0500
Received: by mail-io0-f196.google.com with SMTP id j92so13603757ioi.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 05:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hpIrn5w8/u4Ubd0y8N5iLYCMJWky6HTy9qogx9Bq6Gs=;
        b=fmwwiQMThEHsJXerC/v2LDParwEVWVVpJL4cCKw9+Ksap67VQDu0nzV7MlH5DWgQJ6
         XyOKcNilX5NHMb57xyUFFUAjSkVO7Ta289+Fr7zVBK2dvOgYnDos1GdXFHOmpPVy91PJ
         R65Op3/Zmz5QkTZJDs7fOxwbYDGheKLRlSNiHkXH/tNWWThgWmleL+pLXDnJaLJsSWE3
         57ajP+aqmEjRv2jZXKOhTluVvXuHZfNkO3zYW7vLgCQiIXdldZNRLEnZFyRqgmjdcgXH
         zQcnfn3JeoBHl2lCaZpg2aMR3mhZI4EjPHqtn2f+2cb+MfvHsaA1wOr2JhLcJRO2pZwe
         /+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hpIrn5w8/u4Ubd0y8N5iLYCMJWky6HTy9qogx9Bq6Gs=;
        b=M+TOB0ArwqvFEQMc/BOiL09zazouR1ft99zc0HTG4aD8+gBGluvqcKeVNAymyMMpXr
         XcCtB8iNrySV5B8//eNN6X00BvjKcIRTSEzlOb4VAOGVg7lzQmgBmOvRMiphBiKRaLNN
         dFVT53yWJSBRXnWHbkRIwkOnZerGSwtCCJy1EcTNoQ9s3FYwUqyL2BL6sZhAxGFqCMp4
         E4DnWN8yuTzhgKfb6CdfGqqcDDNDBAB3WxvYcW1hKcYMvPjFG/jQGjJfK9sAmiwb5qwq
         PlUUJwhK7vcYQn7QXujmHqRr1zWwM7N7FZTSDpW6p79Km2mbzBujoD+9SlirXBc+I2JW
         sFvw==
X-Gm-Message-State: AKaTC0307nsMN3FjJFnUf2GEJ3w5jhTvOA/azqBdi3OszboBj5akC4znOoI2R7GJq0Xu7WAAjov1tieseV/Gsw==
X-Received: by 10.36.66.76 with SMTP id i73mr1908265itb.50.1481115236816; Wed,
 07 Dec 2016 04:53:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 04:53:26 -0800 (PST)
In-Reply-To: <1481061106-117775-12-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-12-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 19:53:26 +0700
Message-ID: <CACsJy8D9SAOYtzPTuGnst3J7qCUjMuGMrZ=KNH0MLSxMrq4krw@mail.gmail.com>
Subject: Re: [PATCH 11/17] pathspec: factor global magic into its own function
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> Create helper functions to read the global magic environment variables
> in additon to factoring out the global magic gathering logic into its
> own function.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pathspec.c | 120 +++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 74 insertions(+), 46 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 5afebd3..08e76f6 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -87,6 +87,74 @@ static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
>         strbuf_addf(sb, ",prefix:%d)", prefixlen);
>  }
>
> +static inline int get_literal_global(void)
> +{
> +       static int literal_global = -1;
> +
> +       if (literal_global < 0)
> +               literal_global = git_env_bool(GIT_LITERAL_PATHSPECS_ENVIRONMENT,
> +                                             0);

These zeros look so lonely. I know it would exceed 80 columns if we
put it on the previous line. But I think it's ok for occasional
exceptions. Or you could rename noglob_global to noglob.
-- 
Duy
