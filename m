Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E4E20248
	for <e@80x24.org>; Wed, 27 Feb 2019 17:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbfB0Rk3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 12:40:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42602 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfB0Rk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 12:40:28 -0500
Received: by mail-io1-f67.google.com with SMTP id p196so14190954iod.9
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJlXP4JwZUje/d51zYs7K/4LZgbRW8GQcjxdpRNuM60=;
        b=LNvewjj3gQi/8jK+SwhG4aQYYsNGts7c4YAyIPz8ft/1mXA5bDBz7Ymfx8Bk7RInVV
         OxmagxOJ+aMeNUnwBVtY+Oq3H/wvSJ1w7vWQSArEG57XU/R1tOTIMWL0rlmzabK72Lv4
         UxZYwKBOLqZO9P2X35E+sku2a29VcgBExpbZIQsNY7MLByI6eIIdxDKcneCLnAyprIhw
         OdZh45h8PaH73lh4Z8g2o2ogC/f5UBNKk52RV2nUU2EUDoZsIjskh8A8gS2wwmKWrkOg
         n/FZ8PZnhJUxdBnfVkDoQ2Oorud7DirsqnbJ/PcfPIPgQfW3JcVk6T8BiTfXxBUktwh/
         R2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJlXP4JwZUje/d51zYs7K/4LZgbRW8GQcjxdpRNuM60=;
        b=cEsM/4Y/N9/l0+adypqYYHEUmIzl9X3gPmWe3C0yN3m9EfjvW5+zV5ftNSof5j+czW
         XiDRwikX8Y33P86solYhK5OZTe14e9lh32k6c5sO4q5Ddl+twdm1jbeBdfwRFWz39Z7Y
         hZe641EyhpXUVRmVU0qiQL9034WYeSyXTJrHooX7CQe5/iad2xFZzodN2+vyIvCnJAUL
         AqpO4ZN/GQTUygPfR4iVZJHyALCxFfLtH+9+328JvVr9ApSol/VzuednNSLZHEYrCCM/
         qhHuhIpRXn+L5wdYRxmaUn1gGdr8C0tlR8hvfFncNM9Rjlmued9ZX8tHbvU1J7VAfues
         9kEg==
X-Gm-Message-State: APjAAAVdmYe6+9oqSH5GjsVNXG4L/KzxYGs6MffalJld6C0G7ZV25deW
        ujPUV4RsDoSJO38AGEEPJGeCX7UecW4W/AyHwJjWtw==
X-Google-Smtp-Source: APXvYqxKwRHfan7dWoj+aQUeKZ7A1IZPZsclxqWWn9PYt26Az/P0L6mTwXm3AZrWUFGhsWrj5BBsSYOkBM1UucS4JaA=
X-Received: by 2002:a6b:7941:: with SMTP id j1mr2704640iop.262.1551289227714;
 Wed, 27 Feb 2019 09:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br>
 <20190226051804.10631-6-matheus.bernardino@usp.br> <CACsJy8B1asF3i+G-C1aZRw7QTW7jS+a4VkCbg-17YOTyYHuw5w@mail.gmail.com>
