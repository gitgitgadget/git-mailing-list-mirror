Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EEDB20958
	for <e@80x24.org>; Sat, 25 Mar 2017 11:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbdCYLvh (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 07:51:37 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:34947 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbdCYLvf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 07:51:35 -0400
Received: by mail-oi0-f42.google.com with SMTP id f193so5861194oib.2
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ipIUS6wXtD6rm5H55tDFDyutxull6f0sXJ1chgqkkSM=;
        b=h/tQ1QrPV+QLO5NF8/IGrF7TND1kbDtruD1Vn8WxeI+NKQzs6FbldbEA6aLFnDjoBl
         4PjrZtTEwiWoyCyM9szmbu1I/CZXj+RCOok9vu5BG3cF8Dqey6JonY+fxNYr8o3U3X4/
         yTNGsFXSFzmOgp/7OcyzeiyPwOLeaa0i/PTgZ3HWMVODvTafQaBvDblv6LnP5k4JDUeU
         HsaokjbH3Ye21DQRtgBqQkSgmNIYRcGHBaKTl8AZv++GzABH0DF9b/37P76H1sbQfWPB
         3whOVKP6ErlUIAqs05GRgDK6kWxagsDIhDLPqCKEj61ZfHaphb1oZUMuPHC4XRmVFbEU
         cEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ipIUS6wXtD6rm5H55tDFDyutxull6f0sXJ1chgqkkSM=;
        b=hVWMCazf1cYhj6sKNhSDU9+HA4LCQHO4CnT/yMWyMepCqGYFquopp/ZwUKUf8D/iE1
         Msjei5pN8Hb55jNXG1/yiCRfcyGlQnIRXzxD3mrwpdixIBTA2ajIfBIy6SQEcV4W+xS8
         UPKPTqmR0hadveFMTfoKtfA8x6s9wuvSt0FiXC/RS4dv/E5ryyFGZJTUHdGiwSJPHv/o
         M/VPtBIKOFyJv1mGnXqTeo0vAl11MUVKS7D32ab8HEQ2guDOhKUegXE5ZjS7ZTOx7P3V
         V067+UiMUd9KOZJnlNkfLv5k0Ml/xcKSRtZgCJBfq7F9hRw01yK2jpUB2FdmDYK7YDBk
         R7Qw==
X-Gm-Message-State: AFeK/H2/by59n0DTnHOXRL+1W3leJ2tm6tTXRn8olwWe3Y+ZmWELztyZ7fuA0OSe63e8yIF5poDAyvmXalKvrQ==
X-Received: by 10.202.182.7 with SMTP id g7mr6951862oif.175.1490442694502;
 Sat, 25 Mar 2017 04:51:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 04:51:03 -0700 (PDT)
In-Reply-To: <1490441257-44727-1-git-send-email-bnmvco@gmail.com>
References: <1490441257-44727-1-git-send-email-bnmvco@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 Mar 2017 18:51:03 +0700
Message-ID: <CACsJy8Aajf1Lb4mKC=NEUQTNy7QRK99Aont_UCRnHJfho8n+UA@mail.gmail.com>
Subject: Re: [PATCH v2] [GSoC] remove_subtree(): reimplement using iterators
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 6:27 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> Use dir_iterator to traverse through remove_subtree()'s directory tree,
> avoiding the need for recursive calls to readdir(). Simplify
> remove_subtree()'s code.
>
> A conversion similar in purpose was previously done at 46d092a
> ("for_each_reflog(): reimplement using iterators", 2016-05-21).
>
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---
>
> This is a second-version patch of the Google Summer of Code microproject for
> refactoring recursive readdir() calls to use dir_iterator instead. v1 can be
> found in:
>
> https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#mae023e7a7d7626f00e0923833c4359f5af493730
>
> Additionally, for debugging purposes I turned remove_subtree() into a no-op
> and ran git tests. Some failures were at:
>
> * t2000-checkout-cache-clash.sh
> * t2003-checkout-cache-mkdir.sh
>
> If you guys could check those files out and warn me if any additional tests
> would be welcome, please let me know.
>
> Thanks.
>
>  entry.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index c6eea240b..3cb92592d 100644
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
> @@ -46,29 +48,13 @@ static void create_directories(const char *path, int path_len,
>
>  static void remove_subtree(struct strbuf *path)
>  {
> -       DIR *dir = opendir(path->buf);
> -       struct dirent *de;
> -       int origlen = path->len;
> -
> -       if (!dir)
> -               die_errno("cannot opendir '%s'", path->buf);
> -       while ((de = readdir(dir)) != NULL) {
> -               struct stat st;
> -
> -               if (is_dot_or_dotdot(de->d_name))
> -                       continue;
> -
> -               strbuf_addch(path, '/');
> -               strbuf_addstr(path, de->d_name);
> -               if (lstat(path->buf, &st))
> -                       die_errno("cannot lstat '%s'", path->buf);
> -               if (S_ISDIR(st.st_mode))
> -                       remove_subtree(path);
> -               else if (unlink(path->buf))
> +       struct dir_iterator *diter = dir_iterator_begin(path->buf);
> +
> +       while (dir_iterator_advance(diter) == ITER_OK) {
> +               if (unlink(diter->path.buf))
>                         die_errno("cannot unlink '%s'", path->buf);
> -               strbuf_setlen(path, origlen);
>         }
> -       closedir(dir);
> +
>         if (rmdir(path->buf))
>                 die_errno("cannot rmdir '%s'", path->buf);

Even though it's very nice that lots of code is deleted. This is not
entirely correct, is it? Before this patch, rmdir() is called for
every recursive remove_subtree() call. After this patch, it's only
called once (and likely fails unless you have no subdirectories).

>  }
> --
> 2.12.1.433.g82305b74f.dirty
>



-- 
Duy
