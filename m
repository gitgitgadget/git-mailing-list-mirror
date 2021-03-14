Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9BFC433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 20:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4594764E6B
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 20:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhCNU0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhCNU0J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 16:26:09 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F98C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 13:26:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so13632912pjb.2
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7nJd3xvDBvafPWUC1nMVfN7MZOWBCQZwtwMyeZI6v4=;
        b=TlTtTuMPmM0so+qUjDIgDOVOrEORLMLRpwjI79aZ2l+yNK3AimzZHXLlplss7B5OXw
         CaPt5ydkg7yPx4YhML6r/IxoyG9xBZLqWUHMd5KSZWQI+KDu4QwMuUeVA0pX8Vv0abTi
         cHhkucDDPQ1sndzc8p0GAiU0ymTpV6L8kUSsd8KqPubahN99FNqvARoH9chpn41sEljl
         xpxfHLaWogQXqwYz0SSdLvnWbHt9EFL5053PA+RiAtcN701t2SbnYuzU331QrTzLba2b
         S3VBcnY5b3en5+xPB03On+ou8Ec+lRdJ5idYR0+p0wRqTYE9k9+Z7h0XvYUUw1qiK5rH
         Z21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7nJd3xvDBvafPWUC1nMVfN7MZOWBCQZwtwMyeZI6v4=;
        b=O/EPsDVZzHh/tEVjBL/tsRm+O8AfVKU+wmPuXiQweTclge5i4r+W4JgROADn+vI0RQ
         naQtFjyueVJWEBIgrnNzmfjRqtJ0wAYclJMnPORaqaaEO67GuQy/8gOZBEUVHz3AGBGK
         dip693Zv1bg/ziqOd0b04fayi8xioQyjsoSdEYQkRnOSb02TTSKtW7jWFpcOVogyZZkM
         zTqqFk4YuEzwq04tzsaDFh+KaU97WmWzJ4iCAp9Qz/xJLnicoGrrSIT6YVXphK37vxy4
         qoRNAjCLDJ65usQraPHnlOJzNKzaSNMdH3BIdR990SeSISQEkLXCPmYFas/BLiFajXTy
         AIFQ==
X-Gm-Message-State: AOAM533xqgcscm+fMfDERbW+t+wlt7S85Yul07jXfhqSglpjbVhpGhe3
        CUTpS1uzNSuzT1GLo95vmUKhVLVuoRjjrbH2RH0=
X-Google-Smtp-Source: ABdhPJx2SKq1/3gKn3S1AQRyNbKMCi4nQVXXpgNRtbT0wUCupyrV2P4hBGouovJGcOGp+6QVSDLmgRNZfzlON+nSzC4=
X-Received: by 2002:a17:90a:5413:: with SMTP id z19mr9059731pjh.137.1615753568207;
 Sun, 14 Mar 2021 13:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <pull.899.v2.git.1615747662.gitgitgadget@gmail.com> <2b03785bd4cb76285989aff259af57890ea9fe08.1615747662.git.gitgitgadget@gmail.com>
In-Reply-To: <2b03785bd4cb76285989aff259af57890ea9fe08.1615747662.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 14 Mar 2021 21:25:57 +0100
Message-ID: <CAN0heSo_ArBrjSncvx==kw8K1DzH=0y2h-Q=B_364Ea0EURXxg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] parse-options: convert bitfield values to use
 binary shift
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 14 Mar 2021 at 20:05, Andrzej Hunt via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Andrzej Hunt <ajrhunt@google.com>
>
> Because it's easier to read, but also likely to be easier to maintain.
> I am making this change because I need to add a new flag in a later
> commit.

Makes sense.

> Also add a trailing comma to the last enum entry to simplify addition of
> new flags.

Makes sense.

> This changee was originally suggested by Peff in:

s/changee/change/

> https://public-inbox.org/git/YEZ%2FBWWbpfVwl6nO@coredump.intra.peff.net/

>  enum parse_opt_flags {
> -       PARSE_OPT_KEEP_DASHDASH = 1,
> -       PARSE_OPT_STOP_AT_NON_OPTION = 2,
> -       PARSE_OPT_KEEP_ARGV0 = 4,
> -       PARSE_OPT_KEEP_UNKNOWN = 8,
> -       PARSE_OPT_NO_INTERNAL_HELP = 16,
> -       PARSE_OPT_ONE_SHOT = 32
> +       PARSE_OPT_KEEP_DASHDASH = 1 << 0,
> +       PARSE_OPT_STOP_AT_NON_OPTION = 1 << 1,
> +       PARSE_OPT_KEEP_ARGV0 = 1 << 2,
> +       PARSE_OPT_KEEP_UNKNOWN = 1 << 3,
> +       PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
> +       PARSE_OPT_ONE_SHOT = 1 << 5,
>  };

Straightforward.

>  enum parse_opt_option_flags {
> -       PARSE_OPT_OPTARG  = 1,
> -       PARSE_OPT_NOARG   = 2,
> -       PARSE_OPT_NONEG   = 4,
> -       PARSE_OPT_HIDDEN  = 8,
> -       PARSE_OPT_LASTARG_DEFAULT = 16,
> -       PARSE_OPT_NODASH = 32,
> -       PARSE_OPT_LITERAL_ARGHELP = 64,

`PARSE_OPT_NEGHELP` is gone since acbb08c2e0b ("parse-options: remove
PARSE_OPT_NEGHELP", 2012-02-28), which explains the jump here.

> -       PARSE_OPT_SHELL_EVAL = 256,
> -       PARSE_OPT_NOCOMPLETE = 512,
> -       PARSE_OPT_COMP_ARG = 1024,
> -       PARSE_OPT_CMDMODE = 2048
> +       PARSE_OPT_OPTARG  = 1 << 0,
> +       PARSE_OPT_NOARG   = 1 << 1,
> +       PARSE_OPT_NONEG   = 1 << 2,
> +       PARSE_OPT_HIDDEN  = 1 << 3,
> +       PARSE_OPT_LASTARG_DEFAULT = 1 << 4,
> +       PARSE_OPT_NODASH = 1 << 5,
> +       PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
> +       PARSE_OPT_SHELL_EVAL = 1 << 7,
> +       PARSE_OPT_NOCOMPLETE = 1 << 8,
> +       PARSE_OPT_COMP_ARG = 1 << 9,
> +       PARSE_OPT_CMDMODE = 1 << 10,
>  };

Those last few conversions close the gap and we end with 1024 rather
than 2048. That "should" be ok, unless some piece of code relies on
exact values here, or even their relations(!). Hopefully not? Might be
worth calling out in the commit message that you're changing some
values, if you're rerolling anyway. (Or you could leave 1<<8 unused to
make this a true no-op, then use that value in the next patch. Anyway, I
think this is safely in bikeshedding land.)

Martin