In-Reply-To: <CACsJy8B1asF3i+G-C1aZRw7QTW7jS+a4VkCbg-17YOTyYHuw5w@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 27 Feb 2019 14:40:16 -0300
Message-ID: <CAHd-oW6WJ5JSRAbcy+5kcEA4V8qKEUc9B=6WQZvdqaHz4XHBTA@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 5/5] clone: use dir-iterator to avoid explicit
 dir traversal
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 9:32 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Replace usage of opendir/readdir/closedir API to traverse directories
> > recursively, at copy_or_link_directory function, by the dir-iterator
> > API. This simplifies the code and avoid recursive calls to
> > copy_or_link_directory.
> >
> > This process also makes copy_or_link_directory call die() in case of an
> > error on readdir or stat, inside dir_iterator_advance. Previously it
> > would just print a warning for errors on stat and ignore errors on
> > readdir, which isn't nice because a local git clone would end up
> > successfully even though the .git/objects copy didn't fully succeeded.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> > I can also make the change described in the last paragraph in a separate
> > patch before this one, but I would have to undo it in this patch because
> > dir-iterator already implements it. So, IMHO, it would be just noise
> > and not worthy.
> >
> >  builtin/clone.c | 45 +++++++++++++++++++++++----------------------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index fd580fa98d..b23ba64c94 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -23,6 +23,8 @@
> >  #include "transport.h"
> >  #include "strbuf.h"
> >  #include "dir.h"
> > +#include "dir-iterator.h"
> > +#include "iterator.h"
> >  #include "sigchain.h"
> >  #include "branch.h"
> >  #include "remote.h"
> > @@ -411,42 +413,37 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
> >  }
> >
> >  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> > -                                  const char *src_repo, int src_baselen)
> > +                                  const char *src_repo)
> >  {
> > -       struct dirent *de;
> > -       struct stat buf;
> >         int src_len, dest_len;
> > -       DIR *dir;
> > -
> > -       dir = opendir(src->buf);
> > -       if (!dir)
> > -               die_errno(_("failed to open '%s'"), src->buf);
> > +       struct dir_iterator *iter;
> > +       int iter_status;
> > +       struct stat st;
> > +       unsigned flags;
> >
> >         mkdir_if_missing(dest->buf, 0777);
> >
> > +       flags = DIR_ITERATOR_PEDANTIC | DIR_ITERATOR_FOLLOW_SYMLINKS;
> > +       iter = dir_iterator_begin(src->buf, flags);
> > +
> >         strbuf_addch(src, '/');
> >         src_len = src->len;
> >         strbuf_addch(dest, '/');
> >         dest_len = dest->len;
> >
> > -       while ((de = readdir(dir)) != NULL) {
> > +       while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
> >                 strbuf_setlen(src, src_len);
> > -               strbuf_addstr(src, de->d_name);
> > +               strbuf_addstr(src, iter->relative_path);
> >                 strbuf_setlen(dest, dest_len);
> > -               strbuf_addstr(dest, de->d_name);
> > -               if (stat(src->buf, &buf)) {
> > -                       warning (_("failed to stat %s\n"), src->buf);
> > -                       continue;
> > -               }
> > -               if (S_ISDIR(buf.st_mode)) {
> > -                       if (!is_dot_or_dotdot(de->d_name))
> > -                               copy_or_link_directory(src, dest,
> > -                                                      src_repo, src_baselen);
> > +               strbuf_addstr(dest, iter->relative_path);
> > +
> > +               if (S_ISDIR(iter->st.st_mode)) {
> > +                       mkdir_if_missing(dest->buf, 0777);
>
> I wonder if this mkdir_if_missing is sufficient. What if you have to
> create multiple directories?
>
> Let's say the first advance, we hit "a". The the second advance we hit
> directory "b/b/b/b", we would need to mkdir recursively and something
> like safe_create_leading_directories() would be a better fit.
>
> I'm not sure if it can happen though. I haven't re-read dir-iterator
> code carefully.
>
> >                         continue;
> >                 }
> >
> >                 /* Files that cannot be copied bit-for-bit... */
> > -               if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
> > +               if (!strcmp(iter->relative_path, "info/alternates")) {
>
> While we're here, this should be fspathcmp to be friendlier to
> case-insensitive filesystems. You probably should fix it in a separate
> patch though.
>

Nice! I will make this change in a separate patch in the series. Thanks!

> >                         copy_alternates(src, dest, src_repo);
> >                         continue;
> >                 }
> > @@ -463,7 +460,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> >                 if (copy_file_with_time(dest->buf, src->buf, 0666))
> >                         die_errno(_("failed to copy file to '%s'"), dest->buf);
> >         }
> > -       closedir(dir);
> > +
> > +       if (iter_status != ITER_DONE) {
> > +               strbuf_setlen(src, src_len);
> > +               die(_("failed to iterate over '%s'"), src->buf);
> > +       }
>
> I think you need to abort the iterator even when it returns ITER_DONE.
> At least that's how the first caller in files-backend.c does it.
>

Hm, I don't think so, since dir_iterator_advance() already frees the
resources before returning ITER_DONE. Also, I may be wrong, but it
doesn't seem to me, that files-backend.c does it. The function
files_reflog_iterator_advance() that calls dir_iterator_advance() even
sets the dir-iterator pointer to NULL as soon as ITER_DONE is
returned.


> >  }
> >
> >  static void clone_local(const char *src_repo, const char *dest_repo)
> > @@ -481,7 +482,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
> >                 get_common_dir(&dest, dest_repo);
> >                 strbuf_addstr(&src, "/objects");
> >                 strbuf_addstr(&dest, "/objects");
> > -               copy_or_link_directory(&src, &dest, src_repo, src.len);
> > +               copy_or_link_directory(&src, &dest, src_repo);
> >                 strbuf_release(&src);
> >                 strbuf_release(&dest);
> >         }
> > --
> > 2.20.1
> >
>
>
> --
> Duy
