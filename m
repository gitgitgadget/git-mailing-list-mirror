Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EA9E20248
	for <e@80x24.org>; Mon, 18 Mar 2019 09:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfCRJlk (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 05:41:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42927 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387510AbfCRJlk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 05:41:40 -0400
Received: by mail-io1-f67.google.com with SMTP id c4so13837925ioh.9
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8FK759+HvVX4XJsLG+wxjK80dgzJHC6o6kfTp/l/YU=;
        b=LA+s6HVAG6dnCsadvb634vmaJ66+M1ci7ci8iLd5qDAb5S2A6X1wO9pg1BSrdekn2y
         xLccyoLpRSLvij5zD307lsRFQ2alF8gJ3sSaJbvfsiqy/5sx6gfvFyq6hMSPbVy5sdCP
         TPJSeCcsX+B9JPTi5wWFq1yV1mUQdB6voC76yXkhM8CPkob3aZsN0/DWkoeQn05y6hTz
         VlzYeWV1MW0DknmCJFjZL7gcGimI1ki+S1mJN8jGZZFZMqWnShSeWGL9BqQnehZEuevM
         82BV326h31PiU1r2MNauTVl7mZD80IgkbTiJxOGCLCCfkJtuR1oPzuYG7j6W9YD4/MZq
         NkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8FK759+HvVX4XJsLG+wxjK80dgzJHC6o6kfTp/l/YU=;
        b=FN0xNuWlaHwY47NYG4LgLfgy9iKHo7eY1+jRhi8mQ3BnpjDb2vlIASPgHKDkdipQ7z
         QwGsMcXYLntDlaGp8RhSwh8Bh2vq0VuPIyeCN7hyRyJHsbdZO4q0r5TfIdiJYG1KADAQ
         flK/e8cwcd/wNBgSf6llRDAUlGAzSouqx65QxmGVQHPohWox3zSe/wUI0ujGsVt9C+PQ
         FW7Uix3JzZJ2QTkSCW61EfJ8eImb77dVO15oIYDgnIaYDnxrgRG30PBqUNcImVswY2MG
         ctFQGaBjkelKx8JuFusyyE5uhmexLplZvUBGLHVuNRv9toz47IY24RYTdj6XT10u2hUJ
         u/DA==
X-Gm-Message-State: APjAAAUBrTM3WpRu7ZUg7M6H+wg9PGxNgYDzE1TeIzyF1cMKDxF59NGR
        tq1Xb4TNUHH9WoOrzhid/TZC75aJWYI8sWUEUNw=
X-Google-Smtp-Source: APXvYqwNBtkSSQ5UxkHcE4STtVhVmyvhRLWMh2IUrJO9bv99FqamlvDUEXT3b+g0j8yKWf9RUx12pUEdxwtuOCr5KrM=
X-Received: by 2002:a5d:9446:: with SMTP id x6mr9040447ior.236.1552902099474;
 Mon, 18 Mar 2019 02:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
 <20190317181620.26727-2-tmz@pobox.com>
In-Reply-To: <20190317181620.26727-2-tmz@pobox.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Mar 2019 16:41:13 +0700
Message-ID: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] git: read local config in --list-cmds
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 1:16 AM Todd Zullinger <tmz@pobox.com> wrote:
>
> From: Jeff King <peff@peff.net>
>
> Normally code that is checking config before we've decided to do
> setup_git_directory() would use read_early_config(), which uses
> discover_git_directory() to tentatively see if we're in a repo,
> and if so to add it to the config sequence.
>
> But list_cmds() uses the caching configset mechanism which
> rightly does not use read_early_config(), because it has no
> idea if it's being called early.
>
> Call setup_git_directory_gently() so we can pick up repo-level
> config (like completion.commands).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/git.c b/git.c
> index 2dd588674f..10e49d79f6 100644
> --- a/git.c
> +++ b/git.c
> @@ -62,6 +62,13 @@ static int list_cmds(const char *spec)
>  {
>         struct string_list list = STRING_LIST_INIT_DUP;
>         int i;
> +       int nongit;
> +
> +       /*
> +       * Set up the repository so we can pick up any repo-level config (like
> +       * completion.commands).
> +       */
> +       setup_git_directory_gently(&nongit);

This gave me a pause because we could try to find .git more than
necessary (e.g. when --list-cmds is requested without "config"). But I
don't think that happens often enough to be worried about.

It also subtly changes list_aliases() code flow, because the
read_early_config() call inside will use the already-discovered gitdir
 here instead of trying to rediscover. So, everything is still fine.

You probably want to drop the comment block about repository setup
inside list_cmds_by_config() too.

>
>         while (*spec) {
>                 const char *sep = strchrnul(spec, ',');
-- 
Duy
