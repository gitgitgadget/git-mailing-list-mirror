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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BD4C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEC06103B
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhIOOzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhIOOzr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 10:55:47 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909AC061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 07:54:28 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso3875478ota.8
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbVKnVORY6WMj0mJ/nVPbJJdNlxbEPX66pTFuSJ/q4k=;
        b=dGp9537KE6VJguGmy1ZYhMuSQ/hKQBZ8u2BLPPOhl6fZfJ0Rl5IshpHTtKhvR73x4v
         iA7lPNLtfDqeCqtMx5rwrVOu9lMLTYQ1ei87jXJSjZ/M9Fbl8xDXnwGa7UjDcZEkUQeR
         v1jZAv3/mySzG3IIv02KxMoWZZZMhE7kcLsbIGdYiPQJE6Ft+KFweuHp6WxHoI7oiJS9
         MpybHE5JgSw2ypNg8fzEhUTI/b8iPtyrJTeNtjBEuWmynR2GD/TmjUBl9EyDxUvgGVwO
         4sTWpgK27TgIMUgd7FqZmysE4zyBClMJHuP7EV4CNuI1JlsAaDzeSExH4kmh/XSdvx9G
         Idgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbVKnVORY6WMj0mJ/nVPbJJdNlxbEPX66pTFuSJ/q4k=;
        b=BhJdmE8WhaOM2NbRQLsHC9fTXf9s6gLm/fxGdgLtya8HWrym/LRcdfOAphXGl/PMdC
         Lzw8kqMaKF/7z2gECAbbMfTFBM1W7EuKZxA4wWNYwUxkcufAmHPaXKDgITxDCzHXyqyO
         xI0CVfxA4Rky1gBOR0Q3KnUmiXEqi5Q0clEycOwmYvJrIGz3E+A1l4a4jVGCaaUBn2s2
         8fHziNIakKg3a1YdXaBKlP8JJjKtk7PDtfmKiscWotwrWbvre+dtok+Dso4HNnfWOJvQ
         hlG6rnWE1U24d7tcBKnG7XNdo3+zThtwTiLmnJsI6cyEFT2vZpc5ifx7cVYPqOsHu0+6
         WOPA==
X-Gm-Message-State: AOAM532oobU6mYhuX3PXAjQtLD5qJjrWCKt153/0gRv5itDM/Vga/ZCw
        hhs8jA6UZIhaywHHP2NUlMWMeUt6bNQ681f3IrA=
X-Google-Smtp-Source: ABdhPJz+sOOIOsuDIuh6U25ezmgwfKiiOdjVEhLehv57txHScYbT37tPL+UqK+N5Umy2EavWBrnfs6g3ju2pZ9cb0L8=
X-Received: by 2002:a9d:7204:: with SMTP id u4mr291653otj.276.1631717667884;
 Wed, 15 Sep 2021 07:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
 <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com> <723de4e42582afbe841ed96470fc02db44b24b5e.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <723de4e42582afbe841ed96470fc02db44b24b5e.1631453010.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 15 Sep 2021 07:54:16 -0700
Message-ID: <CABPp-BFitDu8UFkH5Syd3w7_e4sT5nJCJ_6N5sn3a+Acv6B4aQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] dir: select directories correctly
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 6:23 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When matching a path against a list of patterns, the ones that require a
> directory match previously did not work when a filename is specified.
> This was fine when all pattern-matching was done within methods such as
> unpack_trees() that check a directory before recursing into the
> contained files. However, other commands will start matching individual
> files against pattern lists without that recursive approach.
>
> We modify path_matches_dir_pattern() to take a strbuf 'path_parent' that
> is used to store the parent directory of 'pathname' between multiple
> pattern matching tests. This is loaded lazily, only on the first pattern
> it finds that has the PATTERN_FLAG_MUSTBEDIR flag.
>
> If we find that a path has a parent directory, we start by checking to
> see if that parent directory matches the pattern. If so, then we do not
> need to query the index for the type (which can be expensive). If we
> find that the parent does not match, then we still must check the type
> from the index for the given pathname.
>
> Note that this does not affect cone mode pattern matching, but instead
> the more general -- and slower -- full pattern set. Thus, this does not
> affect the sparse index.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 652135df896..fe5ee87bb5f 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1305,10 +1305,38 @@ int match_pathname(const char *pathname, int pathlen,
>
>  static int path_matches_dir_pattern(const char *pathname,
>                                     int pathlen,
> +                                   struct strbuf *path_parent,
>                                     int *dtype,
>                                     struct path_pattern *pattern,
>                                     struct index_state *istate)
>  {
> +       /*
> +        * Use 'alloc' as an indicator that the string has not been
> +        * initialized, in case the parent is the root directory.
> +        */
> +       if (!path_parent->alloc) {
> +               char *slash;
> +               strbuf_addstr(path_parent, pathname);
> +               slash = find_last_dir_sep(path_parent->buf);
> +
> +               if (slash)
> +                       *slash = '\0';

Are you breaking strbuf invariants here?  path_parent->len will not be
corrected by this string manipulation.  Perhaps replace this if-else
block with

    strbuf_setlen(path_parent, slash ? slash - path_parent->buf : 0)

> +               else
> +                       strbuf_setlen(path_parent, 0);
> +       }
> +
> +       /*
> +        * If the parent directory matches the pattern, then we do not
> +        * need to check for dtype.
> +        */
> +       if (path_parent->len &&
> +           match_pathname(path_parent->buf, path_parent->len,
> +                          pattern->base,
> +                          pattern->baselen ? pattern->baselen - 1 : 0,
> +                          pattern->pattern, pattern->nowildcardlen,
> +                          pattern->patternlen, pattern->flags))
> +               return 1;
> +
>         *dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
>         if (*dtype != DT_DIR)
>                 return 0;
> @@ -1331,6 +1359,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
>  {
>         struct path_pattern *res = NULL; /* undecided */
>         int i;
> +       struct strbuf path_parent = STRBUF_INIT;
>
>         if (!pl->nr)
>                 return NULL;    /* undefined */
> @@ -1340,8 +1369,8 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
>                 const char *exclude = pattern->pattern;
>                 int prefix = pattern->nowildcardlen;
>
> -               if ((pattern->flags & PATTERN_FLAG_MUSTBEDIR) &&
> -                   !path_matches_dir_pattern(pathname, pathlen,
> +               if (pattern->flags & PATTERN_FLAG_MUSTBEDIR &&
> +                   !path_matches_dir_pattern(pathname, pathlen, &path_parent,
>                                               dtype, pattern, istate))
>                         continue;
>
> @@ -1367,6 +1396,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
>                         break;
>                 }
>         }
> +       strbuf_release(&path_parent);
>         return res;
>  }
>
> --
> gitgitgadget
