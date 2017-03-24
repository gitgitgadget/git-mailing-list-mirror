Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765B020966
	for <e@80x24.org>; Fri, 24 Mar 2017 17:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936924AbdCXRDH (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 13:03:07 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33249 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936579AbdCXRDE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 13:03:04 -0400
Received: by mail-pg0-f49.google.com with SMTP id w20so3934349pgc.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gZ7xDT2vzgF3NOMokxJZFRMQAjhYFcRV01oZ6WUmOhA=;
        b=j8amOI3cdG/gQ9OuiJXUZB+/xpFdPZt2rHbEKb359uWfWSv2vGEXLm84Wclr18VLC+
         mYtusxRYmd9NKDyxUpMNytG1e0Tu7HKwi71XRy5XdJV98M26Sww7U87Ph8umt35hAZPM
         4GlQsnzbqCVfStHA7y7krbuwBXHDf8vO8YwxP+VLFx4SENjO3j+88Bdklcsi+lKJKt3i
         bODFmfLRyP/e2xvgwMgJkGBIq9SmPVjbzLfK0yws6G57ISEAUQYlOoLEzwyd/BaQVl6U
         QAyWHPniHsCyeAgdrwztT/pPEOp88N5PoBQ7TdluIcuTXgM7aefdpOvyGtt5FKuPiuLx
         v9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gZ7xDT2vzgF3NOMokxJZFRMQAjhYFcRV01oZ6WUmOhA=;
        b=WGMY1ygDLAWyGUSILDxErRiAFylf1ozyg3S9v24RXN0PJT0Qei7X/0RhChS/UE07dG
         6mHx0z3f+IJs/kJ9eqp1wLGWyPlaWB2hRPMDb5u5/F5vXBBewiwV5lYEnOA3+c6LURrZ
         C+wRz4e4lz5mezXoMRD+T55xdrbpa/Bbe40iqmCO5kKLps8oGnwcy9Tp6gkDkGsRk81G
         +F2AAa6+qq9wTBnKZ60HHNDDe1nTy7Zf/KFs5wF0M37D6u06ChgUIfe4sfCsScB+UfVq
         qtjcBadoJAkYn5ivGN92bqMB/7kTMW7s/l/Yx55/JiyemGd95BJ0Y6C8fcIlA3oAZ8fF
         nrTw==
X-Gm-Message-State: AFeK/H1lJ9mpMIb9ShmNweJMHFlMkGp+vm8QSSb7U6zEFTQcWilsSENaQ0N6Tlw+4RbNv5e7tiYr9exFI68cgbvc
X-Received: by 10.99.39.195 with SMTP id n186mr10161517pgn.178.1490374977865;
 Fri, 24 Mar 2017 10:02:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Fri, 24 Mar 2017 10:02:57 -0700 (PDT)
In-Reply-To: <1490328420-75901-1-git-send-email-bnmvco@gmail.com>
References: <1490328420-75901-1-git-send-email-bnmvco@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Mar 2017 10:02:57 -0700
Message-ID: <CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com>
Subject: Re: [PATCH] [GSoC] remove_subtree(): reimplement using iterators
To:     Daniel Ferreira <bnmvco@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the Git community!

On Thu, Mar 23, 2017 at 9:07 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> Uses dir_iterator to traverse through remove_subtree()'s directory tree,
> avoiding the need for recursive calls to readdir() and simplifying code.

Please use a more imperative style. (e.g. s/Uses/Use/ ...
s/and simplfying/which simplifies/)

>
> Suggested in the GSoC microproject list, as well as:
> https://public-inbox.org/git/xmqqk27m4h3h.fsf@gitster.mtv.corp.google.com/

Thanks for this link. It gives good context for reviewing the change,
but it will not be good context to record as a commit message.
(When someone looks at a commit message later on, they are usually trying
to figure out what the author was thinking; if there were any special cases to
be thought about. Was performance on the authors mind? etc)

So I propose to put the link into the more informal section if a
reroll is needed.
I cc'd Duy, who came up with this Microproject.

> A conversion similar in purpose was previously done at 46d092a
> ("for_each_reflog(): reimplement using iterators", 2016-05-21).

Thanks for pointing at another conversion.

>
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>
> Hey there! This is my microproject for Google Summer of Code on git.
> It has passed on Travis CI (https://travis-ci.org/theiostream/git),
> although I would appreciate any suggestion to improve test coverage
> for the affected function.

This function is deep down in the worktree update mechanism, so any run
of "git reset", "git checkout", git cherry-pick" (and all the others), which
remove a directory (possibly recursive) covers the functionality.

If I were to search for test coverage for this function in particular, I'd
start by looking at "(cd t && ls t1*)".


> This is, to my knowledge, one of the few microprojects that have not
> yet been started by someone on this list, but please let me know if
> someone else is already on it.

cool. :)

> --- a/entry.c
> +++ b/entry.c
> @@ -2,6 +2,8 @@
>  #include "blob.h"
>  #include "dir.h"
>  #include "streaming.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
>
>  static void create_directories(const char *path, int path_len,
>                                const struct checkout *state)
> @@ -46,29 +48,17 @@ static void create_directories(const char *path, int path_len,
>
>  static void remove_subtree(struct strbuf *path)
>  {
> -       DIR *dir = opendir(path->buf);
> -       struct dirent *de;
> +       struct dir_iterator *diter = dir_iterator_begin(path->buf);
>         int origlen = path->len;
>
> -       if (!dir)
> -               die_errno("cannot opendir '%s'", path->buf);
> -       while ((de = readdir(dir)) != NULL) {
> -               struct stat st;
> -
> -               if (is_dot_or_dotdot(de->d_name))
> -                       continue;
> -
> +       while (dir_iterator_advance(diter) == ITER_OK) {
>                 strbuf_addch(path, '/');
> -               strbuf_addstr(path, de->d_name);
> -               if (lstat(path->buf, &st))
> -                       die_errno("cannot lstat '%s'", path->buf);
> -               if (S_ISDIR(st.st_mode))
> -                       remove_subtree(path);
> -               else if (unlink(path->buf))
> +               strbuf_addstr(path, diter->relative_path);
> +               if (unlink(path->buf))
>                         die_errno("cannot unlink '%s'", path->buf);
>                 strbuf_setlen(path, origlen);

Instead of constructing the path again here based on relative path
and the path parameter, I wonder if we could use

    if (unlink(diter->path))
        ..

here? Then we would not need the strbuf at all?
Also we'd need to handle (empty) directories differently for removal?
Do we need to check the return code of dir_iterator_advance
for ITER_ERROR as well?

>         }
> -       closedir(dir);
> +
>         if (rmdir(path->buf))
>                 die_errno("cannot rmdir '%s'", path->buf);

This would remove the "top level" directory as given by path.
When reading the dir-iterator code, I am not sure if this is
also part of the yield in dir_iterator_advance.

Thanks for working on this micro project!
Stefan
