Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11EB21F453
	for <e@80x24.org>; Mon, 18 Feb 2019 21:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfBRVNa (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 16:13:30 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38773 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRVNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 16:13:30 -0500
Received: by mail-it1-f195.google.com with SMTP id l66so1280084itg.3
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 13:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdpD6k2ezEYTfJrkUuDrw5PKTNv/rtEzlxT7orct30M=;
        b=QH28D5XLGgVZNqxpPSQBNMtetP8ZcYb+DMmpa8oYnzBDvAVojvOvR5XMjZnXocdGL5
         kd0y+KWiY1PaS+X+gc3SwIpUooz2+/XvTijr+gYgHq/QGo91bKDQDzH1q6YajZZS9lYp
         DOHq60oW6eMzPqbB+dz+AHI/HzTqDK1lzKbeUJ8WtdD0orvhLAOYzFpypn6tt8lGzDAQ
         e5HeJelh1pNaUqKDgx0jq808oC8+SHo4DIiGf+SCp/zs0C2WXTZ9GggKzhDJ2j74y0hL
         k4Rc6LjAEGADO2o9RZjzAU1UgwFm7kuNGPYTnbH/T3ohwVCNhHOaRz5Lup+qDH0ZaXVs
         i7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdpD6k2ezEYTfJrkUuDrw5PKTNv/rtEzlxT7orct30M=;
        b=AMkBKQNCpaP2tPICtRrwZqSTjR0Bx3gLExNgpxgRdeb1klJ/oo1aPR4echvjCZL6mB
         fPsphnyFeW0AAGhK26efcO94UvgzGpuKlC2EBOnROl9jCGlpDH8SVOwaseY+kSTYyhxo
         WzLj4X3QDgUJ1ugdsQ6hNzQ2/xZmPi6wsAsZTqT0XSDSB6/4Z98LM/rYpQNmaMAR5hW1
         KTfx12N8KTJSze8G0SnVPX0zvj6zrLLJZbm9Ap3ndreB9o3uIS+zKogyrnHAPAygfDPw
         7dND70TXg4v0Q4J3Yb5HBqf8JrYLfeI3yh5XAs2NHXhrRcq/djgbxlB4KXc+knmk8CjN
         JNkQ==
X-Gm-Message-State: AHQUAuaDRg/uIFRlzFF+VpJvxN0uZaJfMyl+1KOsqgcNTFeWIubldNGy
        OIZ5ozPtpF6TIrmjWn6EuwdzRkci7q29nmtfnR4DZw==
X-Google-Smtp-Source: AHgI3IaxW+n1L1iVBI4+qoA1aXUpzHFE0VBjxIRzbqNKgkAQggE0JFHlcW7EQc+SPqVuNESw3ecmm6eF3fteI0uk8D4=
X-Received: by 2002:a24:8788:: with SMTP id f130mr520588ite.90.1550524408578;
 Mon, 18 Feb 2019 13:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-3-matheus.bernardino@usp.br> <20190216143824.GJ6085@hank.intra.tgummerer.com>
In-Reply-To: <20190216143824.GJ6085@hank.intra.tgummerer.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 18 Feb 2019 18:13:16 -0300
Message-ID: <CAHd-oW60a+zz9J+u0HiRuTy-FKYN4s95fCcR3mgJz0hUokhTCQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir traversal
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 16, 2019 at 12:38 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 02/15, Matheus Tavares wrote:
> > Replace usage of opendir/readdir/closedir API to traverse directories
> > recursively, at copy_or_link_directory function, by the dir-iterator
> > API.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  builtin/clone.c | 39 +++++++++++++++++++--------------------
> >  1 file changed, 19 insertions(+), 20 deletions(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 2a1cc4dab9..66ae347f79 100644
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
> > @@ -413,40 +415,33 @@ static void mkdir_if_missing(const char *pathname, mode_t mode)
> >  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> >                                  const char *src_repo, int src_baselen)
> >  {
>

Hi, Thomas. Thanks for the review.

> The src_baselen parameter is now unused, and should be removed.  Our
> codebase currently doesn't compile with -Wunused-parameter, so this is
> not something the compiler can catch at the moment unfortunately.
> However there is some work going on towards removing unused parameter
> from the codebase, so it would be nice to not make things worse here.
>

Nice! I will fix that in v2.

> *1*: https://public-inbox.org/git/20190214054736.GA20091@sigill.intra.peff.net
>
> > -     struct dirent *de;
> > -     struct stat buf;
> >       int src_len, dest_len;
> > -     DIR *dir;
> > -
> > -     dir = opendir(src->buf);
> > -     if (!dir)
> > -             die_errno(_("failed to open '%s'"), src->buf);
> > +     struct dir_iterator *iter;
> > +     int iter_status;
> >
> >       mkdir_if_missing(dest->buf, 0777);
> >
> > +     iter = dir_iterator_begin(src->buf);
> > +
> >       strbuf_addch(src, '/');
> >       src_len = src->len;
> >       strbuf_addch(dest, '/');
> >       dest_len = dest->len;
> >
> > -     while ((de = readdir(dir)) != NULL) {
> > +     while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
> >               strbuf_setlen(src, src_len);
> > -             strbuf_addstr(src, de->d_name);
> > +             strbuf_addstr(src, iter->relative_path);
> >               strbuf_setlen(dest, dest_len);
> > -             strbuf_addstr(dest, de->d_name);
> > -             if (stat(src->buf, &buf)) {
> > -                     warning (_("failed to stat %s\n"), src->buf);
> > -                     continue;
> > -             }
>
> Why was this warning removed?  I don't see a corresponding warning in
> the iterator API.  The one thing the iterator API is doing is that it
> does an lstat on the path to check if it exists.  However that does
> not follow symlinks, and ignores possible other errors such as
> permission errors.
>

You are right. I didn't know the differences from lstat and stat. And
reflecting on this now, I realize that the problem is even deeper:
copy_or_link_directory follows symlinks but dir-iterator don't, so I
cannot use dir-iterator without falling back to recursion on
copy_or_link_directory. Because of that, I thought off adding an
option for dir-iterator to follow symlinks. Does this seem like a good
idea?

Also, I just noticed that dir-iterator follows hidden paths while
copy_or_link_directory don't. Maybe another option to add for
dir-iterator?

> If there is a good reason to remove the warning, that would be useful
> to describe in the commit message.
>
> > -             if (S_ISDIR(buf.st_mode)) {
> > -                     if (de->d_name[0] != '.')
> > -                             copy_or_link_directory(src, dest,
> > -                                                    src_repo, src_baselen);
> > +             strbuf_addstr(dest, iter->relative_path);
> > +
> > +             if (S_ISDIR(iter->st.st_mode)) {
> > +                     if (iter->basename[0] != '.')
> > +                             mkdir_if_missing(dest->buf, 0777);
> >                       continue;
> >               }
> >
> >               /* Files that cannot be copied bit-for-bit... */
> > -             if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
> > +             if (!strcmp(iter->relative_path, "info/alternates")) {
> >                       copy_alternates(src, dest, src_repo);
> >                       continue;
> >               }
> > @@ -463,7 +458,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> >               if (copy_file_with_time(dest->buf, src->buf, 0666))
> >                       die_errno(_("failed to copy file to '%s'"), dest->buf);
> >       }
> > -     closedir(dir);
> > +
> > +     if (iter_status != ITER_DONE) {
> > +             strbuf_setlen(src, src_len);
> > +             die(_("failed to iterate over '%s'"), src->buf);
> > +     }
>
> Interestingly enough, this is not something that can currently
> happen if I read the dir-iterator code correctly.  Even though the
> dir_iterator_advance function says it can return ITER_ERROR, it never
> actually does.  The only way the iter_status can be not ITER_DONE at
> this point is if we would 'break' out of the loop.
>
> I don't think it hurts to be defensive here in case someone decides to
> break out of the loop in the future, just something odd I noticed
> while reviewing the code.
>

Yes, I also noticed that. But I thought it would be nice to make this
check so that this code stays consistent to the documentation at
dir-iterator.h (although implementation is different).

Something I just noticed now is that copy_or_link_directory dies upon
an opendir error, but dir-iterator just prints a warning and keeps
going (looking for another file/dir to return for the caller). Is this
ok? Or should I, perhaps, add a "pedantic" option to dir-iterator so
that, when enabled, it immediately returns ITER_ERROR when an error
occurs instead of keep going?

I'm proposing some new options to dir-iterator because as the patch
that adds it says "There are obviously a lot of features that could
easily be added to this class", and maybe those would be useful for
other dir-iterator users. But I don't know if that would be the best
way of doing it, so any feedback on this will be much appreciated.
Also, I saw on public-inbox[1] a patchset from 2017 proposing new
features/options for dir-iterator, but I don't really know if (and
why) it was rejected. (I couldn't find the patches on master/pu log)

[1] https://public-inbox.org/git/1493226219-33423-1-git-send-email-bnmvco@gmail.com/

Thanks,
Matheus Tavares


> >  }
> >
> >  static void clone_local(const char *src_repo, const char *dest_repo)
> > --
> > 2.20.1
> >
