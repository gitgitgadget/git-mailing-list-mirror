Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD461F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1Pwi (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:52:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44112 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfH1Pwh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:52:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so1675789pgl.11
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjmitMnb3ErTdFV+bNw08fZnjx/iPU2EStARJ57tQ/c=;
        b=l2uOknhE4V/DsbVLrAe78N1ukPJ7s9zQtEnM5Eiub4n0fhG/CYKuVrUHYrwhqC8ce2
         KPHgEVHCLQpLhJeOJm3Y2frlMuAqEf6S8Dsi7ESbCXoljEnqEPR/AT8QHpfFsbqVJeBT
         atnJqSfGJ5hrZNhjZZSIgEz8x0aMDIcfREzhfXAhNqIMyBRMCmPNIPAmRyqZUw1hoIdH
         nKgVxZfVlpf++qpHBdjRyYD/6VL9V8riydkiaMusywo2NHP4Kn1YFTvEm9PazFXxWMU6
         pEogh2ZBbgSmitJe24HxAWB4sDedY9zyzlQ9nGf1LDymlxgQJKCt9jwY2JRCMxpdvwkp
         mlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjmitMnb3ErTdFV+bNw08fZnjx/iPU2EStARJ57tQ/c=;
        b=lod/Pw6MWmscO5ErQFjVF7B1DzxOcEzuL9hCdqQ5ZR3eOZQNpzqJ2EK6G08GPR+FUV
         WY2HBOnuNyADX63pj/HFrJZAESflVoxpAhL+oPkXvOoJmqKL9uwm7yagJj3Mh0FPgOYd
         my8wB5pDNNNwDuIBr2fRdeolNWueg/WvG5yGSP5awvJHB5KinsVVu13WILbagD9ORZmh
         29cP9Y9hvaGkmDIyCXiOsXXonMXmbzG/07empHLeMseVHqkSHlrc5yXiSdmaxeZRsJsY
         AqEVu3Uk219d//etyQcC5MuXTgdMuWTM4pdCpJbUgBgxTcj/3fdpD/nhmuljNuPt1hVO
         xzcg==
X-Gm-Message-State: APjAAAUGYUZpjt4fgOAL/mli+/xZiRjrlt7cFNMYuwn9LX1TJ9FmvnUp
        vRGpxMIo+Qv+5HPjKeLpa/6w/8LfFxg6aRfd7Ic=
X-Google-Smtp-Source: APXvYqwyYBmdMybU3AoyCeiL1O3GmZS93vu1h9dZYtesSfhBwNgScO+Pxq3dHiFcTt2cl3ypRwsXfN4pIF5SWPSs2Y8=
X-Received: by 2002:a17:90a:2ecb:: with SMTP id h11mr4841963pjs.108.1567007557368;
 Wed, 28 Aug 2019 08:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190827101408.76757-1-t.gummerer@gmail.com> <20190827101408.76757-3-t.gummerer@gmail.com>
In-Reply-To: <20190827101408.76757-3-t.gummerer@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 28 Aug 2019 17:52:25 +0200
Message-ID: <CAN0heSrs42hL7gmqMuugGLNOV8Vd9gxPcUiLA5oTXnhPEM-9qw@mail.gmail.com>
Subject: Re: [PATCH 2/3] merge: use refresh_and_write_cache
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Aug 2019 at 12:15, Thomas Gummerer <t.gummerer@gmail.com> wrote:

>         struct lock_file lock = LOCK_INIT;
>         const char *head_arg = "HEAD";
>
> -       hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
> -       refresh_cache(REFRESH_QUIET);
> -       if (write_locked_index(&the_index, &lock,
> -                              COMMIT_LOCK | SKIP_IF_UNCHANGED))
> -               return error(_("Unable to write index."));
> +       if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK | SKIP_IF_UNCHANGED) < 0)
> +               return -1;

I wondered why you didn't drop the `struct lock_file`, but it turns out
we still need it further down.

>         if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
>                 int clean, x;

What you could do, I guess, is to move its declaration to around here.
Probably not worth a re-roll.

> @@ -860,13 +857,9 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
>  {
>         struct object_id result_tree, result_commit;
>         struct commit_list *parents, **pptr = &parents;
> -       struct lock_file lock = LOCK_INIT;
>
> -       hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
> -       refresh_cache(REFRESH_QUIET);
> -       if (write_locked_index(&the_index, &lock,
> -                              COMMIT_LOCK | SKIP_IF_UNCHANGED))
> -               return error(_("Unable to write index."));
> +       if (refresh_and_write_cache(REFRESH_QUIET, COMMIT_LOCK | SKIP_IF_UNCHANGED) < 0)
> +               return -1;

Here you do drop the `struct lock_file` entirely, ok.



Martin
