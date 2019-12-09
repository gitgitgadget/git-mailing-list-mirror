Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E052DC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01222077B
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 17:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="RITTz05G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfLIRlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:41:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41933 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIRlp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 12:41:45 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so11377807lfp.8
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxcJHZE3b1nlBQz/aoU0A9wv9AmilWzQrf0xHthvOoc=;
        b=RITTz05GtdZC1WU8fGJ3f/JMwYvoAZ6CNtlaJ78UNWwx1E5jbSSsTpiWY3LllANkBO
         lNDi7SutPlTTcal5S49sVPr0zW7WAoteVazs906YuySlOdfAkvLzB9nJ+ByFXwfWxbBf
         0mjndJ7NlT80E7E3FgWMeBJpyad9sH+GGzZofTHGR0d28bTbgF2702+RNi81RBTm8g4U
         lzlUfH+EvXlZppxcV4X0/07kCbP9SORYgLzJ1jkxFGL/RGOKvPkETCi4V8DHAVrU1FjU
         CWGyn3qqsHvdeiYfZDZpxThIRALQtAfWQ916DcwWkK3yH0Ver64LCgVsktvaDWNP/pVf
         h5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxcJHZE3b1nlBQz/aoU0A9wv9AmilWzQrf0xHthvOoc=;
        b=lxRZQ9YKdzAhyZmnr7FFQVq0HItH0T7TjfQf0zQ5poKsRA4E5dKyUpszerQFkBZ+Gh
         Gl/hKQ/M0NBqXGyrYCl740lQQzhCt7JVNFUVtEfR1y+fd7jlWexa9N322VulUBQxB9FD
         cS0DJTVIXE6TAYyC6UaNmwx+PSxz2m7apNmGqQcgteItDHZGZON0VJplc3HJbTMvbORu
         MuVugYrTGg2oxfcE4twLFZNkIUDJ3vcNh0lFQu4QpTCJHnJZNsanpnjkAucOtT0Z4opB
         G85Ob92I6z34fJ6OXWIzlIbqrmOXZhbmY8OhJWb0Uu28pKN4KbkEr6iSaQj7XlcQeBJy
         zgOw==
X-Gm-Message-State: APjAAAXDwYj6IhumYaPZmisbxPz3FEzQOSB4hl95MWV11eIeLxJEW6jd
        T77w+8V1RLI9g7ExvHMpQQjQV6RJmiKqpoJKM7S8AA==
X-Google-Smtp-Source: APXvYqyv3F0aGkmGYVHnqSgdeHa+ZNurjQUCTUKy11tBm3ubFUqZh6OCE9lYnhBOvxz7opVi20LRtUoxrAWKsgORRYE=
X-Received: by 2002:a19:f80a:: with SMTP id a10mr16801178lff.107.1575913303210;
 Mon, 09 Dec 2019 09:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20191208180439.19018-1-otalpster@gmail.com>
In-Reply-To: <20191208180439.19018-1-otalpster@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 9 Dec 2019 14:41:31 -0300
Message-ID: <CAHd-oW4MzH9Wrb2zNPF0JBN8+FRB4NtDX0166Qt2Kbqs0mDgcw@mail.gmail.com>
Subject: Re: [PATCH] entry.c: use dir-iterator to avoid explicit dir traversal
To:     otalpster@gmail.com
Cc:     git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 8, 2019 at 3:06 PM <otalpster@gmail.com> wrote:
>
> From: Plato <otalpster@gmail.com>
>
> Replace usage of opendir/readdir/closedir API to traverse directories
> recursively, at remove_subtree() function, by the dir-iterator API. This
> simplifies the code and avoids recursive calls to remove_subtree().
>
> Signed-off-by: Plato <otalpster@gmail.com>
> ---
> Hello,
>
> This is my first patch.

Hello Plato, and welcome!
Thanks for working on this.

> I hope I cc'd the correct people and didn't mess up.
>
> The changes pass the test suite t/ and Travis CI.
> Please point out any mistakes.
>
> Thanks for your time! :)
>
>  entry.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index 53380bb614..e7f4881d3b 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -2,6 +2,8 @@
>  #include "blob.h"
>  #include "object-store.h"
>  #include "dir.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
>  #include "streaming.h"
>  #include "submodule.h"
>  #include "progress.h"
> @@ -50,29 +52,25 @@ static void create_directories(const char *path, int path_len,
>
>  static void remove_subtree(struct strbuf *path)
>  {
> -       DIR *dir = opendir(path->buf);
> -       struct dirent *de;
> -       int origlen = path->len;
> +       int ok;
> +       unsigned int flags = DIR_ITERATOR_PEDANTIC;
> +       struct dir_iterator *iter = dir_iterator_begin(path->buf, flags);
>
> -       if (!dir)
> +       if (!iter)
>                 die_errno("cannot opendir '%s'", path->buf);

Nitpick: since dir_iterator_begin() might fail for reasons other than
an opendir() error, I think the error message here could be more
generic. Maybe "failed to start iterator over %s"?

> -       while ((de = readdir(dir)) != NULL) {
> -               struct stat st;
>
> -               if (is_dot_or_dotdot(de->d_name))
> +       while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
> +               if (is_dot_or_dotdot(iter->path.buf))

This check is already done by dir-iterator internally, so you may
remove it here.

>                         continue;
>
> -               strbuf_addch(path, '/');
> -               strbuf_addstr(path, de->d_name);
> -               if (lstat(path->buf, &st))
> -                       die_errno("cannot lstat '%s'", path->buf);
> -               if (S_ISDIR(st.st_mode))
> -                       remove_subtree(path);
> -               else if (unlink(path->buf))
> -                       die_errno("cannot unlink '%s'", path->buf);
> -               strbuf_setlen(path, origlen);
> +               if (unlink(iter->path.buf)) {

unlink()-ing a directory in Linux will return a EISDIR error. So I
think you still need to use S_ISDIR() to check if iter->path.buf is a
directory and call rmdir(), in this case.

However, note that the dir-iterator API gives entries in pre-order.
I.e. a directory appears before its subentries. In the use case of
remove_subtree(), though, we need to traverse in post-order, since we
have to remove the subentries before removing the directory where they
reside. My suggestion is that you add a preliminary patch,
implementing a new DIR_ITERATOR_POST_ORDER flag to dir-iterator.h, and
then use it in this patch.

You may also want to check this[1] series, which worked towards the
same goal of converting remove_subtree(). It ended up not getting
merged, back them, but some of the patches were re-used in this[2]
series which got merged. I think you could also re-use some of the
code from [1] that implements the post-order traversing and a test[3]
for remove_subtree().

Thanks,
Matheus

[1]: https://public-inbox.org/git/1493226219-33423-1-git-send-email-bnmvco@gmail.com/
[2]: https://public-inbox.org/git/cover.1562801254.git.matheus.bernardino@usp.br/
[3]: https://public-inbox.org/git/1493226219-33423-3-git-send-email-bnmvco@gmail.com/
