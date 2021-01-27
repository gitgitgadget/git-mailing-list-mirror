Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC54C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A190E20709
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhA0FmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbhA0D0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:26:31 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891DBC061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:25:50 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i20so389004otl.7
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRhOln7x4DjOM4jRKYDeTPSWlvt9inbSDmEvKvM6DZY=;
        b=Ti8NZz/4N56xtYNHxJkc4q+NBYrbShSLfsK4AudehLIhd5S5KqUVvkzo7EP13MvAVs
         QgHMxeuEsuJ+2wbqEyRGdkFFl4R4S0qeJ0jtK3fihhYhHhkLjsOIZ8CHhpjYDNDNX4zs
         f+BF56UMwTYMWOsOtzxdA1FDa2L5Rm2l0uVYcY96B0nvTohFCeZpirXMbOA7bAov6n78
         6rvvaN/V9uyDAsOmDx71/aH56U2aa9/kNHIUUQM+ypjPRTt/Ipus1sQmzc/ZiUWaxF/K
         7Kpbu9mNtmNxVTKUWO7oJV6u6OVcLf1zvtHOhS2R0gsiNSuB1KBI4ZuieP/man0JasAW
         Pgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRhOln7x4DjOM4jRKYDeTPSWlvt9inbSDmEvKvM6DZY=;
        b=tdrVDaBnTiekdJQPHhRs0JJgY1XFzYw/j7zaDYEwKYLeENZALHBjW1dh3yKNkZb3z8
         37CLIxJIZ107WwDs60MX03CJaEhgqnFWVZGzEfMXZNxPLwpoIS09uTgrwjd0KVetFNV8
         f2rwoyWC8OYBrltTwDaudGpIXr3Pgk9rLNCSdHGR9d4kSYzD4W9zNaeeX9/B6gDndZqn
         a3+dNbIHKjdEAgACWcw1r8Km6xOACmeWVaLLgOB+CKjP/f6DdPzKX448ZK0xxDRW3iOB
         C9qUnPUDpnbgElSmpppAVN4ZmPEkDA1jh0rmjCDQ1nXJdNSHKNxpLPQt4/IVF/M69xPw
         FHPA==
X-Gm-Message-State: AOAM530W1aaa3hd+GRKYf36xi2G9mvADrov3/+gGHZD5NtcP4UpNZ0HJ
        +2fhy4DeLHJMIy2WRZ7pNSYY8hr8MiUu0y2X4do=
X-Google-Smtp-Source: ABdhPJxcE475bc6FIH7OGtVtVV3VT+UOQzXR8nwx5BfRyT6nguJS2JGAv1sC8wgCFOuzlCISYAqaoX9mBBdEla6GLJs=
X-Received: by 2002:a9d:506:: with SMTP id 6mr6053191otw.162.1611717949901;
 Tue, 26 Jan 2021 19:25:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <e3b169c4fec8db34634c77d19a03fc46a3c7690e.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <e3b169c4fec8db34634c77d19a03fc46a3c7690e.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jan 2021 19:25:38 -0800
Message-ID: <CABPp-BH7hQ3cNnUcjuBP0a7R8EW9Oc29+MZ6Kfzxxk5LA0z2yg@mail.gmail.com>
Subject: Re: [PATCH 04/27] test-read-cache: print cache entries with --table
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> This table is helpful for discovering data in the index to ensure it is
> being written correctly, especially as we build and test the
> sparse-index.
>
> To make the option parsing slightly more robust, wrap the string
> comparisons in a loop adapted from test-dir-iterator.c.
>
> Care must be taken with the final check for the 'cnt' variable. We
> continue the expectation that the numerical value is the final argument.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/helper/test-read-cache.c | 49 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> index 244977a29bd..cd7d106a675 100644
> --- a/t/helper/test-read-cache.c
> +++ b/t/helper/test-read-cache.c
> @@ -2,18 +2,55 @@
>  #include "cache.h"
>  #include "config.h"
>
> +static void print_cache_entry(struct cache_entry *ce)
> +{
> +       /* stat info */
> +       printf("%08x %08x %08x %08x %08x %08x ",
> +              ce->ce_stat_data.sd_ctime.sec,
> +              ce->ce_stat_data.sd_ctime.nsec,
> +              ce->ce_stat_data.sd_mtime.sec,
> +              ce->ce_stat_data.sd_mtime.nsec,
> +              ce->ce_stat_data.sd_dev,
> +              ce->ce_stat_data.sd_ino);

Printing sec & nsec in hexidecimal?  Why?

Also, if they'll be displayed in hex, do you want to format them as
0x%08x, similar to what you do with binary below?

> +
> +       /* mode in binary */

This comment feels misleading; I think this is the "S_IFMT portion of
mode in binary" not "mode in binary".

> +       printf("0b%d%d%d%d ",
> +               (ce->ce_mode >> 15) & 1,
> +               (ce->ce_mode >> 14) & 1,
> +               (ce->ce_mode >> 13) & 1,
> +               (ce->ce_mode >> 12) & 1);

Why binary?  Also, since you defined a special magic constant of
01000755 which utilizes bit 18; how come you aren't including any bits
higher than 15?

> +       /* output permissions? */
> +       printf("%04o ", ce->ce_mode & 01777);

01777 instead of 07777 just because we don't have anything using the
setuid or setgid bits?  But if it's based on non-use, then we don't
use the sticky bit (01000) either, so this could be just 0777.

Also, if you're using 0b for binary to distinguish and you're clearly
using multiple bases in this code, perhaps use a print format of
0o%04o (or 0o%03o if you only use a mask of 0777).

> +       printf("%s ", oid_to_hex(&ce->oid));
> +
> +       printf("%s\n", ce->name);
> +}
> +
> +static void print_cache(struct index_state *cache)
> +{
> +       int i;
> +       for (i = 0; i < the_index.cache_nr; i++)
> +               print_cache_entry(the_index.cache[i]);
> +}
> +
>  int cmd__read_cache(int argc, const char **argv)
>  {
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
> +               if (!strcmp(*argv, "--table")) {
> +                       table = 1;
> +               }
>         }
>
> -       if (argc == 2)
> -               cnt = strtol(argv[1], NULL, 0);
> +       if (argc == 1)
> +               cnt = strtol(argv[0], NULL, 0);
>         setup_git_directory();
>         git_config(git_default_config, NULL);
>         for (i = 0; i < cnt; i++) {
> @@ -30,6 +67,8 @@ int cmd__read_cache(int argc, const char **argv)
>                                ce_uptodate(the_index.cache[pos]) ? "" : " not");
>                         write_file(name, "%d\n", i);
>                 }
> +               if (table)
> +                       print_cache(&the_index);
>                 discard_cache();
>         }
>         return 0;
> --
> gitgitgadget
>
