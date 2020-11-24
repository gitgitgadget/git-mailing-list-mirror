Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE25C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E632063A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 19:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKITu4JM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbgKXTDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 14:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390880AbgKXTDq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 14:03:46 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34207C0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:03:46 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id q4so7165017ual.8
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiryxSoBrGtrL4xxPqXmCSkw7JdlZB/+PFb9l2VvNRQ=;
        b=nKITu4JMJ8QZiHElqOidiIgdnRlSLaHj3D9LsdwVWSn+cVcVo/zpZzFtpQFzY9FzbY
         nCiBdy+5kdR6HWphIoLdJAX2dF5HcatPlAGF7cCATcp4txza5VPrED6ccPTeNpeqZSHd
         Iagm0HsiVq4I/93L9KX8JoA0j5K+tEisCEoML+Xi7VcWHh7QGvoS5TlE6BmJIy+6sxWC
         xyxVyRcaURa7p1yWMr5b1uc8LljPvTVlbTcpn5gybyU5V/hvlLIILhKqlzAZ/MHUTDrD
         uBwhFBQ5ZjvDh+En42ngiksCXpscoyPBEsciWeQicMQ/IP7x7/YaCFRPYL2MzTb6OeQz
         /dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiryxSoBrGtrL4xxPqXmCSkw7JdlZB/+PFb9l2VvNRQ=;
        b=KJiOmZEPzNsQMqaTK4vwApt+xIHq4zFAy7jFjwW82X+tyjpOKUO5+Nj03VMUPbvP/P
         Mi/SP/a7nRmxmeddPyKmcv4jiA9YZtrzsbklCunaG7wSMnzcYbKFGzxQ9snlQ+O9uJaD
         dvYgzdR+xzBgjsuhbDag6cFGVstyygyrBwqTQOxfqFDjM8X1FzYk/sRgCy0PcJalp/qF
         C0tmrF3BxldFIZbM+e/zmUD7KLM0Aa5mJxPB6Af0Wg920CXpBk4/BnlSdKBxJWy0C9jU
         jr+o5ylMrYdrXHfz1aPmmCTSCkX/KKVzaXDZ0f9+xtld3tSVzBIsUWepayCHinY35oBm
         YvYQ==
X-Gm-Message-State: AOAM531ehZ7vsJSf8Yhm7XqButj9klGhRYi3uT54v53fyozroNYNsiUj
        wrA7vPyZ/PbauOwY+SutpWBWKTXgFPj8BU3SGjkscyjdJiY=
X-Google-Smtp-Source: ABdhPJwEDcSqNW7Z31ifYHCpEev2TLeB1zSAaXseAHSOMqwtdxx0sjN8HJADX/t/GupEOgk3O20tS8lY4PxoesfS9xI=
X-Received: by 2002:ab0:2606:: with SMTP id c6mr5070546uao.62.1606244625425;
 Tue, 24 Nov 2020 11:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com> <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Nov 2020 20:03:33 +0100
Message-ID: <CAN0heSpjYEZbjXcX-XSvwwBKOEQ=Dtk=Nnr3T+BOqB+fd7x4sQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Nov 2020 at 17:47, Rafael Silva <rafaeloliveira.cs@gmail.com> wrote:
> @@ -1265,9 +1265,14 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
>  {
>         int i, found_selected = 0;
>         int result = 0;
> +       char *lock_path;
>         struct lock_file lk;
>         struct repository *r = the_repository;
> -       char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
> +
> +       if (!r || !r->gitdir)
> +               return error(_("not a git repository"));
> +
> +       lock_path = xstrfmt("%s/maintenance", the_repository->objects->odb->path);

s/the_repository/r/

(The preimage uses "r" and you check using "r".)

> @@ -1513,8 +1518,13 @@ static int update_background_schedule(int run_maintenance)
>         FILE *cron_list, *cron_in;
>         const char *crontab_name;
>         struct strbuf line = STRBUF_INIT;
> +       char *lock_path;
>         struct lock_file lk;
> -       char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
> +
> +       if (!the_repository || !the_repository->gitdir)
> +               return error(_("not a git repository"));
> +
> +       lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);

Here it's "the_repository" both before and after. Ok.

Martin
