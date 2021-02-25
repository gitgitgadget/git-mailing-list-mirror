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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10448C433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D7A64ED9
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhBYHDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBYHDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:03:39 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE341C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:02:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id f3so5121130oiw.13
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Io8o/DRPA2OWtAtU2zbejl5QuG2UeI6CZv0eET0P2yQ=;
        b=GmLS63YKYO5kZrlz8NBTkGJ65hxxmcy3vhbLdomGpaZ9ycVMkC8Vwa7fpAi1cUBWfN
         KanecsJWdPOJxYK47NIELkD99yWAkzAPgw/ReSzIbWsQiel2BHhosAjAkaIeMHyyvrIj
         MHj2t4FTD+rJKmFgb9ed8T/u7FweoHQOYNCrgHykDHThv/0I5uHhMd+8Y5kKnrwzEgKD
         GkHOg8rqYB6CkCGje5wUF7oF00Ej8UHr7UmpWqVxcn7L6YV8oFwoz38X5/mnoCmi1qHd
         NZHz2k3H4TUCM7D4dNGNUH/9j0yNxAV4fkSKUZk5rF5fGZTI+iYGnzpA5kGy1hohnwHn
         QVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Io8o/DRPA2OWtAtU2zbejl5QuG2UeI6CZv0eET0P2yQ=;
        b=qvANvQbgR6ib6/5Ud0qx3PokU4AoWn9R8zDeeOzmAeAbPvYDpi76eusGbpfIvtaTBS
         FxVhNRG6B87PSTm2oZEKSCQ7d4/Bih6ktYIuktC25pGMv4lvDdbYFKtJFzD0IKWSyQYi
         76RWPPKvEfQpoB0mz0BbUEtlZOarCGQDgJh7E9GWevzWtBX+xZDH0Il+AH1nI07z5QNl
         H9j/MsIDZyFja0x3FEprSM0m9Fb51/bsEn0rmsX4PhXwFN2vovNk2X14RZR9j4Bi0DHP
         xTBRCfMEUNe4otyLxdVDtCzsee0R1tM12lwx+rH3xtDRFihzWIhEzR+PeDFQucBpujRK
         W85Q==
X-Gm-Message-State: AOAM532VidiDlNsw9hoADkQJRWZLq0dkhCRLPvGn62mHyPAQ9I8Zd98P
        JQA6lGwb8rYMxn3Niz2z5qrdVwuHCTDrCbQE8Bg=
X-Google-Smtp-Source: ABdhPJx2v0pXSS31P9/uPIVjSdJ9Jnzf32cSJC0o0Jxri+NHoLKxMq9c1kbeWqHYARc38EGj9ArBNeX12UKJ5oCgXWE=
X-Received: by 2002:aca:b407:: with SMTP id d7mr1013851oif.167.1614236578150;
 Wed, 24 Feb 2021 23:02:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <3d92df7a0cf9655dd34895f106cfac26ea44ad94.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <3d92df7a0cf9655dd34895f106cfac26ea44ad94.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 23:02:46 -0800
Message-ID: <CABPp-BGspVmXFNpAoF-8wcb4eyjyivM4Cpcy4wRfjL6kMxcu6Q@mail.gmail.com>
Subject: Re: [PATCH 07/20] test-read-cache: print cache entries with --table
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> This table is helpful for discovering data in the index to ensure it is
> being written correctly, especially as we build and test the
> sparse-index. This table includes an output format similar to 'git
> ls-tree', but should not be compared to that directly. The biggest
> reasons are that 'git ls-tree' includes a tree entry for every
> subdirectory, even those that would not appear as a sparse directory in
> a sparse-index. Further, 'git ls-tree' does not use a trailing directory
> separator for its tree rows.
>
> This does not print the stat() information for the blobs. That could be
> added in a future change with another option. The tests that are added
> in the next few changes care only about the object types and IDs.
>
> To make the option parsing slightly more robust, wrap the string
> comparisons in a loop adapted from test-dir-iterator.c.
>
> Care must be taken with the final check for the 'cnt' variable. We
> continue the expectation that the numerical value is the final argument.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/helper/test-read-cache.c | 50 ++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 10 deletions(-)
>
> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> index 244977a29bdf..e4c3492f7d3e 100644
> --- a/t/helper/test-read-cache.c
> +++ b/t/helper/test-read-cache.c
> @@ -2,35 +2,65 @@
>  #include "cache.h"
>  #include "config.h"
>
> +static void print_cache_entry(struct cache_entry *ce)
> +{
> +       printf("%06o ", ce->ce_mode & 0777777);

This constant is curious.  I think it's because you want to strip off
the special in-memory bits of the ce_mode where git stores extra data,
which would be everything beyond the first 16 bits (as noted in a
comment near the beginning of cache.h).  But here you keep the first
18 bits.  Is CE_UPDATE and CE_REMOVE just 0 in the cases you've viewed
so this works (but you really should use 0177777 or 0xFFFF), or am I
off in my guess of what you're trying to do and you do want to see
those two flags?

It also seems surprising to me that this constant isn't already
defined somewhere in cache.h or as some variant of S_IFMT, though I'm
not finding it.

> +
> +       if (S_ISSPARSEDIR(ce->ce_mode))
> +               printf("tree ");
> +       else if (S_ISGITLINK(ce->ce_mode))
> +               printf("commit ");
> +       else
> +               printf("blob ");

Perhaps make use of the tree_type, commit_type, and blob_type global constants?

> +
> +       printf("%s\t%s\n",
> +              oid_to_hex(&ce->oid),
> +              ce->name);
> +}
> +
> +static void print_cache(struct index_state *cache)
> +{
> +       int i;
> +       for (i = 0; i < the_index.cache_nr; i++)
> +               print_cache_entry(the_index.cache[i]);

Why are you passing cache as a parameter, then ignoring it and using the_index?

> +}
> +
>  int cmd__read_cache(int argc, const char **argv)
>  {
> +       struct repository *r = the_repository;
>         int i, cnt = 1;
>         const char *name = NULL;
> +       int table = 0;
>
> -       if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
> -               argc--;
> -               argv++;
> +       for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
> +               if (skip_prefix(*argv, "--print-and-refresh=", &name))
> +                       continue;
> +               if (!strcmp(*argv, "--table"))
> +                       table = 1;
>         }
>
> -       if (argc == 2)
> -               cnt = strtol(argv[1], NULL, 0);
> +       if (argc == 1)
> +               cnt = strtol(argv[0], NULL, 0);
>         setup_git_directory();
>         git_config(git_default_config, NULL);
> +
>         for (i = 0; i < cnt; i++) {
> -               read_cache();
> +               repo_read_index(r);
>                 if (name) {
>                         int pos;
>
> -                       refresh_index(&the_index, REFRESH_QUIET,
> +                       refresh_index(r->index, REFRESH_QUIET,
>                                       NULL, NULL, NULL);
> -                       pos = index_name_pos(&the_index, name, strlen(name));
> +                       pos = index_name_pos(r->index, name, strlen(name));
>                         if (pos < 0)
>                                 die("%s not in index", name);
>                         printf("%s is%s up to date\n", name,
> -                              ce_uptodate(the_index.cache[pos]) ? "" : " not");
> +                              ce_uptodate(r->index->cache[pos]) ? "" : " not");
>                         write_file(name, "%d\n", i);
>                 }
> -               discard_cache();
> +               if (table)
> +                       print_cache(r->index);
> +               discard_index(r->index);
>         }
>         return 0;
>  }
> --
> gitgitgadget
