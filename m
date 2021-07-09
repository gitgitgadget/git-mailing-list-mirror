Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F202C07E9C
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601F9613B5
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhGIPo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGIPo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 11:44:28 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79C4C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 08:41:44 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s17so12757182oij.0
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+Q9kQYRbNiNfUsjMKqET1LELhM+8DUkR/dW6fba+W8=;
        b=YrXfaCMdwmnnVrM1Ltdyc6YAbsigSZtyS1BR0Wi9vfZfe821I8TFk3w+/BBCnT4HhB
         nDbECX4pKhZBwvwCKwqHXfrVfr93bjKt1TYc+QEUsdurea3rzTu4z00am8MQMqjFNtXg
         yGXdOCzVZkxRh4DWSUjm0vwlNVb3sIT6w93ODp2j/sm/7A+2bBNKmh8r1dB91Vnhjaq6
         15qTo/+ac5s22aXOYie231rtsQvLETDQf3JxAgFOI7XEnQ/8aOri9E8N9a4g4yCmy3Kg
         nwqGuuAUuhWFfiM0GT+aYJwTmmu1T1wkZftFlZ4844Yg2vmbPJuV57a2MLHRfj2rlEeh
         DWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+Q9kQYRbNiNfUsjMKqET1LELhM+8DUkR/dW6fba+W8=;
        b=GCcz6ryxynq2vpPfrcN8LF4VR4J/dhMr+gBIHWG92wclMy80orzl3y+ROi4lwnvaiz
         HKGVi/KgdXEOloZ8GSZb7izGZTUtLoT6VjKqDYkOid0fd5roPfxitx1jnPo6j+5qQkYw
         5RQqr9MePZ2jyNhC8cKYuxnFa6flCBKmQlxmEXqEtZUOE/et63XvwbWE9bJAdv6RpOIW
         gJfO46Qw2c9FGjQmguOaF4H4XyhrIZeeqsHvrfnQ21mMRyoLy7YJxp/KTUH1k4FjEiwq
         8Mlb7Dqpu6mvo0BqfoAh0mTk17TJlABWVpxKKPRID1o32bD/UkU2gC0r8fG3gz0kDfSH
         t2xg==
X-Gm-Message-State: AOAM5301wCIlkq75HDCumvGQgVWwLWNRu4e46XveEne9/8YWrZqtIjkD
        bEkQSMLgVpAaLbry+caN67VPiUVwloXMW70JdZri1Bo1SZo=
X-Google-Smtp-Source: ABdhPJzCXCwLpA/mljAfHqNNARiUW/9DUq1I3tys+H/KzBZVBdMj6hNFAYLpmRoPzUBBmKY0axtj8wj8/uKT/NWIVu8=
X-Received: by 2002:aca:d547:: with SMTP id m68mr18624334oig.31.1625845304266;
 Fri, 09 Jul 2021 08:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <e3d6c6d670b46d4f0dc133e83c6feede4d55c412.1625844149.git.git@grubix.eu>
In-Reply-To: <e3d6c6d670b46d4f0dc133e83c6feede4d55c412.1625844149.git.git@grubix.eu>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 9 Jul 2021 08:41:33 -0700
Message-ID: <CABPp-BEXz2r+VjaWnuCopZXi-WjaCymT3WJe0KU8OGj8Lqi-Mg@mail.gmail.com>
Subject: Re: [filter-repo PATCH] filter-repo: help with local install
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 9, 2021 at 8:25 AM Michael J Gruber <git@grubix.eu> wrote:
>
> The Makefile suggests a local install and works almost as is, except for
> the python path. Make it work automatically for this typical use case,
> and give a corresponding hint in INSTALL.md.

Make sense.

>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  INSTALL.md | 5 +++--
>  Makefile   | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/INSTALL.md b/INSTALL.md
> index 00aabb7..d479681 100644
> --- a/INSTALL.md
> +++ b/INSTALL.md
> @@ -75,8 +75,9 @@ filter-repo only consists of a few files that need to be installed:
>      You can create this symlink to (or copy of) git-filter-repo named
>      git_filter-repo.py and place it in your python site packages; `python
>      -c "import site; print(site.getsitepackages())"` may help you find the
> -    appropriate location for your system.  Alternatively, you can place
> -    this file anywhere within $PYTHONPATH.
> +    appropriate location for your system, `python -c "import site;
> +    print(site.getusersitepackages())"` for a local install. Alternatively,

Why repeat the exact same python invocation twice in the same
sentence?  What's the difference between "may help you find the
appropriate location for your system" and "for a local install"?

> +    you can place this file anywhere within $PYTHONPATH.
>
>    * git-filter-repo.1
>
> diff --git a/Makefile b/Makefile
> index 31f5e3a..c97d1f6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -4,7 +4,7 @@ bindir = $(prefix)/libexec/git-core
>  localedir = $(prefix)/share/locale
>  mandir = $(prefix)/share/man
>  htmldir = $(prefix)/share/doc/git-doc
> -pythondir = $(prefix)/lib64/python3.6/site-packages
> +pythondir = $(shell python -c "import site; print(site.getusersitepackages())")

Yeah, this seems like a good idea.


Thanks for sending this in.  If we can get INSTALL.md straightened
out, I'll be happy to apply it.
