Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C417AC77B6F
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 21:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjDFVzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbjDFVzS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 17:55:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE939EF3
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 14:55:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54be7584b28so87816827b3.16
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680818117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPfDZl/slVeA3aYM7KwLRgbWOulPs//mpYdZtR3XaZg=;
        b=YLQzixiiYmKzLtCc8PpjIIjwm5KLlBm9no2v2awLmTdvNEq/mjLnSngWbvNYpLrKaj
         qLVD9TtPxg2TdnUy6MgjnZzeabE30c09bfnfZU5i/l7464pzi2xF3j5F0cQzdkcdX5O6
         aWzW1S8kX9QFZWIb8tbG6gnPn1PlbQPJYwJj9D2c3uNctZuoZKcw7cTskHKHjwdnWMTG
         yHpA69c4IjB5vemadlVdgbMAptJYBIHQUM8Ykw/rQDNKdY6qGC+FBpiYIji5lP8Cm0Id
         HBAtd54y1QA73SnKXbBLwbnjQzs8O24ufwiqZjob9SpLoI8WKQVfNHSd6GmS5DlbuwEz
         aecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680818117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPfDZl/slVeA3aYM7KwLRgbWOulPs//mpYdZtR3XaZg=;
        b=FKc3t6TEXIEVrraolxFsHwBjDvFBQQt6sOSAnGh021vEVtBPiUklY6k+TgN1vJIE6C
         okfr4lhKMg9FtQM5w1VMQV6iNkhCL8pZ7WjNb1DV8RVUM87ALZwZ5MD4K2Hf8t2R4rJI
         TwzFCjprSNnExISZ+XRkWVqIda7yVdKJ6/c7OoRZfbBkC5TjO/UP2YncuagudqE+p0o8
         BUWmyAryqmbGbkDPZVl1uv6alRNEOzb789uMww+jCvXeIRGowIcQcPBBHP3MS8jrv2ea
         e7UdHwYAJULaQjYxrVJdUTOO8eS2AWaaArQaKA5IxBesjADqE+6qozrRC5cry2XNrcoN
         ZGvA==
X-Gm-Message-State: AAQBX9d/x/k8q1bvteiWKq8nIpeNZwoW9PdeK6Rl6x7eVeIMdWUVWPoK
        ij43I7z1PzODIfItOtW+zC5VIz0uZqM3/g==
X-Google-Smtp-Source: AKy350YI2NxS9UXptFNjvi76vaGw4YbUf1FheSgjiqcgaBQ4o7BjqG0wA+7Q3MLSxGuPwMoWDECmsp+3EtEBcQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a0d:ec4a:0:b0:541:7f7b:a2ff with SMTP id
 r10-20020a0dec4a000000b005417f7ba2ffmr7015221ywn.8.1680818117214; Thu, 06 Apr
 2023 14:55:17 -0700 (PDT)
Date:   Thu, 06 Apr 2023 14:55:15 -0700
In-Reply-To: <ZC87IcLcBnxBRCdr@nand.local>
Mime-Version: 1.0
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
 <xmqq7curxk22.fsf@gitster.g> <kl6ly1n65l7t.fsf@chooglen-macbookpro.roam.corp.google.com>
 <ZC87IcLcBnxBRCdr@nand.local>
Message-ID: <kl6lmt3k3ccc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] clone: error specifically with --local and symlinked objects
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback!

(and phew, I was a few minutes away from submitting v2 :P)

Taylor Blau <me@ttaylorr.com> writes:

> We *could* teach the dir-iterator API to return a specialized error code either
> through a pointer, like:
>
>     struct dir_iterator *dir_iterator_begin(const char *path,
>                                             unsigned int flags, int *error)
>
> and set error to something like -DIR_ITERATOR_IS_SYMLINK when error is
> non-NULL.
>
> Or we could do something like this:
>
>     int dir_iterator_begin(struct dir_iterator **it,
>                            const char *path, unsigned int flags)
>
> and have the `dir_iterator_begin()` function return its specialized
> error and initialize the dir iterator through a pointer. Between these
> two, I prefer the latter, but I think it's up to individual taste.

Yeah, I've thought about doing the latter. That's also what I'd prefer.
Since you've brought it up, I'll give that a try.

>> 	if (!iter) {
>> 		struct stat st;
>>
>>     if (errno == ENOTDIR && lstat(src->buf, &st) == 0 && S_ISLNK(st.st_mode))
>
> Couple of nit-picks here. Instead of writing "lstat(src->buf, &st ==
> 0)", we should write "!lstat(src->buf, &st)" to match
> Documentation/CodingGuidelines.

Ah, thanks.

> But note that that call to lstat() will clobber your errno value, so
> you'd want to save it off beforehand. If you end up going this route,
> I'd probably do something like:
>
>     if (!iter) {
>       int saved_errno = errno;
>       if (errno == ENOTDIR) {
>         struct stat st;
>
>         if (!lstat(src->buf, &st) && S_ISLNK(st.st_mode))
>           die(_("'%s' is a symlink, refusing to clone with `--local`"),
>               src->buf);
>       }
>       errno = saved_errno;
>
>       die_errno(_("failed to start iterator over '%s'"), src->buf);
>     }

Ah thanks, yes. I think it isn't different in practice, since we're
lstat()-ing the same path, but we should always use the "real" errno to
be safe.

This is another good reason to return an error code instead of
overloading errno.
