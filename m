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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D68C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 21:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7E022203
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 21:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbhAAVNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jan 2021 16:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbhAAVNS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jan 2021 16:13:18 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF667C0613CF
        for <git@vger.kernel.org>; Fri,  1 Jan 2021 13:12:37 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d189so25336547oig.11
        for <git@vger.kernel.org>; Fri, 01 Jan 2021 13:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsVXreIPdrpgERSLzBQBb6H8WF3p5MB4uikvnUjBTxQ=;
        b=BHlI8PA5jfshU6lCu26L2Y+iU8NChbgzRYe56zElKR7Ur0wU8AR/+yt264mQBS15T+
         Hpz0UFEb9pUjBw6jAP0aES1Z4+WaMBpuRZlCOkm0IAcf1HVbgAD1d9I4l8R3MBRe/rk/
         59Hxodf8SOiT3SVx/rnIKUOFWVFcxB6WCF1YRvqtoxlXsDDZ3lIVcw6Onowg1VmjEdO9
         nuSfT3a1akoS171fi194EFyrdURcpcIYyVRn8o5ivfi6pP9hiDOzHliq1uVAOqe4gxDU
         BFwtEiVp4AUcLropYgqjse4+W7I6bEe2ivuKiN68J61mc/PljoZ85G+Igx8pZSp87UUj
         25fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsVXreIPdrpgERSLzBQBb6H8WF3p5MB4uikvnUjBTxQ=;
        b=Fbzjkd2LoRUCifZAnccKqdE20zPbbS8OzOI1nt0LnBfhl3uY+jc8J9UJ1ce5eNbfgg
         GZRx2zoySuzO0SwI7sNOarR0t5BII8AMwZoM9MDVF94BE9B8wZYrmQpGWtCWnDi4KfWa
         uJ/KnrY8yKe53dJxZhSKiY6IQ6xzn+sI7bJZV8SfPmZFZXnlTWyPXitWZdQprJKHCi1D
         4gJArafqRpDZGn5EvU5GPUOZd+vm6fqE9CtOpUW60bkRvyDAEVgkPRRVrqp0KL7ZTRlv
         CblVpfEoTMv19tsJrch3TQpuuJhvkt2aN0AZ/+/q4xMbzH3aPTaI3kTW4138V5GyvWxJ
         g6XA==
X-Gm-Message-State: AOAM533kVl/fbiaIDJycZDGsePGpKYvgtwNc2iahdzhOMjbwxrcxx/se
        AUIzfPwaSlG9L/5cTbcHZ5E/wN8rAc0KRy099Yw=
X-Google-Smtp-Source: ABdhPJyPwf7vCqXGhtwjstxJ1U7epBTuIZwOs1U1OSbtHqrmZXy2yl5D3N6r8plZlXBZ42CAC1zqnJQqWWZ78ZttZ74=
X-Received: by 2002:a54:4185:: with SMTP id 5mr11747103oiy.31.1609535556762;
 Fri, 01 Jan 2021 13:12:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.830.git.1609506428.gitgitgadget@gmail.com> <8fb307c3bee9a33ad408bba6c422e992fb1e2656.1609506428.git.gitgitgadget@gmail.com>
In-Reply-To: <8fb307c3bee9a33ad408bba6c422e992fb1e2656.1609506428.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 1 Jan 2021 13:12:25 -0800
Message-ID: <CABPp-BEPDpagENsmx=8gJ9SqUFrD+mh87WbLnV1mpgtFz56qVg@mail.gmail.com>
Subject: Re: [PATCH 12/12] update-index: remove ce_match_stat(), all macros
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 1, 2021 at 5:12 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The final index compatibility macro to remove from the update-index
> builtin is ce_match_state(). Further, this is the last use of that macro

I think you mean ce_match_stat(); no trailing 'e'.

> anywhere, so it should be removed.
>
> There are some remaining references in the racy-git.txt technical
> document that are updated to ie_match_stat().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/racy-git.txt | 6 +++---
>  builtin/update-index.c               | 3 +--
>  cache.h                              | 1 -
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/racy-git.txt b/Documentation/technical/racy-git.txt
> index ceda4bbfda4..65188e04559 100644
> --- a/Documentation/technical/racy-git.txt
> +++ b/Documentation/technical/racy-git.txt
> @@ -26,7 +26,7 @@ information obtained from the filesystem via `lstat(2)` system
>  call when they were last updated.  When checking if they differ,
>  Git first runs `lstat(2)` on the files and compares the result
>  with this information (this is what was originally done by the
> -`ce_match_stat()` function, but the current code does it in
> +`ie_match_stat()` function, but the current code does it in

Even updating the documentation... :-)

Arguably, this change should have been done years ago when
ce_match_stat was turned into a macro, but certainly becomes more
important with your patch that removes the macro.

>  `ce_match_stat_basic()` function).  If some of these "cached
>  stat information" fields do not match, Git can tell that the
>  files are modified without even looking at their contents.
> @@ -102,7 +102,7 @@ timestamp as the index file itself.
>
>  The callers that want to check if an index entry matches the
>  corresponding file in the working tree continue to call
> -`ce_match_stat()`, but with this change, `ce_match_stat()` uses
> +`ie_match_stat()`, but with this change, `ie_match_stat()` uses
>  `ce_modified_check_fs()` to see if racily clean ones are
>  actually clean after comparing the cached stat information using
>  `ce_match_stat_basic()`.
> @@ -128,7 +128,7 @@ Runtime penalty
>  ---------------
>
>  The runtime penalty of falling back to `ce_modified_check_fs()`
> -from `ce_match_stat()` can be very expensive when there are many
> +from `ie_match_stat()` can be very expensive when there are many
>  racily clean entries.  An obvious way to artificially create
>  this situation is to give the same timestamp to all the files in
>  the working tree in a large project, run `git update-index` on
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 4da0c169dc7..256df43ecbd 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -3,7 +3,6 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> -#define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
>  #include "config.h"
>  #include "lockfile.h"
> @@ -277,7 +276,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
>         struct cache_entry *ce;
>
>         /* Was the old index entry already up-to-date? */
> -       if (old && !ce_stage(old) && !ce_match_stat(old, st, 0))
> +       if (old && !ce_stage(old) && !ie_match_stat(istate, old, st, 0))
>                 return 0;
>
>         ce = make_empty_cache_entry(istate, len);
> diff --git a/cache.h b/cache.h
> index dfcbc4923e2..2925bf050b8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -416,7 +416,6 @@ extern struct index_state the_index;
>  #define chmod_cache_entry(ce, flip) chmod_index_entry(&the_index, (ce), (flip))
>  #define refresh_cache(flags) refresh_index(&the_index, (flags), NULL, NULL, NULL)
>  #define refresh_and_write_cache(refresh_flags, write_flags, gentle) repo_refresh_and_write_index(the_repository, (refresh_flags), (write_flags), (gentle), NULL, NULL, NULL)
> -#define ce_match_stat(ce, st, options) ie_match_stat(&the_index, (ce), (st), (options))
>  #define ce_modified(ce, st, options) ie_modified(&the_index, (ce), (st), (options))
>  #define cache_dir_exists(name, namelen) index_dir_exists(&the_index, (name), (namelen))
>  #define cache_name_is_other(name, namelen) index_name_is_other(&the_index, (name), (namelen))

The rest looks good.
